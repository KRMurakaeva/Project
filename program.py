from connect_to_DB import select_from_db, connect_to_db
from docxtpl import DocxTemplate
import pymorphy2
import re
# Инициализация анализатора
morph = pymorphy2.MorphAnalyzer()

#Функция получения инициалов
def initials (fio):
    fio_sep = fio.split(' ')
    if len (fio_sep) > 2:
        return fio_sep[0]+' '+fio_sep[1][0]+'. ' + fio_sep[2][0]+'.'
    else:
        return fio_sep[0]+' '+fio_sep[1][0]+'.'

#Функция определения пола по ФИО
def define_gender(fio):
    fio_sep = fio.split(' ')
    #если есть отчетство, проверяем, на что заканчивается:
    if len (fio_sep)>2:
        #Если на а, то пол женский
        if fio_sep[2].endswith('а'):
            return 'femn'
        else:
            return 'masc'
    #Если отчества нет, проверим фамилию
    else:
        if fio_sep[0].endswith(("ова", "ева", "ина", "ая")):
            return 'femn'
        else:
            return 'masc'

#Функция склонения слова
def change_case(word, target_case, gender=None):
    # Сохраняем оригинальный регистр первой буквы
    was_upper = word[0].isupper()
    word_lower = word.lower()
    parsed = morph.parse(word_lower)[0]

    # Формируем набор грамматических характеристик
    gram_features = {target_case}

    # Добавляем род, если он указан
    if gender:
        gram_features.add(gender)

    # Пробуем просклонять с родом, если он есть
    if parsed.inflect(gram_features):
        result = parsed.inflect(gram_features).word
    else:
        # Если не получилось - пробуем без указания рода
        if gender and parsed.inflect({target_case}):
            result = parsed.inflect({target_case}).word
        else:
            result = word_lower
    # Восстанавливаем регистр
    return result.capitalize() if was_upper else result


#Функция для разбивания фраз (имена, названия)по словам
def change_phrase(phrase, target_case, gender=None):
    # Разбиваем текст на части, сохраняя содержимое в кавычках и скобках
    parts = re.split('("[^"]*")|(\([^)]*\))', phrase)
    processed_parts = []

    for part in parts:
        if not part or part is None:
            continue
        # Оставляем текст в кавычках без изменений
        if part.startswith('"') and part.endswith('"'):
            processed_parts.append(part)
        # Обрабатываем текст в скобках (склоняем содержимое)
        elif part.startswith('(') and part.endswith(')'):
            content = part[1:-1]  # Убираем скобки
            declined_content = change_phrase(content, target_case, gender)  # Рекурсивный вызов
            processed_parts.append(f"({declined_content})")
        else:
            # Обрабатываем остальной текст
            words = part.split()
            processed_words = []

            for word in words:
                # Обрабатываем аббревиатуры (без изменений)
                if word.isupper():
                    processed_words.append(word)
                else:
                    # Обрабатываем слова через дефис (не склоняем первое слово)
                    if '-' in word:
                        subwords = word.split('-')
                        # Первое слово оставляем без изменений
                        first_word = subwords[0]
                        # Остальные склоняем
                        processed_subwords = [first_word] + [change_case(sw, target_case, gender) for sw in
                                                             subwords[1:]]
                        processed_words.append('-'.join(processed_subwords))
                    else:
                        processed_words.append(change_case(word, target_case, gender))

            processed_parts.append(' '.join(processed_words))

    return ' '.join(processed_parts)


def get_db_data(student_id, practice_id):
    connection = connect_to_db()
    parameters = select_from_db(connection, student_id, practice_id)[0]
    for p in parameters.keys():
        if parameters[p] is None:
            parameters[p]=""
        parameters[p]=str(parameters[p])

    if parameters['student_fathername'] == "":
        student_name = parameters['student_lastname']+' '+parameters['student_name']
    else:
        student_name = parameters['student_lastname']+' '+parameters['student_name']+' ' + parameters['student_fathername']
    parameters.update({'student_name': student_name})

    if parameters['director_fathername'] == "":
        practice_director = (parameters['director_lastname']) + ' ' + parameters['director_name']
    else:
        practice_director=(parameters['director_lastname'])+' '+parameters['director_name']+' '+parameters['director_fathername']
    parameters.update({'practice_director':practice_director})
    parameters.update({'student_gender':define_gender(student_name)})
    parameters.update({'director_gender': define_gender(practice_director)})
    return parameters

def generate_indiv_task(student_id, practice_id):
    parameters = get_db_data(student_id, practice_id)
    individual_task = {
        "practice_type": change_phrase(parameters['practice_type'], 'accs').lower(),
        "faculty": parameters['faculty'],
        "program": parameters['program'],
        "place_of_practice": parameters['practice_location'],
        "student_name": parameters['student_name'],
        "course_number": str(parameters['course_number']),
        "group_number": parameters['group_number'],
        "start_date": parameters['start_date'],
        "end_date": parameters['end_date'],
        "practice_director_full": parameters['practice_director'],
        "practice_director_initials": initials(parameters['practice_director']),
        "student_name_initials": initials(parameters['student_name']),
        "student_gender": "Обучающаяся" if parameters['student_gender'] == "femn" else "Обучающийся"
    }
    doc = DocxTemplate("Individual task template.docx")
    doc.render(individual_task)
    doc.save(f"Results/{initials(parameters['student_name'])} Индивидуальное задание {parameters['practice_type']} практика.docx")
    print("Индивидуальное задание готово")

def generate_application(student_id, practice_id):
    parameters = get_db_data(student_id, practice_id)
    application = {
        "of_faculty": change_phrase(parameters['faculty'], 'gent'),
        "to_practice_directior": change_phrase(parameters['practice_director'],'datv', parameters['director_gender']),
        "student_gender": "обучающейся" if parameters['student_gender'] == "femn" else "обучающегося",
        "from_student_name":change_phrase(parameters['student_name'], 'gent', parameters['student_gender']),
        "course_number": parameters['course_number'],
        "group_number": parameters['group_number'],
        "student_phone": parameters['student_phone'],
        "student_email": parameters['student_email'],
        "to_practice_type": change_phrase(parameters['practice_type'], 'gent', 'femn').lower(),
        "start_date": parameters['start_date'],
        "finish_date": parameters['end_date'],
        "practice_directior_initials":  initials(parameters['practice_director']),
        "student_name_initials": initials(parameters['student_name']),
        "in_place_of_practice": change_phrase(parameters['practice_location'], 'loct')
    }
    doc1 = DocxTemplate("Application template.docx")
    doc1.render(application)
    doc1.save(f"Results/{initials(parameters['student_name'])} Заявление {parameters['practice_type']} практика.docx")
    print("Заявление готово")



import psycopg2
from psycopg2.extras import RealDictCursor

def connect_to_db ():
    connection = psycopg2.connect(
        database="postgres",
        user="postgres",
        password="123",
        host="localhost",
        port="5432",
        cursor_factory=RealDictCursor
    )
    return connection

def select_from_db (connection, student_id, practice_id):

    cursor = connection.cursor()

    # Запрос к базе
    cursor.execute('''
        select 
            spa.id,
            s.lastname as student_lastname,
            s.name  as student_name,
            s.fathername as student_fathername,
            s.email as student_email,
            s.phone_number as student_phone,
            g.group_number,
            g.course_number,
            p.title as program,
            f.title as faculty,
            pt.practice_kind || ' (' || pt.practice_type || ')' as practice_type,
            e.lastname as director_lastname, 
            e.name  as director_name,
            e.fathername as director_fathername,
            case 
                when pp.type = 'company' then c.name
                when pp.type = 'faculty' then f.title
            end as practice_location,
            to_char(pt.start_date, 'DD.MM.YYYY') as start_date,
            to_char(pt.end_date, 'DD.MM.YYYY') as end_date
        from 
            student_practice_assignments spa
        join 
            students s on spa.student_id = s.id
        join 
            practice_timetable pt on spa.practice_id = pt.id
        join 
            programs p on pt.program_code = p.code
        join
            faculties f on p.faculty_id = f.id
        join 
            practice_places pp on spa.practice_place_id = pp.id
        left join 
            companies c on pp.company_id = c.id
        left join 
            faculties f1 on pp.faculty_id = f1.id
        join 
            employees e on pt.director_id = e.id
        join
            "groups" g on s.group_number = g.group_number
        where s.id = %s and pt.id = %s;''',(student_id, practice_id))

    result = cursor.fetchall()
    print(type(result), result)
    # Закрываем соединение
    connection.close()
    return result


from program import generate_application, generate_indiv_task

#s_id   pr_id
#4	    9
#2	    11
#3	    10
#1	    12


def main():
    print ('Введите ID студента')
    s = int(input())
    print('Введите ID практики')
    pr = int(input())
    print('Сгенерировать заявление на практику? y/n')
    t = input()
    if t == 'y':
        generate_application()
    print('Сгенерировать индивидуальное задание? y/n')
    t = input()
    if t == 'y':
        generate_indiv_task()

if __name__ == "__main__":
    main()


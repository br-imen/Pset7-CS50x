import csv
from cs50 import SQL

db = SQL("sqlite:///roster.db")
with open("students.csv","r") as file:
    rows = csv.DictReader(file)
    # list for dict_house:
    house = []

    # list for dict_student:
    student= []

    k = 1

    # to skip the header in csv.file:
    (next)

    # A loop for every row in csv file:
    for row in rows:
        x = row['house']  #take the name of house in that row
        y = row['head']
        z = row['student_name'] #take the student_name in that row
        w = row ['id']

        # dict_student: associate the name and the house in that row and then append it in the list student
        #and then load the table of student in db
        dict_student = {"name": z, "house": x, "id" : w}
        student.append(dict_student)
        student_db = db.execute("insert into student (student_name) values(?)", dict_student['name'])
        dict_house = {'house': x, 'head': y, 'id_house': k}
        house_name = [house_item.get('house') for house_item in house]
        if x not in house_name:
            house.append(dict_house)
            k = k + 1

for row_house in house:
    house_db = db.execute("insert into house (house_name,head_name) values(?,?)", row_house['house'],row_house['head'])

for row_student in student:
    id_student = row_student['id']
    for h in house:
        if h['house'] == row_student['house']:
            house_student_db = db.execute("insert into house_student (id_house,id_student) values(?,?)", h['id_house'],id_student)








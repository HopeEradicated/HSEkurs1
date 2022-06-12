import psycopg2
import pymorphy2

perposalph = {'Пастушья': 'Pastoral', 'Компаньон': 'Companion', 'Охотничья': 'Hunting', 'Декоративная': 'Decorative', 'Служебная': 'Service', 'Бойцовская': 'Fighting'}

class BotDB:
    def __init__(self):
        morph = pymorphy2.MorphAnalyzer(lang='ru')
        self.conn = psycopg2.connect(dbname='kursach', user='postgres', password='', host='localhost')
        self.cursor = self.conn.cursor()

    def search(self, breed):
        self.cursor.execute("SELECT breed,full_description,main_photo,max_life_duration,size FROM dogs WHERE  breed = '%s';" % breed)
        return self.cursor.fetchall()

    def shelter_dog(self, input):
        print(type(input))
        if input.isnumeric():
            self.cursor.execute("SELECT * FROM shelterdogs WHERE id = '%s';" % input)
            return self.cursor.fetchall()
        else:
            self.cursor.execute("SELECT * FROM shelterdogs WHERE breed = '%s';" % input)
            results = self.cursor.fetchall()
            if bool(len(results)):
                return results
            else:
                self.cursor.execute("SELECT * FROM shelterdogs WHERE shelter_name = '%s';" % input)
                return self.cursor.fetchall()


    def shelters(self):
        self.cursor.execute("SELECT shelter_name FROM shelters;")
        return self.cursor.fetchall()

    def shelter_info(self, input):
        self.cursor.execute("SELECT * FROM shelters WHERE shelter_name = '%s';" % input)
        return self.cursor.fetchall()

    def select(self, input):
        if len(input) <= 1:
            self.cursor.execute("SELECT breed,main_photo FROM dogs WHERE array_position(main_characteristics,'%s') != 0;" % input)
        else:
            input = input.split(', ')
            basesql = "SELECT breed,main_photo FROM dogs WHERE "
            for row in input:
                basesql = basesql + "array_position(main_characteristics,'" + row + "') != 0 AND "
            basesql = basesql[:-5]
            self.cursor.execute(basesql + ';')
        return self.cursor.fetchall()

    def match(self, input):
        input = input.split(', ')
        basesql = "SELECT breed,main_photo FROM dogs WHERE "
        templen = len(basesql)
        for row in range(len(input)):
            temp = input[row].split(' - ')
            if temp[0] == "Размер":
                basesql = basesql + "size = '" + temp[1] + "' AND "
            if temp[0] == "Категория":
                basesql = basesql + "array_position(purposes,'" + perposalph[temp[1]] + "') != 0 AND "
            if temp[0] == "Продолжительность жизни":
                basesql = basesql + "max_life_duration >= '" + temp[1] + "' AND "
            if temp[0] == "Рост":
                basesql = basesql + "height_male >= '" + temp[1] + "' AND "
            if temp[0] == "Вес":
                basesql = basesql + "weight_border2 >= '" + temp[1] + "' AND "
            if temp[0] == " ":
                break
        if templen != len(basesql):
            basesql = basesql[:-5]
            self.cursor.execute(basesql + ';')
        return self.cursor.fetchall()

    def photos(self, input):
        self.cursor.execute("SELECT photos FROM photogallery WHERE breed = '%s';" % input)
        return self.cursor.fetchall()

    def close(self):
        self.close()

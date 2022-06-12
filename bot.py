#!/usr/bin/env python
# -*- coding: utf-8 -*-
from aiogram import Bot, executor, types, Dispatcher
from aiogram.types import ReplyKeyboardRemove, ReplyKeyboardMarkup
from config import *
from buttons import *
from db import BotDB
import logging

DB = BotDB()

bot_token = BOT_TOKEN
if not bot_token:
    exit("Error: no token provided")

bot = Bot(token=bot_token)
dp = Dispatcher(bot)
logging.basicConfig(level=logging.INFO)
in_kb = ReplyKeyboardMarkup(resize_keyboard=True).add(button_help)
@dp.message_handler(commands=("start","s"), commands_prefix = "/!")
async def start(message: types.Message):
    await message.bot.send_message(message.from_user.id, "Здравствуйте, это бот IWantPet. Чем могу помочь? Для получения инструкции введите /help")

@dp.message_handler(commands=("help","h"), commands_prefix = "/!")
async def start(message: types.Message):
    await message.bot.send_message(message.from_user.id, "Список доступных команд:\n/search *порода собаки*\n/match (/matchhelp для выведения доступных критериев поиска)\n/shelterdogs *порода собаки*/*имя приюта*\n/shelters (Все известные питомники)\n/shelterinfo *имя приюта*\n/link (ссылка на сайт) \n/select (/selecthelp для большей информации)\n/photos *порода собаки*\n/comms *примеры запросов*")

@dp.message_handler(commands=("search","se"), commands_prefix = "/!")
async def start(message: types.Message):
    if len(message.text.split(' ',1))>1:
        result = DB.search(message.text.split(' ',1)[1])
        if bool(len(result)):
            await message.bot.send_message(message.from_user.id, "Порода: " + result[0][0] + "\nПродолжительность жизни(лет): " + str(result[0][3]) + "\nРазмер: " + result[0][4] + "\n" + result[0][1] + "\n" + result[0][2] + "\nПодробнее: https://sobaka.wiki")
        else:
            await message.bot.send_message(message.from_user.id, "Порода не найдена")
    else:
        await message.bot.send_message(message.from_user.id, "Порода не введена")

@dp.message_handler(commands=("match","m"), commands_prefix = "/!")
async def start(message: types.Message):
    if len(message.text.split(' ',1))>1:
        result = DB.match(message.text.split(' ',1)[1])
        if bool(len(result)):
            for row in result:
                await message.bot.send_message(message.from_user.id, "Порода: " + row[0] + "\n" + row[1])
        else:
            await message.bot.send_message(message.from_user.id, "Ни одна собака с такой характеристикой не найдена")
    else:
        await message.bot.send_message(message.from_user.id, "Характеристика не введена")

@dp.message_handler(commands=("matchhelp","mh"), commands_prefix = "/!")
async def start(message: types.Message):
    await message.bot.send_message(message.from_user.id, "Очень преданная\nПодходит для охраны\nВысокий интеллект\nПроживание вне дома\nПодходит для охраны\nДружелюбная\nМало линяет\nХорошее послушание\nПодходит для охоты\nОтличное здоровье\nОтсутствует чувство страха\nДомашняя\nЛопоухая\nДлинношёрстныя\nГладкошёрстная\nЭнергичная\nСпокойная\nЛюбопытная\nС коротким хвостом\nС длинным хвостом\nС кольцевым хвостом\nИгривая\nПример запроса: /match Мало лает, Очень преданная")

@dp.message_handler(commands=("shelterdogs","sg"), commands_prefix = "/!")
async def start(message: types.Message):
    if len(message.text.split(' ',1))>1:
        result = DB.shelter_dog(message.text.split(' ',1)[1])
        if bool(len(result)):
            for row in result:
                await message.bot.send_message(message.from_user.id,"Кличка: " + row[1] + "\nПол: " + row[6] + "\nПорода: " + row[2] + "\nВозраст(лет): " + str(row[3]) + "\nВ приюте: " + row[5] + "\nОписание: " + row[7] + "\nФото: " + row[10] + "\nПодробнее: http://sostradanie-nn.ru")
        else:
            await message.bot.send_message(message.from_user.id, "Ничего не найдено")
    else:
        await message.bot.send_message(message.from_user.id, "Ничего не введено")

@dp.message_handler(commands=("shelters","sh"), commands_prefix = "/!")
async def start(message: types.Message):
    result = DB.shelters()
    for row in result:
        await message.bot.send_message(message.from_user.id, row[0] + "\n")

@dp.message_handler(commands=("shelterinfo","shi"), commands_prefix = "/!")
async def start(message: types.Message):
    if len(message.text.split(' ',1))>1:
        result = DB.shelter_info(message.text.split(' ',1)[1])
        if bool(len(result)):
            await message.bot.send_message(message.from_user.id, "Название приюта: " + result[0][0] + "\nТелефон: " + result[0][2] + "\nАдрес: " + result[0][1] + "\nКоличество собак: " + str(result[0][3]) + "\nПодробнее: http://sostradanie-nn.ru")
        else:
            await message.bot.send_message(message.from_user.id, "Приют не найден")
    else:
        await message.bot.send_message(message.from_user.id, "Имя приюта не введено")

@dp.message_handler(commands=("link","l"), commands_prefix = "/!")
async def start(message: types.Message):
    await message.bot.send_message(message.from_user.id, "https://sobaka.wiki")

@dp.message_handler(commands=("select","sl"), commands_prefix = "/!")
async def start(message: types.Message):
    if len(message.text.split(' ',1))>1:
        result = DB.select(message.text.split(' ',1)[1])
        if bool(len(result)):
            for row in result:
                await message.bot.send_message(message.from_user.id, "Порода: " +  row[0] + "\n" + row[1])
        else:
            await message.bot.send_message(message.from_user.id, "Ни одна собака с такой характеристикой не найдена")
    else:
        await message.bot.send_message(message.from_user.id, "Характеристика не введена")
@dp.message_handler(commands=("selecthelp","slh"), commands_prefix = "/!")
async def start(message: types.Message):
    await message.bot.send_message(message.from_user.id, "Поиск возможен по:\n1.Размеру\nМелкая\nРучная\nСредняя\nКрупная\nОчень крупная\n2.Категории\nПастушья\nКомпаньон\nСлужебная\nДекоративная\nОхотничья\nБойцовская\n3.Продолжительность жизни\nВведите число желаемого максимального возраста\n4.Высоте\nВведите число желаемого максимального роста собаки\n5.Весу\nВведите число желаемого максимального веса собаки\nПример запроса: /select Размер - Крупная, Категория - Компаньон, Продолжительность жизни - 11")

@dp.message_handler(commands=("photos","ph"), commands_prefix = "/!")
async def start(message: types.Message):
    if len(message.text.split(' ',1))>1:
        result = DB.photos(message.text.split(' ',1)[1])
        if bool(len(result)):
            for row in result[0][0]:
                await message.bot.send_message(message.from_user.id, row + "\n")
        else:
            await message.bot.send_message(message.from_user.id, "Порода не найдена")
    else:
        await message.bot.send_message(message.from_user.id, "Порода не введена")

@dp.message_handler(commands=("comms","cm"), commands_prefix = "/!")
async def start(message: types.Message):
    await message.bot.send_message(message.from_user.id, "/search Акита-ину\n/select Дружелюбная, Мало линяет\n/shelterdogs Дворняжка\n/shelterinfo Сострадание\n/match Размер - Крупная, Категория - Компаньон\n/photos Пудель")

@dp.message_handler()
async def start(message: types.Message):
    await message.bot.send_message(message.from_user.id, "Неизвестная команда")

if __name__ == "__main__":
    executor.start_polling(dp, skip_updates=True)
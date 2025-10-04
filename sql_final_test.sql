-- Задание 3.
-- Создание нового пользователя
CREATE USER student1 WITH PASSWORD 'Student1pass';
-- Просмотр созданных пользователей
SELECT usename FROM pg_user;


-- Задание 4. 
--Создайте новую базу данных с названием  school_db .
CREATE DATABASE school_db;
--Назначьте владельцем базы пользователя  student1 
ALTER DATABASE school_db OWNER TO student1;
--  Убедитесь, что база данных появилась в списке баз.
SELECT datname FROM pg_database;


-- Задание 5. 
-- Дайте пользователю  student1  все права на базу данных  school_db .
GRANT ALL PRIVILEGES ON DATABASE school_db TO student1;

-- Задание 6. 
--Создание таблицы студентов в базе данных school_db
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80),
    age INTEGER,
    hobby TEXT
);


-- Задание 7. 
-- Добавление данных
INSERT INTO students (name, age, hobby) VALUES
('Anna', 25, 'reading'),
('Peter', 30, 'programming'),
('Maria', 22, 'drawing'),
('Alex', 35, 'music');



-- Задание 8. Просмотр данных
-- Выведите список всех студентов.
SELECT * FROM students;
-- Попробуйте выбрать только отдельные столбцы, например — имена и хобби.
SELECT name, hobby FROM students;


-- Задание 9. Фильтрация данных
--Составьте запрос, который отобразит только тех студентов, чей возраст меньше определённого значения (например, 32 лет).
SELECT * FROM students WHERE age < 32;


-- Задание 10. Удаление данных
--Удалите из таблицы студентов всех, у кого хобби — музыка.
DELETE FROM students WHERE hobby = 'music';
--- Проверьте, что данные удалены.
SELECT * FROM students;


-- Задание 11. Изменение данных
--Найдите одного из студентов по имени и измените его возраст.
UPDATE students SET age = 26 WHERE name = 'Anna';
--- Проверьте, что данные изменены.
SELECT * FROM students WHERE name = 'Anna';

---

-- Задание 12. Создание таблицы категорий
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) 
);



-- Задание 13. Создание таблицы товаров
CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2),
    category_id INTEGER REFERENCES category(id) -- Внешний ключ указывающий на таблицу категорий.
);

-- Задание 14. 
--Добавление данных в связанные таблицы
INSERT INTO category (name) VALUES
('Electronics'),
('Food'),
('Clothing');

--Добавьте несколько товаров, указав их категории.
INSERT INTO product (name, price, category_id) VALUES
('Laptop', 1200.00, 1), -- Предполагаем, что Electronics имеет id 1
('Apple', 0.50, 2),     -- Предполагаем, что Food имеет id 2
('T-shirt', 25.00, 3);  -- Предполагаем, что Clothing имеет id 3

-- Проверьте, что данные добавлены.
SELECT * FROM product;


-- Задание 15. Объединение таблиц (JOIN)
SELECT
    p.name AS product_name,
    c.name AS category_name
FROM
    product p
JOIN
    category c ON p.category_id = c.id;


-- Задание 16. Создание таблиц для дисциплин и преподавателей
--- Таблица дисциплин
CREATE TABLE discipline (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

--- Таблица преподавателей
CREATE TABLE teacher (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
--Создайте третью таблицу  discipline_teacher , которая будет связывать преподавателей и дисциплины.
CREATE TABLE discipline_teacher (
    teacher_id INTEGER REFERENCES teacher(id),
    discipline_id INTEGER REFERENCES discipline(id),
    PRIMARY KEY (teacher_id, discipline_id)
);


-- Задание 17. Заполнение связанных таблиц
--- Добавьте несколько преподавателей 
INSERT INTO teacher (name) VALUES
('Ivanova'),
('Sidorov'),
('Petrov');

--- Добавьте несколько дисциплин
INSERT INTO discipline (name) VALUES
('Math'),
('Physics'),
('History');

--- Свяжите преподавателей с дисциплинами
INSERT INTO discipline_teacher (teacher_id, discipline_id) VALUES
(1, 1), -- Ivanova преподает Math
(2, 2), -- Sidorov преподает Physics
(3, 3); -- Petrov преподает History

--Составьте запрос, который покажет, кто какой предмет преподаёт.
SELECT
    t.name AS teacher_name,
    d.name AS discipline_name
FROM
    discipline_teacher dt
JOIN
    teacher t ON dt.teacher_id = t.id
JOIN
    discipline d ON dt.discipline_id = d.id;


-- Задание 18. Создание таблицы фермеров
CREATE TABLE farmer (
    id SERIAL PRIMARY KEY,
    height INTEGER,
    age INTEGER,
    name VARCHAR(100),
    number_of_children INTEGER,
    country VARCHAR(50)
);

-- Добавление данных в таблицу фермеров
INSERT INTO farmer (height, age, name, number_of_children, country) VALUES
(180, 45, 'Jean', 2, 'France'),
(175, 52, 'Katarzyna', 3, 'Poland'),
(190, 38, 'Mark', 1, 'USA'),
(165, 60, 'Stanislaw', 4, 'Poland'),
(185, 41, 'Pierre', 2, 'France'),
(178, 33, 'Elsa', 1, 'France');


-- Задание 19. Использование LIKE
-- Имена, заканчивающиеся на 'a' (чувствительно к регистру)
SELECT name FROM farmer WHERE name LIKE '%a';

-- Имена, заканчивающиеся на 'a' (нечувствительно к регистру)
SELECT name FROM farmer WHERE name ILIKE '%A';



-- Задание 20. Диапазоны с BETWEEN
SELECT name, height FROM farmer WHERE height BETWEEN 170 AND 185;


-- Задание 21. Множественный выбор с IN
SELECT name, country FROM farmer WHERE country IN ('France', 'Poland');



-- Задание 22. Подсчёт количества строк
SELECT COUNT(*) FROM farmer;


-- Задание 23. Средние значения
--- Средний возраст фермеров по странам
SELECT country, AVG(age) AS average_age
FROM farmer
GROUP BY country;


-- Задание 24. Условия группировки (HAVING)
--- Страны с количеством фермеров не менее 2
SELECT country, COUNT(*) AS farmer_count
FROM farmer
GROUP BY country
HAVING COUNT(*) >= 2;

-- Задание 25. Создание таблицы с ограничениями
CREATE TABLE limited_product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE, -- NOT NULL и UNIQUE
    price NUMERIC(10, 2) CHECK (price > 0) -- CHECK (price > 0)
);


-- ПРИМЕРЫ ВСТАВОК, ВЫЗЫВАЮЩИХ ОШИБКИ:

-- 1. Ошибка NOT NULL:
-- INSERT INTO limited_product (name, price) VALUES (NULL, 10);

-- 2. Ошибка UNIQUE (после вставки 'Book'):
INSERT INTO limited_product (name, price) VALUES ('Book', 10);
-- INSERT INTO limited_product (name, price) VALUES ('Book', 20);

-- 3. Ошибка CHECK:
-- INSERT INTO limited_product (name, price) VALUES ('Pen', 0);
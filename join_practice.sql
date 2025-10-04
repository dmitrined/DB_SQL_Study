-- СОЗДАНИЕ И ЗАПОЛНЕНИЕ ТАБЛИЦ 


--Создание таблицы courses 
CREATE TABLE courses (
    id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

-- Создание таблицы students 
CREATE TABLE students (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(100) NOT NULL,
    course_id INT NULL,
    FOREIGN KEY (course_id) 
        REFERENCES courses(id) 
        ON DELETE SET NULL
);

-- Заполнение таблицы courses данными
INSERT INTO courses (id, title) VALUES
(1, 'Math'),      
(2, 'Physics'),        
(3, 'Literature'),     
(4, 'Informatics');   

-- Заполнение таблицы students данными
INSERT INTO students (id, name, course_id) VALUES
(1, 'Anna', 1),        -- Анна (Math)
(2, 'Boris', 2),       -- Борис (Physics)
(3, 'Ivan', NULL),     -- Иван (Без курса)
(4, 'Olga', 3);        -- Ольга (Literature)


-- УПРАЖНЕНИЯ НА JOIN 


-- INNER JOIN
-- Соединяет только те строки, где есть совпадения в обеих таблицах.
-- Выведет только студентов, у которых есть курс.
SELECT
    s.name,
    c.title
FROM
    students s
INNER JOIN
    courses c ON s.course_id = c.id;


-- LEFT JOIN
-- Берёт все строки из левой таблицы (students), даже если в правой (courses) совпадений нет.
-- Студенты без курса (Ivan) попадут в результат (у них course.title = NULL).
SELECT
    s.name,
    c.title
FROM
    students s
LEFT JOIN
    courses c ON s.course_id = c.id;


-- RIGHT JOIN
-- Берёт все строки из правой таблицы (courses).
-- Покажет все курсы, даже если на них никто не записан (Informatics).
SELECT
    s.name,
    c.title
FROM
    students s
RIGHT JOIN
    courses c ON s.course_id = c.id;

-- FULL JOIN
-- Объединяет и левое, и правое: все строки из обеих таблиц.
-- Покажет всех студентов и все курсы, даже без совпадений (Ivan и Informatics).
SELECT
    s.name,
    c.title
FROM
    students s
FULL JOIN
    courses c ON s.course_id = c.id;

-- GROUP BY с LEFT JOIN
-- Используется для подсчётов. Подсчитать, сколько студентов на каждом курсе.
-- Используем LEFT JOIN, чтобы включить курс Informatics с 0 студентов.
SELECT
    c.title,
    COUNT(s.id) AS total_students
FROM
    courses c
LEFT JOIN
    students s ON s.course_id = c.id
GROUP BY
    c.title;

-- ORDER BY с JOIN
-- Сортировка результата. Отсортировать студентов по названию курса.
SELECT
    s.name,
    c.title
FROM
    students s
INNER JOIN
    courses c ON s.course_id = c.id
ORDER BY
    c.title;

-- DISTINCT с JOIN
-- Убирает дубликаты. Список уникальных курсов, на которых есть студенты.
SELECT DISTINCT
    c.title
FROM
    students s
INNER JOIN
    courses c ON s.course_id = c.id;

-- JOIN с WHERE
-- Добавляем фильтр к соединению. Только студенты, которые учатся на 'Physics'.
SELECT
    s.name,
    c.title
FROM
    students s
INNER JOIN
    courses c ON s.course_id = c.id
WHERE
    c.title = 'Physics';
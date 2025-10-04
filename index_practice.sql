-- Создание таблицы пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,   
    email VARCHAR(100),
    age INTEGER
);

--  Вставка данных
INSERT INTO users (name, email, age) VALUES
('Иван', 'ivan@mail.ru', 25),
('Мария', 'maria@yandex.ru', 30),
('Петр', 'petr@gmail.com', 35);


--  Поиск БЕЗ индекса 


-- Примечание: на маленькой таблице разница не будет заметна, но на миллионах строк это критично.
SELECT * FROM users WHERE email = 'ivan@mail.ru';

-- Создание и демонстрация обычного индекса  на email

-- Создаем индекс на email 
CREATE INDEX idx_users_email ON users(email);

-- Теперь поиск по email работает быстро 
SELECT * FROM users WHERE email = 'ivan@mail.ru';

-- Создание обычных B-tree индексов:
-- Для поиска по имени 
CREATE INDEX idx_users_name ON users (name);
-- Для поиска по возрасту 
CREATE INDEX idx_users_age ON users(age);


--Уникальный индекс (UNIQUE INDEX)
-- Гарантирует, что email уникален и не будет дубликатов
-- (Это полезно, если не добавили UNIQUE в CREATE TABLE)
CREATE UNIQUE INDEX idx_users_email_unique ON users(email);


--  Составной индекс (Composite Index)
-- Для поиска по нескольким полям, например, по имени И возрасту 
CREATE INDEX idx_users_name_age ON users (name, age);

-- Поиск с составным индексом (быстро)
SELECT * FROM users WHERE name = 'Иван' AND age = 25;


-- Пример 1: Использование индекса для поиска по диапазону (WHERE)
-- Поиск пользователей старше 25 лет
SELECT * FROM users WHERE age > 25;


-- Пример 2: Использование индекса для сортировки (ORDER BY)
-- Сортировка по имени, использует созданный ранее индекс idx_users_name [cite: 71, 75]
SELECT * FROM users ORDER BY name;


-- Пример 3: Использование EXPLAIN для анализа запросов
-- Показывает, используется ли индекс для данного запроса
EXPLAIN SELECT * FROM users WHERE email = 'ivan@mail.ru';

--Простые правила
-- Индекс = быстрый поиск
-- Добавляйте индексы на часто используемые поля
-- Не создавайте лишние индексы - они замедляют добавление данных
-- Первичный ключ (PRIMARY KEY) уже имеет индекс


-- Итог
-- Индексы ускоряют поиск в таблицах. Создавайте их для полей, по которым
-- часто ищете данные. Не переусердствуйте - каждый индекс занимает место и
-- замедляет добавление новых данных
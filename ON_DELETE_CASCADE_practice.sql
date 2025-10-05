

-- Создание таблицы студентов (родительская таблица)
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Создание таблицы оценок (дочерняя таблица)
-- Включает внешний ключ с ON DELETE CASCADE
CREATE TABLE grades (
    id SERIAL PRIMARY KEY,
    -- При удалении студента, связанные оценки будут удалены автоматически
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    subject TEXT NOT NULL,
    grade INTEGER NOT NULL
);

-- Вставка студентов
INSERT INTO students (name) VALUES ('Аня'), ('Борис');

--  Вставка оценок
INSERT INTO grades (student_id, subject, grade) VALUES
(1, 'Математика', 5),-- Оценка для Ани
(1, 'Физика', 4),-- Оценка для Ани
(2, 'Математика', 3);-- Оценка для Бориса

-- Показать таблицу grades до удаления
SELECT * FROM grades;

-- Удаление студента с id = 1
-- Благодаря ON DELETE CASCADE, связанные оценки также будут удалены.
DELETE FROM students WHERE id = 1;

-- Показать таблицу grades после удаления
SELECT * FROM grades;
-- Оценки студента №1 удалились автоматически. 

-- Дополнительный пример: Изменение существующего внешнего ключа для добавления ON DELETE CASCADE 
/*
-- Допустим, мы хотим изменить внешний ключ в таблице grades:
ALTER TABLE grades
DROP CONSTRAINT grades_student_id_fkey, -- Удаляем старый внешний ключ
ADD CONSTRAINT grades_student_id_fkey -- Добавляем новый внешний ключ с ON DELETE CASCADE
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE;
*/
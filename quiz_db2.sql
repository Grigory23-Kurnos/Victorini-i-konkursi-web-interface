-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 23 2026 г., 12:59
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `quiz_db2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admins`
--

CREATE TABLE `admins` (
  `id` int NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `admins`
--

INSERT INTO `admins` (`id`, `full_name`, `login`, `password_hash`, `created_at`) VALUES
(1, 'Администратор', 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2026-06-18 15:35:42');

-- --------------------------------------------------------

--
-- Структура таблицы `contests`
--

CREATE TABLE `contests` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `deadline` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `contests`
--

INSERT INTO `contests` (`id`, `title`, `description`, `deadline`, `created_at`) VALUES
(1, 'Конкурс эссе \"Моя профессия\"', 'Напишите эссе о своей будущей профессии', '2025-12-31 23:59:59', '2026-06-18 15:35:42'),
(3, 'Конкурс \'\'Лучший разработчик\"', 'Ответьте на вопросы о программировании и отправьте свой собственный код для участия.', '2026-12-31 23:59:59', '2026-06-18 21:13:51');

-- --------------------------------------------------------

--
-- Структура таблицы `contest_answers`
--

CREATE TABLE `contest_answers` (
  `id` int NOT NULL,
  `submission_id` int NOT NULL,
  `question_id` int NOT NULL,
  `answer_text` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `contest_answers`
--

INSERT INTO `contest_answers` (`id`, `submission_id`, `question_id`, `answer_text`) VALUES
(7, 3, 3, 'Григорий'),
(8, 3, 4, '5'),
(9, 3, 5, 'Kotlin'),
(10, 3, 6, 'Android,Web,Dekstop');

-- --------------------------------------------------------

--
-- Структура таблицы `contest_questions`
--

CREATE TABLE `contest_questions` (
  `id` int NOT NULL,
  `contest_id` int NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('text','number','radio','checkbox') DEFAULT 'text',
  `options_json` json DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `contest_questions`
--

INSERT INTO `contest_questions` (`id`, `contest_id`, `question_text`, `question_type`, `options_json`, `is_required`, `sort_order`) VALUES
(1, 1, 'Напишите эссе о своей будущей профессии (не менее 300 слов)', 'text', NULL, 1, 1),
(3, 3, 'Как вас зовут?', 'text', NULL, 1, 0),
(4, 3, 'Сколько лет вы программируете', 'text', NULL, 1, 0),
(5, 3, 'Какой язык программирования вы предпочитаете?', 'radio', '[\"Kotlin\", \"Java\", \"Python\", \"C++\"]', 1, 0),
(6, 3, 'Какие технологи вы используете? (можете выбрать несколько)', 'checkbox', '[\"Android\", \"Web\", \"IOS\", \"Dekstop\"]', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `contest_submissions`
--

CREATE TABLE `contest_submissions` (
  `id` int NOT NULL,
  `contest_id` int NOT NULL,
  `student_id` int NOT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `original_filename` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `grade` int DEFAULT NULL,
  `teacher_comment` text,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `contest_submissions`
--

INSERT INTO `contest_submissions` (`id`, `contest_id`, `student_id`, `file_path`, `original_filename`, `status`, `grade`, `teacher_comment`, `submitted_at`, `reviewed_at`) VALUES
(1, 1, 1, NULL, NULL, 'approved', 4, '', '2026-06-18 22:33:56', '2026-06-18 22:36:00'),
(3, 3, 3, NULL, NULL, 'pending', NULL, NULL, '2026-06-18 23:04:50', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `departments`
--

CREATE TABLE `departments` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `departments`
--

INSERT INTO `departments` (`id`, `name`) VALUES
(3, 'Кафедра математики'),
(2, 'Кафедра экономики'),
(1, 'КБИС');

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

CREATE TABLE `groups` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `department_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `groups`
--

INSERT INTO `groups` (`id`, `name`, `department_id`) VALUES
(1, 'ВИ41', 1),
(2, 'ВИ42', 1),
(3, 'ВИ31', 1),
(4, 'ЭК31', 2),
(5, 'МА11', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `options`
--

CREATE TABLE `options` (
  `id` int NOT NULL,
  `question_id` int NOT NULL,
  `option_text` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `options`
--

INSERT INTO `options` (`id`, `question_id`, `option_text`) VALUES
(1, 1, 'Юрий Долгорукий'),
(2, 1, 'Дмитрий Донской'),
(3, 1, 'Иван Грозный'),
(4, 1, 'Александр Невский'),
(5, 2, 'Лев Толстой'),
(6, 2, 'Фёдор Достоевский'),
(7, 2, 'Александр Пушкин'),
(8, 2, 'Михаил Булгаков'),
(9, 3, 'Амазонка'),
(10, 3, 'Нил'),
(11, 3, 'Миссисипи'),
(12, 3, 'Янцзы'),
(13, 4, 'Тихий океан'),
(14, 4, 'Атлантический'),
(15, 4, 'Индийский'),
(16, 4, 'Северный Ледовитый');

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

CREATE TABLE `questions` (
  `id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `text` text NOT NULL,
  `correct_answer` varchar(255) NOT NULL,
  `media_url` varchar(500) DEFAULT NULL,
  `media_type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `questions`
--

INSERT INTO `questions` (`id`, `quiz_id`, `text`, `correct_answer`, `media_url`, `media_type`) VALUES
(1, 1, 'Кто основал Москву?', 'Юрий Долгорукий', NULL, NULL),
(2, 1, 'Кто написал \"Войну и мир\"?', 'Лев Толстой', NULL, NULL),
(3, 2, 'Какая река самая длинная?', 'Нил', NULL, NULL),
(4, 2, 'Какой океан самый большой?', 'Тихий океан', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `quizzes`
--

INSERT INTO `quizzes` (`id`, `title`, `description`, `image_url`, `created_at`) VALUES
(1, 'История России', 'Викторина по истории России', 'http://10.19.119.73/images/quiz31.jpg', '2026-06-18 15:35:42'),
(2, 'География мира', 'Викторина по географии', NULL, '2026-06-18 15:35:42');

-- --------------------------------------------------------

--
-- Структура таблицы `students`
--

CREATE TABLE `students` (
  `id` int NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `group_id` int NOT NULL,
  `department_id` int NOT NULL,
  `consent` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `students`
--

INSERT INTO `students` (`id`, `full_name`, `login`, `password_hash`, `group_id`, `department_id`, `consent`, `created_at`) VALUES
(1, 'Студент Петров', 'student1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 1, 1, '2026-06-18 15:35:42'),
(2, 'Студент Сидоров', 'student2', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 2, 1, 1, '2026-06-18 15:35:42'),
(3, 'Курносенко Г.В.', 'grisha245', '$2y$10$F6zGudMVa.K6O.b2m8RVlue5F.Z7dek2CXMds234QLjbzV638Xc9K', 1, 1, 1, '2026-06-18 17:44:22');

-- --------------------------------------------------------

--
-- Структура таблицы `teachers`
--

CREATE TABLE `teachers` (
  `id` int NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `department_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `teachers`
--

INSERT INTO `teachers` (`id`, `full_name`, `login`, `password_hash`, `department_id`, `created_at`) VALUES
(1, 'Преподаватель Иванов', 'teacher', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2026-06-18 15:35:42'),
(2, 'Курносенко Григорий Владимирович', 'Grigiri245', '$2y$10$R/IcHteCYceb/ZZFLDLDDetsoiKmLgEOz40YpxhMnubQe0QYLv5BO', 1, '2026-06-18 20:54:15');

-- --------------------------------------------------------

--
-- Структура таблицы `user_results`
--

CREATE TABLE `user_results` (
  `id` int NOT NULL,
  `student_id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `score` int NOT NULL,
  `total_questions` int NOT NULL,
  `correct_answers` int NOT NULL,
  `completed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Индексы таблицы `contests`
--
ALTER TABLE `contests`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `contest_answers`
--
ALTER TABLE `contest_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id` (`submission_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Индексы таблицы `contest_questions`
--
ALTER TABLE `contest_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contest_id` (`contest_id`);

--
-- Индексы таблицы `contest_submissions`
--
ALTER TABLE `contest_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contest_id` (`contest_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Индексы таблицы `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `department_id` (`department_id`);

--
-- Индексы таблицы `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Индексы таблицы `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Индексы таблицы `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Индексы таблицы `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `department_id` (`department_id`);

--
-- Индексы таблицы `user_results`
--
ALTER TABLE `user_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `contests`
--
ALTER TABLE `contests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `contest_answers`
--
ALTER TABLE `contest_answers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `contest_questions`
--
ALTER TABLE `contest_questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `contest_submissions`
--
ALTER TABLE `contest_submissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `options`
--
ALTER TABLE `options`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `students`
--
ALTER TABLE `students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `user_results`
--
ALTER TABLE `user_results`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `contest_answers`
--
ALTER TABLE `contest_answers`
  ADD CONSTRAINT `contest_answers_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `contest_submissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contest_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `contest_questions` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `contest_questions`
--
ALTER TABLE `contest_questions`
  ADD CONSTRAINT `contest_questions_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `contest_submissions`
--
ALTER TABLE `contest_submissions`
  ADD CONSTRAINT `contest_submissions_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contest_submissions_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `options`
--
ALTER TABLE `options`
  ADD CONSTRAINT `options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_results`
--
ALTER TABLE `user_results`
  ADD CONSTRAINT `user_results_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_results_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

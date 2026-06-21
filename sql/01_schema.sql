-- =============================================================
-- علمني - منصة تعليم اللغات الأجنبية
-- ملف إنشاء قاعدة البيانات والجداول
-- =============================================================

CREATE DATABASE IF NOT EXISTS `3almni_db`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `3almni_db`;

-- ----------- جدول المستخدمين -----------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `role` ENUM('student','admin') DEFAULT 'student',
  `avatar` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- جدول اللغات -----------
CREATE TABLE IF NOT EXISTS `languages` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name_ar` VARCHAR(50) NOT NULL,
  `name_en` VARCHAR(50) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `flag` VARCHAR(10) DEFAULT NULL,
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- جدول المستويات -----------
CREATE TABLE IF NOT EXISTS `levels` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `language_id` INT NOT NULL,
  `level_number` TINYINT NOT NULL,
  `title` VARCHAR(150) NOT NULL,
  `description` TEXT,
  FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- جدول الدروس -----------
CREATE TABLE IF NOT EXISTS `lessons` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `level_id` INT NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `intro` TEXT,
  `content` LONGTEXT,
  `vocabulary` LONGTEXT,
  `grammar` LONGTEXT,
  `dialogue` LONGTEXT,
  `exercises` LONGTEXT,
  `order_num` INT DEFAULT 1,
  FOREIGN KEY (`level_id`) REFERENCES `levels`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- جدول الكويزات -----------
CREATE TABLE IF NOT EXISTS `quizzes` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `level_id` INT NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `pass_score` TINYINT DEFAULT 80,
  FOREIGN KEY (`level_id`) REFERENCES `levels`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- جدول الأسئلة -----------
CREATE TABLE IF NOT EXISTS `questions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `quiz_id` INT NOT NULL,
  `text` TEXT NOT NULL,
  `type` ENUM('mcq','tf') DEFAULT 'mcq',
  FOREIGN KEY (`quiz_id`) REFERENCES `quizzes`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- جدول الخيارات -----------
CREATE TABLE IF NOT EXISTS `options` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `question_id` INT NOT NULL,
  `text` VARCHAR(500) NOT NULL,
  `is_correct` TINYINT(1) DEFAULT 0,
  FOREIGN KEY (`question_id`) REFERENCES `questions`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- تقدم المستخدم -----------
CREATE TABLE IF NOT EXISTS `user_progress` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `lesson_id` INT NOT NULL,
  `completed` TINYINT(1) DEFAULT 0,
  `completed_at` TIMESTAMP NULL,
  UNIQUE KEY (`user_id`, `lesson_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`lesson_id`) REFERENCES `lessons`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- نتائج الكويز -----------
CREATE TABLE IF NOT EXISTS `quiz_results` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `quiz_id` INT NOT NULL,
  `score` TINYINT NOT NULL,
  `passed` TINYINT(1) DEFAULT 0,
  `attempted_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`quiz_id`) REFERENCES `quizzes`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- سجل المحادثات مع AI -----------
CREATE TABLE IF NOT EXISTS `chat_logs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `message` TEXT NOT NULL,
  `reply` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------- مستخدم Admin افتراضي -----------
-- كلمة المرور: admin123
INSERT INTO `users` (`name`, `email`, `password_hash`, `role`)
VALUES ('مدير الموقع', 'admin@3almni.local',
'$2y$12$sGZ6yUxh.nmOxPJYcEOYquJjW1aNx0vRZECaO3DJMXTX88uElkcCC', 'admin');

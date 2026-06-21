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
-- =============================================================
-- إضافة اللغات الـ 11 والمستويات الأربعة لكل لغة
-- =============================================================

USE `3almni_db`;

-- اللغات
INSERT INTO `languages` (`id`, `name_ar`, `name_en`, `code`, `flag`, `description`) VALUES
(1,  'الإنجليزية', 'English',    'en', '🇬🇧', 'اللغة الأكثر استخداماً عالمياً، أساسية للعمل والدراسة والسفر.'),
(2,  'الفرنسية',   'French',     'fr', '🇫🇷', 'لغة الثقافة والفنون، يتحدث بها أكثر من 300 مليون شخص حول العالم.'),
(3,  'الألمانية',  'German',     'de', '🇩🇪', 'لغة العلم والهندسة، أهم لغة اقتصادية في أوروبا.'),
(4,  'اليابانية',  'Japanese',   'ja', '🇯🇵', 'لغة التكنولوجيا والثقافة الآسيوية المميزة.'),
(5,  'الكورية',    'Korean',     'ko', '🇰🇷', 'لغة شعبية جداً بسبب الموجة الكورية K-Pop والدراما.'),
(6,  'الإيطالية',  'Italian',    'it', '🇮🇹', 'لغة الموسيقى والفن والمطبخ العالمي.'),
(7,  'البرتغالية', 'Portuguese', 'pt', '🇵🇹', 'لغة سادس أكثر اللغات تحدثاً في العالم.'),
(8,  'الروسية',    'Russian',    'ru', '🇷🇺', 'لغة قوية تفتح أبواب أوروبا الشرقية وآسيا الوسطى.'),
(9,  'البولندية',  'Polish',     'pl', '🇵🇱', 'لغة سلافية مهمة في وسط أوروبا.'),
(10, 'التشيكية',   'Czech',      'cs', '🇨🇿', 'لغة جمهورية التشيك، غنية بالثقافة والتاريخ.'),
(11, 'العربية',    'Arabic',     'ar', '🇸🇦', 'لغة القرآن الكريم، يتحدث بها أكثر من 400 مليون شخص.');

-- المستويات (4 مستويات لكل لغة)
INSERT INTO `levels` (`language_id`, `level_number`, `title`, `description`)
SELECT id, 1, 'المستوى الأول - مبتدئ',
       CONCAT('بداية رحلتك في تعلم ', name_ar, ': الحروف، التحيات، الأرقام، الجمل البسيطة.')
FROM `languages`;

INSERT INTO `levels` (`language_id`, `level_number`, `title`, `description`)
SELECT id, 2, 'المستوى الثاني - أساسي',
       CONCAT('قواعد ', name_ar, ' الأساسية، الأزمنة المهمة، مواقف الحياة اليومية.')
FROM `languages`;

INSERT INTO `levels` (`language_id`, `level_number`, `title`, `description`)
SELECT id, 3, 'المستوى الثالث - متوسط',
       CONCAT('محادثات أعمق في ', name_ar, '، فهم النصوص، الكتابة، مفردات متخصصة.')
FROM `languages`;

INSERT INTO `levels` (`language_id`, `level_number`, `title`, `description`)
SELECT id, 4, 'المستوى الرابع - متقدم',
       CONCAT('الطلاقة في ', name_ar, '، محادثات واقعية، فهم متقدم، إعداد للاستخدام العملي.')
FROM `languages`;
-- =============================================================
-- المحتوى التعليمي للغة الإنجليزية (4 مستويات)
-- =============================================================

USE `3almni_db`;

SET @lang_id = 1;
SET @lvl1 = (SELECT id FROM levels WHERE language_id=@lang_id AND level_number=1);
SET @lvl2 = (SELECT id FROM levels WHERE language_id=@lang_id AND level_number=2);
SET @lvl3 = (SELECT id FROM levels WHERE language_id=@lang_id AND level_number=3);
SET @lvl4 = (SELECT id FROM levels WHERE language_id=@lang_id AND level_number=4);

-- ============= المستوى 1 =============
INSERT INTO `lessons` (`level_id`, `title`, `intro`, `content`, `vocabulary`, `grammar`, `dialogue`, `exercises`, `order_num`) VALUES
(@lvl1, 'الدرس 1: الأبجدية والأصوات (The Alphabet)',
'في هذا الدرس ستتعرف على حروف اللغة الإنجليزية الـ 26 وكيفية نطقها.',
'<p>تتكون الأبجدية الإنجليزية من 26 حرفاً، تنقسم إلى:</p><ul><li><b>5 حروف متحركة (Vowels):</b> A, E, I, O, U</li><li><b>21 حرف ساكن (Consonants):</b> B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z</li></ul><p>كل حرف له شكلان: كبير (Capital) وصغير (Small).</p>',
'A (إيه) - B (بي) - C (سي) - D (دي) - E (إي) - F (إف) - G (جي) - H (إيتش) - I (آي) - J (جاي) - K (كاي) - L (إل) - M (إم) - N (إن) - O (أو) - P (بي) - Q (كيو) - R (آر) - S (إس) - T (تي) - U (يو) - V (في) - W (دبليو) - X (إكس) - Y (واي) - Z (زد)',
'<b>قاعدة مهمة:</b> الحروف الكبيرة (Capital) تستخدم في:<ul><li>بداية الجملة</li><li>أسماء الأشخاص: Ahmed, Sara</li><li>أسماء الدول والمدن: Egypt, Cairo</li><li>الضمير I دائماً كبير</li></ul>',
'A: Hello, how are you?\nB: I am fine, thank you.\nA: What is your name?\nB: My name is Ahmed.',
'1) اكتب الحروف الـ 26 بشكليها الكبير والصغير.\n2) اكتب اسمك بالحروف الإنجليزية الكبيرة.\n3) اذكر 5 كلمات تبدأ بحرف متحرك.', 1),

(@lvl1, 'الدرس 2: التحيات والتعارف (Greetings)',
'تعلم كيف تحيي الناس وتعرف بنفسك بالإنجليزية.',
'<p>التحيات في الإنجليزية تختلف حسب الوقت والموقف:</p><ul><li><b>Hello / Hi</b> - مرحبا / أهلا (في أي وقت)</li><li><b>Good morning</b> - صباح الخير (حتى الظهر)</li><li><b>Good afternoon</b> - مساء الخير (من الظهر للمغرب)</li><li><b>Good evening</b> - مساء الخير (بعد المغرب)</li><li><b>Good night</b> - تصبح على خير (عند النوم)</li><li><b>Goodbye / Bye</b> - مع السلامة</li></ul><p><b>عبارات التعارف:</b></p><ul><li>What is your name? - ما اسمك؟</li><li>My name is... - اسمي...</li><li>Nice to meet you - تشرفت بمقابلتك</li><li>How are you? - كيف حالك؟</li><li>I am fine, thank you - أنا بخير، شكراً</li></ul>',
'Hello (هالو) = مرحبا | Hi (هاي) = أهلا | Good (جود) = جيد | Morning = صباح | Afternoon = بعد الظهر | Evening = مساء | Night = ليل | Bye = وداع | Name = اسم | Nice = لطيف | Meet = يقابل | Fine = بخير | Thank you = شكراً | Please = من فضلك | Sorry = آسف | Yes = نعم | No = لا',
'<b>قاعدة:</b> فعل (to be) يأخذ ثلاث صور:<ul><li>I <b>am</b> (أنا)</li><li>You <b>are</b> (أنت)</li><li>He / She / It <b>is</b> (هو/هي/هذا)</li><li>We / They <b>are</b> (نحن/هم)</li></ul><p>مثال: I am Ahmed. She is Sara. They are students.</p>',
'Sara: Hi! What is your name?\nAhmed: Hello, my name is Ahmed.\nSara: Nice to meet you, Ahmed.\nAhmed: Nice to meet you too. How are you?\nSara: I am fine, thank you. And you?\nAhmed: I am good, thanks.',
'1) اكتب 3 طرق مختلفة للتحية بالإنجليزية.\n2) ترجم: "اسمي محمد، تشرفت بمقابلتك".\n3) اكتب حواراً قصيراً بين شخصين يتعارفان.', 2),

(@lvl1, 'الدرس 3: الأرقام والأيام (Numbers & Days)',
'تعلم العد من 1 إلى 100 وأيام الأسبوع وأشهر السنة.',
'<p><b>الأرقام من 1 إلى 20:</b></p><p>1 One | 2 Two | 3 Three | 4 Four | 5 Five | 6 Six | 7 Seven | 8 Eight | 9 Nine | 10 Ten | 11 Eleven | 12 Twelve | 13 Thirteen | 14 Fourteen | 15 Fifteen | 16 Sixteen | 17 Seventeen | 18 Eighteen | 19 Nineteen | 20 Twenty</p><p><b>العشرات:</b> 30 Thirty | 40 Forty | 50 Fifty | 60 Sixty | 70 Seventy | 80 Eighty | 90 Ninety | 100 One hundred</p><p><b>أيام الأسبوع:</b> Sunday (الأحد), Monday (الإثنين), Tuesday (الثلاثاء), Wednesday (الأربعاء), Thursday (الخميس), Friday (الجمعة), Saturday (السبت)</p><p><b>أشهر السنة:</b> January, February, March, April, May, June, July, August, September, October, November, December</p>',
'One = 1 | Two = 2 | Three = 3 | Day = يوم | Week = أسبوع | Month = شهر | Year = سنة | Today = اليوم | Tomorrow = غداً | Yesterday = أمس | Now = الآن | First = الأول | Second = الثاني | Last = الأخير',
'<b>قاعدة الأرقام المركبة:</b><ul><li>21 = Twenty-one</li><li>35 = Thirty-five</li><li>99 = Ninety-nine</li></ul><p><b>السؤال عن العمر:</b> How old are you? - I am 20 years old.</p>',
'A: What day is today?\nB: Today is Monday.\nA: How old are you?\nB: I am twenty years old.\nA: When is your birthday?\nB: My birthday is in May.',
'1) اكتب الأرقام من 1 إلى 30 بالحروف.\n2) اذكر أيام الأسبوع بالترتيب.\n3) اكتب تاريخ ميلادك بالإنجليزية.', 3),

(@lvl1, 'الدرس 4: الضمائر وفعل to be',
'الضمائر هي الكلمات التي تحل محل الأسماء، وفعل to be هو أهم فعل في الإنجليزية.',
'<p><b>الضمائر الشخصية (Personal Pronouns):</b></p><table border="1" cellpadding="6"><tr><th>الضمير</th><th>المعنى</th><th>مع to be</th></tr><tr><td>I</td><td>أنا</td><td>I am</td></tr><tr><td>You</td><td>أنت/أنتم</td><td>You are</td></tr><tr><td>He</td><td>هو</td><td>He is</td></tr><tr><td>She</td><td>هي</td><td>She is</td></tr><tr><td>It</td><td>هو/هي (لغير العاقل)</td><td>It is</td></tr><tr><td>We</td><td>نحن</td><td>We are</td></tr><tr><td>They</td><td>هم</td><td>They are</td></tr></table><p><b>الاختصارات الشائعة:</b> I am = I''m | You are = You''re | He is = He''s | She is = She''s | It is = It''s | We are = We''re | They are = They''re</p>',
'I = أنا | You = أنت | He = هو | She = هي | It = هذا/تلك | We = نحن | They = هم | Am/Is/Are = يكون | Student = طالب | Teacher = معلم | Doctor = طبيب | Engineer = مهندس | Happy = سعيد | Sad = حزين | Tired = متعب',
'<b>صياغة النفي:</b> نضيف <b>not</b> بعد فعل to be:<ul><li>I am not tired - أنا لست متعباً</li><li>She is not a doctor - هي ليست طبيبة</li><li>They are not here - هم ليسوا هنا</li></ul><p><b>صياغة السؤال:</b> نقدم فعل to be:</p><ul><li>Are you a student? - هل أنت طالب؟</li><li>Is she happy? - هل هي سعيدة؟</li></ul>',
'A: Are you a student?\nB: Yes, I am. I am a student at Cairo University.\nA: Is your friend a student too?\nB: No, he is not. He is an engineer.\nA: Where are you from?\nB: I am from Egypt.',
'1) اكتب 5 جمل تستخدم فيها الضمائر المختلفة.\n2) حول هذه الجمل إلى نفي:\n   - I am happy.\n   - She is a teacher.\n   - They are friends.\n3) حول الجمل السابقة إلى أسئلة.', 4),

(@lvl1, 'الدرس 5: الألوان والأشياء حولي (Colors & Things)',
'تعلم أسماء الألوان وأهم الأشياء في حياتك اليومية.',
'<p><b>الألوان (Colors):</b></p><p>Red (أحمر) | Blue (أزرق) | Green (أخضر) | Yellow (أصفر) | Black (أسود) | White (أبيض) | Orange (برتقالي) | Purple (بنفسجي) | Pink (وردي) | Brown (بني) | Gray (رمادي)</p><p><b>أشياء في المنزل:</b></p><p>House (منزل) | Door (باب) | Window (نافذة) | Table (طاولة) | Chair (كرسي) | Bed (سرير) | Book (كتاب) | Pen (قلم) | Phone (هاتف) | Car (سيارة) | Cat (قطة) | Dog (كلب)</p>',
'Red = أحمر | Blue = أزرق | Green = أخضر | Yellow = أصفر | Black = أسود | White = أبيض | Big = كبير | Small = صغير | New = جديد | Old = قديم | Beautiful = جميل | House = منزل | Car = سيارة | Book = كتاب | Phone = هاتف',
'<b>ترتيب الصفات:</b> الصفة تأتي قبل الاسم في الإنجليزية:<ul><li>A red car ✓ (سيارة حمراء)</li><li>A car red ✗</li></ul><p><b>أدوات النكرة:</b></p><ul><li><b>a</b> قبل الكلمات التي تبدأ بحرف ساكن: a book, a car</li><li><b>an</b> قبل الكلمات التي تبدأ بحرف متحرك: an apple, an egg</li></ul>',
'A: What color is your car?\nB: My car is red.\nA: Is it a new car?\nB: No, it is an old car. But it is beautiful.\nA: I have a blue car and a black bike.\nB: Wow, that is great!',
'1) اذكر 8 ألوان بالإنجليزية.\n2) صف 3 أشياء في غرفتك بذكر اللون.\n3) املأ الفراغ بـ a أو an: ___ apple, ___ book, ___ orange, ___ pen.', 5);

-- كويز المستوى 1
INSERT INTO `quizzes` (`level_id`, `title`, `pass_score`) VALUES (@lvl1, 'كويز المستوى الأول - الإنجليزية', 80);
SET @q1 = LAST_INSERT_ID();

INSERT INTO `questions` (`quiz_id`, `text`) VALUES
(@q1, 'كم عدد الحروف في الأبجدية الإنجليزية؟'),
(@q1, 'ما الترجمة الصحيحة لـ "Good morning"؟'),
(@q1, 'أي ضمير نستخدم مع "She"؟'),
(@q1, 'ما هو الرقم Seven؟'),
(@q1, 'متى نستخدم "an" بدلاً من "a"؟'),
(@q1, 'كيف نقول "أنا طالب" بالإنجليزية؟'),
(@q1, 'أي يوم يأتي بعد Monday؟'),
(@q1, 'ما لون "Red"؟'),
(@q1, 'ما السؤال الصحيح للسؤال عن الاسم؟'),
(@q1, 'ما النفي الصحيح لـ "He is happy"؟');

-- خيارات الأسئلة
INSERT INTO `options` (`question_id`, `text`, `is_correct`) VALUES
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 0,1), '24', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 0,1), '26', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 0,1), '28', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 0,1), '30', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 1,1), 'مساء الخير', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 1,1), 'صباح الخير', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 1,1), 'تصبح على خير', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 1,1), 'مع السلامة', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 2,1), 'am', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 2,1), 'are', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 2,1), 'is', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 2,1), 'be', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 3,1), '5', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 3,1), '6', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 3,1), '7', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 3,1), '8', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 4,1), 'قبل الكلمات التي تبدأ بحرف متحرك', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 4,1), 'قبل الكلمات التي تبدأ بحرف ساكن', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 4,1), 'مع الكلمات الجمع', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 4,1), 'في الأسئلة فقط', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 5,1), 'I are student', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 5,1), 'I am a student', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 5,1), 'I is student', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 5,1), 'Me am student', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 6,1), 'Sunday', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 6,1), 'Tuesday', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 6,1), 'Wednesday', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 6,1), 'Friday', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 7,1), 'أزرق', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 7,1), 'أحمر', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 7,1), 'أخضر', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 7,1), 'أصفر', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 8,1), 'How are you?', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 8,1), 'What is your name?', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 8,1), 'Where are you?', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 8,1), 'Who you?', 0),

((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 9,1), 'He no happy', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 9,1), 'He not happy', 0),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 9,1), 'He is not happy', 1),
((SELECT id FROM questions WHERE quiz_id=@q1 ORDER BY id LIMIT 9,1), 'He don''t happy', 0);

-- ============= المستوى 2 =============
INSERT INTO `lessons` (`level_id`, `title`, `intro`, `content`, `vocabulary`, `grammar`, `dialogue`, `exercises`, `order_num`) VALUES
(@lvl2, 'الدرس 1: المضارع البسيط (Present Simple)',
'زمن المضارع البسيط هو الزمن الأكثر استخداماً في اللغة الإنجليزية للحديث عن العادات والحقائق.',
'<p>المضارع البسيط يستخدم لـ:</p><ul><li><b>العادات:</b> I drink coffee every morning.</li><li><b>الحقائق العامة:</b> The sun rises in the east.</li><li><b>المشاعر والآراء:</b> I love football.</li><li><b>الجدول الثابت:</b> The train leaves at 7 AM.</li></ul><p><b>التصريف:</b></p><ul><li>I / You / We / They + الفعل الأصلي → I work</li><li>He / She / It + الفعل + s/es → He works</li></ul><p><b>قاعدة إضافة s/es:</b></p><ul><li>الأفعال العادية: work → works</li><li>الأفعال المنتهية بـ s, sh, ch, x, o: go → goes, watch → watches</li><li>الأفعال المنتهية بـ y بعد ساكن: study → studies</li></ul>',
'Work = يعمل | Study = يدرس | Play = يلعب | Eat = يأكل | Drink = يشرب | Sleep = ينام | Wake up = يستيقظ | Go = يذهب | Come = يأتي | Read = يقرأ | Write = يكتب | Speak = يتحدث | Listen = يستمع | Watch = يشاهد | Always = دائماً | Usually = عادةً | Often = غالباً | Sometimes = أحياناً | Never = أبداً | Every day = كل يوم',
'<b>النفي والسؤال:</b><ul><li>نستخدم <b>do/does</b>:</li><li>I do not (don''t) work.</li><li>He does not (doesn''t) work.</li><li>Do you work? Yes, I do. / No, I don''t.</li><li>Does she work? Yes, she does. / No, she doesn''t.</li></ul><p><b>ملاحظة مهمة:</b> بعد does نستخدم الفعل الأصلي بدون s.</p>',
'Sara: What do you do every day?\nAhmed: I wake up at 6 AM, I eat breakfast, then I go to work.\nSara: Where do you work?\nAhmed: I work in a hospital. I am a doctor.\nSara: Do you like your job?\nAhmed: Yes, I love it. I help people every day.\nSara: That''s wonderful!',
'1) صرف هذه الأفعال مع He/She: play, go, study, watch, do.\n2) اكتب 5 جمل عن روتينك اليومي.\n3) حول إلى نفي: She drinks coffee. They speak English. He plays football.\n4) حول إلى سؤال: You work hard. She likes pizza.', 1),

(@lvl2, 'الدرس 2: المضارع المستمر (Present Continuous)',
'يستخدم للتعبير عن الأفعال التي تحدث الآن أو في فترة معينة.',
'<p><b>التركيب:</b> فاعل + (am/is/are) + فعل + ing</p><ul><li>I am working now. (أنا أعمل الآن)</li><li>She is studying. (هي تدرس)</li><li>They are playing football. (هم يلعبون كرة)</li></ul><p><b>الكلمات الدالة:</b> now, right now, at the moment, today, this week.</p><p><b>قاعدة إضافة ing:</b></p><ul><li>الأفعال العادية: work → working</li><li>الأفعال المنتهية بـ e: write → writing</li><li>الأفعال القصيرة CVC: run → running, sit → sitting</li><li>الأفعال المنتهية بـ ie: lie → lying</li></ul>',
'Right now = الآن مباشرة | At the moment = في هذه اللحظة | Today = اليوم | This week = هذا الأسبوع | Currently = حالياً | Run = يجري | Sit = يجلس | Stand = يقف | Talk = يتكلم | Cook = يطبخ | Drive = يقود',
'<b>الفرق بين المضارع البسيط والمستمر:</b><table border="1" cellpadding="5"><tr><th>المضارع البسيط</th><th>المضارع المستمر</th></tr><tr><td>I work every day</td><td>I am working now</td></tr><tr><td>عادة / حقيقة</td><td>الآن / مؤقت</td></tr></table><p><b>أفعال لا تستخدم في المستمر:</b> love, like, hate, know, want, need, believe.</p><p>✗ I am loving you ✓ I love you</p>',
'A: Hi! What are you doing?\nB: I am studying English at the moment.\nA: Really? Are you preparing for an exam?\nB: Yes, I am. I have an exam next week.\nA: Where is your sister?\nB: She is cooking dinner in the kitchen.\nA: I see. I am sorry, I don''t want to disturb you.\nB: No problem!',
'1) اكتب 5 جمل عما يحدث الآن حولك.\n2) أضف ing للأفعال: write, run, study, swim, make.\n3) اختر الزمن الصحيح: I (work / am working) every day. She (study / is studying) right now.\n4) اكتب فقرة من 5 جمل تصف فيها صورة لأشخاص يفعلون أنشطة مختلفة.', 2),

(@lvl2, 'الدرس 3: الماضي البسيط (Past Simple)',
'للحديث عن أحداث وقعت وانتهت في الماضي.',
'<p><b>الأفعال المنتظمة (Regular Verbs):</b> نضيف <b>ed</b>:</p><ul><li>work → worked</li><li>play → played</li><li>study → studied (y تتحول إلى ied)</li><li>stop → stopped (مضاعفة الحرف)</li></ul><p><b>الأفعال الشاذة (Irregular Verbs):</b> لها صيغ خاصة:</p><table border="1" cellpadding="5"><tr><th>المضارع</th><th>الماضي</th><th>المعنى</th></tr><tr><td>go</td><td>went</td><td>ذهب</td></tr><tr><td>see</td><td>saw</td><td>رأى</td></tr><tr><td>eat</td><td>ate</td><td>أكل</td></tr><tr><td>drink</td><td>drank</td><td>شرب</td></tr><tr><td>have</td><td>had</td><td>كان لديه</td></tr><tr><td>do</td><td>did</td><td>فعل</td></tr><tr><td>be</td><td>was/were</td><td>كان</td></tr><tr><td>buy</td><td>bought</td><td>اشترى</td></tr><tr><td>take</td><td>took</td><td>أخذ</td></tr><tr><td>come</td><td>came</td><td>جاء</td></tr></table>',
'Yesterday = أمس | Last week = الأسبوع الماضي | Last year = العام الماضي | Ago = منذ | Last night = الليلة الماضية | Then = ثم | After = بعد | Before = قبل | Suddenly = فجأة | Finally = أخيراً',
'<b>النفي والسؤال:</b> نستخدم <b>did</b> + الفعل الأصلي:<ul><li>I did not (didn''t) go yesterday.</li><li>Did you see him? Yes, I did. / No, I didn''t.</li></ul><p><b>الكلمات الدالة:</b> yesterday, last (week/month/year), ago, in 2010.</p>',
'Friend: How was your weekend?\nMe: It was great! I went to the beach with my family.\nFriend: Really? What did you do there?\nMe: We swam, played volleyball, and ate seafood.\nFriend: Did you take any photos?\nMe: Yes, I took a lot. I will show you later.\nFriend: That sounds amazing! I stayed home and watched movies.',
'1) صرف 10 أفعال شاذة في الماضي.\n2) اكتب فقرة عما فعلته أمس (5 جمل).\n3) حول إلى الماضي: I go to school. She eats breakfast. They play football.\n4) حول إلى سؤال ونفي: He visited his grandmother last week.', 3),

(@lvl2, 'الدرس 4: الجمع وأدوات التعريف',
'كيف نحول الكلمات من المفرد إلى الجمع، ومتى نستخدم the.',
'<p><b>قواعد الجمع المنتظم:</b></p><ul><li>الأغلبية: نضيف s → book / books</li><li>تنتهي بـ s, sh, ch, x: نضيف es → bus / buses, watch / watches</li><li>تنتهي بـ y بعد ساكن: y → ies → city / cities</li><li>تنتهي بـ f/fe: تتحول لـ ves → leaf / leaves, knife / knives</li></ul><p><b>الجمع الشاذ:</b></p><ul><li>man → men</li><li>woman → women</li><li>child → children</li><li>foot → feet</li><li>tooth → teeth</li><li>mouse → mice</li><li>person → people</li></ul><p><b>أدوات التعريف:</b></p><ul><li><b>a/an</b> للنكرة (شيء غير محدد): a book, an apple</li><li><b>the</b> للمعرفة (شيء محدد): the book on the table</li><li>لا نستخدم أداة مع الجمع غير المحدد: I like cats.</li></ul>',
'Book = كتاب | Books = كتب | Man = رجل | Men = رجال | Woman = امرأة | Women = نساء | Child = طفل | Children = أطفال | City = مدينة | Cities = مدن | Person = شخص | People = أشخاص | Country = دولة | Countries = دول | Family = عائلة | Friend = صديق | School = مدرسة',
'<b>متى نستخدم the؟</b><ul><li>عند الإشارة لشيء معروف: The book on the desk is mine.</li><li>الأشياء الفريدة: the sun, the moon, the world.</li><li>أسماء البحار والأنهار: the Nile, the Atlantic.</li><li>الجنسيات الجمع: the Egyptians.</li></ul><p><b>متى لا نستخدم the؟</b></p><ul><li>أسماء الأشخاص: Ahmed (لا the).</li><li>أسماء الدول العادية: Egypt (لا the).</li><li>الوجبات: I eat breakfast. (لا the).</li></ul>',
'A: How many people are in your family?\nB: There are five people: my father, my mother, my brother, and my two sisters.\nA: Do you have any children?\nB: No, I don''t have children yet.\nA: Where do they live?\nB: They live in Cairo, the capital of Egypt.\nA: I love Cairo! The pyramids are amazing.',
'1) ضع الكلمات في صيغة الجمع: man, child, city, leaf, watch, party, foot.\n2) املأ الفراغ بـ a/an/the/-: I have ___ apple. ___ sun is hot. I love ___ books.\n3) ترجم: "هناك خمسة أطفال في الفصل، والمعلم يشرح الدرس."\n4) اكتب 5 جمل تستخدم فيها الجمع الشاذ.', 4),

(@lvl2, 'الدرس 5: ضمائر الملكية والصفات',
'للتعبير عن الملكية ووصف الأشياء.',
'<p><b>صفات الملكية (Possessive Adjectives):</b> تأتي قبل الاسم.</p><table border="1" cellpadding="5"><tr><th>الضمير</th><th>الصفة</th><th>مثال</th></tr><tr><td>I</td><td>my</td><td>my book</td></tr><tr><td>You</td><td>your</td><td>your car</td></tr><tr><td>He</td><td>his</td><td>his name</td></tr><tr><td>She</td><td>her</td><td>her bag</td></tr><tr><td>It</td><td>its</td><td>its color</td></tr><tr><td>We</td><td>our</td><td>our house</td></tr><tr><td>They</td><td>their</td><td>their friends</td></tr></table><p><b>ضمائر الملكية (Possessive Pronouns):</b> تستخدم وحدها.</p><ul><li>This book is mine (= my book).</li><li>That car is yours (= your car).</li><li>The bag is hers.</li></ul><p><b>الملكية بـ ''s:</b></p><ul><li>Ahmed''s book = كتاب أحمد</li><li>The students'' books = كتب الطلاب (للجمع نضع '' فقط)</li></ul>',
'My = ـي | Your = ـك | His = ـه | Her = ـها | Our = ـنا | Their = ـهم | Mine = لي | Yours = لك | Hers = لها | Ours = لنا | Theirs = لهم | Brother = أخ | Sister = أخت | Father = أب | Mother = أم | Friend = صديق | Pet = حيوان أليف',
'<b>الفرق بين its و it''s:</b><ul><li><b>its</b> = ملكية (its color = لونه)</li><li><b>it''s</b> = اختصار it is (it''s hot = الجو حار)</li></ul><p><b>الفرق بين your و you''re:</b></p><ul><li>your = ملكية</li><li>you''re = you are</li></ul>',
'Sara: Whose phone is this?\nAhmed: It''s mine. Why?\nSara: It was ringing. Your friend was calling.\nAhmed: Oh, thanks! By the way, this is my brother''s book. Can I borrow yours?\nSara: Sure, here is mine. But please return it soon.\nAhmed: I will. Thank you!\nSara: How is your sister doing?\nAhmed: She is fine. Her birthday is next week.',
'1) املأ بصفة الملكية: I have a brother. ___ name is Ali.\n2) حول إلى ملكية: The book of Ahmed = ___\n3) ميز: That is (your/yours) bag. The blue car is (my/mine).\n4) اكتب 5 جمل تصف فيها أفراد عائلتك مستخدماً ضمائر الملكية.', 5);

-- كويز المستوى 2
INSERT INTO `quizzes` (`level_id`, `title`, `pass_score`) VALUES (@lvl2, 'كويز المستوى الثاني - الإنجليزية', 80);
SET @q2 = LAST_INSERT_ID();

INSERT INTO `questions` (`quiz_id`, `text`) VALUES
(@q2, 'ما الصيغة الصحيحة للمضارع البسيط مع He؟'),
(@q2, 'متى نستخدم المضارع المستمر؟'),
(@q2, 'ما الماضي من الفعل "go"؟'),
(@q2, 'ما الماضي من الفعل "eat"؟'),
(@q2, 'ما جمع كلمة "child"؟'),
(@q2, 'اختر الصحيح: She ___ to school every day.'),
(@q2, 'اختر الصحيح: Look! It ___ now.'),
(@q2, 'ما النفي الصحيح في الماضي البسيط؟'),
(@q2, 'ما صفة الملكية الصحيحة لـ "She"؟'),
(@q2, 'اختر: This book is ___ (mine/my).');

INSERT INTO `options` (`question_id`, `text`, `is_correct`) VALUES
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 0,1), 'He work', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 0,1), 'He works', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 0,1), 'He working', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 0,1), 'He is work', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 1,1), 'للعادات اليومية', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 1,1), 'للحقائق العامة', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 1,1), 'لأفعال تحدث الآن', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 1,1), 'للماضي', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 2,1), 'goed', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 2,1), 'gone', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 2,1), 'went', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 2,1), 'going', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 3,1), 'eated', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 3,1), 'ate', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 3,1), 'eaten', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 3,1), 'eating', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 4,1), 'childs', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 4,1), 'childes', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 4,1), 'children', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 4,1), 'childrens', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 5,1), 'go', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 5,1), 'goes', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 5,1), 'going', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 5,1), 'went', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 6,1), 'rain', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 6,1), 'rains', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 6,1), 'is raining', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 6,1), 'rained', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 7,1), 'I no went', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 7,1), 'I didn''t went', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 7,1), 'I didn''t go', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 7,1), 'I not go', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 8,1), 'his', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 8,1), 'her', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 8,1), 'their', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 8,1), 'its', 0),

((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 9,1), 'my', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 9,1), 'mine', 1),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 9,1), 'me', 0),
((SELECT id FROM questions WHERE quiz_id=@q2 ORDER BY id LIMIT 9,1), 'I', 0);

-- ============= المستوى 3 =============
INSERT INTO `lessons` (`level_id`, `title`, `intro`, `content`, `vocabulary`, `grammar`, `dialogue`, `exercises`, `order_num`) VALUES
(@lvl3, 'الدرس 1: المضارع التام (Present Perfect)',
'زمن مهم جداً يربط بين الماضي والحاضر، ولا يوجد مقابل مباشر له في العربية.',
'<p><b>التركيب:</b> فاعل + (have/has) + التصريف الثالث للفعل (Past Participle)</p><ul><li>I have visited Paris. (لقد زرت باريس)</li><li>She has finished her work. (لقد أنهت عملها)</li></ul><p><b>الاستخدامات:</b></p><ul><li>تجربة في الحياة: <i>I have eaten sushi before.</i></li><li>فعل بدأ في الماضي ومستمر للآن: <i>I have lived here for 5 years.</i></li><li>فعل قريب نتيجته في الحاضر: <i>I have lost my keys (= ما زلت لا أجدها).</i></li></ul><p><b>الكلمات الدالة:</b> ever, never, just, already, yet, since, for.</p><ul><li><b>since</b> + نقطة زمنية محددة (since 2010, since Monday).</li><li><b>for</b> + مدة (for 5 years, for 2 hours).</li></ul>',
'Visit = يزور | Travel = يسافر | Try = يجرب | Finish = ينهي | Lose = يفقد | Find = يجد | Just = للتو | Already = بالفعل | Yet = حتى الآن | Ever = في أي وقت | Never = أبداً | Recently = مؤخراً | Lately = مؤخراً | Experience = تجربة',
'<b>الفرق بين Past Simple و Present Perfect:</b><table border="1" cellpadding="5"><tr><th>Past Simple</th><th>Present Perfect</th></tr><tr><td>I visited Paris in 2010</td><td>I have visited Paris</td></tr><tr><td>وقت محدد</td><td>وقت غير محدد</td></tr></table><p><b>أمثلة على التصريف الثالث:</b> go → gone, see → seen, do → done, be → been, write → written, eat → eaten, take → taken.</p>',
'Interviewer: Have you ever worked abroad?\nCandidate: Yes, I have. I have worked in Dubai for 3 years.\nInterviewer: Have you finished the project we discussed?\nCandidate: Yes, I have just finished it.\nInterviewer: Have you ever managed a team?\nCandidate: I have never managed a big team, but I have led small projects.\nInterviewer: Great. Have you applied to other companies?\nCandidate: Not yet. This is my first application.',
'1) صرف هذه الأفعال (V1, V2, V3): go, eat, write, see, take, be, do, have.\n2) اختر بين Past Simple و Present Perfect:\n   - I (visited / have visited) Paris last summer.\n   - I (lived / have lived) here for 10 years.\n3) ترجم: "لم أتناول الفطور بعد." / "لقد تعلمت 3 لغات في حياتي."\n4) اكتب 5 جمل عن تجاربك في الحياة باستخدام Present Perfect.', 1),

(@lvl3, 'الدرس 2: المستقبل بأشكاله (Future Tenses)',
'هناك عدة طرق للتعبير عن المستقبل في الإنجليزية.',
'<p><b>1. Will:</b> للقرارات المفاجئة، التوقعات، الوعود.</p><ul><li>I will help you. (وعد)</li><li>It will rain tomorrow. (توقع)</li></ul><p><b>2. Be going to:</b> للنوايا والخطط المسبقة، أو لشيء واضح أنه سيحدث.</p><ul><li>I am going to study tonight. (خطة)</li><li>Look at those clouds! It is going to rain. (دليل)</li></ul><p><b>3. Present Continuous للمستقبل:</b> للمواعيد المحددة المؤكدة.</p><ul><li>I am meeting my friend at 7 PM tomorrow.</li></ul><p><b>4. Present Simple للمستقبل:</b> للجداول الثابتة (قطار، طائرة).</p><ul><li>The train leaves at 6 AM tomorrow.</li></ul>',
'Will = سوف | Going to = سـ | Tomorrow = غداً | Next week = الأسبوع القادم | Soon = قريباً | Later = لاحقاً | Plan = يخطط | Promise = يعد | Predict = يتوقع | Decision = قرار | Schedule = جدول | Appointment = موعد',
'<b>اختصارات will:</b><ul><li>I will = I''ll | She will = She''ll | They will = They''ll</li><li>will not = won''t</li></ul><p><b>السؤال:</b></p><ul><li>Will you help me? Yes, I will. / No, I won''t.</li><li>Are you going to study? Yes, I am. / No, I''m not.</li></ul>',
'Friend1: What are you doing this weekend?\nFriend2: I am going to visit my grandparents in Alexandria.\nFriend1: Nice! How will you get there?\nFriend2: I am taking the train at 9 AM on Saturday.\nFriend1: That sounds great. I''ll call you when you come back, OK?\nFriend2: Sure! I will be back on Sunday evening.\nFriend1: Have a great trip!\nFriend2: Thanks! I think it will rain though, so I am going to take an umbrella.',
'1) اختر الصيغة الأفضل للمستقبل:\n   - The phone is ringing! I (will / am going to) answer it.\n   - I (will / am going to) study medicine. I have already applied.\n   - The plane (leaves / will leave) at 7:00.\n2) ترجم: "سأساعدك غداً." / "سأذهب إلى السوق."\n3) اكتب 5 خطط لديك للأسبوع القادم.', 2),

(@lvl3, 'الدرس 3: المقارنة (Comparatives & Superlatives)',
'كيف نقارن بين الأشياء ونقول "أكبر، الأكبر".',
'<p><b>الصفات القصيرة (مقطع واحد):</b></p><ul><li>big → bigger → biggest</li><li>tall → taller → tallest</li><li>fast → faster → fastest</li></ul><p><b>الصفات المنتهية بـ y:</b></p><ul><li>happy → happier → happiest</li><li>busy → busier → busiest</li></ul><p><b>الصفات الطويلة (مقطعين أو أكثر):</b> نضيف more / most.</p><ul><li>beautiful → more beautiful → most beautiful</li><li>important → more important → most important</li></ul><p><b>الصفات الشاذة:</b></p><table border="1" cellpadding="5"><tr><th>الصفة</th><th>المقارن</th><th>التفضيل</th></tr><tr><td>good</td><td>better</td><td>best</td></tr><tr><td>bad</td><td>worse</td><td>worst</td></tr><tr><td>far</td><td>farther</td><td>farthest</td></tr><tr><td>little</td><td>less</td><td>least</td></tr><tr><td>much/many</td><td>more</td><td>most</td></tr></table>',
'Big = كبير | Small = صغير | Tall = طويل | Short = قصير | Fast = سريع | Slow = بطيء | Cheap = رخيص | Expensive = غالٍ | Easy = سهل | Difficult = صعب | Important = مهم | Beautiful = جميل | Better = أفضل | Worse = أسوأ',
'<b>التركيب:</b><ul><li><b>المقارن:</b> A + is + (-er/more) + than + B<br>Cairo is bigger than Aswan.</li><li><b>التفضيل:</b> A + is + the + (-est/most) + ...<br>Mount Everest is the tallest mountain in the world.</li></ul><p><b>المساواة:</b> as ... as<br>He is as tall as his brother.</p>',
'A: Which city do you prefer, Cairo or Alexandria?\nB: Alexandria is more beautiful than Cairo, but Cairo is bigger and more crowded.\nA: What about the weather?\nB: Alexandria has better weather. It is cooler.\nA: And which is the most expensive city in Egypt?\nB: I think Cairo is the most expensive, especially in new areas.\nA: How about food?\nB: Both have great food, but seafood in Alexandria is the best.',
'1) قارن: tall, expensive, good, happy, fast, beautiful.\n2) أكمل: My car is ___ (fast) than yours. This is ___ (good) book I have ever read.\n3) قارن بين 5 أشياء (مدن، أكلات، رياضات، إلخ).\n4) ترجم: "محمد أطول من أحمد، لكن خالد هو الأطول."', 3),

(@lvl3, 'الدرس 4: حروف الجر (Prepositions)',
'حروف الجر هي كلمات صغيرة لكنها مهمة جداً للمعنى.',
'<p><b>حروف جر للمكان:</b></p><ul><li><b>in</b> = داخل (in the box, in Cairo)</li><li><b>on</b> = على (on the table, on the wall)</li><li><b>at</b> = عند (at home, at school, at the door)</li><li><b>under</b> = تحت | <b>over</b> = فوق</li><li><b>between</b> = بين شيئين | <b>among</b> = بين عدة أشياء</li><li><b>next to / beside</b> = بجانب</li><li><b>in front of</b> = أمام | <b>behind</b> = خلف</li></ul><p><b>حروف جر للوقت:</b></p><ul><li><b>in</b> + شهر/سنة/فصل: in May, in 2024, in summer.</li><li><b>on</b> + يوم/تاريخ: on Monday, on July 5.</li><li><b>at</b> + ساعة محددة: at 7 PM, at noon, at night.</li></ul><p><b>حروف جر للحركة:</b></p><ul><li><b>to</b> = إلى | <b>from</b> = من | <b>into</b> = إلى داخل | <b>out of</b> = خارجاً | <b>through</b> = خلال</li></ul>',
'In = في | On = على | At = عند | Under = تحت | Over = فوق | Between = بين | Next to = بجانب | In front of = أمام | Behind = خلف | To = إلى | From = من | Into = إلى داخل | Out of = خارج',
'<b>تعابير ثابتة بحروف جر:</b><ul><li>good at = جيد في (good at math)</li><li>interested in = مهتم بـ</li><li>afraid of = خائف من</li><li>proud of = فخور بـ</li><li>depend on = يعتمد على</li><li>wait for = ينتظر</li><li>look at = ينظر إلى</li><li>listen to = يستمع إلى</li></ul>',
'A: Where do you live?\nB: I live in Cairo, on Tahrir Street, at number 25.\nA: When were you born?\nB: I was born in 1995, in May, on the 15th.\nA: Are you good at English?\nB: Yes, I am very interested in languages.\nA: What are you afraid of?\nB: I am afraid of heights. I can''t look down from tall buildings.\nA: I see. I depend on my phone for everything.',
'1) املأ بحرف الجر المناسب (in/on/at):\n   - The book is ___ the table.\n   - I was born ___ 1990.\n   - We meet ___ Monday ___ 5 PM.\n2) أكمل التعابير: good ___ math, afraid ___ snakes, interested ___ history.\n3) صف غرفتك مستخدماً 5 حروف جر مكانية مختلفة.', 4),

(@lvl3, 'الدرس 5: التعابير الشائعة وأفعال modal',
'الأفعال المساعدة المعنوية مهمة للتعبير عن القدرة، الإذن، الواجب.',
'<p><b>أهم Modal Verbs:</b></p><table border="1" cellpadding="5"><tr><th>الفعل</th><th>الاستخدام</th><th>مثال</th></tr><tr><td>can</td><td>قدرة / إمكانية</td><td>I can swim.</td></tr><tr><td>could</td><td>قدرة في الماضي / طلب مهذب</td><td>Could you help me?</td></tr><tr><td>may</td><td>إذن / احتمال</td><td>May I come in?</td></tr><tr><td>might</td><td>احتمال ضعيف</td><td>It might rain.</td></tr><tr><td>must</td><td>وجوب قوي</td><td>You must wear a seatbelt.</td></tr><tr><td>should</td><td>نصيحة</td><td>You should study hard.</td></tr><tr><td>have to</td><td>وجوب من ظرف خارجي</td><td>I have to work.</td></tr><tr><td>will</td><td>مستقبل / وعد</td><td>I will help you.</td></tr><tr><td>would</td><td>طلب مهذب / تمني</td><td>Would you like coffee?</td></tr></table><p><b>قواعد:</b></p><ul><li>بعد modal verb يأتي الفعل الأصلي بدون to (ما عدا have to و ought to).</li><li>لا نضيف s مع He/She/It مع modal verbs: She can swim (✗ She cans).</li><li>النفي: cannot (can''t), should not (shouldn''t), must not (mustn''t).</li></ul>',
'Can = يستطيع | Could = استطاع | May = يجوز | Must = يجب | Should = ينبغي | Would = طلب مهذب | Have to = مضطر لـ | Need to = يحتاج | Be able to = قادر على | Allowed to = مسموح له',
'<b>الفرق بين must و have to:</b><ul><li><b>must</b> = إلزام داخلي (شخصي): I must finish this today.</li><li><b>have to</b> = إلزام خارجي: I have to wake up at 6 (work rule).</li><li><b>mustn''t</b> = ممنوع: You mustn''t smoke here.</li><li><b>don''t have to</b> = ليس ضرورياً: You don''t have to come.</li></ul>',
'Manager: You must arrive on time every day. The work starts at 8 AM.\nEmployee: OK, I understand. Can I leave early on Fridays for prayer?\nManager: Yes, you may. But you should make up the time.\nEmployee: Sure. Could I also work from home sometimes?\nManager: That depends. You would have to discuss it with HR.\nEmployee: Thank you. I really appreciate your flexibility.\nManager: No problem. You should always feel comfortable to ask.',
'1) أكمل بـ modal مناسب: You ___ wear a seatbelt (إجباري). I ___ speak French (قدرة).\n2) ترجم: "هل يمكنك مساعدتي؟" / "يجب أن تدرس بجد." / "ربما تمطر غداً."\n3) اكتب 3 نصائح لشخص يريد تعلم الإنجليزية باستخدام should.\n4) فرق في المعنى بين: You must go vs. You should go vs. You may go.', 5);

-- كويز المستوى 3
INSERT INTO `quizzes` (`level_id`, `title`, `pass_score`) VALUES (@lvl3, 'كويز المستوى الثالث - الإنجليزية', 80);
SET @q3 = LAST_INSERT_ID();

INSERT INTO `questions` (`quiz_id`, `text`) VALUES
(@q3, 'ما التركيب الصحيح للـ Present Perfect؟'),
(@q3, 'اختر: I ___ Paris three times.'),
(@q3, 'متى نستخدم "be going to"؟'),
(@q3, 'ما تفضيل كلمة "good"؟'),
(@q3, 'املأ: I was born ___ 1995.'),
(@q3, 'ما الفرق بين "must" و"should"؟'),
(@q3, 'اختر: Cairo is ___ Alexandria.'),
(@q3, 'املأ: She is afraid ___ dogs.'),
(@q3, 'ما الصيغة الصحيحة بعد modal verb؟'),
(@q3, 'اختر الأنسب: The train ___ at 7 AM tomorrow (جدول ثابت).');

INSERT INTO `options` (`question_id`, `text`, `is_correct`) VALUES
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 0,1), 'have/has + V1', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 0,1), 'have/has + V2', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 0,1), 'have/has + V3', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 0,1), 'have/has + V-ing', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 1,1), 'visit', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 1,1), 'visited', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 1,1), 'have visited', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 1,1), 'visiting', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 2,1), 'للقرارات المفاجئة', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 2,1), 'للنوايا والخطط المسبقة', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 2,1), 'للماضي', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 2,1), 'للحقائق', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 3,1), 'gooder', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 3,1), 'goodest', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 3,1), 'best', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 3,1), 'most good', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 4,1), 'on', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 4,1), 'in', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 4,1), 'at', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 4,1), 'by', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 5,1), 'must = نصيحة، should = إلزام', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 5,1), 'must = إلزام قوي، should = نصيحة', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 5,1), 'لا فرق بينهما', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 5,1), 'must للمستقبل، should للماضي', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 6,1), 'big than', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 6,1), 'bigger than', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 6,1), 'more big than', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 6,1), 'biggest than', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 7,1), 'in', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 7,1), 'at', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 7,1), 'of', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 7,1), 'on', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 8,1), 'الفعل + s', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 8,1), 'الفعل + ing', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 8,1), 'الفعل الأصلي بدون to', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 8,1), 'to + الفعل', 0),

((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 9,1), 'will leave', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 9,1), 'is going to leave', 0),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 9,1), 'leaves', 1),
((SELECT id FROM questions WHERE quiz_id=@q3 ORDER BY id LIMIT 9,1), 'leaving', 0);

-- ============= المستوى 4 =============
INSERT INTO `lessons` (`level_id`, `title`, `intro`, `content`, `vocabulary`, `grammar`, `dialogue`, `exercises`, `order_num`) VALUES
(@lvl4, 'الدرس 1: المبني للمجهول (Passive Voice)',
'يستخدم عندما يكون الفاعل غير معروف أو غير مهم، أو لتسليط الضوء على المفعول.',
'<p><b>التركيب:</b> الفاعل + (be) + التصريف الثالث + (by + الفاعل الأصلي اختيارياً)</p><p><b>التحويل من المعلوم إلى المجهول:</b></p><table border="1" cellpadding="5"><tr><th>الزمن</th><th>المعلوم</th><th>المجهول</th></tr><tr><td>Present Simple</td><td>They make cars.</td><td>Cars are made.</td></tr><tr><td>Past Simple</td><td>He wrote the letter.</td><td>The letter was written.</td></tr><tr><td>Present Continuous</td><td>They are building it.</td><td>It is being built.</td></tr><tr><td>Present Perfect</td><td>She has finished it.</td><td>It has been finished.</td></tr><tr><td>Future</td><td>They will solve it.</td><td>It will be solved.</td></tr><tr><td>Modal</td><td>You must do it.</td><td>It must be done.</td></tr></table>',
'Build = يبني | Make = يصنع | Invent = يخترع | Discover = يكتشف | Found = يؤسس | Write = يكتب | Paint = يرسم | Compose = يؤلف | Be done = يُفعل | Be made = يُصنع',
'<b>متى نستخدم المبني للمجهول؟</b><ul><li>الفاعل غير معروف: My phone was stolen.</li><li>الفاعل غير مهم: English is spoken here.</li><li>التركيز على المفعول: The pyramids were built by ancient Egyptians.</li><li>الأخبار والتقارير الرسمية: A new law was passed yesterday.</li></ul>',
'Reporter: Where was this painting made?\nGuide: It was painted by an Egyptian artist in 1920.\nReporter: How many people visit this museum every year?\nGuide: The museum is visited by about a million people annually.\nReporter: Are any new exhibitions being prepared?\nGuide: Yes, a new collection will be opened next month.\nReporter: Will photos be allowed inside?\nGuide: Photos are not allowed in this hall, but they can be taken in the main lobby.',
'1) حول إلى مبني للمجهول:\n   - They built the bridge in 1990.\n   - Someone stole my car.\n   - They are repairing the road.\n2) حول إلى معلوم: The book was written by Naguib Mahfouz.\n3) اكتب 5 جمل عن إنجازات مصرية مستخدماً المبني للمجهول.\n4) ترجم: "تم تأسيس هذا الموقع عام 2024." / "اللغة العربية يتحدث بها أكثر من 400 مليون شخص."', 1),

(@lvl4, 'الدرس 2: الجمل الشرطية (Conditional Sentences)',
'الشرطية أساسية للتعبير عن المواقف الافتراضية.',
'<p><b>النوع 0 (الحقائق العامة):</b> If + present simple, present simple.</p><ul><li>If you heat water to 100°C, it boils.</li></ul><p><b>النوع 1 (المستقبل الممكن):</b> If + present simple, will + V1.</p><ul><li>If it rains tomorrow, I will stay home.</li></ul><p><b>النوع 2 (الافتراضي غير الواقعي):</b> If + past simple, would + V1.</p><ul><li>If I were rich, I would travel the world.</li><li>(لاحظ: نستخدم were مع كل الضمائر في الشرطية).</li></ul><p><b>النوع 3 (الماضي المستحيل):</b> If + past perfect, would have + V3.</p><ul><li>If I had studied harder, I would have passed.</li></ul><p><b>النوع المختلط:</b> If + past perfect, would + V1 (نتيجة في الحاضر لشيء حدث في الماضي).</p><ul><li>If I had taken that job, I would be rich now.</li></ul>',
'If = إذا | Unless = إلا إذا | Provided that = شريطة أن | As long as = طالما | In case = في حالة | Otherwise = وإلا | Wish = يتمنى | Suppose = افترض | Imagine = تخيل',
'<b>أخطاء شائعة:</b><ul><li>✗ If I will go ✓ If I go (لا نستخدم will بعد if).</li><li>✗ If I would have ✓ If I had (لا نستخدم would في جزء if).</li></ul><p><b>I wish + past simple</b> = أتمنى لو (للحاضر):</p><ul><li>I wish I had more time. (أتمنى لو كان لدي وقت أكثر).</li></ul><p><b>I wish + past perfect</b> = أتمنى لو (للماضي):</p><ul><li>I wish I had studied medicine. (أتمنى لو درست الطب).</li></ul>',
'A: What would you do if you won a million dollars?\nB: If I won that much money, I would travel around the world and start my own business.\nA: That sounds great. And what would you have done if you hadn''t become an engineer?\nB: If I hadn''t studied engineering, I would have become a doctor. I always loved medicine.\nA: Interesting! Do you regret your decision?\nB: Sometimes. I wish I had explored more options when I was young.\nA: Well, if you study hard now, you can still change your career.\nB: True! If life gives you another chance, take it.',
'1) أكمل الجمل الشرطية:\n   - If I had time, I (visit) my grandmother.\n   - If you (study), you would have passed.\n   - If you heat ice, it (melt).\n2) ترجم: "لو كنت مكانك، لما فعلت ذلك."\n3) اكتب 3 جمل بـ I wish عن أمنيات في حياتك.\n4) صف ماذا ستفعل لو سافرت إلى دولة معينة.', 2),

(@lvl4, 'الدرس 3: الكلام المنقول (Reported Speech)',
'كيف ننقل ما قاله الآخرون.',
'<p><b>تغيير الأزمنة في النقل:</b></p><table border="1" cellpadding="5"><tr><th>الكلام المباشر</th><th>الكلام المنقول</th></tr><tr><td>Present Simple</td><td>Past Simple</td></tr><tr><td>Present Continuous</td><td>Past Continuous</td></tr><tr><td>Past Simple</td><td>Past Perfect</td></tr><tr><td>Present Perfect</td><td>Past Perfect</td></tr><tr><td>will</td><td>would</td></tr><tr><td>can</td><td>could</td></tr><tr><td>must</td><td>had to</td></tr></table><p><b>أمثلة:</b></p><ul><li>"I am happy" → He said he was happy.</li><li>"I will come" → She said she would come.</li><li>"I have finished" → He said he had finished.</li></ul><p><b>تغيير الكلمات الزمنية والمكانية:</b></p><ul><li>now → then | today → that day | yesterday → the day before | tomorrow → the next day | here → there | this → that</li></ul>',
'Said = قال | Told = أخبر | Asked = سأل | Replied = أجاب | Mentioned = ذكر | Explained = أوضح | Promised = وعد | Suggested = اقترح | Whether/If = هل | That = أن',
'<b>السؤال المنقول:</b><ul><li>سؤال yes/no: نستخدم if/whether.<br>"Are you happy?" → He asked if I was happy.</li><li>سؤال WH: نستخدم نفس كلمة السؤال.<br>"Where do you live?" → She asked where I lived.</li><li>تذكر: ترتيب الجملة بعد if/whether يصبح ترتيب جملة عادية وليس سؤال.</li></ul><p><b>الأوامر المنقولة:</b> told + somebody + (not) to + V1.</p><ul><li>"Don''t talk!" → The teacher told us not to talk.</li></ul>',
'Direct conversation:\nManager: "I will increase your salary next month."\nEmployee: "Thank you very much!"\nManager: "Are you happy with the new project?"\nEmployee: "Yes, I am very excited."\n\nReported version:\nThe manager said he would increase my salary the next month, and I thanked him very much. He asked if I was happy with the new project, and I replied that I was very excited.',
'1) حول إلى كلام منقول:\n   - "I am tired," he said.\n   - "We will meet tomorrow," she said.\n   - "Did you finish?" he asked.\n2) حول إلى مباشر: She told me she had visited Paris.\n3) اكتب فقرة تنقل فيها مكالمة هاتفية بين شخصين (10 جمل).', 3),

(@lvl4, 'الدرس 4: الجمل الموصولة (Relative Clauses)',
'تستخدم لربط جملتين والإشارة لشخص أو شيء معين.',
'<p><b>الضمائر الموصولة:</b></p><ul><li><b>who</b> = الذي/التي (للأشخاص): The man who lives next door is a doctor.</li><li><b>which</b> = الذي/التي (للأشياء والحيوانات): The book which I read was interesting.</li><li><b>that</b> = للأشخاص أو الأشياء: The car that I bought is fast.</li><li><b>whose</b> = الذي ـه/ـها (للملكية): The girl whose father is a teacher.</li><li><b>where</b> = حيث (للمكان): The city where I was born.</li><li><b>when</b> = عندما (للزمان): The day when we met.</li></ul><p><b>نوعان من الجمل الموصولة:</b></p><ol><li><b>Defining (محددة):</b> ضرورية للمعنى، لا فواصل.<br>The man who called you is here.</li><li><b>Non-defining (غير محددة):</b> معلومة إضافية، بفواصل، ولا تستخدم that.<br>My brother, who lives in Dubai, is visiting us.</li></ol>',
'Who = الذي (للعاقل) | Which = الذي (لغير العاقل) | That = الذي (عام) | Whose = الذي له | Where = حيث | When = عندما | Whom = الذي (مفعول) | Reason = سبب | Result = نتيجة',
'<b>حذف الضمير الموصول:</b> يمكن حذفه إذا كان مفعولاً.<ul><li>The book (that) I read was great. ✓</li><li>The man (who) I met was kind. ✓</li><li>(لا يحذف إذا كان فاعلاً): The man who called you... ✗</li></ul>',
'A: Do you know the woman who is sitting over there?\nB: Yes, that''s Sara. She''s the doctor whose clinic we visited last week.\nA: Oh really! And the man she''s talking to?\nB: That''s her husband. He works in a company which exports software to Europe.\nA: I see. Cairo, where they live, has many talented professionals.\nB: Absolutely. By the way, the restaurant where we are now is owned by their cousin.\nA: That explains why the food is so good!',
'1) اربط الجمل بضمير موصول:\n   - I know a man. He speaks 5 languages.\n   - This is the book. I told you about it.\n   - I visited the city. I was born there.\n2) أضف ضمير موصول مناسب: The girl ___ won the prize is my friend.\n3) اكتب 5 جمل تعرف فيها أشخاصاً أو أشياء حولك مستخدماً الموصولات.', 4),

(@lvl4, 'الدرس 5: مهارات المحادثة المتقدمة',
'كيف تكون أكثر طلاقة في المحادثات الواقعية.',
'<p><b>عبارات بدء المحادثة:</b></p><ul><li>How''s it going? - كيف الحال؟</li><li>What''s up? - ما الأخبار؟</li><li>Long time no see! - لم نلتق منذ زمن!</li><li>Nice to see you again. - سعيد برؤيتك ثانية.</li></ul><p><b>إبداء الرأي:</b></p><ul><li>In my opinion... - في رأيي...</li><li>If you ask me... - إذا سألتني...</li><li>I believe / I think... - أعتقد...</li><li>From my point of view... - من وجهة نظري...</li></ul><p><b>الموافقة وعدمها:</b></p><ul><li>I totally agree. / Absolutely! - أوافق تماماً</li><li>I see your point, but... - أفهم وجهة نظرك، لكن...</li><li>I''m afraid I disagree. - أخشى أنني أختلف</li><li>That''s a good point. - نقطة جيدة</li></ul><p><b>الترددات والمصطلحات الحوارية:</b></p><ul><li>Let me think... - دعني أفكر</li><li>Well, you know... - حسناً، تعرف</li><li>Actually... - في الحقيقة</li><li>To be honest... - بصراحة</li></ul><p><b>تعابير اصطلاحية شائعة (Idioms):</b></p><ul><li>Break the ice - كسر الجمود</li><li>It''s a piece of cake - شيء سهل جداً</li><li>Cost an arm and a leg - مكلف جداً</li><li>Once in a blue moon - نادراً جداً</li><li>Hit the books - يدرس بجد</li><li>Spill the beans - يفشي السر</li></ul>',
'Opinion = رأي | Agree = يوافق | Disagree = يختلف | Argue = يجادل | Convince = يقنع | Suggest = يقترح | Recommend = ينصح | Confident = واثق | Fluent = طليق | Pronunciation = نطق | Accent = لكنة',
'<b>نصائح للطلاقة:</b><ul><li>لا تترجم من العربية، فكر بالإنجليزية مباشرة.</li><li>تعلم العبارات الجاهزة (chunks) مثل: as a matter of fact, on the other hand.</li><li>استخدم filler words بدل التوقف: well, you know, I mean.</li><li>اقرأ بصوت عالٍ يومياً.</li><li>سجل صوتك واستمع للأخطاء.</li><li>شاهد أفلاماً ومسلسلات بدون ترجمة.</li></ul>',
'Discussion about technology:\nA: So, what do you think about social media?\nB: Well, in my opinion, it has both pros and cons. On one hand, it connects us with people around the world. On the other hand, it can be addictive.\nA: I see your point, but I think the cons outweigh the pros these days.\nB: Really? Why do you think so?\nA: To be honest, people spend too much time online and forget about real life.\nB: That''s a fair point. Although I think it depends on how you use it.\nA: Absolutely. Moderation is the key.\nB: Exactly! It''s like food - too much of anything is bad.\nA: Couldn''t agree more!',
'1) استخدم 5 idioms في جمل من تأليفك.\n2) اكتب فقرة تعبر فيها عن رأيك في موضوع: التعليم عن بعد، أو السوشيال ميديا، أو السفر.\n3) سجل نفسك تتحدث لمدة دقيقتين عن نفسك بالإنجليزية، ثم استمع وحدد أخطاءك.\n4) اكتب حواراً بين شخصين يختلفان في الرأي ولكن يحترمان وجهة نظر بعضهما.\n5) ترجم: "بصراحة، أعتقد أن هذا مكلف جداً، لكن من ناحية أخرى، الجودة ممتازة."', 5);

-- كويز المستوى 4
INSERT INTO `quizzes` (`level_id`, `title`, `pass_score`) VALUES (@lvl4, 'كويز المستوى الرابع - الإنجليزية', 80);
SET @q4 = LAST_INSERT_ID();

INSERT INTO `questions` (`quiz_id`, `text`) VALUES
(@q4, 'حول إلى مبني للمجهول: They built the school in 1990.'),
(@q4, 'أكمل: If I ___ rich, I would buy a house.'),
(@q4, 'أي نوع من الشرطية: If it rains, I will stay home.'),
(@q4, 'حول إلى منقول: He said, "I am tired."'),
(@q4, 'أكمل: The man ___ called you is here. (للعاقل)'),
(@q4, 'متى نستخدم Past Perfect في الكلام المنقول؟'),
(@q4, 'ماذا يعني idiom: "It''s a piece of cake"؟'),
(@q4, 'اختر: This museum ___ by millions every year. (مبني للمجهول)'),
(@q4, 'أكمل: I wish I ___ more time yesterday.'),
(@q4, 'الجملة الموصولة غير المحددة (Non-defining) تستخدم؟');

INSERT INTO `options` (`question_id`, `text`, `is_correct`) VALUES
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 0,1), 'The school built in 1990', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 0,1), 'The school was built in 1990', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 0,1), 'The school is built in 1990', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 0,1), 'The school had built in 1990', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 1,1), 'am', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 1,1), 'will be', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 1,1), 'were', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 1,1), 'would be', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 2,1), 'النوع الصفر', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 2,1), 'النوع الأول', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 2,1), 'النوع الثاني', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 2,1), 'النوع الثالث', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 3,1), 'He said he is tired', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 3,1), 'He said he was tired', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 3,1), 'He said I am tired', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 3,1), 'He said he were tired', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 4,1), 'which', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 4,1), 'who', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 4,1), 'whose', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 4,1), 'where', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 5,1), 'بدلاً من Present Simple', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 5,1), 'بدلاً من Past Simple أو Present Perfect', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 5,1), 'بدلاً من Future', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 5,1), 'لا يستخدم في النقل', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 6,1), 'شيء صعب جداً', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 6,1), 'شيء سهل جداً', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 6,1), 'كعكة لذيذة', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 6,1), 'حلوى مكلفة', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 7,1), 'visits', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 7,1), 'is visiting', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 7,1), 'is visited', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 7,1), 'was visiting', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 8,1), 'have', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 8,1), 'had', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 8,1), 'has', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 8,1), 'will have', 0),

((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 9,1), 'بدون فواصل ومع that', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 9,1), 'بفواصل وبدون that', 1),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 9,1), 'بدون ضمير موصول', 0),
((SELECT id FROM questions WHERE quiz_id=@q4 ORDER BY id LIMIT 9,1), 'مع who فقط', 0);
-- =============================================================
-- المحتوى التعليمي للغات الـ 10 المتبقية
-- كل لغة: 4 مستويات × (3 دروس + كويز) - يمكن للمدير إضافة المزيد بسهولة
-- =============================================================

USE `3almni_db`;

DELIMITER $$

-- إجراء لإضافة محتوى أساسي للغة معينة بطريقة منظمة
DROP PROCEDURE IF EXISTS seed_language_content$$
CREATE PROCEDURE seed_language_content(
  IN p_lang_id INT,
  IN p_lang_name VARCHAR(50),
  IN p_greeting VARCHAR(255),
  IN p_thanks VARCHAR(255),
  IN p_yes_no VARCHAR(255),
  IN p_numbers VARCHAR(500),
  IN p_pronouns VARCHAR(500),
  IN p_present_verb VARCHAR(500),
  IN p_grammar_intro TEXT,
  IN p_dialogue_basic TEXT,
  IN p_advanced_topics TEXT
)
BEGIN
  DECLARE lvl1_id, lvl2_id, lvl3_id, lvl4_id INT;
  DECLARE q1_id, q2_id, q3_id, q4_id INT;

  SELECT id INTO lvl1_id FROM levels WHERE language_id=p_lang_id AND level_number=1;
  SELECT id INTO lvl2_id FROM levels WHERE language_id=p_lang_id AND level_number=2;
  SELECT id INTO lvl3_id FROM levels WHERE language_id=p_lang_id AND level_number=3;
  SELECT id INTO lvl4_id FROM levels WHERE language_id=p_lang_id AND level_number=4;

  -- ===== المستوى 1 =====
  INSERT INTO lessons (level_id, title, intro, content, vocabulary, grammar, dialogue, exercises, order_num) VALUES
  (lvl1_id, CONCAT('الدرس 1: التحيات والتعارف بـ', p_lang_name),
   CONCAT('في هذا الدرس ستتعلم كيف تحيي وتعرف بنفسك بـ', p_lang_name),
   CONCAT('<p>التحيات هي أهم ما يبدأ به متعلم أي لغة.</p>', p_greeting,
          '<p>الشكر والاعتذار:</p>', p_thanks,
          '<p>نعم ولا والإجابات البسيطة:</p>', p_yes_no),
   p_greeting,
   '<p>تذكر أن نطق التحيات الصحيح أساسي لانطباع جيد عن متحدث اللغة. تدرب يومياً على النطق.</p>',
   p_dialogue_basic,
   CONCAT('1) كرر التحيات بصوت عالٍ 10 مرات.\n2) اكتب 5 جمل تحية وتعارف مختلفة.\n3) سجل صوتك وهو يحيي بـ', p_lang_name, '.'),
   1),

  (lvl1_id, CONCAT('الدرس 2: الأرقام والوقت بـ', p_lang_name),
   'تعلم العد من 1 إلى 100 وكيف تسأل عن الوقت.',
   CONCAT('<p>الأرقام أساسية في كل تعامل يومي.</p>', p_numbers,
          '<p>السؤال عن الوقت والعمر من الأساسيات.</p>'),
   p_numbers,
   '<p>تعلم الأرقام يفتح لك التعامل مع الأسعار، الوقت، الأعمار والمواعيد.</p>',
   '<p>تدرب على عد من 1 إلى 20 ثم العشرات حتى المئة.</p>',
   '1) عد من 1 إلى 20 بصوت عالٍ.\n2) اكتب 5 أعمار وأسعار بالأرقام.\n3) اسأل صديقاً عن عمره ووقت الحصة.',
   2),

  (lvl1_id, CONCAT('الدرس 3: الضمائر والفعل الأساسي بـ', p_lang_name),
   'تعلم كيف تستخدم الضمائر مع أهم الأفعال.',
   CONCAT('<p>الضمائر الشخصية هي العمود الفقري لأي جملة.</p>', p_pronouns,
          '<p>الفعل "يكون/يفعل" أساسي في الجمل البسيطة.</p>', p_present_verb),
   p_pronouns,
   p_grammar_intro,
   '<p>تدرب على تركيب جمل بسيطة من الضمير + الفعل + المفعول.</p>',
   '1) اكتب 10 جمل تستخدم فيها الضمائر المختلفة.\n2) ترجم 5 جمل بسيطة من العربية.\n3) اعمل قائمة بأهم 20 كلمة تعلمتها.',
   3);

  -- كويز المستوى 1
  INSERT INTO quizzes (level_id, title, pass_score) VALUES (lvl1_id, CONCAT('كويز المستوى الأول - ', p_lang_name), 80);
  SET q1_id = LAST_INSERT_ID();

  INSERT INTO questions (quiz_id, text) VALUES
  (q1_id, CONCAT('ما أهم ما يبدأ به متعلم لغة ', p_lang_name, '؟')),
  (q1_id, 'لماذا الأرقام مهمة في تعلم اللغة؟'),
  (q1_id, 'الضمائر الشخصية تعتبر:'),
  (q1_id, 'النطق الصحيح يأتي بـ:'),
  (q1_id, 'الجمع بين الضمير والفعل يكوّن:');

  INSERT INTO options (question_id, text, is_correct) VALUES
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 0,1), 'التحيات والتعارف', 1),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 0,1), 'القواعد المعقدة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 0,1), 'الأدب', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 0,1), 'الكتابة المتقدمة', 0),

  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 1,1), 'للأسعار والوقت والأعمار', 1),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 1,1), 'للقراءة فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 1,1), 'لا أهمية لها', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 1,1), 'للمحادثات المتقدمة فقط', 0),

  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 2,1), 'العمود الفقري للجملة', 1),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 2,1), 'غير مهمة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 2,1), 'تستخدم نادراً', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 2,1), 'تتعلم في المراحل المتقدمة', 0),

  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 3,1), 'التدريب اليومي', 1),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 3,1), 'القراءة فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 3,1), 'الحفظ بدون تطبيق', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 3,1), 'الترجمة فقط', 0),

  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 4,1), 'جملة كاملة', 1),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 4,1), 'كلمة واحدة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 4,1), 'صفة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q1_id ORDER BY id LIMIT 4,1), 'حرف', 0);

  -- ===== المستوى 2 =====
  INSERT INTO lessons (level_id, title, intro, content, vocabulary, grammar, dialogue, exercises, order_num) VALUES
  (lvl2_id, CONCAT('الدرس 1: قواعد المضارع البسيط بـ', p_lang_name),
   CONCAT('تعلم كيف تتحدث عن العادات والروتين بـ', p_lang_name),
   CONCAT('<p>المضارع البسيط هو زمن العادات والحقائق العامة.</p>', p_grammar_intro),
   '<p>المفردات الشائعة في الروتين اليومي: يستيقظ، يأكل، يعمل، يدرس، ينام.</p>',
   p_grammar_intro,
   p_dialogue_basic,
   '1) اكتب فقرة عن روتينك اليومي.\n2) صرف 5 أفعال شائعة.\n3) اكتب 10 جمل عن عاداتك.',
   1),

  (lvl2_id, CONCAT('الدرس 2: الجمل الاستفهامية والنفي بـ', p_lang_name),
   'كيف تطرح الأسئلة وتنفي الجمل.',
   '<p>الأسئلة من أهم أدوات التواصل. تعلم كيف تسأل بطرق مختلفة.</p>',
   '<p>كلمات الاستفهام الأساسية: ما، من، أين، متى، لماذا، كيف.</p>',
   '<p>قواعد النفي تختلف من لغة لأخرى لكن المبدأ متشابه: أداة نفي + الفعل.</p>',
   '<p>تدرب على إعادة صياغة الجمل من إثبات إلى نفي إلى سؤال.</p>',
   '1) حول 10 جمل من إثبات إلى سؤال.\n2) اكتب 5 جمل نفي.\n3) اعمل حواراً قصيراً به أسئلة وأجوبة.',
   2),

  (lvl2_id, CONCAT('الدرس 3: مفردات الحياة اليومية بـ', p_lang_name),
   'كلمات تستخدمها كل يوم في كل مكان.',
   '<p>توسيع المفردات أهم من حفظ القواعد. ركز على كلمات الأكل، البيت، العمل، الأسرة.</p>',
   '<p>أكل: خبز، ماء، فطور، غداء، عشاء.\nبيت: غرفة، باب، نافذة، طاولة، كرسي.\nأسرة: أب، أم، أخ، أخت، ابن، ابنة.\nعمل: مكتب، اجتماع، مشروع، زميل.</p>',
   '<p>كلما زادت مفرداتك، زادت طلاقتك. اهدف إلى تعلم 20 كلمة جديدة أسبوعياً.</p>',
   '<p>اعمل بطاقات (Flashcards) للكلمات الجديدة وراجعها يومياً.</p>',
   '1) احفظ 30 كلمة جديدة هذا الأسبوع.\n2) اكتب فقرة تستخدم فيها 15 من الكلمات الجديدة.\n3) صف غرفتك بالتفصيل.',
   3);

  INSERT INTO quizzes (level_id, title, pass_score) VALUES (lvl2_id, CONCAT('كويز المستوى الثاني - ', p_lang_name), 80);
  SET q2_id = LAST_INSERT_ID();

  INSERT INTO questions (quiz_id, text) VALUES
  (q2_id, 'متى نستخدم المضارع البسيط؟'),
  (q2_id, 'الأسئلة من أدوات:'),
  (q2_id, 'كم كلمة جديدة يفضل تعلمها أسبوعياً؟'),
  (q2_id, 'الفلاش كاردز تساعد في:'),
  (q2_id, 'لتحقيق الطلاقة نحتاج إلى:');

  INSERT INTO options (question_id, text, is_correct) VALUES
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 0,1), 'العادات والحقائق', 1),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 0,1), 'الماضي فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 0,1), 'المستقبل البعيد', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 0,1), 'الشعر فقط', 0),

  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 1,1), 'التواصل', 1),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 1,1), 'الكتابة فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 1,1), 'الإملاء', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 1,1), 'القواعد فقط', 0),

  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 2,1), '20 كلمة', 1),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 2,1), '5 كلمات', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 2,1), '500 كلمة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 2,1), 'لا حاجة لتعلم كلمات جديدة', 0),

  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 3,1), 'حفظ المفردات بشكل فعال', 1),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 3,1), 'الكتابة الإبداعية', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 3,1), 'الحساب', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 3,1), 'الرسم', 0),

  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 4,1), 'مفردات كثيرة وممارسة يومية', 1),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 4,1), 'الحفظ فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 4,1), 'القواعد فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q2_id ORDER BY id LIMIT 4,1), 'الترجمة الحرفية', 0);

  -- ===== المستوى 3 =====
  INSERT INTO lessons (level_id, title, intro, content, vocabulary, grammar, dialogue, exercises, order_num) VALUES
  (lvl3_id, CONCAT('الدرس 1: الماضي والمستقبل بـ', p_lang_name),
   'تعلم كيف تتحدث عن أحداث الأمس والغد.',
   '<p>الأزمنة الثلاثة (الماضي، الحاضر، المستقبل) أساس أي محادثة.</p><p>تعلم تصريف الأفعال في الأزمنة المختلفة وكيف تربط بينها.</p>',
   '<p>كلمات زمنية مهمة: أمس، اليوم، غداً، الأسبوع الماضي، الشهر القادم، السنة الماضية.</p>',
   '<p>تنبه إلى أن بعض اللغات تستخدم نظاماً مختلفاً للأزمنة عما تعرفه في العربية.</p>',
   '<p>تدرب على رواية أحداث يومك أمس (ماضي) وخططك لغد (مستقبل).</p>',
   '1) اكتب فقرة عما فعلته أمس.\n2) اكتب فقرة عن خططك للأسبوع القادم.\n3) ارو قصة قصيرة باستخدام الماضي.',
   1),

  (lvl3_id, CONCAT('الدرس 2: المقارنة والوصف بـ', p_lang_name),
   'كيف تصف الأشياء وتقارن بينها.',
   '<p>الصفات تجعل كلامك أكثر دقة وجمالاً. تعلم أهم الصفات وكيفية المقارنة.</p>',
   '<p>صفات مهمة: كبير/صغير، طويل/قصير، سعيد/حزين، جميل/قبيح، رخيص/غالٍ، سهل/صعب.</p>',
   '<p>المقارنة (أكبر، أجمل، أفضل) لها قواعد تختلف من لغة لأخرى. ركز على نمط لغتك.</p>',
   '<p>قارن بين شخصين أو مكانين أو شيئين تعرفهما.</p>',
   '1) صف 5 أشخاص تعرفهم.\n2) قارن بين مدينتين.\n3) اكتب 10 صفات مع أضدادها.',
   2),

  (lvl3_id, CONCAT('الدرس 3: المحادثات في المواقف المختلفة بـ', p_lang_name),
   'مواقف عملية: المطعم، المطار، التسوق، الطبيب.',
   '<p>تعلم العبارات الجاهزة للمواقف الشائعة:</p><ul><li>في المطعم: طلب الأكل، طلب الفاتورة.</li><li>في المطار: حجز التذكرة، الجمارك.</li><li>في التسوق: السؤال عن السعر، المساومة.</li><li>عند الطبيب: شرح الأعراض.</li></ul>',
   '<p>عبارات: من فضلك، شكراً، كم سعر، أين، أحتاج، أريد، لا أفهم، أعد من فضلك.</p>',
   '<p>هذه المواقف تتطلب عبارات سريعة ومباشرة. لا تترجم حرفياً، احفظ العبارة كاملة.</p>',
   '<p>مارس مع صديق سيناريوهات مختلفة (لعب أدوار).</p>',
   '1) احفظ 10 عبارات لكل موقف.\n2) اكتب حواراً في مطعم (10 أسطر).\n3) سجل نفسك تتسوق.',
   3);

  INSERT INTO quizzes (level_id, title, pass_score) VALUES (lvl3_id, CONCAT('كويز المستوى الثالث - ', p_lang_name), 80);
  SET q3_id = LAST_INSERT_ID();

  INSERT INTO questions (quiz_id, text) VALUES
  (q3_id, 'كم زمن أساسي في معظم اللغات؟'),
  (q3_id, 'الصفات تستخدم لـ:'),
  (q3_id, 'في المطعم نحتاج عبارات لـ:'),
  (q3_id, 'لتعلم المحادثة بسرعة:'),
  (q3_id, 'الترجمة الحرفية:');

  INSERT INTO options (question_id, text, is_correct) VALUES
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 0,1), '3 (ماضي/حاضر/مستقبل)', 1),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 0,1), '5', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 0,1), '10', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 0,1), '1', 0),

  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 1,1), 'وصف ودقة الكلام', 1),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 1,1), 'الكتابة فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 1,1), 'الترجمة فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 1,1), 'لا تستخدم', 0),

  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 2,1), 'طلب الأكل والفاتورة', 1),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 2,1), 'القواعد المعقدة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 2,1), 'الأدب الكلاسيكي', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 2,1), 'الشعر', 0),

  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 3,1), 'احفظ العبارات كاملة', 1),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 3,1), 'احفظ الحروف فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 3,1), 'تجنب الممارسة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 3,1), 'لا تستمع للناطقين', 0),

  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 4,1), 'غير محبذة دائماً', 1),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 4,1), 'الأفضل دائماً', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 4,1), 'لا فرق', 0),
  ((SELECT id FROM questions WHERE quiz_id=q3_id ORDER BY id LIMIT 4,1), 'الطريقة الوحيدة', 0);

  -- ===== المستوى 4 =====
  INSERT INTO lessons (level_id, title, intro, content, vocabulary, grammar, dialogue, exercises, order_num) VALUES
  (lvl4_id, CONCAT('الدرس 1: الطلاقة والمحادثات الواقعية بـ', p_lang_name),
   'كيف تكون متحدثاً طليقاً وواثقاً.',
   CONCAT('<p>الطلاقة تأتي من الممارسة المستمرة، وليس فقط القواعد.</p>', p_advanced_topics),
   '<p>تعابير الطلاقة: في الواقع، بصراحة، من ناحية أخرى، بناءً على ذلك، باختصار.</p>',
   '<p>القواعد المتقدمة: المبني للمجهول، الجمل الشرطية، الكلام المنقول، الجمل الموصولة.</p>',
   '<p>تدرب على إبداء الرأي والمناقشة في موضوعات متنوعة.</p>',
   '1) اكتب رأيك في موضوع معاصر (300 كلمة).\n2) سجل نفسك تتحدث 3 دقائق بدون توقف.\n3) ناقش شخصاً آخر في موضوع مثير.',
   1),

  (lvl4_id, CONCAT('الدرس 2: قراءة وفهم النصوص بـ', p_lang_name),
   'مهارة فهم المقالات والقصص.',
   '<p>القراءة هي أسرع طريق لإثراء المفردات والأسلوب.</p><p>اقرأ مقالات إخبارية، قصصاً قصيرة، روايات بسيطة.</p>',
   '<p>كلمات أكاديمية: تحليل، تركيب، استنتاج، فرضية، نظرية، تطبيق، مفهوم.</p>',
   '<p>عند القراءة، لا تتوقف عند كل كلمة جديدة. حاول استنباط المعنى من السياق.</p>',
   '<p>اقرأ الخبر بصوت عالٍ ولخصه بكلماتك.</p>',
   '1) اقرأ 3 مقالات أسبوعياً.\n2) لخص كل مقال في 50 كلمة.\n3) استخرج 10 كلمات جديدة من كل مقال.',
   2),

  (lvl4_id, CONCAT('الدرس 3: الكتابة والتعبير المتقدم بـ', p_lang_name),
   'كيف تكتب مقالات ورسائل وتعبيرات راقية.',
   '<p>الكتابة المتقدمة تعتمد على:</p><ul><li>التنظيم: مقدمة - عرض - خاتمة.</li><li>التنوع في الجمل والكلمات.</li><li>الربط بين الفقرات بأدوات الربط.</li><li>الدقة الإملائية والقواعدية.</li></ul>',
   '<p>أدوات الربط: لذلك، بالإضافة إلى ذلك، على الرغم من، رغم ذلك، نتيجة لذلك، أولاً، أخيراً.</p>',
   '<p>الجمل المعقدة (subordinate clauses) ترفع مستوى كتابتك.</p>',
   '<p>اكتب رسالة رسمية وأخرى ودية وقارن بينهما في الأسلوب.</p>',
   '1) اكتب مقالاً 500 كلمة في موضوع تختاره.\n2) اكتب رسالة رسمية لشركة.\n3) اكتب قصة قصيرة (ابتكار).',
   3);

  INSERT INTO quizzes (level_id, title, pass_score) VALUES (lvl4_id, CONCAT('كويز المستوى الرابع - ', p_lang_name), 80);
  SET q4_id = LAST_INSERT_ID();

  INSERT INTO questions (quiz_id, text) VALUES
  (q4_id, 'الطلاقة تأتي من:'),
  (q4_id, 'القراءة المنتظمة تثري:'),
  (q4_id, 'هيكل المقال الجيد:'),
  (q4_id, 'عند القراءة الكلمات الجديدة:'),
  (q4_id, 'الكتابة المتقدمة تتطلب:');

  INSERT INTO options (question_id, text, is_correct) VALUES
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 0,1), 'الممارسة المستمرة', 1),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 0,1), 'حفظ القواعد فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 0,1), 'القراءة في صمت', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 0,1), 'تجنب التحدث', 0),

  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 1,1), 'المفردات والأسلوب', 1),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 1,1), 'الإملاء فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 1,1), 'الحساب', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 1,1), 'الرسم', 0),

  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 2,1), 'مقدمة - عرض - خاتمة', 1),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 2,1), 'فقرة واحدة طويلة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 2,1), 'بدون مقدمة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 2,1), 'بدون نهاية', 0),

  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 3,1), 'حاول استنباط المعنى من السياق', 1),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 3,1), 'توقف عند كل كلمة', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 3,1), 'تجاهلها كلها', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 3,1), 'لا تكمل القراءة', 0),

  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 4,1), 'تنظيم وتنوع وأدوات ربط', 1),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 4,1), 'جمل قصيرة فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 4,1), 'كلمات بسيطة فقط', 0),
  ((SELECT id FROM questions WHERE quiz_id=q4_id ORDER BY id LIMIT 4,1), 'بدون قواعد', 0);

END$$

DELIMITER ;

-- ===== استدعاء الإجراء لكل لغة =====

-- الفرنسية (id=2)
CALL seed_language_content(2, 'الفرنسية',
  '<p>Bonjour (بونجور) = صباح الخير<br>Salut (سالو) = أهلاً<br>Bonsoir (بونسوار) = مساء الخير<br>Au revoir (أو روفوار) = إلى اللقاء</p>',
  '<p>Merci (ميرسي) = شكراً<br>S''il vous plaît (سيل فو بليه) = من فضلك<br>Pardon (باردون) = آسف</p>',
  '<p>Oui (وي) = نعم<br>Non (نون) = لا<br>D''accord (داكور) = موافق</p>',
  '<p>1 un, 2 deux, 3 trois, 4 quatre, 5 cinq, 6 six, 7 sept, 8 huit, 9 neuf, 10 dix, 20 vingt, 30 trente, 100 cent.</p>',
  '<p>Je (أنا), Tu (أنت), Il (هو), Elle (هي), Nous (نحن), Vous (أنتم), Ils/Elles (هم).</p>',
  '<p>Être (يكون): Je suis, Tu es, Il est, Nous sommes, Vous êtes, Ils sont.<br>Avoir (يملك): J''ai, Tu as, Il a, Nous avons, Vous avez, Ils ont.</p>',
  '<p>الفرنسية لها أجناس (مذكر/مؤنث) والأسماء تتغير حسب الجنس. الصفة تتطابق مع الاسم في الجنس والعدد.</p>',
  '<p>A: Bonjour! Comment ça va?<br>B: Bien, merci. Et vous?<br>A: Très bien. Comment vous appelez-vous?<br>B: Je m''appelle Sara.</p>',
  '<p>الجمل المركبة، الزمن الماضي passé composé، المستقبل futur, الشرط conditionnel, المبني للمجهول passif.</p>'
);

-- الألمانية (id=3)
CALL seed_language_content(3, 'الألمانية',
  '<p>Guten Morgen (جوتن مورجن) = صباح الخير<br>Hallo (هالو) = مرحباً<br>Guten Tag (جوتن تاج) = طاب يومك<br>Auf Wiedersehen = إلى اللقاء</p>',
  '<p>Danke (دانكه) = شكراً<br>Bitte (بيته) = من فضلك/عفواً<br>Entschuldigung = آسف</p>',
  '<p>Ja (يا) = نعم<br>Nein (ناين) = لا<br>Vielleicht = ربما</p>',
  '<p>1 eins, 2 zwei, 3 drei, 4 vier, 5 fünf, 6 sechs, 7 sieben, 8 acht, 9 neun, 10 zehn, 20 zwanzig, 100 hundert.</p>',
  '<p>Ich (أنا), Du (أنت), Er (هو), Sie (هي), Wir (نحن), Ihr (أنتم), Sie (هم).</p>',
  '<p>Sein (يكون): Ich bin, Du bist, Er ist, Wir sind, Ihr seid, Sie sind.<br>Haben (يملك): Ich habe, Du hast, Er hat, Wir haben.</p>',
  '<p>الألمانية لها 3 أجناس (مذكر der، مؤنث die، محايد das) و4 حالات إعرابية (Nominativ, Akkusativ, Dativ, Genitiv).</p>',
  '<p>A: Guten Tag! Wie heißen Sie?<br>B: Ich heiße Ahmed. Und Sie?<br>A: Mein Name ist Maria. Wie geht es Ihnen?<br>B: Sehr gut, danke!</p>',
  '<p>الحالات الإعرابية المتقدمة، الفعل المنفصل (trennbare Verben)، المبني للمجهول، الجمل الشرطية، Konjunktiv.</p>'
);

-- اليابانية (id=4)
CALL seed_language_content(4, 'اليابانية',
  '<p>こんにちは Konnichiwa (كونيتشيوا) = مرحباً (نهاراً)<br>おはよう Ohayou (أوهايو) = صباح الخير<br>こんばんは Konbanwa = مساء الخير<br>さようなら Sayounara = وداعاً</p>',
  '<p>ありがとう Arigatou = شكراً<br>すみません Sumimasen = آسف/عفواً<br>お願いします Onegaishimasu = من فضلك</p>',
  '<p>はい Hai = نعم<br>いいえ Iie = لا</p>',
  '<p>1 ichi, 2 ni, 3 san, 4 yon, 5 go, 6 roku, 7 nana, 8 hachi, 9 kyuu, 10 juu, 100 hyaku.</p>',
  '<p>私 watashi (أنا), あなた anata (أنت), 彼 kare (هو), 彼女 kanojo (هي), 私たち watashitachi (نحن).</p>',
  '<p>です desu (يكون - مهذب). الفعل يأتي في نهاية الجملة. مثال: 私は学生です = أنا طالب.</p>',
  '<p>اليابانية تكتب بثلاث أنظمة: هيراجانا (للكلمات اليابانية)، كاتاكانا (للكلمات الأجنبية)، كانجي (الحروف الصينية).</p>',
  '<p>A: こんにちは!お名前は?<br>B: 私はアハメドです。<br>A: はじめまして!<br>B: よろしくお願いします。</p>',
  '<p>مستويات الأدب (敬語 Keigo)، الكانجي المتقدمة، أنماط الجمل المعقدة، الجسيمات (particles) الدقيقة.</p>'
);

-- الكورية (id=5)
CALL seed_language_content(5, 'الكورية',
  '<p>안녕하세요 Annyeonghaseyo (أنيونغ هاسيو) = مرحباً<br>안녕히 가세요 = وداعاً<br>좋은 아침 = صباح الخير</p>',
  '<p>감사합니다 Gamsahamnida = شكراً<br>죄송합니다 Joesonghamnida = آسف<br>주세요 Juseyo = من فضلك</p>',
  '<p>네 Ne = نعم<br>아니요 Aniyo = لا</p>',
  '<p>1 hana/il, 2 dul/i, 3 set/sam, 4 net/sa, 5 daseot/o, 10 yeol/sip, 100 baek.</p>',
  '<p>저 Jeo (أنا - مهذب), 너 Neo (أنت), 그 Geu (هو), 그녀 Geunyeo (هي), 우리 Uri (نحن).</p>',
  '<p>이다 ida (يكون). الفعل في نهاية الجملة. الأفعال تتغير حسب مستوى الأدب.</p>',
  '<p>الأبجدية الكورية (هانغول) منطقية وسهلة التعلم. تتكون من 14 حرفاً ساكناً و10 حروف متحركة.</p>',
  '<p>A: 안녕하세요! 이름이 뭐예요?<br>B: 저는 아흐메드예요.<br>A: 만나서 반가워요!</p>',
  '<p>مستويات الأدب (반말/존댓말)، الأفعال المعقدة، الجسيمات (조사)، الكتابة الأكاديمية.</p>'
);

-- الإيطالية (id=6)
CALL seed_language_content(6, 'الإيطالية',
  '<p>Ciao (تشاو) = مرحباً<br>Buongiorno = صباح الخير<br>Buonasera = مساء الخير<br>Arrivederci = إلى اللقاء</p>',
  '<p>Grazie = شكراً<br>Per favore = من فضلك<br>Scusa = آسف</p>',
  '<p>Sì = نعم<br>No = لا<br>Forse = ربما</p>',
  '<p>1 uno, 2 due, 3 tre, 4 quattro, 5 cinque, 10 dieci, 20 venti, 100 cento.</p>',
  '<p>Io (أنا), Tu (أنت), Lui (هو), Lei (هي), Noi (نحن), Voi (أنتم), Loro (هم).</p>',
  '<p>Essere (يكون): Io sono, Tu sei, Lui è, Noi siamo, Voi siete, Loro sono.<br>Avere (يملك): Io ho, Tu hai, Lui ha.</p>',
  '<p>الإيطالية لها مذكر ومؤنث. الأسماء المنتهية بـ o مذكر، بـ a مؤنث، بـ e قد تكون أي منهما.</p>',
  '<p>A: Ciao! Come ti chiami?<br>B: Mi chiamo Ahmed.<br>A: Piacere di conoscerti!<br>B: Piacere mio.</p>',
  '<p>الزمن الماضي passato prossimo, ماضي ناقص imperfetto, الشرطي condizionale, المضارع المركب congiuntivo.</p>'
);

-- البرتغالية (id=7)
CALL seed_language_content(7, 'البرتغالية',
  '<p>Olá (أولا) = مرحباً<br>Bom dia = صباح الخير<br>Boa tarde = مساء الخير<br>Tchau = وداع</p>',
  '<p>Obrigado/a = شكراً<br>Por favor = من فضلك<br>Desculpe = آسف</p>',
  '<p>Sim = نعم<br>Não = لا<br>Talvez = ربما</p>',
  '<p>1 um, 2 dois, 3 três, 4 quatro, 5 cinco, 10 dez, 20 vinte, 100 cem.</p>',
  '<p>Eu (أنا), Tu/Você (أنت), Ele (هو), Ela (هي), Nós (نحن), Vocês (أنتم), Eles/Elas (هم).</p>',
  '<p>Ser (يكون - دائم): Eu sou, Tu és, Ele é. Estar (يكون - مؤقت): Eu estou, Tu estás.<br>Ter (يملك): Eu tenho.</p>',
  '<p>هناك فرق بين برتغالية البرتغال وبرتغالية البرازيل في النطق وبعض الكلمات.</p>',
  '<p>A: Olá! Como você se chama?<br>B: Eu me chamo Ahmed.<br>A: Prazer em conhecê-lo!<br>B: Igualmente.</p>',
  '<p>الأزمنة المركبة، subjuntivo, infinitivo pessoal الفعل الذاتي الشخصي وهو فريد للبرتغالية.</p>'
);

-- الروسية (id=8)
CALL seed_language_content(8, 'الروسية',
  '<p>Здравствуйте Zdravstvuyte = مرحباً (رسمي)<br>Привет Privet = أهلاً<br>Доброе утро = صباح الخير<br>До свидания = إلى اللقاء</p>',
  '<p>Спасибо Spasibo = شكراً<br>Пожалуйста = من فضلك/عفواً<br>Извините = آسف</p>',
  '<p>Да Da = نعم<br>Нет Nyet = لا</p>',
  '<p>1 один odin, 2 два dva, 3 три tri, 4 четыре chetyre, 5 пять pyat, 10 десять, 100 сто.</p>',
  '<p>Я Ya (أنا), Ты Ty (أنت), Он On (هو), Она Ona (هي), Мы My (نحن), Вы Vy (أنتم), Они Oni (هم).</p>',
  '<p>الفعل быть (يكون) لا يستخدم في المضارع: Я студент = أنا طالب (بدون فعل).</p>',
  '<p>الروسية لها 6 حالات إعرابية وثلاثة أجناس (مذكر، مؤنث، محايد). الحروف 33 (السيريلية).</p>',
  '<p>A: Здравствуйте! Как вас зовут?<br>B: Меня зовут Ахмед.<br>A: Очень приятно!<br>B: Взаимно.</p>',
  '<p>الحالات الإعرابية الست (падежи)، أوجه الفعل (вид) المثالي/غير المثالي، أفعال الحركة المعقدة.</p>'
);

-- البولندية (id=9)
CALL seed_language_content(9, 'البولندية',
  '<p>Cześć (تشيشتش) = أهلاً<br>Dzień dobry = صباح الخير<br>Dobry wieczór = مساء الخير<br>Do widzenia = إلى اللقاء</p>',
  '<p>Dziękuję = شكراً<br>Proszę = من فضلك<br>Przepraszam = آسف</p>',
  '<p>Tak = نعم<br>Nie = لا<br>Może = ربما</p>',
  '<p>1 jeden, 2 dwa, 3 trzy, 4 cztery, 5 pięć, 10 dziesięć, 100 sto.</p>',
  '<p>Ja (أنا), Ty (أنت), On (هو), Ona (هي), My (نحن), Wy (أنتم), Oni/One (هم).</p>',
  '<p>Być (يكون): Ja jestem, Ty jesteś, On jest, My jesteśmy, Wy jesteście, Oni są.</p>',
  '<p>البولندية لغة سلافية صعبة لها 7 حالات إعرابية و3 أجناس. الأبجدية لاتينية مع حروف خاصة (ą, ć, ę, ł, ń, ó, ś, ź, ż).</p>',
  '<p>A: Cześć! Jak się nazywasz?<br>B: Nazywam się Ahmed.<br>A: Miło mi cię poznać!<br>B: Mnie również.</p>',
  '<p>الحالات الإعرابية، الأوجه الفعلية، تصريف الأسماء والصفات، الجمل المركبة.</p>'
);

-- التشيكية (id=10)
CALL seed_language_content(10, 'التشيكية',
  '<p>Ahoj (أهوي) = أهلاً<br>Dobré ráno = صباح الخير<br>Dobrý den = طاب يومك<br>Na shledanou = إلى اللقاء</p>',
  '<p>Děkuji = شكراً<br>Prosím = من فضلك<br>Promiňte = آسف</p>',
  '<p>Ano = نعم<br>Ne = لا<br>Možná = ربما</p>',
  '<p>1 jeden, 2 dva, 3 tři, 4 čtyři, 5 pět, 10 deset, 100 sto.</p>',
  '<p>Já (أنا), Ty (أنت), On (هو), Ona (هي), My (نحن), Vy (أنتم), Oni (هم).</p>',
  '<p>Být (يكون): Já jsem, Ty jsi, On je, My jsme, Vy jste, Oni jsou.</p>',
  '<p>التشيكية لها 7 حالات إعرابية و3 أجناس. مشابهة للبولندية والسلوفاكية. الحروف بها علامات مميزة (ě, š, č, ř, ž).</p>',
  '<p>A: Ahoj! Jak se jmenuješ?<br>B: Jmenuji se Ahmed.<br>A: Těší mě!<br>B: Mě taky.</p>',
  '<p>الحالات الإعرابية الست، الأوجه الفعلية، التراكيب المعقدة، الأدب الكلاسيكي.</p>'
);

-- العربية (id=11) - للناطقين بلغات أخرى يتعلمون العربية
CALL seed_language_content(11, 'العربية',
  '<p>السلام عليكم As-salamu alaykum = السلام عليكم<br>أهلاً Ahlan = أهلاً<br>صباح الخير Sabah al-khair<br>مع السلامة Maa as-salama = وداعاً</p>',
  '<p>شكراً Shukran = شكراً<br>من فضلك Min fadlak = من فضلك<br>آسف Aasif = آسف</p>',
  '<p>نعم Naam = نعم<br>لا La = لا<br>ربما Rubama = ربما</p>',
  '<p>1 واحد wahid, 2 اثنان ithnan, 3 ثلاثة thalatha, 4 أربعة arbaa, 5 خمسة khamsa, 10 عشرة ashara, 100 مئة miah.</p>',
  '<p>أنا Ana (I), أنت Anta/Anti (You), هو Huwa (He), هي Hiya (She), نحن Nahnu (We), أنتم Antum (You pl), هم Hum (They).</p>',
  '<p>الفعل في العربية يتصرف حسب الفاعل: أنا أكتب، أنت تكتب، هو يكتب. ولا حاجة لفعل "يكون" في المضارع.</p>',
  '<p>العربية لغة سامية تكتب من اليمين لليسار. الأبجدية 28 حرفاً. اللغة تتميز بنظام الجذور الثلاثية.</p>',
  '<p>A: السلام عليكم! ما اسمك؟<br>B: اسمي محمد.<br>A: تشرفت بمقابلتك!<br>B: وأنا أيضاً.</p>',
  '<p>الإعراب، الجموع المختلفة، الأزمنة، البلاغة، الفصحى مقابل العامية، النصوص الكلاسيكية.</p>'
);

-- حذف الإجراء بعد استخدامه
DROP PROCEDURE IF EXISTS seed_language_content;

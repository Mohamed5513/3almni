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

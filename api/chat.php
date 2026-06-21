<?php
/**
 * Chat Bot API - يعمل بدون أي API خارجي
 * يحتوي على قاعدة بيانات ذكية للردود التعليمية
 */
header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/../config/config.php';

if (!isLoggedIn()) {
    echo json_encode(['reply' => 'الرجاء تسجيل الدخول أولاً.']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
$message = trim($input['message'] ?? '');
if (empty($message)) {
    echo json_encode(['reply' => 'يرجى إرسال سؤال أو استفسار.']);
    exit;
}

$msg = mb_strtolower($message);

// محرك الردود الذكي
function getBotReply($msg) {
    // ترحيب
    if (preg_match('/(مرحبا|اهلا|أهلا|سلام|hi|hello)/iu', $msg)) {
        return "أهلاً وسهلاً 👋 أنا مساعد علمني. خبرني بأي لغة تتعلم وأي مستوى، وكيف أقدر أساعدك؟";
    }

    // المضارع البسيط
    if (preg_match('/(مضارع بسيط|present simple)/iu', $msg)) {
        return "📚 المضارع البسيط (Present Simple):\n• يستخدم للعادات والحقائق العامة.\n• التركيب: I/You/We/They + V1, He/She/It + V1+s\n• مثال: I work every day. She works in a hospital.\n• كلمات دالة: always, usually, every day, sometimes.";
    }

    // المستقبل
    if (preg_match('/(will|going to|مستقبل|future)/iu', $msg)) {
        return "📖 المستقبل في الإنجليزية:\n• will: للقرارات المفاجئة والوعود → I will help you.\n• be going to: للنوايا والخطط → I am going to study.\n• Present Continuous: للمواعيد المؤكدة → I am meeting John tomorrow.\nالفرق الرئيسي: will = قرار لحظي، going to = خطة مسبقة.";
    }

    // المبني للمجهول
    if (preg_match('/(مجهول|passive)/iu', $msg)) {
        return "📘 المبني للمجهول (Passive Voice):\n• التركيب: be + V3 (التصريف الثالث)\n• Active: They built the house.\n• Passive: The house was built.\nيستخدم عندما يكون الفاعل غير معروف أو غير مهم.";
    }

    // الشرطية
    if (preg_match('/(شرطية|conditional|if)/iu', $msg)) {
        return "🎯 الجمل الشرطية:\nالنوع 0 (حقيقة): If + present, present.\nالنوع 1 (ممكن): If + present, will + V1.\nالنوع 2 (افتراضي): If + past, would + V1.\nالنوع 3 (مستحيل): If + past perfect, would have + V3.";
    }

    // ترجمة
    if (preg_match('/(ترجم|ترجمة|translate)/iu', $msg)) {
        $arabicWords = [
            'السلام عليكم' => 'Peace be upon you (English) / Bonjour (French) / こんにちは (Japanese)',
            'شكرا' => 'Thank you (EN) / Merci (FR) / Danke (DE) / ありがとう (JA) / Gracias (ES)',
            'صباح الخير' => 'Good morning (EN) / Bonjour (FR) / Guten Morgen (DE) / おはよう (JA)',
            'كيف حالك' => 'How are you? (EN) / Comment ça va? (FR) / Wie geht es dir? (DE)',
            'مع السلامة' => 'Goodbye (EN) / Au revoir (FR) / Auf Wiedersehen (DE) / さようなら (JA)',
        ];
        foreach ($arabicWords as $ar => $tr) {
            if (mb_stripos($msg, $ar) !== false) return "🌐 ترجمة \"$ar\":\n$tr";
        }
        return "💡 يمكنك أن تكتب لي مثلاً: \"ترجم: شكراً\" أو \"ترجم: مرحباً\" وسأعطيك الترجمة بعدة لغات.";
    }

    // المفردات/الحفظ
    if (preg_match('/(احفظ|مفردات|كلمات|vocab)/iu', $msg)) {
        return "💪 نصائح لحفظ المفردات:\n1) استخدم بطاقات Flashcards (تطبيقات: Anki, Quizlet).\n2) تعلم 10-20 كلمة يومياً وراجعها بعد 24 ساعة، ثم 3 أيام، ثم أسبوع.\n3) اربط كل كلمة بصورة أو موقف.\n4) استخدم الكلمة في جملة من تأليفك.\n5) تعلم الكلمات في سياقها (من نص أو حوار) لا منفصلة.";
    }

    // النصائح العامة
    if (preg_match('/(نصيحة|نصائح|كيف اتعلم|أتعلم|advice|tips)/iu', $msg)) {
        return "🎯 أهم 7 نصائح لتعلم لغة جديدة:\n1) ادرس يومياً ولو 20 دقيقة (الانتظام أهم من المدة).\n2) ركز على الاستماع والكلام أولاً.\n3) لا تخف من الخطأ.\n4) شاهد أفلاماً ومسلسلات بالترجمة ثم بدونها.\n5) تعلم العبارات الجاهزة لا الكلمات منفصلة.\n6) تحدث مع نفسك بصوت عالٍ.\n7) ابحث عن شريك للمحادثة (Tandem أو HelloTalk).";
    }

    // النطق
    if (preg_match('/(نطق|pronunciation)/iu', $msg)) {
        return "🗣️ تحسين النطق:\n• استمع لمتحدثين أصليين (بودكاست، يوتيوب).\n• كرر بصوت عالٍ بعدهم (Shadowing).\n• سجل صوتك واستمع للأخطاء.\n• استخدم Forvo أو Google Translate للنطق.\n• ركز على الأصوات الصعبة في لغتك.";
    }

    // كويز
    if (preg_match('/(كويز|اختبار|quiz|test)/iu', $msg)) {
        return "📝 نصائح لاجتياز الكويز:\n1) راجع كل دروس المستوى قبل الكويز.\n2) اقرأ السؤال بتمعن.\n3) استبعد الإجابات الخاطئة أولاً.\n4) إذا فشلت، حلل أين أخطأت قبل الإعادة.\n5) لتجاوز 80% تحتاج فهم القواعد لا الحفظ فقط.";
    }

    // الفرنسية
    if (preg_match('/(فرنسية|french|français)/iu', $msg)) {
        return "🇫🇷 الفرنسية: لغة جميلة مع تحديات النطق والأجناس.\n• تذكر: كل اسم مذكر أو مؤنث.\n• الصفة تتطابق مع الاسم في الجنس والعدد.\n• تدرب على الـ liaison (وصل الكلمات).\n• ابدأ بالأفعال être و avoir.";
    }

    // الألمانية
    if (preg_match('/(ألمانية|german|deutsch)/iu', $msg)) {
        return "🇩🇪 الألمانية: لغة منطقية لكنها تحتاج صبراً.\n• لها 3 أجناس: der (مذكر), die (مؤنث), das (محايد).\n• 4 حالات إعرابية: Nominativ, Akkusativ, Dativ, Genitiv.\n• الفعل في المركز الثاني دائماً في الجملة العادية.\n• ركز على Modal Verbs أولاً.";
    }

    // اليابانية
    if (preg_match('/(يابانية|japanese|日本)/iu', $msg)) {
        return "🇯🇵 اليابانية: تكتب بثلاث أنظمة:\n• هيراجانا: للكلمات اليابانية.\n• كاتاكانا: للكلمات الأجنبية.\n• كانجي: حروف صينية للمعاني.\n• ابدأ بالهيراجانا (46 حرف) ثم الكاتاكانا.\n• الفعل في نهاية الجملة دائماً.";
    }

    // إجابة افتراضية
    return "🤔 سؤال جيد! يمكنني مساعدتك في:\n• شرح القواعد (المضارع، الماضي، المستقبل، الشرطية...).\n• نصائح لحفظ المفردات وتحسين النطق.\n• ترجمة عبارات شائعة.\n• إجابة أسئلة عامة عن أي لغة من لغات منصة علمني.\n\nاسألني سؤالاً محدداً مثل: \"اشرح المضارع البسيط\" أو \"كيف أحفظ الكلمات؟\".";
}

$reply = getBotReply($message);

// حفظ في قاعدة البيانات
try {
    $stmt = db()->prepare("INSERT INTO chat_logs (user_id, message, reply) VALUES (?, ?, ?)");
    $stmt->execute([$_SESSION['user_id'], $message, $reply]);
} catch (Exception $e) {}

echo json_encode(['reply' => $reply], JSON_UNESCAPED_UNICODE);

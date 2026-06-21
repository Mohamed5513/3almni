<?php
require_once __DIR__ . '/config/config.php';
requireLogin();

$id = (int)($_GET['id'] ?? 0);
$stmt = db()->prepare("
    SELECT q.*, lv.title AS level_title, lv.id AS level_id, lv.language_id, lv.level_number
    FROM quizzes q
    JOIN levels lv ON lv.id = q.level_id
    WHERE q.id = ?
");
$stmt->execute([$id]);
$quiz = $stmt->fetch();
if (!$quiz) redirect('languages.php');

$userId = $_SESSION['user_id'];
if (!canAccessLevel($userId, $quiz['language_id'], $quiz['level_number'])) {
    flash('error', 'لا يمكنك دخول هذا الكويز.');
    redirect('language.php?id=' . $quiz['language_id']);
}

$pageTitle = $quiz['title'];

// تحميل الأسئلة
$stmt = db()->prepare("SELECT * FROM questions WHERE quiz_id = ? ORDER BY id");
$stmt->execute([$id]);
$questions = $stmt->fetchAll();

foreach ($questions as &$q) {
    $stmt = db()->prepare("SELECT * FROM options WHERE question_id = ? ORDER BY id");
    $stmt->execute([$q['id']]);
    $q['options'] = $stmt->fetchAll();
}
unset($q);

// تقييم الإجابات
$result = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && verifyCsrf($_POST['csrf_token'] ?? '')) {
    $answers = $_POST['answers'] ?? [];
    $correct = 0;
    foreach ($questions as $q) {
        $correctOption = null;
        foreach ($q['options'] as $opt) {
            if ($opt['is_correct']) { $correctOption = $opt['id']; break; }
        }
        if (isset($answers[$q['id']]) && (int)$answers[$q['id']] === (int)$correctOption) {
            $correct++;
        }
    }
    $score = count($questions) > 0 ? round(($correct / count($questions)) * 100) : 0;
    $passed = $score >= $quiz['pass_score'] ? 1 : 0;

    $stmt = db()->prepare("INSERT INTO quiz_results (user_id, quiz_id, score, passed) VALUES (?, ?, ?, ?)");
    $stmt->execute([$userId, $id, $score, $passed]);

    $result = ['score' => $score, 'passed' => $passed, 'correct' => $correct, 'total' => count($questions)];
}

require_once __DIR__ . '/includes/header.php';
?>

<section style="padding-top: 30px;">
  <div class="container">
    <?php if ($result !== null): ?>
      <div class="result-card <?= $result['passed'] ? 'passed' : 'failed' ?>">
        <h2><?= $result['passed'] ? '🎉 مبروك! اجتزت الاختبار' : '😔 لم تجتز هذه المرة' ?></h2>
        <div class="score-circle"><?= $result['score'] ?>%</div>
        <p style="font-size:18px; margin-bottom:8px;">
          <?= $result['correct'] ?> / <?= $result['total'] ?> إجابة صحيحة
        </p>
        <p style="color:var(--text-light); margin-bottom:24px;">
          <?php if ($result['passed']): ?>
            ممتاز! يمكنك الآن الانتقال للمستوى التالي.
          <?php else: ?>
            تحتاج <?= $quiz['pass_score'] ?>% على الأقل للنجاح. راجع الدروس وحاول مجدداً.
          <?php endif; ?>
        </p>
        <div style="display:flex; gap:10px; justify-content:center; flex-wrap:wrap;">
          <a href="<?= SITE_URL ?>/language.php?id=<?= $quiz['language_id'] ?>" class="btn btn-gradient">
            <?= $result['passed'] ? 'المستوى التالي' : 'العودة للمستويات' ?>
          </a>
          <?php if (!$result['passed']): ?>
            <a href="<?= SITE_URL ?>/level.php?id=<?= $quiz['level_id'] ?>" class="btn btn-outline">مراجعة الدروس</a>
            <a href="<?= SITE_URL ?>/quiz.php?id=<?= $id ?>" class="btn btn-outline">إعادة الاختبار</a>
          <?php endif; ?>
        </div>
      </div>
    <?php else: ?>
      <div class="quiz-container">
        <h1 style="margin-bottom:8px;"><?= clean($quiz['title']) ?></h1>
        <p style="color:var(--text-light); margin-bottom:24px;">
          عدد الأسئلة: <?= count($questions) ?> | للنجاح: <?= $quiz['pass_score'] ?>% فأكثر
        </p>
        <div class="quiz-progress"><div class="quiz-progress-fill" id="qpf" style="width:0%"></div></div>

        <form method="POST" id="quizForm">
          <input type="hidden" name="csrf_token" value="<?= csrfToken() ?>">
          <?php foreach ($questions as $i => $q): ?>
            <div class="question">
              <h3><?= ($i+1) ?>. <?= clean($q['text']) ?></h3>
              <div class="options">
                <?php foreach ($q['options'] as $opt): ?>
                  <label class="option-label">
                    <input type="radio" name="answers[<?= $q['id'] ?>]" value="<?= $opt['id'] ?>" required>
                    <span><?= clean($opt['text']) ?></span>
                  </label>
                <?php endforeach; ?>
              </div>
            </div>
          <?php endforeach; ?>
          <button type="submit" class="btn btn-block btn-gradient">إنهاء الاختبار</button>
        </form>
      </div>
    <?php endif; ?>
  </div>
</section>

<?php require_once __DIR__ . '/includes/footer.php'; ?>

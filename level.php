<?php
require_once __DIR__ . '/config/config.php';
requireLogin();

$id = (int)($_GET['id'] ?? 0);
$stmt = db()->prepare("
    SELECT lv.*, lg.name_ar AS lang_name, lg.id AS lang_id, lg.flag
    FROM levels lv JOIN languages lg ON lg.id = lv.language_id
    WHERE lv.id = ?
");
$stmt->execute([$id]);
$level = $stmt->fetch();
if (!$level) redirect('languages.php');

$userId = $_SESSION['user_id'];
if (!canAccessLevel($userId, $level['lang_id'], $level['level_number'])) {
    flash('error', 'يجب اجتياز المستوى السابق بنسبة 80% على الأقل.');
    redirect('language.php?id=' . $level['lang_id']);
}

$pageTitle = $level['title'];

$stmt = db()->prepare("SELECT * FROM lessons WHERE level_id = ? ORDER BY order_num ASC");
$stmt->execute([$id]);
$lessons = $stmt->fetchAll();

// ========== كود التصحيح ==========
// شوف النتيجة دي هتظهرلك في أعلى الصفحة
echo "<div style='background: #ffeb3b; padding: 15px; margin: 10px; border-radius: 8px; direction: ltr; text-align: left; font-family: monospace;'>";
echo "<strong>🔍 DEBUG INFO:</strong><br>";
echo "Level ID: " . $id . "<br>";
echo "Nombre de leçons: " . count($lessons) . "<br>";
if(count($lessons) > 0) {
    echo "<strong>Leçons trouvées:</strong><br>";
    foreach($lessons as $l) {
        echo "- ID: " . $l['id'] . " | Titre: " . $l['title'] . "<br>";
    }
} else {
    echo "<span style='color:red'>⚠️ Aucune leçon trouvée pour ce level_id!</span><br>";
}
echo "</div>";
// ==================================

$stmt = db()->prepare("SELECT * FROM quizzes WHERE level_id = ? LIMIT 1");
$stmt->execute([$id]);
$quiz = $stmt->fetch();

require_once __DIR__ . '/includes/header.php';
?>

<section style="padding-top: 40px;">
  <div class="container">
    <a href="<?= SITE_URL ?>/language.php?id=<?= $level['lang_id'] ?>" style="color:var(--text-light); display:inline-block; margin-bottom:14px;">← العودة إلى <?= clean($level['lang_name']) ?></a>

    <div style="background:var(--gradient); color:white; padding:32px; border-radius:16px; margin-bottom:30px;">
      <div style="font-size:50px;"><?= $level['flag'] ?></div>
      <h1 style="font-size:32px; margin:8px 0;"><?= clean($level['title']) ?></h1>
      <p style="opacity:0.95;"><?= clean($level['description']) ?></p>
    </div>

    <h2 style="margin: 20px 0;">📚 الدروس (<?= count($lessons) ?>)</h2>
    <div class="levels-list">
      <?php if (count($lessons) > 0): ?>
        <?php foreach ($lessons as $lesson): ?>
          <div class="level-card">
            <div class="level-info">
              <h3>📖 <?= clean($lesson['title']) ?></h3>
              <p><?= clean($lesson['intro']) ?></p>
            </div>
            <a href="<?= SITE_URL ?>/lesson.php?id=<?= $lesson['id'] ?>" class="btn btn-sm">دخول الدرس</a>
          </div>
        <?php endforeach; ?>
      <?php else: ?>
        <div style="background: #fff3cd; padding: 20px; border-radius: 10px; text-align: center;">
          <p>⚠️ لا توجد دروس في هذا المستوى حالياً.</p>
          <p>Level ID: <?= $id ?></p>
        </div>
      <?php endif; ?>
    </div>

    <?php if ($quiz): ?>
      <h2 style="margin: 30px 0 16px;">📝 الاختبار النهائي</h2>
      <div class="level-card" style="border-right-color: var(--warning);">
        <div class="level-info">
          <h3>📝 <?= clean($quiz['title']) ?></h3>
          <p>يجب تحقيق <?= $quiz['pass_score'] ?>% على الأقل لاجتياز المستوى والانتقال للتالي.</p>
        </div>
        <a href="<?= SITE_URL ?>/quiz.php?id=<?= $quiz['id'] ?>" class="btn btn-success btn-sm">ابدأ الاختبار</a>
      </div>
    <?php endif; ?>
  </div>
</section>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
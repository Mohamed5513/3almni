<?php
require_once __DIR__ . '/config/config.php';
requireLogin();

$id = (int)($_GET['id'] ?? 0);
$stmt = db()->prepare("
    SELECT le.*, lv.id AS level_id, lv.title AS level_title, lv.language_id, lg.name_ar AS lang_name
    FROM lessons le
    JOIN levels lv ON lv.id = le.level_id
    JOIN languages lg ON lg.id = lv.language_id
    WHERE le.id = ?
");
$stmt->execute([$id]);
$lesson = $stmt->fetch();
if (!$lesson) redirect('languages.php');

$userId = $_SESSION['user_id'];
if (!canAccessLevel($userId, $lesson['language_id'], (int)db()->query("SELECT level_number FROM levels WHERE id={$lesson['level_id']}")->fetchColumn())) {
    flash('error', 'هذا الدرس مقفل.');
    redirect('language.php?id=' . $lesson['language_id']);
}

// تسجيل التقدم
$stmt = db()->prepare("INSERT IGNORE INTO user_progress (user_id, lesson_id, completed, completed_at) VALUES (?, ?, 1, NOW())");
$stmt->execute([$userId, $id]);

// الدروس السابقة والتالية
$stmt = db()->prepare("SELECT id, title FROM lessons WHERE level_id = ? AND order_num < ? ORDER BY order_num DESC LIMIT 1");
$stmt->execute([$lesson['level_id'], $lesson['order_num']]);
$prev = $stmt->fetch();

$stmt = db()->prepare("SELECT id, title FROM lessons WHERE level_id = ? AND order_num > ? ORDER BY order_num ASC LIMIT 1");
$stmt->execute([$lesson['level_id'], $lesson['order_num']]);
$next = $stmt->fetch();

$pageTitle = $lesson['title'];
require_once __DIR__ . '/includes/header.php';
?>

<section style="padding-top: 30px;">
  <div class="container">
    <a href="<?= SITE_URL ?>/level.php?id=<?= $lesson['level_id'] ?>" style="color:var(--text-light); display:inline-block; margin-bottom:14px;">← العودة لـ <?= clean($lesson['level_title']) ?></a>

    <div class="lesson-container">
      <h1><?= clean($lesson['title']) ?></h1>
      <div class="lesson-intro"><?= clean($lesson['intro']) ?></div>

      <div class="lesson-section">
        <h2>الشرح</h2>
        <div><?= $lesson['content'] ?></div>
      </div>

      <?php if ($lesson['vocabulary']): ?>
      <div class="lesson-section">
        <h2>📚 المفردات</h2>
        <div><?= $lesson['vocabulary'] ?></div>
      </div>
      <?php endif; ?>

      <?php if ($lesson['grammar']): ?>
      <div class="lesson-section">
        <h2>📖 القواعد</h2>
        <div><?= $lesson['grammar'] ?></div>
      </div>
      <?php endif; ?>

      <?php if ($lesson['dialogue']): ?>
      <div class="lesson-section">
        <h2>💬 المحادثة</h2>
        <div style="background:#f8fafc; padding:16px; border-radius:10px; white-space: pre-line;"><?= $lesson['dialogue'] ?></div>
      </div>
      <?php endif; ?>

      <?php if ($lesson['exercises']): ?>
      <div class="lesson-section">
        <h2>✏️ التمارين</h2>
        <div style="white-space: pre-line;"><?= $lesson['exercises'] ?></div>
      </div>
      <?php endif; ?>

      <div style="display:flex; justify-content:space-between; margin-top:30px; flex-wrap:wrap; gap:10px;">
        <?php if ($prev): ?>
          <a href="<?= SITE_URL ?>/lesson.php?id=<?= $prev['id'] ?>" class="btn btn-outline">← الدرس السابق</a>
        <?php else: ?><span></span><?php endif; ?>

        <?php if ($next): ?>
          <a href="<?= SITE_URL ?>/lesson.php?id=<?= $next['id'] ?>" class="btn">الدرس التالي →</a>
        <?php else: ?>
          <a href="<?= SITE_URL ?>/level.php?id=<?= $lesson['level_id'] ?>" class="btn btn-success">انتهى! إلى الكويز ←</a>
        <?php endif; ?>
      </div>
    </div>
  </div>
</section>

<?php require_once __DIR__ . '/includes/footer.php'; ?>

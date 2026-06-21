<?php
$pageTitle = 'لوحة التحكم';
require_once __DIR__ . '/config/config.php';
requireLogin();

$user = currentUser();
$userId = $user['id'];

// إحصائيات
$stmt = db()->prepare("SELECT COUNT(DISTINCT q.level_id) AS passed_levels
    FROM quiz_results qr JOIN quizzes q ON q.id = qr.quiz_id
    WHERE qr.user_id = ? AND qr.score >= ?");
$stmt->execute([$userId, PASS_SCORE]);
$passedLevels = $stmt->fetchColumn();

$stmt = db()->prepare("SELECT COUNT(*) FROM quiz_results WHERE user_id = ?");
$stmt->execute([$userId]);
$totalAttempts = $stmt->fetchColumn();

$stmt = db()->prepare("SELECT AVG(score) FROM quiz_results WHERE user_id = ?");
$stmt->execute([$userId]);
$avgScore = round($stmt->fetchColumn() ?: 0);

$languages = db()->query("SELECT * FROM languages ORDER BY id ASC")->fetchAll();

require_once __DIR__ . '/includes/header.php';
?>
<div class="dashboard">
  <aside class="sidebar">
    <h3>القائمة</h3>
    <a href="<?= SITE_URL ?>/dashboard.php" class="active">📊 لوحة التحكم</a>
    <a href="<?= SITE_URL ?>/languages.php">🌐 اللغات</a>
    <a href="<?= SITE_URL ?>/chat.php">🤖 المساعد الذكي</a>
    <a href="<?= SITE_URL ?>/progress.php">📈 تقدمي</a>
    <a href="<?= SITE_URL ?>/logout.php">🚪 تسجيل خروج</a>
  </aside>

  <main class="main-content">
    <div class="welcome-card">
      <h1>أهلاً، <?= clean($user['name']) ?> 👋</h1>
      <p>استمر في رحلتك التعليمية. كل يوم خطوة نحو الطلاقة.</p>
    </div>

    <?php if ($msg = flash('success')): ?>
      <div class="alert alert-success"><?= clean($msg) ?></div>
    <?php endif; ?>

    <div class="stats">
      <div class="stat-card">
        <div class="stat-label">المستويات المجتازة</div>
        <div class="stat-value"><?= $passedLevels ?></div>
      </div>
      <div class="stat-card">
        <div class="stat-label">عدد محاولات الكويز</div>
        <div class="stat-value"><?= $totalAttempts ?></div>
      </div>
      <div class="stat-card">
        <div class="stat-label">متوسط الدرجات</div>
        <div class="stat-value"><?= $avgScore ?>%</div>
      </div>
    </div>

    <h2 style="margin: 24px 0 16px;">اختر لغتك</h2>
    <div class="languages-grid">
      <?php foreach ($languages as $lang): ?>
        <a href="<?= SITE_URL ?>/language.php?id=<?= $lang['id'] ?>" class="lang-card">
          <span class="lang-flag"><?= $lang['flag'] ?></span>
          <div class="lang-name"><?= clean($lang['name_ar']) ?></div>
          <div class="lang-desc"><?= clean($lang['name_en']) ?></div>
          <?php
          $progress = getProgressForLanguage($userId, $lang['id']);
          $passed = 0;
          foreach ($progress as $p) if (($p['best_score'] ?? 0) >= PASS_SCORE) $passed++;
          ?>
          <span class="lang-levels"><?= $passed ?> / 4 مستويات</span>
        </a>
      <?php endforeach; ?>
    </div>
  </main>
</div>
<?php require_once __DIR__ . '/includes/footer.php'; ?>

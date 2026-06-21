<?php
$pageTitle = 'تقدمي';
require_once __DIR__ . '/config/config.php';
requireLogin();

$userId = $_SESSION['user_id'];
$user = currentUser();

$stmt = db()->prepare("
    SELECT qr.*, q.title AS quiz_title, lv.title AS level_title, lg.name_ar AS lang_name, lg.flag
    FROM quiz_results qr
    JOIN quizzes q ON q.id = qr.quiz_id
    JOIN levels lv ON lv.id = q.level_id
    JOIN languages lg ON lg.id = lv.language_id
    WHERE qr.user_id = ?
    ORDER BY qr.attempted_at DESC
");
$stmt->execute([$userId]);
$results = $stmt->fetchAll();

require_once __DIR__ . '/includes/header.php';
?>
<div class="dashboard">
  <aside class="sidebar">
    <h3>القائمة</h3>
    <a href="<?= SITE_URL ?>/dashboard.php">📊 لوحة التحكم</a>
    <a href="<?= SITE_URL ?>/languages.php">🌐 اللغات</a>
    <a href="<?= SITE_URL ?>/chat.php">🤖 المساعد الذكي</a>
    <a href="<?= SITE_URL ?>/progress.php" class="active">📈 تقدمي</a>
    <a href="<?= SITE_URL ?>/logout.php">🚪 تسجيل خروج</a>
  </aside>
  <main class="main-content">
    <div class="welcome-card">
      <h1>📈 تقدمك التعليمي</h1>
      <p>سجل كامل لمحاولاتك واختباراتك.</p>
    </div>

    <?php if (empty($results)): ?>
      <div class="alert alert-info">لم تحاول أي اختبار بعد. ابدأ من <a href="<?= SITE_URL ?>/languages.php">صفحة اللغات</a>.</div>
    <?php else: ?>
      <table style="width:100%; background:white; border-radius:14px; overflow:hidden; box-shadow:var(--shadow); border-collapse:collapse;">
        <thead style="background:var(--gradient); color:white;">
          <tr>
            <th style="padding:14px;">اللغة</th>
            <th style="padding:14px;">المستوى</th>
            <th style="padding:14px;">النتيجة</th>
            <th style="padding:14px;">الحالة</th>
            <th style="padding:14px;">التاريخ</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($results as $r): ?>
            <tr style="border-bottom:1px solid var(--border);">
              <td style="padding:14px;"><?= $r['flag'] ?> <?= clean($r['lang_name']) ?></td>
              <td style="padding:14px;"><?= clean($r['level_title']) ?></td>
              <td style="padding:14px; font-weight:700;"><?= $r['score'] ?>%</td>
              <td style="padding:14px;">
                <?php if ($r['passed']): ?>
                  <span class="level-status status-completed">نجح ✓</span>
                <?php else: ?>
                  <span class="level-status status-locked">رسب ✗</span>
                <?php endif; ?>
              </td>
              <td style="padding:14px; color:var(--text-light);"><?= date('Y-m-d H:i', strtotime($r['attempted_at'])) ?></td>
            </tr>
          <?php endforeach; ?>
        </tbody>
      </table>
    <?php endif; ?>
  </main>
</div>
<?php require_once __DIR__ . '/includes/footer.php'; ?>

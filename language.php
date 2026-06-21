<?php
$pageTitle = 'تفاصيل اللغة';
require_once __DIR__ . '/config/config.php';
requireLogin();

$id = (int)($_GET['id'] ?? 0);
$stmt = db()->prepare("SELECT * FROM languages WHERE id = ?");
$stmt->execute([$id]);
$lang = $stmt->fetch();
if (!$lang) redirect('languages.php');

$pageTitle = $lang['name_ar'];

$stmt = db()->prepare("SELECT * FROM levels WHERE language_id = ? ORDER BY level_number");
$stmt->execute([$id]);
$levels = $stmt->fetchAll();

$userId = $_SESSION['user_id'];

require_once __DIR__ . '/includes/header.php';
?>

<section style="padding-top: 40px;">
  <div class="container">
    <div style="text-align:center; margin-bottom: 30px;">
      <div style="font-size: 80px;"><?= $lang['flag'] ?></div>
      <h1 style="font-size: 40px; margin: 10px 0; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
        <?= clean($lang['name_ar']) ?>
      </h1>
      <p style="font-size: 17px; color: var(--text-light); max-width: 600px; margin: 0 auto;">
        <?= clean($lang['description']) ?>
      </p>
    </div>

    <h2 style="margin: 30px 0 20px;">المستويات الأربعة</h2>
    <div class="levels-list">
      <?php foreach ($levels as $level):
        $canAccess = canAccessLevel($userId, $id, $level['level_number']);
        $passed = hasPassedLevel($userId, $level['id']);
        $cls = $passed ? 'completed' : ($canAccess ? '' : 'locked');
      ?>
        <div class="level-card <?= $cls ?>">
          <div class="level-info">
            <h3>
              <?= $passed ? '✅ ' : ($canAccess ? '📖 ' : '🔒 ') ?>
              <?= clean($level['title']) ?>
            </h3>
            <p><?= clean($level['description']) ?></p>
          </div>
          <div style="display:flex; gap:10px; align-items:center;">
            <?php if ($passed): ?>
              <span class="level-status status-completed">مجتاز ✓</span>
            <?php elseif (!$canAccess): ?>
              <span class="level-status status-locked">مغلق - تحتاج 80%+ في السابق</span>
            <?php else: ?>
              <span class="level-status status-current">متاح</span>
            <?php endif; ?>

            <?php if ($canAccess): ?>
              <a href="<?= SITE_URL ?>/level.php?id=<?= $level['id'] ?>" class="btn btn-sm">
                <?= $passed ? 'مراجعة' : 'دخول' ?>
              </a>
            <?php endif; ?>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<?php require_once __DIR__ . '/includes/footer.php'; ?>

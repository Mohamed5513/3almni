<?php
$pageTitle = 'اللغات';
require_once __DIR__ . '/config/config.php';
$languages = db()->query("SELECT * FROM languages ORDER BY id ASC")->fetchAll();
require_once __DIR__ . '/includes/header.php';
?>
<section>
  <div class="container">
    <h2 class="section-title">اختر لغتك</h2>
    <p class="section-subtitle">11 لغة عالمية بانتظارك</p>
    <div class="languages-grid">
      <?php foreach ($languages as $lang): ?>
        <a href="<?= SITE_URL ?>/language.php?id=<?= $lang['id'] ?>" class="lang-card">
          <span class="lang-flag"><?= $lang['flag'] ?></span>
          <div class="lang-name"><?= clean($lang['name_ar']) ?></div>
          <div class="lang-desc"><?= clean($lang['description']) ?></div>
          <span class="lang-levels">4 مستويات</span>
        </a>
      <?php endforeach; ?>
    </div>
  </div>
</section>
<?php require_once __DIR__ . '/includes/footer.php'; ?>

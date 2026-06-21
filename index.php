<?php
$pageTitle = 'الرئيسية';
require_once __DIR__ . '/includes/header.php';

$languages = db()->query("SELECT * FROM languages ORDER BY id ASC")->fetchAll();
?>

<section class="hero">
  <div class="container">
    <h1>تعلم لغة جديدة، افتح عالماً جديداً</h1>
    <p>منصة علمني تقدم لك 11 لغة عالمية بـ 4 مستويات تدريجية، مع محتوى عميق ومساعد ذكاء اصطناعي يرافقك في رحلتك.</p>
    <?php if (isLoggedIn()): ?>
      <a href="<?= SITE_URL ?>/dashboard.php" class="btn">ابدأ التعلم الآن</a>
    <?php else: ?>
      <a href="<?= SITE_URL ?>/register.php" class="btn">سجل مجاناً وابدأ الآن</a>
    <?php endif; ?>
  </div>
</section>

<section>
  <div class="container">
    <h2 class="section-title">لماذا علمني؟</h2>
    <p class="section-subtitle">منهج تعليمي متكامل يأخذك من الصفر إلى الطلاقة</p>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon">📚</div>
        <h3>محتوى عميق</h3>
        <p>دروس مفصلة في القواعد والمفردات والمحادثات لكل لغة.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🎯</div>
        <h3>4 مستويات</h3>
        <p>من المبتدئ إلى المتقدم، تدرج علمي يضمن لك الفهم.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">📝</div>
        <h3>اختبارات صارمة</h3>
        <p>كل مستوى ينتهي بكويز، يجب تحقيق 80% للانتقال.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🤖</div>
        <h3>مساعد ذكي</h3>
        <p>AI Chat يجيب أسئلتك ويساعدك على الفهم لحظياً.</p>
      </div>
    </div>
  </div>
</section>

<section style="background: white;">
  <div class="container">
    <h2 class="section-title">11 لغة عالمية</h2>
    <p class="section-subtitle">اختر لغتك وابدأ رحلتك التعليمية</p>
    <div class="languages-grid">
      <?php foreach ($languages as $lang): ?>
        <a href="<?= SITE_URL ?>/language.php?id=<?= $lang['id'] ?>" class="lang-card">
          <span class="lang-flag"><?= $lang['flag'] ?></span>
          <div class="lang-name"><?= clean($lang['name_ar']) ?></div>
          <div class="lang-desc"><?= clean($lang['name_en']) ?></div>
          <span class="lang-levels">4 مستويات</span>
        </a>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<?php require_once __DIR__ . '/includes/footer.php'; ?>

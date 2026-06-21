<?php
$pageTitle = 'استعادة كلمة المرور';
require_once __DIR__ . '/config/config.php';
require_once __DIR__ . '/includes/header.php';
?>
<div class="auth-wrapper">
  <div class="auth-card">
    <h2>استعادة كلمة المرور</h2>
    <p class="auth-subtitle">أدخل بريدك وسنرسل لك تعليمات الاستعادة</p>
    <div class="alert alert-info">
      ميزة استعادة كلمة المرور تتطلب إعداد SMTP. حالياً، تواصل مع الإدارة لإعادة تعيين كلمة المرور.
    </div>
    <form method="POST" action="">
      <div class="form-group">
        <label>البريد الإلكتروني</label>
        <input type="email" required placeholder="example@email.com">
      </div>
      <button type="button" class="btn btn-block btn-gradient" onclick="alert('سيتم تفعيل هذه الميزة قريباً')">إرسال التعليمات</button>
    </form>
    <div class="auth-foot">
      <a href="<?= SITE_URL ?>/login.php">العودة لتسجيل الدخول</a>
    </div>
  </div>
</div>
<?php require_once __DIR__ . '/includes/footer.php'; ?>

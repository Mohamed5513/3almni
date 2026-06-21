<?php
$pageTitle = 'إنشاء حساب';
require_once __DIR__ . '/config/config.php';

if (isLoggedIn()) redirect('dashboard.php');

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $confirm = $_POST['confirm'] ?? '';
    $token = $_POST['csrf_token'] ?? '';

    if (!verifyCsrf($token)) {
        $error = 'الجلسة منتهية، حاول مرة أخرى.';
    } elseif (empty($name) || empty($email) || empty($password)) {
        $error = 'كل الحقول مطلوبة.';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = 'البريد الإلكتروني غير صحيح.';
    } elseif (strlen($password) < 6) {
        $error = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.';
    } elseif ($password !== $confirm) {
        $error = 'كلمتا المرور غير متطابقتين.';
    } else {
        $stmt = db()->prepare("SELECT id FROM users WHERE email = ?");
        $stmt->execute([$email]);
        if ($stmt->fetch()) {
            $error = 'البريد مسجل من قبل، استخدم بريداً آخر.';
        } else {
            $hash = password_hash($password, PASSWORD_BCRYPT);
            $stmt = db()->prepare("INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)");
            $stmt->execute([$name, $email, $hash]);
            $_SESSION['user_id'] = db()->lastInsertId();
            $_SESSION['user_name'] = $name;
            flash('success', 'تم إنشاء حسابك بنجاح! ابدأ التعلم الآن.');
            redirect('dashboard.php');
        }
    }
}

require_once __DIR__ . '/includes/header.php';
?>
<div class="auth-wrapper">
  <div class="auth-card">
    <h2>إنشاء حساب جديد</h2>
    <p class="auth-subtitle">انضم إلى آلاف المتعلمين في منصة علمني</p>
    <?php if ($error): ?>
      <div class="alert alert-error"><?= clean($error) ?></div>
    <?php endif; ?>
    <form method="POST" action="">
      <input type="hidden" name="csrf_token" value="<?= csrfToken() ?>">
      <div class="form-group">
        <label>الاسم</label>
        <input type="text" name="name" required placeholder="اسمك بالكامل" value="<?= clean($_POST['name'] ?? '') ?>">
      </div>
      <div class="form-group">
        <label>البريد الإلكتروني</label>
        <input type="email" name="email" required placeholder="example@email.com" value="<?= clean($_POST['email'] ?? '') ?>">
      </div>
      <div class="form-group">
        <label>كلمة المرور</label>
        <input type="password" name="password" required placeholder="6 أحرف على الأقل" minlength="6">
      </div>
      <div class="form-group">
        <label>تأكيد كلمة المرور</label>
        <input type="password" name="confirm" required placeholder="أعد إدخال كلمة المرور">
      </div>
      <button type="submit" class="btn btn-block btn-gradient">سجل الآن</button>
    </form>
    <div class="auth-foot">
      لديك حساب بالفعل؟ <a href="<?= SITE_URL ?>/login.php">تسجيل دخول</a>
    </div>
  </div>
</div>
<?php require_once __DIR__ . '/includes/footer.php'; ?>

<?php
$pageTitle = 'تسجيل الدخول';
require_once __DIR__ . '/config/config.php';

if (isLoggedIn()) redirect('dashboard.php');

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $token = $_POST['csrf_token'] ?? '';

    if (!verifyCsrf($token)) {
        $error = 'الجلسة منتهية، حاول مرة أخرى.';
    } elseif (empty($email) || empty($password)) {
        $error = 'الرجاء إدخال البريد وكلمة المرور.';
    } else {
        $stmt = db()->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->execute([$email]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password_hash'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_name'] = $user['name'];
            flash('success', 'مرحباً بعودتك، ' . $user['name']);
            redirect('dashboard.php');
        } else {
            $error = 'البريد أو كلمة المرور غير صحيحة.';
        }
    }
}

require_once __DIR__ . '/includes/header.php';
?>
<div class="auth-wrapper">
  <div class="auth-card">
    <h2>تسجيل الدخول</h2>
    <p class="auth-subtitle">مرحباً بعودتك إلى منصة علمني</p>
    <?php if ($error): ?>
      <div class="alert alert-error"><?= clean($error) ?></div>
    <?php endif; ?>
    <?php if ($msg = flash('success')): ?>
      <div class="alert alert-success"><?= clean($msg) ?></div>
    <?php endif; ?>
    <form method="POST" action="">
      <input type="hidden" name="csrf_token" value="<?= csrfToken() ?>">
      <div class="form-group">
        <label>البريد الإلكتروني</label>
        <input type="email" name="email" required placeholder="example@email.com">
      </div>
      <div class="form-group">
        <label>كلمة المرور</label>
        <input type="password" name="password" required placeholder="********">
      </div>
      <button type="submit" class="btn btn-block btn-gradient">دخول</button>
    </form>
    <div class="auth-foot">
      ليس لديك حساب؟ <a href="<?= SITE_URL ?>/register.php">سجل الآن</a>
    </div>
  </div>
</div>
<?php require_once __DIR__ . '/includes/footer.php'; ?>

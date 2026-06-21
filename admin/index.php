<?php
$pageTitle = 'لوحة الإدارة';
require_once __DIR__ . '/../config/config.php';
requireAdmin();

$stats = [
    'users' => db()->query("SELECT COUNT(*) FROM users")->fetchColumn(),
    'languages' => db()->query("SELECT COUNT(*) FROM languages")->fetchColumn(),
    'lessons' => db()->query("SELECT COUNT(*) FROM lessons")->fetchColumn(),
    'quizzes' => db()->query("SELECT COUNT(*) FROM quizzes")->fetchColumn(),
    'attempts' => db()->query("SELECT COUNT(*) FROM quiz_results")->fetchColumn(),
];

$recentUsers = db()->query("SELECT * FROM users ORDER BY created_at DESC LIMIT 10")->fetchAll();

require_once __DIR__ . '/../includes/header.php';
?>

<section style="padding-top:30px;">
  <div class="container">
    <h1 style="margin-bottom:20px;">⚙️ لوحة الإدارة</h1>

    <div class="stats">
      <div class="stat-card"><div class="stat-label">عدد المستخدمين</div><div class="stat-value"><?= $stats['users'] ?></div></div>
      <div class="stat-card"><div class="stat-label">عدد اللغات</div><div class="stat-value"><?= $stats['languages'] ?></div></div>
      <div class="stat-card"><div class="stat-label">عدد الدروس</div><div class="stat-value"><?= $stats['lessons'] ?></div></div>
      <div class="stat-card"><div class="stat-label">عدد الكويزات</div><div class="stat-value"><?= $stats['quizzes'] ?></div></div>
      <div class="stat-card"><div class="stat-label">محاولات الاختبار</div><div class="stat-value"><?= $stats['attempts'] ?></div></div>
    </div>

    <h2 style="margin:30px 0 16px;">آخر المستخدمين</h2>
    <table style="width:100%; background:white; border-radius:14px; overflow:hidden; box-shadow:var(--shadow); border-collapse:collapse;">
      <thead style="background:var(--gradient); color:white;">
        <tr>
          <th style="padding:14px;">#</th>
          <th style="padding:14px;">الاسم</th>
          <th style="padding:14px;">البريد</th>
          <th style="padding:14px;">الدور</th>
          <th style="padding:14px;">تاريخ التسجيل</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($recentUsers as $u): ?>
          <tr style="border-bottom:1px solid var(--border);">
            <td style="padding:14px;"><?= $u['id'] ?></td>
            <td style="padding:14px;"><?= clean($u['name']) ?></td>
            <td style="padding:14px;"><?= clean($u['email']) ?></td>
            <td style="padding:14px;">
              <span class="level-status <?= $u['role']=='admin' ? 'status-current' : 'status-completed' ?>">
                <?= $u['role'] ?>
              </span>
            </td>
            <td style="padding:14px;"><?= date('Y-m-d', strtotime($u['created_at'])) ?></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>

    <div class="alert alert-info" style="margin-top:30px;">
      💡 لإضافة لغات أو دروس جديدة، استخدم phpMyAdmin أو ملفات SQL في مجلد <code>/sql</code>.
      <br>سيتم إضافة واجهة إدارة كاملة في الإصدارات القادمة.
    </div>
  </div>
</section>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>

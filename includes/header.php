<?php require_once __DIR__ . '/../config/config.php'; ?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= isset($pageTitle) ? clean($pageTitle) . ' - ' : '' ?><?= SITE_NAME ?></title>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<?= SITE_URL ?>/public/css/style.css">
</head>
<body>
<nav class="navbar">
  <div class="container">
    <a href="<?= SITE_URL ?>/" class="logo">علمني</a>
    <ul class="nav-links">
      <li><a href="<?= SITE_URL ?>/">الرئيسية</a></li>
      <li><a href="<?= SITE_URL ?>/languages.php">اللغات</a></li>
      <?php if (isLoggedIn()): ?>
        <li><a href="<?= SITE_URL ?>/dashboard.php">لوحة التحكم</a></li>
        <li><a href="<?= SITE_URL ?>/chat.php">🤖 المساعد الذكي</a></li>
        <?php if (isAdmin()): ?>
          <li><a href="<?= SITE_URL ?>/admin/index.php">الإدارة</a></li>
        <?php endif; ?>
        <li><a href="<?= SITE_URL ?>/logout.php" class="btn btn-sm btn-outline">خروج</a></li>
      <?php else: ?>
        <li><a href="<?= SITE_URL ?>/login.php">دخول</a></li>
        <li><a href="<?= SITE_URL ?>/register.php" class="btn btn-sm">حساب جديد</a></li>
      <?php endif; ?>
    </ul>
  </div>
</nav>

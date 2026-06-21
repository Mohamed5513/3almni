<?php
/**
 * إعدادات عامة للموقع
 */

session_start();

define('SITE_NAME', 'علمني');
define('SITE_URL', 'http://localhost/3almni');
define('PASS_SCORE', 80); // النسبة المطلوبة للنجاح في الكويز

// المنطقة الزمنية
date_default_timezone_set('Africa/Cairo');

// Charset
header('Content-Type: text/html; charset=utf-8');

require_once __DIR__ . '/database.php';
require_once __DIR__ . '/../includes/functions.php';

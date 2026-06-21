<?php
/**
 * دوال مساعدة عامة
 */

function clean($str) {
    return htmlspecialchars(trim($str), ENT_QUOTES, 'UTF-8');
}

function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

function requireLogin() {
    if (!isLoggedIn()) {
        header('Location: ' . SITE_URL . '/login.php');
        exit;
    }
}

function currentUser() {
    if (!isLoggedIn()) return null;
    static $user = null;
    if ($user === null) {
        $stmt = db()->prepare("SELECT * FROM users WHERE id = ?");
        $stmt->execute([$_SESSION['user_id']]);
        $user = $stmt->fetch();
    }
    return $user;
}

function isAdmin() {
    $u = currentUser();
    return $u && $u['role'] === 'admin';
}

function requireAdmin() {
    requireLogin();
    if (!isAdmin()) {
        header('Location: ' . SITE_URL . '/dashboard.php');
        exit;
    }
}

function flash($key, $msg = null) {
    if ($msg === null) {
        $val = $_SESSION['flash'][$key] ?? null;
        unset($_SESSION['flash'][$key]);
        return $val;
    }
    $_SESSION['flash'][$key] = $msg;
}

function csrfToken() {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function verifyCsrf($token) {
    return isset($_SESSION['csrf_token']) && hash_equals($_SESSION['csrf_token'], $token);
}

function redirect($path) {
    header('Location: ' . SITE_URL . '/' . ltrim($path, '/'));
    exit;
}

/**
 * يتحقق هل المستخدم اجتاز المستوى (80% أو أعلى) للسماح له بالانتقال للمستوى التالي
 */
function hasPassedLevel($userId, $levelId) {
    $stmt = db()->prepare("
        SELECT MAX(score) as best_score
        FROM quiz_results qr
        JOIN quizzes q ON q.id = qr.quiz_id
        WHERE qr.user_id = ? AND q.level_id = ?
    ");
    $stmt->execute([$userId, $levelId]);
    $row = $stmt->fetch();
    return $row && $row['best_score'] >= PASS_SCORE;
}

/**
 * يحدد هل المستخدم يستطيع الوصول لمستوى معين
 * الشرط: نجح في كل المستويات السابقة (80%+) أو إن المستوى = 1
 */
function canAccessLevel($userId, $languageId, $levelNumber) {
    if ($levelNumber == 1) return true;

    // جيب كل المستويات السابقة في نفس اللغة
    $stmt = db()->prepare("
        SELECT id FROM levels
        WHERE language_id = ? AND level_number < ?
        ORDER BY level_number ASC
    ");
    $stmt->execute([$languageId, $levelNumber]);
    $prevLevels = $stmt->fetchAll();

    foreach ($prevLevels as $lvl) {
        if (!hasPassedLevel($userId, $lvl['id'])) {
            return false;
        }
    }
    return true;
}

function getProgressForLanguage($userId, $languageId) {
    $stmt = db()->prepare("
        SELECT l.id, l.level_number, l.title,
               (SELECT MAX(qr.score) FROM quiz_results qr
                JOIN quizzes q ON q.id = qr.quiz_id
                WHERE qr.user_id = ? AND q.level_id = l.id) AS best_score
        FROM levels l
        WHERE l.language_id = ?
        ORDER BY l.level_number ASC
    ");
    $stmt->execute([$userId, $languageId]);
    return $stmt->fetchAll();
}

<?php
// ---------------------------
// Database connection info
// ---------------------------
$host = $_ENV['MYSQLHOST'] ?? 'localhost';
$user = $_ENV['MYSQLUSER'] ?? 'root';
$pass = $_ENV['MYSQLPASSWORD'] ?? '';
$db   = $_ENV['MYSQLDATABASE'] ?? '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // ---------------------------
    // Drop all existing tables
    // ---------------------------
    $tables = $pdo->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
    if (!empty($tables)) {
        $pdo->exec("SET FOREIGN_KEY_CHECKS = 0"); // Disable FK checks
        foreach ($tables as $table) {
            $pdo->exec("DROP TABLE IF EXISTS `$table`");
        }
        $pdo->exec("SET FOREIGN_KEY_CHECKS = 1");
        echo "All existing tables dropped.<br>";
    } else {
        echo "No tables to drop.<br>";
    }

    // ---------------------------
    // Apply schema.sql
    // ---------------------------
    $schemaFile = __DIR__ . '/../db/schema.sql';
    if (file_exists($schemaFile)) {
        $pdo->exec(file_get_contents($schemaFile));
        echo "Schema applied.<br>";
    } else {
        echo "No schema.sql found, skipping.<br>";
    }

    // ---------------------------
    // Apply seed.sql
    // ---------------------------
    $seedFile = __DIR__ . '/../db/seed.sql';
    if (file_exists($seedFile)) {
        $pdo->exec(file_get_contents($seedFile));
        echo "Seed data applied.<br>";
    } else {
        echo "No seed.sql found, skipping.<br>";
    }

    echo "<b>Database fully reset completed successfully.</b>";

} catch (PDOException $e) {
    http_response_code(500);
    echo "Database error: " . htmlspecialchars($e->getMessage());
}
?>
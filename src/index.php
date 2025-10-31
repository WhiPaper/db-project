<?php
$host = getenv('MYSQLHOST');
$port = getenv('MYSQLPORT');
$db   = getenv('MYSQLDATABASE');
$user = getenv('MYSQLUSER');
$pass = getenv('MYSQLPASSWORD');

$conn = mysqli_connect($host, $user, $pass, $db, $port) or die("Connection failed: " . mysqli_connect_error());
phpinfo();
mysqli_close($conn);
?>
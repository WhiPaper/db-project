<?php
$host = getenv('MYSQL_HOST');
$port = getenv('MYSQL_PORT');
$db   = getenv('MYSQL_DATABASE');
$user = getenv('MYSQL_USER');
$pass = getenv('MYSQL_PASSWORD');

$conn = mysqli_connect($host, $user, $pass, $db, $port) or die("Connection failed: " . mysqli_connect_error());
phpinfo();
mysqli_close($conn);
?>
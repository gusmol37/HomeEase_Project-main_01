<?php
include 'conexion.php';

define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', ''); // Deja vacío si no tienes contraseña en XAMPP
define('DB_NAME', 'homeasier_db');

function getDBConnection() {
    try {
        $dsn = "mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=utf8mb4";
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ];
        return new PDO($dsn, DB_USER, DB_PASS, $options);
    } catch (PDOException $e) {
        die("Error de conexión: " . $e->getMessage());
    }
}
?>
<?php
$servername = "localhost";
$username = "root";
$password = ""; // Sin contraseña en XAMPP
$database = "homeasier_db"; 

// Crear conexión
$conn = new mysqli($servername, $username, $password, $database);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Si llegas aquí, la conexión fue exitosa
echo "Conexión exitosa al fin";

?>
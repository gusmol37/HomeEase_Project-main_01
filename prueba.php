<?php
include('conexion.php');

$sql = "INSERT INTO usuarios (nombre, apellido, email, telefono, password, tipo_usuario)
        VALUES ('Paola', 'Parra', 'pparra@gmail.com', '3101234567', '87654321', 'cliente')";

if ($conn->query($sql) === TRUE) {
    echo "¡Funciona!";
} else {
    echo "Error: " . $conn->error;
}
?>

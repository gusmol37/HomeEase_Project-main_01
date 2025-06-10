<?php


include('conexion.php'); 

if (!$conn) {
    die("Error de conexión: " . mysqli_connect_error());
} else {
    echo "✅ Conexión exitosa a la base de datos.<br>";
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = $_POST['firstName'];
    $apellido = $_POST['lastName'];
    $email = $_POST['email'];
    $telefono = $_POST['phone'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $tipo_usuario = $_POST['userType'];


    $sql = "INSERT INTO usuarios (nombre, apellido, email, telefono, password, tipo_usuario)
            VALUES ('$nombre', '$apellido', '$email', '$telefono', '$password', '$tipo_usuario')";



    if ($conn->query($sql) === TRUE) {
        echo "Registro exitoso.";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    $conn->close();
}
?>
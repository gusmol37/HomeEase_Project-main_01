<?php
include 'conexion.php';

session_start();
require_once '../config/db_config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    try {
        $db = getDBConnection();
        $stmt = $db->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->execute([$email]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password'])) {
            if (!$user['is_active']) {
                die("Cuenta no activada. Por favor revisa tu correo.");
            }

            // Guardar datos en sesión
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_email'] = $user['email'];
            $_SESSION['user_role'] = $user['role'];
            $_SESSION['user_name'] = $user['first_name'] . ' ' . $user['last_name'];

            // Redirigir según rol
            switch ($user['role']) {
                case 'admin':
                    header("Location: ../admin/dashboard.php");
                    break;
                case 'provider':
                    header("Location: ../provider/dashboard.php");
                    break;
                default:
                    header("Location: ../client/dashboard.php");
            }
            exit();
        } else {
            die("Credenciales incorrectas");
        }
    } catch (PDOException $e) {
        die("Error en el login: " . $e->getMessage());
    }
}
?>
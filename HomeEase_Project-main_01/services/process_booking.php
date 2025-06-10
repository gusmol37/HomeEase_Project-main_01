<?php
include 'conexion.php';

session_start();
require_once '../config/db_config.php';

if (!isset($_SESSION['user_id'])) {
    die("Debes iniciar sesión para reservar");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = [
        'service_id' => $_POST['service_id'],
        'client_id' => $_SESSION['user_id'],
        'booking_date' => $_POST['booking_date'],
        'notes' => $_POST['notes'] ?? null
    ];

    try {
        $db = getDBConnection();
        
        // Obtener información del servicio
        $stmt = $db->prepare("SELECT provider_id, price FROM services WHERE id = ?");
        $stmt->execute([$data['service_id']]);
        $service = $stmt->fetch();
        
        if (!$service) {
            die("Servicio no encontrado");
        }

        // Insertar reserva
        $sql = "INSERT INTO bookings (client_id, service_id, provider_id, booking_date, notes)
                VALUES (?, ?, ?, ?, ?)";
        $stmt = $db->prepare($sql);
        $stmt->execute([
            $data['client_id'],
            $data['service_id'],
            $service['provider_id'],
            $data['booking_date'],
            $data['notes']
        ]);
        
        $bookingId = $db->lastInsertId();
        
        // Crear registro de pago pendiente
        $sql = "INSERT INTO payments (booking_id, amount, payment_method, status)
                VALUES (?, ?, 'credit_card', 'pending')";
        $stmt = $db->prepare($sql);
        $stmt->execute([$bookingId, $service['price']]);
        
        // Redirigir a confirmación
        header("Location: booking_confirmation.php?id=$bookingId");
        exit();
        
    } catch (PDOException $e) {
        die("Error en la reserva: " . $e->getMessage());
    }
}
?>
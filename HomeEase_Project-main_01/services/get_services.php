<?php
include 'conexion.php';

require_once '../config/db_config.php';

try {
    $db = getDBConnection();
    
    // Consulta con JOIN para obtener información del proveedor
    $sql = "SELECT s.*, u.first_name AS provider_name, c.name AS category_name 
            FROM services s
            JOIN users u ON s.provider_id = u.id
            JOIN service_categories c ON s.category_id = c.id
            WHERE s.is_available = 1";
    
    // Filtrar por categoría si se especifica
    if (isset($_GET['category_id']) && is_numeric($_GET['category_id'])) {
        $sql .= " AND s.category_id = ?";
        $stmt = $db->prepare($sql);
        $stmt->execute([$_GET['category_id']]);
    } else {
        $stmt = $db->query($sql);
    }
    
    $services = $stmt->fetchAll();
    
    // Devolver como JSON
    header('Content-Type: application/json');
    echo json_encode($services);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>
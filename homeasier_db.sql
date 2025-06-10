-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-06-2025 a las 05:31:29
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `homeasier_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `booking_date` datetime NOT NULL,
  `status` enum('pending','confirmed','completed','cancelled') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bookings`
--

INSERT INTO `bookings` (`id`, `client_id`, `service_id`, `provider_id`, `booking_date`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 2, '2025-04-03 03:32:11', 'confirmed', NULL, '2025-03-31 08:32:11', '2025-03-31 08:32:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('credit_card','debit_card','paypal','bank_transfer') NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `payments`
--

INSERT INTO `payments` (`id`, `booking_id`, `amount`, `payment_method`, `transaction_id`, `status`, `payment_date`, `created_at`) VALUES
(1, 1, '120000.00', 'credit_card', 'PAY-123456789', 'completed', '2025-03-31 08:32:36', '2025-03-31 08:32:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provider_availability`
--

CREATE TABLE `provider_availability` (
  `id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `day_of_week` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `provider_availability`
--

INSERT INTO `provider_availability` (`id`, `provider_id`, `day_of_week`, `start_time`, `end_time`) VALUES
(1, 2, 'monday', '08:00:00', '18:00:00'),
(2, 2, 'wednesday', '08:00:00', '18:00:00'),
(3, 2, 'friday', '08:00:00', '18:00:00'),
(4, 3, 'tuesday', '09:00:00', '17:00:00'),
(5, 3, 'thursday', '09:00:00', '17:00:00'),
(6, 3, 'saturday', '10:00:00', '14:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provider_profiles`
--

CREATE TABLE `provider_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `service_area` varchar(100) DEFAULT NULL,
  `years_of_experience` int(11) DEFAULT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT 0.00,
  `profile_picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `provider_profiles`
--

INSERT INTO `provider_profiles` (`id`, `user_id`, `company_name`, `description`, `service_area`, `years_of_experience`, `license_number`, `rating`, `profile_picture`) VALUES
(1, 2, 'Limpieza Total', 'Servicio profesional de limpieza para hogares y oficinas', 'Toda la ciudad', 5, 'LIC-12345', '4.80', NULL),
(2, 3, 'Fontanería Express', 'Soluciones rápidas y efectivas para problemas de fontanería', 'Zona norte y centro', 8, 'LIC-54321', '4.90', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `reviews`
--

INSERT INTO `reviews` (`id`, `booking_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 5, 'Excelente servicio, muy profesional y puntual. La casa quedó impecable.', '2025-03-31 08:32:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` int(11) DEFAULT NULL COMMENT 'Duración en minutos',
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `services`
--

INSERT INTO `services` (`id`, `provider_id`, `category_id`, `name`, `description`, `price`, `duration`, `is_available`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'Limpieza general', 'Limpieza completa de toda la casa incluyendo cocina, baños, dormitorios y áreas comunes', '120000.00', 240, 1, '2025-03-31 08:31:35', '2025-03-31 08:31:35'),
(2, 2, 1, 'Limpieza profunda de cocina', 'Limpieza exhaustiva de cocina incluyendo electrodomésticos, gabinetes y pisos', '80000.00', 180, 1, '2025-03-31 08:31:35', '2025-03-31 08:31:35'),
(3, 3, 2, 'Reparación de tuberías', 'Reparación de fugas y problemas en tuberías', '90000.00', 120, 1, '2025-03-31 08:31:35', '2025-03-31 08:31:35'),
(4, 3, 2, 'Instalación de grifería', 'Instalación profesional de grifos y accesorios de baño', '150000.00', 180, 1, '2025-03-31 08:31:35', '2025-03-31 08:31:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `service_categories`
--

CREATE TABLE `service_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `service_categories`
--

INSERT INTO `service_categories` (`id`, `name`, `description`, `icon`) VALUES
(1, 'Limpieza', 'Servicios de limpieza para el hogar', 'broom'),
(2, 'Fontanería', 'Reparación e instalación de sistemas de agua', 'faucet'),
(3, 'Electricidad', 'Servicios eléctricos y reparaciones', 'bolt'),
(4, 'Jardinería', 'Mantenimiento de jardines y áreas verdes', 'leaf'),
(5, 'Carpintería', 'Trabajos en madera y muebles', 'hammer'),
(6, 'Pintura', 'Servicios de pintura para interiores y exteriores', 'paint-roller'),
(7, 'Mudanzas', 'Servicios de transporte y mudanza', 'truck-moving'),
(8, 'Electrodomésticos', 'Reparación y mantenimiento de electrodomésticos', 'blender');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `role` enum('admin','provider','client') NOT NULL,
  `is_active` tinyint(1) DEFAULT 0,
  `activation_token` varchar(255) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `address`, `role`, `is_active`, `activation_token`, `reset_token`, `reset_token_expires`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'Sistema', 'admin@homeasier.com', '12345678', '1234567890', NULL, 'admin', 1, NULL, NULL, NULL, '2025-03-31 08:30:20', '2025-04-06 20:44:37'),
(2, 'Carlos', 'Mendoza', 'carlos@proveedor.com', '12345678', '3101234567', NULL, 'provider', 1, NULL, NULL, NULL, '2025-03-31 08:30:37', '2025-04-06 20:44:42'),
(3, 'Laura', 'Gómez', 'laura@proveedor.com', '12345678', '3202345678', NULL, 'provider', 1, NULL, NULL, NULL, '2025-03-31 08:30:37', '2025-04-06 20:44:46'),
(4, 'Ana', 'Rodríguez', 'ana@cliente.com', '12345678', '3003456789', 'Calle 123 #45-67, Ciudad', 'client', 1, NULL, NULL, NULL, '2025-03-31 08:31:53', '2025-04-06 20:44:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `tipo_usuario` enum('cliente','proveedor') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `telefono`, `password`, `tipo_usuario`) VALUES
(4, 'Test', 'Usuario', 'test@email.com', '123456789', '1234', 'cliente'),
(8, 'Paola', 'Parra', 'pparra@gmail.com', '3101234567', '87654321', 'cliente'),
(9, 'Gustavo', 'Molina', 'gusmol37@gmail.com', '3101234567', '12345678', 'cliente'),
(10, 'Laura', 'Zuluaga', 'lzuluaga@outlook.com', '3001234567', '12345678', 'cliente'),
(11, 'Gladys', 'Moreno', 'gmoreno@hotmail.com', '3101234567', '12345678', 'proveedor'),
(13, 'Milena', 'Paz', 'mpaz@hotmail.com', '3101234567', '12345678', 'proveedor'),
(15, 'Carolina ', 'Guerra', 'cguerra@hotmail.com', '3101234567', '12345678', 'cliente'),
(16, 'Ricardo', 'Espinosa', 'respinosa@outlook.com', '3101234567', '12345678', 'cliente'),
(18, 'Camilo', 'Espinoza', 'cespinoza@gmail.com', '31212345678', '1234578', 'cliente'),
(19, 'Maria', 'Parra', 'mparra@gmail.com', '3129451237', '$2y$10$hBs4yMdAQwB9CGtVAvtT1Ox8DU2/60ZsPBY08utDBKY', 'cliente'),
(20, 'Jhonan', 'Forero', 'jforero@gmail.com', '3121234567', '$2y$10$0vwLqJxjGcMocCjnvYs26eWIi2OJBZNTYLX4wxDhp/c', 'cliente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `provider_id` (`provider_id`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indices de la tabla `provider_availability`
--
ALTER TABLE `provider_availability`
  ADD PRIMARY KEY (`id`),
  ADD KEY `provider_id` (`provider_id`);

--
-- Indices de la tabla `provider_profiles`
--
ALTER TABLE `provider_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indices de la tabla `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indices de la tabla `service_categories`
--
ALTER TABLE `service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `provider_availability`
--
ALTER TABLE `provider_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `provider_profiles`
--
ALTER TABLE `provider_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `service_categories`
--
ALTER TABLE `service_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`provider_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`);

--
-- Filtros para la tabla `provider_availability`
--
ALTER TABLE `provider_availability`
  ADD CONSTRAINT `provider_availability_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `provider_profiles`
--
ALTER TABLE `provider_profiles`
  ADD CONSTRAINT `provider_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`);

--
-- Filtros para la tabla `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `service_categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

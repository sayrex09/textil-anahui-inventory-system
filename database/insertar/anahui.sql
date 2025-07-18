CREATE DATABASE anahui;
USE anahui;
CREATE TABLE `activity_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `action` varchar(255) NOT NULL,
  `module` varchar(255) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cajas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `fecha_hora_apertura` datetime NOT NULL,
  `fecha_hora_cierre` datetime DEFAULT NULL,
  `saldo_inicial` decimal(8,2) NOT NULL,
  `saldo_final` decimal(8,2) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cajas_user_id_foreign` (`user_id`),
  CONSTRAINT `cajas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `caracteristicas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `categorias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `caracteristica_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorias_caracteristica_id_unique` (`caracteristica_id`),
  CONSTRAINT `categorias_caracteristica_id_foreign` FOREIGN KEY (`caracteristica_id`) REFERENCES `caracteristicas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `clientes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `persona_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientes_persona_id_unique` (`persona_id`),
  CONSTRAINT `clientes_persona_id_foreign` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `compra_producto` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `compra_id` bigint(20) unsigned NOT NULL,
  `producto_id` bigint(20) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compra_producto_compra_id_foreign` (`compra_id`),
  KEY `compra_producto_producto_id_foreign` (`producto_id`),
  CONSTRAINT `compra_producto_compra_id_foreign` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compra_producto_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `compras` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `comprobante_id` bigint(20) unsigned NOT NULL,
  `proveedore_id` bigint(20) unsigned NOT NULL,
  `numero_comprobante` varchar(255) DEFAULT NULL,
  `comprobante_path` varchar(2048) DEFAULT NULL,
  `metodo_pago` enum('EFECTIVO','TARJETA') NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(8,2) unsigned NOT NULL,
  `subtotal` decimal(8,2) unsigned NOT NULL,
  `total` decimal(8,2) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compras_numero_comprobante_unique` (`numero_comprobante`),
  KEY `compras_user_id_foreign` (`user_id`),
  KEY `compras_comprobante_id_foreign` (`comprobante_id`),
  KEY `compras_proveedore_id_foreign` (`proveedore_id`),
  CONSTRAINT `compras_comprobante_id_foreign` FOREIGN KEY (`comprobante_id`) REFERENCES `comprobantes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compras_proveedore_id_foreign` FOREIGN KEY (`proveedore_id`) REFERENCES `proveedores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compras_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `comprobantes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `documentos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `documentos` VALUES
(1,'DNI',NULL,NULL),
(2,'Pasaporte',NULL,NULL),
(3,'RUC',NULL,NULL),
(4,'Carnet Extranjería',NULL,NULL);

CREATE TABLE `empleados` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `img_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `empresa` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `propietario` varchar(255) NOT NULL,
  `ruc` varchar(50) NOT NULL,
  `porcentaje_impuesto` int(10) unsigned NOT NULL,
  `abreviatura_impuesto` varchar(5) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `moneda_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `empresa_moneda_id_unique` (`moneda_id`),
  CONSTRAINT `empresa_moneda_id_foreign` FOREIGN KEY (`moneda_id`) REFERENCES `monedas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `empresa` VALUES
(1,'Textil Anahui SAC','Textil Anahui SACa','20338996706',18,'IGV','Av. Aviacion Nro. 476 Int. 308',NULL,NULL,NULL,1,NULL,NULL);

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `inventario` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` bigint(20) unsigned NOT NULL,
  `ubicacione_id` bigint(20) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `cantidad_minima` int(10) unsigned DEFAULT NULL,
  `cantidad_maxima` int(10) unsigned DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventario_producto_id_unique` (`producto_id`),
  KEY `inventario_ubicacione_id_foreign` (`ubicacione_id`),
  CONSTRAINT `inventario_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inventario_ubicacione_id_foreign` FOREIGN KEY (`ubicacione_id`) REFERENCES `ubicaciones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `kardex` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` bigint(20) unsigned NOT NULL,
  `tipo_transaccion` enum('COMPRA','VENTA','AJUSTE','APERTURA') NOT NULL,
  `descripcion_transaccion` varchar(255) NOT NULL,
  `entrada` int(11) DEFAULT NULL,
  `salida` int(11) DEFAULT NULL,
  `saldo` int(11) NOT NULL,
  `costo_unitario` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kardex_producto_id_foreign` (`producto_id`),
  CONSTRAINT `kardex_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `marcas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `caracteristica_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marcas_caracteristica_id_unique` (`caracteristica_id`),
  CONSTRAINT `marcas_caracteristica_id_foreign` FOREIGN KEY (`caracteristica_id`) REFERENCES `caracteristicas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2019_08_19_000000_create_failed_jobs_table',1),
(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
(5,'2023_03_10_011515_create_documentos_table',1),
(6,'2023_03_10_012149_create_personas_table',1),
(7,'2023_03_10_015030_create_proveedores_table',1),
(8,'2023_03_10_015806_create_clientes_table',1),
(9,'2023_03_10_020010_create_comprobantes_table',1),
(10,'2023_03_10_020257_create_compras_table',1),
(11,'2023_03_10_022517_create_ventas_table',1),
(12,'2023_03_10_023329_create_caracteristicas_table',1),
(13,'2023_03_10_023555_create_categorias_table',1),
(14,'2023_03_10_023818_create_marcas_table',1),
(15,'2023_03_10_023953_create_presentaciones_table',1),
(16,'2023_03_10_024112_create_productos_table',1),
(17,'2023_03_10_025748_create_compra_producto_table',1),
(18,'2023_03_10_030137_create_producto_venta_table',1),
(19,'2025_01_22_114613_create_permission_tables',1),
(20,'2025_01_23_113358_create_monedas_table',1),
(21,'2025_01_23_113626_create_empresas_table',1),
(22,'2025_01_23_114215_create_empleados_table',1),
(23,'2025_01_23_114438_update_columns_to_users_table',1),
(24,'2025_01_23_115036_create_cajas_table',1),
(25,'2025_01_23_115425_create_movimientos_table',1),
(26,'2025_01_23_115923_update_columns_to_ventas_table',1),
(27,'2025_01_23_120147_create_ubicaciones_table',1),
(28,'2025_01_23_121110_create_inventarios_table',1),
(29,'2025_01_23_121449_create_kardexes_table',1),
(30,'2025_02_03_102442_create_activity_logs_table',1),
(31,'2025_05_20_213434_create_jobs_table',1),
(32,'2025_05_24_210954_create_notifications_table',1);

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `model_has_roles` VALUES
(1,'App\\Models\\User',1);

CREATE TABLE `monedas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `estandar_iso` varchar(10) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `simbolo` varchar(3) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `monedas` VALUES
(1,'USD','Dólar estadounidense','$',NULL,NULL),
(2,'EUR','Euro','€',NULL,NULL),
(3,'MXN','Peso mexicano','$',NULL,NULL),
(4,'PEN','Sol peruano','S/',NULL,NULL),
(5,'ARS','Peso Argentino','$',NULL,NULL),
(6,'CLP','Peso Chileno','$',NULL,NULL),
(7,'BTC ','Bitcoin','$',NULL,NULL);

CREATE TABLE `movimientos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` enum('VENTA','RETIRO') NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `monto` decimal(8,2) NOT NULL,
  `metodo_pago` enum('EFECTIVO','TARJETA') NOT NULL,
  `caja_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movimientos_caja_id_foreign` (`caja_id`),
  CONSTRAINT `movimientos_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `permissions` VALUES
(1,'ver-registro-actividad','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(2,'ver-caja','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(3,'aperturar-caja','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(4,'cerrar-caja','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(5,'ver-kardex','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(6,'ver-categoria','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(7,'crear-categoria','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(8,'editar-categoria','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(9,'eliminar-categoria','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(10,'ver-cliente','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(11,'crear-cliente','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(12,'editar-cliente','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(13,'eliminar-cliente','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(14,'ver-compra','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(15,'crear-compra','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(16,'mostrar-compra','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(17,'ver-empleado','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(18,'crear-empleado','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(19,'editar-empleado','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(20,'eliminar-empleado','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(21,'ver-empresa','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(22,'update-empresa','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(23,'ver-inventario','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(24,'crear-inventario','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(25,'ver-marca','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(26,'crear-marca','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(27,'editar-marca','web','2025-07-18 05:13:44','2025-07-18 05:13:44'),
(28,'eliminar-marca','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(29,'ver-movimiento','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(30,'crear-movimiento','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(31,'ver-presentacione','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(32,'crear-presentacione','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(33,'editar-presentacione','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(34,'eliminar-presentacione','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(35,'ver-producto','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(36,'crear-producto','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(37,'editar-producto','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(38,'ver-perfil','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(39,'editar-perfil','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(40,'ver-proveedore','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(41,'crear-proveedore','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(42,'editar-proveedore','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(43,'eliminar-proveedore','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(44,'ver-venta','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(45,'crear-venta','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(46,'mostrar-venta','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(47,'ver-role','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(48,'crear-role','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(49,'editar-role','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(50,'eliminar-role','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(51,'ver-user','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(52,'crear-user','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(53,'editar-user','web','2025-07-18 05:13:45','2025-07-18 05:13:45'),
(54,'eliminar-user','web','2025-07-18 05:13:45','2025-07-18 05:13:45');

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `personas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `tipo` enum('NATURAL','JURIDICA') NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `documento_id` bigint(20) unsigned NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `personas_documento_id_foreign` (`documento_id`),
  CONSTRAINT `personas_documento_id_foreign` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `presentaciones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `caracteristica_id` bigint(20) unsigned NOT NULL,
  `sigla` varchar(5) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `presentaciones_caracteristica_id_unique` (`caracteristica_id`),
  CONSTRAINT `presentaciones_caracteristica_id_foreign` FOREIGN KEY (`caracteristica_id`) REFERENCES `caracteristicas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `producto_venta` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `venta_id` bigint(20) unsigned NOT NULL,
  `producto_id` bigint(20) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_venta_venta_id_foreign` (`venta_id`),
  KEY `producto_venta_producto_id_foreign` (`producto_id`),
  CONSTRAINT `producto_venta_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `producto_venta_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `productos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `img_path` varchar(2048) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `precio` decimal(8,2) DEFAULT NULL,
  `marca_id` bigint(20) unsigned DEFAULT NULL,
  `presentacione_id` bigint(20) unsigned NOT NULL,
  `categoria_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productos_codigo_unique` (`codigo`),
  KEY `productos_marca_id_foreign` (`marca_id`),
  KEY `productos_presentacione_id_foreign` (`presentacione_id`),
  KEY `productos_categoria_id_foreign` (`categoria_id`),
  CONSTRAINT `productos_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `productos_marca_id_foreign` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `productos_presentacione_id_foreign` FOREIGN KEY (`presentacione_id`) REFERENCES `presentaciones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `proveedores` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `persona_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proveedores_persona_id_unique` (`persona_id`),
  CONSTRAINT `proveedores_persona_id_foreign` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `role_has_permissions` VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(28,1),
(29,1),
(30,1),
(31,1),
(32,1),
(33,1),
(34,1),
(35,1),
(36,1),
(37,1),
(38,1),
(39,1),
(40,1),
(41,1),
(42,1),
(43,1),
(44,1),
(45,1),
(46,1),
(47,1),
(48,1),
(49,1),
(50,1),
(51,1),
(52,1),
(53,1),
(54,1);

CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` VALUES
(1,'administrador','web','2025-07-18 05:13:45','2025-07-18 05:13:45');

CREATE TABLE `ubicaciones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ubicaciones` VALUES
(1,'Estante 1',NULL,NULL),
(2,'Estante 2',NULL,NULL),
(3,'Estante 3',NULL,NULL),
(4,'Estante 4',NULL,NULL),
(5,'Estante 5',NULL,NULL),
(6,'Estante 6',NULL,NULL),
(7,'Estante 7',NULL,NULL),
(8,'Estante 8',NULL,NULL),
(9,'Estante 9',NULL,NULL);

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `empleado_id` bigint(20) unsigned DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_empleado_id_unique` (`empleado_id`),
  CONSTRAINT `users_empleado_id_foreign` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` VALUES
(1,'Administrador','admin@gmail.com',NULL,'$2y$10$xFK1TkESrcYWnIcio8JGdeePniEMW00FvL3IIpjYXjOZqqR/yxPKu',NULL,NULL,1,'2025-07-18 05:13:45','2025-07-18 05:13:45');

CREATE TABLE `ventas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `caja_id` bigint(20) unsigned NOT NULL,
  `comprobante_id` bigint(20) unsigned NOT NULL,
  `numero_comprobante` varchar(255) NOT NULL,
  `metodo_pago` enum('EFECTIVO','TARJETA') NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `impuesto` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `monto_recibido` decimal(8,2) NOT NULL,
  `vuelto_entregado` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ventas_numero_comprobante_unique` (`numero_comprobante`),
  KEY `ventas_cliente_id_foreign` (`cliente_id`),
  KEY `ventas_user_id_foreign` (`user_id`),
  KEY `ventas_comprobante_id_foreign` (`comprobante_id`),
  KEY `ventas_caja_id_foreign` (`caja_id`),
  CONSTRAINT `ventas_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ventas_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ventas_comprobante_id_foreign` FOREIGN KEY (`comprobante_id`) REFERENCES `comprobantes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ventas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

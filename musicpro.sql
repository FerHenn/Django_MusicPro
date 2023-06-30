-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-06-2023 a las 22:49:02
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `musicpro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accounts_profile`
--

CREATE TABLE `accounts_profile` (
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `accounts_profile`
--

INSERT INTO `accounts_profile` (`id`, `image`, `address`, `location`, `telephone`, `user_id`) VALUES
(1, 'users/usuario_defecto.jpg', NULL, NULL, NULL, 1),
(2, 'users/usuario_defecto.jpg', NULL, NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(5, 'administrador'),
(2, 'bodeguero'),
(1, 'cliente'),
(4, 'contador'),
(3, 'vendedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add perfil', 7, 'add_profile'),
(26, 'Can change perfil', 7, 'change_profile'),
(27, 'Can delete perfil', 7, 'delete_profile'),
(28, 'Can view perfil', 7, 'view_profile'),
(29, 'Can add post', 8, 'add_post'),
(30, 'Can change post', 8, 'change_post'),
(31, 'Can delete post', 8, 'delete_post'),
(32, 'Can view post', 8, 'view_post'),
(33, 'Can add categoria', 9, 'add_categoria'),
(34, 'Can change categoria', 9, 'change_categoria'),
(35, 'Can delete categoria', 9, 'delete_categoria'),
(36, 'Can view categoria', 9, 'view_categoria'),
(37, 'Can add producto', 10, 'add_producto'),
(38, 'Can change producto', 10, 'change_producto'),
(39, 'Can delete producto', 10, 'delete_producto'),
(40, 'Can view producto', 10, 'view_producto'),
(41, 'Can add detalle venta', 11, 'add_detalleventa'),
(42, 'Can change detalle venta', 11, 'change_detalleventa'),
(43, 'Can delete detalle venta', 11, 'delete_detalleventa'),
(44, 'Can view detalle venta', 11, 'view_detalleventa'),
(45, 'Can add venta', 12, 'add_venta'),
(46, 'Can change venta', 12, 'change_venta'),
(47, 'Can delete venta', 12, 'delete_venta'),
(48, 'Can view venta', 12, 'view_venta'),
(49, 'Can add subcategoria', 13, 'add_subcategoria'),
(50, 'Can change subcategoria', 13, 'change_subcategoria'),
(51, 'Can delete subcategoria', 13, 'delete_subcategoria'),
(52, 'Can view subcategoria', 13, 'view_subcategoria'),
(53, 'Can add coupon', 14, 'add_coupon'),
(54, 'Can change coupon', 14, 'change_coupon'),
(55, 'Can delete coupon', 14, 'delete_coupon'),
(56, 'Can view coupon', 14, 'view_coupon');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$t2agBM0evSmqcx3U9MFLNI$4kQKSngt17tSgWxnBC81DQ5hwgDznf280diluEkXp9o=', '2023-06-30 20:03:13.667289', 1, 'admin', '', '', 'admin@admin.com', 1, 1, '2023-06-29 20:17:20.307479'),
(2, 'pbkdf2_sha256$600000$PzlqU4DvtMRGKw5xofLUBH$8I6q6e9Tqu5DjY9Jo708JJCdgcBcNKVy09H7Mrg9LgU=', '2023-06-30 20:12:18.550880', 0, 'cliente', 'cliente', 'cliente', 'cliente@mail.com', 0, 1, '2023-06-29 20:36:06.813087');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 5),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_categoria`
--

CREATE TABLE `core_categoria` (
  `idCategoria` int(11) NOT NULL,
  `nombreCategoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_categoria`
--

INSERT INTO `core_categoria` (`idCategoria`, `nombreCategoria`) VALUES
(1, 'Instrumentos de Cuerdas'),
(2, 'Percusión'),
(3, 'Amplificadores'),
(4, 'Varios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_coupon`
--

CREATE TABLE `core_coupon` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount_amount` decimal(5,2) NOT NULL,
  `expiration_date` date NOT NULL,
  `email` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_detalleventa`
--

CREATE TABLE `core_detalleventa` (
  `idDetVenta` int(11) NOT NULL,
  `cantidad_prod_venta` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_post`
--

CREATE TABLE `core_post` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `text` longtext NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `published_date` datetime(6) DEFAULT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_producto`
--

CREATE TABLE `core_producto` (
  `idProducto` int(11) NOT NULL,
  `nombre_prod` varchar(40) NOT NULL,
  `imagen_prod` varchar(100) DEFAULT NULL,
  `descripcion_prod` longtext NOT NULL,
  `cantidad_prod` int(11) NOT NULL,
  `precio_prod` int(11) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `marca_prod` varchar(30) DEFAULT NULL,
  `modelo_prod` varchar(30) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_producto`
--

INSERT INTO `core_producto` (`idProducto`, `nombre_prod`, `imagen_prod`, `descripcion_prod`, `cantidad_prod`, `precio_prod`, `categoria_id`, `marca_prod`, `modelo_prod`, `subcategoria_id`) VALUES
(1, 'Guitarra acústica', 'Productos/1.2Ins.Cuerda.jpg', 'Guitarra acústica', 9, 20000, 1, 'Yamaha', 'YM1', 1),
(2, 'Tama', 'Productos/1.3Percusion.jpg', 'Tama', 20, 20000, 2, 'Yamaha', 'YMT', 4),
(3, 'Marshall', 'Productos/1.4Amplificadores.jpg', 'Marshall Amplificador', 25, 50000, 3, 'Marshal', 'Marshal1', 7),
(4, 'Audifonos', 'Productos/1.5Varios.jpg', 'Audifonos', 13, 100000, 4, 'JBL', 'JBL', NULL),
(5, 'prueba 1', 'Productos/IMG_SSUd1OX.png', 'Prueba1', 10, 10000, 3, 'prueba 1', 'prueba 1', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_subcategoria`
--

CREATE TABLE `core_subcategoria` (
  `idSubCategoria` int(11) NOT NULL,
  `nombreSubCategoria` varchar(50) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_subcategoria`
--

INSERT INTO `core_subcategoria` (`idSubCategoria`, `nombreSubCategoria`, `categoria_id`) VALUES
(1, 'Guitarras', 1),
(2, 'Bajos', 1),
(3, 'Pianos', 1),
(4, 'Baterías Acústicas', 2),
(5, 'Batería Electrónica', 2),
(6, 'Cabezales', 3),
(7, 'Cajas', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_venta`
--

CREATE TABLE `core_venta` (
  `idVenta` int(11) NOT NULL,
  `fech_venta` date NOT NULL,
  `descuento` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `iva` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `producto_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-06-29 20:19:34.931716', '1', 'Instrumentos de Cuerdas', 1, '[{\"added\": {}}]', 9, 1),
(2, '2023-06-29 20:19:42.658783', '2', 'Percusión', 1, '[{\"added\": {}}]', 9, 1),
(3, '2023-06-29 20:19:59.272950', '3', 'Amplificadores', 1, '[{\"added\": {}}]', 9, 1),
(4, '2023-06-29 20:20:08.279104', '4', 'Varios', 1, '[{\"added\": {}}]', 9, 1),
(5, '2023-06-29 20:20:36.292742', '1', 'Guitarras cuerpo sólido', 1, '[{\"added\": {}}]', 13, 1),
(6, '2023-06-29 20:31:15.835669', '2', 'Guitarras Acústicas', 1, '[{\"added\": {}}]', 13, 1),
(7, '2023-06-29 20:31:26.278020', '3', 'Guitarras Eléctricas', 1, '[{\"added\": {}}]', 13, 1),
(8, '2023-06-29 20:31:37.674414', '3', 'Guitarras Eléctricas', 3, '', 13, 1),
(9, '2023-06-29 20:31:40.026843', '2', 'Guitarras Acústicas', 3, '', 13, 1),
(10, '2023-06-29 20:31:42.015855', '1', 'Guitarras cuerpo sólido', 3, '', 13, 1),
(11, '2023-06-29 20:31:51.975728', '1', 'Guitarras', 1, '[{\"added\": {}}]', 13, 1),
(12, '2023-06-29 20:32:01.892060', '2', 'Bajos', 1, '[{\"added\": {}}]', 13, 1),
(13, '2023-06-29 20:32:07.857526', '3', 'Pianos', 1, '[{\"added\": {}}]', 13, 1),
(14, '2023-06-29 20:32:25.306735', '3', 'Pianos', 2, '[]', 13, 1),
(15, '2023-06-29 20:32:42.500057', '4', 'Baterías Acústicas', 1, '[{\"added\": {}}]', 13, 1),
(16, '2023-06-29 20:32:49.639977', '5', 'Batería Electrónica', 1, '[{\"added\": {}}]', 13, 1),
(17, '2023-06-29 20:32:56.098116', '4', 'Baterías Acústicas', 2, '[{\"changed\": {\"fields\": [\"Categoria\"]}}]', 13, 1),
(18, '2023-06-29 20:33:13.559821', '6', 'Cabezales', 1, '[{\"added\": {}}]', 13, 1),
(19, '2023-06-29 20:33:20.556040', '7', 'Cajas', 1, '[{\"added\": {}}]', 13, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(7, 'accounts', 'profile'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(9, 'core', 'categoria'),
(14, 'core', 'coupon'),
(11, 'core', 'detalleventa'),
(8, 'core', 'post'),
(10, 'core', 'producto'),
(13, 'core', 'subcategoria'),
(12, 'core', 'venta'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-06-29 20:16:06.280223'),
(2, 'auth', '0001_initial', '2023-06-29 20:16:07.284759'),
(3, 'accounts', '0001_initial', '2023-06-29 20:16:07.439450'),
(4, 'admin', '0001_initial', '2023-06-29 20:16:07.673499'),
(5, 'admin', '0002_logentry_remove_auto_add', '2023-06-29 20:16:07.704077'),
(6, 'admin', '0003_logentry_add_action_flag_choices', '2023-06-29 20:16:07.728783'),
(7, 'contenttypes', '0002_remove_content_type_name', '2023-06-29 20:16:07.865460'),
(8, 'auth', '0002_alter_permission_name_max_length', '2023-06-29 20:16:07.982609'),
(9, 'auth', '0003_alter_user_email_max_length', '2023-06-29 20:16:08.050673'),
(10, 'auth', '0004_alter_user_username_opts', '2023-06-29 20:16:08.090646'),
(11, 'auth', '0005_alter_user_last_login_null', '2023-06-29 20:16:08.188490'),
(12, 'auth', '0006_require_contenttypes_0002', '2023-06-29 20:16:08.188490'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2023-06-29 20:16:08.214278'),
(14, 'auth', '0008_alter_user_username_max_length', '2023-06-29 20:16:08.255416'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2023-06-29 20:16:08.296066'),
(16, 'auth', '0010_alter_group_name_max_length', '2023-06-29 20:16:08.336629'),
(17, 'auth', '0011_update_proxy_permissions', '2023-06-29 20:16:08.353035'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2023-06-29 20:16:08.385985'),
(19, 'core', '0001_initial', '2023-06-29 20:16:08.508250'),
(20, 'core', '0002_categoria_producto', '2023-06-29 20:16:08.675516'),
(21, 'core', '0003_detalleventa_venta_producto_marca_prod_and_more', '2023-06-29 20:16:08.994339'),
(22, 'core', '0004_cupon', '2023-06-29 20:16:09.043826'),
(23, 'core', '0005_rename_cupon_coupon_rename_codigo_coupon_code_and_more', '2023-06-29 20:16:09.218596'),
(24, 'sessions', '0001_initial', '2023-06-29 20:16:09.293882'),
(25, 'core', '0006_venta_producto', '2023-06-29 20:49:47.417213');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('8gxxqd9w2euehomtld907kpum33xq8az', '.eJxVjDsOwjAQBe_iGln-JbYp6TlDtLte4wCypTipEHeHSCmgfTPzXmKCbS3T1nmZ5iTOwojT74ZAD647SHeotyap1XWZUe6KPGiX15b4eTncv4MCvXzrnC1iYqPNAHYcPA3RMEVHyimvwhhsiAmsx8wEHrSObBC1dZaCMpTE-wPpxTf3:1qFKTa:EWN4skhYVYQbk9nI0Xf5PqsPRNXhaZIdKGxHhVQaYOM', '2023-07-14 20:12:18.559251');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accounts_profile`
--
ALTER TABLE `accounts_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `core_categoria`
--
ALTER TABLE `core_categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `core_coupon`
--
ALTER TABLE `core_coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`code`);

--
-- Indices de la tabla `core_detalleventa`
--
ALTER TABLE `core_detalleventa`
  ADD PRIMARY KEY (`idDetVenta`);

--
-- Indices de la tabla `core_post`
--
ALTER TABLE `core_post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_post_author_id_083b751e_fk_auth_user_id` (`author_id`);

--
-- Indices de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `core_producto_categoria_id_65b2d0af_fk_core_cate` (`categoria_id`),
  ADD KEY `core_producto_subcategoria_id_9bdd41ca_fk_core_subc` (`subcategoria_id`);

--
-- Indices de la tabla `core_subcategoria`
--
ALTER TABLE `core_subcategoria`
  ADD PRIMARY KEY (`idSubCategoria`),
  ADD KEY `core_subcategoria_categoria_id_d0e9c4c2_fk_core_cate` (`categoria_id`);

--
-- Indices de la tabla `core_venta`
--
ALTER TABLE `core_venta`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `core_venta_producto_id_74ebc3d4_fk_core_producto_idProducto` (`producto_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accounts_profile`
--
ALTER TABLE `accounts_profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_coupon`
--
ALTER TABLE `core_coupon`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_post`
--
ALTER TABLE `core_post`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `accounts_profile`
--
ALTER TABLE `accounts_profile`
  ADD CONSTRAINT `accounts_profile_user_id_49a85d32_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `core_post`
--
ALTER TABLE `core_post`
  ADD CONSTRAINT `core_post_author_id_083b751e_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `core_producto`
--
ALTER TABLE `core_producto`
  ADD CONSTRAINT `core_producto_categoria_id_65b2d0af_fk_core_cate` FOREIGN KEY (`categoria_id`) REFERENCES `core_categoria` (`idCategoria`),
  ADD CONSTRAINT `core_producto_subcategoria_id_9bdd41ca_fk_core_subc` FOREIGN KEY (`subcategoria_id`) REFERENCES `core_subcategoria` (`idSubCategoria`);

--
-- Filtros para la tabla `core_subcategoria`
--
ALTER TABLE `core_subcategoria`
  ADD CONSTRAINT `core_subcategoria_categoria_id_d0e9c4c2_fk_core_cate` FOREIGN KEY (`categoria_id`) REFERENCES `core_categoria` (`idCategoria`);

--
-- Filtros para la tabla `core_venta`
--
ALTER TABLE `core_venta`
  ADD CONSTRAINT `core_venta_producto_id_74ebc3d4_fk_core_producto_idProducto` FOREIGN KEY (`producto_id`) REFERENCES `core_producto` (`idProducto`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

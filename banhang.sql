-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 17, 2025 lúc 03:12 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `banhang`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_permission`
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
(25, 'Can add Danh mục', 7, 'add_category'),
(26, 'Can change Danh mục', 7, 'change_category'),
(27, 'Can delete Danh mục', 7, 'delete_category'),
(28, 'Can view Danh mục', 7, 'view_category'),
(29, 'Can add Mã giảm giá', 8, 'add_coupon'),
(30, 'Can change Mã giảm giá', 8, 'change_coupon'),
(31, 'Can delete Mã giảm giá', 8, 'delete_coupon'),
(32, 'Can view Mã giảm giá', 8, 'view_coupon'),
(33, 'Can add Giỏ hàng', 9, 'add_cart'),
(34, 'Can change Giỏ hàng', 9, 'change_cart'),
(35, 'Can delete Giỏ hàng', 9, 'delete_cart'),
(36, 'Can view Giỏ hàng', 9, 'view_cart'),
(37, 'Can add Đơn hàng', 10, 'add_order'),
(38, 'Can change Đơn hàng', 10, 'change_order'),
(39, 'Can delete Đơn hàng', 10, 'delete_order'),
(40, 'Can view Đơn hàng', 10, 'view_order'),
(41, 'Can add Sản phẩm', 11, 'add_product'),
(42, 'Can change Sản phẩm', 11, 'change_product'),
(43, 'Can delete Sản phẩm', 11, 'delete_product'),
(44, 'Can view Sản phẩm', 11, 'view_product'),
(45, 'Can add Chi tiết đơn hàng', 12, 'add_orderitem'),
(46, 'Can change Chi tiết đơn hàng', 12, 'change_orderitem'),
(47, 'Can delete Chi tiết đơn hàng', 12, 'delete_orderitem'),
(48, 'Can view Chi tiết đơn hàng', 12, 'view_orderitem'),
(49, 'Can add Hình ảnh sản phẩm', 13, 'add_productimage'),
(50, 'Can change Hình ảnh sản phẩm', 13, 'change_productimage'),
(51, 'Can delete Hình ảnh sản phẩm', 13, 'delete_productimage'),
(52, 'Can view Hình ảnh sản phẩm', 13, 'view_productimage'),
(53, 'Can add Đánh giá', 14, 'add_review'),
(54, 'Can change Đánh giá', 14, 'change_review'),
(55, 'Can delete Đánh giá', 14, 'delete_review'),
(56, 'Can view Đánh giá', 14, 'view_review'),
(57, 'Can add Hồ sơ người dùng', 15, 'add_userprofile'),
(58, 'Can change Hồ sơ người dùng', 15, 'change_userprofile'),
(59, 'Can delete Hồ sơ người dùng', 15, 'delete_userprofile'),
(60, 'Can view Hồ sơ người dùng', 15, 'view_userprofile'),
(61, 'Can add Sản phẩm trong giỏ', 16, 'add_cartitem'),
(62, 'Can change Sản phẩm trong giỏ', 16, 'change_cartitem'),
(63, 'Can delete Sản phẩm trong giỏ', 16, 'delete_cartitem'),
(64, 'Can view Sản phẩm trong giỏ', 16, 'view_cartitem'),
(65, 'Can add Danh sách yêu thích', 17, 'add_wishlist'),
(66, 'Can change Danh sách yêu thích', 17, 'change_wishlist'),
(67, 'Can delete Danh sách yêu thích', 17, 'delete_wishlist'),
(68, 'Can view Danh sách yêu thích', 17, 'view_wishlist');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$eyyxmxS4uR9CX7DhmPMdJ9$HY6uFcLGQLisxWoO0PofEeaKfF6SI1pmQFcIGsCMcHE=', '2025-01-17 08:48:27.193522', 1, 'ad', 'Van', 'Hung', 'ad@123.com', 1, 1, '2025-01-16 07:17:54.568769');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_admin_log`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-01-16 07:18:28.183427', '1', 'testdm', 1, '[{\"added\": {}}]', 7, 1),
(2, '2025-01-16 07:18:56.637257', '1', 'testsp 2', 1, '[{\"added\": {}}]', 11, 1),
(3, '2025-01-16 07:27:37.938879', '1', 'test', 1, '[{\"added\": {}}]', 8, 1),
(4, '2025-01-16 07:30:29.957630', '1', 'test', 2, '[{\"changed\": {\"fields\": [\"Gi\\u00e1 tr\\u1ecb gi\\u1ea3m\"]}}]', 8, 1),
(5, '2025-01-16 12:32:26.055048', '1', 'test', 1, '[{\"added\": {}}]', 7, 1),
(6, '2025-01-16 12:32:52.399454', '2', 'test 1', 1, '[{\"added\": {}}]', 7, 1),
(7, '2025-01-16 12:33:46.015962', '1', 'testsp 1', 1, '[{\"added\": {}}]', 11, 1),
(8, '2025-01-16 12:34:18.437832', '2', 'testsp 2', 1, '[{\"added\": {}}]', 11, 1),
(9, '2025-01-16 13:33:27.563428', '1', 'test', 1, '[{\"added\": {}}]', 8, 1),
(10, '2025-01-16 13:35:29.067974', '2', 'test1', 1, '[{\"added\": {}}]', 8, 1),
(11, '2025-01-16 13:37:09.854809', '3', 'test3', 1, '[{\"added\": {}}]', 8, 1),
(12, '2025-01-16 13:53:14.110368', '2', 'Order ORD20250116133744', 2, '[{\"changed\": {\"fields\": [\"Payment status\"]}}]', 10, 1),
(13, '2025-01-16 13:53:14.113380', '1', 'Order ORD20250116132542', 2, '[{\"changed\": {\"fields\": [\"Payment status\"]}}]', 10, 1),
(14, '2025-01-16 13:55:28.421077', '2', 'Order ORD20250116133744', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 10, 1),
(15, '2025-01-16 14:02:24.982086', '2', 'Order ORD20250116133744', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 10, 1),
(16, '2025-01-16 14:02:24.983088', '1', 'Order ORD20250116132542', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 10, 1),
(17, '2025-01-16 14:02:37.898249', '2', 'Order ORD20250116133744', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 10, 1),
(18, '2025-01-16 14:04:28.675837', '2', 'Order ORD20250116133744', 2, '[{\"changed\": {\"fields\": [\"Payment status\"]}}]', 10, 1),
(19, '2025-01-16 14:04:28.676921', '1', 'Order ORD20250116132542', 2, '[{\"changed\": {\"fields\": [\"Payment status\"]}}]', 10, 1),
(20, '2025-01-16 14:05:08.317890', '1', 'Order ORD20250116132542', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 10, 1),
(21, '2025-01-16 16:00:40.688674', '1', 'test', 2, '[{\"changed\": {\"fields\": [\"H\\u00ecnh \\u1ea3nh\"]}}]', 7, 1),
(22, '2025-01-16 23:40:56.508005', '2', 'testsp 2', 2, '[{\"changed\": {\"fields\": [\"S\\u1ed1 l\\u01b0\\u1ee3ng\"]}}]', 11, 1),
(23, '2025-01-16 23:40:56.509672', '1', 'testsp 1', 2, '[{\"changed\": {\"fields\": [\"S\\u1ed1 l\\u01b0\\u1ee3ng\"]}}]', 11, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(9, 'home', 'cart'),
(16, 'home', 'cartitem'),
(7, 'home', 'category'),
(8, 'home', 'coupon'),
(10, 'home', 'order'),
(12, 'home', 'orderitem'),
(11, 'home', 'product'),
(13, 'home', 'productimage'),
(14, 'home', 'review'),
(15, 'home', 'userprofile'),
(17, 'home', 'wishlist'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-01-16 07:17:34.222720'),
(2, 'auth', '0001_initial', '2025-01-16 07:17:34.993804'),
(3, 'admin', '0001_initial', '2025-01-16 07:17:35.157276'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-01-16 07:17:35.165308'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-16 07:17:35.174538'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-01-16 07:17:35.251962'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-01-16 07:17:35.347827'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-01-16 07:17:35.364089'),
(9, 'auth', '0004_alter_user_username_opts', '2025-01-16 07:17:35.372092'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-01-16 07:17:35.432411'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-01-16 07:17:35.436154'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-01-16 07:17:35.444211'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-01-16 07:17:35.460178'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-01-16 07:17:35.477563'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-01-16 07:17:35.494197'),
(16, 'auth', '0011_update_proxy_permissions', '2025-01-16 07:17:35.503190'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-01-16 07:17:35.519190'),
(19, 'sessions', '0001_initial', '2025-01-16 07:17:37.298011'),
(22, 'home', '0001_initial', '2025-01-16 08:36:40.023898'),
(23, 'home', '0002_order_coupon_alter_order_payment_method_and_more', '2025-01-16 13:36:11.653240'),
(24, 'home', '0003_alter_review_options_remove_review_likes_and_more', '2025-01-16 14:17:48.112504'),
(25, 'home', '0004_alter_cart_options_alter_cartitem_options_and_more', '2025-01-16 16:10:50.002256');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('f6aeuuxcmts7tifzv669tdieuzyx9yl5', '.eJxVjDsOwjAQBe_iGln-RHaWkp4zWLveNQ4gR4qTCnF3iJQC2jcz76USbmtNW5clTazOyqrT70aYH9J2wHdst1nnua3LRHpX9EG7vs4sz8vh_h1U7PVbix2c9w45l4BRAKkwW0GJQyYDI1gsAiYASinBgaccgvERaHQkDOr9ARKWOQE:1tYbRM:DKZdcdjZ05P8mqX3jpLVYmryXjgPEV3vXGa9S9AjFew', '2025-01-31 08:46:28.999107'),
('ocf1fe4t0fapcr6t4tbitrimkestrwqq', '.eJxVjDsOwjAQBe_iGln-RHaWkp4zWLveNQ4gR4qTCnF3iJQC2jcz76USbmtNW5clTazOyqrT70aYH9J2wHdst1nnua3LRHpX9EG7vs4sz8vh_h1U7PVbix2c9w45l4BRAKkwW0GJQyYDI1gsAiYASinBgaccgvERaHQkDOr9ARKWOQE:1tYbd1:q0WFI6rIp6NXHiSSPl0eUPBBlgPlRHOj91HDlyzfqjI', '2025-01-31 08:58:31.647518');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_cart`
--

CREATE TABLE `home_cart` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_cart`
--

INSERT INTO `home_cart` (`id`, `created_at`, `updated_at`, `user_id`) VALUES
(1, '2025-01-16 12:56:14.361230', '2025-01-16 12:56:14.361230', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_cartitem`
--

CREATE TABLE `home_cartitem` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `cart_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_cartitem`
--

INSERT INTO `home_cartitem` (`id`, `quantity`, `created_at`, `updated_at`, `cart_id`, `product_id`) VALUES
(13, 1, '2025-01-17 09:02:29.943423', '2025-01-17 09:02:29.943423', 1, 2),
(14, 1, '2025-01-17 09:02:30.897269', '2025-01-17 09:02:30.897269', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_category`
--

CREATE TABLE `home_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_category`
--

INSERT INTO `home_category` (`id`, `name`, `description`, `image`, `created_at`, `updated_at`, `slug`, `is_active`) VALUES
(1, 'test', '', 'categories/bgthuy.png', '2025-01-16 12:32:26.054082', '2025-01-16 16:00:40.685677', 'test', 1),
(2, 'test 1', '', '', '2025-01-16 12:32:52.398482', '2025-01-16 12:32:52.398482', 'test-1', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_coupon`
--

CREATE TABLE `home_coupon` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `valid_from` datetime(6) NOT NULL,
  `valid_to` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `minimum_amount` decimal(10,2) NOT NULL,
  `usage_limit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_coupon`
--

INSERT INTO `home_coupon` (`id`, `code`, `discount`, `valid_from`, `valid_to`, `active`, `minimum_amount`, `usage_limit`) VALUES
(1, 'test', 10000.00, '2025-01-16 13:33:03.000000', '2025-01-21 17:00:00.000000', 1, 50000.00, 10),
(2, 'test1', 10000.00, '2025-01-16 13:33:03.000000', '2025-01-21 17:00:00.000000', 1, 10000.00, 10),
(3, 'test3', 1000.00, '2025-01-16 13:37:05.000000', '2025-01-30 13:37:06.000000', 1, 500000.00, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_order`
--

CREATE TABLE `home_order` (
  `id` bigint(20) NOT NULL,
  `order_number` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `province_code` varchar(10) NOT NULL,
  `district_code` varchar(10) NOT NULL,
  `ward_code` varchar(10) NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `note` longtext NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `coupon_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_order`
--

INSERT INTO `home_order` (`id`, `order_number`, `full_name`, `phone`, `address`, `province_code`, `district_code`, `ward_code`, `payment_method`, `note`, `subtotal`, `discount`, `total_amount`, `status`, `payment_status`, `created_at`, `updated_at`, `user_id`, `coupon_id`) VALUES
(1, 'ORD20250116132542', 'Van Hung', '0323456789', '3, Phường Phong Châu, Thị xã Phú Thọ, Tỉnh Phú Thọ', '25', '228', '7945', 'cod', '123', 300000.00, 0.00, 300000.00, 'completed', 'pending', '2025-01-16 13:25:42.542382', '2025-01-16 14:05:08.316892', 1, NULL),
(2, 'ORD20250116133744', 'Van Hung', '0323456789', '3, Xã Vạn Ninh, Thành phố Móng Cái, Tỉnh Quảng Ninh', '22', '194', '6748', 'bank', '', 200000.00, 10000.00, 190000.00, 'cancelled', 'refunded', '2025-01-16 13:37:44.426623', '2025-01-16 14:04:28.674837', 1, 1),
(3, 'ORD20250116231850', 'Van Hung', '0323456789', '3, Xã Sông Lô, Thành phố Việt Trì, Tỉnh Phú Thọ', '25', '227', '7936', 'bank', '', 800000.00, 0.00, 800000.00, 'pending', 'pending', '2025-01-16 23:18:50.386061', '2025-01-16 23:18:50.386061', 1, NULL),
(4, 'ORD20250117080306', 'Van Hung', '1234567890', '3 , Xã Bình Yên, Huyện Định Hóa, Tỉnh Thái Nguyên', '19', '167', '5587', 'cod', 'tss', 100000.00, 0.00, 100000.00, 'pending', 'pending', '2025-01-17 08:03:06.935776', '2025-01-17 08:03:06.935776', 1, NULL),
(5, 'ORD20250117085831', 'Van Hung', '1234567890', '3, Xã Lương Thông, Huyện Hà Quảng, Tỉnh Cao Bằng', '4', '45', '1372', 'momo', '', 700000.00, 10000.00, 690000.00, 'pending', 'pending', '2025-01-17 08:58:31.605325', '2025-01-17 08:58:31.617438', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_orderitem`
--

CREATE TABLE `home_orderitem` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `price` decimal(10,2) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_orderitem`
--

INSERT INTO `home_orderitem` (`id`, `quantity`, `price`, `order_id`, `product_id`) VALUES
(1, 1, 100000.00, 1, 2),
(2, 2, 100000.00, 1, 1),
(3, 2, 100000.00, 2, 2),
(4, 7, 100000.00, 3, 2),
(5, 1, 100000.00, 3, 1),
(6, 1, 100000.00, 4, 2),
(7, 4, 100000.00, 5, 1),
(8, 3, 100000.00, 5, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_product`
--

CREATE TABLE `home_product` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `old_price` decimal(10,2) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `featured` tinyint(1) NOT NULL,
  `views` int(11) NOT NULL,
  `sold` int(11) NOT NULL,
  `specifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`specifications`)),
  `category_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_product`
--

INSERT INTO `home_product` (`id`, `name`, `slug`, `description`, `price`, `old_price`, `image`, `stock`, `is_available`, `created_at`, `updated_at`, `featured`, `views`, `sold`, `specifications`, `category_id`) VALUES
(1, 'testsp 1', 'testsp-1', '123', 100000.00, 120000.00, 'products/3_jnhRh5T.jpeg', 3, 1, '2025-01-16 12:33:46.014941', '2025-01-17 08:58:31.625461', 0, 0, 7, NULL, 1),
(2, 'testsp 2', 'testsp-2', '123', 100000.00, 120000.00, 'products/blog2.jpg', 6, 1, '2025-01-16 12:34:18.436833', '2025-01-17 08:58:31.638321', 0, 0, 14, NULL, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_productimage`
--

CREATE TABLE `home_productimage` (
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_review`
--

CREATE TABLE `home_review` (
  `id` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  `images` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_review`
--

INSERT INTO `home_review` (`id`, `rating`, `comment`, `images`, `created_at`, `updated_at`, `product_id`, `user_id`) VALUES
(1, 3, 'good', '', '2025-01-16 14:18:05.131747', '2025-01-16 14:18:05.131747', 2, 1),
(2, 3, 'good', '', '2025-01-16 14:18:52.446657', '2025-01-16 14:18:52.446657', 2, 1),
(3, 2, '333', '', '2025-01-16 14:40:06.125263', '2025-01-16 14:40:06.125263', 2, 1),
(4, 2, 'test', '', '2025-01-16 14:41:19.789726', '2025-01-16 14:41:19.789726', 2, 1),
(5, 2, 'tế', '', '2025-01-16 14:43:14.976781', '2025-01-16 14:43:14.976781', 2, 1),
(6, 1, '22', 'reviews/food-banner2.jpg', '2025-01-16 14:45:03.012944', '2025-01-16 14:45:03.012944', 2, 1),
(7, 1, '333333333333333', 'reviews/blog3.jpg', '2025-01-16 14:46:24.079491', '2025-01-16 14:46:24.079491', 2, 1),
(8, 5, '333333333333333333', '', '2025-01-16 14:48:57.817754', '2025-01-16 14:48:57.817754', 2, 1),
(9, 5, '222222222222222', '', '2025-01-16 14:50:36.402555', '2025-01-16 14:50:36.402555', 2, 1),
(10, 5, '1', '', '2025-01-16 14:50:58.175308', '2025-01-16 14:50:58.175308', 2, 1),
(11, 5, '5', '', '2025-01-16 14:53:09.946796', '2025-01-16 14:53:09.946796', 2, 1),
(12, 5, '5', '', '2025-01-16 14:53:32.628206', '2025-01-16 14:53:32.628206', 2, 1),
(13, 5, 'tss', '', '2025-01-16 14:56:07.412879', '2025-01-16 14:56:07.412879', 2, 1),
(14, 5, '123', '', '2025-01-16 14:57:50.687606', '2025-01-16 14:57:50.687606', 2, 1),
(15, 5, 'ts', '', '2025-01-16 14:59:31.917964', '2025-01-16 14:59:31.917964', 2, 1),
(16, 5, '11', '', '2025-01-16 15:02:18.466216', '2025-01-16 15:02:18.466216', 2, 1),
(17, 5, '3', '', '2025-01-16 15:05:06.994934', '2025-01-16 15:05:06.994934', 2, 1),
(18, 5, '3333', '', '2025-01-16 15:05:24.955693', '2025-01-16 15:05:24.955693', 2, 1),
(19, 5, 't', '', '2025-01-16 15:12:02.767372', '2025-01-16 15:12:02.767372', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_userprofile`
--

CREATE TABLE `home_userprofile` (
  `id` bigint(20) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address_detail` varchar(255) DEFAULT NULL,
  `province_code` varchar(10) DEFAULT NULL,
  `district_code` varchar(10) DEFAULT NULL,
  `ward_code` varchar(10) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `newsletter` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_userprofile`
--

INSERT INTO `home_userprofile` (`id`, `phone`, `address_detail`, `province_code`, `district_code`, `ward_code`, `avatar`, `birth_date`, `gender`, `newsletter`, `user_id`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_wishlist`
--

CREATE TABLE `home_wishlist` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_wishlist`
--

INSERT INTO `home_wishlist` (`id`, `created_at`, `product_id`, `user_id`) VALUES
(14, '2025-01-17 08:38:39.503428', 1, 1),
(15, '2025-01-17 08:38:41.644167', 2, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Chỉ mục cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Chỉ mục cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Chỉ mục cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Chỉ mục cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Chỉ mục cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Chỉ mục cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Chỉ mục cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Chỉ mục cho bảng `home_cart`
--
ALTER TABLE `home_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_cart_user_id_5795e126` (`user_id`);

--
-- Chỉ mục cho bảng `home_cartitem`
--
ALTER TABLE `home_cartitem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `home_cartitem_cart_id_product_id_b40d4476_uniq` (`cart_id`,`product_id`),
  ADD KEY `home_cartitem_product_id_27161cd2_fk_home_product_id` (`product_id`);

--
-- Chỉ mục cho bảng `home_category`
--
ALTER TABLE `home_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Chỉ mục cho bảng `home_coupon`
--
ALTER TABLE `home_coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `home_order`
--
ALTER TABLE `home_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `home_order_user_id_a9204bb2_fk_auth_user_id` (`user_id`),
  ADD KEY `home_order_coupon_id_00f2cf67_fk_home_coupon_id` (`coupon_id`);

--
-- Chỉ mục cho bảng `home_orderitem`
--
ALTER TABLE `home_orderitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_orderitem_order_id_5eff5bc6_fk_home_order_id` (`order_id`),
  ADD KEY `home_orderitem_product_id_06f08645_fk_home_product_id` (`product_id`);

--
-- Chỉ mục cho bảng `home_product`
--
ALTER TABLE `home_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `home_product_category_id_0dc673e8_fk_home_category_id` (`category_id`);

--
-- Chỉ mục cho bảng `home_productimage`
--
ALTER TABLE `home_productimage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_productimage_product_id_a8b70db4_fk_home_product_id` (`product_id`);

--
-- Chỉ mục cho bảng `home_review`
--
ALTER TABLE `home_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_review_product_id_0233ae3c_fk_home_product_id` (`product_id`),
  ADD KEY `home_review_user_id_e328ce0b_fk_auth_user_id` (`user_id`);

--
-- Chỉ mục cho bảng `home_userprofile`
--
ALTER TABLE `home_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `home_wishlist`
--
ALTER TABLE `home_wishlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `home_wishlist_user_id_product_id_09055606_uniq` (`user_id`,`product_id`),
  ADD KEY `home_wishlist_product_id_ebdbbde4_fk_home_product_id` (`product_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `home_cart`
--
ALTER TABLE `home_cart`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `home_cartitem`
--
ALTER TABLE `home_cartitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `home_category`
--
ALTER TABLE `home_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `home_coupon`
--
ALTER TABLE `home_coupon`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `home_order`
--
ALTER TABLE `home_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `home_orderitem`
--
ALTER TABLE `home_orderitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `home_product`
--
ALTER TABLE `home_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `home_productimage`
--
ALTER TABLE `home_productimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `home_review`
--
ALTER TABLE `home_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `home_userprofile`
--
ALTER TABLE `home_userprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `home_wishlist`
--
ALTER TABLE `home_wishlist`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Các ràng buộc cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Các ràng buộc cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `home_cart`
--
ALTER TABLE `home_cart`
  ADD CONSTRAINT `home_cart_user_id_5795e126_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `home_cartitem`
--
ALTER TABLE `home_cartitem`
  ADD CONSTRAINT `home_cartitem_cart_id_64f2d7e8_fk_home_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `home_cart` (`id`),
  ADD CONSTRAINT `home_cartitem_product_id_27161cd2_fk_home_product_id` FOREIGN KEY (`product_id`) REFERENCES `home_product` (`id`);

--
-- Các ràng buộc cho bảng `home_order`
--
ALTER TABLE `home_order`
  ADD CONSTRAINT `home_order_coupon_id_00f2cf67_fk_home_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `home_coupon` (`id`),
  ADD CONSTRAINT `home_order_user_id_a9204bb2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `home_orderitem`
--
ALTER TABLE `home_orderitem`
  ADD CONSTRAINT `home_orderitem_order_id_5eff5bc6_fk_home_order_id` FOREIGN KEY (`order_id`) REFERENCES `home_order` (`id`),
  ADD CONSTRAINT `home_orderitem_product_id_06f08645_fk_home_product_id` FOREIGN KEY (`product_id`) REFERENCES `home_product` (`id`);

--
-- Các ràng buộc cho bảng `home_product`
--
ALTER TABLE `home_product`
  ADD CONSTRAINT `home_product_category_id_0dc673e8_fk_home_category_id` FOREIGN KEY (`category_id`) REFERENCES `home_category` (`id`);

--
-- Các ràng buộc cho bảng `home_productimage`
--
ALTER TABLE `home_productimage`
  ADD CONSTRAINT `home_productimage_product_id_a8b70db4_fk_home_product_id` FOREIGN KEY (`product_id`) REFERENCES `home_product` (`id`);

--
-- Các ràng buộc cho bảng `home_review`
--
ALTER TABLE `home_review`
  ADD CONSTRAINT `home_review_product_id_0233ae3c_fk_home_product_id` FOREIGN KEY (`product_id`) REFERENCES `home_product` (`id`),
  ADD CONSTRAINT `home_review_user_id_e328ce0b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `home_userprofile`
--
ALTER TABLE `home_userprofile`
  ADD CONSTRAINT `home_userprofile_user_id_d1f7b466_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `home_wishlist`
--
ALTER TABLE `home_wishlist`
  ADD CONSTRAINT `home_wishlist_product_id_ebdbbde4_fk_home_product_id` FOREIGN KEY (`product_id`) REFERENCES `home_product` (`id`),
  ADD CONSTRAINT `home_wishlist_user_id_db9d2fa8_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

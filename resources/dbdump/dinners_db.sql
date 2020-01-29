-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Янв 29 2020 г., 10:43
-- Версия сервера: 5.7.25
-- Версия PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `dinners_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `absences`
--

CREATE TABLE `absences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `reason_id` bigint(20) UNSIGNED NOT NULL,
  `massage` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `from` date NOT NULL,
  `to` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `absences`
--

INSERT INTO `absences` (`id`, `user_id`, `reason_id`, `massage`, `from`, `to`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '545456', '2019-05-14', NULL, '2019-05-14 12:14:20', '2019-05-14 12:14:20'),
(2, 7, 1, 'мне хана', '2019-05-15', NULL, '2019-05-15 04:50:39', '2019-05-15 04:50:39'),
(3, 15, 1, 'Как-то так', '2019-05-14', NULL, '2019-05-16 05:00:21', '2019-05-16 05:00:21'),
(4, 15, 1, '<script>alert(\'message\')</script>', '2019-05-16', NULL, '2019-05-16 05:05:16', '2019-05-16 05:05:16'),
(5, 5, 1, 'пиварвп', '2019-05-16', NULL, '2019-05-16 09:52:28', '2019-05-16 09:52:28'),
(6, 3, 1, 'dsadasdasd', '2019-05-16', NULL, '2019-05-16 11:26:44', '2019-05-16 11:26:44'),
(7, 2, 1, 'Заболел', '2019-05-16', NULL, '2019-05-16 11:52:47', '2019-05-16 11:52:47'),
(8, 5, 1, 'слово', '2019-05-16', NULL, '2019-05-16 12:15:35', '2019-05-16 12:15:35'),
(9, 5, 1, 'ппппавв', '2019-05-16', '2019-05-22', '2019-05-16 12:16:12', '2019-05-16 12:16:12'),
(10, 2, 1, 'Тытвтчттч', '2019-05-17', NULL, '2019-05-17 12:52:54', '2019-05-17 12:52:54'),
(11, 7, 1, 'asdadadad', '2019-05-17', NULL, '2019-05-17 18:13:15', '2019-05-17 18:13:15'),
(12, 7, 1, 'asdadd', '2019-04-30', NULL, '2019-05-17 18:13:23', '2019-05-17 18:13:23'),
(13, 7, 1, 'sdasdd', '2019-05-18', NULL, '2019-05-18 19:30:21', '2019-05-18 19:30:21'),
(14, 5, 1, 'ооь', '2019-05-21', NULL, '2019-05-21 19:28:25', '2019-05-21 19:28:25'),
(15, 5, 1, 'vvc', '2019-05-22', NULL, '2019-05-22 19:06:24', '2019-05-22 19:06:24'),
(16, 5, 1, 'посещение врача', '2019-05-22', NULL, '2019-05-22 19:06:51', '2019-05-22 19:06:51'),
(17, 3, 1, 'dsadfdsfds', '2019-05-23', NULL, '2019-05-23 08:29:59', '2019-05-23 08:29:59'),
(18, 3, 1, 'dasdsa', '2019-05-23', '2019-05-24', '2019-05-23 08:30:12', '2019-05-23 08:30:12'),
(19, 3, 1, ',5646', '2019-05-23', NULL, '2019-05-23 08:30:23', '2019-05-23 08:30:23'),
(21, 5, 1, 'hyfvhvyh', '2019-05-24', NULL, '2019-05-24 08:54:04', '2019-05-24 08:54:04'),
(23, 3, 7, 'fdgdfg', '2019-05-26', NULL, '2019-05-26 05:05:02', '2019-05-26 05:05:02'),
(24, 5, 1, 'hfyhcvgh', '2019-05-27', NULL, '2019-05-27 09:31:17', '2019-05-27 09:31:17'),
(25, 5, 1, 'Отсутствую, потому что я так хочу', '2019-05-28', '2019-05-28', '2019-05-28 03:19:15', '2019-05-28 03:19:15'),
(26, 5, 1, 'отсутствую', '2019-05-29', '2019-05-28', '2019-05-28 03:20:04', '2019-05-28 03:20:04'),
(27, 5, 1, 'отсутств', '2019-05-30', NULL, '2019-05-28 03:20:16', '2019-05-28 03:20:16'),
(28, 5, 1, 'nifdhguidsfbguois', '2019-05-31', '2019-05-28', '2019-05-28 03:24:20', '2019-05-28 03:24:20'),
(29, 5, 1, 'отсутствую', '2019-06-01', NULL, '2019-05-28 03:27:32', '2019-05-28 03:27:32'),
(30, 5, 1, 'ygyg', '2019-06-21', NULL, '2019-05-30 04:52:23', '2019-05-30 04:52:23'),
(31, 5, 1, 'hyhyuh', '2019-07-01', '2019-06-04', '2019-05-30 04:54:42', '2019-05-30 04:54:42'),
(32, 5, 1, 'Fygdgb', '2019-07-03', NULL, '2019-05-30 11:05:49', '2019-05-30 11:05:49'),
(33, 4, 1, 'lll', '2019-05-30', NULL, '2019-05-30 17:17:12', '2019-05-30 17:17:12'),
(35, 4, 1, 'фффффффффффф', '2019-05-31', NULL, '2019-05-31 11:13:44', '2019-05-31 11:13:44'),
(36, 4, 1, 'пророро', '2019-06-28', NULL, '2019-05-31 11:14:09', '2019-05-31 11:14:09'),
(37, 4, 1, 'ооооооооооооооо', '2019-07-01', '2019-05-31', '2019-05-31 11:16:09', '2019-05-31 11:16:09'),
(38, 4, 1, 'оооооооооо', '2019-07-02', '2019-07-04', '2019-05-31 11:17:45', '2019-05-31 11:17:45'),
(39, 4, 1, 'жжжжжжжжжжжжжж', '2019-07-10', NULL, '2019-05-31 11:18:05', '2019-05-31 11:18:05'),
(40, 4, 1, 'рпрррр', '2019-07-31', NULL, '2019-05-31 11:18:48', '2019-05-31 11:18:48'),
(41, 4, 1, 'оооо', '2019-08-01', NULL, '2019-05-31 11:19:15', '2019-05-31 11:19:15'),
(42, 7, 2, 'ррррррррррр', '2019-05-03', NULL, '2019-05-31 11:32:40', '2019-05-31 11:32:40'),
(43, 7, 1, 'ррррррррр', '2019-05-05', '2019-05-08', '2019-05-31 11:32:56', '2019-05-31 11:35:44'),
(44, 3, 3, 'тьспрср', '2019-06-03', '2019-06-21', '2019-06-01 16:23:58', '2019-06-01 16:24:13'),
(45, 2, 1, 'sdfdsfsdfds', '2019-06-02', NULL, '2019-06-02 10:47:38', '2019-06-02 10:47:38'),
(46, 2, 1, 'fdfsfds', '2019-06-03', NULL, '2019-06-03 02:47:41', '2019-06-03 02:47:41'),
(47, 6, 3, 'ваып', '2019-06-04', NULL, '2019-06-03 05:28:40', '2019-06-03 05:28:40'),
(48, 1, 2, 'гпг', '2019-06-01', NULL, '2019-06-03 08:00:50', '2019-06-03 08:00:50'),
(49, 1, 2, 'гпг', '2019-06-01', NULL, '2019-06-03 08:00:51', '2019-06-03 08:00:51'),
(50, 1, 1, 'гпгпг', '2019-06-07', NULL, '2019-06-03 08:01:01', '2019-06-03 08:01:01');

-- --------------------------------------------------------

--
-- Структура таблицы `days_for_dishes`
--

CREATE TABLE `days_for_dishes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day_number` int(11) UNSIGNED NOT NULL,
  `dish_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `days_for_dishes`
--

INSERT INTO `days_for_dishes` (`id`, `name`, `day_number`, `dish_id`, `created_at`, `updated_at`) VALUES
(2, 'понедельник', 1, 2, '2019-05-01 21:00:00', NULL),
(3, 'вторник', 2, 3, '2019-05-01 21:00:00', NULL),
(4, 'вторник', 2, 4, '2019-05-01 21:00:00', NULL),
(5, 'среда', 3, 5, '2019-05-01 21:00:00', NULL),
(6, 'среда', 3, 3, '2019-05-01 21:00:00', NULL),
(7, 'четверг', 4, 6, '2019-05-01 21:00:00', NULL),
(8, 'четверг', 4, 7, '2019-05-01 21:00:00', NULL),
(9, 'пятница', 5, 4, '2019-05-01 21:00:00', NULL),
(10, 'пятница', 5, 8, '2019-05-01 21:00:00', NULL),
(11, 'понедельник', 1, 9, NULL, NULL),
(12, 'понедельник', 1, 10, NULL, NULL),
(13, 'понедельник', 1, 11, NULL, NULL),
(21, 'вторник', 2, 11, NULL, NULL),
(22, 'вторник', 2, 12, NULL, NULL),
(23, 'вторник', 2, 13, NULL, NULL),
(24, 'вторник', 2, 14, NULL, NULL),
(25, 'среда', 3, 15, NULL, NULL),
(26, 'среда', 3, 16, NULL, NULL),
(27, 'среда', 3, 10, NULL, NULL),
(28, 'четверг', 4, 10, NULL, NULL),
(29, 'четверг', 4, 9, NULL, NULL),
(30, 'четверг', 4, 17, NULL, NULL),
(31, 'пятница', 5, 10, NULL, NULL),
(32, 'пятница', 5, 14, NULL, NULL),
(33, 'пятница', 5, 12, NULL, NULL),
(34, 'понедельник', 1, 18, NULL, NULL),
(35, 'понедельник', 1, 19, NULL, NULL),
(36, 'вторник', 2, 20, NULL, NULL),
(37, 'вторник', 2, 21, NULL, NULL),
(38, 'среда', 3, 19, NULL, NULL),
(39, 'среда', 3, 24, NULL, NULL),
(40, 'среда', 3, 25, NULL, NULL),
(41, 'среда', 3, 26, NULL, NULL),
(42, 'четверг', 4, 27, NULL, NULL),
(43, 'четверг', 4, 28, NULL, NULL),
(44, 'четверг', 4, 29, NULL, NULL),
(45, 'пятница', 5, 32, NULL, NULL),
(46, 'пятница', 5, 18, NULL, NULL),
(47, 'пятница', 5, 33, NULL, NULL),
(48, 'понедельник', 1, 34, NULL, NULL),
(49, 'понедельник', 1, 35, NULL, NULL),
(50, 'понедельник', 1, 36, NULL, NULL),
(51, 'вторник', 2, 37, NULL, NULL),
(52, 'вторник', 2, 38, NULL, NULL),
(53, 'среда', 3, 39, NULL, NULL),
(54, 'среда', 3, 40, NULL, NULL),
(55, 'четверг', 4, 34, NULL, NULL),
(56, 'четверг', 4, 41, NULL, NULL),
(57, 'пятница', 5, 48, NULL, NULL),
(58, 'пятница', 5, 49, NULL, NULL),
(59, 'понедельник', 1, 50, NULL, NULL),
(60, 'вторник', 2, 51, NULL, NULL),
(61, 'среда', 3, 52, NULL, NULL),
(74, 'четверг', 4, 53, '2019-05-16 09:26:45', '2019-05-16 09:26:45'),
(75, 'пятница', 5, 57, '2019-05-16 09:26:45', '2019-05-16 09:26:45'),
(84, 'вторник', 2, 1, '2019-05-22 18:52:29', '2019-05-22 18:52:29'),
(87, 'вторник', 2, 65, '2019-05-28 04:41:23', '2019-05-28 04:41:23'),
(91, 'понедельник', 1, 1, '2019-06-01 14:15:21', '2019-06-01 14:15:21');

-- --------------------------------------------------------

--
-- Структура таблицы `dishes`
--

CREATE TABLE `dishes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `composition` text COLLATE utf8mb4_unicode_ci,
  `calories` int(11) UNSIGNED DEFAULT NULL,
  `weight` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `type_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `dishes`
--

INSERT INTO `dishes` (`id`, `name`, `composition`, `calories`, `weight`, `price`, `type_id`, `created_at`, `updated_at`) VALUES
(1, 'Бульон с яйцом', 'Описание блюда', NULL, '300 г', 29.00, 1, NULL, '2019-05-16 12:36:34'),
(2, 'Борщ постный с фасолью', NULL, NULL, '300 г', 16.75, 1, NULL, NULL),
(3, 'Суп с лапшой', NULL, NULL, '300 г', 15.25, 1, NULL, NULL),
(4, 'Суп гороховый', NULL, NULL, '300 г', 17.50, 1, NULL, NULL),
(5, 'Суп овощной', NULL, NULL, '300 г', 15.25, 1, NULL, NULL),
(6, 'Суп с грибами', NULL, NULL, '300 г', 21.00, 1, NULL, NULL),
(7, 'Суп с фрикадельками', NULL, NULL, '300 г', 18.75, 1, NULL, NULL),
(8, 'Окрошка с ветчиной', NULL, NULL, '300 г', 34.50, 1, NULL, NULL),
(9, 'Каша гречневая', NULL, NULL, '150 г', 6.53, 2, NULL, NULL),
(10, 'Картофельное пюре', NULL, NULL, '200 г', 12.00, 2, NULL, NULL),
(11, 'Макароны отварные', NULL, NULL, '150 г', 6.00, 2, NULL, NULL),
(12, 'Картофель с чесноком', NULL, NULL, '200 г', 10.50, 2, NULL, NULL),
(13, 'Рис с овощами', NULL, NULL, '150 г', 23.63, 2, NULL, NULL),
(14, 'Булгур', NULL, NULL, '200 г', 7.00, 2, NULL, NULL),
(15, 'Рис отварной', NULL, NULL, '150 г', 6.75, 2, NULL, NULL),
(16, 'Картофель тушенный', NULL, NULL, '200 г', 13.00, 2, NULL, NULL),
(17, 'Фасоль стручковая', NULL, NULL, '200 г', 32.50, 2, NULL, NULL),
(18, 'Гуляш куриный', NULL, NULL, '100 г', 29.50, 3, NULL, NULL),
(19, 'Паровая котлета', NULL, NULL, '1 шт.', 19.50, 3, NULL, NULL),
(20, 'Зраза куриная с яйцом', NULL, NULL, '1 шт.', 21.75, 3, NULL, NULL),
(21, 'Отбивная куриная', NULL, NULL, '1 шт.', 24.00, 3, NULL, NULL),
(24, 'Колбаски в томате', NULL, NULL, '100 г', 21.75, 3, NULL, NULL),
(25, 'Рыба по Монастырски', NULL, NULL, '150 г', 29.50, 3, NULL, NULL),
(26, 'Куриное филе с ананасом', NULL, NULL, '1 шт.', 33.50, 3, NULL, NULL),
(27, 'Котлета куриная', NULL, NULL, '1 шт.', 19.00, 3, NULL, NULL),
(28, 'Котлета по-домашнему', NULL, NULL, '100 г', 23.00, 3, NULL, NULL),
(29, 'Сардели отварные', NULL, NULL, '150 г', 26.25, 3, NULL, NULL),
(32, 'Биточки рыбные', NULL, NULL, '100 г', 31.50, 3, NULL, NULL),
(33, 'Котлета по-киевски', NULL, NULL, '1 шт.', 33.00, 3, NULL, NULL),
(34, 'Салат капуста и огурец', NULL, NULL, '100 г', 7.00, 4, NULL, NULL),
(35, 'Сельдь с луком', NULL, NULL, '100 г', 14.50, 4, NULL, NULL),
(36, 'Огурцы по-грузински', NULL, NULL, '100 г', 7.50, 4, NULL, NULL),
(37, 'Салат по-домашнему', NULL, NULL, '100 г', 18.75, 4, NULL, NULL),
(38, 'Икра свекольная', NULL, NULL, '150 г', 9.38, 4, NULL, NULL),
(39, 'Салат Мимоза', NULL, NULL, '100 г', 15.25, 4, NULL, NULL),
(40, 'Винегрет', NULL, NULL, '100 г', 6.60, 4, NULL, NULL),
(41, 'Сельдь под шубой', NULL, NULL, '150 г', 18.75, 4, NULL, NULL),
(48, 'Салат Столичный', NULL, NULL, '100 г', 15.75, 4, NULL, NULL),
(49, 'Салат Лидия', NULL, NULL, '150 г', 14.63, 4, NULL, NULL),
(50, 'Пирожок с повидлом', NULL, NULL, NULL, 8.00, 5, NULL, NULL),
(51, 'Шарики-пончики', NULL, NULL, NULL, 11.00, 5, NULL, NULL),
(52, 'Кекс с изюмом и курагой', NULL, NULL, NULL, 8.00, 5, NULL, NULL),
(53, 'Рожок с яблоком и корицей', 'Яблоко, корица, тесто', NULL, '1 шт', 10.00, 5, NULL, '2019-05-16 08:10:22'),
(57, 'Кекс с шоколадом', 'Дрожжевое тесто, сахар, шоколад', NULL, '1 шт', 9.00, 5, '2019-05-15 09:14:36', '2019-05-16 09:00:13'),
(65, 'Бульон', 'Описание', 1000, '300', 99.99, 1, '2019-05-28 04:40:52', '2019-05-28 05:19:37');

-- --------------------------------------------------------

--
-- Структура таблицы `dishes_to_requirements`
--

CREATE TABLE `dishes_to_requirements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dish_id` bigint(20) UNSIGNED NOT NULL,
  `requirement_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `dishes_to_requirements`
--

INSERT INTO `dishes_to_requirements` (`id`, `dish_id`, `requirement_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 4, NULL, NULL),
(3, 2, 1, NULL, NULL),
(4, 2, 4, NULL, NULL),
(5, 3, 1, NULL, NULL),
(6, 3, 4, NULL, NULL),
(7, 4, 1, NULL, NULL),
(8, 4, 4, NULL, NULL),
(9, 5, 1, NULL, NULL),
(10, 5, 4, NULL, NULL),
(11, 6, 1, NULL, NULL),
(12, 6, 4, NULL, NULL),
(13, 7, 1, NULL, NULL),
(14, 7, 4, NULL, NULL),
(15, 8, 1, NULL, NULL),
(16, 8, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `dishes_types`
--

CREATE TABLE `dishes_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_link` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'имя картинки типа блюда',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `dishes_types`
--

INSERT INTO `dishes_types` (`id`, `name`, `image_link`, `created_at`, `updated_at`) VALUES
(1, 'первое', 'soup.svg', NULL, NULL),
(2, 'гарнир', 'porridge.svg', NULL, NULL),
(3, 'мясо', 'chicken.svg', NULL, NULL),
(4, 'салат', 'saladbowl.svg', NULL, NULL),
(5, 'выпечка', 'backery.svg', NULL, '2019-05-28 09:38:21');

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_04_29_102612_foods_table', 1),
(4, '2019_05_01_111812_create_reasons_table', 2),
(5, '2019_05_01_111318_create_absences_table', 3),
(6, '2019_05_01_112317_create_orders_table', 4),
(7, '2019_05_01_112737_create_requirements_table', 5),
(8, '2019_05_01_113021_create_dishes_table', 6),
(9, '2019_05_01_113410_create_orders_to_dishes_table', 7),
(10, '2019_05_02_105559_create_dishes_table', 8),
(11, '2019_05_02_165208_days_for_dishes_table', 9),
(12, '2019_05_04_070704_create_absences_table', 10),
(13, '2019_05_12_091225_create_absences_table', 11),
(14, '2019_05_06_085556_create_dishes_table', 12),
(15, '2019_05_06_085619_create_requirements_table', 12),
(16, '2019_05_06_092457_create_dishes_to_types_table', 13),
(17, '2019_05_06_092457_create_dishes_types_table', 14),
(18, '2019_05_06_093149_create_dishes_types_table', 15),
(19, '2019_05_06_093632_create_dishes_table', 16),
(20, '2019_05_06_094545_create_dishes_to_requirements_table', 17);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `orders_to_dishes`
--

CREATE TABLE `orders_to_dishes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `dish_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `orders_to_requirements`
--

CREATE TABLE `orders_to_requirements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `requirement_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `reasons`
--

CREATE TABLE `reasons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `shortName` varchar(2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `reasons`
--

INSERT INTO `reasons` (`id`, `name`, `shortName`, `created_at`, `updated_at`) VALUES
(1, 'Неуважительная', 'н', '2019-05-24 12:49:03', NULL),
(2, 'Болезнь', 'б', '2019-05-24 12:49:03', NULL),
(3, 'Посещение врача', 'в', '2019-05-24 12:49:16', NULL),
(4, 'Медосмотр', 'м', '2019-05-24 12:49:16', NULL),
(5, 'Болезнь ребенка', 'р', '2019-05-24 12:49:29', NULL),
(6, 'Неожиданная поломка', 'нп', '2019-05-24 12:49:29', NULL),
(7, 'Погодные условия', 'п', '2019-05-24 12:49:40', NULL),
(8, 'Неисправность транспорта', 'т', '2019-05-24 12:49:40', NULL),
(9, 'По семейным обстоятельствам', 'с', '2019-05-24 12:49:46', NULL),
(10, 'В счёт переработки', 'пр', '2019-05-25 12:46:38', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `requirements`
--

CREATE TABLE `requirements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `requirements`
--

INSERT INTO `requirements` (`id`, `name`, `price`, `created_at`, `updated_at`) VALUES
(1, 'Банка под первое блюдо', 3.04, NULL, NULL),
(2, 'Контейнер для салата', 1.74, NULL, NULL),
(3, 'Контейнер под мясное блюдо и гарнир', 3.60, NULL, NULL),
(4, 'Ложка', 0.21, NULL, NULL),
(5, 'Вилка', 0.21, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `storage_pdf_bake`
--

CREATE TABLE `storage_pdf_bake` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `pdf_bake` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `storage_pdf_bake`
--

INSERT INTO `storage_pdf_bake` (`id`, `date`, `pdf_bake`, `created_at`, `updated_at`) VALUES
(1, '2019-05-31', 'D:\\OSPanel\\domains\\dinners.loc\\storage\\app\\public\\e245c1a37e3078ed9c3ca6dae99c0d75.pdf', '2019-05-31 18:34:21', '2019-05-31 18:34:21'),
(2, '2019-05-31', 'D:\\OSPanel\\domains\\dinners.loc\\storage\\app\\public\\b3820d4743ee2171e6bb5ffc664b7506.pdf', '2019-05-31 18:40:24', '2019-05-31 18:40:24'),
(3, '2019-06-01', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\bf852862cf9a0430078e6107df96ddda.pdf', '2019-06-01 07:28:29', '2019-06-01 07:28:29'),
(4, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\b2265c645cc55c4ab8d2652e42bbf650.pdf', '2019-06-03 10:02:03', '2019-06-03 10:02:03'),
(5, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\5b33e55f49ffa993f6664fa70d32b180.pdf', '2019-06-03 10:03:08', '2019-06-03 10:03:08'),
(6, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\6ce7c77ce4fa57331acab0e022124795.pdf', '2019-06-03 10:04:08', '2019-06-03 10:04:08'),
(7, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\32c85ba25d0d4e6f2a35738efea31881.pdf', '2019-06-03 10:05:07', '2019-06-03 10:05:07'),
(8, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\0e3a34f1adbb8ee71070ca0cc5960074.pdf', '2019-06-03 10:06:07', '2019-06-03 10:06:07'),
(9, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\2174fe26dff3ccd6c07ce3c51693e12f.pdf', '2019-06-03 10:07:08', '2019-06-03 10:07:08'),
(10, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\3c564be561d0154e1efbdf98b014bc23.pdf', '2019-06-03 10:08:09', '2019-06-03 10:08:09'),
(11, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\bb81e81c811d88cded2f2f785639e546.pdf', '2019-06-03 10:09:08', '2019-06-03 10:09:08'),
(12, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d0c74b24b7e598e08969ad74f5495aba.pdf', '2019-06-03 10:10:08', '2019-06-03 10:10:08'),
(13, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\e864663b957b509c0c1db222cca62b16.pdf', '2019-06-03 10:11:07', '2019-06-03 10:11:07'),
(14, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\fe9e5baf1e7ecd70475500c7419a998c.pdf', '2019-06-03 10:12:09', '2019-06-03 10:12:09'),
(15, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\b7d09bad33789aa6662b7b9e7491a249.pdf', '2019-06-03 10:13:07', '2019-06-03 10:13:07'),
(16, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\fae4c07e0c0cf0dbc7c439631565464c.pdf', '2019-06-03 10:14:08', '2019-06-03 10:14:08'),
(17, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\ca3e8f696de19207c20cdfb9cd0b6b95.pdf', '2019-06-03 10:15:09', '2019-06-03 10:15:09'),
(18, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\5fa30616cc123cc0df6418c4e41481eb.pdf', '2019-06-03 10:16:08', '2019-06-03 10:16:08'),
(19, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\f7189af38c7104a39ebd09afa3d6a539.pdf', '2019-06-03 10:17:08', '2019-06-03 10:17:08'),
(20, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\1fdb4bafafffa7af2d453f3952052382.pdf', '2019-06-03 10:18:08', '2019-06-03 10:18:08'),
(21, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\c7e5b25c7bb51726edafbba6516bac6e.pdf', '2019-06-03 10:19:10', '2019-06-03 10:19:10'),
(22, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d7bb67c92176935deaa555766f7eb37c.pdf', '2019-06-03 10:20:08', '2019-06-03 10:20:08'),
(23, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\7fee2715246f0bb29372478b0ac95e9c.pdf', '2019-06-03 10:21:08', '2019-06-03 10:21:08'),
(24, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\dbc9bde74900f7dd923a34a2e7a68d8c.pdf', '2019-06-03 10:22:09', '2019-06-03 10:22:09'),
(25, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\210f16214c01b1970a4a5110bb68fa0e.pdf', '2019-06-03 10:23:08', '2019-06-03 10:23:08'),
(26, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d97fe624b0bf6eec21ed7e09ccdaa3c3.pdf', '2019-06-03 10:24:09', '2019-06-03 10:24:09'),
(27, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\a137cb19cc6ebbac64fc41c0028655bb.pdf', '2019-06-03 10:25:08', '2019-06-03 10:25:08'),
(28, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\b2e8ec58d5278251b5c2dc61e40c5f0a.pdf', '2019-06-03 10:26:08', '2019-06-03 10:26:08'),
(29, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\54498d24945b3454ecc46ac59a1e5437.pdf', '2019-06-03 10:27:08', '2019-06-03 10:27:08'),
(30, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\7fcdd0a81363c43ba976c4bc987664a1.pdf', '2019-06-03 10:28:09', '2019-06-03 10:28:09'),
(31, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\479b1fb886e899fec70b6ff3a8ce2d42.pdf', '2019-06-03 10:29:08', '2019-06-03 10:29:08'),
(32, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\0f6014f5dfb972a9cfb202c926a345de.pdf', '2019-06-03 10:30:11', '2019-06-03 10:30:11'),
(33, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\ca590fe1797a71f2f8f03644688a55d5.pdf', '2019-06-03 10:31:08', '2019-06-03 10:31:08'),
(34, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\513c1870906a974305cefa71b16e4726.pdf', '2019-06-03 10:32:10', '2019-06-03 10:32:10'),
(35, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\dc1188488222d598cc5bed9dd2c24695.pdf', '2019-06-03 10:33:10', '2019-06-03 10:33:10'),
(36, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\6377a2e1f59731471794fb558c6db881.pdf', '2019-06-03 10:34:09', '2019-06-03 10:34:09'),
(37, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\f67185d0765e3ee179bd7522d553a996.pdf', '2019-06-03 10:35:09', '2019-06-03 10:35:09'),
(38, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\3a065214653ea377e8b92c6b12fdcfb0.pdf', '2019-06-03 10:36:10', '2019-06-03 10:36:10'),
(39, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\4d3f6daae6725ea818f2b94299b6f474.pdf', '2019-06-03 10:37:10', '2019-06-03 10:37:10'),
(40, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\7f04efc5615df059924ae75552fb6db0.pdf', '2019-06-03 10:38:08', '2019-06-03 10:38:08'),
(41, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\8418121961c703c60ccb1f87bc977b8d.pdf', '2019-06-03 10:39:10', '2019-06-03 10:39:10'),
(42, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\b0950144a7c7262dc61385a0bda9a9ea.pdf', '2019-06-03 10:40:09', '2019-06-03 10:40:09'),
(43, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\0467e105012b3d6d310164403ef1bef7.pdf', '2019-06-03 10:41:08', '2019-06-03 10:41:08'),
(44, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\4468b1fec53da47083ab74936b338600.pdf', '2019-06-03 10:42:09', '2019-06-03 10:42:09'),
(45, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d1b9f18f8d0a23dd8e410a7d1ef9719a.pdf', '2019-06-03 10:43:10', '2019-06-03 10:43:10');

-- --------------------------------------------------------

--
-- Структура таблицы `storage_pdf_dish`
--

CREATE TABLE `storage_pdf_dish` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `pdf_dish` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `storage_pdf_dish`
--

INSERT INTO `storage_pdf_dish` (`id`, `date`, `pdf_dish`, `created_at`, `updated_at`) VALUES
(2, '2019-05-31', 'D:\\OSPanel\\domains\\dinners.loc\\storage\\app\\public\\7bdc84929e9d522563c10ce5e1d61b5b.pdf', '2019-05-31 18:40:08', '2019-05-31 18:40:08'),
(3, '2019-06-01', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d73d3b2aacc3ca8189c003cd98f4d599.pdf', '2019-06-01 07:27:45', '2019-06-01 07:27:45'),
(4, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\a4032a25b7807d4f05fb1b4738dc3978.pdf', '2019-06-03 10:02:02', '2019-06-03 10:02:02'),
(5, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\693574d44534ca0ed214b1abc55482f9.pdf', '2019-06-03 10:03:04', '2019-06-03 10:03:04'),
(6, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\81c4e0309f259aadf694bfbc468df5fc.pdf', '2019-06-03 10:04:04', '2019-06-03 10:04:04'),
(7, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\87596c73aba02c211c3f7cba69275717.pdf', '2019-06-03 10:05:04', '2019-06-03 10:05:04'),
(8, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\dc4d06426a11d04db118d4f810254c29.pdf', '2019-06-03 10:06:04', '2019-06-03 10:06:04'),
(9, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\9263072205fc5e117f0e0bd9ee4381c1.pdf', '2019-06-03 10:07:05', '2019-06-03 10:07:05'),
(10, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\a041cc883b79e5e467433db52b38c4f5.pdf', '2019-06-03 10:08:05', '2019-06-03 10:08:05'),
(11, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\5900d152100ddeee395c418e4708d7ae.pdf', '2019-06-03 10:09:05', '2019-06-03 10:09:05'),
(12, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\eaf6bd11d57a912d1b0a583483bab80c.pdf', '2019-06-03 10:10:04', '2019-06-03 10:10:04'),
(13, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\6dcf13fe3467d8df3bd9bd7d0909ed36.pdf', '2019-06-03 10:11:05', '2019-06-03 10:11:05'),
(14, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\58ec3274850ca2d5ebf1f9237cfb2e4a.pdf', '2019-06-03 10:12:05', '2019-06-03 10:12:05'),
(15, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\05a5a29cb7c977dd241a77aa31ec07a5.pdf', '2019-06-03 10:13:04', '2019-06-03 10:13:04'),
(16, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\a0517aa55f880cf1c0a06597dc987251.pdf', '2019-06-03 10:14:05', '2019-06-03 10:14:05'),
(17, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\f75816fb44b3f33bdb6e74571e5bada1.pdf', '2019-06-03 10:15:05', '2019-06-03 10:15:05'),
(18, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\4e804fd191b6d27d3f439dd41ae8e25f.pdf', '2019-06-03 10:16:05', '2019-06-03 10:16:05'),
(19, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\71f8fcd362529764ab0e0a343d270b10.pdf', '2019-06-03 10:17:05', '2019-06-03 10:17:05'),
(20, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d5bcde2ffb252e3fa17f9446e8d9dacd.pdf', '2019-06-03 10:18:05', '2019-06-03 10:18:05'),
(21, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\f96088b71b0ff8e95d137fdb4a071b48.pdf', '2019-06-03 10:19:05', '2019-06-03 10:19:05'),
(22, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\c7f9c528c8ec96ac9cf8a56aa486005c.pdf', '2019-06-03 10:20:05', '2019-06-03 10:20:05'),
(23, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\b0334816e66f7df9ff286ce139ccbf00.pdf', '2019-06-03 10:21:05', '2019-06-03 10:21:05'),
(24, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\07528a39291eca3bb5f5fbc21c9f1cd0.pdf', '2019-06-03 10:22:05', '2019-06-03 10:22:05'),
(25, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d8fffded16fdd031b84e17ef2704d995.pdf', '2019-06-03 10:23:04', '2019-06-03 10:23:04'),
(26, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\f540b4999980ae3ed763e87619e1ebf9.pdf', '2019-06-03 10:24:05', '2019-06-03 10:24:05'),
(27, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\151e4b6085e262ae545849dd3f12bfc4.pdf', '2019-06-03 10:25:04', '2019-06-03 10:25:04'),
(28, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\02eaeb8d96a31a9acde7c60f9bf164a5.pdf', '2019-06-03 10:26:05', '2019-06-03 10:26:05'),
(29, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\d5441c4cfa2d30253e6ac07273e1526a.pdf', '2019-06-03 10:27:05', '2019-06-03 10:27:05'),
(30, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\e54bbaf8e7f96d1dbc7939bf751e8175.pdf', '2019-06-03 10:28:05', '2019-06-03 10:28:05'),
(31, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\4a70419f8c9416da8f74ee1231b2e846.pdf', '2019-06-03 10:29:05', '2019-06-03 10:29:05'),
(32, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\a3884e9ddcabd2f3227a3c9b0912e941.pdf', '2019-06-03 10:30:05', '2019-06-03 10:30:05'),
(33, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\b40e4636306f123599ae0acbff399c91.pdf', '2019-06-03 10:31:05', '2019-06-03 10:31:05'),
(34, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\00b72bab3d9252f278a374ea5f94e7a5.pdf', '2019-06-03 10:32:05', '2019-06-03 10:32:05'),
(35, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\49b894f1b1df03ae1253646d01a01daa.pdf', '2019-06-03 10:33:06', '2019-06-03 10:33:06'),
(36, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\51721d2b227dc46c9758a1e92789e385.pdf', '2019-06-03 10:34:06', '2019-06-03 10:34:06'),
(37, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\1aa860e19ec576d6297c5073c7a7a72b.pdf', '2019-06-03 10:35:05', '2019-06-03 10:35:05'),
(38, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\b24531f384de30371a5d63d064826c06.pdf', '2019-06-03 10:36:06', '2019-06-03 10:36:06'),
(39, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\ce9e9ea83de5999a3a572b3f57633ab2.pdf', '2019-06-03 10:37:05', '2019-06-03 10:37:05'),
(40, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\708858d04702c27b430816531edd838e.pdf', '2019-06-03 10:38:05', '2019-06-03 10:38:05'),
(41, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\14f745f924908d3c238fd456b3feace1.pdf', '2019-06-03 10:39:06', '2019-06-03 10:39:06'),
(42, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\6cc523af44e58b19b91a0de8650a981a.pdf', '2019-06-03 10:40:05', '2019-06-03 10:40:05'),
(43, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\6715cd9e529b989e1dc9ea8fdde2fa13.pdf', '2019-06-03 10:41:04', '2019-06-03 10:41:04'),
(44, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\8b2960983039376fbdf9fb3ebd93c87e.pdf', '2019-06-03 10:42:05', '2019-06-03 10:42:05'),
(45, '2019-06-03', '/var/www/food/data/www/food.client02.prostoy.ru/storage\\app\\public\\6b8d2042ab7dfd467a6f2da21c2184e4.pdf', '2019-06-03 10:43:06', '2019-06-03 10:43:06');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'логин телеграм',
  `avatar` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'аватар',
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accessLevel` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '0 - without access; 1 - user; 2 - admin; 3 - root;',
  `balance` double(8,2) NOT NULL,
  `personalBalance` double(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `provider`, `provider_id`, `password`, `remember_token`, `telegram`, `avatar`, `role`, `accessLevel`, `balance`, `personalBalance`, `created_at`, `updated_at`) VALUES
(1, 'Денис Ос', 'lukeredstone13@gmail.com', NULL, 'GOOGLE', '102292679781837499192', NULL, 't8rJ9cMsTm2J6Q7BNcQCy3qPPBUyo1IfQP3szjZSaZiMuUo8zP1zkth4fmic', NULL, NULL, 'user', 1, 70.00, 158.00, '2019-05-06 10:05:17', '2019-06-28 05:35:44');

-- --------------------------------------------------------

--
-- Структура таблицы `weekend_days`
--

CREATE TABLE `weekend_days` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `weekend_days`
--

INSERT INTO `weekend_days` (`id`, `date`, `created_at`, `updated_at`) VALUES
(48, '2019-01-05', '2019-05-26 15:49:40', '2019-05-26 15:49:40'),
(49, '2019-01-06', '2019-05-26 15:49:40', '2019-05-26 15:49:40'),
(50, '2019-01-12', '2019-05-26 15:49:41', '2019-05-26 15:49:41'),
(51, '2019-01-13', '2019-05-26 15:49:41', '2019-05-26 15:49:41'),
(52, '2019-01-19', '2019-05-26 15:49:41', '2019-05-26 15:49:41'),
(53, '2019-01-20', '2019-05-26 15:49:42', '2019-05-26 15:49:42'),
(54, '2019-01-26', '2019-05-26 15:49:42', '2019-05-26 15:49:42'),
(55, '2019-01-27', '2019-05-26 15:49:54', '2019-05-26 15:49:54'),
(57, '2019-02-02', '2019-05-26 15:50:02', '2019-05-26 15:50:02'),
(58, '2019-02-03', '2019-05-26 15:50:03', '2019-05-26 15:50:03'),
(59, '2019-02-09', '2019-05-26 15:50:03', '2019-05-26 15:50:03'),
(60, '2019-02-10', '2019-05-26 15:50:04', '2019-05-26 15:50:04'),
(61, '2019-02-16', '2019-05-26 15:50:04', '2019-05-26 15:50:04'),
(62, '2019-02-17', '2019-05-26 15:50:04', '2019-05-26 15:50:04'),
(63, '2019-02-23', '2019-05-26 15:50:05', '2019-05-26 15:50:05'),
(64, '2019-02-24', '2019-05-26 15:50:06', '2019-05-26 15:50:06'),
(65, '2019-03-02', '2019-05-26 15:50:06', '2019-05-26 15:50:06'),
(66, '2019-03-03', '2019-05-26 15:50:07', '2019-05-26 15:50:07'),
(67, '2019-03-09', '2019-05-26 15:50:07', '2019-05-26 15:50:07'),
(68, '2019-03-10', '2019-05-26 15:50:08', '2019-05-26 15:50:08'),
(69, '2019-03-16', '2019-05-26 15:50:08', '2019-05-26 15:50:08'),
(70, '2019-03-17', '2019-05-26 15:50:09', '2019-05-26 15:50:09'),
(71, '2019-03-23', '2019-05-26 15:50:09', '2019-05-26 15:50:09'),
(72, '2019-03-24', '2019-05-26 15:50:09', '2019-05-26 15:50:09'),
(73, '2019-03-30', '2019-05-26 15:50:10', '2019-05-26 15:50:10'),
(74, '2019-03-31', '2019-05-26 15:50:11', '2019-05-26 15:50:11'),
(75, '2019-04-06', '2019-05-26 15:50:12', '2019-05-26 15:50:12'),
(76, '2019-04-07', '2019-05-26 15:50:12', '2019-05-26 15:50:12'),
(77, '2019-04-13', '2019-05-26 15:50:13', '2019-05-26 15:50:13'),
(78, '2019-04-14', '2019-05-26 15:50:13', '2019-05-26 15:50:13'),
(79, '2019-04-20', '2019-05-26 15:50:14', '2019-05-26 15:50:14'),
(80, '2019-04-21', '2019-05-26 15:50:14', '2019-05-26 15:50:14'),
(81, '2019-04-27', '2019-05-26 15:50:15', '2019-05-26 15:50:15'),
(82, '2019-04-28', '2019-05-26 15:50:15', '2019-05-26 15:50:15'),
(83, '2019-05-04', '2019-05-26 15:50:16', '2019-05-26 15:50:16'),
(84, '2019-05-05', '2019-05-26 15:50:16', '2019-05-26 15:50:16'),
(85, '2019-05-11', '2019-05-26 15:50:17', '2019-05-26 15:50:17'),
(86, '2019-05-12', '2019-05-26 15:50:17', '2019-05-26 15:50:17'),
(87, '2019-05-18', '2019-05-26 15:50:17', '2019-05-26 15:50:17'),
(88, '2019-05-19', '2019-05-26 15:50:18', '2019-05-26 15:50:18'),
(89, '2019-05-25', '2019-05-26 15:50:18', '2019-05-26 15:50:18'),
(90, '2019-05-26', '2019-05-26 15:50:19', '2019-05-26 15:50:19'),
(91, '2019-06-01', '2019-05-26 15:50:20', '2019-05-26 15:50:20'),
(92, '2019-06-02', '2019-05-26 15:50:20', '2019-05-26 15:50:20'),
(93, '2019-06-08', '2019-05-26 15:50:21', '2019-05-26 15:50:21'),
(94, '2019-06-09', '2019-05-26 15:50:21', '2019-05-26 15:50:21'),
(95, '2019-06-15', '2019-05-26 15:50:21', '2019-05-26 15:50:21'),
(96, '2019-06-16', '2019-05-26 15:50:22', '2019-05-26 15:50:22'),
(97, '2019-06-22', '2019-05-26 15:50:22', '2019-05-26 15:50:22'),
(98, '2019-06-23', '2019-05-26 15:50:23', '2019-05-26 15:50:23'),
(99, '2019-06-29', '2019-05-26 15:50:23', '2019-05-26 15:50:23'),
(100, '2019-06-30', '2019-05-26 15:50:25', '2019-05-26 15:50:25'),
(101, '2019-07-06', '2019-05-26 15:50:25', '2019-05-26 15:50:25'),
(102, '2019-07-07', '2019-05-26 15:50:26', '2019-05-26 15:50:26'),
(103, '2019-07-13', '2019-05-26 15:50:27', '2019-05-26 15:50:27'),
(104, '2019-07-14', '2019-05-26 15:50:27', '2019-05-26 15:50:27'),
(105, '2019-07-20', '2019-05-26 15:50:27', '2019-05-26 15:50:27'),
(106, '2019-07-21', '2019-05-26 15:50:28', '2019-05-26 15:50:28'),
(107, '2019-07-27', '2019-05-26 15:50:28', '2019-05-26 15:50:28'),
(108, '2019-07-28', '2019-05-26 15:50:29', '2019-05-26 15:50:29'),
(109, '2019-08-03', '2019-05-26 15:50:30', '2019-05-26 15:50:30'),
(110, '2019-08-04', '2019-05-26 15:50:30', '2019-05-26 15:50:30'),
(111, '2019-08-10', '2019-05-26 15:50:30', '2019-05-26 15:50:30'),
(112, '2019-08-11', '2019-05-26 15:50:31', '2019-05-26 15:50:31'),
(113, '2019-08-17', '2019-05-26 15:50:31', '2019-05-26 15:50:31'),
(114, '2019-08-18', '2019-05-26 15:50:32', '2019-05-26 15:50:32'),
(115, '2019-08-24', '2019-05-26 15:50:33', '2019-05-26 15:50:33'),
(116, '2019-08-25', '2019-05-26 15:50:33', '2019-05-26 15:50:33'),
(117, '2019-08-31', '2019-05-26 15:50:34', '2019-05-26 15:50:34'),
(118, '2019-09-01', '2019-05-26 15:50:35', '2019-05-26 15:50:35'),
(119, '2019-09-07', '2019-05-26 15:50:35', '2019-05-26 15:50:35'),
(120, '2019-09-08', '2019-05-26 15:50:36', '2019-05-26 15:50:36'),
(121, '2019-09-14', '2019-05-26 15:50:36', '2019-05-26 15:50:36'),
(122, '2019-09-15', '2019-05-26 15:50:37', '2019-05-26 15:50:37'),
(123, '2019-09-22', '2019-05-26 15:50:38', '2019-05-26 15:50:38'),
(124, '2019-09-21', '2019-05-26 15:50:38', '2019-05-26 15:50:38'),
(125, '2019-09-28', '2019-05-26 15:50:38', '2019-05-26 15:50:38'),
(126, '2019-09-29', '2019-05-26 15:50:41', '2019-05-26 15:50:41'),
(127, '2019-10-05', '2019-05-26 15:50:41', '2019-05-26 15:50:41'),
(128, '2019-10-06', '2019-05-26 15:50:42', '2019-05-26 15:50:42'),
(129, '2019-10-12', '2019-05-26 15:50:42', '2019-05-26 15:50:42'),
(130, '2019-10-13', '2019-05-26 15:50:42', '2019-05-26 15:50:42'),
(131, '2019-10-19', '2019-05-26 15:50:43', '2019-05-26 15:50:43'),
(132, '2019-10-20', '2019-05-26 15:50:44', '2019-05-26 15:50:44'),
(133, '2019-10-26', '2019-05-26 15:50:44', '2019-05-26 15:50:44'),
(134, '2019-10-27', '2019-05-26 15:50:45', '2019-05-26 15:50:45'),
(135, '2019-11-02', '2019-05-26 15:50:46', '2019-05-26 15:50:46'),
(136, '2019-11-03', '2019-05-26 15:50:46', '2019-05-26 15:50:46'),
(137, '2019-11-09', '2019-05-26 15:50:47', '2019-05-26 15:50:47'),
(138, '2019-11-10', '2019-05-26 15:50:47', '2019-05-26 15:50:47'),
(139, '2019-11-16', '2019-05-26 15:50:48', '2019-05-26 15:50:48'),
(140, '2019-11-17', '2019-05-26 15:50:48', '2019-05-26 15:50:48'),
(141, '2019-11-23', '2019-05-26 15:50:49', '2019-05-26 15:50:49'),
(142, '2019-11-24', '2019-05-26 15:50:49', '2019-05-26 15:50:49'),
(143, '2019-11-30', '2019-05-26 15:50:50', '2019-05-26 15:50:50'),
(144, '2019-12-01', '2019-05-26 15:50:51', '2019-05-26 15:50:51'),
(145, '2019-12-08', '2019-05-26 15:50:51', '2019-05-26 15:50:51'),
(146, '2019-12-07', '2019-05-26 15:50:52', '2019-05-26 15:50:52'),
(147, '2019-12-14', '2019-05-26 15:50:52', '2019-05-26 15:50:52'),
(148, '2019-12-15', '2019-05-26 15:50:53', '2019-05-26 15:50:53'),
(149, '2019-12-21', '2019-05-26 15:50:53', '2019-05-26 15:50:53'),
(150, '2019-12-22', '2019-05-26 15:50:53', '2019-05-26 15:50:53'),
(151, '2019-12-28', '2019-05-26 15:50:54', '2019-05-26 15:50:54'),
(152, '2019-12-29', '2019-05-26 15:50:55', '2019-05-26 15:50:55'),
(155, '2019-01-01', '2019-05-26 16:02:29', '2019-05-26 16:02:29'),
(162, '2019-03-08', '2019-05-26 16:05:57', '2019-05-26 16:05:57'),
(164, '2019-10-14', '2019-05-26 16:06:06', '2019-05-26 16:06:06'),
(181, '2019-01-07', '2019-05-26 16:32:46', '2019-05-26 16:32:46'),
(182, '2019-12-25', '2019-05-26 16:33:13', '2019-05-26 16:33:13'),
(183, '2019-05-01', '2019-05-26 16:33:14', '2019-05-26 16:33:14'),
(184, '2019-05-09', '2019-05-26 16:33:47', '2019-05-26 16:33:47'),
(185, '2019-08-26', '2019-05-26 16:33:53', '2019-05-26 16:33:53'),
(186, '2019-06-17', '2019-05-26 16:34:22', '2019-05-26 16:34:22'),
(187, '2019-06-28', '2019-05-26 16:34:22', '2019-05-26 16:34:22'),
(188, '2019-04-29', '2019-05-26 16:34:37', '2019-05-26 16:34:37'),
(189, '2019-04-30', '2019-05-26 16:34:37', '2019-05-26 16:34:37'),
(190, '2019-01-08', '2019-05-26 16:53:12', '2019-05-26 16:53:12'),
(193, '2019-01-04', '2019-06-02 14:30:05', '2019-06-02 14:30:05');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `absences`
--
ALTER TABLE `absences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `absences_user_id_foreign` (`user_id`),
  ADD KEY `reason_id` (`reason_id`);

--
-- Индексы таблицы `days_for_dishes`
--
ALTER TABLE `days_for_dishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `days_for_dishes_dish_id_foreign` (`dish_id`);

--
-- Индексы таблицы `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dishes_type_id_foreign` (`type_id`) USING BTREE;

--
-- Индексы таблицы `dishes_to_requirements`
--
ALTER TABLE `dishes_to_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dishes_to_requirements_dish_id_foreign` (`dish_id`),
  ADD KEY `dishes_to_requirements_requirement_id_foreign` (`requirement_id`);

--
-- Индексы таблицы `dishes_types`
--
ALTER TABLE `dishes_types`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `orders_to_dishes`
--
ALTER TABLE `orders_to_dishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_to_dishes_order_id_foreign` (`order_id`),
  ADD KEY `orders_to_dishes_dish_id_foreign` (`dish_id`);

--
-- Индексы таблицы `orders_to_requirements`
--
ALTER TABLE `orders_to_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_to_requirements_requirement_id_foreign` (`requirement_id`),
  ADD KEY `orders_to_requirements_order_id_foreign` (`order_id`);

--
-- Индексы таблицы `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Индексы таблицы `reasons`
--
ALTER TABLE `reasons`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `requirements`
--
ALTER TABLE `requirements`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `storage_pdf_bake`
--
ALTER TABLE `storage_pdf_bake`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `storage_pdf_dish`
--
ALTER TABLE `storage_pdf_dish`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Индексы таблицы `weekend_days`
--
ALTER TABLE `weekend_days`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Date_unique` (`date`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `absences`
--
ALTER TABLE `absences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT для таблицы `days_for_dishes`
--
ALTER TABLE `days_for_dishes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT для таблицы `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT для таблицы `dishes_to_requirements`
--
ALTER TABLE `dishes_to_requirements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `dishes_types`
--
ALTER TABLE `dishes_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `orders_to_dishes`
--
ALTER TABLE `orders_to_dishes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `orders_to_requirements`
--
ALTER TABLE `orders_to_requirements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `reasons`
--
ALTER TABLE `reasons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `requirements`
--
ALTER TABLE `requirements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `storage_pdf_bake`
--
ALTER TABLE `storage_pdf_bake`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT для таблицы `storage_pdf_dish`
--
ALTER TABLE `storage_pdf_dish`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `weekend_days`
--
ALTER TABLE `weekend_days`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `absences`
--
ALTER TABLE `absences`
  ADD CONSTRAINT `absences_ibfk_1` FOREIGN KEY (`reason_id`) REFERENCES `reasons` (`id`),
  ADD CONSTRAINT `absences_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `days_for_dishes`
--
ALTER TABLE `days_for_dishes`
  ADD CONSTRAINT `days_for_dishes_dish_id_foreign` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`);

--
-- Ограничения внешнего ключа таблицы `dishes`
--
ALTER TABLE `dishes`
  ADD CONSTRAINT `dishes_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `dishes_types` (`id`);

--
-- Ограничения внешнего ключа таблицы `dishes_to_requirements`
--
ALTER TABLE `dishes_to_requirements`
  ADD CONSTRAINT `dishes_to_requirements_dish_id_foreign` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`),
  ADD CONSTRAINT `dishes_to_requirements_requirement_id_foreign` FOREIGN KEY (`requirement_id`) REFERENCES `requirements` (`id`);

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `orders_to_dishes`
--
ALTER TABLE `orders_to_dishes`
  ADD CONSTRAINT `orders_to_dishes_dish_id_foreign` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`),
  ADD CONSTRAINT `orders_to_dishes_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

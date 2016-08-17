-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 29, 2015 at 09:21 AM
-- Server version: 5.5.43-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `foodapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(80) NOT NULL,
  `full_name` varchar(80) NOT NULL,
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admins_on_email` (`email`),
  UNIQUE KEY `index_admins_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `full_name`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`) VALUES
(3, 'admin@admin.com', 'admin3', '$2a$10$8EdtW.P6/nShhjZGJ3PTKOaDU5PV/KAV2nV9Ekiktus68Wa0z6/sS', NULL, NULL, NULL, 9, '2015-07-23 03:00:09', '2015-07-14 02:54:38', '127.0.0.1', '127.0.0.1'),
(4, 'ada@ada.com', 'ada', '$2a$10$1/AUwWwyiJ4xN72Vdo43Hue.TGbmagENsIG8vE/6kuCwqF7Qp62r.', NULL, NULL, NULL, 4, '2015-07-27 03:09:49', '2015-07-15 02:49:16', '127.0.0.1', '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE IF NOT EXISTS `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_paid` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `created_at`, `updated_at`, `is_paid`) VALUES
(1, 1, '2015-07-13 07:00:00', NULL, 'N');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE IF NOT EXISTS `cart_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `amount` varchar(45) NOT NULL,
  `item_price` decimal(12,2) NOT NULL,
  `sub_total` decimal(12,2) NOT NULL,
  `vat_total` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id_idx` (`item_id`),
  KEY `cart_id_idx` (`cart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `code` varchar(5) NOT NULL,
  `currency` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `code`, `currency`) VALUES
(1, 'Indonesia', 'ID', 'IDR');

-- --------------------------------------------------------

--
-- Table structure for table `invitations`
--

CREATE TABLE IF NOT EXISTS `invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `invitations`
--

INSERT INTO `invitations` (`id`, `first_name`, `last_name`, `email`, `created_at`) VALUES
(20, 'marchellin', 'antonia', 'marchellin.antonia@gmail.com', '2015-07-09 07:42:10');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `price` double NOT NULL DEFAULT '2.5',
  `photo` varchar(80) DEFAULT NULL,
  `liked` int(11) NOT NULL DEFAULT '0',
  `commented` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_idx` (`user_id`),
  KEY `category_id_idx` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `user_id`, `category_id`, `name`, `price`, `photo`, `liked`, `commented`, `created_at`, `updated_at`, `description`) VALUES
(1, 1, 2, 'Meat Lovers Pizza', 10.5, 'meatlovers.jpg', 3, 0, '2015-07-23 00:00:00', '2015-07-23 07:29:30', 'Full of meat, everybody loves it!'),
(2, 1, 1, 'Kongkow Chow Mien', 12, 'kongkow.jpg', 2, 0, '2015-07-23 00:00:00', '2015-07-23 07:29:50', 'Extra Large portion of kongkow noodle'),
(3, 2, 3, 'Fussili Hot Tuna', 8.9, 'fusili.JPG', 12, 0, '2015-07-23 00:00:00', '2015-07-23 07:30:59', 'Hot Pasta.........'),
(4, 3, 4, 'Tom Yum Goong Soup', 15, 'tomyum.jpg', 6, 2, '2015-07-23 00:00:00', '2015-07-23 07:32:56', 'Thailand Oriental Soup Sweet and Sour taste with lobster and red pepper paste');

-- --------------------------------------------------------

--
-- Table structure for table `item_categories`
--

CREATE TABLE IF NOT EXISTS `item_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `item_categories`
--

INSERT INTO `item_categories` (`id`, `name`, `created_at`) VALUES
(1, 'Noodle', '0000-00-00 00:00:00'),
(2, 'Pizza', '0000-00-00 00:00:00'),
(3, 'Pasta', '0000-00-00 00:00:00'),
(4, 'Soup', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `item_photos`
--

CREATE TABLE IF NOT EXISTS `item_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `url` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `item_id_idx` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `number_of_items` int(11) NOT NULL,
  `sub_total` decimal(12,2) NOT NULL,
  `vat_total` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'Pending',
  `reference_id` varchar(45) NOT NULL,
  `currency` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_id_idx` (`cart_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `cart_id`, `user_id`, `number_of_items`, `sub_total`, `vat_total`, `total`, `payment_date`, `status`, `reference_id`, `currency`) VALUES
(1, 1, 1, 3, 354.00, 1.00, 353.00, '2015-07-16 00:00:00', 'Pending', '1', 'IDR'),
(2, 1, 1, 4, 223.00, 1.00, 224.00, '2015-07-13 00:00:00', 'Completed', '1', 'IDR');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20150708083245');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(80) NOT NULL,
  `about_me` text,
  `photo` varchar(100) DEFAULT NULL,
  `following` int(11) NOT NULL DEFAULT '0',
  `followers` int(11) NOT NULL DEFAULT '0',
  `listing` int(11) NOT NULL DEFAULT '0',
  `facebook_id` varchar(100) DEFAULT NULL,
  `google_id` varchar(100) DEFAULT NULL,
  `verified_fb` varchar(1) NOT NULL DEFAULT 'N',
  `veriried_google` varchar(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `city` int(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `about_me`, `photo`, `following`, `followers`, `listing`, `facebook_id`, `google_id`, `verified_fb`, `veriried_google`, `created_date`, `updated_at`, `country_id`, `city`) VALUES
(1, 'Marchellin Antonia F', 'marchellin_antonia@yahoo.com', 'admin123', 'this is about me field...this is about me field...this is about me field...this is about me field...this is about me field...this is about me field...', '178241_46112aa7-93a8-4dab-9ba6-e1b02b4331c7.jpg', 5, 2, 6, '', '', 'N', 'N', '2015-07-13 00:00:00', '2015-07-23 07:41:00', 1, 3),
(2, 'Tono Ton', 'tono@gmail.com', 'admin123', NULL, '178241_32d6713e-d9d2-11e4-ac81-920887772fba.jpg', 0, 2, 0, '', '', 'N', 'N', '2015-07-13 00:00:00', '2015-07-23 04:22:43', 1, 5),
(3, 'Milano', 'milano@gmail.com', 'admin123', NULL, NULL, 1, 0, 0, NULL, NULL, 'N', 'N', '2015-07-14 00:00:00', NULL, 1, 7);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `user_id_carts` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_id_cart_items` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `item_id_cart_items` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `item_categories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `item_photos`
--
ALTER TABLE `item_photos`
  ADD CONSTRAINT `item_id_photos` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_photos` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `cart_id_payments` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `country_id_users` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

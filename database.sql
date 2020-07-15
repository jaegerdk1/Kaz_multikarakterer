-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 23. 03 2020 kl. 20:37:04
-- Serverversion: 10.4.11-MariaDB
-- PHP-version: 7.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `vrpfx` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vrpfx`;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `kaz_drugs`
--

CREATE TABLE `kaz_drugs` (
  `user_id` int(11) DEFAULT NULL,
  `drug` varchar(255) DEFAULT NULL,
  `xp` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `kaz_tuner`
--

CREATE TABLE `kaz_tuner` (
  `id` int(11) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `veh` varchar(255) DEFAULT NULL,
  `value1` varchar(255) DEFAULT NULL,
  `value2` varchar(255) DEFAULT NULL,
  `value3` varchar(255) DEFAULT NULL,
  `value4` varchar(255) DEFAULT NULL,
  `value5` varchar(255) DEFAULT NULL,
  `value6` varchar(255) DEFAULT NULL,
  `value7` varchar(255) DEFAULT NULL,
  `value8` varchar(255) DEFAULT NULL,
  `value9` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_twitter`
--

CREATE TABLE `phone_twitter` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `message` varchar(300) NOT NULL,
  `time` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `ram_jul`
--

CREATE TABLE `ram_jul` (
  `user_id` int(255) NOT NULL,
  `brugt` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_srv_data`
--

CREATE TABLE `vrp_srv_data` (
  `dkey` varchar(255) NOT NULL DEFAULT '',
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_users`
--

CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL,
  `last_login` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `last_date` text COLLATE utf8_danish_ci DEFAULT NULL,
  `whitelisted` tinyint(1) DEFAULT 0,
  `banned` tinyint(1) DEFAULT 0,
  `reason` text CHARACTER SET utf8 DEFAULT NULL,
  `DmvTest` int(11) DEFAULT 1,
  `freason` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `verify` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

--
-- Triggers/udløsere `vrp_users`
--
DELIMITER $$
CREATE TRIGGER `vrp_users_analysis_bannings` BEFORE UPDATE ON `vrp_users` FOR EACH ROW BEGIN

	IF ( IFNULL(OLD.`banned`,0) != IFNULL(NEW.`banned`,0) ) THEN
		INSERT INTO `_log_banstory`
			(`user_id`,`ban_from`,`ban_to`,`ban_reason`)
				VALUES
            (OLD.`id`,OLD.`banned`,NEW.`banned`,IFNULL(NEW.`reason`,''))
		;
    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_business`
--

CREATE TABLE `vrp_user_business` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(30) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `capital` int(11) DEFAULT 0,
  `laundered` int(11) DEFAULT 0,
  `reset_timestamp` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_data`
--

CREATE TABLE `vrp_user_data` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `dkey` varchar(255) NOT NULL DEFAULT '',
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_homes`
--

CREATE TABLE `vrp_user_homes` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `home` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_identities`
--

CREATE TABLE `vrp_user_identities` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `registration` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `firstname` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `age` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_danish_ci;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_ids`
--

CREATE TABLE `vrp_user_ids` (
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers/udløsere `vrp_user_ids`
--
DELIMITER $$
CREATE TRIGGER `vrp_user_ids_logging` AFTER DELETE ON `vrp_user_ids` FOR EACH ROW BEGIN

	INSERT INTO
		`_log_user_switch`
        (`identifier`,`userid`)
	VALUES
		(OLD.`identifier`,OLD.`user_id`)
	
    ON DUPLICATE KEY UPDATE `userid`=`userid`;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_moneys`
--

CREATE TABLE `vrp_user_moneys` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `wallet` bigint(20) DEFAULT 0,
  `bank` bigint(20) DEFAULT 0,
  `_log_upd` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers/udløsere `vrp_user_moneys`
--
DELIMITER $$
CREATE TRIGGER `vrp_user_moneys_analysis_update` AFTER UPDATE ON `vrp_user_moneys` FOR EACH ROW BEGIN
	/* Lets check if the wallet has changed */
    IF ( IFNULL(OLD.`wallet`,0) != IFNULL(NEW.`wallet`,0) ) THEN
        INSERT INTO `vrpfx`.`_log_cashflow`
            (
                `user_id`,
                `cash_type`,
                `cash_start`,
                `cash_move`,
                `cash_end`
            )
                VALUES
            (
                OLD.`user_id`,
                'WALLET',
                IFNULL(OLD.`wallet`,0),
                ( IFNULL(NEW.`wallet`,0) - IFNULL(OLD.`wallet`,0) ),
                IFNULL(NEW.`wallet`,0)
            )
        ;
    END IF;

    /* Lets check if the wallet has changed */
    IF ( IFNULL(OLD.`bank`,0) != IFNULL(NEW.`bank`,0) ) THEN
        INSERT INTO `vrpfx`.`_log_cashflow`
            (
                `user_id`,
                `cash_type`,
                `cash_start`,
                `cash_move`,
                `cash_end`
            )
                VALUES
            (
                OLD.`user_id`,
                'BANK',
                IFNULL(OLD.`bank`,0),
                ( IFNULL(NEW.`bank`,0) - IFNULL(OLD.`bank`,0) ),
                IFNULL(NEW.`bank`,0)
            )
        ;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_vehicles`
--

CREATE TABLE `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `vehicle` varchar(255) NOT NULL DEFAULT '',
  `vehicle_name` varchar(255) NOT NULL,
  `vehicle_plate` varchar(15) NOT NULL,
  `veh_type` varchar(255) NOT NULL DEFAULT 'default',
  `vehicle_colorprimary` varchar(255) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(255) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(255) DEFAULT NULL,
  `vehicle_wheelcolor` varchar(255) DEFAULT NULL,
  `vehicle_plateindex` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor1` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor2` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor3` varchar(255) DEFAULT NULL,
  `vehicle_windowtint` varchar(255) DEFAULT NULL,
  `vehicle_wheeltype` varchar(255) DEFAULT NULL,
  `vehicle_mods0` varchar(255) DEFAULT NULL,
  `vehicle_mods1` varchar(255) DEFAULT NULL,
  `vehicle_mods2` varchar(255) DEFAULT NULL,
  `vehicle_mods3` varchar(255) DEFAULT NULL,
  `vehicle_mods4` varchar(255) DEFAULT NULL,
  `vehicle_mods5` varchar(255) DEFAULT NULL,
  `vehicle_mods6` varchar(255) DEFAULT NULL,
  `vehicle_mods7` varchar(255) DEFAULT NULL,
  `vehicle_mods8` varchar(255) DEFAULT NULL,
  `vehicle_mods9` varchar(255) DEFAULT NULL,
  `vehicle_mods10` varchar(255) DEFAULT NULL,
  `vehicle_mods11` varchar(255) DEFAULT NULL,
  `vehicle_mods12` varchar(255) DEFAULT NULL,
  `vehicle_mods13` varchar(255) DEFAULT NULL,
  `vehicle_mods14` varchar(255) DEFAULT NULL,
  `vehicle_mods15` varchar(255) DEFAULT NULL,
  `vehicle_mods16` varchar(255) DEFAULT NULL,
  `vehicle_turbo` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_tiresmoke` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_xenon` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_mods23` varchar(255) DEFAULT NULL,
  `vehicle_mods24` varchar(255) DEFAULT NULL,
  `vehicle_neon0` varchar(255) DEFAULT NULL,
  `vehicle_neon1` varchar(255) DEFAULT NULL,
  `vehicle_neon2` varchar(255) DEFAULT NULL,
  `vehicle_neon3` varchar(255) DEFAULT NULL,
  `vehicle_bulletproof` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor1` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor2` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor3` varchar(255) DEFAULT NULL,
  `vehicle_modvariation` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_price` int(60) NOT NULL DEFAULT 0,
  `vehicle_damage` varchar(255) NOT NULL DEFAULT '',
  `vehicle_impound` varchar(255) NOT NULL DEFAULT '',
  `vehicle_livery` varchar(255) DEFAULT NULL,
  `fuel` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers/udløsere `vrp_user_vehicles`
--
DELIMITER $$
CREATE TRIGGER `_log_adding` BEFORE INSERT ON `vrp_user_vehicles` FOR EACH ROW INSERT INTO `vrpfx`.`_log_vehicles` (`action`,`user_id`,`vehicle`,`vehicle_price`) VALUES ('insert', NEW.`user_id`, NEW.`vehicle`, NEW.`vehicle_price`)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `_log_banstory`
--

CREATE TABLE `_log_banstory` (
  `uid` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `ban_from` int(11) NOT NULL,
  `ban_to` int(11) NOT NULL,
  `ban_reason` varchar(255) NOT NULL,
  `_upd` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `_log_cashflow`
--

CREATE TABLE `_log_cashflow` (
  `uid` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_type` varchar(45) NOT NULL,
  `cash_start` bigint(20) NOT NULL,
  `cash_move` bigint(20) NOT NULL,
  `cash_end` bigint(20) NOT NULL,
  `_upd` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `_log_user_switch`
--

CREATE TABLE `_log_user_switch` (
  `uid` bigint(20) NOT NULL,
  `identifier` varchar(250) NOT NULL,
  `userid` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `_log_vehicles`
--

CREATE TABLE `_log_vehicles` (
  `uid` bigint(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `action` varchar(250) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `vehicle` varchar(250) NOT NULL,
  `vehicle_price` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `_log_weapons_user`
--

CREATE TABLE `_log_weapons_user` (
  `user_id` int(11) DEFAULT NULL,
  `to` varchar(255) NOT NULL DEFAULT '',
  `from` varchar(255) NOT NULL DEFAULT '0',
  `weapon_name` varchar(255) DEFAULT '',
  `_time` timestamp NULL DEFAULT current_timestamp(),
  `weapon_amount` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `kaz_tuner`
--
ALTER TABLE `kaz_tuner`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `phone_twitter`
--
ALTER TABLE `phone_twitter`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `ram_jul`
--
ALTER TABLE `ram_jul`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks for tabel `vrp_srv_data`
--
ALTER TABLE `vrp_srv_data`
  ADD PRIMARY KEY (`dkey`);

--
-- Indeks for tabel `vrp_users`
--
ALTER TABLE `vrp_users`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks for tabel `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD PRIMARY KEY (`user_id`,`dkey`);

--
-- Indeks for tabel `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD KEY `home` (`home`,`number`);

--
-- Indeks for tabel `vrp_user_identities`
--
ALTER TABLE `vrp_user_identities`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `registration_UNIQUE` (`registration`),
  ADD UNIQUE KEY `phone_UNIQUE` (`phone`),
  ADD KEY `registration` (`registration`),
  ADD KEY `phone` (`phone`);

--
-- Indeks for tabel `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_user_ids_users` (`user_id`);

--
-- Indeks for tabel `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks for tabel `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD PRIMARY KEY (`user_id`,`vehicle_plate`,`vehicle`);

--
-- Indeks for tabel `_log_banstory`
--
ALTER TABLE `_log_banstory`
  ADD PRIMARY KEY (`uid`);

--
-- Indeks for tabel `_log_cashflow`
--
ALTER TABLE `_log_cashflow`
  ADD PRIMARY KEY (`uid`);

--
-- Indeks for tabel `_log_user_switch`
--
ALTER TABLE `_log_user_switch`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `userid_UNIQUE` (`userid`);

--
-- Indeks for tabel `_log_vehicles`
--
ALTER TABLE `_log_vehicles`
  ADD PRIMARY KEY (`uid`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `kaz_tuner`
--
ALTER TABLE `kaz_tuner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `phone_twitter`
--
ALTER TABLE `phone_twitter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `vrp_users`
--
ALTER TABLE `vrp_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `_log_banstory`
--
ALTER TABLE `_log_banstory`
  MODIFY `uid` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `_log_cashflow`
--
ALTER TABLE `_log_cashflow`
  MODIFY `uid` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `_log_user_switch`
--
ALTER TABLE `_log_user_switch`
  MODIFY `uid` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `_log_vehicles`
--
ALTER TABLE `_log_vehicles`
  MODIFY `uid` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD CONSTRAINT `fk_user_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_identities`
--
ALTER TABLE `vrp_user_identities`
  ADD CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 09 mars 2023 à 12:49
-- Version du serveur : 8.0.27
-- Version de PHP : 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `romassigcom`
--

-- --------------------------------------------------------

--
-- Structure de la table `taxe`
--

DROP TABLE IF EXISTS `taxe`;
CREATE TABLE IF NOT EXISTS `taxe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_taxe_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `appellation` varchar(255) NOT NULL,
  `type_taux` int NOT NULL,
  `taux` decimal(10,2) DEFAULT NULL,
  `sens` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `code_taxe` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_56322FE932982851` (`type_taxe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `taxe`
--

INSERT INTO `taxe` (`id`, `type_taxe_id`, `libelle`, `appellation`, `type_taux`, `taux`, `sens`, `created_at`, `updated_at`, `deleted_at`, `code_taxe`) VALUES
(1, NULL, 'TAXE SUR VALEUR AJOUTEE', 'TVA', 0, '18.00', 1, '2023-03-01 18:09:44', '2023-03-01 18:09:44', NULL, 'TVA'),
(2, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '1.00', 0, '2023-03-01 18:09:34', '2023-03-01 18:09:34', NULL, 'AIB1'),
(3, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '5.00', 0, '2023-03-01 18:10:18', NULL, NULL, 'AIB5'),
(4, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '3.00', 0, '2023-03-01 18:13:01', NULL, NULL, 'AIB3'),
(5, NULL, 'EXONERE', 'EX', 0, '0.00', 1, '2023-03-07 12:17:54', NULL, NULL, 'TVA-EX'),
(6, NULL, 'EXPORTATION', 'TVA-EXP', 0, '0.00', 1, '2023-03-07 12:19:03', NULL, NULL, 'TVA-EXP'),
(7, NULL, 'TVA REGIME D\'EXCEPTION 18%', 'TVAD', 0, '18.00', 1, '2023-03-07 12:19:43', NULL, NULL, 'TVAD'),
(8, NULL, 'TPS', 'E', 0, '0.00', 1, '2023-03-07 12:20:05', NULL, NULL, 'E'),
(9, NULL, 'RESERVE', 'F', 0, '0.00', 1, '2023-03-07 12:20:21', NULL, NULL, 'F');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `taxe`
--
ALTER TABLE `taxe`
  ADD CONSTRAINT `FK_56322FE932982851` FOREIGN KEY (`type_taxe_id`) REFERENCES `type_taxe` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

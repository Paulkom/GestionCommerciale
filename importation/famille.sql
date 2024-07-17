-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 15 fév. 2023 à 14:27
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

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
-- Structure de la table `famille`
--

DROP TABLE IF EXISTS `famille`;
CREATE TABLE IF NOT EXISTS `famille` (
  `id` int NOT NULL AUTO_INCREMENT,
  `famille_parent_id` int DEFAULT NULL,
  `code_famille` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `libelle_famille` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2473F21352523166` (`famille_parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `famille`
--

INSERT INTO `famille` (`id`, `famille_parent_id`, `code_famille`, `libelle_famille`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'PEST', 'PEINTURE ET STAFF', '2023-02-15 13:32:19', NULL, NULL),
(2, NULL, 'CARO', 'CARREAUX', '2023-02-15 13:32:19', NULL, NULL),
(3, NULL, 'CHME', 'CHARPENTE ET MENUISERIE', '2023-02-15 13:32:19', NULL, NULL),
(4, NULL, 'ALVI', 'ALLUMINIUM ET VITRERIE', '2023-02-15 13:32:19', NULL, NULL),
(5, NULL, 'DIV', 'DIVERS', '2023-02-15 13:32:19', NULL, NULL),
(6, NULL, 'MACO', 'MA', '2023-02-15 13:32:19', NULL, NULL),
(7, NULL, 'FER', 'FERRAILLAGE', '2023-02-15 13:32:19', NULL, NULL),
(8, NULL, 'PLOM', 'PLOMBERIE', '2023-02-15 13:32:19', NULL, NULL),
(9, NULL, 'ELEC', 'ELECTRICITE', '2023-02-15 13:32:19', NULL, NULL),
(10, NULL, 'SER', 'SERRURE', '2023-02-15 13:32:19', NULL, NULL),
(11, NULL, 'SOUD', 'SOUDURE', '2023-02-15 13:32:19', NULL, NULL),
(12, NULL, 'AUT', 'AUTRESS', '2023-02-15 13:32:19', NULL, NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `famille`
--
ALTER TABLE `famille`
  ADD CONSTRAINT `FK_2473F21352523166` FOREIGN KEY (`famille_parent_id`) REFERENCES `famille` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

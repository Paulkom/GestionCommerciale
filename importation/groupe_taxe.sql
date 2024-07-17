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
-- Structure de la table `groupe_taxe`
--

DROP TABLE IF EXISTS `groupe_taxe`;
CREATE TABLE IF NOT EXISTS `groupe_taxe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taux_gr_id` int NOT NULL,
  `code_gr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `libelle_gr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FEDA505EE2FBBC81` (`taux_gr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `groupe_taxe`
--

INSERT INTO `groupe_taxe` (`id`, `taux_gr_id`, `code_gr`, `libelle_gr`) VALUES
(3, 5, 'A', 'A - EXONERE'),
(4, 1, 'B', 'B - TAXABLE 18%'),
(5, 6, 'C', 'C - EXPORTATION'),
(6, 7, 'D', 'D - TVA REGIME D\'EXCEPTION 18%'),
(7, 8, 'E', 'E - REGIME TPS'),
(8, 9, 'F', 'F - RESERVE');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `groupe_taxe`
--
ALTER TABLE `groupe_taxe`
  ADD CONSTRAINT `FK_FEDA505EE2FBBC81` FOREIGN KEY (`taux_gr_id`) REFERENCES `taxe` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

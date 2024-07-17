-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 22 sep. 2023 à 17:15
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
-- Structure de la table `adresse_livraison`
--

DROP TABLE IF EXISTS `adresse_livraison`;
CREATE TABLE IF NOT EXISTS `adresse_livraison` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `libelle_adresse` varchar(255) NOT NULL,
  `quartier` varchar(255) DEFAULT NULL,
  `ville` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B0B09C919EB6921` (`client_id`),
  KEY `IDX_B0B09C9EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `approvisionnement`
--

DROP TABLE IF EXISTS `approvisionnement`;
CREATE TABLE IF NOT EXISTS `approvisionnement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_frs_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `fournisseur_id` int DEFAULT NULL,
  `model_signataire_id` int DEFAULT NULL,
  `date_appro` datetime NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_516C3FAAEA316CE` (`commande_frs_id`),
  KEY `IDX_516C3FAAEFA24D68` (`point_vente_id`),
  KEY `IDX_516C3FAA670C757F` (`fournisseur_id`),
  KEY `IDX_516C3FAAD16C5631` (`model_signataire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `approvisionnement`
--

INSERT INTO `approvisionnement` (`id`, `commande_frs_id`, `point_vente_id`, `fournisseur_id`, `model_signataire_id`, `date_appro`, `montant_total`, `est_sup`, `reference`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, NULL, NULL, '2023-09-15 00:00:00', NULL, NULL, 'REF-069B9B863B310A6F', '2023-09-15 10:34:38', NULL, NULL),
(2, NULL, 1, NULL, NULL, '2023-09-15 00:00:00', NULL, NULL, 'REF-26483B756F48E8CC', '2023-09-15 14:55:05', NULL, NULL),
(3, NULL, 1, NULL, NULL, '2023-09-18 00:00:00', NULL, NULL, 'REF-1E6428D37FEF224D', '2023-09-18 14:14:05', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `appro_magasin`
--

DROP TABLE IF EXISTS `appro_magasin`;
CREATE TABLE IF NOT EXISTS `appro_magasin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `approvisionnement_id` int NOT NULL,
  `magasin_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_32DAECBDAE741A98` (`approvisionnement_id`),
  KEY `IDX_32DAECBD20096AE3` (`magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `appro_magasin`
--

INSERT INTO `appro_magasin` (`id`, `approvisionnement_id`, `magasin_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `banque`
--

DROP TABLE IF EXISTS `banque`;
CREATE TABLE IF NOT EXISTS `banque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `denomination_banque` varchar(255) NOT NULL,
  `sigle` varchar(255) NOT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B1F6CB3CEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `caisse`
--

DROP TABLE IF EXISTS `caisse`;
CREATE TABLE IF NOT EXISTS `caisse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lcaisse_id` int DEFAULT NULL,
  `etat_caisse_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `date_ouverture` datetime DEFAULT NULL,
  `date_fermeture` datetime DEFAULT NULL,
  `fond_roulement` decimal(10,0) NOT NULL,
  `solde_cloture` decimal(10,2) DEFAULT NULL,
  `etat` int NOT NULL,
  `ecart` decimal(10,0) DEFAULT NULL,
  `chiffre_affaire` decimal(10,0) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `depense` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B2A353C8E9EC6699` (`lcaisse_id`),
  KEY `IDX_B2A353C8D726B853` (`etat_caisse_id`),
  KEY `IDX_B2A353C8A76ED395` (`user_id`),
  KEY `IDX_B2A353C8EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `caisse`
--

INSERT INTO `caisse` (`id`, `lcaisse_id`, `etat_caisse_id`, `user_id`, `point_vente_id`, `date_ouverture`, `date_fermeture`, `fond_roulement`, `solde_cloture`, `etat`, `ecart`, `chiffre_affaire`, `est_sup`, `depense`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 2, 3, 1, '2023-09-13 10:24:28', '2023-09-15 19:03:35', '0', NULL, 0, NULL, NULL, NULL, NULL, '2023-09-13 10:24:28', '2023-09-15 19:03:35', NULL),
(2, 1, 1, NULL, 1, NULL, '2023-09-15 19:03:35', '0', '11199725.00', 1, '0', '11199725', NULL, '0', '2023-09-15 19:03:35', NULL, NULL),
(3, 1, 4, 3, 1, '2023-09-16 09:11:29', '2023-09-16 14:43:13', '83600', NULL, 0, NULL, NULL, NULL, NULL, '2023-09-16 09:11:31', '2023-09-16 14:43:13', NULL),
(4, 1, 3, NULL, 1, NULL, '2023-09-16 14:43:13', '83600', '285400.00', 1, '-2450', '204250', NULL, '0', '2023-09-16 14:43:13', NULL, NULL),
(5, 1, 6, 3, 1, '2023-09-18 08:45:23', '2023-09-18 16:48:13', '12500', NULL, 0, NULL, NULL, NULL, NULL, '2023-09-18 08:45:23', '2023-09-18 16:48:13', NULL),
(6, 1, 5, NULL, 1, NULL, '2023-09-18 16:48:13', '12500', '817900.00', 1, '0', '1011100', NULL, '205700', '2023-09-18 16:48:13', NULL, NULL),
(7, 1, 8, 3, 1, '2023-09-19 08:42:38', '2023-09-19 17:17:12', '0', NULL, 0, NULL, NULL, NULL, NULL, '2023-09-19 08:42:38', '2023-09-19 17:17:12', NULL),
(8, 1, 7, NULL, 1, NULL, '2023-09-19 17:17:12', '0', '1955100.00', 1, '-200', '1998300', NULL, '43000', '2023-09-19 17:17:12', NULL, NULL),
(9, 1, 10, 3, 1, '2023-09-20 08:32:25', '2023-09-20 17:20:52', '0', NULL, 0, NULL, NULL, NULL, NULL, '2023-09-20 08:32:25', '2023-09-20 17:20:52', NULL),
(10, 1, 9, NULL, 1, NULL, '2023-09-20 17:20:52', '0', '1290750.00', 1, '0', '1425650', NULL, '134900', '2023-09-20 17:20:52', NULL, NULL),
(11, 1, 12, 3, 1, '2023-09-21 08:46:47', '2023-09-21 17:07:09', '12500', NULL, 0, NULL, NULL, NULL, NULL, '2023-09-21 08:46:47', '2023-09-21 17:07:09', NULL),
(12, 1, 11, NULL, 1, NULL, '2023-09-21 17:07:09', '12500', '2287100.00', 1, '0', '2312600', NULL, '38000', '2023-09-21 17:07:09', NULL, NULL),
(13, 1, NULL, 3, 1, '2023-09-22 08:55:49', NULL, '12500', NULL, 0, NULL, NULL, NULL, NULL, '2023-09-22 08:55:49', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `nom` varchar(255) DEFAULT '',
  `prenom` varchar(255) DEFAULT '',
  `adresse` varchar(255) DEFAULT '',
  `email` varchar(255) DEFAULT '',
  `telephone1` varchar(255) DEFAULT NULL,
  `telephone2` varchar(255) DEFAULT NULL,
  `raison_sociale` varchar(255) DEFAULT '',
  `ifu` varchar(255) DEFAULT NULL,
  `rccm` varchar(255) DEFAULT NULL,
  `sigle` varchar(255) DEFAULT '',
  `denomination` varchar(255) DEFAULT '',
  `statut` varchar(255) DEFAULT NULL,
  `date_nais` datetime DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `nom_client` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C7440455EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `point_vente_id`, `nom`, `prenom`, `adresse`, `email`, `telephone1`, `telephone2`, `raison_sociale`, `ifu`, `rccm`, `sigle`, `denomination`, `statut`, `date_nais`, `est_sup`, `nom_client`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Ordinaire', '-', '-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Physique', NULL, NULL, 'Ordinaire -', '2023-09-12 15:37:36', NULL, NULL),
(3, 1, 'IYA', 'SAMIR', '', '', '97188172', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA SAMIR', '2023-09-13 12:50:00', NULL, NULL),
(4, 1, 'AMADJI PVP', 'EMILE', '', '', '97585900', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AMADJI PVP EMILE', '2023-09-13 12:50:00', NULL, NULL),
(5, 1, 'AKLO', 'ET FILS', '', '', '95818952', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AKLO ET FILS', '2023-09-13 12:50:00', NULL, NULL),
(6, 1, 'AYOURAF', 'FLORENTIN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AYOURAF FLORENTIN', '2023-09-13 12:50:00', NULL, NULL),
(7, 1, 'IYA', 'YOUSSOUF', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA YOUSSOUF', '2023-09-13 12:50:01', NULL, NULL),
(8, 1, 'MAMAN', 'MIDONBO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN MIDONBO', '2023-09-13 12:50:01', NULL, NULL),
(9, 1, 'OUTCHE', 'OUTCHE', '', '', '96672490', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'OUTCHE OUTCHE', '2023-09-13 12:50:01', NULL, NULL),
(10, 1, 'MAMAN', 'COCOTOMEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN COCOTOMEY', '2023-09-13 12:50:01', NULL, NULL),
(11, 1, 'IYA', 'TAMDA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA TAMDA', '2023-09-13 12:50:01', NULL, NULL),
(12, 1, 'IYA', 'RAK', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA RAK', '2023-09-13 12:50:01', NULL, NULL),
(13, 1, 'TANGADAROU', '-', '', '', '97517680', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TANGADAROU -', '2023-09-13 12:50:01', NULL, NULL),
(14, 1, 'MAMAN', 'PARAKOU', '', '', '97-00-70-17', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN PARAKOU', '2023-09-13 12:50:01', NULL, NULL),
(15, 1, 'PGD', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PGD PLOMBERIE', '2023-09-13 12:50:01', NULL, NULL),
(16, 1, 'TATA', 'AZIZATH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA AZIZATH', '2023-09-13 12:50:01', NULL, NULL),
(17, 1, 'MR', 'ABIODUN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ABIODUN', '2023-09-13 12:50:01', NULL, NULL),
(18, 1, 'MYRIAM', 'GBEGAMEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MYRIAM GBEGAMEY', '2023-09-13 12:50:01', NULL, NULL),
(19, 1, 'KIFFA', 'PLOMBERIE', '', '', '99 99 88 89', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'KIFFA PLOMBERIE', '2023-09-13 12:50:02', NULL, NULL),
(20, 1, 'JUMEAUX', 'INTER', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'JUMEAUX INTER', '2023-09-13 12:50:02', NULL, NULL),
(21, 1, 'LUCAS', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LUCAS PLOMBERIE', '2023-09-13 12:50:02', NULL, NULL),
(22, 1, 'GOMA', 'GOMA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'GOMA GOMA', '2023-09-13 12:50:02', NULL, NULL),
(23, 1, 'OPKE', 'YEMI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'OPKE YEMI', '2023-09-13 12:50:02', NULL, NULL),
(24, 1, 'ALEPH', 'PLUS', '', '', '98942750', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALEPH PLUS', '2023-09-13 12:50:02', NULL, NULL),
(25, 1, 'OTIS', 'OTIS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'OTIS OTIS', '2023-09-13 12:50:02', NULL, NULL),
(26, 1, 'IYA', 'BEDJI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA BEDJI', '2023-09-13 12:50:02', NULL, NULL),
(27, 1, 'PLOMBIER', 'AMBROISE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBIER AMBROISE', '2023-09-13 12:50:02', NULL, NULL),
(28, 1, 'MARO', 'MILLITAIRE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MARO MILLITAIRE', '2023-09-13 12:50:02', NULL, NULL),
(29, 1, 'MYRIAM', 'GBEGAMEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MYRIAM GBEGAMEY', '2023-09-13 12:50:02', NULL, NULL),
(30, 1, 'THANKS', 'WELL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'THANKS WELL', '2023-09-13 12:50:02', NULL, NULL),
(31, 1, 'MATIERE', 'PLUS', '', '', '97288081', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MATIERE PLUS', '2023-09-13 12:50:02', NULL, NULL),
(32, 1, 'IYA', 'NAFANE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA NAFANE', '2023-09-13 12:50:02', NULL, NULL),
(33, 1, 'PACIFIQUE', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PACIFIQUE PLOMBERIE', '2023-09-13 12:50:02', NULL, NULL),
(34, 1, 'STE', 'RITA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'STE RITA', '2023-09-13 12:50:02', NULL, NULL),
(35, 1, 'LE', 'BIEN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LE BIEN', '2023-09-13 12:50:02', NULL, NULL),
(36, 1, 'MACON', 'ALADJI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MACON ALADJI', '2023-09-13 12:50:02', NULL, NULL),
(37, 1, 'DOFFON', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DOFFON PLOMBERIE', '2023-09-13 12:50:02', NULL, NULL),
(38, 1, 'BARNABÉ', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BARNABÉ PLOMBERIE', '2023-09-13 12:50:02', NULL, NULL),
(39, 1, 'GLOBAL', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'GLOBAL PLOMBERIE', '2023-09-13 12:50:02', NULL, NULL),
(40, 1, 'MR', 'GABIN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR GABIN', '2023-09-13 12:50:02', NULL, NULL),
(41, 1, 'ALADJI', 'ABATTOIR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI ABATTOIR', '2023-09-13 12:50:02', NULL, NULL),
(42, 1, 'KOUDI', 'KOUDI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'KOUDI KOUDI', '2023-09-13 12:50:02', NULL, NULL),
(43, 1, 'TOSSAMAN', 'TOSSAMAN', '', '', '97600001', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TOSSAMAN TOSSAMAN', '2023-09-13 12:50:02', NULL, NULL),
(44, 1, 'CHANTIER', 'SEIVE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'CHANTIER SEIVE', '2023-09-13 12:50:02', NULL, NULL),
(45, 1, 'SALEY', 'ET FILS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SALEY ET FILS', '2023-09-13 12:50:02', NULL, NULL),
(46, 1, 'AYOKA', 'AYOKA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AYOKA AYOKA', '2023-09-13 12:50:02', NULL, NULL),
(47, 1, 'MELIA', 'SEDJRO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MELIA SEDJRO', '2023-09-13 12:50:02', NULL, NULL),
(48, 1, 'YELLOW', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'YELLOW PLOMBERIE', '2023-09-13 12:50:02', NULL, NULL),
(49, 1, 'TATA', 'SOBARA', '', '', '97719315', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA SOBARA', '2023-09-13 12:50:02', NULL, NULL),
(50, 1, 'PHARMACIE', 'SACREE-COEUR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PHARMACIE SACREE-COEUR', '2023-09-13 12:50:02', NULL, NULL),
(51, 1, 'IYA', 'MOUSTACHA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA MOUSTACHA', '2023-09-13 12:50:02', NULL, NULL),
(52, 1, 'QUINCA-', 'MABELLE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'QUINCA- MABELLE', '2023-09-13 12:50:03', NULL, NULL),
(53, 1, 'EMA', 'CO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'EMA CO', '2023-09-13 12:50:03', NULL, NULL),
(54, 1, 'COFFI', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'COFFI PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(55, 1, 'YOVO', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'YOVO PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(56, 1, 'MAMAN', 'PORTO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN PORTO', '2023-09-13 12:50:03', NULL, NULL),
(57, 1, 'SOEUR', 'DORA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOEUR DORA', '2023-09-13 12:50:03', NULL, NULL),
(58, 1, 'MAMAN', 'NAOMIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN NAOMIE', '2023-09-13 12:50:03', NULL, NULL),
(59, 1, 'PAAPA', 'CASIMIR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PAAPA CASIMIR', '2023-09-13 12:50:03', NULL, NULL),
(60, 1, 'MR', 'TONY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR TONY', '2023-09-13 12:50:03', NULL, NULL),
(61, 1, 'MME', 'AMOUSSOU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MME AMOUSSOU', '2023-09-13 12:50:03', NULL, NULL),
(62, 1, 'M.', 'TANTIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'M. TANTIE', '2023-09-13 12:50:03', NULL, NULL),
(63, 1, 'BERTIN', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BERTIN PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(64, 1, 'LE BIEN', 'BELLE-MERE', '', '', '97873910', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LE BIEN BELLE-MERE', '2023-09-13 12:50:03', NULL, NULL),
(65, 1, 'MR', 'ZAIKO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ZAIKO', '2023-09-13 12:50:03', NULL, NULL),
(66, 1, 'KOFFI', 'PLOMBERIE', '', '', '94144225', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'KOFFI PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(67, 1, 'MC', 'GROUPE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MC GROUPE', '2023-09-13 12:50:03', NULL, NULL),
(68, 1, 'PLOMBERIE', 'LA PAIX', '', '', '95405473', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE LA PAIX', '2023-09-13 12:50:03', NULL, NULL),
(69, 1, 'EPSI-', 'BENIN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'EPSI- BENIN', '2023-09-13 12:50:03', NULL, NULL),
(70, 1, 'JESUS SEUL', 'SOCI', '', '', '97515203', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'JESUS SEUL SOCI', '2023-09-13 12:50:03', NULL, NULL),
(71, 1, 'SALEM', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SALEM PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(72, 1, 'INGELEC-', 'MOCTAR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'INGELEC- MOCTAR', '2023-09-13 12:50:03', NULL, NULL),
(73, 1, 'ALADJI', 'CALAVI', '', '', '97029222', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI CALAVI', '2023-09-13 12:50:03', NULL, NULL),
(74, 1, 'MAMAN-', 'RO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN- RO', '2023-09-13 12:50:03', NULL, NULL),
(75, 1, 'ALADJA', 'MIDONBO', '', '', '97061824', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJA MIDONBO', '2023-09-13 12:50:03', NULL, NULL),
(76, 1, 'IYA', 'BASSIT', '', '', '97 59 37 72', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA BASSIT', '2023-09-13 12:50:03', NULL, NULL),
(77, 1, 'MHCV-', 'SARL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MHCV- SARL', '2023-09-13 12:50:03', NULL, NULL),
(78, 1, 'IYA -', 'MIZI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA - MIZI', '2023-09-13 12:50:03', NULL, NULL),
(79, 1, 'HEB AMOUR', 'ET FILS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'HEB AMOUR ET FILS', '2023-09-13 12:50:03', NULL, NULL),
(80, 1, 'BARNABE', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BARNABE PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(81, 1, 'ADA', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ADA PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(82, 1, 'ALIDOU', 'INGELEC', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALIDOU INGELEC', '2023-09-13 12:50:03', NULL, NULL),
(83, 1, 'GAS-', 'PLOMBERIE', '', '', '97984438', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'GAS- PLOMBERIE', '2023-09-13 12:50:03', NULL, NULL),
(84, 1, 'DIVINE', 'PENTECOTE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DIVINE PENTECOTE', '2023-09-13 12:50:03', NULL, NULL),
(85, 1, 'FRANCOIS', 'JAMTALEC', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'FRANCOIS JAMTALEC', '2023-09-13 12:50:04', NULL, NULL),
(86, 1, 'ALEXANDRE', 'CTPS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALEXANDRE CTPS', '2023-09-13 12:50:04', NULL, NULL),
(87, 1, 'PROVIDENCE', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PROVIDENCE PLOMBERIE', '2023-09-13 12:50:04', NULL, NULL),
(88, 1, 'JAFCO', '-', '', '', '66 63 15 31', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'JAFCO -', '2023-09-13 12:50:04', NULL, NULL),
(89, 1, 'COFFI', 'CTPS', '', '', '97 58 09 59', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'COFFI CTPS', '2023-09-13 12:50:04', NULL, NULL),
(90, 1, 'MAMAN -', 'AMBROISE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN - AMBROISE', '2023-09-13 12:50:04', NULL, NULL),
(91, 1, 'AYOURAF', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AYOURAF -', '2023-09-13 12:50:04', NULL, NULL),
(92, 1, 'MR', 'AIMEE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR AIMEE', '2023-09-13 12:50:04', NULL, NULL),
(93, 1, 'ABDEL', 'BOHICON', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ABDEL BOHICON', '2023-09-13 12:50:04', NULL, NULL),
(94, 1, 'ETS DIEU', 'MERCI', '', '', '97522293', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS DIEU MERCI', '2023-09-13 12:50:04', NULL, NULL),
(95, 1, 'MAOUENA', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAOUENA PLOMBERIE', '2023-09-13 12:50:04', NULL, NULL),
(96, 1, 'MKO', 'QUINCAILLERIE', '', '', '67981761', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MKO QUINCAILLERIE', '2023-09-13 12:50:04', NULL, NULL),
(97, 1, 'MR', 'ROMARIC', '', '', '97094412', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ROMARIC', '2023-09-13 12:50:04', NULL, NULL),
(98, 1, 'RABANI', 'INGELEC', '', '', '94 68 60 81', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'RABANI INGELEC', '2023-09-13 12:50:04', NULL, NULL),
(99, 1, 'CHOUKOURATH', 'BOHICON', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'CHOUKOURATH BOHICON', '2023-09-13 12:50:04', NULL, NULL),
(100, 1, 'CT-', 'PS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'CT- PS', '2023-09-13 12:50:04', NULL, NULL),
(101, 1, 'QUINCALLERIE', 'SAMBA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'QUINCALLERIE SAMBA', '2023-09-13 12:50:04', NULL, NULL),
(102, 1, 'PAPA', 'MISSIMAWU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PAPA MISSIMAWU', '2023-09-13 12:50:04', NULL, NULL),
(103, 1, 'CHITOU', 'AMAMATH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'CHITOU AMAMATH', '2023-09-13 12:50:04', NULL, NULL),
(104, 1, 'ETS GPAO', 'PLOMBERIE', '', '', '97091900', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS GPAO PLOMBERIE', '2023-09-13 12:50:04', NULL, NULL),
(105, 1, 'PLOMBERIE LA', 'SAGESSE', '', '', '96127401', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE LA SAGESSE', '2023-09-13 12:50:04', NULL, NULL),
(106, 1, 'PLOMBERIE STE', 'VIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE STE VIE', '2023-09-13 12:50:04', NULL, NULL),
(107, 1, 'MONTEIRO', 'JAMES', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MONTEIRO JAMES', '2023-09-13 12:50:04', NULL, NULL),
(108, 1, 'BAKI', 'INGELEC', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BAKI INGELEC', '2023-09-13 12:50:04', NULL, NULL),
(109, 1, 'IYA', 'TOLA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA TOLA', '2023-09-13 12:50:04', NULL, NULL),
(110, 1, 'STE', 'JANY', '', '', '67725343', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'STE JANY', '2023-09-13 12:50:04', NULL, NULL),
(111, 1, 'STE', 'JANY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'STE JANY', '2023-09-13 12:50:04', NULL, NULL),
(112, 1, 'RACHIDATH', 'NSIA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'RACHIDATH NSIA', '2023-09-13 12:50:04', NULL, NULL),
(113, 1, 'IYA FATAIL', 'QUINCA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA FATAIL QUINCA', '2023-09-13 12:50:04', NULL, NULL),
(114, 1, 'ETS', 'CHIFAO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS CHIFAO', '2023-09-13 12:50:05', NULL, NULL),
(115, 1, 'MR', 'DANIEL SH.', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR DANIEL SH.', '2023-09-13 12:50:05', NULL, NULL),
(116, 1, 'IYA', 'TINUNKE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA TINUNKE', '2023-09-13 12:50:05', NULL, NULL),
(117, 1, 'HEROS', 'NATIONAL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'HEROS NATIONAL', '2023-09-13 12:50:05', NULL, NULL),
(118, 1, 'MR', 'AROUNA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR AROUNA', '2023-09-13 12:50:05', NULL, NULL),
(119, 1, 'ETS PIS', 'ABOULL', '', '', '97250483', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS PIS ABOULL', '2023-09-13 12:50:05', NULL, NULL),
(120, 1, 'IYA', 'CHABI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA CHABI', '2023-09-13 12:50:05', NULL, NULL),
(121, 1, 'DIEU EST', 'GRAND', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DIEU EST GRAND', '2023-09-13 12:50:05', NULL, NULL),
(122, 1, 'DIRECTRICE MARIA', 'PLENA', '', '', '97288937', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DIRECTRICE MARIA PLENA', '2023-09-13 12:50:05', NULL, NULL),
(123, 1, 'MR', 'ALAIN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ALAIN', '2023-09-13 12:50:05', NULL, NULL),
(124, 1, 'IYA', 'RISSI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA RISSI', '2023-09-13 12:50:05', NULL, NULL),
(125, 1, 'TATA', 'HUGUETTE', '', '', '97045353', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA HUGUETTE', '2023-09-13 12:50:05', NULL, NULL),
(126, 1, 'ILLIASSOU', 'PLOMBERIE', '', '', '97878735', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ILLIASSOU PLOMBERIE', '2023-09-13 12:50:05', NULL, NULL),
(127, 1, 'ETS NOUTAI ET', 'FILS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS NOUTAI ET FILS', '2023-09-13 12:50:05', NULL, NULL),
(128, 1, 'SADICOU', 'SANAYA', '', '', '66594693', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SADICOU SANAYA', '2023-09-13 12:50:05', NULL, NULL),
(129, 1, 'ALADJI IYA', 'NAOFAN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI IYA NAOFAN', '2023-09-13 12:50:05', NULL, NULL),
(130, 1, 'ETS', 'SCHUMAN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS SCHUMAN', '2023-09-13 12:50:05', NULL, NULL),
(131, 1, 'MOHAMED -', 'ELECTR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MOHAMED - ELECTR', '2023-09-13 12:50:05', NULL, NULL),
(132, 1, 'ARISTRID', '-', '', '', '94231498', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ARISTRID -', '2023-09-13 12:50:05', NULL, NULL),
(133, 1, 'MR', 'ADESHOLA', '', '', '96534369', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ADESHOLA', '2023-09-13 12:50:05', NULL, NULL),
(134, 1, 'IYA', 'ASMA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA ASMA', '2023-09-13 12:50:05', NULL, NULL),
(135, 1, 'ENVOLE', 'DISTRIBUTION', '', '', '66 36 13 91', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ENVOLE DISTRIBUTION', '2023-09-13 12:50:05', NULL, NULL),
(136, 1, 'LA', 'FOIE', '', '', '95-15-26-71', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LA FOIE', '2023-09-13 12:50:05', NULL, NULL),
(137, 1, 'MR', 'RAHIMI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR RAHIMI', '2023-09-13 12:50:05', NULL, NULL),
(138, 1, 'DAC', 'BULDING', '', '', '96267133', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DAC BULDING', '2023-09-13 12:50:05', NULL, NULL),
(139, 1, 'ETS', 'CP', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS CP', '2023-09-13 12:50:05', NULL, NULL),
(140, 1, 'ETS', 'PLOMBELEC', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS PLOMBELEC', '2023-09-13 12:50:05', NULL, NULL),
(141, 1, 'PLOMBERIE', 'CPES', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE CPES', '2023-09-13 12:50:05', NULL, NULL),
(142, 1, 'ETS', 'L.G.', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS L.G.', '2023-09-13 12:50:05', NULL, NULL),
(143, 1, 'ETS', 'KYC', '', '', '97683901', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS KYC', '2023-09-13 12:50:05', NULL, NULL),
(144, 1, 'ETS', 'STE TRINITÉ', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS STE TRINITÉ', '2023-09-13 12:50:06', NULL, NULL),
(145, 1, 'MANOLÉ', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MANOLÉ PLOMBERIE', '2023-09-13 12:50:06', NULL, NULL),
(146, 1, 'SEIDATH', '-', '', '', '67067432', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SEIDATH -', '2023-09-13 12:50:06', NULL, NULL),
(147, 1, 'MAMAN', 'FOUMIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN FOUMIE', '2023-09-13 12:50:06', NULL, NULL),
(148, 1, 'PLOMBERIE', 'TCHÉNAWA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE TCHÉNAWA', '2023-09-13 12:50:06', NULL, NULL),
(149, 1, 'GLOBAL', 'ATTRACTION', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'GLOBAL ATTRACTION', '2023-09-13 12:50:06', NULL, NULL),
(150, 1, 'LEGENDE', 'GOLF', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LEGENDE GOLF', '2023-09-13 12:50:06', NULL, NULL),
(151, 1, 'MR', 'TUNDJI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR TUNDJI', '2023-09-13 12:50:06', NULL, NULL),
(152, 1, 'TATA', 'CHOUKOURATH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA CHOUKOURATH', '2023-09-13 12:50:06', NULL, NULL),
(153, 1, 'MR', 'COSSI', '', '', '97224358', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR COSSI', '2023-09-13 12:50:06', NULL, NULL),
(154, 1, 'MME', 'HODE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MME HODE', '2023-09-13 12:50:06', NULL, NULL),
(155, 1, 'ETS', 'AHOUSS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS AHOUSS', '2023-09-13 12:50:06', NULL, NULL),
(156, 1, 'BUSNESS', 'FLEURY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BUSNESS FLEURY', '2023-09-13 12:50:06', NULL, NULL),
(157, 1, 'BERTIN PORTO-', 'NOVO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BERTIN PORTO- NOVO', '2023-09-13 12:50:06', NULL, NULL),
(158, 1, 'ETS', 'MORENIKE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS MORENIKE', '2023-09-13 12:50:06', NULL, NULL),
(159, 1, 'MME', 'MOROU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MME MOROU', '2023-09-13 12:50:06', NULL, NULL),
(160, 1, 'PTR', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PTR -', '2023-09-13 12:50:06', NULL, NULL),
(161, 1, 'SOLEIL', 'SERVICE', '', '', '97339080', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOLEIL SERVICE', '2023-09-13 12:50:06', NULL, NULL),
(162, 1, 'ARNAUD', 'CTPS', '', '', '-*', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ARNAUD CTPS', '2023-09-13 12:50:06', NULL, NULL),
(163, 1, 'MR', 'JOEL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR JOEL', '2023-09-13 12:50:06', NULL, NULL),
(164, 1, 'SEMEVO', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SEMEVO -', '2023-09-13 12:50:06', NULL, NULL),
(165, 1, 'ALADJI', 'ILIASSOU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI ILIASSOU', '2023-09-13 12:50:06', NULL, NULL),
(166, 1, 'MR', 'EMILE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR EMILE', '2023-09-13 12:50:06', NULL, NULL),
(167, 1, 'BATI', 'MODERNE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BATI MODERNE', '2023-09-13 12:50:06', NULL, NULL),
(168, 1, 'QUALITY', 'CORPORATE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'QUALITY CORPORATE', '2023-09-13 12:50:06', NULL, NULL),
(169, 1, 'LGC', 'QUINCAILLERIE', '', '', '97207540', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LGC QUINCAILLERIE', '2023-09-13 12:50:06', NULL, NULL),
(170, 1, 'ETS LA', 'MADELENE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS LA MADELENE', '2023-09-13 12:50:07', NULL, NULL),
(171, 1, 'PLOMBERIE MARIE', 'MICHELLE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE MARIE MICHELLE', '2023-09-13 12:50:07', NULL, NULL),
(172, 1, 'AQUATIC', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AQUATIC -', '2023-09-13 12:50:07', NULL, NULL),
(173, 1, 'PLOMBERIE', 'MATH7-7', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE MATH7-7', '2023-09-13 12:50:07', NULL, NULL),
(174, 1, 'MR', 'LUCIEN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR LUCIEN', '2023-09-13 12:50:07', NULL, NULL),
(175, 1, 'MR', 'FELIX', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR FELIX', '2023-09-13 12:50:07', NULL, NULL),
(176, 1, 'MR', 'TONI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR TONI', '2023-09-13 12:50:07', NULL, NULL),
(177, 1, 'PLOMBIER', 'ISRAEL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBIER ISRAEL', '2023-09-13 12:50:07', NULL, NULL),
(178, 1, 'ETS', 'BERTONIM', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS BERTONIM', '2023-09-13 12:50:07', NULL, NULL),
(179, 1, 'ETS', 'GAMESSOU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS GAMESSOU', '2023-09-13 12:50:07', NULL, NULL),
(180, 1, 'DIDIER', 'MIRNAR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DIDIER MIRNAR', '2023-09-13 12:50:07', NULL, NULL),
(181, 1, 'BABA', 'ADJAGBE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BABA ADJAGBE', '2023-09-13 12:50:07', NULL, NULL),
(182, 1, 'EST', 'MARMACH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'EST MARMACH', '2023-09-13 12:50:07', NULL, NULL),
(183, 1, 'SHOLA', 'DE-CHACUS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SHOLA DE-CHACUS', '2023-09-13 12:50:07', NULL, NULL),
(184, 1, 'IYA', 'CHADE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA CHADE', '2023-09-13 12:50:07', NULL, NULL),
(185, 1, 'ALADJI', 'MOHAMED GBÉGAMEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI MOHAMED GBÉGAMEY', '2023-09-13 12:50:07', NULL, NULL),
(186, 1, 'SOEUR', 'BEDJI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOEUR BEDJI', '2023-09-13 12:50:07', NULL, NULL),
(187, 1, 'SEIDOU', 'ELECTRICITE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SEIDOU ELECTRICITE', '2023-09-13 12:50:07', NULL, NULL),
(188, 1, 'SKH', 'QUINCAILLERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SKH QUINCAILLERIE', '2023-09-13 12:50:07', NULL, NULL),
(189, 1, 'SOUDEUR', 'PORTO-NOVO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOUDEUR PORTO-NOVO', '2023-09-13 12:50:08', NULL, NULL),
(190, 1, 'SKH', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SKH -', '2023-09-13 12:50:08', NULL, NULL),
(191, 1, 'DIEU PEUT', 'TOUT', '', '', '97821439', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DIEU PEUT TOUT', '2023-09-13 12:50:08', NULL, NULL),
(192, 1, 'PLOMBERIE', 'AVOTROU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE AVOTROU', '2023-09-13 12:50:08', NULL, NULL),
(193, 1, 'PLOMBERIE', 'M.G', '', '', '96785673', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE M.G', '2023-09-13 12:50:08', NULL, NULL),
(194, 1, 'AMS', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AMS PLOMBERIE', '2023-09-13 12:50:08', NULL, NULL),
(195, 1, 'MR', 'MARCELLIN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR MARCELLIN', '2023-09-13 12:50:08', NULL, NULL),
(196, 1, 'ALADJI', 'DJOUGOU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI DJOUGOU', '2023-09-13 12:50:08', NULL, NULL),
(197, 1, 'PLOMBIER', 'SALEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBIER SALEY', '2023-09-13 12:50:08', NULL, NULL),
(198, 1, 'DJISSOU', 'NARCISSE', '', '', '66448623', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DJISSOU NARCISSE', '2023-09-13 12:50:08', NULL, NULL),
(199, 1, 'ETS', 'MARMECH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS MARMECH', '2023-09-13 12:50:08', NULL, NULL),
(200, 1, 'AGBOTON', 'MARCEL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AGBOTON MARCEL', '2023-09-13 12:50:08', NULL, NULL),
(201, 1, 'PLOMBERIE', 'GER', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE GER', '2023-09-13 12:50:08', NULL, NULL),
(202, 1, 'TPB LA', 'GLOIRE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TPB LA GLOIRE', '2023-09-13 12:50:08', NULL, NULL),
(203, 1, 'IYA', 'MOUBARAKATH', '', '', '97821162', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA MOUBARAKATH', '2023-09-13 12:50:08', NULL, NULL),
(204, 1, 'PHARMACIE', 'TAIFA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PHARMACIE TAIFA', '2023-09-13 12:50:08', NULL, NULL),
(205, 1, 'SO-', 'BRIDE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SO- BRIDE', '2023-09-13 12:50:08', NULL, NULL),
(206, 1, 'IYA', 'FAYANE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA FAYANE', '2023-09-13 12:50:08', NULL, NULL),
(207, 1, 'L.G. ET', 'FILS', '', '', '66-44-86-23', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'L.G. ET FILS', '2023-09-13 12:50:08', NULL, NULL),
(208, 1, 'MR', 'AGBOTON', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR AGBOTON', '2023-09-13 12:50:08', NULL, NULL),
(209, 1, 'WAKILATH', '-', '', '', '96900024', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'WAKILATH -', '2023-09-13 12:50:08', NULL, NULL),
(210, 1, 'PLOMBERIE DIEU ET', 'FILS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE DIEU ET FILS', '2023-09-13 12:50:08', NULL, NULL),
(211, 1, 'MAMAN', 'DIVINE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN DIVINE', '2023-09-13 12:50:08', NULL, NULL),
(212, 1, 'ETS', 'M.G.', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS M.G.', '2023-09-13 12:50:08', NULL, NULL),
(213, 1, 'ALADJI', 'PL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI PL', '2023-09-13 12:50:08', NULL, NULL),
(214, 1, 'QUINCOMO', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'QUINCOMO -', '2023-09-13 12:50:08', NULL, NULL),
(215, 1, 'TOSSOU', 'CLEMENT', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TOSSOU CLEMENT', '2023-09-13 12:50:08', NULL, NULL),
(216, 1, 'ALIOU', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALIOU -', '2023-09-13 12:50:08', NULL, NULL),
(217, 1, 'ETS', 'ABASS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS ABASS', '2023-09-13 12:50:08', NULL, NULL),
(218, 1, 'PLOMBERIE NOUVELLE', 'BENIN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE NOUVELLE BENIN', '2023-09-13 12:50:09', NULL, NULL),
(219, 1, 'ETS', 'FIFONSI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS FIFONSI', '2023-09-13 12:50:09', NULL, NULL),
(220, 1, 'SOPRUD-', 'INTER', '', '', '97-80-61-98', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOPRUD- INTER', '2023-09-13 12:50:09', NULL, NULL),
(221, 1, 'ETS', 'EFI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS EFI', '2023-09-13 12:50:09', NULL, NULL),
(222, 1, 'DPD LA', 'GLOIRE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DPD LA GLOIRE', '2023-09-13 12:50:09', NULL, NULL),
(223, 1, 'SAINTE', 'VILLE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SAINTE VILLE', '2023-09-13 12:50:09', NULL, NULL),
(224, 1, 'TOUT EST', 'GRACE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TOUT EST GRACE', '2023-09-13 12:50:09', NULL, NULL),
(225, 1, 'OLUWA', 'TOBI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'OLUWA TOBI', '2023-09-13 12:50:09', NULL, NULL),
(226, 1, 'FRERE', 'SOUDEUR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'FRERE SOUDEUR', '2023-09-13 12:50:09', NULL, NULL),
(227, 1, 'MADAME', 'ZAIKO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MADAME ZAIKO', '2023-09-13 12:50:09', NULL, NULL),
(228, 1, 'MR', 'FATAIL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR FATAIL', '2023-09-13 12:50:09', NULL, NULL),
(229, 1, 'ETS', 'HCB', '', '', '95069681', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS HCB', '2023-09-13 12:50:09', NULL, NULL),
(230, 1, 'NADJO', 'DON BOSCO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'NADJO DON BOSCO', '2023-09-13 12:50:09', NULL, NULL),
(231, 1, 'ETS', 'REHOBOTH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS REHOBOTH', '2023-09-13 12:50:09', NULL, NULL),
(232, 1, 'TAMAMA', 'TAMAMA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TAMAMA TAMAMA', '2023-09-13 12:50:09', NULL, NULL),
(233, 1, 'ATACORA', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ATACORA -', '2023-09-13 12:50:09', NULL, NULL),
(234, 1, 'ETS', 'ADEOSSI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS ADEOSSI', '2023-09-13 12:50:09', NULL, NULL),
(235, 1, 'ETS', 'ANLIAMINE', '', '', '', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS ANLIAMINE', '2023-09-13 12:50:09', NULL, NULL),
(236, 1, 'MR', 'ROBERT', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ROBERT', '2023-09-13 12:50:09', NULL, NULL),
(237, 1, '-', 'FATIMA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, '- FATIMA', '2023-09-13 12:50:09', NULL, NULL),
(238, 1, 'MADAME', 'NOELLIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MADAME NOELLIE', '2023-09-13 12:50:09', NULL, NULL),
(239, 1, 'GRACE', 'RICHE', '', '', '67305533', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'GRACE RICHE', '2023-09-13 12:50:09', NULL, NULL),
(240, 1, 'TATA', 'MOUFIDATH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA MOUFIDATH', '2023-09-13 12:50:09', NULL, NULL),
(241, 1, 'DINE', 'GBEGAMEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DINE GBEGAMEY', '2023-09-13 12:50:09', NULL, NULL),
(242, 1, 'SOURCE DE', 'VIE', '', '', '95860467', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOURCE DE VIE', '2023-09-13 12:50:09', NULL, NULL),
(243, 1, 'ETS', 'N.G. ET FILS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS N.G. ET FILS', '2023-09-13 12:50:09', NULL, NULL),
(244, 1, 'MAZOUK', 'GBEGAMEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAZOUK GBEGAMEY', '2023-09-13 12:50:09', NULL, NULL),
(245, 1, 'CARRELEUR', 'ALBERT', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'CARRELEUR ALBERT', '2023-09-13 12:50:10', NULL, NULL),
(246, 1, 'MAMAN', 'ISBATH', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN ISBATH', '2023-09-13 12:50:10', NULL, NULL),
(247, 1, '-', 'CHENIC', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, '- CHENIC', '2023-09-13 12:50:10', NULL, NULL),
(248, 1, 'ETS HCB', 'HEVIE BERTIN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS HCB HEVIE BERTIN', '2023-09-13 12:50:10', NULL, NULL),
(249, 1, 'IYA', 'BASSAM', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA BASSAM', '2023-09-13 12:50:10', NULL, NULL),
(250, 1, 'OLAIKAN', 'PLOMBERIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'OLAIKAN PLOMBERIE', '2023-09-13 12:50:10', NULL, NULL),
(251, 1, '-', 'AMADOU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, '- AMADOU', '2023-09-13 12:50:10', NULL, NULL),
(252, 1, 'MME', 'ABATTOIR', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MME ABATTOIR', '2023-09-13 12:50:10', NULL, NULL),
(253, 1, 'VICTOIRE', 'DIVINE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'VICTOIRE DIVINE', '2023-09-13 12:50:10', NULL, NULL),
(254, 1, 'AFRI', 'DISTRIBUTIONS SARL', '', '', '65791106', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AFRI DISTRIBUTIONS SARL', '2023-09-13 12:50:10', NULL, NULL),
(255, 1, 'DOCTEUR', 'JEAN-MARIE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DOCTEUR JEAN-MARIE', '2023-09-13 12:50:10', NULL, NULL),
(256, 1, 'SOCIETE', 'GROUPE LINK', '', '', '97381438', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOCIETE GROUPE LINK', '2023-09-13 12:50:10', NULL, NULL),
(257, 1, 'LAFIA', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LAFIA -', '2023-09-13 12:50:10', NULL, NULL),
(258, 1, 'MR', 'ROMUALD', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ROMUALD', '2023-09-13 12:50:10', NULL, NULL),
(259, 1, 'KMS', 'ADJEDE', '', '', '97419794', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'KMS ADJEDE', '2023-09-13 12:50:10', NULL, NULL),
(260, 1, 'ETS', 'LAURA DE GLOIRE', '', '', '96690040', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS LAURA DE GLOIRE', '2023-09-13 12:50:10', NULL, NULL),
(261, 1, 'TATA', 'HERMINE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA HERMINE', '2023-09-13 12:50:10', NULL, NULL),
(262, 1, 'ETS', 'EDEX S\'', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS EDEX S\'', '2023-09-13 12:50:10', NULL, NULL),
(263, 1, 'ADJIBI', 'ABEL', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ADJIBI ABEL', '2023-09-13 12:50:10', NULL, NULL),
(264, 1, 'MR', 'CISSE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR CISSE', '2023-09-13 12:50:10', NULL, NULL),
(265, 1, 'FAI', 'CONSTRUCTION', '', '', '97 68 39 01', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'FAI CONSTRUCTION', '2023-09-13 12:50:10', NULL, NULL),
(266, 1, 'PAROISE', 'TANTOT', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PAROISE TANTOT', '2023-09-13 12:50:10', NULL, NULL),
(267, 1, 'MR', 'ADEKANBI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ADEKANBI', '2023-09-13 12:50:10', NULL, NULL),
(268, 1, 'MR', 'MAROYA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR MAROYA', '2023-09-13 12:50:10', NULL, NULL),
(269, 1, 'MAMAN', 'GASTON', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN GASTON', '2023-09-13 12:50:10', NULL, NULL),
(270, 1, 'OLORUN', 'KAN', '', '', '66530318', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'OLORUN KAN', '2023-09-13 12:50:10', NULL, NULL),
(271, 1, 'LEGENDE', 'VERSEAU', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'LEGENDE VERSEAU', '2023-09-13 12:50:10', NULL, NULL),
(272, 1, 'IYA', 'DAYANE', '', '', '96035131', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA DAYANE', '2023-09-13 12:50:10', NULL, NULL),
(273, 1, 'MR AKPOVI', 'GEDEON', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR AKPOVI GEDEON', '2023-09-13 12:50:10', NULL, NULL),
(274, 1, 'MR', 'ROMARIC', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR ROMARIC', '2023-09-13 12:50:11', NULL, NULL),
(275, 1, 'MOANZOU', 'ELECTRICITE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MOANZOU ELECTRICITE', '2023-09-13 12:50:11', NULL, NULL),
(276, 1, 'MR MARTIN', 'DE-CHACUS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR MARTIN DE-CHACUS', '2023-09-13 12:50:11', NULL, NULL),
(277, 1, 'PDPA', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PDPA -', '2023-09-13 12:50:11', NULL, NULL),
(278, 1, 'ETS', 'JESUS EST VIVANT', '', '', '95 10 70 29', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS JESUS EST VIVANT', '2023-09-13 12:50:11', NULL, NULL),
(279, 1, 'IYA AMHED', 'GBEGAMEY', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA AMHED GBEGAMEY', '2023-09-13 12:50:11', NULL, NULL),
(280, 1, 'PLOMBERIE', 'LE MAJESTIC', '', '', '97 21 79 21', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE LE MAJESTIC', '2023-09-13 12:50:11', NULL, NULL),
(281, 1, '-', 'OUREKOU', '', '', '94-44-65-65', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, '- OUREKOU', '2023-09-13 12:50:11', NULL, NULL),
(282, 1, 'MAMAN WAKILATH', 'TOKPA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN WAKILATH TOKPA', '2023-09-13 12:50:11', NULL, NULL),
(283, 1, 'AUGUSTIN', 'PV ET FILS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AUGUSTIN PV ET FILS', '2023-09-13 12:50:11', NULL, NULL),
(284, 1, 'ELECTRO', 'DIVERS', '', '', '97-22-10-91', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ELECTRO DIVERS', '2023-09-13 12:50:11', NULL, NULL),
(285, 1, 'PLOMBIER', 'BENARD', '', '', '95 03 46 46', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBIER BENARD', '2023-09-13 12:50:11', NULL, NULL),
(286, 1, 'ETS', 'BABALOLA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS BABALOLA', '2023-09-13 12:50:11', NULL, NULL),
(287, 1, 'IYA', 'ATANDA', '', '', '97560833', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA ATANDA', '2023-09-13 12:50:11', NULL, NULL),
(288, 1, 'PAPA', 'MIDOMBO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PAPA MIDOMBO', '2023-09-13 12:50:11', NULL, NULL),
(289, 1, 'JPC', '-', '', '', '97 95 23 40', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'JPC -', '2023-09-13 12:50:11', NULL, NULL),
(290, 1, 'OLA OLUWA', 'STORE', '', '', '97 24 56 03', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'OLA OLUWA STORE', '2023-09-13 12:50:11', NULL, NULL),
(291, 1, 'ALBERT', 'PLOMBIER', '', '', '97067326', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALBERT PLOMBIER', '2023-09-13 12:50:11', NULL, NULL),
(292, 1, 'IYA', 'CHOUKOURATH BOHICON', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA CHOUKOURATH BOHICON', '2023-09-13 12:50:12', NULL, NULL),
(293, 1, 'MR', 'NESTOR', '', '', '97269712', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR NESTOR', '2023-09-13 12:50:12', NULL, NULL),
(294, 1, 'MR', 'LAURANT', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR LAURANT', '2023-09-13 12:50:12', NULL, NULL),
(295, 1, 'STE', 'BATIMAT', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'STE BATIMAT', '2023-09-13 12:50:12', NULL, NULL),
(296, 1, 'TATA', 'FLORA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA FLORA', '2023-09-13 12:50:12', NULL, NULL),
(297, 1, 'DOCTEUR', 'NADINE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DOCTEUR NADINE', '2023-09-13 12:50:12', NULL, NULL),
(298, 1, 'PLOMBIER', 'WEDO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBIER WEDO', '2023-09-13 12:50:12', NULL, NULL),
(299, 1, 'ETS IFE', 'LE BATISSEUR', '', '', '91 71 98 69', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS IFE LE BATISSEUR', '2023-09-13 12:50:12', NULL, NULL),
(300, 1, 'IYA', 'ALEIFA', '', '', '97 07 31 81', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA ALEIFA', '2023-09-13 12:50:12', NULL, NULL),
(301, 1, 'IYA ALADE', 'MME LE BIEN', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA ALADE MME LE BIEN', '2023-09-13 12:50:12', NULL, NULL),
(302, 1, 'IYA', 'NOURATOU', '', '', '97821321', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA NOURATOU', '2023-09-13 12:50:12', NULL, NULL),
(303, 1, 'MR', 'MOUBACHIROU', '', '', '97 24 56 03', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR MOUBACHIROU', '2023-09-13 12:50:12', NULL, NULL),
(304, 1, 'PLOMBERIE', 'PV ET FILS', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBERIE PV ET FILS', '2023-09-13 12:50:12', NULL, NULL),
(305, 1, 'MME', 'BAKARI', '', '', '97 19 77 21', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MME BAKARI', '2023-09-13 12:50:12', NULL, NULL),
(306, 1, 'ALADJI', 'LALA', '', '', '97 28 89 37', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJI LALA', '2023-09-13 12:50:12', NULL, NULL),
(307, 1, 'MAMAN', 'IYA NAFANE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN IYA NAFANE', '2023-09-13 12:50:12', NULL, NULL),
(308, 1, 'MME HOUNGNIBO', '-', '', '', '61 07 93 56', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MME HOUNGNIBO -', '2023-09-13 12:50:12', NULL, NULL),
(309, 1, 'TATA', 'ACHABI', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TATA ACHABI', '2023-09-13 12:50:12', NULL, NULL),
(310, 1, 'MAMAN', 'GOMEZ', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MAMAN GOMEZ', '2023-09-13 12:50:12', NULL, NULL),
(311, 1, 'MR GOMEZ', 'BOHICON', '', '', '66 40 81 92', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR GOMEZ BOHICON', '2023-09-13 12:50:12', NULL, NULL),
(312, 1, 'ALADJA', 'PK18', '', '', '97 68 72 09', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ALADJA PK18', '2023-09-13 12:50:12', NULL, NULL),
(313, 1, 'ETS ADJAHOSSI', 'ET FILS', '', '', '67 84 84 54', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS ADJAHOSSI ET FILS', '2023-09-13 12:50:13', NULL, NULL),
(314, 1, 'ETS', 'SELF-TRUST', '', '', '96 08 10 06', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS SELF-TRUST', '2023-09-13 12:50:13', NULL, NULL),
(315, 1, 'PLOMBIER', 'WASSIROU', '', '', '96 96 93 51', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PLOMBIER WASSIROU', '2023-09-13 12:50:13', NULL, NULL),
(316, 1, 'PAPA', 'PRINCE', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PAPA PRINCE', '2023-09-13 12:50:13', NULL, NULL),
(317, 1, 'MR', 'DINE', '', '', '97 25 83 52', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR DINE', '2023-09-13 12:50:13', NULL, NULL),
(318, 1, 'IYA CHOUKOURATH', 'GODOMEY', '', '', '97067953', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA CHOUKOURATH GODOMEY', '2023-09-13 12:50:13', NULL, NULL),
(319, 1, 'SOLDAT', 'DU CHRIST', '', '', '97390090', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SOLDAT DU CHRIST', '2023-09-13 12:50:13', NULL, NULL),
(320, 1, 'AYOUBA', '-', '', '', '97302594', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AYOUBA -', '2023-09-13 12:50:13', NULL, NULL),
(321, 1, 'TOUT', 'A TAIRE', '', '', '97482251', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'TOUT A TAIRE', '2023-09-13 12:50:13', NULL, NULL),
(322, 1, 'COCO', 'GEBA', '', '', '97764748', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'COCO GEBA', '2023-09-13 12:50:13', NULL, NULL),
(323, 1, 'GNONNAS', 'PLOMBERIE', '', '', '95657733', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'GNONNAS PLOMBERIE', '2023-09-13 12:50:13', NULL, NULL),
(324, 1, 'ETS BONTE ET', 'PAIX DE DIEU', '', '', '96056002', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS BONTE ET PAIX DE DIEU', '2023-09-13 12:50:13', NULL, NULL),
(325, 1, 'IBRAHIM', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IBRAHIM -', '2023-09-13 12:50:13', NULL, NULL),
(326, 1, 'IYA', 'BETTA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'IYA BETTA', '2023-09-13 12:50:13', NULL, NULL),
(327, 1, 'DIRECTRICE', 'NSIA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'DIRECTRICE NSIA', '2023-09-13 12:50:13', NULL, NULL),
(328, 1, 'ETAMAC', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETAMAC -', '2023-09-13 12:50:13', NULL, NULL),
(329, 1, 'MACON AGOSSA', 'BOGNON', '', '', '97764748', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MACON AGOSSA BOGNON', '2023-09-13 12:50:13', NULL, NULL),
(330, 1, 'SIBBA', 'PARAKOU', '', '', '94548492', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SIBBA PARAKOU', '2023-09-13 12:50:13', NULL, NULL),
(331, 1, 'CHADE', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'CHADE -', '2023-09-13 12:50:13', NULL, NULL),
(332, 1, 'ICHE', 'OLUWA', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ICHE OLUWA', '2023-09-13 12:50:13', NULL, NULL),
(333, 1, 'MR', 'AUREL', '', '', '97570889', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MR AUREL', '2023-09-13 12:50:13', NULL, NULL),
(334, 1, 'AMOUSSA', 'ISDINE', '', '', '61678387', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'AMOUSSA ISDINE', '2023-09-13 12:50:13', NULL, NULL),
(335, 1, 'BOLLALE', '-', '', '', '96898346', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'BOLLALE -', '2023-09-13 12:50:13', NULL, NULL);
INSERT INTO `client` (`id`, `point_vente_id`, `nom`, `prenom`, `adresse`, `email`, `telephone1`, `telephone2`, `raison_sociale`, `ifu`, `rccm`, `sigle`, `denomination`, `statut`, `date_nais`, `est_sup`, `nom_client`, `created_at`, `updated_at`, `deleted_at`) VALUES
(336, 1, 'PAPYRUS', '-', '', '', '66326646', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'PAPYRUS -', '2023-09-13 12:50:13', NULL, NULL),
(337, 1, 'SATI SARL', 'PARAKOU', '', '', '96261596', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SATI SARL PARAKOU', '2023-09-13 12:50:13', NULL, NULL),
(338, 1, 'MME', 'DONOUVO', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'MME DONOUVO', '2023-09-13 12:50:13', NULL, NULL),
(339, 1, 'SAM', '-', '', '', '-', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'SAM -', '2023-09-13 12:50:13', NULL, NULL),
(340, 1, 'ETS RICKYAKP', 'SERVICES', '', '', '60375272', NULL, '', NULL, NULL, '', '', 'Physique', NULL, NULL, 'ETS RICKYAKP SERVICES', '2023-09-13 12:50:13', NULL, NULL),
(341, 1, 'thyam', '-', '', '', '66499193', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'thyam -', '2023-09-13 14:17:07', '2023-09-13 14:17:08', NULL),
(342, 1, 'ETS', 'CHAHAM', '', '', '', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'ETS CHAHAM', '2023-09-13 14:25:08', '2023-09-13 14:25:08', NULL),
(343, 1, 'MARTIAL', 'SOHOU', '', '', '61661791', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'MARTIAL SOHOU', '2023-09-13 14:34:35', '2023-09-13 14:34:35', NULL),
(344, 1, 'ETS', 'OEE', '', '', '', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'ETS OEE', '2023-09-13 18:54:46', '2023-09-13 18:54:46', NULL),
(345, 1, 'GBEPAS', 'ET FILS', '', '', '97319278', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'GBEPAS ET FILS', '2023-09-14 13:51:16', '2023-09-14 13:51:16', NULL),
(346, 1, 'MR', 'PATRICE', '', '', '', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'MR PATRICE', '2023-09-15 15:55:52', '2023-09-15 15:55:52', NULL),
(347, 1, 'MR', 'JIREY', '', '', '99999999', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'MR JIREY', '2023-09-15 17:15:50', '2023-09-15 17:15:51', NULL),
(348, 1, 'IYA', 'MAYAMI', '', '', '97884138', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'IYA MAYAMI', '2023-09-18 13:50:42', '2023-09-18 13:50:43', NULL),
(349, 1, 'MR', 'GILBERT', '', '', '96785673', '', NULL, '', NULL, NULL, NULL, 'Physique', NULL, NULL, 'MR GILBERT', '2023-09-20 14:41:46', '2023-09-20 14:41:46', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `commande_client`
--

DROP TABLE IF EXISTS `commande_client`;
CREATE TABLE IF NOT EXISTS `commande_client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acheteur_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `model_signataire_id` int DEFAULT NULL,
  `date_com` datetime NOT NULL,
  `statut` varchar(255) NOT NULL,
  `montant_ht` decimal(10,2) NOT NULL,
  `montant_ttc` decimal(10,2) NOT NULL,
  `montant_tva` decimal(10,2) NOT NULL,
  `ref_com` varchar(100) DEFAULT NULL,
  `montant_rest` decimal(10,2) DEFAULT '0.00',
  `type_commande` varchar(255) NOT NULL,
  `type_facture` varchar(255) NOT NULL,
  `type_remise` varchar(255) DEFAULT NULL,
  `remise` decimal(10,2) DEFAULT NULL,
  `valeur_remise` varchar(255) DEFAULT NULL,
  `date_liv_prev` date DEFAULT NULL,
  `montant_ht_to_apr_rse` decimal(10,2) NOT NULL,
  `montant_ts` decimal(10,2) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `est_normalisee` tinyint(1) DEFAULT NULL,
  `statut_liv` varchar(255) NOT NULL,
  `montant_aib` decimal(10,2) NOT NULL,
  `taux_aib` int DEFAULT NULL,
  `motif_annulation` varchar(255) DEFAULT NULL,
  `pays_origine` varchar(255) DEFAULT NULL,
  `pays_destination` varchar(255) DEFAULT NULL,
  `lieu_chargement` varchar(255) DEFAULT NULL,
  `lieu_dechargement` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C510FF8096A7BB5F` (`acheteur_id`),
  KEY `IDX_C510FF80EFA24D68` (`point_vente_id`),
  KEY `IDX_C510FF803F192FC` (`operateur_id`),
  KEY `IDX_C510FF80D16C5631` (`model_signataire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `commande_client`
--

INSERT INTO `commande_client` (`id`, `acheteur_id`, `point_vente_id`, `operateur_id`, `model_signataire_id`, `date_com`, `statut`, `montant_ht`, `montant_ttc`, `montant_tva`, `ref_com`, `montant_rest`, `type_commande`, `type_facture`, `type_remise`, `remise`, `valeur_remise`, `date_liv_prev`, `montant_ht_to_apr_rse`, `montant_ts`, `est_sup`, `est_normalisee`, `statut_liv`, `montant_aib`, `taux_aib`, `motif_annulation`, `pays_origine`, `pays_destination`, `lieu_chargement`, `lieu_dechargement`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 315, 1, 2, 1, '2023-09-13 00:00:00', 'Payée', '22033.90', '26000.00', '3966.10', 'CO23000001', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-13', '22033.90', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:31:39', '2023-09-15 17:34:28', NULL),
(2, 321, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '25424.00', '30000.00', '4576.00', 'CO23000002', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '25424.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 12:10:35', '2023-09-15 17:35:49', NULL),
(3, 239, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '4661.00', '5500.00', '839.00', 'CO23000003', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '4661.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 12:25:27', '2023-09-15 17:39:38', NULL),
(4, 53, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '6356.00', '7500.00', '1144.00', 'CO23000004', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '6356.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:02:44', '2023-09-15 17:40:06', NULL),
(5, 235, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '7288.00', '8600.00', '1312.00', 'CO23000005', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '7288.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:04:56', '2023-09-15 17:40:52', NULL),
(6, 283, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '15678.00', '18500.00', '2822.00', 'CO23000006', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '15678.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:06:34', '2023-09-15 17:41:11', NULL),
(7, 341, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '125423.00', '148000.00', '22576.00', 'CO23000007', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '125423.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:17:07', '2023-09-15 17:41:38', NULL),
(8, 31, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '38136.00', '45000.00', '6864.00', 'CO23000008', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '38136.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:18:50', '2023-09-15 17:42:06', NULL),
(9, 19, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '95339.00', '112500.00', '17161.00', 'CO23000009', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '95339.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:20:13', '2023-09-15 17:42:23', NULL),
(10, 290, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '22881.00', '27000.00', '4119.00', 'CO23000010', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '22881.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:21:35', '2023-09-15 17:42:40', NULL),
(11, 342, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '279661.00', '330000.00', '50339.00', 'CO23000011', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '279661.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:25:08', '2023-09-15 17:42:57', NULL),
(12, 222, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '82627.00', '97500.00', '14873.00', 'CO23000012', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '82627.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:26:43', '2023-09-15 17:43:16', NULL),
(13, 12, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '94915.00', '112000.00', '17085.00', 'CO23000013', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '94915.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:27:44', '2023-09-15 17:43:35', NULL),
(14, 343, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '14407.00', '17000.00', '2593.00', 'CO23000014', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '14407.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:34:35', '2023-09-15 17:43:53', NULL),
(15, 290, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '22881.00', '27000.00', '4119.00', 'CO23000015', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '22881.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 15:45:03', '2023-09-15 17:44:16', NULL),
(16, 1, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '2119.00', '2500.00', '381.00', 'CO23000016', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '2119.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 15:46:07', '2023-09-15 17:44:40', NULL),
(17, 265, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '38136.00', '45000.00', '6864.00', 'CO23000017', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '38136.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 15:47:35', '2023-09-15 17:45:15', NULL),
(18, 33, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '133475.00', '157500.00', '24025.00', 'CO23000018', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '133475.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 15:48:42', '2023-09-15 17:45:37', NULL),
(19, 59, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '8983.00', '10600.00', '1617.00', 'CO23000019', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '8983.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 16:19:15', '2023-09-15 17:45:56', NULL),
(20, 27, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '6356.00', '7500.00', '1144.00', 'CO23000020', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '6356.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 16:29:06', '2023-09-15 17:46:19', NULL),
(21, 91, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '89831.00', '106000.00', '16169.00', 'CO23000021', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '89831.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 16:30:23', '2023-09-15 17:46:41', NULL),
(22, 235, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '80508.00', '95000.00', '14492.00', 'CO23000022', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '80508.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 18:42:29', '2023-09-15 17:47:02', NULL),
(23, 140, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '10170.00', '12000.00', '1831.00', 'CO23000023', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-13', '10170.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 18:48:26', '2023-09-15 17:47:33', NULL),
(24, 31, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '146186.00', '172500.00', '26314.00', 'CO23000024', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '146186.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 18:53:30', '2023-09-15 17:48:03', NULL),
(25, 344, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '64830.00', '76500.00', '11669.00', 'CO23000025', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '64830.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 18:54:46', '2023-09-15 17:48:40', NULL),
(26, 1, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '2373.00', '2800.00', '427.00', 'CO23000026', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '2373.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 18:55:55', '2023-09-15 17:49:04', NULL),
(27, 324, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '47034.00', '55500.00', '8466.00', 'CO23000027', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '47034.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 18:56:58', '2023-09-15 17:49:40', NULL),
(28, 25, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '3390.00', '4000.00', '610.00', 'CO23000028', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '3390.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:00:48', '2023-09-15 17:50:27', NULL),
(29, 41, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '31356.00', '37000.00', '5644.00', 'CO23000029', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '31356.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:01:53', '2023-09-15 17:51:20', NULL),
(30, 305, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '69915.00', '82500.00', '12585.00', 'CO23000030', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '69915.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:05:45', '2023-09-15 17:52:02', NULL),
(31, 12, 1, 3, 1, '2023-09-13 00:00:00', 'En attente', '155932.00', '184000.00', '28068.00', 'CO23000031', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-13', '155932.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:09:13', '2023-09-15 17:52:35', NULL),
(32, 256, 1, 3, 1, '2023-09-13 00:00:00', 'En attente', '101695.00', '120000.00', '18305.00', 'CO23000032', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-13', '101695.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:10:24', '2023-09-15 17:52:55', NULL),
(33, 305, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '94915.00', '112000.00', '17085.00', 'CO23000033', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '94915.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:25:56', '2023-09-15 17:53:44', NULL),
(34, 228, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '52881.00', '62400.00', '9519.00', 'CO23000034', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '52881.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:27:10', '2023-09-15 17:54:15', NULL),
(35, 280, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '29237.00', '34500.00', '5263.00', 'CO23000035', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '29237.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:28:30', '2023-09-15 17:54:35', NULL),
(36, 113, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '50847.00', '60000.00', '9153.00', 'CO23000036', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '50847.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:29:25', '2023-09-15 17:54:58', NULL),
(37, 140, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '29661.00', '35000.00', '5339.00', 'CO23000037', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '29661.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:30:14', '2023-09-15 17:55:16', NULL),
(38, 22, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '21864.00', '25800.00', '3936.00', 'CO23000038', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '21864.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:31:41', '2023-09-15 17:55:36', NULL),
(39, 1, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '55085.00', '65000.00', '9915.00', 'CO23000039', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '55085.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:32:24', '2023-09-15 17:55:54', NULL),
(40, 94, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '312288.00', '368500.00', '56212.00', 'CO23000040', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '312288.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:37:22', '2023-09-15 17:56:12', NULL),
(41, 139, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '52966.00', '62500.00', '9534.00', 'CO23000041', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '52966.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:40:38', '2023-09-15 17:56:41', NULL),
(42, 113, 1, 3, 1, '2023-09-13 00:00:00', 'Payée', '48814.00', '57600.00', '8786.00', 'CO23000042', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-13', '48814.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:41:24', '2023-09-15 17:56:59', NULL),
(43, 64, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '22458.00', '26500.00', '4042.00', 'CO23000043', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '22458.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 07:47:52', '2023-09-15 17:57:16', NULL),
(44, 326, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '141526.00', '167000.00', '25475.00', 'CO23000044', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '141526.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 07:50:05', '2023-09-15 17:57:39', NULL),
(45, 220, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '50847.00', '60000.00', '9153.00', 'CO23000045', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '50847.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 07:51:10', '2023-09-15 17:57:59', NULL),
(46, 323, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '52966.00', '62500.00', '9534.00', 'CO23000046', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '52966.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 07:52:03', '2023-09-15 17:58:25', NULL),
(47, 1, 1, 4, 1, '2023-09-14 00:00:00', 'Annuler', '2034.00', '2400.00', '366.00', 'CO23000047', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '2034.00', '0.00', 1, NULL, 'Non livrée', '0.00', NULL, 'ERREUR DE QUANTITE', NULL, NULL, NULL, NULL, '2023-09-14 07:55:01', '2023-09-14 08:07:45', '2023-09-14 08:07:45'),
(48, 1, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '36780.00', '43400.00', '6620.00', 'CO23000048', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '36780.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 07:55:49', '2023-09-15 17:58:44', NULL),
(49, 343, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '19576.00', '23100.00', '3524.00', 'CO23000049', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '19576.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 07:59:32', '2023-09-15 17:59:08', NULL),
(50, 73, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '307203.00', '362500.00', '55297.00', 'CO23000050', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '307203.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:02:14', '2023-09-15 17:59:29', NULL),
(51, 112, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '72034.00', '85000.00', '12966.00', 'CO23000051', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '72034.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:05:50', '2023-09-15 17:59:49', NULL),
(52, 35, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '3814.00', '4500.00', '686.00', 'CO23000052', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '3814.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:07:06', '2023-09-15 18:00:07', NULL),
(53, 1, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '6610.00', '7800.00', '1190.00', 'CO23000053', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '6610.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:08:58', '2023-09-15 18:00:24', NULL),
(54, 321, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '141526.00', '167000.00', '25475.00', 'CO23000054', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '141526.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:13:05', '2023-09-15 18:00:42', NULL),
(55, 181, 1, 2, 1, '2023-09-14 00:00:00', 'Payée', '132203.00', '156000.00', '23797.00', 'CO23000055', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '132203.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:17:21', '2023-09-15 18:01:23', NULL),
(56, 256, 1, 3, 1, '2023-09-14 00:00:00', 'En attente', '44068.00', '52000.00', '7932.00', 'CO23000056', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '44068.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:20:58', '2023-09-15 18:01:52', NULL),
(57, 66, 1, 2, 1, '2023-09-14 00:00:00', 'Annuler', '156780.00', '185000.00', '28220.00', 'CO23000057', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '156780.00', '0.00', 1, NULL, 'Non livrée', '0.00', NULL, 'ERREUR DE QUANTITIES', NULL, NULL, NULL, NULL, '2023-09-14 08:25:32', '2023-09-15 16:45:02', '2023-09-15 16:45:02'),
(58, 27, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '26949.00', '31800.00', '4851.00', 'CO23000058', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '26949.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:26:20', '2023-09-15 18:02:11', NULL),
(59, 239, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '84746.00', '100000.00', '15254.00', 'CO23000059', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '84746.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:27:40', '2023-09-15 18:02:34', NULL),
(60, 35, 1, 2, 1, '2023-09-14 00:00:00', 'Payée', '13983.00', '16500.00', '2517.00', 'CO23000060', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '13983.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:36:01', '2023-09-15 18:02:57', NULL),
(61, 7, 1, 3, 1, '2023-09-14 00:00:00', 'Partielle', '137288.00', '162000.00', '24712.00', 'CO23000061', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '137288.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:36:53', '2023-09-15 18:03:18', NULL),
(62, 146, 1, 2, 1, '2023-09-14 00:00:00', 'Payée', '54237.00', '64000.00', '9763.00', 'CO23000062', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '54237.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:37:25', '2023-09-15 18:03:44', NULL),
(63, 35, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '9534.00', '11250.00', '1716.00', 'CO23000063', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '9534.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:40:54', '2023-09-15 18:04:00', NULL),
(64, 228, 1, 2, 1, '2023-09-14 00:00:00', 'En attente', '105763.00', '124800.00', '19037.00', 'CO23000064', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '105763.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:42:54', '2023-09-15 18:04:22', NULL),
(65, 263, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '15805.00', '18650.00', '2845.00', 'CO23000065', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '15805.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:53:57', '2023-09-15 18:04:58', NULL),
(66, 68, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '35593.00', '42000.00', '6407.00', 'CO23000066', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '35593.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 08:55:19', '2023-09-15 18:05:30', NULL),
(67, 1, 1, 2, 1, '2023-09-14 00:00:00', 'Payée', '21186.00', '25000.00', '3814.00', 'CO23000067', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '21186.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 09:20:47', '2023-09-15 18:05:48', NULL),
(68, 272, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '96610.00', '114000.00', '17390.00', 'CO23000068', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '96610.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 09:37:24', '2023-09-15 18:06:15', NULL),
(69, 171, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '19068.00', '22500.00', '3432.00', 'CO23000069', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '19068.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 09:38:49', '2023-09-15 18:07:17', NULL),
(70, 20, 1, 3, 1, '2023-09-14 00:00:00', 'En attente', '8898.00', '10500.00', '1602.00', 'CO23000070', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '8898.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 09:40:10', '2023-09-15 18:08:17', NULL),
(71, 228, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '42627.00', '50300.00', '7673.00', 'CO23000071', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '42627.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 09:50:24', '2023-09-15 18:08:57', NULL),
(72, 27, 1, 2, 1, '2023-09-14 00:00:00', 'Payée', '54661.00', '64500.00', '9839.00', 'CO23000072', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '54661.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 09:54:39', '2023-09-15 18:09:24', NULL),
(73, 27, 1, 2, 1, '2023-09-14 00:00:00', 'En attente', '68814.00', '81200.00', '12386.00', 'CO23000073', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '68814.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 09:59:32', '2023-09-15 18:10:29', NULL),
(74, 12, 1, 2, 1, '2023-09-14 00:00:00', 'Payée', '71186.00', '84000.00', '12814.00', 'CO23000074', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '71186.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 10:00:47', '2023-09-15 18:10:50', NULL),
(75, 35, 1, 2, 1, '2023-09-14 00:00:00', 'Payée', '1398.00', '1650.00', '252.00', 'CO23000075', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '1398.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 10:06:13', '2023-09-15 18:11:32', NULL),
(76, 140, 1, 2, 1, '2023-09-14 00:00:00', 'En attente', '322034.00', '380000.00', '57966.00', 'CO23000076', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '322034.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 10:09:57', '2023-09-15 18:12:07', NULL),
(77, 53, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '29322.00', '34600.00', '5278.00', 'CO23000077', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '29322.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:03:08', '2023-09-15 18:12:49', NULL),
(78, 123, 1, 3, 1, '2023-09-14 00:00:00', 'En attente', '35000.00', '41300.00', '6300.00', 'CO23000078', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '35000.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:15', NULL),
(79, 59, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '89831.00', '106000.00', '16169.00', 'CO23000079', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '89831.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:25:10', '2023-09-15 18:13:48', NULL),
(80, 335, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '57203.00', '67500.00', '10297.00', 'CO23000080', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '57203.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:26:59', '2023-09-15 18:14:09', NULL),
(81, 223, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '5085.00', '6000.00', '915.00', 'CO23000081', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '5085.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:28:07', '2023-09-15 18:14:26', NULL),
(82, 1, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '424.00', '500.00', '76.00', 'CO23000082', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '424.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:28:42', '2023-09-15 18:14:49', NULL),
(83, 315, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '21186.00', '25000.00', '3814.00', 'CO23000083', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '21186.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:29:37', '2023-09-15 18:15:19', NULL),
(84, 23, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '110170.00', '130000.00', '19831.00', 'CO23000084', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '110170.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:31:35', '2023-09-15 18:15:41', NULL),
(85, 345, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '923559.00', '1089800.00', '166241.00', 'CO23000085', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '923559.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:51:16', '2023-09-15 18:16:30', NULL),
(86, 31, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '56525.00', '66700.00', '10175.00', 'CO23000086', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '56525.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:52:21', '2023-09-15 18:17:05', NULL),
(87, 59, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '19068.00', '22500.00', '3432.00', 'CO23000087', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '19068.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:54:04', '2023-09-15 18:17:41', NULL),
(88, 140, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '31780.00', '37500.00', '5720.00', 'CO23000088', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '31780.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 13:55:14', '2023-09-15 18:18:06', NULL),
(89, 1, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '847.00', '1000.00', '153.00', 'CO23000089', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '847.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 14:08:40', '2023-09-15 18:18:47', NULL),
(90, 344, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '7288.00', '8600.00', '1312.00', 'CO23000090', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '7288.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 14:11:04', '2023-09-15 18:19:19', NULL),
(91, 228, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '19492.00', '23000.00', '3508.00', 'CO23000091', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '19492.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 14:11:52', '2023-09-15 18:19:37', NULL),
(92, 133, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '89407.00', '105500.00', '16093.00', 'CO23000092', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '89407.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 14:13:12', '2023-09-15 18:19:56', NULL),
(93, 41, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '14407.00', '17000.00', '2593.00', 'CO23000093', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '14407.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 14:58:50', '2023-09-15 18:20:22', NULL),
(94, 218, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '605935.00', '715000.00', '109065.00', 'CO23000094', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '605935.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:44:19', '2023-09-15 18:20:42', NULL),
(95, 66, 1, 3, 1, '2023-09-14 00:00:00', 'En attente', '298306.00', '352000.00', '53694.00', 'CO23000095', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '298306.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:46:58', '2023-09-15 18:21:01', NULL),
(96, 218, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '367797.00', '434000.00', '66202.00', 'CO23000096', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '367797.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:52:31', '2023-09-15 18:21:18', NULL),
(97, 5, 1, 3, 1, '2023-09-14 00:00:00', 'En attente', '520764.00', '614500.00', '93736.00', 'CO23000097', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '520764.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:56:25', '2023-09-15 18:21:38', NULL),
(98, 100, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '257966.00', '304400.00', '46434.00', 'CO23000098', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '257966.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:58:22', '2023-09-19 12:16:41', NULL),
(99, 3, 1, 3, 1, '2023-09-14 00:00:00', 'En attente', '1732881.00', '2044800.00', '311919.00', 'CO23000099', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '1732881.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 16:04:33', '2023-09-15 18:22:15', NULL),
(100, 305, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '10593.00', '12500.00', '1907.00', 'CO23000100', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '10593.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 16:05:33', '2023-09-18 12:35:16', NULL),
(101, 41, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '66102.00', '78000.00', '11898.00', 'CO23000101', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '66102.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 16:14:49', '2023-09-15 18:22:56', NULL),
(102, 116, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '259830.00', '306600.00', '46770.00', 'CO23000102', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '259830.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 16:16:25', '2023-09-21 16:31:35', NULL),
(103, 38, 1, 3, 1, '2023-09-14 00:00:00', 'Partielle', '118644.00', '140000.00', '21356.00', 'CO23000103', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '118644.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 16:17:46', '2023-09-15 18:23:51', NULL),
(104, 107, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '125425.00', '148000.00', '22575.00', 'CO23000104', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '125425.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:33:43', '2023-09-15 18:24:09', NULL),
(105, 339, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '115721.00', '136550.00', '20829.00', 'CO23000105', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '115721.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:41:25', '2023-09-15 18:24:29', NULL),
(106, 303, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '8220.00', '9700.00', '1480.00', 'CO23000106', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '8220.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:55:22', '2023-09-15 18:25:12', NULL),
(107, 1, 1, 4, 1, '2023-09-14 00:00:00', 'Payée', '147564.00', '174125.00', '26561.00', 'CO23000107', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-14', '147564.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:49', NULL),
(108, 31, 1, 3, 1, '2023-09-14 00:00:00', 'Payée', '112712.00', '133000.00', '20288.00', 'CO23000108', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-14', '112712.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 18:02:52', '2023-09-15 18:26:13', NULL),
(109, 12, 1, 1, 1, '2023-09-15 00:00:00', 'Payée', '266950.00', '315000.00', '48052.00', 'CO23000109', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '266950.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 14:01:39', '2023-09-15 18:26:31', NULL),
(110, 21, 1, 3, 1, '2023-09-15 00:00:00', 'Partielle', '1397032.00', '1648500.00', '251468.00', 'CO23000110', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '1397032.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:48', NULL),
(111, 73, 1, 1, 1, '2023-09-15 00:00:00', 'Payée', '77712.00', '91700.00', '13988.00', 'CO23000111', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '77712.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 15:02:02', '2023-09-15 18:27:13', NULL),
(112, 341, 1, 3, 1, '2023-09-15 00:00:00', 'Payée', '31356.00', '37000.00', '5644.00', 'CO23000112', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-15', '31356.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 15:05:51', '2023-09-15 18:24:50', NULL),
(113, 346, 1, 3, 1, '2023-09-15 00:00:00', 'Payée', '115254.00', '136000.00', '20746.00', 'CO23000113', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-15', '115254.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 15:55:52', '2023-09-15 18:27:34', NULL),
(114, 181, 1, 3, 1, '2023-09-15 00:00:00', 'Payée', '255932.00', '302000.00', '46068.00', 'CO23000114', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-15', '255932.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 15:57:04', '2023-09-15 18:27:50', NULL),
(115, 256, 1, 3, 1, '2023-09-15 00:00:00', 'En attente', '70339.00', '83000.00', '12661.00', 'CO23000115', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '70339.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:04:43', '2023-09-15 18:28:13', NULL),
(116, 220, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '86018.00', '101500.00', '15483.00', 'CO23000116', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '86018.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:10:23', '2023-09-15 18:28:36', NULL),
(117, 286, 1, 3, 1, '2023-09-15 00:00:00', 'Payée', '337712.00', '398500.00', '60788.00', 'CO23000117', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-15', '337712.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:10:41', '2023-09-15 18:28:58', NULL),
(118, 46, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '21186.00', '25000.00', '3814.00', 'CO23000118', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '21186.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:13:08', '2023-09-15 18:29:22', NULL),
(119, 53, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '51525.00', '60800.00', '9275.00', 'CO23000119', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '51525.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:21:00', '2023-09-15 18:29:57', NULL),
(120, 146, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '19068.00', '22500.00', '3432.00', 'CO23000120', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '19068.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:22:33', '2023-09-15 18:30:18', NULL),
(121, 107, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '36017.00', '42500.00', '6483.00', 'CO23000121', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '36017.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:26:41', '2023-09-16 10:51:50', NULL),
(122, 303, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '16187.00', '19100.00', '2913.00', 'CO23000122', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '16187.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:27:55', '2023-09-15 18:30:55', NULL),
(123, 234, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '15254.00', '18000.00', '2746.00', 'CO23000123', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '15254.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:33:20', '2023-09-15 18:31:13', NULL),
(124, 66, 1, 2, 1, '2023-09-15 00:00:00', 'En attente', '1525420.00', '1800000.00', '274580.00', 'CO23000124', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '1525420.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:50:37', '2023-09-15 18:31:30', NULL),
(125, 209, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '379407.00', '447700.00', '68293.00', 'CO23000125', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '379407.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 17:00:44', '2023-09-15 18:32:20', NULL),
(126, 228, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '23136.00', '27300.00', '4164.00', 'CO23000126', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '23136.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 17:01:31', '2023-09-15 18:33:12', NULL),
(127, 64, 1, 2, 1, '2023-09-15 00:00:00', 'En attente', '243899.00', '287800.00', '43901.00', 'CO23000127', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '243899.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 17:07:10', '2023-09-15 18:33:36', NULL),
(128, 1, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '39407.00', '46500.00', '7093.00', 'CO23000128', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '39407.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 17:09:50', '2023-09-15 18:33:54', NULL),
(129, 347, 1, 2, 1, '2023-09-15 00:00:00', 'Payée', '11356.00', '13400.00', '2045.00', 'CO23000129', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-15', '11356.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:11', NULL),
(130, 133, 1, 3, 1, '2023-09-16 00:00:00', 'Payée', '46610.00', '55000.00', '8390.00', 'CO23000130', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-16', '46610.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-16 10:25:52', '2023-09-16 14:13:02', NULL),
(131, 256, 1, 3, 1, '2023-09-16 00:00:00', 'En attente', '53749.00', '63425.00', '9676.00', 'CO23000131', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-16', '53749.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:31', NULL),
(132, 135, 1, 3, 1, '2023-09-16 00:00:00', 'Payée', '81144.00', '95750.00', '14607.00', 'CO23000132', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-16', '81144.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-16 12:08:56', '2023-09-16 14:15:14', NULL),
(133, 35, 1, 3, 1, '2023-09-16 00:00:00', 'Payée', '9322.00', '11000.00', '1678.00', 'CO23000133', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-16', '9322.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-16 13:42:08', '2023-09-16 14:15:33', NULL),
(134, 20, 1, 3, 1, '2023-09-18 00:00:00', 'En attente', '715676.00', '844500.00', '128823.00', 'CO23000134', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-18', '715677.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 09:02:50', '2023-09-18 10:12:24', NULL),
(135, 113, 1, 3, 1, '2023-09-18 00:00:00', 'Payée', '50847.00', '60000.00', '9153.00', 'CO23000135', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-18', '50847.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 09:26:54', '2023-09-18 10:13:30', NULL),
(136, 66, 1, 2, 1, '2023-09-18 00:00:00', 'En attente', '2338984.00', '2760000.00', '421017.00', 'CO23000136', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-18', '2338983.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 10:05:07', '2023-09-18 10:13:48', NULL),
(137, 337, 1, 3, 1, '2023-09-18 00:00:00', 'Payée', '88984.00', '105000.00', '16016.00', 'CO23000137', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-18', '88984.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 10:19:57', '2023-09-18 12:27:26', NULL),
(138, 31, 1, 3, 1, '2023-09-18 00:00:00', 'Payée', '152542.00', '180000.00', '27458.00', 'CO23000138', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-18', '152542.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 11:22:55', '2023-09-18 12:27:44', NULL),
(139, 1, 1, 3, 1, '2023-09-18 00:00:00', 'Payée', '8475.00', '10000.00', '1525.00', 'CO23000139', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-18', '8475.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 12:24:27', '2023-09-18 12:27:58', NULL),
(140, 76, 1, 2, 1, '2023-09-18 00:00:00', 'Partielle', '190678.00', '225000.00', '34322.00', 'CO23000140', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-18', '190678.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 12:26:51', '2023-09-19 09:21:24', NULL),
(141, 348, 1, 3, 1, '2023-09-18 00:00:00', 'Payée', '64491.00', '76100.00', '11609.00', 'CO23000141', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-18', '64491.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 13:50:42', '2023-09-18 14:12:48', NULL),
(142, 273, 1, 2, 1, '2023-09-18 00:00:00', 'En attente', '379660.00', '448000.00', '68340.00', 'CO23000142', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-18', '379660.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 14:30:18', '2023-09-18 14:30:58', NULL),
(143, 232, 1, 3, 1, '2023-09-18 00:00:00', 'Payée', '480933.00', '567500.00', '86568.00', 'CO23000143', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-18', '480932.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 14:32:18', '2023-09-18 14:42:42', NULL),
(144, 21, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '433051.00', '511000.00', '77949.00', 'CO23000144', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-19', '433051.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 08:42:58', '2023-09-19 08:43:45', NULL),
(145, 209, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '97458.00', '115000.00', '17542.00', 'CO23000145', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-19', '97458.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 08:45:17', '2023-09-19 08:49:19', NULL),
(146, 107, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '65678.00', '77500.00', '11823.00', 'CO23000146', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-19', '65677.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 10:09:16', '2023-09-19 10:10:40', NULL),
(147, 323, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '33899.00', '40000.00', '6102.00', 'CO23000147', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-19', '33898.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 10:19:24', '2023-09-19 10:20:51', NULL),
(148, 138, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '137713.00', '162500.00', '24787.00', 'CO23000148', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-19', '137713.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 11:20:34', '2023-09-19 11:55:03', NULL),
(149, 305, 1, 3, 1, '2023-09-19 00:00:00', 'Partielle', '165256.00', '195000.00', '29746.00', 'CO23000149', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-19', '165254.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 11:26:19', '2023-09-22 16:22:59', NULL),
(150, 228, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '23136.00', '27300.00', '4164.00', 'CO23000150', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-19', '23136.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 11:40:48', '2023-09-19 11:54:28', NULL),
(151, 333, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '508475.00', '600000.00', '91525.00', 'CO23000151', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-19', '508475.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 12:03:26', '2023-09-19 15:34:45', NULL),
(152, 73, 1, 3, 1, '2023-09-19 00:00:00', 'Payée', '152542.00', '180000.00', '27458.00', 'CO23000152', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-19', '152542.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-19 16:00:13', '2023-09-19 16:01:32', NULL),
(153, 4, 1, 3, 1, '2023-09-20 00:00:00', 'En attente', '91525.00', '108000.00', '16475.00', 'CO23000153', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '91525.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 08:10:47', '2023-09-20 10:42:59', NULL),
(154, 252, 1, 3, 1, '2023-09-20 00:00:00', 'Payée', '66102.00', '78000.00', '11898.00', 'CO23000154', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '66102.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 08:36:17', '2023-09-20 10:43:11', NULL),
(155, 228, 1, 2, 1, '2023-09-20 00:00:00', 'Payée', '42628.00', '50300.00', '7672.00', 'CO23000155', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '42628.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 10:42:30', '2023-09-20 10:43:26', NULL),
(156, 1, 1, 2, 1, '2023-09-20 00:00:00', 'Payée', '5508.00', '6500.00', '992.00', 'CO23000156', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '5508.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 11:07:25', '2023-09-20 11:42:11', NULL),
(157, 165, 1, 2, 1, '2023-09-20 00:00:00', 'Payée', '72881.00', '86000.00', '13118.00', 'CO23000157', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '72882.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 11:49:09', '2023-09-20 14:51:59', NULL),
(158, 1, 1, 3, 1, '2023-09-20 00:00:00', 'Payée', '25508.00', '30100.00', '4592.00', 'CO23000158', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '25508.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 12:07:47', '2023-09-20 12:10:10', NULL),
(159, 305, 1, 3, 1, '2023-09-20 00:00:00', 'En attente', '51907.00', '61250.00', '9343.00', 'CO23000159', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '51907.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 12:27:36', '2023-09-20 12:32:17', NULL),
(160, 1, 1, 2, 1, '2023-09-20 00:00:00', 'Annuler', '86355.00', '101900.00', '15545.00', 'CO23000160', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '86355.00', '0.00', 1, NULL, 'Terminée', '0.00', NULL, 'ERREUR DE PRODUIT', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:59:32', '2023-09-20 12:59:32'),
(161, 161, 1, 3, 1, '2023-09-20 00:00:00', 'Payée', '104026.00', '122750.00', '18724.00', 'CO23000161', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '104026.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 12:46:56', '2023-09-20 13:05:42', NULL),
(162, 256, 1, 3, 1, '2023-09-20 00:00:00', 'En attente', '96019.00', '113300.00', '17281.00', 'CO23000162', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '96019.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:55', NULL),
(163, 79, 1, 3, 1, '2023-09-20 00:00:00', 'Payée', '20339.00', '24000.00', '3661.00', 'CO23000163', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '20339.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 14:15:51', '2023-09-20 14:16:35', NULL),
(164, 349, 1, 2, 1, '2023-09-20 00:00:00', 'Payée', '296610.00', '350000.00', '53390.00', 'CO23000164', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '296610.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 14:41:46', '2023-09-20 14:45:56', NULL);
INSERT INTO `commande_client` (`id`, `acheteur_id`, `point_vente_id`, `operateur_id`, `model_signataire_id`, `date_com`, `statut`, `montant_ht`, `montant_ttc`, `montant_tva`, `ref_com`, `montant_rest`, `type_commande`, `type_facture`, `type_remise`, `remise`, `valeur_remise`, `date_liv_prev`, `montant_ht_to_apr_rse`, `montant_ts`, `est_sup`, `est_normalisee`, `statut_liv`, `montant_aib`, `taux_aib`, `motif_annulation`, `pays_origine`, `pays_destination`, `lieu_chargement`, `lieu_dechargement`, `created_at`, `updated_at`, `deleted_at`) VALUES
(165, 1, 1, 3, 1, '2023-09-20 00:00:00', 'Payée', '48729.00', '57500.00', '8771.00', 'CO23000165', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '48729.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 15:13:16', '2023-09-20 16:45:47', NULL),
(166, 342, 1, 3, 1, '2023-09-20 00:00:00', 'Payée', '432203.00', '510000.00', '77796.00', 'CO23000166', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '432204.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 15:55:44', '2023-09-20 16:45:32', NULL),
(167, 1, 1, 3, 1, '2023-09-20 00:00:00', 'En attente', '86355.00', '101900.00', '15545.00', 'CO23000167', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '86355.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:04', NULL),
(168, 1, 1, 3, 1, '2023-09-20 00:00:00', 'Payée', '7288.00', '8600.00', '1312.00', 'CO23000168', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-20', '7288.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 16:43:19', '2023-09-20 16:44:47', NULL),
(169, 100, 1, 3, 1, '2023-09-20 00:00:00', 'En attente', '338984.00', '400000.00', '61017.00', 'CO23000169', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-20', '338983.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-20 16:47:30', '2023-09-20 16:48:03', NULL),
(170, 145, 1, 2, 1, '2023-09-21 00:00:00', 'Partielle', '793137.00', '935900.00', '142764.00', 'CO23000170', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '793136.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:51:53', NULL),
(171, 67, 1, 3, 1, '2023-09-21 00:00:00', 'Payée', '31779.00', '37500.00', '5721.00', 'CO23000171', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-21', '31779.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 10:38:39', '2023-09-21 11:18:55', NULL),
(172, 113, 1, 3, 1, '2023-09-21 00:00:00', 'Payée', '50847.00', '60000.00', '9153.00', 'CO23000172', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-21', '50847.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 11:08:47', '2023-09-21 11:19:25', NULL),
(173, 69, 1, 2, 1, '2023-09-21 00:00:00', 'Payée', '973732.00', '1149000.00', '175272.00', 'CO23000173', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '973728.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 12:18:39', '2023-09-21 12:20:18', NULL),
(174, 5, 1, 2, 1, '2023-09-21 00:00:00', 'Annuler', '127965.00', '151000.00', '23035.00', 'CO23000174', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '127965.00', '0.00', 1, NULL, 'Terminée', '0.00', NULL, 'ERREUR DE PRIX', NULL, NULL, NULL, NULL, '2023-09-21 12:24:52', '2023-09-21 12:40:44', '2023-09-21 12:40:44'),
(175, 279, 1, 3, 1, '2023-09-21 00:00:00', 'Payée', '41949.00', '49500.00', '7551.00', 'CO23000175', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-21', '41949.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 12:36:53', '2023-09-21 12:45:26', NULL),
(176, 12, 1, 3, 1, '2023-09-21 00:00:00', 'Payée', '54237.00', '64000.00', '9763.00', 'CO23000176', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-21', '54237.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 13:09:42', '2023-09-21 15:11:54', NULL),
(177, 113, 1, 3, 1, '2023-09-21 00:00:00', 'Payée', '81356.00', '96000.00', '14644.00', 'CO23000177', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-21', '81356.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 13:35:59', '2023-09-21 15:11:45', NULL),
(178, 252, 1, 3, 1, '2023-09-21 00:00:00', 'En attente', '288136.00', '340000.00', '51864.00', 'CO23000178', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '288136.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 15:15:38', '2023-09-21 15:16:41', NULL),
(179, 5, 1, 3, 1, '2023-09-21 00:00:00', 'En attente', '125000.00', '147500.00', '22500.00', 'CO23000179', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '125000.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 15:20:58', '2023-09-21 15:21:38', NULL),
(180, 106, 1, 2, 1, '2023-09-21 00:00:00', 'Payée', '25424.00', '30000.00', '4576.00', 'CO23000180', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '25424.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:16:17', '2023-09-21 16:19:19', NULL),
(181, 78, 1, 2, 1, '2023-09-21 00:00:00', 'Payée', '101695.00', '120000.00', '18305.00', 'CO23000181', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '101695.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:34:22', '2023-09-21 16:39:01', NULL),
(182, 276, 1, 3, 1, '2023-09-21 00:00:00', 'En attente', '10169.00', '12000.00', '1831.00', 'CO23000182', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '10169.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:42:18', '2023-09-21 16:51:56', NULL),
(183, 50, 1, 2, 1, '2023-09-21 00:00:00', 'En attente', '27966.00', '33000.00', '5034.00', 'CO23000183', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-21', '27966.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:50:44', '2023-09-21 16:52:09', NULL),
(184, 228, 1, 3, 1, '2023-09-22 00:00:00', 'Payée', '52881.00', '62400.00', '9519.00', 'CO23000184', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-22', '52881.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 10:32:53', '2023-09-22 11:55:01', NULL),
(185, 309, 1, 3, 1, '2023-09-22 00:00:00', 'Payée', '57627.00', '68000.00', '10373.00', 'CO23000185', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-22', '57627.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 11:21:33', '2023-09-22 11:55:14', NULL),
(186, 181, 1, 3, 1, '2023-09-22 00:00:00', 'En attente', '105932.00', '125000.00', '19068.00', 'CO23000186', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-22', '105932.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 11:41:10', '2023-09-22 11:55:24', NULL),
(187, 181, 1, 3, 1, '2023-09-22 00:00:00', 'En attente', '114407.00', '135000.00', '20593.00', 'CO23000187', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-22', '114407.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 12:17:37', '2023-09-22 12:50:38', NULL),
(188, 227, 1, 2, 1, '2023-09-22 00:00:00', 'Payée', '33474.00', '39500.00', '6026.00', 'CO23000188', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-22', '33474.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 12:48:16', '2023-09-22 12:55:56', NULL),
(189, 26, 1, 2, 1, '2023-09-22 00:00:00', 'Payée', '38136.00', '45000.00', '6864.00', 'CO23000189', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-22', '38136.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 12:49:15', '2023-09-22 12:55:34', NULL),
(190, 7, 1, 2, 1, '2023-09-22 00:00:00', 'Payée', '16949.00', '20000.00', '3051.00', 'CO23000190', NULL, 'Sur Commande', 'FV', NULL, NULL, NULL, '2023-09-22', '16949.00', '0.00', NULL, NULL, 'Terminée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 13:39:16', '2023-09-22 14:44:17', NULL),
(191, 81, 1, 3, 1, '2023-09-22 00:00:00', 'Payée', '27967.00', '33000.00', '5033.00', 'CO23000191', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-22', '27967.00', '0.00', NULL, NULL, 'Non livrée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 15:26:26', '2023-09-22 15:26:28', NULL),
(192, 43, 1, 3, 1, '2023-09-22 00:00:00', 'Payée', '246186.00', '290500.00', '44314.00', 'CO23000192', NULL, 'Au comptoir', 'FV', NULL, NULL, NULL, '2023-09-22', '246186.00', '0.00', NULL, NULL, 'Non livrée', '0.00', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 16:00:48', '2023-09-22 16:00:50', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `commande_frs`
--

DROP TABLE IF EXISTS `commande_frs`;
CREATE TABLE IF NOT EXISTS `commande_frs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fournisseur_id` int DEFAULT NULL,
  `demande_de_prix_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `date_com_frs` datetime NOT NULL,
  `montant_total` decimal(10,2) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `ref_com` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_604E4222670C757F` (`fournisseur_id`),
  KEY `IDX_604E42225E931ED0` (`demande_de_prix_id`),
  KEY `IDX_604E4222EFA24D68` (`point_vente_id`),
  KEY `IDX_604E42223F192FC` (`operateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

DROP TABLE IF EXISTS `compte`;
CREATE TABLE IF NOT EXISTS `compte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `fournisseur_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `intitule` varchar(255) NOT NULL,
  `solde` decimal(10,2) NOT NULL,
  `solde_initial` decimal(10,2) NOT NULL DEFAULT '0.00',
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CFF6526019EB6921` (`client_id`),
  KEY `IDX_CFF65260670C757F` (`fournisseur_id`),
  KEY `IDX_CFF65260EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `compte_banque`
--

DROP TABLE IF EXISTS `compte_banque`;
CREATE TABLE IF NOT EXISTS `compte_banque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `societe_id` int NOT NULL,
  `banque_id` int NOT NULL,
  `numero_compte_bq` varchar(255) NOT NULL,
  `solde_compte_bq` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6B6F920BFCF77503` (`societe_id`),
  KEY `IDX_6B6F920B37E080D9` (`banque_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `conditionnement`
--

DROP TABLE IF EXISTS `conditionnement`;
CREATE TABLE IF NOT EXISTS `conditionnement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `code_cond` varchar(255) NOT NULL,
  `libelle_cond` varchar(255) NOT NULL,
  `valeur` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3F4BEA3AEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `conditionnement`
--

INSERT INTO `conditionnement` (`id`, `point_vente_id`, `code_cond`, `libelle_cond`, `valeur`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'UNI', 'UNITE', '1', NULL, '2023-09-12 15:37:37', NULL, NULL),
(2, 1, 'BOIT', 'BOITE', NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(3, 1, 'ROUL', 'ROULEAU', NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(4, 1, 'CART', 'CARTON', NULL, NULL, '2023-09-16 14:46:04', '2023-09-16 14:46:04', NULL),
(5, 1, 'DOUZ', 'DOUZAINE', NULL, NULL, '2023-09-13 15:39:26', '2023-09-13 15:39:26', NULL),
(6, 1, 'PAIR', 'PAIRE', NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(7, 1, 'SACH', 'SACHET', NULL, NULL, '2023-09-12 15:42:23', NULL, NULL),
(8, 1, 'CAIS', 'CAISSE', NULL, NULL, '2023-09-15 11:55:39', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE IF NOT EXISTS `configuration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `format_impression` varchar(255) DEFAULT NULL,
  `impression_personnalise_elements` tinyint(1) DEFAULT NULL,
  `impression_sans_entete` tinyint(1) DEFAULT NULL,
  `est_mode_carreau` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `configuration`
--

INSERT INTO `configuration` (`id`, `format_impression`, `impression_personnalise_elements`, `impression_sans_entete`, `est_mode_carreau`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'A4', 0, 0, 1, '2023-09-12 15:37:37', '2023-09-13 10:10:38', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `demande_de_prix`
--

DROP TABLE IF EXISTS `demande_de_prix`;
CREATE TABLE IF NOT EXISTS `demande_de_prix` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fournisseur_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `date_ddp` datetime NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `est_transformer` tinyint(1) DEFAULT NULL,
  `ref_ddp` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E6B3FF96670C757F` (`fournisseur_id`),
  KEY `IDX_E6B3FF96EFA24D68` (`point_vente_id`),
  KEY `IDX_E6B3FF963F192FC` (`operateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `depense`
--

DROP TABLE IF EXISTS `depense`;
CREATE TABLE IF NOT EXISTS `depense` (
  `id` int NOT NULL AUTO_INCREMENT,
  `caisse_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `type_depense_id` int DEFAULT NULL,
  `motif` varchar(255) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `beneficiere` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `date_dep` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3405975727B4FEBF` (`caisse_id`),
  KEY `IDX_34059757A76ED395` (`user_id`),
  KEY `IDX_34059757EFA24D68` (`point_vente_id`),
  KEY `IDX_340597575CDBC346` (`type_depense_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `depense`
--

INSERT INTO `depense` (`id`, `caisse_id`, `user_id`, `point_vente_id`, `type_depense_id`, `motif`, `montant`, `beneficiere`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `date_dep`) VALUES
(1, 5, NULL, 1, 3, 'pour le tricycle', '600.00', 'julien', NULL, NULL, NULL, NULL, NULL),
(2, 5, NULL, 1, 7, 'pour tontine', '200000.00', 'tontinier', NULL, NULL, NULL, NULL, NULL),
(3, 5, NULL, 1, 8, 'vente', '3500.00', 'mc groupe', NULL, NULL, NULL, NULL, NULL),
(4, 5, NULL, 1, 9, 'pour achat de siphon evier', '1600.00', 'Mme', NULL, NULL, NULL, NULL, NULL),
(5, 7, NULL, 1, 11, 'forfait appel', '1000.00', 'STE maria plena', NULL, NULL, NULL, NULL, NULL),
(6, 7, NULL, 1, 9, 'main d\'oeuvre', '34000.00', 'soudeur', NULL, NULL, NULL, NULL, NULL),
(7, 7, NULL, 1, 10, 'papier ram', '2700.00', 'STE maria plena', NULL, NULL, NULL, NULL, NULL),
(8, 7, NULL, 1, 8, 'frais momo', '4000.00', 'lucas', NULL, '2023-09-19 15:41:29', '2023-09-19 15:41:29', NULL, NULL),
(9, 7, NULL, 1, 3, 'deplacement', '1000.00', 'chauffeur de maman mael', NULL, NULL, NULL, NULL, NULL),
(10, 7, NULL, 1, 3, 'chez Mme', '300.00', 'Ephraim', NULL, NULL, NULL, NULL, NULL),
(11, 9, NULL, 1, 3, 'tokpa pour tablette', '600.00', 'julien', NULL, '2023-09-20 14:53:53', '2023-09-20 14:53:53', NULL, NULL),
(12, 9, NULL, 1, 9, 'lampe pour le tricycle', '500.00', 'julien', NULL, NULL, NULL, NULL, NULL),
(13, 9, NULL, 1, 9, 'transfert momo', '6200.00', 'Mme léa josephine', NULL, NULL, NULL, NULL, NULL),
(14, 9, NULL, 1, 9, 'Réduction facture', '1500.00', 'Prête', NULL, NULL, NULL, NULL, NULL),
(15, 9, NULL, 1, 9, 'réduction facture', '1000.00', 'aladji iliassou', NULL, NULL, NULL, NULL, NULL),
(16, 9, NULL, 1, 4, 'eau minéral', '1400.00', 'Mme', NULL, NULL, NULL, NULL, NULL),
(17, 9, NULL, 1, 9, 'PAPIER TOILETTE', '2000.00', 'MARIA PLENA', NULL, NULL, NULL, NULL, NULL),
(18, 9, NULL, 1, 3, 'déplacement', '500.00', 'Mr Alimi', NULL, NULL, NULL, NULL, NULL),
(19, 9, NULL, 1, 3, 'déplacement', '250.00', 'julien', NULL, NULL, NULL, NULL, NULL),
(20, 9, NULL, 1, 7, 'pour la tontine', '100000.00', 'tontinier', NULL, NULL, NULL, NULL, NULL),
(21, 9, NULL, 1, 9, 'Dépôt momo', '20350.00', 'jacques martin K.', NULL, NULL, NULL, NULL, NULL),
(22, 9, NULL, 1, 3, 'livraison CTPS', '600.00', 'Raymond', NULL, NULL, NULL, NULL, NULL),
(23, 11, NULL, 1, 9, 'Réduction facture', '4000.00', 'EPSI-BENIN', NULL, NULL, NULL, NULL, NULL),
(24, 11, NULL, 1, 4, 'Eau minéral gazéifié', '500.00', 'Mr Martin', NULL, NULL, NULL, NULL, NULL),
(25, 11, NULL, 1, 9, 'réduction facture', '1000.00', 'iya rak', NULL, NULL, NULL, NULL, NULL),
(26, 11, NULL, 1, 5, 'voiture de Mme', '500.00', 'ruffin', NULL, NULL, NULL, NULL, NULL),
(27, 11, NULL, 1, 4, 'rechange bombonne d\'eau', '1800.00', 'Maria Plena', NULL, '2023-09-21 15:26:54', '2023-09-21 15:26:54', NULL, '2023-09-21 15:26:54'),
(28, 11, NULL, 1, 12, 'quittance', '200.00', 'mc groupe', NULL, '2023-09-21 15:26:54', NULL, NULL, '2023-09-21 15:26:54'),
(29, 11, NULL, 1, 2, 'groupe', '4000.00', 'Maria Plena', NULL, '2023-09-21 15:26:54', NULL, NULL, '2023-09-21 15:26:54'),
(30, 11, NULL, 1, 3, 'déplacement', '300.00', 'ruffin', NULL, '2023-09-21 15:26:54', NULL, NULL, '2023-09-21 15:26:54'),
(31, 11, NULL, 1, 5, 'réparation tricycle', '25000.00', 'mécanicien tricycle', NULL, '2023-09-21 15:26:54', NULL, NULL, '2023-09-21 15:26:54'),
(32, 11, NULL, 1, 9, 'SGBB banque', '700.00', 'wilfried', NULL, '2023-09-21 15:26:54', NULL, NULL, '2023-09-21 15:26:54'),
(33, 13, NULL, 1, 9, 'achat de robinet lavabo chez le bien', '3500.00', 'Mme', NULL, '2023-09-22 17:34:26', NULL, NULL, '2023-09-22 17:34:26'),
(34, 13, NULL, 1, 11, 'pour la boutique', '1000.00', 'Maria Plena', NULL, '2023-09-22 17:34:26', NULL, NULL, '2023-09-22 17:34:26'),
(35, 13, NULL, 1, 11, 'forfait appel', '2500.00', 'Mme', NULL, '2023-09-22 17:34:26', NULL, NULL, '2023-09-22 17:34:26'),
(36, 13, NULL, 1, 3, 'jafco', '500.00', 'wilfried', NULL, '2023-09-22 17:34:26', NULL, NULL, '2023-09-22 17:34:26');

-- --------------------------------------------------------

--
-- Structure de la table `detachement`
--

DROP TABLE IF EXISTS `detachement`;
CREATE TABLE IF NOT EXISTS `detachement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_det_id` int DEFAULT NULL,
  `magasin_id` int DEFAULT NULL,
  `date_det` datetime DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_29275FF56B7A2406` (`user_det_id`),
  KEY `IDX_29275FF520096AE3` (`magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `detachement`
--

INSERT INTO `detachement` (`id`, `user_det_id`, `magasin_id`, `date_det`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2023-09-15 00:00:00', NULL, NULL, NULL, NULL),
(2, 1, 1, '2023-09-15 00:00:00', NULL, NULL, NULL, NULL),
(3, 2, 1, '2023-09-18 00:00:00', NULL, NULL, NULL, NULL),
(4, 2, 1, '2023-09-18 00:00:00', NULL, NULL, NULL, NULL),
(5, 2, 1, '2023-09-18 00:00:00', NULL, NULL, NULL, NULL),
(6, 2, 1, '2023-09-18 00:00:00', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230922150121', '2023-09-22 15:01:45', 81318);

-- --------------------------------------------------------

--
-- Structure de la table `element_supplementaire`
--

DROP TABLE IF EXISTS `element_supplementaire`;
CREATE TABLE IF NOT EXISTS `element_supplementaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_client_id` int NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `taille_police` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_33DFDCA39E73363` (`commande_client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

DROP TABLE IF EXISTS `facture`;
CREATE TABLE IF NOT EXISTS `facture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_cli_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `date_fac` datetime NOT NULL,
  `montant_total` decimal(10,2) NOT NULL,
  `ref_fac` varchar(100) NOT NULL,
  `statut` varchar(100) NOT NULL,
  `montant_total_cmd` decimal(10,0) DEFAULT NULL,
  `montant_rest` decimal(10,0) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `mecef_date` varchar(255) DEFAULT NULL,
  `mecef_qr_code` varchar(255) DEFAULT NULL,
  `mecef_code` varchar(255) DEFAULT NULL,
  `mecef_compteur` varchar(255) DEFAULT NULL,
  `mecef_nim` varchar(255) DEFAULT NULL,
  `est_normalisee` tinyint(1) DEFAULT NULL,
  `type_facture` varchar(255) NOT NULL DEFAULT 'FV',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FE866410BE1A1965` (`commande_cli_id`),
  KEY `IDX_FE866410EFA24D68` (`point_vente_id`),
  KEY `IDX_FE8664103F192FC` (`operateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `facture`
--

INSERT INTO `facture` (`id`, `commande_cli_id`, `point_vente_id`, `operateur_id`, `date_fac`, `montant_total`, `ref_fac`, `statut`, `montant_total_cmd`, `montant_rest`, `est_sup`, `mecef_date`, `mecef_qr_code`, `mecef_code`, `mecef_compteur`, `mecef_nim`, `est_normalisee`, `type_facture`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 2, '2023-09-13 10:31:39', '26000.00', 'FA23000001', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 10:31:39', '2023-09-14 10:24:20', NULL),
(2, 2, 1, 3, '2023-09-13 12:10:35', '30000.00', 'FA23000002', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 12:10:35', '2023-09-13 12:10:39', NULL),
(3, 3, 1, 3, '2023-09-13 12:25:27', '5500.00', 'FA23000003', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 12:25:27', '2023-09-13 12:25:29', NULL),
(4, 4, 1, 3, '2023-09-13 14:02:44', '7500.00', 'FA23000004', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:02:44', '2023-09-13 14:02:46', NULL),
(5, 5, 1, 3, '2023-09-13 14:04:56', '8600.00', 'FA23000005', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:04:56', '2023-09-13 14:04:57', NULL),
(6, 6, 1, 3, '2023-09-13 14:06:34', '18500.00', 'FA23000006', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:06:34', '2023-09-13 14:06:36', NULL),
(7, 7, 1, 3, '2023-09-13 14:17:07', '148000.00', 'FA23000007', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:17:07', '2023-09-13 14:17:17', NULL),
(8, 8, 1, 3, '2023-09-13 14:18:50', '45000.00', 'FA23000008', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:18:50', '2023-09-13 14:18:52', NULL),
(9, 9, 1, 3, '2023-09-13 14:20:13', '112500.00', 'FA23000009', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:20:13', '2023-09-13 14:20:15', NULL),
(10, 10, 1, 3, '2023-09-13 14:21:35', '27000.00', 'FA23000010', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:21:35', '2023-09-13 14:21:36', NULL),
(11, 11, 1, 3, '2023-09-13 14:25:08', '330000.00', 'FA23000011', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:25:08', '2023-09-13 14:25:12', NULL),
(12, 12, 1, 3, '2023-09-13 14:26:43', '97500.00', 'FA23000012', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:26:43', '2023-09-13 14:26:47', NULL),
(13, 13, 1, 3, '2023-09-13 14:27:44', '112000.00', 'FA23000013', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:27:44', '2023-09-13 14:27:46', NULL),
(14, 14, 1, 3, '2023-09-13 14:34:35', '17000.00', 'FA23000014', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 14:34:35', '2023-09-13 14:34:53', NULL),
(15, 15, 1, 3, '2023-09-13 15:45:03', '27000.00', 'FA23000015', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 15:45:03', '2023-09-13 15:45:05', NULL),
(16, 16, 1, 3, '2023-09-13 15:46:07', '2500.00', 'FA23000016', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 15:46:07', '2023-09-13 15:46:09', NULL),
(17, 17, 1, 3, '2023-09-13 15:47:35', '45000.00', 'FA23000017', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 15:47:35', '2023-09-13 15:47:37', NULL),
(18, 18, 1, 3, '2023-09-13 15:48:42', '157500.00', 'FA23000018', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 15:48:42', '2023-09-13 15:48:44', NULL),
(19, 19, 1, 3, '2023-09-13 16:19:15', '10600.00', 'FA23000019', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 16:19:15', '2023-09-13 16:19:22', NULL),
(20, 20, 1, 3, '2023-09-13 16:29:06', '7500.00', 'FA23000020', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 16:29:06', '2023-09-13 16:29:07', NULL),
(21, 21, 1, 3, '2023-09-13 16:30:23', '106000.00', 'FA23000021', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 16:30:23', '2023-09-13 16:30:25', NULL),
(22, 22, 1, 3, '2023-09-13 18:42:29', '95000.00', 'FA23000022', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 18:42:29', '2023-09-13 18:42:52', NULL),
(23, 23, 1, 3, '2023-09-13 18:48:26', '12000.00', 'FA23000023', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 18:48:26', '2023-09-14 13:56:14', NULL),
(24, 24, 1, 3, '2023-09-13 18:53:30', '172500.00', 'FA23000024', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 18:53:30', '2023-09-13 18:53:32', NULL),
(25, 25, 1, 3, '2023-09-13 18:54:46', '76500.00', 'FA23000025', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 18:54:46', '2023-09-13 18:54:47', NULL),
(26, 26, 1, 3, '2023-09-13 18:55:55', '2800.00', 'FA23000026', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 18:55:55', '2023-09-13 18:55:58', NULL),
(27, 27, 1, 3, '2023-09-13 18:56:58', '55500.00', 'FA23000027', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 18:56:58', '2023-09-13 18:57:00', NULL),
(28, 28, 1, 3, '2023-09-13 19:00:48', '4000.00', 'FA23000028', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:00:48', '2023-09-13 19:00:50', NULL),
(29, 29, 1, 3, '2023-09-13 19:01:53', '37000.00', 'FA23000029', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:01:53', '2023-09-13 19:01:55', NULL),
(30, 30, 1, 3, '2023-09-13 19:05:45', '82500.00', 'FA23000030', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:05:45', '2023-09-13 19:05:54', NULL),
(31, 31, 1, 3, '2023-09-13 19:09:13', '184000.00', 'FA23000031', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:09:13', NULL, NULL),
(32, 32, 1, 3, '2023-09-13 19:10:24', '120000.00', 'FA23000032', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:10:24', NULL, NULL),
(33, 33, 1, 3, '2023-09-13 19:25:56', '112000.00', 'FA23000033', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:25:56', '2023-09-13 19:26:00', NULL),
(34, 34, 1, 3, '2023-09-13 19:27:10', '62400.00', 'FA23000034', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:27:10', '2023-09-13 19:27:13', NULL),
(35, 35, 1, 3, '2023-09-13 19:28:30', '34500.00', 'FA23000035', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:28:30', '2023-09-13 19:28:34', NULL),
(36, 36, 1, 3, '2023-09-13 19:29:25', '60000.00', 'FA23000036', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:29:25', '2023-09-13 19:29:27', NULL),
(37, 37, 1, 3, '2023-09-13 19:30:14', '35000.00', 'FA23000037', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:30:14', '2023-09-13 19:30:16', NULL),
(38, 38, 1, 3, '2023-09-13 19:31:41', '25800.00', 'FA23000038', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:31:41', '2023-09-13 19:31:42', NULL),
(39, 39, 1, 3, '2023-09-13 19:32:24', '65000.00', 'FA23000039', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:32:24', '2023-09-13 19:32:26', NULL),
(40, 40, 1, 3, '2023-09-13 19:37:21', '368500.00', 'FA23000040', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:37:21', '2023-09-13 19:37:39', NULL),
(41, 41, 1, 3, '2023-09-13 19:40:38', '62500.00', 'FA23000041', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:40:38', '2023-09-13 19:40:40', NULL),
(42, 42, 1, 3, '2023-09-13 19:41:24', '57600.00', 'FA23000042', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-13 19:41:24', '2023-09-13 19:41:26', NULL),
(43, 43, 1, 3, '2023-09-14 07:47:52', '26500.00', 'FA23000043', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 07:47:52', '2023-09-14 07:47:59', NULL),
(44, 44, 1, 3, '2023-09-14 07:50:05', '167000.00', 'FA23000044', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 07:50:05', '2023-09-14 07:50:12', NULL),
(45, 45, 1, 3, '2023-09-14 07:51:10', '60000.00', 'FA23000045', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 07:51:10', '2023-09-14 07:51:14', NULL),
(46, 46, 1, 3, '2023-09-14 07:52:03', '62500.00', 'FA23000046', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 07:52:03', '2023-09-14 07:52:05', NULL),
(47, 47, 1, 4, '2023-09-14 07:55:01', '2400.00', 'FA23000047', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 07:55:01', NULL, NULL),
(48, 48, 1, 3, '2023-09-14 07:55:49', '43400.00', 'FA23000048', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 07:55:49', '2023-09-14 07:56:03', NULL),
(49, 49, 1, 3, '2023-09-14 07:59:32', '23100.00', 'FA23000049', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 07:59:32', '2023-09-14 07:59:50', NULL),
(50, 50, 1, 3, '2023-09-14 08:02:14', '362500.00', 'FA23000050', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:02:14', '2023-09-14 08:02:20', NULL),
(51, 51, 1, 3, '2023-09-14 08:05:50', '85000.00', 'FA23000051', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:05:50', '2023-09-14 08:05:52', NULL),
(52, 52, 1, 3, '2023-09-14 08:07:06', '4500.00', 'FA23000052', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:07:06', '2023-09-14 08:07:08', NULL),
(53, 47, 1, 4, '2023-09-14 08:07:45', '2400.00', 'FA23000053', 'Annuler', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FA', '2023-09-14 08:07:45', NULL, NULL),
(54, 53, 1, 3, '2023-09-14 08:08:58', '7800.00', 'FA23000054', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:08:58', '2023-09-14 08:09:04', NULL),
(55, 54, 1, 3, '2023-09-14 08:13:05', '167000.00', 'FA23000055', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:13:05', '2023-09-14 08:13:19', NULL),
(56, 55, 1, 2, '2023-09-14 08:17:21', '156000.00', 'FA23000056', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:17:21', '2023-09-15 16:33:46', NULL),
(57, 56, 1, 3, '2023-09-14 08:20:58', '52000.00', 'FA23000057', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:20:58', NULL, NULL),
(58, 57, 1, 2, '2023-09-14 08:25:32', '185000.00', 'FA23000058', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:25:32', NULL, NULL),
(59, 58, 1, 3, '2023-09-14 08:26:20', '31800.00', 'FA23000059', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:26:20', '2023-09-14 08:26:49', NULL),
(60, 59, 1, 3, '2023-09-14 08:27:40', '100000.00', 'FA23000060', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:27:40', '2023-09-14 08:27:42', NULL),
(61, 60, 1, 2, '2023-09-14 08:36:01', '16500.00', 'FA23000061', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:36:01', '2023-09-14 12:39:26', NULL),
(62, 61, 1, 3, '2023-09-14 08:36:53', '162000.00', 'FA23000062', 'Partielle', NULL, '2000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:36:53', '2023-09-14 08:38:04', NULL),
(63, 62, 1, 2, '2023-09-14 08:37:25', '64000.00', 'FA23000063', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:37:25', '2023-09-14 08:39:45', NULL),
(64, 63, 1, 3, '2023-09-14 08:40:54', '11250.00', 'FA23000064', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:40:54', '2023-09-14 08:40:56', NULL),
(65, 64, 1, 2, '2023-09-14 08:42:54', '124800.00', 'FA23000065', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:42:54', NULL, NULL),
(66, 65, 1, 3, '2023-09-14 08:53:57', '18650.00', 'FA23000066', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:53:57', '2023-09-14 08:54:00', NULL),
(67, 66, 1, 3, '2023-09-14 08:55:19', '42000.00', 'FA23000067', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 08:55:19', '2023-09-14 08:55:21', NULL),
(68, 67, 1, 2, '2023-09-14 09:20:47', '25000.00', 'FA23000068', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 09:20:47', '2023-09-14 12:47:06', NULL),
(69, 68, 1, 3, '2023-09-14 09:37:24', '114000.00', 'FA23000069', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 09:37:24', '2023-09-14 09:37:53', NULL),
(70, 69, 1, 3, '2023-09-14 09:38:49', '22500.00', 'FA23000070', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 09:38:49', '2023-09-14 09:38:50', NULL),
(71, 70, 1, 3, '2023-09-14 09:40:10', '10500.00', 'FA23000071', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 09:40:10', NULL, NULL),
(72, 71, 1, 3, '2023-09-14 09:50:24', '50300.00', 'FA23000072', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 09:50:24', '2023-09-14 09:50:28', NULL),
(73, 72, 1, 2, '2023-09-14 09:54:39', '64500.00', 'FA23000073', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 09:54:39', '2023-09-14 12:51:52', NULL),
(74, 73, 1, 2, '2023-09-14 09:59:32', '81200.00', 'FA23000074', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 09:59:32', NULL, NULL),
(75, 74, 1, 2, '2023-09-14 10:00:47', '84000.00', 'FA23000075', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 10:00:47', '2023-09-14 10:15:24', NULL),
(76, 75, 1, 2, '2023-09-14 10:06:13', '1650.00', 'FA23000076', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 10:06:13', '2023-09-14 10:14:07', NULL),
(77, 76, 1, 2, '2023-09-14 10:09:57', '380000.00', 'FA23000077', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 10:09:57', NULL, NULL),
(78, 77, 1, 3, '2023-09-14 13:03:08', '34600.00', 'FA23000078', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:03:08', '2023-09-14 13:03:37', NULL),
(79, 78, 1, 3, '2023-09-14 13:11:05', '41300.00', 'FA23000079', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:11:05', NULL, NULL),
(80, 79, 1, 3, '2023-09-14 13:25:10', '106000.00', 'FA23000080', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:25:10', '2023-09-14 13:25:16', NULL),
(81, 80, 1, 3, '2023-09-14 13:26:59', '67500.00', 'FA23000081', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:26:59', '2023-09-14 13:27:01', NULL),
(82, 81, 1, 3, '2023-09-14 13:28:07', '6000.00', 'FA23000082', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:28:07', '2023-09-14 13:28:09', NULL),
(83, 82, 1, 3, '2023-09-14 13:28:41', '500.00', 'FA23000083', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:28:42', '2023-09-14 13:28:43', NULL),
(84, 83, 1, 3, '2023-09-14 13:29:37', '25000.00', 'FA23000084', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:29:37', '2023-09-14 13:29:39', NULL),
(85, 84, 1, 3, '2023-09-14 13:31:35', '130000.00', 'FA23000085', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:31:35', '2023-09-14 13:31:48', NULL),
(86, 85, 1, 3, '2023-09-14 13:51:16', '1089800.00', 'FA23000086', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:51:16', '2023-09-14 13:51:21', NULL),
(87, 86, 1, 3, '2023-09-14 13:52:21', '66700.00', 'FA23000087', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:52:21', '2023-09-14 13:52:23', NULL),
(88, 87, 1, 3, '2023-09-14 13:54:04', '22500.00', 'FA23000088', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:54:04', '2023-09-14 13:54:10', NULL),
(89, 88, 1, 3, '2023-09-14 13:55:14', '37500.00', 'FA23000089', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 13:55:14', '2023-09-14 13:55:15', NULL),
(90, 89, 1, 3, '2023-09-14 14:08:40', '1000.00', 'FA23000090', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 14:08:40', '2023-09-14 14:08:42', NULL),
(91, 90, 1, 3, '2023-09-14 14:11:04', '8600.00', 'FA23000091', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 14:11:04', '2023-09-14 14:11:06', NULL),
(92, 91, 1, 3, '2023-09-14 14:11:52', '23000.00', 'FA23000092', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 14:11:52', '2023-09-14 14:11:54', NULL),
(93, 92, 1, 3, '2023-09-14 14:13:12', '105500.00', 'FA23000093', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 14:13:12', '2023-09-14 14:13:16', NULL),
(94, 93, 1, 3, '2023-09-14 14:58:50', '17000.00', 'FA23000094', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 14:58:50', '2023-09-14 14:58:52', NULL),
(95, 94, 1, 3, '2023-09-14 15:44:19', '715000.00', 'FA23000095', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 15:44:19', '2023-09-14 15:44:28', NULL),
(96, 95, 1, 3, '2023-09-14 15:46:58', '352000.00', 'FA23000096', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 15:46:58', NULL, NULL),
(97, 96, 1, 3, '2023-09-14 15:52:31', '434000.00', 'FA23000097', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 15:52:31', '2023-09-14 15:52:41', NULL),
(98, 97, 1, 3, '2023-09-14 15:56:25', '614500.00', 'FA23000098', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 15:56:25', NULL, NULL),
(99, 98, 1, 3, '2023-09-14 15:58:22', '304400.00', 'FA23000099', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 15:58:22', '2023-09-19 12:16:41', NULL),
(100, 99, 1, 3, '2023-09-14 16:04:33', '2044800.00', 'FA23000100', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 16:04:33', NULL, NULL),
(101, 100, 1, 3, '2023-09-14 16:05:33', '12500.00', 'FA23000101', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 16:05:33', '2023-09-18 12:35:16', NULL),
(102, 101, 1, 3, '2023-09-14 16:14:49', '78000.00', 'FA23000102', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 16:14:49', '2023-09-14 16:14:54', NULL),
(103, 102, 1, 3, '2023-09-14 16:16:25', '306600.00', 'FA23000103', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 16:16:25', '2023-09-21 16:31:35', NULL),
(104, 103, 1, 3, '2023-09-14 16:17:46', '140000.00', 'FA23000104', 'Partielle', NULL, '50000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 16:17:46', '2023-09-14 16:18:38', NULL),
(105, 104, 1, 3, '2023-09-14 17:33:43', '148000.00', 'FA23000105', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 17:33:43', '2023-09-14 17:33:45', NULL),
(106, 105, 1, 3, '2023-09-14 17:41:25', '136550.00', 'FA23000106', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 17:41:25', '2023-09-14 17:41:43', NULL),
(107, 106, 1, 3, '2023-09-14 17:55:22', '9700.00', 'FA23000107', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 17:55:22', '2023-09-14 17:55:25', NULL),
(108, 107, 1, 4, '2023-09-14 17:56:14', '174125.00', 'FA23000108', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 17:56:14', '2023-09-14 18:04:41', NULL),
(109, 108, 1, 3, '2023-09-14 18:02:52', '133000.00', 'FA23000109', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-14 18:02:52', '2023-09-14 18:02:58', NULL),
(110, 109, 1, 1, '2023-09-15 14:01:39', '315000.00', 'FA23000110', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 14:01:39', '2023-09-15 14:03:54', NULL),
(111, 110, 1, 3, '2023-09-15 14:39:38', '1648500.00', 'FA23000111', 'Partielle', NULL, '1048500', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 14:39:38', '2023-09-15 14:42:32', NULL),
(112, 111, 1, 1, '2023-09-15 15:02:02', '91700.00', 'FA23000112', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 15:02:02', '2023-09-15 15:03:02', NULL),
(113, 112, 1, 3, '2023-09-15 15:05:51', '37000.00', 'FA23000113', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 15:05:51', '2023-09-15 15:05:54', NULL),
(114, 113, 1, 3, '2023-09-15 15:55:52', '136000.00', 'FA23000114', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 15:55:52', '2023-09-15 15:55:54', NULL),
(115, 114, 1, 3, '2023-09-15 15:57:04', '302000.00', 'FA23000115', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 15:57:04', '2023-09-15 15:57:06', NULL),
(116, 115, 1, 3, '2023-09-15 16:04:43', '83000.00', 'FA23000116', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:04:43', NULL, NULL),
(117, 116, 1, 2, '2023-09-15 16:10:23', '101500.00', 'FA23000117', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:10:23', '2023-09-15 16:14:17', NULL),
(118, 117, 1, 3, '2023-09-15 16:10:41', '398500.00', 'FA23000118', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:10:41', '2023-09-15 16:11:50', NULL),
(119, 118, 1, 2, '2023-09-15 16:13:08', '25000.00', 'FA23000119', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:13:08', '2023-09-15 16:13:58', NULL),
(120, 119, 1, 2, '2023-09-15 16:21:00', '60800.00', 'FA23000120', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:21:00', '2023-09-15 16:48:26', NULL),
(121, 120, 1, 2, '2023-09-15 16:22:33', '22500.00', 'FA23000121', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:22:33', '2023-09-15 16:49:50', NULL),
(122, 121, 1, 2, '2023-09-15 16:26:41', '42500.00', 'FA23000122', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:26:41', '2023-09-16 10:51:50', NULL),
(123, 122, 1, 2, '2023-09-15 16:27:55', '19100.00', 'FA23000123', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:27:55', '2023-09-15 16:53:21', NULL),
(124, 123, 1, 2, '2023-09-15 16:33:20', '18000.00', 'FA23000124', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:33:20', '2023-09-15 16:52:43', NULL),
(125, 57, 1, 2, '2023-09-15 16:45:02', '185000.00', 'FA23000125', 'Annuler', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FA', '2023-09-15 16:45:02', NULL, NULL),
(126, 124, 1, 2, '2023-09-15 16:50:37', '1800000.00', 'FA23000126', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 16:50:37', NULL, NULL),
(127, 125, 1, 2, '2023-09-15 17:00:44', '447700.00', 'FA23000127', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 17:00:44', '2023-09-15 17:04:43', NULL),
(128, 126, 1, 2, '2023-09-15 17:01:31', '27300.00', 'FA23000128', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 17:01:31', '2023-09-15 17:05:26', NULL),
(129, 127, 1, 2, '2023-09-15 17:07:10', '287800.00', 'FA23000129', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 17:07:10', NULL, NULL),
(130, 128, 1, 2, '2023-09-15 17:09:50', '46500.00', 'FA23000130', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 17:09:50', '2023-09-15 17:10:52', NULL),
(131, 129, 1, 2, '2023-09-15 17:15:50', '13400.00', 'FA23000131', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-15 17:15:50', '2023-09-15 17:17:23', NULL),
(132, 130, 1, 3, '2023-09-16 10:25:51', '55000.00', 'FA23000132', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-16 10:25:51', '2023-09-16 10:25:55', NULL),
(133, 131, 1, 3, '2023-09-16 10:34:43', '63425.00', 'FA23000133', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-16 10:34:43', NULL, NULL),
(134, 132, 1, 3, '2023-09-16 12:08:56', '95750.00', 'FA23000134', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-16 12:08:56', '2023-09-16 12:08:59', NULL),
(135, 133, 1, 3, '2023-09-16 13:42:08', '11000.00', 'FA23000135', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-16 13:42:08', '2023-09-16 13:42:09', NULL),
(136, 134, 1, 3, '2023-09-18 09:02:50', '844500.00', 'FA23000136', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 09:02:50', NULL, NULL),
(137, 135, 1, 3, '2023-09-18 09:26:54', '60000.00', 'FA23000137', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 09:26:54', '2023-09-18 09:26:55', NULL),
(138, 136, 1, 2, '2023-09-18 10:05:07', '2760000.00', 'FA23000138', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 10:05:07', NULL, NULL),
(139, 137, 1, 3, '2023-09-18 10:19:57', '105000.00', 'FA23000139', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 10:19:57', '2023-09-18 10:19:59', NULL),
(140, 138, 1, 3, '2023-09-18 11:22:55', '180000.00', 'FA23000140', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 11:22:55', '2023-09-18 11:22:58', NULL),
(141, 139, 1, 3, '2023-09-18 12:24:27', '10000.00', 'FA23000141', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 12:24:27', '2023-09-18 12:24:29', NULL),
(142, 140, 1, 2, '2023-09-18 12:26:51', '225000.00', 'FA23000142', 'Partielle', NULL, '100000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 12:26:51', '2023-09-19 09:21:24', NULL),
(143, 141, 1, 3, '2023-09-18 13:50:42', '76100.00', 'FA23000143', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 13:50:42', '2023-09-18 13:50:47', NULL),
(144, 142, 1, 2, '2023-09-18 14:30:18', '448000.00', 'FA23000144', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 14:30:18', NULL, NULL),
(145, 143, 1, 3, '2023-09-18 14:32:18', '567500.00', 'FA23000145', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-18 14:32:18', '2023-09-18 14:32:24', NULL),
(146, 144, 1, 3, '2023-09-19 08:42:58', '511000.00', 'FA23000146', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 08:42:58', '2023-09-19 08:43:04', NULL),
(147, 145, 1, 3, '2023-09-19 08:45:17', '115000.00', 'FA23000147', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 08:45:17', '2023-09-19 08:45:18', NULL),
(148, 146, 1, 3, '2023-09-19 10:09:16', '77500.00', 'FA23000148', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 10:09:16', '2023-09-19 10:09:21', NULL),
(149, 147, 1, 3, '2023-09-19 10:19:24', '40000.00', 'FA23000149', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 10:19:24', '2023-09-19 10:19:25', NULL),
(150, 148, 1, 3, '2023-09-19 11:20:34', '162500.00', 'FA23000150', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 11:20:34', '2023-09-19 11:53:18', NULL),
(151, 149, 1, 3, '2023-09-19 11:26:19', '195000.00', 'FA23000151', 'Partielle', NULL, '95000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 11:26:19', '2023-09-22 16:22:59', NULL),
(152, 150, 1, 3, '2023-09-19 11:40:48', '27300.00', 'FA23000152', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 11:40:48', '2023-09-19 11:40:49', NULL),
(153, 151, 1, 3, '2023-09-19 12:03:26', '600000.00', 'FA23000153', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 12:03:26', '2023-09-19 12:21:10', NULL),
(154, 152, 1, 3, '2023-09-19 16:00:13', '180000.00', 'FA23000154', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-19 16:00:13', '2023-09-19 16:00:22', NULL),
(155, 153, 1, 3, '2023-09-20 08:10:47', '108000.00', 'FA23000155', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 08:10:47', NULL, NULL),
(156, 154, 1, 3, '2023-09-20 08:36:17', '78000.00', 'FA23000156', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 08:36:17', '2023-09-20 08:36:21', NULL),
(157, 155, 1, 2, '2023-09-20 10:42:30', '50300.00', 'FA23000157', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 10:42:30', '2023-09-20 10:43:15', NULL),
(158, 156, 1, 2, '2023-09-20 11:07:25', '6500.00', 'FA23000158', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 11:07:25', '2023-09-20 11:42:11', NULL),
(159, 157, 1, 2, '2023-09-20 11:49:09', '86000.00', 'FA23000159', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 11:49:09', '2023-09-20 14:51:59', NULL),
(160, 158, 1, 3, '2023-09-20 12:07:47', '30100.00', 'FA23000160', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 12:07:47', '2023-09-20 12:07:48', NULL),
(161, 159, 1, 3, '2023-09-20 12:27:36', '61250.00', 'FA23000161', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 12:27:36', NULL, NULL),
(162, 160, 1, 2, '2023-09-20 12:31:10', '101900.00', 'FA23000162', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 12:31:10', NULL, NULL),
(163, 161, 1, 3, '2023-09-20 12:46:56', '122750.00', 'FA23000163', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 12:46:56', '2023-09-20 12:47:26', NULL),
(165, 160, 1, 2, '2023-09-20 12:59:32', '101900.00', 'FA23000164', 'Annuler', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FA', '2023-09-20 12:59:32', NULL, NULL),
(166, 162, 1, 3, '2023-09-20 14:14:56', '113300.00', 'FA23000165', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 14:14:56', NULL, NULL),
(167, 163, 1, 3, '2023-09-20 14:15:51', '24000.00', 'FA23000166', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 14:15:51', '2023-09-20 14:15:52', NULL),
(168, 164, 1, 2, '2023-09-20 14:41:46', '350000.00', 'FA23000167', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 14:41:46', '2023-09-20 14:45:56', NULL),
(169, 165, 1, 3, '2023-09-20 15:13:16', '57500.00', 'FA23000168', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 15:13:16', '2023-09-20 15:13:18', NULL),
(170, 166, 1, 3, '2023-09-20 15:55:44', '510000.00', 'FA23000169', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 15:55:44', '2023-09-20 15:55:48', NULL),
(171, 167, 1, 3, '2023-09-20 16:29:05', '101900.00', 'FA23000170', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 16:29:05', NULL, NULL),
(172, 168, 1, 3, '2023-09-20 16:43:19', '8600.00', 'FA23000171', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 16:43:19', '2023-09-20 16:43:21', NULL),
(173, 169, 1, 3, '2023-09-20 16:47:30', '400000.00', 'FA23000172', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-20 16:47:30', NULL, NULL),
(174, 170, 1, 2, '2023-09-21 08:47:20', '935900.00', 'FA23000173', 'Partielle', NULL, '535900', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 08:47:20', '2023-09-21 08:51:53', NULL),
(175, 171, 1, 3, '2023-09-21 10:38:39', '37500.00', 'FA23000174', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 10:38:39', '2023-09-21 10:38:41', NULL),
(176, 172, 1, 3, '2023-09-21 11:08:47', '60000.00', 'FA23000175', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 11:08:47', '2023-09-21 11:08:49', NULL),
(177, 173, 1, 2, '2023-09-21 12:18:39', '1149000.00', 'FA23000176', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 12:18:39', '2023-09-21 12:20:18', NULL),
(178, 174, 1, 2, '2023-09-21 12:24:52', '151000.00', 'FA23000177', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 12:24:52', NULL, NULL),
(179, 175, 1, 3, '2023-09-21 12:36:53', '49500.00', 'FA23000178', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 12:36:53', '2023-09-21 12:36:55', NULL),
(180, 174, 1, 2, '2023-09-21 12:40:44', '151000.00', 'FA23000179', 'Annuler', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FA', '2023-09-21 12:40:44', NULL, NULL),
(181, 176, 1, 3, '2023-09-21 13:09:42', '64000.00', 'FA23000180', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 13:09:42', '2023-09-21 13:09:43', NULL),
(182, 177, 1, 3, '2023-09-21 13:35:59', '96000.00', 'FA23000181', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 13:35:59', '2023-09-21 13:36:00', NULL),
(183, 178, 1, 3, '2023-09-21 15:15:38', '340000.00', 'FA23000182', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 15:15:38', NULL, NULL),
(184, 179, 1, 3, '2023-09-21 15:20:58', '147500.00', 'FA23000183', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 15:20:58', NULL, NULL),
(185, 180, 1, 2, '2023-09-21 16:16:17', '30000.00', 'FA23000184', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 16:16:17', '2023-09-21 16:19:19', NULL),
(186, 181, 1, 2, '2023-09-21 16:34:22', '120000.00', 'FA23000185', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 16:34:22', '2023-09-21 16:39:01', NULL),
(187, 182, 1, 3, '2023-09-21 16:42:18', '12000.00', 'FA23000186', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 16:42:18', NULL, NULL),
(188, 183, 1, 2, '2023-09-21 16:50:44', '33000.00', 'FA23000187', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-21 16:50:44', NULL, NULL),
(189, 184, 1, 3, '2023-09-22 10:32:53', '62400.00', 'FA23000188', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 10:32:53', '2023-09-22 10:32:55', NULL),
(190, 185, 1, 3, '2023-09-22 11:21:33', '68000.00', 'FA23000189', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 11:21:33', '2023-09-22 11:21:34', NULL),
(191, 186, 1, 3, '2023-09-22 11:41:10', '125000.00', 'FA23000190', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 11:41:10', NULL, NULL),
(192, 187, 1, 3, '2023-09-22 12:17:37', '135000.00', 'FA23000191', 'En attente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 12:17:37', NULL, NULL),
(193, 188, 1, 2, '2023-09-22 12:48:16', '39500.00', 'FA23000192', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 12:48:16', '2023-09-22 12:55:56', NULL),
(194, 189, 1, 2, '2023-09-22 12:49:15', '45000.00', 'FA23000193', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 12:49:15', '2023-09-22 12:55:34', NULL),
(195, 190, 1, 2, '2023-09-22 13:39:16', '20000.00', 'FA23000194', 'Payée', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 13:39:16', '2023-09-22 14:44:17', NULL),
(196, 191, 1, 3, '2023-09-22 15:26:26', '33000.00', 'FA23000195', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 15:26:26', '2023-09-22 15:26:28', NULL),
(197, 192, 1, 3, '2023-09-22 16:00:48', '290500.00', 'FA23000196', 'Payée', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV', '2023-09-22 16:00:48', '2023-09-22 16:00:51', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `facture_proforma`
--

DROP TABLE IF EXISTS `facture_proforma`;
CREATE TABLE IF NOT EXISTS `facture_proforma` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acheteur_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `model_signataire_id` int DEFAULT NULL,
  `date_factpro` datetime NOT NULL,
  `montant_ht` decimal(10,2) NOT NULL,
  `montant_ttc` decimal(10,2) NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `ref_factpro` varchar(100) DEFAULT NULL,
  `montant_rest` decimal(10,0) DEFAULT '0',
  `type_remise` varchar(255) DEFAULT NULL,
  `remise` decimal(10,0) DEFAULT NULL,
  `valeur_remise` varchar(255) DEFAULT NULL,
  `montant_ht_to_apr_rse` decimal(10,0) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `montant_tva` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_917CA12796A7BB5F` (`acheteur_id`),
  KEY `IDX_917CA127EFA24D68` (`point_vente_id`),
  KEY `IDX_917CA1273F192FC` (`operateur_id`),
  KEY `IDX_917CA127D16C5631` (`model_signataire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `famille`
--

DROP TABLE IF EXISTS `famille`;
CREATE TABLE IF NOT EXISTS `famille` (
  `id` int NOT NULL AUTO_INCREMENT,
  `famille_parent_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `code_famille` varchar(255) NOT NULL,
  `libelle_famille` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2473F21352523166` (`famille_parent_id`),
  KEY `IDX_2473F213EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `famille`
--

INSERT INTO `famille` (`id`, `famille_parent_id`, `point_vente_id`, `code_famille`, `libelle_famille`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, 'SER', 'SERVICE', NULL, '2023-09-12 15:37:37', NULL, NULL),
(2, NULL, 1, '﻿D', '﻿DIVERS', NULL, '2023-09-12 15:42:01', NULL, NULL),
(3, NULL, 1, 'DIVE', 'DIVERS', NULL, '2023-09-12 15:42:02', NULL, NULL),
(4, NULL, 1, 'CHAR', 'CHARPENTE ET MENUISIERIE', NULL, '2023-09-12 15:42:02', NULL, NULL),
(5, NULL, 1, 'ELEC', 'ELECTRICITÉ', NULL, '2023-09-12 15:42:04', NULL, NULL),
(6, NULL, 1, 'MACO', 'MACONNERIE', NULL, '2023-09-12 15:42:05', NULL, NULL),
(7, NULL, 1, 'PLOM', 'PLOMBERIE', NULL, '2023-09-12 15:42:06', NULL, NULL),
(8, NULL, 1, 'SERR', 'SERRURE', NULL, '2023-09-12 15:42:53', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `fonction`
--

DROP TABLE IF EXISTS `fonction`;
CREATE TABLE IF NOT EXISTS `fonction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `intitule` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_900D5BDEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `fonction`
--

INSERT INTO `fonction` (`id`, `point_vente_id`, `code`, `intitule`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'DIR', 'DIRECTEUR', NULL, '2023-09-12 15:37:36', NULL, NULL),
(2, 1, 'GER', 'GERANT', NULL, '2023-09-12 15:37:36', NULL, NULL),
(3, 1, 'COMP', 'COMPTABLE', NULL, '2023-09-12 15:37:36', NULL, NULL),
(4, 1, 'CAIS', 'CAISSIERE', NULL, '2023-09-12 15:37:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `fonction_personnel`
--

DROP TABLE IF EXISTS `fonction_personnel`;
CREATE TABLE IF NOT EXISTS `fonction_personnel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `fonction_id` int NOT NULL,
  `est_actif` tinyint(1) NOT NULL,
  `date_debut_fonc` datetime DEFAULT NULL,
  `date_fin_fonc` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5B2013EF1C109075` (`personnel_id`),
  KEY `IDX_5B2013EF57889920` (`fonction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `fonction_personnel`
--

INSERT INTO `fonction_personnel` (`id`, `personnel_id`, `fonction_id`, `est_actif`, `date_debut_fonc`, `date_fin_fonc`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 2, 1, '2020-07-22 00:00:00', NULL, '2023-09-12 16:46:51', NULL, NULL),
(2, 3, 4, 1, '2023-01-03 00:00:00', NULL, '2023-09-12 16:53:46', NULL, NULL),
(3, 4, 3, 1, '2022-03-07 00:00:00', NULL, '2023-09-12 16:56:31', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `format_impression`
--

DROP TABLE IF EXISTS `format_impression`;
CREATE TABLE IF NOT EXISTS `format_impression` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  `est_actif` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenoms` varchar(255) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tel1` varchar(255) DEFAULT NULL,
  `tel2` varchar(255) DEFAULT NULL,
  `date_nais` datetime DEFAULT NULL,
  `denomination` varchar(255) DEFAULT '',
  `raison_sociale` varchar(255) DEFAULT '',
  `ifu` varchar(255) DEFAULT NULL,
  `rccm` varchar(255) DEFAULT NULL,
  `sigle` varchar(255) DEFAULT '',
  `statut` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_369ECA32EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `groupe_taxe`
--

DROP TABLE IF EXISTS `groupe_taxe`;
CREATE TABLE IF NOT EXISTS `groupe_taxe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taux_gr_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `code_gr` varchar(255) NOT NULL,
  `libelle_gr` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FEDA505EE2FBBC81` (`taux_gr_id`),
  KEY `IDX_FEDA505EEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `groupe_taxe`
--

INSERT INTO `groupe_taxe` (`id`, `taux_gr_id`, `point_vente_id`, `code_gr`, `libelle_gr`, `est_sup`) VALUES
(1, 5, 1, 'A', 'A - EXONERE', NULL),
(2, 1, 1, 'B', 'B - TAXABLE 18%', NULL),
(3, 6, 1, 'C', 'C - EXPORTATION', NULL),
(4, 7, 1, 'D', 'D - TVA REGIME D\'EXCEPTION 18%', NULL),
(5, 8, 1, 'E', 'E - REGIME TPS', NULL),
(6, 9, 1, 'F', 'F - RESERVE', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `inventaire`
--

DROP TABLE IF EXISTS `inventaire`;
CREATE TABLE IF NOT EXISTS `inventaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_inv_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `model_signataire_id` int DEFAULT NULL,
  `date_debut_inv` datetime NOT NULL,
  `date_fin_inv` datetime DEFAULT NULL,
  `motif` longtext NOT NULL,
  `total_debit` decimal(10,2) DEFAULT NULL,
  `total_credit` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `est_cloturer` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_338920E04CB8BE47` (`type_inv_id`),
  KEY `IDX_338920E0EFA24D68` (`point_vente_id`),
  KEY `IDX_338920E0D16C5631` (`model_signataire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `inventaire`
--

INSERT INTO `inventaire` (`id`, `type_inv_id`, `point_vente_id`, `model_signataire_id`, `date_debut_inv`, `date_fin_inv`, `motif`, `total_debit`, `total_credit`, `est_sup`, `est_cloturer`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, NULL, '2023-09-12 15:43:05', '2023-09-12 15:43:05', 'inventaire initial', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `inventaire_mag`
--

DROP TABLE IF EXISTS `inventaire_mag`;
CREATE TABLE IF NOT EXISTS `inventaire_mag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inventaire_id` int NOT NULL,
  `magasin_id` int NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E6B6734ACE430A85` (`inventaire_id`),
  KEY `IDX_E6B6734A20096AE3` (`magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `inventaire_mag`
--

INSERT INTO `inventaire_mag` (`id`, `inventaire_id`, `magasin_id`, `est_sup`) VALUES
(1, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `inventaire_personnel`
--

DROP TABLE IF EXISTS `inventaire_personnel`;
CREATE TABLE IF NOT EXISTS `inventaire_personnel` (
  `inventaire_id` int NOT NULL,
  `personnel_id` int NOT NULL,
  PRIMARY KEY (`inventaire_id`,`personnel_id`),
  KEY `IDX_8BCCFC2FCE430A85` (`inventaire_id`),
  KEY `IDX_8BCCFC2F1C109075` (`personnel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `inventaire_personnel`
--

INSERT INTO `inventaire_personnel` (`inventaire_id`, `personnel_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `list_caisse`
--

DROP TABLE IF EXISTS `list_caisse`;
CREATE TABLE IF NOT EXISTS `list_caisse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `etat` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2B7391E6EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `list_caisse`
--

INSERT INTO `list_caisse` (`id`, `point_vente_id`, `libelle`, `code`, `est_sup`, `etat`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'CAISSE PRINCIPAL', 'CP', NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `livraison`
--

DROP TABLE IF EXISTS `livraison`;
CREATE TABLE IF NOT EXISTS `livraison` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_cli_id` int NOT NULL,
  `livreur_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `model_signataire_id` int DEFAULT NULL,
  `date_liv` datetime NOT NULL,
  `montant_liv` decimal(10,2) DEFAULT NULL,
  `ref_liv` varchar(100) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `total_reste_aliv` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A60C9F1FBE1A1965` (`commande_cli_id`),
  KEY `IDX_A60C9F1FF8646701` (`livreur_id`),
  KEY `IDX_A60C9F1FEFA24D68` (`point_vente_id`),
  KEY `IDX_A60C9F1F3F192FC` (`operateur_id`),
  KEY `IDX_A60C9F1FD16C5631` (`model_signataire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `livraison`
--

INSERT INTO `livraison` (`id`, `commande_cli_id`, `livreur_id`, `point_vente_id`, `operateur_id`, `model_signataire_id`, `date_liv`, `montant_liv`, `ref_liv`, `est_sup`, `total_reste_aliv`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000001', NULL, '0.00', '2023-09-15 17:34:28', NULL, NULL),
(2, 2, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000002', NULL, '0.00', '2023-09-15 17:35:48', NULL, NULL),
(3, 3, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000003', NULL, '0.00', '2023-09-15 17:39:38', NULL, NULL),
(4, 4, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000004', NULL, '0.00', '2023-09-15 17:40:05', NULL, NULL),
(5, 5, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000005', NULL, '0.00', '2023-09-15 17:40:52', NULL, NULL),
(6, 6, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000006', NULL, '0.00', '2023-09-15 17:41:11', NULL, NULL),
(7, 7, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000007', NULL, '0.00', '2023-09-15 17:41:38', NULL, NULL),
(8, 8, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000008', NULL, '0.00', '2023-09-15 17:42:06', NULL, NULL),
(9, 9, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000009', NULL, '0.00', '2023-09-15 17:42:23', NULL, NULL),
(10, 10, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000010', NULL, '0.00', '2023-09-15 17:42:39', NULL, NULL),
(11, 11, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000011', NULL, '0.00', '2023-09-15 17:42:57', NULL, NULL),
(12, 12, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000012', NULL, '0.00', '2023-09-15 17:43:16', NULL, NULL),
(13, 13, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000013', NULL, '0.00', '2023-09-15 17:43:35', NULL, NULL),
(14, 14, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000014', NULL, '0.00', '2023-09-15 17:43:53', NULL, NULL),
(15, 15, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000015', NULL, '0.00', '2023-09-15 17:44:15', NULL, NULL),
(16, 16, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000016', NULL, '0.00', '2023-09-15 17:44:40', NULL, NULL),
(17, 17, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000017', NULL, '0.00', '2023-09-15 17:45:14', NULL, NULL),
(18, 18, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000018', NULL, '0.00', '2023-09-15 17:45:37', NULL, NULL),
(19, 19, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000019', NULL, '0.00', '2023-09-15 17:45:56', NULL, NULL),
(20, 20, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000020', NULL, '0.00', '2023-09-15 17:46:19', NULL, NULL),
(21, 21, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000021', NULL, '0.00', '2023-09-15 17:46:41', NULL, NULL),
(22, 22, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000022', NULL, '0.00', '2023-09-15 17:47:02', NULL, NULL),
(23, 23, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000023', NULL, '0.00', '2023-09-15 17:47:33', NULL, NULL),
(24, 24, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000024', NULL, '0.00', '2023-09-15 17:48:03', NULL, NULL),
(25, 25, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000025', NULL, '0.00', '2023-09-15 17:48:40', NULL, NULL),
(26, 26, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000026', NULL, '0.00', '2023-09-15 17:49:03', NULL, NULL),
(27, 27, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000027', NULL, '0.00', '2023-09-15 17:49:39', NULL, NULL),
(28, 28, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000028', NULL, '0.00', '2023-09-15 17:50:27', NULL, NULL),
(29, 29, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000029', NULL, '0.00', '2023-09-15 17:51:20', NULL, NULL),
(30, 30, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000030', NULL, '0.00', '2023-09-15 17:52:02', NULL, NULL),
(31, 31, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000031', NULL, '0.00', '2023-09-15 17:52:35', NULL, NULL),
(32, 32, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000032', NULL, '0.00', '2023-09-15 17:52:55', NULL, NULL),
(33, 33, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000033', NULL, '0.00', '2023-09-15 17:53:43', NULL, NULL),
(34, 34, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000034', NULL, '0.00', '2023-09-15 17:54:15', NULL, NULL),
(35, 35, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000035', NULL, '0.00', '2023-09-15 17:54:35', NULL, NULL),
(36, 36, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000036', NULL, '0.00', '2023-09-15 17:54:58', NULL, NULL),
(37, 37, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000037', NULL, '0.00', '2023-09-15 17:55:16', NULL, NULL),
(38, 38, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000038', NULL, '0.00', '2023-09-15 17:55:36', NULL, NULL),
(39, 39, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000039', NULL, '0.00', '2023-09-15 17:55:53', NULL, NULL),
(40, 40, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000040', NULL, '0.00', '2023-09-15 17:56:12', NULL, NULL),
(41, 41, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000041', NULL, '0.00', '2023-09-15 17:56:41', NULL, NULL),
(42, 42, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000042', NULL, '0.00', '2023-09-15 17:56:59', NULL, NULL),
(43, 43, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000043', NULL, '0.00', '2023-09-15 17:57:16', NULL, NULL),
(44, 44, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000044', NULL, '0.00', '2023-09-15 17:57:39', NULL, NULL),
(45, 45, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000045', NULL, '0.00', '2023-09-15 17:57:59', NULL, NULL),
(46, 46, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000046', NULL, '0.00', '2023-09-15 17:58:25', NULL, NULL),
(47, 48, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000047', NULL, '0.00', '2023-09-15 17:58:44', NULL, NULL),
(48, 49, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000048', NULL, '0.00', '2023-09-15 17:59:08', NULL, NULL),
(49, 50, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000049', NULL, '0.00', '2023-09-15 17:59:29', NULL, NULL),
(50, 51, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000050', NULL, '0.00', '2023-09-15 17:59:49', NULL, NULL),
(51, 52, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000051', NULL, '0.00', '2023-09-15 18:00:07', NULL, NULL),
(52, 53, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000052', NULL, '0.00', '2023-09-15 18:00:24', NULL, NULL),
(53, 54, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000053', NULL, '0.00', '2023-09-15 18:00:41', NULL, NULL),
(54, 55, 3, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000054', NULL, '0.00', '2023-09-15 18:01:23', NULL, NULL),
(55, 56, 3, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000055', NULL, '0.00', '2023-09-15 18:01:51', NULL, NULL),
(56, 58, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000056', NULL, '0.00', '2023-09-15 18:02:10', NULL, NULL),
(57, 59, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000057', NULL, '0.00', '2023-09-15 18:02:34', NULL, NULL),
(58, 60, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000058', NULL, '0.00', '2023-09-15 18:02:57', NULL, NULL),
(59, 61, 2, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000059', NULL, '0.00', '2023-09-15 18:03:18', NULL, NULL),
(60, 62, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000060', NULL, '0.00', '2023-09-15 18:03:44', NULL, NULL),
(61, 63, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000061', NULL, '0.00', '2023-09-15 18:04:00', NULL, NULL),
(62, 64, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000062', NULL, '0.00', '2023-09-15 18:04:22', NULL, NULL),
(63, 65, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000063', NULL, '0.00', '2023-09-15 18:04:58', NULL, NULL),
(64, 66, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000064', NULL, '0.00', '2023-09-15 18:05:30', NULL, NULL),
(65, 67, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000065', NULL, '0.00', '2023-09-15 18:05:48', NULL, NULL),
(66, 68, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000066', NULL, '0.00', '2023-09-15 18:06:14', NULL, NULL),
(67, 69, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000067', NULL, '0.00', '2023-09-15 18:07:17', NULL, NULL),
(68, 70, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000068', NULL, '0.00', '2023-09-15 18:08:17', NULL, NULL),
(69, 71, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000069', NULL, '0.00', '2023-09-15 18:08:57', NULL, NULL),
(70, 72, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000070', NULL, '0.00', '2023-09-15 18:09:24', NULL, NULL),
(71, 73, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000071', NULL, '0.00', '2023-09-15 18:10:29', NULL, NULL),
(72, 74, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000072', NULL, '0.00', '2023-09-15 18:10:50', NULL, NULL),
(73, 75, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000073', NULL, '0.00', '2023-09-15 18:11:32', NULL, NULL),
(74, 76, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000074', NULL, '0.00', '2023-09-15 18:12:07', NULL, NULL),
(75, 77, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000075', NULL, '0.00', '2023-09-15 18:12:49', NULL, NULL),
(76, 78, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000076', NULL, '0.00', '2023-09-15 18:13:15', NULL, NULL),
(77, 79, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000077', NULL, '0.00', '2023-09-15 18:13:47', NULL, NULL),
(78, 80, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000078', NULL, '0.00', '2023-09-15 18:14:08', NULL, NULL),
(79, 81, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000079', NULL, '0.00', '2023-09-15 18:14:26', NULL, NULL),
(80, 82, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000080', NULL, '0.00', '2023-09-15 18:14:49', NULL, NULL),
(81, 83, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000081', NULL, '0.00', '2023-09-15 18:15:19', NULL, NULL),
(82, 84, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000082', NULL, '0.00', '2023-09-15 18:15:41', NULL, NULL),
(83, 85, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000083', NULL, '0.00', '2023-09-15 18:16:30', NULL, NULL),
(84, 86, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000084', NULL, '0.00', '2023-09-15 18:17:05', NULL, NULL),
(85, 87, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000085', NULL, '0.00', '2023-09-15 18:17:41', NULL, NULL),
(86, 88, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000086', NULL, '0.00', '2023-09-15 18:18:06', NULL, NULL),
(87, 89, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000087', NULL, '0.00', '2023-09-15 18:18:46', NULL, NULL),
(88, 90, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000088', NULL, '0.00', '2023-09-15 18:19:19', NULL, NULL),
(89, 91, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000089', NULL, '0.00', '2023-09-15 18:19:37', NULL, NULL),
(90, 92, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000090', NULL, '0.00', '2023-09-15 18:19:56', NULL, NULL),
(91, 93, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000091', NULL, '0.00', '2023-09-15 18:20:22', NULL, NULL),
(92, 94, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000092', NULL, '0.00', '2023-09-15 18:20:41', NULL, NULL),
(93, 95, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000093', NULL, '0.00', '2023-09-15 18:21:01', NULL, NULL),
(94, 96, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000094', NULL, '0.00', '2023-09-15 18:21:18', NULL, NULL),
(95, 97, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000095', NULL, '0.00', '2023-09-15 18:21:38', NULL, NULL),
(96, 98, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000096', NULL, '0.00', '2023-09-15 18:21:56', NULL, NULL),
(97, 99, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000097', NULL, '0.00', '2023-09-15 18:22:15', NULL, NULL),
(98, 100, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000098', NULL, '0.00', '2023-09-15 18:22:37', NULL, NULL),
(99, 101, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000099', NULL, '0.00', '2023-09-15 18:22:56', NULL, NULL),
(100, 102, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000100', NULL, '0.00', '2023-09-15 18:23:18', NULL, NULL),
(101, 103, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000101', NULL, '0.00', '2023-09-15 18:23:51', NULL, NULL),
(102, 104, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000102', NULL, '0.00', '2023-09-15 18:24:09', NULL, NULL),
(103, 105, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000103', NULL, '0.00', '2023-09-15 18:24:29', NULL, NULL),
(104, 112, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000104', NULL, '0.00', '2023-09-15 18:24:50', NULL, NULL),
(105, 106, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000105', NULL, '0.00', '2023-09-15 18:25:12', NULL, NULL),
(106, 107, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000106', NULL, '0.00', '2023-09-15 18:25:49', NULL, NULL),
(107, 108, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000107', NULL, '0.00', '2023-09-15 18:26:12', NULL, NULL),
(108, 109, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000108', NULL, '0.00', '2023-09-15 18:26:30', NULL, NULL),
(109, 110, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000109', NULL, '0.00', '2023-09-15 18:26:48', NULL, NULL),
(110, 111, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000110', NULL, '0.00', '2023-09-15 18:27:12', NULL, NULL),
(111, 113, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000111', NULL, '0.00', '2023-09-15 18:27:34', NULL, NULL),
(112, 114, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000112', NULL, '0.00', '2023-09-15 18:27:50', NULL, NULL),
(113, 115, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000113', NULL, '0.00', '2023-09-15 18:28:13', NULL, NULL),
(114, 116, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000114', NULL, '0.00', '2023-09-15 18:28:36', NULL, NULL),
(115, 117, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000115', NULL, '0.00', '2023-09-15 18:28:58', NULL, NULL),
(116, 118, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000116', NULL, '0.00', '2023-09-15 18:29:22', NULL, NULL),
(117, 119, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000117', NULL, '0.00', '2023-09-15 18:29:57', NULL, NULL),
(118, 120, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000118', NULL, '0.00', '2023-09-15 18:30:18', NULL, NULL),
(119, 121, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000119', NULL, '0.00', '2023-09-15 18:30:35', NULL, NULL),
(120, 122, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000120', NULL, '0.00', '2023-09-15 18:30:55', NULL, NULL),
(121, 123, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000121', NULL, '0.00', '2023-09-15 18:31:13', NULL, NULL),
(122, 124, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000122', NULL, '0.00', '2023-09-15 18:31:30', NULL, NULL),
(123, 125, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000123', NULL, '0.00', '2023-09-15 18:32:20', NULL, NULL),
(124, 126, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000124', NULL, '0.00', '2023-09-15 18:33:12', NULL, NULL),
(125, 127, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000125', NULL, '0.00', '2023-09-15 18:33:35', NULL, NULL),
(126, 128, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000126', NULL, '0.00', '2023-09-15 18:33:54', NULL, NULL),
(127, 129, 4, 1, 1, NULL, '2023-09-15 00:00:00', NULL, 'LI23000127', NULL, '0.00', '2023-09-15 18:34:11', NULL, NULL),
(128, 130, 2, 1, 2, NULL, '2023-09-16 00:00:00', NULL, 'LI23000128', NULL, '0.00', '2023-09-16 14:13:01', NULL, NULL),
(129, 131, 2, 1, 2, NULL, '2023-09-16 00:00:00', NULL, 'LI23000129', NULL, '0.00', '2023-09-16 14:14:31', NULL, NULL),
(130, 132, 2, 1, 2, NULL, '2023-09-16 00:00:00', NULL, 'LI23000130', NULL, '0.00', '2023-09-16 14:15:14', NULL, NULL),
(131, 133, 2, 1, 2, NULL, '2023-09-16 00:00:00', NULL, 'LI23000131', NULL, '0.00', '2023-09-16 14:15:33', NULL, NULL),
(132, 134, 2, 1, 3, NULL, '2023-09-18 00:00:00', NULL, 'LI23000132', NULL, '0.00', '2023-09-18 10:12:24', NULL, NULL),
(133, 135, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000133', NULL, '0.00', '2023-09-18 10:13:30', NULL, NULL),
(134, 136, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000134', NULL, '0.00', '2023-09-18 10:13:48', NULL, NULL),
(135, 137, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000135', NULL, '0.00', '2023-09-18 12:27:26', NULL, NULL),
(136, 138, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000136', NULL, '0.00', '2023-09-18 12:27:44', NULL, NULL),
(137, 139, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000137', NULL, '0.00', '2023-09-18 12:27:58', NULL, NULL),
(138, 140, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000138', NULL, '0.00', '2023-09-18 12:28:11', NULL, NULL),
(139, 141, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000139', NULL, '0.00', '2023-09-18 14:12:48', NULL, NULL),
(140, 142, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000140', NULL, '0.00', '2023-09-18 14:30:58', NULL, NULL),
(141, 143, 2, 1, 2, NULL, '2023-09-18 00:00:00', NULL, 'LI23000141', NULL, '0.00', '2023-09-18 14:42:42', NULL, NULL),
(142, 144, 2, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000142', NULL, '0.00', '2023-09-19 08:43:44', NULL, NULL),
(143, 145, 2, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000143', NULL, '0.00', '2023-09-19 08:49:19', NULL, NULL),
(144, 146, 4, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000144', NULL, '0.00', '2023-09-19 10:10:40', NULL, NULL),
(145, 147, 4, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000145', NULL, '0.00', '2023-09-19 10:20:51', NULL, NULL),
(146, 150, 4, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000146', NULL, '0.00', '2023-09-19 11:54:28', NULL, NULL),
(147, 149, 2, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000147', NULL, '0.00', '2023-09-19 11:54:48', NULL, NULL),
(148, 148, 4, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000148', NULL, '0.00', '2023-09-19 11:55:03', NULL, NULL),
(149, 151, 4, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000149', NULL, '0.00', '2023-09-19 15:34:45', NULL, NULL),
(150, 152, 4, 1, 3, NULL, '2023-09-19 00:00:00', NULL, 'LI23000150', NULL, '0.00', '2023-09-19 16:01:32', NULL, NULL),
(151, 153, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000151', NULL, '0.00', '2023-09-20 10:42:59', NULL, NULL),
(152, 154, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000152', NULL, '0.00', '2023-09-20 10:43:11', NULL, NULL),
(153, 155, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000153', NULL, '0.00', '2023-09-20 10:43:26', NULL, NULL),
(154, 156, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000154', NULL, '0.00', '2023-09-20 11:07:40', NULL, NULL),
(155, 157, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000155', NULL, '0.00', '2023-09-20 12:09:50', NULL, NULL),
(156, 158, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000156', NULL, '0.00', '2023-09-20 12:10:10', NULL, NULL),
(157, 159, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000157', NULL, '0.00', '2023-09-20 12:32:16', NULL, NULL),
(158, 160, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000158', NULL, '0.00', '2023-09-20 12:32:40', NULL, NULL),
(159, 161, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000159', NULL, '0.00', '2023-09-20 13:05:42', NULL, NULL),
(160, 163, 4, 1, 3, NULL, '2023-09-20 00:00:00', NULL, 'LI23000160', NULL, '0.00', '2023-09-20 14:16:35', NULL, NULL),
(161, 162, 4, 1, 3, NULL, '2023-09-20 00:00:00', NULL, 'LI23000161', NULL, '0.00', '2023-09-20 14:16:55', NULL, NULL),
(162, 164, 2, 1, 2, NULL, '2023-09-20 00:00:00', NULL, 'LI23000162', NULL, '0.00', '2023-09-20 14:42:25', NULL, NULL),
(163, 168, 4, 1, 3, NULL, '2023-09-20 00:00:00', NULL, 'LI23000163', NULL, '0.00', '2023-09-20 16:44:47', NULL, NULL),
(164, 167, 4, 1, 3, NULL, '2023-09-20 00:00:00', NULL, 'LI23000164', NULL, '0.00', '2023-09-20 16:45:04', NULL, NULL),
(165, 166, 4, 1, 3, NULL, '2023-09-20 00:00:00', NULL, 'LI23000165', NULL, '0.00', '2023-09-20 16:45:32', NULL, NULL),
(166, 165, 4, 1, 3, NULL, '2023-09-20 00:00:00', NULL, 'LI23000166', NULL, '0.00', '2023-09-20 16:45:47', NULL, NULL),
(167, 169, 4, 1, 3, NULL, '2023-09-20 00:00:00', NULL, 'LI23000167', NULL, '0.00', '2023-09-20 16:48:03', NULL, NULL),
(168, 170, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000168', NULL, '0.00', '2023-09-21 08:48:56', NULL, NULL),
(169, 125, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000169', NULL, '0.00', '2023-09-21 10:32:40', NULL, NULL),
(170, 171, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000170', NULL, '0.00', '2023-09-21 11:18:55', NULL, NULL),
(171, 172, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000171', NULL, '0.00', '2023-09-21 11:19:25', NULL, NULL),
(172, 173, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000172', NULL, '0.00', '2023-09-21 12:19:03', NULL, NULL),
(173, 174, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000173', NULL, '0.00', '2023-09-21 12:26:42', NULL, NULL),
(174, 175, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000174', NULL, '0.00', '2023-09-21 12:45:26', NULL, NULL),
(175, 177, 4, 1, 3, NULL, '2023-09-21 00:00:00', NULL, 'LI23000175', NULL, '0.00', '2023-09-21 15:11:44', NULL, NULL),
(176, 176, 4, 1, 3, NULL, '2023-09-21 00:00:00', NULL, 'LI23000176', NULL, '0.00', '2023-09-21 15:11:54', NULL, NULL),
(177, 178, 4, 1, 3, NULL, '2023-09-21 00:00:00', NULL, 'LI23000177', NULL, '0.00', '2023-09-21 15:16:41', NULL, NULL),
(178, 179, 2, 1, 3, NULL, '2023-09-21 00:00:00', NULL, 'LI23000178', NULL, '0.00', '2023-09-21 15:21:38', NULL, NULL),
(179, 180, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000179', NULL, '0.00', '2023-09-21 16:16:34', NULL, NULL),
(180, 181, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000180', NULL, '0.00', '2023-09-21 16:35:19', NULL, NULL),
(181, 182, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000181', NULL, '0.00', '2023-09-21 16:51:56', NULL, NULL),
(182, 183, 2, 1, 2, NULL, '2023-09-21 00:00:00', NULL, 'LI23000182', NULL, '0.00', '2023-09-21 16:52:09', NULL, NULL),
(183, 184, 2, 1, 2, NULL, '2023-09-22 00:00:00', NULL, 'LI23000183', NULL, '0.00', '2023-09-22 11:55:01', NULL, NULL),
(184, 185, 2, 1, 2, NULL, '2023-09-22 00:00:00', NULL, 'LI23000184', NULL, '0.00', '2023-09-22 11:55:14', NULL, NULL),
(185, 186, 2, 1, 2, NULL, '2023-09-22 00:00:00', NULL, 'LI23000185', NULL, '0.00', '2023-09-22 11:55:24', NULL, NULL),
(186, 187, 2, 1, 2, NULL, '2023-09-22 00:00:00', NULL, 'LI23000186', NULL, '0.00', '2023-09-22 12:50:38', NULL, NULL),
(187, 188, 2, 1, 2, NULL, '2023-09-22 00:00:00', NULL, 'LI23000187', NULL, '0.00', '2023-09-22 12:50:49', NULL, NULL),
(188, 189, 2, 1, 2, NULL, '2023-09-22 00:00:00', NULL, 'LI23000188', NULL, '0.00', '2023-09-22 12:51:01', NULL, NULL),
(189, 190, 2, 1, 2, NULL, '2023-09-22 00:00:00', NULL, 'LI23000189', NULL, '0.00', '2023-09-22 13:39:41', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `livraison_magasin`
--

DROP TABLE IF EXISTS `livraison_magasin`;
CREATE TABLE IF NOT EXISTS `livraison_magasin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `livraison_id` int NOT NULL,
  `magasin_id` int NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_145931458E54FB25` (`livraison_id`),
  KEY `IDX_1459314520096AE3` (`magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `livraison_magasin`
--

INSERT INTO `livraison_magasin` (`id`, `livraison_id`, `magasin_id`, `est_sup`) VALUES
(1, 1, 1, NULL),
(2, 2, 1, NULL),
(3, 3, 1, NULL),
(4, 4, 1, NULL),
(5, 5, 1, NULL),
(6, 6, 1, NULL),
(7, 7, 1, NULL),
(8, 8, 1, NULL),
(9, 9, 1, NULL),
(10, 10, 1, NULL),
(11, 11, 1, NULL),
(12, 12, 1, NULL),
(13, 13, 1, NULL),
(14, 14, 1, NULL),
(15, 15, 1, NULL),
(16, 16, 1, NULL),
(17, 17, 1, NULL),
(18, 18, 1, NULL),
(19, 19, 1, NULL),
(20, 20, 1, NULL),
(21, 21, 1, NULL),
(22, 22, 1, NULL),
(23, 23, 1, NULL),
(24, 24, 1, NULL),
(25, 25, 1, NULL),
(26, 26, 1, NULL),
(27, 27, 1, NULL),
(28, 28, 1, NULL),
(29, 29, 1, NULL),
(30, 30, 1, NULL),
(31, 31, 1, NULL),
(32, 32, 1, NULL),
(33, 33, 1, NULL),
(34, 34, 1, NULL),
(35, 35, 1, NULL),
(36, 36, 1, NULL),
(37, 37, 1, NULL),
(38, 38, 1, NULL),
(39, 39, 1, NULL),
(40, 40, 1, NULL),
(41, 41, 1, NULL),
(42, 42, 1, NULL),
(43, 43, 1, NULL),
(44, 44, 1, NULL),
(45, 45, 1, NULL),
(46, 46, 1, NULL),
(47, 47, 1, NULL),
(48, 48, 1, NULL),
(49, 49, 1, NULL),
(50, 50, 1, NULL),
(51, 51, 1, NULL),
(52, 52, 1, NULL),
(53, 53, 1, NULL),
(54, 54, 1, NULL),
(55, 55, 1, NULL),
(56, 56, 1, NULL),
(57, 57, 1, NULL),
(58, 58, 1, NULL),
(59, 59, 1, NULL),
(60, 60, 1, NULL),
(61, 61, 1, NULL),
(62, 62, 1, NULL),
(63, 63, 1, NULL),
(64, 64, 1, NULL),
(65, 65, 1, NULL),
(66, 66, 1, NULL),
(67, 67, 1, NULL),
(68, 68, 1, NULL),
(69, 69, 1, NULL),
(70, 70, 1, NULL),
(71, 71, 1, NULL),
(72, 72, 1, NULL),
(73, 73, 1, NULL),
(74, 74, 1, NULL),
(75, 75, 1, NULL),
(76, 76, 1, NULL),
(77, 77, 1, NULL),
(78, 78, 1, NULL),
(79, 79, 1, NULL),
(80, 80, 1, NULL),
(81, 81, 1, NULL),
(82, 82, 1, NULL),
(83, 83, 1, NULL),
(84, 84, 1, NULL),
(85, 85, 1, NULL),
(86, 86, 1, NULL),
(87, 87, 1, NULL),
(88, 88, 1, NULL),
(89, 89, 1, NULL),
(90, 90, 1, NULL),
(91, 91, 1, NULL),
(92, 92, 1, NULL),
(93, 93, 1, NULL),
(94, 94, 1, NULL),
(95, 95, 1, NULL),
(96, 96, 1, NULL),
(97, 97, 1, NULL),
(98, 98, 1, NULL),
(99, 99, 1, NULL),
(100, 100, 1, NULL),
(101, 101, 1, NULL),
(102, 102, 1, NULL),
(103, 103, 1, NULL),
(104, 104, 1, NULL),
(105, 105, 1, NULL),
(106, 106, 1, NULL),
(107, 107, 1, NULL),
(108, 108, 1, NULL),
(109, 109, 1, NULL),
(110, 110, 1, NULL),
(111, 111, 1, NULL),
(112, 112, 1, NULL),
(113, 113, 1, NULL),
(114, 114, 1, NULL),
(115, 115, 1, NULL),
(116, 116, 1, NULL),
(117, 117, 1, NULL),
(118, 118, 1, NULL),
(119, 119, 1, NULL),
(120, 120, 1, NULL),
(121, 121, 1, NULL),
(122, 122, 1, NULL),
(123, 123, 1, NULL),
(124, 124, 1, NULL),
(125, 125, 1, NULL),
(126, 126, 1, NULL),
(127, 127, 1, NULL),
(128, 128, 1, NULL),
(129, 129, 1, NULL),
(130, 130, 1, NULL),
(131, 131, 1, NULL),
(132, 132, 1, NULL),
(133, 133, 1, NULL),
(134, 134, 1, NULL),
(135, 135, 1, NULL),
(136, 136, 1, NULL),
(137, 137, 1, NULL),
(138, 138, 1, NULL),
(139, 139, 1, NULL),
(140, 140, 1, NULL),
(141, 141, 1, NULL),
(142, 142, 1, NULL),
(143, 143, 1, NULL),
(144, 144, 1, NULL),
(145, 145, 1, NULL),
(146, 146, 1, NULL),
(147, 147, 1, NULL),
(148, 148, 1, NULL),
(149, 149, 1, NULL),
(150, 150, 1, NULL),
(151, 151, 1, NULL),
(152, 152, 1, NULL),
(153, 153, 1, NULL),
(154, 154, 1, NULL),
(155, 155, 1, NULL),
(156, 156, 1, NULL),
(157, 157, 1, NULL),
(158, 158, 1, NULL),
(159, 159, 1, NULL),
(160, 160, 1, NULL),
(161, 161, 1, NULL),
(162, 162, 1, NULL),
(163, 163, 1, NULL),
(164, 164, 1, NULL),
(165, 165, 1, NULL),
(166, 166, 1, NULL),
(167, 167, 1, NULL),
(168, 168, 1, NULL),
(169, 169, 1, NULL),
(170, 170, 1, NULL),
(171, 171, 1, NULL),
(172, 172, 1, NULL),
(173, 173, 1, NULL),
(174, 174, 1, NULL),
(175, 175, 1, NULL),
(176, 176, 1, NULL),
(177, 177, 1, NULL),
(178, 178, 1, NULL),
(179, 179, 1, NULL),
(180, 180, 1, NULL),
(181, 181, 1, NULL),
(182, 182, 1, NULL),
(183, 183, 1, NULL),
(184, 184, 1, NULL),
(185, 185, 1, NULL),
(186, 186, 1, NULL),
(187, 187, 1, NULL),
(188, 188, 1, NULL),
(189, 189, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `magasin`
--

DROP TABLE IF EXISTS `magasin`;
CREATE TABLE IF NOT EXISTS `magasin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `superviseur_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `nom_mag` varchar(255) NOT NULL,
  `code_mag` varchar(255) NOT NULL,
  `est_principal` tinyint(1) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `est_defaut` tinyint(1) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_54AF5F27B7BB80FF` (`superviseur_id`),
  KEY `IDX_54AF5F27EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `magasin`
--

INSERT INTO `magasin` (`id`, `superviseur_id`, `point_vente_id`, `nom_mag`, `code_mag`, `est_principal`, `adresse`, `est_defaut`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 'MAGASIN PRINCIPAL', 'MP', 1, '-', NULL, NULL, '2023-09-12 15:37:37', '2023-09-12 15:37:37', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `nom_media` varchar(255) DEFAULT NULL,
  `chemin_media` varchar(80) DEFAULT NULL,
  `num_media` varchar(255) DEFAULT NULL,
  `extension` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6A2CA10CF347EFB` (`produit_id`),
  KEY `IDX_6A2CA10CEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `media`
--

INSERT INTO `media` (`id`, `produit_id`, `point_vente_id`, `nom_media`, `chemin_media`, `num_media`, `extension`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, '1.png', NULL, '', 'png', NULL, '2023-09-12 15:37:37', '2023-09-13 10:02:12', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_superieur_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `sous_titre` varchar(255) DEFAULT NULL,
  `titre` varchar(255) NOT NULL,
  `url` varchar(4000) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `icon` longtext,
  `type_menu` varchar(2) DEFAULT NULL,
  `roles` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7D053A93F9ADC1B4` (`menu_superieur_id`),
  KEY `IDX_7D053A93EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `menu`
--

INSERT INTO `menu` (`id`, `menu_superieur_id`, `point_vente_id`, `sous_titre`, `titre`, `url`, `active`, `icon`, `type_menu`, `roles`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, 'Configuration', 'Application', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path d=\"M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(2, 1, NULL, NULL, 'Menu', 'app_menu_index', 0, NULL, NULL, 'ROLE_MENU', NULL, NULL, NULL),
(3, NULL, NULL, 'ADMINISTRATION', 'Sécurité', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path d=\"M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(4, 3, NULL, NULL, 'Profil', 'app_profil_index', 0, NULL, NULL, 'ROLE_PROFIL', NULL, NULL, NULL),
(5, 3, NULL, NULL, 'Utilisateur', 'app_utilisateur_index', 0, NULL, NULL, 'ROLE_UTILISATEUR', NULL, NULL, NULL),
(6, 3, NULL, NULL, 'Configuration', 'app_configuration_index', 0, NULL, NULL, 'ROLE_CONFIGURATION', NULL, NULL, NULL),
(7, NULL, NULL, 'Etat et Statistique', 'Etat', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path d=\"M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(8, 7, NULL, NULL, 'Mouvement des stocks', 'romassigcom_mouvement_stock', 0, NULL, NULL, 'ROLE_MOUVEMENT_STOCK', NULL, NULL, NULL),
(9, 7, NULL, NULL, 'Statistique des ventes', 'romassigcom_statistique_vente', 0, NULL, NULL, 'ROLE_STAT_VENTE', NULL, NULL, NULL),
(10, 7, NULL, NULL, 'Point des commandes', 'romassigcom_point_commande', 0, NULL, NULL, 'ROLE_POINT_COMMANDE', NULL, NULL, NULL),
(11, 7, NULL, NULL, 'Statistique sur les produits', 'romassigcom_etat_produit', 0, NULL, NULL, 'ROLE_ETAT_PRODUIT', NULL, NULL, NULL),
(12, 7, NULL, NULL, 'Statistique sur les clients', 'romassigcom_etat_client', 0, NULL, NULL, 'ROLE_ETAT_CLIENT', NULL, NULL, NULL),
(13, 7, NULL, NULL, 'Fiche de recensement des carreaux', 'romassigcom_etat_fiche', 0, NULL, NULL, 'ROLE_ETAT_FICHE', NULL, NULL, NULL),
(14, NULL, NULL, 'STANDARD', 'Paramètre', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path opacity=\"0.3\" d=\"M22.1 11.5V12.6C22.1 13.2 21.7 13.6 21.2 13.7L19.9 13.9C19.7 14.7 19.4 15.5 18.9 16.2L19.7 17.2999C20 17.6999 20 18.3999 19.6 18.7999L18.8 19.6C18.4 20 17.8 20 17.3 19.7L16.2 18.9C15.5 19.3 14.7 19.7 13.9 19.9L13.7 21.2C13.6 21.7 13.1 22.1 12.6 22.1H11.5C10.9 22.1 10.5 21.7 10.4 21.2L10.2 19.9C9.4 19.7 8.6 19.4 7.9 18.9L6.8 19.7C6.4 20 5.7 20 5.3 19.6L4.5 18.7999C4.1 18.3999 4.1 17.7999 4.4 17.2999L5.2 16.2C4.8 15.5 4.4 14.7 4.2 13.9L2.9 13.7C2.4 13.6 2 13.1 2 12.6V11.5C2 10.9 2.4 10.5 2.9 10.4L4.2 10.2C4.4 9.39995 4.7 8.60002 5.2 7.90002L4.4 6.79993C4.1 6.39993 4.1 5.69993 4.5 5.29993L5.3 4.5C5.7 4.1 6.3 4.10002 6.8 4.40002L7.9 5.19995C8.6 4.79995 9.4 4.39995 10.2 4.19995L10.4 2.90002C10.5 2.40002 11 2 11.5 2H12.6C13.2 2 13.6 2.40002 13.7 2.90002L13.9 4.19995C14.7 4.39995 15.5 4.69995 16.2 5.19995L17.3 4.40002C17.7 4.10002 18.4 4.1 18.8 4.5L19.6 5.29993C20 5.69993 20 6.29993 19.7 6.79993L18.9 7.90002C19.3 8.60002 19.7 9.39995 19.9 10.2L21.2 10.4C21.7 10.5 22.1 11 22.1 11.5ZM12.1 8.59998C10.2 8.59998 8.6 10.2 8.6 12.1C8.6 14 10.2 15.6 12.1 15.6C14 15.6 15.6 14 15.6 12.1C15.6 10.2 14 8.59998 12.1 8.59998Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M17.1 12.1C17.1 14.9 14.9 17.1 12.1 17.1C9.30001 17.1 7.10001 14.9 7.10001 12.1C7.10001 9.29998 9.30001 7.09998 12.1 7.09998C14.9 7.09998 17.1 9.29998 17.1 12.1ZM12.1 10.1C11 10.1 10.1 11 10.1 12.1C10.1 13.2 11 14.1 12.1 14.1C13.2 14.1 14.1 13.2 14.1 12.1C14.1 11 13.2 10.1 12.1 10.1Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(15, 14, NULL, NULL, 'Société', 'app_societe_index', 0, NULL, NULL, 'ROLE_SOCIETE', NULL, NULL, NULL),
(16, 14, NULL, NULL, 'Famille', 'app_famille_index', 0, NULL, NULL, 'ROLE_FAMILLE', NULL, NULL, NULL),
(17, 14, NULL, NULL, 'Produit', 'app_produit_index', 0, NULL, NULL, 'ROLE_PRODUIT', NULL, NULL, NULL),
(18, 14, NULL, NULL, 'Personnel', 'app_personnel_index', 0, NULL, NULL, 'ROLE_PERSONNEL', NULL, NULL, NULL),
(19, 14, NULL, NULL, 'Fonction', 'app_fonction_index', 0, NULL, NULL, 'ROLE_FONCTION', NULL, NULL, NULL),
(20, 14, NULL, NULL, 'Mode de paiement', 'app_mode_paiement_index', 0, NULL, NULL, 'ROLE_MODE_DE_PAIEMENT', NULL, NULL, NULL),
(21, 14, NULL, NULL, 'Banque', 'app_banque_index', 0, NULL, NULL, 'ROLE_BANQUE', NULL, NULL, NULL),
(22, 14, NULL, NULL, 'Magasin', 'app_magasin_index', 0, NULL, NULL, 'ROLE_MAGASIN', NULL, NULL, NULL),
(23, 14, NULL, NULL, 'Conditionnement', 'app_conditionnement_index', 0, NULL, NULL, 'ROLE_CONDITIONNEMENT', NULL, NULL, NULL),
(24, 14, NULL, NULL, 'Client', 'app_client_index', 0, NULL, NULL, 'ROLE_CLIENT', NULL, NULL, NULL),
(25, 14, NULL, NULL, 'Fournisseur', 'app_fournisseur_index', 0, NULL, NULL, 'ROLE_FOURNISSEUR', NULL, NULL, NULL),
(26, 14, NULL, NULL, 'Monnaie', 'app_monnaie_index', 0, NULL, NULL, 'ROLE_MONNAIE', NULL, NULL, NULL),
(27, 14, NULL, NULL, 'Caisse', 'app_list_caisse_index', 0, NULL, NULL, 'ROLE_CAISSE', NULL, NULL, NULL),
(28, 14, NULL, NULL, 'Type d\'opération', 'app_type_operation_index', 0, NULL, NULL, 'ROLE_TYPE_OPERATION', NULL, NULL, NULL),
(29, 14, NULL, NULL, 'Taxe', 'app_taxe_index', 0, NULL, NULL, 'ROLE_TAXE', NULL, NULL, NULL),
(30, 14, NULL, NULL, 'Point de vente', 'app_point_de_vente_index', 0, NULL, NULL, 'ROLE_POINT_VENTE', NULL, NULL, NULL),
(31, 14, NULL, NULL, 'Modèle Signataire', 'app_model_signataire_index', 0, NULL, NULL, 'ROLE_MODEL_SIGNATAIRE', NULL, NULL, NULL),
(32, 14, NULL, NULL, 'Type de Dépense', 'app_type_depense_index', 0, NULL, NULL, 'ROLE_TYPE_DEPENSE', NULL, NULL, NULL),
(33, NULL, NULL, '', 'Gestion de la vente', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"512\" height=\"512\" viewBox=\"0 0 512 512\" fill=\"currentColor\">\r\n                                        <!--! Font Awesome Free 6.3.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2023 Fonticons, Inc. -->\r\n                                        <path d=\"M64 0C46.3 0 32 14.3 32 32V96c0 17.7 14.3 32 32 32h80v32H87c-31.6 0-58.5 23.1-63.3 54.4L1.1 364.1C.4 368.8 0 373.6 0 378.4V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V378.4c0-4.8-.4-9.6-1.1-14.4L488.2 214.4C483.5 183.1 456.6 160 425 160H208V128h80c17.7 0 32-14.3 32-32V32c0-17.7-14.3-32-32-32H64zM96 48H256c8.8 0 16 7.2 16 16s-7.2 16-16 16H96c-8.8 0-16-7.2-16-16s7.2-16 16-16zM64 432c0-8.8 7.2-16 16-16H432c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm48-168a24 24 0 1 1 0-48 24 24 0 1 1 0 48zm120-24a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM160 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM328 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM256 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM424 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM352 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48z\"/>\r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(34, 33, NULL, NULL, 'Vente', 'app_commande_client_index', 0, NULL, NULL, 'ROLE_COMMANDE_CLIENT', NULL, NULL, NULL),
(35, NULL, NULL, '', 'Gestion de stock', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg style=\"color: white\" width=\"48\" height=\"48\" viewBox=\"0 0 48 48\"  fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> \r\n                                        <path d=\"M27.707 6.29289C28.0975 6.68342 28.0975 7.31658 27.707 7.70711L25.4143 9.99976L27.7071 12.2925C28.0976 12.683 28.0976 13.3162 27.7071 13.7067C27.3166 14.0973 26.6834 14.0973 26.2929 13.7067L24.0001 11.414L21.7074 13.7067C21.3168 14.0973 20.6837 14.0973 20.2931 13.7067C19.9026 13.3162 19.9026 12.683 20.2931 12.2925L22.5859 9.99976L20.2933 7.70711C19.9027 7.31658 19.9027 6.68342 20.2933 6.29289C20.6838 5.90237 21.317 5.90237 21.7075 6.29289L24.0001 8.58554L26.2928 6.29289C26.6833 5.90237 27.3165 5.90237 27.707 6.29289Z\" fill=\"white\"></path> \r\n                                        <path d=\"M19.1975 32.7281C20.5767 33.1878 22.0855 32.7454 23 31.6401L23 42.0231L11 37.5V29.9956L19.1975 32.7281Z\" fill=\"white\"></path> \r\n                                        <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M37 37.5L25 42.0231V31.6401C25.9145 32.7454 27.4234 33.1878 28.8025 32.7281L37 29.9956V37.5Z\" fill=\"white\"></path> \r\n                                        <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M24.3271 15.055C24.1152 14.9817 23.8848 14.9817 23.6729 15.055L10.6748 19.5544L10.6525 19.5623C10.4711 19.6295 10.3204 19.7441 10.2096 19.8872L6.21914 24.8753C6.01489 25.1306 5.94836 25.4697 6.04096 25.7832C6.13356 26.0968 6.3736 26.3453 6.68378 26.4487L20.1838 30.9487C20.6036 31.0886 21.0655 30.936 21.3192 30.5735L24 26.7438L26.6808 30.5735C26.9346 30.936 27.3964 31.0886 27.8162 30.9487L41.3162 26.4487C41.6264 26.3453 41.8665 26.0968 41.9591 25.7832C42.0517 25.4697 41.9851 25.1306 41.7809 24.8753L37.7904 19.8872C37.6803 19.7449 37.5306 19.6307 37.3505 19.5634C37.3421 19.5603 37.3336 19.5572 37.3251 19.5543L24.3271 15.055ZM24 23.9418L33.9429 20.5L24 17.0582L14.0571 20.5L24 23.9418Z\" fill=\"white\"></path> \r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(36, 35, NULL, NULL, 'Suivi de Stock', 'app_stock_en_unite', 0, NULL, NULL, 'ROLE_SUIVI_STOCK', NULL, NULL, NULL),
(37, 35, NULL, NULL, 'Approvisionnement', 'app_approvisionnement_index', 0, NULL, NULL, 'ROLE_APPROVISIONNEMENT', NULL, NULL, NULL),
(38, 35, NULL, NULL, 'Détachement', 'app_detachement_index', 0, NULL, NULL, 'ROLE_LIVRAISON', NULL, NULL, NULL),
(39, 35, NULL, NULL, 'Sortie', 'app_sortie_index', 0, NULL, NULL, 'ROLE_SORTIE', NULL, NULL, NULL),
(40, 35, NULL, NULL, 'Transfert', 'app_transfert_index', 0, NULL, NULL, 'ROLE_TRANSFERT', NULL, NULL, NULL),
(41, 35, NULL, NULL, 'Livraison client', 'app_livraison_index', 0, NULL, NULL, 'ROLE_LIVRAISON', NULL, NULL, NULL),
(42, 35, NULL, NULL, 'Inventaire', 'app_inventaire_index', 0, NULL, NULL, 'ROLE_INVENTAIRE', NULL, NULL, NULL),
(43, NULL, NULL, '', 'Gestion de portefeuilles', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\"\r\n                                                 viewBox=\"0 0 24 24\" fill=\"none\">\r\n                                                <rect x=\"2\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\" fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"2\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                            </svg>\r\n                                        </span>', NULL, '', NULL, NULL, NULL),
(44, 43, NULL, NULL, 'Transaction', 'app_transaction_index', 0, NULL, NULL, 'ROLE_TRANSACTION', NULL, NULL, NULL),
(45, 43, NULL, NULL, 'Compte', 'app_compte_index', 0, NULL, NULL, 'ROLE_COMPTE', NULL, NULL, NULL),
(46, NULL, NULL, '', 'Gestion de la caisse', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"512\" height=\"512\" viewBox=\"0 0 512 512\" fill=\"currentColor\">\r\n                                        <!--! Font Awesome Free 6.3.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2023 Fonticons, Inc. -->\r\n                                        <path d=\"M64 0C46.3 0 32 14.3 32 32V96c0 17.7 14.3 32 32 32h80v32H87c-31.6 0-58.5 23.1-63.3 54.4L1.1 364.1C.4 368.8 0 373.6 0 378.4V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V378.4c0-4.8-.4-9.6-1.1-14.4L488.2 214.4C483.5 183.1 456.6 160 425 160H208V128h80c17.7 0 32-14.3 32-32V32c0-17.7-14.3-32-32-32H64zM96 48H256c8.8 0 16 7.2 16 16s-7.2 16-16 16H96c-8.8 0-16-7.2-16-16s7.2-16 16-16zM64 432c0-8.8 7.2-16 16-16H432c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm48-168a24 24 0 1 1 0-48 24 24 0 1 1 0 48zm120-24a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM160 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM328 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM256 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM424 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM352 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48z\"/>\r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(47, 46, NULL, NULL, 'Paiement', 'app_paiement_index', 0, NULL, NULL, 'ROLE_PAIEMENT', NULL, NULL, NULL),
(48, 46, NULL, NULL, 'Dépôt', 'app_transaction_depot', 0, NULL, NULL, 'ROLE_DEPOT', NULL, NULL, NULL),
(49, 46, NULL, NULL, 'Dépense', 'app_depense_index', 0, NULL, NULL, 'ROLE_DEPENSE', NULL, NULL, NULL),
(50, NULL, NULL, '', 'Gestion des fournisseurs', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\"\r\n                                                 viewBox=\"0 0 24 24\" fill=\"none\">\r\n                                                <rect x=\"2\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\" fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"2\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                            </svg>\r\n                                        </span>', NULL, '', NULL, NULL, NULL),
(51, 50, NULL, NULL, 'Demande de prix', 'app_demande_de_prix_index', 0, NULL, NULL, 'ROLE_DEMANDE_PRIX', NULL, NULL, NULL),
(52, 50, NULL, NULL, 'Commande fournisseur', 'app_commande_frs_index', 0, NULL, NULL, 'ROLE_COMMANDE_FRS', NULL, NULL, NULL),
(53, NULL, NULL, '', 'Gestion des factures', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\"\r\n                                            viewBox=\"0 0 24 24\" fill=\"none\">\r\n                                        <rect x=\"2\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\" fill=\"currentColor\"/>\r\n                                        <rect opacity=\"0.3\" x=\"13\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                fill=\"currentColor\"/>\r\n                                        <rect opacity=\"0.3\" x=\"13\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                fill=\"currentColor\"/>\r\n                                        <rect opacity=\"0.3\" x=\"2\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                fill=\"currentColor\"/>\r\n                                    </svg>\r\n                                </span>', NULL, '', NULL, NULL, NULL),
(54, 53, NULL, NULL, 'Facture', 'app_facture_index', 0, NULL, NULL, 'ROLE_FACTURE', NULL, NULL, NULL),
(55, 53, NULL, NULL, 'Facture proforma', 'app_facture_proforma_index', 0, NULL, NULL, 'ROLE_FACTURE_PRO_FORMA', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `model_signataire`
--

DROP TABLE IF EXISTS `model_signataire`;
CREATE TABLE IF NOT EXISTS `model_signataire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `est_default` tinyint(1) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4D1B8005EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `model_signataire`
--

INSERT INTO `model_signataire` (`id`, `point_vente_id`, `est_default`, `libelle`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 'Model 1', NULL, '2023-09-13 10:09:47', '2023-09-13 10:09:47', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `model_signataire_personnel_fonction`
--

DROP TABLE IF EXISTS `model_signataire_personnel_fonction`;
CREATE TABLE IF NOT EXISTS `model_signataire_personnel_fonction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `fonction_id` int NOT NULL,
  `model_signataire_id` int NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_17B9DBC91C109075` (`personnel_id`),
  KEY `IDX_17B9DBC957889920` (`fonction_id`),
  KEY `IDX_17B9DBC9D16C5631` (`model_signataire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `model_signataire_personnel_fonction`
--

INSERT INTO `model_signataire_personnel_fonction` (`id`, `personnel_id`, `fonction_id`, `model_signataire_id`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 4, 1, NULL, '2023-09-12 15:37:37', '2023-09-13 10:09:47', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `mode_paiement`
--

DROP TABLE IF EXISTS `mode_paiement`;
CREATE TABLE IF NOT EXISTS `mode_paiement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B2BB0E85EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `mode_paiement`
--

INSERT INTO `mode_paiement` (`id`, `point_vente_id`, `code`, `libelle`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'ESP', 'espèce', NULL, '2023-09-12 15:37:36', NULL, NULL),
(2, NULL, 'CC', 'Compte', NULL, '2023-09-12 15:37:36', NULL, NULL),
(3, NULL, 'CH', 'Chèque', NULL, '2023-09-12 15:37:36', NULL, NULL),
(4, NULL, 'VIR', 'Virement', NULL, '2023-09-12 15:37:36', NULL, NULL),
(5, NULL, 'MMO', 'Mobile Money', NULL, '2023-09-12 15:37:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `monnaie`
--

DROP TABLE IF EXISTS `monnaie`;
CREATE TABLE IF NOT EXISTS `monnaie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `valeur` int NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B3A6E2E6EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `monnaie`
--

INSERT INTO `monnaie` (`id`, `point_vente_id`, `libelle`, `valeur`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '5F CFA', 5, NULL, '2023-09-12 15:37:36', NULL, NULL),
(2, 1, '10F CFA', 10, NULL, '2023-09-12 15:37:36', NULL, NULL),
(3, 1, '25F CFA', 25, NULL, '2023-09-12 15:37:36', NULL, NULL),
(4, 1, '50F CFA', 50, NULL, '2023-09-12 15:37:36', NULL, NULL),
(5, 1, '100F CFA', 100, NULL, '2023-09-12 15:37:36', NULL, NULL),
(6, 1, '200F CFA', 200, NULL, '2023-09-12 15:37:36', NULL, NULL),
(7, 1, '250F CFA', 250, NULL, '2023-09-12 15:37:36', NULL, NULL),
(8, 1, '500F CFA', 500, NULL, '2023-09-12 15:37:36', NULL, NULL),
(9, 1, '1000F CFA', 1000, NULL, '2023-09-12 15:37:36', NULL, NULL),
(10, 1, '2000F CFA', 2000, NULL, '2023-09-12 15:37:36', NULL, NULL),
(11, 1, '5000F CFA', 5000, NULL, '2023-09-12 15:37:36', NULL, NULL),
(12, 1, '10000F CFA', 10000, NULL, '2023-09-12 15:37:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `monnaie_caisse`
--

DROP TABLE IF EXISTS `monnaie_caisse`;
CREATE TABLE IF NOT EXISTS `monnaie_caisse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `caisse_id` int NOT NULL,
  `monnaie_id` int NOT NULL,
  `nbr` int NOT NULL DEFAULT '0',
  `montant` decimal(10,0) NOT NULL DEFAULT '0',
  `etat` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_80CC16AD27B4FEBF` (`caisse_id`),
  KEY `IDX_80CC16AD98D3FE22` (`monnaie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `monnaie_caisse`
--

INSERT INTO `monnaie_caisse` (`id`, `caisse_id`, `monnaie_id`, `nbr`, `montant`, `etat`) VALUES
(1, 1, 12, 0, '0', 0),
(2, 1, 11, 0, '0', 0),
(3, 1, 10, 0, '0', 0),
(4, 1, 9, 0, '0', 0),
(5, 1, 8, 0, '0', 0),
(6, 1, 7, 0, '0', 0),
(7, 1, 6, 0, '0', 0),
(8, 1, 5, 0, '0', 0),
(9, 1, 4, 0, '0', 0),
(10, 1, 3, 0, '0', 0),
(11, 1, 2, 0, '0', 0),
(12, 1, 1, 0, '0', 0),
(13, 2, 12, 1100, '11000000', 0),
(14, 2, 11, 0, '0', 0),
(15, 2, 10, 82, '164000', 0),
(16, 2, 9, 0, '0', 0),
(17, 2, 8, 51, '25500', 0),
(18, 2, 7, 0, '0', 0),
(19, 2, 6, 50, '10000', 0),
(20, 2, 5, 0, '0', 0),
(21, 2, 4, 4, '200', 0),
(22, 2, 3, 1, '25', 0),
(23, 2, 2, 0, '0', 0),
(24, 2, 1, 0, '0', 0),
(25, 3, 12, 5, '50000', 0),
(26, 3, 11, 2, '10000', 0),
(27, 3, 10, 10, '20000', 0),
(28, 3, 9, 1, '1000', 0),
(29, 3, 8, 0, '0', 0),
(30, 3, 7, 0, '0', 0),
(31, 3, 6, 0, '0', 0),
(32, 3, 5, 26, '2600', 0),
(33, 3, 4, 0, '0', 0),
(34, 3, 3, 0, '0', 0),
(35, 3, 2, 0, '0', 0),
(36, 3, 1, 0, '0', 0),
(37, 4, 12, 14, '140000', 0),
(38, 4, 11, 24, '120000', 0),
(39, 4, 10, 12, '24000', 0),
(40, 4, 9, 1, '1000', 0),
(41, 4, 8, 0, '0', 0),
(42, 4, 7, 0, '0', 0),
(43, 4, 6, 0, '0', 0),
(44, 4, 5, 4, '400', 0),
(45, 4, 4, 0, '0', 0),
(46, 4, 3, 0, '0', 0),
(47, 4, 2, 0, '0', 0),
(48, 4, 1, 0, '0', 0),
(49, 5, 12, 0, '0', 0),
(50, 5, 11, 0, '0', 0),
(51, 5, 10, 0, '0', 0),
(52, 5, 9, 0, '0', 0),
(53, 5, 8, 0, '0', 0),
(54, 5, 7, 0, '0', 0),
(55, 5, 6, 0, '0', 0),
(56, 5, 5, 125, '12500', 0),
(57, 5, 4, 0, '0', 0),
(58, 5, 3, 0, '0', 0),
(59, 5, 2, 0, '0', 0),
(60, 5, 1, 0, '0', 0),
(61, 6, 12, 1, '10000', 0),
(62, 6, 11, 160, '800000', 0),
(63, 6, 10, 1, '2000', 0),
(64, 6, 9, 0, '0', 0),
(65, 6, 8, 0, '0', 0),
(66, 6, 7, 0, '0', 0),
(67, 6, 6, 0, '0', 0),
(68, 6, 5, 59, '5900', 0),
(69, 6, 4, 0, '0', 0),
(70, 6, 3, 0, '0', 0),
(71, 6, 2, 0, '0', 0),
(72, 6, 1, 0, '0', 0),
(73, 7, 12, 0, '0', 0),
(74, 7, 11, 0, '0', 0),
(75, 7, 10, 0, '0', 0),
(76, 7, 9, 0, '0', 0),
(77, 7, 8, 0, '0', 0),
(78, 7, 7, 0, '0', 0),
(79, 7, 6, 0, '0', 0),
(80, 7, 5, 0, '0', 0),
(81, 7, 4, 0, '0', 0),
(82, 7, 3, 0, '0', 0),
(83, 7, 2, 0, '0', 0),
(84, 7, 1, 0, '0', 0),
(85, 8, 12, 95, '950000', 0),
(86, 8, 11, 201, '1005000', 0),
(87, 8, 10, 0, '0', 0),
(88, 8, 9, 0, '0', 0),
(89, 8, 8, 0, '0', 0),
(90, 8, 7, 0, '0', 0),
(91, 8, 6, 0, '0', 0),
(92, 8, 5, 0, '0', 0),
(93, 8, 4, 2, '100', 0),
(94, 8, 3, 0, '0', 0),
(95, 8, 2, 0, '0', 0),
(96, 8, 1, 0, '0', 0),
(97, 9, 12, 0, '0', 0),
(98, 9, 11, 0, '0', 0),
(99, 9, 10, 0, '0', 0),
(100, 9, 9, 0, '0', 0),
(101, 9, 8, 0, '0', 0),
(102, 9, 7, 0, '0', 0),
(103, 9, 6, 0, '0', 0),
(104, 9, 5, 0, '0', 0),
(105, 9, 4, 0, '0', 0),
(106, 9, 3, 0, '0', 0),
(107, 9, 2, 0, '0', 0),
(108, 9, 1, 0, '0', 0),
(109, 10, 12, 108, '1080000', 0),
(110, 10, 11, 42, '210000', 0),
(111, 10, 10, 0, '0', 0),
(112, 10, 9, 0, '0', 0),
(113, 10, 8, 1, '500', 0),
(114, 10, 7, 0, '0', 0),
(115, 10, 6, 0, '0', 0),
(116, 10, 5, 2, '200', 0),
(117, 10, 4, 1, '50', 0),
(118, 10, 3, 0, '0', 0),
(119, 10, 2, 0, '0', 0),
(120, 10, 1, 0, '0', 0),
(121, 11, 12, 0, '0', 0),
(122, 11, 11, 0, '0', 0),
(123, 11, 10, 0, '0', 0),
(124, 11, 9, 0, '0', 0),
(125, 11, 8, 0, '0', 0),
(126, 11, 7, 0, '0', 0),
(127, 11, 6, 0, '0', 0),
(128, 11, 5, 125, '12500', 0),
(129, 11, 4, 0, '0', 0),
(130, 11, 3, 0, '0', 0),
(131, 11, 2, 0, '0', 0),
(132, 11, 1, 0, '0', 0),
(133, 12, 12, 216, '2160000', 0),
(134, 12, 11, 22, '110000', 0),
(135, 12, 10, 1, '2000', 0),
(136, 12, 9, 2, '2000', 0),
(137, 12, 8, 3, '1500', 0),
(138, 12, 7, 0, '0', 0),
(139, 12, 6, 1, '200', 0),
(140, 12, 5, 113, '11300', 0),
(141, 12, 4, 2, '100', 0),
(142, 12, 3, 0, '0', 0),
(143, 12, 2, 0, '0', 0),
(144, 12, 1, 0, '0', 0),
(145, 13, 12, 0, '0', 0),
(146, 13, 11, 0, '0', 0),
(147, 13, 10, 0, '0', 0),
(148, 13, 9, 0, '0', 0),
(149, 13, 8, 2, '1000', 0),
(150, 13, 7, 0, '0', 0),
(151, 13, 6, 1, '200', 0),
(152, 13, 5, 112, '11200', 0),
(153, 13, 4, 2, '100', 0),
(154, 13, 3, 0, '0', 0),
(155, 13, 2, 0, '0', 0),
(156, 13, 1, 0, '0', 0);

-- --------------------------------------------------------

--
-- Structure de la table `paiement`
--

DROP TABLE IF EXISTS `paiement`;
CREATE TABLE IF NOT EXISTS `paiement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mode_paiement_id` int NOT NULL,
  `facture_id` int DEFAULT NULL,
  `transaction_id` int DEFAULT NULL,
  `banque_id` int DEFAULT NULL,
  `caisse_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `date_paie` datetime NOT NULL,
  `montant_paye` decimal(10,2) NOT NULL,
  `montant_rapayer` decimal(10,2) NOT NULL,
  `ref_paie` varchar(255) NOT NULL,
  `numero_mobile_money` varchar(255) DEFAULT NULL,
  `ref_operation` varchar(255) DEFAULT NULL,
  `montant_recu` decimal(10,2) DEFAULT '0.00',
  `reliquat` decimal(10,0) DEFAULT '0',
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B1DC7A1E438F5B63` (`mode_paiement_id`),
  KEY `IDX_B1DC7A1E7F2DEE08` (`facture_id`),
  KEY `IDX_B1DC7A1E2FC0CB0F` (`transaction_id`),
  KEY `IDX_B1DC7A1E37E080D9` (`banque_id`),
  KEY `IDX_B1DC7A1E27B4FEBF` (`caisse_id`),
  KEY `IDX_B1DC7A1EEFA24D68` (`point_vente_id`),
  KEY `IDX_B1DC7A1E3F192FC` (`operateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `paiement`
--

INSERT INTO `paiement` (`id`, `mode_paiement_id`, `facture_id`, `transaction_id`, `banque_id`, `caisse_id`, `point_vente_id`, `operateur_id`, `date_paie`, `montant_paye`, `montant_rapayer`, `ref_paie`, `numero_mobile_money`, `ref_operation`, `montant_recu`, `reliquat`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 2, NULL, NULL, 1, 1, 3, '2023-09-13 12:10:35', '30000.00', '0.00', 'PA23000001', NULL, NULL, '30000.00', '0', NULL, '2023-09-13 12:10:35', NULL, NULL),
(2, 1, 3, NULL, NULL, 1, 1, 3, '2023-09-13 12:25:27', '5500.00', '0.00', 'PA23000002', NULL, NULL, '5500.00', '0', NULL, '2023-09-13 12:25:27', NULL, NULL),
(3, 1, 4, NULL, NULL, 1, 1, 3, '2023-09-13 14:02:44', '7500.00', '0.00', 'PA23000003', NULL, NULL, '7500.00', '0', NULL, '2023-09-13 14:02:44', NULL, NULL),
(4, 1, 5, NULL, NULL, 1, 1, 3, '2023-09-13 14:04:56', '8600.00', '0.00', 'PA23000004', NULL, NULL, '8600.00', '0', NULL, '2023-09-13 14:04:56', NULL, NULL),
(5, 1, 6, NULL, NULL, 1, 1, 3, '2023-09-13 14:06:34', '18500.00', '0.00', 'PA23000005', NULL, NULL, '18500.00', '0', NULL, '2023-09-13 14:06:34', NULL, NULL),
(6, 1, 7, NULL, NULL, 1, 1, 3, '2023-09-13 14:17:07', '148000.00', '0.00', 'PA23000006', NULL, NULL, '148000.00', '0', NULL, '2023-09-13 14:17:07', NULL, NULL),
(7, 1, 8, NULL, NULL, 1, 1, 3, '2023-09-13 14:18:50', '45000.00', '0.00', 'PA23000007', NULL, NULL, '45000.00', '0', NULL, '2023-09-13 14:18:50', NULL, NULL),
(8, 1, 9, NULL, NULL, 1, 1, 3, '2023-09-13 14:20:13', '112500.00', '0.00', 'PA23000008', NULL, NULL, '112500.00', '0', NULL, '2023-09-13 14:20:13', NULL, NULL),
(9, 1, 10, NULL, NULL, 1, 1, 3, '2023-09-13 14:21:35', '27000.00', '0.00', 'PA23000009', NULL, NULL, '27000.00', '0', NULL, '2023-09-13 14:21:35', NULL, NULL),
(10, 1, 11, NULL, NULL, 1, 1, 3, '2023-09-13 14:25:08', '330000.00', '0.00', 'PA23000010', NULL, NULL, '330000.00', '0', NULL, '2023-09-13 14:25:08', NULL, NULL),
(11, 1, 12, NULL, NULL, 1, 1, 3, '2023-09-13 14:26:43', '97500.00', '0.00', 'PA23000011', NULL, NULL, '97500.00', '0', NULL, '2023-09-13 14:26:43', NULL, NULL),
(12, 1, 13, NULL, NULL, 1, 1, 3, '2023-09-13 14:27:44', '112000.00', '0.00', 'PA23000012', NULL, NULL, '112000.00', '0', NULL, '2023-09-13 14:27:44', NULL, NULL),
(13, 1, 14, NULL, NULL, 1, 1, 3, '2023-09-13 14:34:35', '17000.00', '0.00', 'PA23000013', NULL, NULL, '17000.00', '0', NULL, '2023-09-13 14:34:35', NULL, NULL),
(14, 1, 15, NULL, NULL, 1, 1, 3, '2023-09-13 15:45:03', '27000.00', '0.00', 'PA23000014', NULL, NULL, '27000.00', '0', NULL, '2023-09-13 15:45:03', NULL, NULL),
(15, 1, 16, NULL, NULL, 1, 1, 3, '2023-09-13 15:46:07', '2500.00', '0.00', 'PA23000015', NULL, NULL, '2500.00', '0', NULL, '2023-09-13 15:46:07', NULL, NULL),
(16, 1, 17, NULL, NULL, 1, 1, 3, '2023-09-13 15:47:35', '45000.00', '0.00', 'PA23000016', NULL, NULL, '45000.00', '0', NULL, '2023-09-13 15:47:35', NULL, NULL),
(17, 1, 18, NULL, NULL, 1, 1, 3, '2023-09-13 15:48:42', '157500.00', '0.00', 'PA23000017', NULL, NULL, '157500.00', '0', NULL, '2023-09-13 15:48:42', NULL, NULL),
(18, 1, 19, NULL, NULL, 1, 1, 3, '2023-09-13 16:19:15', '10600.00', '0.00', 'PA23000018', NULL, NULL, '10600.00', '0', NULL, '2023-09-13 16:19:15', NULL, NULL),
(19, 1, 20, NULL, NULL, 1, 1, 3, '2023-09-13 16:29:06', '7500.00', '0.00', 'PA23000019', NULL, NULL, '7500.00', '0', NULL, '2023-09-13 16:29:06', NULL, NULL),
(20, 1, 21, NULL, NULL, 1, 1, 3, '2023-09-13 16:30:23', '106000.00', '0.00', 'PA23000020', NULL, NULL, '106000.00', '0', NULL, '2023-09-13 16:30:23', NULL, NULL),
(21, 1, 22, NULL, NULL, 1, 1, 3, '2023-09-13 18:42:29', '95000.00', '0.00', 'PA23000021', NULL, NULL, '95000.00', '0', NULL, '2023-09-13 18:42:29', NULL, NULL),
(22, 1, 23, NULL, NULL, 1, 1, 3, '2023-09-13 00:00:00', '10000.00', '2000.00', 'PA23000022', NULL, NULL, '10000.00', '0', NULL, '2023-09-13 18:49:34', NULL, NULL),
(23, 1, 24, NULL, NULL, 1, 1, 3, '2023-09-13 18:53:30', '172500.00', '0.00', 'PA23000023', NULL, NULL, '172500.00', '0', NULL, '2023-09-13 18:53:30', NULL, NULL),
(24, 1, 25, NULL, NULL, 1, 1, 3, '2023-09-13 18:54:46', '76500.00', '0.00', 'PA23000024', NULL, NULL, '76500.00', '0', NULL, '2023-09-13 18:54:46', NULL, NULL),
(25, 1, 26, NULL, NULL, 1, 1, 3, '2023-09-13 18:55:55', '2800.00', '0.00', 'PA23000025', NULL, NULL, '2800.00', '0', NULL, '2023-09-13 18:55:55', NULL, NULL),
(26, 1, 27, NULL, NULL, 1, 1, 3, '2023-09-13 18:56:58', '55500.00', '0.00', 'PA23000026', NULL, NULL, '55500.00', '0', NULL, '2023-09-13 18:56:58', NULL, NULL),
(27, 1, 28, NULL, NULL, 1, 1, 3, '2023-09-13 19:00:48', '4000.00', '0.00', 'PA23000027', NULL, NULL, '4000.00', '0', NULL, '2023-09-13 19:00:48', NULL, NULL),
(28, 1, 29, NULL, NULL, 1, 1, 3, '2023-09-13 19:01:53', '37000.00', '0.00', 'PA23000028', NULL, NULL, '37000.00', '0', NULL, '2023-09-13 19:01:53', NULL, NULL),
(29, 1, 30, NULL, NULL, 1, 1, 3, '2023-09-13 19:05:45', '82500.00', '0.00', 'PA23000029', NULL, NULL, '82500.00', '0', NULL, '2023-09-13 19:05:45', NULL, NULL),
(30, 1, 33, NULL, NULL, 1, 1, 3, '2023-09-13 19:25:56', '112000.00', '0.00', 'PA23000030', NULL, NULL, '112000.00', '0', NULL, '2023-09-13 19:25:56', NULL, NULL),
(31, 1, 34, NULL, NULL, 1, 1, 3, '2023-09-13 19:27:10', '62400.00', '0.00', 'PA23000031', NULL, NULL, '62400.00', '0', NULL, '2023-09-13 19:27:10', NULL, NULL),
(32, 1, 35, NULL, NULL, 1, 1, 3, '2023-09-13 19:28:30', '34500.00', '0.00', 'PA23000032', NULL, NULL, '34500.00', '0', NULL, '2023-09-13 19:28:30', NULL, NULL),
(33, 1, 36, NULL, NULL, 1, 1, 3, '2023-09-13 19:29:25', '60000.00', '0.00', 'PA23000033', NULL, NULL, '60000.00', '0', NULL, '2023-09-13 19:29:25', NULL, NULL),
(34, 1, 37, NULL, NULL, 1, 1, 3, '2023-09-13 19:30:14', '35000.00', '0.00', 'PA23000034', NULL, NULL, '35000.00', '0', NULL, '2023-09-13 19:30:14', NULL, NULL),
(35, 1, 38, NULL, NULL, 1, 1, 3, '2023-09-13 19:31:41', '25800.00', '0.00', 'PA23000035', NULL, NULL, '25800.00', '0', NULL, '2023-09-13 19:31:41', NULL, NULL),
(36, 1, 39, NULL, NULL, 1, 1, 3, '2023-09-13 19:32:24', '65000.00', '0.00', 'PA23000036', NULL, NULL, '65000.00', '0', NULL, '2023-09-13 19:32:24', NULL, NULL),
(37, 1, 40, NULL, NULL, 1, 1, 3, '2023-09-13 19:37:21', '368500.00', '0.00', 'PA23000037', NULL, NULL, '368500.00', '0', NULL, '2023-09-13 19:37:22', NULL, NULL),
(38, 1, 41, NULL, NULL, 1, 1, 3, '2023-09-13 19:40:38', '62500.00', '0.00', 'PA23000038', NULL, NULL, '62500.00', '0', NULL, '2023-09-13 19:40:38', NULL, NULL),
(39, 1, 42, NULL, NULL, 1, 1, 3, '2023-09-13 19:41:24', '57600.00', '0.00', 'PA23000039', NULL, NULL, '57600.00', '0', NULL, '2023-09-13 19:41:24', NULL, NULL),
(40, 1, 43, NULL, NULL, 1, 1, 3, '2023-09-14 07:47:52', '26500.00', '0.00', 'PA23000040', NULL, NULL, '26500.00', '0', NULL, '2023-09-14 07:47:52', NULL, NULL),
(41, 1, 44, NULL, NULL, 1, 1, 3, '2023-09-14 07:50:05', '167000.00', '0.00', 'PA23000041', NULL, NULL, '167000.00', '0', NULL, '2023-09-14 07:50:05', NULL, NULL),
(42, 1, 45, NULL, NULL, 1, 1, 3, '2023-09-14 07:51:10', '60000.00', '0.00', 'PA23000042', NULL, NULL, '60000.00', '0', NULL, '2023-09-14 07:51:10', NULL, NULL),
(43, 1, 46, NULL, NULL, 1, 1, 3, '2023-09-14 07:52:03', '62500.00', '0.00', 'PA23000043', NULL, NULL, '62500.00', '0', NULL, '2023-09-14 07:52:03', NULL, NULL),
(44, 1, 48, NULL, NULL, 1, 1, 3, '2023-09-14 07:55:49', '43400.00', '0.00', 'PA23000044', NULL, NULL, '43400.00', '0', NULL, '2023-09-14 07:55:49', NULL, NULL),
(45, 1, 49, NULL, NULL, 1, 1, 3, '2023-09-14 07:59:32', '23100.00', '0.00', 'PA23000045', NULL, NULL, '23100.00', '0', NULL, '2023-09-14 07:59:32', NULL, NULL),
(46, 1, 50, NULL, NULL, 1, 1, 3, '2023-09-14 08:02:14', '362500.00', '0.00', 'PA23000046', NULL, NULL, '362500.00', '0', NULL, '2023-09-14 08:02:14', NULL, NULL),
(47, 1, 51, NULL, NULL, 1, 1, 3, '2023-09-14 08:05:50', '85000.00', '0.00', 'PA23000047', NULL, NULL, '85000.00', '0', NULL, '2023-09-14 08:05:50', NULL, NULL),
(48, 1, 52, NULL, NULL, 1, 1, 3, '2023-09-14 08:07:06', '4500.00', '0.00', 'PA23000048', NULL, NULL, '4500.00', '0', NULL, '2023-09-14 08:07:06', NULL, NULL),
(49, 1, 54, NULL, NULL, 1, 1, 3, '2023-09-14 08:08:58', '7800.00', '0.00', 'PA23000049', NULL, NULL, '7800.00', '0', NULL, '2023-09-14 08:08:58', NULL, NULL),
(50, 1, 55, NULL, NULL, 1, 1, 3, '2023-09-14 08:13:05', '167000.00', '0.00', 'PA23000050', NULL, NULL, '167000.00', '0', NULL, '2023-09-14 08:13:05', NULL, NULL),
(51, 1, 59, NULL, NULL, 1, 1, 3, '2023-09-14 08:26:20', '31800.00', '0.00', 'PA23000051', NULL, NULL, '31800.00', '0', NULL, '2023-09-14 08:26:20', NULL, NULL),
(52, 1, 60, NULL, NULL, 1, 1, 3, '2023-09-14 08:27:40', '100000.00', '0.00', 'PA23000052', NULL, NULL, '100000.00', '0', NULL, '2023-09-14 08:27:40', NULL, NULL),
(53, 1, 62, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '160000.00', '2000.00', 'PA23000053', NULL, NULL, '160000.00', '0', NULL, '2023-09-14 08:38:04', NULL, NULL),
(54, 1, 63, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '64000.00', '0.00', 'PA23000054', NULL, NULL, '64000.00', '0', NULL, '2023-09-14 08:39:45', NULL, NULL),
(55, 1, 64, NULL, NULL, 1, 1, 3, '2023-09-14 08:40:54', '11250.00', '0.00', 'PA23000055', NULL, NULL, '11250.00', '0', NULL, '2023-09-14 08:40:54', NULL, NULL),
(56, 1, 66, NULL, NULL, 1, 1, 3, '2023-09-14 08:53:57', '18650.00', '0.00', 'PA23000056', NULL, NULL, '18650.00', '0', NULL, '2023-09-14 08:53:57', NULL, NULL),
(57, 1, 67, NULL, NULL, 1, 1, 3, '2023-09-14 08:55:19', '42000.00', '0.00', 'PA23000057', NULL, NULL, '42000.00', '0', NULL, '2023-09-14 08:55:19', NULL, NULL),
(58, 1, 69, NULL, NULL, 1, 1, 3, '2023-09-14 09:37:24', '114000.00', '0.00', 'PA23000058', NULL, NULL, '114000.00', '0', NULL, '2023-09-14 09:37:24', NULL, NULL),
(59, 1, 70, NULL, NULL, 1, 1, 3, '2023-09-14 09:38:49', '22500.00', '0.00', 'PA23000059', NULL, NULL, '22500.00', '0', NULL, '2023-09-14 09:38:49', NULL, NULL),
(60, 1, 72, NULL, NULL, 1, 1, 3, '2023-09-14 09:50:24', '50300.00', '0.00', 'PA23000060', NULL, NULL, '50300.00', '0', NULL, '2023-09-14 09:50:24', NULL, NULL),
(61, 1, 76, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '1650.00', '0.00', 'PA23000061', NULL, NULL, '1650.00', '0', NULL, '2023-09-14 10:14:07', NULL, NULL),
(62, 1, 75, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '84000.00', '0.00', 'PA23000062', NULL, NULL, '84000.00', '0', NULL, '2023-09-14 10:15:24', NULL, NULL),
(63, 1, 1, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '26000.00', '0.00', 'PA23000063', NULL, NULL, '26000.00', '0', NULL, '2023-09-14 10:24:20', NULL, NULL),
(64, 1, 61, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '16500.00', '0.00', 'PA23000064', NULL, NULL, '16500.00', '0', NULL, '2023-09-14 12:39:26', NULL, NULL),
(65, 1, 68, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '25000.00', '0.00', 'PA23000065', NULL, NULL, '25000.00', '0', NULL, '2023-09-14 12:47:06', NULL, NULL),
(66, 1, 73, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '64500.00', '0.00', 'PA23000066', NULL, NULL, '64500.00', '0', NULL, '2023-09-14 12:51:51', NULL, NULL),
(67, 1, 78, NULL, NULL, 1, 1, 3, '2023-09-14 13:03:08', '34600.00', '0.00', 'PA23000067', NULL, NULL, '34600.00', '0', NULL, '2023-09-14 13:03:08', NULL, NULL),
(68, 1, 80, NULL, NULL, 1, 1, 3, '2023-09-14 13:25:10', '106000.00', '0.00', 'PA23000068', NULL, NULL, '106000.00', '0', NULL, '2023-09-14 13:25:10', NULL, NULL),
(69, 1, 81, NULL, NULL, 1, 1, 3, '2023-09-14 13:26:59', '67500.00', '0.00', 'PA23000069', NULL, NULL, '67500.00', '0', NULL, '2023-09-14 13:26:59', NULL, NULL),
(70, 1, 82, NULL, NULL, 1, 1, 3, '2023-09-14 13:28:07', '6000.00', '0.00', 'PA23000070', NULL, NULL, '6000.00', '0', NULL, '2023-09-14 13:28:07', NULL, NULL),
(71, 1, 83, NULL, NULL, 1, 1, 3, '2023-09-14 13:28:42', '500.00', '0.00', 'PA23000071', NULL, NULL, '500.00', '0', NULL, '2023-09-14 13:28:42', NULL, NULL),
(72, 1, 84, NULL, NULL, 1, 1, 3, '2023-09-14 13:29:37', '25000.00', '0.00', 'PA23000072', NULL, NULL, '25000.00', '0', NULL, '2023-09-14 13:29:37', NULL, NULL),
(73, 1, 85, NULL, NULL, 1, 1, 3, '2023-09-14 13:31:35', '130000.00', '0.00', 'PA23000073', NULL, NULL, '130000.00', '0', NULL, '2023-09-14 13:31:35', NULL, NULL),
(74, 1, 86, NULL, NULL, 1, 1, 3, '2023-09-14 13:51:16', '1089800.00', '0.00', 'PA23000074', NULL, NULL, '1089800.00', '0', NULL, '2023-09-14 13:51:16', NULL, NULL),
(75, 1, 87, NULL, NULL, 1, 1, 3, '2023-09-14 13:52:21', '66700.00', '0.00', 'PA23000075', NULL, NULL, '66700.00', '0', NULL, '2023-09-14 13:52:21', NULL, NULL),
(76, 1, 88, NULL, NULL, 1, 1, 3, '2023-09-14 13:54:04', '22500.00', '0.00', 'PA23000076', NULL, NULL, '22500.00', '0', NULL, '2023-09-14 13:54:04', NULL, NULL),
(77, 1, 89, NULL, NULL, 1, 1, 3, '2023-09-14 13:55:14', '37500.00', '0.00', 'PA23000077', NULL, NULL, '37500.00', '0', NULL, '2023-09-14 13:55:14', NULL, NULL),
(78, 1, 23, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '2000.00', '0.00', 'PA23000078', NULL, NULL, '2000.00', '0', NULL, '2023-09-14 13:56:14', NULL, NULL),
(79, 1, 90, NULL, NULL, 1, 1, 3, '2023-09-14 14:08:40', '1000.00', '0.00', 'PA23000079', NULL, NULL, '1000.00', '0', NULL, '2023-09-14 14:08:40', NULL, NULL),
(80, 1, 91, NULL, NULL, 1, 1, 3, '2023-09-14 14:11:04', '8600.00', '0.00', 'PA23000080', NULL, NULL, '8600.00', '0', NULL, '2023-09-14 14:11:04', NULL, NULL),
(81, 1, 92, NULL, NULL, 1, 1, 3, '2023-09-14 14:11:52', '23000.00', '0.00', 'PA23000081', NULL, NULL, '23000.00', '0', NULL, '2023-09-14 14:11:52', NULL, NULL),
(82, 1, 93, NULL, NULL, 1, 1, 3, '2023-09-14 14:13:12', '105500.00', '0.00', 'PA23000082', NULL, NULL, '105500.00', '0', NULL, '2023-09-14 14:13:12', NULL, NULL),
(83, 1, 94, NULL, NULL, 1, 1, 3, '2023-09-14 14:58:50', '17000.00', '0.00', 'PA23000083', NULL, NULL, '17000.00', '0', NULL, '2023-09-14 14:58:50', NULL, NULL),
(84, 1, 95, NULL, NULL, 1, 1, 3, '2023-09-14 15:44:19', '715000.00', '0.00', 'PA23000084', NULL, NULL, '715000.00', '0', NULL, '2023-09-14 15:44:19', NULL, NULL),
(85, 1, 97, NULL, NULL, 1, 1, 3, '2023-09-14 15:52:31', '434000.00', '0.00', 'PA23000085', NULL, NULL, '434000.00', '0', NULL, '2023-09-14 15:52:31', NULL, NULL),
(86, 1, 99, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '144400.00', '160000.00', 'PA23000086', NULL, NULL, '144400.00', '0', NULL, '2023-09-14 16:00:14', NULL, NULL),
(87, 1, 102, NULL, NULL, 1, 1, 3, '2023-09-14 16:14:49', '78000.00', '0.00', 'PA23000087', NULL, NULL, '78000.00', '0', NULL, '2023-09-14 16:14:49', NULL, NULL),
(88, 1, 104, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '90000.00', '50000.00', 'PA23000088', NULL, NULL, '90000.00', '0', NULL, '2023-09-14 16:18:38', NULL, NULL),
(89, 1, 105, NULL, NULL, 1, 1, 3, '2023-09-14 17:33:43', '148000.00', '0.00', 'PA23000089', NULL, NULL, '148000.00', '0', NULL, '2023-09-14 17:33:43', NULL, NULL),
(90, 1, 106, NULL, NULL, 1, 1, 3, '2023-09-14 17:41:25', '136550.00', '0.00', 'PA23000090', NULL, NULL, '136550.00', '0', NULL, '2023-09-14 17:41:25', NULL, NULL),
(91, 1, 107, NULL, NULL, 1, 1, 3, '2023-09-14 17:55:22', '9700.00', '0.00', 'PA23000091', NULL, NULL, '9700.00', '0', NULL, '2023-09-14 17:55:22', NULL, NULL),
(92, 1, 109, NULL, NULL, 1, 1, 3, '2023-09-14 18:02:52', '133000.00', '0.00', 'PA23000092', NULL, NULL, '133000.00', '0', NULL, '2023-09-14 18:02:52', NULL, NULL),
(93, 1, 108, NULL, NULL, 1, 1, 3, '2023-09-14 00:00:00', '174125.00', '0.00', 'PA23000093', NULL, NULL, '174125.00', '0', NULL, '2023-09-14 18:04:41', NULL, NULL),
(94, 1, 110, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '315000.00', '0.00', 'PA23000094', NULL, NULL, '315000.00', '0', NULL, '2023-09-15 14:03:54', NULL, NULL),
(95, 1, 111, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '600000.00', '1048500.00', 'PA23000095', NULL, NULL, '600000.00', '0', NULL, '2023-09-15 14:42:32', NULL, NULL),
(96, 1, 112, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '91700.00', '0.00', 'PA23000096', NULL, NULL, NULL, NULL, NULL, '2023-09-15 15:03:02', NULL, NULL),
(97, 1, 113, NULL, NULL, 1, 1, 3, '2023-09-15 15:05:51', '37000.00', '0.00', 'PA23000097', NULL, NULL, '37000.00', '0', NULL, '2023-09-15 15:05:51', NULL, NULL),
(98, 1, 114, NULL, NULL, 1, 1, 3, '2023-09-15 15:55:52', '136000.00', '0.00', 'PA23000098', NULL, NULL, '136000.00', '0', NULL, '2023-09-15 15:55:52', NULL, NULL),
(99, 1, 115, NULL, NULL, 1, 1, 3, '2023-09-15 15:57:04', '302000.00', '0.00', 'PA23000099', NULL, NULL, '302000.00', '0', NULL, '2023-09-15 15:57:04', NULL, NULL),
(100, 1, 118, NULL, NULL, 1, 1, 3, '2023-09-15 16:10:41', '398500.00', '0.00', 'PA23000100', NULL, NULL, '398500.00', '0', NULL, '2023-09-15 16:10:41', NULL, NULL),
(101, 1, 119, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '25000.00', '0.00', 'PA23000101', NULL, NULL, '25000.00', '0', NULL, '2023-09-15 16:13:58', NULL, NULL),
(102, 1, 117, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '101500.00', '0.00', 'PA23000102', NULL, NULL, '101500.00', '0', NULL, '2023-09-15 16:14:17', NULL, NULL),
(103, 1, 56, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '156000.00', '0.00', 'PA23000103', NULL, NULL, '156000.00', '0', NULL, '2023-09-15 16:33:46', NULL, NULL),
(104, 1, 120, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '60800.00', '0.00', 'PA23000104', NULL, NULL, '60800.00', '0', NULL, '2023-09-15 16:48:26', NULL, NULL),
(105, 1, 121, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '22500.00', '0.00', 'PA23000105', NULL, NULL, '22500.00', '0', NULL, '2023-09-15 16:49:50', NULL, NULL),
(106, 1, 124, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '18000.00', '0.00', 'PA23000106', NULL, NULL, '18000.00', '0', NULL, '2023-09-15 16:52:43', NULL, NULL),
(107, 1, 123, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '19100.00', '0.00', 'PA23000107', NULL, NULL, '19100.00', '0', NULL, '2023-09-15 16:53:21', NULL, NULL),
(108, 1, 127, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '447700.00', '0.00', 'PA23000108', NULL, NULL, '447700.00', '0', NULL, '2023-09-15 17:04:43', NULL, NULL),
(109, 1, 128, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '27300.00', '0.00', 'PA23000109', NULL, NULL, '27300.00', '0', NULL, '2023-09-15 17:05:26', NULL, NULL),
(110, 1, 130, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '46500.00', '0.00', 'PA23000110', NULL, NULL, '46500.00', '0', NULL, '2023-09-15 17:10:52', NULL, NULL),
(111, 1, 131, NULL, NULL, 1, 1, 3, '2023-09-15 00:00:00', '13400.00', '0.00', 'PA23000111', NULL, NULL, '13400.00', '0', NULL, '2023-09-15 17:17:23', NULL, NULL),
(112, 1, 132, NULL, NULL, 3, 1, 3, '2023-09-16 10:25:52', '55000.00', '0.00', 'PA23000112', NULL, NULL, '55000.00', '0', NULL, '2023-09-16 10:25:52', NULL, NULL),
(113, 1, 122, NULL, NULL, 3, 1, 3, '2023-09-16 00:00:00', '42500.00', '0.00', 'PA23000113', NULL, NULL, '42500.00', '0', NULL, '2023-09-16 10:51:50', NULL, NULL),
(114, 1, 134, NULL, NULL, 3, 1, 3, '2023-09-16 12:08:56', '95750.00', '0.00', 'PA23000114', NULL, NULL, '95750.00', '0', NULL, '2023-09-16 12:08:56', NULL, NULL),
(115, 1, 135, NULL, NULL, 3, 1, 3, '2023-09-16 13:42:08', '11000.00', '0.00', 'PA23000115', NULL, NULL, '11000.00', '0', NULL, '2023-09-16 13:42:08', NULL, NULL),
(116, 1, 137, NULL, NULL, 5, 1, 3, '2023-09-18 09:26:54', '60000.00', '0.00', 'PA23000116', NULL, NULL, '60000.00', '0', NULL, '2023-09-18 09:26:54', NULL, NULL),
(117, 1, 139, NULL, NULL, 5, 1, 3, '2023-09-18 10:19:57', '105000.00', '0.00', 'PA23000117', NULL, NULL, '105000.00', '0', NULL, '2023-09-18 10:19:57', NULL, NULL),
(118, 1, 140, NULL, NULL, 5, 1, 3, '2023-09-18 11:22:55', '180000.00', '0.00', 'PA23000118', NULL, NULL, '180000.00', '0', NULL, '2023-09-18 11:22:55', NULL, NULL),
(119, 1, 141, NULL, NULL, 5, 1, 3, '2023-09-18 12:24:27', '10000.00', '0.00', 'PA23000119', NULL, NULL, '10000.00', '0', NULL, '2023-09-18 12:24:27', NULL, NULL),
(120, 1, 101, NULL, NULL, 5, 1, 3, '2023-09-18 00:00:00', '12500.00', '0.00', 'PA23000120', NULL, NULL, '12500.00', '0', NULL, '2023-09-18 12:35:16', NULL, NULL),
(121, 1, 143, NULL, NULL, 5, 1, 3, '2023-09-18 13:50:42', '76100.00', '0.00', 'PA23000121', NULL, NULL, '76100.00', '0', NULL, '2023-09-18 13:50:42', NULL, NULL),
(122, 1, 145, NULL, NULL, 5, 1, 3, '2023-09-18 14:32:18', '567500.00', '0.00', 'PA23000122', NULL, NULL, '567500.00', '0', NULL, '2023-09-18 14:32:18', NULL, NULL),
(123, 1, 146, NULL, NULL, 7, 1, 3, '2023-09-19 08:42:58', '511000.00', '0.00', 'PA23000123', NULL, NULL, '511000.00', '0', NULL, '2023-09-19 08:42:58', NULL, NULL),
(124, 1, 147, NULL, NULL, 7, 1, 3, '2023-09-19 08:45:17', '115000.00', '0.00', 'PA23000124', NULL, NULL, '115000.00', '0', NULL, '2023-09-19 08:45:17', NULL, NULL),
(125, 1, 142, NULL, NULL, 7, 1, 3, '2023-09-19 00:00:00', '125000.00', '100000.00', 'PA23000125', NULL, NULL, '125000.00', '0', NULL, '2023-09-19 09:21:24', NULL, NULL),
(126, 1, 148, NULL, NULL, 7, 1, 3, '2023-09-19 10:09:16', '77500.00', '0.00', 'PA23000126', NULL, NULL, '77500.00', '0', NULL, '2023-09-19 10:09:16', NULL, NULL),
(127, 1, 149, NULL, NULL, 7, 1, 3, '2023-09-19 10:19:24', '40000.00', '0.00', 'PA23000127', NULL, NULL, '40000.00', '0', NULL, '2023-09-19 10:19:24', NULL, NULL),
(128, 1, 150, NULL, NULL, 7, 1, 3, '2023-09-19 00:00:00', '125000.00', '37500.00', 'PA23000128', NULL, NULL, '125000.00', '0', NULL, '2023-09-19 11:21:19', NULL, NULL),
(129, 1, 152, NULL, NULL, 7, 1, 3, '2023-09-19 11:40:48', '27300.00', '0.00', 'PA23000129', NULL, NULL, '27300.00', '0', NULL, '2023-09-19 11:40:48', NULL, NULL),
(130, 1, 150, NULL, NULL, 7, 1, 3, '2023-09-19 00:00:00', '37500.00', '0.00', 'PA23000130', NULL, NULL, '37500.00', '0', NULL, '2023-09-19 11:53:18', NULL, NULL),
(131, 3, 99, NULL, NULL, 7, 1, 3, '2023-09-19 00:00:00', '160000.00', '0.00', 'PA23000131', NULL, '0751956', '160000.00', '0', NULL, '2023-09-19 12:16:41', NULL, NULL),
(132, 3, 153, NULL, NULL, 7, 1, 3, '2023-09-19 00:00:00', '600000.00', '0.00', 'PA23000132', NULL, '3356839', NULL, NULL, NULL, '2023-09-19 12:21:10', NULL, NULL),
(133, 1, 154, NULL, NULL, 7, 1, 3, '2023-09-19 16:00:13', '180000.00', '0.00', 'PA23000133', NULL, NULL, '180000.00', '0', NULL, '2023-09-19 16:00:13', NULL, NULL),
(134, 1, 156, NULL, NULL, 9, 1, 3, '2023-09-20 08:36:17', '78000.00', '0.00', 'PA23000134', NULL, NULL, '78000.00', '0', NULL, '2023-09-20 08:36:17', NULL, NULL),
(135, 1, 157, NULL, NULL, 9, 1, 3, '2023-09-20 00:00:00', '50300.00', '0.00', 'PA23000135', NULL, NULL, '50300.00', '0', NULL, '2023-09-20 10:43:15', NULL, NULL),
(136, 1, 158, NULL, NULL, 9, 1, 3, '2023-09-20 00:00:00', '6500.00', '0.00', 'PA23000136', NULL, NULL, '6500.00', '0', NULL, '2023-09-20 11:42:11', NULL, NULL),
(137, 1, 160, NULL, NULL, 9, 1, 3, '2023-09-20 12:07:47', '30100.00', '0.00', 'PA23000137', NULL, NULL, '30100.00', '0', NULL, '2023-09-20 12:07:47', NULL, NULL),
(138, 1, 163, NULL, NULL, 9, 1, 3, '2023-09-20 12:46:56', '122750.00', '0.00', 'PA23000138', NULL, NULL, '122750.00', '0', NULL, '2023-09-20 12:46:56', NULL, NULL),
(139, 1, 167, NULL, NULL, 9, 1, 3, '2023-09-20 14:15:51', '24000.00', '0.00', 'PA23000139', NULL, NULL, '24000.00', '0', NULL, '2023-09-20 14:15:51', NULL, NULL),
(140, 1, 168, NULL, NULL, 9, 1, 3, '2023-09-20 00:00:00', '350000.00', '0.00', 'PA23000140', NULL, NULL, '350000.00', '0', NULL, '2023-09-20 14:45:56', NULL, NULL),
(141, 1, 159, NULL, NULL, 9, 1, 3, '2023-09-20 00:00:00', '86000.00', '0.00', 'PA23000141', NULL, NULL, '86000.00', '0', NULL, '2023-09-20 14:51:59', NULL, NULL),
(142, 1, 169, NULL, NULL, 9, 1, 3, '2023-09-20 15:13:16', '57500.00', '0.00', 'PA23000142', NULL, NULL, '57500.00', '0', NULL, '2023-09-20 15:13:16', NULL, NULL),
(143, 1, 170, NULL, NULL, 9, 1, 3, '2023-09-20 15:55:44', '510000.00', '0.00', 'PA23000143', NULL, NULL, '510000.00', '0', NULL, '2023-09-20 15:55:44', NULL, NULL),
(144, 1, 171, NULL, NULL, 9, 1, 3, '2023-09-20 16:29:05', '101900.00', '0.00', 'PA23000144', NULL, NULL, '101900.00', '0', NULL, '2023-09-20 16:29:05', NULL, NULL),
(145, 1, 172, NULL, NULL, 9, 1, 3, '2023-09-20 16:43:19', '8600.00', '0.00', 'PA23000145', NULL, NULL, '8600.00', '0', NULL, '2023-09-20 16:43:19', NULL, NULL),
(146, 1, 174, NULL, NULL, 11, 1, 3, '2023-09-21 00:00:00', '400000.00', '535900.00', 'PA23000146', NULL, NULL, '400000.00', '0', NULL, '2023-09-21 08:51:53', NULL, NULL),
(147, 1, 175, NULL, NULL, 11, 1, 3, '2023-09-21 10:38:39', '37500.00', '0.00', 'PA23000147', NULL, NULL, '37500.00', '0', NULL, '2023-09-21 10:38:39', NULL, NULL),
(148, 1, 176, NULL, NULL, 11, 1, 3, '2023-09-21 11:08:47', '60000.00', '0.00', 'PA23000148', NULL, NULL, '60000.00', '0', NULL, '2023-09-21 11:08:47', NULL, NULL),
(149, 1, 177, NULL, NULL, 11, 1, 3, '2023-09-21 00:00:00', '1149000.00', '0.00', 'PA23000149', NULL, NULL, '1149000.00', '0', NULL, '2023-09-21 12:20:18', NULL, NULL),
(150, 1, 179, NULL, NULL, 11, 1, 3, '2023-09-21 12:36:53', '49500.00', '0.00', 'PA23000150', NULL, NULL, '49500.00', '0', NULL, '2023-09-21 12:36:53', NULL, NULL),
(151, 1, 181, NULL, NULL, 11, 1, 3, '2023-09-21 13:09:42', '64000.00', '0.00', 'PA23000151', NULL, NULL, '64000.00', '0', NULL, '2023-09-21 13:09:42', NULL, NULL),
(152, 1, 182, NULL, NULL, 11, 1, 3, '2023-09-21 13:35:59', '96000.00', '0.00', 'PA23000152', NULL, NULL, '96000.00', '0', NULL, '2023-09-21 13:35:59', NULL, NULL),
(153, 1, 185, NULL, NULL, 11, 1, 3, '2023-09-21 00:00:00', '30000.00', '0.00', 'PA23000153', NULL, NULL, '30000.00', '0', NULL, '2023-09-21 16:19:19', NULL, NULL),
(154, 1, 103, NULL, NULL, 11, 1, 3, '2023-09-21 00:00:00', '306600.00', '0.00', 'PA23000154', NULL, NULL, '306600.00', '0', NULL, '2023-09-21 16:31:35', NULL, NULL),
(155, 1, 186, NULL, NULL, 11, 1, 3, '2023-09-21 00:00:00', '120000.00', '0.00', 'PA23000155', NULL, NULL, '120000.00', '0', NULL, '2023-09-21 16:39:01', NULL, NULL),
(156, 1, 189, NULL, NULL, 13, 1, 3, '2023-09-22 10:32:53', '62400.00', '0.00', 'PA23000156', NULL, NULL, '62400.00', '0', NULL, '2023-09-22 10:32:53', NULL, NULL),
(157, 1, 190, NULL, NULL, 13, 1, 3, '2023-09-22 11:21:33', '68000.00', '0.00', 'PA23000157', NULL, NULL, '68000.00', '0', NULL, '2023-09-22 11:21:33', NULL, NULL),
(158, 1, 194, NULL, NULL, 13, 1, 3, '2023-09-22 00:00:00', '45000.00', '0.00', 'PA23000158', NULL, NULL, '45000.00', '0', NULL, '2023-09-22 12:55:34', NULL, NULL),
(159, 1, 193, NULL, NULL, 13, 1, 3, '2023-09-22 00:00:00', '39500.00', '0.00', 'PA23000159', NULL, NULL, '39500.00', '0', NULL, '2023-09-22 12:55:56', NULL, NULL),
(160, 1, 195, NULL, NULL, 13, 1, 3, '2023-09-22 00:00:00', '20000.00', '0.00', 'PA23000160', NULL, NULL, '20000.00', '0', NULL, '2023-09-22 14:44:17', NULL, NULL),
(161, 1, 196, NULL, NULL, 13, 1, 3, '2023-09-22 15:26:26', '33000.00', '0.00', 'PA23000161', NULL, NULL, '33000.00', '0', NULL, '2023-09-22 15:26:26', NULL, NULL),
(162, 1, 197, NULL, NULL, 13, 1, 3, '2023-09-22 16:00:48', '290500.00', '0.00', 'PA23000162', NULL, NULL, '290500.00', '0', NULL, '2023-09-22 16:00:48', NULL, NULL),
(163, 1, 151, NULL, NULL, 13, 1, 3, '2023-09-22 00:00:00', '100000.00', '95000.00', 'PA23000163', NULL, NULL, '100000.00', '0', NULL, '2023-09-22 16:22:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `libelle_fr` varchar(255) NOT NULL,
  `libelle_en` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `personnel`
--

DROP TABLE IF EXISTS `personnel`;
CREATE TABLE IF NOT EXISTS `personnel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `nom` varchar(255) NOT NULL,
  `prenoms` varchar(255) NOT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `date_nais` datetime DEFAULT NULL,
  `sexe` varchar(255) NOT NULL,
  `civilite` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A6BCF3DEEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `personnel`
--

INSERT INTO `personnel` (`id`, `point_vente_id`, `nom`, `prenoms`, `tel`, `email`, `adresse`, `date_nais`, `sexe`, `civilite`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'ADMIN', 'ROMAS', '0', 'contact@romastechnologie.com', NULL, NULL, 'Masculin', NULL, NULL, '2023-09-12 15:37:36', NULL, NULL),
(2, 1, 'KINLODON', 'Inès', '97109893', NULL, 'COTONOU', NULL, 'Feminin', 'Mademoiselle', NULL, '2023-09-12 16:46:51', NULL, NULL),
(3, 1, 'LOKO', 'EPHRAIM', '64479409', NULL, 'COTONOU', NULL, 'Feminin', 'Mademoiselle', NULL, '2023-09-12 16:53:46', NULL, NULL),
(4, 1, 'ATHINDEHOU', 'WILFRID', '66699122', NULL, 'COTONOU', NULL, 'Masculin', 'Monsieur', NULL, '2023-09-12 16:56:31', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `personnel_caisse`
--

DROP TABLE IF EXISTS `personnel_caisse`;
CREATE TABLE IF NOT EXISTS `personnel_caisse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `caisse_id` int NOT NULL,
  `personnel_id` int DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9E5D042827B4FEBF` (`caisse_id`),
  KEY `IDX_9E5D04281C109075` (`personnel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `personnel_caisse`
--

INSERT INTO `personnel_caisse` (`id`, `caisse_id`, `personnel_id`, `statut`) VALUES
(1, 1, 2, NULL),
(2, 2, 2, NULL),
(3, 3, 2, NULL),
(4, 4, 2, NULL),
(5, 5, 2, NULL),
(6, 6, 2, NULL),
(7, 7, 2, NULL),
(8, 8, 2, NULL),
(9, 9, 2, NULL),
(10, 10, 2, NULL),
(11, 11, 2, NULL),
(12, 12, 2, NULL),
(13, 13, 2, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `point_de_vente`
--

DROP TABLE IF EXISTS `point_de_vente`;
CREATE TABLE IF NOT EXISTS `point_de_vente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `est_principal` tinyint(1) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C9182F7BEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `point_de_vente`
--

INSERT INTO `point_de_vente` (`id`, `point_vente_id`, `code`, `libelle`, `adresse`, `tel`, `est_principal`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'pv_pr', 'POINT DE VENTE PRINCIPAL', '-', '0', 1, NULL, '2023-09-12 15:37:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `famille_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `groupe_taxe_id` int DEFAULT NULL,
  `magasin_defaut_id` int DEFAULT NULL,
  `ref_prod` varchar(255) DEFAULT NULL,
  `nom_prod` varchar(255) NOT NULL,
  `desc_prod` longtext,
  `prix_achat_prod` decimal(10,2) DEFAULT NULL,
  `prix_vente_prod` decimal(10,2) DEFAULT NULL,
  `est_taxable` tinyint(1) NOT NULL,
  `est_service` tinyint(1) NOT NULL,
  `est_mode_carreau` tinyint(1) NOT NULL,
  `code_qr` varbinary(255) DEFAULT NULL,
  `code_barre` varbinary(255) DEFAULT NULL,
  `seuil_appro` decimal(10,2) DEFAULT NULL,
  `stock` decimal(10,2) NOT NULL DEFAULT '0.00',
  `code_produit` varchar(255) DEFAULT NULL,
  `suivi_stock` int DEFAULT NULL,
  `mode_def_prix` varchar(255) DEFAULT NULL,
  `metre_carre_par_carton` varchar(255) DEFAULT NULL,
  `piece_par_carton` varchar(255) DEFAULT NULL,
  `piece_par_metre_carre` varchar(255) DEFAULT NULL,
  `surface_par_piece` varchar(255) DEFAULT NULL,
  `couleur_carreau` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_29A5EC271102A8BB` (`code_produit`),
  KEY `IDX_29A5EC2797A77B84` (`famille_id`),
  KEY `IDX_29A5EC27EFA24D68` (`point_vente_id`),
  KEY `IDX_29A5EC27DCDEA0EA` (`groupe_taxe_id`),
  KEY `IDX_29A5EC27F12D8438` (`magasin_defaut_id`)
) ENGINE=InnoDB AUTO_INCREMENT=478 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `famille_id`, `point_vente_id`, `groupe_taxe_id`, `magasin_defaut_id`, `ref_prod`, `nom_prod`, `desc_prod`, `prix_achat_prod`, `prix_vente_prod`, `est_taxable`, `est_service`, `est_mode_carreau`, `code_qr`, `code_barre`, `seuil_appro`, `stock`, `code_produit`, `suivi_stock`, `mode_def_prix`, `metre_carre_par_carton`, `piece_par_carton`, `piece_par_metre_carre`, `surface_par_piece`, `couleur_carreau`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 1, 2, 1, NULL, 'BALAI DE SOL', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '23.00', '﻿10000001', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:01', NULL, NULL),
(2, 3, 1, 2, 1, NULL, 'BALAI CANTONNÉ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '760.00', 'DIV10000001', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', '2023-09-19 15:34:45', NULL),
(3, 3, 1, 2, 1, NULL, 'BROSSE WC 8078', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '379.00', 'DIV10000002', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(4, 3, 1, 2, 1, NULL, 'FACE MASK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '427.00', 'DIV10000003', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(5, 3, 1, 2, 1, NULL, 'GAZON SYNTHETIQUE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'DIV10000004', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(6, 3, 1, 2, 1, NULL, 'PINCEAU 100MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'DIV10000005', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(7, 3, 1, 2, 1, NULL, 'PINCEAU 40MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'DIV10000006', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(8, 3, 1, 2, 1, NULL, 'PINCEAU 50MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'DIV10000007', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(9, 3, 1, 2, 1, NULL, 'PINCEAU 60MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'DIV10000008', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(10, 3, 1, 2, 1, NULL, 'PINCEAU 70MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'DIV10000009', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(11, 3, 1, 2, 1, NULL, 'RIDEAU DE DOUCHE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '51.00', 'DIV10000010', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', NULL, NULL),
(12, 3, 1, 2, 1, NULL, 'SERPIERE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '120.00', 'DIV10000011', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', '2023-09-22 12:50:49', NULL),
(13, 4, 1, 2, 1, NULL, 'BAGUETTE ATLANTICS 2.5', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'CHA10000001', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:02', '2023-09-21 10:47:23', NULL),
(14, 4, 1, 2, 1, NULL, 'BAGUETTE ATLANTICS 3.2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'CHA10000002', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', '2023-09-21 10:47:23', NULL),
(15, 4, 1, 2, 1, NULL, 'CENTIMETRE JAUNE TRANSPARENT F2-13928-2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '14.00', 'CHA10000003', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', NULL, NULL),
(16, 4, 1, 2, 1, NULL, 'CENTIMETRE VERT F2-13928-1', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '79.00', 'CHA10000004', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', NULL, NULL),
(17, 4, 1, 2, 1, NULL, 'COLLE TOP BOND 1KG', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'CHA10000005', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', NULL, NULL),
(18, 4, 1, 2, 1, NULL, 'COUTEAU D\'ENDUIRE DE 16', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'CHA10000006', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', NULL, NULL),
(19, 4, 1, 2, 1, NULL, 'EQUERRE 10\"*12\"', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'CHA10000007', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', '2023-09-21 15:21:40', NULL),
(20, 4, 1, 2, 1, NULL, 'EQUERRE 12\"*14\"', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'CHA10000008', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', '2023-09-21 15:21:41', NULL),
(21, 4, 1, 2, 1, NULL, 'GRILLAGE FENETRE VITRIER 1M20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '75.00', 'CHA10000009', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', NULL, NULL),
(22, 4, 1, 2, 1, NULL, 'GRILLAGE LAPIN 1M20 VERT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '26.00', 'CHA10000010', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:03', NULL, NULL),
(23, 4, 1, 2, 1, NULL, 'GRILLAGE LAPIN GALVANISÉ 25M ORIGINAL', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'CHA10000011', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', '2023-09-22 12:51:01', NULL),
(24, 4, 1, 2, 1, NULL, 'GRILLAGE TAMI 1M20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '50.00', 'CHA10000012', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', '2023-09-15 18:33:37', NULL),
(25, 4, 1, 2, 1, NULL, 'GRILLARGE POULLAILE 1M20 2DOIGT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '6.00', 'CHA10000013', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(26, 4, 1, 2, 1, NULL, 'GRILLARGE POULLAILE 1M20 1DOIGT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'CHA10000014', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(27, 4, 1, 2, 1, NULL, 'POINTE ACIER 10', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'CHA10000015', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(28, 4, 1, 2, 1, NULL, 'POINTE TAPICIER 1/2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '8.00', 'CHA10000016', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', '2023-09-15 18:30:18', NULL),
(29, 4, 1, 2, 1, NULL, 'POINTE TAPICIER 3/4', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '54.00', 'CHA10000017', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(30, 4, 1, 2, 1, NULL, 'POINTE TAPICIER 5/8', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'CHA10000018', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(31, 4, 1, 2, 1, NULL, 'VERROU PAPILLON 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '18.00', 'CHA10000019', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(32, 4, 1, 2, 1, NULL, 'VERROU PAPILLON 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'CHA10000020', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(33, 4, 1, 2, 1, NULL, 'VICE DE RAPPEL 009CMECOC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '54.00', 'CHA10000021', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(34, 5, 1, 2, 1, NULL, 'AMPOULE GLOBE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '18.00', 'ELE10000001', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(35, 5, 1, 2, 1, NULL, 'ATTACHE DE 8 INGELEC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '47.00', 'ELE10000002', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(36, 5, 1, 2, 1, NULL, 'BOITE D\'ENCARDREMENT INGELEC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1000.00', 'ELE10000003', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(37, 5, 1, 2, 1, NULL, 'BOUTON A POUSSOI ETANCHE ENCASTRE 5881/53', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'ELE10000004', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:04', NULL, NULL),
(38, 5, 1, 2, 1, NULL, 'CHEVILLE 10', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '160.00', 'ELE10000005', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(39, 5, 1, 2, 1, NULL, 'CHEVILLE 8', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'ELE10000006', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', '2023-09-21 11:18:05', NULL),
(40, 5, 1, 2, 1, NULL, 'COMPTEUR INGELEC DDS 1531', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'ELE10000007', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(41, 5, 1, 2, 1, NULL, 'DOUBLE ETANCHE ENCASTRE 5882/20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'ELE10000008', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(42, 5, 1, 2, 1, NULL, 'PRISE ETANCHE ENCASTRE 4886', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '11.00', 'ELE10000009', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(43, 5, 1, 2, 1, NULL, 'TUYAUX CUIVRE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '61.00', 'ELE10000010', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(44, 5, 1, 2, 1, NULL, 'VENTILATEUR CMC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '23.00', 'ELE10000011', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 11:12:41', '2023-09-15 11:12:41', NULL),
(45, 5, 1, 2, 1, NULL, 'VENTILATEUR ITC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '77.00', 'ELE10000012', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 11:11:21', '2023-09-15 11:11:21', NULL),
(46, 5, 1, 2, 1, NULL, 'VENTILATEUR PANASONIK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '87.00', 'ELE10000013', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 11:07:00', '2023-09-15 18:26:54', NULL),
(47, 5, 1, 2, 1, NULL, 'VENTILATEUR SMC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '129.00', 'ELE10000014', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 10:45:57', '2023-09-15 18:27:34', NULL),
(48, 6, 1, 2, 1, NULL, 'BOTTES POINTURE 41', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '14.00', 'MAC10000001', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(49, 6, 1, 2, 1, NULL, 'BOTTES POINTURE 42', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '45.00', 'MAC10000002', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', '2023-09-18 12:27:26', NULL),
(50, 6, 1, 2, 1, NULL, 'BOTTES POINTURE 43', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'MAC10000003', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', '2023-09-15 18:26:31', NULL),
(51, 6, 1, 2, 1, NULL, 'BOTTES POINTURE 44', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '75.00', 'MAC10000004', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', '2023-09-15 18:26:31', NULL),
(52, 6, 1, 2, 1, NULL, 'BOTTES POINTURE 45', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '105.00', 'MAC10000005', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', '2023-09-18 12:27:26', NULL),
(53, 6, 1, 2, 1, NULL, 'BOTTES POINTURE 47', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '49.00', 'MAC10000006', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(54, 6, 1, 2, 1, NULL, 'BROUETTES (au complet, avec tous accessoires)', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'MAC10000007', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(55, 6, 1, 2, 1, NULL, 'PERLES BLEU', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'MAC10000008', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(56, 6, 1, 2, 1, NULL, 'PIEERRE À MELER 50/CT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '83.00', 'MAC10000009', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:05', NULL, NULL),
(57, 6, 1, 2, 1, NULL, 'PIERRE À COUPER 100/CT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '413.00', 'MAC10000010', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', NULL, NULL),
(58, 6, 1, 2, 1, NULL, 'PIOCHE 2KILO', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'MAC10000011', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', NULL, NULL),
(59, 6, 1, 2, 1, NULL, 'PUNEU BROUETTE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '232.00', 'MAC10000012', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-22 13:39:41', NULL),
(60, 6, 1, 2, 1, NULL, 'RACCORD D\'EAU BLANC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '19.00', 'MAC10000013', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(61, 6, 1, 2, 1, NULL, 'RACCORD D\'EAU JAUNE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '15.00', 'MAC10000014', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(62, 6, 1, 2, 1, NULL, 'RACCORD D\'EAU VERT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'MAC10000015', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(63, 7, 1, 2, 1, NULL, 'ROBINET EVIER GOLD MIX', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000001', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-21 11:18:09', NULL),
(64, 7, 1, 2, 1, NULL, 'ABATTAN LOURD', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '193.00', 'PLO10000002', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-18 14:14:06', NULL),
(65, 7, 1, 2, 1, NULL, 'ABATTAN PARMA ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '12.00', 'PLO10000003', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-19 16:01:34', NULL),
(66, 7, 1, 2, 1, NULL, 'ABATTANT WC COMBINE J2-SC1770', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000004', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', NULL, NULL),
(67, 7, 1, 2, 1, NULL, 'ABATTANT WC COMBINE J2-SC1767', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000005', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', NULL, NULL),
(68, 7, 1, 2, 1, NULL, 'ACCESOIRE PARMA', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000006', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', '2023-09-21 15:11:45', NULL),
(69, 7, 1, 2, 1, NULL, 'BALLON FLOTTEUR NOIRE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '20.00', 'PLO10000007', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', NULL, NULL),
(70, 7, 1, 2, 1, NULL, 'BOMBONE À EAU', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '15.00', 'PLO10000008', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:06', NULL, NULL),
(71, 7, 1, 2, 1, NULL, 'BONDE LAVABO FIRMER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '108.00', 'PLO10000009', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', '2023-09-15 18:09:26', NULL),
(72, 7, 1, 2, 1, NULL, 'BOUCHON FOSSES SEPTIQUES', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '80.00', 'PLO10000010', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(73, 7, 1, 2, 1, NULL, 'BOUCHON GALVA 15/21 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000011', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(74, 7, 1, 2, 1, NULL, 'BOUCHON GALVA 15/21 MALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '27059.00', 'PLO10000012', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', '2023-09-20 16:45:11', NULL),
(75, 7, 1, 2, 1, NULL, 'BOUCHON GALVA 20/27 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '990.00', 'PLO10000013', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(76, 7, 1, 2, 1, NULL, 'BOUCHON GALVA 20/27 MALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'PLO10000014', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(77, 7, 1, 2, 1, NULL, 'BOUCHON LAITON FEMELLE 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2016.00', 'PLO10000015', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(78, 7, 1, 2, 1, NULL, 'BOUCHON LAITON MALE 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3295.00', 'PLO10000016', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(79, 7, 1, 2, 1, NULL, 'BOUCHON PPR 20 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '338.00', 'PLO10000017', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(80, 7, 1, 2, 1, NULL, 'BOUCHON PPR 20 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2051.00', 'PLO10000018', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(81, 7, 1, 2, 1, NULL, 'BOUCHON PPR 25 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1383.00', 'PLO10000019', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(82, 7, 1, 2, 1, NULL, 'BOUCHON PPR 25 MALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '929.00', 'PLO10000020', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(83, 7, 1, 2, 1, NULL, 'BOUCHON PPR 32 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'PLO10000021', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(84, 7, 1, 2, 1, NULL, 'BOUCHON PPR 32 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '228.00', 'PLO10000022', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:07', NULL, NULL),
(85, 7, 1, 2, 1, NULL, 'BOUCHON PPR 40 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '14.00', 'PLO10000023', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(86, 7, 1, 2, 1, NULL, 'BOUCHON PRESSION 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '258.00', 'PLO10000024', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(87, 7, 1, 2, 1, NULL, 'BOUCHON PRESSION 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000025', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(88, 7, 1, 2, 1, NULL, 'BOUCHON PVC  110', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000026', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(89, 7, 1, 2, 1, NULL, 'BOUCHON PVC 100', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1799.00', 'PLO10000027', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', '2023-09-16 14:14:38', NULL),
(90, 7, 1, 2, 1, NULL, 'BOUCHON PVC 125', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000028', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(91, 7, 1, 2, 1, NULL, 'BOUCHON PVC 200', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '162.00', 'PLO10000029', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(92, 7, 1, 2, 1, NULL, 'BOUCHON PVC 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '344.00', 'PLO10000030', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', '2023-09-15 18:08:18', NULL),
(93, 7, 1, 2, 1, NULL, 'BOUCHON PVC 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '-4.00', 'PLO10000031', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', '2023-09-15 18:08:19', NULL),
(94, 7, 1, 2, 1, NULL, 'BOUCHON PVC 75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1330.00', 'PLO10000032', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', '2023-09-15 18:30:56', NULL),
(95, 7, 1, 2, 1, NULL, 'CHAPEAU CHINOIS 110 SC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000033', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(96, 7, 1, 2, 1, NULL, 'CHAPEAU CHINOIS 63 KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '149.00', 'PLO10000034', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:08', NULL, NULL),
(97, 7, 1, 2, 1, NULL, 'CHAPEAU CHINOIS 75 SC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '690.00', 'PLO10000035', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', NULL, NULL),
(98, 7, 1, 2, 1, NULL, 'CHATAF INOX', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '13.00', 'PLO10000036', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', NULL, NULL),
(99, 7, 1, 2, 1, NULL, 'CHAUFFE EAU MAXI 30L', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '6.00', 'PLO10000037', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-15 18:10:29', NULL),
(100, 7, 1, 2, 1, NULL, 'CHAUFFE-EAU MAXI 15L', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000038', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-15 17:55:54', NULL),
(101, 7, 1, 2, 1, NULL, 'CLAPET À MEMBRANE 2\"', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '13.00', 'PLO10000039', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', NULL, NULL),
(102, 7, 1, 2, 1, NULL, 'CLAPET À MEMBRANE 3/4 (20/27)', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '29.00', 'PLO10000040', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', NULL, NULL),
(103, 7, 1, 2, 1, NULL, 'CLAPET À RESSORT FIRMER 3/4 EN FER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '24.00', 'PLO10000041', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-15 18:25:53', NULL),
(104, 7, 1, 2, 1, NULL, 'COLLE TANGIT MEDIUM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '26.00', 'PLO10000042', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-16 14:14:38', NULL),
(105, 7, 1, 2, 1, NULL, 'COLLE TANGIT ORIGINAL 1KILO', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '68.00', 'PLO10000043', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-20 13:05:46', NULL),
(106, 7, 1, 2, 1, NULL, 'COLLE VINKOGITE PVC-U 1KG', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000044', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-21 11:18:06', NULL),
(107, 7, 1, 2, 1, NULL, 'COLLIER ATELAS 64010-16', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '30.00', 'PLO10000045', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', NULL, NULL),
(108, 7, 1, 2, 1, NULL, 'COLLIER ATELAS 64010-25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '56.00', 'PLO10000046', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-15 18:29:03', NULL),
(109, 7, 1, 2, 1, NULL, 'COLLIER ATELAS 64010-32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '45.00', 'PLO10000047', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:09', '2023-09-15 18:29:04', NULL),
(110, 7, 1, 2, 1, NULL, 'COLLIER ATELAS 64010-40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000048', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', NULL, NULL),
(111, 7, 1, 2, 1, NULL, 'COLLIER GOUTTIERE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000049', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', '2023-09-15 17:59:09', NULL),
(112, 7, 1, 2, 1, NULL, 'COLLIER INOX 100', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000050', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', NULL, NULL),
(113, 7, 1, 2, 1, NULL, 'COLLIER INOX 125', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3460.00', 'PLO10000051', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', '2023-09-15 18:30:36', NULL),
(114, 7, 1, 2, 1, NULL, 'COLLIER INOX 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '448.00', 'PLO10000052', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', '2023-09-21 10:47:22', NULL),
(115, 7, 1, 2, 1, NULL, 'COLLIER INOX 63', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000053', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', NULL, NULL),
(116, 7, 1, 2, 1, NULL, 'COLLIER INOX 75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2595.00', 'PLO10000054', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', NULL, NULL),
(117, 7, 1, 2, 1, NULL, 'COLLIER PPR 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '94.00', 'PLO10000055', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', NULL, NULL),
(118, 7, 1, 2, 1, NULL, 'COLLIER PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000056', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', NULL, NULL),
(119, 7, 1, 2, 1, NULL, 'COLLIER PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000057', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:10', NULL, NULL),
(120, 7, 1, 2, 1, NULL, 'COLLIER PVC  100', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'PLO10000058', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', NULL, NULL),
(121, 7, 1, 2, 1, NULL, 'COLLIER PVC 75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '734.00', 'PLO10000059', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', '2023-09-15 18:32:21', NULL),
(122, 7, 1, 2, 1, NULL, 'COLONNE DE DOUCHE MITIGEUR MAAT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000060', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', '2023-09-20 16:45:14', NULL),
(123, 7, 1, 2, 1, NULL, 'COLONNE FIXE ALLURE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '30.00', 'PLO10000061', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', NULL, NULL),
(124, 7, 1, 2, 1, NULL, 'COLONNE FIXE EN FER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3531.00', 'PLO10000062', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', '2023-09-21 12:19:06', NULL),
(125, 7, 1, 2, 1, NULL, 'COLONNE FIXE EN PLASTIC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2345.00', 'PLO10000063', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', '2023-09-15 18:29:00', NULL),
(126, 7, 1, 2, 1, NULL, 'COMPTEUR GALVA 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '20.00', 'PLO10000064', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', NULL, NULL),
(127, 7, 1, 2, 1, NULL, 'COMPTEUR GALVA 26/34', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '167.00', 'PLO10000065', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', NULL, NULL),
(128, 7, 1, 2, 1, NULL, 'COMPTEUR GALVA GRK 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '45.00', 'PLO10000066', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', '2023-09-15 17:41:40', NULL),
(129, 7, 1, 2, 1, NULL, 'COMPTEUR LAITON 20/27 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '338.00', 'PLO10000067', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', '2023-09-19 08:43:45', NULL),
(130, 7, 1, 2, 1, NULL, 'COMPTEUR YONSSO 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '40.00', 'PLO10000068', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', NULL, NULL),
(131, 7, 1, 2, 1, NULL, 'CONTROLEUR AUTOMATIQUE INTER DAB', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '121.00', 'PLO10000069', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:11', NULL, NULL),
(132, 7, 1, 2, 1, NULL, 'COUDE LAITON 15/21 55GRM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '23850.00', 'PLO10000070', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:12', '2023-09-21 11:18:07', NULL),
(133, 7, 1, 2, 1, NULL, 'COUDE LAITON 20/27 72GRAM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000071', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:12', NULL, NULL),
(134, 7, 1, 2, 1, NULL, 'COUDE LAITON 26/34', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '213.00', 'PLO10000072', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:12', '2023-09-15 18:21:19', NULL),
(135, 7, 1, 2, 1, NULL, 'COUDE PE 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '150.00', 'PLO10000073', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:12', NULL, NULL),
(136, 7, 1, 2, 1, NULL, 'COUDE PE 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000074', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:12', NULL, NULL),
(137, 7, 1, 2, 1, NULL, 'COUDE PPR 1/8 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '400.00', 'PLO10000075', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:12', NULL, NULL),
(138, 7, 1, 2, 1, NULL, 'COUDE PPR 1/8 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000076', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:12', NULL, NULL),
(139, 7, 1, 2, 1, NULL, 'COUDE PPR 1/8 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000077', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', '2023-09-15 18:34:15', NULL),
(140, 7, 1, 2, 1, NULL, 'COUDE PPR 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000078', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', NULL, NULL),
(141, 7, 1, 2, 1, NULL, 'COUDE PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2070.00', 'PLO10000079', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', '2023-09-20 13:05:43', NULL),
(142, 7, 1, 2, 1, NULL, 'COUDE PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000080', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', '2023-09-15 18:34:14', NULL),
(143, 7, 1, 2, 1, NULL, 'COUDE PPR 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000081', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', '2023-09-15 18:34:12', NULL),
(144, 7, 1, 2, 1, NULL, 'COUDE PPR 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '172.00', 'PLO10000082', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', NULL, NULL),
(145, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 20*1/2 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1820.00', 'PLO10000083', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', NULL, NULL),
(146, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 20*1/2 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1128.00', 'PLO10000084', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', NULL, NULL),
(147, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 25*1/2 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '711.00', 'PLO10000085', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:13', '2023-09-20 13:05:44', NULL),
(148, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 25*3/4 MALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '105.00', 'PLO10000086', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(149, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 25*3/4F FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000087', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(150, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 32*1\" FMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '100.00', 'PLO10000088', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(151, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 32*1/2 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000089', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(152, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 32*3/4 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '75.00', 'PLO10000090', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(153, 7, 1, 2, 1, NULL, 'COUDE PPR TARODÉ 32*3/4 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '32.00', 'PLO10000091', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(154, 7, 1, 2, 1, NULL, 'COUDE PPR TRODÉ 25*1/2 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000092', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(155, 7, 1, 2, 1, NULL, 'COUDE PRESSION 110', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '34.00', 'PLO10000093', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', NULL, NULL),
(156, 7, 1, 2, 1, NULL, 'COUDE PRESSION 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3560.00', 'PLO10000094', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', '2023-09-21 11:18:08', NULL),
(157, 7, 1, 2, 1, NULL, 'COUDE PRESSION 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '23.00', 'PLO10000095', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:14', '2023-09-20 16:45:09', NULL),
(158, 7, 1, 2, 1, NULL, 'COUDE PRESSION 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000096', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', NULL, NULL),
(159, 7, 1, 2, 1, NULL, 'COUDE PRESSION 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000097', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', NULL, NULL),
(160, 7, 1, 2, 1, NULL, 'COUDE PRESSION 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000098', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', '2023-09-20 16:45:05', NULL),
(161, 7, 1, 2, 1, NULL, 'COUDE PRESSION 63', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '177.00', 'PLO10000099', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', '2023-09-15 18:02:58', NULL),
(162, 7, 1, 2, 1, NULL, 'COUDE PRESSION 75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '46.00', 'PLO10000100', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', NULL, NULL),
(163, 7, 1, 2, 1, NULL, 'COUDE PRESSION 90', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '62.00', 'PLO10000101', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', NULL, NULL),
(164, 7, 1, 2, 1, NULL, 'COUDE PVC 1/4 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3195.00', 'PLO10000102', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', '2023-09-20 13:05:46', NULL),
(165, 7, 1, 2, 1, NULL, 'COUDE PVC 1/4 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10304.00', 'PLO10000103', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', '2023-09-20 14:17:02', NULL),
(166, 7, 1, 2, 1, NULL, 'COUDE PVC 1/4 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000104', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:15', NULL, NULL),
(167, 7, 1, 2, 1, NULL, 'COUDE PVC 1/8  50 ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000105', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(168, 7, 1, 2, 1, NULL, 'COUDE PVC 1/8  63', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '592.00', 'PLO10000106', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(169, 7, 1, 2, 1, NULL, 'COUDE PVC 1/8 110', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '65.00', 'PLO10000107', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(170, 7, 1, 2, 1, NULL, 'COUDE PVC 1/8 125', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '71.00', 'PLO10000108', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(171, 7, 1, 2, 1, NULL, 'COUDE PVC 1/8 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '134.00', 'PLO10000109', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(172, 7, 1, 2, 1, NULL, 'DOS-DANE PPR 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '157.00', 'PLO10000110', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(173, 7, 1, 2, 1, NULL, 'DOS-DANE PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000111', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(174, 7, 1, 2, 1, NULL, 'DOS-DANE PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '16.00', 'PLO10000112', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(175, 7, 1, 2, 1, NULL, 'ECARTEMENT 15/20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '81.00', 'PLO10000113', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:16', NULL, NULL),
(176, 7, 1, 2, 1, NULL, 'ECROU 20/15 GRAND ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000114', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', NULL, NULL),
(177, 7, 1, 2, 1, NULL, 'ECROU 20/15 MOYEN', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2741.00', 'PLO10000115', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', '2023-09-21 08:49:00', NULL),
(178, 7, 1, 2, 1, NULL, 'ECROU COMPTEUR 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '224.00', 'PLO10000116', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', '2023-09-15 17:57:18', NULL),
(179, 7, 1, 2, 1, NULL, 'ECROU COMPTEUR 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '26.00', 'PLO10000117', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', '2023-09-15 17:57:18', NULL),
(180, 7, 1, 2, 1, NULL, 'ECROU COMPTEUR 26/34', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '219.00', 'PLO10000118', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', NULL, NULL),
(181, 7, 1, 2, 1, NULL, 'ECROU LAITON 15/15', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '17760.00', 'PLO10000119', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', '2023-09-21 08:49:04', NULL),
(182, 7, 1, 2, 1, NULL, 'ECROU LAITON 15/15 A BAGUE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '14934.00', 'PLO10000120', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', '2023-09-21 11:18:04', NULL),
(183, 7, 1, 2, 1, NULL, 'ECROU LAITON 15/15 KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1611.00', 'PLO10000121', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', NULL, NULL),
(184, 7, 1, 2, 1, NULL, 'ECROU LAITON 26/20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1879.00', 'PLO10000122', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:17', '2023-09-15 18:21:21', NULL),
(185, 7, 1, 2, 1, NULL, 'ECROU LAITON REDUIT 12/12', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4299.00', 'PLO10000123', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', '2023-09-19 10:10:41', NULL),
(186, 7, 1, 2, 1, NULL, 'ECROU LAITON REDUIT 15/12', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5779.00', 'PLO10000124', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', '2023-09-20 14:17:01', NULL),
(187, 7, 1, 2, 1, NULL, 'ECROU MIX 12/17', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000125', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', NULL, NULL),
(188, 7, 1, 2, 1, NULL, 'ECROU MIX 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '47.00', 'PLO10000126', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', '2023-09-15 18:10:30', NULL),
(189, 7, 1, 2, 1, NULL, 'ECROU RALLONGE LAITON 1/2*30M', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000127', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', '2023-09-21 11:18:11', NULL),
(190, 7, 1, 2, 1, NULL, 'EMBOUT À CHAUD', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1206.00', 'PLO10000128', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', NULL, NULL),
(191, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 20*1/2 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1184.00', 'PLO10000129', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', NULL, NULL),
(192, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 20*1/2 MALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1059.00', 'PLO10000130', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', NULL, NULL),
(193, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 25*1/2 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1339.00', 'PLO10000131', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:18', NULL, NULL),
(194, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 25*1/2 MALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '6541.00', 'PLO10000132', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', '2023-09-20 13:05:44', NULL),
(195, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 25*3/4 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'PLO10000133', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', NULL, NULL),
(196, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 25*3/4 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3486.00', 'PLO10000134', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', '2023-09-16 14:14:33', NULL),
(197, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 32*1\" FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '253.00', 'PLO10000135', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', '2023-09-15 18:12:52', NULL),
(198, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 32*1\" MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '148.00', 'PLO10000136', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', '2023-09-16 14:14:37', NULL),
(199, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 32*1/2 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '189.00', 'PLO10000137', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', NULL, NULL),
(200, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 32*1/2 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '96.00', 'PLO10000138', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', NULL, NULL),
(201, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 32*3/4 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '172.00', 'PLO10000139', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:19', NULL, NULL),
(202, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 40*1\" FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000140', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', NULL, NULL),
(203, 7, 1, 2, 1, NULL, 'EMBOUT PPR TARODÉ 40*1\" MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000141', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', NULL, NULL),
(204, 7, 1, 2, 1, NULL, 'EMBOUT PRESSION  40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000142', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', NULL, NULL),
(205, 7, 1, 2, 1, NULL, 'EMBOUT PRESSION 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000143', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', '2023-09-15 18:25:13', NULL),
(206, 7, 1, 2, 1, NULL, 'EMBOUT PRESSION 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000144', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', NULL, NULL),
(207, 7, 1, 2, 1, NULL, 'EMBOUT PRESSION 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '46.00', 'PLO10000145', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', '2023-09-20 16:45:08', NULL),
(208, 7, 1, 2, 1, NULL, 'EMBOUT PRESSION 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '12.00', 'PLO10000146', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', '2023-09-15 17:45:58', NULL),
(209, 7, 1, 2, 1, NULL, 'EMBOUT PRESSION 63', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '350.00', 'PLO10000147', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:20', '2023-09-15 17:45:59', NULL),
(210, 7, 1, 2, 1, NULL, 'EVIER 1BAC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '196.00', 'PLO10000148', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', NULL, NULL),
(211, 7, 1, 2, 1, NULL, 'EVIER 2BAC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000149', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', '2023-09-21 11:18:10', NULL),
(212, 7, 1, 2, 1, NULL, 'FILTRE À EAU 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'PLO10000150', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', '2023-09-20 11:07:41', NULL),
(213, 7, 1, 2, 1, NULL, 'FLEXIBLE INOX LAVABO EN FER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1819.00', 'PLO10000151', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', '2023-09-21 16:16:34', NULL),
(214, 7, 1, 2, 1, NULL, 'FLEXIBLE INOX LAVABO EN PVC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '42.00', 'PLO10000152', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', '2023-09-15 17:35:50', NULL),
(215, 7, 1, 2, 1, NULL, 'FLEXIBLE INOX WC EN FER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1422.00', 'PLO10000153', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', '2023-09-21 12:19:05', NULL),
(216, 7, 1, 2, 1, NULL, 'FLEXIBLE  WC EN PVC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '169.00', 'PLO10000154', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', '2023-09-15 18:23:52', NULL),
(217, 7, 1, 2, 1, NULL, 'FLEXIBLE LAVABO FIRMER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '208.00', 'PLO10000155', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', '2023-09-21 12:19:04', NULL),
(218, 7, 1, 2, 1, NULL, 'FLEXIBLE MITIGEUR EN FER ALEXMIX', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000156', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:21', NULL, NULL),
(219, 7, 1, 2, 1, NULL, 'FLEXIBLE WC FIRMER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '112.00', 'PLO10000157', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', '2023-09-21 12:19:05', NULL),
(220, 7, 1, 2, 1, NULL, 'FLOTTEUR ELECTRIQUE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000158', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', NULL, NULL),
(221, 7, 1, 2, 1, NULL, 'FLOTTEUR THANK CHROMÉ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '27.00', 'PLO10000159', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', NULL, NULL),
(222, 7, 1, 2, 1, NULL, 'FLOTTEUR WC MPMP 63813', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000160', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', '2023-09-15 18:27:15', NULL),
(223, 7, 1, 2, 1, NULL, 'FOND GOUTTIERE ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '78.00', 'PLO10000161', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', '2023-09-15 18:26:53', NULL),
(224, 7, 1, 2, 1, NULL, 'FOND NAISSANCE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1594.00', 'PLO10000162', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', '2023-09-15 18:26:53', NULL),
(225, 7, 1, 2, 1, NULL, 'GEBADJOINT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '42.00', 'PLO10000163', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', '2023-09-21 08:49:04', NULL),
(226, 7, 1, 2, 1, NULL, 'GOURGEON LAVABO GRAND', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '523.00', 'PLO10000164', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:22', '2023-09-20 14:17:00', NULL),
(227, 7, 1, 2, 1, NULL, 'GOURGEON LAVABO MOYEN', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000165', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', NULL, NULL),
(228, 7, 1, 2, 1, NULL, 'JOINT 12-17', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '170.00', 'PLO10000166', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', NULL, NULL),
(229, 7, 1, 2, 1, NULL, 'JOINT 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '377.00', 'PLO10000167', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', NULL, NULL),
(230, 7, 1, 2, 1, NULL, 'JOINT 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '254.00', 'PLO10000168', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', NULL, NULL),
(231, 7, 1, 2, 1, NULL, 'JONCTION GOTTIERE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '496.00', 'PLO10000169', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', '2023-09-15 18:26:52', NULL),
(232, 7, 1, 2, 1, NULL, 'LAVABO LIMA LUXE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '258.00', 'PLO10000170', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', '2023-09-15 17:58:01', NULL),
(233, 7, 1, 2, 1, NULL, 'LAVABA SUSPENDU BESILE CARRE I-2638', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000171', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', NULL, NULL);
INSERT INTO `produit` (`id`, `famille_id`, `point_vente_id`, `groupe_taxe_id`, `magasin_defaut_id`, `ref_prod`, `nom_prod`, `desc_prod`, `prix_achat_prod`, `prix_vente_prod`, `est_taxable`, `est_service`, `est_mode_carreau`, `code_qr`, `code_barre`, `seuil_appro`, `stock`, `code_produit`, `suivi_stock`, `mode_def_prix`, `metre_carre_par_carton`, `piece_par_carton`, `piece_par_metre_carre`, `surface_par_piece`, `couleur_carreau`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(234, 7, 1, 2, 1, NULL, 'LAVABA SUSPENDU BESILE ROND I-2628', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'PLO10000172', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:23', NULL, NULL),
(235, 7, 1, 2, 1, NULL, 'LAVABO SUSPENDU BESILE NOIR I-2742', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'PLO10000173', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', NULL, NULL),
(236, 7, 1, 2, 1, NULL, 'LAVE MAIN PARMA', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '190.00', 'PLO10000174', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', '2023-09-18 12:27:45', NULL),
(237, 7, 1, 2, 1, NULL, 'MACHINE PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '18.00', 'PLO10000175', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', NULL, NULL),
(238, 7, 1, 2, 1, NULL, 'MAMELON LAITON 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '18071.00', 'PLO10000176', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', '2023-09-20 14:17:04', NULL),
(239, 7, 1, 2, 1, NULL, 'MAMELON LAITON 26/34', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '902.00', 'PLO10000177', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', NULL, NULL),
(240, 7, 1, 2, 1, NULL, 'MAMELON LATON 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1389.00', 'PLO10000178', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', NULL, NULL),
(241, 7, 1, 2, 1, NULL, 'MAMELON RÉDUIT 62902-1/2*3/4L', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3430.00', 'PLO10000179', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', '2023-09-19 10:10:41', NULL),
(242, 7, 1, 2, 1, NULL, 'MANCHON À CHAUD', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '102.00', 'PLO10000180', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:24', NULL, NULL),
(243, 7, 1, 2, 1, NULL, 'MANCHON LAITON 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4037.00', 'PLO10000181', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', '2023-09-21 08:49:03', NULL),
(244, 7, 1, 2, 1, NULL, 'MANCHON LAITON 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000182', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', NULL, NULL),
(245, 7, 1, 2, 1, NULL, 'MANCHON LAITON 26/34', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000183', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', '2023-09-15 18:21:19', NULL),
(246, 7, 1, 2, 1, NULL, 'MANCHON PE 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '206.00', 'PLO10000184', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', NULL, NULL),
(247, 7, 1, 2, 1, NULL, 'MANCHON PE 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000185', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', NULL, NULL),
(248, 7, 1, 2, 1, NULL, 'MANCHON PE 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000186', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', NULL, NULL),
(249, 7, 1, 2, 1, NULL, 'MANCHON PPR 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '29.00', 'PLO10000187', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', NULL, NULL),
(250, 7, 1, 2, 1, NULL, 'MANCHON PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'PLO10000188', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:25', NULL, NULL),
(251, 7, 1, 2, 1, NULL, 'MANCHON PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'PLO10000189', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:26', NULL, NULL),
(252, 7, 1, 2, 1, NULL, 'MANCHON PPR 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000190', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:26', NULL, NULL),
(253, 7, 1, 2, 1, NULL, 'MANCHON PPR 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '12.00', 'PLO10000191', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:26', NULL, NULL),
(254, 7, 1, 2, 1, NULL, 'MANCHON PRESSION 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2616.00', 'PLO10000192', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:26', NULL, NULL),
(255, 7, 1, 2, 1, NULL, 'MANCHON PRESSION 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '453.00', 'PLO10000193', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:26', '2023-09-18 12:27:59', NULL),
(256, 7, 1, 2, 1, NULL, 'MANCHON PRESSION 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '13.00', 'PLO10000194', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:26', NULL, NULL),
(257, 7, 1, 2, 1, NULL, 'MANCHON PRESSION 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '159.00', 'PLO10000195', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:26', NULL, NULL),
(258, 7, 1, 2, 1, NULL, 'MÉCANISME À TIRETTE MPMP WK13151', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'PLO10000196', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:27', NULL, NULL),
(259, 7, 1, 2, 1, NULL, 'MECANISME GOLF À DOUBLE POUSSOIRE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'PLO10000197', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:27', NULL, NULL),
(260, 7, 1, 2, 1, NULL, 'MÉCANISME GOLF À POUSSOI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '308.00', 'PLO10000198', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:27', '2023-09-19 11:55:05', NULL),
(261, 7, 1, 2, 1, NULL, 'MECANISME PARMA', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '865.00', 'PLO10000199', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:27', '2023-09-15 18:29:02', NULL),
(262, 7, 1, 2, 1, NULL, 'MECANISME WC COMBINE J2-YFS', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '15.00', 'PLO10000200', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:27', NULL, NULL),
(263, 7, 1, 2, 1, NULL, 'MIROIRE WT-2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '70.00', 'PLO10000201', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:27', '2023-09-21 08:49:03', NULL),
(264, 7, 1, 2, 1, NULL, 'MITIGEUR DOUCHE FIRMER SP22040001', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '14.00', 'PLO10000202', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:27', '2023-09-15 18:15:20', NULL),
(265, 7, 1, 2, 1, NULL, 'NAISSANCE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '646.00', 'PLO10000203', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:28', '2023-09-15 18:25:52', NULL),
(266, 7, 1, 2, 1, NULL, 'PATE À GLACE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1043.00', 'PLO10000204', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:28', '2023-09-20 16:45:17', NULL),
(267, 7, 1, 2, 1, NULL, 'PATIN 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '56.00', 'PLO10000205', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:28', '2023-09-15 17:58:00', NULL),
(268, 7, 1, 2, 1, NULL, 'PATIN 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '58.00', 'PLO10000206', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:28', NULL, NULL),
(269, 7, 1, 2, 1, NULL, 'POMPE EMERGE INTER DAB 0.75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000207', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:28', NULL, NULL),
(270, 7, 1, 2, 1, NULL, 'PORT PAPIER KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '143.00', 'PLO10000208', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:28', NULL, NULL),
(271, 7, 1, 2, 1, NULL, 'PORT PAPIER SC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '390.00', 'PLO10000209', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:29', '2023-09-21 11:18:55', NULL),
(272, 7, 1, 2, 1, NULL, 'PORT SAVON LY7704 KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '597.00', 'PLO10000210', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:29', '2023-09-15 17:43:56', NULL),
(273, 7, 1, 2, 1, NULL, 'PORT SAVON SC GEDEYA', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000211', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:29', NULL, NULL),
(274, 7, 1, 2, 1, NULL, 'PORT SERVIETTE EN FER', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000212', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:29', NULL, NULL),
(275, 7, 1, 2, 1, NULL, 'PORT SERVIETTE LY7701 KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '13.00', 'PLO10000213', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:29', NULL, NULL),
(276, 7, 1, 2, 1, NULL, 'PORT SERVIETTE PLASTIQUE GDY60701', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '165.00', 'PLO10000214', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:29', '2023-09-15 18:17:05', NULL),
(277, 7, 1, 2, 1, NULL, 'POUPEE FILASS 2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '107.00', 'PLO10000215', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:30', '2023-09-20 16:45:07', NULL),
(278, 7, 1, 2, 1, NULL, 'PUISSAGE KMEI LY303 1/2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'PLO10000216', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:30', '2023-09-19 08:43:46', NULL),
(279, 7, 1, 2, 1, NULL, 'QUEUE DE CAP', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '60.00', 'PLO10000217', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:30', NULL, NULL),
(280, 7, 1, 2, 1, NULL, 'RACCORD ANNULE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '332.00', 'PLO10000218', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:30', NULL, NULL),
(281, 7, 1, 2, 1, NULL, 'RACCORD UNION PPR 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '417.00', 'PLO10000219', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:30', NULL, NULL),
(282, 7, 1, 2, 1, NULL, 'RACCORD UNION PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '8.00', 'PLO10000220', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:30', '2023-09-16 14:14:34', NULL),
(283, 7, 1, 2, 1, NULL, 'RACCORD UNION PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000221', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:31', '2023-09-16 14:14:36', NULL),
(284, 7, 1, 2, 1, NULL, 'RACCORD UNION PPR 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '215.00', 'PLO10000222', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:31', NULL, NULL),
(285, 7, 1, 2, 1, NULL, 'RACCORD UNION PRESSION 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000223', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:31', NULL, NULL),
(286, 7, 1, 2, 1, NULL, 'RACCORD UNION PRESSION 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000224', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:31', '2023-09-15 17:45:57', NULL),
(287, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PPR 25*20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000225', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:31', NULL, NULL),
(288, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PPR 32*20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '425.00', 'PLO10000226', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:31', NULL, NULL),
(289, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PPR 32*25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1173.00', 'PLO10000227', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:31', '2023-09-20 13:01:20', NULL),
(290, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PPR 40*32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '157.00', 'PLO10000228', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:32', '2023-09-16 14:14:36', NULL),
(291, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PPR 50*32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '78.00', 'PLO10000229', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:32', '2023-09-20 13:01:20', NULL),
(292, 7, 1, 2, 1, NULL, 'REDUCTEUR PRESSION  63/50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '150.00', 'PLO10000230', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:32', NULL, NULL),
(293, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PRESSION 25*20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1109.00', 'PLO10000231', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:32', '2023-09-20 16:45:11', NULL),
(294, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PRESSION 32/25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '467.00', 'PLO10000232', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:32', '2023-09-20 16:45:07', NULL),
(295, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PRESSION 40*32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '27.00', 'PLO10000233', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:32', '2023-09-15 18:09:28', NULL),
(296, 7, 1, 2, 1, NULL, 'REDUCTEUR PRESSION 50/32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '346.00', 'PLO10000234', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:32', '2023-09-20 16:45:06', NULL),
(297, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC 40/32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '398.00', 'PLO10000235', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:33', NULL, NULL),
(298, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 100/32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4250.00', 'PLO10000236', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:33', '2023-09-20 13:05:45', NULL),
(299, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 100/40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2195.00', 'PLO10000237', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:33', '2023-09-20 14:16:56', NULL),
(300, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 100/63', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '114.00', 'PLO10000238', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:33', NULL, NULL),
(301, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 100/75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3932.00', 'PLO10000239', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:33', '2023-09-15 17:53:45', NULL),
(302, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 110/100', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '395.00', 'PLO10000240', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:33', '2023-09-15 18:26:13', NULL),
(303, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 110/32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '291.00', 'PLO10000241', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:33', NULL, NULL),
(304, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 110/75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '45.00', 'PLO10000242', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:34', NULL, NULL),
(305, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 125/100', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '118.00', 'PLO10000243', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:34', '2023-09-15 17:47:34', NULL),
(306, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 125/110', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000244', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:34', NULL, NULL),
(307, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 160*110 KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '99.00', 'PLO10000245', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:34', NULL, NULL),
(308, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 75/32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '230.00', 'PLO10000246', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:34', NULL, NULL),
(309, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 75/40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '498.00', 'PLO10000247', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:34', '2023-09-20 14:16:57', NULL),
(310, 7, 1, 2, 1, NULL, 'RÉDUCTEUR PVC PLAT 75/50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '32.00', 'PLO10000248', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:34', NULL, NULL),
(311, 7, 1, 2, 1, NULL, 'ROBINET D\'ARRET 15/21 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7505.00', 'PLO10000249', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:35', '2023-09-21 11:18:08', NULL),
(312, 7, 1, 2, 1, NULL, 'ROBINET D\'ARRET GRK 26/34', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '350.00', 'PLO10000250', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:35', '2023-09-15 18:20:43', NULL),
(313, 7, 1, 2, 1, NULL, 'ROBINET D\'ARRETE 20/27 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000251', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:35', '2023-09-15 17:47:04', NULL),
(314, 7, 1, 2, 1, NULL, 'ROBINET DE DOUCHE 8901', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '449.00', 'PLO10000252', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:35', '2023-09-20 16:45:13', NULL),
(315, 7, 1, 2, 1, NULL, 'ROBINET DE DOUCHE KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000253', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:35', '2023-09-15 18:27:13', NULL),
(316, 7, 1, 2, 1, NULL, 'ROBINET DE DOUCHE MITIGEUR MAAT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000254', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:35', NULL, NULL),
(317, 7, 1, 2, 1, NULL, 'ROBINET EQUERRE GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '12006.00', 'PLO10000255', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:35', '2023-09-21 08:48:59', NULL),
(318, 7, 1, 2, 1, NULL, 'ROBINET EVIER MITIGEUR MURALE SC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000256', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:36', NULL, NULL),
(319, 7, 1, 2, 1, NULL, 'ROBINET EVIER MURAL', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '107.00', 'PLO10000257', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:36', '2023-09-20 16:45:15', NULL),
(320, 7, 1, 2, 1, NULL, 'ROBINET EVIER ORIGINAL MAK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'PLO10000258', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:36', NULL, NULL),
(321, 7, 1, 2, 1, NULL, 'ROBINET EVIER PLASTIC SUR TABLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '187.00', 'PLO10000259', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:36', NULL, NULL),
(322, 7, 1, 2, 1, NULL, 'ROBINET EVIER PLASTIQUE MURAL', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '57.00', 'PLO10000260', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:36', NULL, NULL),
(323, 7, 1, 2, 1, NULL, 'ROBINET LAVABO BLEU MITIGEUR PETIT CORPS', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'PLO10000261', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:36', NULL, NULL),
(324, 7, 1, 2, 1, NULL, 'ROBINET LAVABO INGLAND', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '30.00', 'PLO10000262', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:37', '2023-09-21 11:18:09', NULL),
(325, 7, 1, 2, 1, NULL, 'ROBINET LAVABO KMEI LY 600-861K', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'PLO10000263', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:37', NULL, NULL),
(326, 7, 1, 2, 1, NULL, 'ROBINET LAVABO MITIGEUR BLEU GROS CORPS', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000264', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:37', '2023-09-15 18:09:28', NULL),
(327, 7, 1, 2, 1, NULL, 'ROBINET LAVABO MITIGEUR Ingland', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '6.00', 'PLO10000265', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:37', NULL, NULL),
(328, 7, 1, 2, 1, NULL, 'ROBINET LAVABO MITIGEUR MAAT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000266', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:37', NULL, NULL),
(329, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE 15/21 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4268.00', 'PLO10000267', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 09:49:12', '2023-09-21 08:48:58', NULL),
(330, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE À BOISSEAU 15/21 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '66.00', 'PLO10000268', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:38', '2023-09-15 18:25:50', NULL),
(331, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE À BOISSEAU FIRMER YLN6316-1/2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000269', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:38', NULL, NULL),
(332, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE À CLÉ 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '11.00', 'PLO10000270', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:38', '2023-09-15 17:41:39', NULL),
(333, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE CHROMÉ A CLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '12.00', 'PLO10000271', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:38', '2023-09-21 08:49:01', NULL),
(334, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE GRK 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000272', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:38', NULL, NULL),
(335, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE KMEI 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '337.00', 'PLO10000273', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:39', NULL, NULL),
(336, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE KMEI LY1300 1/2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '82.00', 'PLO10000274', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:39', '2023-09-19 08:43:46', NULL),
(337, 7, 1, 2, 1, NULL, 'ROBINET PUISSAGE PLASTIQUE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '84.00', 'PLO10000275', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:39', NULL, NULL),
(338, 7, 1, 2, 1, NULL, 'ROBINET URINOIRE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000276', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:39', '2023-09-15 18:31:14', NULL),
(339, 7, 1, 2, 1, NULL, 'SIPHON DE SOL 10G', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '360.00', 'PLO10000277', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:39', '2023-09-21 12:19:06', NULL),
(340, 7, 1, 2, 1, NULL, 'SIPHON DE SOL DE LUXE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '51.00', 'PLO10000278', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:39', '2023-09-18 14:30:59', NULL),
(341, 7, 1, 2, 1, NULL, 'SIPHON EVIER GROS TROU 1BAC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '8.00', 'PLO10000279', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:40', NULL, NULL),
(342, 7, 1, 2, 1, NULL, 'SIPHON EVIER SC 60804-40C', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000280', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:40', NULL, NULL),
(343, 7, 1, 2, 1, NULL, 'SIPHON LAVABO À TIGE KMEI LY761-32P', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'PLO10000281', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:40', NULL, NULL),
(344, 7, 1, 2, 1, NULL, 'SIPHON LAVABO ACCORDÉON SC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1308.00', 'PLO10000282', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:40', '2023-09-20 14:16:58', NULL),
(345, 7, 1, 2, 1, NULL, 'SIPHON LAVABO SANS TIGE KMIE LY761-32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000283', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:40', NULL, NULL),
(346, 7, 1, 2, 1, NULL, 'TABLETTE LY7702 KMEI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000284', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:40', NULL, NULL),
(347, 7, 1, 2, 1, NULL, 'TABLETTE PLASTIQUE GDY60702', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '75.00', 'PLO10000285', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:41', NULL, NULL),
(348, 7, 1, 2, 1, NULL, 'TÉ À CHAUD', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000286', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:41', NULL, NULL),
(349, 7, 1, 2, 1, NULL, 'TÉ LAITON 15/21', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1030.00', 'PLO10000287', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:41', '2023-09-20 16:45:10', NULL),
(350, 7, 1, 2, 1, NULL, 'TÉ LAITON 20/27', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '534.00', 'PLO10000288', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:41', NULL, NULL),
(351, 7, 1, 2, 1, NULL, 'TÉ LAITON 26/34', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000289', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:41', NULL, NULL),
(352, 7, 1, 2, 1, NULL, 'TÉ PPR 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '803.00', 'PLO10000290', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:41', NULL, NULL),
(353, 7, 1, 2, 1, NULL, 'TÉ PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1629.00', 'PLO10000291', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:42', '2023-09-20 13:05:43', NULL),
(354, 7, 1, 2, 1, NULL, 'TÉ PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1702.00', 'PLO10000292', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:42', '2023-09-15 18:34:13', NULL),
(355, 7, 1, 2, 1, NULL, 'TÉ PPR 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '241.00', 'PLO10000293', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:42', '2023-09-15 18:34:12', NULL),
(356, 7, 1, 2, 1, NULL, 'TÉ PPR 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'PLO10000294', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:42', NULL, NULL),
(357, 7, 1, 2, 1, NULL, 'TÉ PPR TARODÉ 20*1/2 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '65.00', 'PLO10000295', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:42', NULL, NULL),
(358, 7, 1, 2, 1, NULL, 'TÉ PPR TARODÉ 20*1/2 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '80.00', 'PLO10000296', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:42', NULL, NULL),
(359, 7, 1, 2, 1, NULL, 'TÉ PPR TARODE 25*1/2 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1622.00', 'PLO10000297', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:43', NULL, NULL),
(360, 7, 1, 2, 1, NULL, 'TÉ PPR TARODÉ 25*1/2FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '418.00', 'PLO10000298', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:43', '2023-09-15 18:13:20', NULL),
(361, 7, 1, 2, 1, NULL, 'TÉ PPR TARODÉ 25*3/4 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '447.00', 'PLO10000299', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:43', NULL, NULL),
(362, 7, 1, 2, 1, NULL, 'TÉ PPR TARODE 25*3/4 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '196.00', 'PLO10000300', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:43', NULL, NULL),
(363, 7, 1, 2, 1, NULL, 'TÉ PPR TARODÉ 32*1\" FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '158.00', 'PLO10000301', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:43', NULL, NULL),
(364, 7, 1, 2, 1, NULL, 'TÉ PPR TARODÉ 32*1/2 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '43.00', 'PLO10000302', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:44', NULL, NULL),
(365, 7, 1, 2, 1, NULL, 'TÉ PPR TARODE 32*3/4 FEMELLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '168.00', 'PLO10000303', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:44', NULL, NULL),
(366, 7, 1, 2, 1, NULL, 'TÉ PPR TARODÉ 32*3/4 MÂLE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '99.00', 'PLO10000304', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:44', NULL, NULL),
(367, 7, 1, 2, 1, NULL, 'TÉ PRESSION 110', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '24.00', 'PLO10000305', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:44', NULL, NULL),
(368, 7, 1, 2, 1, NULL, 'TÉ PRESSION 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '6.00', 'PLO10000306', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:44', NULL, NULL),
(369, 7, 1, 2, 1, NULL, 'TÉ PRESSION 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2237.00', 'PLO10000307', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:44', '2023-09-21 11:18:06', NULL),
(370, 7, 1, 2, 1, NULL, 'TÉ PRESSION 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1495.00', 'PLO10000308', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:45', '2023-09-20 16:45:06', NULL),
(371, 7, 1, 2, 1, NULL, 'TÉ PRESSION 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '259.00', 'PLO10000309', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:45', '2023-09-21 11:18:05', NULL),
(372, 7, 1, 2, 1, NULL, 'TÉ PRESSION 63', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000310', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:45', NULL, NULL),
(373, 7, 1, 2, 1, NULL, 'TÉ PRESSION 90', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '34.00', 'PLO10000311', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:45', NULL, NULL),
(374, 7, 1, 2, 1, NULL, 'TEFLON PETIT', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000312', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:45', NULL, NULL),
(375, 7, 1, 2, 1, NULL, 'TETE ROBINET 15/21 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '15033.00', 'PLO10000313', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:46', '2023-09-21 08:48:59', NULL),
(376, 7, 1, 2, 1, NULL, 'TETE ROBINET 20/27 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1440.00', 'PLO10000314', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:46', '2023-09-21 08:48:59', NULL),
(377, 7, 1, 2, 1, NULL, 'TUYAUX À CHAUD', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000315', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:46', NULL, NULL),
(378, 7, 1, 2, 1, NULL, 'TUYAUX GOUTTIERE ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '43.00', 'PLO10000316', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:46', '2023-09-15 18:25:51', NULL),
(379, 7, 1, 2, 1, NULL, 'TUYAUX PPR 25*4.4', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000317', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:46', '2023-09-15 17:46:20', NULL),
(380, 7, 1, 2, 1, NULL, 'TUYAUX PPR 32*5.4', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '21.00', 'PLO10000318', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:46', '2023-09-16 14:14:37', NULL),
(381, 7, 1, 2, 1, NULL, 'TUYAUX PPR 40*6.7', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '442.00', 'PLO10000319', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:47', NULL, NULL),
(382, 7, 1, 2, 1, NULL, 'TUYAUX PPR 50*8.4', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '366.00', 'PLO10000320', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:47', NULL, NULL),
(383, 7, 1, 2, 1, NULL, 'TUYAUX PPR 63*10.5', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '204.00', 'PLO10000321', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:47', NULL, NULL),
(384, 7, 1, 2, 1, NULL, 'VANNE À BOISSEAU 61511-1\"/1/4 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '36.00', 'PLO10000322', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:47', '2023-09-15 18:13:50', NULL),
(385, 7, 1, 2, 1, NULL, 'VANNE À BOISSEAU 61511-15/21 GRK', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '46.00', 'PLO10000323', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:47', NULL, NULL),
(386, 7, 1, 2, 1, NULL, 'VANNE À BOISSEAU FIRMER CHROME 1\"/1/4', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '44.00', 'PLO10000324', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:47', NULL, NULL),
(387, 7, 1, 2, 1, NULL, 'VANNE A BOISSEAU FIRMER CHROME 1./1/2 FF', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '61.00', 'PLO10000325', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:48', NULL, NULL),
(388, 7, 1, 2, 1, NULL, 'VANNE À BOISSEAU FIRMER YLN 6233-2\"', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000326', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:48', NULL, NULL),
(389, 7, 1, 2, 1, NULL, 'VANNE A BOISSEAU FIRMER YLN 6233-3/4', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000327', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:48', NULL, NULL),
(390, 7, 1, 2, 1, NULL, 'VANNE À BOISSEAU MAYER 1\"', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '16.00', 'PLO10000328', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:48', NULL, NULL),
(391, 7, 1, 2, 1, NULL, 'VANNE À BOISSEAU PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '181.00', 'PLO10000329', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:48', '2023-09-15 18:29:58', NULL),
(392, 7, 1, 2, 1, NULL, 'VANNE À BOISSEAU PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '43.00', 'PLO10000330', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:49', NULL, NULL),
(393, 7, 1, 2, 1, NULL, 'VANNE À RACCORD  UNION PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'PLO10000331', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:49', NULL, NULL),
(394, 7, 1, 2, 1, NULL, 'VANNE À RACCORD UNION PRESSION 110', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '8.00', 'PLO10000332', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:49', NULL, NULL),
(395, 7, 1, 2, 1, NULL, 'VANNE À RACCORD UNION PRESSION 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '90.00', 'PLO10000333', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:49', NULL, NULL),
(396, 7, 1, 2, 1, NULL, 'VANNE À RACCORD UNION PRESSION 63', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '48.00', 'PLO10000334', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:49', NULL, NULL),
(397, 7, 1, 2, 1, NULL, 'VANNE À RACCORD UNION PRESSION 75', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '19.00', 'PLO10000335', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:49', NULL, NULL),
(398, 7, 1, 2, 1, NULL, 'VANNE À VOLANT PPR 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '172.00', 'PLO10000336', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:50', NULL, NULL),
(399, 7, 1, 2, 1, NULL, 'VANNE À VOLANT PPR 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '232.00', 'PLO10000337', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:50', '2023-09-20 12:09:51', NULL),
(400, 7, 1, 2, 1, NULL, 'VANNE À VOLANT PPR 32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1969.00', 'PLO10000338', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:50', NULL, NULL),
(401, 7, 1, 2, 1, NULL, 'VANNE PPR DE LUXE 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '684.00', 'PLO10000339', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:50', NULL, NULL),
(402, 7, 1, 2, 1, NULL, 'VANNE PRESSION DE 20', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '272.00', 'PLO10000340', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:50', NULL, NULL),
(403, 7, 1, 2, 1, NULL, 'VANNE PRESSION DE 25', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '258.00', 'PLO10000341', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:51', NULL, NULL),
(404, 7, 1, 2, 1, NULL, 'VANNE PRESSION DE 50', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '8.00', 'PLO10000342', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:51', '2023-09-21 15:21:38', NULL),
(405, 7, 1, 2, 1, NULL, 'VANNE PRESSION DE 40', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '51.00', 'PLO10000343', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:51', NULL, NULL),
(406, 7, 1, 2, 1, NULL, 'VICE CACHE TETE LY562WC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'PLO10000344', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:51', NULL, NULL),
(407, 7, 1, 2, 1, NULL, 'VIDANGE BAIGNOIRE PROFESSIONNEL', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '103.00', 'PLO10000345', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:51', NULL, NULL),
(408, 7, 1, 2, 1, NULL, 'VIDANGE EVIER 2BAC GROS TROU', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '160.00', 'PLO10000346', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:52', NULL, NULL),
(409, 7, 1, 2, 1, NULL, 'WC PARMA BLANC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000347', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:52', NULL, NULL),
(410, 7, 1, 2, 1, NULL, 'WC LIMA GRAND', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '140.00', 'PLO10000348', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:52', '2023-09-15 17:46:43', NULL),
(411, 7, 1, 2, 1, NULL, 'WC COMBINE RONA A-P 1769', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'PLO10000349', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:52', NULL, NULL),
(412, 7, 1, 2, 1, NULL, 'WC COMBINE CARRE A-P1770', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'PLO10000350', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:52', NULL, NULL),
(413, 7, 1, 2, 1, NULL, 'WC COMBINE CARRE A-P1767', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'PLO10000351', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:53', NULL, NULL),
(414, 7, 1, 2, 1, NULL, 'WC SUSPENDU BESILE D-P3651', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'PLO10000352', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:53', NULL, NULL),
(415, 7, 1, 2, 1, NULL, 'WC SUSPENDU BESILE NOIR D-P3651B', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'PLO10000353', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:53', '2023-09-18 14:30:59', NULL),
(416, 8, 1, 2, 1, NULL, ' AGA 270  ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '9.00', 'SER10000001', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:53', '2023-09-22 12:50:38', NULL),
(417, 8, 1, 2, 1, NULL, ' ROBIWANG 124', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '168.00', 'SER10000002', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:53', NULL, NULL),
(418, 8, 1, 2, 1, NULL, 'CADENAS VACHETTE  SEMI 75MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '251.00', 'SER10000003', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:53', '2023-09-15 18:33:38', NULL),
(419, 8, 1, 2, 1, NULL, 'CADENAS VACHETTE SEMI  80MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '258.00', 'SER10000004', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:54', NULL, NULL),
(420, 8, 1, 2, 1, NULL, 'CADENAS VACHETTE ORIGINAL  80MM', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '58.00', 'SER10000005', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:54', '2023-09-21 16:52:09', NULL),
(421, 8, 1, 2, 1, NULL, 'CLÉ DOR 88 3CLÉS', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '40.00', 'SER10000006', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:54', NULL, NULL),
(422, 8, 1, 2, 1, NULL, 'CYLINDRE ARM LOCK A70', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '214.00', 'SER10000007', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:54', '2023-09-22 11:55:01', NULL),
(423, 8, 1, 2, 1, NULL, 'CYLINDRE BUTUC UNIC U70A', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '498.00', 'SER10000008', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:54', '2023-09-22 11:55:01', NULL),
(424, 8, 1, 2, 1, NULL, 'CYLINDRE CLE DOOR', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '840.00', 'SER10000009', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 09:35:38', '2023-09-18 14:12:48', NULL),
(425, 8, 1, 2, 1, NULL, 'CYLINDRE LA PERCHE 60M LAP SACHET', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '26.00', 'SER10000010', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:55', '2023-09-21 12:45:26', NULL),
(426, 8, 1, 2, 1, NULL, 'CYLINDRE LA PERCHE BLEU 60M', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '206.00', 'SER10000011', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 09:09:52', '2023-09-22 11:55:24', NULL),
(427, 8, 1, 2, 1, NULL, 'CYLINDRE PARFAIT BLEU P70A', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '606.00', 'SER10000012', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 16:57:46', '2023-09-22 11:55:01', NULL),
(428, 8, 1, 2, 1, NULL, 'CYLINDRE VACHETTE 60MM 3K', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '20.00', 'SER10000013', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-18 09:45:12', '2023-09-21 15:11:55', NULL),
(429, 8, 1, 2, 1, NULL, 'EVERLEO', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '46.00', 'SER10000014', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:56', '2023-09-20 10:43:27', NULL),
(430, 8, 1, 2, 1, NULL, 'FAEA 139-32', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '141.00', 'SER10000015', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:56', NULL, NULL),
(431, 8, 1, 2, 1, NULL, 'SERRURE G.J.S', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1173.00', 'SER10000016', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:56', '2023-09-18 14:12:48', NULL),
(432, 8, 1, 2, 1, NULL, 'LA CLÉ 124', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000017', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:56', NULL, NULL),
(433, 8, 1, 2, 1, NULL, 'LA PERCHE 3253 CR', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '57.00', 'SER10000018', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:56', NULL, NULL),
(434, 8, 1, 2, 1, NULL, 'LA PERCHE 3253 SCR', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '48.00', 'SER10000019', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:57', NULL, NULL),
(435, 8, 1, 2, 1, NULL, 'LA PERCHE 9019-F1 SILVER GP', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '144.00', 'SER10000020', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:57', '2023-09-15 17:56:14', NULL),
(436, 8, 1, 2, 1, NULL, 'LA PERCHE 9019-WC SILVER ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '41.00', 'SER10000021', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:57', '2023-09-15 17:40:52', NULL),
(437, 8, 1, 2, 1, NULL, 'LA PERCHE 911B6458 AB NORMALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '160.00', 'SER10000022', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:57', '2023-09-22 12:50:38', NULL),
(438, 8, 1, 2, 1, NULL, 'LA PERCHE 911B6458 AB WC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '76.00', 'SER10000023', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:57', '2023-09-15 17:56:13', NULL),
(439, 8, 1, 2, 1, NULL, 'LA PERCHE 911B6458 SCR NORMALE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '404.00', 'SER10000024', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:58', '2023-09-15 17:56:13', NULL),
(440, 8, 1, 2, 1, NULL, 'LA PERCHE 911B6458 SCR WC', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '90.00', 'SER10000025', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:58', NULL, NULL),
(441, 8, 1, 2, 1, NULL, 'LA PERCHE CAISSE 6458', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3342.00', 'SER10000026', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 12:00:03', '2023-09-20 16:44:48', NULL),
(442, 8, 1, 2, 1, NULL, 'LA PERCHE DE LUXE 0850', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000027', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:58', NULL, NULL),
(443, 8, 1, 2, 1, NULL, 'LA PERCHE GARANTIE 10 ANS 9058', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000028', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:58', NULL, NULL),
(444, 8, 1, 2, 1, NULL, 'LA PERCHE ORIGINAL', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '52.00', 'SER10000029', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:59', '2023-09-18 14:14:05', NULL),
(445, 8, 1, 2, 1, NULL, 'MICC 202', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '76.00', 'SER10000030', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:59', '2023-09-20 16:45:47', NULL),
(446, 8, 1, 2, 1, NULL, 'MICC 404', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '98.00', 'SER10000031', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:59', '2023-09-20 16:45:47', NULL),
(447, 8, 1, 2, 1, NULL, 'PACO 210PA', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '10.00', 'SER10000032', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:59', '2023-09-15 18:33:54', NULL),
(448, 8, 1, 2, 1, NULL, 'PACO PARFAIT G112-AB', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '194.00', 'SER10000033', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:42:59', '2023-09-21 16:52:09', NULL),
(449, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT à GAGE A007', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '139.00', 'SER10000034', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:00', '2023-09-15 17:56:15', NULL),
(450, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT A GAGE A007-2 CHAMPAGNE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '91.00', 'SER10000035', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:00', NULL, NULL),
(451, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT A GAGE BLACK A007-4', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'SER10000036', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:00', '2023-09-21 16:51:56', NULL),
(452, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT A007BL-020BL-022', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '121.00', 'SER10000037', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:00', '2023-09-18 14:30:58', NULL),
(453, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT A022', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '18.00', 'SER10000038', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:01', '2023-09-15 17:56:14', NULL),
(454, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT A020BL-A020AB', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '163.00', 'SER10000039', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:01', NULL, NULL),
(455, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT PORTE VITRIER P100 B8 W2', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '172.00', 'SER10000040', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:01', NULL, NULL),
(456, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT X-A003', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'SER10000041', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:01', NULL, NULL),
(457, 8, 1, 2, 1, NULL, 'PAUMELLE AGA 140', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '43.00', 'SER10000042', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 19:17:39', '2023-09-15 18:21:39', NULL),
(458, 8, 1, 2, 1, NULL, 'PAUMELLE AGA 160 ', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '29.00', 'SER10000043', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:02', '2023-09-21 15:16:41', NULL),
(459, 8, 1, 2, 1, NULL, 'PAUMELLE AGA 80', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '4.00', 'SER10000044', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:02', '2023-09-21 15:21:39', NULL),
(460, 8, 1, 2, 1, NULL, 'PAUMELLE AMI 110', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'SER10000045', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:02', NULL, NULL),
(461, 8, 1, 2, 1, NULL, 'PAUMELLE AMI 95', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '5.00', 'SER10000046', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:02', '2023-09-21 15:21:40', NULL),
(462, 8, 1, 2, 1, NULL, 'SERRURE EVERLEO 905AB/7050H', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '0.00', 'SER10000047', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:02', '2023-09-22 12:50:49', NULL);
INSERT INTO `produit` (`id`, `famille_id`, `point_vente_id`, `groupe_taxe_id`, `magasin_defaut_id`, `ref_prod`, `nom_prod`, `desc_prod`, `prix_achat_prod`, `prix_vente_prod`, `est_taxable`, `est_service`, `est_mode_carreau`, `code_qr`, `code_barre`, `seuil_appro`, `stock`, `code_produit`, `suivi_stock`, `mode_def_prix`, `metre_carre_par_carton`, `piece_par_carton`, `piece_par_metre_carre`, `surface_par_piece`, `couleur_carreau`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(463, 8, 1, 2, 1, NULL, 'SERRURE PARFAIT DOUCHE', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '168.00', 'SER10000048', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:03', '2023-09-18 14:30:58', NULL),
(464, 8, 1, 2, 1, NULL, 'SERRURE PH01', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '7.00', 'SER10000049', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:03', NULL, NULL),
(465, 8, 1, 2, 1, NULL, 'VACHETTE 9045', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000050', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:03', NULL, NULL),
(466, 8, 1, 2, 1, NULL, 'VACHETTE ARMOIRE 1TOUR 4464-22', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '11.00', 'SER10000051', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:03', NULL, NULL),
(467, 8, 1, 2, 1, NULL, 'VERROU à CADENAS 10 SEMI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'SER10000052', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:04', NULL, NULL),
(468, 8, 1, 2, 1, NULL, 'VERROU à CADENAS 12 SEMI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '3.00', 'SER10000053', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:04', NULL, NULL),
(469, 8, 1, 2, 1, NULL, 'VERROU À CADENAS 14', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000054', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:04', NULL, NULL),
(470, 8, 1, 2, 1, NULL, 'VERROU à CADENAS 14 SEMI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000055', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:04', NULL, NULL),
(471, 8, 1, 2, 1, NULL, 'VERROU à CADENAS 8 SEMI', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000056', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:04', NULL, NULL),
(472, 8, 1, 2, 1, NULL, 'VERROU À PISTOLER 12', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '1.00', 'SER10000057', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(473, 8, 1, 2, 1, NULL, 'VERROU À PISTOLER 16', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'SER10000058', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(474, 8, 1, 2, 1, NULL, 'VERROU À PISTOLER 8', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '2.00', 'SER10000059', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(475, 8, 1, 2, 1, NULL, ' WISTA', NULL, '0.00', '0.00', 1, 0, 0, NULL, NULL, '10.00', '29.00', 'SER10000060', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(476, 7, 1, 2, 1, NULL, 'ROBINET LAVABO KMEI LY 631-680', NULL, '0.00', NULL, 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000354', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 12:13:00', '2023-09-15 18:29:24', NULL),
(477, 7, 1, 2, 1, NULL, 'ROBINET LAVABO KMEI PLASTIC GROS CORPS', NULL, '0.00', NULL, 1, 0, 0, NULL, NULL, '10.00', '0.00', 'PLO10000355', 0, '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 12:17:12', '2023-09-15 18:28:37', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_conditionnement`
--

DROP TABLE IF EXISTS `produit_conditionnement`;
CREATE TABLE IF NOT EXISTS `produit_conditionnement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int NOT NULL,
  `conditionnement_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `qte_cond` decimal(10,2) NOT NULL DEFAULT '0.00',
  `qte_stock_cond` decimal(10,2) NOT NULL DEFAULT '0.00',
  `prix_min` decimal(10,2) DEFAULT NULL,
  `prix_max` decimal(10,2) DEFAULT NULL,
  `prix_de_vente` decimal(10,2) NOT NULL,
  `prix_de_vente_ht` decimal(10,2) DEFAULT NULL,
  `prix_de_vente_ttc` decimal(10,2) DEFAULT NULL,
  `cump` decimal(10,2) DEFAULT NULL,
  `stock_init` decimal(10,2) DEFAULT NULL,
  `qte_stock_cond_logique` decimal(10,2) NOT NULL DEFAULT '0.00',
  `nom_pro_cond` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `est_unite_base` tinyint(1) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1F452A28F347EFB` (`produit_id`),
  KEY `IDX_1F452A28A222637` (`conditionnement_id`),
  KEY `IDX_1F452A28EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_conditionnement`
--

INSERT INTO `produit_conditionnement` (`id`, `produit_id`, `conditionnement_id`, `point_vente_id`, `qte_cond`, `qte_stock_cond`, `prix_min`, `prix_max`, `prix_de_vente`, `prix_de_vente_ht`, `prix_de_vente_ttc`, `cump`, `stock_init`, `qte_stock_cond_logique`, `nom_pro_cond`, `est_sup`, `est_unite_base`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, '1.00', '23.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '23.00', 'BALAI DE SOL [UNITE]', NULL, 0, '2023-09-12 15:42:01', NULL, NULL),
(2, 2, 1, 1, '1.00', '760.00', '0.00', '1000000.00', '1900.00', '1610.17', '1900.00', '0.00', NULL, '1100.00', 'BALAI CANTONNÉ [UNITE]', NULL, 0, '2023-09-12 15:42:02', '2023-09-19 15:34:45', NULL),
(3, 3, 1, 1, '1.00', '379.00', '0.00', '1000000.00', '850.00', '720.34', '850.00', '0.00', NULL, '379.00', 'BROSSE WC 8078 [UNITE]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(4, 4, 2, 1, '1.00', '427.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '427.00', 'FACE MASK [BOITE]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(5, 5, 3, 1, '1.00', '4.00', '0.00', '1000000.00', '350000.00', '296610.17', '350000.00', '0.00', NULL, '4.00', 'GAZON SYNTHETIQUE [ROULEAU]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(6, 6, 4, 1, '1.00', '1.00', '0.00', '1000000.00', '76000.00', '64406.78', '76000.00', '0.00', NULL, '1.00', 'PINCEAU 100MM [CARTON]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(7, 7, 4, 1, '1.00', '3.00', '0.00', '1000000.00', '90000.00', '76271.19', '90000.00', '0.00', NULL, '3.00', 'PINCEAU 40MM [CARTON]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(8, 8, 4, 1, '1.00', '7.00', '0.00', '1000000.00', '100000.00', '84745.76', '100000.00', '0.00', NULL, '7.00', 'PINCEAU 50MM [CARTON]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(9, 9, 4, 1, '1.00', '5.00', '0.00', '1000000.00', '100000.00', '84745.76', '100000.00', '0.00', NULL, '5.00', 'PINCEAU 60MM [CARTON]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(10, 10, 4, 1, '1.00', '4.00', '0.00', '1000000.00', '120000.00', '101694.92', '120000.00', '0.00', NULL, '4.00', 'PINCEAU 70MM [CARTON]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(11, 11, 1, 1, '1.00', '51.00', '0.00', '1000000.00', '1800.00', '1525.42', '1800.00', '0.00', NULL, '51.00', 'RIDEAU DE DOUCHE [UNITE]', NULL, 0, '2023-09-12 15:42:02', NULL, NULL),
(12, 12, 5, 1, '1.00', '120.00', '0.00', '1000000.00', '7000.00', '5932.20', '7000.00', '0.00', NULL, '120.00', 'SERPIERE [DOUZAINE]', NULL, 0, '2023-09-12 15:42:02', '2023-09-22 12:50:49', NULL),
(13, 13, 4, 1, '1.00', '0.00', '0.00', '1000000.00', '24000.00', '20338.98', '24000.00', '0.00', NULL, '19.00', 'BAGUETTE ATLANTICS 2.5 [CARTON]', NULL, 0, '2023-09-12 15:42:02', '2023-09-21 10:47:22', NULL),
(14, 14, 4, 1, '1.00', '0.00', '0.00', '1000000.00', '24000.00', '20338.98', '24000.00', '0.00', NULL, '40.00', 'BAGUETTE ATLANTICS 3.2 [CARTON]', NULL, 0, '2023-09-12 15:42:03', '2023-09-21 10:47:23', NULL),
(15, 15, 5, 1, '1.00', '14.00', '0.00', '1000000.00', '6000.00', '5084.75', '6000.00', '0.00', NULL, '14.00', 'CENTIMETRE JAUNE TRANSPARENT F2-13928-2 [DOUZAINE]', NULL, 0, '2023-09-12 15:42:03', NULL, NULL),
(16, 16, 5, 1, '1.00', '79.00', '0.00', '1000000.00', '7000.00', '5932.20', '7000.00', '0.00', NULL, '79.00', 'CENTIMETRE VERT F2-13928-1 [DOUZAINE]', NULL, 0, '2023-09-12 15:42:03', NULL, NULL),
(17, 17, 4, 1, '1.00', '5.00', '0.00', '1000000.00', '31000.00', '26271.19', '31000.00', '0.00', NULL, '5.00', 'COLLE TOP BOND 1KG [CARTON]', NULL, 0, '2023-09-12 15:42:03', NULL, NULL),
(18, 18, 4, 1, '1.00', '2.00', '0.00', '1000000.00', '66000.00', '55932.20', '66000.00', '0.00', NULL, '2.00', 'COUTEAU D\'ENDUIRE DE 16 [CARTON]', NULL, 0, '2023-09-12 15:42:03', NULL, NULL),
(19, 19, 5, 1, '1.00', '0.00', '0.00', '1000000.00', '3000.00', '2542.37', '3000.00', '0.00', NULL, '0.00', 'EQUERRE 10\"*12\" [DOUZAINE]', NULL, 0, '2023-09-12 15:42:03', '2023-09-21 15:21:40', NULL),
(20, 20, 5, 1, '1.00', '33.00', '0.00', '1000000.00', '4000.00', '3389.83', '4000.00', '0.00', NULL, '0.00', 'EQUERRE 12\"*14\" [DOUZAINE]', NULL, 0, '2023-09-12 15:42:03', '2023-09-21 15:21:41', NULL),
(21, 21, 3, 1, '1.00', '75.00', '0.00', '1000000.00', '14000.00', '11864.41', '14000.00', '0.00', NULL, '75.00', 'GRILLAGE FENETRE VITRIER 1M20 [ROULEAU]', NULL, 0, '2023-09-12 15:42:03', NULL, NULL),
(22, 22, 3, 1, '1.00', '26.00', '0.00', '1000000.00', '36000.00', '30508.47', '36000.00', '0.00', NULL, '26.00', 'GRILLAGE LAPIN 1M20 VERT [ROULEAU]', NULL, 0, '2023-09-12 15:42:03', NULL, NULL),
(23, 23, 3, 1, '1.00', '5.00', '0.00', '1000000.00', '46000.00', '38983.05', '46000.00', '0.00', NULL, '5.00', 'GRILLAGE LAPIN GALVANISÉ 25M ORIGINAL [ROULEAU]', NULL, 0, '2023-09-12 15:42:04', '2023-09-22 12:51:01', NULL),
(24, 24, 3, 1, '1.00', '50.00', '0.00', '1000000.00', '13500.00', '11440.68', '13500.00', '0.00', NULL, '58.00', 'GRILLAGE TAMI 1M20 [ROULEAU]', NULL, 0, '2023-09-12 15:42:04', '2023-09-15 18:33:37', NULL),
(25, 25, 3, 1, '1.00', '6.00', '0.00', '1000000.00', '38000.00', '32203.39', '38000.00', '0.00', NULL, '6.00', 'GRILLARGE POULLAILE 1M20 2DOIGT [ROULEAU]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(26, 26, 3, 1, '1.00', '1.00', '0.00', '1000000.00', '46000.00', '38983.05', '46000.00', '0.00', NULL, '1.00', 'GRILLARGE POULLAILE 1M20 1DOIGT [ROULEAU]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(27, 27, 4, 1, '1.00', '1.00', '0.00', '1000000.00', '23000.00', '19491.53', '23000.00', '0.00', NULL, '1.00', 'POINTE ACIER 10 [CARTON]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(28, 28, 4, 1, '1.00', '8.00', '0.00', '1000000.00', '23000.00', '19491.53', '23000.00', '0.00', NULL, '9.00', 'POINTE TAPICIER 1/2 [CARTON]', NULL, 0, '2023-09-12 15:42:04', '2023-09-15 18:30:18', NULL),
(29, 29, 4, 1, '1.00', '54.00', '0.00', '1000000.00', '23000.00', '19491.53', '23000.00', '0.00', NULL, '54.00', 'POINTE TAPICIER 3/4 [CARTON]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(30, 30, 4, 1, '1.00', '1.00', '0.00', '1000000.00', '23000.00', '19491.53', '23000.00', '0.00', NULL, '1.00', 'POINTE TAPICIER 5/8 [CARTON]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(31, 31, 4, 1, '1.00', '18.00', '0.00', '1000000.00', '47500.00', '40254.24', '47500.00', '0.00', NULL, '18.00', 'VERROU PAPILLON 40 [CARTON]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(32, 32, 4, 1, '1.00', '9.00', '0.00', '1000000.00', '49500.00', '41949.15', '49500.00', '0.00', NULL, '9.00', 'VERROU PAPILLON 50 [CARTON]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(33, 33, 4, 1, '1.00', '54.00', '0.00', '1000000.00', '70000.00', '59322.03', '70000.00', '0.00', NULL, '54.00', 'VICE DE RAPPEL 009CMECOC [CARTON]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(34, 34, 1, 1, '1.00', '18.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '18.00', 'AMPOULE GLOBE [UNITE]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(35, 35, 1, 1, '1.00', '47.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '47.00', 'ATTACHE DE 8 INGELEC [UNITE]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(36, 36, 1, 1, '1.00', '1000.00', '0.00', '1000000.00', '90.00', '76.27', '90.00', '0.00', NULL, '1000.00', 'BOITE D\'ENCARDREMENT INGELEC [UNITE]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(37, 37, 4, 1, '1.00', '3.00', '0.00', '1000000.00', '60000.00', '50847.46', '60000.00', '0.00', NULL, '3.00', 'BOUTON A POUSSOI ETANCHE ENCASTRE 5881/53 [CARTON]', NULL, 0, '2023-09-12 15:42:04', NULL, NULL),
(38, 38, 2, 1, '1.00', '160.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '160.00', 'CHEVILLE 10 [BOITE]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(39, 39, 2, 1, '1.00', '1.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '3.00', 'CHEVILLE 8 [BOITE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-21 11:18:05', NULL),
(40, 40, 4, 1, '1.00', '2.00', '0.00', '1000000.00', '42000.00', '35593.22', '42000.00', '0.00', NULL, '2.00', 'COMPTEUR INGELEC DDS 1531 [CARTON]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(41, 41, 4, 1, '1.00', '4.00', '0.00', '1000000.00', '75000.00', '63559.32', '75000.00', '0.00', NULL, '4.00', 'DOUBLE ETANCHE ENCASTRE 5882/20 [CARTON]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(42, 42, 4, 1, '1.00', '11.00', '0.00', '1000000.00', '75000.00', '63559.32', '75000.00', '0.00', NULL, '11.00', 'PRISE ETANCHE ENCASTRE 4886 [CARTON]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(43, 43, 3, 1, '1.00', '61.00', '0.00', '1000000.00', '110000.00', '93220.34', '110000.00', '0.00', NULL, '61.00', 'TUYAUX CUIVRE [ROULEAU]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(44, 44, 1, 1, '1.00', '8.00', '22000.00', '24000.00', '22000.00', '18644.07', '22000.00', '0.00', NULL, '23.00', 'VENTILATEUR CMC [UNITE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-15 11:20:47', NULL),
(45, 45, 1, 1, '1.00', '17.00', '22000.00', '240000.00', '22000.00', '18644.07', '22000.00', '0.00', NULL, '77.00', 'VENTILATEUR ITC [UNITE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-15 11:20:48', NULL),
(46, 46, 1, 1, '1.00', '30.00', '0.00', '1000000.00', '22000.00', '18644.07', '22000.00', '0.00', NULL, '90.00', 'VENTILATEUR PANASONIK [UNITE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-15 11:20:49', NULL),
(47, 47, 1, 1, '1.00', '45.00', '0.00', '1000000.00', '20000.00', '16949.15', '20000.00', '0.00', NULL, '135.00', 'VENTILATEUR SMC [UNITE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-15 11:20:48', NULL),
(48, 48, 6, 1, '1.00', '14.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '14.00', 'BOTTES POINTURE 41 [PAIRE]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(49, 49, 6, 1, '1.00', '45.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '75.00', 'BOTTES POINTURE 42 [PAIRE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-18 12:27:26', NULL),
(50, 50, 6, 1, '1.00', '1.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '31.00', 'BOTTES POINTURE 43 [PAIRE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-15 18:26:31', NULL),
(51, 51, 6, 1, '1.00', '75.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '90.00', 'BOTTES POINTURE 44 [PAIRE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-15 18:26:31', NULL),
(52, 52, 6, 1, '1.00', '105.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '120.00', 'BOTTES POINTURE 45 [PAIRE]', NULL, 0, '2023-09-12 15:42:05', '2023-09-18 12:27:26', NULL),
(53, 53, 6, 1, '1.00', '49.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '49.00', 'BOTTES POINTURE 47 [PAIRE]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(54, 54, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '20500.00', '17372.88', '20500.00', '0.00', NULL, '7.00', 'BROUETTES (au complet, avec tous accessoires) [UNITE]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(55, 55, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '1800.00', '1525.42', '1800.00', '0.00', NULL, '1.00', 'PERLES BLEU [UNITE]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(56, 56, 1, 1, '1.00', '83.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '83.00', 'PIEERRE À MELER 50/CT [UNITE]', NULL, 0, '2023-09-12 15:42:05', NULL, NULL),
(57, 57, 1, 1, '1.00', '413.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '413.00', 'PIERRE À COUPER 100/CT [UNITE]', NULL, 0, '2023-09-12 15:42:06', NULL, NULL),
(58, 58, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '30000.00', '25423.73', '30000.00', '0.00', NULL, '1.00', 'PIOCHE 2KILO [UNITE]', NULL, 0, '2023-09-12 15:42:06', NULL, NULL),
(59, 59, 1, 1, '1.00', '232.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '232.00', 'PUNEU BROUETTE [UNITE]', NULL, 0, '2023-09-12 15:42:06', '2023-09-22 13:39:41', NULL),
(60, 60, 3, 1, '1.00', '19.00', '0.00', '1000000.00', '17000.00', '14406.78', '17000.00', '0.00', NULL, '22.00', 'RACCORD D\'EAU BLANC [ROULEAU]', NULL, 0, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(61, 61, 3, 1, '1.00', '15.00', '0.00', '1000000.00', '17000.00', '14406.78', '17000.00', '0.00', NULL, '18.00', 'RACCORD D\'EAU JAUNE [ROULEAU]', NULL, 0, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(62, 62, 3, 1, '1.00', '1.00', '0.00', '1000000.00', '17000.00', '14406.78', '17000.00', '0.00', NULL, '5.00', 'RACCORD D\'EAU VERT [ROULEAU]', NULL, 0, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(63, 63, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '5000.00', '4237.29', '5000.00', '0.00', NULL, '1.00', 'ROBINET EVIER GOLD MIX [UNITE]', NULL, 0, '2023-09-12 15:42:06', '2023-09-21 11:18:09', NULL),
(64, 64, 1, 1, '1.00', '193.00', '0.00', '1000000.00', '6000.00', '5084.75', '6000.00', '0.00', NULL, '194.00', 'ABATTAN LOURD [UNITE]', NULL, 0, '2023-09-12 15:42:06', '2023-09-18 14:14:06', NULL),
(65, 65, 1, 1, '1.00', '12.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '26.00', 'ABATTAN PARMA  [UNITE]', NULL, 0, '2023-09-12 15:42:06', '2023-09-19 16:01:34', NULL),
(66, 66, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '30000.00', '25423.73', '30000.00', '0.00', NULL, '5.00', 'ABATTANT WC COMBINE J2-SC1770 [UNITE]', NULL, 0, '2023-09-12 15:42:06', NULL, NULL),
(67, 67, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '30000.00', '25423.73', '30000.00', '0.00', NULL, '5.00', 'ABATTANT WC COMBINE J2-SC1767 [UNITE]', NULL, 0, '2023-09-12 15:42:06', NULL, NULL),
(68, 68, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '11500.00', '9745.76', '11500.00', '0.00', NULL, '45.00', 'ACCESOIRE PARMA [UNITE]', NULL, 0, '2023-09-12 15:42:06', '2023-09-21 15:11:45', NULL),
(69, 69, 1, 1, '1.00', '20.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '20.00', 'BALLON FLOTTEUR NOIRE [UNITE]', NULL, 0, '2023-09-12 15:42:06', NULL, NULL),
(70, 70, 1, 1, '1.00', '15.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '15.00', 'BOMBONE À EAU [UNITE]', NULL, 0, '2023-09-12 15:42:06', NULL, NULL),
(71, 71, 1, 1, '1.00', '108.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '113.00', 'BONDE LAVABO FIRMER [UNITE]', NULL, 0, '2023-09-12 15:42:07', '2023-09-15 18:09:26', NULL),
(72, 72, 1, 1, '1.00', '80.00', '0.00', '1000000.00', '15000.00', '12711.86', '15000.00', '0.00', NULL, '80.00', 'BOUCHON FOSSES SEPTIQUES [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(73, 73, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '75.00', '63.56', '75.00', '0.00', NULL, '1.00', 'BOUCHON GALVA 15/21 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(74, 74, 1, 1, '1.00', '27055.00', '0.00', '1000000.00', '65.00', '55.08', '65.00', '0.00', NULL, '27067.00', 'BOUCHON GALVA 15/21 MALE [UNITE]', NULL, 0, '2023-09-12 15:42:07', '2023-09-20 16:45:11', NULL),
(75, 75, 1, 1, '1.00', '990.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '990.00', 'BOUCHON GALVA 20/27 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(76, 76, 1, 1, '1.00', '9.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '9.00', 'BOUCHON GALVA 20/27 MALE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(77, 77, 1, 1, '1.00', '2016.00', '0.00', '1000000.00', '200.00', '169.49', '200.00', '0.00', NULL, '2016.00', 'BOUCHON LAITON FEMELLE 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(78, 78, 1, 1, '1.00', '3295.00', '0.00', '1000000.00', '200.00', '169.49', '200.00', '0.00', NULL, '3295.00', 'BOUCHON LAITON MALE 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(79, 79, 1, 1, '1.00', '338.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '338.00', 'BOUCHON PPR 20 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(80, 80, 1, 1, '1.00', '2051.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '2051.00', 'BOUCHON PPR 20 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(81, 81, 1, 1, '1.00', '1383.00', '0.00', '1000000.00', '85.00', '72.03', '85.00', '0.00', NULL, '1383.00', 'BOUCHON PPR 25 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(82, 82, 1, 1, '1.00', '929.00', '0.00', '1000000.00', '85.00', '72.03', '85.00', '0.00', NULL, '929.00', 'BOUCHON PPR 25 MALE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(83, 83, 1, 1, '1.00', '9.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '9.00', 'BOUCHON PPR 32 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(84, 84, 1, 1, '1.00', '228.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '228.00', 'BOUCHON PPR 32 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:07', NULL, NULL),
(85, 85, 1, 1, '1.00', '14.00', '0.00', '1000000.00', '150.00', '127.12', '150.00', '0.00', NULL, '14.00', 'BOUCHON PPR 40 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(86, 86, 1, 1, '1.00', '258.00', '0.00', '1000000.00', '85.00', '72.03', '85.00', '0.00', NULL, '258.00', 'BOUCHON PRESSION 25 [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(87, 87, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '1.00', 'BOUCHON PRESSION 32 [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(88, 88, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '1.00', 'BOUCHON PVC  110 [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(89, 89, 1, 1, '1.00', '1799.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '1800.00', 'BOUCHON PVC 100 [UNITE]', NULL, 0, '2023-09-12 15:42:08', '2023-09-16 14:14:38', NULL),
(90, 90, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '900.00', '762.71', '900.00', '0.00', NULL, '1.00', 'BOUCHON PVC 125 [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(91, 91, 1, 1, '1.00', '162.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '162.00', 'BOUCHON PVC 200 [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(92, 92, 1, 1, '1.00', '344.00', '0.00', '1000000.00', '300.00', '254.24', '300.00', '0.00', NULL, '359.00', 'BOUCHON PVC 40 [UNITE]', NULL, 0, '2023-09-12 15:42:08', '2023-09-15 18:08:18', NULL),
(93, 93, 1, 1, '1.00', '-4.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '11.00', 'BOUCHON PVC 50 [UNITE]', NULL, 0, '2023-09-12 15:42:08', '2023-09-15 18:08:19', NULL),
(94, 94, 1, 1, '1.00', '1330.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '1350.00', 'BOUCHON PVC 75 [UNITE]', NULL, 0, '2023-09-12 15:42:08', '2023-09-15 18:30:56', NULL),
(95, 95, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '5.00', 'CHAPEAU CHINOIS 110 SC [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(96, 96, 1, 1, '1.00', '149.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '149.00', 'CHAPEAU CHINOIS 63 KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:08', NULL, NULL),
(97, 97, 1, 1, '1.00', '690.00', '0.00', '1000000.00', '900.00', '762.71', '900.00', '0.00', NULL, '690.00', 'CHAPEAU CHINOIS 75 SC [UNITE]', NULL, 0, '2023-09-12 15:42:09', NULL, NULL),
(98, 98, 1, 1, '1.00', '13.00', '0.00', '1000000.00', '6000.00', '5084.75', '6000.00', '0.00', NULL, '13.00', 'CHATAF INOX [UNITE]', NULL, 0, '2023-09-12 15:42:09', NULL, NULL),
(99, 99, 1, 1, '1.00', '6.00', '0.00', '1000000.00', '80000.00', '67796.61', '80000.00', '0.00', NULL, '7.00', 'CHAUFFE EAU MAXI 30L [UNITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-15 18:10:29', NULL),
(100, 100, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '65000.00', '55084.75', '65000.00', '0.00', NULL, '2.00', 'CHAUFFE-EAU MAXI 15L [UNITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-15 17:55:54', NULL),
(101, 101, 1, 1, '1.00', '13.00', '0.00', '1000000.00', '11500.00', '9745.76', '11500.00', '0.00', NULL, '13.00', 'CLAPET À MEMBRANE 2\" [UNITE]', NULL, 0, '2023-09-12 15:42:09', NULL, NULL),
(102, 102, 1, 1, '1.00', '29.00', '0.00', '1000000.00', '2200.00', '1864.41', '2200.00', '0.00', NULL, '29.00', 'CLAPET À MEMBRANE 3/4 (20/27) [UNITE]', NULL, 0, '2023-09-12 15:42:09', NULL, NULL),
(103, 103, 1, 1, '1.00', '24.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '34.00', 'CLAPET À RESSORT FIRMER 3/4 EN FER [UNITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-15 18:25:53', NULL),
(104, 104, 2, 1, '1.00', '26.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '28.00', 'COLLE TANGIT MEDIUM [BOITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-16 14:14:38', NULL),
(105, 105, 2, 1, '1.00', '68.00', '0.00', '1000000.00', '9000.00', '7627.12', '9000.00', '0.00', NULL, '68.00', 'COLLE TANGIT ORIGINAL 1KILO [BOITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-20 13:05:46', NULL),
(106, 106, 2, 1, '1.00', '7.00', '0.00', '1000000.00', '4800.00', '4067.80', '4800.00', '0.00', NULL, '10.00', 'COLLE VINKOGITE PVC-U 1KG [BOITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-21 11:18:06', NULL),
(107, 107, 1, 1, '1.00', '30.00', '0.00', '1000000.00', '4000.00', '3389.83', '4000.00', '0.00', NULL, '30.00', 'COLLIER ATELAS 64010-16 [UNITE]', NULL, 0, '2023-09-12 15:42:09', NULL, NULL),
(108, 108, 1, 1, '1.00', '56.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '66.00', 'COLLIER ATELAS 64010-25 [UNITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-15 18:29:03', NULL),
(109, 109, 1, 1, '1.00', '45.00', '0.00', '1000000.00', '6000.00', '5084.75', '6000.00', '0.00', NULL, '45.00', 'COLLIER ATELAS 64010-32 [UNITE]', NULL, 0, '2023-09-12 15:42:09', '2023-09-15 18:29:04', NULL),
(110, 110, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '7.00', 'COLLIER ATELAS 64010-40 [UNITE]', NULL, 0, '2023-09-12 15:42:10', NULL, NULL),
(111, 111, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '0.00', 'COLLIER GOUTTIERE [UNITE]', NULL, 0, '2023-09-12 15:42:10', '2023-09-15 17:59:09', NULL),
(112, 112, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '5.00', 'COLLIER INOX 100 [UNITE]', NULL, 0, '2023-09-12 15:42:10', NULL, NULL),
(113, 113, 1, 1, '1.00', '3460.00', '0.00', '1000000.00', '850.00', '720.34', '850.00', '0.00', NULL, '3510.00', 'COLLIER INOX 125 [UNITE]', NULL, 0, '2023-09-12 15:42:10', '2023-09-15 18:30:36', NULL),
(114, 114, 1, 1, '1.00', '448.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '463.00', 'COLLIER INOX 32 [UNITE]', NULL, 0, '2023-09-12 15:42:10', '2023-09-21 10:47:22', NULL),
(115, 115, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '5.00', 'COLLIER INOX 63 [UNITE]', NULL, 0, '2023-09-12 15:42:10', NULL, NULL),
(116, 116, 1, 1, '1.00', '2595.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '2595.00', 'COLLIER INOX 75 [UNITE]', NULL, 0, '2023-09-12 15:42:10', NULL, NULL),
(117, 117, 1, 1, '1.00', '94.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '94.00', 'COLLIER PPR 20 [UNITE]', NULL, 0, '2023-09-12 15:42:10', NULL, NULL),
(118, 118, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '75.00', '63.56', '75.00', '0.00', NULL, '1.00', 'COLLIER PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:10', NULL, NULL),
(119, 119, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '5.00', 'COLLIER PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:10', NULL, NULL),
(120, 120, 1, 1, '1.00', '10.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '10.00', 'COLLIER PVC  100 [UNITE]', NULL, 0, '2023-09-12 15:42:11', NULL, NULL),
(121, 121, 1, 1, '1.00', '734.00', '0.00', '1000000.00', '175.00', '148.31', '175.00', '0.00', NULL, '940.00', 'COLLIER PVC 75 [UNITE]', NULL, 0, '2023-09-12 15:42:11', '2023-09-15 18:32:21', NULL),
(122, 122, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '60000.00', '50847.46', '60000.00', '0.00', NULL, '6.00', 'COLONNE DE DOUCHE MITIGEUR MAAT [UNITE]', NULL, 0, '2023-09-12 15:42:11', '2023-09-20 16:45:14', NULL),
(123, 123, 1, 1, '1.00', '30.00', '0.00', '1000000.00', '1250.00', '1059.32', '1250.00', '0.00', NULL, '30.00', 'COLONNE FIXE ALLURE [UNITE]', NULL, 0, '2023-09-12 15:42:11', NULL, NULL),
(124, 124, 1, 1, '1.00', '3530.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '3687.00', 'COLONNE FIXE EN FER [UNITE]', NULL, 0, '2023-09-12 15:42:11', '2023-09-21 12:19:06', NULL),
(125, 125, 1, 1, '1.00', '2345.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '2375.00', 'COLONNE FIXE EN PLASTIC [UNITE]', NULL, 0, '2023-09-12 15:42:11', '2023-09-15 18:29:00', NULL),
(126, 126, 1, 1, '1.00', '20.00', '0.00', '1000000.00', '5000.00', '4237.29', '5000.00', '0.00', NULL, '20.00', 'COMPTEUR GALVA 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:11', NULL, NULL),
(127, 127, 1, 1, '1.00', '167.00', '0.00', '1000000.00', '9000.00', '7627.12', '9000.00', '0.00', NULL, '167.00', 'COMPTEUR GALVA 26/34 [UNITE]', NULL, 0, '2023-09-12 15:42:11', NULL, NULL),
(128, 128, 1, 1, '1.00', '45.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '45.00', 'COMPTEUR GALVA GRK 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:11', '2023-09-15 17:41:40', NULL),
(129, 129, 1, 1, '1.00', '338.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '338.00', 'COMPTEUR LAITON 20/27 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:11', '2023-09-19 08:43:45', NULL),
(130, 130, 1, 1, '1.00', '40.00', '0.00', '1000000.00', '7000.00', '5932.20', '7000.00', '0.00', NULL, '40.00', 'COMPTEUR YONSSO 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:11', NULL, NULL),
(131, 131, 1, 1, '1.00', '121.00', '0.00', '1000000.00', '14000.00', '11864.41', '14000.00', '0.00', NULL, '121.00', 'CONTROLEUR AUTOMATIQUE INTER DAB [UNITE]', NULL, 0, '2023-09-12 15:42:11', NULL, NULL),
(132, 132, 1, 1, '1.00', '23847.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '25127.00', 'COUDE LAITON 15/21 55GRM [UNITE]', NULL, 0, '2023-09-12 15:42:12', '2023-09-21 11:18:07', NULL),
(133, 133, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '550.00', '466.10', '550.00', '0.00', NULL, '1.00', 'COUDE LAITON 20/27 72GRAM [UNITE]', NULL, 0, '2023-09-12 15:42:12', NULL, NULL),
(134, 134, 1, 1, '1.00', '213.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '213.00', 'COUDE LAITON 26/34 [UNITE]', NULL, 0, '2023-09-12 15:42:12', '2023-09-15 18:21:19', NULL),
(135, 135, 1, 1, '1.00', '150.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '150.00', 'COUDE PE 25 [UNITE]', NULL, 0, '2023-09-12 15:42:12', NULL, NULL),
(136, 136, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '4.00', 'COUDE PE 32 [UNITE]', NULL, 0, '2023-09-12 15:42:12', NULL, NULL),
(137, 137, 1, 1, '1.00', '400.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '400.00', 'COUDE PPR 1/8 20 [UNITE]', NULL, 0, '2023-09-12 15:42:12', NULL, NULL),
(138, 138, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '4.00', 'COUDE PPR 1/8 25 [UNITE]', NULL, 0, '2023-09-12 15:42:12', NULL, NULL),
(139, 139, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '3.00', 'COUDE PPR 1/8 32 [UNITE]', NULL, 0, '2023-09-12 15:42:13', '2023-09-15 18:34:15', NULL),
(140, 140, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '2.00', 'COUDE PPR 20 [UNITE]', NULL, 0, '2023-09-12 15:42:13', NULL, NULL),
(141, 141, 1, 1, '1.00', '2070.00', '0.00', '1000000.00', '85.00', '72.03', '85.00', '0.00', NULL, '2140.00', 'COUDE PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:13', '2023-09-20 13:05:43', NULL),
(142, 142, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '13.00', 'COUDE PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:13', '2023-09-15 18:34:14', NULL),
(143, 143, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '4.00', 'COUDE PPR 40 [UNITE]', NULL, 0, '2023-09-12 15:42:13', '2023-09-15 18:34:12', NULL),
(144, 144, 1, 1, '1.00', '172.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '172.00', 'COUDE PPR 50 [UNITE]', NULL, 0, '2023-09-12 15:42:13', NULL, NULL),
(145, 145, 1, 1, '1.00', '1820.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1820.00', 'COUDE PPR TARODÉ 20*1/2 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:13', NULL, NULL),
(146, 146, 1, 1, '1.00', '1128.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1128.00', 'COUDE PPR TARODÉ 20*1/2 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:13', NULL, NULL),
(147, 147, 1, 1, '1.00', '711.00', '0.00', '1000000.00', '450.00', '381.36', '450.00', '0.00', NULL, '731.00', 'COUDE PPR TARODÉ 25*1/2 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:13', '2023-09-20 13:05:44', NULL),
(148, 148, 1, 1, '1.00', '105.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '105.00', 'COUDE PPR TARODÉ 25*3/4 MALE [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(149, 149, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '2.00', 'COUDE PPR TARODÉ 25*3/4F FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(150, 150, 1, 1, '1.00', '100.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '100.00', 'COUDE PPR TARODÉ 32*1\" FMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(151, 151, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '1.00', 'COUDE PPR TARODÉ 32*1/2 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(152, 152, 1, 1, '1.00', '75.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '75.00', 'COUDE PPR TARODÉ 32*3/4 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(153, 153, 1, 1, '1.00', '32.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '32.00', 'COUDE PPR TARODÉ 32*3/4 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(154, 154, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '450.00', '381.36', '450.00', '0.00', NULL, '2.00', 'COUDE PPR TRODÉ 25*1/2 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(155, 155, 1, 1, '1.00', '34.00', '0.00', '1000000.00', '5000.00', '4237.29', '5000.00', '0.00', NULL, '34.00', 'COUDE PRESSION 110 [UNITE]', NULL, 0, '2023-09-12 15:42:14', NULL, NULL),
(156, 156, 1, 1, '1.00', '3560.00', '0.00', '1000000.00', '95.00', '80.51', '95.00', '0.00', NULL, '3562.00', 'COUDE PRESSION 20 [UNITE]', NULL, 0, '2023-09-12 15:42:14', '2023-09-21 11:18:07', NULL),
(157, 157, 1, 1, '1.00', '21.00', '0.00', '1000000.00', '75.00', '63.56', '75.00', '0.00', NULL, '27.00', 'COUDE PRESSION 25 [UNITE]', NULL, 0, '2023-09-12 15:42:14', '2023-09-20 16:45:09', NULL),
(158, 158, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '1.00', 'COUDE PRESSION 32 [UNITE]', NULL, 0, '2023-09-12 15:42:15', NULL, NULL),
(159, 159, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '2.00', 'COUDE PRESSION 40 [UNITE]', NULL, 0, '2023-09-12 15:42:15', NULL, NULL),
(160, 160, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '10.00', 'COUDE PRESSION 50 [UNITE]', NULL, 0, '2023-09-12 15:42:15', '2023-09-20 16:45:05', NULL),
(161, 161, 1, 1, '1.00', '177.00', '0.00', '1000000.00', '1100.00', '932.20', '1100.00', '0.00', NULL, '192.00', 'COUDE PRESSION 63 [UNITE]', NULL, 0, '2023-09-12 15:42:15', '2023-09-15 18:02:58', NULL),
(162, 162, 1, 1, '1.00', '46.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '46.00', 'COUDE PRESSION 75 [UNITE]', NULL, 0, '2023-09-12 15:42:15', NULL, NULL),
(163, 163, 1, 1, '1.00', '62.00', '0.00', '1000000.00', '3000.00', '2542.37', '3000.00', '0.00', NULL, '62.00', 'COUDE PRESSION 90 [UNITE]', NULL, 0, '2023-09-12 15:42:15', NULL, NULL),
(164, 164, 1, 1, '1.00', '3195.00', '0.00', '1000000.00', '150.00', '127.12', '150.00', '0.00', NULL, '3195.00', 'COUDE PVC 1/4 32 [UNITE]', NULL, 0, '2023-09-12 15:42:15', '2023-09-20 13:05:46', NULL),
(165, 165, 1, 1, '1.00', '10304.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '10340.00', 'COUDE PVC 1/4 40 [UNITE]', NULL, 0, '2023-09-12 15:42:15', '2023-09-20 14:17:02', NULL),
(166, 166, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1.00', 'COUDE PVC 1/4 50 [UNITE]', NULL, 0, '2023-09-12 15:42:15', NULL, NULL),
(167, 167, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '300.00', '254.24', '300.00', '0.00', NULL, '2.00', 'COUDE PVC 1/8  50  [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(168, 168, 1, 1, '1.00', '592.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '592.00', 'COUDE PVC 1/8  63 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(169, 169, 1, 1, '1.00', '65.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '65.00', 'COUDE PVC 1/8 110 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(170, 170, 1, 1, '1.00', '71.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '71.00', 'COUDE PVC 1/8 125 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(171, 171, 1, 1, '1.00', '134.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '134.00', 'COUDE PVC 1/8 32 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(172, 172, 1, 1, '1.00', '157.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '157.00', 'DOS-DANE PPR 20 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(173, 173, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1.00', 'DOS-DANE PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(174, 174, 1, 1, '1.00', '16.00', '0.00', '1000000.00', '650.00', '550.85', '650.00', '0.00', NULL, '16.00', 'DOS-DANE PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(175, 175, 1, 1, '1.00', '81.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '81.00', 'ECARTEMENT 15/20 [UNITE]', NULL, 0, '2023-09-12 15:42:16', NULL, NULL),
(176, 176, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '2.00', 'ECROU 20/15 GRAND  [UNITE]', NULL, 0, '2023-09-12 15:42:17', NULL, NULL),
(177, 177, 1, 1, '1.00', '2741.00', '0.00', '1000000.00', '325.00', '275.42', '325.00', '0.00', NULL, '2941.00', 'ECROU 20/15 MOYEN [UNITE]', NULL, 0, '2023-09-12 15:42:17', '2023-09-21 08:49:00', NULL),
(178, 178, 1, 1, '1.00', '224.00', '0.00', '1000000.00', '1200.00', '1016.95', '1200.00', '0.00', NULL, '224.00', 'ECROU COMPTEUR 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:17', '2023-09-15 17:57:18', NULL),
(179, 179, 1, 1, '1.00', '26.00', '0.00', '1000000.00', '1400.00', '1186.44', '1400.00', '0.00', NULL, '26.00', 'ECROU COMPTEUR 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:17', '2023-09-15 17:57:18', NULL),
(180, 180, 1, 1, '1.00', '219.00', '0.00', '1000000.00', '4200.00', '3559.32', '4200.00', '0.00', NULL, '219.00', 'ECROU COMPTEUR 26/34 [UNITE]', NULL, 0, '2023-09-12 15:42:17', NULL, NULL),
(181, 181, 1, 1, '1.00', '17760.00', '0.00', '1000000.00', '215.00', '182.20', '215.00', '0.00', NULL, '23118.00', 'ECROU LAITON 15/15 [UNITE]', NULL, 0, '2023-09-12 15:42:17', '2023-09-21 08:49:03', NULL),
(182, 182, 1, 1, '1.00', '14934.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '17135.00', 'ECROU LAITON 15/15 A BAGUE [UNITE]', NULL, 0, '2023-09-12 15:42:17', '2023-09-21 11:18:03', NULL),
(183, 183, 1, 1, '1.00', '1611.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '1611.00', 'ECROU LAITON 15/15 KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:17', NULL, NULL),
(184, 184, 1, 1, '1.00', '1879.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '1879.00', 'ECROU LAITON 26/20 [UNITE]', NULL, 0, '2023-09-12 15:42:17', '2023-09-15 18:21:21', NULL),
(185, 185, 1, 1, '1.00', '4299.00', '0.00', '1000000.00', '200.00', '169.49', '200.00', '0.00', NULL, '4424.00', 'ECROU LAITON REDUIT 12/12 [UNITE]', NULL, 0, '2023-09-12 15:42:18', '2023-09-19 10:10:41', NULL),
(186, 186, 1, 1, '1.00', '5779.00', '0.00', '1000000.00', '225.00', '190.68', '225.00', '0.00', NULL, '5987.00', 'ECROU LAITON REDUIT 15/12 [UNITE]', NULL, 0, '2023-09-12 15:42:18', '2023-09-20 14:17:01', NULL),
(187, 187, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '200.00', '169.49', '200.00', '0.00', NULL, '5.00', 'ECROU MIX 12/17 [UNITE]', NULL, 0, '2023-09-12 15:42:18', NULL, NULL),
(188, 188, 1, 1, '1.00', '47.00', '0.00', '1000000.00', '225.00', '190.68', '225.00', '0.00', NULL, '51.00', 'ECROU MIX 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:18', '2023-09-15 18:10:30', NULL),
(189, 189, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '3.00', 'ECROU RALLONGE LAITON 1/2*30M [UNITE]', NULL, 0, '2023-09-12 15:42:18', '2023-09-21 11:18:10', NULL),
(190, 190, 1, 1, '1.00', '1206.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '1206.00', 'EMBOUT À CHAUD [UNITE]', NULL, 0, '2023-09-12 15:42:18', NULL, NULL),
(191, 191, 1, 1, '1.00', '1184.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1184.00', 'EMBOUT PPR TARODÉ 20*1/2 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:18', NULL, NULL),
(192, 192, 1, 1, '1.00', '1059.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1059.00', 'EMBOUT PPR TARODÉ 20*1/2 MALE [UNITE]', NULL, 0, '2023-09-12 15:42:18', NULL, NULL),
(193, 193, 1, 1, '1.00', '1339.00', '0.00', '1000000.00', '450.00', '381.36', '450.00', '0.00', NULL, '1339.00', 'EMBOUT PPR TARODÉ 25*1/2 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:18', NULL, NULL),
(194, 194, 1, 1, '1.00', '6541.00', '0.00', '1000000.00', '450.00', '381.36', '450.00', '0.00', NULL, '6559.00', 'EMBOUT PPR TARODÉ 25*1/2 MALE [UNITE]', NULL, 0, '2023-09-12 15:42:19', '2023-09-20 13:05:44', NULL),
(195, 195, 1, 1, '1.00', '10.00', '0.00', '1000000.00', '550.00', '466.10', '550.00', '0.00', NULL, '10.00', 'EMBOUT PPR TARODÉ 25*3/4 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:19', NULL, NULL),
(196, 196, 1, 1, '1.00', '3486.00', '0.00', '1000000.00', '550.00', '466.10', '550.00', '0.00', NULL, '3494.00', 'EMBOUT PPR TARODÉ 25*3/4 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:19', '2023-09-16 14:14:33', NULL),
(197, 197, 1, 1, '1.00', '253.00', '0.00', '1000000.00', '900.00', '762.71', '900.00', '0.00', NULL, '253.00', 'EMBOUT PPR TARODÉ 32*1\" FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:19', '2023-09-15 18:12:52', NULL),
(198, 198, 1, 1, '1.00', '148.00', '0.00', '1000000.00', '900.00', '762.71', '900.00', '0.00', NULL, '150.00', 'EMBOUT PPR TARODÉ 32*1\" MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:19', '2023-09-16 14:14:37', NULL),
(199, 199, 1, 1, '1.00', '189.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '189.00', 'EMBOUT PPR TARODÉ 32*1/2 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:19', NULL, NULL),
(200, 200, 1, 1, '1.00', '96.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '96.00', 'EMBOUT PPR TARODÉ 32*1/2 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:19', NULL, NULL),
(201, 201, 1, 1, '1.00', '172.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '172.00', 'EMBOUT PPR TARODÉ 32*3/4 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:19', NULL, NULL),
(202, 202, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '1.00', 'EMBOUT PPR TARODÉ 40*1\" FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:20', NULL, NULL),
(203, 203, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '1.00', 'EMBOUT PPR TARODÉ 40*1\" MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:20', NULL, NULL),
(204, 204, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1.00', 'EMBOUT PRESSION  40 [UNITE]', NULL, 0, '2023-09-12 15:42:20', NULL, NULL),
(205, 205, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '0.00', 'EMBOUT PRESSION 20 [UNITE]', NULL, 0, '2023-09-12 15:42:20', '2023-09-15 18:25:13', NULL),
(206, 206, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '4.00', 'EMBOUT PRESSION 25 [UNITE]', NULL, 0, '2023-09-12 15:42:20', NULL, NULL),
(207, 207, 1, 1, '1.00', '42.00', '0.00', '1000000.00', '1250.00', '1059.32', '1250.00', '0.00', NULL, '54.00', 'EMBOUT PRESSION 32 [UNITE]', NULL, 0, '2023-09-12 15:42:20', '2023-09-20 16:45:08', NULL),
(208, 208, 1, 1, '1.00', '12.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '12.00', 'EMBOUT PRESSION 50 [UNITE]', NULL, 0, '2023-09-12 15:42:20', '2023-09-15 17:45:58', NULL),
(209, 209, 1, 1, '1.00', '350.00', '0.00', '1000000.00', '1100.00', '932.20', '1100.00', '0.00', NULL, '350.00', 'EMBOUT PRESSION 63 [UNITE]', NULL, 0, '2023-09-12 15:42:20', '2023-09-15 17:45:59', NULL),
(210, 210, 1, 1, '1.00', '196.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '196.00', 'EVIER 1BAC [UNITE]', NULL, 0, '2023-09-12 15:42:21', NULL, NULL),
(211, 211, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '11500.00', '9745.76', '11500.00', '0.00', NULL, '5.00', 'EVIER 2BAC [UNITE]', NULL, 0, '2023-09-12 15:42:21', '2023-09-21 11:18:10', NULL),
(212, 212, 1, 1, '1.00', '9.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '10.00', 'FILTRE À EAU 32 [UNITE]', NULL, 0, '2023-09-12 15:42:21', '2023-09-20 11:07:41', NULL),
(213, 213, 1, 1, '1.00', '1819.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '1969.00', 'FLEXIBLE INOX LAVABO EN FER [UNITE]', NULL, 0, '2023-09-12 15:42:21', '2023-09-21 16:16:34', NULL),
(214, 214, 1, 1, '1.00', '42.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '42.00', 'FLEXIBLE INOX LAVABO EN PVC [UNITE]', NULL, 0, '2023-09-12 15:42:21', '2023-09-15 17:35:50', NULL),
(215, 215, 1, 1, '1.00', '1421.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '1574.00', 'FLEXIBLE INOX WC EN FER [UNITE]', NULL, 0, '2023-09-12 15:42:21', '2023-09-21 12:19:05', NULL),
(216, 216, 1, 1, '1.00', '169.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '369.00', 'FLEXIBLE  WC EN PVC [UNITE]', NULL, 0, '2023-09-12 15:42:21', '2023-09-15 18:23:52', NULL),
(217, 217, 1, 1, '1.00', '208.00', '0.00', '1000000.00', '750.00', '635.59', '750.00', '0.00', NULL, '208.00', 'FLEXIBLE LAVABO FIRMER [UNITE]', NULL, 0, '2023-09-12 15:42:21', '2023-09-21 12:19:04', NULL),
(218, 218, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '1.00', 'FLEXIBLE MITIGEUR EN FER ALEXMIX [UNITE]', NULL, 0, '2023-09-12 15:42:21', NULL, NULL),
(219, 219, 1, 1, '1.00', '112.00', '0.00', '1000000.00', '750.00', '635.59', '750.00', '0.00', NULL, '112.00', 'FLEXIBLE WC FIRMER [UNITE]', NULL, 0, '2023-09-12 15:42:22', '2023-09-21 12:19:05', NULL),
(220, 220, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2800.00', '2372.88', '2800.00', '0.00', NULL, '1.00', 'FLOTTEUR ELECTRIQUE [UNITE]', NULL, 0, '2023-09-12 15:42:22', NULL, NULL),
(221, 221, 1, 1, '1.00', '27.00', '0.00', '1000000.00', '5000.00', '4237.29', '5000.00', '0.00', NULL, '27.00', 'FLOTTEUR THANK CHROMÉ [UNITE]', NULL, 0, '2023-09-12 15:42:22', NULL, NULL),
(222, 222, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '2.00', 'FLOTTEUR WC MPMP 63813 [UNITE]', NULL, 0, '2023-09-12 15:42:22', '2023-09-15 18:27:15', NULL),
(223, 223, 1, 1, '1.00', '78.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '197.00', 'FOND GOUTTIERE  [UNITE]', NULL, 0, '2023-09-12 15:42:22', '2023-09-15 18:26:53', NULL),
(224, 224, 1, 1, '1.00', '1594.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1694.00', 'FOND NAISSANCE [UNITE]', NULL, 0, '2023-09-12 15:42:22', '2023-09-15 18:26:53', NULL),
(225, 225, 1, 1, '1.00', '42.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '114.00', 'GEBADJOINT [UNITE]', NULL, 0, '2023-09-12 15:42:22', '2023-09-21 08:49:04', NULL),
(226, 226, 1, 1, '1.00', '523.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '527.00', 'GOURGEON LAVABO GRAND [UNITE]', NULL, 0, '2023-09-12 15:42:22', '2023-09-20 14:17:00', NULL),
(227, 227, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '4.00', 'GOURGEON LAVABO MOYEN [UNITE]', NULL, 0, '2023-09-12 15:42:23', NULL, NULL),
(228, 228, 7, 1, '1.00', '170.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '170.00', 'JOINT 12-17 [SACHET]', NULL, 0, '2023-09-12 15:42:23', NULL, NULL),
(229, 229, 7, 1, '1.00', '377.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '377.00', 'JOINT 15/21 [SACHET]', NULL, 0, '2023-09-12 15:42:23', NULL, NULL),
(230, 230, 7, 1, '1.00', '254.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '254.00', 'JOINT 20/27 [SACHET]', NULL, 0, '2023-09-12 15:42:23', NULL, NULL),
(231, 231, 1, 1, '1.00', '496.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '611.00', 'JONCTION GOTTIERE [UNITE]', NULL, 0, '2023-09-12 15:42:23', '2023-09-15 18:26:52', NULL),
(232, 232, 1, 1, '1.00', '258.00', '0.00', '1000000.00', '35000.00', '29661.02', '35000.00', '0.00', NULL, '258.00', 'LAVABO LIMA LUXE [UNITE]', NULL, 0, '2023-09-12 15:42:23', '2023-09-15 17:58:01', NULL),
(233, 233, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '115000.00', '97457.63', '115000.00', '0.00', NULL, '7.00', 'LAVABA SUSPENDU BESILE CARRE I-2638 [UNITE]', NULL, 0, '2023-09-12 15:42:23', NULL, NULL),
(234, 234, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '110000.00', '93220.34', '110000.00', '0.00', NULL, '3.00', 'LAVABA SUSPENDU BESILE ROND I-2628 [UNITE]', NULL, 0, '2023-09-12 15:42:23', NULL, NULL),
(235, 235, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '120000.00', '101694.92', '120000.00', '0.00', NULL, '3.00', 'LAVABO SUSPENDU BESILE NOIR I-2742 [UNITE]', NULL, 0, '2023-09-12 15:42:24', NULL, NULL),
(236, 236, 1, 1, '1.00', '190.00', '0.00', '1000000.00', '7000.00', '5932.20', '7000.00', '0.00', NULL, '190.00', 'LAVE MAIN PARMA [UNITE]', NULL, 0, '2023-09-12 15:42:24', '2023-09-18 12:27:45', NULL),
(237, 237, 1, 1, '1.00', '18.00', '0.00', '1000000.00', '25000.00', '21186.44', '25000.00', '0.00', NULL, '18.00', 'MACHINE PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:24', NULL, NULL),
(238, 238, 1, 1, '1.00', '18071.00', '0.00', '1000000.00', '215.00', '182.20', '215.00', '0.00', NULL, '19095.00', 'MAMELON LAITON 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:24', '2023-09-20 14:17:04', NULL),
(239, 239, 1, 1, '1.00', '902.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '902.00', 'MAMELON LAITON 26/34 [UNITE]', NULL, 0, '2023-09-12 15:42:24', NULL, NULL),
(240, 240, 1, 1, '1.00', '1389.00', '0.00', '1000000.00', '650.00', '550.85', '650.00', '0.00', NULL, '1389.00', 'MAMELON LATON 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:24', NULL, NULL),
(241, 241, 1, 1, '1.00', '3430.00', '0.00', '1000000.00', '200.00', '169.49', '200.00', '0.00', NULL, '3430.00', 'MAMELON RÉDUIT 62902-1/2*3/4L [UNITE]', NULL, 0, '2023-09-12 15:42:24', '2023-09-19 10:10:41', NULL),
(242, 242, 1, 1, '1.00', '102.00', '0.00', '1000000.00', '300.00', '254.24', '300.00', '0.00', NULL, '102.00', 'MANCHON À CHAUD [UNITE]', NULL, 0, '2023-09-12 15:42:24', NULL, NULL),
(243, 243, 1, 1, '1.00', '4037.00', '0.00', '1000000.00', '300.00', '254.24', '300.00', '0.00', NULL, '4288.00', 'MANCHON LAITON 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:25', '2023-09-21 08:49:03', NULL),
(244, 244, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '1.00', 'MANCHON LAITON 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:25', NULL, NULL),
(245, 245, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '4.00', 'MANCHON LAITON 26/34 [UNITE]', NULL, 0, '2023-09-12 15:42:25', '2023-09-15 18:21:19', NULL),
(246, 246, 1, 1, '1.00', '206.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '206.00', 'MANCHON PE 32 [UNITE]', NULL, 0, '2023-09-12 15:42:25', NULL, NULL),
(247, 247, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '1.00', 'MANCHON PE 40 [UNITE]', NULL, 0, '2023-09-12 15:42:25', NULL, NULL),
(248, 248, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2800.00', '2372.88', '2800.00', '0.00', NULL, '1.00', 'MANCHON PE 50 [UNITE]', NULL, 0, '2023-09-12 15:42:25', NULL, NULL),
(249, 249, 1, 1, '1.00', '29.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '29.00', 'MANCHON PPR 20 [UNITE]', NULL, 0, '2023-09-12 15:42:25', NULL, NULL),
(250, 250, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '70.00', '59.32', '70.00', '0.00', NULL, '3.00', 'MANCHON PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:25', NULL, NULL),
(251, 251, 1, 1, '1.00', '9.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '9.00', 'MANCHON PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:26', NULL, NULL),
(252, 252, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '2.00', 'MANCHON PPR 40 [UNITE]', NULL, 0, '2023-09-12 15:42:26', NULL, NULL),
(253, 253, 1, 1, '1.00', '12.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '12.00', 'MANCHON PPR 50 [UNITE]', NULL, 0, '2023-09-12 15:42:26', NULL, NULL),
(254, 254, 1, 1, '1.00', '2616.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '2616.00', 'MANCHON PRESSION 20 [UNITE]', NULL, 0, '2023-09-12 15:42:26', NULL, NULL),
(255, 255, 1, 1, '1.00', '453.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '453.00', 'MANCHON PRESSION 25 [UNITE]', NULL, 0, '2023-09-12 15:42:26', '2023-09-18 12:27:59', NULL),
(256, 256, 1, 1, '1.00', '13.00', '0.00', '1000000.00', '110.00', '93.22', '110.00', '0.00', NULL, '13.00', 'MANCHON PRESSION 32 [UNITE]', NULL, 0, '2023-09-12 15:42:26', NULL, NULL),
(257, 257, 1, 1, '1.00', '159.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '159.00', 'MANCHON PRESSION 50 [UNITE]', NULL, 0, '2023-09-12 15:42:26', NULL, NULL);
INSERT INTO `produit_conditionnement` (`id`, `produit_id`, `conditionnement_id`, `point_vente_id`, `qte_cond`, `qte_stock_cond`, `prix_min`, `prix_max`, `prix_de_vente`, `prix_de_vente_ht`, `prix_de_vente_ttc`, `cump`, `stock_init`, `qte_stock_cond_logique`, `nom_pro_cond`, `est_sup`, `est_unite_base`, `created_at`, `updated_at`, `deleted_at`) VALUES
(258, 258, 1, 1, '1.00', '10.00', '0.00', '1000000.00', '1600.00', '1355.93', '1600.00', '0.00', NULL, '10.00', 'MÉCANISME À TIRETTE MPMP WK13151 [UNITE]', NULL, 0, '2023-09-12 15:42:27', NULL, NULL),
(259, 259, 1, 1, '1.00', '9.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '9.00', 'MECANISME GOLF À DOUBLE POUSSOIRE [UNITE]', NULL, 0, '2023-09-12 15:42:27', NULL, NULL),
(260, 260, 1, 1, '1.00', '308.00', '0.00', '1000000.00', '3200.00', '2711.86', '3200.00', '0.00', NULL, '376.00', 'MÉCANISME GOLF À POUSSOI [UNITE]', NULL, 0, '2023-09-12 15:42:27', '2023-09-19 11:55:05', NULL),
(261, 261, 1, 1, '1.00', '865.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '875.00', 'MECANISME PARMA [UNITE]', NULL, 0, '2023-09-12 15:42:27', '2023-09-15 18:29:02', NULL),
(262, 262, 1, 1, '1.00', '15.00', '0.00', '1000000.00', '10000.00', '8474.58', '10000.00', '0.00', NULL, '15.00', 'MECANISME WC COMBINE J2-YFS [UNITE]', NULL, 0, '2023-09-12 15:42:27', NULL, NULL),
(263, 263, 1, 1, '1.00', '69.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '96.00', 'MIROIRE WT-2 [UNITE]', NULL, 0, '2023-09-12 15:42:27', '2023-09-21 08:49:02', NULL),
(264, 264, 1, 1, '1.00', '14.00', '0.00', '1000000.00', '20000.00', '16949.15', '20000.00', '0.00', NULL, '16.00', 'MITIGEUR DOUCHE FIRMER SP22040001 [UNITE]', NULL, 0, '2023-09-12 15:42:27', '2023-09-15 18:15:20', NULL),
(265, 265, 1, 1, '1.00', '646.00', '0.00', '1000000.00', '1650.00', '1398.31', '1650.00', '0.00', NULL, '656.00', 'NAISSANCE [UNITE]', NULL, 0, '2023-09-12 15:42:28', '2023-09-15 18:25:52', NULL),
(266, 266, 1, 1, '1.00', '1093.00', '0.00', '1000000.00', '650.00', '550.85', '650.00', '0.00', NULL, '1171.00', 'PATE À GLACE [UNITE]', NULL, 0, '2023-09-12 15:42:28', '2023-09-20 16:45:17', NULL),
(267, 267, 7, 1, '1.00', '56.00', '0.00', '1000000.00', '3000.00', '2542.37', '3000.00', '0.00', NULL, '56.00', 'PATIN 15/21 [SACHET]', NULL, 0, '2023-09-12 15:42:28', '2023-09-15 17:58:00', NULL),
(268, 268, 7, 1, '1.00', '58.00', '0.00', '1000000.00', '4000.00', '3389.83', '4000.00', '0.00', NULL, '58.00', 'PATIN 20/27 [SACHET]', NULL, 0, '2023-09-12 15:42:28', NULL, NULL),
(269, 269, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '65000.00', '55084.75', '65000.00', '0.00', NULL, '1.00', 'POMPE EMERGE INTER DAB 0.75 [UNITE]', NULL, 0, '2023-09-12 15:42:28', NULL, NULL),
(270, 270, 1, 1, '1.00', '143.00', '0.00', '1000000.00', '1100.00', '932.20', '1100.00', '0.00', NULL, '143.00', 'PORT PAPIER KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:28', NULL, NULL),
(271, 271, 1, 1, '1.00', '390.00', '0.00', '1000000.00', '1100.00', '932.20', '1100.00', '0.00', NULL, '340.00', 'PORT PAPIER SC [UNITE]', NULL, 0, '2023-09-12 15:42:29', '2023-09-22 16:00:48', NULL),
(272, 272, 1, 1, '1.00', '597.00', '0.00', '1000000.00', '1100.00', '932.20', '1100.00', '0.00', NULL, '597.00', 'PORT SAVON LY7704 KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:29', '2023-09-15 17:43:56', NULL),
(273, 273, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '5.00', 'PORT SAVON SC GEDEYA [UNITE]', NULL, 0, '2023-09-12 15:42:29', NULL, NULL),
(274, 274, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '1.00', 'PORT SERVIETTE EN FER [UNITE]', NULL, 0, '2023-09-12 15:42:29', NULL, NULL),
(275, 275, 1, 1, '1.00', '13.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '13.00', 'PORT SERVIETTE LY7701 KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:29', NULL, NULL),
(276, 276, 1, 1, '1.00', '165.00', '0.00', '1000000.00', '1300.00', '1101.69', '1300.00', '0.00', NULL, '165.00', 'PORT SERVIETTE PLASTIQUE GDY60701 [UNITE]', NULL, 0, '2023-09-12 15:42:29', '2023-09-15 18:17:05', NULL),
(277, 277, 3, 1, '1.00', '106.00', '0.00', '1000000.00', '1600.00', '1355.93', '1600.00', '0.00', NULL, '112.00', 'POUPEE FILASS 2 [ROULEAU]', NULL, 0, '2023-09-12 15:42:30', '2023-09-20 16:45:07', NULL),
(278, 278, 1, 1, '1.00', '10.00', '0.00', '1000000.00', '1850.00', '1567.80', '1850.00', '0.00', NULL, '10.00', 'PUISSAGE KMEI LY303 1/2 [UNITE]', NULL, 0, '2023-09-12 15:42:30', '2023-09-19 08:43:46', NULL),
(279, 279, 1, 1, '1.00', '60.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '60.00', 'QUEUE DE CAP [UNITE]', NULL, 0, '2023-09-12 15:42:30', NULL, NULL),
(280, 280, 1, 1, '1.00', '332.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '332.00', 'RACCORD ANNULE [UNITE]', NULL, 0, '2023-09-12 15:42:30', NULL, NULL),
(281, 281, 1, 1, '1.00', '417.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '417.00', 'RACCORD UNION PPR 20 [UNITE]', NULL, 0, '2023-09-12 15:42:30', NULL, NULL),
(282, 282, 1, 1, '1.00', '8.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '15.00', 'RACCORD UNION PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:30', '2023-09-16 14:14:34', NULL),
(283, 283, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '1.00', 'RACCORD UNION PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:31', '2023-09-16 14:14:36', NULL),
(284, 284, 1, 1, '1.00', '215.00', '0.00', '1000000.00', '800.00', '677.97', '800.00', '0.00', NULL, '215.00', 'RACCORD UNION PPR 40 [UNITE]', NULL, 0, '2023-09-12 15:42:31', NULL, NULL),
(285, 285, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '1.00', 'RACCORD UNION PRESSION 20 [UNITE]', NULL, 0, '2023-09-12 15:42:31', NULL, NULL),
(286, 286, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '7.00', 'RACCORD UNION PRESSION 25 [UNITE]', NULL, 0, '2023-09-12 15:42:31', '2023-09-15 17:45:57', NULL),
(287, 287, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '5.00', 'RÉDUCTEUR PPR 25*20 [UNITE]', NULL, 0, '2023-09-12 15:42:31', NULL, NULL),
(288, 288, 1, 1, '1.00', '425.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '425.00', 'RÉDUCTEUR PPR 32*20 [UNITE]', NULL, 0, '2023-09-12 15:42:31', NULL, NULL),
(289, 289, 1, 1, '1.00', '1169.00', '0.00', '1000000.00', '150.00', '127.12', '150.00', '0.00', NULL, '1192.00', 'RÉDUCTEUR PPR 32*25 [UNITE]', NULL, 0, '2023-09-12 15:42:31', '2023-09-20 13:01:19', NULL),
(290, 290, 1, 1, '1.00', '157.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '165.00', 'RÉDUCTEUR PPR 40*32 [UNITE]', NULL, 0, '2023-09-12 15:42:32', '2023-09-16 14:14:36', NULL),
(291, 291, 1, 1, '1.00', '74.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '82.00', 'RÉDUCTEUR PPR 50*32 [UNITE]', NULL, 0, '2023-09-12 15:42:32', '2023-09-20 13:01:19', NULL),
(292, 292, 1, 1, '1.00', '150.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '150.00', 'REDUCTEUR PRESSION  63/50 [UNITE]', NULL, 0, '2023-09-12 15:42:32', NULL, NULL),
(293, 293, 1, 1, '1.00', '1108.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '1111.00', 'RÉDUCTEUR PRESSION 25*20 [UNITE]', NULL, 0, '2023-09-12 15:42:32', '2023-09-20 16:45:11', NULL),
(294, 294, 1, 1, '1.00', '467.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '471.00', 'RÉDUCTEUR PRESSION 32/25 [UNITE]', NULL, 0, '2023-09-12 15:42:32', '2023-09-20 16:45:07', NULL),
(295, 295, 1, 1, '1.00', '27.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '32.00', 'RÉDUCTEUR PRESSION 40*32 [UNITE]', NULL, 0, '2023-09-12 15:42:32', '2023-09-15 18:09:28', NULL),
(296, 296, 1, 1, '1.00', '346.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '400.00', 'REDUCTEUR PRESSION 50/32 [UNITE]', NULL, 0, '2023-09-12 15:42:32', '2023-09-20 16:45:06', NULL),
(297, 297, 1, 1, '1.00', '398.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '398.00', 'RÉDUCTEUR PVC 40/32 [UNITE]', NULL, 0, '2023-09-12 15:42:33', NULL, NULL),
(298, 298, 1, 1, '1.00', '4250.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '4250.00', 'RÉDUCTEUR PVC PLAT 100/32 [UNITE]', NULL, 0, '2023-09-12 15:42:33', '2023-09-20 13:05:45', NULL),
(299, 299, 1, 1, '1.00', '2195.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '2200.00', 'RÉDUCTEUR PVC PLAT 100/40 [UNITE]', NULL, 0, '2023-09-12 15:42:33', '2023-09-20 14:16:56', NULL),
(300, 300, 1, 1, '1.00', '114.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '114.00', 'RÉDUCTEUR PVC PLAT 100/63 [UNITE]', NULL, 0, '2023-09-12 15:42:33', NULL, NULL),
(301, 301, 1, 1, '1.00', '3932.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '3932.00', 'RÉDUCTEUR PVC PLAT 100/75 [UNITE]', NULL, 0, '2023-09-12 15:42:33', '2023-09-15 17:53:45', NULL),
(302, 302, 1, 1, '1.00', '395.00', '0.00', '1000000.00', '850.00', '720.34', '850.00', '0.00', NULL, '395.00', 'RÉDUCTEUR PVC PLAT 110/100 [UNITE]', NULL, 0, '2023-09-12 15:42:33', '2023-09-15 18:26:13', NULL),
(303, 303, 1, 1, '1.00', '291.00', '0.00', '1000000.00', '650.00', '550.85', '650.00', '0.00', NULL, '291.00', 'RÉDUCTEUR PVC PLAT 110/32 [UNITE]', NULL, 0, '2023-09-12 15:42:33', NULL, NULL),
(304, 304, 1, 1, '1.00', '45.00', '0.00', '1000000.00', '650.00', '550.85', '650.00', '0.00', NULL, '45.00', 'RÉDUCTEUR PVC PLAT 110/75 [UNITE]', NULL, 0, '2023-09-12 15:42:34', NULL, NULL),
(305, 305, 1, 1, '1.00', '118.00', '0.00', '1000000.00', '900.00', '762.71', '900.00', '0.00', NULL, '128.00', 'RÉDUCTEUR PVC PLAT 125/100 [UNITE]', NULL, 0, '2023-09-12 15:42:34', '2023-09-15 17:47:34', NULL),
(306, 306, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '2.00', 'RÉDUCTEUR PVC PLAT 125/110 [UNITE]', NULL, 0, '2023-09-12 15:42:34', NULL, NULL),
(307, 307, 1, 1, '1.00', '99.00', '0.00', '1000000.00', '1800.00', '1525.42', '1800.00', '0.00', NULL, '99.00', 'RÉDUCTEUR PVC PLAT 160*110 KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:34', NULL, NULL),
(308, 308, 1, 1, '1.00', '230.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '230.00', 'RÉDUCTEUR PVC PLAT 75/32 [UNITE]', NULL, 0, '2023-09-12 15:42:34', NULL, NULL),
(309, 309, 1, 1, '1.00', '498.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '499.00', 'RÉDUCTEUR PVC PLAT 75/40 [UNITE]', NULL, 0, '2023-09-12 15:42:34', '2023-09-20 14:16:57', NULL),
(310, 310, 1, 1, '1.00', '32.00', '0.00', '1000000.00', '250.00', '211.86', '250.00', '0.00', NULL, '32.00', 'RÉDUCTEUR PVC PLAT 75/50 [UNITE]', NULL, 0, '2023-09-12 15:42:34', NULL, NULL),
(311, 311, 1, 1, '1.00', '7504.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '7816.00', 'ROBINET D\'ARRET 15/21 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:35', '2023-09-21 11:18:08', NULL),
(312, 312, 1, 1, '1.00', '350.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '350.00', 'ROBINET D\'ARRET GRK 26/34 [UNITE]', NULL, 0, '2023-09-12 15:42:35', '2023-09-15 18:20:42', NULL),
(313, 313, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '0.00', 'ROBINET D\'ARRETE 20/27 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:35', '2023-09-15 17:47:04', NULL),
(314, 314, 1, 1, '1.00', '448.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '465.00', 'ROBINET DE DOUCHE 8901 [UNITE]', NULL, 0, '2023-09-12 15:42:35', '2023-09-20 16:45:13', NULL),
(315, 315, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '5.00', 'ROBINET DE DOUCHE KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:35', '2023-09-15 18:27:13', NULL),
(316, 316, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '35000.00', '29661.02', '35000.00', '0.00', NULL, '4.00', 'ROBINET DE DOUCHE MITIGEUR MAAT [UNITE]', NULL, 0, '2023-09-12 15:42:35', NULL, NULL),
(317, 317, 1, 1, '1.00', '12005.00', '0.00', '1000000.00', '750.00', '635.59', '750.00', '0.00', NULL, '12208.00', 'ROBINET EQUERRE GRK [UNITE]', NULL, 0, '2023-09-12 15:42:35', '2023-09-21 08:48:59', NULL),
(318, 318, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '9000.00', '7627.12', '9000.00', '0.00', NULL, '4.00', 'ROBINET EVIER MITIGEUR MURALE SC [UNITE]', NULL, 0, '2023-09-12 15:42:36', NULL, NULL),
(319, 319, 1, 1, '1.00', '106.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '134.00', 'ROBINET EVIER MURAL [UNITE]', NULL, 0, '2023-09-12 15:42:36', '2023-09-22 15:26:26', NULL),
(320, 320, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '10000.00', '8474.58', '10000.00', '0.00', NULL, '3.00', 'ROBINET EVIER ORIGINAL MAK [UNITE]', NULL, 0, '2023-09-12 15:42:36', NULL, NULL),
(321, 321, 1, 1, '1.00', '187.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '187.00', 'ROBINET EVIER PLASTIC SUR TABLE [UNITE]', NULL, 0, '2023-09-12 15:42:36', NULL, NULL),
(322, 322, 1, 1, '1.00', '57.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '57.00', 'ROBINET EVIER PLASTIQUE MURAL [UNITE]', NULL, 0, '2023-09-12 15:42:36', NULL, NULL),
(323, 323, 1, 1, '1.00', '9.00', '0.00', '1000000.00', '15000.00', '12711.86', '15000.00', '0.00', NULL, '9.00', 'ROBINET LAVABO BLEU MITIGEUR PETIT CORPS [UNITE]', NULL, 0, '2023-09-12 15:42:36', NULL, NULL),
(324, 324, 1, 1, '1.00', '30.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '35.00', 'ROBINET LAVABO INGLAND [UNITE]', NULL, 0, '2023-09-12 15:42:37', '2023-09-21 11:18:08', NULL),
(325, 325, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '3.00', 'ROBINET LAVABO KMEI LY 600-861K [UNITE]', NULL, 0, '2023-09-12 15:42:37', NULL, NULL),
(326, 326, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '20000.00', '16949.15', '20000.00', '0.00', NULL, '4.00', 'ROBINET LAVABO MITIGEUR BLEU GROS CORPS [UNITE]', NULL, 0, '2023-09-12 15:42:37', '2023-09-15 18:09:28', NULL),
(327, 327, 1, 1, '1.00', '6.00', '0.00', '1000000.00', '20000.00', '16949.15', '20000.00', '0.00', NULL, '6.00', 'ROBINET LAVABO MITIGEUR Ingland [UNITE]', NULL, 0, '2023-09-12 15:42:37', NULL, NULL),
(328, 328, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '35000.00', '29661.02', '35000.00', '0.00', NULL, '5.00', 'ROBINET LAVABO MITIGEUR MAAT [UNITE]', NULL, 0, '2023-09-12 15:42:37', NULL, NULL),
(329, 329, 1, 1, '1.00', '1765.00', '1800.00', '2000.00', '1850.00', '1567.80', '1850.00', '0.00', NULL, '3575.00', 'ROBINET PUISSAGE 15/21 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:38', '2023-09-22 16:00:49', NULL),
(330, 330, 1, 1, '1.00', '66.00', '0.00', '1000000.00', '1600.00', '1355.93', '1600.00', '0.00', NULL, '76.00', 'ROBINET PUISSAGE À BOISSEAU 15/21 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:38', '2023-09-15 18:25:50', NULL),
(331, 331, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '7.00', 'ROBINET PUISSAGE À BOISSEAU FIRMER YLN6316-1/2 [UNITE]', NULL, 0, '2023-09-12 15:42:38', NULL, NULL),
(332, 332, 1, 1, '1.00', '11.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '11.00', 'ROBINET PUISSAGE À CLÉ 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:38', '2023-09-15 17:41:39', NULL),
(333, 333, 1, 1, '1.00', '12.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '37.00', 'ROBINET PUISSAGE CHROMÉ A CLE [UNITE]', NULL, 0, '2023-09-12 15:42:38', '2023-09-21 08:49:01', NULL),
(334, 334, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '5.00', 'ROBINET PUISSAGE GRK 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:38', NULL, NULL),
(335, 335, 1, 1, '1.00', '337.00', '0.00', '1000000.00', '2200.00', '1864.41', '2200.00', '0.00', NULL, '317.00', 'ROBINET PUISSAGE KMEI 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:39', '2023-09-22 16:00:50', NULL),
(336, 336, 1, 1, '1.00', '82.00', '0.00', '1000000.00', '1850.00', '1567.80', '1850.00', '0.00', NULL, '342.00', 'ROBINET PUISSAGE KMEI LY1300 1/2 [UNITE]', NULL, 0, '2023-09-12 15:42:39', '2023-09-19 08:43:46', NULL),
(337, 337, 1, 1, '1.00', '84.00', '0.00', '1000000.00', '450.00', '381.36', '450.00', '0.00', NULL, '84.00', 'ROBINET PUISSAGE PLASTIQUE [UNITE]', NULL, 0, '2023-09-12 15:42:39', NULL, NULL),
(338, 338, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '4000.00', '3389.83', '4000.00', '0.00', NULL, '6.00', 'ROBINET URINOIRE [UNITE]', NULL, 0, '2023-09-12 15:42:39', '2023-09-15 18:31:14', NULL),
(339, 339, 1, 1, '1.00', '360.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '360.00', 'SIPHON DE SOL 10G [UNITE]', NULL, 0, '2023-09-12 15:42:39', '2023-09-21 12:19:06', NULL),
(340, 340, 1, 1, '1.00', '51.00', '0.00', '1000000.00', '12000.00', '10169.49', '12000.00', '0.00', NULL, '56.00', 'SIPHON DE SOL DE LUXE [UNITE]', NULL, 0, '2023-09-12 15:42:39', '2023-09-18 14:30:59', NULL),
(341, 341, 1, 1, '1.00', '8.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '8.00', 'SIPHON EVIER GROS TROU 1BAC [UNITE]', NULL, 0, '2023-09-12 15:42:40', NULL, NULL),
(342, 342, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '850.00', '720.34', '850.00', '0.00', NULL, '7.00', 'SIPHON EVIER SC 60804-40C [UNITE]', NULL, 0, '2023-09-12 15:42:40', NULL, NULL),
(343, 343, 1, 1, '1.00', '10.00', '0.00', '1000000.00', '1000.00', '847.46', '1000.00', '0.00', NULL, '10.00', 'SIPHON LAVABO À TIGE KMEI LY761-32P [UNITE]', NULL, 0, '2023-09-12 15:42:40', NULL, NULL),
(344, 344, 1, 1, '1.00', '1308.00', '0.00', '1000000.00', '1700.00', '1440.68', '1700.00', '0.00', NULL, '1312.00', 'SIPHON LAVABO ACCORDÉON SC [UNITE]', NULL, 0, '2023-09-12 15:42:40', '2023-09-20 14:16:58', NULL),
(345, 345, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '1100.00', '932.20', '1100.00', '0.00', NULL, '2.00', 'SIPHON LAVABO SANS TIGE KMIE LY761-32 [UNITE]', NULL, 0, '2023-09-12 15:42:40', NULL, NULL),
(346, 346, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '2.00', 'TABLETTE LY7702 KMEI [UNITE]', NULL, 0, '2023-09-12 15:42:40', NULL, NULL),
(347, 347, 1, 1, '1.00', '75.00', '0.00', '1000000.00', '1300.00', '1101.69', '1300.00', '0.00', NULL, '75.00', 'TABLETTE PLASTIQUE GDY60702 [UNITE]', NULL, 0, '2023-09-12 15:42:41', NULL, NULL),
(348, 348, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '200.00', '169.49', '200.00', '0.00', NULL, '1.00', 'TÉ À CHAUD [UNITE]', NULL, 0, '2023-09-12 15:42:41', NULL, NULL),
(349, 349, 1, 1, '1.00', '1029.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '1023.00', 'TÉ LAITON 15/21 [UNITE]', NULL, 0, '2023-09-12 15:42:41', '2023-09-22 15:26:27', NULL),
(350, 350, 1, 1, '1.00', '534.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '534.00', 'TÉ LAITON 20/27 [UNITE]', NULL, 0, '2023-09-12 15:42:41', NULL, NULL),
(351, 351, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '1200.00', '1016.95', '1200.00', '0.00', NULL, '1.00', 'TÉ LAITON 26/34 [UNITE]', NULL, 0, '2023-09-12 15:42:41', NULL, NULL),
(352, 352, 1, 1, '1.00', '803.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '803.00', 'TÉ PPR 20 [UNITE]', NULL, 0, '2023-09-12 15:42:41', NULL, NULL),
(353, 353, 1, 1, '1.00', '1629.00', '0.00', '1000000.00', '80.00', '67.80', '80.00', '0.00', NULL, '1644.00', 'TÉ PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:42', '2023-09-20 13:05:43', NULL),
(354, 354, 1, 1, '1.00', '1702.00', '0.00', '1000000.00', '120.00', '101.69', '120.00', '0.00', NULL, '1705.00', 'TÉ PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:42', '2023-09-15 18:34:13', NULL),
(355, 355, 1, 1, '1.00', '241.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '245.00', 'TÉ PPR 40 [UNITE]', NULL, 0, '2023-09-12 15:42:42', '2023-09-15 18:34:12', NULL),
(356, 356, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '550.00', '466.10', '550.00', '0.00', NULL, '7.00', 'TÉ PPR 50 [UNITE]', NULL, 0, '2023-09-12 15:42:42', NULL, NULL),
(357, 357, 1, 1, '1.00', '65.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '65.00', 'TÉ PPR TARODÉ 20*1/2 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:42', NULL, NULL),
(358, 358, 1, 1, '1.00', '80.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '80.00', 'TÉ PPR TARODÉ 20*1/2 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:42', NULL, NULL),
(359, 359, 1, 1, '1.00', '1622.00', '0.00', '1000000.00', '400.00', '338.98', '400.00', '0.00', NULL, '1622.00', 'TÉ PPR TARODE 25*1/2 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:43', NULL, NULL),
(360, 360, 1, 1, '1.00', '418.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '421.00', 'TÉ PPR TARODÉ 25*1/2FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:43', '2023-09-15 18:13:20', NULL),
(361, 361, 1, 1, '1.00', '447.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '447.00', 'TÉ PPR TARODÉ 25*3/4 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:43', NULL, NULL),
(362, 362, 1, 1, '1.00', '196.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '196.00', 'TÉ PPR TARODE 25*3/4 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:43', NULL, NULL),
(363, 363, 1, 1, '1.00', '158.00', '0.00', '1000000.00', '750.00', '635.59', '750.00', '0.00', NULL, '158.00', 'TÉ PPR TARODÉ 32*1\" FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:43', NULL, NULL),
(364, 364, 1, 1, '1.00', '43.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '43.00', 'TÉ PPR TARODÉ 32*1/2 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:44', NULL, NULL),
(365, 365, 1, 1, '1.00', '168.00', '0.00', '1000000.00', '650.00', '550.85', '650.00', '0.00', NULL, '168.00', 'TÉ PPR TARODE 32*3/4 FEMELLE [UNITE]', NULL, 0, '2023-09-12 15:42:44', NULL, NULL),
(366, 366, 1, 1, '1.00', '99.00', '0.00', '1000000.00', '650.00', '550.85', '650.00', '0.00', NULL, '99.00', 'TÉ PPR TARODÉ 32*3/4 MÂLE [UNITE]', NULL, 0, '2023-09-12 15:42:44', NULL, NULL),
(367, 367, 1, 1, '1.00', '24.00', '0.00', '1000000.00', '5000.00', '4237.29', '5000.00', '0.00', NULL, '24.00', 'TÉ PRESSION 110 [UNITE]', NULL, 0, '2023-09-12 15:42:44', NULL, NULL),
(368, 368, 1, 1, '1.00', '6.00', '0.00', '1000000.00', '60.00', '50.85', '60.00', '0.00', NULL, '6.00', 'TÉ PRESSION 20 [UNITE]', NULL, 0, '2023-09-12 15:42:44', NULL, NULL),
(369, 369, 1, 1, '1.00', '2233.00', '0.00', '1000000.00', '75.00', '63.56', '75.00', '0.00', NULL, '2247.00', 'TÉ PRESSION 25 [UNITE]', NULL, 0, '2023-09-12 15:42:44', '2023-09-21 11:18:05', NULL),
(370, 370, 1, 1, '1.00', '1490.00', '0.00', '1000000.00', '125.00', '105.93', '125.00', '0.00', NULL, '1505.00', 'TÉ PRESSION 32 [UNITE]', NULL, 0, '2023-09-12 15:42:45', '2023-09-20 16:45:06', NULL),
(371, 371, 1, 1, '1.00', '259.00', '0.00', '1000000.00', '350.00', '296.61', '350.00', '0.00', NULL, '260.00', 'TÉ PRESSION 40 [UNITE]', NULL, 0, '2023-09-12 15:42:45', '2023-09-21 11:18:04', NULL),
(372, 372, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '1100.00', '932.20', '1100.00', '0.00', NULL, '1.00', 'TÉ PRESSION 63 [UNITE]', NULL, 0, '2023-09-12 15:42:45', NULL, NULL),
(373, 373, 1, 1, '1.00', '34.00', '0.00', '1000000.00', '3000.00', '2542.37', '3000.00', '0.00', NULL, '34.00', 'TÉ PRESSION 90 [UNITE]', NULL, 0, '2023-09-12 15:42:45', NULL, NULL),
(374, 374, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '100.00', '84.75', '100.00', '0.00', NULL, '2.00', 'TEFLON PETIT [UNITE]', NULL, 0, '2023-09-12 15:42:45', NULL, NULL),
(375, 375, 1, 1, '1.00', '15033.00', '0.00', '1000000.00', '700.00', '593.22', '700.00', '0.00', NULL, '15234.00', 'TETE ROBINET 15/21 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:46', '2023-09-21 08:48:58', NULL),
(376, 376, 1, 1, '1.00', '1440.00', '0.00', '1000000.00', '900.00', '762.71', '900.00', '0.00', NULL, '1515.00', 'TETE ROBINET 20/27 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:46', '2023-09-21 08:48:59', NULL),
(377, 377, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2300.00', '1949.15', '2300.00', '0.00', NULL, '1.00', 'TUYAUX À CHAUD [UNITE]', NULL, 0, '2023-09-12 15:42:46', NULL, NULL),
(378, 378, 1, 1, '1.00', '43.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '53.00', 'TUYAUX GOUTTIERE  [UNITE]', NULL, 0, '2023-09-12 15:42:46', '2023-09-15 18:25:51', NULL),
(379, 379, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '2300.00', '1949.15', '2300.00', '0.00', NULL, '2.00', 'TUYAUX PPR 25*4.4 [UNITE]', NULL, 0, '2023-09-12 15:42:46', '2023-09-15 17:46:20', NULL),
(380, 380, 1, 1, '1.00', '21.00', '0.00', '1000000.00', '3300.00', '2796.61', '3300.00', '0.00', NULL, '25.00', 'TUYAUX PPR 32*5.4 [UNITE]', NULL, 0, '2023-09-12 15:42:46', '2023-09-16 14:14:37', NULL),
(381, 381, 1, 1, '1.00', '442.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '442.00', 'TUYAUX PPR 40*6.7 [UNITE]', NULL, 0, '2023-09-12 15:42:47', NULL, NULL),
(382, 382, 1, 1, '1.00', '366.00', '0.00', '1000000.00', '10000.00', '8474.58', '10000.00', '0.00', NULL, '366.00', 'TUYAUX PPR 50*8.4 [UNITE]', NULL, 0, '2023-09-12 15:42:47', NULL, NULL),
(383, 383, 1, 1, '1.00', '204.00', '0.00', '1000000.00', '17000.00', '14406.78', '17000.00', '0.00', NULL, '204.00', 'TUYAUX PPR 63*10.5 [UNITE]', NULL, 0, '2023-09-12 15:42:47', NULL, NULL),
(384, 384, 1, 1, '1.00', '36.00', '0.00', '1000000.00', '6000.00', '5084.75', '6000.00', '0.00', NULL, '36.00', 'VANNE À BOISSEAU 61511-1\"/1/4 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:47', '2023-09-15 18:13:50', NULL),
(385, 385, 1, 1, '1.00', '46.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '46.00', 'VANNE À BOISSEAU 61511-15/21 GRK [UNITE]', NULL, 0, '2023-09-12 15:42:47', NULL, NULL),
(386, 386, 1, 1, '1.00', '44.00', '0.00', '1000000.00', '6000.00', '5084.75', '6000.00', '0.00', NULL, '44.00', 'VANNE À BOISSEAU FIRMER CHROME 1\"/1/4 [UNITE]', NULL, 0, '2023-09-12 15:42:47', NULL, NULL),
(387, 387, 1, 1, '1.00', '61.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '61.00', 'VANNE A BOISSEAU FIRMER CHROME 1./1/2 FF [UNITE]', NULL, 0, '2023-09-12 15:42:48', NULL, NULL),
(388, 388, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '13000.00', '11016.95', '13000.00', '0.00', NULL, '4.00', 'VANNE À BOISSEAU FIRMER YLN 6233-2\" [UNITE]', NULL, 0, '2023-09-12 15:42:48', NULL, NULL),
(389, 389, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '2.00', 'VANNE A BOISSEAU FIRMER YLN 6233-3/4 [UNITE]', NULL, 0, '2023-09-12 15:42:48', NULL, NULL),
(390, 390, 1, 1, '1.00', '16.00', '0.00', '1000000.00', '3200.00', '2711.86', '3200.00', '0.00', NULL, '16.00', 'VANNE À BOISSEAU MAYER 1\" [UNITE]', NULL, 0, '2023-09-12 15:42:48', NULL, NULL),
(391, 391, 1, 1, '1.00', '181.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '197.00', 'VANNE À BOISSEAU PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:48', '2023-09-15 18:29:58', NULL),
(392, 392, 1, 1, '1.00', '43.00', '0.00', '1000000.00', '3000.00', '2542.37', '3000.00', '0.00', NULL, '43.00', 'VANNE À BOISSEAU PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:49', NULL, NULL),
(393, 393, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '2000.00', '1694.92', '2000.00', '0.00', NULL, '1.00', 'VANNE À RACCORD  UNION PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:49', NULL, NULL),
(394, 394, 1, 1, '1.00', '8.00', '0.00', '1000000.00', '29000.00', '24576.27', '29000.00', '0.00', NULL, '8.00', 'VANNE À RACCORD UNION PRESSION 110 [UNITE]', NULL, 0, '2023-09-12 15:42:49', NULL, NULL),
(395, 395, 1, 1, '1.00', '90.00', '0.00', '1000000.00', '1300.00', '1101.69', '1300.00', '0.00', NULL, '90.00', 'VANNE À RACCORD UNION PRESSION 25 [UNITE]', NULL, 0, '2023-09-12 15:42:49', NULL, NULL),
(396, 396, 1, 1, '1.00', '48.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '48.00', 'VANNE À RACCORD UNION PRESSION 63 [UNITE]', NULL, 0, '2023-09-12 15:42:49', NULL, NULL),
(397, 397, 1, 1, '1.00', '19.00', '0.00', '1000000.00', '11500.00', '9745.76', '11500.00', '0.00', NULL, '19.00', 'VANNE À RACCORD UNION PRESSION 75 [UNITE]', NULL, 0, '2023-09-12 15:42:49', NULL, NULL),
(398, 398, 1, 1, '1.00', '172.00', '0.00', '1000000.00', '1400.00', '1186.44', '1400.00', '0.00', NULL, '172.00', 'VANNE À VOLANT PPR 20 [UNITE]', NULL, 0, '2023-09-12 15:42:50', NULL, NULL),
(399, 399, 1, 1, '1.00', '232.00', '0.00', '1000000.00', '2200.00', '1864.41', '2200.00', '0.00', NULL, '269.00', 'VANNE À VOLANT PPR 25 [UNITE]', NULL, 0, '2023-09-12 15:42:50', '2023-09-20 12:09:51', NULL),
(400, 400, 1, 1, '1.00', '1969.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '1969.00', 'VANNE À VOLANT PPR 32 [UNITE]', NULL, 0, '2023-09-12 15:42:50', NULL, NULL),
(401, 401, 1, 1, '1.00', '684.00', '0.00', '1000000.00', '3500.00', '2966.10', '3500.00', '0.00', NULL, '684.00', 'VANNE PPR DE LUXE 25 [UNITE]', NULL, 0, '2023-09-12 15:42:50', NULL, NULL),
(402, 402, 1, 1, '1.00', '272.00', '0.00', '1000000.00', '500.00', '423.73', '500.00', '0.00', NULL, '272.00', 'VANNE PRESSION DE 20 [UNITE]', NULL, 0, '2023-09-12 15:42:50', NULL, NULL),
(403, 403, 1, 1, '1.00', '258.00', '0.00', '1000000.00', '600.00', '508.47', '600.00', '0.00', NULL, '258.00', 'VANNE PRESSION DE 25 [UNITE]', NULL, 0, '2023-09-12 15:42:51', NULL, NULL),
(404, 404, 1, 1, '1.00', '-23.00', '0.00', '1000000.00', '1500.00', '1271.19', '1500.00', '0.00', NULL, '10.00', 'VANNE PRESSION DE 50 [UNITE]', NULL, 0, '2023-09-12 15:42:51', '2023-09-21 15:21:38', NULL),
(405, 405, 1, 1, '1.00', '51.00', '0.00', '1000000.00', '1700.00', '1440.68', '1700.00', '0.00', NULL, '51.00', 'VANNE PRESSION DE 40 [UNITE]', NULL, 0, '2023-09-12 15:42:51', NULL, NULL),
(406, 406, 1, 1, '1.00', '2.00', '0.00', '1000000.00', '175.00', '148.31', '175.00', '0.00', NULL, '2.00', 'VICE CACHE TETE LY562WC [UNITE]', NULL, 0, '2023-09-12 15:42:51', NULL, NULL),
(407, 407, 1, 1, '1.00', '103.00', '0.00', '1000000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '103.00', 'VIDANGE BAIGNOIRE PROFESSIONNEL [UNITE]', NULL, 0, '2023-09-12 15:42:51', NULL, NULL),
(408, 408, 1, 1, '1.00', '160.00', '0.00', '1000000.00', '4000.00', '3389.83', '4000.00', '0.00', NULL, '160.00', 'VIDANGE EVIER 2BAC GROS TROU [UNITE]', NULL, 0, '2023-09-12 15:42:52', NULL, NULL),
(409, 409, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '32000.00', '27118.64', '32000.00', '0.00', NULL, '5.00', 'WC PARMA BLANC [UNITE]', NULL, 0, '2023-09-12 15:42:52', NULL, NULL),
(410, 410, 1, 1, '1.00', '140.00', '0.00', '1000000.00', '50000.00', '42372.88', '50000.00', '0.00', NULL, '140.00', 'WC LIMA GRAND [UNITE]', NULL, 0, '2023-09-12 15:42:52', '2023-09-15 17:46:43', NULL),
(411, 411, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '150000.00', '127118.64', '150000.00', '0.00', NULL, '5.00', 'WC COMBINE RONA A-P 1769 [UNITE]', NULL, 0, '2023-09-12 15:42:52', NULL, NULL),
(412, 412, 1, 1, '1.00', '10.00', '0.00', '1000000.00', '150000.00', '127118.64', '150000.00', '0.00', NULL, '10.00', 'WC COMBINE CARRE A-P1770 [UNITE]', NULL, 0, '2023-09-12 15:42:52', NULL, NULL),
(413, 413, 1, 1, '1.00', '10.00', '0.00', '1000000.00', '150000.00', '127118.64', '150000.00', '0.00', NULL, '10.00', 'WC COMBINE CARRE A-P1767 [UNITE]', NULL, 0, '2023-09-12 15:42:53', NULL, NULL),
(414, 414, 1, 1, '1.00', '4.00', '0.00', '1000000.00', '280000.00', '237288.14', '280000.00', '0.00', NULL, '4.00', 'WC SUSPENDU BESILE D-P3651 [UNITE]', NULL, 0, '2023-09-12 15:42:53', NULL, NULL),
(415, 415, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '300000.00', '254237.29', '300000.00', '0.00', NULL, '4.00', 'WC SUSPENDU BESILE NOIR D-P3651B [UNITE]', NULL, 0, '2023-09-12 15:42:53', '2023-09-18 14:30:59', NULL),
(416, 416, 4, 1, '1.00', '9.00', '0.00', '1000000.00', '70000.00', '59322.03', '70000.00', '0.00', NULL, '9.00', ' AGA 270   [CARTON]', NULL, 0, '2023-09-12 15:42:53', '2023-09-22 12:50:38', NULL),
(417, 417, 1, 1, '1.00', '168.00', '0.00', '1000000.00', '57600.00', '48813.56', '57600.00', '0.00', NULL, '168.00', ' ROBIWANG 124 [UNITE]', NULL, 0, '2023-09-12 15:42:53', NULL, NULL),
(418, 418, 1, 1, '1.00', '251.00', '0.00', '1000000.00', '4000.00', '3389.83', '4000.00', '0.00', NULL, '257.00', 'CADENAS VACHETTE  SEMI 75MM [UNITE]', NULL, 0, '2023-09-12 15:42:53', '2023-09-15 18:33:38', NULL),
(419, 419, 1, 1, '1.00', '258.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '258.00', 'CADENAS VACHETTE SEMI  80MM [UNITE]', NULL, 0, '2023-09-12 15:42:54', NULL, NULL),
(420, 420, 1, 1, '1.00', '58.00', '0.00', '1000000.00', '6000.00', '5084.75', '6000.00', '0.00', NULL, '58.00', 'CADENAS VACHETTE ORIGINAL  80MM [UNITE]', NULL, 0, '2023-09-12 15:42:54', '2023-09-21 16:52:09', NULL),
(421, 421, 4, 1, '1.00', '40.00', '0.00', '1000000.00', '40000.00', '33898.31', '40000.00', '0.00', NULL, '40.00', 'CLÉ DOR 88 3CLÉS [CARTON]', NULL, 0, '2023-09-12 15:42:54', NULL, NULL),
(422, 422, 1, 1, '1.00', '214.00', '0.00', '1000000.00', '2400.00', '2033.90', '2400.00', '0.00', NULL, '226.00', 'CYLINDRE ARM LOCK A70 [UNITE]', NULL, 0, '2023-09-12 15:42:54', '2023-09-22 11:55:01', NULL),
(423, 423, 1, 1, '1.00', '498.00', '0.00', '1000000.00', '2400.00', '2033.90', '2400.00', '0.00', NULL, '549.00', 'CYLINDRE BUTUC UNIC U70A [UNITE]', NULL, 0, '2023-09-12 15:42:54', '2023-09-22 11:55:01', NULL),
(424, 424, 5, 1, '1.00', '640.00', '11500.00', '12500.00', '12000.00', '10169.49', '12000.00', '0.00', NULL, '660.00', 'CYLINDRE CLE DOOR [DOUZAINE]', NULL, 0, '2023-09-12 15:42:55', '2023-09-18 14:12:48', NULL),
(425, 425, 5, 1, '1.00', '26.00', '0.00', '1000000.00', '17000.00', '14406.78', '17000.00', '0.00', NULL, '26.00', 'CYLINDRE LA PERCHE 60M LAP SACHET [DOUZAINE]', NULL, 0, '2023-09-12 15:42:55', '2023-09-21 12:45:26', NULL),
(426, 426, 5, 1, '1.00', '126.00', '0.00', '1000000.00', '13000.00', '11016.95', '13000.00', '0.00', NULL, '226.00', 'CYLINDRE LA PERCHE BLEU 60M [DOUZAINE]', NULL, 0, '2023-09-12 15:42:55', '2023-09-20 10:43:12', NULL),
(427, 427, 1, 1, '1.00', '606.00', '0.00', '1000000.00', '2600.00', '2203.39', '2600.00', '0.00', NULL, '654.00', 'CYLINDRE PARFAIT BLEU P70A [UNITE]', NULL, 0, '2023-09-12 15:42:55', '2023-09-22 11:55:01', NULL),
(428, 428, 5, 1, '1.00', '0.00', '6500.00', '7000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '10.00', 'CYLINDRE VACHETTE 60MM 3K [DOUZAINE]', NULL, 0, '2023-09-12 15:42:56', '2023-09-18 09:46:01', NULL),
(429, 429, 2, 1, '1.00', '46.00', '0.00', '1000000.00', '23000.00', '19491.53', '23000.00', '0.00', NULL, '47.00', 'EVERLEO [BOITE]', NULL, 0, '2023-09-12 15:42:56', '2023-09-20 10:43:27', NULL),
(430, 430, 5, 1, '1.00', '141.00', '0.00', '1000000.00', '7000.00', '5932.20', '7000.00', '0.00', NULL, '141.00', 'FAEA 139-32 [DOUZAINE]', NULL, 0, '2023-09-12 15:42:56', NULL, NULL),
(431, 431, 1, 1, '1.00', '1173.00', '0.00', '1000000.00', '4300.00', '3644.07', '4300.00', '0.00', NULL, '1174.00', 'SERRURE G.J.S [UNITE]', NULL, 0, '2023-09-12 15:42:56', '2023-09-18 14:12:48', NULL),
(432, 432, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '4800.00', '4067.80', '4800.00', '0.00', NULL, '1.00', 'LA CLÉ 124 [UNITE]', NULL, 0, '2023-09-12 15:42:56', NULL, NULL),
(433, 433, 1, 1, '1.00', '57.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '57.00', 'LA PERCHE 3253 CR [UNITE]', NULL, 0, '2023-09-12 15:42:56', NULL, NULL),
(434, 434, 1, 1, '1.00', '48.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '48.00', 'LA PERCHE 3253 SCR [UNITE]', NULL, 0, '2023-09-12 15:42:57', NULL, NULL),
(435, 435, 1, 1, '1.00', '144.00', '0.00', '1000000.00', '4500.00', '3813.56', '4500.00', '0.00', NULL, '144.00', 'LA PERCHE 9019-F1 SILVER GP [UNITE]', NULL, 0, '2023-09-12 15:42:57', '2023-09-15 17:56:14', NULL),
(436, 436, 1, 1, '1.00', '41.00', '0.00', '1000000.00', '4300.00', '3644.07', '4300.00', '0.00', NULL, '41.00', 'LA PERCHE 9019-WC SILVER  [UNITE]', NULL, 0, '2023-09-12 15:42:57', '2023-09-15 17:40:52', NULL),
(437, 437, 1, 1, '1.00', '160.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '160.00', 'LA PERCHE 911B6458 AB NORMALE [UNITE]', NULL, 0, '2023-09-12 15:42:57', '2023-09-22 12:50:38', NULL),
(438, 438, 1, 1, '1.00', '76.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '76.00', 'LA PERCHE 911B6458 AB WC [UNITE]', NULL, 0, '2023-09-12 15:42:57', '2023-09-15 17:56:13', NULL),
(439, 439, 1, 1, '1.00', '404.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '404.00', 'LA PERCHE 911B6458 SCR NORMALE [UNITE]', NULL, 0, '2023-09-12 15:42:58', '2023-09-15 17:56:13', NULL),
(440, 440, 1, 1, '1.00', '90.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '90.00', 'LA PERCHE 911B6458 SCR WC [UNITE]', NULL, 0, '2023-09-12 15:42:58', NULL, NULL),
(441, 441, 1, 1, '1.00', '1254.00', '0.00', '1000000.00', '4250.00', '3601.69', '4250.00', '0.00', NULL, '1475.00', 'LA PERCHE CAISSE 6458 [UNITE]', NULL, 0, '2023-09-12 15:42:58', '2023-09-20 16:44:48', NULL),
(442, 442, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '9000.00', '7627.12', '9000.00', '0.00', NULL, '1.00', 'LA PERCHE DE LUXE 0850 [UNITE]', NULL, 0, '2023-09-12 15:42:58', NULL, NULL),
(443, 443, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '1.00', 'LA PERCHE GARANTIE 10 ANS 9058 [UNITE]', NULL, 0, '2023-09-12 15:42:58', NULL, NULL),
(444, 444, 1, 1, '1.00', '52.00', '0.00', '1000000.00', '10000.00', '8474.58', '10000.00', '0.00', NULL, '68.00', 'LA PERCHE ORIGINAL [UNITE]', NULL, 0, '2023-09-12 15:42:59', '2023-09-18 14:14:05', NULL),
(445, 445, 4, 1, '1.00', '76.00', '0.00', '1000000.00', '26500.00', '22457.63', '26500.00', '0.00', NULL, '76.00', 'MICC 202 [CARTON]', NULL, 0, '2023-09-12 15:42:59', '2023-09-20 16:45:47', NULL),
(446, 446, 4, 1, '1.00', '98.00', '0.00', '1000000.00', '31000.00', '26271.19', '31000.00', '0.00', NULL, '98.00', 'MICC 404 [CARTON]', NULL, 0, '2023-09-12 15:42:59', '2023-09-20 16:45:47', NULL),
(447, 447, 4, 1, '1.00', '10.00', '0.00', '1000000.00', '47000.00', '39830.51', '47000.00', '0.00', NULL, '15.00', 'PACO 210PA [CARTON]', NULL, 0, '2023-09-12 15:42:59', '2023-09-15 18:33:54', NULL),
(448, 448, 1, 1, '1.00', '194.00', '0.00', '1000000.00', '9000.00', '7627.12', '9000.00', '0.00', NULL, '206.00', 'PACO PARFAIT G112-AB [UNITE]', NULL, 0, '2023-09-12 15:42:59', '2023-09-21 16:52:09', NULL),
(449, 449, 1, 1, '1.00', '139.00', '0.00', '1000000.00', '10500.00', '8898.31', '10500.00', '0.00', NULL, '139.00', 'SERRURE PARFAIT à GAGE A007 [UNITE]', NULL, 0, '2023-09-12 15:43:00', '2023-09-15 17:56:15', NULL),
(450, 450, 1, 1, '1.00', '91.00', '0.00', '1000000.00', '10500.00', '8898.31', '10500.00', '0.00', NULL, '91.00', 'SERRURE PARFAIT A GAGE A007-2 CHAMPAGNE [UNITE]', NULL, 0, '2023-09-12 15:43:00', NULL, NULL),
(451, 451, 1, 1, '1.00', '5.00', '0.00', '1000000.00', '10500.00', '8898.31', '10500.00', '0.00', NULL, '5.00', 'SERRURE PARFAIT A GAGE BLACK A007-4 [UNITE]', NULL, 0, '2023-09-12 15:43:00', '2023-09-21 16:51:56', NULL),
(452, 452, 1, 1, '1.00', '121.00', '0.00', '1000000.00', '11500.00', '9745.76', '11500.00', '0.00', NULL, '129.00', 'SERRURE PARFAIT A007BL-020BL-022 [UNITE]', NULL, 0, '2023-09-12 15:43:00', '2023-09-18 14:30:58', NULL),
(453, 453, 1, 1, '1.00', '18.00', '0.00', '1000000.00', '11500.00', '9745.76', '11500.00', '0.00', NULL, '18.00', 'SERRURE PARFAIT A022 [UNITE]', NULL, 0, '2023-09-12 15:43:01', '2023-09-15 17:56:14', NULL),
(454, 454, 1, 1, '1.00', '163.00', '0.00', '1000000.00', '11500.00', '9745.76', '11500.00', '0.00', NULL, '163.00', 'SERRURE PARFAIT A020BL-A020AB [UNITE]', NULL, 0, '2023-09-12 15:43:01', NULL, NULL),
(455, 455, 1, 1, '1.00', '172.00', '0.00', '1000000.00', '9000.00', '7627.12', '9000.00', '0.00', NULL, '172.00', 'SERRURE PARFAIT PORTE VITRIER P100 B8 W2 [UNITE]', NULL, 0, '2023-09-12 15:43:01', NULL, NULL),
(456, 456, 1, 1, '1.00', '3.00', '0.00', '1000000.00', '4200.00', '3559.32', '4200.00', '0.00', NULL, '3.00', 'SERRURE PARFAIT X-A003 [UNITE]', NULL, 0, '2023-09-12 15:43:01', NULL, NULL),
(457, 457, 4, 1, '1.00', '43.00', '0.00', '1000000.00', '22000.00', '18644.07', '22000.00', '0.00', NULL, '47.00', 'PAUMELLE AGA 140 [CARTON]', NULL, 0, '2023-09-12 15:43:01', '2023-09-15 18:21:39', NULL),
(458, 458, 4, 1, '1.00', '29.00', '0.00', '1000000.00', '34000.00', '28813.56', '34000.00', '0.00', NULL, '33.00', 'PAUMELLE AGA 160  [CARTON]', NULL, 0, '2023-09-12 15:43:02', '2023-09-21 15:16:41', NULL),
(459, 459, 4, 1, '1.00', '3.00', '0.00', '1000000.00', '38000.00', '32203.39', '38000.00', '0.00', NULL, '4.00', 'PAUMELLE AGA 80 [CARTON]', NULL, 0, '2023-09-12 15:43:02', '2023-09-21 15:21:39', NULL),
(460, 460, 4, 1, '1.00', '5.00', '0.00', '1000000.00', '32000.00', '27118.64', '32000.00', '0.00', NULL, '5.00', 'PAUMELLE AMI 110 [CARTON]', NULL, 0, '2023-09-12 15:43:02', NULL, NULL),
(461, 461, 4, 1, '1.00', '4.00', '0.00', '1000000.00', '33000.00', '27966.10', '33000.00', '0.00', NULL, '5.00', 'PAUMELLE AMI 95 [CARTON]', NULL, 0, '2023-09-12 15:43:02', '2023-09-21 15:21:40', NULL),
(462, 462, 1, 1, '1.00', '0.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '0.00', 'SERRURE EVERLEO 905AB/7050H [UNITE]', NULL, 0, '2023-09-12 15:43:02', '2023-09-22 12:50:49', NULL),
(463, 463, 1, 1, '1.00', '168.00', '0.00', '1000000.00', '9000.00', '7627.12', '9000.00', '0.00', NULL, '169.00', 'SERRURE PARFAIT DOUCHE [UNITE]', NULL, 0, '2023-09-12 15:43:03', '2023-09-18 14:30:58', NULL),
(464, 464, 1, 1, '1.00', '7.00', '0.00', '1000000.00', '12000.00', '10169.49', '12000.00', '0.00', NULL, '7.00', 'SERRURE PH01 [UNITE]', NULL, 0, '2023-09-12 15:43:03', NULL, NULL),
(465, 465, 1, 1, '1.00', '1.00', '0.00', '1000000.00', '6500.00', '5508.47', '6500.00', '0.00', NULL, '1.00', 'VACHETTE 9045 [UNITE]', NULL, 0, '2023-09-12 15:43:03', NULL, NULL),
(466, 466, 1, 1, '1.00', '11.00', '0.00', '1000000.00', '5500.00', '4661.02', '5500.00', '0.00', NULL, '11.00', 'VACHETTE ARMOIRE 1TOUR 4464-22 [UNITE]', NULL, 0, '2023-09-12 15:43:03', NULL, NULL),
(467, 467, 4, 1, '1.00', '2.00', '0.00', '1000000.00', '46000.00', '38983.05', '46000.00', '0.00', NULL, '2.00', 'VERROU à CADENAS 10 SEMI [CARTON]', NULL, 0, '2023-09-12 15:43:04', NULL, NULL),
(468, 468, 4, 1, '1.00', '3.00', '0.00', '1000000.00', '35000.00', '29661.02', '35000.00', '0.00', NULL, '3.00', 'VERROU à CADENAS 12 SEMI [CARTON]', NULL, 0, '2023-09-12 15:43:04', NULL, NULL),
(469, 469, 4, 1, '1.00', '1.00', '0.00', '1000000.00', '45000.00', '38135.59', '45000.00', '0.00', NULL, '1.00', 'VERROU À CADENAS 14 [CARTON]', NULL, 0, '2023-09-12 15:43:04', NULL, NULL),
(470, 470, 4, 1, '1.00', '1.00', '0.00', '1000000.00', '45000.00', '38135.59', '45000.00', '0.00', NULL, '1.00', 'VERROU à CADENAS 14 SEMI [CARTON]', NULL, 0, '2023-09-12 15:43:04', NULL, NULL),
(471, 471, 4, 1, '1.00', '1.00', '0.00', '1000000.00', '40000.00', '33898.31', '40000.00', '0.00', NULL, '1.00', 'VERROU à CADENAS 8 SEMI [CARTON]', NULL, 0, '2023-09-12 15:43:04', NULL, NULL),
(472, 472, 4, 1, '1.00', '1.00', '0.00', '1000000.00', '38000.00', '32203.39', '38000.00', '0.00', NULL, '1.00', 'VERROU À PISTOLER 12 [CARTON]', NULL, 0, '2023-09-12 15:43:05', NULL, NULL),
(473, 473, 4, 1, '1.00', '2.00', '0.00', '1000000.00', '54000.00', '45762.71', '54000.00', '0.00', NULL, '2.00', 'VERROU À PISTOLER 16 [CARTON]', NULL, 0, '2023-09-12 15:43:05', NULL, NULL),
(474, 474, 4, 1, '1.00', '2.00', '0.00', '1000000.00', '45000.00', '38135.59', '45000.00', '0.00', NULL, '2.00', 'VERROU À PISTOLER 8 [CARTON]', NULL, 0, '2023-09-12 15:43:05', NULL, NULL),
(475, 475, 1, 1, '1.00', '29.00', '0.00', '1000000.00', '7000.00', '5932.20', '7000.00', '0.00', NULL, '29.00', ' WISTA [UNITE]', NULL, 0, '2023-09-12 15:43:05', NULL, NULL),
(476, 427, 4, 1, '60.00', '0.00', '156000.00', '160000.00', '156000.00', '132203.39', '156000.00', '0.00', NULL, '0.00', 'CYLINDRE PARFAIT BLEU P70A [CARTON]', NULL, 0, '2023-09-13 16:57:46', NULL, NULL),
(477, 47, 4, 1, '3.00', '28.00', '65000.00', '68000.00', '65000.00', '55084.75', '65000.00', '0.00', NULL, '28.00', 'VENTILATEUR SMC [CARTON]', NULL, 0, '2023-09-15 10:45:57', '2023-09-15 18:27:34', NULL),
(478, 46, 4, 1, '3.00', '19.00', '65000.00', '68000.00', '65000.00', '55084.75', '65000.00', '0.00', NULL, '20.00', 'VENTILATEUR PANASONIK [CARTON]', NULL, 0, '2023-09-15 11:07:00', '2023-09-15 18:26:54', NULL),
(479, 45, 4, 1, '3.00', '20.00', '65000.00', '68000.00', '65000.00', '55084.75', '65000.00', '0.00', NULL, '20.00', 'VENTILATEUR ITC [CARTON]', NULL, 0, '2023-09-15 11:11:21', '2023-09-15 11:20:48', NULL),
(480, 44, 4, 1, '3.00', '5.00', '65000.00', '68000.00', '65000.00', '55084.75', '65000.00', '0.00', NULL, '5.00', 'VENTILATEUR CMC [CARTON]', NULL, 0, '2023-09-15 11:12:41', '2023-09-15 11:20:47', NULL),
(481, 441, 8, 1, '72.00', '29.00', '302000.00', '306000.00', '302400.00', '256271.19', '302400.00', '0.00', NULL, '29.00', 'LA PERCHE CAISSE 6458 [CAISSE]', NULL, 0, '2023-09-15 11:58:29', '2023-09-15 18:27:50', NULL),
(482, 476, 1, 1, '1.00', '0.00', '2500.00', '3000.00', '2500.00', '2118.64', '2500.00', '0.00', NULL, '3.00', 'ROBINET LAVABO KMEI LY 631-680 [UNITE]', NULL, 0, '2023-09-15 12:13:00', '2023-09-15 18:29:24', NULL),
(483, 477, 1, 1, '1.00', '0.00', '3000.00', '3500.00', '3000.00', '2542.37', '3000.00', '0.00', NULL, '13.00', 'ROBINET LAVABO KMEI PLASTIC GROS CORPS [UNITE]', NULL, 0, '2023-09-15 12:17:12', '2023-09-15 18:28:37', NULL),
(484, 426, 4, 1, '10.00', '8.00', '120000.00', '125000.00', '125000.00', '105932.20', '125000.00', '0.00', NULL, '8.00', 'CYLINDRE LA PERCHE BLEU 60M [CARTON]', NULL, 0, '2023-09-18 09:09:52', '2023-09-22 11:55:24', NULL),
(485, 424, 4, 1, '10.00', '20.00', '120000.00', '125000.00', '120000.00', '101694.92', '120000.00', '0.00', NULL, '20.00', 'CYLINDRE CLE DOOR [CARTON]', NULL, 0, '2023-09-18 09:35:38', '2023-09-18 09:37:22', NULL),
(486, 428, 4, 1, '10.00', '2.00', '64000.00', '65000.00', '65000.00', '55084.75', '65000.00', '0.00', NULL, '2.00', 'CYLINDRE VACHETTE 60MM 3K [CARTON]', NULL, 0, '2023-09-18 09:45:12', '2023-09-21 15:11:55', NULL),
(487, 329, 4, 1, '100.00', '25.00', '180000.00', '200000.00', '185000.00', '156779.66', '185000.00', '0.00', NULL, '35.00', 'ROBINET PUISSAGE 15/21 GRK [CARTON]', NULL, 0, '2023-09-18 09:49:12', '2023-09-18 10:13:49', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_appro_mag`
--

DROP TABLE IF EXISTS `produit_cond_appro_mag`;
CREATE TABLE IF NOT EXISTS `produit_cond_appro_mag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_conditionnement_id` int NOT NULL,
  `appro_magasin_id` int NOT NULL,
  `qte_cond_appro` decimal(10,2) NOT NULL,
  `carton` decimal(10,0) DEFAULT NULL,
  `piece` decimal(10,0) DEFAULT NULL,
  `prix_achat` decimal(10,2) DEFAULT NULL,
  `montant_cond` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2A498BD239C2AB40` (`produit_conditionnement_id`),
  KEY `IDX_2A498BD23F0A2F6B` (`appro_magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_appro_mag`
--

INSERT INTO `produit_cond_appro_mag` (`id`, `produit_conditionnement_id`, `appro_magasin_id`, `qte_cond_appro`, `carton`, `piece`, `prix_achat`, `montant_cond`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 50, 1, '14.00', NULL, NULL, NULL, NULL, '2023-09-15 10:34:38', NULL, NULL),
(2, 51, 1, '70.00', NULL, NULL, NULL, NULL, '2023-09-15 10:34:38', NULL, NULL),
(3, 52, 1, '98.00', NULL, NULL, NULL, NULL, '2023-09-15 10:34:38', NULL, NULL),
(4, 108, 1, '9.00', NULL, NULL, NULL, NULL, '2023-09-15 10:34:38', NULL, NULL),
(5, 129, 1, '20.00', NULL, NULL, NULL, NULL, '2023-09-15 10:34:38', NULL, NULL),
(6, 222, 1, '1.00', NULL, NULL, NULL, NULL, '2023-09-15 10:34:38', NULL, NULL),
(7, 315, 1, '2.00', NULL, NULL, '0.00', NULL, '2023-09-15 10:34:38', NULL, NULL),
(8, 483, 2, '13.00', NULL, NULL, NULL, NULL, '2023-09-15 14:55:05', NULL, NULL),
(9, 482, 2, '3.00', NULL, NULL, '0.00', NULL, '2023-09-15 14:55:05', NULL, NULL),
(10, 444, 3, '6.00', NULL, NULL, NULL, NULL, '2023-09-18 14:14:05', NULL, NULL),
(11, 64, 3, '1.00', NULL, NULL, NULL, NULL, '2023-09-18 14:14:05', NULL, NULL),
(12, 65, 3, '1.00', NULL, NULL, NULL, NULL, '2023-09-18 14:14:05', NULL, NULL),
(13, 415, 3, '1.00', NULL, NULL, '0.00', NULL, '2023-09-18 14:14:05', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_com_clit`
--

DROP TABLE IF EXISTS `produit_cond_com_clit`;
CREATE TABLE IF NOT EXISTS `produit_cond_com_clit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int DEFAULT NULL,
  `commande_clit_id` int DEFAULT NULL,
  `magasin_id` int DEFAULT NULL,
  `qtite` decimal(10,3) NOT NULL,
  `taxe_specifique` decimal(10,2) DEFAULT NULL,
  `montant` int NOT NULL,
  `prix` int NOT NULL,
  `rest_aliv` decimal(10,3) DEFAULT NULL,
  `montant_ht_apr_rse` decimal(10,0) DEFAULT NULL,
  `type_remise` varchar(255) DEFAULT NULL,
  `valeur_remise` varchar(255) DEFAULT NULL,
  `remise` decimal(10,0) DEFAULT NULL,
  `prix_ht` decimal(10,0) NOT NULL,
  `montant_ttcp` decimal(10,0) NOT NULL,
  `montant_tvap` decimal(10,0) NOT NULL,
  `carton` decimal(10,0) DEFAULT NULL,
  `piece` decimal(10,0) DEFAULT NULL,
  `libelle_produit` varchar(255) DEFAULT NULL,
  `groupe_taxe_produit` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_192AE28EF347EFB` (`produit_id`),
  KEY `IDX_192AE28E47C00A52` (`commande_clit_id`),
  KEY `IDX_192AE28E20096AE3` (`magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=535 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_com_clit`
--

INSERT INTO `produit_cond_com_clit` (`id`, `produit_id`, `commande_clit_id`, `magasin_id`, `qtite`, `taxe_specifique`, `montant`, `prix`, `rest_aliv`, `montant_ht_apr_rse`, `type_remise`, `valeur_remise`, `remise`, `prix_ht`, `montant_ttcp`, `montant_tvap`, `carton`, `piece`, `libelle_produit`, `groupe_taxe_produit`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 264, 1, 1, '1.000', NULL, 21186, 25000, '0.000', '21186', NULL, NULL, '0', '21186', '25000', '3814', NULL, NULL, NULL, NULL, '2023-09-13 10:31:39', '2023-09-15 17:34:29', NULL),
(2, 375, 1, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-13 10:31:39', '2023-09-15 17:34:30', NULL),
(3, 214, 2, 1, '20.000', NULL, 12711, 750, '0.000', '12712', NULL, NULL, '0', '636', '15000', '2288', NULL, NULL, 'FLEXIBLE INOX LAVABO EN PVC [UNITE]', 'B', '2023-09-13 12:10:35', '2023-09-15 17:35:50', NULL),
(4, 339, 2, 1, '40.000', NULL, 12712, 375, '0.000', '12712', NULL, NULL, '0', '318', '15000', '2288', NULL, NULL, 'SIPHON DE SOL 10G [UNITE]', 'B', '2023-09-13 12:10:35', '2023-09-15 17:35:50', NULL),
(5, 114, 3, 1, '20.000', NULL, 4661, 275, '0.000', '4661', NULL, NULL, '0', '233', '5500', '839', NULL, NULL, 'COLLIER INOX 32 [UNITE]', 'B', '2023-09-13 12:25:27', '2023-09-15 17:39:39', NULL),
(6, 129, 4, 1, '1.000', NULL, 6355, 7500, '0.000', '6356', NULL, NULL, '0', '6356', '7500', '1144', NULL, NULL, 'COMPTEUR LAITON 20/27 GRK [UNITE]', 'B', '2023-09-13 14:02:44', '2023-09-15 17:40:06', NULL),
(7, 436, 5, 1, '2.000', NULL, 7288, 4300, '0.000', '7288', NULL, NULL, '0', '3644', '8600', '1312', NULL, NULL, 'LA PERCHE 9019-WC SILVER  [UNITE]', 'B', '2023-09-13 14:04:56', '2023-09-15 17:40:52', NULL),
(8, 329, 6, 1, '10.000', NULL, 15678, 1850, '0.000', '15678', NULL, NULL, '0', '1568', '18500', '2822', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-13 14:06:34', '2023-09-15 17:41:12', NULL),
(9, 332, 7, 1, '20.000', NULL, 42372, 2500, '0.000', '42373', NULL, NULL, '0', '2119', '50000', '7627', NULL, NULL, 'ROBINET PUISSAGE À CLÉ 15/21 [UNITE]', 'B', '2023-09-13 14:17:07', '2023-09-15 17:41:39', NULL),
(10, 196, 7, 1, '50.000', NULL, 25423, 600, '0.000', '25424', NULL, NULL, '0', '508', '30000', '4576', NULL, NULL, 'EMBOUT PPR TARODÉ 25*3/4 MÂLE [UNITE]', 'B', '2023-09-13 14:17:07', '2023-09-15 17:41:39', NULL),
(11, 128, 7, 1, '5.000', NULL, 28813, 6800, '0.000', '28814', NULL, NULL, '0', '5763', '34000', '5186', NULL, NULL, 'COMPTEUR GALVA GRK 20/27 [UNITE]', 'B', '2023-09-13 14:17:07', '2023-09-15 17:41:40', NULL),
(12, 129, 7, 1, '5.000', NULL, 28813, 6800, '0.000', '28814', NULL, NULL, '0', '5763', '34000', '5186', NULL, NULL, 'COMPTEUR LAITON 20/27 GRK [UNITE]', 'B', '2023-09-13 14:17:07', '2023-09-15 17:41:41', NULL),
(13, 231, 8, 1, '100.000', NULL, 38136, 450, '0.000', '38136', NULL, NULL, '0', '381', '45000', '6864', NULL, NULL, 'JONCTION GOTTIERE [UNITE]', 'B', '2023-09-13 14:18:50', '2023-09-15 17:42:07', NULL),
(14, 336, 9, 1, '50.000', NULL, 95339, 2250, '0.000', '95339', NULL, NULL, '0', '1907', '112500', '17161', NULL, NULL, 'ROBINET PUISSAGE KMEI LY1300 1/2 [UNITE]', 'B', '2023-09-13 14:20:13', '2023-09-15 17:42:24', NULL),
(15, 448, 10, 1, '3.000', NULL, 22881, 9000, '0.000', '22881', NULL, NULL, '0', '7627', '27000', '4119', NULL, NULL, 'PACO PARFAIT G112-AB [UNITE]', 'B', '2023-09-13 14:21:35', '2023-09-15 17:42:40', NULL),
(16, 329, 11, 1, '100.000', NULL, 152542, 1800, '0.000', '152542', NULL, NULL, '0', '1525', '180000', '27458', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-13 14:25:08', '2023-09-15 17:42:58', NULL),
(17, 311, 11, 1, '100.000', NULL, 127119, 1500, '0.000', '127119', NULL, NULL, '0', '1271', '150000', '22881', NULL, NULL, 'ROBINET D\'ARRET 15/21 GRK [UNITE]', 'B', '2023-09-13 14:25:08', '2023-09-15 17:42:58', NULL),
(18, 260, 12, 1, '15.000', NULL, 44491, 3500, '0.000', '44492', NULL, NULL, '0', '2966', '52500', '8008', NULL, NULL, 'MÉCANISME GOLF À POUSSOI [UNITE]', 'B', '2023-09-13 14:26:43', '2023-09-15 17:43:17', NULL),
(19, 261, 12, 1, '15.000', NULL, 38135, 3000, '0.000', '38136', NULL, NULL, '0', '2542', '45000', '6864', NULL, NULL, 'MECANISME PARMA [UNITE]', 'B', '2023-09-13 14:26:43', '2023-09-15 17:43:17', NULL),
(20, 24, 13, 1, '8.000', NULL, 94915, 14000, '0.000', '94915', NULL, NULL, '0', '11864', '112000', '17085', NULL, NULL, 'GRILLAGE TAMI 1M20 [ROULEAU]', 'B', '2023-09-13 14:27:44', '2023-09-15 17:43:35', NULL),
(21, 324, 14, 1, '1.000', NULL, 5084, 6000, '0.000', '5085', NULL, NULL, '0', '5085', '6000', '915', NULL, NULL, 'ROBINET LAVABO INGLAND [UNITE]', 'B', '2023-09-13 14:34:35', '2023-09-15 17:43:54', NULL),
(22, 319, 14, 1, '1.000', NULL, 2542, 3000, '0.000', '2542', NULL, NULL, '0', '2542', '3000', '458', NULL, NULL, 'ROBINET EVIER MURAL [UNITE]', 'B', '2023-09-13 14:34:35', '2023-09-15 17:43:54', NULL),
(23, 276, 14, 1, '1.000', NULL, 1525, 1800, '0.000', '1525', NULL, NULL, '0', '1525', '1800', '275', NULL, NULL, 'PORT SERVIETTE PLASTIQUE GDY60701 [UNITE]', 'B', '2023-09-13 14:34:35', '2023-09-15 17:43:55', NULL),
(24, 272, 14, 1, '1.000', NULL, 1016, 1200, '0.000', '1017', NULL, NULL, '0', '1017', '1200', '183', NULL, NULL, 'PORT SAVON LY7704 KMEI [UNITE]', 'B', '2023-09-13 14:34:35', '2023-09-15 17:43:55', NULL),
(25, 263, 14, 1, '1.000', NULL, 3389, 4000, '0.000', '3390', NULL, NULL, '0', '3390', '4000', '610', NULL, NULL, 'MIROIRE WT-2 [UNITE]', 'B', '2023-09-13 14:34:35', '2023-09-15 17:43:56', NULL),
(26, 266, 14, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, 'PATE À GLACE [UNITE]', 'B', '2023-09-13 14:34:35', '2023-09-15 17:43:57', NULL),
(27, 448, 15, 1, '3.000', NULL, 22881, 9000, '0.000', '22881', NULL, NULL, '0', '7627', '27000', '4119', NULL, NULL, 'PACO PARFAIT G112-AB [UNITE]', 'B', '2023-09-13 15:45:03', '2023-09-15 17:44:16', NULL),
(28, 329, 16, 1, '1.000', NULL, 2118, 2500, '0.000', '2119', NULL, NULL, '0', '2119', '2500', '381', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-13 15:46:07', '2023-09-15 17:44:41', NULL),
(29, 302, 17, 1, '50.000', NULL, 38135, 900, '0.000', '38136', NULL, NULL, '0', '763', '45000', '6864', NULL, NULL, 'RÉDUCTEUR PVC PLAT 110/100 [UNITE]', 'B', '2023-09-13 15:47:35', '2023-09-15 17:45:15', NULL),
(30, 65, 18, 1, '45.000', NULL, 133474, 3500, '0.000', '133475', NULL, NULL, '0', '2966', '157500', '24025', NULL, NULL, 'ABATTAN PARMA  [UNITE]', 'B', '2023-09-13 15:48:42', '2023-09-15 17:45:38', NULL),
(31, 286, 19, 1, '10.000', NULL, 3389, 400, '0.000', '3390', NULL, NULL, '0', '339', '4000', '610', NULL, NULL, 'RACCORD UNION PRESSION 25 [UNITE]', 'B', '2023-09-13 16:19:15', '2023-09-15 17:45:57', NULL),
(32, 208, 19, 1, '5.000', NULL, 2542, 600, '0.000', '2542', NULL, NULL, '0', '508', '3000', '458', NULL, NULL, 'EMBOUT PRESSION 50 [UNITE]', 'B', '2023-09-13 16:19:15', '2023-09-15 17:45:58', NULL),
(33, 209, 19, 1, '3.000', NULL, 3050, 1200, '0.000', '3051', NULL, NULL, '0', '1017', '3600', '549', NULL, NULL, 'EMBOUT PRESSION 63 [UNITE]', 'B', '2023-09-13 16:19:15', '2023-09-15 17:45:58', NULL),
(34, 379, 20, 1, '3.000', NULL, 6355, 2500, '0.000', '6356', NULL, NULL, '0', '2119', '7500', '1144', NULL, NULL, 'TUYAUX PPR 25*4.4 [UNITE]', 'B', '2023-09-13 16:29:06', '2023-09-15 17:46:20', NULL),
(35, 410, 21, 1, '2.000', NULL, 89830, 53000, '0.000', '89831', NULL, NULL, '0', '44915', '106000', '16169', NULL, NULL, 'WC LIMA GRAND [UNITE]', 'B', '2023-09-13 16:30:23', '2023-09-15 17:46:42', NULL),
(36, 311, 22, 1, '10.000', NULL, 13135, 1550, '0.000', '13136', NULL, NULL, '0', '1314', '15500', '2364', NULL, NULL, 'ROBINET D\'ARRET 15/21 GRK [UNITE]', 'B', '2023-09-13 18:42:29', '2023-09-15 17:47:02', NULL),
(37, 329, 22, 1, '10.000', NULL, 15678, 1850, '0.000', '15678', NULL, NULL, '0', '1568', '18500', '2822', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-13 18:42:29', '2023-09-15 17:47:03', NULL),
(38, 313, 22, 1, '10.000', NULL, 19491, 2300, '0.000', '19492', NULL, NULL, '0', '1949', '23000', '3508', NULL, NULL, 'ROBINET D\'ARRETE 20/27 GRK [UNITE]', 'B', '2023-09-13 18:42:29', '2023-09-15 17:47:03', NULL),
(39, 132, 22, 1, '30.000', NULL, 10805, 425, '0.000', '10805', NULL, NULL, '0', '360', '12750', '1945', NULL, NULL, 'COUDE LAITON 15/21 55GRM [UNITE]', 'B', '2023-09-13 18:42:29', '2023-09-15 17:47:04', NULL),
(40, 124, 22, 1, '10.000', NULL, 10593, 1250, '0.000', '10593', NULL, NULL, '0', '1059', '12500', '1907', NULL, NULL, 'COLONNE FIXE EN FER [UNITE]', 'B', '2023-09-13 18:42:29', '2023-09-15 17:47:05', NULL),
(41, 125, 22, 1, '10.000', NULL, 10593, 1250, '0.000', '10593', NULL, NULL, '0', '1059', '12500', '1907', NULL, NULL, 'COLONNE FIXE EN PLASTIC [UNITE]', 'B', '2023-09-13 18:42:29', '2023-09-15 17:47:06', NULL),
(42, 181, 22, 1, '1.000', NULL, 211, 250, '0.000', '212', NULL, NULL, '0', '212', '250', '38', NULL, NULL, 'ECROU LAITON 15/15 [UNITE]', 'B', '2023-09-13 18:42:29', '2023-09-15 17:47:06', NULL),
(43, 305, 23, 1, '10.000', NULL, 10169, 1200, '0.000', '10170', NULL, NULL, '0', '1017', '12000', '1831', NULL, NULL, NULL, NULL, '2023-09-13 18:48:26', '2023-09-15 17:47:34', NULL),
(44, 68, 24, 1, '15.000', NULL, 146186, 11500, '0.000', '146186', NULL, NULL, '0', '9746', '172500', '26314', NULL, NULL, 'ACCESOIRE PARMA [UNITE]', 'B', '2023-09-13 18:53:30', '2023-09-15 17:48:04', NULL),
(45, 431, 25, 1, '18.000', NULL, 64830, 4250, '0.000', '64830', NULL, NULL, '0', '3602', '76500', '11669', NULL, NULL, 'SERRURE G.J.S [UNITE]', 'B', '2023-09-13 18:54:46', '2023-09-15 17:48:41', NULL),
(46, 266, 26, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, 'PATE À GLACE [UNITE]', 'B', '2023-09-13 18:55:55', '2023-09-15 17:49:04', NULL),
(47, 314, 26, 1, '1.000', NULL, 1525, 1800, '0.000', '1525', NULL, NULL, '0', '1525', '1800', '275', NULL, NULL, 'ROBINET DE DOUCHE 8901 [UNITE]', 'B', '2023-09-13 18:55:55', '2023-09-15 17:49:05', NULL),
(48, 329, 27, 1, '30.000', NULL, 47034, 1850, '0.000', '47034', NULL, NULL, '0', '1568', '55500', '8466', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-13 18:56:58', '2023-09-15 17:49:40', NULL),
(49, 121, 28, 1, '20.000', NULL, 3389, 200, '0.000', '3390', NULL, NULL, '0', '169', '4000', '610', NULL, NULL, 'COLLIER PVC 75 [UNITE]', 'B', '2023-09-13 19:00:48', '2023-09-15 17:50:28', NULL),
(50, 329, 29, 1, '20.000', NULL, 31356, 1850, '0.000', '31356', NULL, NULL, '0', '1568', '37000', '5644', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-13 19:01:53', '2023-09-15 17:51:21', NULL),
(51, 181, 30, 1, '100.000', NULL, 20339, 240, '0.000', '20339', NULL, NULL, '0', '203', '24000', '3661', NULL, NULL, 'ECROU LAITON 15/15 [UNITE]', 'B', '2023-09-13 19:05:45', '2023-09-15 17:52:03', NULL),
(52, 238, 30, 1, '100.000', NULL, 19915, 235, '0.000', '19915', NULL, NULL, '0', '199', '23500', '3585', NULL, NULL, 'MAMELON LAITON 15/21 [UNITE]', 'B', '2023-09-13 19:05:45', '2023-09-15 17:52:03', NULL),
(53, 92, 30, 1, '50.000', NULL, 12712, 300, '0.000', '12712', NULL, NULL, '0', '254', '15000', '2288', NULL, NULL, 'BOUCHON PVC 40 [UNITE]', 'B', '2023-09-13 19:05:45', '2023-09-15 17:52:04', NULL),
(54, 93, 30, 1, '50.000', NULL, 16949, 400, '0.000', '16949', NULL, NULL, '0', '339', '20000', '3051', NULL, NULL, 'BOUCHON PVC 50 [UNITE]', 'B', '2023-09-13 19:05:45', '2023-09-15 17:52:05', NULL),
(55, 447, 31, 1, '4.000', NULL, 155932, 46000, '0.000', '155932', NULL, NULL, '0', '38983', '184000', '28068', NULL, NULL, NULL, NULL, '2023-09-13 19:09:13', '2023-09-15 17:52:36', NULL),
(56, 444, 32, 1, '10.000', NULL, 101694, 12000, '0.000', '101695', NULL, NULL, '0', '10169', '120000', '18305', NULL, NULL, NULL, NULL, '2023-09-13 19:10:24', '2023-09-15 17:52:55', NULL),
(57, 225, 33, 1, '12.000', NULL, 35593, 3500, '0.000', '35593', NULL, NULL, '0', '2966', '42000', '6407', NULL, NULL, 'GEBADJOINT [UNITE]', 'B', '2023-09-13 19:25:56', '2023-09-15 17:53:44', NULL),
(58, 301, 33, 1, '100.000', NULL, 59322, 700, '0.000', '59322', NULL, NULL, '0', '593', '70000', '10678', NULL, NULL, 'RÉDUCTEUR PVC PLAT 100/75 [UNITE]', 'B', '2023-09-13 19:25:56', '2023-09-15 17:53:45', NULL),
(59, 423, 34, 1, '12.000', NULL, 26440, 2600, '0.000', '26441', NULL, NULL, '0', '2203', '31200', '4759', NULL, NULL, 'CYLINDRE BUTUC UNIC U70A [UNITE]', 'B', '2023-09-13 19:27:10', '2023-09-15 17:54:16', NULL),
(60, 427, 34, 1, '12.000', NULL, 26440, 2600, '0.000', '26441', NULL, NULL, '0', '2203', '31200', '4759', NULL, NULL, 'CYLINDRE PARFAIT BLEU P70A [UNITE]', 'B', '2023-09-13 19:27:10', '2023-09-15 17:54:16', NULL),
(61, 317, 35, 1, '20.000', NULL, 13559, 800, '0.000', '13559', NULL, NULL, '0', '678', '16000', '2441', NULL, NULL, 'ROBINET EQUERRE GRK [UNITE]', 'B', '2023-09-13 19:28:30', '2023-09-15 17:54:36', NULL),
(62, 329, 35, 1, '10.000', NULL, 15678, 1850, '0.000', '15678', NULL, NULL, '0', '1568', '18500', '2822', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-13 19:28:30', '2023-09-15 17:54:36', NULL),
(63, 68, 36, 1, '5.000', NULL, 50847, 12000, '0.000', '50847', NULL, NULL, '0', '10169', '60000', '9153', NULL, NULL, 'ACCESOIRE PARMA [UNITE]', 'B', '2023-09-13 19:29:25', '2023-09-15 17:54:59', NULL),
(64, 182, 37, 1, '100.000', NULL, 29661, 350, '0.000', '29661', NULL, NULL, '0', '297', '35000', '5339', NULL, NULL, 'ECROU LAITON 15/15 A BAGUE [UNITE]', 'B', '2023-09-13 19:30:14', '2023-09-15 17:55:17', NULL),
(65, 441, 38, 1, '6.000', NULL, 21864, 4300, '0.000', '21864', NULL, NULL, '0', '3644', '25800', '3936', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-13 19:31:41', '2023-09-15 17:55:36', NULL),
(66, 100, 39, 1, '1.000', NULL, 55084, 65000, '0.000', '55085', NULL, NULL, '0', '55085', '65000', '9915', NULL, NULL, 'CHAUFFE-EAU MAXI 15L [UNITE]', 'B', '2023-09-13 19:32:24', '2023-09-15 17:55:54', NULL),
(67, 438, 40, 1, '10.000', NULL, 57203, 6750, '0.000', '57203', NULL, NULL, '0', '5720', '67500', '10297', NULL, NULL, 'LA PERCHE 911B6458 AB WC [UNITE]', 'B', '2023-09-13 19:37:22', '2023-09-15 17:56:13', NULL),
(68, 439, 40, 1, '15.000', NULL, 86440, 6800, '0.000', '86441', NULL, NULL, '0', '5763', '102000', '15559', NULL, NULL, 'LA PERCHE 911B6458 SCR NORMALE [UNITE]', 'B', '2023-09-13 19:37:22', '2023-09-15 17:56:13', NULL),
(69, 441, 40, 1, '15.000', NULL, 54661, 4300, '0.000', '54661', NULL, NULL, '0', '3644', '64500', '9839', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-13 19:37:22', '2023-09-15 17:56:13', NULL),
(70, 453, 40, 1, '4.000', NULL, 38983, 11500, '0.000', '38983', NULL, NULL, '0', '9746', '46000', '7017', NULL, NULL, 'SERRURE PARFAIT A022 [UNITE]', 'B', '2023-09-13 19:37:22', '2023-09-15 17:56:14', NULL),
(71, 435, 40, 1, '5.000', NULL, 19067, 4500, '0.000', '19068', NULL, NULL, '0', '3814', '22500', '3432', NULL, NULL, 'LA PERCHE 9019-F1 SILVER GP [UNITE]', 'B', '2023-09-13 19:37:22', '2023-09-15 17:56:14', NULL),
(72, 418, 40, 1, '6.000', NULL, 20338, 4000, '0.000', '20339', NULL, NULL, '0', '3390', '24000', '3661', NULL, NULL, 'CADENAS VACHETTE  SEMI 75MM [UNITE]', 'B', '2023-09-13 19:37:22', '2023-09-15 17:56:14', NULL),
(73, 449, 40, 1, '4.000', NULL, 35593, 10500, '0.000', '35593', NULL, NULL, '0', '8898', '42000', '6407', NULL, NULL, 'SERRURE PARFAIT à GAGE A007 [UNITE]', 'B', '2023-09-13 19:37:22', '2023-09-15 17:56:14', NULL),
(74, 319, 41, 1, '25.000', NULL, 52966, 2500, '0.000', '52966', NULL, NULL, '0', '2119', '62500', '9534', NULL, NULL, 'ROBINET EVIER MURAL [UNITE]', 'B', '2023-09-13 19:40:38', '2023-09-15 17:56:42', NULL),
(75, 263, 42, 1, '16.000', NULL, 48813, 3600, '0.000', '48814', NULL, NULL, '0', '3051', '57600', '8786', NULL, NULL, 'MIROIRE WT-2 [UNITE]', 'B', '2023-09-13 19:41:24', '2023-09-15 17:57:00', NULL),
(76, 317, 43, 1, '20.000', NULL, 13559, 800, '0.000', '13559', NULL, NULL, '0', '678', '16000', '2441', NULL, NULL, 'ROBINET EQUERRE GRK [UNITE]', 'B', '2023-09-14 07:47:52', '2023-09-15 17:57:17', NULL),
(77, 179, 43, 1, '5.000', NULL, 7627, 1800, '0.000', '7627', NULL, NULL, '0', '1525', '9000', '1373', NULL, NULL, 'ECROU COMPTEUR 20/27 [UNITE]', 'B', '2023-09-14 07:47:53', '2023-09-15 17:57:17', NULL),
(78, 178, 43, 1, '1.000', NULL, 1271, 1500, '0.000', '1271', NULL, NULL, '0', '1271', '1500', '229', NULL, NULL, 'ECROU COMPTEUR 15/21 [UNITE]', 'B', '2023-09-14 07:47:53', '2023-09-15 17:57:18', NULL),
(79, 243, 44, 1, '100.000', NULL, 25424, 300, '0.000', '25424', NULL, NULL, '0', '254', '30000', '4576', NULL, NULL, 'MANCHON LAITON 15/21 [UNITE]', 'B', '2023-09-14 07:50:05', '2023-09-15 17:57:40', NULL),
(80, 129, 44, 1, '10.000', NULL, 55084, 6500, '0.000', '55085', NULL, NULL, '0', '5508', '65000', '9915', NULL, NULL, 'COMPTEUR LAITON 20/27 GRK [UNITE]', 'B', '2023-09-14 07:50:05', '2023-09-15 17:57:40', NULL),
(81, 329, 44, 1, '40.000', NULL, 61016, 1800, '0.000', '61017', NULL, NULL, '0', '1525', '72000', '10983', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-14 07:50:05', '2023-09-15 17:57:41', NULL),
(82, 267, 45, 1, '10.000', NULL, 21186, 2500, '0.000', '21186', NULL, NULL, '0', '2119', '25000', '3814', NULL, NULL, 'PATIN 15/21 [SACHET]', 'B', '2023-09-14 07:51:10', '2023-09-15 17:58:00', NULL),
(83, 232, 45, 1, '1.000', NULL, 29661, 35000, '0.000', '29661', NULL, NULL, '0', '29661', '35000', '5339', NULL, NULL, 'LAVABO LIMA LUXE [UNITE]', 'B', '2023-09-14 07:51:10', '2023-09-15 17:58:00', NULL),
(84, 271, 46, 1, '50.000', NULL, 52966, 1250, '0.000', '52966', NULL, NULL, '0', '1059', '62500', '9534', NULL, NULL, 'PORT PAPIER SC [UNITE]', 'B', '2023-09-14 07:52:03', '2023-09-15 17:58:25', NULL),
(85, 423, 47, 1, '1.000', NULL, 2033, 2600, '47.000', '2034', NULL, NULL, '0', '2034', '2400', '366', NULL, NULL, NULL, NULL, '2023-09-14 07:55:01', NULL, NULL),
(86, 276, 48, 1, '4.000', NULL, 4915, 1450, '0.000', '4915', NULL, NULL, '0', '1229', '5800', '885', NULL, NULL, 'PORT SERVIETTE PLASTIQUE GDY60701 [UNITE]', 'B', '2023-09-14 07:55:49', '2023-09-15 17:58:45', NULL),
(87, 329, 48, 1, '4.000', NULL, 6271, 1850, '0.000', '6271', NULL, NULL, '0', '1568', '7400', '1129', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-14 07:55:49', '2023-09-15 17:58:45', NULL),
(88, 124, 48, 1, '4.000', NULL, 4237, 1250, '0.000', '4237', NULL, NULL, '0', '1059', '5000', '763', NULL, NULL, 'COLONNE FIXE EN FER [UNITE]', 'B', '2023-09-14 07:55:49', '2023-09-15 17:58:46', NULL),
(89, 314, 48, 1, '4.000', NULL, 6101, 1800, '0.000', '6102', NULL, NULL, '0', '1525', '7200', '1098', NULL, NULL, 'ROBINET DE DOUCHE 8901 [UNITE]', 'B', '2023-09-14 07:55:49', '2023-09-15 17:58:46', NULL),
(90, 324, 48, 1, '4.000', NULL, 15254, 4500, '0.000', '15254', NULL, NULL, '0', '3814', '18000', '2746', NULL, NULL, 'ROBINET LAVABO INGLAND [UNITE]', 'B', '2023-09-14 07:55:49', '2023-09-15 17:58:47', NULL),
(91, 378, 49, 1, '2.000', NULL, 13559, 8000, '0.000', '13559', NULL, NULL, '0', '6780', '16000', '2441', NULL, NULL, 'TUYAUX GOUTTIERE  [UNITE]', 'B', '2023-09-14 07:59:32', '2023-09-15 17:59:09', NULL),
(92, 111, 49, 1, '2.000', NULL, 1186, 700, '0.000', '1186', NULL, NULL, '0', '593', '1400', '214', NULL, NULL, 'COLLIER GOUTTIERE [UNITE]', 'B', '2023-09-14 07:59:32', '2023-09-15 17:59:09', NULL),
(93, 231, 49, 1, '2.000', NULL, 1101, 650, '0.000', '1102', NULL, NULL, '0', '551', '1300', '198', NULL, NULL, 'JONCTION GOTTIERE [UNITE]', 'B', '2023-09-14 07:59:32', '2023-09-15 17:59:09', NULL),
(94, 223, 49, 1, '1.000', NULL, 593, 700, '0.000', '593', NULL, NULL, '0', '593', '700', '107', NULL, NULL, 'FOND GOUTTIERE  [UNITE]', 'B', '2023-09-14 07:59:32', '2023-09-15 17:59:10', NULL),
(95, 265, 49, 1, '1.000', NULL, 2542, 3000, '0.000', '2542', NULL, NULL, '0', '2542', '3000', '458', NULL, NULL, 'NAISSANCE [UNITE]', 'B', '2023-09-14 07:59:32', '2023-09-15 17:59:11', NULL),
(96, 224, 49, 1, '1.000', NULL, 593, 700, '0.000', '593', NULL, NULL, '0', '593', '700', '107', NULL, NULL, 'FOND NAISSANCE [UNITE]', 'B', '2023-09-14 07:59:32', '2023-09-15 17:59:11', NULL),
(97, 378, 50, 1, '40.000', NULL, 237288, 7000, '0.000', '237288', NULL, NULL, '0', '5932', '280000', '42712', NULL, NULL, 'TUYAUX GOUTTIERE  [UNITE]', 'B', '2023-09-14 08:02:14', '2023-09-15 17:59:30', NULL),
(98, 265, 50, 1, '10.000', NULL, 22881, 2700, '0.000', '22881', NULL, NULL, '0', '2288', '27000', '4119', NULL, NULL, 'NAISSANCE [UNITE]', 'B', '2023-09-14 08:02:14', '2023-09-15 17:59:30', NULL),
(99, 278, 50, 1, '30.000', NULL, 47034, 1850, '0.000', '47034', NULL, NULL, '0', '1568', '55500', '8466', NULL, NULL, 'PUISSAGE KMEI LY303 1/2 [UNITE]', 'B', '2023-09-14 08:02:14', '2023-09-15 17:59:31', NULL),
(100, 61, 51, 1, '4.000', NULL, 57627, 17000, '0.000', '57627', NULL, NULL, '0', '14407', '68000', '10373', NULL, NULL, 'RACCORD D\'EAU JAUNE [ROULEAU]', 'B', '2023-09-14 08:05:50', '2023-09-15 17:59:49', NULL),
(101, 62, 51, 1, '1.000', NULL, 14406, 17000, '0.000', '14407', NULL, NULL, '0', '14407', '17000', '2593', NULL, NULL, 'RACCORD D\'EAU VERT [ROULEAU]', 'B', '2023-09-14 08:05:50', '2023-09-15 17:59:49', NULL),
(102, 186, 52, 1, '20.000', NULL, 3813, 225, '0.000', '3814', NULL, NULL, '0', '191', '4500', '686', NULL, NULL, 'ECROU LAITON REDUIT 15/12 [UNITE]', 'B', '2023-09-14 08:07:06', '2023-09-15 18:00:08', NULL),
(103, 213, 53, 1, '4.000', NULL, 2542, 750, '0.000', '2542', NULL, NULL, '0', '636', '3000', '458', NULL, NULL, 'FLEXIBLE INOX LAVABO EN FER [UNITE]', 'B', '2023-09-14 08:08:58', '2023-09-15 18:00:25', NULL),
(104, 317, 53, 1, '4.000', NULL, 2542, 750, '0.000', '2542', NULL, NULL, '0', '636', '3000', '458', NULL, NULL, 'ROBINET EQUERRE GRK [UNITE]', 'B', '2023-09-14 08:08:58', '2023-09-15 18:00:25', NULL),
(105, 226, 53, 1, '4.000', NULL, 1525, 450, '0.000', '1525', NULL, NULL, '0', '381', '1800', '275', NULL, NULL, 'GOURGEON LAVABO GRAND [UNITE]', 'B', '2023-09-14 08:08:58', '2023-09-15 18:00:26', NULL),
(106, 329, 54, 1, '30.000', NULL, 47034, 1850, '0.000', '47034', NULL, NULL, '0', '1568', '55500', '8466', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-14 08:13:05', '2023-09-15 18:00:42', NULL),
(107, 260, 54, 1, '7.000', NULL, 20762, 3500, '0.000', '20763', NULL, NULL, '0', '2966', '24500', '3737', NULL, NULL, 'MÉCANISME GOLF À POUSSOI [UNITE]', 'B', '2023-09-14 08:13:05', '2023-09-15 18:00:43', NULL),
(108, 261, 54, 1, '15.000', NULL, 38135, 3000, '0.000', '38136', NULL, NULL, '0', '2542', '45000', '6864', NULL, NULL, 'MECANISME PARMA [UNITE]', 'B', '2023-09-14 08:13:05', '2023-09-15 18:00:43', NULL),
(109, 445, 54, 1, '1.000', NULL, 22033, 26000, '0.000', '22034', NULL, NULL, '0', '22034', '26000', '3966', NULL, NULL, 'MICC 202 [CARTON]', 'B', '2023-09-14 08:13:05', '2023-09-15 18:00:44', NULL),
(110, 375, 54, 1, '20.000', NULL, 13559, 800, '0.000', '13559', NULL, NULL, '0', '678', '16000', '2441', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-14 08:13:05', '2023-09-15 18:00:45', NULL),
(111, 423, 55, 1, '30.000', NULL, 66101, 2600, '0.000', '66102', NULL, NULL, '0', '2203', '78000', '11898', NULL, NULL, NULL, NULL, '2023-09-14 08:17:21', '2023-09-15 18:01:23', NULL),
(112, 427, 55, 1, '30.000', NULL, 66101, 2600, '0.000', '66102', NULL, NULL, '0', '2203', '78000', '11898', NULL, NULL, NULL, NULL, '2023-09-14 08:17:21', '2023-09-15 18:01:23', NULL),
(113, 65, 56, 1, '13.000', NULL, 44067, 4000, '0.000', '44068', NULL, NULL, '0', '3390', '52000', '7932', NULL, NULL, NULL, NULL, '2023-09-14 08:20:58', '2023-09-15 18:01:52', NULL),
(114, 329, 57, 1, '100.000', NULL, 156780, 1850, '57.000', '156780', NULL, NULL, '0', '1568', '185000', '28220', NULL, NULL, NULL, NULL, '2023-09-14 08:25:32', NULL, NULL),
(115, 349, 58, 1, '1.000', NULL, 508, 600, '0.000', '508', NULL, NULL, '0', '508', '600', '92', NULL, NULL, 'TÉ LAITON 15/21 [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:11', NULL),
(116, 182, 58, 1, '4.000', NULL, 1355, 400, '0.000', '1356', NULL, NULL, '0', '339', '1600', '244', NULL, NULL, 'ECROU LAITON 15/15 A BAGUE [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:12', NULL),
(117, 147, 58, 1, '4.000', NULL, 2372, 700, '0.000', '2373', NULL, NULL, '0', '593', '2800', '427', NULL, NULL, 'COUDE PPR TARODÉ 25*1/2 FEMELLE [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:13', NULL),
(118, 194, 58, 1, '4.000', NULL, 2372, 700, '0.000', '2373', NULL, NULL, '0', '593', '2800', '427', NULL, NULL, 'EMBOUT PPR TARODÉ 25*1/2 MALE [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:13', NULL),
(119, 238, 58, 1, '4.000', NULL, 1016, 300, '0.000', '1017', NULL, NULL, '0', '254', '1200', '183', NULL, NULL, 'MAMELON LAITON 15/21 [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:14', NULL),
(120, 188, 58, 1, '4.000', NULL, 1016, 300, '0.000', '1017', NULL, NULL, '0', '254', '1200', '183', NULL, NULL, 'ECROU MIX 15/21 [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:14', NULL),
(121, 141, 58, 1, '8.000', NULL, 1355, 200, '0.000', '1356', NULL, NULL, '0', '169', '1600', '244', NULL, NULL, 'COUDE PPR 25 [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:15', NULL),
(122, 264, 58, 1, '1.000', NULL, 16949, 20000, '0.000', '16949', NULL, NULL, '0', '16949', '20000', '3051', NULL, NULL, 'MITIGEUR DOUCHE FIRMER SP22040001 [UNITE]', 'B', '2023-09-14 08:26:20', '2023-09-15 18:02:16', NULL),
(123, 319, 59, 1, '40.000', NULL, 84745, 2500, '0.000', '84746', NULL, NULL, '0', '2119', '100000', '15254', NULL, NULL, 'ROBINET EVIER MURAL [UNITE]', 'B', '2023-09-14 08:27:40', '2023-09-15 18:02:35', NULL),
(124, 161, 60, 1, '15.000', NULL, 13983, 1100, '0.000', '13983', NULL, NULL, '0', '932', '16500', '2517', NULL, NULL, NULL, NULL, '2023-09-14 08:36:01', '2023-09-15 18:02:58', NULL),
(125, 2, 61, 1, '90.000', NULL, 137287, 1800, '0.000', '137288', NULL, NULL, '0', '1525', '162000', '24712', NULL, NULL, NULL, NULL, '2023-09-14 08:36:53', '2023-09-15 18:03:18', NULL),
(126, 428, 62, 1, '10.000', NULL, 54237, 6400, '0.000', '54237', NULL, NULL, '0', '5424', '64000', '9763', NULL, NULL, NULL, NULL, '2023-09-14 08:37:25', '2023-09-15 18:03:44', NULL),
(127, 186, 63, 1, '50.000', NULL, 9534, 225, '0.000', '9534', NULL, NULL, '0', '191', '11250', '1716', NULL, NULL, 'ECROU LAITON REDUIT 15/12 [UNITE]', 'B', '2023-09-14 08:40:54', '2023-09-15 18:04:01', NULL),
(128, 423, 64, 1, '18.000', NULL, 39661, 2600, '0.000', '39661', NULL, NULL, '0', '2203', '46800', '7139', NULL, NULL, NULL, NULL, '2023-09-14 08:42:54', '2023-09-15 18:04:22', NULL),
(129, 427, 64, 1, '18.000', NULL, 39661, 2600, '0.000', '39661', NULL, NULL, '0', '2203', '46800', '7139', NULL, NULL, NULL, NULL, '2023-09-14 08:42:54', '2023-09-15 18:04:22', NULL),
(130, 422, 64, 1, '12.000', NULL, 26440, 2600, '0.000', '26441', NULL, NULL, '0', '2203', '31200', '4759', NULL, NULL, NULL, NULL, '2023-09-14 08:42:54', '2023-09-15 18:04:23', NULL),
(131, 329, 65, 1, '10.000', NULL, 15678, 1850, '0.000', '15678', NULL, NULL, '0', '1568', '18500', '2822', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-14 08:53:57', '2023-09-15 18:04:59', NULL),
(132, 293, 65, 1, '1.000', NULL, 127, 150, '0.000', '127', NULL, NULL, '0', '127', '150', '23', NULL, NULL, 'RÉDUCTEUR PRESSION 25*20 [UNITE]', 'B', '2023-09-14 08:53:57', '2023-09-15 18:05:00', NULL),
(133, 236, 66, 1, '6.000', NULL, 35593, 7000, '0.000', '35593', NULL, NULL, '0', '5932', '42000', '6407', NULL, NULL, 'LAVE MAIN PARMA [UNITE]', 'B', '2023-09-14 08:55:19', '2023-09-15 18:05:31', NULL),
(134, 264, 67, 1, '1.000', NULL, 21186, 25000, '0.000', '21186', NULL, NULL, '0', '21186', '25000', '3814', NULL, NULL, NULL, NULL, '2023-09-14 09:20:47', '2023-09-15 18:05:49', NULL),
(135, 329, 68, 1, '20.000', NULL, 31356, 1850, '0.000', '31356', NULL, NULL, '0', '1568', '37000', '5644', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:15', NULL),
(136, 311, 68, 1, '10.000', NULL, 13135, 1550, '0.000', '13136', NULL, NULL, '0', '1314', '15500', '2364', NULL, NULL, 'ROBINET D\'ARRET 15/21 GRK [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:16', NULL),
(137, 181, 68, 1, '50.000', NULL, 10593, 250, '0.000', '10593', NULL, NULL, '0', '212', '12500', '1907', NULL, NULL, 'ECROU LAITON 15/15 [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:16', NULL),
(138, 238, 68, 1, '50.000', NULL, 10169, 240, '0.000', '10170', NULL, NULL, '0', '203', '12000', '1831', NULL, NULL, 'MAMELON LAITON 15/21 [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:17', NULL),
(139, 317, 68, 1, '20.000', NULL, 12711, 750, '0.000', '12712', NULL, NULL, '0', '636', '15000', '2288', NULL, NULL, 'ROBINET EQUERRE GRK [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:17', NULL),
(140, 215, 68, 1, '10.000', NULL, 6355, 750, '0.000', '6356', NULL, NULL, '0', '636', '7500', '1144', NULL, NULL, 'FLEXIBLE INOX WC EN FER [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:18', NULL),
(141, 213, 68, 1, '10.000', NULL, 6355, 750, '0.000', '6356', NULL, NULL, '0', '636', '7500', '1144', NULL, NULL, 'FLEXIBLE INOX LAVABO EN FER [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:19', NULL),
(142, 236, 68, 1, '1.000', NULL, 5932, 7000, '0.000', '5932', NULL, NULL, '0', '5932', '7000', '1068', NULL, NULL, 'LAVE MAIN PARMA [UNITE]', 'B', '2023-09-14 09:37:24', '2023-09-15 18:06:19', NULL),
(143, 457, 69, 1, '1.000', NULL, 19067, 22500, '0.000', '19068', NULL, NULL, '0', '19068', '22500', '3432', NULL, NULL, 'PAUMELLE AGA 140 [CARTON]', 'B', '2023-09-14 09:38:49', '2023-09-15 18:07:17', NULL),
(144, 92, 70, 1, '15.000', NULL, 3813, 300, '0.000', '3814', NULL, NULL, '0', '254', '4500', '686', NULL, NULL, NULL, NULL, '2023-09-14 09:40:10', '2023-09-15 18:08:18', NULL),
(145, 93, 70, 1, '15.000', NULL, 5084, 400, '0.000', '5085', NULL, NULL, '0', '339', '6000', '915', NULL, NULL, NULL, NULL, '2023-09-14 09:40:10', '2023-09-15 18:08:18', NULL),
(146, 266, 71, 1, '42.000', NULL, 23135, 650, '0.000', '23136', NULL, NULL, '0', '551', '27300', '4164', NULL, NULL, 'PATE À GLACE [UNITE]', 'B', '2023-09-14 09:50:24', '2023-09-15 18:08:58', NULL),
(147, 429, 71, 1, '1.000', NULL, 19491, 23000, '0.000', '19492', NULL, NULL, '0', '19492', '23000', '3508', NULL, NULL, 'EVERLEO [BOITE]', 'B', '2023-09-14 09:50:24', '2023-09-15 18:08:58', NULL),
(148, 165, 72, 1, '10.000', NULL, 1694, 200, '0.000', '1695', NULL, NULL, '0', '169', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-14 09:54:39', '2023-09-15 18:09:25', NULL),
(149, 71, 72, 1, '5.000', NULL, 16949, 4000, '0.000', '16949', NULL, NULL, '0', '3390', '20000', '3051', NULL, NULL, NULL, NULL, '2023-09-14 09:54:39', '2023-09-15 18:09:26', NULL),
(150, 132, 72, 1, '10.000', NULL, 4237, 500, '0.000', '4237', NULL, NULL, '0', '424', '5000', '763', NULL, NULL, NULL, NULL, '2023-09-14 09:54:39', '2023-09-15 18:09:26', NULL),
(151, 238, 72, 1, '20.000', NULL, 5084, 300, '0.000', '5085', NULL, NULL, '0', '254', '6000', '915', NULL, NULL, NULL, NULL, '2023-09-14 09:54:39', '2023-09-15 18:09:27', NULL),
(152, 295, 72, 1, '5.000', NULL, 1271, 300, '0.000', '1271', NULL, NULL, '0', '254', '1500', '229', NULL, NULL, NULL, NULL, '2023-09-14 09:54:39', '2023-09-15 18:09:27', NULL),
(153, 326, 72, 1, '2.000', NULL, 25423, 15000, '0.000', '25424', NULL, NULL, '0', '12712', '30000', '4576', NULL, NULL, NULL, NULL, '2023-09-14 09:54:39', '2023-09-15 18:09:28', NULL),
(154, 99, 73, 1, '1.000', NULL, 67796, 80000, '0.000', '67797', NULL, NULL, '0', '67797', '80000', '12203', NULL, NULL, NULL, NULL, '2023-09-14 09:59:32', '2023-09-15 18:10:29', NULL),
(155, 188, 73, 1, '4.000', NULL, 1016, 300, '0.000', '1017', NULL, NULL, '0', '254', '1200', '183', NULL, NULL, NULL, NULL, '2023-09-14 09:59:32', '2023-09-15 18:10:30', NULL),
(156, 24, 74, 1, '6.000', NULL, 71186, 14000, '0.000', '71186', NULL, NULL, '0', '11864', '84000', '12814', NULL, NULL, NULL, NULL, '2023-09-14 10:00:47', '2023-09-15 18:10:50', NULL),
(157, 121, 75, 1, '6.000', NULL, 1398, 275, '0.000', '1398', NULL, NULL, '0', '233', '1650', '252', NULL, NULL, NULL, NULL, '2023-09-14 10:06:13', '2023-09-15 18:11:33', NULL),
(158, 60, 76, 1, '3.000', NULL, 43220, 17000, '0.000', '43220', NULL, NULL, '0', '14407', '51000', '7780', NULL, NULL, NULL, NULL, '2023-09-14 10:09:57', '2023-09-15 18:12:07', NULL),
(159, 62, 76, 1, '4.000', NULL, 57627, 17000, '0.000', '57627', NULL, NULL, '0', '14407', '68000', '10373', NULL, NULL, NULL, NULL, '2023-09-14 10:09:57', '2023-09-15 18:12:07', NULL),
(160, 61, 76, 1, '3.000', NULL, 43220, 17000, '0.000', '43220', NULL, NULL, '0', '14407', '51000', '7780', NULL, NULL, NULL, NULL, '2023-09-14 10:09:57', '2023-09-15 18:12:07', NULL),
(161, 225, 76, 1, '60.000', NULL, 177966, 3500, '0.000', '177966', NULL, NULL, '0', '2966', '210000', '32034', NULL, NULL, NULL, NULL, '2023-09-14 10:09:57', '2023-09-15 18:12:08', NULL),
(162, 141, 77, 1, '50.000', NULL, 4237, 100, '0.000', '4238', NULL, NULL, '0', '85', '5000', '763', NULL, NULL, 'COUDE PPR 25 [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:49', NULL),
(163, 353, 77, 1, '20.000', NULL, 1695, 100, '0.000', '1695', NULL, NULL, '0', '85', '2000', '305', NULL, NULL, 'TÉ PPR 25 [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:50', NULL),
(164, 147, 77, 1, '31.000', NULL, 13135, 500, '0.000', '13136', NULL, NULL, '0', '424', '15500', '2364', NULL, NULL, 'COUDE PPR TARODÉ 25*1/2 FEMELLE [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:51', NULL),
(165, 360, 77, 1, '2.000', NULL, 1016, 600, '0.000', '1017', NULL, NULL, '0', '508', '1200', '183', NULL, NULL, 'TÉ PPR TARODÉ 25*1/2FEMELLE [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:51', NULL),
(166, 197, 77, 1, '5.000', NULL, 3813, 900, '0.000', '3814', NULL, NULL, '0', '763', '4500', '686', NULL, NULL, 'EMBOUT PPR TARODÉ 32*1\" FEMELLE [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:52', NULL),
(167, 198, 77, 1, '5.000', NULL, 3813, 900, '0.000', '3814', NULL, NULL, '0', '763', '4500', '686', NULL, NULL, 'EMBOUT PPR TARODÉ 32*1\" MÂLE [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:52', NULL),
(168, 142, 77, 1, '6.000', NULL, 762, 150, '0.000', '763', NULL, NULL, '0', '127', '900', '137', NULL, NULL, 'COUDE PPR 32 [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:53', NULL),
(169, 354, 77, 1, '5.000', NULL, 847, 200, '0.000', '847', NULL, NULL, '0', '169', '1000', '153', NULL, NULL, 'TÉ PPR 32 [UNITE]', 'B', '2023-09-14 13:03:08', '2023-09-15 18:12:54', NULL),
(170, 165, 78, 1, '20.000', NULL, 3389, 200, '0.000', '3390', NULL, NULL, '0', '169', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:16', NULL),
(171, 299, 78, 1, '3.000', NULL, 2542, 1000, '0.000', '2542', NULL, NULL, '0', '847', '3000', '458', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:16', NULL),
(172, 104, 78, 1, '1.000', NULL, 5084, 6000, '0.000', '5085', NULL, NULL, '0', '5085', '6000', '915', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:17', NULL),
(173, 141, 78, 1, '30.000', NULL, 2542, 100, '0.000', '2543', NULL, NULL, '0', '85', '3000', '458', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:17', NULL),
(174, 147, 78, 1, '20.000', NULL, 8474, 500, '0.000', '8475', NULL, NULL, '0', '424', '10000', '1525', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:18', NULL),
(175, 353, 78, 1, '10.000', NULL, 847, 100, '0.000', '848', NULL, NULL, '0', '85', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:19', NULL),
(176, 399, 78, 1, '5.000', NULL, 10593, 2500, '0.000', '10593', NULL, NULL, '0', '2119', '12500', '1907', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:19', NULL),
(177, 360, 78, 1, '3.000', NULL, 1525, 600, '0.000', '1525', NULL, NULL, '0', '508', '1800', '275', NULL, NULL, NULL, NULL, '2023-09-14 13:11:05', '2023-09-15 18:13:20', NULL),
(178, 329, 79, 1, '10.000', NULL, 15678, 1850, '0.000', '15678', NULL, NULL, '0', '1568', '18500', '2822', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-14 13:25:10', '2023-09-15 18:13:48', NULL),
(179, 336, 79, 1, '25.000', NULL, 48728, 2300, '0.000', '48729', NULL, NULL, '0', '1949', '57500', '8771', NULL, NULL, 'ROBINET PUISSAGE KMEI LY1300 1/2 [UNITE]', 'B', '2023-09-14 13:25:10', '2023-09-15 18:13:49', NULL),
(180, 384, 79, 1, '5.000', NULL, 25423, 6000, '0.000', '25424', NULL, NULL, '0', '5085', '30000', '4576', NULL, NULL, 'VANNE À BOISSEAU 61511-1\"/1/4 GRK [UNITE]', 'B', '2023-09-14 13:25:10', '2023-09-15 18:13:49', NULL),
(181, 437, 80, 1, '10.000', NULL, 57203, 6750, '0.000', '57203', NULL, NULL, '0', '5720', '67500', '10297', NULL, NULL, 'LA PERCHE 911B6458 AB NORMALE [UNITE]', 'B', '2023-09-14 13:26:59', '2023-09-15 18:14:09', NULL),
(182, 108, 81, 1, '1.000', NULL, 5084, 6000, '0.000', '5085', NULL, NULL, '0', '5085', '6000', '915', NULL, NULL, 'COLLIER ATELAS 64010-25 [UNITE]', 'B', '2023-09-14 13:28:07', '2023-09-15 18:14:27', NULL),
(183, 181, 82, 1, '1.000', NULL, 423, 500, '0.000', '424', NULL, NULL, '0', '424', '500', '76', NULL, NULL, 'ECROU LAITON 15/15 [UNITE]', 'B', '2023-09-14 13:28:42', '2023-09-15 18:14:50', NULL),
(184, 264, 83, 1, '1.000', NULL, 21186, 25000, '0.000', '21186', NULL, NULL, '0', '21186', '25000', '3814', NULL, NULL, 'MITIGEUR DOUCHE FIRMER SP22040001 [UNITE]', 'B', '2023-09-14 13:29:37', '2023-09-15 18:15:20', NULL),
(185, 375, 84, 1, '50.000', NULL, 33898, 800, '0.000', '33899', NULL, NULL, '0', '678', '40000', '6102', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-14 13:31:35', '2023-09-15 18:15:42', NULL),
(186, 376, 84, 1, '25.000', NULL, 20127, 950, '0.000', '20127', NULL, NULL, '0', '805', '23750', '3623', NULL, NULL, 'TETE ROBINET 20/27 GRK [UNITE]', 'B', '2023-09-14 13:31:35', '2023-09-15 18:15:42', NULL),
(187, 426, 84, 1, '1.000', NULL, 10593, 12500, '0.000', '10593', NULL, NULL, '0', '10593', '12500', '1907', NULL, NULL, 'CYLINDRE LA PERCHE BLEU 60M  [DOUZAINE]', 'B', '2023-09-14 13:31:35', '2023-09-15 18:15:43', NULL),
(188, 266, 84, 1, '43.000', NULL, 23686, 650, '0.000', '23687', NULL, NULL, '0', '551', '27950', '4264', NULL, NULL, 'PATE À GLACE [UNITE]', 'B', '2023-09-14 13:31:35', '2023-09-15 18:15:44', NULL),
(189, 441, 84, 1, '6.000', NULL, 21864, 4300, '0.000', '21864', NULL, NULL, '0', '3644', '25800', '3936', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-14 13:31:35', '2023-09-15 18:15:45', NULL),
(190, 441, 85, 1, '144.000', NULL, 512542, 4200, '0.000', '512542', NULL, NULL, '0', '3559', '604800', '92258', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-14 13:51:16', '2023-09-15 18:16:30', NULL),
(191, 426, 85, 1, '20.000', NULL, 211864, 12500, '0.000', '211864', NULL, NULL, '0', '10593', '250000', '38136', NULL, NULL, 'CYLINDRE LA PERCHE BLEU 60M  [DOUZAINE]', 'B', '2023-09-14 13:51:16', '2023-09-15 18:16:30', NULL),
(192, 23, 85, 1, '5.000', NULL, 199152, 47000, '0.000', '199153', NULL, NULL, '0', '39831', '235000', '35847', NULL, NULL, 'GRILLAGE LAPIN GALVANISÉ 25M ORIGINAL [ROULEAU]', 'B', '2023-09-14 13:51:16', '2023-09-15 18:16:30', NULL),
(193, 276, 86, 1, '46.000', NULL, 56525, 1450, '0.000', '56525', NULL, NULL, '0', '1229', '66700', '10175', NULL, NULL, 'PORT SERVIETTE PLASTIQUE GDY60701 [UNITE]', 'B', '2023-09-14 13:52:21', '2023-09-15 18:17:05', NULL),
(194, 215, 87, 1, '10.000', NULL, 6355, 750, '0.000', '6356', NULL, NULL, '0', '636', '7500', '1144', NULL, NULL, 'FLEXIBLE INOX WC EN FER [UNITE]', 'B', '2023-09-14 13:54:04', '2023-09-15 18:17:42', NULL),
(195, 213, 87, 1, '10.000', NULL, 6355, 750, '0.000', '6356', NULL, NULL, '0', '636', '7500', '1144', NULL, NULL, 'FLEXIBLE INOX LAVABO EN FER [UNITE]', 'B', '2023-09-14 13:54:04', '2023-09-15 18:17:42', NULL),
(196, 317, 87, 1, '10.000', NULL, 6355, 750, '0.000', '6356', NULL, NULL, '0', '636', '7500', '1144', NULL, NULL, 'ROBINET EQUERRE GRK [UNITE]', 'B', '2023-09-14 13:54:04', '2023-09-15 18:17:43', NULL),
(197, 375, 88, 1, '50.000', NULL, 31779, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-14 13:55:14', '2023-09-15 18:18:07', NULL),
(198, 266, 89, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, 'PATE À GLACE [UNITE]', 'B', '2023-09-14 14:08:40', '2023-09-15 18:18:47', NULL),
(199, 431, 90, 1, '2.000', NULL, 7288, 4300, '0.000', '7288', NULL, NULL, '0', '3644', '8600', '1312', NULL, NULL, 'SERRURE G.J.S [UNITE]', 'B', '2023-09-14 14:11:04', '2023-09-15 18:19:20', NULL),
(200, 429, 91, 1, '1.000', NULL, 19491, 23000, '0.000', '19492', NULL, NULL, '0', '19492', '23000', '3508', NULL, NULL, 'EVERLEO [BOITE]', 'B', '2023-09-14 14:11:52', '2023-09-15 18:19:37', NULL),
(201, 114, 92, 1, '300.000', NULL, 69915, 275, '0.000', '69915', NULL, NULL, '0', '233', '82500', '12585', NULL, NULL, 'COLLIER INOX 32 [UNITE]', 'B', '2023-09-14 14:13:12', '2023-09-15 18:19:56', NULL),
(202, 336, 92, 1, '10.000', NULL, 19491, 2300, '0.000', '19492', NULL, NULL, '0', '1949', '23000', '3508', NULL, NULL, 'ROBINET PUISSAGE KMEI LY1300 1/2 [UNITE]', 'B', '2023-09-14 14:13:12', '2023-09-15 18:19:57', NULL),
(203, 132, 93, 1, '40.000', NULL, 14406, 425, '0.000', '14407', NULL, NULL, '0', '360', '17000', '2593', NULL, NULL, 'COUDE LAITON 15/21 55GRM [UNITE]', 'B', '2023-09-14 14:58:50', '2023-09-15 18:20:22', NULL),
(204, 312, 94, 1, '20.000', NULL, 67796, 4000, '0.000', '67797', NULL, NULL, '0', '3390', '80000', '12203', NULL, NULL, 'ROBINET D\'ARRET GRK 26/34 [UNITE]', 'B', '2023-09-14 15:44:19', '2023-09-15 18:20:42', NULL),
(205, 181, 94, 1, '1000.000', NULL, 207630, 245, '0.000', '207630', NULL, NULL, '0', '208', '245000', '37370', NULL, NULL, 'ECROU LAITON 15/15 [UNITE]', 'B', '2023-09-14 15:44:19', '2023-09-15 18:20:43', NULL),
(206, 185, 94, 1, '200.000', NULL, 33898, 200, '0.000', '33898', NULL, NULL, '0', '169', '40000', '6102', NULL, NULL, 'ECROU LAITON REDUIT 12/12 [UNITE]', 'B', '2023-09-14 15:44:19', '2023-09-15 18:20:43', NULL),
(207, 260, 94, 1, '100.000', NULL, 296610, 3500, '0.000', '296610', NULL, NULL, '0', '2966', '350000', '53390', NULL, NULL, 'MÉCANISME GOLF À POUSSOI [UNITE]', 'B', '2023-09-14 15:44:19', '2023-09-15 18:20:44', NULL),
(208, 336, 95, 1, '160.000', NULL, 298305, 2200, '0.000', '298306', NULL, NULL, '0', '1864', '352000', '53694', NULL, NULL, NULL, NULL, '2023-09-14 15:46:58', '2023-09-15 18:21:02', NULL),
(209, 134, 96, 1, '100.000', NULL, 93220, 1100, '0.000', '93220', NULL, NULL, '0', '932', '110000', '16780', NULL, NULL, 'COUDE LAITON 26/34 [UNITE]', 'B', '2023-09-14 15:52:31', '2023-09-15 18:21:19', NULL),
(210, 245, 96, 1, '90.000', NULL, 64830, 850, '0.000', '64831', NULL, NULL, '0', '720', '76500', '11669', NULL, NULL, 'MANCHON LAITON 26/34 [UNITE]', 'B', '2023-09-14 15:52:31', '2023-09-15 18:21:19', NULL),
(211, 375, 96, 1, '300.000', NULL, 184323, 725, '0.000', '184323', NULL, NULL, '0', '614', '217500', '33177', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-14 15:52:31', '2023-09-15 18:21:20', NULL),
(212, 184, 96, 1, '50.000', NULL, 25423, 600, '0.000', '25424', NULL, NULL, '0', '508', '30000', '4576', NULL, NULL, 'ECROU LAITON 26/20 [UNITE]', 'B', '2023-09-14 15:52:31', '2023-09-15 18:21:20', NULL),
(213, 457, 97, 1, '4.000', NULL, 72881, 21500, '0.000', '72881', NULL, NULL, '0', '18220', '86000', '13119', NULL, NULL, NULL, NULL, '2023-09-14 15:56:25', '2023-09-15 18:21:38', NULL),
(214, 458, 97, 1, '4.000', NULL, 115254, 34000, '0.000', '115254', NULL, NULL, '0', '28814', '136000', '20746', NULL, NULL, NULL, NULL, '2023-09-14 15:56:25', '2023-09-15 18:21:39', NULL),
(215, 329, 97, 1, '200.000', NULL, 313560, 1850, '0.000', '313560', NULL, NULL, '0', '1568', '370000', '56440', NULL, NULL, NULL, NULL, '2023-09-14 15:56:25', '2023-09-15 18:21:39', NULL),
(216, 186, 97, 1, '100.000', NULL, 19068, 225, '0.000', '19068', NULL, NULL, '0', '191', '22500', '3432', NULL, NULL, NULL, NULL, '2023-09-14 15:56:25', '2023-09-15 18:21:40', NULL),
(217, 311, 98, 1, '100.000', NULL, 135593, 1600, '0.000', '135593', NULL, NULL, '0', '1356', '160000', '24407', NULL, NULL, NULL, NULL, '2023-09-14 15:58:22', '2023-09-15 18:21:57', NULL),
(218, 260, 98, 1, '38.000', NULL, 122372, 3800, '0.000', '122373', NULL, NULL, '0', '3220', '144400', '22027', NULL, NULL, NULL, NULL, '2023-09-14 15:58:22', '2023-09-15 18:21:57', NULL),
(219, 426, 99, 1, '100.000', NULL, 1016949, 12000, '0.000', '1016949', NULL, NULL, '0', '10169', '1200000', '183051', NULL, NULL, NULL, NULL, '2023-09-14 16:04:33', '2023-09-15 18:22:15', NULL),
(220, 424, 99, 1, '20.000', NULL, 203389, 12000, '0.000', '203390', NULL, NULL, '0', '10169', '240000', '36610', NULL, NULL, NULL, NULL, '2023-09-14 16:04:33', '2023-09-15 18:22:15', NULL),
(221, 441, 99, 1, '144.000', NULL, 512542, 4200, '0.000', '512542', NULL, NULL, '0', '3559', '604800', '92258', NULL, NULL, NULL, NULL, '2023-09-14 16:04:33', '2023-09-15 18:22:15', NULL),
(222, 296, 100, 1, '50.000', NULL, 10593, 250, '0.000', '10593', NULL, NULL, '0', '212', '12500', '1907', NULL, NULL, NULL, NULL, '2023-09-14 16:05:33', '2023-09-15 18:22:38', NULL),
(223, 423, 101, 1, '12.000', NULL, 26440, 2600, '0.000', '26441', NULL, NULL, '0', '2203', '31200', '4759', NULL, NULL, 'CYLINDRE BUTUC UNIC U70A [UNITE]', 'B', '2023-09-14 16:14:49', '2023-09-15 18:22:57', NULL),
(224, 427, 101, 1, '12.000', NULL, 26440, 2600, '0.000', '26441', NULL, NULL, '0', '2203', '31200', '4759', NULL, NULL, 'CYLINDRE PARFAIT BLEU P70A [UNITE]', 'B', '2023-09-14 16:14:49', '2023-09-15 18:22:57', NULL),
(225, 422, 101, 1, '6.000', NULL, 13220, 2600, '0.000', '13220', NULL, NULL, '0', '2203', '15600', '2380', NULL, NULL, 'CYLINDRE ARM LOCK A70 [UNITE]', 'B', '2023-09-14 16:14:49', '2023-09-15 18:22:57', NULL),
(226, 441, 102, 1, '72.000', NULL, 256271, 4200, '0.000', '256271', NULL, NULL, '0', '3559', '302400', '46129', NULL, NULL, NULL, NULL, '2023-09-14 16:16:25', '2023-09-15 18:23:18', NULL),
(227, 431, 102, 1, '1.000', NULL, 3559, 4200, '0.000', '3559', NULL, NULL, '0', '3559', '4200', '641', NULL, NULL, NULL, NULL, '2023-09-14 16:16:25', '2023-09-15 18:23:18', NULL),
(228, 216, 103, 1, '200.000', NULL, 118644, 700, '0.000', '118644', NULL, NULL, '0', '593', '140000', '21356', NULL, NULL, NULL, NULL, '2023-09-14 16:17:46', '2023-09-15 18:23:52', NULL),
(229, 114, 104, 1, '500.000', NULL, 125425, 296, '0.000', '125425', NULL, NULL, '0', '251', '148000', '22575', NULL, NULL, 'COLLIER INOX 32 [UNITE]', 'B', '2023-09-14 17:33:43', '2023-09-15 18:24:10', NULL),
(230, 142, 105, 1, '7.000', NULL, 1186, 200, '0.000', '1186', NULL, NULL, '0', '169', '1400', '214', NULL, NULL, 'COUDE PPR 32 [UNITE]', 'B', '2023-09-14 17:41:25', '2023-09-15 18:24:29', NULL),
(231, 141, 105, 1, '200.000', NULL, 25424, 150, '0.000', '25424', NULL, NULL, '0', '127', '30000', '4576', NULL, NULL, 'COUDE PPR 25 [UNITE]', 'B', '2023-09-14 17:41:25', '2023-09-15 18:24:30', NULL),
(232, 353, 105, 1, '136.000', NULL, 17288, 150, '0.000', '17288', NULL, NULL, '0', '127', '20400', '3112', NULL, NULL, 'TÉ PPR 25 [UNITE]', 'B', '2023-09-14 17:41:25', '2023-09-15 18:24:30', NULL),
(233, 165, 105, 1, '25.000', NULL, 5296, 250, '0.000', '5297', NULL, NULL, '0', '212', '6250', '953', NULL, NULL, 'COUDE PVC 1/4 40 [UNITE]', 'B', '2023-09-14 17:41:25', '2023-09-15 18:24:31', NULL),
(234, 289, 105, 1, '30.000', NULL, 5084, 200, '0.000', '5085', NULL, NULL, '0', '169', '6000', '915', NULL, NULL, 'RÉDUCTEUR PPR 32*25 [UNITE]', 'B', '2023-09-14 17:41:25', '2023-09-15 18:24:31', NULL),
(235, 147, 105, 1, '145.000', NULL, 61440, 500, '0.000', '61441', NULL, NULL, '0', '424', '72500', '11059', NULL, NULL, 'COUDE PPR TARODÉ 25*1/2 FEMELLE [UNITE]', 'B', '2023-09-14 17:41:25', '2023-09-15 18:24:32', NULL),
(236, 311, 106, 1, '6.000', NULL, 8135, 1600, '0.000', '8136', NULL, NULL, '0', '1356', '9600', '1464', NULL, NULL, 'ROBINET D\'ARRET 15/21 GRK [UNITE]', 'B', '2023-09-14 17:55:22', '2023-09-15 18:25:12', NULL),
(237, 205, 106, 1, '1.000', NULL, 84, 100, '0.000', '85', NULL, NULL, '0', '85', '100', '15', NULL, NULL, 'EMBOUT PRESSION 20 [UNITE]', 'B', '2023-09-14 17:55:22', '2023-09-15 18:25:13', NULL),
(238, 330, 107, 1, '10.000', NULL, 12711, 1500, '0.000', '12712', NULL, NULL, '0', '1271', '15000', '2288', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:50', NULL),
(239, 185, 107, 1, '25.000', NULL, 4767, 225, '0.000', '4767', NULL, NULL, '0', '191', '5625', '858', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:50', NULL),
(240, 378, 107, 1, '10.000', NULL, 55084, 6500, '0.000', '55085', NULL, NULL, '0', '5508', '65000', '9915', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:51', NULL),
(241, 265, 107, 1, '10.000', NULL, 22881, 2700, '0.000', '22881', NULL, NULL, '0', '2288', '27000', '4119', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:51', NULL),
(242, 223, 107, 1, '20.000', NULL, 8474, 500, '0.000', '8475', NULL, NULL, '0', '424', '10000', '1525', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:52', NULL),
(243, 103, 107, 1, '10.000', NULL, 18644, 2200, '0.000', '18644', NULL, NULL, '0', '1864', '22000', '3356', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:52', NULL),
(244, 260, 107, 1, '5.000', NULL, 14830, 3500, '0.000', '14831', NULL, NULL, '0', '2966', '17500', '2670', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:53', NULL),
(245, 125, 107, 1, '10.000', NULL, 10169, 1200, '0.000', '10170', NULL, NULL, '0', '1017', '12000', '1831', NULL, NULL, NULL, NULL, '2023-09-14 17:56:14', '2023-09-15 18:25:53', NULL),
(246, 302, 108, 1, '60.000', NULL, 43220, 850, '0.000', '43220', NULL, NULL, '0', '720', '51000', '7780', NULL, NULL, 'RÉDUCTEUR PVC PLAT 110/100 [UNITE]', 'B', '2023-09-14 18:02:52', '2023-09-15 18:26:13', NULL),
(247, 278, 108, 1, '20.000', NULL, 31356, 1850, '0.000', '31356', NULL, NULL, '0', '1568', '37000', '5644', NULL, NULL, 'PUISSAGE KMEI LY303 1/2 [UNITE]', 'B', '2023-09-14 18:02:52', '2023-09-15 18:26:14', NULL),
(248, 336, 108, 1, '20.000', NULL, 38135, 2250, '0.000', '38136', NULL, NULL, '0', '1907', '45000', '6864', NULL, NULL, 'ROBINET PUISSAGE KMEI LY1300 1/2 [UNITE]', 'B', '2023-09-14 18:02:53', '2023-09-15 18:26:14', NULL),
(249, 49, 109, 1, '30.000', NULL, 88983, 3500, '0.000', '88983', NULL, NULL, '0', '2966', '105000', '16017', NULL, NULL, NULL, NULL, '2023-09-15 14:01:39', '2023-09-15 18:26:31', NULL);
INSERT INTO `produit_cond_com_clit` (`id`, `produit_id`, `commande_clit_id`, `magasin_id`, `qtite`, `taxe_specifique`, `montant`, `prix`, `rest_aliv`, `montant_ht_apr_rse`, `type_remise`, `valeur_remise`, `remise`, `prix_ht`, `montant_ttcp`, `montant_tvap`, `carton`, `piece`, `libelle_produit`, `groupe_taxe_produit`, `created_at`, `updated_at`, `deleted_at`) VALUES
(250, 50, 109, 1, '30.000', NULL, 88983, 3500, '0.000', '88983', NULL, NULL, '0', '2966', '105000', '16017', NULL, NULL, NULL, NULL, '2023-09-15 14:01:39', '2023-09-15 18:26:31', NULL),
(251, 51, 109, 1, '15.000', NULL, 44492, 3500, '0.000', '44492', NULL, NULL, '0', '2966', '52500', '8009', NULL, NULL, NULL, NULL, '2023-09-15 14:01:39', '2023-09-15 18:26:31', NULL),
(252, 52, 109, 1, '15.000', NULL, 44492, 3500, '0.000', '44492', NULL, NULL, '0', '2966', '52500', '8009', NULL, NULL, NULL, NULL, '2023-09-15 14:01:39', '2023-09-15 18:26:31', NULL),
(253, 182, 110, 1, '2000.000', NULL, 593220, 350, '0.000', '593220', NULL, NULL, '0', '297', '700000', '106780', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:48', NULL),
(254, 185, 110, 1, '100.000', NULL, 16949, 200, '0.000', '16949', NULL, NULL, '0', '169', '20000', '3051', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:49', NULL),
(255, 186, 110, 1, '100.000', NULL, 19068, 225, '0.000', '19068', NULL, NULL, '0', '191', '22500', '3432', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:49', NULL),
(256, 238, 110, 1, '1000.000', NULL, 203390, 240, '0.000', '203390', NULL, NULL, '0', '203', '240000', '36610', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:50', NULL),
(257, 132, 110, 1, '960.000', NULL, 325421, 400, '0.000', '325421', NULL, NULL, '0', '339', '384000', '58579', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:51', NULL),
(258, 243, 110, 1, '200.000', NULL, 50848, 300, '0.000', '50848', NULL, NULL, '0', '254', '60000', '9152', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:51', NULL),
(259, 231, 110, 1, '115.000', NULL, 48729, 500, '0.000', '48729', NULL, NULL, '0', '424', '57500', '8771', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:52', NULL),
(260, 223, 110, 1, '99.000', NULL, 41949, 500, '0.000', '41949', NULL, NULL, '0', '424', '49500', '7551', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:52', NULL),
(261, 224, 110, 1, '100.000', NULL, 42373, 500, '0.000', '42373', NULL, NULL, '0', '424', '50000', '7627', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:53', NULL),
(262, 478, 110, 1, '1.000', NULL, 55084, 65000, '0.000', '55085', NULL, NULL, '0', '55085', '65000', '9915', NULL, NULL, NULL, NULL, '2023-09-15 14:39:38', '2023-09-15 18:26:53', NULL),
(263, 315, 111, 1, '5.000', NULL, 6356, 1500, '0.000', '6356', NULL, NULL, '0', '1271', '7500', '1144', NULL, NULL, NULL, NULL, '2023-09-15 15:02:02', '2023-09-15 18:27:13', NULL),
(264, 314, 111, 1, '10.000', NULL, 12712, 1500, '0.000', '12712', NULL, NULL, '0', '1271', '15000', '2288', NULL, NULL, NULL, NULL, '2023-09-15 15:02:02', '2023-09-15 18:27:13', NULL),
(265, 261, 111, 1, '10.000', NULL, 25424, 3000, '0.000', '25424', NULL, NULL, '0', '2542', '30000', '4576', NULL, NULL, NULL, NULL, '2023-09-15 15:02:02', '2023-09-15 18:27:14', NULL),
(266, 222, 111, 1, '2.000', NULL, 1441, 850, '0.000', '1441', NULL, NULL, '0', '720', '1700', '259', NULL, NULL, NULL, NULL, '2023-09-15 15:02:02', '2023-09-15 18:27:14', NULL),
(267, 181, 111, 1, '50.000', NULL, 10593, 250, '0.000', '10593', NULL, NULL, '0', '212', '12500', '1907', NULL, NULL, NULL, NULL, '2023-09-15 15:02:02', '2023-09-15 18:27:15', NULL),
(268, 125, 111, 1, '20.000', NULL, 21186, 1250, '0.000', '21186', NULL, NULL, '0', '1059', '25000', '3814', NULL, NULL, NULL, NULL, '2023-09-15 15:02:02', '2023-09-15 18:27:16', NULL),
(269, 260, 112, 1, '10.000', NULL, 29661, 3500, '0.000', '29661', NULL, NULL, '0', '2966', '35000', '5339', NULL, NULL, 'MÉCANISME GOLF À POUSSOI [UNITE]', 'B', '2023-09-15 15:05:51', '2023-09-15 18:24:50', NULL),
(270, 238, 112, 1, '8.000', NULL, 1695, 250, '0.000', '1695', NULL, NULL, '0', '212', '2000', '305', NULL, NULL, 'MAMELON LAITON 15/21 [UNITE]', 'B', '2023-09-15 15:05:51', '2023-09-15 18:24:51', NULL),
(271, 477, 113, 1, '2.000', NULL, 115254, 68000, '0.000', '115254', NULL, NULL, '0', '57627', '136000', '20746', NULL, NULL, 'VENTILATEUR SMC [CARTON]', 'B', '2023-09-15 15:55:52', '2023-09-15 18:27:34', NULL),
(272, 481, 114, 1, '1.000', NULL, 255932, 302000, '0.000', '255932', NULL, NULL, '0', '255932', '302000', '46068', NULL, NULL, 'LA PERCHE CAISSE 6458 [CAISSE]', 'B', '2023-09-15 15:57:04', '2023-09-15 18:27:50', NULL),
(273, 64, 115, 1, '1.000', NULL, 5932, 7000, '0.000', '5932', NULL, NULL, '0', '5932', '7000', '1068', NULL, NULL, NULL, NULL, '2023-09-15 16:04:43', '2023-09-15 18:28:14', NULL),
(274, 65, 115, 1, '1.000', NULL, 3390, 4000, '0.000', '3390', NULL, NULL, '0', '3390', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-15 16:04:43', '2023-09-15 18:28:14', NULL),
(275, 444, 115, 1, '6.000', NULL, 61017, 12000, '0.000', '61017', NULL, NULL, '0', '10169', '72000', '10983', NULL, NULL, NULL, NULL, '2023-09-15 16:04:43', '2023-09-15 18:28:15', NULL),
(276, 108, 116, 1, '10.000', NULL, 50848, 6000, '0.000', '50848', NULL, NULL, '0', '5085', '60000', '9153', NULL, NULL, NULL, NULL, '2023-09-15 16:10:23', '2023-09-15 18:28:37', NULL),
(277, 483, 116, 1, '13.000', NULL, 33051, 3000, '0.000', '33051', NULL, NULL, '0', '2542', '39000', '5949', NULL, NULL, NULL, NULL, '2023-09-15 16:10:23', '2023-09-15 18:28:37', NULL),
(278, 482, 116, 1, '1.000', NULL, 2118, 2500, '0.000', '2119', NULL, NULL, '0', '2119', '2500', '381', NULL, NULL, NULL, NULL, '2023-09-15 16:10:23', '2023-09-15 18:28:37', NULL),
(279, 319, 117, 1, '12.000', NULL, 25424, 2500, '0.000', '25424', NULL, NULL, '0', '2119', '30000', '4576', NULL, NULL, 'ROBINET EVIER MURAL [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:28:59', NULL),
(280, 124, 117, 1, '10.000', NULL, 10593, 1250, '0.000', '10593', NULL, NULL, '0', '1059', '12500', '1907', NULL, NULL, 'COLONNE FIXE EN FER [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:28:59', NULL),
(281, 125, 117, 1, '10.000', NULL, 10593, 1250, '0.000', '10593', NULL, NULL, '0', '1059', '12500', '1907', NULL, NULL, 'COLONNE FIXE EN PLASTIC [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:00', NULL),
(282, 236, 117, 1, '10.000', NULL, 59322, 7000, '0.000', '59322', NULL, NULL, '0', '5932', '70000', '10678', NULL, NULL, 'LAVE MAIN PARMA [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:00', NULL),
(283, 271, 117, 1, '50.000', NULL, 52966, 1250, '0.000', '52966', NULL, NULL, '0', '1059', '62500', '9534', NULL, NULL, 'PORT PAPIER SC [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:01', NULL),
(284, 339, 117, 1, '100.000', NULL, 31780, 375, '0.000', '31780', NULL, NULL, '0', '318', '37500', '5720', NULL, NULL, 'SIPHON DE SOL 10G [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:01', NULL),
(285, 261, 117, 1, '25.000', NULL, 63559, 3000, '0.000', '63559', NULL, NULL, '0', '2542', '75000', '11441', NULL, NULL, 'MECANISME PARMA [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:02', NULL),
(286, 263, 117, 1, '10.000', NULL, 31356, 3700, '0.000', '31356', NULL, NULL, '0', '3136', '37000', '5644', NULL, NULL, 'MIROIRE WT-2 [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:02', NULL),
(287, 108, 117, 1, '1.000', NULL, 5085, 6000, '0.000', '5085', NULL, NULL, '0', '5085', '6000', '915', NULL, NULL, 'COLLIER ATELAS 64010-25 [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:03', NULL),
(288, 109, 117, 1, '1.000', NULL, 5508, 6500, '0.000', '5508', NULL, NULL, '0', '5508', '6500', '992', NULL, NULL, 'COLLIER ATELAS 64010-32 [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:03', NULL),
(289, 317, 117, 1, '20.000', NULL, 12712, 750, '0.000', '12712', NULL, NULL, '0', '636', '15000', '2288', NULL, NULL, 'ROBINET EQUERRE GRK [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:04', NULL),
(290, 375, 117, 1, '20.000', NULL, 12712, 750, '0.000', '12712', NULL, NULL, '0', '636', '15000', '2288', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:04', NULL),
(291, 376, 117, 1, '20.000', NULL, 16102, 950, '0.000', '16102', NULL, NULL, '0', '805', '19000', '2898', NULL, NULL, 'TETE ROBINET 20/27 GRK [UNITE]', 'B', '2023-09-15 16:10:41', '2023-09-15 18:29:05', NULL),
(292, 319, 118, 1, '8.000', NULL, 16949, 2500, '0.000', '16949', NULL, NULL, '0', '2119', '20000', '3051', NULL, NULL, NULL, NULL, '2023-09-15 16:13:08', '2023-09-15 18:29:23', NULL),
(293, 482, 118, 1, '2.000', NULL, 4237, 2500, '0.000', '4237', NULL, NULL, '0', '2119', '5000', '763', NULL, NULL, NULL, NULL, '2023-09-15 16:13:08', '2023-09-15 18:29:23', NULL),
(294, 391, 119, 1, '16.000', NULL, 51525, 3800, '0.000', '51525', NULL, NULL, '0', '3220', '60800', '9275', NULL, NULL, NULL, NULL, '2023-09-15 16:21:00', '2023-09-15 18:29:58', NULL),
(295, 28, 120, 1, '1.000', NULL, 19068, 22500, '0.000', '19068', NULL, NULL, '0', '19068', '22500', '3432', NULL, NULL, NULL, NULL, '2023-09-15 16:22:33', '2023-09-15 18:30:18', NULL),
(296, 113, 121, 1, '50.000', NULL, 36017, 850, '0.000', '36017', NULL, NULL, '0', '720', '42500', '6483', NULL, NULL, NULL, NULL, '2023-09-15 16:26:41', '2023-09-15 18:30:36', NULL),
(297, 94, 122, 1, '20.000', NULL, 6780, 400, '0.000', '6780', NULL, NULL, '0', '339', '8000', '1220', NULL, NULL, NULL, NULL, '2023-09-15 16:27:55', '2023-09-15 18:30:55', NULL),
(298, 329, 122, 1, '6.000', NULL, 9407, 1850, '0.000', '9407', NULL, NULL, '0', '1568', '11100', '1693', NULL, NULL, NULL, NULL, '2023-09-15 16:27:55', '2023-09-15 18:30:56', NULL),
(299, 338, 123, 1, '4.000', NULL, 15254, 4500, '0.000', '15254', NULL, NULL, '0', '3814', '18000', '2746', NULL, NULL, NULL, NULL, '2023-09-15 16:33:20', '2023-09-15 18:31:14', NULL),
(300, 329, 124, 1, '1000.000', NULL, 1525420, 1800, '0.000', '1525420', NULL, NULL, '0', '1525', '1800000', '274580', NULL, NULL, NULL, NULL, '2023-09-15 16:50:37', '2023-09-15 18:31:31', NULL),
(301, 68, 125, 1, '35.000', NULL, 341102, 11500, '0.000', '341102', NULL, NULL, '0', '9746', '402500', '61398', NULL, NULL, NULL, NULL, '2023-09-15 17:00:44', '2023-09-21 10:32:40', NULL),
(302, 121, 125, 1, '200.000', NULL, 33898, 200, '0.000', '33898', NULL, NULL, '0', '169', '40000', '6102', NULL, NULL, NULL, NULL, '2023-09-15 17:00:44', '2023-09-15 18:32:21', NULL),
(303, 423, 125, 1, '2.000', NULL, 4407, 2600, '0.000', '4407', NULL, NULL, '0', '2203', '5200', '793', NULL, NULL, NULL, NULL, '2023-09-15 17:00:44', '2023-09-15 18:32:21', NULL),
(304, 266, 126, 1, '42.000', NULL, 23136, 650, '0.000', '23136', NULL, NULL, '0', '551', '27300', '4164', NULL, NULL, NULL, NULL, '2023-09-15 17:01:31', '2023-09-15 18:33:13', NULL),
(305, 266, 127, 1, '42.000', NULL, 23136, 650, '0.000', '23136', NULL, NULL, '0', '551', '27300', '4164', NULL, NULL, NULL, NULL, '2023-09-15 17:07:10', '2023-09-15 18:33:36', NULL),
(306, 24, 127, 1, '2.000', NULL, 25424, 15000, '0.000', '25424', NULL, NULL, '0', '12712', '30000', '4576', NULL, NULL, NULL, NULL, '2023-09-15 17:07:10', '2023-09-15 18:33:36', NULL),
(307, 329, 127, 1, '100.000', NULL, 156780, 1850, '0.000', '156780', NULL, NULL, '0', '1568', '185000', '28220', NULL, NULL, NULL, NULL, '2023-09-15 17:07:10', '2023-09-15 18:33:37', NULL),
(308, 418, 127, 1, '6.000', NULL, 20339, 4000, '0.000', '20339', NULL, NULL, '0', '3390', '24000', '3661', NULL, NULL, NULL, NULL, '2023-09-15 17:07:10', '2023-09-15 18:33:38', NULL),
(309, 441, 127, 1, '5.000', NULL, 18220, 4300, '0.000', '18220', NULL, NULL, '0', '3644', '21500', '3280', NULL, NULL, NULL, NULL, '2023-09-15 17:07:10', '2023-09-15 18:33:38', NULL),
(310, 447, 128, 1, '1.000', NULL, 39407, 46500, '0.000', '39407', NULL, NULL, '0', '39407', '46500', '7093', NULL, NULL, NULL, NULL, '2023-09-15 17:09:50', '2023-09-15 18:33:54', NULL),
(311, 355, 129, 1, '4.000', NULL, 2034, 600, '0.000', '2034', NULL, NULL, '0', '508', '2400', '366', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:12', NULL),
(312, 143, 129, 1, '4.000', NULL, 1356, 400, '0.000', '1356', NULL, NULL, '0', '339', '1600', '244', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:12', NULL),
(313, 290, 129, 1, '7.000', NULL, 2373, 400, '0.000', '2373', NULL, NULL, '0', '339', '2800', '427', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:12', NULL),
(314, 354, 129, 1, '3.000', NULL, 508, 200, '0.000', '508', NULL, NULL, '0', '169', '600', '92', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:13', NULL),
(315, 142, 129, 1, '12.000', NULL, 2034, 200, '0.000', '2034', NULL, NULL, '0', '169', '2400', '366', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:13', NULL),
(316, 289, 129, 1, '10.000', NULL, 1695, 200, '0.000', '1695', NULL, NULL, '0', '169', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:14', NULL),
(317, 141, 129, 1, '10.000', NULL, 848, 100, '0.000', '848', NULL, NULL, '0', '85', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:14', NULL),
(318, 139, 129, 1, '3.000', NULL, 508, 200, '0.000', '508', NULL, NULL, '0', '169', '600', '92', NULL, NULL, NULL, NULL, '2023-09-15 17:15:50', '2023-09-15 18:34:15', NULL),
(319, 260, 130, 1, '10.000', NULL, 29661, 3500, '0.000', '29661', NULL, NULL, '0', '2966', '35000', '5339', NULL, NULL, 'MÉCANISME GOLF À POUSSOI [UNITE]', 'B', '2023-09-16 10:25:52', '2023-09-16 14:13:02', NULL),
(320, 65, 130, 1, '5.000', NULL, 16949, 4000, '0.000', '16949', NULL, NULL, '0', '3390', '20000', '3051', NULL, NULL, 'ABATTAN PARMA  [UNITE]', 'B', '2023-09-16 10:25:52', '2023-09-16 14:13:02', NULL),
(321, 311, 131, 1, '8.000', NULL, 12203, 1800, '0.000', '12203', NULL, NULL, '0', '1525', '14400', '2197', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:32', NULL),
(322, 194, 131, 1, '18.000', NULL, 9152, 600, '0.000', '9152', NULL, NULL, '0', '508', '10800', '1647', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:32', NULL),
(323, 196, 131, 1, '8.000', NULL, 4746, 700, '0.000', '4746', NULL, NULL, '0', '593', '5600', '854', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:33', NULL),
(324, 282, 131, 1, '7.000', NULL, 2966, 500, '0.000', '2966', NULL, NULL, '0', '424', '3500', '534', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:33', NULL),
(325, 141, 131, 1, '30.000', NULL, 2543, 100, '0.000', '2543', NULL, NULL, '0', '85', '3000', '458', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:34', NULL),
(326, 353, 131, 1, '5.000', NULL, 530, 125, '0.000', '530', NULL, NULL, '0', '106', '625', '95', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:34', NULL),
(327, 289, 131, 1, '5.000', NULL, 847, 200, '0.000', '847', NULL, NULL, '0', '169', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:35', NULL),
(328, 290, 131, 1, '1.000', NULL, 339, 400, '0.000', '339', NULL, NULL, '0', '339', '400', '61', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:35', NULL),
(329, 283, 131, 1, '1.000', NULL, 593, 700, '0.000', '593', NULL, NULL, '0', '593', '700', '107', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:36', NULL),
(330, 380, 131, 1, '4.000', NULL, 12203, 3600, '0.000', '12203', NULL, NULL, '0', '3051', '14400', '2197', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:36', NULL),
(331, 198, 131, 1, '2.000', NULL, 1695, 1000, '0.000', '1695', NULL, NULL, '0', '847', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:37', NULL),
(332, 89, 131, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:37', NULL),
(333, 104, 131, 1, '1.000', NULL, 5085, 6000, '0.000', '5085', NULL, NULL, '0', '5085', '6000', '915', NULL, NULL, NULL, NULL, '2023-09-16 10:34:43', '2023-09-16 14:14:38', NULL),
(334, 441, 132, 1, '15.000', NULL, 54661, 4300, '0.000', '54661', NULL, NULL, '0', '3644', '64500', '9839', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-16 12:08:56', '2023-09-16 14:15:14', NULL),
(335, 164, 132, 1, '250.000', NULL, 26483, 125, '0.000', '26483', NULL, NULL, '0', '106', '31250', '4768', NULL, NULL, 'COUDE PVC 1/4 32 [UNITE]', 'B', '2023-09-16 12:08:56', '2023-09-16 14:15:14', NULL),
(336, 186, 133, 1, '50.000', NULL, 9322, 220, '0.000', '9322', NULL, NULL, '0', '186', '11000', '1678', NULL, NULL, 'ECROU LAITON REDUIT 15/12 [UNITE]', 'B', '2023-09-16 13:42:08', '2023-09-16 14:15:33', NULL),
(337, 329, 134, 1, '200.000', NULL, 313560, 1850, '0.000', '313559', NULL, NULL, '0', '1568', '370000', '56441', NULL, NULL, NULL, NULL, '2023-09-18 09:02:50', '2023-09-18 10:12:24', NULL),
(338, 311, 134, 1, '100.000', NULL, 131356, 1550, '0.000', '131356', NULL, NULL, '0', '1314', '155000', '23644', NULL, NULL, NULL, NULL, '2023-09-18 09:02:50', '2023-09-18 10:12:25', NULL),
(339, 132, 134, 1, '300.000', NULL, 105507, 415, '0.000', '105508', NULL, NULL, '0', '352', '124500', '18992', NULL, NULL, NULL, NULL, '2023-09-18 09:02:50', '2023-09-18 10:12:25', NULL),
(340, 317, 134, 1, '100.000', NULL, 63559, 750, '0.000', '63559', NULL, NULL, '0', '636', '75000', '11441', NULL, NULL, NULL, NULL, '2023-09-18 09:02:50', '2023-09-18 10:12:26', NULL),
(341, 182, 134, 1, '200.000', NULL, 59322, 350, '0.000', '59322', NULL, NULL, '0', '297', '70000', '10678', NULL, NULL, NULL, NULL, '2023-09-18 09:02:50', '2023-09-18 10:12:26', NULL),
(342, 181, 134, 1, '200.000', NULL, 42372, 250, '0.000', '42373', NULL, NULL, '0', '212', '50000', '7627', NULL, NULL, NULL, NULL, '2023-09-18 09:02:50', '2023-09-18 10:12:27', NULL),
(343, 68, 135, 1, '5.000', NULL, 50847, 12000, '0.000', '50847', NULL, NULL, '0', '10169', '60000', '9153', NULL, NULL, 'ACCESOIRE PARMA [UNITE]', 'B', '2023-09-18 09:26:54', '2023-09-18 10:13:30', NULL),
(344, 487, 136, 1, '10.000', NULL, 1525424, 180000, '0.000', '1525424', NULL, NULL, '0', '152542', '1800000', '274576', NULL, NULL, NULL, NULL, '2023-09-18 10:05:07', '2023-09-18 10:13:49', NULL),
(345, 181, 136, 1, '4000.000', NULL, 813560, 240, '0.000', '813559', NULL, NULL, '0', '203', '960000', '146441', NULL, NULL, NULL, NULL, '2023-09-18 10:05:07', '2023-09-18 10:13:49', NULL),
(346, 49, 137, 1, '15.000', NULL, 44492, 3500, '0.000', '44492', NULL, NULL, '0', '2966', '52500', '8008', NULL, NULL, 'BOTTES POINTURE 42 [PAIRE]', 'B', '2023-09-18 10:19:57', '2023-09-18 12:27:26', NULL),
(347, 52, 137, 1, '15.000', NULL, 44492, 3500, '0.000', '44492', NULL, NULL, '0', '2966', '52500', '8008', NULL, NULL, 'BOTTES POINTURE 45 [PAIRE]', 'B', '2023-09-18 10:19:57', '2023-09-18 12:27:26', NULL),
(348, 68, 138, 1, '12.000', NULL, 116949, 11500, '0.000', '116949', NULL, NULL, '0', '9746', '138000', '21051', NULL, NULL, 'ACCESOIRE PARMA [UNITE]', 'B', '2023-09-18 11:22:55', '2023-09-18 12:27:45', NULL),
(349, 236, 138, 1, '6.000', NULL, 35593, 7000, '0.000', '35593', NULL, NULL, '0', '5932', '42000', '6407', NULL, NULL, 'LAVE MAIN PARMA [UNITE]', 'B', '2023-09-18 11:22:55', '2023-09-18 12:27:45', NULL),
(350, 255, 139, 1, '50.000', NULL, 8475, 200, '0.000', '8475', NULL, NULL, '0', '169', '10000', '1525', NULL, NULL, 'MANCHON PRESSION 25 [UNITE]', 'B', '2023-09-18 12:24:27', '2023-09-18 12:27:59', NULL),
(351, 336, 140, 1, '100.000', NULL, 190678, 2250, '0.000', '190678', NULL, NULL, '0', '1907', '225000', '34322', NULL, NULL, NULL, NULL, '2023-09-18 12:26:51', '2023-09-18 12:28:12', NULL),
(352, 431, 141, 1, '12.000', NULL, 43729, 4300, '0.000', '43729', NULL, NULL, '0', '3644', '51600', '7871', NULL, NULL, 'SERRURE G.J.S [UNITE]', 'B', '2023-09-18 13:50:42', '2023-09-18 14:12:48', NULL),
(353, 424, 141, 1, '1.000', NULL, 10169, 12000, '0.000', '10169', NULL, NULL, '0', '10169', '12000', '1831', NULL, NULL, 'CYLINDRE CLE DOOR [DOUZAINE]', 'B', '2023-09-18 13:50:42', '2023-09-18 14:12:48', NULL),
(354, 426, 141, 1, '1.000', NULL, 10593, 12500, '0.000', '10593', NULL, NULL, '0', '10593', '12500', '1907', NULL, NULL, 'CYLINDRE LA PERCHE BLEU 60M [DOUZAINE]', 'B', '2023-09-18 13:50:42', '2023-09-18 14:12:48', NULL),
(355, 452, 142, 1, '8.000', NULL, 71186, 10500, '0.000', '71186', NULL, NULL, '0', '8898', '84000', '12814', NULL, NULL, NULL, NULL, '2023-09-18 14:30:18', '2023-09-18 14:30:58', NULL),
(356, 463, 142, 1, '1.000', NULL, 7627, 9000, '0.000', '7627', NULL, NULL, '0', '7627', '9000', '1373', NULL, NULL, NULL, NULL, '2023-09-18 14:30:18', '2023-09-18 14:30:58', NULL),
(357, 340, 142, 1, '5.000', NULL, 63559, 15000, '0.000', '63559', NULL, NULL, '0', '12712', '75000', '11441', NULL, NULL, NULL, NULL, '2023-09-18 14:30:18', '2023-09-18 14:30:58', NULL),
(358, 415, 142, 1, '1.000', NULL, 237288, 280000, '0.000', '237288', NULL, NULL, '0', '237288', '280000', '42712', NULL, NULL, NULL, NULL, '2023-09-18 14:30:18', '2023-09-18 14:30:59', NULL),
(359, 445, 143, 1, '10.000', NULL, 220339, 26000, '0.000', '220339', NULL, NULL, '0', '22034', '260000', '39661', NULL, NULL, 'MICC 202 [CARTON]', 'B', '2023-09-18 14:32:18', '2023-09-18 14:42:42', NULL),
(360, 376, 143, 1, '100.000', NULL, 76271, 900, '0.000', '76271', NULL, NULL, '0', '763', '90000', '13729', NULL, NULL, 'TETE ROBINET 20/27 GRK [UNITE]', 'B', '2023-09-18 14:32:18', '2023-09-18 14:42:42', NULL),
(361, 375, 143, 1, '300.000', NULL, 184323, 725, '0.000', '184322', NULL, NULL, '0', '614', '217500', '33178', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-18 14:32:18', '2023-09-18 14:42:42', NULL),
(362, 129, 144, 1, '20.000', NULL, 110169, 6500, '0.000', '110169', NULL, NULL, '0', '5508', '130000', '19831', NULL, NULL, 'COMPTEUR LAITON 20/27 GRK [UNITE]', 'B', '2023-09-19 08:42:58', '2023-09-19 08:43:45', NULL),
(363, 336, 144, 1, '120.000', NULL, 228814, 2250, '0.000', '228814', NULL, NULL, '0', '1907', '270000', '41186', NULL, NULL, 'ROBINET PUISSAGE KMEI LY1300 1/2 [UNITE]', 'B', '2023-09-19 08:42:58', '2023-09-19 08:43:45', NULL),
(364, 278, 144, 1, '60.000', NULL, 94068, 1850, '0.000', '94068', NULL, NULL, '0', '1568', '111000', '16932', NULL, NULL, 'PUISSAGE KMEI LY303 1/2 [UNITE]', 'B', '2023-09-19 08:42:58', '2023-09-19 08:43:46', NULL),
(365, 68, 145, 1, '10.000', NULL, 97458, 11500, '0.000', '97458', NULL, NULL, '0', '9746', '115000', '17542', NULL, NULL, 'ACCESOIRE PARMA [UNITE]', 'B', '2023-09-19 08:45:17', '2023-09-19 08:49:20', NULL),
(366, 185, 146, 1, '100.000', NULL, 16949, 200, '0.000', '16949', NULL, NULL, '0', '169', '20000', '3051', NULL, NULL, 'ECROU LAITON REDUIT 12/12 [UNITE]', 'B', '2023-09-19 10:09:16', '2023-09-19 10:10:41', NULL),
(367, 241, 146, 1, '100.000', NULL, 21186, 250, '0.000', '21186', NULL, NULL, '0', '212', '25000', '3814', NULL, NULL, 'MAMELON RÉDUIT 62902-1/2*3/4L [UNITE]', 'B', '2023-09-19 10:09:16', '2023-09-19 10:10:41', NULL),
(368, 266, 146, 1, '50.000', NULL, 27543, 650, '0.000', '27542', NULL, NULL, '0', '551', '32500', '4958', NULL, NULL, 'PATE À GLACE [UNITE]', 'B', '2023-09-19 10:09:16', '2023-09-19 10:10:42', NULL),
(369, 375, 147, 1, '50.000', NULL, 33899, 800, '0.000', '33898', NULL, NULL, '0', '678', '40000', '6102', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-19 10:19:24', '2023-09-19 10:20:51', NULL),
(370, 213, 148, 1, '50.000', NULL, 31780, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, NULL, NULL, '2023-09-19 11:20:34', '2023-09-19 11:55:03', NULL),
(371, 215, 148, 1, '50.000', NULL, 31780, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, NULL, NULL, '2023-09-19 11:20:34', '2023-09-19 11:55:04', NULL),
(372, 260, 148, 1, '25.000', NULL, 74153, 3500, '0.000', '74153', NULL, NULL, '0', '2966', '87500', '13347', NULL, NULL, NULL, NULL, '2023-09-19 11:20:34', '2023-09-19 11:55:04', NULL),
(373, 213, 149, 1, '50.000', NULL, 30721, 725, '0.000', '30720', NULL, NULL, '0', '614', '36250', '5530', NULL, NULL, NULL, NULL, '2023-09-19 11:26:19', '2023-09-19 11:54:48', NULL),
(374, 215, 149, 1, '50.000', NULL, 30721, 725, '0.000', '30720', NULL, NULL, '0', '614', '36250', '5530', NULL, NULL, NULL, NULL, '2023-09-19 11:26:19', '2023-09-19 11:54:49', NULL),
(375, 319, 149, 1, '20.000', NULL, 42373, 2500, '0.000', '42373', NULL, NULL, '0', '2119', '50000', '7627', NULL, NULL, NULL, NULL, '2023-09-19 11:26:19', '2023-09-19 11:54:49', NULL),
(376, 375, 149, 1, '50.000', NULL, 31780, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, NULL, NULL, '2023-09-19 11:26:19', '2023-09-19 11:54:50', NULL),
(377, 317, 149, 1, '50.000', NULL, 29661, 700, '0.000', '29661', NULL, NULL, '0', '593', '35000', '5339', NULL, NULL, NULL, NULL, '2023-09-19 11:26:19', '2023-09-19 11:54:50', NULL),
(378, 266, 150, 1, '42.000', NULL, 23136, 650, '0.000', '23136', NULL, NULL, '0', '551', '27300', '4164', NULL, NULL, 'PATE À GLACE [UNITE]', 'B', '2023-09-19 11:40:48', '2023-09-19 11:54:29', NULL),
(379, 2, 151, 1, '250.000', NULL, 508475, 2400, '0.000', '508475', NULL, NULL, '0', '2034', '600000', '91525', NULL, NULL, NULL, NULL, '2023-09-19 12:03:26', '2023-09-19 15:34:45', NULL),
(380, 441, 152, 1, '15.000', NULL, 54661, 4300, '0.000', '54661', NULL, NULL, '0', '3644', '64500', '9839', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-19 16:00:13', '2023-09-19 16:01:32', NULL),
(381, 271, 152, 1, '50.000', NULL, 52966, 1250, '0.000', '52966', NULL, NULL, '0', '1059', '62500', '9534', NULL, NULL, 'PORT PAPIER SC [UNITE]', 'B', '2023-09-19 16:00:13', '2023-09-19 16:01:32', NULL),
(382, 65, 152, 1, '10.000', NULL, 33898, 4000, '0.000', '33898', NULL, NULL, '0', '3390', '40000', '6102', NULL, NULL, 'ABATTAN PARMA  [UNITE]', 'B', '2023-09-19 16:00:13', '2023-09-19 16:01:33', NULL),
(383, 181, 152, 1, '52.000', NULL, 11017, 250, '0.000', '11017', NULL, NULL, '0', '212', '13000', '1983', NULL, NULL, 'ECROU LAITON 15/15 [UNITE]', 'B', '2023-09-19 16:00:13', '2023-09-19 16:01:34', NULL),
(384, 448, 153, 1, '12.000', NULL, 91525, 9000, '0.000', '91525', NULL, NULL, '0', '7627', '108000', '16475', NULL, NULL, NULL, NULL, '2023-09-20 08:10:47', '2023-09-20 10:42:59', NULL),
(385, 311, 154, 1, '10.000', NULL, 13136, 1550, '0.000', '13136', NULL, NULL, '0', '1314', '15500', '2364', NULL, NULL, 'ROBINET D\'ARRET 15/21 GRK [UNITE]', 'B', '2023-09-20 08:36:17', '2023-09-20 10:43:12', NULL),
(386, 426, 154, 1, '5.000', NULL, 52966, 12500, '0.000', '52966', NULL, NULL, '0', '10593', '62500', '9534', NULL, NULL, 'CYLINDRE LA PERCHE BLEU 60M [DOUZAINE]', 'B', '2023-09-20 08:36:17', '2023-09-20 10:43:12', NULL),
(387, 266, 155, 1, '42.000', NULL, 23136, 650, '0.000', '23136', NULL, NULL, '0', '551', '27300', '4164', NULL, NULL, NULL, NULL, '2023-09-20 10:42:30', '2023-09-20 10:43:26', NULL),
(388, 429, 155, 1, '1.000', NULL, 19491, 23000, '0.000', '19492', NULL, NULL, '0', '19492', '23000', '3508', NULL, NULL, NULL, NULL, '2023-09-20 10:42:30', '2023-09-20 10:43:27', NULL),
(389, 212, 156, 1, '1.000', NULL, 5508, 6500, '0.000', '5508', NULL, NULL, '0', '5508', '6500', '992', NULL, NULL, NULL, NULL, '2023-09-20 11:07:25', '2023-09-20 11:07:41', NULL),
(390, 399, 157, 1, '32.000', NULL, 67796, 2500, '0.000', '67797', NULL, NULL, '0', '2119', '80000', '12203', NULL, NULL, NULL, NULL, '2023-09-20 11:49:09', '2023-09-20 12:09:50', NULL),
(391, 329, 157, 1, '2.000', NULL, 3390, 2000, '0.000', '3390', NULL, NULL, '0', '1695', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 11:49:09', '2023-09-20 12:09:51', NULL),
(392, 277, 157, 1, '1.000', NULL, 1695, 2000, '0.000', '1695', NULL, NULL, '0', '1695', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-20 11:49:09', '2023-09-20 12:09:51', NULL),
(393, 441, 158, 1, '7.000', NULL, 25508, 4300, '0.000', '25508', NULL, NULL, '0', '3644', '30100', '4592', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-20 12:07:47', '2023-09-20 12:10:10', NULL),
(394, 375, 159, 1, '50.000', NULL, 31780, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, NULL, NULL, '2023-09-20 12:27:36', '2023-09-20 12:32:17', NULL),
(395, 376, 159, 1, '25.000', NULL, 20127, 950, '0.000', '20127', NULL, NULL, '0', '805', '23750', '3623', NULL, NULL, NULL, NULL, '2023-09-20 12:27:36', '2023-09-20 12:32:18', NULL),
(396, 160, 160, 1, '5.000', NULL, 3390, 800, '0.000', '3390', NULL, NULL, '0', '678', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:40', NULL),
(397, 404, 160, 1, '1.000', NULL, 2119, 2500, '0.000', '2119', NULL, NULL, '0', '2119', '2500', '381', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:41', NULL),
(398, 370, 160, 1, '5.000', NULL, 1271, 300, '0.000', '1271', NULL, NULL, '0', '254', '1500', '229', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:41', NULL),
(399, 291, 160, 1, '4.000', NULL, 2034, 600, '0.000', '2034', NULL, NULL, '0', '508', '2400', '366', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:42', NULL),
(400, 289, 160, 1, '4.000', NULL, 678, 200, '0.000', '678', NULL, NULL, '0', '169', '800', '122', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:42', NULL),
(401, 277, 160, 1, '1.000', NULL, 2119, 2500, '0.000', '2119', NULL, NULL, '0', '2119', '2500', '381', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:43', NULL),
(402, 207, 160, 1, '4.000', NULL, 1017, 300, '0.000', '1017', NULL, NULL, '0', '254', '1200', '183', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:43', NULL),
(403, 369, 160, 1, '4.000', NULL, 678, 200, '0.000', '678', NULL, NULL, '0', '169', '800', '122', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:44', NULL),
(404, 157, 160, 1, '2.000', NULL, 339, 200, '0.000', '339', NULL, NULL, '0', '169', '400', '61', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:44', NULL),
(405, 132, 160, 1, '3.000', NULL, 1525, 600, '0.000', '1525', NULL, NULL, '0', '508', '1800', '275', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:45', NULL),
(406, 349, 160, 1, '1.000', NULL, 593, 700, '0.000', '593', NULL, NULL, '0', '593', '700', '107', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:45', NULL),
(407, 293, 160, 1, '1.000', NULL, 85, 100, '0.000', '85', NULL, NULL, '0', '85', '100', '15', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:46', NULL),
(408, 74, 160, 1, '4.000', NULL, 339, 100, '0.000', '339', NULL, NULL, '0', '85', '400', '61', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:46', NULL),
(409, 311, 160, 1, '1.000', NULL, 1525, 1800, '0.000', '1525', NULL, NULL, '0', '1525', '1800', '275', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:47', NULL),
(410, 329, 160, 1, '3.000', NULL, 5085, 2000, '0.000', '5085', NULL, NULL, '0', '1695', '6000', '915', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:47', NULL),
(411, 124, 160, 1, '1.000', NULL, 1695, 2000, '0.000', '1695', NULL, NULL, '0', '1695', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:48', NULL),
(412, 314, 160, 1, '1.000', NULL, 1695, 2000, '0.000', '1695', NULL, NULL, '0', '1695', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:48', NULL),
(413, 122, 160, 1, '1.000', NULL, 50847, 60000, '0.000', '50847', NULL, NULL, '0', '50847', '60000', '9153', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:49', NULL),
(414, 319, 160, 1, '1.000', NULL, 3390, 4000, '0.000', '3390', NULL, NULL, '0', '3390', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:49', NULL),
(415, 317, 160, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:50', NULL),
(416, 215, 160, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:50', NULL),
(417, 263, 160, 1, '1.000', NULL, 3390, 4000, '0.000', '3390', NULL, NULL, '0', '3390', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:51', NULL),
(418, 266, 160, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-20 12:31:10', '2023-09-20 12:32:51', NULL),
(419, 141, 161, 1, '30.000', NULL, 3178, 125, '0.000', '3178', NULL, NULL, '0', '106', '3750', '572', NULL, NULL, 'COUDE PPR 25 [UNITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:43', NULL),
(420, 353, 161, 1, '30.000', NULL, 3814, 150, '0.000', '3814', NULL, NULL, '0', '127', '4500', '686', NULL, NULL, 'TÉ PPR 25 [UNITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:43', NULL),
(421, 147, 161, 1, '50.000', NULL, 23305, 550, '0.000', '23305', NULL, NULL, '0', '466', '27500', '4195', NULL, NULL, 'COUDE PPR TARODÉ 25*1/2 FEMELLE [UNITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:43', NULL),
(422, 194, 161, 1, '50.000', NULL, 23305, 550, '0.000', '23305', NULL, NULL, '0', '466', '27500', '4195', NULL, NULL, 'EMBOUT PPR TARODÉ 25*1/2 MALE [UNITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:44', NULL),
(423, 311, 161, 1, '20.000', NULL, 30508, 1800, '0.000', '30508', NULL, NULL, '0', '1525', '36000', '5492', NULL, NULL, 'ROBINET D\'ARRET 15/21 GRK [UNITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:44', NULL),
(424, 298, 161, 1, '10.000', NULL, 8475, 1000, '0.000', '8475', NULL, NULL, '0', '847', '10000', '1525', NULL, NULL, 'RÉDUCTEUR PVC PLAT 100/32 [UNITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:45', NULL),
(425, 164, 161, 1, '20.000', NULL, 3390, 200, '0.000', '3390', NULL, NULL, '0', '169', '4000', '610', NULL, NULL, 'COUDE PVC 1/4 32 [UNITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:45', NULL),
(426, 105, 161, 1, '1.000', NULL, 8051, 9500, '0.000', '8051', NULL, NULL, '0', '8051', '9500', '1449', NULL, NULL, 'COLLE TANGIT ORIGINAL 1KILO [BOITE]', 'B', '2023-09-20 12:46:56', '2023-09-20 13:05:46', NULL),
(427, 319, 162, 1, '1.000', NULL, 3814, 4500, '0.000', '3814', NULL, NULL, '0', '3814', '4500', '686', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:56', NULL),
(428, 299, 162, 1, '2.000', NULL, 1695, 1000, '0.000', '1695', NULL, NULL, '0', '847', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:56', NULL),
(429, 309, 162, 1, '1.000', NULL, 424, 500, '0.000', '424', NULL, NULL, '0', '424', '500', '76', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:57', NULL),
(430, 329, 162, 1, '3.000', NULL, 5085, 2000, '0.000', '5085', NULL, NULL, '0', '1695', '6000', '915', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:57', NULL),
(431, 324, 162, 1, '4.000', NULL, 16949, 5000, '0.000', '16949', NULL, NULL, '0', '4237', '20000', '3051', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:58', NULL),
(432, 344, 162, 1, '4.000', NULL, 6780, 2000, '0.000', '6780', NULL, NULL, '0', '1695', '8000', '1220', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:58', NULL),
(433, 314, 162, 1, '4.000', NULL, 6780, 2000, '0.000', '6780', NULL, NULL, '0', '1695', '8000', '1220', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:59', NULL),
(434, 68, 162, 1, '3.000', NULL, 35593, 14000, '0.000', '35593', NULL, NULL, '0', '11864', '42000', '6407', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:16:59', NULL),
(435, 226, 162, 1, '4.000', NULL, 1695, 500, '0.000', '1695', NULL, NULL, '0', '424', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:00', NULL),
(436, 186, 162, 1, '8.000', NULL, 2034, 300, '0.000', '2034', NULL, NULL, '0', '254', '2400', '366', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:00', NULL),
(437, 277, 162, 1, '2.000', NULL, 3390, 2000, '0.000', '3390', NULL, NULL, '0', '1695', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:01', NULL),
(438, 349, 162, 1, '1.000', NULL, 508, 600, '0.000', '508', NULL, NULL, '0', '508', '600', '92', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:01', NULL),
(439, 165, 162, 1, '6.000', NULL, 1017, 200, '0.000', '1017', NULL, NULL, '0', '169', '1200', '183', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:02', NULL),
(440, 124, 162, 1, '4.000', NULL, 6780, 2000, '0.000', '6780', NULL, NULL, '0', '1695', '8000', '1220', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:02', NULL),
(441, 181, 162, 1, '8.000', NULL, 2034, 300, '0.000', '2034', NULL, NULL, '0', '254', '2400', '366', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:03', NULL),
(442, 238, 162, 1, '4.000', NULL, 1017, 300, '0.000', '1017', NULL, NULL, '0', '254', '1200', '183', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:03', NULL),
(443, 243, 162, 1, '1.000', NULL, 424, 500, '0.000', '424', NULL, NULL, '0', '424', '500', '76', NULL, NULL, NULL, NULL, '2023-09-20 14:14:56', '2023-09-20 14:17:04', NULL),
(444, 375, 163, 1, '30.000', NULL, 20339, 800, '0.000', '20339', NULL, NULL, '0', '678', '24000', '3661', NULL, NULL, 'TETE ROBINET 15/21 GRK [UNITE]', 'B', '2023-09-20 14:15:51', '2023-09-20 14:16:36', NULL),
(445, 181, 164, 1, '1000.000', NULL, 203390, 240, '0.000', '203390', NULL, NULL, '0', '203', '240000', '36610', NULL, NULL, NULL, NULL, '2023-09-20 14:41:46', '2023-09-20 14:42:25', NULL),
(446, 124, 164, 1, '100.000', NULL, 93220, 1100, '0.000', '93220', NULL, NULL, '0', '932', '110000', '16780', NULL, NULL, NULL, NULL, '2023-09-20 14:41:46', '2023-09-20 14:42:25', NULL),
(447, 445, 165, 1, '1.000', NULL, 22034, 26000, '0.000', '22034', NULL, NULL, '0', '22034', '26000', '3966', NULL, NULL, 'MICC 202 [CARTON]', 'B', '2023-09-20 15:13:16', '2023-09-20 16:45:47', NULL),
(448, 446, 165, 1, '1.000', NULL, 26695, 31500, '0.000', '26695', NULL, NULL, '0', '26695', '31500', '4805', NULL, NULL, 'MICC 404 [CARTON]', 'B', '2023-09-20 15:13:16', '2023-09-20 16:45:47', NULL),
(449, 311, 166, 1, '100.000', NULL, 127119, 1500, '0.000', '127119', NULL, NULL, '0', '1271', '150000', '22881', NULL, NULL, 'ROBINET D\'ARRET 15/21 GRK [UNITE]', 'B', '2023-09-20 15:55:44', '2023-09-20 16:45:32', NULL),
(450, 329, 166, 1, '200.000', NULL, 305084, 1800, '0.000', '305085', NULL, NULL, '0', '1525', '360000', '54915', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-20 15:55:44', '2023-09-20 16:45:33', NULL),
(451, 160, 167, 1, '5.000', NULL, 3390, 800, '0.000', '3390', NULL, NULL, '0', '678', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:05', NULL),
(452, 404, 167, 1, '1.000', NULL, 2119, 2500, '0.000', '2119', NULL, NULL, '0', '2119', '2500', '381', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:05', NULL),
(453, 370, 167, 1, '5.000', NULL, 1271, 300, '0.000', '1271', NULL, NULL, '0', '254', '1500', '229', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:05', NULL),
(454, 296, 167, 1, '4.000', NULL, 2034, 600, '0.000', '2034', NULL, NULL, '0', '508', '2400', '366', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:06', NULL),
(455, 294, 167, 1, '4.000', NULL, 678, 200, '0.000', '678', NULL, NULL, '0', '169', '800', '122', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:06', NULL),
(456, 277, 167, 1, '1.000', NULL, 2119, 2500, '0.000', '2119', NULL, NULL, '0', '2119', '2500', '381', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:07', NULL),
(457, 207, 167, 1, '4.000', NULL, 1017, 300, '0.000', '1017', NULL, NULL, '0', '254', '1200', '183', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:08', NULL),
(458, 369, 167, 1, '4.000', NULL, 678, 200, '0.000', '678', NULL, NULL, '0', '169', '800', '122', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:08', NULL),
(459, 157, 167, 1, '2.000', NULL, 339, 200, '0.000', '339', NULL, NULL, '0', '169', '400', '61', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:09', NULL),
(460, 132, 167, 1, '3.000', NULL, 1525, 600, '0.000', '1525', NULL, NULL, '0', '508', '1800', '275', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:09', NULL),
(461, 349, 167, 1, '1.000', NULL, 593, 700, '0.000', '593', NULL, NULL, '0', '593', '700', '107', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:10', NULL),
(462, 293, 167, 1, '1.000', NULL, 85, 100, '0.000', '85', NULL, NULL, '0', '85', '100', '15', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:10', NULL),
(463, 74, 167, 1, '4.000', NULL, 339, 100, '0.000', '339', NULL, NULL, '0', '85', '400', '61', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:11', NULL),
(464, 311, 167, 1, '1.000', NULL, 1525, 1800, '0.000', '1525', NULL, NULL, '0', '1525', '1800', '275', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:11', NULL),
(465, 329, 167, 1, '3.000', NULL, 5085, 2000, '0.000', '5085', NULL, NULL, '0', '1695', '6000', '915', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:12', NULL),
(466, 124, 167, 1, '1.000', NULL, 1695, 2000, '0.000', '1695', NULL, NULL, '0', '1695', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:12', NULL),
(467, 314, 167, 1, '1.000', NULL, 1695, 2000, '0.000', '1695', NULL, NULL, '0', '1695', '2000', '305', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:13', NULL),
(468, 122, 167, 1, '1.000', NULL, 50847, 60000, '0.000', '50847', NULL, NULL, '0', '50847', '60000', '9153', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:14', NULL),
(469, 319, 167, 1, '1.000', NULL, 3390, 4000, '0.000', '3390', NULL, NULL, '0', '3390', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:14', NULL),
(470, 317, 167, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:15', NULL),
(471, 215, 167, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:15', NULL),
(472, 263, 167, 1, '1.000', NULL, 3390, 4000, '0.000', '3390', NULL, NULL, '0', '3390', '4000', '610', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:16', NULL),
(473, 266, 167, 1, '1.000', NULL, 847, 1000, '0.000', '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, NULL, NULL, '2023-09-20 16:29:05', '2023-09-20 16:45:16', NULL),
(474, 441, 168, 1, '2.000', NULL, 7288, 4300, '0.000', '7288', NULL, NULL, '0', '3644', '8600', '1312', NULL, NULL, 'LA PERCHE CAISSE 6458 [UNITE]', 'B', '2023-09-20 16:43:19', '2023-09-20 16:44:48', NULL),
(475, 329, 169, 1, '200.000', NULL, 338984, 2000, '0.000', '338983', NULL, NULL, '0', '1695', '400000', '61017', NULL, NULL, NULL, NULL, '2023-09-20 16:47:30', '2023-09-20 16:48:03', NULL),
(476, 329, 170, 1, '100.000', NULL, 156780, 1850, '0.000', '156780', NULL, NULL, '0', '1568', '185000', '28220', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:48:57', NULL),
(477, 311, 170, 1, '100.000', NULL, 131356, 1550, '0.000', '131356', NULL, NULL, '0', '1314', '155000', '23644', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:48:58', NULL),
(478, 375, 170, 1, '100.000', NULL, 67797, 800, '0.000', '67797', NULL, NULL, '0', '678', '80000', '12203', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:48:58', NULL),
(479, 376, 170, 1, '50.000', NULL, 40254, 950, '0.000', '40254', NULL, NULL, '0', '805', '47500', '7246', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:48:59', NULL),
(480, 317, 170, 1, '50.000', NULL, 31780, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:48:59', NULL),
(481, 177, 170, 1, '200.000', NULL, 50848, 300, '0.000', '50847', NULL, NULL, '0', '254', '60000', '9153', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:00', NULL),
(482, 124, 170, 1, '50.000', NULL, 52966, 1250, '0.000', '52966', NULL, NULL, '0', '1059', '62500', '9534', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:00', NULL),
(483, 333, 170, 1, '25.000', NULL, 52966, 2500, '0.000', '52966', NULL, NULL, '0', '2119', '62500', '9534', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:01', NULL),
(484, 215, 170, 1, '50.000', NULL, 31780, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:01', NULL),
(485, 213, 170, 1, '50.000', NULL, 31780, 750, '0.000', '31780', NULL, NULL, '0', '636', '37500', '5720', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:02', NULL),
(486, 263, 170, 1, '24.000', NULL, 73220, 3600, '0.000', '73220', NULL, NULL, '0', '3051', '86400', '13180', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:02', NULL),
(487, 243, 170, 1, '50.000', NULL, 14831, 350, '0.000', '14831', NULL, NULL, '0', '297', '17500', '2669', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:03', NULL),
(488, 181, 170, 1, '100.000', NULL, 21186, 250, '0.000', '21186', NULL, NULL, '0', '212', '25000', '3814', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:03', NULL),
(489, 225, 170, 1, '12.000', NULL, 35593, 3500, '0.000', '35593', NULL, NULL, '0', '2966', '42000', '6407', NULL, NULL, NULL, NULL, '2023-09-21 08:47:20', '2023-09-21 08:49:04', NULL),
(490, 271, 171, 1, '10.000', NULL, 10593, 1250, '0.000', '10593', NULL, NULL, '0', '1059', '12500', '1907', NULL, NULL, 'PORT PAPIER SC [UNITE]', 'B', '2023-09-21 10:38:39', '2023-09-21 11:18:55', NULL),
(491, 124, 171, 1, '20.000', NULL, 21186, 1250, '0.000', '21186', NULL, NULL, '0', '1059', '25000', '3814', NULL, NULL, 'COLONNE FIXE EN FER [UNITE]', 'B', '2023-09-21 10:38:39', '2023-09-21 11:18:55', NULL),
(492, 68, 172, 1, '5.000', NULL, 50847, 12000, '0.000', '50847', NULL, NULL, '0', '10169', '60000', '9153', NULL, NULL, 'ACCESOIRE PARMA [UNITE]', 'B', '2023-09-21 11:08:47', '2023-09-21 11:19:25', NULL),
(493, 217, 173, 1, '480.000', NULL, 294917, 725, '0.000', '294915', NULL, NULL, '0', '614', '348000', '53085', NULL, NULL, 'FLEXIBLE LAVABO FIRMER [UNITE]', 'B', '2023-09-21 12:18:39', '2023-09-21 12:19:04', NULL),
(494, 219, 173, 1, '360.000', NULL, 221188, 725, '0.000', '221186', NULL, NULL, '0', '614', '261000', '39814', NULL, NULL, 'FLEXIBLE WC FIRMER [UNITE]', 'B', '2023-09-21 12:18:39', '2023-09-21 12:19:04', NULL),
(495, 215, 173, 1, '200.000', NULL, 122882, 725, '0.000', '122881', NULL, NULL, '0', '614', '145000', '22119', NULL, NULL, 'FLEXIBLE INOX WC EN FER [UNITE]', 'B', '2023-09-21 12:18:39', '2023-09-21 12:19:05', NULL),
(496, 124, 173, 1, '200.000', NULL, 186440, 1100, '0.000', '186441', NULL, NULL, '0', '932', '220000', '33559', NULL, NULL, 'COLONNE FIXE EN FER [UNITE]', 'B', '2023-09-21 12:18:39', '2023-09-21 12:19:05', NULL),
(497, 339, 173, 1, '500.000', NULL, 148305, 350, '0.000', '148305', NULL, NULL, '0', '297', '175000', '26695', NULL, NULL, 'SIPHON DE SOL 10G [UNITE]', 'B', '2023-09-21 12:18:40', '2023-09-21 12:19:06', NULL),
(498, 404, 174, 1, '30.000', NULL, 45763, 1800, '0.000', '45763', NULL, NULL, '0', '1525', '54000', '8237', NULL, NULL, 'VANNE PRESSION DE 50 [UNITE]', 'B', '2023-09-21 12:24:52', '2023-09-21 12:26:43', NULL),
(499, 459, 174, 1, '1.000', NULL, 32203, 38000, '0.000', '32203', NULL, NULL, '0', '32203', '38000', '5797', NULL, NULL, 'PAUMELLE AGA 80 [CARTON]', 'B', '2023-09-21 12:24:52', '2023-09-21 12:26:43', NULL),
(500, 461, 174, 1, '1.000', NULL, 33898, 40000, '0.000', '33898', NULL, NULL, '0', '33898', '40000', '6102', NULL, NULL, 'PAUMELLE AMI 95 [CARTON]', 'B', '2023-09-21 12:24:52', '2023-09-21 12:26:44', NULL),
(501, 19, 174, 1, '1.000', NULL, 2542, 3000, '0.000', '2542', NULL, NULL, '0', '2542', '3000', '458', NULL, NULL, 'EQUERRE 10\"*12\" [DOUZAINE]', 'B', '2023-09-21 12:24:52', '2023-09-21 12:26:45', NULL),
(502, 20, 174, 1, '4.000', NULL, 13559, 4000, '0.000', '13559', NULL, NULL, '0', '3390', '16000', '2441', NULL, NULL, 'EQUERRE 12\"*14\" [DOUZAINE]', 'B', '2023-09-21 12:24:52', '2023-09-21 12:26:45', NULL),
(503, 425, 175, 1, '3.000', NULL, 41949, 16500, '0.000', '41949', NULL, NULL, '0', '13983', '49500', '7551', NULL, NULL, 'CYLINDRE LA PERCHE 60M LAP SACHET [DOUZAINE]', 'B', '2023-09-21 12:36:53', '2023-09-21 12:45:26', NULL),
(504, 486, 176, 1, '1.000', NULL, 54237, 64000, '0.000', '54237', NULL, NULL, '0', '54237', '64000', '9763', NULL, NULL, 'CYLINDRE VACHETTE 60MM 3K [CARTON]', 'B', '2023-09-21 13:09:42', '2023-09-21 15:11:55', NULL),
(505, 68, 177, 1, '8.000', NULL, 81356, 12000, '0.000', '81356', NULL, NULL, '0', '10169', '96000', '14644', NULL, NULL, 'ACCESOIRE PARMA [UNITE]', 'B', '2023-09-21 13:35:59', '2023-09-21 15:11:45', NULL),
(506, 437, 178, 1, '40.000', NULL, 228814, 6750, '0.000', '228814', NULL, NULL, '0', '5720', '270000', '41186', NULL, NULL, 'LA PERCHE 911B6458 AB NORMALE [UNITE]', 'B', '2023-09-21 15:15:38', '2023-09-21 15:16:41', NULL),
(507, 458, 178, 1, '2.000', NULL, 59322, 35000, '0.000', '59322', NULL, NULL, '0', '29661', '70000', '10678', NULL, NULL, 'PAUMELLE AGA 160  [CARTON]', 'B', '2023-09-21 15:15:38', '2023-09-21 15:16:41', NULL),
(508, 404, 179, 1, '30.000', NULL, 45763, 1800, '0.000', '45763', NULL, NULL, '0', '1525', '54000', '8237', NULL, NULL, 'VANNE PRESSION DE 50 [UNITE]', 'B', '2023-09-21 15:20:58', '2023-09-21 15:21:38', NULL),
(509, 459, 179, 1, '1.000', NULL, 32203, 38000, '0.000', '32203', NULL, NULL, '0', '32203', '38000', '5797', NULL, NULL, 'PAUMELLE AGA 80 [CARTON]', 'B', '2023-09-21 15:20:58', '2023-09-21 15:21:38', NULL),
(510, 461, 179, 1, '1.000', NULL, 33898, 40000, '0.000', '33898', NULL, NULL, '0', '33898', '40000', '6102', NULL, NULL, 'PAUMELLE AMI 95 [CARTON]', 'B', '2023-09-21 15:20:58', '2023-09-21 15:21:39', NULL),
(511, 19, 179, 1, '1.000', NULL, 2458, 2900, '0.000', '2458', NULL, NULL, '0', '2458', '2900', '442', NULL, NULL, 'EQUERRE 10\"*12\" [DOUZAINE]', 'B', '2023-09-21 15:20:58', '2023-09-21 15:21:40', NULL);
INSERT INTO `produit_cond_com_clit` (`id`, `produit_id`, `commande_clit_id`, `magasin_id`, `qtite`, `taxe_specifique`, `montant`, `prix`, `rest_aliv`, `montant_ht_apr_rse`, `type_remise`, `valeur_remise`, `remise`, `prix_ht`, `montant_ttcp`, `montant_tvap`, `carton`, `piece`, `libelle_produit`, `groupe_taxe_produit`, `created_at`, `updated_at`, `deleted_at`) VALUES
(512, 20, 179, 1, '4.000', NULL, 10678, 3150, '0.000', '10678', NULL, NULL, '0', '2669', '12600', '1922', NULL, NULL, 'EQUERRE 12\"*14\" [DOUZAINE]', 'B', '2023-09-21 15:20:58', '2023-09-21 15:21:40', NULL),
(513, 213, 180, 1, '40.000', NULL, 25424, 750, '0.000', '25424', NULL, NULL, '0', '636', '30000', '4576', NULL, NULL, 'FLEXIBLE INOX LAVABO EN FER [UNITE]', 'B', '2023-09-21 16:16:17', '2023-09-21 16:16:34', NULL),
(514, 484, 181, 1, '1.000', NULL, 101695, 120000, '0.000', '101695', NULL, NULL, '0', '101695', '120000', '18305', NULL, NULL, 'CYLINDRE LA PERCHE BLEU 60M [CARTON]', 'B', '2023-09-21 16:34:22', '2023-09-21 16:35:19', NULL),
(515, 451, 182, 1, '1.000', NULL, 10169, 12000, '0.000', '10169', NULL, NULL, '0', '10169', '12000', '1831', NULL, NULL, 'SERRURE PARFAIT A GAGE BLACK A007-4 [UNITE]', 'B', '2023-09-21 16:42:18', '2023-09-21 16:51:56', NULL),
(516, 448, 183, 1, '1.000', NULL, 7627, 9000, '0.000', '7627', NULL, NULL, '0', '7627', '9000', '1373', NULL, NULL, 'PACO PARFAIT G112-AB [UNITE]', 'B', '2023-09-21 16:50:44', '2023-09-21 16:52:09', NULL),
(517, 420, 183, 1, '4.000', NULL, 20339, 6000, '0.000', '20339', NULL, NULL, '0', '5085', '24000', '3661', NULL, NULL, 'CADENAS VACHETTE ORIGINAL  80MM [UNITE]', 'B', '2023-09-21 16:50:44', '2023-09-21 16:52:09', NULL),
(518, 423, 184, 1, '12.000', NULL, 26441, 2600, '0.000', '26441', NULL, NULL, '0', '2203', '31200', '4759', NULL, NULL, 'CYLINDRE BUTUC UNIC U70A [UNITE]', 'B', '2023-09-22 10:32:53', '2023-09-22 11:55:01', NULL),
(519, 422, 184, 1, '6.000', NULL, 13220, 2600, '0.000', '13220', NULL, NULL, '0', '2203', '15600', '2380', NULL, NULL, 'CYLINDRE ARM LOCK A70 [UNITE]', 'B', '2023-09-22 10:32:53', '2023-09-22 11:55:01', NULL),
(520, 427, 184, 1, '6.000', NULL, 13220, 2600, '0.000', '13220', NULL, NULL, '0', '2203', '15600', '2380', NULL, NULL, 'CYLINDRE PARFAIT BLEU P70A [UNITE]', 'B', '2023-09-22 10:32:53', '2023-09-22 11:55:01', NULL),
(521, 416, 185, 1, '1.000', NULL, 57627, 68000, '0.000', '57627', NULL, NULL, '0', '57627', '68000', '10373', NULL, NULL, ' AGA 270   [CARTON]', 'B', '2023-09-22 11:21:33', '2023-09-22 11:55:14', NULL),
(522, 484, 186, 1, '1.000', NULL, 105932, 125000, '0.000', '105932', NULL, NULL, '0', '105932', '125000', '19068', NULL, NULL, 'CYLINDRE LA PERCHE BLEU 60M [CARTON]', 'B', '2023-09-22 11:41:10', '2023-09-22 11:55:24', NULL),
(523, 416, 187, 1, '1.000', NULL, 59322, 70000, '0.000', '59322', NULL, NULL, '0', '59322', '70000', '10678', NULL, NULL, ' AGA 270   [CARTON]', 'B', '2023-09-22 12:17:38', '2023-09-22 12:50:38', NULL),
(524, 437, 187, 1, '10.000', NULL, 55085, 6500, '0.000', '55085', NULL, NULL, '0', '5508', '65000', '9915', NULL, NULL, 'LA PERCHE 911B6458 AB NORMALE [UNITE]', 'B', '2023-09-22 12:17:38', '2023-09-22 12:50:38', NULL),
(525, 12, 188, 1, '1.000', NULL, 5932, 7000, '0.000', '5932', NULL, NULL, '0', '5932', '7000', '1068', NULL, NULL, 'SERPIERE [DOUZAINE]', 'B', '2023-09-22 12:48:16', '2023-09-22 12:50:49', NULL),
(526, 462, 188, 1, '5.000', NULL, 27542, 6500, '0.000', '27542', NULL, NULL, '0', '5508', '32500', '4958', NULL, NULL, 'SERRURE EVERLEO 905AB/7050H [UNITE]', 'B', '2023-09-22 12:48:16', '2023-09-22 12:50:49', NULL),
(527, 23, 189, 1, '1.000', NULL, 38136, 45000, '0.000', '38136', NULL, NULL, '0', '38136', '45000', '6864', NULL, NULL, 'GRILLAGE LAPIN GALVANISÉ 25M ORIGINAL [ROULEAU]', 'B', '2023-09-22 12:49:15', '2023-09-22 12:51:01', NULL),
(528, 59, 190, 1, '5.000', NULL, 16949, 4000, '0.000', '16949', NULL, NULL, '0', '3390', '20000', '3051', NULL, NULL, 'PUNEU BROUETTE [UNITE]', 'B', '2023-09-22 13:39:16', '2023-09-22 13:39:41', NULL),
(529, 319, 191, 1, '4.000', NULL, 8475, 2500, '4.000', '8475', NULL, NULL, '0', '2119', '10000', '1525', NULL, NULL, 'ROBINET EVIER MURAL [UNITE]', 'B', '2023-09-22 15:26:26', '2023-09-22 15:26:26', NULL),
(530, 329, 191, 1, '10.000', NULL, 15678, 1850, '10.000', '15678', NULL, NULL, '0', '1568', '18500', '2822', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-22 15:26:26', '2023-09-22 15:26:27', NULL),
(531, 349, 191, 1, '10.000', NULL, 3814, 450, '10.000', '3814', NULL, NULL, '0', '381', '4500', '686', NULL, NULL, 'TÉ LAITON 15/21 [UNITE]', 'B', '2023-09-22 15:26:26', '2023-09-22 15:26:28', NULL),
(532, 271, 192, 1, '50.000', NULL, 52966, 1250, '50.000', '52966', NULL, NULL, '0', '1059', '62500', '9534', NULL, NULL, 'PORT PAPIER SC [UNITE]', 'B', '2023-09-22 16:00:48', '2023-09-22 16:00:49', NULL),
(533, 329, 192, 1, '100.000', NULL, 152542, 1800, '100.000', '152542', NULL, NULL, '0', '1525', '180000', '27458', NULL, NULL, 'ROBINET PUISSAGE 15/21 GRK [UNITE]', 'B', '2023-09-22 16:00:48', '2023-09-22 16:00:49', NULL),
(534, 335, 192, 1, '20.000', NULL, 40678, 2400, '20.000', '40678', NULL, NULL, '0', '2034', '48000', '7322', NULL, NULL, 'ROBINET PUISSAGE KMEI 20/27 [UNITE]', 'B', '2023-09-22 16:00:48', '2023-09-22 16:00:50', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_com_frs`
--

DROP TABLE IF EXISTS `produit_cond_com_frs`;
CREATE TABLE IF NOT EXISTS `produit_cond_com_frs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_frs_id` int DEFAULT NULL,
  `produit_cond_id` int NOT NULL,
  `qte_comfrs` decimal(10,2) NOT NULL,
  `montant_cond` decimal(10,2) NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_66568B8AEA316CE` (`commande_frs_id`),
  KEY `IDX_66568B8A132D0AAA` (`produit_cond_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_ddp`
--

DROP TABLE IF EXISTS `produit_cond_ddp`;
CREATE TABLE IF NOT EXISTS `produit_cond_ddp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `demande_de_prix_id` int NOT NULL,
  `produit_cond_id` int NOT NULL,
  `qte_ddp` decimal(10,2) NOT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BCCF6A1E5E931ED0` (`demande_de_prix_id`),
  KEY `IDX_BCCF6A1E132D0AAA` (`produit_cond_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_facture`
--

DROP TABLE IF EXISTS `produit_cond_facture`;
CREATE TABLE IF NOT EXISTS `produit_cond_facture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int NOT NULL,
  `facture_proforma_id` int NOT NULL,
  `qtite` decimal(10,2) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `montant_ht_apr_rse` decimal(10,0) DEFAULT NULL,
  `type_remise` varchar(255) DEFAULT NULL,
  `valeur_remise` varchar(255) DEFAULT NULL,
  `remise` decimal(10,0) DEFAULT NULL,
  `prix_ht` decimal(10,0) NOT NULL,
  `montant_tvap` decimal(10,0) NOT NULL,
  `montant_ttcp` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2CD3FB7BF347EFB` (`produit_id`),
  KEY `IDX_2CD3FB7BB5EC257B` (`facture_proforma_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_mag`
--

DROP TABLE IF EXISTS `produit_cond_mag`;
CREATE TABLE IF NOT EXISTS `produit_cond_mag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `magasin_id` int NOT NULL,
  `produit_conditionnement_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `qte_stock_mag` decimal(10,2) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4DBA201320096AE3` (`magasin_id`),
  KEY `IDX_4DBA201339C2AB40` (`produit_conditionnement_id`),
  KEY `IDX_4DBA2013EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_mag`
--

INSERT INTO `produit_cond_mag` (`id`, `magasin_id`, `produit_conditionnement_id`, `point_vente_id`, `qte_stock_mag`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, '23.00', NULL, '2023-09-12 15:42:01', NULL, NULL),
(2, 1, 2, 1, '760.00', NULL, '2023-09-12 15:42:02', '2023-09-19 15:34:45', NULL),
(3, 1, 3, 1, '379.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(4, 1, 4, 1, '427.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(5, 1, 5, 1, '4.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(6, 1, 6, 1, '1.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(7, 1, 7, 1, '3.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(8, 1, 8, 1, '7.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(9, 1, 9, 1, '5.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(10, 1, 10, 1, '4.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(11, 1, 11, 1, '51.00', NULL, '2023-09-12 15:42:02', NULL, NULL),
(12, 1, 12, 1, '120.00', NULL, '2023-09-12 15:42:02', '2023-09-22 12:50:49', NULL),
(13, 1, 13, 1, '0.00', NULL, '2023-09-12 15:42:02', '2023-09-21 10:47:23', NULL),
(14, 1, 14, 1, '0.00', NULL, '2023-09-12 15:42:03', '2023-09-21 10:47:23', NULL),
(15, 1, 15, 1, '14.00', NULL, '2023-09-12 15:42:03', NULL, NULL),
(16, 1, 16, 1, '79.00', NULL, '2023-09-12 15:42:03', NULL, NULL),
(17, 1, 17, 1, '5.00', NULL, '2023-09-12 15:42:03', NULL, NULL),
(18, 1, 18, 1, '2.00', NULL, '2023-09-12 15:42:03', NULL, NULL),
(19, 1, 19, 1, '0.00', NULL, '2023-09-12 15:42:03', '2023-09-21 15:21:40', NULL),
(20, 1, 20, 1, '0.00', NULL, '2023-09-12 15:42:03', '2023-09-21 15:21:41', NULL),
(21, 1, 21, 1, '75.00', NULL, '2023-09-12 15:42:03', NULL, NULL),
(22, 1, 22, 1, '26.00', NULL, '2023-09-12 15:42:03', NULL, NULL),
(23, 1, 23, 1, '5.00', NULL, '2023-09-12 15:42:04', '2023-09-22 12:51:01', NULL),
(24, 1, 24, 1, '50.00', NULL, '2023-09-12 15:42:04', '2023-09-15 18:33:37', NULL),
(25, 1, 25, 1, '6.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(26, 1, 26, 1, '1.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(27, 1, 27, 1, '1.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(28, 1, 28, 1, '8.00', NULL, '2023-09-12 15:42:04', '2023-09-15 18:30:18', NULL),
(29, 1, 29, 1, '54.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(30, 1, 30, 1, '1.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(31, 1, 31, 1, '18.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(32, 1, 32, 1, '9.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(33, 1, 33, 1, '54.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(34, 1, 34, 1, '18.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(35, 1, 35, 1, '47.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(36, 1, 36, 1, '1000.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(37, 1, 37, 1, '3.00', NULL, '2023-09-12 15:42:04', NULL, NULL),
(38, 1, 38, 1, '160.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(39, 1, 39, 1, '1.00', NULL, '2023-09-12 15:42:05', '2023-09-21 11:18:05', NULL),
(40, 1, 40, 1, '2.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(41, 1, 41, 1, '4.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(42, 1, 42, 1, '11.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(43, 1, 43, 1, '61.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(44, 1, 44, 1, '8.00', NULL, '2023-09-12 15:42:05', '2023-09-15 11:20:47', NULL),
(45, 1, 45, 1, '17.00', NULL, '2023-09-12 15:42:05', '2023-09-15 11:20:48', NULL),
(46, 1, 46, 1, '30.00', NULL, '2023-09-12 15:42:05', '2023-09-15 11:20:50', NULL),
(47, 1, 47, 1, '45.00', NULL, '2023-09-12 15:42:05', '2023-09-15 11:20:49', NULL),
(48, 1, 48, 1, '14.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(49, 1, 49, 1, '45.00', NULL, '2023-09-12 15:42:05', '2023-09-18 12:27:26', NULL),
(50, 1, 50, 1, '1.00', NULL, '2023-09-12 15:42:05', '2023-09-15 18:26:31', NULL),
(51, 1, 51, 1, '75.00', NULL, '2023-09-12 15:42:05', '2023-09-15 18:26:31', NULL),
(52, 1, 52, 1, '105.00', NULL, '2023-09-12 15:42:05', '2023-09-18 12:27:26', NULL),
(53, 1, 53, 1, '49.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(54, 1, 54, 1, '7.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(55, 1, 55, 1, '1.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(56, 1, 56, 1, '83.00', NULL, '2023-09-12 15:42:05', NULL, NULL),
(57, 1, 57, 1, '413.00', NULL, '2023-09-12 15:42:06', NULL, NULL),
(58, 1, 58, 1, '1.00', NULL, '2023-09-12 15:42:06', NULL, NULL),
(59, 1, 59, 1, '232.00', NULL, '2023-09-12 15:42:06', '2023-09-22 13:39:41', NULL),
(60, 1, 60, 1, '19.00', NULL, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(61, 1, 61, 1, '15.00', NULL, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(62, 1, 62, 1, '1.00', NULL, '2023-09-12 15:42:06', '2023-09-15 18:12:07', NULL),
(63, 1, 63, 1, '0.00', NULL, '2023-09-12 15:42:06', '2023-09-21 11:18:10', NULL),
(64, 1, 64, 1, '193.00', NULL, '2023-09-12 15:42:06', '2023-09-18 14:14:06', NULL),
(65, 1, 65, 1, '12.00', NULL, '2023-09-12 15:42:06', '2023-09-19 16:01:34', NULL),
(66, 1, 66, 1, '5.00', NULL, '2023-09-12 15:42:06', NULL, NULL),
(67, 1, 67, 1, '5.00', NULL, '2023-09-12 15:42:06', NULL, NULL),
(68, 1, 68, 1, '7.00', NULL, '2023-09-12 15:42:06', '2023-09-21 15:11:45', NULL),
(69, 1, 69, 1, '20.00', NULL, '2023-09-12 15:42:06', NULL, NULL),
(70, 1, 70, 1, '15.00', NULL, '2023-09-12 15:42:06', NULL, NULL),
(71, 1, 71, 1, '108.00', NULL, '2023-09-12 15:42:07', '2023-09-15 18:09:26', NULL),
(72, 1, 72, 1, '80.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(73, 1, 73, 1, '1.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(74, 1, 74, 1, '27059.00', NULL, '2023-09-12 15:42:07', '2023-09-20 16:45:11', NULL),
(75, 1, 75, 1, '990.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(76, 1, 76, 1, '9.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(77, 1, 77, 1, '2016.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(78, 1, 78, 1, '3295.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(79, 1, 79, 1, '338.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(80, 1, 80, 1, '2051.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(81, 1, 81, 1, '1383.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(82, 1, 82, 1, '929.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(83, 1, 83, 1, '9.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(84, 1, 84, 1, '228.00', NULL, '2023-09-12 15:42:07', NULL, NULL),
(85, 1, 85, 1, '14.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(86, 1, 86, 1, '258.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(87, 1, 87, 1, '1.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(88, 1, 88, 1, '1.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(89, 1, 89, 1, '1799.00', NULL, '2023-09-12 15:42:08', '2023-09-16 14:14:38', NULL),
(90, 1, 90, 1, '1.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(91, 1, 91, 1, '162.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(92, 1, 92, 1, '344.00', NULL, '2023-09-12 15:42:08', '2023-09-15 18:08:18', NULL),
(93, 1, 93, 1, '-4.00', NULL, '2023-09-12 15:42:08', '2023-09-15 18:08:19', NULL),
(94, 1, 94, 1, '1330.00', NULL, '2023-09-12 15:42:08', '2023-09-15 18:30:56', NULL),
(95, 1, 95, 1, '5.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(96, 1, 96, 1, '149.00', NULL, '2023-09-12 15:42:08', NULL, NULL),
(97, 1, 97, 1, '690.00', NULL, '2023-09-12 15:42:09', NULL, NULL),
(98, 1, 98, 1, '13.00', NULL, '2023-09-12 15:42:09', NULL, NULL),
(99, 1, 99, 1, '6.00', NULL, '2023-09-12 15:42:09', '2023-09-15 18:10:30', NULL),
(100, 1, 100, 1, '2.00', NULL, '2023-09-12 15:42:09', '2023-09-15 17:55:55', NULL),
(101, 1, 101, 1, '13.00', NULL, '2023-09-12 15:42:09', NULL, NULL),
(102, 1, 102, 1, '29.00', NULL, '2023-09-12 15:42:09', NULL, NULL),
(103, 1, 103, 1, '24.00', NULL, '2023-09-12 15:42:09', '2023-09-15 18:25:53', NULL),
(104, 1, 104, 1, '26.00', NULL, '2023-09-12 15:42:09', '2023-09-16 14:14:38', NULL),
(105, 1, 105, 1, '68.00', NULL, '2023-09-12 15:42:09', '2023-09-20 13:05:46', NULL),
(106, 1, 106, 1, '7.00', NULL, '2023-09-12 15:42:09', '2023-09-21 11:18:06', NULL),
(107, 1, 107, 1, '30.00', NULL, '2023-09-12 15:42:09', NULL, NULL),
(108, 1, 108, 1, '56.00', NULL, '2023-09-12 15:42:09', '2023-09-15 18:29:03', NULL),
(109, 1, 109, 1, '45.00', NULL, '2023-09-12 15:42:09', '2023-09-15 18:29:04', NULL),
(110, 1, 110, 1, '7.00', NULL, '2023-09-12 15:42:10', NULL, NULL),
(111, 1, 111, 1, '0.00', NULL, '2023-09-12 15:42:10', '2023-09-15 17:59:09', NULL),
(112, 1, 112, 1, '5.00', NULL, '2023-09-12 15:42:10', NULL, NULL),
(113, 1, 113, 1, '3460.00', NULL, '2023-09-12 15:42:10', '2023-09-15 18:30:36', NULL),
(114, 1, 114, 1, '448.00', NULL, '2023-09-12 15:42:10', '2023-09-21 10:47:22', NULL),
(115, 1, 115, 1, '5.00', NULL, '2023-09-12 15:42:10', NULL, NULL),
(116, 1, 116, 1, '2595.00', NULL, '2023-09-12 15:42:10', NULL, NULL),
(117, 1, 117, 1, '94.00', NULL, '2023-09-12 15:42:10', NULL, NULL),
(118, 1, 118, 1, '1.00', NULL, '2023-09-12 15:42:10', NULL, NULL),
(119, 1, 119, 1, '5.00', NULL, '2023-09-12 15:42:10', NULL, NULL),
(120, 1, 120, 1, '10.00', NULL, '2023-09-12 15:42:11', NULL, NULL),
(121, 1, 121, 1, '734.00', NULL, '2023-09-12 15:42:11', '2023-09-15 18:32:21', NULL),
(122, 1, 122, 1, '4.00', NULL, '2023-09-12 15:42:11', '2023-09-20 16:45:14', NULL),
(123, 1, 123, 1, '30.00', NULL, '2023-09-12 15:42:11', NULL, NULL),
(124, 1, 124, 1, '3531.00', NULL, '2023-09-12 15:42:11', '2023-09-21 12:19:06', NULL),
(125, 1, 125, 1, '2345.00', NULL, '2023-09-12 15:42:11', '2023-09-15 18:29:00', NULL),
(126, 1, 126, 1, '20.00', NULL, '2023-09-12 15:42:11', NULL, NULL),
(127, 1, 127, 1, '167.00', NULL, '2023-09-12 15:42:11', NULL, NULL),
(128, 1, 128, 1, '45.00', NULL, '2023-09-12 15:42:11', '2023-09-15 17:41:40', NULL),
(129, 1, 129, 1, '338.00', NULL, '2023-09-12 15:42:11', '2023-09-19 08:43:45', NULL),
(130, 1, 130, 1, '40.00', NULL, '2023-09-12 15:42:11', NULL, NULL),
(131, 1, 131, 1, '121.00', NULL, '2023-09-12 15:42:11', NULL, NULL),
(132, 1, 132, 1, '23850.00', NULL, '2023-09-12 15:42:12', '2023-09-21 11:18:07', NULL),
(133, 1, 133, 1, '1.00', NULL, '2023-09-12 15:42:12', NULL, NULL),
(134, 1, 134, 1, '213.00', NULL, '2023-09-12 15:42:12', '2023-09-15 18:21:19', NULL),
(135, 1, 135, 1, '150.00', NULL, '2023-09-12 15:42:12', NULL, NULL),
(136, 1, 136, 1, '4.00', NULL, '2023-09-12 15:42:12', NULL, NULL),
(137, 1, 137, 1, '400.00', NULL, '2023-09-12 15:42:12', NULL, NULL),
(138, 1, 138, 1, '4.00', NULL, '2023-09-12 15:42:12', NULL, NULL),
(139, 1, 139, 1, '0.00', NULL, '2023-09-12 15:42:13', '2023-09-15 18:34:15', NULL),
(140, 1, 140, 1, '2.00', NULL, '2023-09-12 15:42:13', NULL, NULL),
(141, 1, 141, 1, '2070.00', NULL, '2023-09-12 15:42:13', '2023-09-20 13:05:43', NULL),
(142, 1, 142, 1, '1.00', NULL, '2023-09-12 15:42:13', '2023-09-15 18:34:14', NULL),
(143, 1, 143, 1, '0.00', NULL, '2023-09-12 15:42:13', '2023-09-15 18:34:12', NULL),
(144, 1, 144, 1, '172.00', NULL, '2023-09-12 15:42:13', NULL, NULL),
(145, 1, 145, 1, '1820.00', NULL, '2023-09-12 15:42:13', NULL, NULL),
(146, 1, 146, 1, '1128.00', NULL, '2023-09-12 15:42:13', NULL, NULL),
(147, 1, 147, 1, '711.00', NULL, '2023-09-12 15:42:13', '2023-09-20 13:05:44', NULL),
(148, 1, 148, 1, '105.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(149, 1, 149, 1, '2.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(150, 1, 150, 1, '100.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(151, 1, 151, 1, '1.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(152, 1, 152, 1, '75.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(153, 1, 153, 1, '32.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(154, 1, 154, 1, '2.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(155, 1, 155, 1, '34.00', NULL, '2023-09-12 15:42:14', NULL, NULL),
(156, 1, 156, 1, '3560.00', NULL, '2023-09-12 15:42:14', '2023-09-21 11:18:08', NULL),
(157, 1, 157, 1, '23.00', NULL, '2023-09-12 15:42:14', '2023-09-20 16:45:09', NULL),
(158, 1, 158, 1, '1.00', NULL, '2023-09-12 15:42:15', NULL, NULL),
(159, 1, 159, 1, '2.00', NULL, '2023-09-12 15:42:15', NULL, NULL),
(160, 1, 160, 1, '0.00', NULL, '2023-09-12 15:42:15', '2023-09-20 16:45:05', NULL),
(161, 1, 161, 1, '177.00', NULL, '2023-09-12 15:42:15', '2023-09-15 18:02:58', NULL),
(162, 1, 162, 1, '46.00', NULL, '2023-09-12 15:42:15', NULL, NULL),
(163, 1, 163, 1, '62.00', NULL, '2023-09-12 15:42:15', NULL, NULL),
(164, 1, 164, 1, '3195.00', NULL, '2023-09-12 15:42:15', '2023-09-20 13:05:46', NULL),
(165, 1, 165, 1, '10304.00', NULL, '2023-09-12 15:42:15', '2023-09-20 14:17:02', NULL),
(166, 1, 166, 1, '1.00', NULL, '2023-09-12 15:42:15', NULL, NULL),
(167, 1, 167, 1, '2.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(168, 1, 168, 1, '592.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(169, 1, 169, 1, '65.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(170, 1, 170, 1, '71.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(171, 1, 171, 1, '134.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(172, 1, 172, 1, '157.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(173, 1, 173, 1, '1.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(174, 1, 174, 1, '16.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(175, 1, 175, 1, '81.00', NULL, '2023-09-12 15:42:16', NULL, NULL),
(176, 1, 176, 1, '2.00', NULL, '2023-09-12 15:42:17', NULL, NULL),
(177, 1, 177, 1, '2741.00', NULL, '2023-09-12 15:42:17', '2023-09-21 08:49:00', NULL),
(178, 1, 178, 1, '224.00', NULL, '2023-09-12 15:42:17', '2023-09-15 17:57:18', NULL),
(179, 1, 179, 1, '26.00', NULL, '2023-09-12 15:42:17', '2023-09-15 17:57:18', NULL),
(180, 1, 180, 1, '219.00', NULL, '2023-09-12 15:42:17', NULL, NULL),
(181, 1, 181, 1, '17760.00', NULL, '2023-09-12 15:42:17', '2023-09-21 08:49:04', NULL),
(182, 1, 182, 1, '14934.00', NULL, '2023-09-12 15:42:17', '2023-09-21 11:18:04', NULL),
(183, 1, 183, 1, '1611.00', NULL, '2023-09-12 15:42:17', NULL, NULL),
(184, 1, 184, 1, '1879.00', NULL, '2023-09-12 15:42:17', '2023-09-15 18:21:21', NULL),
(185, 1, 185, 1, '4299.00', NULL, '2023-09-12 15:42:18', '2023-09-19 10:10:41', NULL),
(186, 1, 186, 1, '5779.00', NULL, '2023-09-12 15:42:18', '2023-09-20 14:17:01', NULL),
(187, 1, 187, 1, '5.00', NULL, '2023-09-12 15:42:18', NULL, NULL),
(188, 1, 188, 1, '47.00', NULL, '2023-09-12 15:42:18', '2023-09-15 18:10:30', NULL),
(189, 1, 189, 1, '2.00', NULL, '2023-09-12 15:42:18', '2023-09-21 11:18:11', NULL),
(190, 1, 190, 1, '1206.00', NULL, '2023-09-12 15:42:18', NULL, NULL),
(191, 1, 191, 1, '1184.00', NULL, '2023-09-12 15:42:18', NULL, NULL),
(192, 1, 192, 1, '1059.00', NULL, '2023-09-12 15:42:18', NULL, NULL),
(193, 1, 193, 1, '1339.00', NULL, '2023-09-12 15:42:18', NULL, NULL),
(194, 1, 194, 1, '6541.00', NULL, '2023-09-12 15:42:19', '2023-09-20 13:05:44', NULL),
(195, 1, 195, 1, '10.00', NULL, '2023-09-12 15:42:19', NULL, NULL),
(196, 1, 196, 1, '3486.00', NULL, '2023-09-12 15:42:19', '2023-09-16 14:14:33', NULL),
(197, 1, 197, 1, '253.00', NULL, '2023-09-12 15:42:19', '2023-09-15 18:12:52', NULL),
(198, 1, 198, 1, '148.00', NULL, '2023-09-12 15:42:19', '2023-09-16 14:14:37', NULL),
(199, 1, 199, 1, '189.00', NULL, '2023-09-12 15:42:19', NULL, NULL),
(200, 1, 200, 1, '96.00', NULL, '2023-09-12 15:42:19', NULL, NULL),
(201, 1, 201, 1, '172.00', NULL, '2023-09-12 15:42:19', NULL, NULL),
(202, 1, 202, 1, '1.00', NULL, '2023-09-12 15:42:20', NULL, NULL),
(203, 1, 203, 1, '1.00', NULL, '2023-09-12 15:42:20', NULL, NULL),
(204, 1, 204, 1, '1.00', NULL, '2023-09-12 15:42:20', NULL, NULL),
(205, 1, 205, 1, '0.00', NULL, '2023-09-12 15:42:20', '2023-09-15 18:25:13', NULL),
(206, 1, 206, 1, '4.00', NULL, '2023-09-12 15:42:20', NULL, NULL),
(207, 1, 207, 1, '46.00', NULL, '2023-09-12 15:42:20', '2023-09-20 16:45:08', NULL),
(208, 1, 208, 1, '12.00', NULL, '2023-09-12 15:42:20', '2023-09-15 17:45:58', NULL),
(209, 1, 209, 1, '350.00', NULL, '2023-09-12 15:42:20', '2023-09-15 17:45:59', NULL),
(210, 1, 210, 1, '196.00', NULL, '2023-09-12 15:42:21', NULL, NULL),
(211, 1, 211, 1, '4.00', NULL, '2023-09-12 15:42:21', '2023-09-21 11:18:10', NULL),
(212, 1, 212, 1, '9.00', NULL, '2023-09-12 15:42:21', '2023-09-20 11:07:41', NULL),
(213, 1, 213, 1, '1819.00', NULL, '2023-09-12 15:42:21', '2023-09-21 16:16:34', NULL),
(214, 1, 214, 1, '42.00', NULL, '2023-09-12 15:42:21', '2023-09-15 17:35:50', NULL),
(215, 1, 215, 1, '1422.00', NULL, '2023-09-12 15:42:21', '2023-09-21 12:19:05', NULL),
(216, 1, 216, 1, '169.00', NULL, '2023-09-12 15:42:21', '2023-09-15 18:23:52', NULL),
(217, 1, 217, 1, '208.00', NULL, '2023-09-12 15:42:21', '2023-09-21 12:19:04', NULL),
(218, 1, 218, 1, '1.00', NULL, '2023-09-12 15:42:21', NULL, NULL),
(219, 1, 219, 1, '112.00', NULL, '2023-09-12 15:42:22', '2023-09-21 12:19:05', NULL),
(220, 1, 220, 1, '1.00', NULL, '2023-09-12 15:42:22', NULL, NULL),
(221, 1, 221, 1, '27.00', NULL, '2023-09-12 15:42:22', NULL, NULL),
(222, 1, 222, 1, '0.00', NULL, '2023-09-12 15:42:22', '2023-09-15 18:27:15', NULL),
(223, 1, 223, 1, '78.00', NULL, '2023-09-12 15:42:22', '2023-09-15 18:26:53', NULL),
(224, 1, 224, 1, '1594.00', NULL, '2023-09-12 15:42:22', '2023-09-15 18:26:53', NULL),
(225, 1, 225, 1, '42.00', NULL, '2023-09-12 15:42:22', '2023-09-21 08:49:04', NULL),
(226, 1, 226, 1, '523.00', NULL, '2023-09-12 15:42:22', '2023-09-20 14:17:00', NULL),
(227, 1, 227, 1, '4.00', NULL, '2023-09-12 15:42:23', NULL, NULL),
(228, 1, 228, 1, '170.00', NULL, '2023-09-12 15:42:23', NULL, NULL),
(229, 1, 229, 1, '377.00', NULL, '2023-09-12 15:42:23', NULL, NULL),
(230, 1, 230, 1, '254.00', NULL, '2023-09-12 15:42:23', NULL, NULL),
(231, 1, 231, 1, '496.00', NULL, '2023-09-12 15:42:23', '2023-09-15 18:26:52', NULL),
(232, 1, 232, 1, '258.00', NULL, '2023-09-12 15:42:23', '2023-09-15 17:58:01', NULL),
(233, 1, 233, 1, '7.00', NULL, '2023-09-12 15:42:23', NULL, NULL),
(234, 1, 234, 1, '3.00', NULL, '2023-09-12 15:42:23', NULL, NULL),
(235, 1, 235, 1, '3.00', NULL, '2023-09-12 15:42:24', NULL, NULL),
(236, 1, 236, 1, '190.00', NULL, '2023-09-12 15:42:24', '2023-09-18 12:27:45', NULL),
(237, 1, 237, 1, '18.00', NULL, '2023-09-12 15:42:24', NULL, NULL),
(238, 1, 238, 1, '18071.00', NULL, '2023-09-12 15:42:24', '2023-09-20 14:17:04', NULL),
(239, 1, 239, 1, '902.00', NULL, '2023-09-12 15:42:24', NULL, NULL),
(240, 1, 240, 1, '1389.00', NULL, '2023-09-12 15:42:24', NULL, NULL),
(241, 1, 241, 1, '3430.00', NULL, '2023-09-12 15:42:24', '2023-09-19 10:10:41', NULL),
(242, 1, 242, 1, '102.00', NULL, '2023-09-12 15:42:24', NULL, NULL),
(243, 1, 243, 1, '4037.00', NULL, '2023-09-12 15:42:25', '2023-09-21 08:49:03', NULL),
(244, 1, 244, 1, '1.00', NULL, '2023-09-12 15:42:25', NULL, NULL),
(245, 1, 245, 1, '4.00', NULL, '2023-09-12 15:42:25', '2023-09-15 18:21:20', NULL),
(246, 1, 246, 1, '206.00', NULL, '2023-09-12 15:42:25', NULL, NULL),
(247, 1, 247, 1, '1.00', NULL, '2023-09-12 15:42:25', NULL, NULL),
(248, 1, 248, 1, '1.00', NULL, '2023-09-12 15:42:25', NULL, NULL),
(249, 1, 249, 1, '29.00', NULL, '2023-09-12 15:42:25', NULL, NULL),
(250, 1, 250, 1, '3.00', NULL, '2023-09-12 15:42:25', NULL, NULL),
(251, 1, 251, 1, '9.00', NULL, '2023-09-12 15:42:26', NULL, NULL),
(252, 1, 252, 1, '2.00', NULL, '2023-09-12 15:42:26', NULL, NULL),
(253, 1, 253, 1, '12.00', NULL, '2023-09-12 15:42:26', NULL, NULL),
(254, 1, 254, 1, '2616.00', NULL, '2023-09-12 15:42:26', NULL, NULL),
(255, 1, 255, 1, '453.00', NULL, '2023-09-12 15:42:26', '2023-09-18 12:27:59', NULL),
(256, 1, 256, 1, '13.00', NULL, '2023-09-12 15:42:26', NULL, NULL),
(257, 1, 257, 1, '159.00', NULL, '2023-09-12 15:42:26', NULL, NULL),
(258, 1, 258, 1, '10.00', NULL, '2023-09-12 15:42:27', NULL, NULL),
(259, 1, 259, 1, '9.00', NULL, '2023-09-12 15:42:27', NULL, NULL),
(260, 1, 260, 1, '308.00', NULL, '2023-09-12 15:42:27', '2023-09-19 11:55:05', NULL),
(261, 1, 261, 1, '865.00', NULL, '2023-09-12 15:42:27', '2023-09-15 18:29:02', NULL),
(262, 1, 262, 1, '15.00', NULL, '2023-09-12 15:42:27', NULL, NULL),
(263, 1, 263, 1, '70.00', NULL, '2023-09-12 15:42:27', '2023-09-21 08:49:03', NULL),
(264, 1, 264, 1, '14.00', NULL, '2023-09-12 15:42:27', '2023-09-15 18:15:20', NULL),
(265, 1, 265, 1, '646.00', NULL, '2023-09-12 15:42:28', '2023-09-15 18:25:52', NULL),
(266, 1, 266, 1, '1043.00', NULL, '2023-09-12 15:42:28', '2023-09-20 16:45:17', NULL),
(267, 1, 267, 1, '56.00', NULL, '2023-09-12 15:42:28', '2023-09-15 17:58:00', NULL),
(268, 1, 268, 1, '58.00', NULL, '2023-09-12 15:42:28', NULL, NULL),
(269, 1, 269, 1, '1.00', NULL, '2023-09-12 15:42:28', NULL, NULL),
(270, 1, 270, 1, '143.00', NULL, '2023-09-12 15:42:28', NULL, NULL),
(271, 1, 271, 1, '390.00', NULL, '2023-09-12 15:42:29', '2023-09-21 11:18:55', NULL),
(272, 1, 272, 1, '597.00', NULL, '2023-09-12 15:42:29', '2023-09-15 17:43:56', NULL),
(273, 1, 273, 1, '5.00', NULL, '2023-09-12 15:42:29', NULL, NULL),
(274, 1, 274, 1, '1.00', NULL, '2023-09-12 15:42:29', NULL, NULL),
(275, 1, 275, 1, '13.00', NULL, '2023-09-12 15:42:29', NULL, NULL),
(276, 1, 276, 1, '165.00', NULL, '2023-09-12 15:42:29', '2023-09-15 18:17:06', NULL),
(277, 1, 277, 1, '107.00', NULL, '2023-09-12 15:42:30', '2023-09-20 16:45:07', NULL),
(278, 1, 278, 1, '10.00', NULL, '2023-09-12 15:42:30', '2023-09-19 08:43:46', NULL),
(279, 1, 279, 1, '60.00', NULL, '2023-09-12 15:42:30', NULL, NULL),
(280, 1, 280, 1, '332.00', NULL, '2023-09-12 15:42:30', NULL, NULL),
(281, 1, 281, 1, '417.00', NULL, '2023-09-12 15:42:30', NULL, NULL),
(282, 1, 282, 1, '8.00', NULL, '2023-09-12 15:42:30', '2023-09-16 14:14:34', NULL),
(283, 1, 283, 1, '0.00', NULL, '2023-09-12 15:42:31', '2023-09-16 14:14:36', NULL),
(284, 1, 284, 1, '215.00', NULL, '2023-09-12 15:42:31', NULL, NULL),
(285, 1, 285, 1, '1.00', NULL, '2023-09-12 15:42:31', NULL, NULL),
(286, 1, 286, 1, '7.00', NULL, '2023-09-12 15:42:31', '2023-09-15 17:45:57', NULL),
(287, 1, 287, 1, '5.00', NULL, '2023-09-12 15:42:31', NULL, NULL),
(288, 1, 288, 1, '425.00', NULL, '2023-09-12 15:42:31', NULL, NULL),
(289, 1, 289, 1, '1173.00', NULL, '2023-09-12 15:42:31', '2023-09-20 13:01:21', NULL),
(290, 1, 290, 1, '157.00', NULL, '2023-09-12 15:42:32', '2023-09-16 14:14:36', NULL),
(291, 1, 291, 1, '78.00', NULL, '2023-09-12 15:42:32', '2023-09-20 13:01:21', NULL),
(292, 1, 292, 1, '150.00', NULL, '2023-09-12 15:42:32', NULL, NULL),
(293, 1, 293, 1, '1109.00', NULL, '2023-09-12 15:42:32', '2023-09-20 16:45:11', NULL),
(294, 1, 294, 1, '467.00', NULL, '2023-09-12 15:42:32', '2023-09-20 16:45:07', NULL),
(295, 1, 295, 1, '27.00', NULL, '2023-09-12 15:42:32', '2023-09-15 18:09:28', NULL),
(296, 1, 296, 1, '346.00', NULL, '2023-09-12 15:42:32', '2023-09-20 16:45:06', NULL),
(297, 1, 297, 1, '398.00', NULL, '2023-09-12 15:42:33', NULL, NULL),
(298, 1, 298, 1, '4250.00', NULL, '2023-09-12 15:42:33', '2023-09-20 13:05:45', NULL),
(299, 1, 299, 1, '2195.00', NULL, '2023-09-12 15:42:33', '2023-09-20 14:16:56', NULL),
(300, 1, 300, 1, '114.00', NULL, '2023-09-12 15:42:33', NULL, NULL),
(301, 1, 301, 1, '3932.00', NULL, '2023-09-12 15:42:33', '2023-09-15 17:53:45', NULL),
(302, 1, 302, 1, '395.00', NULL, '2023-09-12 15:42:33', '2023-09-15 18:26:14', NULL),
(303, 1, 303, 1, '291.00', NULL, '2023-09-12 15:42:33', NULL, NULL),
(304, 1, 304, 1, '45.00', NULL, '2023-09-12 15:42:34', NULL, NULL),
(305, 1, 305, 1, '118.00', NULL, '2023-09-12 15:42:34', '2023-09-15 17:47:34', NULL),
(306, 1, 306, 1, '2.00', NULL, '2023-09-12 15:42:34', NULL, NULL),
(307, 1, 307, 1, '99.00', NULL, '2023-09-12 15:42:34', NULL, NULL),
(308, 1, 308, 1, '230.00', NULL, '2023-09-12 15:42:34', NULL, NULL),
(309, 1, 309, 1, '498.00', NULL, '2023-09-12 15:42:34', '2023-09-20 14:16:57', NULL),
(310, 1, 310, 1, '32.00', NULL, '2023-09-12 15:42:34', NULL, NULL),
(311, 1, 311, 1, '7505.00', NULL, '2023-09-12 15:42:35', '2023-09-21 11:18:08', NULL),
(312, 1, 312, 1, '350.00', NULL, '2023-09-12 15:42:35', '2023-09-15 18:20:43', NULL),
(313, 1, 313, 1, '0.00', NULL, '2023-09-12 15:42:35', '2023-09-15 17:47:04', NULL),
(314, 1, 314, 1, '449.00', NULL, '2023-09-12 15:42:35', '2023-09-20 16:45:13', NULL),
(315, 1, 315, 1, '0.00', NULL, '2023-09-12 15:42:35', '2023-09-15 18:27:13', NULL),
(316, 1, 316, 1, '4.00', NULL, '2023-09-12 15:42:35', NULL, NULL),
(317, 1, 317, 1, '12006.00', NULL, '2023-09-12 15:42:35', '2023-09-21 08:48:59', NULL),
(318, 1, 318, 1, '4.00', NULL, '2023-09-12 15:42:36', NULL, NULL),
(319, 1, 319, 1, '107.00', NULL, '2023-09-12 15:42:36', '2023-09-20 16:45:15', NULL),
(320, 1, 320, 1, '3.00', NULL, '2023-09-12 15:42:36', NULL, NULL),
(321, 1, 321, 1, '187.00', NULL, '2023-09-12 15:42:36', NULL, NULL),
(322, 1, 322, 1, '57.00', NULL, '2023-09-12 15:42:36', NULL, NULL),
(323, 1, 323, 1, '9.00', NULL, '2023-09-12 15:42:36', NULL, NULL),
(324, 1, 324, 1, '30.00', NULL, '2023-09-12 15:42:37', '2023-09-21 11:18:09', NULL),
(325, 1, 325, 1, '3.00', NULL, '2023-09-12 15:42:37', NULL, NULL),
(326, 1, 326, 1, '2.00', NULL, '2023-09-12 15:42:37', '2023-09-15 18:09:28', NULL),
(327, 1, 327, 1, '6.00', NULL, '2023-09-12 15:42:37', NULL, NULL),
(328, 1, 328, 1, '5.00', NULL, '2023-09-12 15:42:37', NULL, NULL),
(329, 1, 329, 1, '1768.00', NULL, '2023-09-12 15:42:38', '2023-09-21 08:48:58', NULL),
(330, 1, 330, 1, '66.00', NULL, '2023-09-12 15:42:38', '2023-09-15 18:25:50', NULL),
(331, 1, 331, 1, '7.00', NULL, '2023-09-12 15:42:38', NULL, NULL),
(332, 1, 332, 1, '11.00', NULL, '2023-09-12 15:42:38', '2023-09-15 17:41:39', NULL),
(333, 1, 333, 1, '12.00', NULL, '2023-09-12 15:42:38', '2023-09-21 08:49:01', NULL),
(334, 1, 334, 1, '5.00', NULL, '2023-09-12 15:42:38', NULL, NULL),
(335, 1, 335, 1, '337.00', NULL, '2023-09-12 15:42:39', NULL, NULL),
(336, 1, 336, 1, '82.00', NULL, '2023-09-12 15:42:39', '2023-09-19 08:43:46', NULL),
(337, 1, 337, 1, '84.00', NULL, '2023-09-12 15:42:39', NULL, NULL),
(338, 1, 338, 1, '2.00', NULL, '2023-09-12 15:42:39', '2023-09-15 18:31:14', NULL),
(339, 1, 339, 1, '360.00', NULL, '2023-09-12 15:42:39', '2023-09-21 12:19:06', NULL),
(340, 1, 340, 1, '51.00', NULL, '2023-09-12 15:42:39', '2023-09-18 14:30:59', NULL),
(341, 1, 341, 1, '8.00', NULL, '2023-09-12 15:42:40', NULL, NULL),
(342, 1, 342, 1, '7.00', NULL, '2023-09-12 15:42:40', NULL, NULL),
(343, 1, 343, 1, '10.00', NULL, '2023-09-12 15:42:40', NULL, NULL),
(344, 1, 344, 1, '1308.00', NULL, '2023-09-12 15:42:40', '2023-09-20 14:16:58', NULL),
(345, 1, 345, 1, '2.00', NULL, '2023-09-12 15:42:40', NULL, NULL),
(346, 1, 346, 1, '2.00', NULL, '2023-09-12 15:42:40', NULL, NULL),
(347, 1, 347, 1, '75.00', NULL, '2023-09-12 15:42:41', NULL, NULL),
(348, 1, 348, 1, '1.00', NULL, '2023-09-12 15:42:41', NULL, NULL),
(349, 1, 349, 1, '1030.00', NULL, '2023-09-12 15:42:41', '2023-09-20 16:45:10', NULL),
(350, 1, 350, 1, '534.00', NULL, '2023-09-12 15:42:41', NULL, NULL),
(351, 1, 351, 1, '1.00', NULL, '2023-09-12 15:42:41', NULL, NULL),
(352, 1, 352, 1, '803.00', NULL, '2023-09-12 15:42:41', NULL, NULL),
(353, 1, 353, 1, '1629.00', NULL, '2023-09-12 15:42:42', '2023-09-20 13:05:43', NULL),
(354, 1, 354, 1, '1702.00', NULL, '2023-09-12 15:42:42', '2023-09-15 18:34:13', NULL),
(355, 1, 355, 1, '241.00', NULL, '2023-09-12 15:42:42', '2023-09-15 18:34:12', NULL),
(356, 1, 356, 1, '7.00', NULL, '2023-09-12 15:42:42', NULL, NULL),
(357, 1, 357, 1, '65.00', NULL, '2023-09-12 15:42:42', NULL, NULL),
(358, 1, 358, 1, '80.00', NULL, '2023-09-12 15:42:42', NULL, NULL),
(359, 1, 359, 1, '1622.00', NULL, '2023-09-12 15:42:43', NULL, NULL),
(360, 1, 360, 1, '418.00', NULL, '2023-09-12 15:42:43', '2023-09-15 18:13:21', NULL),
(361, 1, 361, 1, '447.00', NULL, '2023-09-12 15:42:43', NULL, NULL),
(362, 1, 362, 1, '196.00', NULL, '2023-09-12 15:42:43', NULL, NULL),
(363, 1, 363, 1, '158.00', NULL, '2023-09-12 15:42:43', NULL, NULL),
(364, 1, 364, 1, '43.00', NULL, '2023-09-12 15:42:44', NULL, NULL),
(365, 1, 365, 1, '168.00', NULL, '2023-09-12 15:42:44', NULL, NULL),
(366, 1, 366, 1, '99.00', NULL, '2023-09-12 15:42:44', NULL, NULL),
(367, 1, 367, 1, '24.00', NULL, '2023-09-12 15:42:44', NULL, NULL),
(368, 1, 368, 1, '6.00', NULL, '2023-09-12 15:42:44', NULL, NULL),
(369, 1, 369, 1, '2237.00', NULL, '2023-09-12 15:42:44', '2023-09-21 11:18:06', NULL),
(370, 1, 370, 1, '1495.00', NULL, '2023-09-12 15:42:45', '2023-09-20 16:45:06', NULL),
(371, 1, 371, 1, '259.00', NULL, '2023-09-12 15:42:45', '2023-09-21 11:18:05', NULL),
(372, 1, 372, 1, '1.00', NULL, '2023-09-12 15:42:45', NULL, NULL),
(373, 1, 373, 1, '34.00', NULL, '2023-09-12 15:42:45', NULL, NULL),
(374, 1, 374, 1, '2.00', NULL, '2023-09-12 15:42:45', NULL, NULL),
(375, 1, 375, 1, '15033.00', NULL, '2023-09-12 15:42:46', '2023-09-21 08:48:59', NULL),
(376, 1, 376, 1, '1440.00', NULL, '2023-09-12 15:42:46', '2023-09-21 08:48:59', NULL),
(377, 1, 377, 1, '1.00', NULL, '2023-09-12 15:42:46', NULL, NULL),
(378, 1, 378, 1, '43.00', NULL, '2023-09-12 15:42:46', '2023-09-15 18:25:51', NULL),
(379, 1, 379, 1, '2.00', NULL, '2023-09-12 15:42:46', '2023-09-15 17:46:20', NULL),
(380, 1, 380, 1, '21.00', NULL, '2023-09-12 15:42:46', '2023-09-16 14:14:37', NULL),
(381, 1, 381, 1, '442.00', NULL, '2023-09-12 15:42:47', NULL, NULL),
(382, 1, 382, 1, '366.00', NULL, '2023-09-12 15:42:47', NULL, NULL),
(383, 1, 383, 1, '204.00', NULL, '2023-09-12 15:42:47', NULL, NULL),
(384, 1, 384, 1, '36.00', NULL, '2023-09-12 15:42:47', '2023-09-15 18:13:50', NULL),
(385, 1, 385, 1, '46.00', NULL, '2023-09-12 15:42:47', NULL, NULL),
(386, 1, 386, 1, '44.00', NULL, '2023-09-12 15:42:47', NULL, NULL),
(387, 1, 387, 1, '61.00', NULL, '2023-09-12 15:42:48', NULL, NULL),
(388, 1, 388, 1, '4.00', NULL, '2023-09-12 15:42:48', NULL, NULL),
(389, 1, 389, 1, '2.00', NULL, '2023-09-12 15:42:48', NULL, NULL),
(390, 1, 390, 1, '16.00', NULL, '2023-09-12 15:42:48', NULL, NULL),
(391, 1, 391, 1, '181.00', NULL, '2023-09-12 15:42:48', '2023-09-15 18:29:58', NULL),
(392, 1, 392, 1, '43.00', NULL, '2023-09-12 15:42:49', NULL, NULL),
(393, 1, 393, 1, '1.00', NULL, '2023-09-12 15:42:49', NULL, NULL),
(394, 1, 394, 1, '8.00', NULL, '2023-09-12 15:42:49', NULL, NULL),
(395, 1, 395, 1, '90.00', NULL, '2023-09-12 15:42:49', NULL, NULL),
(396, 1, 396, 1, '48.00', NULL, '2023-09-12 15:42:49', NULL, NULL),
(397, 1, 397, 1, '19.00', NULL, '2023-09-12 15:42:49', NULL, NULL),
(398, 1, 398, 1, '172.00', NULL, '2023-09-12 15:42:50', NULL, NULL),
(399, 1, 399, 1, '232.00', NULL, '2023-09-12 15:42:50', '2023-09-20 12:09:51', NULL),
(400, 1, 400, 1, '1969.00', NULL, '2023-09-12 15:42:50', NULL, NULL),
(401, 1, 401, 1, '684.00', NULL, '2023-09-12 15:42:50', NULL, NULL),
(402, 1, 402, 1, '272.00', NULL, '2023-09-12 15:42:50', NULL, NULL),
(403, 1, 403, 1, '258.00', NULL, '2023-09-12 15:42:51', NULL, NULL),
(404, 1, 404, 1, '8.00', NULL, '2023-09-12 15:42:51', '2023-09-21 15:21:38', NULL),
(405, 1, 405, 1, '51.00', NULL, '2023-09-12 15:42:51', NULL, NULL),
(406, 1, 406, 1, '2.00', NULL, '2023-09-12 15:42:51', NULL, NULL),
(407, 1, 407, 1, '103.00', NULL, '2023-09-12 15:42:51', NULL, NULL),
(408, 1, 408, 1, '160.00', NULL, '2023-09-12 15:42:52', NULL, NULL),
(409, 1, 409, 1, '5.00', NULL, '2023-09-12 15:42:52', NULL, NULL),
(410, 1, 410, 1, '140.00', NULL, '2023-09-12 15:42:52', '2023-09-15 17:46:43', NULL),
(411, 1, 411, 1, '5.00', NULL, '2023-09-12 15:42:52', NULL, NULL),
(412, 1, 412, 1, '10.00', NULL, '2023-09-12 15:42:52', NULL, NULL),
(413, 1, 413, 1, '10.00', NULL, '2023-09-12 15:42:53', NULL, NULL),
(414, 1, 414, 1, '4.00', NULL, '2023-09-12 15:42:53', NULL, NULL),
(415, 1, 415, 1, '3.00', NULL, '2023-09-12 15:42:53', '2023-09-18 14:30:59', NULL),
(416, 1, 416, 1, '9.00', NULL, '2023-09-12 15:42:53', '2023-09-22 12:50:38', NULL),
(417, 1, 417, 1, '168.00', NULL, '2023-09-12 15:42:53', NULL, NULL),
(418, 1, 418, 1, '251.00', NULL, '2023-09-12 15:42:53', '2023-09-15 18:33:38', NULL),
(419, 1, 419, 1, '258.00', NULL, '2023-09-12 15:42:54', NULL, NULL),
(420, 1, 420, 1, '58.00', NULL, '2023-09-12 15:42:54', '2023-09-21 16:52:09', NULL),
(421, 1, 421, 1, '40.00', NULL, '2023-09-12 15:42:54', NULL, NULL),
(422, 1, 422, 1, '214.00', NULL, '2023-09-12 15:42:54', '2023-09-22 11:55:01', NULL),
(423, 1, 423, 1, '498.00', NULL, '2023-09-12 15:42:54', '2023-09-22 11:55:01', NULL),
(424, 1, 424, 1, '640.00', NULL, '2023-09-12 15:42:55', '2023-09-18 14:12:48', NULL),
(425, 1, 425, 1, '26.00', NULL, '2023-09-12 15:42:55', '2023-09-21 12:45:26', NULL),
(426, 1, 426, 1, '126.00', NULL, '2023-09-12 15:42:55', '2023-09-20 10:43:12', NULL),
(427, 1, 427, 1, '606.00', NULL, '2023-09-12 15:42:55', '2023-09-22 11:55:01', NULL),
(428, 1, 428, 1, '0.00', NULL, '2023-09-12 15:42:56', '2023-09-18 09:46:01', NULL),
(429, 1, 429, 1, '46.00', NULL, '2023-09-12 15:42:56', '2023-09-20 10:43:27', NULL),
(430, 1, 430, 1, '141.00', NULL, '2023-09-12 15:42:56', NULL, NULL),
(431, 1, 431, 1, '1173.00', NULL, '2023-09-12 15:42:56', '2023-09-18 14:12:48', NULL),
(432, 1, 432, 1, '1.00', NULL, '2023-09-12 15:42:56', NULL, NULL),
(433, 1, 433, 1, '57.00', NULL, '2023-09-12 15:42:56', NULL, NULL),
(434, 1, 434, 1, '48.00', NULL, '2023-09-12 15:42:57', NULL, NULL),
(435, 1, 435, 1, '144.00', NULL, '2023-09-12 15:42:57', '2023-09-15 17:56:14', NULL),
(436, 1, 436, 1, '41.00', NULL, '2023-09-12 15:42:57', '2023-09-15 17:40:52', NULL),
(437, 1, 437, 1, '160.00', NULL, '2023-09-12 15:42:57', '2023-09-22 12:50:38', NULL),
(438, 1, 438, 1, '76.00', NULL, '2023-09-12 15:42:57', '2023-09-15 17:56:13', NULL),
(439, 1, 439, 1, '404.00', NULL, '2023-09-12 15:42:58', '2023-09-15 17:56:13', NULL),
(440, 1, 440, 1, '90.00', NULL, '2023-09-12 15:42:58', NULL, NULL),
(441, 1, 441, 1, '1254.00', NULL, '2023-09-12 15:42:58', '2023-09-20 16:44:48', NULL),
(442, 1, 442, 1, '1.00', NULL, '2023-09-12 15:42:58', NULL, NULL),
(443, 1, 443, 1, '1.00', NULL, '2023-09-12 15:42:58', NULL, NULL),
(444, 1, 444, 1, '52.00', NULL, '2023-09-12 15:42:59', '2023-09-18 14:14:05', NULL),
(445, 1, 445, 1, '76.00', NULL, '2023-09-12 15:42:59', '2023-09-20 16:45:47', NULL),
(446, 1, 446, 1, '98.00', NULL, '2023-09-12 15:42:59', '2023-09-20 16:45:47', NULL),
(447, 1, 447, 1, '10.00', NULL, '2023-09-12 15:42:59', '2023-09-15 18:33:54', NULL),
(448, 1, 448, 1, '194.00', NULL, '2023-09-12 15:42:59', '2023-09-21 16:52:09', NULL),
(449, 1, 449, 1, '139.00', NULL, '2023-09-12 15:43:00', '2023-09-15 17:56:15', NULL),
(450, 1, 450, 1, '91.00', NULL, '2023-09-12 15:43:00', NULL, NULL),
(451, 1, 451, 1, '5.00', NULL, '2023-09-12 15:43:00', '2023-09-21 16:51:56', NULL),
(452, 1, 452, 1, '121.00', NULL, '2023-09-12 15:43:00', '2023-09-18 14:30:58', NULL),
(453, 1, 453, 1, '18.00', NULL, '2023-09-12 15:43:01', '2023-09-15 17:56:14', NULL),
(454, 1, 454, 1, '163.00', NULL, '2023-09-12 15:43:01', NULL, NULL),
(455, 1, 455, 1, '172.00', NULL, '2023-09-12 15:43:01', NULL, NULL),
(456, 1, 456, 1, '3.00', NULL, '2023-09-12 15:43:01', NULL, NULL),
(457, 1, 457, 1, '43.00', NULL, '2023-09-12 15:43:01', '2023-09-15 18:21:39', NULL),
(458, 1, 458, 1, '29.00', NULL, '2023-09-12 15:43:02', '2023-09-21 15:16:41', NULL),
(459, 1, 459, 1, '4.00', NULL, '2023-09-12 15:43:02', '2023-09-21 15:21:39', NULL),
(460, 1, 460, 1, '5.00', NULL, '2023-09-12 15:43:02', NULL, NULL),
(461, 1, 461, 1, '5.00', NULL, '2023-09-12 15:43:02', '2023-09-21 15:21:40', NULL),
(462, 1, 462, 1, '0.00', NULL, '2023-09-12 15:43:02', '2023-09-22 12:50:49', NULL),
(463, 1, 463, 1, '168.00', NULL, '2023-09-12 15:43:03', '2023-09-18 14:30:58', NULL),
(464, 1, 464, 1, '7.00', NULL, '2023-09-12 15:43:03', NULL, NULL),
(465, 1, 465, 1, '1.00', NULL, '2023-09-12 15:43:03', NULL, NULL),
(466, 1, 466, 1, '11.00', NULL, '2023-09-12 15:43:03', NULL, NULL),
(467, 1, 467, 1, '2.00', NULL, '2023-09-12 15:43:04', NULL, NULL),
(468, 1, 468, 1, '3.00', NULL, '2023-09-12 15:43:04', NULL, NULL),
(469, 1, 469, 1, '1.00', NULL, '2023-09-12 15:43:04', NULL, NULL),
(470, 1, 470, 1, '1.00', NULL, '2023-09-12 15:43:04', NULL, NULL),
(471, 1, 471, 1, '1.00', NULL, '2023-09-12 15:43:04', NULL, NULL),
(472, 1, 472, 1, '1.00', NULL, '2023-09-12 15:43:05', NULL, NULL),
(473, 1, 473, 1, '2.00', NULL, '2023-09-12 15:43:05', NULL, NULL),
(474, 1, 474, 1, '2.00', NULL, '2023-09-12 15:43:05', NULL, NULL),
(475, 1, 475, 1, '29.00', NULL, '2023-09-12 15:43:05', NULL, NULL),
(476, 1, 480, 1, '5.00', NULL, '2023-09-15 11:20:46', NULL, NULL),
(477, 1, 479, 1, '20.00', NULL, '2023-09-15 11:20:47', NULL, NULL),
(478, 1, 477, 1, '28.00', NULL, '2023-09-15 11:20:48', '2023-09-15 18:27:34', NULL),
(479, 1, 478, 1, '19.00', NULL, '2023-09-15 11:20:49', '2023-09-15 18:26:54', NULL),
(480, 1, 481, 1, '29.00', NULL, '2023-09-15 12:04:15', '2023-09-15 18:27:50', NULL),
(481, 1, 483, 1, '0.00', NULL, '2023-09-15 14:55:05', '2023-09-15 18:28:37', NULL),
(482, 1, 482, 1, '0.00', NULL, '2023-09-15 14:55:06', '2023-09-15 18:29:24', NULL),
(483, 1, 484, 1, '8.00', NULL, '2023-09-18 09:32:32', '2023-09-22 11:55:24', NULL),
(484, 1, 485, 1, '20.00', NULL, '2023-09-18 09:37:21', NULL, NULL),
(485, 1, 486, 1, '2.00', NULL, '2023-09-18 09:46:01', '2023-09-21 15:11:55', NULL),
(486, 1, 487, 1, '25.00', NULL, '2023-09-18 09:52:38', '2023-09-18 10:13:49', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_mag_inv`
--

DROP TABLE IF EXISTS `produit_cond_mag_inv`;
CREATE TABLE IF NOT EXISTS `produit_cond_mag_inv` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inventaire_mag_id` int NOT NULL,
  `produit_cond_inv_id` int NOT NULL,
  `qte_cond_stock_log` decimal(10,2) NOT NULL,
  `qte_cond_stock_phy` decimal(10,2) NOT NULL,
  `ecart` decimal(10,2) NOT NULL,
  `debit` decimal(10,2) DEFAULT NULL,
  `credit` decimal(10,2) DEFAULT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  `est_cloturer` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DB9267E93D5CF14C` (`inventaire_mag_id`),
  KEY `IDX_DB9267E937754359` (`produit_cond_inv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_mag_inv`
--

INSERT INTO `produit_cond_mag_inv` (`id`, `inventaire_mag_id`, `produit_cond_inv_id`, `qte_cond_stock_log`, `qte_cond_stock_phy`, `ecart`, `debit`, `credit`, `prix_unitaire`, `est_cloturer`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '0.00', '23.00', '23.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(2, 1, 2, '0.00', '1100.00', '1100.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(3, 1, 3, '0.00', '379.00', '379.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(4, 1, 4, '0.00', '427.00', '427.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(5, 1, 5, '0.00', '4.00', '4.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(6, 1, 6, '0.00', '1.00', '1.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(7, 1, 7, '0.00', '3.00', '3.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(8, 1, 8, '0.00', '7.00', '7.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(9, 1, 9, '0.00', '5.00', '5.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(10, 1, 10, '0.00', '4.00', '4.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(11, 1, 11, '0.00', '51.00', '51.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL),
(12, 1, 12, '0.00', '121.00', '121.00', NULL, NULL, NULL, NULL, '2023-09-12 15:43:05', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_mag_liv`
--

DROP TABLE IF EXISTS `produit_cond_mag_liv`;
CREATE TABLE IF NOT EXISTS `produit_cond_mag_liv` (
  `id` int NOT NULL AUTO_INCREMENT,
  `livraison_mag_id` int DEFAULT NULL,
  `produit_com_clit_id` int DEFAULT NULL,
  `qte_liv` decimal(10,2) NOT NULL,
  `qte_raliv` decimal(10,2) NOT NULL,
  `montant_cond` decimal(10,2) DEFAULT NULL,
  `qte_aliv` decimal(10,2) NOT NULL,
  `prix` decimal(10,0) NOT NULL,
  `carton` decimal(10,0) DEFAULT NULL,
  `piece` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_921833C5B76E34A8` (`livraison_mag_id`),
  KEY `IDX_921833C5F1787AB9` (`produit_com_clit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_mag_liv`
--

INSERT INTO `produit_cond_mag_liv` (`id`, `livraison_mag_id`, `produit_com_clit_id`, `qte_liv`, `qte_raliv`, `montant_cond`, `qte_aliv`, `prix`, `carton`, `piece`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '1.00', '0.00', NULL, '1.00', '25000', NULL, NULL, '2023-09-15 17:34:28', NULL, NULL),
(2, 1, 2, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-15 17:34:28', NULL, NULL),
(3, 2, 3, '20.00', '0.00', NULL, '20.00', '750', NULL, NULL, '2023-09-15 17:35:48', NULL, NULL),
(4, 2, 4, '40.00', '0.00', NULL, '40.00', '375', NULL, NULL, '2023-09-15 17:35:48', NULL, NULL),
(5, 3, 5, '20.00', '0.00', NULL, '20.00', '275', NULL, NULL, '2023-09-15 17:39:38', NULL, NULL),
(6, 4, 6, '1.00', '0.00', NULL, '1.00', '7500', NULL, NULL, '2023-09-15 17:40:05', NULL, NULL),
(7, 5, 7, '2.00', '0.00', NULL, '2.00', '4300', NULL, NULL, '2023-09-15 17:40:52', NULL, NULL),
(8, 6, 8, '10.00', '0.00', NULL, '10.00', '1850', NULL, NULL, '2023-09-15 17:41:11', NULL, NULL),
(9, 7, 9, '20.00', '0.00', NULL, '20.00', '2500', NULL, NULL, '2023-09-15 17:41:38', NULL, NULL),
(10, 7, 10, '50.00', '0.00', NULL, '50.00', '600', NULL, NULL, '2023-09-15 17:41:38', NULL, NULL),
(11, 7, 11, '5.00', '0.00', NULL, '5.00', '6800', NULL, NULL, '2023-09-15 17:41:38', NULL, NULL),
(12, 7, 12, '5.00', '0.00', NULL, '5.00', '6800', NULL, NULL, '2023-09-15 17:41:38', NULL, NULL),
(13, 8, 13, '100.00', '0.00', NULL, '100.00', '450', NULL, NULL, '2023-09-15 17:42:06', NULL, NULL),
(14, 9, 14, '50.00', '0.00', NULL, '50.00', '2250', NULL, NULL, '2023-09-15 17:42:23', NULL, NULL),
(15, 10, 15, '3.00', '0.00', NULL, '3.00', '9000', NULL, NULL, '2023-09-15 17:42:39', NULL, NULL),
(16, 11, 16, '100.00', '0.00', NULL, '100.00', '1800', NULL, NULL, '2023-09-15 17:42:57', NULL, NULL),
(17, 11, 17, '100.00', '0.00', NULL, '100.00', '1500', NULL, NULL, '2023-09-15 17:42:57', NULL, NULL),
(18, 12, 18, '15.00', '0.00', NULL, '15.00', '3500', NULL, NULL, '2023-09-15 17:43:16', NULL, NULL),
(19, 12, 19, '15.00', '0.00', NULL, '15.00', '3000', NULL, NULL, '2023-09-15 17:43:16', NULL, NULL),
(20, 13, 20, '8.00', '0.00', NULL, '8.00', '14000', NULL, NULL, '2023-09-15 17:43:35', NULL, NULL),
(21, 14, 21, '1.00', '0.00', NULL, '1.00', '6000', NULL, NULL, '2023-09-15 17:43:53', NULL, NULL),
(22, 14, 22, '1.00', '0.00', NULL, '1.00', '3000', NULL, NULL, '2023-09-15 17:43:53', NULL, NULL),
(23, 14, 23, '1.00', '0.00', NULL, '1.00', '1800', NULL, NULL, '2023-09-15 17:43:53', NULL, NULL),
(24, 14, 24, '1.00', '0.00', NULL, '1.00', '1200', NULL, NULL, '2023-09-15 17:43:53', NULL, NULL),
(25, 14, 25, '1.00', '0.00', NULL, '1.00', '4000', NULL, NULL, '2023-09-15 17:43:53', NULL, NULL),
(26, 14, 26, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-15 17:43:53', NULL, NULL),
(27, 15, 27, '3.00', '0.00', NULL, '3.00', '9000', NULL, NULL, '2023-09-15 17:44:15', NULL, NULL),
(28, 16, 28, '1.00', '0.00', NULL, '1.00', '2500', NULL, NULL, '2023-09-15 17:44:40', NULL, NULL),
(29, 17, 29, '50.00', '0.00', NULL, '50.00', '900', NULL, NULL, '2023-09-15 17:45:14', NULL, NULL),
(30, 18, 30, '45.00', '0.00', NULL, '45.00', '3500', NULL, NULL, '2023-09-15 17:45:37', NULL, NULL),
(31, 19, 31, '10.00', '0.00', NULL, '10.00', '400', NULL, NULL, '2023-09-15 17:45:56', NULL, NULL),
(32, 19, 32, '5.00', '0.00', NULL, '5.00', '600', NULL, NULL, '2023-09-15 17:45:56', NULL, NULL),
(33, 19, 33, '3.00', '0.00', NULL, '3.00', '1200', NULL, NULL, '2023-09-15 17:45:56', NULL, NULL),
(34, 20, 34, '3.00', '0.00', NULL, '3.00', '2500', NULL, NULL, '2023-09-15 17:46:19', NULL, NULL),
(35, 21, 35, '2.00', '0.00', NULL, '2.00', '53000', NULL, NULL, '2023-09-15 17:46:41', NULL, NULL),
(36, 22, 36, '10.00', '0.00', NULL, '10.00', '1550', NULL, NULL, '2023-09-15 17:47:02', NULL, NULL),
(37, 22, 37, '10.00', '0.00', NULL, '10.00', '1850', NULL, NULL, '2023-09-15 17:47:02', NULL, NULL),
(38, 22, 38, '10.00', '0.00', NULL, '10.00', '2300', NULL, NULL, '2023-09-15 17:47:02', NULL, NULL),
(39, 22, 39, '30.00', '0.00', NULL, '30.00', '425', NULL, NULL, '2023-09-15 17:47:02', NULL, NULL),
(40, 22, 40, '10.00', '0.00', NULL, '10.00', '1250', NULL, NULL, '2023-09-15 17:47:02', NULL, NULL),
(41, 22, 41, '10.00', '0.00', NULL, '10.00', '1250', NULL, NULL, '2023-09-15 17:47:02', NULL, NULL),
(42, 22, 42, '1.00', '0.00', NULL, '1.00', '250', NULL, NULL, '2023-09-15 17:47:02', NULL, NULL),
(43, 23, 43, '10.00', '0.00', NULL, '10.00', '1200', NULL, NULL, '2023-09-15 17:47:33', NULL, NULL),
(44, 24, 44, '15.00', '0.00', NULL, '15.00', '11500', NULL, NULL, '2023-09-15 17:48:03', NULL, NULL),
(45, 25, 45, '18.00', '0.00', NULL, '18.00', '4250', NULL, NULL, '2023-09-15 17:48:40', NULL, NULL),
(46, 26, 46, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-15 17:49:03', NULL, NULL),
(47, 26, 47, '1.00', '0.00', NULL, '1.00', '1800', NULL, NULL, '2023-09-15 17:49:03', NULL, NULL),
(48, 27, 48, '30.00', '0.00', NULL, '30.00', '1850', NULL, NULL, '2023-09-15 17:49:39', NULL, NULL),
(49, 28, 49, '20.00', '0.00', NULL, '20.00', '200', NULL, NULL, '2023-09-15 17:50:27', NULL, NULL),
(50, 29, 50, '20.00', '0.00', NULL, '20.00', '1850', NULL, NULL, '2023-09-15 17:51:20', NULL, NULL),
(51, 30, 51, '100.00', '0.00', NULL, '100.00', '240', NULL, NULL, '2023-09-15 17:52:02', NULL, NULL),
(52, 30, 52, '100.00', '0.00', NULL, '100.00', '235', NULL, NULL, '2023-09-15 17:52:02', NULL, NULL),
(53, 30, 53, '50.00', '0.00', NULL, '50.00', '300', NULL, NULL, '2023-09-15 17:52:02', NULL, NULL),
(54, 30, 54, '50.00', '0.00', NULL, '50.00', '400', NULL, NULL, '2023-09-15 17:52:02', NULL, NULL),
(55, 31, 55, '4.00', '0.00', NULL, '4.00', '46000', NULL, NULL, '2023-09-15 17:52:35', NULL, NULL),
(56, 32, 56, '10.00', '0.00', NULL, '10.00', '12000', NULL, NULL, '2023-09-15 17:52:55', NULL, NULL),
(57, 33, 57, '12.00', '0.00', NULL, '12.00', '3500', NULL, NULL, '2023-09-15 17:53:43', NULL, NULL),
(58, 33, 58, '100.00', '0.00', NULL, '100.00', '700', NULL, NULL, '2023-09-15 17:53:43', NULL, NULL),
(59, 34, 59, '12.00', '0.00', NULL, '12.00', '2600', NULL, NULL, '2023-09-15 17:54:15', NULL, NULL),
(60, 34, 60, '12.00', '0.00', NULL, '12.00', '2600', NULL, NULL, '2023-09-15 17:54:15', NULL, NULL),
(61, 35, 61, '20.00', '0.00', NULL, '20.00', '800', NULL, NULL, '2023-09-15 17:54:35', NULL, NULL),
(62, 35, 62, '10.00', '0.00', NULL, '10.00', '1850', NULL, NULL, '2023-09-15 17:54:35', NULL, NULL),
(63, 36, 63, '5.00', '0.00', NULL, '5.00', '12000', NULL, NULL, '2023-09-15 17:54:58', NULL, NULL),
(64, 37, 64, '100.00', '0.00', NULL, '100.00', '350', NULL, NULL, '2023-09-15 17:55:16', NULL, NULL),
(65, 38, 65, '6.00', '0.00', NULL, '6.00', '4300', NULL, NULL, '2023-09-15 17:55:36', NULL, NULL),
(66, 39, 66, '1.00', '0.00', NULL, '1.00', '65000', NULL, NULL, '2023-09-15 17:55:53', NULL, NULL),
(67, 40, 67, '10.00', '0.00', NULL, '10.00', '6750', NULL, NULL, '2023-09-15 17:56:12', NULL, NULL),
(68, 40, 68, '15.00', '0.00', NULL, '15.00', '6800', NULL, NULL, '2023-09-15 17:56:12', NULL, NULL),
(69, 40, 69, '15.00', '0.00', NULL, '15.00', '4300', NULL, NULL, '2023-09-15 17:56:12', NULL, NULL),
(70, 40, 70, '4.00', '0.00', NULL, '4.00', '11500', NULL, NULL, '2023-09-15 17:56:12', NULL, NULL),
(71, 40, 71, '5.00', '0.00', NULL, '5.00', '4500', NULL, NULL, '2023-09-15 17:56:12', NULL, NULL),
(72, 40, 72, '6.00', '0.00', NULL, '6.00', '4000', NULL, NULL, '2023-09-15 17:56:12', NULL, NULL),
(73, 40, 73, '4.00', '0.00', NULL, '4.00', '10500', NULL, NULL, '2023-09-15 17:56:12', NULL, NULL),
(74, 41, 74, '25.00', '0.00', NULL, '25.00', '2500', NULL, NULL, '2023-09-15 17:56:41', NULL, NULL),
(75, 42, 75, '16.00', '0.00', NULL, '16.00', '3600', NULL, NULL, '2023-09-15 17:56:59', NULL, NULL),
(76, 43, 76, '20.00', '0.00', NULL, '20.00', '800', NULL, NULL, '2023-09-15 17:57:16', NULL, NULL),
(77, 43, 77, '5.00', '0.00', NULL, '5.00', '1800', NULL, NULL, '2023-09-15 17:57:16', NULL, NULL),
(78, 43, 78, '1.00', '0.00', NULL, '1.00', '1500', NULL, NULL, '2023-09-15 17:57:16', NULL, NULL),
(79, 44, 79, '100.00', '0.00', NULL, '100.00', '300', NULL, NULL, '2023-09-15 17:57:39', NULL, NULL),
(80, 44, 80, '10.00', '0.00', NULL, '10.00', '6500', NULL, NULL, '2023-09-15 17:57:39', NULL, NULL),
(81, 44, 81, '40.00', '0.00', NULL, '40.00', '1800', NULL, NULL, '2023-09-15 17:57:39', NULL, NULL),
(82, 45, 82, '10.00', '0.00', NULL, '10.00', '2500', NULL, NULL, '2023-09-15 17:57:59', NULL, NULL),
(83, 45, 83, '1.00', '0.00', NULL, '1.00', '35000', NULL, NULL, '2023-09-15 17:57:59', NULL, NULL),
(84, 46, 84, '50.00', '0.00', NULL, '50.00', '1250', NULL, NULL, '2023-09-15 17:58:25', NULL, NULL),
(85, 47, 86, '4.00', '0.00', NULL, '4.00', '1450', NULL, NULL, '2023-09-15 17:58:44', NULL, NULL),
(86, 47, 87, '4.00', '0.00', NULL, '4.00', '1850', NULL, NULL, '2023-09-15 17:58:44', NULL, NULL),
(87, 47, 88, '4.00', '0.00', NULL, '4.00', '1250', NULL, NULL, '2023-09-15 17:58:44', NULL, NULL),
(88, 47, 89, '4.00', '0.00', NULL, '4.00', '1800', NULL, NULL, '2023-09-15 17:58:44', NULL, NULL),
(89, 47, 90, '4.00', '0.00', NULL, '4.00', '4500', NULL, NULL, '2023-09-15 17:58:44', NULL, NULL),
(90, 48, 91, '2.00', '0.00', NULL, '2.00', '8000', NULL, NULL, '2023-09-15 17:59:08', NULL, NULL),
(91, 48, 92, '2.00', '0.00', NULL, '2.00', '700', NULL, NULL, '2023-09-15 17:59:08', NULL, NULL),
(92, 48, 93, '2.00', '0.00', NULL, '2.00', '650', NULL, NULL, '2023-09-15 17:59:08', NULL, NULL),
(93, 48, 94, '1.00', '0.00', NULL, '1.00', '700', NULL, NULL, '2023-09-15 17:59:08', NULL, NULL),
(94, 48, 95, '1.00', '0.00', NULL, '1.00', '3000', NULL, NULL, '2023-09-15 17:59:08', NULL, NULL),
(95, 48, 96, '1.00', '0.00', NULL, '1.00', '700', NULL, NULL, '2023-09-15 17:59:08', NULL, NULL),
(96, 49, 97, '40.00', '0.00', NULL, '40.00', '7000', NULL, NULL, '2023-09-15 17:59:29', NULL, NULL),
(97, 49, 98, '10.00', '0.00', NULL, '10.00', '2700', NULL, NULL, '2023-09-15 17:59:29', NULL, NULL),
(98, 49, 99, '30.00', '0.00', NULL, '30.00', '1850', NULL, NULL, '2023-09-15 17:59:29', NULL, NULL),
(99, 50, 100, '4.00', '0.00', NULL, '4.00', '17000', NULL, NULL, '2023-09-15 17:59:49', NULL, NULL),
(100, 50, 101, '1.00', '0.00', NULL, '1.00', '17000', NULL, NULL, '2023-09-15 17:59:49', NULL, NULL),
(101, 51, 102, '20.00', '0.00', NULL, '20.00', '225', NULL, NULL, '2023-09-15 18:00:07', NULL, NULL),
(102, 52, 103, '4.00', '0.00', NULL, '4.00', '750', NULL, NULL, '2023-09-15 18:00:24', NULL, NULL),
(103, 52, 104, '4.00', '0.00', NULL, '4.00', '750', NULL, NULL, '2023-09-15 18:00:24', NULL, NULL),
(104, 52, 105, '4.00', '0.00', NULL, '4.00', '450', NULL, NULL, '2023-09-15 18:00:24', NULL, NULL),
(105, 53, 106, '30.00', '0.00', NULL, '30.00', '1850', NULL, NULL, '2023-09-15 18:00:41', NULL, NULL),
(106, 53, 107, '7.00', '0.00', NULL, '7.00', '3500', NULL, NULL, '2023-09-15 18:00:41', NULL, NULL),
(107, 53, 108, '15.00', '0.00', NULL, '15.00', '3000', NULL, NULL, '2023-09-15 18:00:41', NULL, NULL),
(108, 53, 109, '1.00', '0.00', NULL, '1.00', '26000', NULL, NULL, '2023-09-15 18:00:41', NULL, NULL),
(109, 53, 110, '20.00', '0.00', NULL, '20.00', '800', NULL, NULL, '2023-09-15 18:00:41', NULL, NULL),
(110, 54, 111, '30.00', '0.00', NULL, '30.00', '2600', NULL, NULL, '2023-09-15 18:01:23', NULL, NULL),
(111, 54, 112, '30.00', '0.00', NULL, '30.00', '2600', NULL, NULL, '2023-09-15 18:01:23', NULL, NULL),
(112, 55, 113, '13.00', '0.00', NULL, '13.00', '4000', NULL, NULL, '2023-09-15 18:01:51', NULL, NULL),
(113, 56, 115, '1.00', '0.00', NULL, '1.00', '600', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(114, 56, 116, '4.00', '0.00', NULL, '4.00', '400', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(115, 56, 117, '4.00', '0.00', NULL, '4.00', '700', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(116, 56, 118, '4.00', '0.00', NULL, '4.00', '700', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(117, 56, 119, '4.00', '0.00', NULL, '4.00', '300', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(118, 56, 120, '4.00', '0.00', NULL, '4.00', '300', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(119, 56, 121, '8.00', '0.00', NULL, '8.00', '200', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(120, 56, 122, '1.00', '0.00', NULL, '1.00', '20000', NULL, NULL, '2023-09-15 18:02:10', NULL, NULL),
(121, 57, 123, '40.00', '0.00', NULL, '40.00', '2500', NULL, NULL, '2023-09-15 18:02:34', NULL, NULL),
(122, 58, 124, '15.00', '0.00', NULL, '15.00', '1100', NULL, NULL, '2023-09-15 18:02:57', NULL, NULL),
(123, 59, 125, '90.00', '0.00', NULL, '90.00', '1800', NULL, NULL, '2023-09-15 18:03:18', NULL, NULL),
(124, 60, 126, '10.00', '0.00', NULL, '10.00', '6400', NULL, NULL, '2023-09-15 18:03:44', NULL, NULL),
(125, 61, 127, '50.00', '0.00', NULL, '50.00', '225', NULL, NULL, '2023-09-15 18:04:00', NULL, NULL),
(126, 62, 128, '18.00', '0.00', NULL, '18.00', '2600', NULL, NULL, '2023-09-15 18:04:22', NULL, NULL),
(127, 62, 129, '18.00', '0.00', NULL, '18.00', '2600', NULL, NULL, '2023-09-15 18:04:22', NULL, NULL),
(128, 62, 130, '12.00', '0.00', NULL, '12.00', '2600', NULL, NULL, '2023-09-15 18:04:22', NULL, NULL),
(129, 63, 131, '10.00', '0.00', NULL, '10.00', '1850', NULL, NULL, '2023-09-15 18:04:58', NULL, NULL),
(130, 63, 132, '1.00', '0.00', NULL, '1.00', '150', NULL, NULL, '2023-09-15 18:04:58', NULL, NULL),
(131, 64, 133, '6.00', '0.00', NULL, '6.00', '7000', NULL, NULL, '2023-09-15 18:05:30', NULL, NULL),
(132, 65, 134, '1.00', '0.00', NULL, '1.00', '25000', NULL, NULL, '2023-09-15 18:05:48', NULL, NULL),
(133, 66, 135, '20.00', '0.00', NULL, '20.00', '1850', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(134, 66, 136, '10.00', '0.00', NULL, '10.00', '1550', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(135, 66, 137, '50.00', '0.00', NULL, '50.00', '250', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(136, 66, 138, '50.00', '0.00', NULL, '50.00', '240', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(137, 66, 139, '20.00', '0.00', NULL, '20.00', '750', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(138, 66, 140, '10.00', '0.00', NULL, '10.00', '750', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(139, 66, 141, '10.00', '0.00', NULL, '10.00', '750', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(140, 66, 142, '1.00', '0.00', NULL, '1.00', '7000', NULL, NULL, '2023-09-15 18:06:14', NULL, NULL),
(141, 67, 143, '1.00', '0.00', NULL, '1.00', '22500', NULL, NULL, '2023-09-15 18:07:17', NULL, NULL),
(142, 68, 144, '15.00', '0.00', NULL, '15.00', '300', NULL, NULL, '2023-09-15 18:08:17', NULL, NULL),
(143, 68, 145, '15.00', '0.00', NULL, '15.00', '400', NULL, NULL, '2023-09-15 18:08:17', NULL, NULL),
(144, 69, 146, '42.00', '0.00', NULL, '42.00', '650', NULL, NULL, '2023-09-15 18:08:57', NULL, NULL),
(145, 69, 147, '1.00', '0.00', NULL, '1.00', '23000', NULL, NULL, '2023-09-15 18:08:57', NULL, NULL),
(146, 70, 148, '10.00', '0.00', NULL, '10.00', '200', NULL, NULL, '2023-09-15 18:09:24', NULL, NULL),
(147, 70, 149, '5.00', '0.00', NULL, '5.00', '4000', NULL, NULL, '2023-09-15 18:09:24', NULL, NULL),
(148, 70, 150, '10.00', '0.00', NULL, '10.00', '500', NULL, NULL, '2023-09-15 18:09:24', NULL, NULL),
(149, 70, 151, '20.00', '0.00', NULL, '20.00', '300', NULL, NULL, '2023-09-15 18:09:24', NULL, NULL),
(150, 70, 152, '5.00', '0.00', NULL, '5.00', '300', NULL, NULL, '2023-09-15 18:09:24', NULL, NULL),
(151, 70, 153, '2.00', '0.00', NULL, '2.00', '15000', NULL, NULL, '2023-09-15 18:09:24', NULL, NULL),
(152, 71, 154, '1.00', '0.00', NULL, '1.00', '80000', NULL, NULL, '2023-09-15 18:10:29', NULL, NULL),
(153, 71, 155, '4.00', '0.00', NULL, '4.00', '300', NULL, NULL, '2023-09-15 18:10:29', NULL, NULL),
(154, 72, 156, '6.00', '0.00', NULL, '6.00', '14000', NULL, NULL, '2023-09-15 18:10:50', NULL, NULL),
(155, 73, 157, '6.00', '0.00', NULL, '6.00', '275', NULL, NULL, '2023-09-15 18:11:32', NULL, NULL),
(156, 74, 158, '3.00', '0.00', NULL, '3.00', '17000', NULL, NULL, '2023-09-15 18:12:07', NULL, NULL),
(157, 74, 159, '4.00', '0.00', NULL, '4.00', '17000', NULL, NULL, '2023-09-15 18:12:07', NULL, NULL),
(158, 74, 160, '3.00', '0.00', NULL, '3.00', '17000', NULL, NULL, '2023-09-15 18:12:07', NULL, NULL),
(159, 74, 161, '60.00', '0.00', NULL, '60.00', '3500', NULL, NULL, '2023-09-15 18:12:07', NULL, NULL),
(160, 75, 162, '50.00', '0.00', NULL, '50.00', '100', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(161, 75, 163, '20.00', '0.00', NULL, '20.00', '100', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(162, 75, 164, '31.00', '0.00', NULL, '31.00', '500', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(163, 75, 165, '2.00', '0.00', NULL, '2.00', '600', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(164, 75, 166, '5.00', '0.00', NULL, '5.00', '900', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(165, 75, 167, '5.00', '0.00', NULL, '5.00', '900', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(166, 75, 168, '6.00', '0.00', NULL, '6.00', '150', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(167, 75, 169, '5.00', '0.00', NULL, '5.00', '200', NULL, NULL, '2023-09-15 18:12:49', NULL, NULL),
(168, 76, 170, '20.00', '0.00', NULL, '20.00', '200', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(169, 76, 171, '3.00', '0.00', NULL, '3.00', '1000', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(170, 76, 172, '1.00', '0.00', NULL, '1.00', '6000', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(171, 76, 173, '30.00', '0.00', NULL, '30.00', '100', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(172, 76, 174, '20.00', '0.00', NULL, '20.00', '500', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(173, 76, 175, '10.00', '0.00', NULL, '10.00', '100', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(174, 76, 176, '5.00', '0.00', NULL, '5.00', '2500', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(175, 76, 177, '3.00', '0.00', NULL, '3.00', '600', NULL, NULL, '2023-09-15 18:13:15', NULL, NULL),
(176, 77, 178, '10.00', '0.00', NULL, '10.00', '1850', NULL, NULL, '2023-09-15 18:13:47', NULL, NULL),
(177, 77, 179, '25.00', '0.00', NULL, '25.00', '2300', NULL, NULL, '2023-09-15 18:13:47', NULL, NULL),
(178, 77, 180, '5.00', '0.00', NULL, '5.00', '6000', NULL, NULL, '2023-09-15 18:13:47', NULL, NULL),
(179, 78, 181, '10.00', '0.00', NULL, '10.00', '6750', NULL, NULL, '2023-09-15 18:14:08', NULL, NULL),
(180, 79, 182, '1.00', '0.00', NULL, '1.00', '6000', NULL, NULL, '2023-09-15 18:14:26', NULL, NULL),
(181, 80, 183, '1.00', '0.00', NULL, '1.00', '500', NULL, NULL, '2023-09-15 18:14:49', NULL, NULL),
(182, 81, 184, '1.00', '0.00', NULL, '1.00', '25000', NULL, NULL, '2023-09-15 18:15:19', NULL, NULL),
(183, 82, 185, '50.00', '0.00', NULL, '50.00', '800', NULL, NULL, '2023-09-15 18:15:41', NULL, NULL),
(184, 82, 186, '25.00', '0.00', NULL, '25.00', '950', NULL, NULL, '2023-09-15 18:15:41', NULL, NULL),
(185, 82, 187, '1.00', '0.00', NULL, '1.00', '12500', NULL, NULL, '2023-09-15 18:15:41', NULL, NULL),
(186, 82, 188, '43.00', '0.00', NULL, '43.00', '650', NULL, NULL, '2023-09-15 18:15:41', NULL, NULL),
(187, 82, 189, '6.00', '0.00', NULL, '6.00', '4300', NULL, NULL, '2023-09-15 18:15:41', NULL, NULL),
(188, 83, 190, '144.00', '0.00', NULL, '144.00', '4200', NULL, NULL, '2023-09-15 18:16:30', NULL, NULL),
(189, 83, 191, '20.00', '0.00', NULL, '20.00', '12500', NULL, NULL, '2023-09-15 18:16:30', NULL, NULL),
(190, 83, 192, '5.00', '0.00', NULL, '5.00', '47000', NULL, NULL, '2023-09-15 18:16:30', NULL, NULL),
(191, 84, 193, '46.00', '0.00', NULL, '46.00', '1450', NULL, NULL, '2023-09-15 18:17:05', NULL, NULL),
(192, 85, 194, '10.00', '0.00', NULL, '10.00', '750', NULL, NULL, '2023-09-15 18:17:41', NULL, NULL),
(193, 85, 195, '10.00', '0.00', NULL, '10.00', '750', NULL, NULL, '2023-09-15 18:17:41', NULL, NULL),
(194, 85, 196, '10.00', '0.00', NULL, '10.00', '750', NULL, NULL, '2023-09-15 18:17:41', NULL, NULL),
(195, 86, 197, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-15 18:18:06', NULL, NULL),
(196, 87, 198, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-15 18:18:46', NULL, NULL),
(197, 88, 199, '2.00', '0.00', NULL, '2.00', '4300', NULL, NULL, '2023-09-15 18:19:19', NULL, NULL),
(198, 89, 200, '1.00', '0.00', NULL, '1.00', '23000', NULL, NULL, '2023-09-15 18:19:37', NULL, NULL),
(199, 90, 201, '300.00', '0.00', NULL, '300.00', '275', NULL, NULL, '2023-09-15 18:19:56', NULL, NULL),
(200, 90, 202, '10.00', '0.00', NULL, '10.00', '2300', NULL, NULL, '2023-09-15 18:19:56', NULL, NULL),
(201, 91, 203, '40.00', '0.00', NULL, '40.00', '425', NULL, NULL, '2023-09-15 18:20:22', NULL, NULL),
(202, 92, 204, '20.00', '0.00', NULL, '20.00', '4000', NULL, NULL, '2023-09-15 18:20:41', NULL, NULL),
(203, 92, 205, '1000.00', '0.00', NULL, '1000.00', '245', NULL, NULL, '2023-09-15 18:20:41', NULL, NULL),
(204, 92, 206, '200.00', '0.00', NULL, '200.00', '200', NULL, NULL, '2023-09-15 18:20:41', NULL, NULL),
(205, 92, 207, '100.00', '0.00', NULL, '100.00', '3500', NULL, NULL, '2023-09-15 18:20:41', NULL, NULL),
(206, 93, 208, '160.00', '0.00', NULL, '160.00', '2200', NULL, NULL, '2023-09-15 18:21:01', NULL, NULL),
(207, 94, 209, '100.00', '0.00', NULL, '100.00', '1100', NULL, NULL, '2023-09-15 18:21:18', NULL, NULL),
(208, 94, 210, '90.00', '0.00', NULL, '90.00', '850', NULL, NULL, '2023-09-15 18:21:18', NULL, NULL),
(209, 94, 211, '300.00', '0.00', NULL, '300.00', '725', NULL, NULL, '2023-09-15 18:21:18', NULL, NULL),
(210, 94, 212, '50.00', '0.00', NULL, '50.00', '600', NULL, NULL, '2023-09-15 18:21:18', NULL, NULL),
(211, 95, 213, '4.00', '0.00', NULL, '4.00', '21500', NULL, NULL, '2023-09-15 18:21:38', NULL, NULL),
(212, 95, 214, '4.00', '0.00', NULL, '4.00', '34000', NULL, NULL, '2023-09-15 18:21:38', NULL, NULL),
(213, 95, 215, '200.00', '0.00', NULL, '200.00', '1850', NULL, NULL, '2023-09-15 18:21:38', NULL, NULL),
(214, 95, 216, '100.00', '0.00', NULL, '100.00', '225', NULL, NULL, '2023-09-15 18:21:38', NULL, NULL),
(215, 96, 217, '100.00', '0.00', NULL, '100.00', '1600', NULL, NULL, '2023-09-15 18:21:56', NULL, NULL),
(216, 96, 218, '38.00', '0.00', NULL, '38.00', '3800', NULL, NULL, '2023-09-15 18:21:56', NULL, NULL),
(217, 97, 219, '100.00', '0.00', NULL, '100.00', '12000', NULL, NULL, '2023-09-15 18:22:15', NULL, NULL),
(218, 97, 220, '20.00', '0.00', NULL, '20.00', '12000', NULL, NULL, '2023-09-15 18:22:15', NULL, NULL),
(219, 97, 221, '144.00', '0.00', NULL, '144.00', '4200', NULL, NULL, '2023-09-15 18:22:15', NULL, NULL),
(220, 98, 222, '50.00', '0.00', NULL, '50.00', '250', NULL, NULL, '2023-09-15 18:22:37', NULL, NULL),
(221, 99, 223, '12.00', '0.00', NULL, '12.00', '2600', NULL, NULL, '2023-09-15 18:22:56', NULL, NULL),
(222, 99, 224, '12.00', '0.00', NULL, '12.00', '2600', NULL, NULL, '2023-09-15 18:22:56', NULL, NULL),
(223, 99, 225, '6.00', '0.00', NULL, '6.00', '2600', NULL, NULL, '2023-09-15 18:22:56', NULL, NULL),
(224, 100, 226, '72.00', '0.00', NULL, '72.00', '4200', NULL, NULL, '2023-09-15 18:23:18', NULL, NULL),
(225, 100, 227, '1.00', '0.00', NULL, '1.00', '4200', NULL, NULL, '2023-09-15 18:23:18', NULL, NULL),
(226, 101, 228, '200.00', '0.00', NULL, '200.00', '700', NULL, NULL, '2023-09-15 18:23:51', NULL, NULL),
(227, 102, 229, '500.00', '0.00', NULL, '500.00', '296', NULL, NULL, '2023-09-15 18:24:09', NULL, NULL),
(228, 103, 230, '7.00', '0.00', NULL, '7.00', '200', NULL, NULL, '2023-09-15 18:24:29', NULL, NULL),
(229, 103, 231, '200.00', '0.00', NULL, '200.00', '150', NULL, NULL, '2023-09-15 18:24:29', NULL, NULL),
(230, 103, 232, '136.00', '0.00', NULL, '136.00', '150', NULL, NULL, '2023-09-15 18:24:29', NULL, NULL),
(231, 103, 233, '25.00', '0.00', NULL, '25.00', '250', NULL, NULL, '2023-09-15 18:24:29', NULL, NULL),
(232, 103, 234, '30.00', '0.00', NULL, '30.00', '200', NULL, NULL, '2023-09-15 18:24:29', NULL, NULL),
(233, 103, 235, '145.00', '0.00', NULL, '145.00', '500', NULL, NULL, '2023-09-15 18:24:29', NULL, NULL),
(234, 104, 269, '10.00', '0.00', NULL, '10.00', '3500', NULL, NULL, '2023-09-15 18:24:50', NULL, NULL),
(235, 104, 270, '8.00', '0.00', NULL, '8.00', '250', NULL, NULL, '2023-09-15 18:24:50', NULL, NULL),
(236, 105, 236, '6.00', '0.00', NULL, '6.00', '1600', NULL, NULL, '2023-09-15 18:25:12', NULL, NULL),
(237, 105, 237, '1.00', '0.00', NULL, '1.00', '100', NULL, NULL, '2023-09-15 18:25:12', NULL, NULL),
(238, 106, 238, '10.00', '0.00', NULL, '10.00', '1500', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(239, 106, 239, '25.00', '0.00', NULL, '25.00', '225', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(240, 106, 240, '10.00', '0.00', NULL, '10.00', '6500', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(241, 106, 241, '10.00', '0.00', NULL, '10.00', '2700', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(242, 106, 242, '20.00', '0.00', NULL, '20.00', '500', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(243, 106, 243, '10.00', '0.00', NULL, '10.00', '2200', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(244, 106, 244, '5.00', '0.00', NULL, '5.00', '3500', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(245, 106, 245, '10.00', '0.00', NULL, '10.00', '1200', NULL, NULL, '2023-09-15 18:25:49', NULL, NULL),
(246, 107, 246, '60.00', '0.00', NULL, '60.00', '850', NULL, NULL, '2023-09-15 18:26:12', NULL, NULL),
(247, 107, 247, '20.00', '0.00', NULL, '20.00', '1850', NULL, NULL, '2023-09-15 18:26:12', NULL, NULL),
(248, 107, 248, '20.00', '0.00', NULL, '20.00', '2250', NULL, NULL, '2023-09-15 18:26:12', NULL, NULL),
(249, 108, 249, '30.00', '0.00', NULL, '30.00', '3500', NULL, NULL, '2023-09-15 18:26:30', NULL, NULL),
(250, 108, 250, '30.00', '0.00', NULL, '30.00', '3500', NULL, NULL, '2023-09-15 18:26:30', NULL, NULL),
(251, 108, 251, '15.00', '0.00', NULL, '15.00', '3500', NULL, NULL, '2023-09-15 18:26:30', NULL, NULL),
(252, 108, 252, '15.00', '0.00', NULL, '15.00', '3500', NULL, NULL, '2023-09-15 18:26:30', NULL, NULL),
(253, 109, 253, '2000.00', '0.00', NULL, '2000.00', '350', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(254, 109, 254, '100.00', '0.00', NULL, '100.00', '200', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(255, 109, 255, '100.00', '0.00', NULL, '100.00', '225', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(256, 109, 256, '1000.00', '0.00', NULL, '1000.00', '240', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(257, 109, 257, '960.00', '0.00', NULL, '960.00', '400', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(258, 109, 258, '200.00', '0.00', NULL, '200.00', '300', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(259, 109, 259, '115.00', '0.00', NULL, '115.00', '500', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(260, 109, 260, '99.00', '0.00', NULL, '99.00', '500', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(261, 109, 261, '100.00', '0.00', NULL, '100.00', '500', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(262, 109, 262, '1.00', '0.00', NULL, '1.00', '65000', NULL, NULL, '2023-09-15 18:26:48', NULL, NULL),
(263, 110, 263, '5.00', '0.00', NULL, '5.00', '1500', NULL, NULL, '2023-09-15 18:27:12', NULL, NULL),
(264, 110, 264, '10.00', '0.00', NULL, '10.00', '1500', NULL, NULL, '2023-09-15 18:27:12', NULL, NULL),
(265, 110, 265, '10.00', '0.00', NULL, '10.00', '3000', NULL, NULL, '2023-09-15 18:27:12', NULL, NULL),
(266, 110, 266, '2.00', '0.00', NULL, '2.00', '850', NULL, NULL, '2023-09-15 18:27:12', NULL, NULL),
(267, 110, 267, '50.00', '0.00', NULL, '50.00', '250', NULL, NULL, '2023-09-15 18:27:12', NULL, NULL),
(268, 110, 268, '20.00', '0.00', NULL, '20.00', '1250', NULL, NULL, '2023-09-15 18:27:12', NULL, NULL),
(269, 111, 271, '2.00', '0.00', NULL, '2.00', '68000', NULL, NULL, '2023-09-15 18:27:34', NULL, NULL),
(270, 112, 272, '1.00', '0.00', NULL, '1.00', '302000', NULL, NULL, '2023-09-15 18:27:50', NULL, NULL),
(271, 113, 273, '1.00', '0.00', NULL, '1.00', '7000', NULL, NULL, '2023-09-15 18:28:13', NULL, NULL),
(272, 113, 274, '1.00', '0.00', NULL, '1.00', '4000', NULL, NULL, '2023-09-15 18:28:13', NULL, NULL),
(273, 113, 275, '6.00', '0.00', NULL, '6.00', '12000', NULL, NULL, '2023-09-15 18:28:13', NULL, NULL),
(274, 114, 276, '10.00', '0.00', NULL, '10.00', '6000', NULL, NULL, '2023-09-15 18:28:36', NULL, NULL),
(275, 114, 277, '13.00', '0.00', NULL, '13.00', '3000', NULL, NULL, '2023-09-15 18:28:36', NULL, NULL),
(276, 114, 278, '1.00', '0.00', NULL, '1.00', '2500', NULL, NULL, '2023-09-15 18:28:36', NULL, NULL),
(277, 115, 279, '12.00', '0.00', NULL, '12.00', '2500', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(278, 115, 280, '10.00', '0.00', NULL, '10.00', '1250', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(279, 115, 281, '10.00', '0.00', NULL, '10.00', '1250', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(280, 115, 282, '10.00', '0.00', NULL, '10.00', '7000', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(281, 115, 283, '50.00', '0.00', NULL, '50.00', '1250', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(282, 115, 284, '100.00', '0.00', NULL, '100.00', '375', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(283, 115, 285, '25.00', '0.00', NULL, '25.00', '3000', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(284, 115, 286, '10.00', '0.00', NULL, '10.00', '3700', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(285, 115, 287, '1.00', '0.00', NULL, '1.00', '6000', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(286, 115, 288, '1.00', '0.00', NULL, '1.00', '6500', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(287, 115, 289, '20.00', '0.00', NULL, '20.00', '750', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(288, 115, 290, '20.00', '0.00', NULL, '20.00', '750', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(289, 115, 291, '20.00', '0.00', NULL, '20.00', '950', NULL, NULL, '2023-09-15 18:28:58', NULL, NULL),
(290, 116, 292, '8.00', '0.00', NULL, '8.00', '2500', NULL, NULL, '2023-09-15 18:29:22', NULL, NULL),
(291, 116, 293, '2.00', '0.00', NULL, '2.00', '2500', NULL, NULL, '2023-09-15 18:29:22', NULL, NULL),
(292, 117, 294, '16.00', '0.00', NULL, '16.00', '3800', NULL, NULL, '2023-09-15 18:29:57', NULL, NULL),
(293, 118, 295, '1.00', '0.00', NULL, '1.00', '22500', NULL, NULL, '2023-09-15 18:30:18', NULL, NULL),
(294, 119, 296, '50.00', '0.00', NULL, '50.00', '850', NULL, NULL, '2023-09-15 18:30:35', NULL, NULL),
(295, 120, 297, '20.00', '0.00', NULL, '20.00', '400', NULL, NULL, '2023-09-15 18:30:55', NULL, NULL),
(296, 120, 298, '6.00', '0.00', NULL, '6.00', '1850', NULL, NULL, '2023-09-15 18:30:55', NULL, NULL),
(297, 121, 299, '4.00', '0.00', NULL, '4.00', '4500', NULL, NULL, '2023-09-15 18:31:13', NULL, NULL),
(298, 122, 300, '1000.00', '0.00', NULL, '1000.00', '1800', NULL, NULL, '2023-09-15 18:31:30', NULL, NULL),
(299, 123, 302, '200.00', '0.00', NULL, '200.00', '200', NULL, NULL, '2023-09-15 18:32:20', NULL, NULL),
(300, 123, 303, '2.00', '0.00', NULL, '2.00', '2600', NULL, NULL, '2023-09-15 18:32:20', NULL, NULL),
(301, 124, 304, '42.00', '0.00', NULL, '42.00', '650', NULL, NULL, '2023-09-15 18:33:12', NULL, NULL),
(302, 125, 305, '42.00', '0.00', NULL, '42.00', '650', NULL, NULL, '2023-09-15 18:33:35', NULL, NULL),
(303, 125, 306, '2.00', '0.00', NULL, '2.00', '15000', NULL, NULL, '2023-09-15 18:33:35', NULL, NULL),
(304, 125, 307, '100.00', '0.00', NULL, '100.00', '1850', NULL, NULL, '2023-09-15 18:33:35', NULL, NULL),
(305, 125, 308, '6.00', '0.00', NULL, '6.00', '4000', NULL, NULL, '2023-09-15 18:33:35', NULL, NULL),
(306, 125, 309, '5.00', '0.00', NULL, '5.00', '4300', NULL, NULL, '2023-09-15 18:33:35', NULL, NULL),
(307, 126, 310, '1.00', '0.00', NULL, '1.00', '46500', NULL, NULL, '2023-09-15 18:33:54', NULL, NULL),
(308, 127, 311, '4.00', '0.00', NULL, '4.00', '600', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(309, 127, 312, '4.00', '0.00', NULL, '4.00', '400', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(310, 127, 313, '7.00', '0.00', NULL, '7.00', '400', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(311, 127, 314, '3.00', '0.00', NULL, '3.00', '200', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(312, 127, 315, '12.00', '0.00', NULL, '12.00', '200', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(313, 127, 316, '10.00', '0.00', NULL, '10.00', '200', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(314, 127, 317, '10.00', '0.00', NULL, '10.00', '100', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(315, 127, 318, '3.00', '0.00', NULL, '3.00', '200', NULL, NULL, '2023-09-15 18:34:11', NULL, NULL),
(316, 128, 319, '10.00', '0.00', NULL, '10.00', '3500', NULL, NULL, '2023-09-16 14:13:01', NULL, NULL),
(317, 128, 320, '5.00', '0.00', NULL, '5.00', '4000', NULL, NULL, '2023-09-16 14:13:01', NULL, NULL),
(318, 129, 321, '8.00', '0.00', NULL, '8.00', '1800', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(319, 129, 322, '18.00', '0.00', NULL, '18.00', '600', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(320, 129, 323, '8.00', '0.00', NULL, '8.00', '700', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(321, 129, 324, '7.00', '0.00', NULL, '7.00', '500', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(322, 129, 325, '30.00', '0.00', NULL, '30.00', '100', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(323, 129, 326, '5.00', '0.00', NULL, '5.00', '125', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(324, 129, 327, '5.00', '0.00', NULL, '5.00', '200', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(325, 129, 328, '1.00', '0.00', NULL, '1.00', '400', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(326, 129, 329, '1.00', '0.00', NULL, '1.00', '700', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(327, 129, 330, '4.00', '0.00', NULL, '4.00', '3600', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(328, 129, 331, '2.00', '0.00', NULL, '2.00', '1000', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(329, 129, 332, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(330, 129, 333, '1.00', '0.00', NULL, '1.00', '6000', NULL, NULL, '2023-09-16 14:14:31', NULL, NULL),
(331, 130, 334, '15.00', '0.00', NULL, '15.00', '4300', NULL, NULL, '2023-09-16 14:15:14', NULL, NULL),
(332, 130, 335, '250.00', '0.00', NULL, '250.00', '125', NULL, NULL, '2023-09-16 14:15:14', NULL, NULL),
(333, 131, 336, '50.00', '0.00', NULL, '50.00', '220', NULL, NULL, '2023-09-16 14:15:33', NULL, NULL),
(334, 132, 337, '200.00', '0.00', NULL, '200.00', '1850', NULL, NULL, '2023-09-18 10:12:24', NULL, NULL),
(335, 132, 338, '100.00', '0.00', NULL, '100.00', '1550', NULL, NULL, '2023-09-18 10:12:24', NULL, NULL),
(336, 132, 339, '300.00', '0.00', NULL, '300.00', '415', NULL, NULL, '2023-09-18 10:12:24', NULL, NULL),
(337, 132, 340, '100.00', '0.00', NULL, '100.00', '750', NULL, NULL, '2023-09-18 10:12:24', NULL, NULL),
(338, 132, 341, '200.00', '0.00', NULL, '200.00', '350', NULL, NULL, '2023-09-18 10:12:24', NULL, NULL),
(339, 132, 342, '200.00', '0.00', NULL, '200.00', '250', NULL, NULL, '2023-09-18 10:12:24', NULL, NULL),
(340, 133, 343, '5.00', '0.00', NULL, '5.00', '12000', NULL, NULL, '2023-09-18 10:13:30', NULL, NULL),
(341, 134, 344, '10.00', '0.00', NULL, '10.00', '180000', NULL, NULL, '2023-09-18 10:13:48', NULL, NULL),
(342, 134, 345, '4000.00', '0.00', NULL, '4000.00', '240', NULL, NULL, '2023-09-18 10:13:48', NULL, NULL),
(343, 135, 346, '15.00', '0.00', NULL, '15.00', '3500', NULL, NULL, '2023-09-18 12:27:26', NULL, NULL),
(344, 135, 347, '15.00', '0.00', NULL, '15.00', '3500', NULL, NULL, '2023-09-18 12:27:26', NULL, NULL),
(345, 136, 348, '12.00', '0.00', NULL, '12.00', '11500', NULL, NULL, '2023-09-18 12:27:44', NULL, NULL),
(346, 136, 349, '6.00', '0.00', NULL, '6.00', '7000', NULL, NULL, '2023-09-18 12:27:44', NULL, NULL),
(347, 137, 350, '50.00', '0.00', NULL, '50.00', '200', NULL, NULL, '2023-09-18 12:27:58', NULL, NULL),
(348, 138, 351, '100.00', '0.00', NULL, '100.00', '2250', NULL, NULL, '2023-09-18 12:28:11', NULL, NULL),
(349, 139, 352, '12.00', '0.00', NULL, '12.00', '4300', NULL, NULL, '2023-09-18 14:12:48', NULL, NULL),
(350, 139, 353, '1.00', '0.00', NULL, '1.00', '12000', NULL, NULL, '2023-09-18 14:12:48', NULL, NULL),
(351, 139, 354, '1.00', '0.00', NULL, '1.00', '12500', NULL, NULL, '2023-09-18 14:12:48', NULL, NULL),
(352, 140, 355, '8.00', '0.00', NULL, '8.00', '10500', NULL, NULL, '2023-09-18 14:30:58', NULL, NULL),
(353, 140, 356, '1.00', '0.00', NULL, '1.00', '9000', NULL, NULL, '2023-09-18 14:30:58', NULL, NULL),
(354, 140, 357, '5.00', '0.00', NULL, '5.00', '15000', NULL, NULL, '2023-09-18 14:30:58', NULL, NULL),
(355, 140, 358, '1.00', '0.00', NULL, '1.00', '280000', NULL, NULL, '2023-09-18 14:30:58', NULL, NULL),
(356, 141, 359, '10.00', '0.00', NULL, '10.00', '26000', NULL, NULL, '2023-09-18 14:42:42', NULL, NULL),
(357, 141, 360, '100.00', '0.00', NULL, '100.00', '900', NULL, NULL, '2023-09-18 14:42:42', NULL, NULL),
(358, 141, 361, '300.00', '0.00', NULL, '300.00', '725', NULL, NULL, '2023-09-18 14:42:42', NULL, NULL),
(359, 142, 362, '20.00', '0.00', NULL, '20.00', '6500', NULL, NULL, '2023-09-19 08:43:44', NULL, NULL),
(360, 142, 363, '120.00', '0.00', NULL, '120.00', '2250', NULL, NULL, '2023-09-19 08:43:44', NULL, NULL),
(361, 142, 364, '60.00', '0.00', NULL, '60.00', '1850', NULL, NULL, '2023-09-19 08:43:44', NULL, NULL),
(362, 143, 365, '10.00', '0.00', NULL, '10.00', '11500', NULL, NULL, '2023-09-19 08:49:19', NULL, NULL),
(363, 144, 366, '100.00', '0.00', NULL, '100.00', '200', NULL, NULL, '2023-09-19 10:10:40', NULL, NULL),
(364, 144, 367, '100.00', '0.00', NULL, '100.00', '250', NULL, NULL, '2023-09-19 10:10:40', NULL, NULL),
(365, 144, 368, '50.00', '0.00', NULL, '50.00', '650', NULL, NULL, '2023-09-19 10:10:40', NULL, NULL),
(366, 145, 369, '50.00', '0.00', NULL, '50.00', '800', NULL, NULL, '2023-09-19 10:20:51', NULL, NULL),
(367, 146, 378, '42.00', '0.00', NULL, '42.00', '650', NULL, NULL, '2023-09-19 11:54:28', NULL, NULL),
(368, 147, 373, '50.00', '0.00', NULL, '50.00', '725', NULL, NULL, '2023-09-19 11:54:48', NULL, NULL),
(369, 147, 374, '50.00', '0.00', NULL, '50.00', '725', NULL, NULL, '2023-09-19 11:54:48', NULL, NULL),
(370, 147, 375, '20.00', '0.00', NULL, '20.00', '2500', NULL, NULL, '2023-09-19 11:54:48', NULL, NULL),
(371, 147, 376, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-19 11:54:48', NULL, NULL),
(372, 147, 377, '50.00', '0.00', NULL, '50.00', '700', NULL, NULL, '2023-09-19 11:54:48', NULL, NULL),
(373, 148, 370, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-19 11:55:03', NULL, NULL),
(374, 148, 371, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-19 11:55:03', NULL, NULL),
(375, 148, 372, '25.00', '0.00', NULL, '25.00', '3500', NULL, NULL, '2023-09-19 11:55:03', NULL, NULL),
(376, 149, 379, '250.00', '0.00', NULL, '250.00', '2400', NULL, NULL, '2023-09-19 15:34:45', NULL, NULL),
(377, 150, 380, '15.00', '0.00', NULL, '15.00', '4300', NULL, NULL, '2023-09-19 16:01:32', NULL, NULL),
(378, 150, 381, '50.00', '0.00', NULL, '50.00', '1250', NULL, NULL, '2023-09-19 16:01:32', NULL, NULL),
(379, 150, 382, '10.00', '0.00', NULL, '10.00', '4000', NULL, NULL, '2023-09-19 16:01:32', NULL, NULL),
(380, 150, 383, '52.00', '0.00', NULL, '52.00', '250', NULL, NULL, '2023-09-19 16:01:32', NULL, NULL),
(381, 151, 384, '12.00', '0.00', NULL, '12.00', '9000', NULL, NULL, '2023-09-20 10:42:59', NULL, NULL),
(382, 152, 385, '10.00', '0.00', NULL, '10.00', '1550', NULL, NULL, '2023-09-20 10:43:11', NULL, NULL),
(383, 152, 386, '5.00', '0.00', NULL, '5.00', '12500', NULL, NULL, '2023-09-20 10:43:11', NULL, NULL),
(384, 153, 387, '42.00', '0.00', NULL, '42.00', '650', NULL, NULL, '2023-09-20 10:43:26', NULL, NULL),
(385, 153, 388, '1.00', '0.00', NULL, '1.00', '23000', NULL, NULL, '2023-09-20 10:43:26', NULL, NULL),
(386, 154, 389, '1.00', '0.00', NULL, '1.00', '6500', NULL, NULL, '2023-09-20 11:07:40', NULL, NULL),
(387, 155, 390, '32.00', '0.00', NULL, '32.00', '2500', NULL, NULL, '2023-09-20 12:09:50', NULL, NULL),
(388, 155, 391, '2.00', '0.00', NULL, '2.00', '2000', NULL, NULL, '2023-09-20 12:09:50', NULL, NULL),
(389, 155, 392, '1.00', '0.00', NULL, '1.00', '2000', NULL, NULL, '2023-09-20 12:09:50', NULL, NULL),
(390, 156, 393, '7.00', '0.00', NULL, '7.00', '4300', NULL, NULL, '2023-09-20 12:10:10', NULL, NULL),
(391, 157, 394, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-20 12:32:16', NULL, NULL),
(392, 157, 395, '25.00', '0.00', NULL, '25.00', '950', NULL, NULL, '2023-09-20 12:32:16', NULL, NULL),
(393, 158, 396, '5.00', '0.00', NULL, '5.00', '800', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(394, 158, 397, '1.00', '0.00', NULL, '1.00', '2500', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(395, 158, 398, '5.00', '0.00', NULL, '5.00', '300', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(396, 158, 399, '4.00', '0.00', NULL, '4.00', '600', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(397, 158, 400, '4.00', '0.00', NULL, '4.00', '200', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(398, 158, 401, '1.00', '0.00', NULL, '1.00', '2500', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(399, 158, 402, '4.00', '0.00', NULL, '4.00', '300', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(400, 158, 403, '4.00', '0.00', NULL, '4.00', '200', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(401, 158, 404, '2.00', '0.00', NULL, '2.00', '200', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(402, 158, 405, '3.00', '0.00', NULL, '3.00', '600', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(403, 158, 406, '1.00', '0.00', NULL, '1.00', '700', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(404, 158, 407, '1.00', '0.00', NULL, '1.00', '100', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(405, 158, 408, '4.00', '0.00', NULL, '4.00', '100', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(406, 158, 409, '1.00', '0.00', NULL, '1.00', '1800', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(407, 158, 410, '3.00', '0.00', NULL, '3.00', '2000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(408, 158, 411, '1.00', '0.00', NULL, '1.00', '2000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(409, 158, 412, '1.00', '0.00', NULL, '1.00', '2000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(410, 158, 413, '1.00', '0.00', NULL, '1.00', '60000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(411, 158, 414, '1.00', '0.00', NULL, '1.00', '4000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(412, 158, 415, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(413, 158, 416, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(414, 158, 417, '1.00', '0.00', NULL, '1.00', '4000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(415, 158, 418, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-20 12:32:40', NULL, NULL),
(416, 159, 419, '30.00', '0.00', NULL, '30.00', '125', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(417, 159, 420, '30.00', '0.00', NULL, '30.00', '150', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(418, 159, 421, '50.00', '0.00', NULL, '50.00', '550', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(419, 159, 422, '50.00', '0.00', NULL, '50.00', '550', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(420, 159, 423, '20.00', '0.00', NULL, '20.00', '1800', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(421, 159, 424, '10.00', '0.00', NULL, '10.00', '1000', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(422, 159, 425, '20.00', '0.00', NULL, '20.00', '200', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(423, 159, 426, '1.00', '0.00', NULL, '1.00', '9500', NULL, NULL, '2023-09-20 13:05:42', NULL, NULL),
(424, 160, 444, '30.00', '0.00', NULL, '30.00', '800', NULL, NULL, '2023-09-20 14:16:35', NULL, NULL),
(425, 161, 427, '1.00', '0.00', NULL, '1.00', '4500', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(426, 161, 428, '2.00', '0.00', NULL, '2.00', '1000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(427, 161, 429, '1.00', '0.00', NULL, '1.00', '500', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(428, 161, 430, '3.00', '0.00', NULL, '3.00', '2000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(429, 161, 431, '4.00', '0.00', NULL, '4.00', '5000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(430, 161, 432, '4.00', '0.00', NULL, '4.00', '2000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(431, 161, 433, '4.00', '0.00', NULL, '4.00', '2000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(432, 161, 434, '3.00', '0.00', NULL, '3.00', '14000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(433, 161, 435, '4.00', '0.00', NULL, '4.00', '500', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(434, 161, 436, '8.00', '0.00', NULL, '8.00', '300', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(435, 161, 437, '2.00', '0.00', NULL, '2.00', '2000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(436, 161, 438, '1.00', '0.00', NULL, '1.00', '600', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(437, 161, 439, '6.00', '0.00', NULL, '6.00', '200', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(438, 161, 440, '4.00', '0.00', NULL, '4.00', '2000', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(439, 161, 441, '8.00', '0.00', NULL, '8.00', '300', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(440, 161, 442, '4.00', '0.00', NULL, '4.00', '300', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(441, 161, 443, '1.00', '0.00', NULL, '1.00', '500', NULL, NULL, '2023-09-20 14:16:55', NULL, NULL),
(442, 162, 445, '1000.00', '0.00', NULL, '1000.00', '240', NULL, NULL, '2023-09-20 14:42:25', NULL, NULL),
(443, 162, 446, '100.00', '0.00', NULL, '100.00', '1100', NULL, NULL, '2023-09-20 14:42:25', NULL, NULL),
(444, 163, 474, '2.00', '0.00', NULL, '2.00', '4300', NULL, NULL, '2023-09-20 16:44:47', NULL, NULL),
(445, 164, 451, '5.00', '0.00', NULL, '5.00', '800', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(446, 164, 452, '1.00', '0.00', NULL, '1.00', '2500', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(447, 164, 453, '5.00', '0.00', NULL, '5.00', '300', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(448, 164, 454, '4.00', '0.00', NULL, '4.00', '600', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(449, 164, 455, '4.00', '0.00', NULL, '4.00', '200', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(450, 164, 456, '1.00', '0.00', NULL, '1.00', '2500', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(451, 164, 457, '4.00', '0.00', NULL, '4.00', '300', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(452, 164, 458, '4.00', '0.00', NULL, '4.00', '200', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(453, 164, 459, '2.00', '0.00', NULL, '2.00', '200', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(454, 164, 460, '3.00', '0.00', NULL, '3.00', '600', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(455, 164, 461, '1.00', '0.00', NULL, '1.00', '700', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(456, 164, 462, '1.00', '0.00', NULL, '1.00', '100', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(457, 164, 463, '4.00', '0.00', NULL, '4.00', '100', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(458, 164, 464, '1.00', '0.00', NULL, '1.00', '1800', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(459, 164, 465, '3.00', '0.00', NULL, '3.00', '2000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(460, 164, 466, '1.00', '0.00', NULL, '1.00', '2000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(461, 164, 467, '1.00', '0.00', NULL, '1.00', '2000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(462, 164, 468, '1.00', '0.00', NULL, '1.00', '60000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(463, 164, 469, '1.00', '0.00', NULL, '1.00', '4000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(464, 164, 470, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(465, 164, 471, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(466, 164, 472, '1.00', '0.00', NULL, '1.00', '4000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(467, 164, 473, '1.00', '0.00', NULL, '1.00', '1000', NULL, NULL, '2023-09-20 16:45:04', NULL, NULL),
(468, 165, 449, '100.00', '0.00', NULL, '100.00', '1500', NULL, NULL, '2023-09-20 16:45:32', NULL, NULL),
(469, 165, 450, '200.00', '0.00', NULL, '200.00', '1800', NULL, NULL, '2023-09-20 16:45:32', NULL, NULL),
(470, 166, 447, '1.00', '0.00', NULL, '1.00', '26000', NULL, NULL, '2023-09-20 16:45:47', NULL, NULL),
(471, 166, 448, '1.00', '0.00', NULL, '1.00', '31500', NULL, NULL, '2023-09-20 16:45:47', NULL, NULL),
(472, 167, 475, '200.00', '0.00', NULL, '200.00', '2000', NULL, NULL, '2023-09-20 16:48:03', NULL, NULL),
(473, 168, 476, '100.00', '0.00', NULL, '100.00', '1850', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(474, 168, 477, '100.00', '0.00', NULL, '100.00', '1550', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(475, 168, 478, '100.00', '0.00', NULL, '100.00', '800', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(476, 168, 479, '50.00', '0.00', NULL, '50.00', '950', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(477, 168, 480, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(478, 168, 481, '200.00', '0.00', NULL, '200.00', '300', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(479, 168, 482, '50.00', '0.00', NULL, '50.00', '1250', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(480, 168, 483, '25.00', '0.00', NULL, '25.00', '2500', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(481, 168, 484, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(482, 168, 485, '50.00', '0.00', NULL, '50.00', '750', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(483, 168, 486, '24.00', '0.00', NULL, '24.00', '3600', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(484, 168, 487, '50.00', '0.00', NULL, '50.00', '350', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(485, 168, 488, '100.00', '0.00', NULL, '100.00', '250', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(486, 168, 489, '12.00', '0.00', NULL, '12.00', '3500', NULL, NULL, '2023-09-21 08:48:56', NULL, NULL),
(487, 169, 301, '35.00', '0.00', NULL, '35.00', '11500', NULL, NULL, '2023-09-21 10:32:40', NULL, NULL),
(488, 170, 490, '10.00', '0.00', NULL, '10.00', '1250', NULL, NULL, '2023-09-21 11:18:55', NULL, NULL),
(489, 170, 491, '20.00', '0.00', NULL, '20.00', '1250', NULL, NULL, '2023-09-21 11:18:55', NULL, NULL),
(490, 171, 492, '5.00', '0.00', NULL, '5.00', '12000', NULL, NULL, '2023-09-21 11:19:25', NULL, NULL),
(491, 172, 493, '480.00', '0.00', NULL, '480.00', '725', NULL, NULL, '2023-09-21 12:19:03', NULL, NULL),
(492, 172, 494, '360.00', '0.00', NULL, '360.00', '725', NULL, NULL, '2023-09-21 12:19:03', NULL, NULL),
(493, 172, 495, '200.00', '0.00', NULL, '200.00', '725', NULL, NULL, '2023-09-21 12:19:03', NULL, NULL),
(494, 172, 496, '200.00', '0.00', NULL, '200.00', '1100', NULL, NULL, '2023-09-21 12:19:03', NULL, NULL),
(495, 172, 497, '500.00', '0.00', NULL, '500.00', '350', NULL, NULL, '2023-09-21 12:19:03', NULL, NULL),
(496, 173, 498, '30.00', '0.00', NULL, '30.00', '1800', NULL, NULL, '2023-09-21 12:26:42', NULL, NULL);
INSERT INTO `produit_cond_mag_liv` (`id`, `livraison_mag_id`, `produit_com_clit_id`, `qte_liv`, `qte_raliv`, `montant_cond`, `qte_aliv`, `prix`, `carton`, `piece`, `created_at`, `updated_at`, `deleted_at`) VALUES
(497, 173, 499, '1.00', '0.00', NULL, '1.00', '38000', NULL, NULL, '2023-09-21 12:26:42', NULL, NULL),
(498, 173, 500, '1.00', '0.00', NULL, '1.00', '40000', NULL, NULL, '2023-09-21 12:26:42', NULL, NULL),
(499, 173, 501, '1.00', '0.00', NULL, '1.00', '3000', NULL, NULL, '2023-09-21 12:26:42', NULL, NULL),
(500, 173, 502, '4.00', '0.00', NULL, '4.00', '4000', NULL, NULL, '2023-09-21 12:26:42', NULL, NULL),
(501, 174, 503, '3.00', '0.00', NULL, '3.00', '16500', NULL, NULL, '2023-09-21 12:45:26', NULL, NULL),
(502, 175, 505, '8.00', '0.00', NULL, '8.00', '12000', NULL, NULL, '2023-09-21 15:11:44', NULL, NULL),
(503, 176, 504, '1.00', '0.00', NULL, '1.00', '64000', NULL, NULL, '2023-09-21 15:11:54', NULL, NULL),
(504, 177, 506, '40.00', '0.00', NULL, '40.00', '6750', NULL, NULL, '2023-09-21 15:16:41', NULL, NULL),
(505, 177, 507, '2.00', '0.00', NULL, '2.00', '35000', NULL, NULL, '2023-09-21 15:16:41', NULL, NULL),
(506, 178, 508, '30.00', '0.00', NULL, '30.00', '1800', NULL, NULL, '2023-09-21 15:21:38', NULL, NULL),
(507, 178, 509, '1.00', '0.00', NULL, '1.00', '38000', NULL, NULL, '2023-09-21 15:21:38', NULL, NULL),
(508, 178, 510, '1.00', '0.00', NULL, '1.00', '40000', NULL, NULL, '2023-09-21 15:21:38', NULL, NULL),
(509, 178, 511, '1.00', '0.00', NULL, '1.00', '2900', NULL, NULL, '2023-09-21 15:21:38', NULL, NULL),
(510, 178, 512, '4.00', '0.00', NULL, '4.00', '3150', NULL, NULL, '2023-09-21 15:21:38', NULL, NULL),
(511, 179, 513, '40.00', '0.00', NULL, '40.00', '750', NULL, NULL, '2023-09-21 16:16:34', NULL, NULL),
(512, 180, 514, '1.00', '0.00', NULL, '1.00', '120000', NULL, NULL, '2023-09-21 16:35:19', NULL, NULL),
(513, 181, 515, '1.00', '0.00', NULL, '1.00', '12000', NULL, NULL, '2023-09-21 16:51:56', NULL, NULL),
(514, 182, 516, '1.00', '0.00', NULL, '1.00', '9000', NULL, NULL, '2023-09-21 16:52:09', NULL, NULL),
(515, 182, 517, '4.00', '0.00', NULL, '4.00', '6000', NULL, NULL, '2023-09-21 16:52:09', NULL, NULL),
(516, 183, 518, '12.00', '0.00', NULL, '12.00', '2600', NULL, NULL, '2023-09-22 11:55:01', NULL, NULL),
(517, 183, 519, '6.00', '0.00', NULL, '6.00', '2600', NULL, NULL, '2023-09-22 11:55:01', NULL, NULL),
(518, 183, 520, '6.00', '0.00', NULL, '6.00', '2600', NULL, NULL, '2023-09-22 11:55:01', NULL, NULL),
(519, 184, 521, '1.00', '0.00', NULL, '1.00', '68000', NULL, NULL, '2023-09-22 11:55:14', NULL, NULL),
(520, 185, 522, '1.00', '0.00', NULL, '1.00', '125000', NULL, NULL, '2023-09-22 11:55:24', NULL, NULL),
(521, 186, 523, '1.00', '0.00', NULL, '1.00', '70000', NULL, NULL, '2023-09-22 12:50:38', NULL, NULL),
(522, 186, 524, '10.00', '0.00', NULL, '10.00', '6500', NULL, NULL, '2023-09-22 12:50:38', NULL, NULL),
(523, 187, 525, '1.00', '0.00', NULL, '1.00', '7000', NULL, NULL, '2023-09-22 12:50:49', NULL, NULL),
(524, 187, 526, '5.00', '0.00', NULL, '5.00', '6500', NULL, NULL, '2023-09-22 12:50:49', NULL, NULL),
(525, 188, 527, '1.00', '0.00', NULL, '1.00', '45000', NULL, NULL, '2023-09-22 12:51:01', NULL, NULL),
(526, 189, 528, '5.00', '0.00', NULL, '5.00', '4000', NULL, NULL, '2023-09-22 13:39:41', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_sortie_mag`
--

DROP TABLE IF EXISTS `produit_cond_sortie_mag`;
CREATE TABLE IF NOT EXISTS `produit_cond_sortie_mag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sortie_mag_id` int NOT NULL,
  `produit_cond_id` int NOT NULL,
  `prod_cond_mag_id` int DEFAULT NULL,
  `qte_cond_sortie` decimal(10,2) NOT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_205E22C599FFFAFE` (`sortie_mag_id`),
  KEY `IDX_205E22C5132D0AAA` (`produit_cond_id`),
  KEY `IDX_205E22C514658E17` (`prod_cond_mag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_sortie_mag`
--

INSERT INTO `produit_cond_sortie_mag` (`id`, `sortie_mag_id`, `produit_cond_id`, `prod_cond_mag_id`, `qte_cond_sortie`, `prix_unitaire`, `montant`, `est_sup`) VALUES
(1, 1, 114, 114, '15.00', '250.00', NULL, NULL),
(2, 1, 13, 13, '19.00', '24000.00', NULL, NULL),
(3, 1, 14, 14, '40.00', '24000.00', NULL, NULL),
(4, 2, 182, 182, '1.00', '350.00', NULL, NULL),
(5, 2, 371, 371, '1.00', '350.00', NULL, NULL),
(6, 2, 39, 39, '2.00', '500.00', NULL, NULL),
(7, 2, 369, 369, '2.00', '75.00', NULL, NULL),
(8, 2, 106, 106, '3.00', '4800.00', NULL, NULL),
(9, 2, 132, 132, '1.00', '350.00', NULL, NULL),
(10, 2, 156, 156, '2.00', '95.00', NULL, NULL),
(11, 2, 311, 311, '1.00', '1500.00', NULL, NULL),
(12, 2, 324, 324, '1.00', '4500.00', NULL, NULL),
(13, 2, 63, 63, '1.00', '5000.00', NULL, NULL),
(14, 2, 211, 211, '1.00', '11500.00', NULL, NULL),
(15, 2, 189, 189, '1.00', '800.00', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_cond_trans`
--

DROP TABLE IF EXISTS `produit_cond_trans`;
CREATE TABLE IF NOT EXISTS `produit_cond_trans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transfert_id` int NOT NULL,
  `produit_cond_id` int NOT NULL,
  `qte_cond_trans` decimal(10,2) NOT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2FB29803C9C4BAD` (`transfert_id`),
  KEY `IDX_2FB2980132D0AAA` (`produit_cond_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `produit_detacher`
--

DROP TABLE IF EXISTS `produit_detacher`;
CREATE TABLE IF NOT EXISTS `produit_detacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cible_id` int DEFAULT NULL,
  `produit_cond_mag_id` int DEFAULT NULL,
  `detachement_id` int DEFAULT NULL,
  `quantite` decimal(10,2) NOT NULL,
  `quantite_cible` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3C257CD4A96E5E09` (`cible_id`),
  KEY `IDX_3C257CD4C611A664` (`produit_cond_mag_id`),
  KEY `IDX_3C257CD44D6780D2` (`detachement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_detacher`
--

INSERT INTO `produit_detacher` (`id`, `cible_id`, `produit_cond_mag_id`, `detachement_id`, `quantite`, `quantite_cible`) VALUES
(1, 480, 44, 1, '15.00', '5.00'),
(2, 479, 45, 1, '60.00', '20.00'),
(3, 477, 47, 1, '90.00', '30.00'),
(4, 478, 46, 1, '60.00', '20.00'),
(5, 481, 441, 2, '2160.00', '30.00'),
(6, 484, 426, 3, '100.00', '10.00'),
(7, 485, 424, 4, '200.00', '20.00'),
(8, 486, 428, 5, '30.00', '3.00'),
(9, 487, 329, 6, '3500.00', '35.00');

-- --------------------------------------------------------

--
-- Structure de la table `prod_cond_fact`
--

DROP TABLE IF EXISTS `prod_cond_fact`;
CREATE TABLE IF NOT EXISTS `prod_cond_fact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int DEFAULT NULL,
  `facture_id` int DEFAULT NULL,
  `produit_com_clit_id` int DEFAULT NULL,
  `prix` decimal(10,0) NOT NULL,
  `montant` decimal(10,0) NOT NULL,
  `qtite` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C3C2615AF347EFB` (`produit_id`),
  KEY `IDX_C3C2615A7F2DEE08` (`facture_id`),
  KEY `IDX_C3C2615AF1787AB9` (`produit_com_clit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `profil`
--

DROP TABLE IF EXISTS `profil`;
CREATE TABLE IF NOT EXISTS `profil` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `titre` varchar(255) NOT NULL,
  `roles` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E6D6B297EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `profil`
--

INSERT INTO `profil` (`id`, `point_vente_id`, `titre`, `roles`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'CAISSE', '[\"ROLE_MOUVEMENT_STOCK\", \"ROLE_STAT_VENTE\", \"ROLE_POINT_COMMANDE\", \"ROLE_SOCIETE\", \"ROLE_COMMANDE_CLIENT\", \"ROLE_SUIVI_STOCK\", \"ROLE_TRANSACTION\", \"ROLE_PAIEMENT\", \"ROLE_DEPOT\", \"ROLE_DEPENSE\", \"ROLE_FACTURE\", \"ROLE_FACTURE_PRO_FORMA\", \"ROLE_FAMILLE\", \"ROLE_PRODUIT\", \"ROLE_MONNAIE\", \"ROLE_CAISSE\", \"ROLE_MODEL_SIGNATAIRE\", \"ROLE_BANQUE\", \"ROLE_CLIENT\", \"ROLE_FOURNISSEUR\", \"ROLE_TYPE_DEPENSE\", \"ROLE_ETAT_PRODUIT\", \"ROLE_ETAT_CLIENT\", \"ROLE_TYPE_OPERATION\"]', '2023-09-18 16:31:14', '2023-09-18 16:31:14', NULL),
(2, 1, 'PROFIL STOCK', '{\"0\": \"ROLE_MOUVEMENT_STOCK\", \"1\": \"ROLE_STAT_VENTE\", \"2\": \"ROLE_POINT_COMMANDE\", \"3\": \"ROLE_ETAT_PRODUIT\", \"4\": \"ROLE_ETAT_CLIENT\", \"5\": \"ROLE_SOCIETE\", \"6\": \"ROLE_FAMILLE\", \"7\": \"ROLE_PRODUIT\", \"8\": \"ROLE_PERSONNEL\", \"9\": \"ROLE_FONCTION\", \"10\": \"ROLE_MODE_DE_PAIEMENT\", \"11\": \"ROLE_CONDITIONNEMENT\", \"12\": \"ROLE_CLIENT\", \"13\": \"ROLE_FOURNISSEUR\", \"14\": \"ROLE_MONNAIE\", \"15\": \"ROLE_TYPE_OPERATION\", \"16\": \"ROLE_COMMANDE_CLIENT\", \"17\": \"ROLE_SUIVI_STOCK\", \"19\": \"ROLE_LIVRAISON\", \"20\": \"ROLE_SORTIE\", \"21\": \"ROLE_TRANSFERT\", \"22\": \"ROLE_LIVRAISON\", \"23\": \"ROLE_INVENTAIRE\", \"24\": \"ROLE_TRANSACTION\", \"25\": \"ROLE_DEPENSE\", \"26\": \"ROLE_DEMANDE_PRIX\", \"27\": \"ROLE_COMMANDE_FRS\", \"28\": \"ROLE_FACTURE\", \"29\": \"ROLE_FACTURE_PRO_FORMA\"}', '2023-09-21 10:26:20', '2023-09-21 10:26:20', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `selector` varchar(20) NOT NULL,
  `hashed_token` varchar(100) NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_57698A6AEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `societe`
--

DROP TABLE IF EXISTS `societe`;
CREATE TABLE IF NOT EXISTS `societe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logo_id` int DEFAULT NULL,
  `entete_id` int DEFAULT NULL,
  `pied_de_page_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `est_regime_tps` tinyint(1) NOT NULL,
  `denomination` varchar(255) NOT NULL,
  `sigle` varchar(255) NOT NULL,
  `raison_sociale` varchar(255) NOT NULL,
  `ifu` varchar(255) NOT NULL,
  `rccm` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `api_link` varchar(255) DEFAULT NULL,
  `api_nim` varchar(255) DEFAULT NULL,
  `api_token` longtext,
  `est_mode_mecef` tinyint(1) NOT NULL,
  `lieu_impression` varchar(255) DEFAULT NULL,
  `message_commercial` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_19653DBDF98F144A` (`logo_id`),
  UNIQUE KEY `UNIQ_19653DBDEC285501` (`entete_id`),
  UNIQUE KEY `UNIQ_19653DBDF31E83EB` (`pied_de_page_id`),
  KEY `IDX_19653DBDEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `societe`
--

INSERT INTO `societe` (`id`, `logo_id`, `entete_id`, `pied_de_page_id`, `point_vente_id`, `est_regime_tps`, `denomination`, `sigle`, `raison_sociale`, `ifu`, `rccm`, `adresse`, `telephone`, `est_sup`, `api_link`, `api_nim`, `api_token`, `est_mode_mecef`, `lieu_impression`, `message_commercial`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, NULL, NULL, 0, 'MARIA PLENA INTER', 'MPI', 'MARIA PLENA INTER', '3202290770618', 'RCCM RB/COT/22 B', 'COTONOU', '22997288937', NULL, 'https://developper.impots.bj/sygmef-emcf', 'TS01003999', '-', 0, 'Cotonou', NULL, '2023-09-13 10:07:01', '2023-09-13 10:07:01', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sortie`
--

DROP TABLE IF EXISTS `sortie`;
CREATE TABLE IF NOT EXISTS `sortie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `auteur_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `date_sortie` datetime NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `motif` longtext NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3C3FD3F260BB6FE6` (`auteur_id`),
  KEY `IDX_3C3FD3F2EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `sortie`
--

INSERT INTO `sortie` (`id`, `auteur_id`, `point_vente_id`, `date_sortie`, `montant_total`, `motif`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 1, '2023-09-21 10:47:21', '1419750.00', 'ERREUR D\'APPROVISIONNEMENT ET DE COMPTAGE', NULL, '2023-09-21 10:47:22', NULL, NULL),
(2, 2, 1, '2023-09-21 11:18:03', '40090.00', 'POURLE COMPTE DE MME', NULL, '2023-09-21 11:18:03', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sortie_mag`
--

DROP TABLE IF EXISTS `sortie_mag`;
CREATE TABLE IF NOT EXISTS `sortie_mag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sortie_id` int NOT NULL,
  `magasin_id` int NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_89043578CC72D953` (`sortie_id`),
  KEY `IDX_8904357820096AE3` (`magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `sortie_mag`
--

INSERT INTO `sortie_mag` (`id`, `sortie_id`, `magasin_id`, `est_sup`) VALUES
(1, 1, 1, NULL),
(2, 2, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `taxe`
--

DROP TABLE IF EXISTS `taxe`;
CREATE TABLE IF NOT EXISTS `taxe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_taxe_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `appellation` varchar(255) NOT NULL,
  `type_taux` int NOT NULL,
  `taux` decimal(10,2) DEFAULT NULL,
  `sens` int NOT NULL,
  `code_taxe` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_56322FE932982851` (`type_taxe_id`),
  KEY `IDX_56322FE9EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `taxe`
--

INSERT INTO `taxe` (`id`, `type_taxe_id`, `point_vente_id`, `libelle`, `appellation`, `type_taux`, `taux`, `sens`, `code_taxe`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, 'TAXE SUR VALEUR AJOUTEE', 'TVA', 0, '18.00', 1, 'TVA', NULL, '2023-09-12 15:37:36', NULL, NULL),
(2, NULL, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '1.00', 0, 'AIB1', NULL, '2023-09-12 15:37:36', NULL, NULL),
(3, NULL, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '5.00', 0, 'AIB5', NULL, '2023-09-12 15:37:36', NULL, NULL),
(4, NULL, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '3.00', 0, 'AIB3', NULL, '2023-09-12 15:37:36', NULL, NULL),
(5, NULL, NULL, 'EXONERE', 'EX', 0, '0.00', 1, 'TVA-EX', NULL, '2023-09-12 15:37:36', NULL, NULL),
(6, NULL, NULL, 'EXPORTATION', 'TVA-EXP', 0, '0.00', 1, 'TVA-EXP', NULL, '2023-09-12 15:37:36', NULL, NULL),
(7, NULL, NULL, 'TVA REGIME D\'EXCEPTION 18%', 'TVAD', 0, '18.00', 1, 'TVAD', NULL, '2023-09-12 15:37:36', NULL, NULL),
(8, NULL, NULL, 'TPS', 'E', 0, '0.00', 1, 'E', NULL, '2023-09-12 15:37:36', NULL, NULL),
(9, NULL, NULL, 'RESERVE', 'F', 0, '0.00', 1, 'F', NULL, '2023-09-12 15:37:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_operation_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `compte_id` int DEFAULT NULL,
  `mode_paiement_id` int DEFAULT NULL,
  `compte_banque_id` int DEFAULT NULL,
  `caisse_id` int DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `date_transac` datetime NOT NULL,
  `ref_transac` varchar(255) DEFAULT NULL,
  `montant_transac` decimal(10,2) NOT NULL,
  `numero_mobile_money` varchar(100) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `motif` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_723705D1C3EF8F86` (`type_operation_id`),
  KEY `IDX_723705D119EB6921` (`client_id`),
  KEY `IDX_723705D1F2C56620` (`compte_id`),
  KEY `IDX_723705D1438F5B63` (`mode_paiement_id`),
  KEY `IDX_723705D1F46EBEEB` (`compte_banque_id`),
  KEY `IDX_723705D127B4FEBF` (`caisse_id`),
  KEY `IDX_723705D1EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `transfert`
--

DROP TABLE IF EXISTS `transfert`;
CREATE TABLE IF NOT EXISTS `transfert` (
  `id` int NOT NULL AUTO_INCREMENT,
  `magasin_trans1_id` int NOT NULL,
  `magasin_trans2_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `date_trans` datetime NOT NULL,
  `motif` longtext NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1E4EACBB3CE82F8F` (`magasin_trans1_id`),
  KEY `IDX_1E4EACBB2E5D8061` (`magasin_trans2_id`),
  KEY `IDX_1E4EACBBEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `type_depense`
--

DROP TABLE IF EXISTS `type_depense`;
CREATE TABLE IF NOT EXISTS `type_depense` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1C24F8A2EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `type_depense`
--

INSERT INTO `type_depense` (`id`, `point_vente_id`, `libelle`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'Salaire', NULL, NULL, NULL, NULL),
(2, NULL, 'Carburation', NULL, NULL, NULL, NULL),
(3, NULL, 'Transport', NULL, '2023-09-18 16:25:46', '2023-09-18 16:25:46', NULL),
(4, NULL, 'Restauration', NULL, NULL, NULL, NULL),
(5, NULL, 'Assurance', NULL, NULL, NULL, NULL),
(6, NULL, 'Impôt', NULL, NULL, NULL, NULL),
(7, NULL, 'TONTINE', NULL, NULL, NULL, NULL),
(8, NULL, 'Frais retrait momo', NULL, NULL, NULL, NULL),
(9, NULL, 'Autres dépenses', NULL, NULL, NULL, NULL),
(10, NULL, 'Achat de fournitures de bureau', NULL, NULL, NULL, NULL),
(11, NULL, 'Achat de crédit de communication', NULL, NULL, NULL, NULL),
(12, NULL, 'Photocopie', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `type_inventaire`
--

DROP TABLE IF EXISTS `type_inventaire`;
CREATE TABLE IF NOT EXISTS `type_inventaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2E8AF6C5EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `type_operation`
--

DROP TABLE IF EXISTS `type_operation`;
CREATE TABLE IF NOT EXISTS `type_operation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AD47E77DEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `type_operation`
--

INSERT INTO `type_operation` (`id`, `point_vente_id`, `libelle`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Dépôt', NULL, '2023-09-12 15:37:36', NULL, NULL),
(2, 1, 'Retrait', NULL, '2023-09-12 15:37:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `type_taxe`
--

DROP TABLE IF EXISTS `type_taxe`;
CREATE TABLE IF NOT EXISTS `type_taxe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `point_vente_id` int DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_813DEAE1EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `username` varchar(180) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `roles` json NOT NULL,
  `profil` json NOT NULL,
  `password` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `security_code` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1D1C63B3F85E0677` (`username`),
  UNIQUE KEY `UNIQ_1D1C63B31C109075` (`personnel_id`),
  KEY `IDX_1D1C63B3EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `personnel_id`, `point_vente_id`, `username`, `email`, `roles`, `profil`, `password`, `est_sup`, `security_code`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 'Administrateur', NULL, '[\"ROLE_ADRESSE_LIVRAISON\", \"ROLE_APPROVISIONNEMENT\", \"ROLE_BANQUE\", \"ROLE_CAISSE\", \"ROLE_CLIENT\", \"ROLE_COMMANDE_CLIENT\", \"ROLE_COMMANDE_FRS\", \"ROLE_CONDITIONNEMENT\", \"ROLE_COMPTE\", \"ROLE_DEMANDE_DE_PRIX\", \"ROLE_ETAT\", \"ROLE_FACTURE\", \"ROLE_FACTURE_PRO_FORMA\", \"ROLE_FAMILLE\", \"ROLE_FONCTION\", \"ROLE_FOURNISSEUR\", \"ROLE_INVENTAIRE\", \"ROLE_LISTE_CAISSE\", \"ROLE_LIVRAISON\", \"ROLE_MAGASIN\", \"ROLE_MODEL_SIGNATURE\", \"ROLE_MODE_PAIEMENT\", \"ROLE_MONNAIE\", \"ROLE_PAIEMENT\", \"ROLE_MOUVEMENT_STOCK\", \"ROLE_STAT_VENTE\", \"ROLE_POINT_COMMANDE\", \"ROLE_ETAT_PRODUIT\", \"ROLE_ETAT_CLIENT\", \"ROLE_ETAT_FICHE\", \"ROLE_PROFIL\", \"ROLE_TRANSFERT\", \"ROLE_TRANSACTION\", \"ROLE_SORTIE\", \"ROLE_UTILISATEUR\", \"ROLE_POINT_VENTE\", \"ROLE_TAXE\", \"ROLE_TYPE_TAXE\", \"ROLE_TYPE_OPERATION\", \"ROLE_PERSONNEL\", \"ROLE_PRODUIT\", \"ROLE_SOCIETE\", \"ROLE_MENU\", \"ROLE_DEPENSE\", \"ROLE_SUIVI_STOCK\", \"ROLE_DEMANDE_PRIX\", \"ROLE_TYPE_DEPENSE\", \"ROLE_MODEL_SIGNATAIRE\", \"ROLE_DEPOT\", \"ROLE_CONFIGURATION\", \"ROLE_MODE_DE_PAIEMENT\"]', '[]', '$2y$13$Masn8094UESw65YHXvpFHu9euWKHfjUlfib/8bmWsuFv9tdyp/myC', NULL, 'u1amn8jketvj3cupsdf95d7qve', '2023-09-12 15:37:37', '2023-09-22 16:40:07', NULL),
(2, 2, 1, 'INES', NULL, '[\"ROLE_MOUVEMENT_STOCK\", \"ROLE_STAT_VENTE\", \"ROLE_POINT_COMMANDE\", \"ROLE_ETAT_PRODUIT\", \"ROLE_ETAT_CLIENT\", \"ROLE_SOCIETE\", \"ROLE_FAMILLE\", \"ROLE_PRODUIT\", \"ROLE_PERSONNEL\", \"ROLE_FONCTION\", \"ROLE_MODE_DE_PAIEMENT\", \"ROLE_CONDITIONNEMENT\", \"ROLE_CLIENT\", \"ROLE_FOURNISSEUR\", \"ROLE_MONNAIE\", \"ROLE_TYPE_OPERATION\", \"ROLE_COMMANDE_CLIENT\", \"ROLE_SUIVI_STOCK\", \"ROLE_LIVRAISON\", \"ROLE_SORTIE\", \"ROLE_TRANSFERT\", \"ROLE_LIVRAISON\", \"ROLE_INVENTAIRE\", \"ROLE_TRANSACTION\", \"ROLE_DEPENSE\", \"ROLE_DEMANDE_PRIX\", \"ROLE_COMMANDE_FRS\", \"ROLE_FACTURE\", \"ROLE_FACTURE_PRO_FORMA\"]', '[2]', '$2y$13$Z/9zX.id5MsKnqbwei4wyu9CGh/JeJz2FLgo85bO6ylXTXRRu5ha6', NULL, '0gooc3cksgkihsc369p83us03o', '2023-09-15 18:50:49', '2023-09-22 16:43:41', NULL),
(3, 3, 1, 'LOKO', NULL, '[\"ROLE_MOUVEMENT_STOCK\", \"ROLE_STAT_VENTE\", \"ROLE_POINT_COMMANDE\", \"ROLE_SOCIETE\", \"ROLE_COMMANDE_CLIENT\", \"ROLE_SUIVI_STOCK\", \"ROLE_TRANSACTION\", \"ROLE_PAIEMENT\", \"ROLE_DEPOT\", \"ROLE_DEPENSE\", \"ROLE_FACTURE\", \"ROLE_FACTURE_PRO_FORMA\", \"ROLE_FAMILLE\", \"ROLE_PRODUIT\", \"ROLE_MONNAIE\", \"ROLE_CAISSE\", \"ROLE_MODEL_SIGNATAIRE\", \"ROLE_BANQUE\", \"ROLE_CLIENT\", \"ROLE_FOURNISSEUR\", \"ROLE_TYPE_DEPENSE\", \"ROLE_ETAT_PRODUIT\", \"ROLE_ETAT_CLIENT\", \"ROLE_TYPE_OPERATION\"]', '[1]', '$2y$13$Ji0eBv.cKtNFBQNHclQVm.buXi9alQ9n4kDgpA1UtBj.QVEa9lRLi', NULL, 'p2rnrq5eo75dd7g0ipbc4de1b1', '2023-09-12 17:16:21', '2023-09-22 16:43:39', NULL),
(4, 4, 1, 'WILFRID', NULL, '[\"ROLE_MOUVEMENT_STOCK\", \"ROLE_STAT_VENTE\", \"ROLE_POINT_COMMANDE\", \"ROLE_ETAT_PRODUIT\", \"ROLE_ETAT_CLIENT\", \"ROLE_SOCIETE\", \"ROLE_FAMILLE\", \"ROLE_PRODUIT\", \"ROLE_PERSONNEL\", \"ROLE_FONCTION\", \"ROLE_MODE_DE_PAIEMENT\", \"ROLE_CONDITIONNEMENT\", \"ROLE_CLIENT\", \"ROLE_FOURNISSEUR\", \"ROLE_MONNAIE\", \"ROLE_TYPE_OPERATION\", \"ROLE_COMMANDE_CLIENT\", \"ROLE_SUIVI_STOCK\", \"ROLE_LIVRAISON\", \"ROLE_SORTIE\", \"ROLE_TRANSFERT\", \"ROLE_LIVRAISON\", \"ROLE_INVENTAIRE\", \"ROLE_TRANSACTION\", \"ROLE_DEPENSE\", \"ROLE_DEMANDE_PRIX\", \"ROLE_COMMANDE_FRS\", \"ROLE_FACTURE\", \"ROLE_FACTURE_PRO_FORMA\", \"ROLE_MOUVEMENT_STOCK\", \"ROLE_STAT_VENTE\", \"ROLE_POINT_COMMANDE\", \"ROLE_ETAT_PRODUIT\", \"ROLE_ETAT_CLIENT\", \"ROLE_SOCIETE\", \"ROLE_FAMILLE\", \"ROLE_PRODUIT\", \"ROLE_PERSONNEL\", \"ROLE_FONCTION\", \"ROLE_MODE_DE_PAIEMENT\", \"ROLE_CONDITIONNEMENT\", \"ROLE_CLIENT\", \"ROLE_FOURNISSEUR\", \"ROLE_MONNAIE\", \"ROLE_TYPE_OPERATION\", \"ROLE_COMMANDE_CLIENT\", \"ROLE_SUIVI_STOCK\", \"ROLE_LIVRAISON\", \"ROLE_SORTIE\", \"ROLE_TRANSFERT\", \"ROLE_LIVRAISON\", \"ROLE_INVENTAIRE\", \"ROLE_TRANSACTION\", \"ROLE_DEPENSE\", \"ROLE_DEMANDE_PRIX\", \"ROLE_COMMANDE_FRS\", \"ROLE_FACTURE\", \"ROLE_FACTURE_PRO_FORMA\"]', '[2]', '$2y$13$uMdV9sHmUHEF9ftyuWWjkOTvJk5jGFx1150yEnVEVjzqgOfvEwjz.', NULL, '8ed9jvq08cs8l592dqvq71irji', '2023-09-15 18:51:15', '2023-09-21 10:26:20', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_point_de_vente`
--

DROP TABLE IF EXISTS `utilisateur_point_de_vente`;
CREATE TABLE IF NOT EXISTS `utilisateur_point_de_vente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int NOT NULL,
  `point_de_vente_id` int NOT NULL,
  `est_actif` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CA8A1026FB88E14F` (`utilisateur_id`),
  KEY `IDX_CA8A10263F95E273` (`point_de_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `utilisateur_point_de_vente`
--

INSERT INTO `utilisateur_point_de_vente` (`id`, `utilisateur_id`, `point_de_vente_id`, `est_actif`) VALUES
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adresse_livraison`
--
ALTER TABLE `adresse_livraison`
  ADD CONSTRAINT `FK_B0B09C919EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_B0B09C9EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `approvisionnement`
--
ALTER TABLE `approvisionnement`
  ADD CONSTRAINT `FK_516C3FAA670C757F` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseur` (`id`),
  ADD CONSTRAINT `FK_516C3FAAD16C5631` FOREIGN KEY (`model_signataire_id`) REFERENCES `model_signataire` (`id`),
  ADD CONSTRAINT `FK_516C3FAAEA316CE` FOREIGN KEY (`commande_frs_id`) REFERENCES `commande_frs` (`id`),
  ADD CONSTRAINT `FK_516C3FAAEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `appro_magasin`
--
ALTER TABLE `appro_magasin`
  ADD CONSTRAINT `FK_32DAECBD20096AE3` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_32DAECBDAE741A98` FOREIGN KEY (`approvisionnement_id`) REFERENCES `approvisionnement` (`id`);

--
-- Contraintes pour la table `banque`
--
ALTER TABLE `banque`
  ADD CONSTRAINT `FK_B1F6CB3CEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `caisse`
--
ALTER TABLE `caisse`
  ADD CONSTRAINT `FK_B2A353C8A76ED395` FOREIGN KEY (`user_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_B2A353C8D726B853` FOREIGN KEY (`etat_caisse_id`) REFERENCES `caisse` (`id`),
  ADD CONSTRAINT `FK_B2A353C8E9EC6699` FOREIGN KEY (`lcaisse_id`) REFERENCES `list_caisse` (`id`),
  ADD CONSTRAINT `FK_B2A353C8EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `FK_C7440455EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `commande_client`
--
ALTER TABLE `commande_client`
  ADD CONSTRAINT `FK_C510FF803F192FC` FOREIGN KEY (`operateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_C510FF8096A7BB5F` FOREIGN KEY (`acheteur_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_C510FF80D16C5631` FOREIGN KEY (`model_signataire_id`) REFERENCES `model_signataire` (`id`),
  ADD CONSTRAINT `FK_C510FF80EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `commande_frs`
--
ALTER TABLE `commande_frs`
  ADD CONSTRAINT `FK_604E42223F192FC` FOREIGN KEY (`operateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_604E42225E931ED0` FOREIGN KEY (`demande_de_prix_id`) REFERENCES `demande_de_prix` (`id`),
  ADD CONSTRAINT `FK_604E4222670C757F` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseur` (`id`),
  ADD CONSTRAINT `FK_604E4222EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `compte`
--
ALTER TABLE `compte`
  ADD CONSTRAINT `FK_CFF6526019EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_CFF65260670C757F` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseur` (`id`),
  ADD CONSTRAINT `FK_CFF65260EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `compte_banque`
--
ALTER TABLE `compte_banque`
  ADD CONSTRAINT `FK_6B6F920B37E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`),
  ADD CONSTRAINT `FK_6B6F920BFCF77503` FOREIGN KEY (`societe_id`) REFERENCES `societe` (`id`);

--
-- Contraintes pour la table `conditionnement`
--
ALTER TABLE `conditionnement`
  ADD CONSTRAINT `FK_3F4BEA3AEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `demande_de_prix`
--
ALTER TABLE `demande_de_prix`
  ADD CONSTRAINT `FK_E6B3FF963F192FC` FOREIGN KEY (`operateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_E6B3FF96670C757F` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseur` (`id`),
  ADD CONSTRAINT `FK_E6B3FF96EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `depense`
--
ALTER TABLE `depense`
  ADD CONSTRAINT `FK_3405975727B4FEBF` FOREIGN KEY (`caisse_id`) REFERENCES `caisse` (`id`),
  ADD CONSTRAINT `FK_340597575CDBC346` FOREIGN KEY (`type_depense_id`) REFERENCES `type_depense` (`id`),
  ADD CONSTRAINT `FK_34059757A76ED395` FOREIGN KEY (`user_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_34059757EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `detachement`
--
ALTER TABLE `detachement`
  ADD CONSTRAINT `FK_29275FF520096AE3` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_29275FF56B7A2406` FOREIGN KEY (`user_det_id`) REFERENCES `utilisateur` (`id`);

--
-- Contraintes pour la table `element_supplementaire`
--
ALTER TABLE `element_supplementaire`
  ADD CONSTRAINT `FK_33DFDCA39E73363` FOREIGN KEY (`commande_client_id`) REFERENCES `commande_client` (`id`);

--
-- Contraintes pour la table `facture`
--
ALTER TABLE `facture`
  ADD CONSTRAINT `FK_FE8664103F192FC` FOREIGN KEY (`operateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_FE866410BE1A1965` FOREIGN KEY (`commande_cli_id`) REFERENCES `commande_client` (`id`),
  ADD CONSTRAINT `FK_FE866410EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `facture_proforma`
--
ALTER TABLE `facture_proforma`
  ADD CONSTRAINT `FK_917CA1273F192FC` FOREIGN KEY (`operateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_917CA12796A7BB5F` FOREIGN KEY (`acheteur_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_917CA127D16C5631` FOREIGN KEY (`model_signataire_id`) REFERENCES `model_signataire` (`id`),
  ADD CONSTRAINT `FK_917CA127EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `famille`
--
ALTER TABLE `famille`
  ADD CONSTRAINT `FK_2473F21352523166` FOREIGN KEY (`famille_parent_id`) REFERENCES `famille` (`id`),
  ADD CONSTRAINT `FK_2473F213EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `fonction`
--
ALTER TABLE `fonction`
  ADD CONSTRAINT `FK_900D5BDEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `fonction_personnel`
--
ALTER TABLE `fonction_personnel`
  ADD CONSTRAINT `FK_5B2013EF1C109075` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `FK_5B2013EF57889920` FOREIGN KEY (`fonction_id`) REFERENCES `fonction` (`id`);

--
-- Contraintes pour la table `fournisseur`
--
ALTER TABLE `fournisseur`
  ADD CONSTRAINT `FK_369ECA32EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `groupe_taxe`
--
ALTER TABLE `groupe_taxe`
  ADD CONSTRAINT `FK_FEDA505EE2FBBC81` FOREIGN KEY (`taux_gr_id`) REFERENCES `taxe` (`id`),
  ADD CONSTRAINT `FK_FEDA505EEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `inventaire`
--
ALTER TABLE `inventaire`
  ADD CONSTRAINT `FK_338920E04CB8BE47` FOREIGN KEY (`type_inv_id`) REFERENCES `type_inventaire` (`id`),
  ADD CONSTRAINT `FK_338920E0D16C5631` FOREIGN KEY (`model_signataire_id`) REFERENCES `model_signataire` (`id`),
  ADD CONSTRAINT `FK_338920E0EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `inventaire_mag`
--
ALTER TABLE `inventaire_mag`
  ADD CONSTRAINT `FK_E6B6734A20096AE3` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_E6B6734ACE430A85` FOREIGN KEY (`inventaire_id`) REFERENCES `inventaire` (`id`);

--
-- Contraintes pour la table `inventaire_personnel`
--
ALTER TABLE `inventaire_personnel`
  ADD CONSTRAINT `FK_8BCCFC2F1C109075` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_8BCCFC2FCE430A85` FOREIGN KEY (`inventaire_id`) REFERENCES `inventaire` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `list_caisse`
--
ALTER TABLE `list_caisse`
  ADD CONSTRAINT `FK_2B7391E6EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD CONSTRAINT `FK_A60C9F1F3F192FC` FOREIGN KEY (`operateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_A60C9F1FBE1A1965` FOREIGN KEY (`commande_cli_id`) REFERENCES `commande_client` (`id`),
  ADD CONSTRAINT `FK_A60C9F1FD16C5631` FOREIGN KEY (`model_signataire_id`) REFERENCES `model_signataire` (`id`),
  ADD CONSTRAINT `FK_A60C9F1FEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_A60C9F1FF8646701` FOREIGN KEY (`livreur_id`) REFERENCES `personnel` (`id`);

--
-- Contraintes pour la table `livraison_magasin`
--
ALTER TABLE `livraison_magasin`
  ADD CONSTRAINT `FK_1459314520096AE3` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_145931458E54FB25` FOREIGN KEY (`livraison_id`) REFERENCES `livraison` (`id`);

--
-- Contraintes pour la table `magasin`
--
ALTER TABLE `magasin`
  ADD CONSTRAINT `FK_54AF5F27B7BB80FF` FOREIGN KEY (`superviseur_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `FK_54AF5F27EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `FK_6A2CA10CEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_6A2CA10CF347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`);

--
-- Contraintes pour la table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `FK_7D053A93EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_7D053A93F9ADC1B4` FOREIGN KEY (`menu_superieur_id`) REFERENCES `menu` (`id`);

--
-- Contraintes pour la table `model_signataire`
--
ALTER TABLE `model_signataire`
  ADD CONSTRAINT `FK_4D1B8005EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `model_signataire_personnel_fonction`
--
ALTER TABLE `model_signataire_personnel_fonction`
  ADD CONSTRAINT `FK_17B9DBC91C109075` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `FK_17B9DBC957889920` FOREIGN KEY (`fonction_id`) REFERENCES `fonction` (`id`),
  ADD CONSTRAINT `FK_17B9DBC9D16C5631` FOREIGN KEY (`model_signataire_id`) REFERENCES `model_signataire` (`id`);

--
-- Contraintes pour la table `mode_paiement`
--
ALTER TABLE `mode_paiement`
  ADD CONSTRAINT `FK_B2BB0E85EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `monnaie`
--
ALTER TABLE `monnaie`
  ADD CONSTRAINT `FK_B3A6E2E6EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `monnaie_caisse`
--
ALTER TABLE `monnaie_caisse`
  ADD CONSTRAINT `FK_80CC16AD27B4FEBF` FOREIGN KEY (`caisse_id`) REFERENCES `caisse` (`id`),
  ADD CONSTRAINT `FK_80CC16AD98D3FE22` FOREIGN KEY (`monnaie_id`) REFERENCES `monnaie` (`id`);

--
-- Contraintes pour la table `paiement`
--
ALTER TABLE `paiement`
  ADD CONSTRAINT `FK_B1DC7A1E27B4FEBF` FOREIGN KEY (`caisse_id`) REFERENCES `caisse` (`id`),
  ADD CONSTRAINT `FK_B1DC7A1E2FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`),
  ADD CONSTRAINT `FK_B1DC7A1E37E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`),
  ADD CONSTRAINT `FK_B1DC7A1E3F192FC` FOREIGN KEY (`operateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `FK_B1DC7A1E438F5B63` FOREIGN KEY (`mode_paiement_id`) REFERENCES `mode_paiement` (`id`),
  ADD CONSTRAINT `FK_B1DC7A1E7F2DEE08` FOREIGN KEY (`facture_id`) REFERENCES `facture` (`id`),
  ADD CONSTRAINT `FK_B1DC7A1EEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `personnel`
--
ALTER TABLE `personnel`
  ADD CONSTRAINT `FK_A6BCF3DEEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `personnel_caisse`
--
ALTER TABLE `personnel_caisse`
  ADD CONSTRAINT `FK_9E5D04281C109075` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `FK_9E5D042827B4FEBF` FOREIGN KEY (`caisse_id`) REFERENCES `caisse` (`id`);

--
-- Contraintes pour la table `point_de_vente`
--
ALTER TABLE `point_de_vente`
  ADD CONSTRAINT `FK_C9182F7BEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `FK_29A5EC2797A77B84` FOREIGN KEY (`famille_id`) REFERENCES `famille` (`id`),
  ADD CONSTRAINT `FK_29A5EC27DCDEA0EA` FOREIGN KEY (`groupe_taxe_id`) REFERENCES `groupe_taxe` (`id`),
  ADD CONSTRAINT `FK_29A5EC27EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_29A5EC27F12D8438` FOREIGN KEY (`magasin_defaut_id`) REFERENCES `magasin` (`id`);

--
-- Contraintes pour la table `produit_conditionnement`
--
ALTER TABLE `produit_conditionnement`
  ADD CONSTRAINT `FK_1F452A28A222637` FOREIGN KEY (`conditionnement_id`) REFERENCES `conditionnement` (`id`),
  ADD CONSTRAINT `FK_1F452A28EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_1F452A28F347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`);

--
-- Contraintes pour la table `produit_cond_appro_mag`
--
ALTER TABLE `produit_cond_appro_mag`
  ADD CONSTRAINT `FK_2A498BD239C2AB40` FOREIGN KEY (`produit_conditionnement_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_2A498BD23F0A2F6B` FOREIGN KEY (`appro_magasin_id`) REFERENCES `appro_magasin` (`id`);

--
-- Contraintes pour la table `produit_cond_com_clit`
--
ALTER TABLE `produit_cond_com_clit`
  ADD CONSTRAINT `FK_192AE28E20096AE3` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_192AE28E47C00A52` FOREIGN KEY (`commande_clit_id`) REFERENCES `commande_client` (`id`),
  ADD CONSTRAINT `FK_192AE28EF347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit_conditionnement` (`id`);

--
-- Contraintes pour la table `produit_cond_com_frs`
--
ALTER TABLE `produit_cond_com_frs`
  ADD CONSTRAINT `FK_66568B8A132D0AAA` FOREIGN KEY (`produit_cond_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_66568B8AEA316CE` FOREIGN KEY (`commande_frs_id`) REFERENCES `commande_frs` (`id`);

--
-- Contraintes pour la table `produit_cond_ddp`
--
ALTER TABLE `produit_cond_ddp`
  ADD CONSTRAINT `FK_BCCF6A1E132D0AAA` FOREIGN KEY (`produit_cond_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_BCCF6A1E5E931ED0` FOREIGN KEY (`demande_de_prix_id`) REFERENCES `demande_de_prix` (`id`);

--
-- Contraintes pour la table `produit_cond_facture`
--
ALTER TABLE `produit_cond_facture`
  ADD CONSTRAINT `FK_2CD3FB7BB5EC257B` FOREIGN KEY (`facture_proforma_id`) REFERENCES `facture_proforma` (`id`),
  ADD CONSTRAINT `FK_2CD3FB7BF347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit_conditionnement` (`id`);

--
-- Contraintes pour la table `produit_cond_mag`
--
ALTER TABLE `produit_cond_mag`
  ADD CONSTRAINT `FK_4DBA201320096AE3` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_4DBA201339C2AB40` FOREIGN KEY (`produit_conditionnement_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_4DBA2013EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `produit_cond_mag_inv`
--
ALTER TABLE `produit_cond_mag_inv`
  ADD CONSTRAINT `FK_DB9267E937754359` FOREIGN KEY (`produit_cond_inv_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_DB9267E93D5CF14C` FOREIGN KEY (`inventaire_mag_id`) REFERENCES `inventaire_mag` (`id`);

--
-- Contraintes pour la table `produit_cond_mag_liv`
--
ALTER TABLE `produit_cond_mag_liv`
  ADD CONSTRAINT `FK_921833C5B76E34A8` FOREIGN KEY (`livraison_mag_id`) REFERENCES `livraison_magasin` (`id`),
  ADD CONSTRAINT `FK_921833C5F1787AB9` FOREIGN KEY (`produit_com_clit_id`) REFERENCES `produit_cond_com_clit` (`id`);

--
-- Contraintes pour la table `produit_cond_sortie_mag`
--
ALTER TABLE `produit_cond_sortie_mag`
  ADD CONSTRAINT `FK_205E22C5132D0AAA` FOREIGN KEY (`produit_cond_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_205E22C514658E17` FOREIGN KEY (`prod_cond_mag_id`) REFERENCES `produit_cond_mag` (`id`),
  ADD CONSTRAINT `FK_205E22C599FFFAFE` FOREIGN KEY (`sortie_mag_id`) REFERENCES `sortie_mag` (`id`);

--
-- Contraintes pour la table `produit_cond_trans`
--
ALTER TABLE `produit_cond_trans`
  ADD CONSTRAINT `FK_2FB2980132D0AAA` FOREIGN KEY (`produit_cond_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_2FB29803C9C4BAD` FOREIGN KEY (`transfert_id`) REFERENCES `transfert` (`id`);

--
-- Contraintes pour la table `produit_detacher`
--
ALTER TABLE `produit_detacher`
  ADD CONSTRAINT `FK_3C257CD44D6780D2` FOREIGN KEY (`detachement_id`) REFERENCES `detachement` (`id`),
  ADD CONSTRAINT `FK_3C257CD4A96E5E09` FOREIGN KEY (`cible_id`) REFERENCES `produit_conditionnement` (`id`),
  ADD CONSTRAINT `FK_3C257CD4C611A664` FOREIGN KEY (`produit_cond_mag_id`) REFERENCES `produit_cond_mag` (`id`);

--
-- Contraintes pour la table `prod_cond_fact`
--
ALTER TABLE `prod_cond_fact`
  ADD CONSTRAINT `FK_C3C2615A7F2DEE08` FOREIGN KEY (`facture_id`) REFERENCES `facture` (`id`),
  ADD CONSTRAINT `FK_C3C2615AF1787AB9` FOREIGN KEY (`produit_com_clit_id`) REFERENCES `produit_cond_com_clit` (`id`),
  ADD CONSTRAINT `FK_C3C2615AF347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit_conditionnement` (`id`);

--
-- Contraintes pour la table `profil`
--
ALTER TABLE `profil`
  ADD CONSTRAINT `FK_E6D6B297EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `utilisateur` (`id`);

--
-- Contraintes pour la table `role`
--
ALTER TABLE `role`
  ADD CONSTRAINT `FK_57698A6AEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `societe`
--
ALTER TABLE `societe`
  ADD CONSTRAINT `FK_19653DBDEC285501` FOREIGN KEY (`entete_id`) REFERENCES `media` (`id`),
  ADD CONSTRAINT `FK_19653DBDEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_19653DBDF31E83EB` FOREIGN KEY (`pied_de_page_id`) REFERENCES `media` (`id`),
  ADD CONSTRAINT `FK_19653DBDF98F144A` FOREIGN KEY (`logo_id`) REFERENCES `media` (`id`);

--
-- Contraintes pour la table `sortie`
--
ALTER TABLE `sortie`
  ADD CONSTRAINT `FK_3C3FD3F260BB6FE6` FOREIGN KEY (`auteur_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `FK_3C3FD3F2EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `sortie_mag`
--
ALTER TABLE `sortie_mag`
  ADD CONSTRAINT `FK_8904357820096AE3` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_89043578CC72D953` FOREIGN KEY (`sortie_id`) REFERENCES `sortie` (`id`);

--
-- Contraintes pour la table `taxe`
--
ALTER TABLE `taxe`
  ADD CONSTRAINT `FK_56322FE932982851` FOREIGN KEY (`type_taxe_id`) REFERENCES `type_taxe` (`id`),
  ADD CONSTRAINT `FK_56322FE9EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `FK_723705D119EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_723705D127B4FEBF` FOREIGN KEY (`caisse_id`) REFERENCES `caisse` (`id`),
  ADD CONSTRAINT `FK_723705D1438F5B63` FOREIGN KEY (`mode_paiement_id`) REFERENCES `mode_paiement` (`id`),
  ADD CONSTRAINT `FK_723705D1C3EF8F86` FOREIGN KEY (`type_operation_id`) REFERENCES `type_operation` (`id`),
  ADD CONSTRAINT `FK_723705D1EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_723705D1F2C56620` FOREIGN KEY (`compte_id`) REFERENCES `compte` (`id`),
  ADD CONSTRAINT `FK_723705D1F46EBEEB` FOREIGN KEY (`compte_banque_id`) REFERENCES `compte_banque` (`id`);

--
-- Contraintes pour la table `transfert`
--
ALTER TABLE `transfert`
  ADD CONSTRAINT `FK_1E4EACBB2E5D8061` FOREIGN KEY (`magasin_trans2_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_1E4EACBB3CE82F8F` FOREIGN KEY (`magasin_trans1_id`) REFERENCES `magasin` (`id`),
  ADD CONSTRAINT `FK_1E4EACBBEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `type_depense`
--
ALTER TABLE `type_depense`
  ADD CONSTRAINT `FK_1C24F8A2EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `type_inventaire`
--
ALTER TABLE `type_inventaire`
  ADD CONSTRAINT `FK_2E8AF6C5EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `type_operation`
--
ALTER TABLE `type_operation`
  ADD CONSTRAINT `FK_AD47E77DEFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `type_taxe`
--
ALTER TABLE `type_taxe`
  ADD CONSTRAINT `FK_813DEAE1EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `FK_1D1C63B31C109075` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `FK_1D1C63B3EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `utilisateur_point_de_vente`
--
ALTER TABLE `utilisateur_point_de_vente`
  ADD CONSTRAINT `FK_CA8A10263F95E273` FOREIGN KEY (`point_de_vente_id`) REFERENCES `point_de_vente` (`id`),
  ADD CONSTRAINT `FK_CA8A1026FB88E14F` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

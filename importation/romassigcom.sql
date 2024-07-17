-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 12 juil. 2023 à 10:17
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
  `libelle_adresse` varchar(255) NOT NULL,
  `quartier` varchar(255) DEFAULT NULL,
  `ville` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
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
  `date_appro` datetime NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `fournisseur_id` int DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_516C3FAAEA316CE` (`commande_frs_id`),
  KEY `IDX_516C3FAAEFA24D68` (`point_vente_id`),
  KEY `IDX_516C3FAA670C757F` (`fournisseur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `approvisionnement`
--

INSERT INTO `approvisionnement` (`id`, `commande_frs_id`, `date_appro`, `montant_total`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `fournisseur_id`, `reference`) VALUES
(1, NULL, '2023-05-31 00:00:00', '100000.00', NULL, '2023-05-31 16:40:33', NULL, NULL, 1, 1, 'ref1'),
(2, NULL, '2023-05-31 00:00:00', NULL, NULL, '2023-05-31 17:53:34', NULL, NULL, 1, 1, NULL),
(3, NULL, '2023-06-06 00:00:00', NULL, NULL, '2023-06-06 00:04:46', NULL, NULL, 1, NULL, NULL),
(4, NULL, '2023-06-09 00:00:00', '100000.00', NULL, '2023-06-09 11:05:54', NULL, NULL, 1, NULL, 'REF3BCE643021E71BE4'),
(5, NULL, '2023-06-09 00:00:00', '2.00', NULL, '2023-06-09 11:26:32', NULL, NULL, 1, 1, 'REF-B7172A507C32E557'),
(6, NULL, '2023-06-14 00:00:00', '300000.00', NULL, '2023-06-14 20:24:15', NULL, NULL, 1, 1, 'REF-72159F3AD5B75B43'),
(7, NULL, '2023-06-16 00:00:00', '200000.00', NULL, '2023-06-16 18:39:39', NULL, NULL, 1, 1, 'REF-B28ED52A08E4C457'),
(8, NULL, '2023-06-16 00:00:00', '3000000.00', NULL, '2023-06-16 19:10:47', NULL, NULL, 1, 1, 'REF-2E38B22C697B0090'),
(9, NULL, '2023-06-20 00:00:00', '200000.00', NULL, '2023-06-20 11:21:40', NULL, NULL, 1, 1, 'REF-AC4F2F2508E7B73B'),
(10, NULL, '2023-06-20 00:00:00', '150000.00', NULL, '2023-06-20 13:17:52', NULL, NULL, 1, 1, 'REF-6419782948EE685B'),
(11, NULL, '2023-06-20 00:00:00', '1000000.00', NULL, '2023-06-20 20:18:12', NULL, NULL, 1, 1, 'REF-2D58A8E08E224DC4'),
(12, NULL, '2023-06-21 00:00:00', '11.00', NULL, '2023-06-21 20:15:09', NULL, NULL, 1, 1, 'REF-56EC61047968DE45'),
(13, NULL, '2023-06-22 00:00:00', '11.00', NULL, '2023-06-22 10:15:40', NULL, NULL, 1, 1, 'REF-490C80E77C79043D'),
(14, NULL, '2023-06-22 00:00:00', NULL, NULL, '2023-06-22 10:21:42', NULL, NULL, 1, NULL, 'REF-C70051F45EBA9950'),
(15, NULL, '2023-06-22 00:00:00', '1100.00', NULL, '2023-06-22 13:00:16', NULL, NULL, 1, NULL, 'REF-EFFD28A8A9DA3CFB'),
(16, NULL, '2023-06-22 00:00:00', NULL, NULL, '2023-06-22 18:52:45', NULL, NULL, 1, 1, 'REF-8C4174064689FB5C'),
(17, NULL, '2023-06-22 00:00:00', NULL, NULL, '2023-06-22 20:07:06', NULL, NULL, 1, 1, 'REF-2B75434E9D7CC4A9'),
(18, NULL, '2023-07-11 00:00:00', '100000.00', NULL, '2023-07-11 17:26:10', NULL, NULL, 2, 1, 'REF-BA2CD2F727169BDF');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `appro_magasin`
--

INSERT INTO `appro_magasin` (`id`, `approvisionnement_id`, `magasin_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 1),
(18, 18, 4);

-- --------------------------------------------------------

--
-- Structure de la table `banque`
--

DROP TABLE IF EXISTS `banque`;
CREATE TABLE IF NOT EXISTS `banque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_banque` varchar(255) NOT NULL,
  `sigle` varchar(255) NOT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B1F6CB3CEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `banque`
--

INSERT INTO `banque` (`id`, `denomination_banque`, `sigle`, `adresse`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 'nsia banque', 'NSIA', 'cotonou', NULL, '2023-05-06 08:26:38', NULL, NULL, NULL),
(2, 'banque UBA', 'UBA', 'calavi', NULL, '2023-05-06 08:27:00', NULL, NULL, NULL),
(3, 'banque bsic', 'BSIC', 'cotonou', NULL, '2023-05-06 08:27:27', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `caisse`
--

DROP TABLE IF EXISTS `caisse`;
CREATE TABLE IF NOT EXISTS `caisse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_ouverture` datetime DEFAULT NULL,
  `date_fermeture` datetime DEFAULT NULL,
  `fond_roulement` decimal(10,0) NOT NULL,
  `solde_cloture` decimal(10,2) DEFAULT NULL,
  `etat` int NOT NULL,
  `ecart` decimal(10,0) DEFAULT NULL,
  `chiffre_affaire` decimal(10,0) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `lcaisse_id` int DEFAULT NULL,
  `etat_caisse_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `depense` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B2A353C8EFA24D68` (`point_vente_id`),
  KEY `IDX_B2A353C8E9EC6699` (`lcaisse_id`),
  KEY `IDX_B2A353C8D726B853` (`etat_caisse_id`),
  KEY `IDX_B2A353C8A76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `caisse`
--

INSERT INTO `caisse` (`id`, `date_ouverture`, `date_fermeture`, `fond_roulement`, `solde_cloture`, `etat`, `ecart`, `chiffre_affaire`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `lcaisse_id`, `etat_caisse_id`, `user_id`, `depense`) VALUES
(1, '2023-05-23 10:06:21', '2023-06-05 09:03:58', '75050', NULL, 0, NULL, NULL, NULL, '2023-05-23 10:06:22', '2023-06-05 09:03:58', NULL, 1, 1, 15, 1, '0'),
(2, '2023-05-23 10:17:16', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-05-23 10:17:17', NULL, NULL, 1, 1, NULL, 1, '0'),
(3, '2023-05-23 10:50:50', NULL, '30000', NULL, 0, NULL, NULL, NULL, '2023-05-23 10:50:51', NULL, NULL, 1, 1, NULL, 1, '0'),
(4, '2023-05-23 10:56:30', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-05-23 10:56:31', NULL, NULL, 1, 1, NULL, 1, '0'),
(5, '2023-05-25 20:32:22', NULL, '10000', NULL, 0, NULL, NULL, NULL, '2023-05-25 20:32:22', NULL, NULL, 1, 1, NULL, 1, '0'),
(6, '2023-05-31 19:42:46', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-05-31 19:42:46', NULL, NULL, 1, 1, NULL, 1, '0'),
(7, '2023-06-02 11:12:32', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-06-02 11:12:33', NULL, NULL, 1, 1, NULL, 1, '0'),
(8, '2023-06-02 13:11:29', NULL, '200000', NULL, 0, NULL, NULL, NULL, '2023-06-02 13:11:30', NULL, NULL, 1, 1, NULL, 1, '0'),
(9, '2023-06-02 15:05:44', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-06-02 15:05:44', NULL, NULL, 1, 1, NULL, 1, '0'),
(10, '2023-06-02 15:58:06', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-06-02 15:58:07', NULL, NULL, 1, 1, NULL, 1, '0'),
(11, '2023-06-02 15:58:08', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-06-02 15:58:09', NULL, NULL, 1, 1, NULL, 1, '0'),
(12, '2023-06-02 16:32:59', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-06-02 16:32:59', NULL, NULL, 1, 1, NULL, 1, '0'),
(13, '2023-06-02 19:07:51', NULL, '10000', NULL, 0, NULL, NULL, NULL, '2023-06-02 19:07:52', NULL, NULL, 1, 1, NULL, 1, '0'),
(14, '2023-06-02 19:53:42', NULL, '100000', NULL, 0, NULL, NULL, NULL, '2023-06-02 19:53:43', NULL, NULL, 1, 1, NULL, 1, '0'),
(15, NULL, '2023-06-05 09:03:58', '75050', '110000.00', 1, '34945', '5', NULL, '2023-06-05 09:03:58', NULL, NULL, 1, 1, 1, NULL, '0'),
(16, '2023-06-14 11:23:41', '2023-06-14 18:43:59', '100000', NULL, 0, NULL, NULL, NULL, '2023-06-14 11:23:42', '2023-06-14 18:43:59', NULL, 1, 1, 17, 2, NULL),
(17, NULL, '2023-06-14 18:43:59', '100000', '100000.00', 1, '-100152', '152', NULL, '2023-06-14 18:43:59', NULL, NULL, 1, 1, 16, NULL, '100000'),
(18, '2023-06-14 19:24:31', '2023-06-29 09:19:01', '100000', NULL, 0, NULL, NULL, NULL, '2023-06-14 19:24:32', '2023-06-29 09:19:01', NULL, 1, 1, 19, 2, NULL),
(19, NULL, '2023-06-29 09:19:01', '100000', '510000.00', 1, '-3554218', '3967218', NULL, '2023-06-29 09:19:01', NULL, NULL, 1, 1, 18, NULL, '3000'),
(20, '2023-06-29 12:42:00', NULL, '10000', NULL, 0, NULL, NULL, NULL, '2023-06-29 12:42:01', NULL, NULL, 1, 1, NULL, 2, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C7440455EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `nom`, `prenom`, `adresse`, `email`, `telephone1`, `telephone2`, `raison_sociale`, `ifu`, `rccm`, `sigle`, `denomination`, `statut`, `date_nais`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 'BIAOU', 'Castel', 'cotonou enagnon', 'antoniettaberrettino@gmail.com', '96259895', '333333333333333', NULL, '1234567891254', NULL, NULL, NULL, 'Physique', NULL, NULL, '2023-05-09 16:21:52', NULL, NULL, NULL),
(2, 'DELLOUH', 'Deschanel', 'Calavi', 'ddellouh@gmail.com', '22996253007', NULL, NULL, NULL, NULL, NULL, NULL, 'Physique', NULL, NULL, '2023-05-12 11:42:16', NULL, NULL, 1),
(3, 'TAUPIN', 'Eric', '7 chemin du rivage', 'rosetteella2@gmail.com', '067809987', NULL, NULL, NULL, NULL, NULL, NULL, 'Physique', NULL, NULL, '2023-05-22 12:00:15', NULL, NULL, 1),
(4, NULL, NULL, 'fifadji Ste rita, von de la garderie des enfants, immeuble carrelé en jaune', 'romastechnologie@gmail.com', '90621523', NULL, 'ROYAL MAGNIFICAT SERVICE SARL', '3201501642813', '-', 'ROMAS', 'ROYAL MAGNIFICAT SERVICE SARL', 'Moral', NULL, NULL, '2023-06-02 20:23:34', NULL, NULL, 1),
(5, 'Ordinaire', '-', NULL, NULL, '99999999', NULL, NULL, NULL, NULL, NULL, NULL, 'Physique', NULL, NULL, '2023-06-14 18:47:15', NULL, NULL, 1),
(6, NULL, NULL, NULL, NULL, '22511151', NULL, 'SOCIETE MISSI MAWU SARL', '3201300937010', 'RCCM: RB/ABY/13-B19', 'SOMIMAS', 'SOCIETE MISSI MAWU SARL', 'Moral', NULL, NULL, '2023-06-15 18:27:56', NULL, NULL, 1),
(7, 'ATINDOKOU', 'marius', NULL, NULL, '98989898', NULL, NULL, '1234567891251', NULL, NULL, NULL, 'Physique', NULL, NULL, '2023-06-26 19:26:12', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `commande_client`
--

DROP TABLE IF EXISTS `commande_client`;
CREATE TABLE IF NOT EXISTS `commande_client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acheteur_id` int NOT NULL,
  `date_com` datetime NOT NULL,
  `statut` varchar(255) NOT NULL,
  `montant_ht` decimal(10,2) NOT NULL,
  `montant_ttc` decimal(10,2) NOT NULL,
  `montant_tva` decimal(10,2) NOT NULL,
  `ref_com` varchar(100) DEFAULT NULL,
  `montant_rest` decimal(10,2) DEFAULT '0.00',
  `type_commande` varchar(255) NOT NULL,
  `type_remise` varchar(255) DEFAULT NULL,
  `remise` decimal(10,2) DEFAULT NULL,
  `valeur_remise` varchar(255) DEFAULT NULL,
  `date_liv_prev` date DEFAULT NULL,
  `montant_ht_to_apr_rse` decimal(10,2) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `est_normalisee` tinyint(1) DEFAULT NULL,
  `statut_liv` varchar(255) NOT NULL,
  `montant_aib` decimal(10,2) NOT NULL,
  `taux_aib` int DEFAULT NULL,
  `motif_annulation` varchar(255) DEFAULT NULL,
  `montant_ts` decimal(10,2) NOT NULL,
  `pays_origine` varchar(255) DEFAULT NULL,
  `pays_destination` varchar(255) DEFAULT NULL,
  `lieu_chargement` varchar(255) DEFAULT NULL,
  `lieu_dechargement` varchar(255) DEFAULT NULL,
  `type_facture` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C510FF8096A7BB5F` (`acheteur_id`),
  KEY `IDX_C510FF80EFA24D68` (`point_vente_id`),
  KEY `IDX_C510FF803F192FC` (`operateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `commande_client`
--

INSERT INTO `commande_client` (`id`, `acheteur_id`, `date_com`, `statut`, `montant_ht`, `montant_ttc`, `montant_tva`, `ref_com`, `montant_rest`, `type_commande`, `type_remise`, `remise`, `valeur_remise`, `date_liv_prev`, `montant_ht_to_apr_rse`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `operateur_id`, `est_normalisee`, `statut_liv`, `montant_aib`, `taux_aib`, `motif_annulation`, `montant_ts`, `pays_origine`, `pays_destination`, `lieu_chargement`, `lieu_dechargement`, `type_facture`) VALUES
(1, 1, '2023-05-31 00:00:00', 'payer', '847.46', '1000.00', '152.54', 'CO23000001', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-05-31', '847.00', NULL, '2023-05-31 19:43:11', '2023-05-31 19:43:11', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(2, 1, '2023-06-02 00:00:00', 'payer', '847.46', '1000.00', '152.54', 'CO23000002', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '847.00', NULL, '2023-06-02 11:14:01', '2023-06-02 11:14:01', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(3, 1, '2023-06-02 00:00:00', 'payer', '847.46', '1000.00', '152.54', 'CO23000003', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '847.00', NULL, '2023-06-02 11:50:57', '2023-06-02 11:50:58', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(41, 1, '2023-06-02 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000004', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 19:54:04', '2023-06-02 19:54:04', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(42, 1, '2023-06-02 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000005', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 19:56:49', '2023-06-02 19:56:49', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(43, 1, '2023-06-02 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000006', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 19:58:45', '2023-06-02 19:58:45', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(44, 1, '2023-06-02 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000007', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 19:59:30', '2023-06-02 19:59:31', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(45, 1, '2023-06-02 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000008', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 20:01:26', '2023-06-02 20:01:26', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(46, 1, '2023-06-02 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000009', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 20:03:05', '2023-06-02 20:03:05', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(47, 1, '2023-06-02 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000010', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 20:04:36', '2023-06-02 20:04:37', NULL, 1, 1, 1, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(48, 4, '2023-06-02 00:00:00', 'Annuler', '0.85', '1.00', '0.15', 'CO23000011', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-02', '1.00', NULL, '2023-06-02 20:25:00', '2023-06-13 17:24:31', NULL, 1, 1, 1, '', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, ''),
(49, 1, '2023-06-05 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000012', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-05', '1.00', NULL, '2023-06-05 07:53:58', '2023-06-05 07:53:58', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(50, 1, '2023-06-05 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000013', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-05', '1.00', NULL, '2023-06-05 07:57:20', '2023-06-05 07:57:20', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(51, 1, '2023-06-05 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000014', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-05', '1.00', NULL, '2023-06-05 07:58:34', '2023-06-05 07:58:34', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(52, 1, '2023-06-05 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000015', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-05', '1.00', NULL, '2023-06-05 08:05:08', '2023-06-05 08:05:08', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(53, 1, '2023-06-05 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000016', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-05', '1.00', NULL, '2023-06-05 08:15:53', '2023-06-05 08:15:53', NULL, 1, 1, NULL, '', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(54, 3, '2023-06-06 00:00:00', 'payer', '333000.00', '333000.00', '0.00', 'CO23000017', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '333000.00', NULL, '2023-06-06 00:28:11', '2023-06-07 17:24:47', NULL, 1, 1, NULL, 'Partielle', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(55, 3, '2023-06-06 00:00:00', 'payer', '33000.00', '33000.00', '0.00', 'CO23000018', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '33000.00', NULL, '2023-06-06 00:30:09', '2023-06-06 00:30:09', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(56, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000019', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:18:10', '2023-06-06 10:18:10', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(57, 2, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000020', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:18:49', '2023-06-06 10:18:49', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(58, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000021', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:22:06', '2023-06-06 10:22:06', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(59, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000022', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:24:40', '2023-06-06 10:24:40', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(60, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000023', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:24:42', '2023-06-06 10:24:42', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(61, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000024', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:26:33', '2023-06-06 10:26:33', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(62, 3, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000025', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:27:37', '2023-06-06 10:27:38', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(63, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000026', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:29:18', '2023-06-06 10:29:18', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(64, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000027', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 10:30:37', '2023-06-06 10:30:37', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(65, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000028', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 11:20:00', '2023-06-06 11:20:00', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(66, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000029', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 11:22:57', '2023-06-06 11:22:57', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(67, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000030', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 14:45:25', '2023-06-06 14:45:25', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(68, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000031', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 14:49:44', '2023-06-06 14:49:44', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(69, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000032', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 14:52:22', '2023-06-06 14:52:22', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(70, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000033', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 15:36:08', '2023-06-06 15:36:08', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(71, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000034', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 15:37:19', '2023-06-06 15:37:19', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(72, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000035', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 15:39:08', '2023-06-06 15:39:08', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(73, 1, '2023-06-06 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000036', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '1.00', NULL, '2023-06-06 15:39:49', '2023-06-06 15:39:49', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(74, 2, '2023-06-06 00:00:00', 'payer', '8.50', '10.03', '1.53', 'CO23000037', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '9.00', NULL, '2023-06-06 15:49:07', '2023-06-06 15:49:07', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(75, 1, '2023-06-06 00:00:00', 'payer', '500.85', '501.00', '0.15', 'CO23000038', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-06', '501.00', NULL, '2023-06-06 17:54:11', '2023-06-06 17:54:12', NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(76, 1, '2023-06-07 00:00:00', 'Annuler', '3500.85', '3501.00', '0.15', 'CO23000039', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-07', '3501.00', NULL, '2023-06-07 14:10:03', '2023-06-13 16:13:43', NULL, 1, 1, NULL, 'Terminée', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, ''),
(77, 1, '2023-06-14 00:00:00', 'En attente', '85.00', '100.30', '15.30', 'CO23000040', NULL, 'Au comptoire', NULL, NULL, NULL, '2023-06-14', '85.00', NULL, '2023-06-14 10:01:35', NULL, NULL, 1, 1, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(78, 1, '2023-06-14 00:00:00', 'payer', '8.50', '10.03', '1.53', 'CO23000041', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:24:49', '2023-06-14 11:24:50', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(79, 1, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000042', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 11:27:20', '2023-06-14 11:27:20', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(80, 2, '2023-06-14 00:00:00', 'En attente', '0.85', '1.00', '0.15', 'CO23000043', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 11:32:24', NULL, NULL, 1, 2, NULL, '-', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(81, 2, '2023-06-14 00:00:00', 'En attente', '9.35', '11.03', '1.68', 'CO23000044', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:34:03', NULL, NULL, 1, 2, NULL, '-', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(82, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000045', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:35:09', '2023-06-14 11:35:09', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(83, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000046', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:35:48', '2023-06-14 11:35:48', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(84, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000047', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:36:41', '2023-06-14 11:36:41', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(85, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000048', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:36:54', '2023-06-14 11:36:55', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(86, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000049', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:37:22', '2023-06-14 11:37:22', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(87, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000050', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:37:42', '2023-06-14 11:37:42', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(88, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000051', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:38:29', '2023-06-14 11:38:30', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(89, 2, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000052', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:39:38', '2023-06-14 11:39:39', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(90, 4, '2023-06-14 00:00:00', 'Annuler', '1.00', '1.00', '0.00', 'CO23000053', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 11:52:09', '2023-06-14 12:11:13', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, 'ERREUR DE PRIX', '0.00', NULL, NULL, NULL, NULL, ''),
(91, 1, '2023-06-14 00:00:00', 'Annuler', '8.50', '10.03', '1.53', 'CO23000054', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 11:53:38', '2023-06-14 13:59:33', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, ''),
(92, 1, '2023-06-14 00:00:00', 'payer', '8.50', '10.03', '1.53', 'CO23000055', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 12:04:27', '2023-06-14 12:04:28', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(95, 1, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000056', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 13:42:56', '2023-06-14 13:42:59', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(96, 2, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000057', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 14:06:34', '2023-06-14 14:06:35', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(97, 2, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000058', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 14:22:39', '2023-06-14 14:22:40', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(98, 2, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000059', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 14:59:43', '2023-06-14 14:59:46', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(99, 3, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000060', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 15:04:12', '2023-06-14 15:04:13', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(100, 1, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000061', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 15:08:34', '2023-06-14 15:08:36', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(101, 4, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000062', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 15:28:03', '2023-06-14 15:28:04', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(102, 1, '2023-06-14 00:00:00', 'payer', '9.35', '11.03', '1.68', 'CO23000063', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '9.00', NULL, '2023-06-14 15:29:19', '2023-06-14 15:29:20', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(103, 1, '2023-06-14 00:00:00', 'payer', '0.85', '1.01', '0.15', 'CO23000064', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', NULL, '2023-06-14 17:07:41', '2023-06-14 17:07:42', NULL, 1, 2, 1, 'Non livrée', '0.00', 1, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(104, 1, '2023-06-14 00:00:00', 'Annuler', '0.85', '1.01', '0.15', 'CO23000065', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '1.00', 1, '2023-06-14 17:12:43', '2023-06-29 16:22:41', '2023-06-29 16:22:38', 1, 2, 1, 'Non livrée', '0.01', 1, 'test', '0.00', NULL, NULL, NULL, NULL, ''),
(105, 5, '2023-06-14 00:00:00', 'payer', '0.85', '1.00', '0.15', 'CO23000066', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '0.85', NULL, '2023-06-14 19:26:03', '2023-06-14 19:26:05', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(106, 5, '2023-06-14 00:00:00', 'payer', '2600.00', '2600.00', '0.00', 'CO23000067', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '2600.00', NULL, '2023-06-14 20:25:13', '2023-06-14 20:25:14', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(107, 5, '2023-06-14 00:00:00', 'payer', '2132.00', '2132.00', '0.00', 'CO23000068', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '2132.00', NULL, '2023-06-14 20:43:18', '2023-06-14 20:43:21', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(108, 5, '2023-06-14 00:00:00', 'payer', '2600.00', '2600.00', '0.00', 'CO23000069', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '2600.00', NULL, '2023-06-14 20:46:42', '2023-06-14 20:46:43', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(109, 5, '2023-06-14 00:00:00', 'payer', '2600.00', '2600.00', '0.00', 'CO23000070', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-14', '2600.00', NULL, '2023-06-14 21:33:04', '2023-06-14 21:33:04', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(110, 5, '2023-06-15 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000071', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-15', '10000.00', NULL, '2023-06-15 11:49:26', '2023-06-15 11:49:27', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(111, 5, '2023-06-15 00:00:00', 'payer', '35200.00', '40600.00', '5400.00', 'CO23000072', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-15', '35200.00', NULL, '2023-06-15 16:05:53', '2023-06-15 16:05:54', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(112, 5, '2023-06-15 00:00:00', 'payer', '39000.00', '44850.00', '5850.00', 'CO23000073', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-15', '39000.00', NULL, '2023-06-15 17:53:52', '2023-06-15 17:53:53', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(113, 5, '2023-06-15 00:00:00', 'payer', '39000.00', '44850.00', '5850.00', 'CO23000074', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-15', '39000.00', NULL, '2023-06-15 18:03:29', '2023-06-15 18:03:30', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(114, 6, '2023-06-15 00:00:00', 'Annuler', '35200.00', '40600.00', '5400.00', 'CO23000075', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-15', '35200.00', NULL, '2023-06-15 18:30:16', '2023-06-15 18:34:02', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, 'CAS DE TEST 6', '0.00', NULL, NULL, NULL, NULL, ''),
(115, 6, '2023-06-15 00:00:00', 'Annuler', '30000.00', '35998.00', '5400.00', 'CO23000076', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-15', '30000.00', 1, '2023-06-15 20:05:46', '2023-06-29 16:23:46', '2023-06-29 16:23:42', 1, 2, 1, 'Non livrée', '0.00', NULL, 'tato', '598.00', NULL, NULL, NULL, NULL, ''),
(116, 6, '2023-06-16 00:00:00', 'payer', '30000.00', '35998.00', '5400.00', 'CO23000077', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '30000.00', NULL, '2023-06-16 13:25:07', '2023-06-16 13:25:08', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '598.00', NULL, NULL, NULL, NULL, ''),
(117, 6, '2023-06-16 00:00:00', 'payer', '30000.00', '35998.00', '5400.00', 'CO23000078', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '30000.00', NULL, '2023-06-16 13:27:04', '2023-06-16 13:27:04', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '598.00', NULL, NULL, NULL, NULL, ''),
(118, 6, '2023-06-16 00:00:00', 'payer', '35200.00', '42360.00', '5400.00', 'CO23000079', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '35200.00', NULL, '2023-06-16 15:59:27', '2023-06-16 15:59:28', NULL, 1, 2, 1, 'Non livrée', '1760.00', 5, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(119, 6, '2023-06-16 00:00:00', 'payer', '35200.00', '40952.00', '5400.00', 'CO23000080', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '35200.00', NULL, '2023-06-16 16:02:09', '2023-06-16 16:02:10', NULL, 1, 2, 1, 'Non livrée', '352.00', 1, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(120, 6, '2023-06-16 00:00:00', 'payer', '35200.00', '42958.00', '5400.00', 'CO23000081', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '35200.00', NULL, '2023-06-16 16:08:26', '2023-06-16 16:08:28', NULL, 1, 2, 1, 'Non livrée', '1760.00', 5, NULL, '598.00', NULL, NULL, NULL, NULL, ''),
(121, 6, '2023-06-16 00:00:00', 'payer', '35200.00', '42983.34', '5400.00', 'CO23000082', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '35706.78', NULL, '2023-06-16 16:22:49', '2023-06-16 16:22:50', NULL, 1, 2, 1, 'Non livrée', '1785.34', 5, NULL, '598.00', NULL, NULL, NULL, NULL, ''),
(122, 6, '2023-06-16 00:00:00', 'payer', '25000.00', '28600.00', '3600.00', 'CO23000083', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '25000.00', NULL, '2023-06-16 18:00:26', '2023-06-16 18:00:27', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(123, 6, '2023-06-16 00:00:00', 'payer', '191000.00', '225380.00', '34380.00', 'CO23000084', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '191000.00', NULL, '2023-06-16 18:47:42', '2023-06-16 18:47:43', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(124, 6, '2023-06-16 00:00:00', 'payer', '191000.00', '225979.00', '34380.00', 'CO23000085', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '191507.63', NULL, '2023-06-16 19:04:30', '2023-06-16 19:04:31', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '599.00', NULL, NULL, NULL, NULL, ''),
(125, 5, '2023-06-16 00:00:00', 'payer', '191000.00', '191000.00', '0.00', 'CO23000086', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '191000.00', NULL, '2023-06-16 19:13:37', '2023-06-16 19:13:38', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(126, 5, '2023-06-16 00:00:00', 'payer', '191000.00', '191600.00', '0.00', 'CO23000087', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '191508.47', NULL, '2023-06-16 19:19:48', '2023-06-16 19:19:48', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '600.00', NULL, NULL, NULL, NULL, 'EV'),
(127, 5, '2023-06-16 00:00:00', 'payer', '191000.00', '191600.00', '0.00', 'CO23000088', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-16', '191508.47', NULL, '2023-06-16 19:41:46', '2023-06-16 19:41:47', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '600.00', NULL, NULL, NULL, NULL, ''),
(128, 5, '2023-06-20 00:00:00', 'payer', '10000.00', '10000.00', '0.00', 'CO23000089', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-20', '10000.00', NULL, '2023-06-20 13:19:18', '2023-06-20 13:19:20', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', 'BENIN [ BJ ] ', 'TOGO [ TG ] ', 'COTONOU', 'LOME', ''),
(129, 5, '2023-06-20 00:00:00', 'payer', '10000.00', '10000.00', '0.00', 'CO23000090', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-20', '10000.00', NULL, '2023-06-20 15:54:44', '2023-06-20 15:54:44', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(130, 5, '2023-06-20 00:00:00', 'payer', '10000.00', '10000.00', '0.00', 'CO23000091', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-20', '10000.00', NULL, '2023-06-20 15:56:19', '2023-06-20 15:56:20', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'EV'),
(131, 5, '2023-06-20 00:00:00', 'payer', '10000.00', '10000.00', '0.00', 'CO23000092', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-20', '10000.00', NULL, '2023-06-20 18:37:23', '2023-06-20 18:37:25', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', 'BENIN [ BJ ] ', 'TOGO [ TG ] ', 'fifadji', 'seto', 'EV'),
(132, 6, '2023-06-20 00:00:00', 'payer', '20200.00', '20200.00', '0.00', 'CO23000093', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-20', '20200.00', NULL, '2023-06-20 19:38:05', '2023-06-20 19:38:06', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', 'BENIN [ BJ ] ', 'TOGO [ TG ] ', 'COTONOU', 'LOME', 'EV'),
(133, 4, '2023-06-20 00:00:00', 'Annuler', '10000.00', '10000.00', '0.00', 'CO23000094', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-20', '10000.00', NULL, '2023-06-20 19:47:26', '2023-06-20 20:07:48', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, 'test', '0.00', 'BENIN [ BJ ] ', 'TOGO [ TG ] ', 'COTONOU', 'LOME', 'EV'),
(134, 4, '2023-06-20 00:00:00', 'Annuler', '191000.00', '191000.00', '0.00', 'CO23000095', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-20', '191000.00', NULL, '2023-06-20 20:20:06', '2023-06-20 20:22:51', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, 'TEST', '0.00', 'BENIN [ BJ ] ', 'TOGO [ TG ] ', 'COTONOU', 'LOME', 'EV'),
(135, 5, '2023-06-21 00:00:00', 'Annuler', '5084.75', '6000.00', '915.25', 'CO23000096', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-21', '5084.75', 1, '2023-06-21 13:03:54', '2023-06-29 16:16:32', '2023-06-29 16:16:32', 1, 2, NULL, 'Non livrée', '0.00', NULL, 'vgh', '0.00', NULL, NULL, NULL, NULL, ''),
(136, 5, '2023-06-21 00:00:00', 'Annuler', '5084.75', '6000.00', '915.25', 'CO23000097', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-21', '5084.75', 1, '2023-06-21 13:04:44', '2023-06-29 16:20:25', '2023-06-29 16:20:21', 1, 2, 1, 'Non livrée', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, ''),
(137, 1, '2023-06-21 00:00:00', 'payer', '5084.75', '6000.01', '915.25', 'CO23000098', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-21', '5084.75', NULL, '2023-06-21 13:07:18', '2023-06-21 13:07:19', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, ''),
(138, 5, '2023-06-21 00:00:00', 'Annuler', '200000.00', '236000.00', '36000.00', 'CO23000099', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-21', '200000.00', NULL, '2023-06-21 13:09:34', '2023-06-21 14:12:49', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, 'RAS', '0.00', NULL, NULL, NULL, NULL, ''),
(139, 5, '2023-06-21 00:00:00', 'Annuler', '95500.00', '95500.00', '0.00', 'CO23000100', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-21', '95500.00', NULL, '2023-06-21 13:12:41', '2023-06-21 14:10:46', NULL, 1, 2, NULL, 'Non livrée', '0.00', NULL, 'REFUS', '0.00', NULL, NULL, NULL, NULL, ''),
(140, 5, '2023-06-22 00:00:00', 'Annuler', '30000.00', '35980.00', '5400.00', 'CO23000101', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-22', '30491.53', 1, '2023-06-22 18:54:17', '2023-06-29 16:12:29', '2023-06-29 16:12:27', 1, 2, 1, 'Non livrée', '0.00', NULL, 'test', '580.00', NULL, NULL, NULL, NULL, 'FV'),
(141, 5, '2023-06-22 00:00:00', 'payer', '30000.00', '35998.00', '5400.00', 'CO23000102', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-22', '30506.78', NULL, '2023-06-22 18:55:42', '2023-06-22 18:55:43', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '598.00', NULL, NULL, NULL, NULL, 'FV'),
(142, 5, '2023-06-23 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000103', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-23', '10000.00', NULL, '2023-06-23 16:08:48', '2023-06-23 16:08:49', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(143, 5, '2023-06-23 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000104', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-23', '10000.00', NULL, '2023-06-23 16:23:43', '2023-06-23 16:23:44', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(144, 5, '2023-06-23 00:00:00', 'Annuler', '100000.00', '118000.00', '18000.00', 'CO23000105', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-23', '100000.00', NULL, '2023-06-23 18:24:07', '2023-06-23 18:38:44', NULL, 1, 2, 1, 'Partielle', '0.00', NULL, 'ERREUR DE QUANTITE', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(145, 5, '2023-06-26 00:00:00', 'Annuler', '20000.00', '23600.00', '3600.00', 'CO23000106', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-26', '20000.00', NULL, '2023-06-26 16:51:54', '2023-06-26 16:52:37', NULL, 1, 2, 1, 'Non livrée', '0.00', NULL, 'ANNUATION', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(146, 5, '2023-06-26 00:00:00', 'Annuler', '150000.00', '177000.00', '27000.00', 'CO23000107', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-26', '150000.00', 1, '2023-06-26 17:05:22', '2023-06-26 17:57:02', '2023-06-26 17:57:01', 1, 2, 1, 'Partielle', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(147, 5, '2023-06-26 00:00:00', 'Annuler', '10000.00', '11800.00', '1800.00', 'CO23000108', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-26', '10000.00', 1, '2023-06-26 18:12:59', '2023-06-26 18:29:26', '2023-06-26 18:29:25', 1, 2, 1, 'Non livrée', '0.00', NULL, 'test', '0.00', 'BENIN [ BJ ] ', 'TOGO [ TG ] ', 'cotonou', 'lome', 'EV'),
(148, 5, '2023-06-26 00:00:00', 'Annuler', '10000.00', '11800.00', '1800.00', 'CO23000109', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-26', '10000.00', 1, '2023-06-26 18:33:13', '2023-06-26 18:33:52', '2023-06-26 18:33:51', 1, 2, 1, 'Non livrée', '0.00', NULL, 'TEST', '0.00', 'BENIN [ BJ ] ', 'TOGO [ TG ] ', 'calavi', 'kpodji', 'EV'),
(149, 5, '2023-06-26 00:00:00', 'Annuler', '10000.00', '11800.00', '1800.00', 'CO23000110', NULL, 'Sur Commande', NULL, NULL, NULL, '2023-06-26', '10000.00', 1, '2023-06-26 20:42:02', '2023-06-29 15:55:18', '2023-06-29 15:55:14', 1, 2, 1, 'Non livrée', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(150, 5, '2023-06-26 00:00:00', 'Annuler', '10000.00', '11800.00', '1800.00', 'CO23000111', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-26', '10000.00', 1, '2023-06-26 20:55:08', '2023-06-26 20:55:28', '2023-06-26 20:55:27', 1, 2, 1, 'Non livrée', '0.00', NULL, 'tete', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(151, 5, '2023-06-26 00:00:00', 'Annuler', '1055000.00', '1244900.00', '189900.00', 'CO23000112', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-26', '1055000.00', 1, '2023-06-26 20:56:27', '2023-06-26 20:58:17', '2023-06-26 20:58:16', 1, 2, 1, 'Terminée', '0.00', NULL, 'ddd', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(152, 5, '2023-06-26 00:00:00', 'Annuler', '100000.00', '118000.00', '18000.00', 'CO23000113', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-06-26', '100000.00', 1, '2023-06-26 21:01:19', '2023-06-29 16:07:35', '2023-06-29 16:07:34', 1, 2, 1, 'Terminée', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(153, 5, '2023-07-04 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000114', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-04', '10000.00', NULL, '2023-07-04 10:06:46', '2023-07-04 10:06:49', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(154, 5, '2023-07-04 00:00:00', 'payer', '12600.00', '14400.00', '1800.00', 'CO23000115', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-04', '12600.00', NULL, '2023-07-04 11:40:05', '2023-07-04 11:40:06', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(155, 5, '2023-07-05 00:00:00', 'payer', '12600.00', '14400.00', '1800.00', 'CO23000116', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-05', '12600.00', NULL, '2023-07-05 09:51:48', '2023-07-05 09:51:52', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(157, 5, '2023-07-05 00:00:00', 'payer', '15084.75', '17800.00', '2715.25', 'CO23000117', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-05', '15084.75', NULL, '2023-07-05 10:18:24', '2023-07-05 10:18:26', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(158, 5, '2023-07-05 00:00:00', 'payer', '13000.00', '14800.00', '1800.00', 'CO23000118', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-05', '13000.00', NULL, '2023-07-05 11:56:03', '2023-07-05 11:56:07', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(159, 1, '2023-07-06 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000119', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-06', '10000.00', NULL, '2023-07-06 18:32:22', '2023-07-06 18:32:24', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'EV'),
(160, 1, '2023-07-06 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000120', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-06', '10000.00', NULL, '2023-07-06 18:34:23', '2023-07-06 18:34:24', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(161, 5, '2023-07-06 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000121', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-06', '10000.00', NULL, '2023-07-06 18:41:52', '2023-07-06 18:41:53', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(162, 5, '2023-07-06 00:00:00', 'payer', '10000.00', '11800.00', '1800.00', 'CO23000122', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-06', '10000.00', NULL, '2023-07-06 18:58:25', '2023-07-06 18:58:27', NULL, NULL, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(163, 5, '2023-07-06 00:00:00', 'payer', '110000.00', '129800.00', '19800.00', 'CO23000123', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-06', '110000.00', NULL, '2023-07-06 19:05:35', '2023-07-06 19:05:36', NULL, 2, 2, 1, 'Non livrée', '0.00', NULL, NULL, '0.00', NULL, NULL, NULL, NULL, 'FV'),
(164, 5, '2023-07-11 00:00:00', 'Annuler', '100.00', '100.00', '0.00', 'CO23000124', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-11', '100.00', 1, '2023-07-11 17:36:34', '2023-07-11 17:55:38', '2023-07-11 17:55:37', 2, 2, 1, 'Terminée', '0.00', NULL, 'test', '0.00', NULL, NULL, NULL, NULL, 'FV'),
(165, 1, '2023-07-11 00:00:00', 'Annuler', '100.00', '100.00', '0.00', 'CO23000125', NULL, 'Au comptoir', NULL, NULL, NULL, '2023-07-11', '100.00', 1, '2023-07-11 18:06:24', '2023-07-11 18:18:05', '2023-07-11 18:18:04', 2, 2, 1, 'Terminée', '0.00', NULL, 'yudv', '0.00', NULL, NULL, NULL, NULL, 'FV');

-- --------------------------------------------------------

--
-- Structure de la table `commande_frs`
--

DROP TABLE IF EXISTS `commande_frs`;
CREATE TABLE IF NOT EXISTS `commande_frs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fournisseur_id` int DEFAULT NULL,
  `demande_de_prix_id` int DEFAULT NULL,
  `date_com_frs` datetime NOT NULL,
  `montant_total` decimal(10,2) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_604E4222670C757F` (`fournisseur_id`),
  KEY `IDX_604E42225E931ED0` (`demande_de_prix_id`),
  KEY `IDX_604E4222EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `commande_frs`
--

INSERT INTO `commande_frs` (`id`, `fournisseur_id`, `demande_de_prix_id`, `date_com_frs`, `montant_total`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 1, NULL, '2023-05-17 00:00:00', '1050000.00', NULL, '2023-05-17 09:38:12', NULL, NULL, 1),
(6, 1, 6, '2023-06-08 00:00:00', '1000.00', NULL, '2023-06-08 16:14:43', NULL, NULL, 1),
(7, 1, 6, '2023-06-08 00:00:00', '1000.00', NULL, '2023-06-08 16:23:04', NULL, NULL, 1),
(8, 1, 6, '2023-06-08 00:00:00', '1000.00', NULL, '2023-06-08 16:24:52', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

DROP TABLE IF EXISTS `compte`;
CREATE TABLE IF NOT EXISTS `compte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `fournisseur_id` int DEFAULT NULL,
  `intitule` varchar(255) NOT NULL,
  `solde` decimal(10,2) NOT NULL,
  `solde_initial` decimal(10,0) NOT NULL DEFAULT '0',
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CFF6526019EB6921` (`client_id`),
  KEY `IDX_CFF65260670C757F` (`fournisseur_id`),
  KEY `IDX_CFF65260EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `compte`
--

INSERT INTO `compte` (`id`, `client_id`, `fournisseur_id`, `intitule`, `solde`, `solde_initial`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 2, NULL, 'tezs', '6000.00', '1000', NULL, '2023-05-22 12:02:54', '2023-05-22 12:03:13', NULL, NULL),
(2, 3, NULL, 'rrr', '1000.00', '1000', NULL, '2023-05-22 14:21:24', NULL, NULL, NULL),
(3, 1, NULL, 'test', '0.00', '0', NULL, '2023-06-08 11:19:30', NULL, NULL, NULL),
(4, 4, NULL, 'ROMAS', '20000.00', '20000', NULL, '2023-06-21 14:21:24', NULL, NULL, NULL),
(5, 7, NULL, 'dhgvdhgv', '1.00', '1', NULL, '2023-06-26 19:27:46', NULL, NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `compte_banque`
--

INSERT INTO `compte_banque` (`id`, `societe_id`, `banque_id`, `numero_compte_bq`, `solde_compte_bq`, `est_sup`) VALUES
(1, 1, 1, '1111111111', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `conditionnement`
--

DROP TABLE IF EXISTS `conditionnement`;
CREATE TABLE IF NOT EXISTS `conditionnement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code_cond` varchar(255) NOT NULL,
  `libelle_cond` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3F4BEA3AEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `conditionnement`
--

INSERT INTO `conditionnement` (`id`, `code_cond`, `libelle_cond`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 'UNI', 'UNITE', NULL, '2023-05-04 16:27:31', NULL, NULL, NULL),
(2, 'TON', 'TONNE', NULL, '2023-05-04 16:27:49', NULL, NULL, NULL),
(3, 'CAR', 'CARTON', NULL, '2023-05-04 16:28:04', NULL, NULL, NULL),
(4, 'M2', 'METRE CARRE', NULL, '2023-05-16 14:24:30', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE IF NOT EXISTS `configuration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `format_impression` varchar(255) DEFAULT NULL,
  `est_mode_carreau` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `impression_personnalise_elements` tinyint(1) DEFAULT NULL,
  `impression_sans_entete` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `configuration`
--

INSERT INTO `configuration` (`id`, `format_impression`, `est_mode_carreau`, `created_at`, `updated_at`, `deleted_at`, `impression_personnalise_elements`, `impression_sans_entete`) VALUES
(1, 'A4', 1, '2023-07-06 14:28:11', NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `demande_de_prix`
--

DROP TABLE IF EXISTS `demande_de_prix`;
CREATE TABLE IF NOT EXISTS `demande_de_prix` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fournisseur_id` int NOT NULL,
  `date_ddp` datetime NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `est_transformer` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E6B3FF96670C757F` (`fournisseur_id`),
  KEY `IDX_E6B3FF96EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `demande_de_prix`
--

INSERT INTO `demande_de_prix` (`id`, `fournisseur_id`, `date_ddp`, `montant_total`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `est_transformer`) VALUES
(1, 1, '2023-05-17 00:00:00', NULL, NULL, '2023-05-17 09:53:43', NULL, NULL, 1, NULL),
(2, 1, '2023-05-25 00:00:00', NULL, NULL, '2023-05-25 10:49:49', NULL, NULL, 2, NULL),
(4, 1, '2023-05-26 00:00:00', NULL, NULL, '2023-06-01 10:21:45', '2023-06-01 10:21:45', NULL, 1, NULL),
(5, 1, '2023-05-31 00:00:00', NULL, NULL, '2023-05-31 19:47:08', NULL, NULL, 1, NULL),
(6, 1, '2023-06-08 00:00:00', NULL, NULL, '2023-06-08 11:21:09', '2023-06-08 16:24:52', NULL, 1, 1);

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
  `montant` decimal(10,0) NOT NULL,
  `beneficiere` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3405975727B4FEBF` (`caisse_id`),
  KEY `IDX_34059757A76ED395` (`user_id`),
  KEY `IDX_34059757EFA24D68` (`point_vente_id`),
  KEY `IDX_340597575CDBC346` (`type_depense_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `depense`
--

INSERT INTO `depense` (`id`, `caisse_id`, `user_id`, `point_vente_id`, `type_depense_id`, `motif`, `montant`, `beneficiere`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 18, NULL, 1, 1, 'TEST', '2000', 'AUGUSTIN', NULL, NULL, NULL, NULL),
(2, 18, NULL, 1, 1, 'test', '1000', 'test', NULL, NULL, NULL, NULL),
(3, 20, NULL, 1, 1, 'Déplacements', '5000', 'Disnel', NULL, '2023-06-29 21:22:55', '2023-06-29 21:22:55', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230620082435', '2023-06-20 09:25:20', 235),
('DoctrineMigrations\\Version20230620123835', '2023-06-20 13:40:32', 457),
('DoctrineMigrations\\Version20230629120429', '2023-06-29 13:05:06', 1021),
('DoctrineMigrations\\Version20230629131924', '2023-06-29 14:19:57', 883),
('DoctrineMigrations\\Version20230630103843', '2023-06-30 11:39:16', 945),
('DoctrineMigrations\\Version20230704100332', '2023-07-04 11:04:27', 1281),
('DoctrineMigrations\\Version20230704100633', '2023-07-04 11:06:39', 181),
('DoctrineMigrations\\Version20230705111835', '2023-07-05 12:18:47', 4217),
('DoctrineMigrations\\Version20230705113142', '2023-07-05 12:31:53', 3928),
('DoctrineMigrations\\Version20230705114626', '2023-07-05 12:46:34', 3941),
('DoctrineMigrations\\Version20230705114938', '2023-07-05 12:49:56', 2896),
('DoctrineMigrations\\Version20230705123234', '2023-07-05 13:32:44', 222),
('DoctrineMigrations\\Version20230705123706', '2023-07-05 13:37:15', 204),
('DoctrineMigrations\\Version20230705142113', '2023-07-05 15:21:25', 259),
('DoctrineMigrations\\Version20230706143339', '2023-07-06 15:33:50', 1271);

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `element_supplementaire`
--

INSERT INTO `element_supplementaire` (`id`, `commande_client_id`, `titre`, `description`, `taille_police`, `position`) VALUES
(1, 153, 'Objets', 'Une description', '12', 'GAUCHE'),
(2, 154, 'Objet', 'test test', '12', 'GAUCHE'),
(3, 154, 'Contrat', 'dsdsdsqd dgfgfd', '12', 'GAUCHE'),
(4, 154, 'Bonde commande', 'test test test', '12', 'GAUCHE'),
(5, 155, 'Objet', 'marché de commande de produit vivrier', '12', 'GAUCHE'),
(6, 155, 'Contrat', 'contrat de marché externe du ministère de l\'industrie et du commerce', '12', 'GAUCHE'),
(7, 157, 'FACTURE N° 0047/SIZS/DG/SA/2023', NULL, '16', 'CENTER'),
(8, 157, 'CONTRAT DE MARCHE N°4161/MEF/MDN/SG/PRMP/DCMP/DNCMP/SP DU 08/12/2022', NULL, '12', 'GAUCHE'),
(9, 157, 'REFERENCE :', 'DECOMPTE N°2 100%-80.04%= 19.96%', '12', 'GAUCHE'),
(10, 157, 'OBJET :', 'TRAVAUX DIVERS DE REHABILITATION ET CONSTRUCTION D\'INFRSTRUCTURES AU PROTIT DU 2IEME  BIA ET DU 6EME BIA', '12', 'GAUCHE'),
(11, 157, 'CLIENT :', 'MINISTERE DE LA DEFENSE NATIONALE (MDN)', '12', 'GAUCHE'),
(12, 158, 'FACTURE N° 0047/SIZS/DG/SA/2023', NULL, '17', 'CENTER'),
(13, 158, NULL, NULL, '12', 'CENTER'),
(14, 158, 'CONTRAT DE MARCHE N°4161/MEF/MDN/SG/PRMP/DCMP/DNCMP/SP DU 08/12/2022', NULL, '12', 'GAUCHE'),
(15, 158, 'REFERENCE :', 'DECOMPTE N°2 100%-80.04%= 19.96%', '12', 'GAUCHE'),
(16, 158, 'OBJET :', 'TRAVAUX DIVERS DE REHABILITATION ET CONSTRUCTION D\'INFRSTRUCTURES AU PROTIT DU 2IEME  BIA ET DU 6EME BIA', '12', 'GAUCHE'),
(17, 158, 'CLIENT :', 'MINISTERE DE LA DEFENSE NATIONALE (MDN', '12', 'GAUCHE');

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

DROP TABLE IF EXISTS `facture`;
CREATE TABLE IF NOT EXISTS `facture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_cli_id` int DEFAULT NULL,
  `date_fac` datetime NOT NULL,
  `montant_total` decimal(10,2) NOT NULL,
  `ref_fac` varchar(100) NOT NULL,
  `statut` varchar(100) NOT NULL,
  `montant_total_cmd` decimal(10,0) DEFAULT NULL,
  `montant_rest` decimal(10,0) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `mecef_date` varchar(255) DEFAULT NULL,
  `mecef_qr_code` varchar(255) DEFAULT NULL,
  `mecef_code` varchar(255) DEFAULT NULL,
  `mecef_compteur` varchar(255) DEFAULT NULL,
  `mecef_nim` varchar(255) DEFAULT NULL,
  `est_normalisee` tinyint(1) DEFAULT NULL,
  `type_facture` varchar(255) NOT NULL DEFAULT 'FV',
  PRIMARY KEY (`id`),
  KEY `IDX_FE866410BE1A1965` (`commande_cli_id`),
  KEY `IDX_FE866410EFA24D68` (`point_vente_id`),
  KEY `IDX_FE8664103F192FC` (`operateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `facture`
--

INSERT INTO `facture` (`id`, `commande_cli_id`, `date_fac`, `montant_total`, `ref_fac`, `statut`, `montant_total_cmd`, `montant_rest`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `operateur_id`, `mecef_date`, `mecef_qr_code`, `mecef_code`, `mecef_compteur`, `mecef_nim`, `est_normalisee`, `type_facture`) VALUES
(1, 1, '2023-05-12 18:21:33', '1180.00', 'FA23000001', 'payer', NULL, NULL, NULL, '2023-05-12 18:21:33', '2023-05-12 18:21:33', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(2, 2, '2023-05-25 20:33:44', '16000.00', 'FA23000002', 'payer', NULL, NULL, NULL, '2023-05-25 20:33:44', '2023-05-25 20:33:45', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(3, 3, '2023-05-25 20:35:45', '1000.00', 'FA23000003', 'payer', NULL, NULL, NULL, '2023-05-25 20:35:45', '2023-05-25 20:35:46', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(4, 1, '2023-05-31 19:43:11', '1000.00', 'FA23000004', 'payer', NULL, NULL, NULL, '2023-05-31 19:43:11', '2023-05-31 19:43:11', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(5, 2, '2023-06-02 11:14:01', '1000.00', 'FA23000005', 'payer', NULL, NULL, NULL, '2023-06-02 11:14:01', '2023-06-02 11:14:01', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(6, 3, '2023-06-02 11:50:57', '1000.00', 'FA23000006', 'payer', NULL, NULL, NULL, '2023-06-02 11:50:57', '2023-06-02 11:50:58', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(7, 41, '2023-06-02 19:54:04', '1.00', 'FA23000007', 'payer', NULL, NULL, NULL, '2023-06-02 19:54:04', '2023-06-02 19:54:04', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(8, 42, '2023-06-02 19:56:49', '1.00', 'FA23000008', 'payer', NULL, NULL, NULL, '2023-06-02 19:56:49', '2023-06-02 19:56:49', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(9, 43, '2023-06-02 19:58:45', '1.00', 'FA23000009', 'payer', NULL, NULL, NULL, '2023-06-02 19:58:45', '2023-06-02 19:58:45', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(10, 44, '2023-06-02 19:59:30', '1.00', 'FA23000010', 'payer', NULL, NULL, NULL, '2023-06-02 19:59:30', '2023-06-02 19:59:31', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(11, 45, '2023-06-02 20:01:26', '1.00', 'FA23000011', 'payer', NULL, NULL, NULL, '2023-06-02 20:01:26', '2023-06-02 20:01:26', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(12, 46, '2023-06-02 20:03:05', '1.00', 'FA23000012', 'payer', NULL, NULL, NULL, '2023-06-02 20:03:05', '2023-06-02 20:03:05', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(13, 47, '2023-06-02 20:04:36', '1.00', 'FA23000013', 'payer', NULL, NULL, NULL, '2023-06-02 20:04:36', '2023-06-02 20:04:37', NULL, 1, 1, '02/06/2023 21:04:38', 'F;EM01192039;JTDVFP3VDX2273OGFDQ4WDAJ;0202112753715;20230602210438', 'JTDV-FP3V-DX22-73OG-FDQ4-WDAJ', '8/9 FV', 'EM01192039', 1, 'FV'),
(14, 48, '2023-06-02 20:25:00', '1.00', 'FA23000014', 'payer', NULL, NULL, NULL, '2023-06-02 20:25:00', '2023-06-02 20:25:01', NULL, 1, 1, '02/06/2023 21:25:01', 'F;EM01192039;5NEMTIP26TFEPU6MHAMZAUDO;0202112753715;20230602212501', '5NEM-TIP2-6TFE-PU6M-HAMZ-AUDO', '9/10 FV', 'EM01192039', 1, 'FV'),
(15, 49, '2023-06-05 07:53:58', '1.00', 'FA23000015', 'payer', NULL, NULL, NULL, '2023-06-05 07:53:58', '2023-06-05 07:53:58', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(16, 50, '2023-06-05 07:57:20', '1.00', 'FA23000016', 'payer', NULL, NULL, NULL, '2023-06-05 07:57:20', '2023-06-05 07:57:20', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(17, 51, '2023-06-05 07:58:34', '1.00', 'FA23000017', 'payer', NULL, NULL, NULL, '2023-06-05 07:58:34', '2023-06-05 07:58:34', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(18, 52, '2023-06-05 08:05:08', '1.00', 'FA23000018', 'payer', NULL, NULL, NULL, '2023-06-05 08:05:08', '2023-06-05 08:05:08', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(19, 53, '2023-06-05 08:15:53', '1.00', 'FA23000019', 'payer', NULL, NULL, NULL, '2023-06-05 08:15:53', '2023-06-05 08:15:53', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(20, 54, '2023-06-06 00:28:11', '333000.00', 'FA23000020', 'payer', NULL, NULL, NULL, '2023-06-06 00:28:11', '2023-06-06 00:28:11', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(21, 55, '2023-06-06 00:30:08', '33000.00', 'FA23000021', 'payer', NULL, NULL, NULL, '2023-06-06 00:30:08', '2023-06-06 00:30:09', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(22, 56, '2023-06-06 10:18:10', '1.00', 'FA23000022', 'payer', NULL, NULL, NULL, '2023-06-06 10:18:10', '2023-06-06 10:18:10', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(23, 57, '2023-06-06 10:18:49', '1.00', 'FA23000023', 'payer', NULL, NULL, NULL, '2023-06-06 10:18:49', '2023-06-06 10:18:49', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(24, 58, '2023-06-06 10:22:06', '1.00', 'FA23000024', 'payer', NULL, NULL, NULL, '2023-06-06 10:22:06', '2023-06-06 10:22:06', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(25, 59, '2023-06-06 10:24:40', '1.00', 'FA23000025', 'payer', NULL, NULL, NULL, '2023-06-06 10:24:40', '2023-06-06 10:24:40', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(26, 60, '2023-06-06 10:24:42', '1.00', 'FA23000026', 'payer', NULL, NULL, NULL, '2023-06-06 10:24:42', '2023-06-06 10:24:42', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(27, 61, '2023-06-06 10:26:33', '1.00', 'FA23000027', 'payer', NULL, NULL, NULL, '2023-06-06 10:26:33', '2023-06-06 10:26:33', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(28, 62, '2023-06-06 10:27:37', '1.00', 'FA23000028', 'payer', NULL, NULL, NULL, '2023-06-06 10:27:37', '2023-06-06 10:27:38', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(29, 63, '2023-06-06 10:29:18', '1.00', 'FA23000029', 'payer', NULL, NULL, NULL, '2023-06-06 10:29:18', '2023-06-06 10:29:18', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(30, 64, '2023-06-06 10:30:37', '1.00', 'FA23000030', 'payer', NULL, NULL, NULL, '2023-06-06 10:30:37', '2023-06-06 10:30:37', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(31, 65, '2023-06-06 11:20:00', '1.00', 'FA23000031', 'payer', NULL, NULL, NULL, '2023-06-06 11:20:00', '2023-06-06 11:20:00', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(32, 66, '2023-06-06 11:22:57', '1.00', 'FA23000032', 'payer', NULL, NULL, NULL, '2023-06-06 11:22:57', '2023-06-06 11:22:57', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(33, 67, '2023-06-06 14:45:25', '1.00', 'FA23000033', 'payer', NULL, NULL, NULL, '2023-06-06 14:45:25', '2023-06-06 14:45:25', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(34, 68, '2023-06-06 14:49:44', '1.00', 'FA23000034', 'payer', NULL, NULL, NULL, '2023-06-06 14:49:44', '2023-06-06 14:49:44', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(35, 69, '2023-06-06 14:52:22', '1.00', 'FA23000035', 'payer', NULL, NULL, NULL, '2023-06-06 14:52:22', '2023-06-06 14:52:22', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(36, 70, '2023-06-06 15:36:08', '1.00', 'FA23000036', 'payer', NULL, NULL, NULL, '2023-06-06 15:36:08', '2023-06-06 15:36:08', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(37, 71, '2023-06-06 15:37:19', '1.00', 'FA23000037', 'payer', NULL, NULL, NULL, '2023-06-06 15:37:19', '2023-06-06 15:37:19', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(38, 72, '2023-06-06 15:39:08', '1.00', 'FA23000038', 'payer', NULL, NULL, NULL, '2023-06-06 15:39:08', '2023-06-06 15:39:08', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(39, 73, '2023-06-06 15:39:49', '1.00', 'FA23000039', 'payer', NULL, NULL, NULL, '2023-06-06 15:39:49', '2023-06-06 15:39:49', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(40, 74, '2023-06-06 15:49:07', '10.03', 'FA23000040', 'payer', NULL, NULL, NULL, '2023-06-06 15:49:07', '2023-06-06 15:49:07', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(41, 75, '2023-06-06 17:54:11', '501.00', 'FA23000041', 'payer', NULL, NULL, NULL, '2023-06-06 17:54:11', '2023-06-06 17:54:12', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(42, 76, '2023-06-07 14:10:03', '3501.00', 'FA23000042', 'payer', NULL, NULL, NULL, '2023-06-07 14:10:03', '2023-06-07 14:10:03', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(44, 76, '2023-06-13 16:13:43', '3501.00', 'FA23000044', 'En attente', NULL, NULL, NULL, '2023-06-13 16:13:43', NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FA'),
(45, 48, '2023-06-13 17:24:30', '1.00', 'FA23000044', 'En attente', NULL, NULL, NULL, '2023-06-13 17:24:31', NULL, NULL, 1, 1, '13/06/2023 17:24:31', 'F;EM01192039;26JZ66ZBGJOIKS435EZPGZGK;0202112753715;20230613172431', '26JZ-66ZB-GJOI-KS43-5EZP-GZGK', '2/16 FA', 'EM01192039', 1, 'FA'),
(46, 77, '2023-06-14 10:01:35', '100.30', 'FA23000045', 'En attente', NULL, NULL, NULL, '2023-06-14 10:01:35', NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(47, 78, '2023-06-14 11:24:49', '10.03', 'FA23000046', 'payer', NULL, NULL, NULL, '2023-06-14 11:24:49', '2023-06-14 11:24:50', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(48, 79, '2023-06-14 11:27:19', '1.00', 'FA23000047', 'payer', NULL, NULL, NULL, '2023-06-14 11:27:19', '2023-06-14 11:27:20', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(49, 80, '2023-06-14 11:32:23', '1.00', 'FA23000048', 'En attente', NULL, NULL, NULL, '2023-06-14 11:32:23', NULL, NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(50, 81, '2023-06-14 11:34:03', '11.03', 'FA23000049', 'En attente', NULL, NULL, NULL, '2023-06-14 11:34:03', NULL, NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(51, 82, '2023-06-14 11:35:09', '11.03', 'FA23000050', 'payer', NULL, NULL, NULL, '2023-06-14 11:35:09', '2023-06-14 11:35:09', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(52, 83, '2023-06-14 11:35:48', '11.03', 'FA23000051', 'payer', NULL, NULL, NULL, '2023-06-14 11:35:48', '2023-06-14 11:35:48', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(53, 84, '2023-06-14 11:36:41', '11.03', 'FA23000052', 'payer', NULL, NULL, NULL, '2023-06-14 11:36:41', '2023-06-14 11:36:41', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(54, 85, '2023-06-14 11:36:54', '11.03', 'FA23000053', 'payer', NULL, NULL, NULL, '2023-06-14 11:36:54', '2023-06-14 11:36:55', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(55, 86, '2023-06-14 11:37:22', '11.03', 'FA23000054', 'payer', NULL, NULL, NULL, '2023-06-14 11:37:22', '2023-06-14 11:37:22', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(56, 87, '2023-06-14 11:37:42', '11.03', 'FA23000055', 'payer', NULL, NULL, NULL, '2023-06-14 11:37:42', '2023-06-14 11:37:42', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(57, 88, '2023-06-14 11:38:29', '11.03', 'FA23000056', 'payer', NULL, NULL, NULL, '2023-06-14 11:38:29', '2023-06-14 11:38:30', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(58, 89, '2023-06-14 11:39:37', '11.03', 'FA23000057', 'payer', NULL, NULL, NULL, '2023-06-14 11:39:37', '2023-06-14 11:39:39', NULL, 1, 2, '14/06/2023 11:39:39', 'F;TS01003999;TESTPX234MH4JF5OMSRZLPTS;3201501642813;20230614113939', 'TEST-PX23-4MH4-JF5O-MSRZ-LPTS', '17/20 FV', 'TS01003999', 1, 'FV'),
(59, 90, '2023-06-14 11:52:09', '1.00', 'FA23000058', 'payer', NULL, NULL, NULL, '2023-06-14 11:52:09', '2023-06-14 11:52:09', NULL, 1, 2, '14/06/2023 11:52:09', 'F;TS01003999;TESTOONCUR2KHAQZVSY77WEC;3201501642813;20230614115209', 'TEST-OONC-UR2K-HAQZ-VSY7-7WEC', '18/21 FV', 'TS01003999', 1, 'FV'),
(60, 91, '2023-06-14 11:53:38', '10.03', 'FA23000059', 'payer', NULL, NULL, NULL, '2023-06-14 11:53:38', '2023-06-14 11:53:39', NULL, 1, 2, '14/06/2023 11:53:39', 'F;TS01003999;TESTGBBLEVMQPDXX3ARR6YDK;3201501642813;20230614115339', 'TEST-GBBL-EVMQ-PDXX-3ARR-6YDK', '19/22 FV', 'TS01003999', 1, 'FV'),
(61, 92, '2023-06-14 12:04:27', '10.03', 'FA23000060', 'payer', NULL, NULL, NULL, '2023-06-14 12:04:27', '2023-06-14 12:04:28', NULL, 1, 2, '14/06/2023 12:04:27', 'F;TS01003999;TESTMESVRPZN3RIK55QTVMBK;3201501642813;20230614120427', 'TEST-MESV-RPZN-3RIK-55QT-VMBK', '20/23 FV', 'TS01003999', 1, 'FV'),
(62, 90, '2023-06-14 12:11:12', '1.00', 'FA23000061', 'En attente', NULL, NULL, NULL, '2023-06-14 12:11:13', NULL, NULL, 1, 2, '14/06/2023 12:11:13', 'F;TS01003999;TEST6BBDY3RLGO4LIOHC3LTP;3201501642813;20230614121113', 'TEST-6BBD-Y3RL-GO4L-IOHC-3LTP', '3/24 FA', 'TS01003999', 1, 'FA'),
(63, 95, '2023-06-14 13:42:56', '1.00', 'FA23000062', 'payer', NULL, NULL, NULL, '2023-06-14 13:42:56', '2023-06-14 13:42:59', NULL, 1, 2, '14/06/2023 13:42:59', 'F;TS01003999;TESTLYLHKTSL5FSWL2OWFBYJ;3201501642813;20230614134259', 'TEST-LYLH-KTSL-5FSW-L2OW-FBYJ', '21/25 FV', 'TS01003999', 1, 'FV'),
(64, 91, '2023-06-14 13:59:32', '10.03', 'FA23000063', 'Annuler', NULL, NULL, NULL, '2023-06-14 13:59:33', NULL, NULL, 1, 2, '14/06/2023 13:59:33', 'F;TS01003999;TESTTJ3SGA5KLMTWLLBRAMTA;3201501642813;20230614135933', 'TEST-TJ3S-GA5K-LMTW-LLBR-AMTA', '4/26 FA', 'TS01003999', 1, 'FA'),
(65, 96, '2023-06-14 14:06:34', '1.00', 'FA23000064', 'payer', NULL, NULL, NULL, '2023-06-14 14:06:34', '2023-06-14 14:06:35', NULL, 1, 2, '14/06/2023 14:06:35', 'F;TS01003999;TESTRTDMVNG7ESNDIOZKAG6Z;3201501642813;20230614140635', 'TEST-RTDM-VNG7-ESND-IOZK-AG6Z', '22/27 FV', 'TS01003999', 1, 'FV'),
(66, 97, '2023-06-14 14:22:39', '1.00', 'FA23000065', 'payer', NULL, NULL, NULL, '2023-06-14 14:22:39', '2023-06-14 14:22:40', NULL, 1, 2, '14/06/2023 14:22:39', 'F;TS01003999;TESTOBDWWP6QYOOSQKHGYWMH;3201501642813;20230614142239', 'TEST-OBDW-WP6Q-YOOS-QKHG-YWMH', '23/28 FV', 'TS01003999', 1, 'FV'),
(67, 98, '2023-06-14 14:59:43', '1.00', 'FA23000066', 'payer', NULL, NULL, NULL, '2023-06-14 14:59:43', '2023-06-14 14:59:46', NULL, 1, 2, '14/06/2023 14:59:45', 'F;TS01003999;TESTGA6CFRNCI3A64TZHZIT7;3201501642813;20230614145945', 'TEST-GA6C-FRNC-I3A6-4TZH-ZIT7', '24/29 FV', 'TS01003999', 1, 'FV'),
(68, 99, '2023-06-14 15:04:11', '1.00', 'FA23000067', 'payer', NULL, NULL, NULL, '2023-06-14 15:04:11', '2023-06-14 15:04:13', NULL, 1, 2, '14/06/2023 15:04:12', 'F;TS01003999;TESTLJSCVBLLFRQJVCLKMRWP;3201501642813;20230614150412', 'TEST-LJSC-VBLL-FRQJ-VCLK-MRWP', '25/30 FV', 'TS01003999', 1, 'FV'),
(69, 100, '2023-06-14 15:08:34', '1.00', 'FA23000068', 'payer', NULL, NULL, NULL, '2023-06-14 15:08:34', '2023-06-14 15:08:36', NULL, 1, 2, '14/06/2023 15:08:35', 'F;TS01003999;TEST6VOEEKJ2YXJQ3O6WWLK4;3201501642813;20230614150835', 'TEST-6VOE-EKJ2-YXJQ-3O6W-WLK4', '26/31 FV', 'TS01003999', 1, 'FV'),
(70, 101, '2023-06-14 15:28:03', '1.00', 'FA23000069', 'payer', NULL, NULL, NULL, '2023-06-14 15:28:03', '2023-06-14 15:28:04', NULL, 1, 2, '14/06/2023 15:28:03', 'F;TS01003999;TESTOTXJ4RLLA55FOATT6HJW;3201501642813;20230614152803', 'TEST-OTXJ-4RLL-A55F-OATT-6HJW', '29/34 FV', 'TS01003999', 1, 'FV'),
(71, 102, '2023-06-14 15:29:19', '11.03', 'FA23000070', 'payer', NULL, NULL, NULL, '2023-06-14 15:29:19', '2023-06-14 15:29:20', NULL, 1, 2, '14/06/2023 15:29:19', 'F;TS01003999;TESTETARL7KFGYGTAWLOAGQE;3201501642813;20230614152919', 'TEST-ETAR-L7KF-GYGT-AWLO-AGQE', '30/35 FV', 'TS01003999', 1, 'FV'),
(72, 103, '2023-06-14 17:07:41', '1.01', 'FA23000071', 'payer', NULL, NULL, NULL, '2023-06-14 17:07:41', '2023-06-14 17:07:42', NULL, 1, 2, '14/06/2023 17:07:42', 'F;TS01003999;TESTMQEKOXCH4JYI4O3GFJKB;3201501642813;20230614170742', 'TEST-MQEK-OXCH-4JYI-4O3G-FJKB', '33/39 FV', 'TS01003999', 1, 'FV'),
(73, 104, '2023-06-14 17:12:41', '1.01', 'FA23000072', 'payer', NULL, NULL, NULL, '2023-06-14 17:12:42', '2023-06-14 17:12:51', NULL, 1, 2, '14/06/2023 17:12:50', 'F;TS01003999;TESTHBGTJMZYF7OEXDECZUWE;3201501642813;20230614171250', 'TEST-HBGT-JMZY-F7OE-XDEC-ZUWE', '34/40 FV', 'TS01003999', 1, 'FV'),
(74, 105, '2023-06-14 19:26:03', '1.00', 'FA23000073', 'payer', NULL, NULL, NULL, '2023-06-14 19:26:03', '2023-06-14 19:26:05', NULL, 1, 2, '14/06/2023 19:26:04', 'F;TS01003999;TESTYR5KDTEQKJGNWHDGU2XD;3201501642813;20230614192604', 'TEST-YR5K-DTEQ-KJGN-WHDG-U2XD', '36/42 FV', 'TS01003999', 1, 'FV'),
(75, 106, '2023-06-14 20:25:13', '2600.00', 'FA23000074', 'payer', NULL, NULL, NULL, '2023-06-14 20:25:13', '2023-06-14 20:25:14', NULL, 1, 2, '14/06/2023 20:25:14', 'F;TS01003999;TEST6EQ6VQGPFBLXYX7CQ4C3;3201501642813;20230614202514', 'TEST-6EQ6-VQGP-FBLX-YX7C-Q4C3', '37/43 FV', 'TS01003999', 1, 'FV'),
(76, 107, '2023-06-14 20:43:17', '2132.00', 'FA23000075', 'payer', NULL, NULL, NULL, '2023-06-14 20:43:17', '2023-06-14 20:43:21', NULL, 1, 2, '14/06/2023 20:43:20', 'F;TS01003999;TESTEFBBMBRC3AWKULRQVLLF;3201501642813;20230614204320', 'TEST-EFBB-MBRC-3AWK-ULRQ-VLLF', '38/44 FV', 'TS01003999', 1, 'FV'),
(77, 108, '2023-06-14 20:46:42', '2600.00', 'FA23000076', 'payer', NULL, NULL, NULL, '2023-06-14 20:46:42', '2023-06-14 20:46:43', NULL, 1, 2, '14/06/2023 20:46:42', 'F;TS01003999;TESTZNUV4XUH5XX3FZKUCZYV;3201501642813;20230614204642', 'TEST-ZNUV-4XUH-5XX3-FZKU-CZYV', '39/45 FV', 'TS01003999', 1, 'FV'),
(78, 109, '2023-06-14 21:33:03', '2600.00', 'FA23000077', 'payer', NULL, NULL, NULL, '2023-06-14 21:33:03', '2023-06-14 21:33:04', NULL, 1, 2, '14/06/2023 21:33:04', 'F;TS01003999;TESTYI72G7KI4OGBZQWBRACC;3201501642813;20230614213304', 'TEST-YI72-G7KI-4OGB-ZQWB-RACC', '40/46 FV', 'TS01003999', 1, 'FV'),
(79, 110, '2023-06-15 11:49:26', '11800.00', 'FA23000078', 'payer', NULL, NULL, NULL, '2023-06-15 11:49:26', '2023-06-15 11:49:27', NULL, 1, 2, '15/06/2023 11:49:26', 'F;TS01003999;TEST56NL245Y6UV73XV2MIME;3201501642813;20230615114926', 'TEST-56NL-245Y-6UV7-3XV2-MIME', '41/47 FV', 'TS01003999', 1, 'FV'),
(80, 111, '2023-06-15 16:05:53', '40600.00', 'FA23000079', 'payer', NULL, NULL, NULL, '2023-06-15 16:05:53', '2023-06-15 16:05:54', NULL, 1, 2, '15/06/2023 16:05:53', 'F;TS01003999;TESTCHPXXE7V2TXGSSHJ6OYP;3201501642813;20230615160553', 'TEST-CHPX-XE7V-2TXG-SSHJ-6OYP', '42/48 FV', 'TS01003999', 1, 'FV'),
(81, 112, '2023-06-15 17:53:52', '44850.00', 'FA23000080', 'payer', NULL, NULL, NULL, '2023-06-15 17:53:52', '2023-06-15 17:53:53', NULL, 1, 2, '15/06/2023 17:53:53', 'F;TS01003999;TEST6OY6LHERWRTZRNTGZDGX;3201501642813;20230615175353', 'TEST-6OY6-LHER-WRTZ-RNTG-ZDGX', '43/49 FV', 'TS01003999', 1, 'FV'),
(82, 113, '2023-06-15 18:03:29', '44850.00', 'FA23000081', 'payer', NULL, NULL, NULL, '2023-06-15 18:03:29', '2023-06-15 18:03:30', NULL, 1, 2, '15/06/2023 18:03:30', 'F;TS01003999;TESTLREWKZST2M2QNCR4GXIZ;3201501642813;20230615180330', 'TEST-LREW-KZST-2M2Q-NCR4-GXIZ', '44/50 FV', 'TS01003999', 1, 'FV'),
(83, 114, '2023-06-15 18:30:16', '40600.00', 'FA23000082', 'payer', NULL, NULL, NULL, '2023-06-15 18:30:16', '2023-06-15 18:30:17', NULL, 1, 2, '15/06/2023 18:30:17', 'F;TS01003999;TESTVAINIJ7OPOVQXLK7ZA4D;3201501642813;20230615183017', 'TEST-VAIN-IJ7O-POVQ-XLK7-ZA4D', '45/51 FV', 'TS01003999', 1, 'FV'),
(84, 114, '2023-06-15 18:34:01', '40600.00', 'FA23000083', 'Annuler', NULL, NULL, NULL, '2023-06-15 18:34:02', NULL, NULL, 1, 2, '15/06/2023 18:34:02', 'F;TS01003999;TESTXP2AP7H26UOKDS2YE6ML;3201501642813;20230615183402', 'TEST-XP2A-P7H2-6UOK-DS2Y-E6ML', '6/52 FA', 'TS01003999', 1, 'FA'),
(85, 115, '2023-06-15 20:05:46', '35998.00', 'FA23000084', 'payer', NULL, NULL, NULL, '2023-06-15 20:05:46', '2023-06-15 20:05:47', NULL, 1, 2, '15/06/2023 20:05:48', 'F;TS01003999;TESTX3QPXBM4W7RTXCUQ73VL;3201501642813;20230615200548', 'TEST-X3QP-XBM4-W7RT-XCUQ-73VL', '46/53 FV', 'TS01003999', 1, 'FV'),
(86, 116, '2023-06-16 13:25:06', '35998.00', 'FA23000085', 'payer', NULL, NULL, NULL, '2023-06-16 13:25:06', '2023-06-16 13:25:08', NULL, 1, 2, '16/06/2023 13:25:08', 'F;TS01003999;TESTAQSQ2A4QNN35MDMN7WZV;3201501642813;20230616132508', 'TEST-AQSQ-2A4Q-NN35-MDMN-7WZV', '47/54 FV', 'TS01003999', 1, 'FV'),
(87, 117, '2023-06-16 13:27:04', '35998.00', 'FA23000086', 'payer', NULL, NULL, NULL, '2023-06-16 13:27:04', '2023-06-16 13:27:04', NULL, 1, 2, '16/06/2023 13:27:04', 'F;TS01003999;TESTFEPWBKMHHTM2ZVSI2X4F;3201501642813;20230616132704', 'TEST-FEPW-BKMH-HTM2-ZVSI-2X4F', '48/55 FV', 'TS01003999', 1, 'FV'),
(88, 118, '2023-06-16 15:59:27', '42360.00', 'FA23000087', 'payer', NULL, NULL, NULL, '2023-06-16 15:59:27', '2023-06-16 15:59:28', NULL, 1, 2, '16/06/2023 15:59:28', 'F;TS01003999;TEST4MDAUCLJB6NDLBRVBABQ;3201501642813;20230616155928', 'TEST-4MDA-UCLJ-B6ND-LBRV-BABQ', '49/56 FV', 'TS01003999', 1, 'FV'),
(89, 119, '2023-06-16 16:02:09', '40952.00', 'FA23000088', 'payer', NULL, NULL, NULL, '2023-06-16 16:02:09', '2023-06-16 16:02:10', NULL, 1, 2, '16/06/2023 16:02:10', 'F;TS01003999;TEST5WBFVDXGO5Z5QBLJZNFA;3201501642813;20230616160210', 'TEST-5WBF-VDXG-O5Z5-QBLJ-ZNFA', '50/57 FV', 'TS01003999', 1, 'FV'),
(90, 120, '2023-06-16 16:08:26', '42958.00', 'FA23000089', 'payer', NULL, NULL, NULL, '2023-06-16 16:08:26', '2023-06-16 16:08:28', NULL, 1, 2, '16/06/2023 16:08:28', 'F;TS01003999;TESTAJXJPRHULKAJ35RPRZWU;3201501642813;20230616160828', 'TEST-AJXJ-PRHU-LKAJ-35RP-RZWU', '51/58 FV', 'TS01003999', 1, 'FV'),
(91, 121, '2023-06-16 16:22:49', '42983.34', 'FA23000090', 'payer', NULL, NULL, NULL, '2023-06-16 16:22:49', '2023-06-16 16:22:50', NULL, 1, 2, '16/06/2023 16:22:50', 'F;TS01003999;TESTKKEWIUCR5TY6C5LCN3UL;3201501642813;20230616162250', 'TEST-KKEW-IUCR-5TY6-C5LC-N3UL', '52/59 FV', 'TS01003999', 1, 'FV'),
(92, 122, '2023-06-16 18:00:26', '28600.00', 'FA23000091', 'payer', NULL, NULL, NULL, '2023-06-16 18:00:26', '2023-06-16 18:00:27', NULL, 1, 2, '16/06/2023 18:00:27', 'F;TS01003999;TESTE37KIH3YUGP35EVDXPGF;3201501642813;20230616180027', 'TEST-E37K-IH3Y-UGP3-5EVD-XPGF', '53/60 FV', 'TS01003999', 1, 'FV'),
(93, 123, '2023-06-16 18:47:42', '225380.00', 'FA23000092', 'payer', NULL, NULL, NULL, '2023-06-16 18:47:42', '2023-06-16 18:47:43', NULL, 1, 2, '16/06/2023 18:47:44', 'F;TS01003999;TESTW3KXOL3KK5OON7WFPK76;3201501642813;20230616184744', 'TEST-W3KX-OL3K-K5OO-N7WF-PK76', '54/61 FV', 'TS01003999', 1, 'FV'),
(94, 124, '2023-06-16 19:04:30', '225979.00', 'FA23000093', 'payer', NULL, NULL, NULL, '2023-06-16 19:04:30', '2023-06-16 19:04:31', NULL, 1, 2, '16/06/2023 19:04:31', 'F;TS01003999;TESTT3CEB2EGSBMYTR2TJEDH;3201501642813;20230616190431', 'TEST-T3CE-B2EG-SBMY-TR2T-JEDH', '55/62 FV', 'TS01003999', 1, 'FV'),
(95, 125, '2023-06-16 19:13:36', '191000.00', 'FA23000094', 'payer', NULL, NULL, NULL, '2023-06-16 19:13:36', '2023-06-16 19:13:38', NULL, 1, 2, '16/06/2023 19:13:38', 'F;TS01003999;TESTGQ6PD24RXWLL5BGAJZJK;3201501642813;20230616191338', 'TEST-GQ6P-D24R-XWLL-5BGA-JZJK', '56/63 FV', 'TS01003999', 1, 'FV'),
(96, 126, '2023-06-16 19:19:48', '191600.00', 'FA23000095', 'payer', NULL, NULL, NULL, '2023-06-16 19:19:48', '2023-06-16 19:19:48', NULL, 1, 2, '16/06/2023 19:19:49', 'F;TS01003999;TEST2U42OYEBVK2LGZG7RDC5;3201501642813;20230616191949', 'TEST-2U42-OYEB-VK2L-GZG7-RDC5', '57/64 FV', 'TS01003999', 1, 'FV'),
(97, 127, '2023-06-16 19:41:46', '191600.00', 'FA23000096', 'payer', NULL, NULL, NULL, '2023-06-16 19:41:46', '2023-06-16 19:41:47', NULL, 1, 2, '16/06/2023 19:41:47', 'F;TS01003999;TESTMBLLA5T7CEUUXL5NGTRP;3201501642813;20230616194147', 'TEST-MBLL-A5T7-CEUU-XL5N-GTRP', '58/65 FV', 'TS01003999', 1, 'FV'),
(98, 128, '2023-06-20 13:19:18', '10000.00', 'FA23000097', 'payer', NULL, NULL, NULL, '2023-06-20 13:19:18', '2023-06-20 13:19:20', NULL, 1, 2, '20/06/2023 13:19:19', 'F;TS01003999;TESTQ6LZXWWZA77CTI2VR2DM;3201501642813;20230620131919', 'TEST-Q6LZ-XWWZ-A77C-TI2V-R2DM', '72/84 FV', 'TS01003999', 1, 'FV'),
(99, 129, '2023-06-20 15:54:43', '10000.00', 'FA23000098', 'payer', NULL, NULL, NULL, '2023-06-20 15:54:43', '2023-06-20 15:54:44', NULL, 1, 2, '20/06/2023 15:54:44', 'F;TS01003999;TESTEXUIVBWTPK57KPS2YOZ4;3201501642813;20230620155444', 'TEST-EXUI-VBWT-PK57-KPS2-YOZ4', '73/85 FV', 'TS01003999', 1, 'FV'),
(100, 130, '2023-06-20 15:56:19', '10000.00', 'FA23000099', 'payer', NULL, NULL, NULL, '2023-06-20 15:56:19', '2023-06-20 15:56:20', NULL, 1, 2, '20/06/2023 15:56:19', 'F;TS01003999;TESTQB7VZ2WTE2STXFEY3BLT;3201501642813;20230620155619', 'TEST-QB7V-Z2WT-E2ST-XFEY-3BLT', '1/86 EV', 'TS01003999', 1, 'FV'),
(101, 131, '2023-06-20 18:37:23', '10000.00', 'FA23000100', 'payer', NULL, NULL, NULL, '2023-06-20 18:37:23', '2023-06-20 18:37:25', NULL, 1, 2, '20/06/2023 18:37:24', 'F;TS01003999;TESTSQ5YIOYMCS5SRD7CLTIU;3201501642813;20230620183724', 'TEST-SQ5Y-IOYM-CS5S-RD7C-LTIU', '2/89 EV', 'TS01003999', 1, 'FV'),
(102, 132, '2023-06-20 19:38:04', '20200.00', 'FA23000101', 'payer', NULL, NULL, NULL, '2023-06-20 19:38:04', '2023-06-20 19:38:05', NULL, 1, 2, '20/06/2023 19:38:05', 'F;TS01003999;TESTGPGPW4HQITURTO4YQ5OX;3201501642813;20230620193805', 'TEST-GPGP-W4HQ-ITUR-TO4Y-Q5OX', '3/90 EV', 'TS01003999', 1, 'FV'),
(103, 133, '2023-06-20 19:47:26', '10000.00', 'FA23000102', 'payer', NULL, NULL, NULL, '2023-06-20 19:47:26', '2023-06-20 19:47:26', NULL, 1, 2, '20/06/2023 19:47:26', 'F;TS01003999;TEST4JM255Y4XWLQ66RDHEXO;3201501642813;20230620194726', 'TEST-4JM2-55Y4-XWLQ-66RD-HEXO', '4/91 EV', 'TS01003999', 1, 'FV'),
(104, 133, '2023-06-20 20:07:47', '10000.00', 'FA23000103', 'Annuler', NULL, NULL, NULL, '2023-06-20 20:07:48', NULL, NULL, 1, 2, '20/06/2023 20:07:48', 'F;TS01003999;TESTYIV36NVQCHRGLVOTUR5P;3201501642813;20230620200748', 'TEST-YIV3-6NVQ-CHRG-LVOT-UR5P', '1/92 EA', 'TS01003999', 1, 'FA'),
(105, 134, '2023-06-20 20:20:06', '191000.00', 'FA23000104', 'payer', NULL, NULL, NULL, '2023-06-20 20:20:06', '2023-06-20 20:20:06', NULL, 1, 2, '20/06/2023 20:20:06', 'F;TS01003999;TESTR5TCQGXV5VFJ5T6MNT5Y;3201501642813;20230620202006', 'TEST-R5TC-QGXV-5VFJ-5T6M-NT5Y', '5/94 EV', 'TS01003999', 1, 'FV'),
(106, 134, '2023-06-20 20:22:50', '191000.00', 'FA23000105', 'Annuler', NULL, NULL, NULL, '2023-06-20 20:22:51', NULL, NULL, 1, 2, '20/06/2023 20:22:50', 'F;TS01003999;TESTRLN3EPIUDIYUEUGAQ2DN;3201501642813;20230620202250', 'TEST-RLN3-EPIU-DIYU-EUGA-Q2DN', '2/95 EA', 'TS01003999', 1, 'FA'),
(107, 135, '2023-06-21 13:03:53', '6000.00', 'FA23000106', 'payer', NULL, NULL, NULL, '2023-06-21 13:03:53', '2023-06-21 13:03:54', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(108, 136, '2023-06-21 13:04:44', '6000.00', 'FA23000107', 'payer', NULL, NULL, NULL, '2023-06-21 13:04:44', '2023-06-21 13:04:45', NULL, 1, 2, '21/06/2023 13:04:44', 'F;TS01003999;TEST57U3UOS3P2EKPDMTOC2K;3201501642813;20230621130444', 'TEST-57U3-UOS3-P2EK-PDMT-OC2K', '79/99 FV', 'TS01003999', 1, 'FV'),
(109, 137, '2023-06-21 13:07:18', '6000.01', 'FA23000108', 'payer', NULL, NULL, NULL, '2023-06-21 13:07:18', '2023-06-21 13:07:19', NULL, 1, 2, '21/06/2023 13:07:18', 'F;TS01003999;TESTMYZNTMARQDZ3TEE7XG7N;3201501642813;20230621130718', 'TEST-MYZN-TMAR-QDZ3-TEE7-XG7N', '80/100 FV', 'TS01003999', 1, 'FV'),
(110, 138, '2023-06-21 13:09:34', '236000.00', 'FA23000109', 'payer', NULL, NULL, NULL, '2023-06-21 13:09:34', '2023-06-21 13:09:34', NULL, 1, 2, '21/06/2023 13:09:34', 'F;TS01003999;TESTWU54OIKRGAK6YQ23AAPW;3201501642813;20230621130934', 'TEST-WU54-OIKR-GAK6-YQ23-AAPW', '81/101 FV', 'TS01003999', 1, 'FV'),
(111, 139, '2023-06-21 13:12:41', '95500.00', 'FA23000110', 'payer', NULL, NULL, NULL, '2023-06-21 13:12:41', '2023-06-21 13:12:41', NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FV'),
(112, 139, '2023-06-21 14:10:46', '95500.00', 'FA23000111', 'Annuler', NULL, NULL, NULL, '2023-06-21 14:10:46', NULL, NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FA'),
(113, 138, '2023-06-21 14:12:48', '236000.00', 'FA23000112', 'Annuler', NULL, NULL, NULL, '2023-06-21 14:12:49', NULL, NULL, 1, 2, '21/06/2023 14:12:48', 'F;TS01003999;TESTMU2BTFFG3G76DGAPDNIZ;3201501642813;20230621141248', 'TEST-MU2B-TFFG-3G76-DGAP-DNIZ', '13/102 FA', 'TS01003999', 1, 'FA'),
(114, 140, '2023-06-22 18:54:17', '35980.00', 'FA23000113', 'payer', NULL, NULL, NULL, '2023-06-22 18:54:17', '2023-06-22 18:54:19', NULL, 1, 2, '22/06/2023 18:54:19', 'F;TS01003999;TEST23AQ7LKY73OB5TDWDB3B;3201501642813;20230622185419', 'TEST-23AQ-7LKY-73OB-5TDW-DB3B', '94/116 FV', 'TS01003999', 1, 'FV'),
(115, 141, '2023-06-22 18:55:42', '35998.00', 'FA23000114', 'payer', NULL, NULL, NULL, '2023-06-22 18:55:42', '2023-06-22 18:55:43', NULL, 1, 2, '22/06/2023 18:55:42', 'F;TS01003999;TESTEJJATVS2AKRZR3TEJ6GX;3201501642813;20230622185542', 'TEST-EJJA-TVS2-AKRZ-R3TE-J6GX', '95/117 FV', 'TS01003999', 1, 'FV'),
(116, 142, '2023-06-23 16:08:48', '11800.00', 'FA23000115', 'payer', NULL, NULL, NULL, '2023-06-23 16:08:48', '2023-06-23 16:08:49', NULL, 1, 2, '23/06/2023 16:08:49', 'F;TS01003999;TESTFEPX4JAFBFGTYKAJF5Y3;3201501642813;20230623160849', 'TEST-FEPX-4JAF-BFGT-YKAJ-F5Y3', '106/133 FV', 'TS01003999', 1, 'FV'),
(117, 143, '2023-06-23 16:23:43', '11800.00', 'FA23000116', 'payer', NULL, NULL, NULL, '2023-06-23 16:23:43', '2023-06-23 16:23:44', NULL, 1, 2, '23/06/2023 16:23:44', 'F;TS01003999;TESTNRUBPRMO4YEC72HZ5MYS;3201501642813;20230623162344', 'TEST-NRUB-PRMO-4YEC-72HZ-5MYS', '107/134 FV', 'TS01003999', 1, 'FV'),
(118, 144, '2023-06-23 18:24:07', '118000.00', 'FA23000117', 'payer', NULL, NULL, NULL, '2023-06-23 18:24:07', '2023-06-23 18:24:10', NULL, 1, 2, '23/06/2023 18:24:09', 'F;TS01003999;TEST4LGQ6VDMO3SMJHRWXSGL;3201501642813;20230623182409', 'TEST-4LGQ-6VDM-O3SM-JHRW-XSGL', '108/135 FV', 'TS01003999', 1, 'FV'),
(119, 144, '2023-06-23 18:38:43', '118000.00', 'FA23000118', 'Annuler', NULL, NULL, NULL, '2023-06-23 18:38:44', NULL, NULL, 1, 2, '23/06/2023 18:38:44', 'F;TS01003999;TESTCWH2LMOSPEMTKQYE7R2V;3201501642813;20230623183844', 'TEST-CWH2-LMOS-PEMT-KQYE-7R2V', '15/136 FA', 'TS01003999', 1, 'FA'),
(120, 145, '2023-06-26 16:51:53', '23600.00', 'FA23000119', 'payer', NULL, NULL, NULL, '2023-06-26 16:51:53', '2023-06-26 16:51:55', NULL, 1, 2, '26/06/2023 16:51:55', 'F;TS01003999;TESTSIJKHUML4TTYYAOGQB63;3201501642813;20230626165155', 'TEST-SIJK-HUML-4TTY-YAOG-QB63', '110/138 FV', 'TS01003999', 1, 'FV'),
(121, 145, '2023-06-26 16:52:36', '23600.00', 'FA23000120', 'Annuler', NULL, NULL, NULL, '2023-06-26 16:52:37', NULL, NULL, 1, 2, '26/06/2023 16:52:37', 'F;TS01003999;TESTNOIG3CSXQTEHXKJ7PXHD;3201501642813;20230626165237', 'TEST-NOIG-3CSX-QTEH-XKJ7-PXHD', '16/139 FA', 'TS01003999', 1, 'FA'),
(122, 146, '2023-06-26 17:05:22', '177000.00', 'FA23000121', 'payer', NULL, NULL, NULL, '2023-06-26 17:05:22', '2023-06-26 17:05:23', NULL, 1, 2, '26/06/2023 17:05:23', 'F;TS01003999;TESTMH7SD2WD76Q7HOEMMUYW;3201501642813;20230626170523', 'TEST-MH7S-D2WD-76Q7-HOEM-MUYW', '111/140 FV', 'TS01003999', 1, 'FV'),
(130, 146, '2023-06-26 17:57:01', '177000.00', 'FA23000122', 'Annuler', NULL, NULL, NULL, '2023-06-26 17:57:02', NULL, NULL, 1, 2, '26/06/2023 17:57:02', 'F;TS01003999;TESTIPUIF7GUEH56HUDIMUTW;3201501642813;20230626175702', 'TEST-IPUI-F7GU-EH56-HUDI-MUTW', '24/148 FA', 'TS01003999', 1, 'FA'),
(131, 147, '2023-06-26 18:12:58', '11800.00', 'FA23000123', 'payer', NULL, NULL, NULL, '2023-06-26 18:12:58', '2023-06-26 18:12:59', NULL, 1, 2, '26/06/2023 18:12:59', 'F;TS01003999;TESTJMQNKQBMYVXGLVYJ346I;3201501642813;20230626181259', 'TEST-JMQN-KQBM-YVXG-LVYJ-346I', '9/149 EV', 'TS01003999', 1, 'EV'),
(132, 147, '2023-06-26 18:29:25', '11800.00', 'FA23000124', 'Annuler', NULL, NULL, NULL, '2023-06-26 18:29:26', NULL, NULL, 1, 2, '26/06/2023 18:29:26', 'F;TS01003999;TESTL7RYFZHHEEYDL2IVFZJY;3201501642813;20230626182926', 'TEST-L7RY-FZHH-EEYD-L2IV-FZJY', '5/150 EA', 'TS01003999', 1, 'FA'),
(133, 148, '2023-06-26 18:33:13', '11800.00', 'FA23000125', 'payer', NULL, NULL, NULL, '2023-06-26 18:33:13', '2023-06-26 18:33:14', NULL, 1, 2, '26/06/2023 18:33:14', 'F;TS01003999;TESTTU7U7XQZOHXAAYAWZIWP;3201501642813;20230626183314', 'TEST-TU7U-7XQZ-OHXA-AYAW-ZIWP', '10/151 EV', 'TS01003999', 1, 'EV'),
(134, 148, '2023-06-26 18:33:51', '11800.00', 'FA23000126', 'Annuler', NULL, NULL, NULL, '2023-06-26 18:33:52', NULL, NULL, 1, 2, '26/06/2023 18:33:52', 'F;TS01003999;TEST5KNNDQPHF2GTZ6MHYKLW;3201501642813;20230626183352', 'TEST-5KNN-DQPH-F2GT-Z6MH-YKLW', '6/152 EA', 'TS01003999', 1, 'EA'),
(135, 149, '2023-06-26 20:42:02', '11800.00', 'FA23000127', 'En attente', NULL, NULL, NULL, '2023-06-26 20:42:02', '2023-06-26 20:42:03', NULL, 1, 2, '26/06/2023 20:42:03', 'F;TS01003999;TESTVD3VBHKBTMFQD3RGUQOP;3201501642813;20230626204203', 'TEST-VD3V-BHKB-TMFQ-D3RG-UQOP', '112/153 FV', 'TS01003999', 1, 'FV'),
(136, 150, '2023-06-26 20:55:08', '11800.00', 'FA23000128', 'payer', NULL, NULL, NULL, '2023-06-26 20:55:08', '2023-06-26 20:55:09', NULL, 1, 2, '26/06/2023 20:55:09', 'F;TS01003999;TESTJ4SO735PPJ42UC4AITLM;3201501642813;20230626205509', 'TEST-J4SO-735P-PJ42-UC4A-ITLM', '113/154 FV', 'TS01003999', 1, 'FV'),
(137, 150, '2023-06-26 20:55:27', '11800.00', 'FA23000129', 'Annuler', NULL, '10000', NULL, '2023-06-26 20:55:28', '2023-06-29 12:42:54', NULL, 1, 2, '26/06/2023 20:55:28', 'F;TS01003999;TESTPXC36LQPRRCFRQXAIXZN;3201501642813;20230626205528', 'TEST-PXC3-6LQP-RRCF-RQXA-IXZN', '25/155 FA', 'TS01003999', 1, 'FA'),
(138, 151, '2023-06-26 20:56:27', '1244900.00', 'FA23000130', 'payer', NULL, NULL, NULL, '2023-06-26 20:56:27', '2023-06-26 20:56:28', NULL, 1, 2, '26/06/2023 20:56:28', 'F;TS01003999;TESTYRXLJNM6WXE2J7NFUAXG;3201501642813;20230626205628', 'TEST-YRXL-JNM6-WXE2-J7NF-UAXG', '114/156 FV', 'TS01003999', 1, 'FV'),
(139, 151, '2023-06-26 20:58:16', '1244900.00', 'FA23000131', 'Annuler', NULL, '1234900', NULL, '2023-06-26 20:58:17', '2023-06-29 12:56:33', NULL, 1, 2, '26/06/2023 20:58:17', 'F;TS01003999;TESTES6BREY2CC2KJ6KRFAQL;3201501642813;20230626205817', 'TEST-ES6B-REY2-CC2K-J6KR-FAQL', '26/157 FA', 'TS01003999', 1, 'FA'),
(140, 152, '2023-06-26 21:01:19', '118000.00', 'FA23000132', 'payer', NULL, NULL, NULL, '2023-06-26 21:01:19', '2023-06-26 21:01:19', NULL, 1, 2, '26/06/2023 21:01:19', 'F;TS01003999;TESTTHGA72JLB5CZ2ZDEQVMQ;3201501642813;20230626210119', 'TEST-THGA-72JL-B5CZ-2ZDE-QVMQ', '115/159 FV', 'TS01003999', 1, 'FV'),
(141, 149, '2023-06-29 15:55:14', '11800.00', 'FA23000133', 'Annuler', NULL, NULL, NULL, '2023-06-29 15:55:18', NULL, NULL, 1, 2, '29/06/2023 15:55:17', 'F;TS01003999;TESTDU6UJ2LRI56CW6RPA2WN;3201501642813;20230629155517', 'TEST-DU6U-J2LR-I56C-W6RP-A2WN', '33/169 FA', 'TS01003999', 1, 'FA'),
(142, 152, '2023-06-29 16:07:34', '118000.00', 'FA23000134', 'Annuler', NULL, NULL, NULL, '2023-06-29 16:07:35', NULL, NULL, 1, 2, '29/06/2023 16:07:34', 'F;TS01003999;TESTAYPIXJXNXPJYMLQRZFAM;3201501642813;20230629160734', 'TEST-AYPI-XJXN-XPJY-MLQR-ZFAM', '34/170 FA', 'TS01003999', 1, 'FA'),
(143, 140, '2023-06-29 16:12:27', '35980.00', 'FA23000135', 'Annuler', NULL, NULL, NULL, '2023-06-29 16:12:28', NULL, NULL, 1, 2, '29/06/2023 16:12:28', 'F;TS01003999;TESTS3PKSZFKRVXOJXC67S7S;3201501642813;20230629161228', 'TEST-S3PK-SZFK-RVXO-JXC6-7S7S', '35/171 FA', 'TS01003999', 1, 'FA'),
(144, 135, '2023-06-29 16:16:32', '6000.00', 'FA23000136', 'Annuler', NULL, NULL, NULL, '2023-06-29 16:16:32', NULL, NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'FA'),
(145, 136, '2023-06-29 16:20:21', '6000.00', 'FA23000137', 'Annuler', NULL, NULL, NULL, '2023-06-29 16:20:25', NULL, NULL, 1, 2, '29/06/2023 16:20:24', 'F;TS01003999;TESTF7TYUBZ2SX73SSKMFT3T;3201501642813;20230629162024', 'TEST-F7TY-UBZ2-SX73-SSKM-FT3T', '36/172 FA', 'TS01003999', 1, 'FA'),
(146, 104, '2023-06-29 16:22:38', '1.01', 'FA23000138', 'Annuler', NULL, NULL, NULL, '2023-06-29 16:22:41', NULL, NULL, 1, 2, '29/06/2023 16:22:40', 'F;TS01003999;TESTMYMKKL566SFSGHEVROVM;3201501642813;20230629162240', 'TEST-MYMK-KL56-6SFS-GHEV-ROVM', '37/173 FA', 'TS01003999', 1, 'FA'),
(147, 115, '2023-06-29 16:23:42', '35998.00', 'FA23000139', 'Annuler', NULL, NULL, NULL, '2023-06-29 16:23:46', NULL, NULL, 1, 2, '29/06/2023 16:23:45', 'F;TS01003999;TESTYR6R2FB7VQIMUTSMRTUR;3201501642813;20230629162345', 'TEST-YR6R-2FB7-VQIM-UTSM-RTUR', '38/174 FA', 'TS01003999', 1, 'FA'),
(148, 153, '2023-07-04 10:06:46', '11800.00', 'FA23000140', 'payer', NULL, NULL, NULL, '2023-07-04 10:06:46', '2023-07-04 10:06:49', NULL, NULL, 2, '04/07/2023 11:06:50', 'F;TS01003999;TESTSSZX232SRYMBZTG7RLS3;3201501642813;20230704110650', 'TEST-SSZX-232S-RYMB-ZTG7-RLS3', '121/181 FV', 'TS01003999', 1, 'FV'),
(149, 154, '2023-07-04 11:40:05', '14400.00', 'FA23000141', 'payer', NULL, NULL, NULL, '2023-07-04 11:40:05', '2023-07-04 11:40:06', NULL, NULL, 2, '04/07/2023 12:40:06', 'F;TS01003999;TESTE4TYDXPI2JDKMC35V7WI;3201501642813;20230704124006', 'TEST-E4TY-DXPI-2JDK-MC35-V7WI', '122/182 FV', 'TS01003999', 1, 'FV'),
(150, 155, '2023-07-05 09:51:44', '14400.00', 'FA23000142', 'payer', NULL, NULL, NULL, '2023-07-05 09:51:45', '2023-07-05 09:51:52', NULL, NULL, 2, '05/07/2023 10:51:52', 'F;TS01003999;TESTK3NWZIG2ZKJJ6D7ZJU5B;3201501642813;20230705105152', 'TEST-K3NW-ZIG2-ZKJJ-6D7Z-JU5B', '123/183 FV', 'TS01003999', 1, 'FV'),
(151, 157, '2023-07-05 10:18:24', '17800.00', 'FA23000143', 'payer', NULL, NULL, NULL, '2023-07-05 10:18:24', '2023-07-05 10:18:25', NULL, NULL, 2, '05/07/2023 11:18:25', 'F;TS01003999;TEST5HMWQTMWNW3XCWCJA5XH;3201501642813;20230705111825', 'TEST-5HMW-QTMW-NW3X-CWCJ-A5XH', '124/184 FV', 'TS01003999', 1, 'FV'),
(152, 158, '2023-07-05 11:56:03', '14800.00', 'FA23000144', 'payer', NULL, NULL, NULL, '2023-07-05 11:56:03', '2023-07-05 11:56:07', NULL, NULL, 2, '05/07/2023 12:56:07', 'F;TS01003999;TESTDY2G2XIQZBZDOWJ4SQWX;3201501642813;20230705125607', 'TEST-DY2G-2XIQ-ZBZD-OWJ4-SQWX', '125/185 FV', 'TS01003999', 1, 'FV'),
(153, 159, '2023-07-06 18:32:22', '11800.00', 'FA23000145', 'payer', NULL, NULL, NULL, '2023-07-06 18:32:22', '2023-07-06 18:32:24', NULL, NULL, 2, '06/07/2023 19:32:23', 'F;TS01003999;TESTMNKPAK2WFQYKVUJGA3HX;3201501642813;20230706193223', 'TEST-MNKP-AK2W-FQYK-VUJG-A3HX', '12/186 EV', 'TS01003999', 1, 'EV'),
(154, 160, '2023-07-06 18:34:23', '11800.00', 'FA23000146', 'payer', NULL, NULL, NULL, '2023-07-06 18:34:23', '2023-07-06 18:34:24', NULL, NULL, 2, '06/07/2023 19:34:24', 'F;TS01003999;TEST5YRKRGYYRBZ6GCRUZ7PG;3201501642813;20230706193424', 'TEST-5YRK-RGYY-RBZ6-GCRU-Z7PG', '126/187 FV', 'TS01003999', 1, 'FV'),
(155, 161, '2023-07-06 18:41:52', '11800.00', 'FA23000147', 'payer', NULL, NULL, NULL, '2023-07-06 18:41:52', '2023-07-06 18:41:53', NULL, NULL, 2, '06/07/2023 19:41:53', 'F;TS01003999;TESTAL7EHGANGMIPRHGXPBSQ;3201501642813;20230706194153', 'TEST-AL7E-HGAN-GMIP-RHGX-PBSQ', '127/188 FV', 'TS01003999', 1, 'FV'),
(156, 162, '2023-07-06 18:58:25', '11800.00', 'FA23000148', 'payer', NULL, NULL, NULL, '2023-07-06 18:58:25', '2023-07-06 18:58:27', NULL, NULL, 2, '06/07/2023 19:58:26', 'F;TS01003999;TESTXWSPOZTBIJAXSPZLNXXI;3201501642813;20230706195826', 'TEST-XWSP-OZTB-IJAX-SPZL-NXXI', '128/189 FV', 'TS01003999', 1, 'FV'),
(157, 163, '2023-07-06 19:05:35', '129800.00', 'FA23000149', 'payer', NULL, NULL, NULL, '2023-07-06 19:05:35', '2023-07-06 19:05:36', NULL, 2, 2, '06/07/2023 20:05:36', 'F;TS01003999;TESTFBBBOD4AGROESCOS54I4;3201501642813;20230706200536', 'TEST-FBBB-OD4A-GROE-SCOS-54I4', '129/190 FV', 'TS01003999', 1, 'FV'),
(158, 164, '2023-07-11 17:36:34', '100.00', 'FA23000150', 'payer', NULL, NULL, NULL, '2023-07-11 17:36:34', '2023-07-11 17:36:36', NULL, 2, 2, '11/07/2023 18:36:35', 'F;TS01003999;TEST7RSDA55MLJLFGZ7MTTPO;3201501642813;20230711183635', 'TEST-7RSD-A55M-LJLF-GZ7M-TTPO', '131/192 FV', 'TS01003999', 1, 'FV'),
(159, 164, '2023-07-11 17:55:37', '100.00', 'FA23000151', 'Annuler', NULL, NULL, NULL, '2023-07-11 17:55:38', NULL, NULL, 2, 2, '11/07/2023 18:55:38', 'F;TS01003999;TESTCVWSLJXF2YUFIZZMKHST;3201501642813;20230711185538', 'TEST-CVWS-LJXF-2YUF-IZZM-KHST', '42/193 FA', 'TS01003999', 1, 'FA'),
(160, 165, '2023-07-11 18:06:24', '100.00', 'FA23000152', 'payer', NULL, NULL, NULL, '2023-07-11 18:06:24', '2023-07-11 18:06:24', NULL, 2, 2, '11/07/2023 19:06:24', 'F;TS01003999;TESTIZMXUSEN3RO5HGB4S4NT;3201501642813;20230711190624', 'TEST-IZMX-USEN-3RO5-HGB4-S4NT', '132/194 FV', 'TS01003999', 1, 'FV'),
(161, 165, '2023-07-11 18:18:04', '100.00', 'FA23000153', 'Annuler', NULL, NULL, NULL, '2023-07-11 18:18:05', NULL, NULL, 2, 2, '11/07/2023 19:18:04', 'F;TS01003999;TESTE23DXCBI33IRS37P7DBU;3201501642813;20230711191804', 'TEST-E23D-XCBI-33IR-S37P-7DBU', '43/195 FA', 'TS01003999', 1, 'FA');

-- --------------------------------------------------------

--
-- Structure de la table `facture_proforma`
--

DROP TABLE IF EXISTS `facture_proforma`;
CREATE TABLE IF NOT EXISTS `facture_proforma` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acheteur_id` int NOT NULL,
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
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `montant_tva` decimal(10,0) DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_917CA12796A7BB5F` (`acheteur_id`),
  KEY `IDX_917CA127EFA24D68` (`point_vente_id`),
  KEY `IDX_917CA1273F192FC` (`operateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `facture_proforma`
--

INSERT INTO `facture_proforma` (`id`, `acheteur_id`, `date_factpro`, `montant_ht`, `montant_ttc`, `montant_total`, `ref_factpro`, `montant_rest`, `type_remise`, `remise`, `valeur_remise`, `montant_ht_to_apr_rse`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `montant_tva`, `operateur_id`) VALUES
(1, 2, '2023-05-17 00:00:00', '1000.00', '1180.00', '1180.00', 'FP23000001', NULL, NULL, NULL, NULL, '1000', NULL, '2023-05-17 19:51:13', NULL, NULL, 1, NULL, NULL),
(2, 1, '2023-05-19 00:00:00', '8000.00', '9440.00', '9440.00', 'FP23000002', NULL, NULL, '0', NULL, '8000', NULL, '2023-05-19 12:27:36', NULL, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `famille`
--

DROP TABLE IF EXISTS `famille`;
CREATE TABLE IF NOT EXISTS `famille` (
  `id` int NOT NULL AUTO_INCREMENT,
  `famille_parent_id` int DEFAULT NULL,
  `code_famille` varchar(255) NOT NULL,
  `libelle_famille` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2473F21352523166` (`famille_parent_id`),
  KEY `IDX_2473F213EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `famille`
--

INSERT INTO `famille` (`id`, `famille_parent_id`, `code_famille`, `libelle_famille`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, NULL, 'PLOM', 'PLOMBERIE', NULL, '2023-05-04 16:27:04', '2023-05-04 16:27:04', NULL, 1),
(2, NULL, 'CAR', 'CARREAUX', NULL, '2023-06-14 13:17:55', '2023-06-14 13:17:55', NULL, 1),
(3, NULL, 'FER', 'FERAILLAGE', NULL, '2023-06-14 19:35:07', '2023-06-14 19:35:07', NULL, 1),
(4, NULL, 'ELEC', 'ELECTRICITE', NULL, '2023-07-03 09:15:51', '2023-07-03 09:15:51', NULL, 1),
(5, NULL, 'PLOMB', 'PLOMBERIES', NULL, '2023-07-07 08:59:39', '2023-07-07 08:59:39', NULL, 2);

-- --------------------------------------------------------

--
-- Structure de la table `fonction`
--

DROP TABLE IF EXISTS `fonction`;
CREATE TABLE IF NOT EXISTS `fonction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `intitule` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_900D5BDEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `fonction`
--

INSERT INTO `fonction` (`id`, `code`, `intitule`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 'MAG', 'MAGASINIER', NULL, '2023-05-25 15:51:30', '2023-05-25 15:51:30', NULL, NULL),
(2, 'GER', 'GERANT', NULL, '2023-05-25 15:51:01', '2023-05-25 15:51:01', NULL, NULL),
(3, 'COMP', 'COMPTABLE', NULL, '2023-05-25 15:50:41', '2023-05-25 15:50:41', NULL, NULL),
(4, 'CAIS', 'CAISSIERE', NULL, '2023-05-25 15:49:54', '2023-05-25 15:49:54', NULL, NULL),
(5, 'DG', 'Directeur', NULL, '2023-05-25 15:49:12', '2023-05-25 15:49:12', NULL, NULL),
(6, 'test', 'test', 1, '2023-05-10 10:42:55', '2023-05-25 15:51:11', '2023-05-25 15:51:11', NULL),
(7, 'ss', 'ss', NULL, '2023-05-23 13:39:11', NULL, NULL, 1),
(8, 'SSSSSS', 'SSSSS', NULL, '2023-05-23 14:07:25', NULL, NULL, 1),
(9, 'SSS', 'QQQ', NULL, '2023-05-23 14:08:34', NULL, NULL, 1),
(10, 'AAA', 'AAAA', NULL, '2023-05-23 14:17:18', NULL, NULL, 1),
(11, 'aa', 'aaaaa', NULL, '2023-05-23 14:23:21', NULL, NULL, 1),
(12, 'aa', 'aaaaa', NULL, '2023-05-23 14:23:43', NULL, NULL, 1),
(13, 'eee', 'eeee', NULL, '2023-05-23 14:23:57', NULL, NULL, 1),
(14, 'test aa', 'testaa', NULL, '2023-05-26 17:41:32', NULL, NULL, 1),
(15, 'DIR', 'Directeurrr', NULL, '2023-06-02 11:15:19', NULL, NULL, NULL),
(16, 'ok', 'test', NULL, '2023-06-02 11:16:03', NULL, NULL, NULL),
(17, 'dddddd', 'ddddddd', NULL, '2023-06-09 10:29:58', NULL, NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `fonction_personnel`
--

INSERT INTO `fonction_personnel` (`id`, `personnel_id`, `fonction_id`, `est_actif`, `date_debut_fonc`, `date_fin_fonc`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 5, 1, '2023-05-25 00:00:00', NULL, '2023-05-25 15:53:08', NULL, NULL),
(2, 3, 1, 1, '2023-06-09 00:00:00', NULL, '2023-06-09 11:38:41', NULL, NULL),
(3, 1, 5, 1, '2023-06-13 00:00:00', NULL, '2023-06-13 15:25:34', NULL, NULL),
(4, 2, 3, 1, '2023-06-13 00:00:00', NULL, '2023-06-13 15:38:13', NULL, NULL),
(5, 1, 2, 1, '2023-06-05 00:00:00', NULL, '2023-06-14 10:55:53', NULL, NULL),
(6, 2, 5, 1, '2023-06-05 00:00:00', NULL, '2023-06-14 10:56:37', NULL, NULL),
(7, 4, 4, 1, '2023-06-26 00:00:00', NULL, '2023-06-26 19:23:28', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_369ECA32EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`id`, `nom`, `prenoms`, `adresse`, `email`, `tel1`, `tel2`, `date_nais`, `denomination`, `raison_sociale`, `ifu`, `rccm`, `sigle`, `statut`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 'TAUPIN', 'Eric', '7 chemin du rivage', 'rosetteella2@gmail.com', '0678099879', NULL, NULL, NULL, NULL, '3444444444444', NULL, NULL, 'Physique', NULL, '2023-05-11 10:06:08', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `groupe_taxe`
--

DROP TABLE IF EXISTS `groupe_taxe`;
CREATE TABLE IF NOT EXISTS `groupe_taxe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taux_gr_id` int NOT NULL,
  `code_gr` varchar(255) NOT NULL,
  `libelle_gr` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FEDA505EE2FBBC81` (`taux_gr_id`),
  KEY `IDX_FEDA505EEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `groupe_taxe`
--

INSERT INTO `groupe_taxe` (`id`, `taux_gr_id`, `code_gr`, `libelle_gr`, `est_sup`, `point_vente_id`) VALUES
(3, 5, 'A', 'A - EXONERE', NULL, NULL),
(4, 1, 'B', 'B - TAXABLE 18%', NULL, NULL),
(5, 6, 'C', 'C - EXPORTATION', NULL, NULL),
(6, 7, 'D', 'D - TVA REGIME D\'EXCEPTION 18%', NULL, NULL),
(7, 8, 'E', 'E - REGIME TPS', NULL, NULL),
(8, 9, 'F', 'F - RESERVE', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `inventaire`
--

DROP TABLE IF EXISTS `inventaire`;
CREATE TABLE IF NOT EXISTS `inventaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_inv_id` int DEFAULT NULL,
  `date_debut_inv` datetime NOT NULL,
  `date_fin_inv` datetime DEFAULT NULL,
  `motif` longtext NOT NULL,
  `total_debit` decimal(10,2) DEFAULT NULL,
  `total_credit` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `est_cloturer` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_338920E04CB8BE47` (`type_inv_id`),
  KEY `IDX_338920E0EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `inventaire`
--

INSERT INTO `inventaire` (`id`, `type_inv_id`, `date_debut_inv`, `date_fin_inv`, `motif`, `total_debit`, `total_credit`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `est_cloturer`) VALUES
(1, NULL, '2023-06-08 09:52:42', '2023-06-08 10:54:30', 'inventaire d\'ouverture', NULL, NULL, NULL, '2023-06-08 10:54:30', '2023-06-08 10:54:30', NULL, 1, 1);

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
  `libelle` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `etat` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_2B7391E6EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `list_caisse`
--

INSERT INTO `list_caisse` (`id`, `libelle`, `code`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `etat`) VALUES
(1, 'Caisse principal', 'CAI1', NULL, NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `livraison`
--

DROP TABLE IF EXISTS `livraison`;
CREATE TABLE IF NOT EXISTS `livraison` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_cli_id` int NOT NULL,
  `livreur_id` int NOT NULL,
  `date_liv` datetime NOT NULL,
  `montant_liv` decimal(10,2) DEFAULT NULL,
  `ref_liv` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  `total_reste_aliv` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A60C9F1FBE1A1965` (`commande_cli_id`),
  KEY `IDX_A60C9F1FF8646701` (`livreur_id`),
  KEY `IDX_A60C9F1FEFA24D68` (`point_vente_id`),
  KEY `IDX_A60C9F1F3F192FC` (`operateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `livraison`
--

INSERT INTO `livraison` (`id`, `commande_cli_id`, `livreur_id`, `date_liv`, `montant_liv`, `ref_liv`, `created_at`, `updated_at`, `deleted_at`, `est_sup`, `point_vente_id`, `operateur_id`, `total_reste_aliv`) VALUES
(1, 76, 1, '2023-06-07 00:00:00', NULL, 'LI23000001', '2023-06-07 14:15:25', NULL, NULL, NULL, 1, 1, '0'),
(2, 54, 1, '2023-06-07 00:00:00', '0.00', 'LI23000002', '2023-06-07 17:24:47', NULL, NULL, NULL, 1, 1, '111'),
(3, 54, 1, '2023-06-07 00:00:00', '0.00', 'LI23000003', '2023-06-07 17:35:46', NULL, NULL, NULL, 1, 1, '101'),
(4, 144, 1, '2023-06-23 00:00:00', '0.00', 'LI23000004', '2023-06-23 18:35:48', NULL, NULL, NULL, 1, 2, '5'),
(5, 146, 2, '2023-06-26 00:00:00', '0.00', 'LI23000005', '2023-06-26 17:07:36', NULL, NULL, NULL, 1, 2, '10'),
(6, 151, 1, '2023-06-26 00:00:00', '0.00', 'LI23000006', '2023-06-26 20:57:01', NULL, NULL, NULL, 1, 2, '14'),
(7, 151, 1, '2023-06-26 00:00:00', '0.00', 'LI23000007', '2023-06-26 20:57:18', NULL, NULL, NULL, 1, 2, '4'),
(8, 151, 3, '2023-06-26 00:00:00', NULL, 'LI23000008', '2023-06-26 20:57:34', NULL, NULL, NULL, 1, 2, '0'),
(9, 152, 1, '2023-06-26 00:00:00', NULL, 'LI23000009', '2023-06-26 21:01:43', NULL, NULL, NULL, 1, 2, '0'),
(10, 164, 1, '2023-07-11 00:00:00', NULL, 'LI23000010', '2023-07-11 17:52:59', NULL, NULL, NULL, 2, 2, '0'),
(11, 165, 2, '2023-07-11 00:00:00', NULL, 'LI23000011', '2023-07-11 18:11:52', NULL, NULL, NULL, 2, 2, '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

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
(10, 10, 4, NULL),
(11, 11, 4, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `magasin`
--

DROP TABLE IF EXISTS `magasin`;
CREATE TABLE IF NOT EXISTS `magasin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `superviseur_id` int DEFAULT NULL,
  `nom_mag` varchar(255) NOT NULL,
  `code_mag` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `est_defaut` tinyint(1) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_54AF5F27B7BB80FF` (`superviseur_id`),
  KEY `IDX_54AF5F27EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `magasin`
--

INSERT INTO `magasin` (`id`, `superviseur_id`, `nom_mag`, `code_mag`, `adresse`, `est_defaut`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, 1, 'MAGASIN STE RITA', 'MSR', 'STE RITA', NULL, NULL, '2023-05-04 16:31:24', '2023-05-04 16:31:24', NULL, 1),
(2, 1, 'MAGASIN STE RITA EX', 'MSE', 'STE RITA', NULL, NULL, '2023-05-04 16:31:24', '2023-05-04 16:31:24', NULL, 1),
(3, 1, 'Magasin 3', 'mag3', 'cotonou', NULL, NULL, '2023-05-19 16:28:12', '2023-05-19 16:28:13', NULL, 1),
(4, 6, 'MAGASIN TOGOUDO', 'MTOG', 'TOGOUDO CARREFOUR', NULL, NULL, '2023-07-07 09:54:03', '2023-07-07 09:54:04', NULL, 2);

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int DEFAULT NULL,
  `nom_media` varchar(255) DEFAULT NULL,
  `chemin_media` varchar(80) DEFAULT NULL,
  `num_media` varchar(255) DEFAULT NULL,
  `extension` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6A2CA10CF347EFB` (`produit_id`),
  KEY `IDX_6A2CA10CEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `media`
--

INSERT INTO `media` (`id`, `produit_id`, `nom_media`, `chemin_media`, `num_media`, `extension`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, NULL, 'photo_entete_romas.jpg', NULL, '', 'jpg', NULL, '2023-05-17 11:48:54', '2023-05-25 17:13:08', NULL, NULL),
(7, NULL, 'Image1.gif', NULL, '', 'gif', NULL, '2023-06-01 15:14:31', '2023-06-01 15:15:55', NULL, NULL),
(8, 8, 'Image1.gif', NULL, '', 'gif', NULL, '2023-06-06 18:33:17', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_superieur_id` int DEFAULT NULL,
  `sous_titre` varchar(255) DEFAULT NULL,
  `titre` varchar(255) NOT NULL,
  `url` varchar(4000) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `icon` longtext,
  `type_menu` varchar(2) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7D053A93F9ADC1B4` (`menu_superieur_id`),
  KEY `IDX_7D053A93EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `menu`
--

INSERT INTO `menu` (`id`, `menu_superieur_id`, `sous_titre`, `titre`, `url`, `active`, `icon`, `type_menu`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`) VALUES
(1, NULL, 'Configuration', 'Application', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path d=\"M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(2, 1, NULL, 'Menu', 'app_menu_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, 'ADMINISTRATION', 'Sécurité', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path d=\"M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(4, 3, NULL, 'Profil', '', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 3, NULL, 'Role', '', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 3, NULL, 'Utilisateur', 'app_utilisateur_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(7, NULL, 'Etat et Statistique', 'Etat', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path d=\"M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z\" fill=\"currentColor\"></path>\r\n                                        <path opacity=\"0.3\" d=\"M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(8, 7, NULL, 'Mouvement des stocks', 'romassigcom_mouvement_stock', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 7, NULL, 'Statistique des ventes', 'romassigcom_statistique_vente', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 7, NULL, 'Point des commandes', 'romassigcom_point_commande', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 7, NULL, 'Statistique sur les produits', 'romassigcom_etat_produit', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 7, NULL, 'Statistique sur les clients', 'romassigcom_etat_client', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 7, NULL, 'Fiches', 'romassigcom_etat_fiche', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(14, NULL, 'STANDARD', 'Paramètre', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                        <path opacity=\"0.3\" d=\"M22.1 11.5V12.6C22.1 13.2 21.7 13.6 21.2 13.7L19.9 13.9C19.7 14.7 19.4 15.5 18.9 16.2L19.7 17.2999C20 17.6999 20 18.3999 19.6 18.7999L18.8 19.6C18.4 20 17.8 20 17.3 19.7L16.2 18.9C15.5 19.3 14.7 19.7 13.9 19.9L13.7 21.2C13.6 21.7 13.1 22.1 12.6 22.1H11.5C10.9 22.1 10.5 21.7 10.4 21.2L10.2 19.9C9.4 19.7 8.6 19.4 7.9 18.9L6.8 19.7C6.4 20 5.7 20 5.3 19.6L4.5 18.7999C4.1 18.3999 4.1 17.7999 4.4 17.2999L5.2 16.2C4.8 15.5 4.4 14.7 4.2 13.9L2.9 13.7C2.4 13.6 2 13.1 2 12.6V11.5C2 10.9 2.4 10.5 2.9 10.4L4.2 10.2C4.4 9.39995 4.7 8.60002 5.2 7.90002L4.4 6.79993C4.1 6.39993 4.1 5.69993 4.5 5.29993L5.3 4.5C5.7 4.1 6.3 4.10002 6.8 4.40002L7.9 5.19995C8.6 4.79995 9.4 4.39995 10.2 4.19995L10.4 2.90002C10.5 2.40002 11 2 11.5 2H12.6C13.2 2 13.6 2.40002 13.7 2.90002L13.9 4.19995C14.7 4.39995 15.5 4.69995 16.2 5.19995L17.3 4.40002C17.7 4.10002 18.4 4.1 18.8 4.5L19.6 5.29993C20 5.69993 20 6.29993 19.7 6.79993L18.9 7.90002C19.3 8.60002 19.7 9.39995 19.9 10.2L21.2 10.4C21.7 10.5 22.1 11 22.1 11.5ZM12.1 8.59998C10.2 8.59998 8.6 10.2 8.6 12.1C8.6 14 10.2 15.6 12.1 15.6C14 15.6 15.6 14 15.6 12.1C15.6 10.2 14 8.59998 12.1 8.59998Z\" fill=\"currentColor\"></path>\r\n                                        <path d=\"M17.1 12.1C17.1 14.9 14.9 17.1 12.1 17.1C9.30001 17.1 7.10001 14.9 7.10001 12.1C7.10001 9.29998 9.30001 7.09998 12.1 7.09998C14.9 7.09998 17.1 9.29998 17.1 12.1ZM12.1 10.1C11 10.1 10.1 11 10.1 12.1C10.1 13.2 11 14.1 12.1 14.1C13.2 14.1 14.1 13.2 14.1 12.1C14.1 11 13.2 10.1 12.1 10.1Z\" fill=\"currentColor\"></path>\r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(15, 14, NULL, 'Société', 'app_societe_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 14, NULL, 'Produit', 'app_produit_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 14, NULL, 'Personnel', 'app_personnel_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 14, NULL, 'Fonction', 'app_fonction_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 14, NULL, 'Famille', 'app_famille_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 14, NULL, 'Mode de paiement', 'app_mode_paiement_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 14, NULL, 'Banque', 'app_banque_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 14, NULL, 'Magasin', 'app_magasin_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 14, NULL, 'Conditionnement', 'app_conditionnement_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 14, NULL, 'Fournisseur', 'app_fournisseur_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 14, NULL, 'Client', 'app_client_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 14, NULL, 'Monnaie', 'app_monnaie_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 14, NULL, 'Type d\'opération', 'app_type_operation_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 14, NULL, 'Taxe', 'app_taxe_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 14, NULL, 'Point de vente', 'app_point_de_vente_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(30, NULL, '', 'Gestion de la vente', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"512\" height=\"512\" viewBox=\"0 0 512 512\" fill=\"currentColor\">\r\n                                        <!--! Font Awesome Free 6.3.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2023 Fonticons, Inc. -->\r\n                                        <path d=\"M64 0C46.3 0 32 14.3 32 32V96c0 17.7 14.3 32 32 32h80v32H87c-31.6 0-58.5 23.1-63.3 54.4L1.1 364.1C.4 368.8 0 373.6 0 378.4V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V378.4c0-4.8-.4-9.6-1.1-14.4L488.2 214.4C483.5 183.1 456.6 160 425 160H208V128h80c17.7 0 32-14.3 32-32V32c0-17.7-14.3-32-32-32H64zM96 48H256c8.8 0 16 7.2 16 16s-7.2 16-16 16H96c-8.8 0-16-7.2-16-16s7.2-16 16-16zM64 432c0-8.8 7.2-16 16-16H432c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm48-168a24 24 0 1 1 0-48 24 24 0 1 1 0 48zm120-24a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM160 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM328 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM256 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM424 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM352 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48z\"/>\r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(31, 30, NULL, 'Vente', 'app_commande_client_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(32, NULL, '', 'Gestion de stock', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg style=\"color: white\" width=\"48\" height=\"48\" viewBox=\"0 0 48 48\"  fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> \r\n                                        <path d=\"M27.707 6.29289C28.0975 6.68342 28.0975 7.31658 27.707 7.70711L25.4143 9.99976L27.7071 12.2925C28.0976 12.683 28.0976 13.3162 27.7071 13.7067C27.3166 14.0973 26.6834 14.0973 26.2929 13.7067L24.0001 11.414L21.7074 13.7067C21.3168 14.0973 20.6837 14.0973 20.2931 13.7067C19.9026 13.3162 19.9026 12.683 20.2931 12.2925L22.5859 9.99976L20.2933 7.70711C19.9027 7.31658 19.9027 6.68342 20.2933 6.29289C20.6838 5.90237 21.317 5.90237 21.7075 6.29289L24.0001 8.58554L26.2928 6.29289C26.6833 5.90237 27.3165 5.90237 27.707 6.29289Z\" fill=\"white\"></path> \r\n                                        <path d=\"M19.1975 32.7281C20.5767 33.1878 22.0855 32.7454 23 31.6401L23 42.0231L11 37.5V29.9956L19.1975 32.7281Z\" fill=\"white\"></path> \r\n                                        <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M37 37.5L25 42.0231V31.6401C25.9145 32.7454 27.4234 33.1878 28.8025 32.7281L37 29.9956V37.5Z\" fill=\"white\"></path> \r\n                                        <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M24.3271 15.055C24.1152 14.9817 23.8848 14.9817 23.6729 15.055L10.6748 19.5544L10.6525 19.5623C10.4711 19.6295 10.3204 19.7441 10.2096 19.8872L6.21914 24.8753C6.01489 25.1306 5.94836 25.4697 6.04096 25.7832C6.13356 26.0968 6.3736 26.3453 6.68378 26.4487L20.1838 30.9487C20.6036 31.0886 21.0655 30.936 21.3192 30.5735L24 26.7438L26.6808 30.5735C26.9346 30.936 27.3964 31.0886 27.8162 30.9487L41.3162 26.4487C41.6264 26.3453 41.8665 26.0968 41.9591 25.7832C42.0517 25.4697 41.9851 25.1306 41.7809 24.8753L37.7904 19.8872C37.6803 19.7449 37.5306 19.6307 37.3505 19.5634C37.3421 19.5603 37.3336 19.5572 37.3251 19.5543L24.3271 15.055ZM24 23.9418L33.9429 20.5L24 17.0582L14.0571 20.5L24 23.9418Z\" fill=\"white\"></path> \r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(33, 32, NULL, 'Suivi de Stock', 'app_stock_en_unite', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 32, NULL, 'Approvisionnement', 'app_approvisionnement_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 32, NULL, 'Sortie', 'app_sortie_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 32, NULL, 'Transfert', 'app_transfert_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 32, NULL, 'Livraison client', 'app_livraison_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(38, 32, NULL, 'Inventaire', 'app_inventaire_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(39, NULL, '', 'Gestion de portefeuilles', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\"\r\n                                                 viewBox=\"0 0 24 24\" fill=\"none\">\r\n                                                <rect x=\"2\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\" fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"2\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                            </svg>\r\n                                        </span>', NULL, NULL, NULL, NULL, NULL),
(40, 39, NULL, 'Transaction', 'app_transaction_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 39, NULL, 'Compte', 'app_compte_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(42, NULL, '', 'Gestion de la caisse', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"512\" height=\"512\" viewBox=\"0 0 512 512\" fill=\"currentColor\">\r\n                                        <!--! Font Awesome Free 6.3.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2023 Fonticons, Inc. -->\r\n                                        <path d=\"M64 0C46.3 0 32 14.3 32 32V96c0 17.7 14.3 32 32 32h80v32H87c-31.6 0-58.5 23.1-63.3 54.4L1.1 364.1C.4 368.8 0 373.6 0 378.4V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V378.4c0-4.8-.4-9.6-1.1-14.4L488.2 214.4C483.5 183.1 456.6 160 425 160H208V128h80c17.7 0 32-14.3 32-32V32c0-17.7-14.3-32-32-32H64zM96 48H256c8.8 0 16 7.2 16 16s-7.2 16-16 16H96c-8.8 0-16-7.2-16-16s7.2-16 16-16zM64 432c0-8.8 7.2-16 16-16H432c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm48-168a24 24 0 1 1 0-48 24 24 0 1 1 0 48zm120-24a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM160 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM328 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM256 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM424 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM352 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48z\"/>\r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(43, 42, NULL, 'Paiement', 'app_paiement_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 42, NULL, 'Dépôt', 'app_transaction_depot', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(45, NULL, '', 'Gestion des fournisseurs', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\"\r\n                                                 viewBox=\"0 0 24 24\" fill=\"none\">\r\n                                                <rect x=\"2\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\" fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"13\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                                <rect opacity=\"0.3\" x=\"2\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                      fill=\"currentColor\"/>\r\n                                            </svg>\r\n                                        </span>', NULL, NULL, NULL, NULL, NULL),
(46, 45, NULL, 'Demande de prix', 'app_demande_de_prix_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(47, NULL, '', 'Gestion des factures', '', 0, '<span class=\"svg-icon svg-icon-2\">\r\n                                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\"\r\n                                            viewBox=\"0 0 24 24\" fill=\"none\">\r\n                                        <rect x=\"2\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\" fill=\"currentColor\"/>\r\n                                        <rect opacity=\"0.3\" x=\"13\" y=\"2\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                fill=\"currentColor\"/>\r\n                                        <rect opacity=\"0.3\" x=\"13\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                fill=\"currentColor\"/>\r\n                                        <rect opacity=\"0.3\" x=\"2\" y=\"13\" width=\"9\" height=\"9\" rx=\"2\"\r\n                                                fill=\"currentColor\"/>\r\n                                    </svg>\r\n                                </span>', NULL, NULL, NULL, NULL, NULL),
(48, 47, NULL, 'Facture', 'app_facture_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 47, NULL, 'Facture proforma', 'app_facture_proforma_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 14, NULL, 'Caisse', 'app_list_caisse_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 45, NULL, 'Commande fournisseur', 'app_commande_frs_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 14, NULL, 'Model Signataire', 'app_model_signataire_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 14, NULL, 'Modèle Signataire', 'app_model_signataire_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 14, NULL, 'Type de Dépense', 'app_type_depense_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 42, NULL, 'Dépense', 'app_depense_index', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 3, NULL, 'Configuration', 'app_configuration_index', 0, NULL, NULL, NULL, NULL, NULL, NULL);

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
  `est_default` tinyint(1) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4D1B8005EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `model_signataire`
--

INSERT INTO `model_signataire` (`id`, `est_default`, `libelle`, `created_at`, `updated_at`, `deleted_at`, `point_vente_id`, `est_sup`) VALUES
(1, 0, 'AAAA', '2023-05-17 19:58:39', '2023-05-18 16:31:49', '2023-05-18 16:31:49', NULL, 1),
(2, 0, 'qqqq', '2023-05-17 20:24:36', NULL, NULL, 1, NULL),
(3, 0, 'MODEL DE SIGNATURE N3', '2023-05-18 16:27:17', NULL, NULL, 1, NULL),
(4, 1, 'MODELE A', '2023-05-25 15:53:41', '2023-05-25 15:53:41', NULL, 2, NULL),
(6, 0, 'Model 11', '2023-06-29 15:21:04', '2023-06-29 15:21:04', NULL, 1, NULL),
(7, 0, 'test', '2023-06-29 15:22:06', '2023-06-29 15:22:06', NULL, 1, NULL);

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
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_17B9DBC91C109075` (`personnel_id`),
  KEY `IDX_17B9DBC957889920` (`fonction_id`),
  KEY `IDX_17B9DBC9D16C5631` (`model_signataire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `model_signataire_personnel_fonction`
--

INSERT INTO `model_signataire_personnel_fonction` (`id`, `personnel_id`, `fonction_id`, `model_signataire_id`, `created_at`, `updated_at`, `deleted_at`, `est_sup`) VALUES
(1, 1, 2, 1, '2023-05-26 10:21:47', NULL, NULL, NULL),
(2, 1, 2, 2, '2023-05-26 10:21:47', NULL, NULL, NULL),
(3, 1, 5, 3, '2023-05-26 10:21:47', NULL, NULL, NULL),
(4, 1, 2, 4, '2023-05-26 10:21:47', NULL, NULL, NULL),
(5, 2, 5, 4, '2023-05-26 10:21:47', NULL, NULL, NULL),
(6, 1, 1, 6, '2023-05-26 09:23:54', NULL, NULL, NULL),
(7, 2, 2, 6, '2023-05-26 09:23:54', '2023-06-29 14:20:41', '2023-06-29 14:20:41', 1),
(8, 1, 3, 7, '2023-06-29 15:21:35', NULL, NULL, NULL),
(9, 2, 3, 7, '2023-06-29 15:22:06', NULL, NULL, NULL),
(10, 3, 2, 7, '2023-06-29 15:22:06', '2023-06-29 15:23:11', '2023-06-29 15:23:11', 1);

-- --------------------------------------------------------

--
-- Structure de la table `mode_paiement`
--

DROP TABLE IF EXISTS `mode_paiement`;
CREATE TABLE IF NOT EXISTS `mode_paiement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B2BB0E85EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `mode_paiement`
--

INSERT INTO `mode_paiement` (`id`, `code`, `libelle`, `est_sup`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ESP', 'ESPECES', 1, NULL, '2023-05-19 21:09:57', '2023-05-26 14:07:56', '2023-05-26 14:07:56'),
(2, 'CHQ', 'CHEQUES', 1, NULL, '2023-05-19 21:09:57', '2023-06-21 09:14:32', '2023-06-21 09:14:32'),
(3, 'VIR', 'VIREMENTS', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(4, 'MMO', 'MOBILE MONEY', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(5, 'ES', 'ESPECES', NULL, 1, '2023-05-26 14:08:21', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `monnaie`
--

DROP TABLE IF EXISTS `monnaie`;
CREATE TABLE IF NOT EXISTS `monnaie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  `valeur` int NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B3A6E2E6EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `monnaie`
--

INSERT INTO `monnaie` (`id`, `libelle`, `valeur`, `est_sup`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '5F CFA', 5, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(2, '10F CFA', 10, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(3, '25F CFA', 25, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(4, '50F CFA', 50, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(5, '100F CFA', 100, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(6, '200F CFA', 200, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(7, '250F CFA', 250, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(8, '500F CFA', 500, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(9, '1000F CFA', 1000, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(10, '2000F CFA', 2000, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(11, '5000F CFA', 5000, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(12, '10000F CFA', 10000, NULL, NULL, '2023-05-19 21:09:57', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `monnaie_caisse`
--

INSERT INTO `monnaie_caisse` (`id`, `caisse_id`, `monnaie_id`, `nbr`, `montant`, `etat`) VALUES
(1, 1, 12, 6, '60000', 0),
(2, 1, 11, 0, '0', 0),
(3, 1, 10, 0, '0', 0),
(4, 1, 9, 0, '0', 0),
(5, 1, 8, 30, '15000', 0),
(6, 1, 7, 0, '0', 0),
(7, 1, 6, 0, '0', 0),
(8, 1, 5, 0, '0', 0),
(9, 1, 4, 1, '50', 0),
(10, 1, 3, 0, '0', 0),
(11, 1, 2, 0, '0', 0),
(12, 1, 1, 0, '0', 0),
(13, 2, 12, 10, '100000', 0),
(14, 2, 11, 0, '0', 0),
(15, 2, 10, 0, '0', 0),
(16, 2, 9, 0, '0', 0),
(17, 2, 8, 0, '0', 0),
(18, 2, 7, 0, '0', 0),
(19, 2, 6, 0, '0', 0),
(20, 2, 5, 0, '0', 0),
(21, 2, 4, 0, '0', 0),
(22, 2, 3, 0, '0', 0),
(23, 2, 2, 0, '0', 0),
(24, 2, 1, 0, '0', 0),
(25, 3, 12, 1, '10000', 0),
(26, 3, 11, 0, '0', 0),
(27, 3, 10, 10, '20000', 0),
(28, 3, 9, 0, '0', 0),
(29, 3, 8, 0, '0', 0),
(30, 3, 7, 0, '0', 0),
(31, 3, 6, 0, '0', 0),
(32, 3, 5, 0, '0', 0),
(33, 3, 4, 0, '0', 0),
(34, 3, 3, 0, '0', 0),
(35, 3, 2, 0, '0', 0),
(36, 3, 1, 0, '0', 0),
(37, 4, 12, 10, '100000', 0),
(38, 4, 11, 0, '0', 0),
(39, 4, 10, 0, '0', 0),
(40, 4, 9, 0, '0', 0),
(41, 4, 8, 0, '0', 0),
(42, 4, 7, 0, '0', 0),
(43, 4, 6, 0, '0', 0),
(44, 4, 5, 0, '0', 0),
(45, 4, 4, 0, '0', 0),
(46, 4, 3, 0, '0', 0),
(47, 4, 2, 0, '0', 0),
(48, 4, 1, 0, '0', 0),
(49, 5, 12, 1, '10000', 0),
(50, 5, 11, 0, '0', 0),
(51, 5, 10, 0, '0', 0),
(52, 5, 9, 0, '0', 0),
(53, 5, 8, 0, '0', 0),
(54, 5, 7, 0, '0', 0),
(55, 5, 6, 0, '0', 0),
(56, 5, 5, 0, '0', 0),
(57, 5, 4, 0, '0', 0),
(58, 5, 3, 0, '0', 0),
(59, 5, 2, 0, '0', 0),
(60, 5, 1, 0, '0', 0),
(61, 6, 12, 10, '100000', 0),
(62, 6, 11, 0, '0', 0),
(63, 6, 10, 0, '0', 0),
(64, 6, 9, 0, '0', 0),
(65, 6, 8, 0, '0', 0),
(66, 6, 7, 0, '0', 0),
(67, 6, 6, 0, '0', 0),
(68, 6, 5, 0, '0', 0),
(69, 6, 4, 0, '0', 0),
(70, 6, 3, 0, '0', 0),
(71, 6, 2, 0, '0', 0),
(72, 6, 1, 0, '0', 0),
(73, 7, 12, 10, '100000', 0),
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
(85, 8, 12, 20, '200000', 0),
(86, 8, 11, 0, '0', 0),
(87, 8, 10, 0, '0', 0),
(88, 8, 9, 0, '0', 0),
(89, 8, 8, 0, '0', 0),
(90, 8, 7, 0, '0', 0),
(91, 8, 6, 0, '0', 0),
(92, 8, 5, 0, '0', 0),
(93, 8, 4, 0, '0', 0),
(94, 8, 3, 0, '0', 0),
(95, 8, 2, 0, '0', 0),
(96, 8, 1, 0, '0', 0),
(97, 9, 12, 10, '100000', 0),
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
(109, 10, 12, 10, '100000', 0),
(110, 10, 11, 0, '0', 0),
(111, 10, 10, 0, '0', 0),
(112, 10, 9, 0, '0', 0),
(113, 10, 8, 0, '0', 0),
(114, 10, 7, 0, '0', 0),
(115, 10, 6, 0, '0', 0),
(116, 10, 5, 0, '0', 0),
(117, 10, 4, 0, '0', 0),
(118, 10, 3, 0, '0', 0),
(119, 10, 2, 0, '0', 0),
(120, 10, 1, 0, '0', 0),
(121, 11, 12, 10, '100000', 0),
(122, 11, 11, 0, '0', 0),
(123, 11, 10, 0, '0', 0),
(124, 11, 9, 0, '0', 0),
(125, 11, 8, 0, '0', 0),
(126, 11, 7, 0, '0', 0),
(127, 11, 6, 0, '0', 0),
(128, 11, 5, 0, '0', 0),
(129, 11, 4, 0, '0', 0),
(130, 11, 3, 0, '0', 0),
(131, 11, 2, 0, '0', 0),
(132, 11, 1, 0, '0', 0),
(133, 12, 12, 10, '100000', 0),
(134, 12, 11, 0, '0', 0),
(135, 12, 10, 0, '0', 0),
(136, 12, 9, 0, '0', 0),
(137, 12, 8, 0, '0', 0),
(138, 12, 7, 0, '0', 0),
(139, 12, 6, 0, '0', 0),
(140, 12, 5, 0, '0', 0),
(141, 12, 4, 0, '0', 0),
(142, 12, 3, 0, '0', 0),
(143, 12, 2, 0, '0', 0),
(144, 12, 1, 0, '0', 0),
(145, 13, 12, 1, '10000', 0),
(146, 13, 11, 0, '0', 0),
(147, 13, 10, 0, '0', 0),
(148, 13, 9, 0, '0', 0),
(149, 13, 8, 0, '0', 0),
(150, 13, 7, 0, '0', 0),
(151, 13, 6, 0, '0', 0),
(152, 13, 5, 0, '0', 0),
(153, 13, 4, 0, '0', 0),
(154, 13, 3, 0, '0', 0),
(155, 13, 2, 0, '0', 0),
(156, 13, 1, 0, '0', 0),
(157, 14, 12, 10, '100000', 0),
(158, 14, 11, 0, '0', 0),
(159, 14, 10, 0, '0', 0),
(160, 14, 9, 0, '0', 0),
(161, 14, 8, 0, '0', 0),
(162, 14, 7, 0, '0', 0),
(163, 14, 6, 0, '0', 0),
(164, 14, 5, 0, '0', 0),
(165, 14, 4, 0, '0', 0),
(166, 14, 3, 0, '0', 0),
(167, 14, 2, 0, '0', 0),
(168, 14, 1, 0, '0', 0),
(169, 15, 12, 11, '110000', 0),
(170, 15, 11, 0, '0', 0),
(171, 15, 10, 0, '0', 0),
(172, 15, 9, 0, '0', 0),
(173, 15, 8, 0, '0', 0),
(174, 15, 7, 0, '0', 0),
(175, 15, 6, 0, '0', 0),
(176, 15, 5, 0, '0', 0),
(177, 15, 4, 0, '0', 0),
(178, 15, 3, 0, '0', 0),
(179, 15, 2, 0, '0', 0),
(180, 15, 1, 0, '0', 0),
(181, 16, 12, 10, '100000', 0),
(182, 16, 11, 0, '0', 0),
(183, 16, 10, 0, '0', 0),
(184, 16, 9, 0, '0', 0),
(185, 16, 8, 0, '0', 0),
(186, 16, 7, 0, '0', 0),
(187, 16, 6, 0, '0', 0),
(188, 16, 5, 0, '0', 0),
(189, 16, 4, 0, '0', 0),
(190, 16, 3, 0, '0', 0),
(191, 16, 2, 0, '0', 0),
(192, 16, 1, 0, '0', 0),
(193, 17, 12, 10, '100000', 0),
(194, 17, 11, 0, '0', 0),
(195, 17, 10, 0, '0', 0),
(196, 17, 9, 0, '0', 0),
(197, 17, 8, 0, '0', 0),
(198, 17, 7, 0, '0', 0),
(199, 17, 6, 0, '0', 0),
(200, 17, 5, 0, '0', 0),
(201, 17, 4, 0, '0', 0),
(202, 17, 3, 0, '0', 0),
(203, 17, 2, 0, '0', 0),
(204, 17, 1, 0, '0', 0),
(205, 18, 12, 10, '100000', 0),
(206, 18, 11, 0, '0', 0),
(207, 18, 10, 0, '0', 0),
(208, 18, 9, 0, '0', 0),
(209, 18, 8, 0, '0', 0),
(210, 18, 7, 0, '0', 0),
(211, 18, 6, 0, '0', 0),
(212, 18, 5, 0, '0', 0),
(213, 18, 4, 0, '0', 0),
(214, 18, 3, 0, '0', 0),
(215, 18, 2, 0, '0', 0),
(216, 18, 1, 0, '0', 0),
(217, 19, 12, 50, '500000', 0),
(218, 19, 11, 0, '0', 0),
(219, 19, 10, 0, '0', 0),
(220, 19, 9, 0, '0', 0),
(221, 19, 8, 20, '10000', 0),
(222, 19, 7, 0, '0', 0),
(223, 19, 6, 0, '0', 0),
(224, 19, 5, 0, '0', 0),
(225, 19, 4, 0, '0', 0),
(226, 19, 3, 0, '0', 0),
(227, 19, 2, 0, '0', 0),
(228, 19, 1, 0, '0', 0),
(229, 20, 12, 1, '10000', 0),
(230, 20, 11, 0, '0', 0),
(231, 20, 10, 0, '0', 0),
(232, 20, 9, 0, '0', 0),
(233, 20, 8, 0, '0', 0),
(234, 20, 7, 0, '0', 0),
(235, 20, 6, 0, '0', 0),
(236, 20, 5, 0, '0', 0),
(237, 20, 4, 0, '0', 0),
(238, 20, 3, 0, '0', 0),
(239, 20, 2, 0, '0', 0),
(240, 20, 1, 0, '0', 0);

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
  `date_paie` datetime NOT NULL,
  `montant_paye` decimal(10,2) NOT NULL,
  `montant_rapayer` decimal(10,2) NOT NULL,
  `ref_paie` varchar(255) NOT NULL,
  `numero_mobile_money` varchar(255) DEFAULT NULL,
  `ref_operation` varchar(255) DEFAULT NULL,
  `montant_recu` decimal(10,0) DEFAULT '0',
  `reliquat` decimal(10,0) DEFAULT '0',
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `caisse_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `operateur_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B1DC7A1E438F5B63` (`mode_paiement_id`),
  KEY `IDX_B1DC7A1E7F2DEE08` (`facture_id`),
  KEY `IDX_B1DC7A1E2FC0CB0F` (`transaction_id`),
  KEY `IDX_B1DC7A1E37E080D9` (`banque_id`),
  KEY `IDX_B1DC7A1EEFA24D68` (`point_vente_id`),
  KEY `IDX_B1DC7A1E27B4FEBF` (`caisse_id`),
  KEY `IDX_B1DC7A1E3F192FC` (`operateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `paiement`
--

INSERT INTO `paiement` (`id`, `mode_paiement_id`, `facture_id`, `transaction_id`, `banque_id`, `date_paie`, `montant_paye`, `montant_rapayer`, `ref_paie`, `numero_mobile_money`, `ref_operation`, `montant_recu`, `reliquat`, `est_sup`, `point_vente_id`, `caisse_id`, `created_at`, `updated_at`, `deleted_at`, `operateur_id`) VALUES
(1, 1, 1, NULL, NULL, '2023-05-12 18:21:33', '1180.00', '0.00', 'PA23000001', NULL, NULL, '1500', '320', NULL, 1, NULL, '2023-05-19 22:53:25', NULL, NULL, NULL),
(2, 1, 2, NULL, NULL, '2023-05-25 20:33:44', '16000.00', '0.00', 'PA23000002', NULL, NULL, '20000', '4000', NULL, 1, 5, '2023-05-25 20:33:44', NULL, NULL, 1),
(3, 1, 3, NULL, NULL, '2023-05-25 20:35:46', '1000.00', '0.00', 'PA23000003', NULL, NULL, '1000', '0', NULL, 1, 5, '2023-05-25 20:35:46', NULL, NULL, 1),
(4, 1, 4, NULL, NULL, '2023-05-31 19:43:11', '1000.00', '0.00', 'PA23000004', NULL, NULL, '1000', '0', NULL, 1, 6, '2023-05-31 19:43:11', NULL, NULL, 1),
(5, 1, 5, NULL, NULL, '2023-06-02 11:14:01', '1000.00', '0.00', 'PA23000005', NULL, NULL, '1000', '0', NULL, 1, 7, '2023-06-02 11:14:01', NULL, NULL, 1),
(6, 1, 6, NULL, NULL, '2023-06-02 11:50:57', '1000.00', '0.00', 'PA23000006', NULL, NULL, '1000', '0', NULL, 1, 7, '2023-06-02 11:50:57', NULL, NULL, 1),
(7, 1, 7, NULL, NULL, '2023-06-02 19:54:04', '1.00', '0.00', 'PA23000007', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 19:54:04', NULL, NULL, 1),
(8, 1, 8, NULL, NULL, '2023-06-02 19:56:49', '1.00', '0.00', 'PA23000008', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 19:56:49', NULL, NULL, 1),
(9, 1, 9, NULL, NULL, '2023-06-02 19:58:45', '1.00', '0.00', 'PA23000009', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 19:58:45', NULL, NULL, 1),
(10, 1, 10, NULL, NULL, '2023-06-02 19:59:30', '1.00', '0.00', 'PA23000010', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 19:59:30', NULL, NULL, 1),
(11, 1, 11, NULL, NULL, '2023-06-02 20:01:26', '1.00', '0.00', 'PA23000011', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 20:01:26', NULL, NULL, 1),
(12, 1, 12, NULL, NULL, '2023-06-02 20:03:05', '1.00', '0.00', 'PA23000012', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 20:03:05', NULL, NULL, 1),
(13, 1, 13, NULL, NULL, '2023-06-02 20:04:36', '1.00', '0.00', 'PA23000013', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 20:04:36', NULL, NULL, 1),
(14, 1, 14, NULL, NULL, '2023-06-02 20:25:00', '1.00', '0.00', 'PA23000014', NULL, NULL, '1', '0', NULL, 1, 14, '2023-06-02 20:25:00', NULL, NULL, 1),
(15, 1, 15, NULL, NULL, '2023-06-05 07:53:58', '1.00', '0.00', 'PA23000015', NULL, NULL, '1', '0', NULL, 1, 1, '2023-06-05 07:53:58', NULL, NULL, 1),
(16, 1, 16, NULL, NULL, '2023-06-05 07:57:20', '1.00', '0.00', 'PA23000016', NULL, NULL, '1', '0', NULL, 1, 1, '2023-06-05 07:57:20', NULL, NULL, 1),
(17, 1, 17, NULL, NULL, '2023-06-05 07:58:34', '1.00', '0.00', 'PA23000017', NULL, NULL, '1', '0', NULL, 1, 1, '2023-06-05 07:58:34', NULL, NULL, 1),
(18, 1, 18, NULL, NULL, '2023-06-05 08:05:08', '1.00', '0.00', 'PA23000018', NULL, NULL, '1', '0', NULL, 1, 1, '2023-06-05 08:05:08', NULL, NULL, 1),
(19, 1, 19, NULL, NULL, '2023-06-05 08:15:53', '1.00', '0.00', 'PA23000019', NULL, NULL, '1', '0', NULL, 1, 1, '2023-06-05 08:15:53', NULL, NULL, 1),
(20, 1, 20, NULL, NULL, '2023-06-06 00:28:11', '333000.00', '0.00', 'PA23000020', NULL, NULL, '340000', '7000', NULL, 1, 2, '2023-06-06 00:28:11', NULL, NULL, 1),
(21, 1, 21, NULL, NULL, '2023-06-06 00:30:08', '33000.00', '0.00', 'PA23000021', NULL, NULL, '40000', '7000', NULL, 1, 2, '2023-06-06 00:30:09', NULL, NULL, 1),
(22, 1, 22, NULL, NULL, '2023-06-06 10:18:10', '1.00', '0.00', 'PA23000022', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 10:18:10', NULL, NULL, 1),
(23, 1, 23, NULL, NULL, '2023-06-06 10:18:49', '1.00', '0.00', 'PA23000023', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 10:18:49', NULL, NULL, 1),
(24, 1, 24, NULL, NULL, '2023-06-06 10:22:06', '1.00', '0.00', 'PA23000024', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 10:22:06', NULL, NULL, 1),
(25, 1, 25, NULL, NULL, '2023-06-06 10:24:40', '1.00', '0.00', 'PA23000025', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 10:24:40', NULL, NULL, 1),
(26, 1, 26, NULL, NULL, '2023-06-06 10:24:42', '1.00', '0.00', 'PA23000026', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 10:24:42', NULL, NULL, 1),
(27, 1, 27, NULL, NULL, '2023-06-06 10:26:33', '1.00', '0.00', 'PA23000027', NULL, NULL, '0', '0', NULL, 1, 2, '2023-06-06 10:26:33', NULL, NULL, 1),
(28, 1, 28, NULL, NULL, '2023-06-06 10:27:37', '1.00', '0.00', 'PA23000028', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 10:27:37', NULL, NULL, 1),
(29, 1, 29, NULL, NULL, '2023-06-06 10:29:18', '1.00', '0.00', 'PA23000029', NULL, NULL, '0', '0', NULL, 1, 2, '2023-06-06 10:29:18', NULL, NULL, 1),
(30, 1, 30, NULL, NULL, '2023-06-06 10:30:37', '1.00', '0.00', 'PA23000030', NULL, NULL, '0', '0', NULL, 1, 2, '2023-06-06 10:30:37', NULL, NULL, 1),
(31, 1, 31, NULL, NULL, '2023-06-06 11:20:00', '1.00', '0.00', 'PA23000031', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 11:20:00', NULL, NULL, 1),
(32, 1, 32, NULL, NULL, '2023-06-06 11:22:57', '1.00', '0.00', 'PA23000032', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 11:22:57', NULL, NULL, 1),
(33, 1, 33, NULL, NULL, '2023-06-06 14:45:25', '1.00', '0.00', 'PA23000033', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 14:45:25', NULL, NULL, 1),
(34, 1, 34, NULL, NULL, '2023-06-06 14:49:44', '1.00', '0.00', 'PA23000034', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 14:49:44', NULL, NULL, 1),
(35, 1, 35, NULL, NULL, '2023-06-06 14:52:22', '1.00', '0.00', 'PA23000035', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 14:52:22', NULL, NULL, 1),
(36, 1, 36, NULL, NULL, '2023-06-06 15:36:08', '1.00', '0.00', 'PA23000036', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 15:36:08', NULL, NULL, 1),
(37, 1, 37, NULL, NULL, '2023-06-06 15:37:19', '1.00', '0.00', 'PA23000037', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 15:37:19', NULL, NULL, 1),
(38, 1, 38, NULL, NULL, '2023-06-06 15:39:08', '1.00', '0.00', 'PA23000038', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 15:39:08', NULL, NULL, 1),
(39, 1, 39, NULL, NULL, '2023-06-06 15:39:49', '1.00', '0.00', 'PA23000039', NULL, NULL, '1', '0', NULL, 1, 2, '2023-06-06 15:39:49', NULL, NULL, 1),
(40, 1, 40, NULL, NULL, '2023-06-06 15:49:07', '10.03', '0.00', 'PA23000040', NULL, NULL, '20', '10', NULL, 1, 2, '2023-06-06 15:49:07', NULL, NULL, 1),
(41, 1, 41, NULL, NULL, '2023-06-06 17:54:11', '501.00', '0.00', 'PA23000041', NULL, NULL, '1000', '499', NULL, 1, 2, '2023-06-06 17:54:11', NULL, NULL, 1),
(42, 1, 42, NULL, NULL, '2023-06-07 14:10:03', '3501.00', '0.00', 'PA23000042', NULL, NULL, '4000', '499', NULL, 1, 2, '2023-06-07 14:10:03', NULL, NULL, 1),
(43, 1, 47, NULL, NULL, '2023-06-14 11:24:49', '10.03', '0.00', 'PA23000043', NULL, NULL, '50', '40', NULL, 1, 16, '2023-06-14 11:24:49', NULL, NULL, 2),
(44, 1, 48, NULL, NULL, '2023-06-14 11:27:20', '1.00', '0.00', 'PA23000044', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 11:27:20', NULL, NULL, 2),
(45, 1, 49, NULL, NULL, '2023-06-14 11:32:23', '1.00', '0.00', 'PA23000045', NULL, NULL, '0', '0', NULL, 1, 16, '2023-06-14 11:32:24', NULL, NULL, 2),
(46, 1, 50, NULL, NULL, '2023-06-14 11:34:03', '11.03', '0.00', 'PA23000046', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:34:03', NULL, NULL, 2),
(47, 1, 51, NULL, NULL, '2023-06-14 11:35:09', '11.03', '0.00', 'PA23000047', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:35:09', NULL, NULL, 2),
(48, 1, 52, NULL, NULL, '2023-06-14 11:35:48', '11.03', '0.00', 'PA23000048', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:35:48', NULL, NULL, 2),
(49, 1, 53, NULL, NULL, '2023-06-14 11:36:41', '11.03', '0.00', 'PA23000049', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:36:41', NULL, NULL, 2),
(50, 1, 54, NULL, NULL, '2023-06-14 11:36:54', '11.03', '0.00', 'PA23000050', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:36:54', NULL, NULL, 2),
(51, 1, 55, NULL, NULL, '2023-06-14 11:37:22', '11.03', '0.00', 'PA23000051', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:37:22', NULL, NULL, 2),
(52, 1, 56, NULL, NULL, '2023-06-14 11:37:42', '11.03', '0.00', 'PA23000052', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:37:42', NULL, NULL, 2),
(53, 1, 57, NULL, NULL, '2023-06-14 11:38:29', '11.03', '0.00', 'PA23000053', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:38:29', NULL, NULL, 2),
(54, 1, 58, NULL, NULL, '2023-06-14 11:39:37', '11.03', '0.00', 'PA23000054', NULL, NULL, '12', '1', NULL, 1, 16, '2023-06-14 11:39:37', NULL, NULL, 2),
(55, 1, 59, NULL, NULL, '2023-06-14 11:52:09', '1.00', '0.00', 'PA23000055', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 11:52:09', NULL, NULL, 2),
(56, 1, 60, NULL, NULL, '2023-06-14 11:53:38', '10.03', '0.00', 'PA23000056', NULL, NULL, '15', '5', NULL, 1, 16, '2023-06-14 11:53:38', NULL, NULL, 2),
(57, 1, 61, NULL, NULL, '2023-06-14 12:04:27', '10.03', '0.00', 'PA23000057', NULL, NULL, '12', '2', NULL, 1, 16, '2023-06-14 12:04:27', NULL, NULL, 2),
(58, 1, 63, NULL, NULL, '2023-06-14 13:42:56', '1.00', '0.00', 'PA23000058', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 13:42:56', NULL, NULL, 2),
(59, 1, 65, NULL, NULL, '2023-06-14 14:06:34', '1.00', '0.00', 'PA23000059', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 14:06:34', NULL, NULL, 2),
(60, 1, 66, NULL, NULL, '2023-06-14 14:22:39', '1.00', '0.00', 'PA23000060', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 14:22:39', NULL, NULL, 2),
(61, 1, 67, NULL, NULL, '2023-06-14 14:59:43', '1.00', '0.00', 'PA23000061', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 14:59:43', NULL, NULL, 2),
(62, 1, 68, NULL, NULL, '2023-06-14 15:04:11', '1.00', '0.00', 'PA23000062', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 15:04:12', NULL, NULL, 2),
(63, 1, 69, NULL, NULL, '2023-06-14 15:08:34', '1.00', '0.00', 'PA23000063', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 15:08:34', NULL, NULL, 2),
(64, 1, 70, NULL, NULL, '2023-06-14 15:28:03', '1.00', '0.00', 'PA23000064', NULL, NULL, '1', '0', NULL, 1, 16, '2023-06-14 15:28:03', NULL, NULL, 2),
(65, 1, 71, NULL, NULL, '2023-06-14 15:29:19', '11.03', '0.00', 'PA23000065', NULL, NULL, '15', '4', NULL, 1, 16, '2023-06-14 15:29:19', NULL, NULL, 2),
(66, 1, 72, NULL, NULL, '2023-06-14 17:07:41', '1.01', '0.00', 'PA23000066', NULL, NULL, '2', '1', NULL, 1, 16, '2023-06-14 17:07:41', NULL, NULL, 2),
(67, 1, 73, NULL, NULL, '2023-06-14 17:12:42', '1.01', '0.00', 'PA23000067', NULL, NULL, '2', '1', NULL, 1, 16, '2023-06-14 17:12:43', NULL, NULL, 2),
(68, 1, 74, NULL, NULL, '2023-06-14 19:26:03', '1.00', '0.00', 'PA23000068', NULL, NULL, '1', '0', NULL, 1, 18, '2023-06-14 19:26:03', NULL, NULL, 2),
(69, 1, 75, NULL, NULL, '2023-06-14 20:25:13', '2600.00', '0.00', 'PA23000069', NULL, NULL, '2600', '0', NULL, 1, 18, '2023-06-14 20:25:13', NULL, NULL, 2),
(70, 1, 76, NULL, NULL, '2023-06-14 20:43:17', '2132.00', '0.00', 'PA23000070', NULL, NULL, '3000', '868', NULL, 1, 18, '2023-06-14 20:43:18', NULL, NULL, 2),
(71, 1, 77, NULL, NULL, '2023-06-14 20:46:42', '2600.00', '0.00', 'PA23000071', NULL, NULL, '3000', '400', NULL, 1, 18, '2023-06-14 20:46:42', NULL, NULL, 2),
(72, 1, 78, NULL, NULL, '2023-06-14 21:33:04', '2600.00', '0.00', 'PA23000072', NULL, NULL, '3000', '400', NULL, 1, 18, '2023-06-14 21:33:04', NULL, NULL, 2),
(73, 1, 79, NULL, NULL, '2023-06-15 11:49:26', '11800.00', '0.00', 'PA23000073', NULL, NULL, '12000', '200', NULL, 1, 18, '2023-06-15 11:49:26', NULL, NULL, 2),
(74, 1, 80, NULL, NULL, '2023-06-15 16:05:53', '40600.00', '0.00', 'PA23000074', NULL, NULL, '45000', '4400', NULL, 1, 18, '2023-06-15 16:05:53', NULL, NULL, 2),
(75, 1, 81, NULL, NULL, '2023-06-15 17:53:52', '44850.00', '0.00', 'PA23000075', NULL, NULL, '50000', '5150', NULL, 1, 18, '2023-06-15 17:53:52', NULL, NULL, 2),
(76, 1, 82, NULL, NULL, '2023-06-15 18:03:29', '44850.00', '0.00', 'PA23000076', NULL, NULL, '50000', '5150', NULL, 1, 18, '2023-06-15 18:03:29', NULL, NULL, 2),
(77, 1, 83, NULL, NULL, '2023-06-15 18:30:16', '40600.00', '0.00', 'PA23000077', NULL, NULL, '50000', '9400', NULL, 1, 18, '2023-06-15 18:30:16', NULL, NULL, 2),
(78, 1, 85, NULL, NULL, '2023-06-15 20:05:46', '35998.00', '0.00', 'PA23000078', NULL, NULL, '40000', '4002', NULL, 1, 18, '2023-06-15 20:05:46', NULL, NULL, 2),
(79, 1, 86, NULL, NULL, '2023-06-16 13:25:06', '35998.00', '0.00', 'PA23000079', NULL, NULL, '40000', '4002', NULL, 1, 18, '2023-06-16 13:25:07', NULL, NULL, 2),
(80, 1, 87, NULL, NULL, '2023-06-16 13:27:04', '35998.00', '0.00', 'PA23000080', NULL, NULL, '40000', '4002', NULL, 1, 18, '2023-06-16 13:27:04', NULL, NULL, 2),
(81, 1, 88, NULL, NULL, '2023-06-16 15:59:27', '42360.00', '0.00', 'PA23000081', NULL, NULL, '45000', '2640', NULL, 1, 18, '2023-06-16 15:59:27', NULL, NULL, 2),
(82, 1, 89, NULL, NULL, '2023-06-16 16:02:09', '40952.00', '0.00', 'PA23000082', NULL, NULL, '41000', '48', NULL, 1, 18, '2023-06-16 16:02:09', NULL, NULL, 2),
(83, 1, 90, NULL, NULL, '2023-06-16 16:08:26', '42958.00', '0.00', 'PA23000083', NULL, NULL, '43000', '42', NULL, 1, 18, '2023-06-16 16:08:26', NULL, NULL, 2),
(84, 1, 91, NULL, NULL, '2023-06-16 16:22:49', '42983.34', '0.00', 'PA23000084', NULL, NULL, '45000', '2017', NULL, 1, 18, '2023-06-16 16:22:49', NULL, NULL, 2),
(85, 1, 92, NULL, NULL, '2023-06-16 18:00:26', '28600.00', '0.00', 'PA23000085', NULL, NULL, '30000', '1400', NULL, 1, 18, '2023-06-16 18:00:26', NULL, NULL, 2),
(86, 1, 93, NULL, NULL, '2023-06-16 18:47:42', '225380.00', '0.00', 'PA23000086', NULL, NULL, '230000', '4620', NULL, 1, 18, '2023-06-16 18:47:42', NULL, NULL, 2),
(87, 1, 94, NULL, NULL, '2023-06-16 19:04:30', '225979.00', '0.00', 'PA23000087', NULL, NULL, '230000', '4021', NULL, 1, 18, '2023-06-16 19:04:30', NULL, NULL, 2),
(88, 1, 95, NULL, NULL, '2023-06-16 19:13:36', '191000.00', '0.00', 'PA23000088', NULL, NULL, '200000', '9000', NULL, 1, 18, '2023-06-16 19:13:37', NULL, NULL, 2),
(89, 1, 96, NULL, NULL, '2023-06-16 19:19:48', '191600.00', '0.00', 'PA23000089', NULL, NULL, '200000', '8400', NULL, 1, 18, '2023-06-16 19:19:48', NULL, NULL, 2),
(90, 1, 97, NULL, NULL, '2023-06-16 19:41:46', '191600.00', '0.00', 'PA23000090', NULL, NULL, '200000', '8400', NULL, 1, 18, '2023-06-16 19:41:46', NULL, NULL, 2),
(91, 1, 98, NULL, NULL, '2023-06-20 13:19:18', '10000.00', '0.00', 'PA23000091', NULL, NULL, '10000', '0', NULL, 1, 18, '2023-06-20 13:19:18', NULL, NULL, 2),
(92, 1, 99, NULL, NULL, '2023-06-20 15:54:43', '10000.00', '0.00', 'PA23000092', NULL, NULL, '10000', '0', NULL, 1, 18, '2023-06-20 15:54:44', NULL, NULL, 2),
(93, 1, 100, NULL, NULL, '2023-06-20 15:56:19', '10000.00', '0.00', 'PA23000093', NULL, NULL, '10000', '0', NULL, 1, 18, '2023-06-20 15:56:19', NULL, NULL, 2),
(94, 1, 101, NULL, NULL, '2023-06-20 18:37:23', '10000.00', '0.00', 'PA23000094', NULL, NULL, '10000', '0', NULL, 1, 18, '2023-06-20 18:37:23', NULL, NULL, 2),
(95, 1, 102, NULL, NULL, '2023-06-20 19:38:05', '20200.00', '0.00', 'PA23000095', NULL, NULL, '21000', '800', NULL, 1, 18, '2023-06-20 19:38:05', NULL, NULL, 2),
(96, 1, 103, NULL, NULL, '2023-06-20 19:47:26', '10000.00', '0.00', 'PA23000096', NULL, NULL, '10000', '0', NULL, 1, 18, '2023-06-20 19:47:26', NULL, NULL, 2),
(97, 1, 105, NULL, NULL, '2023-06-20 20:20:06', '191000.00', '0.00', 'PA23000097', NULL, NULL, '200000', '9000', NULL, 1, 18, '2023-06-20 20:20:06', NULL, NULL, 2),
(98, 1, 107, NULL, NULL, '2023-06-21 13:03:53', '6000.00', '0.00', 'PA23000098', NULL, NULL, '10000', '4000', NULL, 1, 18, '2023-06-21 13:03:53', NULL, NULL, 2),
(99, 1, 108, NULL, NULL, '2023-06-21 13:04:44', '6000.00', '0.00', 'PA23000099', NULL, NULL, '10000', '4000', NULL, 1, 18, '2023-06-21 13:04:44', NULL, NULL, 2),
(100, 1, 109, NULL, NULL, '2023-06-21 13:07:18', '6000.01', '0.00', 'PA23000100', NULL, NULL, '10000', '4000', NULL, 1, 18, '2023-06-21 13:07:18', NULL, NULL, 2),
(101, 1, 110, NULL, NULL, '2023-06-21 13:09:34', '236000.00', '0.00', 'PA23000101', NULL, NULL, '500000', '264000', NULL, 1, 18, '2023-06-21 13:09:34', NULL, NULL, 2),
(102, 1, 111, NULL, NULL, '2023-06-21 13:12:41', '95500.00', '0.00', 'PA23000102', NULL, NULL, '100000', '4500', NULL, 1, 18, '2023-06-21 13:12:41', NULL, NULL, 2),
(103, 1, 114, NULL, NULL, '2023-06-22 18:54:17', '35980.00', '0.00', 'PA23000103', NULL, NULL, '40000', '4020', NULL, 1, 18, '2023-06-22 18:54:17', NULL, NULL, 2),
(104, 1, 115, NULL, NULL, '2023-06-22 18:55:42', '35998.00', '0.00', 'PA23000104', NULL, NULL, '40000', '4002', NULL, 1, 18, '2023-06-22 18:55:42', NULL, NULL, 2),
(105, 1, 116, NULL, NULL, '2023-06-23 16:08:48', '11800.00', '0.00', 'PA23000105', NULL, NULL, '12000', '200', NULL, 1, 18, '2023-06-23 16:08:48', NULL, NULL, 2),
(106, 1, 117, NULL, NULL, '2023-06-23 16:23:43', '11800.00', '0.00', 'PA23000106', NULL, NULL, '12000', '200', NULL, 1, 18, '2023-06-23 16:23:43', NULL, NULL, 2),
(107, 1, 118, NULL, NULL, '2023-06-23 18:24:07', '118000.00', '0.00', 'PA23000107', NULL, NULL, '200000', '82000', NULL, 1, 18, '2023-06-23 18:24:07', NULL, NULL, 2),
(108, 1, 120, NULL, NULL, '2023-06-26 16:51:54', '23600.00', '0.00', 'PA23000108', NULL, NULL, '25000', '1400', NULL, 1, 18, '2023-06-26 16:51:54', NULL, NULL, 2),
(109, 1, 122, NULL, NULL, '2023-06-26 17:05:22', '177000.00', '0.00', 'PA23000109', NULL, NULL, '180000', '3000', NULL, 1, 18, '2023-06-26 17:05:22', NULL, NULL, 2),
(110, 1, 131, NULL, NULL, '2023-06-26 18:12:59', '11800.00', '0.00', 'PA23000110', NULL, NULL, '12000', '200', NULL, 1, 18, '2023-06-26 18:12:59', NULL, NULL, 2),
(111, 1, 133, NULL, NULL, '2023-06-26 18:33:13', '11800.00', '0.00', 'PA23000111', NULL, NULL, '12000', '200', NULL, 1, 18, '2023-06-26 18:33:13', NULL, NULL, 2),
(112, 1, 136, NULL, NULL, '2023-06-26 20:55:08', '11800.00', '0.00', 'PA23000112', NULL, NULL, '12000', '200', NULL, 1, 18, '2023-06-26 20:55:08', NULL, NULL, 2),
(113, 1, 138, NULL, NULL, '2023-06-26 20:56:27', '1244900.00', '0.00', 'PA23000113', NULL, NULL, '11111111', '9866211', NULL, 1, 18, '2023-06-26 20:56:27', NULL, NULL, 2),
(114, 1, 140, NULL, NULL, '2023-06-26 21:01:19', '118000.00', '0.00', 'PA23000114', NULL, NULL, '1111111', '993111', NULL, 1, 18, '2023-06-26 21:01:19', NULL, NULL, 2),
(115, 1, 137, NULL, NULL, '2023-06-29 00:00:00', '1800.00', '10000.00', 'PA23000115', NULL, NULL, '2000', '200', NULL, 1, 20, '2023-06-29 12:42:53', NULL, NULL, 2),
(116, 3, 139, NULL, NULL, '2023-06-29 00:00:00', '10000.00', '1234900.00', 'PA23000116', NULL, NULL, '10000', '0', NULL, 1, 20, '2023-06-29 12:56:32', NULL, NULL, 2),
(117, 1, 148, NULL, NULL, '2023-07-04 10:06:46', '11800.00', '0.00', 'PA23000117', NULL, NULL, '12000', '200', NULL, NULL, 20, '2023-07-04 10:06:46', NULL, NULL, 2),
(118, 1, 149, NULL, NULL, '2023-07-04 11:40:05', '14400.00', '0.00', 'PA23000118', NULL, NULL, '15000', '600', NULL, NULL, 20, '2023-07-04 11:40:05', NULL, NULL, 2),
(119, 1, 150, NULL, NULL, '2023-07-05 09:51:48', '14400.00', '0.00', 'PA23000119', NULL, NULL, '15000', '600', NULL, NULL, 20, '2023-07-05 09:51:48', NULL, NULL, 2),
(120, 1, 151, NULL, NULL, '2023-07-05 10:18:24', '17800.00', '0.00', 'PA23000120', NULL, NULL, '18000', '200', NULL, NULL, 20, '2023-07-05 10:18:24', NULL, NULL, 2),
(121, 1, 152, NULL, NULL, '2023-07-05 11:56:03', '14800.00', '0.00', 'PA23000121', NULL, NULL, '15000', '200', NULL, NULL, 20, '2023-07-05 11:56:03', NULL, NULL, 2),
(122, 1, 153, NULL, NULL, '2023-07-06 18:32:22', '11800.00', '0.00', 'PA23000122', NULL, NULL, '12000', '200', NULL, NULL, 20, '2023-07-06 18:32:22', NULL, NULL, 2),
(123, 1, 154, NULL, NULL, '2023-07-06 18:34:23', '11800.00', '0.00', 'PA23000123', NULL, NULL, '12000', '200', NULL, NULL, 20, '2023-07-06 18:34:23', NULL, NULL, 2),
(124, 1, 155, NULL, NULL, '2023-07-06 18:41:52', '11800.00', '0.00', 'PA23000124', NULL, NULL, '12000', '200', NULL, NULL, 20, '2023-07-06 18:41:52', NULL, NULL, 2),
(125, 1, 156, NULL, NULL, '2023-07-06 18:58:25', '11800.00', '0.00', 'PA23000125', NULL, NULL, '12000', '200', NULL, NULL, 20, '2023-07-06 18:58:25', NULL, NULL, 2),
(126, 1, 157, NULL, NULL, '2023-07-06 19:05:35', '129800.00', '0.00', 'PA23000126', NULL, NULL, '130000', '200', NULL, 2, 20, '2023-07-06 19:05:35', NULL, NULL, 2),
(127, 1, 158, NULL, NULL, '2023-07-11 17:36:34', '100.00', '0.00', 'PA23000127', NULL, NULL, '200', '100', NULL, 2, 20, '2023-07-11 17:36:34', NULL, NULL, 2),
(128, 1, 160, NULL, NULL, '2023-07-11 18:06:24', '100.00', '0.00', 'PA23000128', NULL, NULL, '120', '20', NULL, 2, 20, '2023-07-11 18:06:24', NULL, NULL, 2);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id`, `code`, `libelle_fr`, `libelle_en`) VALUES
(1, 'BJ', 'BENIN', 'BENIN'),
(2, 'TG', 'TOGO', 'TOGO');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `personnel`
--

INSERT INTO `personnel` (`id`, `point_vente_id`, `nom`, `prenoms`, `tel`, `email`, `adresse`, `date_nais`, `sexe`, `civilite`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'TAUPIN', 'Eric', '067809987', 'rosetteella2@gmail.com', '7 chemin du rivage\r\ntest', '2023-06-14 00:00:00', 'Masculin', 'Monsieur', NULL, '2023-06-14 10:55:53', NULL, NULL),
(2, 1, 'DELLOUH', 'Deschanel', '22996253007', 'ddellouh@gmail.com', 'Calavi\r\npavé itta', NULL, 'Masculin', 'Monsieur', NULL, '2023-06-14 10:56:37', NULL, NULL),
(3, 1, 'KPATOUKPA', 'DIDIER', '97969594', NULL, 'CALAVI', '2023-06-26 00:00:00', 'Masculin', 'Monsieur', NULL, '2023-06-26 19:23:49', '2023-06-26 19:23:49', NULL),
(4, 1, 'ATINDOHOU', 'viviane', '91919191', NULL, 'akassato', '2023-06-26 00:00:00', 'Masculin', 'Monsieur', NULL, '2023-06-26 19:23:28', NULL, NULL),
(5, 1, 'DOSSOU', 'Aline', '90909090', 'daline@gmail.com', 'cotonou', '2023-05-30 00:00:00', 'Masculin', 'Monsieur', NULL, '2023-06-29 20:48:32', NULL, NULL),
(6, 2, 'AVOSSE', 'BEA', '434343434', 'bea@gmail.com', 'cotonou', '2023-06-29 00:00:00', 'Masculin', 'Monsieur', NULL, '2023-06-29 20:51:03', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `personnel_caisse`
--

INSERT INTO `personnel_caisse` (`id`, `caisse_id`, `personnel_id`, `statut`) VALUES
(1, 16, 2, NULL),
(2, 17, 1, NULL),
(3, 18, 1, NULL),
(4, 19, 1, NULL),
(5, 20, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `point_de_vente`
--

DROP TABLE IF EXISTS `point_de_vente`;
CREATE TABLE IF NOT EXISTS `point_de_vente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `est_principal` tinyint(1) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C9182F7BEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `point_de_vente`
--

INSERT INTO `point_de_vente` (`id`, `code`, `libelle`, `adresse`, `tel`, `est_principal`, `est_sup`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'pv_cot', 'POINT DE VENTE DE COTONOU', 'cotonou', '90000000', 0, NULL, NULL, '2023-05-19 22:53:25', NULL, NULL),
(2, 'PV_tog', 'POINT DE VENTE DE TOGOUDO', 'Calavi togoudo', '98989898', 1, NULL, NULL, '2023-05-19 22:53:25', NULL, NULL),
(3, 'PV_sav', 'POINT DE VENTE DE SAVALOU', 'SAVALOU GAR', '98989895', 0, NULL, NULL, '2023-05-26 08:45:04', NULL, NULL);

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
  `code_qr` varbinary(255) DEFAULT NULL,
  `code_barre` varbinary(255) DEFAULT NULL,
  `seuil_appro` decimal(10,2) DEFAULT NULL,
  `stock` decimal(10,2) NOT NULL DEFAULT '0.00',
  `code_produit` varchar(255) DEFAULT NULL,
  `suivi_stock` int DEFAULT NULL,
  `mode_def_prix` varchar(255) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `est_mode_carreau` tinyint(1) NOT NULL,
  `metre_carre_par_carton` varchar(255) DEFAULT NULL,
  `piece_par_carton` varchar(255) DEFAULT NULL,
  `piece_par_metre_carre` varchar(255) DEFAULT NULL,
  `surface_par_piece` varchar(255) DEFAULT NULL,
  `couleur_carreau` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_29A5EC271102A8BB` (`code_produit`),
  KEY `IDX_29A5EC2797A77B84` (`famille_id`),
  KEY `IDX_29A5EC27DCDEA0EA` (`groupe_taxe_id`),
  KEY `IDX_29A5EC27F12D8438` (`magasin_defaut_id`),
  KEY `IDX_29A5EC27EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `famille_id`, `point_vente_id`, `groupe_taxe_id`, `magasin_defaut_id`, `ref_prod`, `nom_prod`, `desc_prod`, `prix_achat_prod`, `prix_vente_prod`, `est_taxable`, `est_service`, `code_qr`, `code_barre`, `seuil_appro`, `stock`, `code_produit`, `suivi_stock`, `mode_def_prix`, `est_sup`, `est_mode_carreau`, `metre_carre_par_carton`, `piece_par_carton`, `piece_par_metre_carre`, `surface_par_piece`, `couleur_carreau`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 4, 1, 'CD', 'COLONNE DE DOUCHES', NULL, '0.00', NULL, 1, 0, NULL, NULL, '10.00', '152.00', 'PLO0000001', 0, '1', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-15 11:48:14', '2023-06-26 21:01:43', NULL),
(2, 1, 1, 3, 1, 'aa', 'produit sup', NULL, '0.00', NULL, 0, 0, NULL, NULL, '10.00', '50.00', 'PLO0000002', 0, '0', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-05-31 17:52:07', '2023-05-31 17:54:34', '2023-05-31 17:54:34'),
(3, 1, 1, 3, NULL, 's', 'ss', NULL, '0.00', '0.00', 0, 1, NULL, NULL, '10.00', '0.00', 'PLO0000003', NULL, '0', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-05-31 18:43:58', '2023-06-15 11:09:22', '2023-06-15 11:09:22'),
(5, 1, 1, 3, 1, 'test', 'test', 'deschanel\r\ndee', '0.00', '0.00', 0, 0, NULL, NULL, '10.00', '0.00', 'PLO0000004', 1, '0', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-01 16:12:11', '2023-06-15 11:10:22', '2023-06-15 11:10:22'),
(6, 1, 1, 3, NULL, 'TM', 'LIVRAISON', 'une petite description du service', '0.00', NULL, 0, 1, NULL, NULL, '10.00', '0.00', 'PLO0000005', NULL, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-15 11:06:37', '2023-06-15 11:06:37', NULL),
(7, 2, 1, 4, 1, 'VSP007', 'CAREAU  POLY 60X60  VSP007', NULL, '0.00', NULL, 1, 0, NULL, NULL, '10.00', '12.00', 'PLO0000006', 0, '1', NULL, 1, '1.44', '4', '2', '0.36', NULL, '2023-06-15 11:04:43', '2023-06-22 13:00:17', NULL),
(8, 2, 1, 7, 1, 'C30', 'CARREAU SOL 30X30', NULL, '0.00', NULL, 0, 0, NULL, NULL, '10.00', '989.00', 'CAR0000002', 0, '0', NULL, 1, '1.8', '20', '11', '0.06', NULL, '2023-06-16 17:26:45', '2023-06-16 17:26:46', NULL),
(9, 3, 1, 3, 1, 'F6', 'FER DE 6 LISSE', NULL, '0.00', NULL, 0, 0, NULL, NULL, '10.00', '97.00', 'FER0000001', 0, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-16 17:28:05', '2023-06-22 17:18:54', NULL),
(10, 1, 1, 6, 1, 'TU20', 'TUYAUX PVC DE  100', NULL, '0.00', NULL, 1, 0, NULL, NULL, '10.00', '90.00', 'PLO0000008', 0, '1', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-16 18:46:21', '2023-06-26 20:57:34', NULL),
(13, 1, 1, 8, 1, 'TS', 'TAXE DE SEJOUR', NULL, '0.00', '0.00', 0, 1, NULL, NULL, '10.00', '0.00', 'PLO0000007', 0, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-16 17:29:17', NULL, NULL),
(14, 1, 1, 7, 1, 'WCP', 'WC PARMA', NULL, '0.00', '0.00', 0, 0, NULL, NULL, '10.00', '100.00', 'PLO0000009', 0, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-16 19:10:04', '2023-06-16 19:10:47', NULL),
(16, 3, 1, 5, 1, 'TA', 'TUYA A EXPORTER', NULL, '0.00', NULL, 1, 0, NULL, NULL, '10.00', '100.00', 'FER0000002', 0, '0', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-20 11:20:18', '2023-06-20 13:10:23', '2023-06-20 13:10:23'),
(17, 3, 1, 5, 1, 'PRR', 'PRO', NULL, '0.00', NULL, 1, 0, NULL, NULL, '10.00', '0.00', 'FER0000003', 0, '1', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-20 12:07:42', '2023-06-20 13:10:38', '2023-06-20 13:10:38'),
(18, 3, 1, 5, 1, 'TEX', 'TUYAU EXPORTABLE', NULL, '0.00', '0.00', 0, 0, NULL, NULL, '10.00', '100.00', 'FER0000004', 0, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-20 13:12:27', '2023-06-20 13:17:53', NULL),
(19, 1, 1, 4, 1, 'test', 'test', NULL, '0.00', NULL, 1, 0, NULL, NULL, '10.00', '0.00', 'PLO0000012', 0, '1', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-22 11:06:02', '2023-06-22 11:06:02', NULL),
(20, 3, 1, 7, 1, 'PTP', 'PRO TPS', NULL, '0.00', NULL, 0, 0, NULL, NULL, '10.00', '100.00', 'FER0000006', 0, '0', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-20 20:16:45', '2023-06-21 19:36:31', '2023-06-21 19:36:31'),
(22, 1, 1, 3, NULL, 'etete', 'tett', NULL, '0.00', NULL, 0, 1, NULL, NULL, '10.00', '0.00', 'PLO0000010', NULL, '0', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-21 19:32:30', '2023-06-23 10:58:10', '2023-06-23 10:58:10'),
(23, 1, 1, 3, NULL, 'yugyug', 'uygyug', NULL, '0.00', NULL, 0, 1, NULL, NULL, '10.00', '0.00', 'PLO0000011', NULL, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-21 19:33:52', NULL, NULL),
(25, 3, 1, 4, 1, 'SS', 'TUYAU PVC DE 1000', NULL, '0.00', '0.00', 1, 0, NULL, NULL, '10.00', '985.00', 'FER0000007', 0, '1', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-22 18:52:05', '2023-06-26 18:38:33', NULL),
(27, 3, 1, 4, 1, '_dd', 'PROD8', NULL, '0.00', NULL, 1, 0, NULL, NULL, '10.00', '1000.00', 'FER0000008', 0, '1', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-22 20:03:47', '2023-06-23 09:49:17', '2023-06-23 09:49:17'),
(28, 3, 1, 3, NULL, 'tttss', 'test suppression', 'ok test', '0.00', NULL, 0, 1, NULL, NULL, '10.00', '0.00', 'FER0000009', NULL, '0', 1, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-23 09:29:22', '2023-06-23 09:33:04', '2023-06-23 09:33:04'),
(29, 3, 1, 3, NULL, 'testsup', 'test sup', NULL, '0.00', NULL, 0, 1, NULL, NULL, '10.00', '0.00', 'FER0000010', NULL, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-29 14:17:08', '2023-06-29 14:17:08', NULL),
(30, 3, 1, 3, NULL, 'ser1', 'service 1', NULL, '0.00', NULL, 0, 1, NULL, NULL, '10.00', '0.00', 'FER0000011', NULL, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-06-30 09:49:02', NULL, NULL),
(32, 5, 2, 3, 4, 'qsds', 'test 22', NULL, '0.00', NULL, 0, 0, NULL, NULL, '10.00', '99.00', 'PLO20000012', 0, '0', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2023-07-11 17:19:28', '2023-07-11 18:18:05', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `produit_conditionnement`
--

DROP TABLE IF EXISTS `produit_conditionnement`;
CREATE TABLE IF NOT EXISTS `produit_conditionnement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int NOT NULL,
  `conditionnement_id` int NOT NULL,
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
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1F452A28F347EFB` (`produit_id`),
  KEY `IDX_1F452A28A222637` (`conditionnement_id`),
  KEY `IDX_1F452A28EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_conditionnement`
--

INSERT INTO `produit_conditionnement` (`id`, `produit_id`, `conditionnement_id`, `qte_cond`, `qte_stock_cond`, `prix_min`, `prix_max`, `prix_de_vente`, `prix_de_vente_ht`, `prix_de_vente_ttc`, `cump`, `stock_init`, `qte_stock_cond_logique`, `nom_pro_cond`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`, `est_sup`) VALUES
(1, 1, 1, '1.00', '162.00', NULL, NULL, '11800.00', '10000.00', '11800.00', '943.50', NULL, '-50.25', 'COLONNE DE DOUCHES [UNITE]', 1, '2023-05-31 16:26:03', '2023-07-06 19:05:36', NULL, NULL),
(2, 2, 1, '1.00', '50.00', NULL, NULL, '100.00', '100.00', '100.00', '0.00', NULL, '50.00', 'produit sup [UNITE]', 1, '2023-05-31 17:52:07', '2023-05-31 17:54:34', '2023-05-31 17:54:34', NULL),
(3, 6, 1, '1.00', '0.00', NULL, '100000.00', '500.00', '500.00', '500.00', '0.00', NULL, '-2.00', 'LIVRAISON [UNITE]', 1, '2023-06-05 16:16:20', '2023-06-15 11:06:37', NULL, NULL),
(4, 7, 4, '1.00', '12.00', NULL, NULL, '6000.00', '5084.75', '6000.00', '91.83', NULL, '9.00', 'CAREAU  POLY 60X60  VSP007 [METRE CARRE]', 1, '2023-06-05 18:24:36', '2023-07-05 10:18:25', NULL, NULL),
(5, 8, 4, '1.00', '989.00', NULL, NULL, '3000.00', '3000.00', '3000.00', '0.00', NULL, '876.00', 'CARREAU SOL 30X30 [METRE CARRE]', 1, '2023-06-06 00:03:53', '2023-07-05 11:56:05', NULL, NULL),
(6, 9, 1, '1.00', '97.00', '1.00', '3000.00', '2600.00', '2600.00', '2600.00', '3000.00', NULL, '75.50', 'FER DE 6 LISSE [UNITE]', 1, '2023-06-14 18:37:30', '2023-07-05 09:51:49', NULL, NULL),
(7, 10, 1, '1.00', '110.00', '1.00', '120000.00', '112690.00', '95500.00', '112690.00', '2000.00', NULL, '96.00', 'TUYAUX PVC DE  100 [UNITE]', 1, '2023-06-14 18:39:29', '2023-06-26 20:58:17', NULL, NULL),
(8, 13, 1, '1.00', '0.00', NULL, NULL, '5000.00', '5000.00', '5000.00', '0.00', NULL, '-1.00', 'TAXE DE SEJOUR [UNITE]', 1, '2023-06-16 17:29:17', '2023-06-16 18:00:26', NULL, NULL),
(9, 14, 1, '1.00', '100.00', '1.00', '100000.00', '95500.00', '95500.00', '95500.00', '30000.00', NULL, '93.00', 'WC PARMA [UNITE]', 1, '2023-06-16 19:10:04', '2023-06-21 13:12:41', NULL, NULL),
(10, 16, 1, '1.00', '100.00', NULL, NULL, '5000.00', '5000.00', '0.00', '2000.00', NULL, '100.00', 'TUYA A EXPORTER [UNITE]', 1, '2023-06-20 11:17:45', '2023-06-20 13:10:23', '2023-06-20 13:10:23', NULL),
(11, 17, 1, '1.00', '0.00', '0.00', '6000.00', '5000.00', '5000.00', '5000.00', '0.00', NULL, '0.00', 'PRO [UNITE]', 1, '2023-06-20 12:07:42', '2023-06-20 13:10:38', '2023-06-20 13:10:38', NULL),
(12, 18, 1, '1.00', '100.00', NULL, NULL, '5000.00', '5000.00', '5000.00', '1500.00', NULL, '87.00', 'TUYAU EXPORTABLE [UNITE]', 1, '2023-06-20 13:12:27', '2023-06-20 19:47:26', NULL, NULL),
(13, 19, 1, '1.00', '0.00', NULL, NULL, '1000.00', '847.46', '1000.00', '0.00', NULL, '0.00', 'test [UNITE]', 1, '2023-06-20 18:22:16', NULL, NULL, NULL),
(14, 20, 1, '1.00', '100.00', NULL, NULL, '95500.00', '95500.00', '95500.00', '10000.00', NULL, '98.00', 'PRO TPS [UNITE]', 1, '2023-06-20 20:16:45', '2023-06-21 19:36:31', '2023-06-21 19:36:31', NULL),
(15, 22, 1, '1.00', '0.00', NULL, NULL, '100.00', '100.00', '100.00', '0.00', NULL, '0.00', 'tett [UNITE]', 1, '2023-06-21 19:32:30', '2023-06-23 10:58:11', '2023-06-23 10:58:11', NULL),
(16, 23, 1, '1.00', '0.00', NULL, NULL, '100.00', '100.00', '100.00', '0.00', NULL, '0.00', 'uygyug [UNITE]', 1, '2023-06-21 19:33:52', NULL, NULL, NULL),
(17, 25, 1, '1.00', '990.00', NULL, NULL, '11800.00', '10000.00', '11800.00', '0.00', NULL, '987.00', 'TUYAU PVC DE 1000 [UNITE]', 1, '2023-06-22 18:52:05', '2023-06-29 16:12:29', NULL, NULL),
(18, 27, 1, '1.00', '1000.00', NULL, NULL, '11.00', '9.32', '11.00', '0.00', NULL, '1000.00', 'PROD8 [UNITE]', 1, '2023-06-22 20:03:47', '2023-06-23 09:49:18', '2023-06-23 09:49:18', NULL),
(19, 28, 1, '1.00', '0.00', NULL, NULL, '10.00', '10.00', '10.00', '0.00', NULL, '0.00', 'test suppression [UNITE]', 1, '2023-06-23 09:29:22', '2023-06-23 09:33:04', '2023-06-23 09:33:04', NULL),
(20, 29, 1, '1.00', '0.00', NULL, NULL, '1.00', '1.00', '1.00', '0.00', NULL, '0.00', 'test sup [UNITE]', 1, '2023-06-29 13:01:51', NULL, NULL, NULL),
(21, 29, 3, '10.00', '0.00', NULL, NULL, '11.00', '11.00', '11.00', '0.00', NULL, '0.00', 'test sup [CARTON]', 1, '2023-06-29 13:01:51', '2023-06-29 13:11:15', '2023-06-29 13:11:15', 1),
(22, 30, 1, '1.00', '0.00', '100.00', '300.00', '200.00', '200.00', '200.00', '0.00', NULL, '0.00', 'service 1 [UNITE]', 1, '2023-06-30 09:49:02', NULL, NULL, NULL),
(23, 32, 1, '1.00', '100.00', NULL, NULL, '100.00', '100.00', '100.00', '1000.00', NULL, '100.00', 'test 22 [UNITE]', 2, '2023-07-11 17:19:28', '2023-07-11 18:18:05', NULL, NULL);

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
  `prix_achat` decimal(10,2) DEFAULT NULL,
  `montant_cond` decimal(10,2) DEFAULT NULL,
  `carton` decimal(10,0) DEFAULT NULL,
  `piece` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2A498BD239C2AB40` (`produit_conditionnement_id`),
  KEY `IDX_2A498BD23F0A2F6B` (`appro_magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_appro_mag`
--

INSERT INTO `produit_cond_appro_mag` (`id`, `produit_conditionnement_id`, `appro_magasin_id`, `qte_cond_appro`, `prix_achat`, `montant_cond`, `carton`, `piece`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '100.00', '1000.00', '100000.00', NULL, NULL, '2023-05-31 16:40:33', NULL, NULL),
(2, 2, 2, '50.00', NULL, NULL, NULL, NULL, '2023-05-31 17:53:34', NULL, NULL),
(3, 5, 3, '1000.00', '0.00', NULL, '555', '11', '2023-06-06 00:04:46', NULL, NULL),
(4, 1, 4, '100.00', '1000.00', '100000.00', NULL, NULL, '2023-06-09 11:05:54', NULL, NULL),
(5, 4, 5, '1.00', '2.00', '2.00', NULL, NULL, '2023-06-09 11:26:32', NULL, NULL),
(6, 6, 6, '100.00', '3000.00', '300000.00', NULL, NULL, '2023-06-14 20:24:15', NULL, NULL),
(7, 7, 7, '100.00', '2000.00', '200000.00', NULL, NULL, '2023-06-16 18:39:39', NULL, NULL),
(8, 9, 8, '100.00', '30000.00', '3000000.00', NULL, NULL, '2023-06-16 19:10:47', NULL, NULL),
(9, 10, 9, '100.00', '2000.00', '200000.00', NULL, NULL, '2023-06-20 11:21:40', NULL, NULL),
(10, 12, 10, '100.00', '1500.00', '150000.00', NULL, NULL, '2023-06-20 13:17:52', NULL, NULL),
(11, 14, 11, '100.00', '10000.00', '1000000.00', NULL, NULL, '2023-06-20 20:18:12', NULL, NULL),
(12, 1, 12, '11.00', '1.00', '11.00', NULL, NULL, '2023-06-21 20:15:09', NULL, NULL),
(13, 1, 13, '1.00', '11.00', '11.00', NULL, NULL, '2023-06-22 10:15:40', NULL, NULL),
(14, 4, 15, '11.00', '100.00', '1100.00', '7', '2', '2023-06-22 13:00:16', NULL, NULL),
(15, 17, 16, '1000.00', NULL, NULL, NULL, NULL, '2023-06-22 18:52:45', NULL, NULL),
(16, 18, 17, '1000.00', NULL, NULL, NULL, NULL, '2023-06-22 20:07:06', NULL, NULL),
(17, 23, 18, '100.00', '1000.00', '100000.00', NULL, NULL, '2023-07-11 17:26:10', NULL, NULL);

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
  `montant` int NOT NULL,
  `prix` int NOT NULL,
  `rest_aliv` int DEFAULT NULL,
  `montant_ht_apr_rse` decimal(10,0) DEFAULT NULL,
  `type_remise` varchar(255) DEFAULT NULL,
  `valeur_remise` varchar(255) DEFAULT NULL,
  `remise` decimal(10,0) DEFAULT NULL,
  `prix_ht` decimal(10,0) NOT NULL,
  `montant_ttcp` decimal(10,0) NOT NULL,
  `montant_tvap` decimal(10,0) NOT NULL,
  `carton` decimal(10,0) DEFAULT NULL,
  `piece` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `libelle_produit` varchar(255) DEFAULT NULL,
  `groupe_taxe_produit` varchar(255) DEFAULT NULL,
  `taxe_specifique` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_192AE28EF347EFB` (`produit_id`),
  KEY `IDX_192AE28E47C00A52` (`commande_clit_id`),
  KEY `IDX_192AE28E20096AE3` (`magasin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_com_clit`
--

INSERT INTO `produit_cond_com_clit` (`id`, `produit_id`, `commande_clit_id`, `magasin_id`, `qtite`, `montant`, `prix`, `rest_aliv`, `montant_ht_apr_rse`, `type_remise`, `valeur_remise`, `remise`, `prix_ht`, `montant_ttcp`, `montant_tvap`, `carton`, `piece`, `created_at`, `updated_at`, `deleted_at`, `libelle_produit`, `groupe_taxe_produit`, `taxe_specifique`) VALUES
(1, 1, 1, 1, '1.000', 847, 1000, 1, '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(2, 1, 2, 1, '1.000', 847, 1000, 1, '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(3, 1, 3, 1, '1.000', 847, 1000, 1, '847', NULL, NULL, '0', '847', '1000', '153', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(4, 1, 41, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(5, 1, 42, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(6, 1, 43, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(7, 1, 44, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(8, 1, 45, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(9, 1, 46, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(10, 1, 47, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(11, 1, 48, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(12, 1, 49, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(13, 1, 50, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(14, 1, 51, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(15, 1, 52, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(16, 1, 53, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(17, 5, 54, 1, '111.000', 333000, 3000, 101, '333000', NULL, NULL, '0', '3000', '333000', '0', '61', '13', '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(18, 5, 55, 1, '11.000', 33000, 3000, 11, '33000', NULL, NULL, '0', '3000', '33000', '0', '6', '2', '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(19, 1, 56, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(20, 1, 57, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(21, 1, 58, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(22, 1, 59, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(23, 1, 60, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(24, 1, 61, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(25, 1, 62, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(26, 1, 63, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(27, 1, 64, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(28, 1, 65, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(29, 1, 66, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(30, 1, 67, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(31, 1, 68, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(32, 1, 69, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(33, 1, 70, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(34, 1, 71, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(35, 1, 72, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(36, 1, 73, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(37, 1, 74, 1, '10.000', 8, 1, 10, '9', NULL, NULL, '0', '1', '10', '2', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(38, 1, 75, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(39, 3, 75, NULL, '1.000', 500, 500, 1, '500', NULL, NULL, '0', '500', '500', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(40, 1, 76, 1, '1.000', 0, 1, 0, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(41, 3, 76, NULL, '1.000', 500, 500, 1, '500', NULL, NULL, '0', '500', '500', '0', NULL, NULL, '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(42, 5, 76, 1, '1.000', 3000, 3000, 0, '3000', NULL, NULL, '0', '3000', '3000', '0', '0', '11', '2023-06-12 11:26:43', NULL, NULL, '', NULL, '0.00'),
(43, 1, 77, 1, '100.000', 85, 1, NULL, '85', NULL, NULL, '0', '1', '100', '15', NULL, NULL, '2023-06-14 10:01:35', NULL, NULL, '', NULL, '0.00'),
(44, 1, 78, 1, '10.000', 8, 1, 10, '9', NULL, NULL, '0', '1', '10', '2', NULL, NULL, '2023-06-14 11:24:49', '2023-06-14 11:24:50', NULL, '', NULL, '0.00'),
(45, 1, 79, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 11:27:20', '2023-06-14 11:27:20', NULL, '', NULL, '0.00'),
(46, 1, 80, 1, '1.000', 0, 1, NULL, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 11:32:24', NULL, NULL, '', NULL, '0.00'),
(47, 1, 81, 1, '11.000', 9, 1, NULL, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:34:03', NULL, NULL, '', NULL, '0.00'),
(48, 1, 82, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:35:09', '2023-06-14 11:35:09', NULL, '', NULL, '0.00'),
(49, 1, 83, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:35:48', '2023-06-14 11:35:48', NULL, '', NULL, '0.00'),
(50, 1, 84, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:36:41', '2023-06-14 11:36:41', NULL, '', NULL, '0.00'),
(51, 1, 85, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:36:54', '2023-06-14 11:36:55', NULL, '', NULL, '0.00'),
(52, 1, 86, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:37:22', '2023-06-14 11:37:22', NULL, '', NULL, '0.00'),
(53, 1, 87, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:37:42', '2023-06-14 11:37:42', NULL, '', NULL, '0.00'),
(54, 1, 88, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:38:29', '2023-06-14 11:38:30', NULL, '', NULL, '0.00'),
(55, 1, 89, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 11:39:38', '2023-06-14 11:39:38', NULL, '', NULL, '0.00'),
(56, 4, 90, 1, '1.000', 1, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', '1', '0', '2023-06-14 11:52:09', '2023-06-14 11:52:09', NULL, '', NULL, '0.00'),
(57, 1, 91, 1, '10.000', 8, 1, 10, '9', NULL, NULL, '0', '1', '10', '2', NULL, NULL, '2023-06-14 11:53:38', '2023-06-14 11:53:39', NULL, '', NULL, '0.00'),
(58, 1, 92, 1, '10.000', 8, 1, 10, '9', NULL, NULL, '0', '1', '10', '2', NULL, NULL, '2023-06-14 12:04:27', '2023-06-14 12:04:27', NULL, '', NULL, '0.00'),
(59, 1, 95, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 13:42:56', '2023-06-14 13:42:56', NULL, NULL, NULL, '0.00'),
(60, 1, 96, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 14:06:34', '2023-06-14 14:06:35', NULL, NULL, NULL, '0.00'),
(61, 1, 97, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 14:22:39', '2023-06-14 14:22:39', NULL, NULL, NULL, '0.00'),
(62, 1, 98, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 14:59:43', '2023-06-14 14:59:43', NULL, NULL, NULL, '0.00'),
(63, 1, 99, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 15:04:12', '2023-06-14 15:04:12', NULL, NULL, NULL, '0.00'),
(64, 1, 100, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 15:08:34', '2023-06-14 15:08:35', NULL, NULL, NULL, '0.00'),
(65, 1, 101, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 15:28:03', '2023-06-14 15:28:03', NULL, NULL, NULL, '0.00'),
(66, 1, 102, 1, '11.000', 9, 1, 11, '9', NULL, NULL, '0', '1', '11', '2', NULL, NULL, '2023-06-14 15:29:19', '2023-06-14 15:29:19', NULL, NULL, NULL, '0.00'),
(67, 1, 103, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 17:07:41', '2023-06-14 17:07:42', NULL, NULL, NULL, '0.00'),
(68, 1, 104, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 17:12:43', '2023-06-14 17:12:49', NULL, NULL, NULL, '0.00'),
(69, 1, 105, 1, '1.000', 0, 1, 1, '1', NULL, NULL, '0', '1', '1', '0', NULL, NULL, '2023-06-14 19:26:03', '2023-06-14 19:26:04', NULL, NULL, NULL, '0.00'),
(70, 6, 106, 1, '1.000', 2600, 2600, 1, '2600', NULL, NULL, '0', '2600', '2600', '0', NULL, NULL, '2023-06-14 20:25:13', '2023-06-14 20:25:13', NULL, NULL, NULL, '0.00'),
(71, 6, 107, 1, '1.000', 2132, 2600, 1, '2132', NULL, NULL, '0', '2132', '2132', '0', NULL, NULL, '2023-06-14 20:43:18', '2023-06-14 20:43:20', NULL, 'FER DE 6 LISSE [UNITE]', 'A', '0.00'),
(72, 6, 108, 1, '1.000', 2600, 2600, 1, '2600', NULL, NULL, '0', '2600', '2600', '0', NULL, NULL, '2023-06-14 20:46:42', '2023-06-14 20:46:42', NULL, 'FER DE 6 LISSE [UNITE]', 'A', '0.00'),
(73, 6, 109, 1, '1.000', 2600, 2600, 1, '2600', NULL, NULL, '0', '2600', '2600', '0', NULL, NULL, '2023-06-14 21:33:04', '2023-06-14 21:33:04', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', '0.00'),
(74, 1, 110, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-06-15 11:49:26', '2023-06-15 11:49:26', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '0.00'),
(75, 6, 111, 1, '2.000', 5200, 2600, 2, '5200', NULL, NULL, '0', '2600', '5200', '0', NULL, NULL, '2023-06-15 16:05:53', '2023-06-15 16:05:53', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', '0.00'),
(76, 1, 111, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35400', '5400', NULL, NULL, '2023-06-15 16:05:53', '2023-06-15 16:05:53', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '0.00'),
(77, 6, 112, 1, '2.000', 6500, 2600, 2, '6500', NULL, NULL, '0', '2600', '6500', '0', NULL, NULL, '2023-06-15 17:53:52', '2023-06-15 17:53:53', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', '0.00'),
(78, 1, 112, 1, '3.000', 32500, 11800, 3, '32500', NULL, NULL, '0', '10000', '38350', '5850', NULL, NULL, '2023-06-15 17:53:52', '2023-06-15 17:53:53', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '0.00'),
(79, 6, 113, 1, '2.500', 6500, 2600, 2, '6500', NULL, NULL, '0', '2600', '6500', '0', NULL, NULL, '2023-06-15 18:03:29', '2023-06-15 18:03:30', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', '0.00'),
(80, 1, 113, 1, '3.250', 32500, 11800, 3, '32500', NULL, NULL, '0', '10000', '38350', '5850', NULL, NULL, '2023-06-15 18:03:29', '2023-06-15 18:03:30', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '0.00'),
(81, 6, 114, 1, '2.000', 5200, 2600, 2, '5200', NULL, NULL, '0', '2600', '5200', '0', NULL, NULL, '2023-06-15 18:30:16', '2023-06-15 18:30:17', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', '0.00'),
(82, 1, 114, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35400', '5400', NULL, NULL, '2023-06-15 18:30:16', '2023-06-15 18:30:17', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '0.00'),
(83, 1, 115, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35400', '5400', NULL, NULL, '2023-06-15 20:05:46', '2023-06-15 20:05:47', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '598.00'),
(84, 1, 116, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35998', '5400', NULL, NULL, '2023-06-16 13:25:07', '2023-06-16 13:25:07', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '598.00'),
(85, 1, 117, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35998', '5400', NULL, NULL, '2023-06-16 13:27:04', '2023-06-16 13:27:04', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '598.00'),
(86, 6, 118, 1, '2.000', 5200, 2600, 2, '5200', NULL, NULL, '0', '2600', '5200', '0', NULL, NULL, '2023-06-16 15:59:27', '2023-06-16 15:59:27', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', NULL),
(87, 1, 118, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35400', '5400', NULL, NULL, '2023-06-16 15:59:27', '2023-06-16 15:59:27', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(88, 6, 119, 1, '2.000', 5200, 2600, 2, '5200', NULL, NULL, '0', '2600', '5200', '0', NULL, NULL, '2023-06-16 16:02:09', '2023-06-16 16:02:10', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', NULL),
(89, 1, 119, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35400', '5400', NULL, NULL, '2023-06-16 16:02:09', '2023-06-16 16:02:10', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(90, 6, 120, 1, '2.000', 5200, 2600, 2, '5200', NULL, NULL, '0', '2600', '5200', '0', NULL, NULL, '2023-06-16 16:08:26', '2023-06-16 16:08:27', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', NULL),
(91, 1, 120, 1, '3.000', 30000, 11800, 3, '30000', NULL, NULL, '0', '10000', '35998', '5400', NULL, NULL, '2023-06-16 16:08:26', '2023-06-16 16:08:27', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '598.00'),
(92, 6, 121, 1, '2.000', 5200, 2600, 2, '5200', NULL, NULL, '0', '2600', '5200', '0', NULL, NULL, '2023-06-16 16:22:49', '2023-06-16 16:22:49', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', NULL),
(93, 1, 121, 1, '3.000', 30000, 11800, 3, '30507', NULL, NULL, '0', '10000', '35998', '5400', NULL, NULL, '2023-06-16 16:22:49', '2023-06-16 16:22:49', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', '598.00'),
(94, 1, 122, 1, '2.000', 20000, 11800, 2, '20000', NULL, NULL, '0', '10000', '23600', '3600', NULL, NULL, '2023-06-16 18:00:26', '2023-06-16 18:00:26', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(95, 8, 122, NULL, '1.000', 5000, 5000, 1, '5000', NULL, NULL, '0', '5000', '5000', '0', NULL, NULL, '2023-06-16 18:00:26', '2023-06-16 18:00:26', NULL, 'TAXE DE SEJOUR [UNITE]', 'F', NULL),
(96, 7, 123, 1, '2.000', 191000, 112690, 2, '191000', NULL, NULL, '0', '95500', '225380', '34380', NULL, NULL, '2023-06-16 18:47:42', '2023-06-16 18:47:43', NULL, 'TUYAUX PVC DE  100 [UNITE]', 'D', NULL),
(97, 7, 124, 1, '2.000', 191000, 112690, 2, '191508', NULL, NULL, '0', '95500', '225979', '34380', NULL, NULL, '2023-06-16 19:04:30', '2023-06-16 19:04:30', NULL, 'TUYAUX PVC DE  100 [UNITE]', 'D', '599.00'),
(98, 9, 125, 1, '2.000', 191000, 95500, 2, '191000', NULL, NULL, '0', '95500', '191000', '0', NULL, NULL, '2023-06-16 19:13:37', '2023-06-16 19:13:37', NULL, 'WC PARMA [UNITE]', 'E', NULL),
(99, 9, 126, 1, '2.000', 191000, 95500, 2, '191508', NULL, NULL, '0', '95500', '191600', '0', NULL, NULL, '2023-06-16 19:19:48', '2023-06-16 19:19:48', NULL, 'WC PARMA [UNITE]', 'E', '600.00'),
(100, 9, 127, 1, '2.000', 191000, 95500, 2, '191508', NULL, NULL, '0', '95500', '191600', '0', NULL, NULL, '2023-06-16 19:41:46', '2023-06-16 19:41:47', NULL, 'WC PARMA [UNITE]', 'E', '600.00'),
(101, 12, 128, 1, '2.000', 10000, 5000, 2, '10000', NULL, NULL, '0', '5000', '10000', '0', NULL, NULL, '2023-06-20 13:19:18', '2023-06-20 13:19:19', NULL, 'TUYAU EXPORTABLE [UNITE]', 'C', NULL),
(102, 12, 129, 1, '2.000', 10000, 5000, 2, '10000', NULL, NULL, '0', '5000', '10000', '0', NULL, NULL, '2023-06-20 15:54:44', '2023-06-20 15:54:44', NULL, 'TUYAU EXPORTABLE [UNITE]', 'C', NULL),
(103, 12, 130, 1, '2.000', 10000, 5000, 2, '10000', NULL, NULL, '0', '5000', '10000', '0', NULL, NULL, '2023-06-20 15:56:19', '2023-06-20 15:56:19', NULL, 'TUYAU EXPORTABLE [UNITE]', 'C', NULL),
(104, 12, 131, 1, '2.000', 10000, 5000, 2, '10000', NULL, NULL, '0', '5000', '10000', '0', NULL, NULL, '2023-06-20 18:37:23', '2023-06-20 18:37:24', NULL, 'TUYAU EXPORTABLE [UNITE]', 'C', NULL),
(105, 6, 132, 1, '2.000', 5200, 2600, 2, '5200', NULL, NULL, '0', '2600', '5200', '0', NULL, NULL, '2023-06-20 19:38:05', '2023-06-20 19:38:05', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', NULL),
(106, 12, 132, 1, '3.000', 15000, 5000, 3, '15000', NULL, NULL, '0', '5000', '15000', '0', NULL, NULL, '2023-06-20 19:38:05', '2023-06-20 19:38:05', NULL, 'TUYAU EXPORTABLE [UNITE]', 'C', NULL),
(107, 12, 133, 1, '2.000', 10000, 5000, 2, '10000', NULL, NULL, '0', '5000', '10000', '0', NULL, NULL, '2023-06-20 19:47:26', '2023-06-20 19:47:26', NULL, 'TUYAU EXPORTABLE [UNITE]', 'C', NULL),
(108, 14, 134, 1, '2.000', 191000, 95500, 2, '191000', NULL, NULL, '0', '95500', '191000', '0', NULL, NULL, '2023-06-20 20:20:06', '2023-06-20 20:20:06', NULL, 'PRO TPS [UNITE]', 'E', NULL),
(109, 4, 135, 1, '1.000', 5084, 6000, 1, '5085', NULL, NULL, '0', '5085', '6000', '915', '0', '2', '2023-06-21 13:03:54', '2023-06-21 13:03:54', NULL, 'CAREAU  POLY 60X60  VSP007 [METRE CARRE]', 'B', NULL),
(110, 4, 136, 1, '1.000', 5084, 6000, 1, '5085', NULL, NULL, '0', '5085', '6000', '915', '0', '2', '2023-06-21 13:04:44', '2023-06-21 13:04:45', NULL, 'CAREAU  POLY 60X60  VSP007 [METRE CARRE]', 'B', NULL),
(111, 4, 137, 1, '1.000', 5084, 6000, 1, '5085', NULL, NULL, '0', '5085', '6000', '915', '0', '2', '2023-06-21 13:07:18', '2023-06-21 13:07:18', NULL, 'CAREAU  POLY 60X60  VSP007 [METRE CARRE]', 'B', NULL),
(112, 1, 138, 1, '20.000', 200000, 11800, 20, '200000', NULL, NULL, '0', '10000', '236000', '36000', NULL, NULL, '2023-06-21 13:09:34', '2023-06-21 13:09:34', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(113, 9, 139, 1, '1.000', 95500, 95500, 1, '95500', NULL, NULL, '0', '95500', '95500', '0', NULL, NULL, '2023-06-21 13:12:41', '2023-06-21 13:12:41', NULL, 'WC PARMA [UNITE]', 'E', NULL),
(114, 17, 140, 1, '3.000', 30000, 11800, 3, '30492', NULL, NULL, '0', '10000', '35980', '5400', NULL, NULL, '2023-06-22 18:54:17', '2023-06-22 18:54:18', NULL, 'TUYAU PVC DE 1000 [UNITE]', 'B', '580.00'),
(115, 17, 141, 1, '3.000', 30000, 11800, 3, '30507', NULL, NULL, '0', '10000', '35998', '5400', NULL, NULL, '2023-06-22 18:55:42', '2023-06-22 18:55:43', NULL, 'TUYAU PVC DE 1000 [UNITE]', 'B', '598.00'),
(116, 1, 142, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-06-23 16:08:48', '2023-06-23 16:08:48', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(117, 1, 143, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-06-23 16:23:43', '2023-06-23 16:23:44', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(118, 17, 144, 1, '10.000', 100000, 11800, 5, '100000', NULL, NULL, '0', '10000', '118000', '18000', NULL, NULL, '2023-06-23 18:24:07', '2023-06-23 18:35:49', NULL, 'TUYAU PVC DE 1000 [UNITE]', 'B', NULL),
(119, 1, 145, 1, '2.000', 20000, 11800, 2, '20000', NULL, NULL, '0', '10000', '23600', '3600', NULL, NULL, '2023-06-26 16:51:54', '2023-06-26 16:51:54', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(120, 17, 146, 1, '15.000', 150000, 11800, 10, '150000', NULL, NULL, '0', '10000', '177000', '27000', NULL, NULL, '2023-06-26 17:05:22', '2023-06-26 17:07:37', NULL, 'TUYAU PVC DE 1000 [UNITE]', 'B', NULL),
(121, 1, 147, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-06-26 18:12:59', '2023-06-26 18:12:59', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(122, 1, 148, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-06-26 18:33:13', '2023-06-26 18:33:14', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(123, 1, 149, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-06-26 20:42:02', '2023-06-26 20:42:03', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(124, 1, 150, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-06-26 20:55:08', '2023-06-26 20:55:08', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(125, 1, 151, 1, '10.000', 100000, 11800, 0, '100000', NULL, NULL, '0', '10000', '118000', '18000', NULL, NULL, '2023-06-26 20:56:27', '2023-06-26 20:57:34', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(126, 7, 151, 1, '10.000', 955000, 112690, 0, '955000', NULL, NULL, '0', '95500', '1126900', '171900', NULL, NULL, '2023-06-26 20:56:27', '2023-06-26 20:57:34', NULL, 'TUYAUX PVC DE  100 [UNITE]', 'D', NULL),
(127, 1, 152, 1, '10.000', 100000, 11800, 0, '100000', NULL, NULL, '0', '10000', '118000', '18000', NULL, NULL, '2023-06-26 21:01:19', '2023-06-26 21:01:43', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(128, 1, 153, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-04 10:06:46', '2023-07-04 10:06:47', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(129, 1, 154, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-04 11:40:05', '2023-07-04 11:40:05', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(130, 6, 154, 1, '1.000', 2600, 2600, 1, '2600', NULL, NULL, '0', '2600', '2600', '0', NULL, NULL, '2023-07-04 11:40:05', '2023-07-04 11:40:05', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', NULL),
(131, 1, 155, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-05 09:51:48', '2023-07-05 09:51:49', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(132, 6, 155, 1, '1.000', 2600, 2600, 1, '2600', NULL, NULL, '0', '2600', '2600', '0', NULL, NULL, '2023-07-05 09:51:48', '2023-07-05 09:51:49', NULL, 'FER DE 6 LISSE [UNITE]', 'A-EX', NULL),
(135, 1, 157, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-05 10:18:24', '2023-07-05 10:18:25', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(136, 4, 157, 1, '1.000', 5084, 6000, 1, '5085', NULL, NULL, '0', '5085', '6000', '915', '0', '2', '2023-07-05 10:18:24', '2023-07-05 10:18:25', NULL, 'CAREAU  POLY 60X60  VSP007 [METRE CARRE]', 'B', NULL),
(137, 1, 158, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-05 11:56:03', '2023-07-05 11:56:05', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(138, 5, 158, 1, '1.000', 3000, 3000, 1, '3000', NULL, NULL, '0', '3000', '3000', '0', '0', '11', '2023-07-05 11:56:03', '2023-07-05 11:56:05', NULL, 'CARREAU SOL 30X30 [METRE CARRE]', 'E', NULL),
(139, 1, 159, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-06 18:32:22', '2023-07-06 18:32:22', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(140, 1, 160, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-06 18:34:23', '2023-07-06 18:34:24', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(141, 1, 161, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-06 18:41:52', '2023-07-06 18:41:53', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(142, 1, 162, 1, '1.000', 10000, 11800, 1, '10000', NULL, NULL, '0', '10000', '11800', '1800', NULL, NULL, '2023-07-06 18:58:25', '2023-07-06 18:58:26', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(143, 1, 163, 1, '11.000', 110000, 11800, 11, '110000', NULL, NULL, '0', '10000', '129800', '19800', NULL, NULL, '2023-07-06 19:05:35', '2023-07-06 19:05:36', NULL, 'COLONNE DE DOUCHES [UNITE]', 'B', NULL),
(144, 23, 164, 4, '1.000', 100, 100, 0, '100', NULL, NULL, '0', '100', '100', '0', NULL, NULL, '2023-07-11 17:36:34', '2023-07-11 17:53:00', NULL, 'test 22 [UNITE]', 'A-EX', NULL),
(145, 23, 165, 4, '1.000', 100, 100, 0, '100', NULL, NULL, '0', '100', '100', '0', NULL, NULL, '2023-07-11 18:06:24', '2023-07-11 18:11:52', NULL, 'test 22 [UNITE]', 'A-EX', NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_com_frs`
--

INSERT INTO `produit_cond_com_frs` (`id`, `commande_frs_id`, `produit_cond_id`, `qte_comfrs`, `montant_cond`, `prix_unitaire`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 6, 1, '1000.00', '1000.00', '1.00', '2023-06-30 11:39:17', NULL, NULL),
(2, 6, 4, '50.00', '50.00', '1.00', '2023-06-30 11:39:17', NULL, NULL),
(3, 7, 1, '1000.00', '1000.00', '1.00', '2023-06-30 11:39:17', NULL, NULL),
(4, 7, 4, '50.00', '50.00', '1.00', '2023-06-30 11:39:17', NULL, NULL),
(5, 8, 1, '1000.00', '1000.00', '1.00', '2023-06-30 11:39:17', NULL, NULL),
(6, 8, 4, '50.00', '50.00', '1.00', '2023-06-30 11:39:17', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_ddp`
--

INSERT INTO `produit_cond_ddp` (`id`, `demande_de_prix_id`, `produit_cond_id`, `qte_ddp`, `montant`) VALUES
(1, 5, 1, '1.00', NULL),
(2, 4, 1, '100.00', NULL),
(3, 4, 2, '100.00', NULL),
(4, 6, 1, '1000.00', NULL),
(5, 6, 4, '50.00', NULL);

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
  `qte_stock_mag` decimal(10,2) NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4DBA201320096AE3` (`magasin_id`),
  KEY `IDX_4DBA201339C2AB40` (`produit_conditionnement_id`),
  KEY `IDX_4DBA2013EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_mag`
--

INSERT INTO `produit_cond_mag` (`id`, `magasin_id`, `produit_conditionnement_id`, `qte_stock_mag`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`, `est_sup`) VALUES
(1, 1, 1, '172.00', 1, '2023-05-31 16:40:33', '2023-06-29 16:07:35', NULL, NULL),
(2, 1, 2, '50.00', 1, '2023-05-31 17:53:34', '2023-05-31 17:54:34', '2023-05-31 17:54:34', NULL),
(3, 1, 5, '989.00', 1, '2023-06-06 00:04:46', '2023-06-07 17:35:46', NULL, NULL),
(4, 1, 4, '12.00', 1, '2023-06-09 11:26:32', '2023-06-22 13:00:17', NULL, NULL),
(5, 1, 6, '77.00', 1, '2023-06-14 20:24:15', '2023-06-22 19:53:20', NULL, NULL),
(6, 1, 7, '90.00', 1, '2023-06-16 18:39:39', '2023-06-26 20:58:17', NULL, NULL),
(7, 1, 9, '100.00', 1, '2023-06-16 19:10:47', NULL, NULL, NULL),
(8, 1, 10, '100.00', 1, '2023-06-20 11:21:40', '2023-06-20 13:10:23', '2023-06-20 13:10:23', NULL),
(9, 1, 12, '100.00', 1, '2023-06-20 13:17:53', NULL, NULL, NULL),
(10, 1, 14, '100.00', 1, '2023-06-20 20:18:12', '2023-06-21 19:36:31', '2023-06-21 19:36:31', NULL),
(11, 3, 7, '10.00', 1, '2023-06-22 15:06:16', NULL, NULL, NULL),
(12, 3, 6, '23.00', 1, '2023-06-22 15:19:33', '2023-06-22 19:54:40', NULL, NULL),
(13, 1, 17, '980.00', 1, '2023-06-22 18:52:46', '2023-06-26 18:47:56', NULL, NULL),
(14, 1, 18, '1000.00', 1, '2023-06-22 20:07:07', '2023-06-23 09:49:18', '2023-06-23 09:49:18', NULL),
(15, 3, 18, '0.00', 1, '2023-06-22 20:10:34', '2023-06-23 09:49:18', '2023-06-23 09:49:18', NULL),
(16, 2, 17, '10.00', 1, '2023-06-26 18:47:56', NULL, NULL, NULL),
(17, 4, 23, '100.00', 2, '2023-07-11 17:26:11', '2023-07-11 18:18:05', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_mag_inv`
--

INSERT INTO `produit_cond_mag_inv` (`id`, `inventaire_mag_id`, `produit_cond_inv_id`, `qte_cond_stock_log`, `qte_cond_stock_phy`, `ecart`, `debit`, `credit`, `prix_unitaire`, `est_cloturer`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '61.00', '60.00', '-1.00', NULL, NULL, NULL, 1, '2023-06-08 09:54:51', '2023-06-08 10:54:30', NULL);

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
  `qte_aliv` int NOT NULL,
  `prix` decimal(10,0) NOT NULL,
  `carton` decimal(10,0) DEFAULT NULL,
  `piece` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_921833C5B76E34A8` (`livraison_mag_id`),
  KEY `IDX_921833C5F1787AB9` (`produit_com_clit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_mag_liv`
--

INSERT INTO `produit_cond_mag_liv` (`id`, `livraison_mag_id`, `produit_com_clit_id`, `qte_liv`, `qte_raliv`, `montant_cond`, `qte_aliv`, `prix`, `carton`, `piece`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 40, '1.00', '0.00', NULL, 1, '1', NULL, NULL, '2023-06-07 14:15:25', NULL, NULL),
(2, 1, 42, '1.00', '0.00', NULL, 1, '3000', '0', '11', '2023-06-07 14:15:25', NULL, NULL),
(3, 2, 17, '0.00', '111.00', NULL, 111, '3000', '0', '0', '2023-06-07 17:24:47', NULL, NULL),
(4, 3, 17, '10.00', '101.00', NULL, 111, '3000', '5', '11', '2023-06-07 17:35:46', NULL, NULL),
(5, 4, 118, '5.00', '5.00', NULL, 10, '11800', '0', '0', '2023-06-23 18:35:48', NULL, NULL),
(6, 5, 120, '5.00', '10.00', NULL, 15, '11800', NULL, NULL, '2023-06-26 17:07:36', NULL, NULL),
(7, 6, 125, '3.00', '7.00', NULL, 10, '11800', NULL, NULL, '2023-06-26 20:57:01', NULL, NULL),
(8, 6, 126, '3.00', '7.00', NULL, 10, '112690', NULL, NULL, '2023-06-26 20:57:01', NULL, NULL),
(9, 7, 125, '5.00', '2.00', NULL, 7, '11800', NULL, NULL, '2023-06-26 20:57:18', NULL, NULL),
(10, 7, 126, '5.00', '2.00', NULL, 7, '112690', NULL, NULL, '2023-06-26 20:57:18', NULL, NULL),
(11, 8, 125, '2.00', '0.00', NULL, 2, '11800', NULL, NULL, '2023-06-26 20:57:34', NULL, NULL),
(12, 8, 126, '2.00', '0.00', NULL, 2, '112690', NULL, NULL, '2023-06-26 20:57:34', NULL, NULL),
(13, 9, 127, '10.00', '0.00', NULL, 10, '11800', NULL, NULL, '2023-06-26 21:01:43', NULL, NULL),
(14, 10, 144, '1.00', '0.00', NULL, 1, '100', NULL, NULL, '2023-07-11 17:52:59', NULL, NULL),
(15, 11, 145, '1.00', '0.00', NULL, 1, '100', NULL, NULL, '2023-07-11 18:11:52', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_sortie_mag`
--

INSERT INTO `produit_cond_sortie_mag` (`id`, `sortie_mag_id`, `produit_cond_id`, `prod_cond_mag_id`, `qte_cond_sortie`, `prix_unitaire`, `montant`, `est_sup`) VALUES
(2, 2, 1, 1, '10.00', '1000.00', NULL, NULL),
(5, 5, 1, 1, '10.00', '1000.00', NULL, NULL),
(6, 6, 1, 1, '7.00', '1000.00', NULL, NULL),
(7, 7, 1, 1, '8.00', '1000.00', NULL, NULL),
(8, 8, 1, 1, '3.00', '1000.00', NULL, NULL),
(9, 9, 7, 6, '10.00', '112690.00', NULL, NULL),
(10, 10, 17, 13, '5.00', '11800.00', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `produit_cond_trans`
--

INSERT INTO `produit_cond_trans` (`id`, `transfert_id`, `produit_cond_id`, `qte_cond_trans`, `prix_unitaire`) VALUES
(1, 4, 7, '10.00', '112690.00'),
(2, 5, 6, '10.00', '2600.00'),
(5, 8, 6, '3.00', '2600.00'),
(6, 9, 18, '100.00', '11.00'),
(7, 10, 17, '10.00', '11800.00');

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
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
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
  `denomination` varchar(255) NOT NULL,
  `sigle` varchar(255) NOT NULL,
  `raison_sociale` varchar(255) NOT NULL,
  `ifu` varchar(255) NOT NULL,
  `rccm` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `est_regime_tps` tinyint(1) NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  `api_link` varchar(255) DEFAULT NULL,
  `api_nim` varchar(255) DEFAULT NULL,
  `api_token` longtext,
  `est_mode_mecef` tinyint(1) NOT NULL,
  `lieu_impression` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `message_commercial` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_19653DBDF98F144A` (`logo_id`),
  UNIQUE KEY `UNIQ_19653DBDEC285501` (`entete_id`),
  UNIQUE KEY `UNIQ_19653DBDF31E83EB` (`pied_de_page_id`),
  KEY `IDX_19653DBDEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `societe`
--

INSERT INTO `societe` (`id`, `logo_id`, `entete_id`, `pied_de_page_id`, `denomination`, `sigle`, `raison_sociale`, `ifu`, `rccm`, `adresse`, `telephone`, `est_sup`, `est_regime_tps`, `point_vente_id`, `api_link`, `api_nim`, `api_token`, `est_mode_mecef`, `lieu_impression`, `created_at`, `updated_at`, `deleted_at`, `message_commercial`) VALUES
(1, NULL, 1, NULL, 'romas', 'romas', 'romas', '3201501642813', 'romas', '7 chemin du rivage', '0678099878', NULL, 0, NULL, 'https://developper.impots.bj/sygmef-emcf', 'TS01003999', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjMyMDE1MDE2NDI4MTN8VFMwMTAwMzk5OSIsInJvbGUiOiJUYXhwYXllciIsIm5iZiI6MTY4NjY3NTkzNiwiZXhwIjoxNzAzOTc3MjAwLCJpYXQiOjE2ODY2NzU5MzYsImlzcyI6ImltcG90cy5iaiIsImF1ZCI6ImltcG90cy5iaiJ9.j0wNlllvxEsrdBCcVbH5pHD2ORS4b9OCQtqot8g_3Rg', 1, 'Cotonou', '2023-06-20 11:12:49', '2023-06-20 11:12:49', NULL, 'Merci');

-- --------------------------------------------------------

--
-- Structure de la table `sortie`
--

DROP TABLE IF EXISTS `sortie`;
CREATE TABLE IF NOT EXISTS `sortie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `auteur_id` int DEFAULT NULL,
  `date_sortie` datetime NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `motif` longtext NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3C3FD3F260BB6FE6` (`auteur_id`),
  KEY `IDX_3C3FD3F2EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `sortie`
--

INSERT INTO `sortie` (`id`, `auteur_id`, `date_sortie`, `montant_total`, `motif`, `est_sup`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 1, '2023-06-01 16:59:25', '10000.00', 'de', 1, NULL, '2023-06-01 16:59:26', '2023-06-01 17:07:24', '2023-06-01 17:07:24'),
(5, 1, '2023-06-01 17:09:58', '10000.00', 'test', 1, NULL, '2023-06-01 17:09:59', '2023-06-01 17:20:34', '2023-06-01 17:20:34'),
(6, 1, '2023-06-01 17:24:02', '7000.00', 'des', 1, NULL, '2023-06-01 17:27:02', '2023-06-01 17:27:45', '2023-06-01 17:27:45'),
(7, 1, '2023-06-01 17:25:05', '8000.00', 'des', 1, NULL, '2023-06-01 17:25:06', '2023-06-01 17:30:04', '2023-06-01 17:30:04'),
(8, 1, '2023-06-01 17:29:36', '3000.00', 'test', 1, NULL, '2023-06-01 17:29:37', '2023-06-01 17:31:56', '2023-06-01 17:31:56'),
(9, 2, '2023-06-22 13:19:54', '1126900.00', 'test', 1, NULL, '2023-06-22 13:19:55', '2023-06-22 13:49:28', '2023-06-22 13:49:28'),
(10, 2, '2023-06-26 18:38:32', '59000.00', 'test de sortie', NULL, 1, '2023-06-26 18:38:33', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `sortie_mag`
--

INSERT INTO `sortie_mag` (`id`, `sortie_id`, `magasin_id`, `est_sup`) VALUES
(2, 2, 1, NULL),
(5, 5, 1, NULL),
(6, 6, 1, NULL),
(7, 7, 1, NULL),
(8, 8, 1, NULL),
(9, 9, 1, NULL),
(10, 10, 1, NULL);

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
  `code_taxe` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
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

INSERT INTO `taxe` (`id`, `type_taxe_id`, `libelle`, `appellation`, `type_taux`, `taux`, `sens`, `code_taxe`, `est_sup`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'TAXE SUR VALEUR AJOUTEE', 'TVA', 0, '18.00', 1, 'TVA', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(2, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '1.00', 0, 'AIB1', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(3, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '5.00', 0, 'AIB5', 1, NULL, '2023-05-19 21:09:57', NULL, NULL),
(4, NULL, 'ACCOMPTE ASSIS SUR IMPÖTS', 'AIB', 0, '3.00', 0, 'AIB3', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(5, NULL, 'EXONERE', 'EX', 0, '0.00', 1, 'TVA-EX', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(6, NULL, 'EXPORTATION', 'TVA-EXP', 0, '0.00', 1, 'TVA-EXP', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(7, NULL, 'TVA REGIME D\'EXCEPTION 18%', 'TVAD', 0, '18.00', 1, 'TVAD', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(8, NULL, 'TPS', 'E', 0, '0.00', 1, 'E', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL),
(9, NULL, 'RESERVE', 'F', 0, '0.00', 1, 'F', NULL, NULL, '2023-05-19 21:09:57', NULL, NULL);

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
  `date_transac` datetime NOT NULL,
  `ref_transac` varchar(255) DEFAULT NULL,
  `montant_transac` decimal(10,2) NOT NULL,
  `numero_mobile_money` varchar(100) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `caisse_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `motif` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_723705D1C3EF8F86` (`type_operation_id`),
  KEY `IDX_723705D119EB6921` (`client_id`),
  KEY `IDX_723705D1F2C56620` (`compte_id`),
  KEY `IDX_723705D1438F5B63` (`mode_paiement_id`),
  KEY `IDX_723705D1F46EBEEB` (`compte_banque_id`),
  KEY `IDX_723705D1EFA24D68` (`point_vente_id`),
  KEY `IDX_723705D127B4FEBF` (`caisse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `transaction`
--

INSERT INTO `transaction` (`id`, `type_operation_id`, `client_id`, `compte_id`, `mode_paiement_id`, `compte_banque_id`, `date_transac`, `ref_transac`, `montant_transac`, `numero_mobile_money`, `est_sup`, `point_vente_id`, `caisse_id`, `created_at`, `updated_at`, `deleted_at`, `motif`) VALUES
(1, 1, 2, 1, 1, NULL, '2023-05-22 00:00:00', NULL, '5000.00', NULL, NULL, 1, NULL, '2023-05-22 12:03:13', NULL, NULL, NULL),
(2, 1, 2, NULL, 1, 1, '2023-05-22 12:05:16', 'eee', '4000.00', NULL, NULL, 1, NULL, '2023-05-22 12:05:17', NULL, NULL, NULL),
(3, 1, 4, 4, NULL, NULL, '2023-06-21 14:21:24', NULL, '20000.00', NULL, NULL, 1, 18, '2023-06-21 14:21:24', NULL, NULL, 'Dépôt initial'),
(4, 1, 7, 5, NULL, NULL, '2023-06-26 19:27:46', NULL, '1.00', NULL, NULL, 1, 18, '2023-06-26 19:27:46', NULL, NULL, 'Dépôt initial');

-- --------------------------------------------------------

--
-- Structure de la table `transfert`
--

DROP TABLE IF EXISTS `transfert`;
CREATE TABLE IF NOT EXISTS `transfert` (
  `id` int NOT NULL AUTO_INCREMENT,
  `magasin_trans1_id` int NOT NULL,
  `magasin_trans2_id` int NOT NULL,
  `date_trans` datetime NOT NULL,
  `motif` longtext NOT NULL,
  `montant_total` decimal(10,2) DEFAULT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1E4EACBB3CE82F8F` (`magasin_trans1_id`),
  KEY `IDX_1E4EACBB2E5D8061` (`magasin_trans2_id`),
  KEY `IDX_1E4EACBBEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `transfert`
--

INSERT INTO `transfert` (`id`, `magasin_trans1_id`, `magasin_trans2_id`, `date_trans`, `motif`, `montant_total`, `est_sup`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 3, '2023-05-19 19:13:07', 'TEST', '20000.00', NULL, NULL, '2023-05-19 19:19:18', '2023-05-19 19:19:18', NULL),
(2, 1, 2, '2023-05-24 12:19:24', 'e', '11000.00', NULL, NULL, '2023-05-24 12:19:25', NULL, NULL),
(4, 1, 3, '2023-06-22 15:06:14', 'TEST', '1126900.00', NULL, NULL, '2023-06-22 15:06:16', NULL, NULL),
(5, 1, 3, '2023-06-22 15:19:32', 'TEST2', '26000.00', 1, NULL, '2023-06-22 15:19:33', '2023-06-22 19:53:18', '2023-06-22 19:53:18'),
(8, 1, 3, '2023-06-22 17:18:52', 'test', '7800.00', NULL, NULL, '2023-06-22 17:18:54', NULL, NULL),
(9, 1, 3, '2023-06-22 20:10:33', 'DD', '1100.00', 1, NULL, '2023-06-22 20:10:34', '2023-06-22 20:17:11', '2023-06-22 20:17:11'),
(10, 1, 2, '2023-06-26 18:47:55', 'test', '118000.00', NULL, 1, '2023-06-26 18:47:56', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `type_depense`
--

INSERT INTO `type_depense` (`id`, `point_vente_id`, `libelle`, `est_sup`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'Salaire du personnel', NULL, NULL, NULL, NULL),
(2, NULL, 'Reparation des motos', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `type_inventaire`
--

DROP TABLE IF EXISTS `type_inventaire`;
CREATE TABLE IF NOT EXISTS `type_inventaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
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
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AD47E77DEFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `type_operation`
--

INSERT INTO `type_operation` (`id`, `libelle`, `est_sup`, `point_vente_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Dépôt', NULL, NULL, '2023-05-19 22:53:26', NULL, NULL),
(2, 'Retrait', NULL, NULL, '2023-05-19 22:53:26', NULL, NULL),
(3, 'test', 1, 1, '2023-06-01 15:18:31', '2023-06-14 19:17:08', '2023-06-14 19:17:08'),
(4, 'test', NULL, 1, '2023-06-01 15:21:35', NULL, NULL),
(5, 'test', 1, 1, '2023-06-01 15:58:01', '2023-06-14 19:17:14', '2023-06-14 19:17:14'),
(6, 'test', NULL, 1, '2023-06-01 16:00:29', NULL, NULL),
(7, 'eee', NULL, 1, '2023-06-02 11:19:46', NULL, NULL),
(8, 'Dépôt MOMO', NULL, 1, '2023-06-02 11:23:59', NULL, NULL),
(9, 'scccs', NULL, 1, '2023-06-02 11:28:08', NULL, NULL),
(10, 'scccs', NULL, 1, '2023-06-02 11:29:41', NULL, NULL),
(11, 'ffff', NULL, 1, '2023-06-02 11:30:56', NULL, NULL),
(12, 'ffff', NULL, 1, '2023-06-02 11:31:44', NULL, NULL),
(13, 'ffff', NULL, 1, '2023-06-02 11:31:46', NULL, NULL),
(14, 'mljn', NULL, 1, '2023-06-02 11:32:29', NULL, NULL),
(15, 'testvc', NULL, 1, '2023-06-02 11:34:46', NULL, NULL),
(16, 'test ok', NULL, 1, '2023-06-02 11:38:34', NULL, NULL),
(17, 'tetete', NULL, 1, '2023-06-02 11:40:14', NULL, NULL),
(18, 'uirhutuie', 1, 1, '2023-06-02 11:40:52', '2023-06-14 19:17:32', '2023-06-14 19:17:32'),
(19, 'kkkk', 1, 1, '2023-06-02 11:41:34', '2023-06-14 19:17:42', '2023-06-14 19:17:42'),
(20, 'uoiop', NULL, 1, '2023-06-02 11:43:04', NULL, NULL),
(21, 'jnklo', NULL, 1, '2023-06-02 11:44:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `type_taxe`
--

DROP TABLE IF EXISTS `type_taxe`;
CREATE TABLE IF NOT EXISTS `type_taxe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_813DEAE1EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `type_taxe`
--

INSERT INTO `type_taxe` (`id`, `code`, `libelle`, `est_sup`, `point_vente_id`) VALUES
(1, 'MT', 'Montant', NULL, NULL),
(2, '%', 'Pourcentage', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `est_sup` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `username` varchar(180) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  `point_vente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1D1C63B3F85E0677` (`username`),
  UNIQUE KEY `UNIQ_1D1C63B31C109075` (`personnel_id`),
  KEY `IDX_1D1C63B3EFA24D68` (`point_vente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `personnel_id`, `est_sup`, `created_at`, `updated_at`, `deleted_at`, `username`, `roles`, `password`, `point_vente_id`) VALUES
(1, 1, NULL, '2023-06-14 10:57:41', '2023-06-14 10:57:42', NULL, 'disnel', '[\"ROLE_USER\", \"ROLE_SUPER_ADMIN\"]', '$2y$13$OXTvBYlxz.6BD9uhDk7KuOGsxJb9OdWrt37GLd5P46ooaIc2wd486', 1),
(2, 2, NULL, '2023-06-14 10:58:33', '2023-06-14 10:58:34', NULL, 'fa', '[\"ROLE_USER\", \"ROLE_SUPER_ADMIN\"]', '$2y$13$sx4STikyzagiNaBUJST3duO0bixewyNKbGFnq8QL.g7JxKTVnyk2K', 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `utilisateur_point_de_vente`
--

INSERT INTO `utilisateur_point_de_vente` (`id`, `utilisateur_id`, `point_de_vente_id`, `est_actif`) VALUES
(1, 1, 1, 0),
(2, 2, 1, 1),
(3, 2, 2, 1);

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
  ADD CONSTRAINT `FK_C510FF80EFA24D68` FOREIGN KEY (`point_vente_id`) REFERENCES `point_de_vente` (`id`);

--
-- Contraintes pour la table `commande_frs`
--
ALTER TABLE `commande_frs`
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
-- Contraintes pour la table `prod_cond_fact`
--
ALTER TABLE `prod_cond_fact`
  ADD CONSTRAINT `FK_C3C2615A7F2DEE08` FOREIGN KEY (`facture_id`) REFERENCES `facture` (`id`),
  ADD CONSTRAINT `FK_C3C2615AF1787AB9` FOREIGN KEY (`produit_com_clit_id`) REFERENCES `produit_cond_com_clit` (`id`),
  ADD CONSTRAINT `FK_C3C2615AF347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit_conditionnement` (`id`);

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

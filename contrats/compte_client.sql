-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 15 mai 2025 à 11:36
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `compte_client`
--

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `id` int(11) NOT NULL,
  `id_publication_id` int(11) NOT NULL,
  `id_commentaire_parent_id` int(11) DEFAULT NULL,
  `texte` longtext NOT NULL,
  `date_heure_insertion` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `date_heure_maj` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contrat`
--

CREATE TABLE `contrat` (
  `id` int(11) NOT NULL,
  `id_utilisateur_id` int(11) NOT NULL,
  `intitule` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `date_debut_prevue` datetime DEFAULT NULL,
  `date_fin_prevue` datetime DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `chemin_fichier` varchar(255) DEFAULT NULL,
  `date_heure_insertion` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `date_heure_maj` datetime DEFAULT NULL,
  `numero_contrat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `contrat`
--

INSERT INTO `contrat` (`id`, `id_utilisateur_id`, `intitule`, `description`, `date_debut_prevue`, `date_fin_prevue`, `date_debut`, `date_fin`, `chemin_fichier`, `date_heure_insertion`, `date_heure_maj`, `numero_contrat`) VALUES
(13, 28, 'Contrat de mission de conseil en architecture d’intérieur (Prestation ponctuelle)', 'Le Prestataire est chargé de fournir un avis professionnel sur l’aménagement intérieur du\r\nlogement/bureau situé à [adresse du lieu]', '2025-05-16 11:32:00', '2025-05-30 11:32:00', NULL, NULL, 'utilisateurs/28/contrat/contrat-1-15052025_11_32_49.pdf', '2025-05-15 11:32:49', NULL, 'MD_1_09052025'),
(14, 28, 'Contrat de conception d’un projet d’aménagement (Sans suivi de travaux)', 'Le Prestataire conçoit un projet d’aménagement intérieur pour [type de lieu, ex : un appartement de 60 m²], situé à [adresse].', '2025-05-16 11:34:00', '2025-05-30 11:34:00', NULL, NULL, 'utilisateurs/28/contrat/contrat-2-15052025_11_34_14.pdf', '2025-05-15 11:34:14', NULL, 'MD-2-09052025'),
(15, 28, 'Contrat complet avec suivi de chantier', 'Conception et suivi de la réalisation d’un projet d’aménagement intérieur pour le bien situé à [adresse].', '2025-05-16 11:35:00', '2025-05-30 11:35:00', NULL, NULL, 'utilisateurs/28/contrat/contrat-3-15052025_11_35_22.pdf', '2025-05-15 11:35:22', NULL, 'MD_3_07052025');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250423135619', '2025-04-28 13:16:20', 276),
('DoctrineMigrations\\Version20250507192603', '2025-05-07 19:26:48', 307);

-- --------------------------------------------------------

--
-- Structure de la table `etat_contrat`
--

CREATE TABLE `etat_contrat` (
  `id` int(11) NOT NULL,
  `id_utilisateur_id` int(11) DEFAULT NULL,
  `id_contrat_id` int(11) NOT NULL,
  `etat` varchar(30) NOT NULL,
  `date_heure_insertion` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `date_heure_maj` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `etat_contrat`
--

INSERT INTO `etat_contrat` (`id`, `id_utilisateur_id`, `id_contrat_id`, `etat`, `date_heure_insertion`, `date_heure_maj`) VALUES
(25, 25, 13, 'En discussion', '2025-05-15 09:32:49', NULL),
(26, 25, 14, 'En discussion', '2025-05-15 09:34:14', NULL),
(27, 25, 15, 'En discussion', '2025-05-15 09:35:22', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `messenger_messages`
--

INSERT INTO `messenger_messages` (`id`, `body`, `headers`, `queue_name`, `created_at`, `available_at`, `delivered_at`) VALUES
(1, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:175:\\\"https://127.0.0.1:8000/verify/email?expires=1745867777&id=5&signature=RiliNUzTSnTEKom1T5vIrHzNIFi1ha4Stzz3CZoN8Nc%3D&token=uOTzJ%2Fb0hrvdY%2BtDpVjJuGbXlJ8Ve5MXFshGCE%2Femos%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:17:\\\"contact@clo-ad.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:16:\\\"CLO Architecture\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:23:\\\"georges.dreiding@sfr.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2025-04-28 18:16:17', '2025-04-28 18:16:17', NULL),
(2, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:181:\\\"https://127.0.0.1:8000/verify/email?expires=1745867911&id=6&signature=H5H9wpy%2Fm8PYn%2Bw7qYC49KuOOG0WTKUz%2F%2BOwjKvANus%3D&token=K1nyL4u%2BRLhtPYlDeTA1xd1m%2FemHOPYYYbdtFfX1d6g%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:17:\\\"contact@clo-ad.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:16:\\\"CLO Architecture\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:23:\\\"georges.dreiding@sfr.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2025-04-28 18:18:31', '2025-04-28 18:18:31', NULL),
(3, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:177:\\\"https://127.0.0.1:8000/verify/email?expires=1745870629&id=7&signature=CBuFP9upkrYu1i15HrbvK34IK%2Bi5apFPBuRd8obX5Ts%3D&token=yVsERmInhxsSyEm%2BFA8beqnL%2BXIDeX80un%2F2BQ0g4m4%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:17:\\\"contact@clo-ad.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:16:\\\"CLO Architecture\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:23:\\\"georges.dreiding@sfr.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2025-04-28 19:03:49', '2025-04-28 19:03:49', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `photo`
--

CREATE TABLE `photo` (
  `id` int(11) NOT NULL,
  `id_publication_id` int(11) NOT NULL,
  `id_commentaire_id` int(11) DEFAULT NULL,
  `legende` varchar(255) DEFAULT NULL,
  `chemin_fichier_image` varchar(500) NOT NULL,
  `date_heure_insertion` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `date_heure_maj` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `publication`
--

CREATE TABLE `publication` (
  `id` int(11) NOT NULL,
  `id_utilisateur_id` int(11) NOT NULL,
  `id_contrat_id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `contenu` longtext NOT NULL,
  `date_heure_insertion` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `date_heure_maj` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `courriel` varchar(180) NOT NULL,
  `medias_de_contact` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`medias_de_contact`)),
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `genre` varchar(20) NOT NULL,
  `telephone_fixe` varchar(30) DEFAULT NULL,
  `telephone_mobile` varchar(30) DEFAULT NULL,
  `rue_et_numero` varchar(255) NOT NULL,
  `code_postal` varchar(20) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `societe` varchar(100) DEFAULT NULL,
  `date_heure_insertion` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `date_heure_maj` datetime DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `courriel`, `medias_de_contact`, `roles`, `password`, `prenom`, `nom`, `genre`, `telephone_fixe`, `telephone_mobile`, `rue_et_numero`, `code_postal`, `ville`, `societe`, `date_heure_insertion`, `date_heure_maj`, `is_verified`) VALUES
(24, 'contact@ad-clo.fr', '[\"SMS\"]', '[\"ROLE_EMPLOYE_ADMINISTRATEUR\"]', '$2y$13$2AzZ.ZKWpFLUBXojEIOiCu9ZiH0sIej/aSYQZ8TO8LInvPmj1tr3e', 'Clara', 'Israel', 'Femme', '+33 1 02 03 04 05', '+33 6 02 03 04 05', '151 rue des Rabats', '92160', 'Antony', 'CLO architecture', '2025-04-29 14:34:21', NULL, 0),
(25, 'aurelien.Avert@ad-clo.fr', '[\"SMS\"]', '[\"ROLE_EMPLOYE_ADMINISTRATEUR\"]', '$2y$13$77zdy10BOY2PmIqO3dTtpeDD1D3Om6ENgWrL1Kp2BFdhsoLXLfwhO', 'Aurélien', 'Avert', 'Homme', '+33 1 06 07 08 09', '+33 6 06 07 08 09', '1 rue de l\'industrie', '74000', 'Annecy', 'CLO architecture', '2025-04-29 14:34:21', NULL, 0),
(26, 'eleonor.majault@ad-clo.fr', '[\"SMS\"]', '[\"ROLE_EMPLOYE\"]', '$2y$13$YDIgi7jG4EdvkZQrTfPM5ufoLsJCFmt9HZ94P1Q/jeiEkvvlkj.rq', 'Eléonor', 'Majault', 'Femme', '+33 1 10 11 12 13', '+33 6 10 11 12 13', '2 rue de l\'industrie', '74000', 'Annecy', 'CLO architecture', '2025-04-29 14:34:22', NULL, 0),
(27, 'anais.molliex@ad-clo.fr', '[\"SMS\",\"Courriel\"]', '[\"ROLE_EMPLOYE\",\"ROLE_UTILISATEUR\"]', '$2y$13$.6XJIJRKoqybxaTCTB5lk.PX1GqHFnt7RFxmwz6Z.mZOqpiBCu56q', 'Anaïs', 'Molliex', 'Femme', '+33 1 14 15 16 17', '+33 6 14 15 16 17', '3 rue de l\'industrie', '74000', 'Annecy', 'CLO architecture', '2025-04-29 14:34:22', '2025-05-05 14:56:07', 0),
(28, 'marc.dupont@ad-clo.fr', '[\"SMS\",\"Courriel\"]', '{\"0\":\"ROLE_CLIENT\",\"2\":\"ROLE_CLIENT_POTENTIEL\"}', '$2y$13$uWULejMQ7xcfuGQVIC2QQ.h/r0RijTEzwLgrJZrxjWlv.rx/9Mw42', 'Marc', 'Dupont', 'Homme', '+33 1 19 20 21 22', '+33 6 19 20 21 22', '45 rue des Lilas', '75015', 'Paris', 'Indépendant', '2025-04-29 14:34:22', '2025-05-06 13:24:27', 0),
(29, 'sylvie.dutertre@ad-clo.fr', '[\"SMS\"]', '[\"ROLE_CLIENT\"]', '$2y$13$osj00tqAfOBEUjVsvWeR4OsURuVCDGhBBemg7ANDE/vCMy/BonAqG', 'Sylive', 'Dutertre', 'Femme', '+33 1 23 24 25 26', '+33 6 23 24 25 26', '17 rue des Papillons', '74011', 'Thiais', 'SESA', '2025-04-29 14:34:23', NULL, 0),
(31, 'georges.dreiding@sfr.fr', '[\"SMS\",\"WhatsApp\"]', '[\"ROLE_UTILISATEUR\",\"ROLE_CLIENT_POTENTIEL\"]', '$2y$13$awUQe8KWbTxr9sUaf0Vr2uNrkkvlUJp6gCeXnrvEnIKyAPIILUl66', 'Georges', 'Dreiding', 'Homme', '0668652672', '0668652672', '149 rue des Rabats', '92160', 'Antony', 'Auto-entrepreneur', '2025-05-04 20:30:15', NULL, 0),
(32, 'yoon.cho@sfr.fr', '[\"Courriel\"]', '[\"ROLE_EMPLOYE\"]', '$2y$13$4EE1SWarOarLBDY3xSv.5uMuSZDyiSbTTWbvv9nONDINL2kDQuQ46', 'Yoon', 'Cho', 'Femme', '0668652672', '0668652672', '149 rue des Rabats', '92160', 'Antony', 'Auto-entrepreneur', '2025-05-07 11:51:50', '2025-05-07 11:52:26', 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_67F068BC5D4AAA1` (`id_publication_id`),
  ADD KEY `IDX_67F068BC2C5AD247` (`id_commentaire_parent_id`);

--
-- Index pour la table `contrat`
--
ALTER TABLE `contrat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_60349993C6EE5C49` (`id_utilisateur_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `etat_contrat`
--
ALTER TABLE `etat_contrat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_67EBA616C6EE5C49` (`id_utilisateur_id`),
  ADD KEY `IDX_67EBA616BDA986C8` (`id_contrat_id`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Index pour la table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_14B784185D4AAA1` (`id_publication_id`),
  ADD KEY `IDX_14B7841887FA6C96` (`id_commentaire_id`);

--
-- Index pour la table `publication`
--
ALTER TABLE `publication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_AF3C6779C6EE5C49` (`id_utilisateur_id`),
  ADD KEY `IDX_AF3C6779BDA986C8` (`id_contrat_id`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_COURRIEL` (`courriel`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commentaire`
--
ALTER TABLE `commentaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contrat`
--
ALTER TABLE `contrat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `etat_contrat`
--
ALTER TABLE `etat_contrat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `photo`
--
ALTER TABLE `photo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `publication`
--
ALTER TABLE `publication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `FK_67F068BC2C5AD247` FOREIGN KEY (`id_commentaire_parent_id`) REFERENCES `commentaire` (`id`),
  ADD CONSTRAINT `FK_67F068BC5D4AAA1` FOREIGN KEY (`id_publication_id`) REFERENCES `publication` (`id`);

--
-- Contraintes pour la table `contrat`
--
ALTER TABLE `contrat`
  ADD CONSTRAINT `FK_60349993C6EE5C49` FOREIGN KEY (`id_utilisateur_id`) REFERENCES `utilisateur` (`id`);

--
-- Contraintes pour la table `etat_contrat`
--
ALTER TABLE `etat_contrat`
  ADD CONSTRAINT `FK_67EBA616BDA986C8` FOREIGN KEY (`id_contrat_id`) REFERENCES `contrat` (`id`),
  ADD CONSTRAINT `FK_67EBA616C6EE5C49` FOREIGN KEY (`id_utilisateur_id`) REFERENCES `utilisateur` (`id`);

--
-- Contraintes pour la table `photo`
--
ALTER TABLE `photo`
  ADD CONSTRAINT `FK_14B784185D4AAA1` FOREIGN KEY (`id_publication_id`) REFERENCES `publication` (`id`),
  ADD CONSTRAINT `FK_14B7841887FA6C96` FOREIGN KEY (`id_commentaire_id`) REFERENCES `commentaire` (`id`);

--
-- Contraintes pour la table `publication`
--
ALTER TABLE `publication`
  ADD CONSTRAINT `FK_AF3C6779BDA986C8` FOREIGN KEY (`id_contrat_id`) REFERENCES `contrat` (`id`),
  ADD CONSTRAINT `FK_AF3C6779C6EE5C49` FOREIGN KEY (`id_utilisateur_id`) REFERENCES `utilisateur` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

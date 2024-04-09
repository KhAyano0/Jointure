-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 19 mars 2024 à 17:31
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
-- Base de données : `series`
--

-- --------------------------------------------------------

--
-- Structure de la table `critiques`
--

DROP TABLE IF EXISTS `critiques`;
CREATE TABLE IF NOT EXISTS `critiques` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_serie` int NOT NULL,
  `note_public` int NOT NULL,
  `note_tomaters` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk2` (`id_serie`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `critiques`
--

INSERT INTO `critiques` (`id`, `id_serie`, `note_public`, `note_tomaters`) VALUES
(1, 1, 97, 96),
(2, 2, 89, 81),
(3, 3, 78, 79),
(4, 4, 67, 63),
(5, 5, 0, 89),
(6, 6, 92, 94),
(7, 7, 80, 93);

-- --------------------------------------------------------

--
-- Structure de la table `genres`
--

DROP TABLE IF EXISTS `genres`;
CREATE TABLE IF NOT EXISTS `genres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `genre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `genres`
--

INSERT INTO `genres` (`id`, `genre`) VALUES
(1, 'Action'),
(2, 'Comedie'),
(3, 'Drama'),
(4, 'Science Fiction'),
(5, 'Romance'),
(6, 'Aventure');

-- --------------------------------------------------------

--
-- Structure de la table `serie`
--

DROP TABLE IF EXISTS `serie`;
CREATE TABLE IF NOT EXISTS `serie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_genre` int NOT NULL,
  `titre` varchar(50) NOT NULL,
  `sinopsis` varchar(50) NOT NULL,
  `annee_sorti` int NOT NULL,
  `saison` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk2` (`id_genre`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `serie`
--

INSERT INTO `serie` (`id`, `id_genre`, `titre`, `sinopsis`, `annee_sorti`, `saison`) VALUES
(1, 3, 'Breaking Bad', 'Walter White, prof de chimie avec un cancer, comme', 2008, 5),
(2, 2, 'The Office', 'La série met en scène le quotidien des employés de', 2005, 9),
(3, 4, 'The Walking Dead', 'Après une apocalypse zombie, Rick Grimes, un adjoi', 2010, 11),
(4, 3, 'Control Z', 'Lorsqu un hacker se met soudainement à distiller l', 2020, 3),
(5, 1, 'How to Sell Drugs Online (Fast)', '\"How to Sell Drugs Online (Fast)\" suit Moritz et L', 2019, 3),
(6, 1, 'Cobra Kai', 'Johnny Lawrence, ex-star du karaté, reprend sa vie', 2018, 6),
(7, 5, 'On My Block', 'Quatre amis de banlieue voient leur vie chamboulée', 2018, 4);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `critiques`
--
ALTER TABLE `critiques`
  ADD CONSTRAINT `fk_critique_idserie` FOREIGN KEY (`id_serie`) REFERENCES `serie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `serie`
--
ALTER TABLE `serie`
  ADD CONSTRAINT `fk_serie_idgenre` FOREIGN KEY (`id_genre`) REFERENCES `genres` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

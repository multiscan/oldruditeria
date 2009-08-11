-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	4.1.14-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema ruditeria_development
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ ruditeria_development;
USE ruditeria_development;

--
-- Table structure for table `ruditeria_development`.`costs`
--

DROP TABLE IF EXISTS `costs`;
CREATE TABLE `costs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `product_id` int(10) unsigned NOT NULL default '0',
  `valid_from` datetime default NULL,
  `amount` float default NULL,
  PRIMARY KEY  (`id`,`product_id`),
  KEY `costs_FKIndex1` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruditeria_development`.`costs`
--

/*!40000 ALTER TABLE `costs` DISABLE KEYS */;
INSERT INTO `costs` (`id`,`product_id`,`valid_from`,`amount`) VALUES 
 (1,1,'2005-07-28 18:38:56',1.2),
 (2,2,'2005-09-15 15:35:08',1.6),
 (3,3,'2005-10-25 13:58:38',1),
 (4,4,'2005-10-25 13:58:54',1),
 (5,5,'2005-10-25 13:59:09',0.8);
/*!40000 ALTER TABLE `costs` ENABLE KEYS */;


--
-- Table structure for table `ruditeria_development`.`payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `amount` float default NULL,
  `date` datetime default NULL,
  PRIMARY KEY  (`id`,`user_id`),
  KEY `payments_FKIndex1` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruditeria_development`.`payments`
--

/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` (`id`,`user_id`,`amount`,`date`) VALUES 
 (3,43,50,'2006-03-16 00:00:00');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;


--
-- Table structure for table `ruditeria_development`.`products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL default '',
  `picture` varchar(255) default NULL,
  `visible` tinyint(3) unsigned NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruditeria_development`.`products`
--

/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`,`name`,`picture`,`visible`) VALUES 
 (1,'Henniez','henniez.gif',1),
 (2,'Coke','coke.gif',1),
 (3,'Granador','granador.gif',1),
 (4,'IceT','iceT.gif',1),
 (5,'Coffee','cafe.gif',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;


--
-- Table structure for table `ruditeria_development`.`purchases`
--

DROP TABLE IF EXISTS `purchases`;
CREATE TABLE `purchases` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `product_id` int(10) unsigned NOT NULL default '0',
  `date` datetime default NULL,
  PRIMARY KEY  (`id`,`user_id`,`product_id`),
  KEY `purchases_FKIndex1` (`user_id`),
  KEY `purchases_FKIndex2` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruditeria_development`.`purchases`
--

/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` (`id`,`user_id`,`product_id`,`date`) VALUES 
 (36,43,2,'2006-03-16 10:28:44');
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;


--
-- Table structure for table `ruditeria_development`.`secure_users`
--

DROP TABLE IF EXISTS `secure_users`;
CREATE TABLE `secure_users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(80) default NULL,
  `password` varchar(40) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruditeria_development`.`secure_users`
--

/*!40000 ALTER TABLE `secure_users` DISABLE KEYS */;
INSERT INTO `secure_users` (`id`,`login`,`password`) VALUES 
 (1,'admin','fb926264d965e1e8e92fedbf2acd13417a90f7ed');
/*!40000 ALTER TABLE `secure_users` ENABLE KEYS */;


--
-- Table structure for table `ruditeria_development`.`users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL default '',
  `email` varchar(45) NOT NULL default '',
  `camipro` int(10) unsigned default NULL,
  `picture` varchar(255) default NULL,
  `expiry` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruditeria_development`.`users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`name`,`email`,`camipro`,`picture`,`expiry`) VALUES 
 (1,'Amraoui','abdelaziz.amraoui@epfl.ch',NULL,'http://lthcwww.epfl.ch/pictures/abdelaziz.jpg',NULL),
 (2,'Baltcheva','irina.baltcheva@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/243be0d046c4dcc6f957b012ade76f74.jpg',NULL),
 (3,'Bardet','muriel.bardet@epfl.ch',NULL,'http://lthcwww.epfl.ch/pictures/muriel2.gif',NULL),
 (4,'Behn','francoise.behn@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (5,'Berlin','peter.berlin@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (6,'Bhaskaran','sibi.bhaskaranpillai@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (7,'Bovay','???',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (8,'Bremaud','pierre.bremaud@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/53889aa1d3abea2ebdff188917605be9.jpg',NULL),
 (9,'Cangiani','giovanni.cangiani@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/3d3f6332eaf39e8387be5fcd23a763b0.jpg',NULL),
 (10,'Cheraghchi','mahdi.cheraghchi@epfl.ch',NULL,'http://mahdi.cheraghchi.info/images/mch.jpg',NULL);
INSERT INTO `users` (`id`,`name`,`email`,`camipro`,`picture`,`expiry`) VALUES 
 (11,'Cronie','harm.cronie@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (12,'Degott','corinne.degott@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/11a1b877e1a3a62087a075c2fc39dc2c.jpg',NULL),
 (13,'Demicheli','giovanni.demicheli@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/7bd9aad79ecb2e9fda3217e2c8ae05b4.jpg',NULL),
 (14,'Diggavie','suhas.diggavi@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/c64734d27e0566123d42edaf0faad254.jpg',NULL),
 (15,'Donini','chiara.donini@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/a7b36227735e9c17a05d5a90803c05e8.jpg',NULL),
 (16,'Durvy','mathilde.durvy@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/0ea2156d4d678084af55398d3f2bf67e.jpg',NULL),
 (17,'Dusad','sanket.dusad@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/44892acb87bac658c24b1abd18d642ff.jpg',NULL),
 (18,'Fontana','natascha.fontana@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (19,'Gajic','vojislav.gajic@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/43a34043a4ff0d83060d0c1c4bbf7f6f.jpg',NULL);
INSERT INTO `users` (`id`,`name`,`email`,`camipro`,`picture`,`expiry`) VALUES 
 (20,'Goseling','jasper.goseling@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/07fa671a6301dd6d3575cadf27a11f09.jpg',NULL),
 (21,'Huskie','yvonne.huskie@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (22,'Jovanovic','ivana.jovanovic@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/9e5f0e1f1ff1017fec52ea85f3048f1e.jpg',NULL),
 (23,'Karbasi','amin.karbasi@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/e6951c7d9ebb273d5b78f53545eb5cf8.jpg',NULL),
 (24,'Kleiner','marius.kleiner@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/285c90573188e3be1554e7b5908cce58.jpg',NULL),
 (25,'Korada','satish.korada@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/93309339f73204d15aa25fd7d8112bfb.jpg',NULL),
 (26,'Kudekar','shrinivas.kudekar@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (27,'Leblebici','anil.leblebici@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/f03008f93afa99eeea3c7544e8a9d8f3.jpg',NULL),
 (28,'Meason','cyril.measson@epfl.ch',NULL,'http://lthcwww.epfl.ch/~cyril/cubecyr9.jpg',NULL);
INSERT INTO `users` (`id`,`name`,`email`,`camipro`,`picture`,`expiry`) VALUES 
 (29,'Macris','nicolas.macris@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (30,'Mettraux','john.mettraux@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (31,'Mohajer','soheil.mohajer@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (32,'Musy','stephane.musy@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (33,'Neuberg','christine.neuberg@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (34,'Ozgur','ayfer.ozgur@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (35,'Perron','etienne.perron@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/camipro/49757c5c1794ebdc0d55bf09839fda7d.jpg',NULL),
 (36,'Rathi','vishwambhar.rathi@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (37,'Ridolfi','andrea.ridolfi@epfl.ch',NULL,'http://lcavwww.epfl.ch/~ridolfi/tete_andrea_cabane1202.jpg',NULL),
 (38,'Rimoldi','bixio.rimoldi@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/df3189083a70b90655729ae5f1170594.jpg',NULL),
 (39,'Rochat','denis.rochat@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL);
INSERT INTO `users` (`id`,`name`,`email`,`camipro`,`picture`,`expiry`) VALUES 
 (40,'Roud','philippe.roud@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (41,'Sbaiz','luciano.sbaiz@epfl.ch',NULL,'http://lcavwww.epfl.ch/~sbaiz/teaching_det.jpg',NULL),
 (42,'Tabet','tarik.tabet@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (43,'Telatar','emre.telatar@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/e3b1d969dabac0178de882d11ad4ffbf.jpg',NULL),
 (44,'Tian','chao.tian@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL),
 (45,'Urbanke','rudiger.urbanke@epfl.ch',NULL,'http://people.epfl.ch/cache/photos/ext/ff3f928a4412565850cdf908c22469ea.jpg',NULL),
 (46,'Vasudevan','dinkar.vasudevan@epfl.ch',NULL,'http://people.epfl.ch/images/noprofile.jpg',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

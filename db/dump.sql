-- MySQL dump 10.13  Distrib 5.7.17, for osx10.12 (x86_64)
--
-- Host: localhost    Database: prototypedb
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pt_recruitertb01`
--

DROP TABLE IF EXISTS `pt_recruitertb01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pt_recruitertb01` (
  `uuid` varchar(100) CHARACTER SET latin1 NOT NULL,
  `username` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `latlng` geometry DEFAULT NULL,
  `registertime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `encounterd` json DEFAULT NULL,
  `liked` json DEFAULT NULL,
  `matched` json DEFAULT NULL,
  `industry` json DEFAULT NULL,
  `treat` json DEFAULT NULL,
  `companyname` varchar(100) DEFAULT NULL,
  `occupation` json DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pt_recruitertb01`
--

LOCK TABLES `pt_recruitertb01` WRITE;
/*!40000 ALTER TABLE `pt_recruitertb01` DISABLE KEYS */;
INSERT INTO `pt_recruitertb01` VALUES ('04c6df8103','47d3c21da7','daa3a1dcc97dc3cbf707','\0\0\0\0\0\0\0–\×W\åua@?D‘«QA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('0d29dff529','476d0f65b9','9b2fab35dd65a93daadc','\0\0\0\0\0\0\0Ô™mútfa@%\Ú\æP‰¶C@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('1e9bb6420b','bf3d064276','c94bf3105e39a35707c2','\0\0\0\0\0\0\0¯ü­+`@6÷\Èq\Í=B@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('1fc7c141e8','f4f34e7e11','61d03a5fd85fc8247e64','\0\0\0\0\0\0\03\Ê\ÅÀŒò`@õºEA½nC@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('2f5252e94c','4965db8491','d1a99d405a2606e5a4a6','\0\0\0\0\0\0\0\âš‹¸&a@ªôI *B@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('3ae77d1d26','8ddc68e22e','8a977c243e3212163f8d','\0\0\0\0\0\0\0÷>žÇ½a@­–Ek@@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('429f98de9c','b3f3258159','35f4652fa11f32e030c5','\0\0\0\0\0\0\0¦2½’©a@\r\"*;ƒˆA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('46a2eb400e','6fe83f42d8','efc1495a2b954245b894','\0\0\0\0\0\0\09€l;`a@{—+²\Þ\åB@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('52bf7b9e91','cb01f9ddf4','f0046656256929543626','\0\0\0\0\0\0\0÷E-Å½`@PF»”\ÑA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('552a0b7374','25c407ce81','1dda6974a94a37bc14d4','\0\0\0\0\0\0\0\Ë\êO\Æ2a@4Z5úŒV?@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('580a535c38','8cfe003348','c76a0e88ec25a3206056','\0\0\0\0\0\0\0S5\ÃEa@\á\ÝMx`@@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('5c8583887d','bf79d27cde','f7e91882295812e640e1','\0\0\0\0\0\0\0,\ã\Ëø`@1±\nPL¬A@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('5fe9e5ed00','e11c011ad9','2af41e6f153f961d2a1c','\0\0\0\0\0\0\0+\Ñ\ì©J4a@ðz6¼žB@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('60ef18e089','d37b434fed','240c64abd68df1b58036','\0\0\0\0\0\0\0–þŠc¥`@„\æ]¡yA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('6b7bf1cb2c','68cc2e482a','308fc79e36622b97ec95','\0\0\0\0\0\0\0bR§a@#¿Àˆ\ÃA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('6bc0d811ea','ce75b5221f','aae6635168a698e311af','\0\0\0\0\0\0\0\ÇQ#ºq\Ô`@™=\é%fO>@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('785d7d65ca','e99ffb3b21','9953246d68d3e81ad5ef','\0\0\0\0\0\0\0\â^·¸a@T\ìšñ»>@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('799fe83115','7202ccf96b','5e2d563a5214c3051486','\0\0\0\0\0\0\03\Ã|¶\Ìpa@‰±žQb¬C@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('84abce15fb','0f19e72f00','c53afb6a04d2f6b9b223','\0\0\0\0\0\0\0ø³‹þla@¬÷»\ëý>@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('8ac898ee1f','82a913cd09','e6e0f6455de3a7a4938e','\0\0\0\0\0\0\0·nÃ­`@•\ê%:¥zA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('8b20773426','b6fe7337b1','3a6e3fc1ae0b21993fa6','\0\0\0\0\0\0\0\Ñ2ŒCô`@X¦\ã–A@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('9099201ef4','93375878fe','65ee0d82f05f879c7c64','\0\0\0\0\0\0\0ƒ\Åx\Â`ñ`@ÿ•¾?C?@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('9c244d4e9e','7bcc2328c2','966a6a86887eb2aa4d1f','\0\0\0\0\0\0\0Œ\æ¢\Ã`@,V]ùŠUB@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('a3e2ed7731','c05f2954bf','31bdbb2404a7590940b5','\0\0\0\0\0\0\0€ ``@ÿ‘\ÃA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('a6c0fc9f0b','4b4a8546e6','48c6e93c815ce99b6125','\0\0\0\0\0\0\0zFwŸžQa@%‡CIB@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('bd13164d6b','6a0caa2290','dd3f50c211d52cba41ee','\0\0\0\0\0\0\0\ËúÄ²¾`@\ê÷’qú½A@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('c3a7994826','4849b8d64f','c99be2f10f056d9a0467','\0\0\0\0\0\0\0{¼A`@/´\\ª-?@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('c3b623dc47','6cd900754a','96d33835692827971986','\0\0\0\0\0\0\0edù1Ya@R$ö¦‰C@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('c3b989ebbf','81f18f61cd','87471cb1cbcc89547d53','\0\0\0\0\0\0\0,¦\"‹©`@¦Š¥ ©bA@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('c78eb218b1','hogecompany','1a489b9ae2b8f9520b19','\0\0\0\0\0\0\0@\Õ=\Ð`@•A\Ë(e\ÐB@','2017-05-25 07:48:16','[\"bnb\"]','[\"hoge\"]',NULL,'[\"IT\"]','[\"cafe\", \"morning\"]',NULL,'[\"PR\", \"MR\"]'),('f54d8a0dce','de04bafc53','d21cfdc1c3a4467a092b','\0\0\0\0\0\0\0<©÷Î£`@þC·€ÿ>@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL),('f5e89b4910','e905a37227','1e2ddba908fa15141771','\0\0\0\0\0\0\0`¥ZXia@\äe\0yC@','2017-05-25 03:50:41','[\"bnb\"]','[\"hoge\"]',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `pt_recruitertb01` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pt_jobhuntertb01`
--

DROP TABLE IF EXISTS `pt_jobhuntertb01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pt_jobhuntertb01` (
  `uuid` varchar(100) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `latlng` geometry DEFAULT NULL,
  `resitertime` datetime DEFAULT NULL,
  `encounterd` json DEFAULT NULL,
  `liked` json DEFAULT NULL,
  `matched` json DEFAULT NULL,
  `currentlogintime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pt_jobhuntertb01`
--

LOCK TABLES `pt_jobhuntertb01` WRITE;
/*!40000 ALTER TABLE `pt_jobhuntertb01` DISABLE KEYS */;
INSERT INTO `pt_jobhuntertb01` VALUES ('hoge','takashi','aaa','\0\0\0\0\0\0\0;q9^\í`@\Ý\na5–\äB@','2017-04-24 19:07:19','[\"frbfosd\", \"9c244d4e9e\", \"5fe9e5ed00\", \"2f5252e94c\", \"6b7bf1cb2c\", \"52bf7b9e91\", \"5c8583887d\", \"bd13164d6b\", \"8b20773426\", \"a6c0fc9f0b\", \"429f98de9c\", \"46a2eb400e\", \"c3b623dc47\", \"1e9bb6420b\", \"f5e89b4910\", \"8ac898ee1f\", \"0d29dff529\"]','[\"\", \"f5e89b4910\", \"8ac898ee1f\", \"0d29dff529\"]',NULL,'2017-05-24 04:54:45'),('ten3Nq8ZNRMkA9oYJgYuWEg7B2E2','zakiyama','atjolove@yahoo.co.jp','\0\0\0\0\0\0\0\0\0\0\0\0@`@\0\0\0\0\0\0>@','2017-04-20 11:21:02','[]',NULL,NULL,'2017-05-06 06:44:03');
/*!40000 ALTER TABLE `pt_jobhuntertb01` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-26 16:59:03

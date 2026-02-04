-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: sales_analysis
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `stores_clean`
--

DROP TABLE IF EXISTS `stores_clean`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores_clean` (
  `StoreKey` int DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `SquareMeters` int DEFAULT NULL,
  `OpenDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores_clean`
--

LOCK TABLES `stores_clean` WRITE;
/*!40000 ALTER TABLE `stores_clean` DISABLE KEYS */;
INSERT INTO `stores_clean` VALUES (1,'Australia','Australian Capital Territory',595,'2008-01-01'),(2,'Australia','Northern Territory',665,'2008-01-12'),(3,'Australia','South Australia',2000,'2012-01-07'),(4,'Australia','Tasmania',2000,'2010-01-01'),(5,'Australia','Victoria',2000,'2015-12-09'),(6,'Australia','Western Australia',2000,'2010-01-01'),(7,'Canada','New Brunswick',1105,'2007-05-07'),(8,'Canada','Newfoundland and Labrador',2105,'2014-07-02'),(9,'Canada','Northwest Territories',1500,'2005-03-04'),(10,'Canada','Nunavut',1210,'2015-04-04'),(11,'Canada','Yukon',1210,'2009-06-03'),(12,'France','Basse-Normandie',350,'2012-06-06'),(13,'France','Corse',245,'2013-06-07'),(14,'France','Franche-ComtÃ©',350,'2009-12-15'),(15,'France','La RÃ©union',400,'2015-01-01'),(16,'France','Limousin',385,'2010-06-03'),(17,'France','Martinique',350,'2007-07-08'),(18,'France','Mayotte',310,'2012-08-08'),(19,'Germany','Berlin',1295,'2015-04-04'),(20,'Germany','Brandenburg',1715,'2012-12-15'),(21,'Germany','Freie Hansestadt Bremen',560,'2018-06-03'),(22,'Germany','Freistaat ThÃ¼ringen',2000,'2008-03-06'),(23,'Germany','Hamburg',1365,'2010-01-01'),(24,'Germany','Hessen',1855,'2012-12-15'),(25,'Germany','Mecklenburg-Vorpommern',1610,'2010-01-01'),(26,'Germany','Saarland',350,'2019-03-05'),(27,'Germany','Sachsen-Anhalt',2000,'2008-08-08'),(28,'Italy','Caltanissetta',1200,'2012-12-15'),(29,'Italy','Enna',1000,'2008-01-01'),(30,'Italy','Pesaro',2100,'2008-01-12'),(31,'Netherlands','Drenthe',1085,'2012-01-07'),(32,'Netherlands','Flevoland',910,'2010-01-01'),(33,'Netherlands','Friesland',1540,'2015-12-09'),(34,'Netherlands','Groningen',1365,'2010-01-01'),(35,'Netherlands','Zeeland',1225,'2007-05-07'),(36,'United Kingdom','Armagh',1300,'2014-07-02'),(37,'United Kingdom','Ayrshire',2100,'2005-03-04'),(38,'United Kingdom','Belfast',1800,'2015-04-04'),(39,'United Kingdom','Blaenau Gwent',2100,'2009-06-03'),(40,'United Kingdom','Dungannon and South Tyrone',1300,'2012-06-06'),(41,'United Kingdom','Fermanagh',2100,'2013-06-07'),(42,'United Kingdom','North Down',1900,'2009-12-15'),(43,'United States','Alaska',1190,'2015-01-01'),(44,'United States','Arkansas',2000,'2010-06-03'),(45,'United States','Connecticut',2000,'2007-07-08'),(46,'United States','Delaware',1015,'2012-08-08'),(47,'United States','Hawaii',1120,'2015-04-04'),(48,'United States','Idaho',1540,'2012-12-15'),(49,'United States','Iowa',2000,'2018-06-03'),(50,'United States','Kansas',2000,'2008-03-06'),(51,'United States','Maine',1295,'2010-01-01'),(52,'United States','Mississippi',2000,'2009-06-03'),(53,'United States','Montana',1260,'2012-06-06'),(54,'United States','Nebraska',2000,'2013-06-07'),(55,'United States','Nevada',2000,'2009-12-15'),(56,'United States','New Hampshire',1260,'2015-01-01'),(57,'United States','New Mexico',1645,'2010-06-03'),(58,'United States','North Dakota',1330,'2007-07-08'),(59,'United States','Oregon',2000,'2012-08-08'),(60,'United States','Rhode Island',1260,'2005-04-04'),(61,'United States','South Carolina',2000,'2012-12-15'),(62,'United States','South Dakota',1120,'2018-06-03'),(63,'United States','Utah',2000,'2008-03-06'),(64,'United States','Washington DC',1330,'2010-01-01'),(65,'United States','West Virginia',1785,'2012-01-01'),(66,'United States','Wyoming',840,'2014-01-01'),(0,'Online','Online',NULL,'2010-01-01');
/*!40000 ALTER TABLE `stores_clean` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-27  7:53:56

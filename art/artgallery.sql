-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: localhost    Database: artgallery
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `bidding`
--

DROP TABLE IF EXISTS `bidding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bidding` (
  `bid_id` int NOT NULL AUTO_INCREMENT,
  `b_id` int NOT NULL,
  `bid_status` varchar(45) NOT NULL,
  `bid_price` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `c_id` int NOT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `b_id_idx` (`b_id`),
  KEY `c_id_idx` (`c_id`),
  CONSTRAINT `c_id` FOREIGN KEY (`c_id`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidding`
--

LOCK TABLES `bidding` WRITE;
/*!40000 ALTER TABLE `bidding` DISABLE KEYS */;
INSERT INTO `bidding` VALUES (65,1,'running','6666','2022-03-30 15:25:39',15),(66,1,'running','6666','2022-03-30 15:25:39',15),(80,1,'running','6666','2022-03-30 15:25:39',15),(82,8,'running','6666','2022-03-30 15:25:39',13),(83,8,'running','6666','2022-03-30 15:40:16',14),(84,8,'running','6666','2022-03-30 15:40:16',14);
/*!40000 ALTER TABLE `bidding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `crt_id` int NOT NULL AUTO_INCREMENT,
  `pid` varchar(45) NOT NULL,
  `qnty` int NOT NULL,
  `total` float NOT NULL,
  `usr_id` int NOT NULL,
  PRIMARY KEY (`crt_id`),
  KEY `usr_id_idx` (`usr_id`),
  CONSTRAINT `usr_id` FOREIGN KEY (`usr_id`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaint`
--

DROP TABLE IF EXISTS `complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaint` (
  `cmp_id` int NOT NULL AUTO_INCREMENT,
  `lid` int NOT NULL,
  `complaint` varchar(300) NOT NULL,
  `reply` varchar(300) DEFAULT NULL,
  `complaint_date` date DEFAULT NULL,
  `reply_date` datetime DEFAULT NULL,
  PRIMARY KEY (`cmp_id`),
  KEY `lid_idx` (`lid`),
  CONSTRAINT `llid` FOREIGN KEY (`lid`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint`
--

LOCK TABLES `complaint` WRITE;
/*!40000 ALTER TABLE `complaint` DISABLE KEYS */;
INSERT INTO `complaint` VALUES (2,15,'ytfghhhjb','sorry','2022-03-30','2022-03-30 19:27:27'),(3,15,'yfgghggg','dfdgfdg','2022-03-30','2022-03-30 19:28:03');
/*!40000 ALTER TABLE `complaint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `fid` int NOT NULL AUTO_INCREMENT,
  `lid` int NOT NULL,
  `subject` varchar(105) NOT NULL,
  `feedback` varchar(455) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`fid`),
  KEY `logid_idx` (`lid`),
  CONSTRAINT `logid` FOREIGN KEY (`lid`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (3,15,'dffggfd','dsfdsf','2022-03-30 16:03:32');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `lid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(70) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'admin@gmail.com','admin','admin'),(13,'avmaneesha@gmail.com','Maneesha@176','artist'),(14,'avmaneesha@gmail.com','@176','customer'),(15,'anjusha@gmail.com','anju','customer'),(28,'avmaneesha@gmail.com','qwerty@qwerty123Q','artist'),(29,'avmaneesha@gmail.com','qwerty@qwerty123Q','artist');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(45) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,'test','yfdusugHDKS','2022-03-14 11:27:07'),(4,'newtst','fdsfdsdsf','2022-03-30 15:48:54'),(5,'newtst','fdsfdsdsf','2022-03-30 15:49:27'),(6,'ghdghdf','fdsfddsf','2022-03-30 15:49:58'),(7,'ghdghdf','fdsfddsf','2022-03-30 15:50:39');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitem` (
  `o_itm` int NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL,
  `oid` int NOT NULL,
  `qnty` varchar(45) NOT NULL,
  `total` float NOT NULL,
  PRIMARY KEY (`o_itm`),
  KEY `pid_idx` (`pid`),
  KEY `oid_idx` (`oid`),
  CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `pro_registration` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` VALUES (13,9,12,'2',246);
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `oid` int NOT NULL AUTO_INCREMENT,
  `l_id` int NOT NULL,
  `total` float NOT NULL,
  `pay_status` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `order_status` varchar(45) NOT NULL,
  PRIMARY KEY (`oid`),
  KEY `l_id_idx` (`l_id`),
  CONSTRAINT `l_id` FOREIGN KEY (`l_id`) REFERENCES `login` (`lid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (7,15,1000,'pending','2022-03-09 14:49:35','Waiting for updates'),(8,15,0,'paid','2022-03-09 14:57:04','Waiting for updates'),(9,15,1000,'paid','2022-03-09 14:58:00','posted'),(10,15,6690,'pending','2022-03-15 11:28:55','Waiting for updates'),(11,15,1234,'pending','2022-03-29 22:00:19','Waiting for updates'),(12,15,246,'paid','2022-03-30 12:12:29','posted'),(13,15,1111,'paid','2022-03-30 12:20:32','posted'),(14,15,234,'pending','2022-03-30 17:03:21','Waiting for updates');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `pay_id` int NOT NULL AUTO_INCREMENT,
  `oid` int NOT NULL,
  `amount` float NOT NULL,
  `uid` int NOT NULL,
  `card_holder_name` varchar(60) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `exp` varchar(10) NOT NULL,
  `payment_date` datetime NOT NULL,
  PRIMARY KEY (`pay_id`),
  KEY `uid_idx` (`uid`),
  KEY `odrid_idx` (`oid`),
  CONSTRAINT `odrid` FOREIGN KEY (`oid`) REFERENCES `orders` (`oid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `login` (`lid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (9,8,0,15,'MANEESHA','1237737742313456','2022-07','2022-03-09 14:57:46'),(10,9,1000,15,'MANEESHA','1234567890123456','2022-12','2022-03-09 14:58:20'),(11,12,246,15,'mnaju','2132465776887345','12/34','2022-03-30 12:13:02'),(12,13,1111,15,'mnjjuu','2345678987564312','12/34','2022-03-30 12:20:53');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pro_registration`
--

DROP TABLE IF EXISTS `pro_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pro_registration` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `pname` varchar(90) NOT NULL,
  `image` text NOT NULL,
  `desc` varchar(300) NOT NULL,
  `price` float NOT NULL,
  `stock` varchar(45) NOT NULL,
  `logid` int NOT NULL,
  `type` varchar(45) NOT NULL,
  `o_price` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `user_id_idx` (`logid`),
  CONSTRAINT `lid` FOREIGN KEY (`logid`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pro_registration`
--

LOCK TABLES `pro_registration` WRITE;
/*!40000 ALTER TABLE `pro_registration` DISABLE KEYS */;
INSERT INTO `pro_registration` VALUES (5,'test','8.png','test',234,'1',13,'bidding',''),(6,'test','9.png','test',123,'1',13,'bidding',''),(7,'test','9.png','test',123,'1',13,'bidding',''),(8,'test','8.png','test',6787,'1',13,'bidding',''),(9,'test','3.png','test',123,'0',13,'normal',''),(12,'test1','8.png','test1',656,'1',13,'bidding',''),(13,'test1','6.png','test1',76767,'1',13,'bidding',''),(14,'newtest','12.png','newtest',23454,'1',13,'bidding','23454'),(15,'newtest','9.png','newtest',23454,'1',13,'bidding','23454'),(17,'new','12.png','new',234,'1',14,'normal',NULL),(19,'are','8.png','nre3w',345,'1',13,'bidding','345'),(20,'test','17.png','test',1111,'1',13,'bidding','1111');
/*!40000 ALTER TABLE `pro_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bidding`
--

DROP TABLE IF EXISTS `product_bidding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bidding` (
  `pb_id` int NOT NULL AUTO_INCREMENT,
  `p_id` int NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`pb_id`),
  KEY `pid_idx` (`p_id`),
  CONSTRAINT `p_id` FOREIGN KEY (`p_id`) REFERENCES `pro_registration` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bidding`
--

LOCK TABLES `product_bidding` WRITE;
/*!40000 ALTER TABLE `product_bidding` DISABLE KEYS */;
INSERT INTO `product_bidding` VALUES (1,8,'2022-03-09 17:38:04','2022-04-01 00:00:00'),(2,12,'2022-03-11 11:50:01','2022-03-31 00:00:00'),(3,13,'2022-03-11 11:52:11','2022-03-31 00:00:00'),(4,14,'2022-03-15 20:33:35','2022-03-17 10:35:00'),(5,15,'2022-03-15 21:31:59','2022-03-23 01:35:00'),(7,19,'2022-03-30 12:38:26','2022-03-31 12:38:00'),(8,20,'2022-03-30 15:16:05','2022-04-01 15:16:00');
/*!40000 ALTER TABLE `product_bidding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reg_payment`
--

DROP TABLE IF EXISTS `reg_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reg_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `u_id` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `card_holder` varchar(45) DEFAULT NULL,
  `csv` varchar(3) DEFAULT NULL,
  `exp` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `u_id_idx` (`u_id`),
  CONSTRAINT `u_id` FOREIGN KEY (`u_id`) REFERENCES `registration` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_payment`
--

LOCK TABLES `reg_payment` WRITE;
/*!40000 ALTER TABLE `reg_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `reg_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `district` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `pin` varchar(45) DEFAULT NULL,
  `asso_regno` varchar(45) DEFAULT NULL,
  `adhaarno` varchar(45) DEFAULT NULL,
  `adrs` varchar(300) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `lid` int NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`rid`),
  UNIQUE KEY `adhaarno_UNIQUE` (`adhaarno`),
  KEY `logid_idx` (`lid`),
  CONSTRAINT `user_id` FOREIGN KEY (`lid`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (10,'Anusha','avmaneesha@gmail.com','8848000094','Kannur','payyanur','679307','3546556','3344546466442','fhdfhghfd','2022-03-09 13:17:11',13,'artist'),(12,'anjusha','anjusha@gmail.com','8848000094','kannur','payyanur','670307',NULL,NULL,'ddffds','2022-03-09 13:34:45',15,'customer'),(25,'testpp','avmaneesha@gmail.com','8848000094','kasargod','kanhangad','671306','4564','4532123476879876','hhgdhvdshd','2022-04-05 12:04:32',28,'artist');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-05 13:46:29

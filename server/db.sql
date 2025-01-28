-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: art
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
  `c_id` int DEFAULT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `b_id_idx` (`b_id`),
  KEY `c_id_idx` (`c_id`),
  CONSTRAINT `c_id` FOREIGN KEY (`c_id`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidding`
--

LOCK TABLES `bidding` WRITE;
/*!40000 ALTER TABLE `bidding` DISABLE KEYS */;
INSERT INTO `bidding` VALUES (91,14,'running','4444','2022-04-28 12:12:18',66);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (29,'33',2,1332,66);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (4,30,'hgdgb','bgndn','2022-04-17 08:48:33');
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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'admin@gmail.com','admin','admin'),(30,'ummersimaqm@gmail.com','#Us12345','customer'),(64,'kichu953966@gmail.com','#KIshan8','artist'),(65,'smariyamath@gmail.com','#Sumayya7','artist'),(66,'smariyamath@gmail.com','#suMayya8','customer');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` VALUES (17,26,16,'1',560000),(18,28,17,'4',240000),(19,27,18,'1',54000),(20,34,19,'1',666);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (15,30,2000,'pending','2022-04-17 08:39:51','Waiting for updates'),(16,66,560000,'pending','2022-04-28 11:28:21','Waiting for updates'),(17,66,240000,'pending','2022-04-28 12:10:23','Waiting for updates'),(18,66,54000,'pending','2022-04-28 12:30:00','Waiting for updates'),(19,66,666,'paid','2022-04-28 12:45:28','Waiting for updates');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (13,18,54000,66,'mananan','8989898989898989','2022-10','2022-04-28 12:45:28');
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pro_registration`
--

LOCK TABLES `pro_registration` WRITE;
/*!40000 ALTER TABLE `pro_registration` DISABLE KEYS */;
INSERT INTO `pro_registration` VALUES (26,'abc','bv9.png','abcd',560000,'0',64,'normal',NULL),(27,'abc','bv9.png','a well defined art from kishan',54000,'0',64,'normal',NULL),(28,'women wall art','cart1.png','a well defined art ',60000,'-3',65,'normal',NULL),(29,'brush photo','cart3.jpg','a well defined art ',40000,'1',64,'bidding','40000'),(31,'women wall art','cart3.jpg','a well defined art ',70000,'1',64,'bidding','70000'),(32,'women wall art','cart3.jpg','a well defined art from kishan',4444,'1',64,'bidding','34555'),(33,'bbjb','3.png','ggg',666,'1',64,'normal',NULL),(34,'mnmn','9.png','hghghg',666,'0',64,'normal',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bidding`
--

LOCK TABLES `product_bidding` WRITE;
/*!40000 ALTER TABLE `product_bidding` DISABLE KEYS */;
INSERT INTO `product_bidding` VALUES (11,29,'2022-04-28 11:45:37','2022-05-03 11:45:00'),(13,31,'2022-04-28 12:03:28','2022-05-03 12:03:00'),(14,32,'2022-04-28 12:05:09','2022-05-07 12:05:00');
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
  `exp` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `u_id_idx` (`id`,`u_id`),
  KEY `u_id_idx1` (`u_id`),
  CONSTRAINT `u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`lid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_payment`
--

LOCK TABLES `reg_payment` WRITE;
/*!40000 ALTER TABLE `reg_payment` DISABLE KEYS */;
INSERT INTO `reg_payment` VALUES (5,64,'2022-04-28 10:18:37','paid','kishan','123','2022-03'),(6,65,'2022-04-28 10:21:17','paid','sumayya','235','2022-03');
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (27,'ummer','ummersimaqm@gmail.com','7559929636','kasaragod','manjeshwar','671323',NULL,NULL,'udyawar','2022-04-11 09:12:53',30,'customer'),(61,'kishan','kichu953966@gmail.com','9898712323','kasaragod','seethangoli','671321','','86777896675','Kishan','2022-04-28 10:18:37',64,'artist'),(62,'sumayya','smariyamath@gmail.com','9876543425','kasaragod','uppala','671322','','867778965987','mahinroad','2022-04-28 10:21:17',65,'artist'),(63,'sumayya','smariyamath@gmail.com','9876543425','kasaragod','uppala','671322',NULL,NULL,'mahinroad','2022-04-28 10:22:21',66,'customer');
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

-- Dump completed on 2022-04-28 12:50:20

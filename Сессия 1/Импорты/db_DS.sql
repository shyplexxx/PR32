CREATE DATABASE  IF NOT EXISTS `db22` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db22`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db22
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(450) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Мужская обувь'),(2,'Женская обувь');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliverypoint`
--

DROP TABLE IF EXISTS `deliverypoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliverypoint` (
  `DPID` int NOT NULL AUTO_INCREMENT,
  `DPName` varchar(405) NOT NULL,
  PRIMARY KEY (`DPID`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverypoint`
--

LOCK TABLES `deliverypoint` WRITE;
/*!40000 ALTER TABLE `deliverypoint` DISABLE KEYS */;
INSERT INTO `deliverypoint` VALUES (1,'344288, г. Москва, ул. Чехова, 1'),(2,'614164, г.Москва,  ул. Степная, 30'),(3,'394242, г. Москва, ул. Коммунистическая, 43'),(4,'660540, г. Москва, ул. Солнечная, 25'),(5,'125837, г. Москва, ул. Шоссейная, 40'),(6,'125703, г. Москва, ул. Партизанская, 49'),(7,'625283, г. Москва, ул. Победы, 46'),(8,'614611, г. Москва, ул. Молодежная, 50'),(9,'454311, г.Москва, ул. Новая, 19'),(10,'660007, г.Москва, ул. Октябрьская, 19'),(11,'603036, г. Москва, ул. Садовая, 4'),(12,'450983, г.Москва, ул. Комсомольская, 26'),(13,'394782, г. Москва, ул. Чехова, 3'),(14,'603002, г. Москва, ул. Дзержинского, 28'),(15,'450558, г. Москва, ул. Набережная, 30'),(16,'394060, г.Москва, ул. Фрунзе, 43'),(17,'410661, г. Москва, ул. Школьная, 50'),(18,'625590, г. Москва, ул. Коммунистическая, 20'),(19,'625683, г. Москва, ул. 8 Марта'),(20,'400562, г. Москва, ул. Зеленая, 32'),(21,'614510, г. Москва, ул. Маяковского, 47'),(22,'410542, г. Москва, ул. Светлая, 46'),(23,'620839, г. Москва, ул. Цветочная, 8'),(24,'443890, г. Москва, ул. Коммунистическая, 1'),(25,'603379, г. Москва, ул. Спортивная, 46'),(26,'603721, г. Москва, ул. Гоголя, 41'),(27,'410172, г. Москва, ул. Северная, 13'),(28,'420151, г. Москва, ул. Вишневая, 32'),(29,'125061, г. Москва, ул. Подгорная, 8'),(30,'630370, г. Москва, ул. Шоссейная, 24'),(31,'614753, г. Москва, ул. Полевая, 35'),(32,'426030, г. Москва, ул. Маяковского, 44'),(33,'450375, г. Москва ул. Клубная, 44'),(34,'625560, г. Москва, ул. Некрасова, 12'),(35,'630201, г. Москва, ул. Комсомольская, 17'),(36,'344288, г. Москва, ул. Чехова, 1');
/*!40000 ALTER TABLE `deliverypoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `OrderDateOrder` datetime NOT NULL,
  `OrderDateDel` varchar(45) NOT NULL,
  `OrderDelivery` int NOT NULL,
  `OrderClient` int NOT NULL,
  `OrderCode` int NOT NULL,
  `OrderStatus` int NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `OrderDelivery_idx` (`OrderDelivery`),
  KEY `OrderClient_idx` (`OrderClient`),
  KEY `OrderStatus_idx` (`OrderStatus`),
  CONSTRAINT `OrderClient` FOREIGN KEY (`OrderClient`) REFERENCES `user` (`UserID`),
  CONSTRAINT `OrderDelivery` FOREIGN KEY (`OrderDelivery`) REFERENCES `deliverypoint` (`DPID`),
  CONSTRAINT `OrderStatus` FOREIGN KEY (`OrderStatus`) REFERENCES `status` (`StatusID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2022-05-16 00:00:00','2022.05.22',10,1,911,1),(2,'2022-05-17 00:00:00','2022.05.23',5,2,912,2),(3,'2022-05-18 00:00:00','2022.05.24',11,3,913,2),(4,'2022-05-19 00:00:00','2022.05.25',10,6,914,2),(5,'2022-05-20 00:00:00','2022.05.26',1,7,915,1),(6,'2022-05-21 00:00:00','2022.05.27',32,8,916,1),(7,'2022-05-22 00:00:00','2022.05.28',20,11,917,1),(8,'2022-05-23 00:00:00','2022.05.29',34,12,918,2),(9,'2022-05-24 00:00:00','2022.05.30',25,13,919,1);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderproduct`
--

DROP TABLE IF EXISTS `orderproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderproduct` (
  `OrderProductID` int NOT NULL,
  `OrderProductAtricle` varchar(6) NOT NULL,
  `OrderProductCount` int NOT NULL,
  PRIMARY KEY (`OrderProductID`,`OrderProductAtricle`),
  KEY `OrderProductAtricle_idx` (`OrderProductAtricle`),
  CONSTRAINT `OrderProductAtricle` FOREIGN KEY (`OrderProductAtricle`) REFERENCES `product` (`ProductArticle`),
  CONSTRAINT `OrderProductID` FOREIGN KEY (`OrderProductID`) REFERENCES `order` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderproduct`
--

LOCK TABLES `orderproduct` WRITE;
/*!40000 ALTER TABLE `orderproduct` DISABLE KEYS */;
INSERT INTO `orderproduct` VALUES (1,'А112Т4',2),(2,'F635R4',1),(3,'J384T6',5),(4,'D329H3',6),(5,'G432E4',2),(6,'S634B5',3),(7,'G531F4',5),(8,'P764G4',3),(9,'D364R4',1);
/*!40000 ALTER TABLE `orderproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `ProductArticle` varchar(6) NOT NULL,
  `ProductName` varchar(450) NOT NULL,
  `ProductUnit` int NOT NULL,
  `ProductCost` int NOT NULL,
  `ProductMaxSale` int NOT NULL,
  `ProductManufacture` varchar(405) NOT NULL,
  `ProductSypplier` int NOT NULL,
  `ProductCategory` int NOT NULL,
  `ProductNowSale` int NOT NULL,
  `ProductCountWH` int NOT NULL,
  `ProductDesk` varchar(405) NOT NULL,
  `ProductImage` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ProductID`,`ProductArticle`),
  KEY `ProductUnit_idx` (`ProductUnit`),
  KEY `ProductSypplier_idx` (`ProductSypplier`),
  KEY `ProductCategory_idx` (`ProductCategory`),
  KEY `idx_product_article` (`ProductArticle`),
  CONSTRAINT `ProductCategory` FOREIGN KEY (`ProductCategory`) REFERENCES `category` (`CategoryID`),
  CONSTRAINT `ProductSypplier` FOREIGN KEY (`ProductSypplier`) REFERENCES `sypplier` (`SypplierID`),
  CONSTRAINT `ProductUnit` FOREIGN KEY (`ProductUnit`) REFERENCES `unit` (`UnitID`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'А112Т4','Ботинки',1,4990,30,'Kari',1,2,3,6,'Женские Ботинки демисезонные kari','А112Т4.jpg'),(2,'F635R4','Ботинки',1,3244,20,'Marco Tozzi',2,2,2,13,'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый','F635R4.jpg'),(3,'H782T5','Туфли',1,4499,30,'Kari',1,1,4,5,'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный','H782T5.jpg'),(4,'G783F5','Ботинки',1,5900,25,'Рос',1,1,2,8,'Мужские ботинки Рос-Обувь кожаные с натуральным мехом','G783F5.jpg'),(5,'J384T6','Ботинки',1,3800,10,'Rieker',2,1,2,16,'B3430/14 Полуботинки мужские Rieker','J384T6.jpg'),(6,'D572U8','Кроссовки',1,4100,5,'Рос',2,1,3,6,'129615-4 Кроссовки мужские','D572U8.jpg'),(7,'F572H7','Туфли',1,2700,15,'Marco Tozzi',1,2,2,14,'Туфли Marco Tozzi женские летние, размер 39, цвет черный','F572H7.jpg'),(8,'D329H3','Полуботинки',1,1890,10,'Alessio Nesca',2,2,4,4,'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый','D329H3.jpg'),(9,'B320R5','Туфли',1,4300,15,'Rieker',1,2,2,6,'Туфли Rieker женские демисезонные, размер 41, цвет коричневый','B320R5.jpg'),(10,'G432E4','Туфли',1,2800,10,'Kari',1,2,3,15,'Туфли kari женские TR-YR-413017, размер 37, цвет: черный','G432E4.jpg'),(11,'S213E3','Полуботинки',1,2156,5,'CROSBY',2,1,3,6,'407700/01-01 Полуботинки мужские CROSBY',''),(12,'E482R4','Полуботинки',1,1800,15,'Kari',1,2,2,14,'Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный',''),(13,'S634B5','Кеды',1,5500,20,'CROSBY',2,1,3,6,'Кеды Caprice мужские демисезонные, размер 42, цвет черный',''),(14,'K345R4','Полуботинки',1,2100,15,'CROSBY',2,1,2,3,'407700/01-02 Полуботинки мужские CROSBY',''),(15,'O754F4','Туфли',1,5400,10,'Rieker',2,2,4,18,'Туфли женские демисезонные Rieker артикул 55073-68/37',''),(16,'G531F4','Ботинки',1,6600,5,'Kari',1,2,2,9,'Ботинки женские зимние ROMER арт. 893167-01 Черный',''),(17,'J542F5','Тапочки',1,500,5,'Kari',1,1,3,12,'Тапочки мужские Арт.70701-55-67син р.41',''),(18,'B431R5','Ботинки',1,2700,10,'Rieker',2,1,2,5,'Мужские кожаные ботинки/мужские ботинки',''),(19,'P764G4','Туфли',1,6800,30,'CROSBY',1,2,3,15,'Туфли женские, ARGO, размер 38',''),(20,'C436G5','Ботинки',1,10200,15,'Alessio Nesca',1,2,2,9,'Ботинки женские, ARGO, размер 40',''),(21,'F427R5','Ботинки',1,11800,10,'Rieker',2,2,4,11,'Ботинки на молнии с декоративной пряжкой FRAU',''),(22,'N457T5','Полуботинки',1,4600,5,'CROSBY',1,2,3,13,'Полуботинки Ботинки черные зимние, мех',''),(23,'D364R4','Туфли',1,12400,10,'Kari',1,2,2,5,'Туфли Luiza Belly женские Kate-lazo черные из натуральной замши',''),(24,'S326R5','Тапочки',1,9900,15,'CROSBY',2,1,3,15,'Мужские кожаные тапочки \"Профиль С.Дали\"\" \"',''),(25,'L754R4','Полуботинки',1,1700,10,'Kari',1,2,2,7,'Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный',''),(26,'M542T5','Кроссовки',1,2800,5,'Rieker',2,1,5,3,'Кроссовки мужские TOFA',''),(27,'D268G5','Туфли',1,4399,10,'Rieker',2,2,3,12,'Туфли Rieker женские демисезонные, размер 36, цвет коричневый',''),(28,'T324F5','Сапоги',1,4699,15,'CROSBY',1,2,2,5,'Сапоги замша Цвет: синий',''),(29,'K358H6','Тапочки',1,599,5,'Rieker',1,1,3,2,'Тапочки мужские син р.41',''),(30,'H535R5','Ботинки',1,2300,25,'Rieker',2,2,2,7,'Женские Ботинки демисезонные',''),(31,'А112Т4','Ботинки',1,4990,30,'Kari',1,2,3,6,'Женские Ботинки демисезонные kari','А112Т4.jpg'),(32,'F635R4','Ботинки',1,3244,20,'Marco Tozzi',2,2,2,13,'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый','F635R4.jpg'),(33,'H782T5','Туфли',1,4499,30,'Kari',1,1,4,5,'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный','H782T5.jpg'),(34,'G783F5','Ботинки',1,5900,25,'Рос',1,1,2,8,'Мужские ботинки Рос-Обувь кожаные с натуральным мехом','G783F5.jpg'),(35,'J384T6','Ботинки',1,3800,10,'Rieker',2,1,2,16,'B3430/14 Полуботинки мужские Rieker','J384T6.jpg'),(36,'D572U8','Кроссовки',1,4100,5,'Рос',2,1,3,6,'129615-4 Кроссовки мужские','D572U8.jpg'),(37,'F572H7','Туфли',1,2700,15,'Marco Tozzi',1,2,2,14,'Туфли Marco Tozzi женские летние, размер 39, цвет черный','F572H7.jpg'),(38,'D329H3','Полуботинки',1,1890,10,'Alessio Nesca',2,2,4,4,'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый','D329H3.jpg'),(39,'B320R5','Туфли',1,4300,15,'Rieker',1,2,2,6,'Туфли Rieker женские демисезонные, размер 41, цвет коричневый','B320R5.jpg'),(40,'G432E4','Туфли',1,2800,10,'Kari',1,2,3,15,'Туфли kari женские TR-YR-413017, размер 37, цвет: черный','G432E4.jpg'),(41,'А112Т4','Ботинки',1,4990,30,'Kari',1,2,3,6,'Женские Ботинки демисезонные kari','А112Т4.jpg'),(42,'F635R4','Ботинки',1,3244,20,'Marco Tozzi',2,2,2,13,'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый','F635R4.jpg'),(43,'H782T5','Туфли',1,4499,30,'Kari',1,1,4,5,'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный','H782T5.jpg'),(44,'G783F5','Ботинки',1,5900,25,'Рос',1,1,2,8,'Мужские ботинки Рос-Обувь кожаные с натуральным мехом','G783F5.jpg'),(45,'J384T6','Ботинки',1,3800,10,'Rieker',2,1,2,16,'B3430/14 Полуботинки мужские Rieker','J384T6.jpg'),(46,'D572U8','Кроссовки',1,4100,5,'Рос',2,1,3,6,'129615-4 Кроссовки мужские','D572U8.jpg'),(47,'F572H7','Туфли',1,2700,15,'Marco Tozzi',1,2,2,14,'Туфли Marco Tozzi женские летние, размер 39, цвет черный','F572H7.jpg'),(48,'D329H3','Полуботинки',1,1890,10,'Alessio Nesca',2,2,4,4,'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый','D329H3.jpg'),(49,'B320R5','Туфли',1,4300,15,'Rieker',1,2,2,6,'Туфли Rieker женские демисезонные, размер 41, цвет коричневый','B320R5.jpg'),(50,'G432E4','Туфли',1,2800,10,'Kari',1,2,3,15,'Туфли kari женские TR-YR-413017, размер 37, цвет: черный','G432E4.jpg'),(51,'А112Т4','Ботинки',1,4990,30,'Kari',1,2,3,6,'Женские Ботинки демисезонные kari','А112Т4.jpg'),(52,'F635R4','Ботинки',1,3244,20,'Marco Tozzi',2,2,2,13,'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый','F635R4.jpg'),(53,'H782T5','Туфли',1,4499,30,'Kari',1,1,4,5,'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный','H782T5.jpg'),(54,'G783F5','Ботинки',1,5900,25,'Рос',1,1,2,8,'Мужские ботинки Рос-Обувь кожаные с натуральным мехом','G783F5.jpg'),(55,'J384T6','Ботинки',1,3800,10,'Rieker',2,1,2,16,'B3430/14 Полуботинки мужские Rieker','J384T6.jpg'),(56,'D572U8','Кроссовки',1,4100,5,'Рос',2,1,3,6,'129615-4 Кроссовки мужские','D572U8.jpg'),(57,'F572H7','Туфли',1,2700,15,'Marco Tozzi',1,2,2,14,'Туфли Marco Tozzi женские летние, размер 39, цвет черный','F572H7.jpg'),(58,'D329H3','Полуботинки',1,1890,10,'Alessio Nesca',2,2,4,4,'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый','D329H3.jpg'),(59,'B320R5','Туфли',1,4300,15,'Rieker',1,2,2,6,'Туфли Rieker женские демисезонные, размер 41, цвет коричневый','B320R5.jpg'),(60,'G432E4','Туфли',1,2800,10,'Kari',1,2,3,15,'Туфли kari женские TR-YR-413017, размер 37, цвет: черный','G432E4.jpg'),(61,'А112Т4','Ботинки',1,4990,30,'Kari',1,2,3,6,'Женские Ботинки демисезонные kari','А112Т4.jpg'),(62,'F635R4','Ботинки',1,3244,20,'Marco Tozzi',2,2,2,13,'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый','F635R4.jpg'),(63,'H782T5','Туфли',1,4499,30,'Kari',1,1,4,5,'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный','H782T5.jpg'),(64,'G783F5','Ботинки',1,5900,25,'Рос',1,1,2,8,'Мужские ботинки Рос-Обувь кожаные с натуральным мехом','G783F5.jpg'),(65,'J384T6','Ботинки',1,3800,10,'Rieker',2,1,2,16,'B3430/14 Полуботинки мужские Rieker','J384T6.jpg'),(66,'D572U8','Кроссовки',1,4100,5,'Рос',2,1,3,6,'129615-4 Кроссовки мужские','D572U8.jpg'),(67,'F572H7','Туфли',1,2700,15,'Marco Tozzi',1,2,2,14,'Туфли Marco Tozzi женские летние, размер 39, цвет черный','F572H7.jpg'),(68,'D329H3','Полуботинки',1,1890,10,'Alessio Nesca',2,2,4,4,'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый','D329H3.jpg'),(69,'B320R5','Туфли',1,4300,15,'Rieker',1,2,2,6,'Туфли Rieker женские демисезонные, размер 41, цвет коричневый','B320R5.jpg'),(70,'G432E4','Туфли',1,2800,10,'Kari',1,2,3,15,'Туфли kari женские TR-YR-413017, размер 37, цвет: черный','G432E4.jpg'),(71,'S213E3','Полуботинки',1,2156,5,'CROSBY',2,1,3,6,'407700/01-01 Полуботинки мужские CROSBY','line.jpg'),(72,'E482R4','Полуботинки',1,1800,15,'Kari',1,2,2,14,'Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный','line.jpg'),(73,'S634B5','Кеды',1,5500,20,'CROSBY',2,1,3,6,'Кеды Caprice мужские демисезонные, размер 42, цвет черный','line.jpg'),(74,'K345R4','Полуботинки',1,2100,15,'CROSBY',2,1,2,3,'407700/01-02 Полуботинки мужские CROSBY','line.jpg'),(75,'O754F4','Туфли',1,5400,10,'Rieker',2,2,4,18,'Туфли женские демисезонные Rieker артикул 55073-68/37','line.jpg'),(76,'G531F4','Ботинки',1,6600,5,'Kari',1,2,2,9,'Ботинки женские зимние ROMER арт. 893167-01 Черный','line.jpg'),(77,'J542F5','Тапочки',1,500,5,'Kari',1,1,3,12,'Тапочки мужские Арт.70701-55-67син р.41','line.jpg'),(78,'B431R5','Ботинки',1,2700,10,'Rieker',2,1,2,5,'Мужские кожаные ботинки/мужские ботинки','line.jpg'),(79,'P764G4','Туфли',1,6800,30,'CROSBY',1,2,3,15,'Туфли женские, ARGO, размер 38','line.jpg'),(80,'C436G5','Ботинки',1,10200,15,'Alessio Nesca',1,2,2,9,'Ботинки женские, ARGO, размер 40','line.jpg'),(81,'F427R5','Ботинки',1,11800,10,'Rieker',2,2,4,11,'Ботинки на молнии с декоративной пряжкой FRAU','line.jpg'),(82,'N457T5','Полуботинки',1,4600,5,'CROSBY',1,2,3,13,'Полуботинки Ботинки черные зимние, мех','line.jpg'),(83,'D364R4','Туфли',1,12400,10,'Kari',1,2,2,5,'Туфли Luiza Belly женские Kate-lazo черные из натуральной замши','line.jpg'),(84,'S326R5','Тапочки',1,9900,15,'CROSBY',2,1,3,15,'Мужские кожаные тапочки Профиль С.Дали','line.jpg'),(85,'L754R4','Полуботинки',1,1700,10,'Kari',1,2,2,7,'Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный','line.jpg'),(86,'M542T5','Кроссовки',1,2800,5,'Rieker',2,1,5,3,'Кроссовки мужские TOFA','line.jpg'),(87,'D268G5','Туфли',1,4399,10,'Rieker',2,2,3,12,'Туфли Rieker женские демисезонные, размер 36, цвет коричневый','line.jpg'),(88,'T324F5','Сапоги',1,4699,15,'CROSBY',1,2,2,5,'Сапоги замша Цвет: синий','line.jpg'),(90,'H535R5','Ботинки',1,2300,25,'Rieker',2,2,2,7,'Женские Ботинки демисезонные','line.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(45) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Клиент'),(2,'Менеджер'),(3,'Администратор');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `StatusID` int NOT NULL AUTO_INCREMENT,
  `StatusName` varchar(45) NOT NULL,
  PRIMARY KEY (`StatusID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Новый'),(2,'Завершен');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sypplier`
--

DROP TABLE IF EXISTS `sypplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sypplier` (
  `SypplierID` int NOT NULL AUTO_INCREMENT,
  `SypplierName` varchar(455) NOT NULL,
  PRIMARY KEY (`SypplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sypplier`
--

LOCK TABLES `sypplier` WRITE;
/*!40000 ALTER TABLE `sypplier` DISABLE KEYS */;
INSERT INTO `sypplier` VALUES (1,'Kari'),(2,'Обувь для вас');
/*!40000 ALTER TABLE `sypplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit` (
  `UnitID` int NOT NULL AUTO_INCREMENT,
  `UnitName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UnitID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES (1,'шт');
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserSourname` varchar(450) NOT NULL,
  `UserName` varchar(405) NOT NULL,
  `UserPpatronymic` varchar(405) NOT NULL,
  `UserLogin` varchar(405) NOT NULL,
  `UserPassword` varchar(450) NOT NULL,
  `UserRole` int NOT NULL,
  PRIMARY KEY (`UserID`),
  KEY `UserRole_idx` (`UserRole`),
  CONSTRAINT `UserRole` FOREIGN KEY (`UserRole`) REFERENCES `role` (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Герасимов','Вячеслав','Ростиславович','loginDEftn2018','gPq+a}',1),(2,'Суворов','Всеволод','Богданович','loginDEhuv2018','EJFYzS',2),(3,'Ширяев','Иван','Игоревич','loginDEfhd2018','{4wU7n',3),(4,'Колобова','Иванна','Геннадьевна','loginDEaon2018','&OmaNE',1),(5,'Шестаков','Антон','Константинович','loginDEyat2018','ELSTyH',2),(6,'Игнатьев','Федосей','Богданович','loginDEmin2018','pQ6jze',2),(7,'Горбунов','Валентин','Григорьевич','loginDEzal2018','zbU8R5',2),(8,'Терентьева','Анжела','Михаиловна','loginDEemw2018','NxhF5I',3),(9,'Мясникова','Ия','Евсеевна','loginDEmqt2018','SIasu5',1),(10,'Горбунов','Григорий','Денисович','loginDEpxx2018','Xv{vjN',2),(11,'Герасимов','Олег','Авксентьевич','loginDEetv2018','lNi&rF',2),(12,'Меркушева','Нинель','Матвеевна','loginDEonq2018','mKIIRQ',1),(13,'Степанов','Григорий','Матвеевич','loginDErhl2018','U}rb9j',3),(14,'Агафонов','Владлен','Станиславович','loginDEfou2018','O+S9hm',1),(15,'Кузнецов','Фрол','Георгьевич','loginDElno2018','le1vt2',2),(16,'Игнатьев','Борис','Владиславович','loginDEtbx2018','CQplH|',2),(17,'Симонов','Юрий','Созонович','loginDEltw2018','zvjkwE',3),(18,'Степанов','Евсей','Федотович','loginDEfuz2018','ILry03',2),(19,'Зыков','Вячеслав','Антонович','loginDEygj2018','7b6PUb',2),(20,'Анисимова','Алина','Протасьевна','loginDEwpn2018','9BBkXP',1),(21,'Артемьева','Лариса','Макаровна','loginDEyix2018','6zbXg*',2),(22,'Мамонтова','Ия','Христофоровна','loginDEtms2018','70Z&Zy',3),(23,'Котова','Светлана','Леонидовна','loginDEmgl2018','QJNgD&',2),(24,'Фёдорова','Алла','Брониславовна','loginDEhix2018','ZKnd*0',1),(25,'Гущина','Анжела','Аркадьевна','loginDEwbk2018','iJMh5B',2),(26,'Дмитриев','Григорий','Мэлорович','loginDEpwa2018','yn5MLQ',2),(27,'Дроздова','Фёкла','Митрофановна','loginDElrx2018','lbX+dF',1),(28,'Гаврилов','Василий','Германович','loginDEidx2018','R2j0mn',2),(29,'Суханова','Фаина','Юрьевна','loginDEzmk2018','ZrgBk6',1),(30,'Савельев','Егор','Сергеевич','loginDEvje2018','gCU1fd',1),(31,'Кирилов','Иван','Сергеевич','loginDEwun2018','gCU1fd',1),(32,'Сазонова','Клавдия','Евгеньевна','loginDEfzq2018','36H8f}',3),(33,'Шаров','Григорий','Созонович','loginDEwel2018','UU5FTi',1),(34,'Щербаков','Кондрат','Фёдорович','loginDEljg2018','CT44Gc',1),(35,'Дроздов','Дмитрий','Юлианович','loginDEgsp2018','9ACW}r',1),(36,'Молчанов','Юрий','Лукьянович','loginDEjvp2018','etLGcB',3),(37,'Тихонов','Валентин','Авдеевич','loginDEapt2018','cwx{RH',1),(38,'Виноградов','Юрий','Лукьевич','loginDEilb2018','IN2Ahc',2),(39,'Горбунова','Нинель','Сергеевна','loginDErch2018','|&DFy+',1),(40,'Маслов','Леонид','Николаевич','loginDEfwx2018','t|*wCk',2),(41,'Родионова','Венера','Арсеньевна','loginDEggp2018','bBNxJb',2),(42,'Агафонов','Пантелеймон','Гордеевич','loginDEbgb2018','VtmP58',2),(43,'Кудрявцев','Гордей','Авксентьевич','loginDEnif2018','Nhj*t+',2),(44,'Лыткина','Алевтина','Романовна','loginDEsvs2018','tLgPnC',2),(45,'Князев','Геласий','Евсеевич','loginDEghx2018','gue+iw',2),(46,'Бирюкова','Пелагея','Дмитрьевна','loginDElmy2018','X2LtuP',2),(47,'Быков','Лаврентий','Ярославович','loginDEevd2018','GMbcZN',1),(48,'Воронов','Олег','Яковович','loginDEodd2018','s2|Eb1',1),(49,'Богданова','Марфа','Владимировна','loginDEmrj2018','blrD&8',3),(50,'Беляев','Донат','Агафонович','loginDEyct2018','uD+|Ud',3),(151,'Герасимов','Вячеслав','Ростиславович','loginDEftn2018','gPq+a}',1),(152,'Суворов','Всеволод','Богданович','loginDEhuv2018','EJFYzS',2),(153,'Ширяев','Иван','Игоревич','loginDEfhd2018','{4wU7n',3),(154,'Колобова','Иванна','Геннадьевна','loginDEaon2018','&OmaNE',1),(155,'Шестаков','Антон','Константинович','loginDEyat2018','ELSTyH',2),(156,'Игнатьев','Федосей','Богданович','loginDEmin2018','pQ6jze',2),(157,'Горбунов','Валентин','Григорьевич','loginDEzal2018','zbU8R5',2),(158,'Терентьева','Анжела','Михаиловна','loginDEemw2018','NxhF5I',3),(159,'Мясникова','Ия','Евсеевна','loginDEmqt2018','SIasu5',1),(160,'Горбунов','Григорий','Денисович','loginDEpxx2018','Xv{vjN',2),(161,'Герасимов','Олег','Авксентьевич','loginDEetv2018','lNi&rF',2),(162,'Меркушева','Нинель','Матвеевна','loginDEonq2018','mKIIRQ',1),(163,'Степанов','Григорий','Матвеевич','loginDErhl2018','U}rb9j',3),(164,'Агафонов','Владлен','Станиславович','loginDEfou2018','O+S9hm',1),(165,'Кузнецов','Фрол','Георгьевич','loginDElno2018','le1vt2',2),(166,'Игнатьев','Борис','Владиславович','loginDEtbx2018','CQplH|',2),(167,'Симонов','Юрий','Созонович','loginDEltw2018','zvjkwE',3),(168,'Степанов','Евсей','Федотович','loginDEfuz2018','ILry03',2),(169,'Зыков','Вячеслав','Антонович','loginDEygj2018','7b6PUb',2),(170,'Анисимова','Алина','Протасьевна','loginDEwpn2018','9BBkXP',1),(171,'Артемьева','Лариса','Макаровна','loginDEyix2018','6zbXg*',2),(172,'Мамонтова','Ия','Христофоровна','loginDEtms2018','70Z&Zy',3),(173,'Котова','Светлана','Леонидовна','loginDEmgl2018','QJNgD&',2),(174,'Фёдорова','Алла','Брониславовна','loginDEhix2018','ZKnd*0',1),(175,'Гущина','Анжела','Аркадьевна','loginDEwbk2018','iJMh5B',2),(176,'Дмитриев','Григорий','Мэлорович','loginDEpwa2018','yn5MLQ',2),(177,'Дроздова','Фёкла','Митрофановна','loginDElrx2018','lbX+dF',1),(178,'Гаврилов','Василий','Германович','loginDEidx2018','R2j0mn',2),(179,'Суханова','Фаина','Юрьевна','loginDEzmk2018','ZrgBk6',1),(180,'Савельев','Егор','Сергеевич','loginDEvje2018','gCU1fd',1),(181,'Кирилов','Иван','Сергеевич','loginDEwun2018','gCU1fd',1),(182,'Сазонова','Клавдия','Евгеньевна','loginDEfzq2018','36H8f}',3),(183,'Шаров','Григорий','Созонович','loginDEwel2018','UU5FTi',1),(184,'Щербаков','Кондрат','Фёдорович','loginDEljg2018','CT44Gc',1),(185,'Дроздов','Дмитрий','Юлианович','loginDEgsp2018','9ACW}r',1),(186,'Молчанов','Юрий','Лукьянович','loginDEjvp2018','etLGcB',3),(187,'Тихонов','Валентин','Авдеевич','loginDEapt2018','cwx{RH',1),(188,'Виноградов','Юрий','Лукьевич','loginDEilb2018','IN2Ahc',2),(189,'Горбунова','Нинель','Сергеевна','loginDErch2018','|&DFy+',1),(190,'Маслов','Леонид','Николаевич','loginDEfwx2018','t|*wCk',2),(191,'Родионова','Венера','Арсеньевна','loginDEggp2018','bBNxJb',2),(192,'Агафонов','Пантелеймон','Гордеевич','loginDEbgb2018','VtmP58',2),(193,'Кудрявцев','Гордей','Авксентьевич','loginDEnif2018','Nhj*t+',2),(194,'Лыткина','Алевтина','Романовна','loginDEsvs2018','tLgPnC',2),(195,'Князев','Геласий','Евсеевич','loginDEghx2018','gue+iw',2),(196,'Бирюкова','Пелагея','Дмитрьевна','loginDElmy2018','X2LtuP',2),(197,'Быков','Лаврентий','Ярославович','loginDEevd2018','GMbcZN',1),(198,'Воронов','Олег','Яковович','loginDEodd2018','s2|Eb1',1),(199,'Богданова','Марфа','Владимировна','loginDEmrj2018','blrD&8',3),(200,'Беляев','Донат','Агафонович','loginDEyct2018','uD+|Ud',3),(201,'Герасимов','Вячеслав','Ростиславович','loginDEftn2018','gPq+a}',1),(202,'Суворов','Всеволод','Богданович','loginDEhuv2018','EJFYzS',2),(203,'Ширяев','Иван','Игоревич','loginDEfhd2018','{4wU7n',3),(204,'Колобова','Иванна','Геннадьевна','loginDEaon2018','&OmaNE',1),(205,'Шестаков','Антон','Константинович','loginDEyat2018','ELSTyH',2),(206,'Игнатьев','Федосей','Богданович','loginDEmin2018','pQ6jze',2),(207,'Горбунов','Валентин','Григорьевич','loginDEzal2018','zbU8R5',2),(208,'Терентьева','Анжела','Михаиловна','loginDEemw2018','NxhF5I',3),(209,'Мясникова','Ия','Евсеевна','loginDEmqt2018','SIasu5',1),(210,'Горбунов','Григорий','Денисович','loginDEpxx2018','Xv{vjN',2),(211,'Герасимов','Олег','Авксентьевич','loginDEetv2018','lNi&rF',2),(212,'Меркушева','Нинель','Матвеевна','loginDEonq2018','mKIIRQ',1),(213,'Степанов','Григорий','Матвеевич','loginDErhl2018','U}rb9j',3),(214,'Агафонов','Владлен','Станиславович','loginDEfou2018','O+S9hm',1),(215,'Кузнецов','Фрол','Георгьевич','loginDElno2018','le1vt2',2),(216,'Игнатьев','Борис','Владиславович','loginDEtbx2018','CQplH|',2),(217,'Симонов','Юрий','Созонович','loginDEltw2018','zvjkwE',3),(218,'Степанов','Евсей','Федотович','loginDEfuz2018','ILry03',2),(219,'Зыков','Вячеслав','Антонович','loginDEygj2018','7b6PUb',2),(220,'Анисимова','Алина','Протасьевна','loginDEwpn2018','9BBkXP',1),(221,'Артемьева','Лариса','Макаровна','loginDEyix2018','6zbXg*',2),(222,'Мамонтова','Ия','Христофоровна','loginDEtms2018','70Z&Zy',3),(223,'Котова','Светлана','Леонидовна','loginDEmgl2018','QJNgD&',2),(224,'Фёдорова','Алла','Брониславовна','loginDEhix2018','ZKnd*0',1),(225,'Гущина','Анжела','Аркадьевна','loginDEwbk2018','iJMh5B',2),(226,'Дмитриев','Григорий','Мэлорович','loginDEpwa2018','yn5MLQ',2),(227,'Дроздова','Фёкла','Митрофановна','loginDElrx2018','lbX+dF',1),(228,'Гаврилов','Василий','Германович','loginDEidx2018','R2j0mn',2),(229,'Суханова','Фаина','Юрьевна','loginDEzmk2018','ZrgBk6',1),(230,'Савельев','Егор','Сергеевич','loginDEvje2018','gCU1fd',1),(231,'Кирилов','Иван','Сергеевич','loginDEwun2018','gCU1fd',1),(232,'Сазонова','Клавдия','Евгеньевна','loginDEfzq2018','36H8f}',3),(233,'Шаров','Григорий','Созонович','loginDEwel2018','UU5FTi',1),(234,'Щербаков','Кондрат','Фёдорович','loginDEljg2018','CT44Gc',1),(235,'Дроздов','Дмитрий','Юлианович','loginDEgsp2018','9ACW}r',1),(236,'Молчанов','Юрий','Лукьянович','loginDEjvp2018','etLGcB',3),(237,'Тихонов','Валентин','Авдеевич','loginDEapt2018','cwx{RH',1),(238,'Виноградов','Юрий','Лукьевич','loginDEilb2018','IN2Ahc',2),(239,'Горбунова','Нинель','Сергеевна','loginDErch2018','|&DFy+',1),(240,'Маслов','Леонид','Николаевич','loginDEfwx2018','t|*wCk',2),(241,'Родионова','Венера','Арсеньевна','loginDEggp2018','bBNxJb',2),(242,'Агафонов','Пантелеймон','Гордеевич','loginDEbgb2018','VtmP58',2),(243,'Кудрявцев','Гордей','Авксентьевич','loginDEnif2018','Nhj*t+',2),(244,'Лыткина','Алевтина','Романовна','loginDEsvs2018','tLgPnC',2),(245,'Князев','Геласий','Евсеевич','loginDEghx2018','gue+iw',2),(246,'Бирюкова','Пелагея','Дмитрьевна','loginDElmy2018','X2LtuP',2),(247,'Быков','Лаврентий','Ярославович','loginDEevd2018','GMbcZN',1),(248,'Воронов','Олег','Яковович','loginDEodd2018','s2|Eb1',1),(249,'Богданова','Марфа','Владимировна','loginDEmrj2018','blrD&8',3),(250,'Беляев','Донат','Агафонович','loginDEyct2018','uD+|Ud',3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db22'
--

--
-- Dumping routines for database 'db22'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-16  0:24:18

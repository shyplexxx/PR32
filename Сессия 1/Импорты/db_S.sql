CREATE DATABASE  IF NOT EXISTS `db22`;
USE `db22`;


DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(450) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `deliverypoint`;

CREATE TABLE `deliverypoint` (
  `DPID` int NOT NULL AUTO_INCREMENT,
  `DPName` varchar(405) NOT NULL,
  PRIMARY KEY (`DPID`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
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



DROP TABLE IF EXISTS `order`;
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

-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: us-cdbr-east-06.cleardb.net    Database: heroku_56236b0149670d1
-- ------------------------------------------------------
-- Server version	5.5.62-log

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
-- Table structure for table `cheques`
--

DROP TABLE IF EXISTS `cheques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cheques` (
  `chequesId` int(11) NOT NULL AUTO_INCREMENT,
  `chequesNumber` varchar(45) DEFAULT NULL,
  `chequesRealiseDate` datetime DEFAULT NULL,
  `chequesIssueDate` datetime DEFAULT NULL,
  `chequesBank` varchar(45) NOT NULL,
  `chequesAmount` double(65,2) DEFAULT NULL,
  `cheque_companyId` int(11) NOT NULL,
  `chequesCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chequesId`),
  UNIQUE KEY `chequesNumber_UNIQUE` (`chequesNumber`),
  KEY `cheque_companyId` (`cheque_companyId`),
  CONSTRAINT `cheques_ibfk_1` FOREIGN KEY (`cheque_companyId`) REFERENCES `company` (`companyId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheques`
--

LOCK TABLES `cheques` WRITE;
/*!40000 ALTER TABLE `cheques` DISABLE KEYS */;
INSERT INTO `cheques` VALUES (42,'4785111','2020-04-10 00:00:00','2020-04-10 00:00:00','BOC',100000.00,1,'2020-04-10 09:51:55'),(44,'78945116','2020-04-11 00:00:00','2020-04-11 00:00:00','BOC',50000.00,1,'2020-04-11 11:53:10'),(45,'7845124578','2020-04-18 00:00:00','2020-04-18 00:00:00','Sampath',25000.33,2,'2020-04-18 06:39:10');
/*!40000 ALTER TABLE `cheques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `companyId` int(11) NOT NULL AUTO_INCREMENT,
  `companyName` varchar(100) NOT NULL,
  `companyAddress` varchar(150) DEFAULT NULL,
  `companyRegNo` varchar(45) NOT NULL,
  `companyEmail` varchar(45) DEFAULT NULL,
  `companyContact` varchar(45) DEFAULT NULL,
  `companyRegDate` varchar(45) DEFAULT NULL,
  `companyCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`companyId`,`companyRegNo`),
  UNIQUE KEY `companyRegNo_UNIQUE` (`companyRegNo`),
  UNIQUE KEY `companyName_UNIQUE` (`companyName`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Subasinghe','Matale','REG12345','suba@gmail.com','0667812459','2020-03-7','2020-03-17 12:13:34'),(2,'Noushart','Kandy','REG54673','nou@gmail.com','0815789456','2020-3-18','2020-03-18 04:06:45'),(7,'Jayanthi Super','Thawalankoya','REG1234567','jaya@gmail.com','0663578426','2020-3-21','2020-03-21 08:56:18');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companypayments`
--

DROP TABLE IF EXISTS `companypayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companypayments` (
  `companyPaymentsId` int(11) NOT NULL AUTO_INCREMENT,
  `companyPaymentsCredit` double(65,2) DEFAULT '0.00',
  `companyPaymentsDebit` double(65,2) NOT NULL DEFAULT '0.00',
  `company_companyId` int(11) NOT NULL,
  PRIMARY KEY (`companyPaymentsId`),
  KEY `fk_CompanyPayments_company1_idx` (`company_companyId`),
  CONSTRAINT `CompanyPayments_ibfk_1` FOREIGN KEY (`company_companyId`) REFERENCES `company` (`companyId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companypayments`
--

LOCK TABLES `companypayments` WRITE;
/*!40000 ALTER TABLE `companypayments` DISABLE KEYS */;
INSERT INTO `companypayments` VALUES (2,150000.00,387833.03,1),(3,25000.33,0.00,2);
/*!40000 ALTER TABLE `companypayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery` (
  `deliveryNoteNO` int(11) NOT NULL AUTO_INCREMENT,
  `deliveryDistance` float DEFAULT NULL,
  `deliveryAcceptance` varchar(10) DEFAULT 'Pending..',
  `deliveryDate` timestamp NULL DEFAULT NULL,
  `deliveryPayment` double DEFAULT '0',
  `deliveryDepartureTime` varchar(10) DEFAULT NULL,
  `vehicle_vehicleNumber` varchar(10) NOT NULL,
  `uploadingPlace_uploadingPlaceId` int(11) NOT NULL,
  `driver_driverLicenseNo` int(11) NOT NULL,
  PRIMARY KEY (`deliveryNoteNO`),
  KEY `fk_delivery_vehicle1_idx` (`vehicle_vehicleNumber`),
  KEY `fk_delivery_uploadingPlace1_idx` (`uploadingPlace_uploadingPlaceId`),
  KEY `fk_delivery_driver1_idx` (`driver_driverLicenseNo`),
  CONSTRAINT `fk_delivery_driver1` FOREIGN KEY (`driver_driverLicenseNo`) REFERENCES `driver` (`driverLicenseNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_delivery_uploadingPlace1` FOREIGN KEY (`uploadingPlace_uploadingPlaceId`) REFERENCES `unloadingplace` (`uploadingPlaceId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_delivery_vehicle1` FOREIGN KEY (`vehicle_vehicleNumber`) REFERENCES `vehicle` (`vehicleNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (22,30,'Accepted','2020-03-20 18:30:00',4200,'12.49','LA-8899',2,512478964),(23,10,'Accepted','2020-03-20 18:30:00',1400,'12.49','LA-8899',2,512478964),(24,4,'Accepted','2020-03-20 18:30:00',1600,'12.49','LA-8899',2,512478964),(25,10,'Accepted','2020-03-20 18:30:00',1400,'12.49','LA-8899',2,512478964),(26,10,'Accepted','2020-03-20 18:30:00',1400,'12.49','KA-8765',2,512478964),(27,10,'Accepted','2020-03-20 18:30:00',1400,'12.53','LA-8899',2,512478964),(28,20,'Accepted','2020-03-20 18:30:00',2800,'14.46','KA-8765',1,512478964),(29,20,'Accepted','2020-03-18 18:30:00',2800,'14.46','KA-8765',1,512478964),(30,20,'Accepted','2020-03-20 18:30:00',2800,'14.55','BA-8748',1,512478964),(31,3,'Accepted','2020-03-21 18:30:00',1200,'10.42','KA-8765',1,512478964),(32,30,'Accepted','2020-03-21 18:30:00',4200,'14.13','KA-8765',2,789452154),(33,20,'Accepted','2020-03-21 18:30:00',2800,'15.6','KA-8765',1,789452154),(34,40,'Accepted','2020-03-23 18:30:00',5600,'13.49','LA-8899',1,512478964),(35,20,'Accepted','2020-03-24 18:30:00',2900,'11.29','KD-9876',5,55655488),(36,20,'Accepted','2020-03-24 18:30:00',2800,'19.10','KA-8765',4,789452154),(37,12,'Accepted','2020-03-26 18:30:00',1740,'10.40','KD-9876',4,789452154),(38,12,'Accepted','2020-03-26 18:30:00',1680,'15.47','BA-8748',4,512478964),(39,14,'Accepted','2020-03-26 18:30:00',1960,'15.54','KA-8765',4,512478964),(40,21,'Accepted','2020-03-26 18:30:00',2940,'16.25','BA-8748',5,789452154),(41,20,'Accepted','2020-03-28 18:30:00',2800,'17.12','KA-8765',1,512478964),(42,10,'Accepted','2020-04-01 18:30:00',1400,'10.38','LA-8899',1,512478964),(43,20,'Accepted','2020-04-03 18:30:00',2800,'11.29','BA-8748',4,789452154),(44,12,'Rejected','2020-04-03 18:30:00',1680,'11.31','KA-8765',5,55655488),(45,12,'Accepted','2020-04-05 18:30:00',1740,'16.23','KD-9876',4,789452154),(46,12,'Accepted','2020-04-05 18:30:00',1740,'16.23','KD-9876',4,789452154),(47,11,'Accepted','2020-04-05 18:30:00',1540,'16.24','BA-8748',5,789452154),(48,20,'Accepted','2020-04-05 18:30:00',2800,'16.28','BA-8748',1,55655488),(49,12,'Accepted','2020-04-05 18:30:00',1680,'16.30','KA-8765',2,789452154),(50,12,'Accepted','2020-04-05 18:30:00',1680,'16.32','KA-8765',5,55655488),(51,12,'Rejected','2020-04-05 18:30:00',1680,'16.34','BA-8748',4,789452154),(52,15,'Rejected','2020-04-05 18:30:00',2100,'17.28','BA-8748',2,789452154),(53,14,'Rejected','2020-04-06 18:30:00',1960,'9.57','KA-8765',5,789452154),(55,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','KA-8765',2,789452154),(56,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','KA-8765',2,789452154),(57,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','KA-8765',2,789452154),(58,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','KA-8765',2,789452154),(59,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','KA-8765',2,789452154),(60,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(61,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(62,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(63,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(64,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(65,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(66,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(67,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(70,25,'Accepted','2020-04-14 18:30:00',3500,'13.28','LA-8899',1,789452154),(168,20,'Accepted','2020-04-13 18:30:00',2800,'12.34','BA-8748',1,55655488),(171,20,'Accepted','2020-05-14 00:00:00',2800,'16.58','LA-8899',1,512478964),(181,20,'Rejected','2020-05-20 00:00:00',2800,'10.48','KA-8765',1,512478964);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dieselfee`
--

DROP TABLE IF EXISTS `dieselfee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dieselfee` (
  `dieselFeeId` int(11) NOT NULL AUTO_INCREMENT,
  `dieselFeeLiters` float DEFAULT NULL,
  PRIMARY KEY (`dieselFeeId`),
  CONSTRAINT `dieselFee_ibfk_1` FOREIGN KEY (`dieselFeeId`) REFERENCES `lorrypayments` (`paymentsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dieselfee`
--

LOCK TABLES `dieselfee` WRITE;
/*!40000 ALTER TABLE `dieselfee` DISABLE KEYS */;
INSERT INTO `dieselfee` VALUES (75,1);
/*!40000 ALTER TABLE `dieselfee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `driver` (
  `driverLicenseNo` int(11) NOT NULL,
  `driverName` varchar(100) DEFAULT NULL,
  `driverContact` varchar(45) DEFAULT NULL,
  `driverRegDate` date DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`driverLicenseNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES (55655488,'Ishan Harshana','078542457','2020-03-25','2020-03-25 04:34:10'),(512478964,'W.S Liyanage','0778541265','2019-07-05','2020-03-17 12:34:23'),(789452154,'K.S Kumara','078451247','2020-02-14','2020-03-17 12:34:23');
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `invoiceId` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceCompanyId` int(11) NOT NULL,
  `invoiceRange` varchar(45) NOT NULL,
  `invoiceAmount` double(65,2) NOT NULL,
  `invoiceCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`invoiceId`),
  KEY `invoiceCompanyId` (`invoiceCompanyId`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`invoiceCompanyId`) REFERENCES `company` (`companyId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (51,1,'2020-5-14 To 2020-5-14',11333.32,'2020-05-14 13:18:41'),(61,1,'2020-1-14 To 2020-5-14',376499.71,'2020-05-14 13:19:36');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lorrypayments`
--

DROP TABLE IF EXISTS `lorrypayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lorrypayments` (
  `paymentsId` int(11) NOT NULL AUTO_INCREMENT,
  `paymentsAmount` double DEFAULT NULL,
  `paymentsDescription` varchar(150) NOT NULL,
  `paymentsDate` date DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `paymentType_paymentTypeId` int(11) NOT NULL,
  `vehicle_vehicleNumber` varchar(10) NOT NULL,
  PRIMARY KEY (`paymentsId`),
  KEY `fk_payments_paymentType1_idx` (`paymentType_paymentTypeId`),
  KEY `fk_payments_vehicle1_idx` (`vehicle_vehicleNumber`),
  CONSTRAINT `fk_payments_paymentType1` FOREIGN KEY (`paymentType_paymentTypeId`) REFERENCES `paymenttype` (`paymentTypeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_payments_vehicle1` FOREIGN KEY (`vehicle_vehicleNumber`) REFERENCES `vehicle` (`vehicleNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lorrypayments`
--

LOCK TABLES `lorrypayments` WRITE;
/*!40000 ALTER TABLE `lorrypayments` DISABLE KEYS */;
INSERT INTO `lorrypayments` VALUES (75,120,'kkkk','2020-04-11','2020-04-11 08:39:02',5,'LA-8899'),(76,400,'kkkk','2020-04-11','2020-04-11 08:39:45',1,'LA-8899'),(77,12200,'hose','2020-04-11','2020-04-11 09:36:53',2,'LA-8899'),(78,2200,'hose 2','2020-04-11','2020-04-11 09:45:02',2,'LA-8899'),(81,0,'','2020-05-14','2020-05-14 13:22:26',1,'BA-8748');
/*!40000 ALTER TABLE `lorrypayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymenttype`
--

DROP TABLE IF EXISTS `paymenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymenttype` (
  `paymentTypeId` int(11) NOT NULL,
  `paymentTypeType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`paymentTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymenttype`
--

LOCK TABLES `paymenttype` WRITE;
/*!40000 ALTER TABLE `paymenttype` DISABLE KEYS */;
INSERT INTO `paymenttype` VALUES (1,'Day Advance'),(2,'Maintain'),(3,'Delivery Fee'),(4,'Finance'),(5,'Diesel');
/*!40000 ALTER TABLE `paymenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pettycashbook`
--

DROP TABLE IF EXISTS `pettycashbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pettycashbook` (
  `pettyId` int(11) NOT NULL AUTO_INCREMENT,
  `LorryPayments_paymentsId` int(11) NOT NULL,
  `pettyDate` date NOT NULL,
  PRIMARY KEY (`pettyId`),
  KEY `LorryPayments_paymentsId` (`LorryPayments_paymentsId`),
  CONSTRAINT `pettyCashBook_ibfk_1` FOREIGN KEY (`LorryPayments_paymentsId`) REFERENCES `lorrypayments` (`paymentsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pettycashbook`
--

LOCK TABLES `pettycashbook` WRITE;
/*!40000 ALTER TABLE `pettycashbook` DISABLE KEYS */;
INSERT INTO `pettycashbook` VALUES (24,75,'2020-04-11'),(25,76,'2020-04-11');
/*!40000 ALTER TABLE `pettycashbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate`
--

DROP TABLE IF EXISTS `rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rate` (
  `rateId` int(11) NOT NULL AUTO_INCREMENT,
  `rateRange` varchar(45) DEFAULT NULL,
  `ratePrice` float DEFAULT NULL,
  PRIMARY KEY (`rateId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate`
--

LOCK TABLES `rate` WRITE;
/*!40000 ALTER TABLE `rate` DISABLE KEYS */;
INSERT INTO `rate` VALUES (1,'1-5',135);
/*!40000 ALTER TABLE `rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unloadingplace`
--

DROP TABLE IF EXISTS `unloadingplace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unloadingplace` (
  `uploadingPlaceId` int(11) NOT NULL AUTO_INCREMENT,
  `uploadingPlaceAddress` varchar(100) DEFAULT NULL,
  `unloadingPlaceIncomeRate` float DEFAULT NULL,
  `company_companyId` int(11) NOT NULL,
  PRIMARY KEY (`uploadingPlaceId`),
  KEY `fk_unloadingPlace_company1_idx` (`company_companyId`),
  CONSTRAINT `fk_unloadingPlace_company1` FOREIGN KEY (`company_companyId`) REFERENCES `company` (`companyId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unloadingplace`
--

LOCK TABLES `unloadingplace` WRITE;
/*!40000 ALTER TABLE `unloadingplace` DISABLE KEYS */;
INSERT INTO `unloadingplace` VALUES (1,'Rajagammana',2833.33,1),(2,'Matale Yard',2500,1),(4,'Ukuwela',2500,7),(5,'Elwala',2300.3,2);
/*!40000 ALTER TABLE `unloadingplace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `Status` varchar(10) NOT NULL DEFAULT 'Inactive',
  `role` varchar(45) NOT NULL DEFAULT 'Member',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'ishan','','ishan@gmail.com','$2b$10$ddSy9Mw1swo7/WUgskD58uqpB4LGcc.4/Vi7ZRVSByE8HVnP03wxm','Active','Admin','2020-04-11 18:30:00'),(3,'har','','har@gmail.com','$2b$10$u6mSgEpLiQoo8PIXvGb/MOertNM97TvV1qHClw/2v.dZjHIs8TSW.','Active','Member','2020-04-13 18:30:00'),(11,'soil transport','','soiltransport2020@gmail.com','$2b$10$JX.cQVGk119ohHlYU2V56uZhmFFNcd5/ATNmrqkTiFJIw0gBSaADq','Active','Admin','2020-05-19 11:54:24');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `vehicleNumber` varchar(10) NOT NULL,
  `vehicleCapacity` varchar(10) DEFAULT NULL,
  `vehicleDeliRate` float NOT NULL,
  `vehicleRegDate` date DEFAULT NULL,
  `vehicleCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`vehicleNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('BA-8748','5',140,'2020-03-21','2020-03-21 06:52:20'),('KA-8765','4',140,'2020-03-21','2020-03-21 06:45:11'),('KD-9876','6',145,'2020-03-25','2020-03-25 05:59:21'),('LA-8899','4',140,'2020-01-12','2020-03-17 12:14:45');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-03 16:15:28

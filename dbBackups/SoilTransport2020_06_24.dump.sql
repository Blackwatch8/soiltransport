-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: us-cdbr-east-05.cleardb.net    Database: heroku_c09fd48e58d7734
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
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheques`
--

LOCK TABLES `cheques` WRITE;
/*!40000 ALTER TABLE `cheques` DISABLE KEYS */;
INSERT INTO `cheques` VALUES (42,'4785111','2020-04-10 00:00:00','2020-04-10 00:00:00','BOC',100000.00,1,'2020-04-10 09:51:55'),(44,'78945116','2020-04-11 00:00:00','2020-04-11 00:00:00','BOC',50000.00,1,'2020-04-11 11:53:10'),(45,'7845124578','2020-04-18 00:00:00','2020-04-18 00:00:00','Sampath',25000.33,2,'2020-04-18 06:39:10'),(51,'113','2020-06-20 00:00:00','2020-06-20 00:00:00','boc',1000000.00,1,'2020-06-20 15:19:30'),(91,'113156511111116','2020-06-20 00:00:00','2020-06-20 00:00:00','boc',1000000.00,1,'2020-06-20 15:20:17'),(141,'invoice','2020-06-22 00:00:00','2020-06-22 00:00:00','BOC',50000.00,2,'2020-06-22 03:09:40'),(151,'online deposit','2020-06-22 00:00:00','2020-06-22 00:00:00','boc',500000.00,1,'2020-06-22 04:57:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Subasinghe','Matale','REG12345','suba@gmail.com','0667812459','2020-03-7','2020-03-17 12:13:34'),(2,'Noushart','Kandy','REG54673','nou@gmail.com','0815789456','2020-3-18','2020-03-18 04:06:45'),(7,'Jayanthi Super','Thawalankoya','REG1234567','jaya@gmail.com','0663578426','2020-3-21','2020-03-21 08:56:18'),(31,'cmk conturctions','polgahawela','5','','123','2020-6-20','2020-06-20 15:34:26'),(41,'vvk company (pvt)ltd','kalaniya','2','','0712222878','2020-6-20','2020-06-20 15:36:01'),(51,'ESURU BILDORS','UKUWELA','3','','12','2020-6-20','2020-06-20 15:37:19'),(61,'HARSHANI CONTURCTIONS','MAHAWELA','6','','1234','2020-6-20','2020-06-20 15:38:05'),(71,'CHAINA CEMICALS','CHINA','7','','1234','2020-6-20','2020-06-20 15:39:29'),(81,'MAICAL (BRIT VISON)','PERADENIYA','4','','1245','2020-6-20','2020-06-20 15:40:51'),(91,'RDA','MATALE','8','','122','2020-6-20','2020-06-20 15:41:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companypayments`
--

LOCK TABLES `companypayments` WRITE;
/*!40000 ALTER TABLE `companypayments` DISABLE KEYS */;
INSERT INTO `companypayments` VALUES (2,2630000.00,417533.03,1),(3,75000.33,0.00,2),(11,0.00,0.00,31),(21,0.00,0.00,41),(31,0.00,0.00,51),(41,0.00,0.00,61),(51,0.00,0.00,71),(61,0.00,0.00,81),(71,0.00,0.00,91);
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
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (2,5,'Accepted','2020-06-21 00:00:00',1500,'9.59','CP LA 7710',11,123),(3,12,'Pending..','2020-06-22 00:00:00',1680,'7.51','CP LA 7710',21,123),(4,11,'Accepted','2020-06-22 00:00:00',1540,'7.57','NW LJ 0121',41,123),(5,12,'Accepted','2020-06-22 00:00:00',1680,'8.30','CP LI 0545',21,512478964),(6,15,'Accepted','2020-06-22 00:00:00',2100,'10.15','CP LA 7710',21,512478964);
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
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dieselfee`
--

LOCK TABLES `dieselfee` WRITE;
/*!40000 ALTER TABLE `dieselfee` DISABLE KEYS */;
INSERT INTO `dieselfee` VALUES (621,12);
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
INSERT INTO `driver` VALUES (0,'DAMITH','0712854401','2020-06-20','2020-06-20 16:10:12'),(123,'GAMINI','0765679236','2020-06-20','2020-06-20 16:09:36'),(55655488,'Ishan Harshana','078542457','2020-03-25','2020-03-25 04:34:10'),(512478964,'W.S Liyanage','0778541265','2019-07-05','2020-03-17 12:34:23'),(789452154,'K.S Kumara','078451247','2020-02-14','2020-03-17 12:34:23');
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (51,1,'2020-5-14 To 2020-5-14',11333.32,'2020-05-14 13:18:41'),(61,1,'2020-1-14 To 2020-5-14',376499.71,'2020-05-14 13:19:36'),(71,1,'2020-1-22 To 2020-6-22',29700.00,'2020-06-22 04:55:16');
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
) ENGINE=InnoDB AUTO_INCREMENT=631 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lorrypayments`
--

LOCK TABLES `lorrypayments` WRITE;
/*!40000 ALTER TABLE `lorrypayments` DISABLE KEYS */;
INSERT INTO `lorrypayments` VALUES (591,15000,'THRWILL ACSIDANT','2020-06-20','2020-06-20 16:11:51',1,'CP LA 7710'),(601,400,'ABAGABA YATA','2020-06-20','2020-06-20 16:18:25',1,'CP LA 7710'),(611,400,'day advance','2020-06-22','2020-06-22 04:51:36',1,'CP LA 7710'),(621,1200,'diesel','2020-06-22','2020-06-22 04:53:22',5,'CP LA 7710');
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
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pettycashbook`
--

LOCK TABLES `pettycashbook` WRITE;
/*!40000 ALTER TABLE `pettycashbook` DISABLE KEYS */;
INSERT INTO `pettycashbook` VALUES (451,601,'2020-06-20'),(461,611,'2020-06-22');
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unloadingplace`
--

LOCK TABLES `unloadingplace` WRITE;
/*!40000 ALTER TABLE `unloadingplace` DISABLE KEYS */;
INSERT INTO `unloadingplace` VALUES (11,'MATALE YARD',2500,1),(21,'SALAGAMA',1400,1),(31,'KAVATAYAMUNA',2833.33,1),(41,'KAVATAYAMUNA',3200,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'ishan','','ishan@gmail.com','$2b$10$ddSy9Mw1swo7/WUgskD58uqpB4LGcc.4/Vi7ZRVSByE8HVnP03wxm','Active','Admin','2020-04-11 18:30:00'),(3,'har','','har@gmail.com','$2b$10$u6mSgEpLiQoo8PIXvGb/MOertNM97TvV1qHClw/2v.dZjHIs8TSW.','Active','Member','2020-06-20 14:58:14'),(11,'soil transport','','soiltransport2020@gmail.com','$2b$10$JX.cQVGk119ohHlYU2V56uZhmFFNcd5/ATNmrqkTiFJIw0gBSaADq','Active','Admin','2020-05-19 11:54:24');
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
INSERT INTO `vehicle` VALUES ('CP LA 7710','3',140,'2020-06-20','2020-06-20 15:43:24'),('CP LI 0545','3',140,'2020-06-20','2020-06-20 15:44:36'),('CP LJ 4653','3',140,'2020-06-20','2020-06-20 15:45:12'),('NW LH2157','3',140,'2020-06-20','2020-06-20 15:46:38'),('NW LJ 0121','3',140,'2020-06-20','2020-06-20 15:46:01');
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

-- Dump completed on 2020-06-24 11:44:59

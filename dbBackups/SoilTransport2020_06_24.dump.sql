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

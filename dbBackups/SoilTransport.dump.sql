/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: cheques
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `cheques` (
  `chequesId` int(11) NOT NULL AUTO_INCREMENT,
  `chequesNumber` varchar(150) NOT NULL,
  `chequesRealiseDate` datetime DEFAULT NULL,
  `chequesIssueDate` datetime DEFAULT NULL,
  `chequesBank` varchar(45) NOT NULL,
  `chequesAmount` double(65, 2) DEFAULT NULL,
  `cheque_companyId` int(11) NOT NULL,
  `chequesCreated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`chequesId`),
  KEY `cheque_companyId` (`cheque_companyId`),
  CONSTRAINT `cheques_ibfk_1` FOREIGN KEY (`cheque_companyId`) REFERENCES `company` (`companyId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: company
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `company` (
  `companyId` int(11) NOT NULL AUTO_INCREMENT,
  `companyName` varchar(100) NOT NULL,
  `companyAddress` varchar(150) DEFAULT NULL,
  `companyRegNo` varchar(45) NOT NULL,
  `companyEmail` varchar(45) DEFAULT NULL,
  `companyContact` varchar(45) DEFAULT NULL,
  `companyRegDate` varchar(45) DEFAULT NULL,
  `companyCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`companyId`, `companyRegNo`),
  UNIQUE KEY `companyRegNo_UNIQUE` (`companyRegNo`),
  UNIQUE KEY `companyName_UNIQUE` (`companyName`)
) ENGINE = InnoDB AUTO_INCREMENT = 101 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: companypayments
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `companypayments` (
  `companyPaymentsId` int(11) NOT NULL AUTO_INCREMENT,
  `companyPaymentsCredit` double(65, 2) DEFAULT '0.00',
  `companyPaymentsDebit` double(65, 2) NOT NULL DEFAULT '0.00',
  `company_companyId` int(11) NOT NULL,
  PRIMARY KEY (`companyPaymentsId`),
  KEY `fk_CompanyPayments_company1_idx` (`company_companyId`),
  CONSTRAINT `CompanyPayments_ibfk_1` FOREIGN KEY (`company_companyId`) REFERENCES `company` (`companyId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 81 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: delivery
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `delivery` (
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
) ENGINE = InnoDB AUTO_INCREMENT = 1961 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: dieselfee
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `dieselfee` (
  `dieselFeeId` int(11) NOT NULL AUTO_INCREMENT,
  `dieselFeeLiters` float DEFAULT NULL,
  PRIMARY KEY (`dieselFeeId`),
  CONSTRAINT `dieselFee_ibfk_1` FOREIGN KEY (`dieselFeeId`) REFERENCES `lorrypayments` (`paymentsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 362 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: driver
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `driver` (
  `driverLicenseNo` int(11) NOT NULL,
  `driverName` varchar(100) DEFAULT NULL,
  `driverContact` varchar(45) DEFAULT NULL,
  `driverRegDate` date DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`driverLicenseNo`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: invoice
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `invoice` (
  `invoiceId` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceCompanyId` int(11) NOT NULL,
  `invoiceRange` varchar(45) NOT NULL,
  `invoiceAmount` double(65, 2) NOT NULL,
  `invoiceCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`invoiceId`),
  KEY `invoiceCompanyId` (`invoiceCompanyId`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`invoiceCompanyId`) REFERENCES `company` (`companyId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: lorrypayments
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `lorrypayments` (
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
) ENGINE = InnoDB AUTO_INCREMENT = 541 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: paymenttype
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `paymenttype` (
  `paymentTypeId` int(11) NOT NULL,
  `paymentTypeType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`paymentTypeId`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: pettycashbook
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `pettycashbook` (
  `pettyId` int(11) NOT NULL AUTO_INCREMENT,
  `LorryPayments_paymentsId` int(11) NOT NULL,
  `pettyDate` date NOT NULL,
  PRIMARY KEY (`pettyId`),
  KEY `LorryPayments_paymentsId` (`LorryPayments_paymentsId`),
  CONSTRAINT `pettyCashBook_ibfk_1` FOREIGN KEY (`LorryPayments_paymentsId`) REFERENCES `lorrypayments` (`paymentsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 371 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rate
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `rate` (
  `rateId` int(11) NOT NULL AUTO_INCREMENT,
  `rateRange` varchar(45) DEFAULT NULL,
  `ratePrice` float DEFAULT NULL,
  PRIMARY KEY (`rateId`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: unloadingplace
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `unloadingplace` (
  `uploadingPlaceId` int(11) NOT NULL AUTO_INCREMENT,
  `uploadingPlaceAddress` varchar(100) DEFAULT NULL,
  `unloadingPlaceIncomeRate` float DEFAULT NULL,
  `company_companyId` int(11) NOT NULL,
  PRIMARY KEY (`uploadingPlaceId`),
  KEY `fk_unloadingPlace_company1_idx` (`company_companyId`),
  CONSTRAINT `fk_unloadingPlace_company1` FOREIGN KEY (`company_companyId`) REFERENCES `company` (`companyId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 301 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `Status` varchar(10) NOT NULL DEFAULT 'Inactive',
  `role` varchar(45) NOT NULL DEFAULT 'Member',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userID`)
) ENGINE = InnoDB AUTO_INCREMENT = 21 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: vehicle
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `vehicle` (
  `vehicleNumber` varchar(10) NOT NULL,
  `vehicleCapacity` varchar(10) DEFAULT NULL,
  `vehicleDeliRate` float NOT NULL,
  `vehicleRegDate` date DEFAULT NULL,
  `vehicleCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`vehicleNumber`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: cheques
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: company
# ------------------------------------------------------------

INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    1,
    'Subasingha',
    'Subassinghe Contractors (PVT) Ltd. No 294 A, Hapugalla Wakwella Gall',
    '001',
    'Subassinghe@gmail.com',
    '0771234567',
    '2020-7-5',
    '2020-07-05 10:17:18'
  );
INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    21,
    'C. M. K. Contractors',
    'C. M. K. Construction NO; 232/2, Dampitiya Estate, Thorayaya.',
    '002',
    'cmk@gmail.com',
    '0777123578',
    '2020-7-5',
    '2020-07-05 10:21:03'
  );
INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    31,
    'Edward & Cristine',
    'Edward and Christie (pvt) Ltd, Water Project, Matale.',
    '003',
    'edward&cristine@gmail.com',
    '077238207',
    '2020-7-5',
    '2020-07-05 10:25:57'
  );
INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    41,
    'HARSHANI CONSTRUCTION',
    'HARSHANI CONSTRUCTION, 70, Napana Gunnepana, Kandy, Sri Lanka.',
    '004',
    'harshani@gmail.com',
    '0762067081',
    '2020-7-5',
    '2020-07-05 10:30:55'
  );
INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    51,
    'Bright Vision (PVT) Ltd',
    'Bright Vision (PVT) Ltd. Raththota Water Projet, Raththota,',
    '005',
    'brightvision@gmail.com',
    '0772382047',
    '2020-7-5',
    '2020-07-05 10:33:42'
  );
INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    71,
    'V.V Karunarathna Company',
    'V.V Karunarathna Company, Rattota Water Project Rattota',
    '006',
    'vvkarunarathna@gmail.com',
    '0777712356',
    '2020-7-5',
    '2020-07-05 10:35:50'
  );
INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    81,
    'Extra Load',
    '',
    '007',
    '',
    '',
    '2020-7-7',
    '2020-07-07 11:34:15'
  );
INSERT INTO
  `company` (
    `companyId`,
    `companyName`,
    `companyAddress`,
    `companyRegNo`,
    `companyEmail`,
    `companyContact`,
    `companyRegDate`,
    `companyCreated`
  )
VALUES
  (
    91,
    'Chaina Company',
    '',
    '008',
    '',
    '',
    '2020-7-9',
    '2020-07-09 02:42:12'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: companypayments
# ------------------------------------------------------------

INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (1, 0.00, 0.00, 1);
INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (11, 0.00, 0.00, 21);
INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (21, 0.00, 0.00, 31);
INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (31, 0.00, 0.00, 41);
INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (41, 0.00, 0.00, 51);
INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (51, 0.00, 0.00, 71);
INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (61, 0.00, 0.00, 81);
INSERT INTO
  `companypayments` (
    `companyPaymentsId`,
    `companyPaymentsCredit`,
    `companyPaymentsDebit`,
    `company_companyId`
  )
VALUES
  (71, 0.00, 0.00, 91);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: delivery
# ------------------------------------------------------------

INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    115,
    1,
    'Accepted',
    '2020-06-01 00:00:00',
    1000,
    '17.56',
    'LJ 4653',
    191,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    227,
    13,
    'Accepted',
    '2020-06-01 00:00:00',
    1755,
    '17.44',
    'LJ 0121',
    1,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    233,
    28,
    'Accepted',
    '2020-07-06 00:00:00',
    3780,
    '16.46',
    'LJ 0121',
    201,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    234,
    28,
    'Accepted',
    '2020-07-06 00:00:00',
    3780,
    '16.46',
    'LH 7253',
    201,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    235,
    30,
    'Accepted',
    '2020-07-06 00:00:00',
    4050,
    '16.53',
    'LJ 0121',
    251,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    236,
    28,
    'Accepted',
    '2020-07-07 00:00:00',
    3780,
    '8.4',
    'LI 0430',
    251,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    237,
    28,
    'Accepted',
    '2020-07-07 00:00:00',
    3780,
    '8.4',
    'LI 0430',
    251,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    238,
    28,
    'Accepted',
    '2020-07-07 00:00:00',
    3920,
    '8.4',
    'LJ 0121',
    251,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    271,
    1,
    'Accepted',
    '2020-06-01 00:00:00',
    1000,
    '17.56',
    'LH 7253',
    191,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    273,
    1,
    'Accepted',
    '2020-06-01 00:00:00',
    1000,
    '17.56',
    'LJ 4653',
    191,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    274,
    13,
    'Accepted',
    '2020-06-01 00:00:00',
    0,
    '17.52',
    'LJ 4653',
    1,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    275,
    13,
    'Accepted',
    '2020-06-01 00:00:00',
    1755,
    '17.52',
    'LH 7253',
    1,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    276,
    13,
    'Accepted',
    '2020-06-01 00:00:00',
    1755,
    '17.52',
    'LH 7253',
    1,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    277,
    13,
    'Accepted',
    '2020-06-01 00:00:00',
    0,
    '17.52',
    'LJ 4653',
    21,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    420,
    28,
    'Accepted',
    '2020-07-07 00:00:00',
    3920,
    '8.3',
    'LJ 0121',
    241,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    421,
    28,
    'Accepted',
    '2020-07-08 00:00:00',
    3780,
    '11.14',
    'LI 0430',
    241,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    422,
    28,
    'Accepted',
    '2020-07-08 00:00:00',
    3920,
    '11.14',
    'LJ 0121',
    241,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    423,
    28,
    'Accepted',
    '2020-07-08 00:00:00',
    3920,
    '11.14',
    'LJ 0121',
    241,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    424,
    28,
    'Accepted',
    '2020-07-08 00:00:00',
    3780,
    '11.14',
    'LI 0430',
    241,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    625,
    30,
    'Accepted',
    '2020-07-06 00:00:00',
    4050,
    '16.56',
    'LI 0430',
    221,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    626,
    30,
    'Accepted',
    '2020-07-06 00:00:00',
    4050,
    '16.56',
    'LJ 0121',
    221,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    627,
    30,
    'Accepted',
    '2020-07-06 00:00:00',
    0,
    '16.56',
    'LJ 4653',
    221,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    628,
    30,
    'Accepted',
    '2020-07-06 00:00:00',
    4050,
    '16.56',
    'LI 0430',
    221,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    629,
    25,
    'Accepted',
    '2020-07-06 00:00:00',
    3375,
    '16.56',
    'LI 0430',
    231,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    630,
    25,
    'Accepted',
    '2020-07-06 00:00:00',
    0,
    '16.56',
    'LJ 4653',
    231,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    631,
    25,
    'Accepted',
    '2020-07-06 00:00:00',
    3375,
    '16.56',
    'LH 7253',
    231,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    632,
    31,
    'Accepted',
    '2020-07-07 00:00:00',
    4340,
    '8.2',
    'LH 7253',
    221,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    633,
    25,
    'Accepted',
    '2020-07-08 00:00:00',
    3500,
    '11.17',
    'LH 7253',
    231,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    634,
    25,
    'Accepted',
    '2020-07-08 00:00:00',
    3500,
    '11.17',
    'LJ 0121',
    231,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    635,
    25,
    'Accepted',
    '2020-07-08 00:00:00',
    3500,
    '11.17',
    'LH 7253',
    231,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    690,
    18,
    'Accepted',
    '2020-07-07 00:00:00',
    2520,
    '7.52',
    'LJ 0121',
    31,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    691,
    18,
    'Accepted',
    '2020-07-07 00:00:00',
    0,
    '7.52',
    'LJ 4653',
    31,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    692,
    18,
    'Accepted',
    '2020-07-07 00:00:00',
    0,
    '7.54',
    'LJ 4653',
    31,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    693,
    18,
    'Accepted',
    '2020-07-07 00:00:00',
    2520,
    '7.54',
    'LH 7253',
    31,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    694,
    0,
    'Accepted',
    '2020-07-07 00:00:00',
    0,
    '7.54',
    'LJ 4653',
    71,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    695,
    0,
    'Pending..',
    '2020-07-07 00:00:00',
    0,
    '7.54',
    'LJ 4653',
    121,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    696,
    5,
    'Pending..',
    '2020-07-07 00:00:00',
    1000,
    '7.54',
    'LH 7253',
    121,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    697,
    5,
    'Pending..',
    '2020-07-07 00:00:00',
    1000,
    '7.54',
    'LI 0430',
    121,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    698,
    5,
    'Pending..',
    '2020-07-07 00:00:00',
    0,
    '7.54',
    'LJ 4653',
    121,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    699,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    1000,
    '11.2',
    'LI 0430',
    121,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    700,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.9',
    'LJ 4653',
    121,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    701,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.9',
    'LA 7710',
    121,
    1
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    702,
    5,
    'Pending..',
    '2020-07-08 00:00:00',
    0,
    '11.9',
    'LJ 4653',
    121,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    703,
    5,
    'Pending..',
    '2020-07-08 00:00:00',
    0,
    '11.9',
    'LJ 4653',
    121,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    704,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    1000,
    '11.2',
    'LI 0430',
    121,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    705,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.2',
    'LA 7710',
    121,
    1
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    706,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    1000,
    '11.2',
    'LI 0430',
    121,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    707,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.2',
    'LJ 4653',
    121,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    708,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.2',
    'LA 7710',
    121,
    1
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    709,
    18,
    'Accepted',
    '2020-07-08 00:00:00',
    2520,
    '11.2',
    'LH 7253',
    31,
    3
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    1904,
    3,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.19',
    'LA 7710',
    211,
    1
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    1955,
    10,
    'Accepted',
    '2020-07-06 00:00:00',
    0,
    '17.5',
    'LJ 4653',
    281,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    1956,
    5,
    'Pending..',
    '2020-07-07 00:00:00',
    1000,
    '8.13',
    'LJ 0121',
    291,
    4
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    1957,
    5,
    'Pending..',
    '2020-07-07 00:00:00',
    0,
    '8.13',
    'LJ 4653',
    291,
    2
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    1958,
    5,
    'Pending..',
    '2020-07-07 00:00:00',
    1000,
    '8.13',
    'LI 0430',
    291,
    5
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    1959,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.13',
    'LA 7710',
    291,
    1
  );
INSERT INTO
  `delivery` (
    `deliveryNoteNO`,
    `deliveryDistance`,
    `deliveryAcceptance`,
    `deliveryDate`,
    `deliveryPayment`,
    `deliveryDepartureTime`,
    `vehicle_vehicleNumber`,
    `uploadingPlace_uploadingPlaceId`,
    `driver_driverLicenseNo`
  )
VALUES
  (
    1960,
    5,
    'Accepted',
    '2020-07-08 00:00:00',
    0,
    '11.13',
    'LJ 4653',
    291,
    2
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dieselfee
# ------------------------------------------------------------

INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (111, 52.63);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (121, 52.63);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (141, 52.63);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (241, 147.36);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (251, 147.36);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (261, 147.36);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (271, 147.36);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (281, 15.78);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (291, 18.94);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (301, 18.94);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (341, 218.94);
INSERT INTO
  `dieselfee` (`dieselFeeId`, `dieselFeeLiters`)
VALUES
  (361, 147.36);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: driver
# ------------------------------------------------------------

INSERT INTO
  `driver` (
    `driverLicenseNo`,
    `driverName`,
    `driverContact`,
    `driverRegDate`,
    `created`
  )
VALUES
  (
    1,
    'Garmini',
    '0771235789',
    '2020-07-05',
    '2020-07-05 10:54:00'
  );
INSERT INTO
  `driver` (
    `driverLicenseNo`,
    `driverName`,
    `driverContact`,
    `driverRegDate`,
    `created`
  )
VALUES
  (
    2,
    'Damith',
    '0765793412',
    '2020-07-05',
    '2020-07-05 10:55:35'
  );
INSERT INTO
  `driver` (
    `driverLicenseNo`,
    `driverName`,
    `driverContact`,
    `driverRegDate`,
    `created`
  )
VALUES
  (
    3,
    'Jayasuriya',
    '0778019796',
    '2020-07-05',
    '2020-07-05 10:56:31'
  );
INSERT INTO
  `driver` (
    `driverLicenseNo`,
    `driverName`,
    `driverContact`,
    `driverRegDate`,
    `created`
  )
VALUES
  (
    4,
    'Ajith',
    '0773130688',
    '2020-07-05',
    '2020-07-05 10:57:12'
  );
INSERT INTO
  `driver` (
    `driverLicenseNo`,
    `driverName`,
    `driverContact`,
    `driverRegDate`,
    `created`
  )
VALUES
  (
    5,
    'Runga',
    '0777777777',
    '2020-07-05',
    '2020-07-05 10:57:56'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: invoice
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: lorrypayments
# ------------------------------------------------------------

INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    111,
    5000,
    'Company Diesel Enter',
    '2020-07-06',
    '2020-07-08 02:18:37',
    5,
    'LJ 0121'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    121,
    5000,
    'Company Diesel Enter',
    '2020-07-06',
    '2020-07-08 02:19:57',
    5,
    'LI 0430'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    141,
    5000,
    'Company Diesel Enter',
    '2020-07-06',
    '2020-07-08 02:23:10',
    5,
    'LH 7253'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    151,
    400,
    'Day Advanced',
    '2020-07-06',
    '2020-07-08 02:24:21',
    1,
    'LJ 0121'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    171,
    400,
    'Day Advanced',
    '2020-07-06',
    '2020-07-08 02:26:01',
    1,
    'LH 7253'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    181,
    3000,
    'Repair',
    '2020-07-06',
    '2020-07-08 02:27:10',
    2,
    'LH 7253'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    191,
    1250,
    'Engine oil 3L',
    '2020-07-06',
    '2020-07-08 02:29:58',
    2,
    'LJ 4653'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    211,
    550,
    'Nut & Bolt',
    '2020-07-08',
    '2020-07-08 02:35:35',
    2,
    'Machine'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    241,
    14000,
    ' Subasingha Diesel Suppaly',
    '2020-07-07',
    '2020-07-09 02:51:31',
    5,
    'LJ 0121'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    251,
    14000,
    ' Subasingha Diesel Suppaly',
    '2020-07-07',
    '2020-07-09 02:51:59',
    5,
    'LJ 4653'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    261,
    14000,
    ' Subasingha Diesel Suppaly',
    '2020-07-07',
    '2020-07-09 02:52:21',
    5,
    'LI 0430'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    271,
    14000,
    ' Subasingha Diesel Suppaly',
    '2020-07-07',
    '2020-07-09 02:52:30',
    5,
    'LA 7710'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    281,
    1500,
    'Company Diesel Suppaly',
    '2020-07-07',
    '2020-07-09 02:53:41',
    5,
    'LJ 0121'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    291,
    1800,
    'Company Diesel Supply',
    '2020-07-07',
    '2020-07-09 02:54:22',
    5,
    'LJ 4653'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    301,
    1800,
    'Company Diesel Supply',
    '2020-07-07',
    '2020-07-09 02:54:40',
    5,
    'LI 0430'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    311,
    400,
    'Day Advanced',
    '2020-07-07',
    '2020-07-09 02:56:15',
    1,
    'LH 7253'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    321,
    400,
    'Day Advanced',
    '2020-07-07',
    '2020-07-09 02:56:37',
    1,
    'LJ 0121'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    341,
    20800,
    'Diesel',
    '2020-07-07',
    '2020-07-09 02:58:10',
    5,
    'Machine'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    361,
    14000,
    'Subasinghe Diesel Supply',
    '2020-07-07',
    '2020-07-09 03:04:13',
    5,
    'LH 7253'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    371,
    400,
    'Day Advanced',
    '2020-07-06',
    '2020-07-09 03:13:00',
    1,
    'Damith'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    381,
    400,
    'Day Advanced',
    '2020-07-07',
    '2020-07-09 03:13:17',
    1,
    'Damith'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    391,
    400,
    'Day Advanced',
    '2020-07-06',
    '2020-07-09 03:14:05',
    1,
    'Chuttan'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    401,
    400,
    'Day Advanced',
    '2020-07-07',
    '2020-07-09 03:14:14',
    1,
    'Chuttan'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    411,
    400,
    'Day Advanced',
    '2020-07-06',
    '2020-07-09 03:14:33',
    1,
    'Kasun'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    421,
    400,
    'Day Advanced',
    '2020-07-07',
    '2020-07-09 03:14:45',
    1,
    'Kasun'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    431,
    550,
    'Nut & Bolte',
    '2020-07-06',
    '2020-07-09 03:16:17',
    2,
    'Machine'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    441,
    2300,
    'Gier oil',
    '2020-07-06',
    '2020-07-09 03:16:48',
    2,
    'Machine'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    451,
    15000,
    'Salary',
    '2020-07-06',
    '2020-07-09 05:28:44',
    4,
    'Damith'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    461,
    10000,
    'Salary',
    '2020-07-06',
    '2020-07-09 05:29:13',
    4,
    'Kasun'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    471,
    12000,
    'Sallary',
    '2020-07-07',
    '2020-07-09 05:31:29',
    4,
    'Chuttan'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    491,
    400,
    'Day Advanced',
    '2020-07-08',
    '2020-07-09 05:52:29',
    1,
    'Damith'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    501,
    400,
    'Day Advanced',
    '2020-07-08',
    '2020-07-09 05:52:48',
    1,
    'Garmini'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    511,
    400,
    'Day Advanced',
    '2020-07-08',
    '2020-07-09 05:53:07',
    1,
    'LH 7253'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    521,
    300,
    'Side Mirrer',
    '2020-07-08',
    '2020-07-09 05:54:00',
    2,
    'LA 7710'
  );
INSERT INTO
  `lorrypayments` (
    `paymentsId`,
    `paymentsAmount`,
    `paymentsDescription`,
    `paymentsDate`,
    `created`,
    `paymentType_paymentTypeId`,
    `vehicle_vehicleNumber`
  )
VALUES
  (
    531,
    400,
    'Day Adwancsed',
    '2020-07-08',
    '2020-07-09 05:54:41',
    1,
    'Chuttan'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: paymenttype
# ------------------------------------------------------------

INSERT INTO
  `paymenttype` (`paymentTypeId`, `paymentTypeType`)
VALUES
  (1, 'Day Advance');
INSERT INTO
  `paymenttype` (`paymentTypeId`, `paymentTypeType`)
VALUES
  (2, 'Maintain');
INSERT INTO
  `paymenttype` (`paymentTypeId`, `paymentTypeType`)
VALUES
  (3, 'Delivery Fee');
INSERT INTO
  `paymenttype` (`paymentTypeId`, `paymentTypeType`)
VALUES
  (4, 'Finance');
INSERT INTO
  `paymenttype` (`paymentTypeId`, `paymentTypeType`)
VALUES
  (5, 'Diesel');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pettycashbook
# ------------------------------------------------------------

INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (1, 111, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (11, 121, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (31, 141, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (41, 151, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (61, 171, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (71, 181, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (81, 191, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (101, 211, '2020-07-08');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (131, 281, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (141, 291, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (151, 301, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (161, 311, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (171, 321, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (191, 341, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (211, 371, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (221, 381, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (231, 391, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (241, 401, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (251, 411, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (261, 421, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (271, 431, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (281, 441, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (291, 451, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (301, 461, '2020-07-06');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (311, 471, '2020-07-07');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (321, 491, '2020-07-08');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (331, 501, '2020-07-08');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (341, 511, '2020-07-08');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (351, 521, '2020-07-08');
INSERT INTO
  `pettycashbook` (`pettyId`, `LorryPayments_paymentsId`, `pettyDate`)
VALUES
  (361, 531, '2020-07-08');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rate
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: unloadingplace
# ------------------------------------------------------------

INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (1, 'Akurambada', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (21, 'Paldeniya', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (31, 'Matale Yard', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (41, 'Madawala', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (61, 'Madawala', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (71, 'Katawala', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (81, 'Delgolla', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (91, 'Nikagolla', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (101, 'Mahawela', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (111, 'Pallepola', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (121, 'Rajgammana', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (131, 'koholanwala', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (141, 'Noth Matale', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (151, 'Mahameunawa', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (161, 'Ambokka', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (171, 'Walmoruwa', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (181, 'Galaliyadda', 2500, 1);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (191, 'Koholanwala', 2500, 21);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (201, 'Rattota Town', 3000, 31);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (211, 'Noth Matale', 2500, 41);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (221, 'Babarakirialla', 3000, 51);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (231, 'Weragama', 3000, 51);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (241, 'Rattota Yard', 3000, 71);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (251, 'Raithalawela', 3000, 31);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (261, 'Babarakirialla', 3000, 51);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (271, 'Weragama', 3000, 51);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (281, 'Palapathwala', 2333.33, 81);
INSERT INTO
  `unloadingplace` (
    `uploadingPlaceId`,
    `uploadingPlaceAddress`,
    `unloadingPlaceIncomeRate`,
    `company_companyId`
  )
VALUES
  (291, 'Rajgammana', 2500, 91);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user
# ------------------------------------------------------------

INSERT INTO
  `user` (
    `userID`,
    `first_name`,
    `last_name`,
    `email`,
    `password`,
    `Status`,
    `role`,
    `created`
  )
VALUES
  (
    1,
    'admin',
    '',
    'admin@soiltransport.com',
    '$2b$10$Y6RWkhFGiazDg9gLjWvIzeaTY1XaJdN97Sifzr4ITGnn/9/1AQKQe',
    'Active',
    'Admin',
    '2020-06-28 06:17:27'
  );
INSERT INTO
  `user` (
    `userID`,
    `first_name`,
    `last_name`,
    `email`,
    `password`,
    `Status`,
    `role`,
    `created`
  )
VALUES
  (
    11,
    'test',
    '',
    'test@gmail.com',
    '$2b$10$p5T54nwChVkb4bodLVJzHu1xT59W69k5dcj0e897nlBjJ6gcyvMKO',
    'Active',
    'Member',
    '2020-07-05 01:14:26'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: vehicle
# ------------------------------------------------------------

INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  ('ASHEN', '', 0, '2020-07-09', '2020-07-09 03:09:00');
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'Chuttan',
    '',
    0,
    '2020-07-09',
    '2020-07-09 03:08:23'
  );
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  ('Damith', '', 0, '2020-07-09', '2020-07-09 03:08:08');
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'Garmini',
    '',
    0,
    '2020-07-09',
    '2020-07-09 03:08:33'
  );
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  ('Kasun', '', 0, '2020-07-09', '2020-07-09 03:08:43');
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'LA 7710',
    '03',
    0,
    '2020-07-05',
    '2020-07-05 10:38:19'
  );
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'LH 7253',
    '03',
    140,
    '2020-07-05',
    '2020-07-05 10:39:04'
  );
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'LI 0430',
    '03',
    135,
    '2020-07-05',
    '2020-07-05 10:40:02'
  );
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'LJ 0121',
    '03',
    140,
    '2020-07-05',
    '2020-07-05 10:39:24'
  );
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'LJ 4653',
    '3',
    0,
    '2020-07-05',
    '2020-07-05 12:22:19'
  );
INSERT INTO
  `vehicle` (
    `vehicleNumber`,
    `vehicleCapacity`,
    `vehicleDeliRate`,
    `vehicleRegDate`,
    `vehicleCreated`
  )
VALUES
  (
    'Machine',
    '',
    0,
    '2020-07-08',
    '2020-07-08 02:33:55'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

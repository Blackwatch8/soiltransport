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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: dieselfee
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `dieselfee` (
  `dieselFeeId` int(11) NOT NULL AUTO_INCREMENT,
  `dieselFeeLiters` float DEFAULT NULL,
  PRIMARY KEY (`dieselFeeId`),
  CONSTRAINT `dieselFee_ibfk_1` FOREIGN KEY (`dieselFeeId`) REFERENCES `lorrypayments` (`paymentsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = latin1;

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


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: companypayments
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: delivery
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dieselfee
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: driver
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: invoice
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: lorrypayments
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: paymenttype
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pettycashbook
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rate
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: unloadingplace
# ------------------------------------------------------------


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

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: vehicle
# ------------------------------------------------------------


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

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
) ENGINE = InnoDB AUTO_INCREMENT = 81 DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB AUTO_INCREMENT = 61 DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB AUTO_INCREMENT = 278 DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB AUTO_INCREMENT = 251 DEFAULT CHARSET = utf8;

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

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dieselfee
# ------------------------------------------------------------


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
    135,
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
    135,
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

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

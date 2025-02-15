-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SERV
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SERV` ;

-- -----------------------------------------------------
-- Schema SERV
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SERV` DEFAULT CHARACTER SET koi8r ;
USE `SERV` ;

-- -----------------------------------------------------
-- Table `SERV`.`SERVGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`SERVGroup` ;

CREATE TABLE IF NOT EXISTS `SERV`.`SERVGroup` (
  `GroupID` INT NOT NULL AUTO_INCREMENT,
  `Group` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`GroupID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Member` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Member` (
  `MemberID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `JoinDate` DATETIME NULL,
  `EmailAddress` VARCHAR(60) NOT NULL,
  `MobileNumber` VARCHAR(12) NOT NULL,
  `HomeNumber` VARCHAR(12) NULL,
  `Occupation` VARCHAR(45) NULL,
  `MemberStatusID` INT NOT NULL,
  `AvailabilityID` INT NULL,
  `RiderAssesmentPassDate` DATETIME NULL,
  `AdQualPassDate` DATETIME NULL,
  `AdQualType` VARCHAR(15) NULL,
  `BikeType` VARCHAR(45) NULL,
  `CarType` VARCHAR(45) NULL,
  `Notes` VARCHAR(400) NULL,
  `Address1` VARCHAR(45) NULL,
  `Address2` VARCHAR(45) NULL,
  `Address3` VARCHAR(45) NULL,
  `Town` VARCHAR(45) NULL,
  `County` VARCHAR(45) NULL,
  `PostCode` VARCHAR(10) NULL,
  `BirthYear` INT NULL,
  `NextOfKin` VARCHAR(80) NULL,
  `NextOfKinAddress` VARCHAR(200) NULL,
  `NextOfKinPhone` VARCHAR(45) NULL,
  `LegalConfirmation` TINYINT(1) NULL,
  `LeaveDate` DATETIME NULL,
  `LastGDPGMPDate` DATETIME NULL,
  `OnDuty` TINYINT(1) NULL,
  `LastLat` VARCHAR(45) NULL,
  `LastLng` VARCHAR(45) NULL,
  `GroupID` INT NOT NULL,
  `SystemController` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`MemberID`),
  INDEX `fk_Member_SERVGroup1_idx` (`GroupID` ASC),
  CONSTRAINT `fk_Member_SERVGroup1`
    FOREIGN KEY (`GroupID`)
    REFERENCES `SERV`.`SERVGroup` (`GroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`UserLevel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`UserLevel` ;

CREATE TABLE IF NOT EXISTS `SERV`.`UserLevel` (
  `UserLevelID` INT NOT NULL AUTO_INCREMENT,
  `UserLevel` VARCHAR(45) NULL,
  PRIMARY KEY (`UserLevelID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`User` ;

CREATE TABLE IF NOT EXISTS `SERV`.`User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `MemberID` INT NOT NULL,
  `UserLevelID` INT NOT NULL,
  `PasswordHash` VARCHAR(45) NOT NULL,
  `LastLoginDate` TIMESTAMP NULL,
  PRIMARY KEY (`UserID`),
  INDEX `fk_User_Member_idx` (`MemberID` ASC),
  INDEX `fk_User_UserLevel1_idx` (`UserLevelID` ASC),
  CONSTRAINT `fk_User_Member`
    FOREIGN KEY (`MemberID`)
    REFERENCES `SERV`.`Member` (`MemberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_UserLevel1`
    FOREIGN KEY (`UserLevelID`)
    REFERENCES `SERV`.`UserLevel` (`UserLevelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Availability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Availability` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Availability` (
  `AvailabilityID` INT NOT NULL,
  `DayNo` INT NULL,
  `EveningNo` INT NULL,
  `Available` TINYINT(1) NULL,
  PRIMARY KEY (`AvailabilityID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`MessageType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`MessageType` ;

CREATE TABLE IF NOT EXISTS `SERV`.`MessageType` (
  `MessageTypeID` INT NOT NULL AUTO_INCREMENT,
  `MessageType` VARCHAR(45) NULL,
  PRIMARY KEY (`MessageTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Message` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Message` (
  `MessageID` INT NOT NULL AUTO_INCREMENT,
  `SenderUserID` INT NOT NULL,
  `SentDate` DATETIME NOT NULL,
  `Recipient` VARCHAR(4000) NOT NULL,
  `Message` VARCHAR(1000) NOT NULL,
  `RecipientMemberID` INT NULL,
  `MessageTypeID` INT NOT NULL,
  PRIMARY KEY (`MessageID`),
  INDEX `fk_Message_MessageType1_idx` (`MessageTypeID` ASC),
  INDEX `fk_Message_User1_idx` (`SenderUserID` ASC),
  CONSTRAINT `fk_Message_MessageType1`
    FOREIGN KEY (`MessageTypeID`)
    REFERENCES `SERV`.`MessageType` (`MessageTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_User1`
    FOREIGN KEY (`SenderUserID`)
    REFERENCES `SERV`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`MemberStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`MemberStatus` ;

CREATE TABLE IF NOT EXISTS `SERV`.`MemberStatus` (
  `MemberStatusID` INT NOT NULL AUTO_INCREMENT,
  `MemberStatus` VARCHAR(45) NULL,
  PRIMARY KEY (`MemberStatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Tag` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Tag` (
  `TagID` INT NOT NULL AUTO_INCREMENT,
  `Tag` VARCHAR(45) NULL,
  PRIMARY KEY (`TagID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Member_Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Member_Tag` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Member_Tag` (
  `MemberID` INT NOT NULL,
  `TagID` INT NOT NULL,
  INDEX `fk_Member_Capability_Member1_idx` (`MemberID` ASC),
  INDEX `fk_Member_Capability_Capability1_idx` (`TagID` ASC),
  CONSTRAINT `fk_Member_Capability_Member1`
    FOREIGN KEY (`MemberID`)
    REFERENCES `SERV`.`Member` (`MemberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Member_Capability_Capability1`
    FOREIGN KEY (`TagID`)
    REFERENCES `SERV`.`Tag` (`TagID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Location` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Location` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `Location` VARCHAR(45) NULL,
  `Lat` VARCHAR(45) NULL,
  `Lng` VARCHAR(45) NULL,
  `PostCode` VARCHAR(45) NULL,
  `Hospital` TINYINT(1) NOT NULL DEFAULT false,
  `Changeover` TINYINT(1) NOT NULL DEFAULT false,
  `BloodBank` TINYINT(1) NOT NULL DEFAULT false,
  `InNetwork` TINYINT(1) NOT NULL DEFAULT 0,
  `Enabled` TINYINT(1) NOT NULL DEFAULT true,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`RawRunLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`RawRunLog` ;

CREATE TABLE IF NOT EXISTS `SERV`.`RawRunLog` (
  `RawRunLogID` INT NOT NULL AUTO_INCREMENT,
  `CallDate` DATETIME NULL,
  `CallTime` VARCHAR(45) NULL,
  `Destination` VARCHAR(45) NULL,
  `CollectFrom` VARCHAR(45) NULL,
  `CollectTime` VARCHAR(45) NULL,
  `DeliveryTime` VARCHAR(45) NULL,
  `Consignment` VARCHAR(45) NULL,
  `Urgency` VARCHAR(45) NULL,
  `Controller` VARCHAR(45) NULL,
  `Rider` VARCHAR(45) NULL,
  `Notes` VARCHAR(2000) NULL,
  `CollectTime2` VARCHAR(45) NULL,
  `Vehicle` VARCHAR(45) NULL,
  PRIMARY KEY (`RawRunLogID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Product` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Product` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `Product` VARCHAR(100) NOT NULL,
  `Enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`VehicleType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`VehicleType` ;

CREATE TABLE IF NOT EXISTS `SERV`.`VehicleType` (
  `VehicleTypeID` INT NOT NULL AUTO_INCREMENT,
  `VehicleType` VARCHAR(45) NULL,
  `Enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`VehicleTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`RunLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`RunLog` ;

CREATE TABLE IF NOT EXISTS `SERV`.`RunLog` (
  `RunLogID` INT NOT NULL AUTO_INCREMENT,
  `CreatedByUserID` INT NOT NULL,
  `CreateDate` TIMESTAMP NOT NULL,
  `DutyDate` DATETIME NULL,
  `CallDateTime` DATETIME NULL,
  `CollectionLocationID` INT NOT NULL,
  `AcceptedDateTime` DATETIME NULL,
  `CollectDateTime` DATETIME NULL,
  `DeliverDateTime` DATETIME NULL,
  `FinalDestinationLocationID` INT NOT NULL,
  `ControllerMemberID` INT NOT NULL,
  `Urgency` INT NOT NULL,
  `IsTransfer` TINYINT(1) NOT NULL DEFAULT 0,
  `VehicleTypeID` INT NULL,
  `Notes` VARCHAR(600) NULL,
  `OriginLocationID` INT NOT NULL,
  `CallFromLocationID` INT NOT NULL,
  `RiderMemberID` INT NULL,
  `DeliverToLocationID` INT NOT NULL,
  `HomeSafeDateTime` DATETIME NULL,
  `Boxes` INT NOT NULL DEFAULT 0,
  `Description` VARCHAR(300) NULL,
  `CallerNumber` VARCHAR(20) NULL,
  `CallerExt` VARCHAR(10) NULL,
  PRIMARY KEY (`RunLogID`),
  INDEX `fk_RunLog_VehicleType1_idx` (`VehicleTypeID` ASC),
  INDEX `fk_RunLog_User1_idx` (`CreatedByUserID` ASC),
  INDEX `fk_RunLog_Member1_idx` (`RiderMemberID` ASC),
  INDEX `fk_RunLog_Location1_idx` (`DeliverToLocationID` ASC),
  INDEX `CallDateTime` (`CallDateTime` ASC),
  CONSTRAINT `fk_RunLog_VehicleType1`
    FOREIGN KEY (`VehicleTypeID`)
    REFERENCES `SERV`.`VehicleType` (`VehicleTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RunLog_User1`
    FOREIGN KEY (`CreatedByUserID`)
    REFERENCES `SERV`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RunLog_Member1`
    FOREIGN KEY (`RiderMemberID`)
    REFERENCES `SERV`.`Member` (`MemberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RunLog_Location1`
    FOREIGN KEY (`DeliverToLocationID`)
    REFERENCES `SERV`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`RunLog_Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`RunLog_Product` ;

CREATE TABLE IF NOT EXISTS `SERV`.`RunLog_Product` (
  `RunLog_ProductID` INT NOT NULL AUTO_INCREMENT,
  `RunLogID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `Quantity` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`RunLog_ProductID`),
  INDEX `fk_RunLog_Product_Product1_idx` (`ProductID` ASC),
  INDEX `fk_RunLog_Product_RunLog1_idx` (`RunLogID` ASC),
  CONSTRAINT `fk_RunLog_Product_Product1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `SERV`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RunLog_Product_RunLog1`
    FOREIGN KEY (`RunLogID`)
    REFERENCES `SERV`.`RunLog` (`RunLogID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Karma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Karma` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Karma` (
  `KarmaID` INT NOT NULL AUTO_INCREMENT,
  `AllocationDateTime` TIMESTAMP NOT NULL,
  `MemberID` INT NOT NULL,
  `Reason` VARCHAR(100) NOT NULL,
  `Points` INT NOT NULL,
  PRIMARY KEY (`KarmaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Calendar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Calendar` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Calendar` (
  `CalendarID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `SimpleCalendar` TINYINT(1) NOT NULL DEFAULT 1,
  `SimpleDaysIncrement` INT NULL DEFAULT 14 COMMENT 'For simple calendars this is the number of days before the member gets rotad again.\n\n14 means you get a shift every other week.',
  `SequentialDayCount` INT NULL COMMENT 'If a simple calendar and Simple days increment is null, then the auto scheduler will assign the member x days in a row on the calendar.  Allows for controllers doing 7 days in a row as AA controller.\n',
  `VolunteerRemainsFree` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'If set to 1 it means the member can be scheduled for another calendar where its set to one as well.\n\n1+1 == OK.  1+0 || 0+1 == not ok',
  `RequiredTagID` INT NOT NULL COMMENT 'In order to be scheduled on this calendar, or volunteer for a shift, the ember must have this tag.',
  `DefaultRequirement` INT NOT NULL DEFAULT 4 COMMENT 'If not overridden in CalendarRequirements the system will try to achieve this number of volunteers per night',
  `SortOrder` INT NULL DEFAULT 0,
  `LastGenerated` DATETIME NULL,
  `GeneratedUpTo` DATE NULL,
  `GroupID` INT NOT NULL,
  PRIMARY KEY (`CalendarID`),
  INDEX `fk_Calendar_SERVGroup1_idx` (`GroupID` ASC),
  CONSTRAINT `fk_Calendar_SERVGroup1`
    FOREIGN KEY (`GroupID`)
    REFERENCES `SERV`.`SERVGroup` (`GroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`CalendarEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`CalendarEntry` ;

CREATE TABLE IF NOT EXISTS `SERV`.`CalendarEntry` (
  `CalendarEntryID` INT NOT NULL AUTO_INCREMENT,
  `CreateDateTime` TIMESTAMP NOT NULL,
  `CalendarID` INT NOT NULL,
  `EntryDate` DATE NOT NULL,
  `MemberID` INT NOT NULL,
  `CoverNeeded` TINYINT(1) NOT NULL DEFAULT 0,
  `CoverCalendarEntryID` INT NULL,
  `AdHoc` TINYINT(1) NOT NULL DEFAULT 0,
  `ManuallyAdded` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`CalendarEntryID`),
  INDEX `fk_CalendarEntry_Calendar1_idx` (`CalendarID` ASC),
  INDEX `fk_CalendarEntry_Member1_idx` (`MemberID` ASC),
  INDEX `EntryDate` (`EntryDate` ASC),
  INDEX `EntryDateCalID` (`CalendarID` ASC, `EntryDate` ASC),
  CONSTRAINT `fk_CalendarEntry_Calendar1`
    FOREIGN KEY (`CalendarID`)
    REFERENCES `SERV`.`Calendar` (`CalendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CalendarEntry_Member1`
    FOREIGN KEY (`MemberID`)
    REFERENCES `SERV`.`Member` (`MemberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`CalendarRequirements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`CalendarRequirements` ;

CREATE TABLE IF NOT EXISTS `SERV`.`CalendarRequirements` (
  `CalendarRequirementsID` INT NOT NULL AUTO_INCREMENT,
  `CalendarID` INT NOT NULL,
  `DayOfWeek` INT NOT NULL,
  `NumberNeeded` INT NOT NULL,
  PRIMARY KEY (`CalendarRequirementsID`),
  INDEX `fk_CalendarRequirements_Calendar1_idx` (`CalendarID` ASC),
  CONSTRAINT `fk_CalendarRequirements_Calendar1`
    FOREIGN KEY (`CalendarID`)
    REFERENCES `SERV`.`Calendar` (`CalendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`Member_Calendar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`Member_Calendar` ;

CREATE TABLE IF NOT EXISTS `SERV`.`Member_Calendar` (
  `Member_CalendarID` INT NOT NULL AUTO_INCREMENT,
  `MemberID` INT NOT NULL,
  `CalendarID` INT NOT NULL,
  `SetDayNo` INT NULL COMMENT 'The day of the week number the volunteer is rotad for \n\nMonday == 0',
  `Week` CHAR(1) NULL COMMENT 'Week 0 or week 1.  Allows every week of the year to be either week 1 or week 0\n\n30th December 2013 = Start of week 0',
  `RecurrenceInterval` INT NULL,
  INDEX `fk_Member_Calendar_Member1_idx` (`MemberID` ASC),
  INDEX `fk_Member_Calendar_Calendar1_idx` (`CalendarID` ASC),
  PRIMARY KEY (`Member_CalendarID`),
  UNIQUE INDEX `UniqueMemberCalDayWeek` (`MemberID` ASC, `CalendarID` ASC, `SetDayNo` ASC, `Week` ASC),
  CONSTRAINT `fk_Member_Calendar_Member1`
    FOREIGN KEY (`MemberID`)
    REFERENCES `SERV`.`Member` (`MemberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Member_Calendar_Calendar1`
    FOREIGN KEY (`CalendarID`)
    REFERENCES `SERV`.`Calendar` (`CalendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`MemberRejectedRun`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`MemberRejectedRun` ;

CREATE TABLE IF NOT EXISTS `SERV`.`MemberRejectedRun` (
  `MemberID` INT NOT NULL,
  `RunLogID` INT NOT NULL,
  INDEX `fk_MemberRejectedRun_Member1_idx` (`MemberID` ASC),
  INDEX `fk_MemberRejectedRun_RunLog1_idx` (`RunLogID` ASC),
  CONSTRAINT `fk_MemberRejectedRun_Member1`
    FOREIGN KEY (`MemberID`)
    REFERENCES `SERV`.`Member` (`MemberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MemberRejectedRun_RunLog1`
    FOREIGN KEY (`RunLogID`)
    REFERENCES `SERV`.`RunLog` (`RunLogID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`RunRejectionReason`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`RunRejectionReason` ;

CREATE TABLE IF NOT EXISTS `SERV`.`RunRejectionReason` (
  `RunRejectionReasonID` INT NOT NULL AUTO_INCREMENT,
  `Reason` VARCHAR(45) NULL,
  PRIMARY KEY (`RunRejectionReasonID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERV`.`SystemSetting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SERV`.`SystemSetting` ;

CREATE TABLE IF NOT EXISTS `SERV`.`SystemSetting` (
  `SystemSettingID` INT NOT NULL AUTO_INCREMENT,
  `SettingName` VARCHAR(45) NOT NULL,
  `Value` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`SystemSettingID`))
ENGINE = InnoDB;

USE `SERV` ;

-- -----------------------------------------------------
-- procedure LastMonthRunStats
-- -----------------------------------------------------

USE `SERV`;
DROP procedure IF EXISTS `SERV`.`LastMonthRunStats`;

DELIMITER $$
USE `SERV`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LastMonthRunStats`()
BEGIN
SET @FROMDATE= date_format((date_sub(CURRENT_DATE, INTERVAL 1 MONTH)), '%Y-%m-01 00:00:00');
SET @TODATE= date_format(CURRENT_DATE, '%Y-%m-01 00:00:00');

select sum(rlp.Quantity) into @BLOOD from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 1;

select sum(rlp.Quantity) into @PLATELETS from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 2;

select sum(rlp.Quantity) into @PLASMA from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 3;

select sum(rlp.Quantity) into @SAMPLE from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 4;

select sum(rlp.Quantity) into @MILK from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 5;

select sum(rlp.Quantity) into @AA from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID in (7,8,9,10,11,12,13);

select sum(rlp.Quantity) into @PACKAGE from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 16;

select count(*) into @RUNS from RunLog where RiderMemberID is not null and DutyDate > @FROMDATE and DutyDate < @TODATE;

select concat(monthname(@FROMDATE), ' ', year(@FROMDATE)) as Month, 
@RUNS as 'Total Runs', @BLOOD as 'Blood Boxes', 
@PLATELETS as 'Platelet Boxes', @PLASMA as 'Plasma Boxes', @SAMPLE as 'Samples', @MILK as 'Milk', @AA as 'AA Boxes', 
@PACKAGE as 'Packages';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ThisMonthRunStats
-- -----------------------------------------------------

USE `SERV`;
DROP procedure IF EXISTS `SERV`.`ThisMonthRunStats`;

DELIMITER $$
USE `SERV`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ThisMonthRunStats`()
BEGIN
SET @TODATE= date_format((date_add(CURRENT_DATE, INTERVAL 1 MONTH)), '%Y-%m-01 00:00:00');
SET @FROMDATE= date_format(CURRENT_DATE, '%Y-%m-01 00:00:00');

select sum(rlp.Quantity) into @BLOOD from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 1;

select sum(rlp.Quantity) into @PLATELETS from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 2;

select sum(rlp.Quantity) into @PLASMA from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 3;

select sum(rlp.Quantity) into @SAMPLE from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 4;

select sum(rlp.Quantity) into @MILK from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 5;

select sum(rlp.Quantity) into @AA from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID in (7,8,9,10,11,12,13);

select sum(rlp.Quantity) into @PACKAGE from RunLog rl
join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID
where rl.RiderMemberID is not null and rl.DutyDate >= @FROMDATE and rl.DutyDate < @TODATE and rlp.productID = 16;

select count(*) into @RUNS from RunLog where RiderMemberID is not null and DutyDate > @FROMDATE and DutyDate < @TODATE;

select concat(monthname(@FROMDATE), ' ', year(@FROMDATE)) as Month, 
@RUNS as 'Total Runs', @BLOOD as 'Blood Boxes', 
@PLATELETS as 'Platelet Boxes', @PLASMA as 'Plasma Boxes', @SAMPLE as 'Samples', @MILK as 'Milk', @AA as 'AA Boxes', 
@PACKAGE as 'Packages';
END$$

DELIMITER ;
SET SQL_MODE = '';
GRANT USAGE ON *.* TO localweb@localhost;
 DROP USER localweb@localhost;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'localweb'@'localhost' IDENTIFIED BY 'Tooting2Hooley';

GRANT LOCK TABLES ON SERV.* TO 'localweb'@'localhost';
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE SERV.* TO 'localweb'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `SERV`.`SERVGroup`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`SERVGroup` (`GroupID`, `Group`) VALUES (1, 'SERV DEMO Group');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`Member`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Super', 'User', '2011-01-01', 'admin@servsystem.org', '07429386911', NULL, 'Developer', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RH69SD', 1980, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Louis', 'Lane', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Peter', 'Parker', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Stanley', 'Stroman', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Brendon', 'Bodden', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Zackary', 'Zawislak', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Jerrod', 'Junk', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Wilber', 'Welles', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Henry', 'Taylor', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Edward', 'Phillips', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Ernest', 'Patterson', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Norma', 'Kelly', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Beverly', 'James', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Charles', 'Martin', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Donna', 'Cox', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`) VALUES (DEFAULT, 'Bonnie', 'Lopez', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`UserLevel`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`UserLevel` (`UserLevelID`, `UserLevel`) VALUES (DEFAULT, 'Volunteer');
INSERT INTO `SERV`.`UserLevel` (`UserLevelID`, `UserLevel`) VALUES (DEFAULT, 'Controller');
INSERT INTO `SERV`.`UserLevel` (`UserLevelID`, `UserLevel`) VALUES (DEFAULT, 'Committee');
INSERT INTO `SERV`.`UserLevel` (`UserLevelID`, `UserLevel`) VALUES (DEFAULT, 'Admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 1, 4, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 2, 1, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 3, 1, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 4, 1, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 5, 1, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 6, 1, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 7, 1, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 8, 1, '', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 9, 1, ' ', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 10, 1, ' ', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 11, 1, ' ', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 12, 1, ' ', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 13, 1, ' ', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 14, 1, ' ', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 15, 1, ' ', NULL);
INSERT INTO `SERV`.`User` (`UserID`, `MemberID`, `UserLevelID`, `PasswordHash`, `LastLoginDate`) VALUES (DEFAULT, 16, 1, ' ', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`MessageType`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`MessageType` (`MessageTypeID`, `MessageType`) VALUES (DEFAULT, 'Email');
INSERT INTO `SERV`.`MessageType` (`MessageTypeID`, `MessageType`) VALUES (DEFAULT, 'SMS');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`MemberStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`MemberStatus` (`MemberStatusID`, `MemberStatus`) VALUES (DEFAULT, 'Active');
INSERT INTO `SERV`.`MemberStatus` (`MemberStatusID`, `MemberStatus`) VALUES (DEFAULT, 'Training');
INSERT INTO `SERV`.`MemberStatus` (`MemberStatusID`, `MemberStatus`) VALUES (DEFAULT, 'Inactive');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`Tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Rider');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Driver');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Controller');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'EmergencyList');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, '4x4');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Fundraiser');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Blood');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'AA');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Milk');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Water');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, 'Committee');
INSERT INTO `SERV`.`Tag` (`TagID`, `Tag`) VALUES (DEFAULT, '2Boxes');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`Member_Tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 2);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 3);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 4);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 5);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 6);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 7);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (1, 8);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (2, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (3, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (4, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (5, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (6, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (7, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (8, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (9, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (10, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (11, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (12, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (13, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (14, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (15, 1);
INSERT INTO `SERV`.`Member_Tag` (`MemberID`, `TagID`) VALUES (16, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`Location`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'NBS Tooting', NULL, NULL, NULL, 0, 0, 1, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Hooley', NULL, NULL, NULL, 0, 1, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Royal Surrey', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'St Peter\'s', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'St Thomas\'', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Frimley Park', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'East Surrey', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Redhill Aerodrome', NULL, NULL, NULL, 0, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'King\'s College', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Guy\'s', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Queen Charlotte\'s', NULL, NULL, NULL, 1, 0, 0, 0, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Darent Valley', NULL, NULL, NULL, 1, 0, 0, 0, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'NBS Colindale', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'St Helier', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Great Ormond Street', NULL, NULL, NULL, 1, 0, 0, 1, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Royal Brompton', NULL, NULL, NULL, 1, 0, 0, 0, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Farnham Hospital', NULL, NULL, NULL, 1, 0, 0, 0, 1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (DEFAULT, 'Epsom General', NULL, NULL, NULL, 1, 0, 0, 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Blood', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Platelets', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Plasma', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Sample', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Human Milk', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Water Sample', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH1', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH2', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH3', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH4', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH5', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH6', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH7', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'RH8', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Drugs', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Package', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'Other', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`VehicleType`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`VehicleType` (`VehicleTypeID`, `VehicleType`, `Enabled`) VALUES (DEFAULT, 'Bike', 1);
INSERT INTO `SERV`.`VehicleType` (`VehicleTypeID`, `VehicleType`, `Enabled`) VALUES (DEFAULT, 'Car', 1);
INSERT INTO `SERV`.`VehicleType` (`VehicleTypeID`, `VehicleType`, `Enabled`) VALUES (DEFAULT, 'TB1', 1);
INSERT INTO `SERV`.`VehicleType` (`VehicleTypeID`, `VehicleType`, `Enabled`) VALUES (DEFAULT, 'TB2', 1);
INSERT INTO `SERV`.`VehicleType` (`VehicleTypeID`, `VehicleType`, `Enabled`) VALUES (DEFAULT, 'TB3', 1);
INSERT INTO `SERV`.`VehicleType` (`VehicleTypeID`, `VehicleType`, `Enabled`) VALUES (DEFAULT, 'The Pig', 1);
INSERT INTO `SERV`.`VehicleType` (`VehicleTypeID`, `VehicleType`, `Enabled`) VALUES (DEFAULT, 'Florence', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`Calendar`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Blood', 1, 14, NULL, 0, 7, 4, NULL, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Day Controller', 1, 14, NULL, 1, 3, 1, NULL, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Night Controller', 1, 14, NULL, 0, 3, 1, NULL, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`RunRejectionReason`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`RunRejectionReason` (`RunRejectionReasonID`, `Reason`) VALUES (DEFAULT, 'Too Tired');
INSERT INTO `SERV`.`RunRejectionReason` (`RunRejectionReasonID`, `Reason`) VALUES (DEFAULT, 'Bad Rider Choice');
INSERT INTO `SERV`.`RunRejectionReason` (`RunRejectionReasonID`, `Reason`) VALUES (DEFAULT, 'Already Busy');
INSERT INTO `SERV`.`RunRejectionReason` (`RunRejectionReasonID`, `Reason`) VALUES (DEFAULT, 'Mechanical Issues');
INSERT INTO `SERV`.`RunRejectionReason` (`RunRejectionReasonID`, `Reason`) VALUES (DEFAULT, 'Weather');
INSERT INTO `SERV`.`RunRejectionReason` (`RunRejectionReasonID`, `Reason`) VALUES (DEFAULT, 'Other');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERV`.`SystemSetting`
-- -----------------------------------------------------
START TRANSACTION;
USE `SERV`;
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'SMSProvider', 'AQL');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'SMSUser', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'SMSPassword', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'SMSFrom', 'SERV');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'FlextelNumber', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'FlextelPin', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'FlextelFormat', 'https://www.f-l-e-x-t-e-l.ltd.uk/cgi-bin/reroute.sh?alt=simple&amp;mode=divert&amp;flextel={0}&amp;pin={1}&amp;new_dest={2}');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'SendSwapNeededEmails', 'true');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'AAPickupLocation', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'AADeliverLocation', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'TweetTriggerEmailAddress', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'SystemMemberID', '-');
INSERT INTO `SERV`.`SystemSetting` (`SystemSettingID`, `SettingName`, `Value`) VALUES (DEFAULT, 'TwitterID', '-');

COMMIT;


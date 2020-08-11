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
  `RegNumber` VARCHAR(45) NULL,
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
  `CollectionPostcode` VARCHAR(8) NULL,
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
  `DeliverToPostcode` VARCHAR(8) NULL,
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


CREATE TABLE IF NOT EXISTS `SERV`.`PasswordReset` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Token` VARCHAR(100) NOT NULL,
  `EmailAddress` VARCHAR(60) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  PRIMARY KEY (`Id`))
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
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Super', 'User', '2011-01-01', 'admin@servsystem.org', '07429386911', NULL, 'Developer', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RH69SD', 1980, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Louis', 'Lane', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Peter', 'Parker', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Stanley', 'Stroman', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Brendon', 'Bodden', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Zackary', 'Zawislak', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Jerrod', 'Junk', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Wilber', 'Welles', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Henry', 'Taylor', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Edward', 'Phillips', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Ernest', 'Patterson', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Norma', 'Kelly', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Beverly', 'James', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Charles', 'Martin', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Donna', 'Cox', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);
INSERT INTO `SERV`.`Member` (`MemberID`, `FirstName`, `LastName`, `JoinDate`, `EmailAddress`, `MobileNumber`, `HomeNumber`, `Occupation`, `MemberStatusID`, `AvailabilityID`, `RiderAssesmentPassDate`, `AdQualPassDate`, `AdQualType`, `BikeType`, `CarType`, `Notes`, `Address1`, `Address2`, `Address3`, `Town`, `County`, `PostCode`, `BirthYear`, `NextOfKin`, `NextOfKinAddress`, `NextOfKinPhone`, `LegalConfirmation`, `LeaveDate`, `LastGDPGMPDate`, `OnDuty`, `LastLat`, `LastLng`, `GroupID`, `SystemController`, `RegNumber`) VALUES (DEFAULT, 'Bonnie', 'Lopez', NULL, '@', '07', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, DEFAULT, NULL);

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
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (1, 'NBS Tooting',51.4280830891659, -0.176260566711448,'SW17 0QS',0,0,1,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (2, 'Hooley',51.2909124476623, -0.154566860198997,'CR5 3EG',0,1,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (3, 'Royal Surrey County, Guildford',51.2410341405981, -0.60743103027346,'GU2 7XX',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (4, 'St Peter''s, Chertsey',51.3789364825302, -0.528595542907737,'KT16 0PZ',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (5, 'St Thomas''',51.4998640029305, -0.118625259399436,'SE1 7EH',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (6, 'Frimley Park',51.3193651310227, -0.740468597412132,'GU16 7UJ',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (7, 'East Surrey, Redhill',51.2196497899582, -0.163503980636619,'RH1 5RH',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (8, 'Redhill Aerodrome',51.2160948459174, -0.142872428894065,'RH1 5YP',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (9, 'King''s College, Denmark Hill',51.4672861604432, -0.0927902221679914,'SE5 9RS',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (10, 'Guy''s, Great Maze Pond',51.5032099976795, -0.0879515171051252,'SE1 9RT',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (11, 'Queen Charlotte''s, Hammersmith',51.5163711975223, -0.237414932250999,'W12 0HS',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (12, 'Darent Valley, Dartford',51.4350729684255, 0.258793735504127,'DA2 8DA',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (13, 'NBS Colindale',51.5955284995702, -0.255809521675132,'NW9 5BG',0,0,1,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (14, 'St Helier, Carshalton',51.3799945305654, -0.182783699035667,'SM5 1AA',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (15, 'Great Ormond Street',51.5224864225607, -0.12077102661135,'WC1N 3JH',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (16, 'Royal Brompton',51.4890696590007, -0.170767402648948,'SW3 6NP',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (17, 'Farnham Community',51.2205838412448, -0.784671401977561,'GU9 9QL',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (18, 'Epsom General',51.3254263177353, -0.273292160034202,'KT18 7EG',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (19, 'Private Address',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (20, 'Kent & Canterbury',51.265745101716, 1.08680238723752,'CT1 3NG',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (21, 'Medway Maritime, Gillingham',51.3799409591008, 0.541756057739235,'ME7 5NY',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (22, 'Maidstone',51.2737196090513, 0.484056377410865,'ME16 9QQ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (23, 'QEQM, Margate',51.3772623059271, 1.39044990539548,'CT9 4AN',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (24, 'Tunbridge Wells, Pembury',51.1492457944756, 0.305721664428688,'TN2 4QJ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (25, 'William Harvey, Ashford',51.1425420945125, 0.91516246795652,'TN24 0LZ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (26, 'Princess Royal, Haywards Heath',50.9911406939242, -0.090129470825218,'RH16 4EX',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (27, 'Royal Sussex County, Brighton',50.8194016598157, -0.118453598022483,'BN2 5BE',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (28, 'Conquest, Hastings',50.885238546225, 0.566067600250221,'TN37 7RD',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (29, 'Worthing',50.8162361690955, -0.363564586639427,'BN11 2DH',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (30, 'St Richard''s, Chichester',50.8426041860178, -0.76922187805178,'PO19 6SE',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (31, 'Eastbourne',50.78701812263, 0.267054939269996,'BN21 2UD',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (32, 'Southampton General',50.9338250010317, -1.43374452590944,'SO16 6YD',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (33, 'Queen Alexandra, Portsmouth',50.8510854077748, -1.06864223480226,'PO6 3LY',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (34, 'SERV - Kent',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (35, 'SERV - Sussex',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (36, 'Farningham',51.3831283521223, 0.221618318557716,'DA4 0DX',0,1,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (37, '*Other-Not Listed(Detail in Notes)',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (38, 'Camberley',51.32099784144, -0.762425160408042,'GU15 3YN',0,1,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (39, 'St Mary''s, Paddington',51.5171456600746, -0.173900222778343,'W2 1NY',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (40, 'West Middlesex University',51.4740628787265, -0.326185321807884,'TW7 6AF',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (41, 'Chelsea & Westminster',51.4842327500224, -0.18145332336428,'SW10 9NH',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (42, '-',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (43, 'Charing Cross',51.4865710988163, -0.219497776031516,'W6 8RF',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (44, 'Cobham Services M25',51.3046647682255, -0.40566453933718,'KT11 3DB',0,1,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (45, 'The Whittington, Highgate',51.5664971421466, -0.139396286010764,'N19 5NF',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (46, 'The Wellington, St John''s Wood',51.5315375845275, -0.171496963500999,'NW8 9LE',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (47, 'Kingston',51.4142138765546, -0.282025432586692,'KT2 7QB',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (49, 'SERV - Wessex',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (50, 'St George''s, Tooting',51.4262969867646, -0.176045989990257,'SW17 0QT',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (51, 'Croydon University',51.3895828126446, -0.110342597961448,'CR7 7YE',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (52, 'SERV - OBN',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (53, 'Heston Services M4 (Eastbound)',51.4885485802087, -0.388026332855247,'TW5 9NB.',0,1,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (54, 'NBS Brentwood',51.6231200866554, 0.318459475040413,'CM15 8DP',0,0,1,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (55, 'NBS Filton, Bristol',51.5184141478754, -2.56582984924318,'BS34 7QH',0,0,1,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (56, 'Royal Marsden, Sutton',51.3431761580971, -0.191345310211204,'SM2 5PT',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (57, 'University College, London',51.5246359026866, -0.135705566406272,'NW1 2BU',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (58, 'Milford',51.1669830171967, -0.625369644165061,'GU7 1UF',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (59, 'Haslemere Community',51.0925432731202, -0.707252120971702,'GU27 2BJ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (60, 'Holy Cross, Haslemere',51.0903128091642, -0.736531114578269,'GU27 1NQ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (61, 'Royal Marsden, Chelsea',51.4904324523013, -0.172612762451194,'SW3 6JJ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (62, 'Princess Royal University, Orpington',51.3661710139074, 0.058958435058571,'BR6 8ND',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (63, 'St Bartholomew''s',51.5171590127617, -0.100075101852439,'EC1A 7BE',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (64, 'Hammersmith',51.5163177858265, -0.237414932250999,'W12 0HS',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (65, 'Central Middlesex, Park Royal',51.531444145145, -0.26885042190554,'NW10 7NS',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (66, 'North Middlesex University',51.6129703913596, -0.0743795394897688,'N18 1BX',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (67, 'Ealing',51.5073704428809, -0.34650573730471,'UB1 3HW',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (68, 'Northwick Park, Harrow',51.5754328687457, -0.318696594238304,'HA1 3UJ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (69, 'Spire Clare Park, Farnham',51.2251799038579, -0.847070312500022,'GU10 5XX',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (70, 'Homerton University',51.55051515112, -0.0460554122925032,'E9 6SR',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (71, 'Honeywood House, Horsham',NULL, NULL,'RH12 3QD',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (72, 'Whipps Cross University',51.5791533473591, 0.00173082351682296,'E11 1NR',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (73, 'Queen Elizabeth, Woolwich',51.4788607746769, 0.050568485259987,'SE18 4QH',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (74, 'Royal Free, Hampstead Heath',51.5526766502442, -0.165059661865257,'NW3 2QG',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (75, 'Royal London, Whitechapel',51.5187880112233, -0.0601745605468977,'E1 1BB',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (76, 'Hillingdon, Uxbridge',51.526277983733, -0.461261367797874,'UB8 3NN',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (77, 'Countess of Chester, Cheshire',53.20915, -2.8974088,'CH2 1UL',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (78, 'BMI Mount Alvernia, Guildford',51.23585, -0.564709,'GU1 3LX',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (79, 'The London Chest, Bethnal Green',51.5320715201768, -0.0492740631103743,'E2 9JX',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (80, 'The Priory Hospital, Woking',51.3224762826626, -0.622880554199241,'GU21 2QF',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (81, 'Porton Down Water Protection Agency',51.1297512114965, -1.70636425018312,'SP4 0JG',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (82, 'Ashford, Surrey',51.4440612505875, -0.472998714447044,'TW15 3AA',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (83, '* NULL',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (84, 'Dorking Community',51.2261339996816, -0.333287811279319,'RH4 2AA',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (85, 'Heathrow South (Cargo)',51.4612337135649, -0.481565690040611,'TW6 3PF',0,1,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (86, 'Spire St Anthony''s, Cheam',51.3799543519728, -0.219991302490257,'SM3 9DW',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (87, 'Godstone Shell Garage',51.2542172108283, -0.0667298793791815,'RH9 8AJ',0,1,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (88, 'Nursing Home (Address in Notes)',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (89, 'University Hospital Lewisham',51.4530878783832, -0.0167227745056379,'SE13 6LH',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (90, 'Molesey Community',51.3978838921132, -0.372769927978538,'KT8 2LU',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (91, 'Woking Community',51.3150869529512, -0.556469058990501,'GU22 7HS',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (92, 'Wexham Park, Slough',51.533246156562, -0.575158691406272,'SL2 4HL',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (93, '-',NULL, NULL,'',0,0,0,0,0);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (94, 'Southmead, Bristol',51.4968450503575, -2.59097824096681,'BS10 5NB',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (95, 'Mile End, Stepney',51.5244957222929, -0.0426436424255598,'E1 4DG',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (96, 'London School of Hygiene and Tropical Medicin',51.5205604822943, -0.129928088188194,'WC1E 7HT',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (97, 'Newham University Hospital',51.522433018036, 0.0347970962524186,'E13 8RU',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (98, 'Great Western Hospital, Swindon',51.53867, -1.72736,'SN3 6BB',0,1,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (99, '-',NULL, NULL,'',0,0,0,0,0);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (100, 'Royal Shrewsbury',52.709357, -2.793752,'SY3 8XQ',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (101, 'Shropshire, Stafordshire, Cheshire Blood Bike',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (102, 'HEMS',NULL, NULL,'',0,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (103, 'Doctor''s Lab',51.521604, -0.136065,'W1T 4EU',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (104, '-',NULL, NULL,'',0,0,0,0,0);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (105, 'Moorfields Eye Hospital',51.527188, -0.090223,'EC1V 2PD',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (106, 'HSL- Heath Services Laboratories 60 Whitfield',51.5214659, -0.1363342,'W1T 4EU',1,0,0,1,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (107, 'Royal Berkshire',51.451022, -0.95933,'RG1 5AN',1,0,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (108, 'Tooting as exchange',51.42808, 0.17626,'SW17 0QS',0,1,0,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (109, 'Dorset County, Dorchester',50.7128324, -2.4482908,'DT1 2JY',1,0,1,0,1);
INSERT INTO `SERV`.`Location` (`LocationID`, `Location`, `Lat`, `Lng`, `PostCode`, `Hospital`, `Changeover`, `BloodBank`, `InNetwork`, `Enabled`) VALUES (110, 'Fleet Services North M3',51.2965452, -0.8578999,'GU51 1AA',0,1,0,1,1);

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
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH1', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH2', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH3', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH4', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH5', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH6', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH7', 1);
INSERT INTO `SERV`.`Product` (`ProductID`, `Product`, `Enabled`) VALUES (DEFAULT, 'ESH8', 1);
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
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Blood', 1, 14, NULL, 0, 7, 4, 2, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'AA Evening', 1, 14, NULL, 1, 8, 1, 4, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Controller - Days', 1, 14, NULL, 1, 3, 1, 100, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Controller - Nights', 1, 14, NULL, 1, 3, 1, 1, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'AA Reserve', 1, 14, NULL, 1, 8, 0, 200, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'AA Daytime', 1, 14, NULL, 1, 8, 2, 200, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Hooleygan', 1, 14, NULL, 0, 7, 1, 3, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Milk', 0, 0, NULL, 1, 0, 0, 300, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`, `SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (DEFAULT, 'Daytime Blood', 0, 0, NULL, 0, 7, 0, 400, NULL, NULL, 1);
INSERT INTO `SERV`.`Calendar` (`CalendarID`, `Name`, `SimpleCalendar`, `SimpleDaysIncrement`, `SequentialDayCount`, `VolunteerRemainsFree`, `RequiredTagID`, `DefaultRequirement`,`SortOrder`, `LastGenerated`, `GeneratedUpTo`, `GroupID`) VALUES (10, 'Daytime Sample', 0, 0, NULL, 0, 7, 0, 450, NULL, NULL, 1);

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


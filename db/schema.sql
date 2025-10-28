-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PC_Room_Database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PC_Room_Database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PC_Room_Database` DEFAULT CHARACTER SET utf8 ;
USE `PC_Room_Database` ;

-- -----------------------------------------------------
-- Table `PC_Room_Database`.`Grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room_Database`.`Grades` (
  `gradeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gradeName` VARCHAR(10) NOT NULL,
  `minSpend` INT UNSIGNED NOT NULL,
  `discountRate` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`gradeID`),
  UNIQUE INDEX `gradeID_UNIQUE` (`gradeID` ASC) VISIBLE,
  UNIQUE INDEX `gradeName_UNIQUE` (`gradeName` ASC) VISIBLE,
  UNIQUE INDEX `minSpend_UNIQUE` (`minSpend` ASC) VISIBLE,
  UNIQUE INDEX `discountRate_UNIQUE` (`discountRate` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room_Database`.`Members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room_Database`.`Members` (
  `memberID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `logInID` VARCHAR(12) NOT NULL,
  `memberName` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(50) NULL,
  `gradeID` INT UNSIGNED NOT NULL,
  `remainTime` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`memberID`),
  UNIQUE INDEX `memberID_UNIQUE` (`memberID` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`memberName` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `gradeID_idx` (`gradeID` ASC) VISIBLE,
  UNIQUE INDEX `logInID_UNIQUE` (`logInID` ASC) VISIBLE,
  CONSTRAINT `fk_gradeID`
    FOREIGN KEY (`gradeID`)
    REFERENCES `PC_Room_Database`.`Grades` (`gradeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room_Database`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room_Database`.`Products` (
  `productID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `productType` ENUM('TIME', 'FOOD') NOT NULL,
  `productName` VARCHAR(20) NOT NULL,
  `currentPrice` INT UNSIGNED NOT NULL,
  `timeValue` INT UNSIGNED NOT NULL,
  `stock` INT UNSIGNED NULL,
  PRIMARY KEY (`productID`),
  UNIQUE INDEX `productID_UNIQUE` (`productID` ASC) VISIBLE,
  UNIQUE INDEX `productName_UNIQUE` (`productName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room_Database`.`Products_Log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room_Database`.`Products_Log` (
  `logID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `productID` INT UNSIGNED NOT NULL,
  `changReason` ENUM('IN', 'SALE', 'DISUSE') NOT NULL,
  `recordTime` DATETIME NOT NULL,
  PRIMARY KEY (`logID`),
  UNIQUE INDEX `logID_UNIQUE` (`logID` ASC) VISIBLE,
  CONSTRAINT `fk_productID_PL`
    FOREIGN KEY (`productID`)
    REFERENCES `PC_Room_Database`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room_Database`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room_Database`.`Orders` (
  `orderID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `memberID` INT UNSIGNED NOT NULL,
  `orderTime` DATETIME NOT NULL,
  `beforeDiscount` INT UNSIGNED NOT NULL,
  `afterDiscount` INT UNSIGNED NOT NULL,
  `payByTime` INT UNSIGNED NOT NULL,
  `payByCard` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`orderID`),
  UNIQUE INDEX `orderID_UNIQUE` (`orderID` ASC) VISIBLE,
  CONSTRAINT `fk_memberID`
    FOREIGN KEY (`memberID`)
    REFERENCES `PC_Room_Database`.`Members` (`memberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room_Database`.`Orders_Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room_Database`.`Orders_Detail` (
  `detailID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderID` BIGINT UNSIGNED NOT NULL,
  `productID` INT UNSIGNED NOT NULL,
  `priceAtSale` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`detailID`),
  UNIQUE INDEX `detailID_UNIQUE` (`detailID` ASC) VISIBLE,
  CONSTRAINT `fk_orderID`
    FOREIGN KEY (`orderID`)
    REFERENCES `PC_Room_Database`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productID_OD`
    FOREIGN KEY (`productID`)
    REFERENCES `PC_Room_Database`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

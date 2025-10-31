-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PC_Room
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PC_Room
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PC_Room` DEFAULT CHARACTER SET utf8 ;
USE `PC_Room` ;

-- -----------------------------------------------------
-- Table `PC_Room`.`grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room`.`grades` (
  `gradeID` INT UNSIGNED NOT NULL,
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
-- Table `PC_Room`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room`.`members` (
  `memberID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `logInID` VARCHAR(12) NOT NULL,
  `memberName` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(50) NULL,
  `gradeID` INT UNSIGNED NOT NULL,
  `remainTime` INT NOT NULL,
  PRIMARY KEY (`memberID`),
  UNIQUE INDEX `memberID_UNIQUE` (`memberID` ASC) VISIBLE,
  UNIQUE INDEX `logInID_UNIQUE` (`logInID` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_gradeID_idx` (`gradeID` ASC) VISIBLE,
  CONSTRAINT `fk_gradeID`
    FOREIGN KEY (`gradeID`)
    REFERENCES `PC_Room`.`grades` (`gradeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room`.`products` (
  `productID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `productType` ENUM('TIME', 'FOOD') NOT NULL,
  `productName` VARCHAR(20) NOT NULL,
  `currentPrice` INT UNSIGNED NOT NULL,
  `timeValue` INT UNSIGNED NOT NULL,
  `stock` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`productID`),
  UNIQUE INDEX `productID_UNIQUE` (`productID` ASC) VISIBLE,
  UNIQUE INDEX `productName_UNIQUE` (`productName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room`.`orders` (
  `orderID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderTime` DATETIME NOT NULL,
  `memberID` INT UNSIGNED NOT NULL,
  `beforeDiscount` INT UNSIGNED NOT NULL,
  `afterDiscount` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`orderID`),
  UNIQUE INDEX `orderID_UNIQUE` (`orderID` ASC) VISIBLE,
  INDEX `fk_memberID_idx` (`memberID` ASC) VISIBLE,
  CONSTRAINT `fk_memberID`
    FOREIGN KEY (`memberID`)
    REFERENCES `PC_Room`.`members` (`memberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room`.`order_details` (
  `detailID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderID` INT UNSIGNED NOT NULL,
  `productID` INT UNSIGNED NOT NULL,
  `priceAtSale` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`detailID`),
  UNIQUE INDEX `detailID_UNIQUE` (`detailID` ASC) VISIBLE,
  INDEX `fk_productID_OD_idx` (`productID` ASC) VISIBLE,
  INDEX `fk_orderID_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `fk_productID_OD`
    FOREIGN KEY (`productID`)
    REFERENCES `PC_Room`.`products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderID_OD`
    FOREIGN KEY (`orderID`)
    REFERENCES `PC_Room`.`orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room`.`product_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room`.`product_logs` (
  `logID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `productID` INT UNSIGNED NOT NULL,
  `changeStock` INT UNSIGNED NOT NULL,
  `changeReason` ENUM('IN', 'SALE') NOT NULL,
  PRIMARY KEY (`logID`),
  UNIQUE INDEX `logID_UNIQUE` (`logID` ASC) VISIBLE,
  INDEX `fk_productID_PL_idx` (`productID` ASC) VISIBLE,
  CONSTRAINT `fk_productID_PL`
    FOREIGN KEY (`productID`)
    REFERENCES `PC_Room`.`products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PC_Room`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PC_Room`.`payments` (
  `paymentID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderID` INT UNSIGNED NOT NULL,
  `paymentType` ENUM('TIME', 'CARD') NOT NULL,
  `amount` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`paymentID`),
  UNIQUE INDEX `paymentID_UNIQUE` (`paymentID` ASC) VISIBLE,
  INDEX `fk_orderID_PM_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `fk_orderID_PM`
    FOREIGN KEY (`orderID`)
    REFERENCES `PC_Room`.`orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

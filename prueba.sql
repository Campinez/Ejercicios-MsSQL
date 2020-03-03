-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Adress_Book_Provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adress_Book_Provider` (
  `id_Provider_name` VARCHAR(100) NOT NULL,
  `Street` VARCHAR(100) NOT NULL,
  `Number` INT NOT NULL,
  `Floor` INT NULL,
  `Door` VARCHAR(45) NULL,
  `City` VARCHAR(45) NOT NULL,
  `Postal_number` INT NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `Phone` INT NULL,
  `Fax` INT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Provider_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provider` (
  `idPROVIDER` INT NOT NULL,
  `BRANDS` VARCHAR(45) NOT NULL,
  `Adress_Book_Provider_id_Provider_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPROVIDER`, `Adress_Book_Provider_id_Provider_name`),
  INDEX `fk_Provider_Adress_Book_Provider_idx` (`Adress_Book_Provider_id_Provider_name` ASC),
  CONSTRAINT `fk_Provider_Adress_Book_Provider`
    FOREIGN KEY (`Adress_Book_Provider_id_Provider_name`)
    REFERENCES `mydb`.`Adress_Book_Provider` (`id_Provider_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Seller` (
  `idSeller` INT NOT NULL,
  `Seller_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSeller`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Glasses` (
  `Model` VARCHAR(100) NOT NULL,
  `Graduation` INT NOT NULL,
  `saddle color` VARCHAR(45) NOT NULL,
  `Glass_color` VARCHAR(45) NOT NULL,
  `Price` INT NOT NULL,
  `mount type` VARCHAR(32) NOT NULL,
  `Seller_idSeller` INT NOT NULL,
  PRIMARY KEY (`Model`),
  INDEX `fk_Glasses_Seller1_idx` (`Seller_idSeller` ASC),
  CONSTRAINT `fk_Glasses_Seller1`
    FOREIGN KEY (`Seller_idSeller`)
    REFERENCES `mydb`.`Seller` (`idSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Provider_has_Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provider_has_Glasses` (
  `Provider_idPROVIDER` INT NOT NULL,
  `Provider_Adress_Book_Provider_id_Provider_name` VARCHAR(100) NOT NULL,
  `Glasses_Model` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Provider_idPROVIDER`, `Provider_Adress_Book_Provider_id_Provider_name`, `Glasses_Model`),
  INDEX `fk_Provider_has_Glasses_Glasses1_idx` (`Glasses_Model` ASC),
  INDEX `fk_Provider_has_Glasses_Provider1_idx` (`Provider_idPROVIDER` ASC, `Provider_Adress_Book_Provider_id_Provider_name` ASC),
  CONSTRAINT `fk_Provider_has_Glasses_Provider1`
    FOREIGN KEY (`Provider_idPROVIDER` , `Provider_Adress_Book_Provider_id_Provider_name`)
    REFERENCES `mydb`.`Provider` (`idPROVIDER` , `Adress_Book_Provider_id_Provider_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Provider_has_Glasses_Glasses1`
    FOREIGN KEY (`Glasses_Model`)
    REFERENCES `mydb`.`Glasses` (`Model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idClient` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Adress` VARCHAR(45) NULL,
  `Phone` INT NULL,
  `Email` VARCHAR(45) NULL,
  `Register_date` DATETIME NOT NULL,
  PRIMARY KEY (`idClient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client_has_Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client_has_Client` (
  `Client_idClient` INT NOT NULL,
  `Client_idClient1` INT NOT NULL,
  PRIMARY KEY (`Client_idClient`, `Client_idClient1`),
  INDEX `fk_Client_has_Client_Client2_idx` (`Client_idClient1` ASC),
  INDEX `fk_Client_has_Client_Client1_idx` (`Client_idClient` ASC),
  CONSTRAINT `fk_Client_has_Client_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_Client_Client2`
    FOREIGN KEY (`Client_idClient1`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

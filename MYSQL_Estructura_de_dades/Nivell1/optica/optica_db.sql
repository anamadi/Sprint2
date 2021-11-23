-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica_db` ;
USE `optica_db` ;

-- -----------------------------------------------------
-- Table `optica_db`.`PROVEEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_db`.`PROVEEDOR` (
  `NIF` VARCHAR(9) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigoPostal` VARCHAR(5) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `telefono1` VARCHAR(20) NOT NULL,
  `telefono2` VARCHAR(20) NULL,
  `fax` VARCHAR(20) NULL,
  PRIMARY KEY (`NIF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_db`.`GAFAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_db`.`GAFAS` (
  `idgafas` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(45) NOT NULL,
  `graduacionVidrio1` DECIMAL(5,2) NOT NULL,
  `graduacionVidrio2` DECIMAL(5,2) NOT NULL,
  `tipoMontura` ENUM('PASTA', 'FLOTANTE', 'METALICA') NOT NULL,
  `colorMontura` VARCHAR(45) NOT NULL,
  `colorVidrio1` VARCHAR(45) NOT NULL,
  `colorVidrio2` VARCHAR(45) NOT NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  `PROVEEDOR_NIF` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idgafas`),
  INDEX `fk_GAFAS_PROVEEDOR_idx` (`PROVEEDOR_NIF` ASC),
  CONSTRAINT `fk_GAFAS_PROVEEDOR`
    FOREIGN KEY (`PROVEEDOR_NIF`)
    REFERENCES `optica_db`.`PROVEEDOR` (`NIF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_db`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_db`.`CLIENTE` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `ciudad` VARCHAR(30) NOT NULL,
  `codigoPostal` VARCHAR(5) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `fechaAlta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CLIENTE_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_CLIENTE_CLIENTE1_idx` (`CLIENTE_idCliente` ASC),
  CONSTRAINT `fk_CLIENTE_CLIENTE1`
    FOREIGN KEY (`CLIENTE_idCliente`)
    REFERENCES `optica_db`.`CLIENTE` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_db`.`FACTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_db`.`FACTURA` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `empleado` VARCHAR(45) NOT NULL,
  `fechaFactura` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total` DECIMAL(9,2) NOT NULL,
  `CLIENTE_idCliente` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_FACTURA_CLIENTE1_idx` (`CLIENTE_idCliente` ASC),
  CONSTRAINT `fk_FACTURA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_idCliente`)
    REFERENCES `optica_db`.`CLIENTE` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_db`.`LINEA_FACTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_db`.`LINEA_FACTURA` (
  `FACTURA_idFactura` INT NOT NULL,
  `id_linea` INT NOT NULL,
  `GAFAS_idgafas` INT NOT NULL,
  `cantidad` INT NULL,
  INDEX `fk_LINEA_FACTURA_FACTURA1_idx` (`FACTURA_idFactura` ASC),
  INDEX `fk_LINEA_FACTURA_GAFAS1_idx` (`GAFAS_idgafas` ASC),
  PRIMARY KEY (`FACTURA_idFactura`, `id_linea`),
  CONSTRAINT `fk_LINEA_FACTURA_FACTURA1`
    FOREIGN KEY (`FACTURA_idFactura`)
    REFERENCES `optica_db`.`FACTURA` (`idFactura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LINEA_FACTURA_GAFAS1`
    FOREIGN KEY (`GAFAS_idgafas`)
    REFERENCES `optica_db`.`GAFAS` (`idgafas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

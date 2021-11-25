-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema opticaB_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema opticaB_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `opticaB_db` ;
USE `opticaB_db` ;

-- -----------------------------------------------------
-- Table `opticaB_db`.`PROVEEDOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opticaB_db`.`PROVEEDOR` ;

CREATE TABLE IF NOT EXISTS `opticaB_db`.`PROVEEDOR` (
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
-- Table `opticaB_db`.`GAFAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opticaB_db`.`GAFAS` ;

CREATE TABLE IF NOT EXISTS `opticaB_db`.`GAFAS` (
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
    REFERENCES `opticaB_db`.`PROVEEDOR` (`NIF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticaB_db`.`CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opticaB_db`.`CLIENTE` ;

CREATE TABLE IF NOT EXISTS `opticaB_db`.`CLIENTE` (
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
    REFERENCES `opticaB_db`.`CLIENTE` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticaB_db`.`VENTAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opticaB_db`.`VENTAS` ;

CREATE TABLE IF NOT EXISTS `opticaB_db`.`VENTAS` (
  `GAFAS_idgafas` INT NOT NULL,
  `CLIENTE_idCliente` INT NOT NULL,
  `fechaVenta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad` INT NOT NULL,
  `total` DECIMAL(9,2) NOT NULL,
  INDEX `fk_FACTURA_CLIENTE1_idx` (`CLIENTE_idCliente` ASC),
  INDEX `fk_VENTAS_GAFAS1_idx` (`GAFAS_idgafas` ASC),
  PRIMARY KEY (`GAFAS_idgafas`, `CLIENTE_idCliente`, `fechaVenta`),
  CONSTRAINT `fk_FACTURA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_idCliente`)
    REFERENCES `opticaB_db`.`CLIENTE` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VENTAS_GAFAS1`
    FOREIGN KEY (`GAFAS_idgafas`)
    REFERENCES `opticaB_db`.`GAFAS` (`idgafas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

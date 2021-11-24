-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria_db` ;
USE `pizzeria_db` ;

-- -----------------------------------------------------
-- Table `pizzeria_db`.`PROVINCIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`PROVINCIA` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`PROVINCIA` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`LOCALIDAD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`LOCALIDAD` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`LOCALIDAD` (
  `idLocalidad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `PROVINCIA_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idLocalidad`),
  INDEX `fk_LOCALIDAD_PROVINCIA1_idx` (`PROVINCIA_idProvincia` ASC),
  CONSTRAINT `fk_LOCALIDAD_PROVINCIA1`
    FOREIGN KEY (`PROVINCIA_idProvincia`)
    REFERENCES `pizzeria_db`.`PROVINCIA` (`idProvincia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`CLIENTE` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`CLIENTE` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `codigoPostal` VARCHAR(5) NOT NULL,
  `telefono1` VARCHAR(20) NOT NULL,
  `telefono2` VARCHAR(20) NULL,
  `LOCALIDAD_idLocalidad` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_CLIENTE_LOCALIDAD1_idx` (`LOCALIDAD_idLocalidad` ASC),
  CONSTRAINT `fk_CLIENTE_LOCALIDAD1`
    FOREIGN KEY (`LOCALIDAD_idLocalidad`)
    REFERENCES `pizzeria_db`.`LOCALIDAD` (`idLocalidad`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`TIENDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`TIENDA` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`TIENDA` (
  `idTienda` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(100) NOT NULL,
  `codigoPostal` VARCHAR(5) NOT NULL,
  `LOCALIDAD_idLocalidad` INT NOT NULL,
  PRIMARY KEY (`idTienda`),
  INDEX `fk_TIENDA_LOCALIDAD1_idx` (`LOCALIDAD_idLocalidad` ASC),
  CONSTRAINT `fk_TIENDA_LOCALIDAD1`
    FOREIGN KEY (`LOCALIDAD_idLocalidad`)
    REFERENCES `pizzeria_db`.`LOCALIDAD` (`idLocalidad`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`PEDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`PEDIDO` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`PEDIDO` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fechaPedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidadHamburguesas` INT NULL,
  `cantidadBebidas` INT NULL,
  `cantidadPizzas` INT NULL,
  `TIENDA_idTienda` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_PEDIDO_TIENDA1_idx` (`TIENDA_idTienda` ASC),
  CONSTRAINT `fk_PEDIDO_TIENDA1`
    FOREIGN KEY (`TIENDA_idTienda`)
    REFERENCES `pizzeria_db`.`TIENDA` (`idTienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`PRODUCTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`PRODUCTO` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`PRODUCTO` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`PEDIDO_PRODUCTOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`PEDIDO_PRODUCTOS` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`PEDIDO_PRODUCTOS` (
  `PRODUCTO_idProducto` INT NOT NULL,
  `PEDIDO_idPedido` INT NOT NULL,
  `cantidad` INT NOT NULL,
  INDEX `fk_PEDIDO_PRODUCTOS_PEDIDO1_idx` (`PEDIDO_idPedido` ASC),
  INDEX `fk_PEDIDO_PRODUCTOS_PRODUCTO1_idx` (`PRODUCTO_idProducto` ASC),
  PRIMARY KEY (`PRODUCTO_idProducto`, `PEDIDO_idPedido`),
  CONSTRAINT `fk_PEDIDO_PRODUCTOS_PEDIDO1`
    FOREIGN KEY (`PEDIDO_idPedido`)
    REFERENCES `pizzeria_db`.`PEDIDO` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PEDIDO_PRODUCTOS_PRODUCTO1`
    FOREIGN KEY (`PRODUCTO_idProducto`)
    REFERENCES `pizzeria_db`.`PRODUCTO` (`idProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`EN_TIENDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`EN_TIENDA` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`EN_TIENDA` (
  `PEDIDO_idPedido` INT NOT NULL,
  INDEX `fk_EN_TIENDA_PEDIDO1_idx` (`PEDIDO_idPedido` ASC),
  PRIMARY KEY (`PEDIDO_idPedido`),
  CONSTRAINT `fk_EN_TIENDA_PEDIDO1`
    FOREIGN KEY (`PEDIDO_idPedido`)
    REFERENCES `pizzeria_db`.`PEDIDO` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`EMPLEADO` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL,
  `telefono1` VARCHAR(20) NOT NULL,
  `telefono2` VARCHAR(20) NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `tipoEmpleado` ENUM('COCINERO', 'REPARTIDOR') NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`A_DOMICILIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`A_DOMICILIO` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`A_DOMICILIO` (
  `PEDIDO_idPedido` INT NOT NULL,
  `fechaEntrega` DATETIME NULL,
  `EMPLEADO_idEmpleado` INT NOT NULL,
  INDEX `fk_A_DOMICILIO_EMPLEADO1_idx` (`EMPLEADO_idEmpleado` ASC),
  INDEX `fk_A_DOMICILIO_PEDIDO1_idx` (`PEDIDO_idPedido` ASC),
  PRIMARY KEY (`PEDIDO_idPedido`),
  CONSTRAINT `fk_A_DOMICILIO_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_idEmpleado`)
    REFERENCES `pizzeria_db`.`EMPLEADO` (`idEmpleado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_A_DOMICILIO_PEDIDO1`
    FOREIGN KEY (`PEDIDO_idPedido`)
    REFERENCES `pizzeria_db`.`PEDIDO` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`HAMBURGUESA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`HAMBURGUESA` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`HAMBURGUESA` (
  `PEDIDO_idPedido` INT NOT NULL,
  INDEX `fk_HAMBURGUESA_PEDIDO1_idx` (`PEDIDO_idPedido` ASC),
  PRIMARY KEY (`PEDIDO_idPedido`),
  CONSTRAINT `fk_HAMBURGUESA_PEDIDO1`
    FOREIGN KEY (`PEDIDO_idPedido`)
    REFERENCES `pizzeria_db`.`PEDIDO` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`BEBIDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`BEBIDA` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`BEBIDA` (
  `PEDIDO_idPedido` INT NOT NULL,
  INDEX `fk_BEBIDA_PEDIDO1_idx` (`PEDIDO_idPedido` ASC),
  PRIMARY KEY (`PEDIDO_idPedido`),
  CONSTRAINT `fk_BEBIDA_PEDIDO1`
    FOREIGN KEY (`PEDIDO_idPedido`)
    REFERENCES `pizzeria_db`.`PEDIDO` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`CATEGORIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`CATEGORIA` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`CATEGORIA` (
  `idCategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria_db`.`PIZZA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria_db`.`PIZZA` ;

CREATE TABLE IF NOT EXISTS `pizzeria_db`.`PIZZA` (
  `PEDIDO_idPedido` INT NOT NULL,
  `CATEGORIA_idCategoria` INT NOT NULL,
  INDEX `fk_PIZZA_PEDIDO1_idx` (`PEDIDO_idPedido` ASC),
  INDEX `fk_PIZZA_CATEGORIA1_idx` (`CATEGORIA_idCategoria` ASC),
  PRIMARY KEY (`PEDIDO_idPedido`),
  CONSTRAINT `fk_PIZZA_PEDIDO1`
    FOREIGN KEY (`PEDIDO_idPedido`)
    REFERENCES `pizzeria_db`.`PEDIDO` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PIZZA_CATEGORIA1`
    FOREIGN KEY (`CATEGORIA_idCategoria`)
    REFERENCES `pizzeria_db`.`CATEGORIA` (`idCategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

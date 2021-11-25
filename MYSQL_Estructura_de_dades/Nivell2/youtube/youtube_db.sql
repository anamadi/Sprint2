-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube_db` ;
USE `youtube_db` ;

-- -----------------------------------------------------
-- Table `youtube_db`.`USUARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`USUARIO` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`USUARIO` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` BLOB NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATETIME NOT NULL,
  `sexo` ENUM('Mujer', 'Hombre', 'Otro') NOT NULL,
  `pais` VARCHAR(25) NOT NULL,
  `codigoPostal` VARCHAR(5) NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`VIDEO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`VIDEO` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`VIDEO` (
  `idVideo` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `tamaño` BIGINT NOT NULL,
  `nombreArchivo` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `thumbnail` BLOB NULL,
  `numeroReproducciones` BIGINT NOT NULL,
  `numeroLikes` BIGINT NULL,
  `numeroDislikes` BIGINT NULL,
  `estados` ENUM('publico', 'privado', 'oculto') NOT NULL,
  `USUARIO_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idVideo`),
  INDEX `fk_VIDEO_USUARIO_idx` (`USUARIO_idUsuario` ASC),
  CONSTRAINT `fk_VIDEO_USUARIO`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`ETIQUETA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`ETIQUETA` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`ETIQUETA` (
  `idEtiqueta` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEtiqueta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`VIDEO_ETIQUETA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`VIDEO_ETIQUETA` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`VIDEO_ETIQUETA` (
  `VIDEO_idVideo` INT NOT NULL,
  `ETIQUETA_idEtiqueta` INT NOT NULL,
  INDEX `fk_VIDEO_ETIQUETA_VIDEO1_idx` (`VIDEO_idVideo` ASC),
  INDEX `fk_VIDEO_ETIQUETA_ETIQUETA1_idx` (`ETIQUETA_idEtiqueta` ASC),
  PRIMARY KEY (`VIDEO_idVideo`, `ETIQUETA_idEtiqueta`),
  CONSTRAINT `fk_VIDEO_ETIQUETA_VIDEO1`
    FOREIGN KEY (`VIDEO_idVideo`)
    REFERENCES `youtube_db`.`VIDEO` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VIDEO_ETIQUETA_ETIQUETA1`
    FOREIGN KEY (`ETIQUETA_idEtiqueta`)
    REFERENCES `youtube_db`.`ETIQUETA` (`idEtiqueta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`PUBLICA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`PUBLICA` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`PUBLICA` (
  `USUARIO_idUsuario` INT NOT NULL,
  `VIDEO_idVideo` INT NOT NULL,
  `fechaVideo` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_PUBLICA_USUARIO1_idx` (`USUARIO_idUsuario` ASC),
  INDEX `fk_PUBLICA_VIDEO1_idx` (`VIDEO_idVideo` ASC),
  PRIMARY KEY (`USUARIO_idUsuario`, `VIDEO_idVideo`),
  CONSTRAINT `fk_PUBLICA_USUARIO1`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PUBLICA_VIDEO1`
    FOREIGN KEY (`VIDEO_idVideo`)
    REFERENCES `youtube_db`.`VIDEO` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`CANAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`CANAL` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`CANAL` (
  `idCanal` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `fechaCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `USUARIO_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idCanal`),
  INDEX `fk_CANAL_USUARIO1_idx` (`USUARIO_idUsuario` ASC),
  CONSTRAINT `fk_CANAL_USUARIO1`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`SUSCRIBE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`SUSCRIBE` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`SUSCRIBE` (
  `CANAL_idCanal` INT NOT NULL,
  `USUARIO_idUsuario` INT NOT NULL,
  INDEX `fk_SUSCRIBE_CANAL1_idx` (`CANAL_idCanal` ASC),
  INDEX `fk_SUSCRIBE_USUARIO1_idx` (`USUARIO_idUsuario` ASC),
  PRIMARY KEY (`CANAL_idCanal`, `USUARIO_idUsuario`),
  CONSTRAINT `fk_SUSCRIBE_CANAL1`
    FOREIGN KEY (`CANAL_idCanal`)
    REFERENCES `youtube_db`.`CANAL` (`idCanal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SUSCRIBE_USUARIO1`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`MARCA_VIDEO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`MARCA_VIDEO` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`MARCA_VIDEO` (
  `USUARIO_idUsuario` INT NOT NULL,
  `VIDEO_idVideo` INT NOT NULL,
  `fechaMarcacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo` ENUM('like', 'dislike') NULL,
  INDEX `fk_MARCA_VIDEO_USUARIO1_idx` (`USUARIO_idUsuario` ASC),
  INDEX `fk_MARCA_VIDEO_VIDEO1_idx` (`VIDEO_idVideo` ASC) ,
  PRIMARY KEY (`fechaMarcacion`, `VIDEO_idVideo`, `USUARIO_idUsuario`),
  CONSTRAINT `fk_MARCA_VIDEO_USUARIO1`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MARCA_VIDEO_VIDEO1`
    FOREIGN KEY (`VIDEO_idVideo`)
    REFERENCES `youtube_db`.`VIDEO` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`PLAYLIST`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`PLAYLIST` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`PLAYLIST` (
  `idPlaylist` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fechaCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` ENUM('publica', 'privada') NOT NULL,
  `USUARIO_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPlaylist`),
  INDEX `fk_PLAYLIST_USUARIO1_idx` (`USUARIO_idUsuario` ASC),
  CONSTRAINT `fk_PLAYLIST_USUARIO1`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`VIDEO_PLAYLIST`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`VIDEO_PLAYLIST` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`VIDEO_PLAYLIST` (
  `VIDEO_idVideo` INT NOT NULL,
  `PLAYLIST_idPlaylist` INT NOT NULL,
  INDEX `fk_VIDEO_PLAYLIST_VIDEO1_idx` (`VIDEO_idVideo` ASC),
  INDEX `fk_VIDEO_PLAYLIST_PLAYLIST1_idx` (`PLAYLIST_idPlaylist` ASC),
  PRIMARY KEY (`VIDEO_idVideo`, `PLAYLIST_idPlaylist`),
  CONSTRAINT `fk_VIDEO_PLAYLIST_VIDEO1`
    FOREIGN KEY (`VIDEO_idVideo`)
    REFERENCES `youtube_db`.`VIDEO` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VIDEO_PLAYLIST_PLAYLIST1`
    FOREIGN KEY (`PLAYLIST_idPlaylist`)
    REFERENCES `youtube_db`.`PLAYLIST` (`idPlaylist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`COMENTARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`COMENTARIO` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`COMENTARIO` (
  `idComentario` INT NOT NULL AUTO_INCREMENT,
  `textoComentario` VARCHAR(300) NOT NULL,
  `fechaCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `USUARIO_idUsuario` INT NOT NULL,
  `VIDEO_idVideo` INT NOT NULL,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_COMENTARIO_USUARIO1_idx` (`USUARIO_idUsuario` ASC),
  INDEX `fk_COMENTARIO_VIDEO1_idx` (`VIDEO_idVideo` ASC),
  CONSTRAINT `fk_COMENTARIO_USUARIO1`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_COMENTARIO_VIDEO1`
    FOREIGN KEY (`VIDEO_idVideo`)
    REFERENCES `youtube_db`.`VIDEO` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`MARCA_COMENTARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube_db`.`MARCA_COMENTARIO` ;

CREATE TABLE IF NOT EXISTS `youtube_db`.`MARCA_COMENTARIO` (
  `USUARIO_idUsuario` INT NOT NULL,
  `COMENTARIO_idComentario` INT NOT NULL,
  `fechaMarcacion` DATETIME NOT NULL,
  `tipo` ENUM('megusta', 'nomegusta') NOT NULL,
  INDEX `fk_MARCA_COMENTARIO_USUARIO1_idx` (`USUARIO_idUsuario` ASC),
  INDEX `fk_MARCA_COMENTARIO_COMENTARIO1_idx` (`COMENTARIO_idComentario` ASC),
  PRIMARY KEY (`USUARIO_idUsuario`, `COMENTARIO_idComentario`, `fechaMarcacion`),
  CONSTRAINT `fk_MARCA_COMENTARIO_USUARIO1`
    FOREIGN KEY (`USUARIO_idUsuario`)
    REFERENCES `youtube_db`.`USUARIO` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MARCA_COMENTARIO_COMENTARIO1`
    FOREIGN KEY (`COMENTARIO_idComentario`)
    REFERENCES `youtube_db`.`COMENTARIO` (`idComentario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

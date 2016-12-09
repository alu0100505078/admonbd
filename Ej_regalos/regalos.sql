-- MySQL Script generated by MySQL Workbench
-- 12/09/16 17:30:44
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTE` (
  `Codigo_cliente` INT NOT NULL AUTO_INCREMENT,
  `DNI` VARCHAR(9) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  PRIMARY KEY (`Codigo_cliente`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC));


-- -----------------------------------------------------
-- Table `mydb`.`CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CATEGORIA` (
  `Identificador` INT NOT NULL AUTO_INCREMENT,
  `Breve_descripcion` VARCHAR(45) NOT NULL,
  `Nombre_categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Identificador`));


-- -----------------------------------------------------
-- Table `mydb`.`REGALO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`REGALO` (
  `Numero_referencia` INT NOT NULL AUTO_INCREMENT,
  `Cantidad_articulo` INT NOT NULL,
  `Precio_unidad` INT NOT NULL,
  `CATEGORIA_Identificador` INT NOT NULL,
  PRIMARY KEY (`Numero_referencia`),
  INDEX `fk_REGALO_CATEGORIA1_idx` (`CATEGORIA_Identificador` ASC),
  CONSTRAINT `fk_REGALO_CATEGORIA1`
    FOREIGN KEY (`CATEGORIA_Identificador`)
    REFERENCES `mydb`.`CATEGORIA` (`Identificador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`RECIBE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RECIBE` (
  `Dia` DATETIME NOT NULL,
  `Dedicatoria` VARCHAR(45) NOT NULL,
  `REGALO_Numero_referencia` INT NOT NULL,
  PRIMARY KEY (`Dia`, `REGALO_Numero_referencia`),
  INDEX `fk_RECIBE_REGALO1_idx` (`REGALO_Numero_referencia` ASC),
  CONSTRAINT `fk_RECIBE_REGALO1`
    FOREIGN KEY (`REGALO_Numero_referencia`)
    REFERENCES `mydb`.`REGALO` (`Numero_referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`RECEPTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RECEPTOR` (
  `Id_regalo` INT NOT NULL,
  `Nombre` VARCHAR(30) NULL,
  `Apellido` VARCHAR(30) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Codigo_postal` INT NULL,
  `Provincia` VARCHAR(45) NULL,
  `Telefono` INT NULL,
  `RECIBE_Dia` DATETIME NOT NULL,
  `RECIBE_REGALO_Numero_referencia` INT NOT NULL,
  PRIMARY KEY (`Id_regalo`),
  INDEX `fk_RECEPTOR_RECIBE1_idx` (`RECIBE_Dia` ASC, `RECIBE_REGALO_Numero_referencia` ASC),
  CONSTRAINT `fk_RECEPTOR_RECIBE1`
    FOREIGN KEY (`RECIBE_Dia` , `RECIBE_REGALO_Numero_referencia`)
    REFERENCES `mydb`.`RECIBE` (`Dia` , `REGALO_Numero_referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`PREFERENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PREFERENCIA` (
  `RECEPTOR_Id_regalo` INT NOT NULL,
  `REGALO_Numero_referencia` INT NOT NULL,
  INDEX `fk_PREFERENCIA_RECEPTOR1_idx` (`RECEPTOR_Id_regalo` ASC),
  INDEX `fk_PREFERENCIA_REGALO1_idx` (`REGALO_Numero_referencia` ASC),
  CONSTRAINT `fk_PREFERENCIA_RECEPTOR1`
    FOREIGN KEY (`RECEPTOR_Id_regalo`)
    REFERENCES `mydb`.`RECEPTOR` (`Id_regalo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PREFERENCIA_REGALO1`
    FOREIGN KEY (`REGALO_Numero_referencia`)
    REFERENCES `mydb`.`REGALO` (`Numero_referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`REGALA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`REGALA` (
  `CLIENTE_Codigo_cliente` INT NOT NULL,
  `RECEPTOR_Id_regalo` INT NOT NULL,
  PRIMARY KEY (`CLIENTE_Codigo_cliente`),
  INDEX `fk_REGALA_RECEPTOR1_idx` (`RECEPTOR_Id_regalo` ASC),
  CONSTRAINT `fk_REGALA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_Codigo_cliente`)
    REFERENCES `mydb`.`CLIENTE` (`Codigo_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REGALA_RECEPTOR1`
    FOREIGN KEY (`RECEPTOR_Id_regalo`)
    REFERENCES `mydb`.`RECEPTOR` (`Id_regalo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

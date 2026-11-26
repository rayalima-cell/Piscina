-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PISCINA` DEFAULT CHARACTER SET utf8 ;
USE `PISCINA` ;

-- -----------------------------------------------------
-- Table `mydb`.`Responsavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PISCINA`.`Responsavel` (
  `idResponsavel` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `CPF` VARBINARY(255) NULL,
  `Email` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NULL,
  PRIMARY KEY (`idResponsavel`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Filhos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PISCINA`.`Filhos` (
  `idFilhos` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `data_nascimento` VARCHAR(45) NULL,
  `nive_natacao` VARCHAR(45) NULL,
  `Responsavel_idResponsavel` INT NOT NULL,
  PRIMARY KEY (`idFilhos`),
  INDEX `fk_Filhos_Responsavel_idx` (`Responsavel_idResponsavel` ASC) VISIBLE,
  CONSTRAINT `fk_Filhos_Responsavel`
    FOREIGN KEY (`Responsavel_idResponsavel`)
    REFERENCES `mydb`.`Responsavel` (`idResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PISCINA`.`Aula` (
  `idAula` INT NOT NULL,
  `nome_professor` VARCHAR(45) NULL,
  `data_horario` VARCHAR(45) NULL,
  `Filhos_idFilhos` INT NOT NULL,
  PRIMARY KEY (`idAula`),
  INDEX `fk_Aula_Filhos1_idx` (`Filhos_idFilhos` ASC) VISIBLE,
  CONSTRAINT `fk_Aula_Filhos1`
    FOREIGN KEY (`Filhos_idFilhos`)
    REFERENCES `mydb`.`Filhos` (`idFilhos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PISCINA`.`Usuarios` (
  `idUsuarios` INT NOT NULL,
  `login` VARCHAR(100) NULL,
  `nome` VARCHAR(45) NULL,
  `senha` VARCHAR(64) NULL,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

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
CREATE SCHEMA IF NOT EXISTS `Piscina` DEFAULT CHARACTER SET utf8 ;
USE `Piscina` ;

-- -----------------------------------------------------
-- Table `mydb`.`Responsavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Piscina`.`Responsavel` (
  `idResponsavel` INT auto_increment NOT NULL,
  `nome` VARCHAR(45) NULL,
  `CPF` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NULL,
  PRIMARY KEY (`idResponsavel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Filhos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Piscina`.`Filhos` (
  `idFilhos` INT auto_increment NOT NULL,
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
CREATE TABLE IF NOT EXISTS `piscina`.`Aula` (
  `idAula` INT  auto_increment NOT NULL,
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
CREATE TABLE IF NOT EXISTS `piscina`.`Usuarios` (
  `idUsuarios` INT  auto_increment NOT NULL,
  `login` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  `senha` VARCHAR(45) NULL,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB;

INSERT INTO Responsavel(nome, CPF, Email, Telefone) VALUES 
('Helena Souza','111.222.333-44', 'helena@email.com', '(48) 999990001'), 
('Igor Martins','222.333.444-55', 'igor@email.com', '(48) 999990002'), 
('Joana Lima',  '333.444.555-66', 'joana@email.com', '(48) 999990003');

select * from Responsavel;

INSERT INTO Filhos(Nome, data_nascimento, nive_natacao, Responsavel_idResponsavel) VALUES 
('Marina', '12-06-2008', 'Não sabe nada', 1),
('Tiego', '14-04-2009', 'Sabe nada mais é muito pouco', 2),
('Isabela', '16-09-2009', 'Sabe nada mais é muito pouco', 3);

select * from Filhos;

INSERT INTO Aula(nome_professor, data_horario, Filhos_idFilhos) VALUES 
('Miriã', '2026-11-18 09:00:00', 1),
('Gabriel', '2026-11-18 13:00:00', 2),
('Julia', '2026-11-18 14:00:00', 3);

select * from Aula;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

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
  `idResponsavel` int auto_increment PRIMARY KEY,
  `nome` VARCHAR(45) NULL,
  `CPF` VARBINARY(255) NOT NULL UNIQUE,
  `Email` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NULL,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Filhos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PISCINA`.`Filhos` (
  `idFilhos` INT NOT NULL auto_increment,
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
  `idAula` INT NOT NULL auto_increment,
  `nome_professor` VARCHAR(45) NULL,
  `data_aula` date not null,
  `horario` time not null,
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
  `idUsuarios` INT NOT NULL auto_increment,
  `login` VARCHAR(100) NOT NULL UNIQUE,
  `nome` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(64) NULL,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB;

INSERT INTO Responsavel( nome, CPF, Email, Telefone) VALUES 
( 'HelenA Souza', aes_encrypt('111.222.333-44', 'senha123'),  'helena@email.com', '(48) 999990001'), 
( 'Igor Martins', AES_ENCRYPT('222.333.444-55', 'senha123'), 'igor@email.com', '(48) 999990002'), 
( 'Joana Lima',   AES_ENCRYPT('333.444.555-66', 'senha123'), 'joana@email.com', '(48) 999990003');

INSERT INTO Filhos(Nome, data_nascimento, nive_natacao, Responsavel_idResponsavel) VALUES 
( 'Maria Souza', '2026-11-03', 'Baixo do esperado', 1), 
( 'Samuel Martins',  '2026-11-04', 'Mediano', 2), 
( 'Miriã Lima',  '2026-11-05', 'Acima do esperado', 3);

INSERT INTO Usuarios(login, nome, senha) VALUES 
('admin', 'Administrador', sha2('123', 256)), 
('helena', 'HelenA Souza', sha2('123', 256)), 
('igor', 'Igor Martins', sha2('123', 256)),
('joana', 'Joana Lima', sha2('123', 256));

select * from Responsavel;
select * from Filhos;
select * from Aula;
select * from Usuarios;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Script generated by MySQL Workbench
-- Fri 19 Feb 2016 11:25:18 AM EST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projects` ;

CREATE TABLE IF NOT EXISTS `projects` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NOT NULL COMMENT '',
  `created_at` DATETIME NOT NULL COMMENT '',
  `modified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `types` ;

CREATE TABLE IF NOT EXISTS `types` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NOT NULL COMMENT '',
  `created_at` DATETIME NOT NULL COMMENT '',
  `modified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filesystems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filesystems` ;

CREATE TABLE IF NOT EXISTS `filesystems` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `project_id` INT(11) NOT NULL COMMENT '',
  `type_id` INT(11) NOT NULL COMMENT '',
  `name` VARCHAR(45) NOT NULL COMMENT '',
  `hostname` VARCHAR(45) NOT NULL COMMENT '',
  `current_storage` VARCHAR(45) NOT NULL COMMENT '',
  `alloc_storage` VARCHAR(45) NOT NULL COMMENT '',
  `total_storage` VARCHAR(45) NOT NULL COMMENT '',
  `path` VARCHAR(45) NOT NULL COMMENT '',
  `created_at` DATETIME NOT NULL COMMENT '',
  `modified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_filesystems_1_idx` (`project_id` ASC)  COMMENT '',
  INDEX `fk_filesystems_2_idx` (`type_id` ASC)  COMMENT '',
  CONSTRAINT `fk_filesystems_1`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_filesystems_2`
    FOREIGN KEY (`type_id`)
    REFERENCES `types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `slots`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slots` ;

CREATE TABLE IF NOT EXISTS `slots` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `filesystem_id` INT NULL COMMENT '',
  `name` VARCHAR(255) NOT NULL COMMENT '',
  `alloc_size` VARCHAR(45) NOT NULL COMMENT '',
  `current_size` VARCHAR(45) NOT NULL COMMENT '',
  `created_at` DATETIME NOT NULL COMMENT '',
  `modified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_slots_1_idx` (`filesystem_id` ASC)  COMMENT '',
  CONSTRAINT `fk_slots_1`
    FOREIGN KEY (`filesystem_id`)
    REFERENCES `filesystems` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

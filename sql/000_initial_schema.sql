-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema slots
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
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `index2` (`name` ASC)  COMMENT '')
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
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `index2` (`name` ASC)  COMMENT '')
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
  `size_used` BIGINT NOT NULL DEFAULT 0 COMMENT '',
  `size_total` BIGINT NOT NULL DEFAULT 0 COMMENT '',
  `path` VARCHAR(45) NOT NULL COMMENT '',
  `created_at` DATETIME NOT NULL COMMENT '',
  `modified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_filesystems_1_idx` (`project_id` ASC)  COMMENT '',
  INDEX `fk_filesystems_2_idx` (`type_id` ASC)  COMMENT '',
  INDEX `index4` (`name` ASC)  COMMENT '',
  INDEX `index5` (`hostname` ASC)  COMMENT '',
  UNIQUE INDEX `index6` (`name` ASC, `hostname` ASC)  COMMENT '',
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
  `filesystem_id` INT NOT NULL COMMENT '',
  `name` VARCHAR(255) NOT NULL COMMENT '',
  `size` VARCHAR(45) NOT NULL COMMENT '',
  `created_at` DATETIME NOT NULL COMMENT '',
  `modified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_slots_1_idx` (`filesystem_id` ASC)  COMMENT '',
  UNIQUE INDEX `index3` (`name` ASC, `filesystem_id` ASC)  COMMENT '',
  CONSTRAINT `fk_slots_1`
    FOREIGN KEY (`filesystem_id`)
    REFERENCES `filesystems` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `types`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `types` (`id`, `name`, `created_at`, `modified_at`) VALUES (DEFAULT, 'nfs', DEFAULT, DEFAULT);

COMMIT;


-- MySQL Script generated by MySQL Workbench
-- Sun May  7 11:14:33 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LibraryVlocka
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LibraryVlocka
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LibraryVlocka` DEFAULT CHARACTER SET utf8 ;
USE `LibraryVlocka` ;

-- -----------------------------------------------------
-- Table `LibraryVlocka`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`languages` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `language` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`books` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `languages_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `relase` YEAR NOT NULL,
  `ISBN` VARCHAR(20) NULL,
  `pages` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_languages1_idx` (`languages_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `LibraryVlocka`.`languages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`countries` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`authors` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `countries_id` INT UNSIGNED NOT NULL,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `bday` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_author_countries1_idx` (`countries_id` ASC) VISIBLE,
  CONSTRAINT `fk_author_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `LibraryVlocka`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`room` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `created` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`pickup_dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`pickup_dates` (
  `id` INT NOT NULL,
  `pickup` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`reservations` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `pickup_dates_id` INT NOT NULL,
  `book_id` BIGINT UNSIGNED NOT NULL,
  `duration_of_borow` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reservation_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_reservations_pickup_dates1_idx` (`pickup_dates_id` ASC) VISIBLE,
  INDEX `fk_reservations_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_reservation_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `LibraryVlocka`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservations_pickup_dates1`
    FOREIGN KEY (`pickup_dates_id`)
    REFERENCES `LibraryVlocka`.`pickup_dates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservations_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `LibraryVlocka`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`books_has_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`books_has_authors` (
  `book_id` BIGINT UNSIGNED NOT NULL,
  `author_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `author_id`),
  INDEX `fk_book_has_author_author1_idx` (`author_id` ASC) VISIBLE,
  INDEX `fk_book_has_author_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_author_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `LibraryVlocka`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `LibraryVlocka`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`genres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`books_has_genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`books_has_genres` (
  `book_id` BIGINT UNSIGNED NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `genre_id`),
  INDEX `fk_book_has_genres_genres1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `fk_book_has_genres_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_genres_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `LibraryVlocka`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_genres_genres1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `LibraryVlocka`.`genres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`book_has_reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`book_has_reservation` (
  `book_id` BIGINT UNSIGNED NOT NULL,
  `reservation_id` BIGINT NOT NULL,
  PRIMARY KEY (`book_id`, `reservation_id`),
  INDEX `fk_book_has_reservation_reservation1_idx` (`reservation_id` ASC) VISIBLE,
  INDEX `fk_book_has_reservation_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_reservation_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `LibraryVlocka`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_reservation_reservation1`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `LibraryVlocka`.`reservations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`rating` (
  `stars` TINYINT(5) NOT NULL,
  `book_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `user_id`),
  INDEX `fk_rating_book1_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_rating_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_rating_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `LibraryVlocka`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `LibraryVlocka`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryVlocka`.`bookhvezda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibraryVlocka`.`bookhvezda` (
  `book` INT NOT NULL,
  PRIMARY KEY (`book`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

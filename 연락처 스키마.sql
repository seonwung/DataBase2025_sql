CREATE TABLE IF NOT EXISTS `numberbook`.`contact` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `profile_url` VARCHAR(255) NULL,
  `meno` TEXT NULL,
  `is_favorite` TINYINT NULL DEFAULT  FALSE,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp,
  PRIMARY KEY (`contact_id`));
  
  CREATE TABLE IF NOT EXISTS `numberbook`.`contact_channel` (
  `channel_id` INT NOT NULL AUTO_INCREMENT,
  `contact_id` INT NOT NULL,
  `type` ENUM('phone', 'email', 'im', 'url', 'address') NOT NULL,
  `label` VARCHAR(45) NULL,
  `value` VARCHAR(200) NOT NULL,
  `is_primary` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`channel_id`),
  INDEX `fk_contact_channel_contact_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `fk_contact_channel_contact`
    FOREIGN KEY (`contact_id`)
    REFERENCES `numberbook`.`contact` (`contact_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
    CREATE TABLE IF NOT EXISTS `numberbook`.`contact_group` (
  `group_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);
  
  CREATE TABLE IF NOT EXISTS `numberbook`.`contact_group_map` (
  `contact_contact_id` INT NOT NULL,
  `contact_group_group_id` INT NOT NULL,
  INDEX `fk_contact_group_map_contact1_idx` (`contact_contact_id` ASC) VISIBLE,
  INDEX `fk_contact_group_map_contact_group1_idx` (`contact_group_group_id` ASC) VISIBLE,
  PRIMARY KEY (`contact_contact_id`, `contact_group_group_id`),
  CONSTRAINT `fk_contact_group_map_contact1`
    FOREIGN KEY (`contact_contact_id`)
    REFERENCES `numberbook`.`contact` (`contact_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_group_map_contact_group1`
    FOREIGN KEY (`contact_group_group_id`)
    REFERENCES `numberbook`.`contact_group` (`group_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


    
    
    
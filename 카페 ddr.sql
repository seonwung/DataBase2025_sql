CREATE TABLE IF NOT EXISTS `cafe`.`menu_item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `name_ko` VARCHAR(45) NOT NULL,
  `description_ko` TEXT NULL,
  `description_en` TEXT NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`));
  CREATE TABLE IF NOT EXISTS `cafe`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `parent_id` INT NULL,
  `name_ko` VARCHAR(45) NOT NULL,
  `name_en` VARCHAR(45) NULL,
  `sort_order` INT NULL DEFAULT 0,
  PRIMARY KEY (`category_id`),
  INDEX `fk_category_parent_idx` (`parent_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `cafe`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    CREATE TABLE IF NOT EXISTS `cafe`.`menu_item_category` (
  `category_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  INDEX `fk_menu_item_category_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_menu_item_category_menu_item1_idx` (`item_id` ASC) VISIBLE,
  PRIMARY KEY (`category_id`, `item_id`),
  CONSTRAINT `fk_menu_item_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `cafe`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_item_category_menu_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `cafe`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    CREATE TABLE IF NOT EXISTS `cafe`.`availability` (
  `item_id` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  INDEX `fk_availability_menu_item1_idx` (`item_id` ASC) VISIBLE,
  PRIMARY KEY (`item_id`),
  CONSTRAINT `fk_availability_menu_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `cafe`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    CREATE TABLE IF NOT EXISTS `cafe`.`image` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `url` VARCHAR(45) NOT NULL,
  `discrible_text` TEXT NULL,
  `sort_order` INT NULL DEFAULT 0,
  PRIMARY KEY (`image_id`),
  INDEX `fk_image_menu_item1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_image_menu_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `cafe`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    CREATE TABLE IF NOT EXISTS `cafe`.`nutrition` (
  `item_id` INT NOT NULL,
  `serving_size` INT NULL,
  `kcal` INT NULL,
  `sugar_g` DECIMAL(5,2) NULL,
  `protein_g` DECIMAL(5,2) NULL,
  `fat_g` DECIMAL(5,2) NULL,
  `sodium_mg` INT NULL,
  `caffein_mg` INT NULL,
  INDEX `fk_nutrition_menu_item1_idx` (`item_id` ASC) VISIBLE,
  PRIMARY KEY (`item_id`),
  CONSTRAINT `fk_nutrition_menu_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `cafe`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `cafe`.`allergen` (
  `allergen_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`allergen_id`));
  CREATE TABLE IF NOT EXISTS `cafe`.`menu_item_allergen` (
  `item_id` INT NOT NULL,
  `allergen_id` INT NOT NULL,
  INDEX `fk_menu_item_allergen_menu_item1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_menu_item_allergen_allergen1_idx` (`allergen_id` ASC) VISIBLE,
  PRIMARY KEY (`item_id`, `allergen_id`),
  CONSTRAINT `fk_menu_item_allergen_menu_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `cafe`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_item_allergen_allergen1`
    FOREIGN KEY (`allergen_id`)
    REFERENCES `cafe`.`allergen` (`allergen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    CREATE TABLE IF NOT EXISTS `cafe`.`size` (
  `size_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `ml` INT NULL,
  `sort_order` INT NULL DEFAULT 0,
  PRIMARY KEY (`size_id`));
  CREATE TABLE IF NOT EXISTS `cafe`.`temperature` (
  `temperature_id` INT NOT NULL AUTO_INCREMENT,
  `name` ENUM('HOT', 'ICE') NOT NULL,
  `sort_order` INT NULL DEFAULT 0,
  PRIMARY KEY (`temperature_id`));
  CREATE TABLE IF NOT EXISTS `cafe`.`menu_price` (
  `price_id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `temperature_id` INT NOT NULL,
  `size_id` INT NOT NULL,
  `price` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL DEFAULT '2999-12-31',
  PRIMARY KEY (`price_id`),
  INDEX `fk_menu_price_menu_item1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_menu_price_temperature1_idx` (`temperature_id` ASC) VISIBLE,
  INDEX `fk_menu_price_size1_idx` (`size_id` ASC) VISIBLE,
  UNIQUE INDEX `uq_price` (`item_id` ASC, `size_id` ASC, `temperature_id` ASC, `start_date` ASC, `end_date` ASC) INVISIBLE,
  CONSTRAINT `fk_menu_price_menu_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `cafe`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_price_temperature1`
    FOREIGN KEY (`temperature_id`)
    REFERENCES `cafe`.`temperature` (`temperature_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_price_size1`
    FOREIGN KEY (`size_id`)
    REFERENCES `cafe`.`size` (`size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    CREATE TABLE IF NOT EXISTS `cafe`.`option_group` (
  `group_id` INT NOT NULL AUTO_INCREMENT,
  `name_ko` VARCHAR(50) NOT NULL,
  `multi_select` TINYINT NOT NULL DEFAULT 0,
  `sort_order` INT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`));
  CREATE TABLE IF NOT EXISTS `cafe`.`option_item` (
  `option_id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `name_ko` VARCHAR(100) NOT NULL,
  `extra_price` INT NOT NULL DEFAULT 0,
  `is_default` TINYINT NULL DEFAULT 0,
  `sort_order` INT NULL DEFAULT 0,
  PRIMARY KEY (`option_id`),
  INDEX `fk_option_item_option_group1_idx` (`group_id` ASC) VISIBLE,
  CONSTRAINT `fk_option_item_option_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `cafe`.`option_group` (`group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    CREATE TABLE IF NOT EXISTS `cafe`.`menu_item_option_rule` (
  `item_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `min_select` INT NOT NULL DEFAULT 0,
  `max_select` INT NOT NULL DEFAULT 1,
  INDEX `fk_menu_item_option_rul_menu_item1_idx` (`item_id` ASC) VISIBLE,
  PRIMARY KEY (`item_id`, `group_id`),
  INDEX `fk_menu_item_option_rul_option_group1_idx` (`group_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_item_option_rul_menu_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `cafe`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_item_option_rul_option_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `cafe`.`option_group` (`group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

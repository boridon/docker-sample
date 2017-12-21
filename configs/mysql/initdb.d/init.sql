CREATE DATABASE sample CHARACTER SET utf8mb4;
GRANT ALL PRIVILEGES ON sample.* TO 'sample'@'%';
CREATE TABLE sample.test (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` VARCHAR(60) NOT NULL COMMENT 'user name',
  `password` VARCHAR(200) NOT NULL COMMENT 'user password',
  `created_at` DATETIME NOT NULL COMMENT 'create datetime',
  `updated_at` DATETIME NULL COMMENT 'update datetime',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


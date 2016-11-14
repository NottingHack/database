CREATE TABLE `rfid_tags_migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `migrated_count` int(11) DEFAULT NULL,
  `active_count` int(11) DEFAULT NULL,
  `expired_count` int(11) DEFAULT NULL,
  `total_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

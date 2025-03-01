CREATE TABLE IF NOT EXISTS `utils_users` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `unique_id` VARCHAR(255) NOT NULL,
    `rank` ENUM('member', 'mod', 'admin', 'dev', 'owner') NOT NULL DEFAULT 'member',
    `vip` BOOLEAN NOT NULL DEFAULT 0,
    `priority` INT(11) NOT NULL DEFAULT 0,
    `character_slots` INT(11) NOT NULL DEFAULT 2,
    `license` VARCHAR(255) NOT NULL,
    `discord` VARCHAR(255),
    `tokens` JSON NOT NULL,
    `ip` VARCHAR(255) NOT NULL,
    `banned` BOOLEAN NOT NULL DEFAULT FALSE,
    `banned_by` VARCHAR(255) NOT NULL DEFAULT 'utils',
    `reason` TEXT DEFAULT NULL,
    `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `deleted` BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`unique_id`),
    KEY (`license`),
    KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `utils_bans` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `unique_id` VARCHAR(255) NOT NULL,
    `banned_by` VARCHAR(255) NOT NULL DEFAULT 'utils',
    `reason` TEXT DEFAULT NULL,
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `expires_at` TIMESTAMP NULL DEFAULT NULL,
    `expired` BOOLEAN NOT NULL DEFAULT FALSE,
    `appealed` BOOLEAN NOT NULL DEFAULT FALSE,
    `appealed_by` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


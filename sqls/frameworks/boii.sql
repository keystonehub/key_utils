CREATE TABLE IF NOT EXISTS `player_skills` (
    `identifier` VARCHAR(255) NOT NULL,
    `skills` JSON DEFAULT '{}',
    CONSTRAINT `fk_player_skills_players` FOREIGN KEY (`identifier`)
    REFERENCES `players` (`identifier`) ON DELETE CASCADE,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_reputation` (
    `identifier` VARCHAR(255) NOT NULL,
    `reputation` JSON DEFAULT '{}',
    CONSTRAINT `fk_player_reputation_players` FOREIGN KEY (`identifier`)
    REFERENCES `players` (`identifier`) ON DELETE CASCADE,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_licences` (
    `identifier` VARCHAR(255) NOT NULL,
    `licences` JSON DEFAULT '{}',
    CONSTRAINT `fk_player_licences_players` FOREIGN KEY (`identifier`)
    REFERENCES `players` (`identifier`) ON DELETE CASCADE,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

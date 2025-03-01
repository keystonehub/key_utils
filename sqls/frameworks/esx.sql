CREATE TABLE IF NOT EXISTS `player_skills` (
    `identifier` varchar(60) NOT NULL,
    `skills` json DEFAULT '{}',
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_reputation` (
    `identifier` varchar(60) NOT NULL,
    `reputation` json DEFAULT '{}',
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_licences` (
    `identifier` varchar(60) NOT NULL,
    `licences` json DEFAULT '{}',
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

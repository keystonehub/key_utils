CREATE TABLE IF NOT EXISTS `player_skills` (
    `citizenid` varchar(50) NOT NULL,
    `skills` json DEFAULT '{}',
    PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_reputation` (
    `citizenid` varchar(50) NOT NULL,
    `reputation` json DEFAULT '{}',
    PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_licences` (
    `citizenid` varchar(50) NOT NULL,
    `licences` json DEFAULT '{}',
    PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
USE herodb;
CREATE TABLE IF NOT EXISTS heroes(
    hero_id INT NOT NULL AUTO_INCREMENT,
    hero_name VARCHAR(64) NOT NULL,
    PRIMARY KEY (hero_id)
);
DROP DATABASE IF EXISTS home_work05;
CREATE DATABASE IF NOT EXISTS home_work05;

USE home_work05;

DROP TABLE IF EXISTS cars;
CREATE TABLE cars (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(45),
    Cost INT
);

INSERT INTO cars (`Name`, Cost)
VALUES
	('Audi', 52642),
    ('Mercedes', 57127),
    ('Skoda', 9000),
    ('Volvo', 29000),
    ('Bentley', 35000),
    ('Citroen', 21000),
    ('Hummer', 41400),
    ('Volkswagen', 21600);
    
SELECT * FROM cars;

-- 1 Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE VIEW v1_cars
AS
SELECT * 
FROM cars
WHERE Cost < 25000
ORDER BY Cost ASC;

SELECT * FROM v1_cars;

-- 2 Изменить в существующем представлении порог для стоимости:
-- пусть цена будет до 30 000 долларов (используя оператор OR REPLACE) 

CREATE OR REPLACE VIEW v1_cars
AS
SELECT * 
FROM cars
WHERE Cost < 30000
ORDER BY Cost ASC;

SELECT * FROM v1_cars;

-- 3 Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW v2_cars
AS
SELECT * 
FROM cars
WHERE `Name` IN ('Skoda', 'Audi');

SELECT * FROM v2_cars;

-- 4. Добавьте в таблицу новый столбец под названием «время до следующей станции»

DROP TABLE IF EXISTS train_schedule;
CREATE TABLE IF NOT EXISTS train_schedule (
	train_id INT NOT NULL,
    station VARCHAR(20) NOT NULL,
    station_time TIME NOT NULL
);

INSERT INTO train_schedule (train_id, station, station_time)
VALUES
	(110, 'San Francisco', '10:00:00'),
    (110, 'Redwood City', '10:54:00'),
    (110, 'Palo Alto', '11:02:00'),
    (110, 'San Jose', '12:35:00'),
    (120, 'San Francisco', '11:00:00'),
    (120, 'Palo Alto', '12:49:00'),
    (120, 'San Jose', '13:30:00');
    
SELECT * FROM train_schedule;

SELECT 
	train_id,
    station,
    station_time,
    TIMEDIFF(LEAD(station_time) OVER (PARTITION BY train_id order by station_time), station_time) AS time_to_next_station
FROM train_schedule;
    

    
    

    
    
    

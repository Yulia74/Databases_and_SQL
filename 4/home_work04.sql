DROP DATABASE IF EXISTS home_work04;
CREATE DATABASE IF NOT EXISTS home_work04;
USE home_work04;

DROP TABLE IF EXISTS shops;
CREATE TABLE shops (
	`id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `cats`;
CREATE TABLE `cats` (
	`name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES `shops` (id)
);

INSERT INTO `shops`
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);
        
-- 1.1 Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
SELECT
	c.id AS 'id котика',
	c.name AS 'Котик',
    s.id AS 'id магазина',
    s.shopname AS 'Магазин'
FROM cats c
JOIN shops s
ON s.id = c.shops_id;

-- 1.2a Вывести магазин, в котором продается кот “Murzik”. С помощью фильтра “WHERE”
SELECT
	c.name AS 'Котик',
    s.id AS 'id магазина',
    s.shopname AS 'Магазин'
FROM cats c
JOIN shops s
ON s.id = c.shops_id
WHERE c.name = 'Murzik';

-- 1.2b Вывести магазин, в котором продается кот “Murzik”. С помощью подзапроса (вложенного SELECTа)
SELECT 
	s.id AS 'id магазина',
    s.shopname AS 'Магазин',
	cat_Murzik.name AS 'Котик'
FROM shops s
JOIN (SELECT id, `name` FROM cats
WHERE `name` = 'Murzik') cat_Murzik
ON s.id = cat_Murzik.id;

-- 1.3 Вывести магазины, в которых НЕ продаются коты “Murzik” и “Zuza”
SELECT
	s.shopname  
FROM shops s
LEFT JOIN cats c 
ON s.id = c.shops_id AND (c.name = 'Murzik' OR c.name = 'Zuza')
WHERE c.name IS NULL; 

-- Второе задание, таблица:

DROP TABLE IF EXISTS Analysis;

CREATE TABLE Analysis
(
	an_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	an_name varchar(50),
	an_cost INT,
	an_price INT,
	an_group INT
);

INSERT INTO analysis (an_name, an_cost, an_price, an_group)
VALUES 
	('Общий анализ крови', 30, 50, 1),
	('Биохимия крови', 150, 210, 1),
	('Анализ крови на глюкозу', 110, 130, 1),
	('Общий анализ мочи', 25, 40, 2),
	('Общий анализ кала', 35, 50, 2),
	('Общий анализ мочи', 25, 40, 2),
	('Тест на COVID-19', 160, 210, 3);

DROP TABLE IF EXISTS GroupsAn;

CREATE TABLE GroupsAn
(
	gr_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	gr_name varchar(50),
	gr_temp FLOAT(5,1),
	FOREIGN KEY (gr_id) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO groupsan (gr_name, gr_temp)
VALUES 
	('Анализы крови', -12.2),
	('Общие анализы', -20.0),
	('ПЦР-диагностика', -20.5);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
	ord_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ord_datetime DATETIME,	-- 'YYYY-MM-DD hh:mm:ss'
	ord_an INT,
	FOREIGN KEY (ord_an) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Orders (ord_datetime, ord_an)
VALUES 
	('2020-02-04 07:15:25', 1),
	('2020-02-04 07:20:50', 2),
	('2020-02-04 07:30:04', 1),
	('2020-02-04 07:40:57', 1),
	('2020-02-05 07:05:14', 1),
	('2020-02-05 07:15:15', 3),
	('2020-02-05 07:30:49', 3),
	('2020-02-06 07:10:10', 2),
	('2020-02-06 07:20:38', 2),
	('2020-02-07 07:05:09', 1),
	('2020-02-07 07:10:54', 1),
	('2020-02-07 07:15:25', 1),
	('2020-02-08 07:05:44', 1),
	('2020-02-08 07:10:39', 2),
	('2020-02-08 07:20:36', 1),
	('2020-02-08 07:25:26', 3),
	('2020-02-09 07:05:06', 1),
	('2020-02-09 07:10:34', 1),
	('2020-02-09 07:20:19', 2),
	('2020-02-10 07:05:55', 3),
	('2020-02-10 07:15:08', 3),
	('2020-02-10 07:25:07', 1),
	('2020-02-11 07:05:33', 1),
	('2020-02-11 07:10:32', 2),
	('2020-02-11 07:20:17', 3),
	('2020-02-12 07:05:36', 1),
	('2020-02-12 07:10:54', 2),
	('2020-02-12 07:20:19', 3),
	('2020-02-12 07:35:38', 1);
   
-- 2. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
SELECT 
	o.ord_id AS 'id заказа',
	a.an_name AS 'Название анализа',
    a.an_cost AS 'Цена',
    o.ord_datetime AS 'Дата проведения'
FROM analysis a
JOIN orders o
ON a.an_id = o.ord_an
WHERE o.ord_datetime BETWEEN '2020-02-05' AND '2020-02-12'
ORDER BY o.ord_datetime;


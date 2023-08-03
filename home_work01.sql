-- 1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными

CREATE DATABASE IF NOT EXISTS home_work01;
USE home_work01;

DROP TABLE IF EXISTS mobile_phone;
CREATE TABLE mobile_phone
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(45),
	Manufacturer VARCHAR(45),
	ProductCount INT,
	Price INT
);

INSERT mobile_phone (ProductName, Manufacturer, ProductCount, Price)
VALUES
	('iPhone X', 'Apple', 3, 76000),
    ('iPhone 8', 'Apple', 2, 51000),
    ('Galaxy S9', 'Samsung', 2, 56000),
    ('Galaxy S8', 'Samsung', 1, 41000),
    ('P20 Pro', 'Huawei', 5, 36000);

-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2 

SELECT ProductName, Manufacturer, Price
FROM mobile_phone
WHERE ProductCount > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”

SELECT ProductName
FROM mobile_phone
WHERE Manufacturer = 'Samsung';

-- 4. Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000**

SELECT * FROM mobile_phone
WHERE ProductCount * Price > 100000 AND ProductCount * Price < 145000;

-- 4.1 С помощью регулярных выражений найти товары, в которых есть упоминание "Iphone"
SELECT * FROM mobile_phone
WHERE Productname
LIKE 'Iphone%';

-- 4.2 Найти товары, в которых есть упоминание "Galaxy"
SELECT * FROM mobile_phone
WHERE Productname
LIKE 'Galaxy%';

-- 4.3 Найти товары, в которых есть ЦИФРЫ
SELECT * FROM mobile_phone
WHERE Productname
RLIKE '[:digit:]';

-- 4.4 Товары, в которых есть ЦИФРА "8"  
SELECT * FROM mobile_phone
WHERE Productname
RLIKE '[8]';




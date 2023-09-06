DROP DATABASE IF EXISTS home_work06;
CREATE DATABASE IF NOT EXISTS home_work06;

USE home_work06;

-- 1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'

DROP PROCEDURE IF EXISTS get_time;
DELIMITER $$ 
CREATE PROCEDURE get_time
(
	IN num INT,
    OUT format_time VARCHAR(100)
)

BEGIN
	DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
		
    SET format_time = "";  
    
    If num >= 86400 THEN
		SET days = num DIV (24 * 60 * 60);
        SET num = num % (24 * 60 * 60);
	END IF;

	IF num >= 3600 THEN
		SET hours = num DIV (60 * 60);
        SET num = num % (60 * 60);
	END IF;
    
    IF num >= 60 THEN
		SET minutes = num DIV 60;
        SET num = num % 60;
	END IF;
    
    SET format_time = CONCAT(
                    CAST(days AS CHAR), ' days  ',
                    CAST(hours AS CHAR), ' hours  ',
                    CAST(minutes AS CHAR), ' minuts  ',
                    CAST(num AS CHAR), ' seconds');
END ; 

CALL get_time(123456, @res);
SELECT @res;



-- 2. Выведите только четные числа от 1 до 10 (Через цикл).
-- Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS even_numbers;
DELIMITER //
CREATE PROCEDURE even_numbers()
BEGIN
    DECLARE x INT DEFAULT 1;
    DECLARE result VARCHAR(45) DEFAULT '';
    WHILE x <= 10 DO
        IF x % 2 = 0 THEN
            IF result = '' THEN
                SET result = x;
            ELSE
                SET result = CONCAT(result, ' ', x);
            END IF;
        END IF;
        SET x = x + 1;
    END WHILE;
    SELECT result;
END //
DELIMITER ;

CALL even_numbers();
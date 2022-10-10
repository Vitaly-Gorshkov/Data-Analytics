--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type
SELECT model, maker, type 
FROM product

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
SELECT *,
	CASE  
	    WHEN price > (SELECT avg(price) FROM pc) THEN '1'
	    ELSE '0'
	END AS flag
FROM printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
SELECT s.name AS name
FROM Ships AS s JOIN Classes AS c ON c.class = s.class
WHERE c.class IS NULL

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
WITH battle_top AS 
	(
	SELECT name, date_part('year', date) AS year
	FROM Battles
	)
SELECT * 
FROM battle_top
WHERE YEAR NOT IN (SELECT launched FROM Ships)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
SELECT battle
FROM Outcomes
WHERE ship IN (SELECT name FROM Ships WHERE class = 'Kongo')

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag
CREATE VIEW all_products_flag_300 AS 

WITH all_products AS
	(SELECT model, price 
 	FROM pc
 	UNION ALL
 	SELECT model, price  
 	FROM printer
 	UNION ALL
	SELECT model, price 
 	FROM laptop) 

SELECT p.model AS model, price,  
       CASE 
           WHEN price > 300 THEN '1'
           ELSE '0'
       END AS flag
FROM product AS p JOIN all_products AS b ON p.model = b.model

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
CREATE VIEW all_products_flag_avg_price AS 

WITH all_products AS
	(SELECT model, price 
 	FROM pc
 	UNION ALL
 	SELECT model, price  
 	FROM printer
 	UNION ALL
	SELECT model, price 
 	FROM laptop) 

SELECT p.model AS model, price,  
       CASE 
           WHEN price > (SELECT avg(price) FROM all_products) THEN '1'
           ELSE '0'
       END AS flag
FROM product AS p JOIN all_products AS b ON p.model = b.model

--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
WITH product_printer AS
	(SELECT  p.model AS model, price, maker
	FROM product AS pt JOIN printer AS pr  ON  pt.model = pr.model)

SELECT DISTINCT(model)
FROM product_printer
WHERE maker = 'A' AND price > (SELECT avg(price) FROM product_printer WHERE maker IN ('D', 'C'))

--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
WITH all_products AS
	(SELECT model, price 
 	FROM pc
 	UNION ALL
 	SELECT model, price  
 	FROM printer
 	UNION ALL
	SELECT model, price 
 	FROM laptop) 

SELECT DISTINCT(p.model)
FROM product AS p JOIN all_products AS all_p on p.model = all_p.model
WHERE maker = 'A' AND price > (SELECT avg(price) FROM product AS pt JOIN printer AS pr ON pt.model = pr.model WHERE maker IN ('D', 'C'))

--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
WITH all_pr AS
	(SELECT model, price 
 	FROM pc
 	UNION 
 	SELECT model, price  
 	FROM printer
    UNION 
	SELECT model, price 
 	FROM laptop) 
 
SELECT avg(price)
FROM product as p JOIN all_pr AS a ON p.model = a.model
WHERE maker = 'A'

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count
CREATE VIEW count_products_by_makers AS
SELECT maker, count(*) 
FROM product
GROUP BY maker
ORDER BY maker

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
CREATE TABLE printer_updated AS TABLE printer

DELETE FROM printer_updated WHERE model IN (SELECT model FROM product WHERE maker = 'D')

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)
CREATE VIEW printer_updated_with_makers AS

SELECT pr.*, p.maker
FROM printer_updated AS pr JOIN product AS pt ON pr.model = pt.model

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
CREATE VIEW sunk_ships_by_classes AS

WITH sunked AS
	(SELECT ship, class 
	FROM Outcomes AS o LEFT JOIN ships AS s ON o.ship=s.name 
	WHERE result = 'sunk'
	UNION 
	SELECT ship, class 
	FROM outcomes AS o LEFT JOIN classes AS c ON o.ship=c.class 
	WHERE result = 'sunk')
	
SELECT count(ship) AS count,
    	CASE 
	    WHEN class IS NULL THEN '0'
	    ELSE class
	END AS class
FROM sunked
GROUP BY class

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0
CREATE TABLE classes_with_flag AS

SELECT *,
      CASE 
          WHEN numguns >= 9 THEN '1'
          ELSE '0'
      END AS flag    
from Classes

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".
WITH names_shipsOM AS
	( 
	SELECT name
	FROM Ships 
	WHERE name LIKE 'O%' OR name LIKE 'M%'
	)
SELECT count(*) 
FROM names_shipsOM

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
WITH names_ships2 as
	( 
	SELECT *
	FROM Ships
	WHERE name LIKE '% %'
	)
SELECT count(*)
FROM names_ships2

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)

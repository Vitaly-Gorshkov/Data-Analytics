--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
SELECT class, count(*)
FROM Ships
WHERE name IN (SELECT ship FROM Outcomes WHERE result = 'sunk')
GROUP BY class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
WITH min_data_launched as
	(SELECT class, min(launched) AS min_data
	FROM Ships 
	GROUP BY class)

SELECT c.class AS class,
	CASE 
		WHEN s.launched IS NULL THEN m.min_data		
		ELSE s.launched
	END AS launched_first
FROM Classes AS C LEFT JOIN Ships AS s ON c.class = s.name LEFT JOIN min_data_launched AS m ON c.class = m.class

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
SELECT class, count(*)
FROM Ships
WHERE name IN (SELECT ship FROM Outcomes WHERE result = 'sunk') AND class IN (SELECT class FROM Ships GROUP BY class HAVING count(class) >= 3) 
GROUP BY class

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
WITH all_ships AS 
	(SELECT name, class 
	FROM Ships
	UNION 
	SELECT ship AS name, ship AS class
	FROM Outcomes
	WHERE ship IN (SELECT class FROM Classes)),
	
	displ_numguns AS
	(SELECT  displacement, max(numGuns) AS max_guns
	FROM Classes	
	GROUP BY displacement)
	
SELECT al.name AS name, d.displacement AS displacement, d.max_guns AS max_guns
FROM Classes AS c join all_ships AS a ON c.class = a.class JOIN displ_numguns AS d ON d.displacement = c.displacement AND d.max_guns = c.numGuns 
ORDER BY c.displacement DESC

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
SELECT maker
FROM product 
WHERE TYPE = 'Printer'
AND maker IN (SELECT maker FROM pc AS p JOIN product AS pr ON p.model = pr.model WHERE ram = (SELECT min(ram) FROM pc)
			  UNION ALL
			  SELECT maker FROM pc AS p JOIN product AS pr ON p.model = pr.model WHERE speed = (SELECT max(speed) FROM pc AS p JOIN product AS pr on p.model = pr.model WHERE ram = (SELECT min(ram) FROM pc)))
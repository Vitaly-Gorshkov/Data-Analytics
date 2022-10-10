--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
SELECT name, class
FROM Ships 
WHERE launched > 1920

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
SELECT name, class
FROM Ships 
WHERE launched > 1920 AND launched < 1942

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
SELECT class, count(name) 
FROM Ships
GROUP BY class

-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
SELECT class, country
FROM Classes
WHERE bore >= 16

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
SELECT ship
FROM Outcomes
WHERE battle = 'North Atlantic' AND result = 'sunk'

-- Задание 6: Вывести название (ship) последнего потопленного корабля
SELECT o.ship AS name
FROM Outcomes AS o JOIN Battles AS b ON o.battle = b.name
WHERE  result = 'sunk' AND date = (SELECT  max(date)
		   FROM Outcomes AS o JOIN Battles AS b ON o.battle = b.name
		   WHERE RESULT = 'sunk')

-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
SELECT o.ship AS name, s.class AS class
FROM Outcomes AS o JOIN Battles AS b ON o.battle = b.name LEFT JOIN ships AS s ON o.ship = s.name
WHERE  result = 'sunk' AND date = (SELECT  max(date)
		   FROM Outcomes AS o JOIN Battles AS b ON o.battle = b.name
		   WHERE RESULT = 'sunk')

-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
SELECT o.ship AS ship, c.class AS class
FROM Outcomes AS o JOIN Battles AS b ON o.battle = b.name LEFT JOIN Ships AS s ON o.ship = s.name LEFT JOIN Classes AS c ON s.class = c.class
WHERE o.result = 'sunk' AND c.bore >= 16

-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
SELECT class
FROM Classes
WHERE country = 'USA'

-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
SELECT s.name AS name, s.class AS class
FROM Classes AS c JOIN Ships AS s ON s.class = c.class
WHERE country = 'USA'	

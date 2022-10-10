--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

sample:
1 1
2 1
1 2
2 2
1 3
2 3

CREATE VIEW pages_all_products AS
SELECT code, model, speed, ram, hd, price, screen, 
    CASE WHEN num % 2 = 0 
      	THEN num/2 
      	ELSE num/2 + 1 
	END AS page_num, 
    CASE WHEN total % 2 = 0 
    	THEN total/2 
    	ELSE total/2 + 1 
    END AS num_of_pages
FROM (SELECT *, ROW_NUMBER(*) OVER(ORDER BY model DESC) AS num, count(*) OVER() AS total FROM Laptop) AS A

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель, тип, процент (%)
CREATE VIEW distribution_by_type AS
SELECT maker, TYPE, count(*) * 100.0 / (SELECT count(*) FROM product) AS percent
FROM product
GROUP BY maker, type
ORDER BY maker

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов
CREATE TABLE ships_two_words AS
SELECT *
FROM ships
WHERE name LIKE '% %'

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"
SELECT *
FROM ships
WHERE class IS NULL AND name LIKE 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model
(SELECT pr.model AS model
FROM product as pt join printer AS pr ON pt.model = pr.model
WHERE maker = 'A' AND price > (SELECT avg(price) FROM product AS pt JOIN printer AS pr ON pt.model = pr.model WHERE maker = 'D') 
)
UNION ALL
(SELECT model
FROM (SELECT p.model AS model, ROW_NUMBER(*) OVER(PARTITION BY pt.type ORDER BY price DESC) AS money
	FROM product AS pt JOIN printer AS pr ON  pt.model = pr.model) AS A
WHERE money <= 3)

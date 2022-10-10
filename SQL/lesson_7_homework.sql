--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
SELECT email 
FROM (SELECT email, count(email) AS count FROM Person GROUP BY email) AS a
WHERE count > 1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
SELECT a.name AS Employee
FROM Employee AS a,Employee AS b
WHERE a.managerId = b.Id AND a.salary > b.salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM Scores


--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
SELECT firstName, lastName, city, state
FROM Person as p LEFT JOIN Address AS a ON p.personId = a.personId

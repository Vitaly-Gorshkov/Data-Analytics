--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
WITH employee_rank AS
(SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary, DENSE_RANK() OVER (PARTITION BY d.id ORDER by e.salary DESC) AS rank
FROM Employee AS e JOIN Department as d ON e.departmentId = d.id)       
        
SELECT Department, Employee, Salary
FROM employee_rank
WHERE rank <= 3

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
SELECT member_name, status, sum(amount*unit_price) AS costs
FROM FamilyMembers AS F JOIN Payments AS P ON F.member_id = P.family_member
WHERE P.date BETWEEN '2005-01-01' AND '2006-01-01'
GROUP BY member_name, status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
SELECT name
FROM Passenger
GROUP BY name
HAVING count(*) > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
SELECT count(first_name) as count
FROM Student
WHERE first_name = 'Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
SELECT COUNT(classroom) as count
FROM Schedule
WHERE date = '2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
SELECT count(first_name) as count
FROM Student
WHERE first_name = 'Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
SELECT round(avg(TIMESTAMPDIFF(YEAR, birthday, CURDATE())),0) AS age
FROM FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
SELECT good_type_name, sum(amount * unit_price) AS costs
FROM Goods AS  g JOIN Payments AS p ON g.good_id = p.good JOIN GoodTypes AS gt ON g.type = gt.good_type_id
WHERE EXTRACT(year from date) = 2005
GROUP BY good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
SELECT min(TIMESTAMPDIFF(YEAR, birthday, CURDATE())) AS year
FROM Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
SELECT max(TIMESTAMPDIFF(YEAR, birthday, CURDATE())) as max_year
FROM Student AS s JOIN Student_in_class AS  sc ON s.id = sc.student JOIN Class AS c ON c.id = sc.class 
WHERE name = 10

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
SELECT status, member_name, sum(amount * unit_price) AS costs
FROM FamilyMembers AS f JOIN Payments AS p ON f.member_id = p.family_member JOIN Goods AS g ON p.good = g.good_id JOIN GoodTypes AS gt ON g.type = gt.good_type_id
WHERE good_type_name = 'entertainment'
GROUP BY status, member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
DELETE FROM Company
WHERE id IN (SELECT company FROM Trip GROUP BY company HAVING count(id) = (SELECT min(count) FROM (SELECT count(id) AS count FROM trip GROUP BY company) AS a))

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
SELECT classroom 
FROM Schedule
GROUP BY classroom 
HAVING count(id) = (SELECT max(count) FROM (SELECT classroom, count(id) AS count FROM Schedule GROUP BY classroom) AS a)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
SELECT DISTINCT(last_name) AS last_name
FROM Schedule AS s JOIN teacher AS t ON t.id = s.teacher JOIN Subject AS sb ON sb.id = s.subject
WHERE sb.name = 'Physical Culture'
ORDER BY last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
SELECT concat(last_name, '.', left(first_name, 1), '.', left(middle_name, 1), '.') AS name
FROM Student
ORDER BY name ASC

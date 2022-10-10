--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT CASE WHEN (g.grade < 8) THEN 'NULL' 
            ELSE s.name 
            END AS name,
        g.grade, s.marks
FROM students AS s, grades AS g
WHERE s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC, s.name ASC


--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
SELECT 
MIN(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
MIN(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
MIN(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
MIN(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor
FROM (SELECT a.Occupation, a.Name, (SELECT COUNT(*) FROM Occupations AS b WHERE a.Occupation = b.Occupation AND a.Name > b.Name) AS rank
  FROM Occupations AS a) AS c
GROUP BY c.rank

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
SELECT DISTINCT(CITY) 
FROM Station
WHERE CITY NOT LIKE '[aeiou]%'

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
SELECT DISTINCT(City)
FROM Station
WHERE RIGHT(city,1) NOT IN ('a','e','i','o','u')

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
SELECT DISTINCT(City)
FROM Station
WHERE CITY NOT LIKE '[aeiou]%' OR RIGHT(city,1) NOT IN ('a','e','i','o','u')

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
SELECT DISTINCT(City)
FROM Station
WHERE CITY NOT LIKE '[aeiou]%' AND RIGHT(city,1) NOT IN ('a','e','i','o','u')

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
SELECT name
FROM employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT CASE WHEN (g.grade < 8) THEN 'NULL' 
            ELSE s.name 
            END AS name,
        g.grade, s.marks
FROM students AS s, grades AS g
WHERE s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC, s.name ASC

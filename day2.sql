CREATE TABLE workers
(
    id SMALLINT,
    name VARCHAR(50),
    salary SMALLINT,
    CONSTRAINT id4_pk PRIMARY KEY(id)
);
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
SELECT * FROM workers
WHERE salary IN((SELECT MAX(salary) FROM workers),(SELECT MIN(salary) FROM workers))

--"AS" keyword is used to create a temporary field from your table
--Find the highest salary and display the data under"the highest salary" heading

SELECT MAX(salary) AS the_highest_salary FROM workers
--Find the lowest salary and display the data under"the lowest salary" heading
SELECT MIN(salary) AS the_lowest_salary FROM workers
--Find the average salary column and use AS keyword
SELECT AVG(salary) AS avarege_salary
FROM workers
--Find the total number of the records
SELECT COUNT(name) AS number_of_workers FROM workers
--Find the total value of salaries
SELECT SUM(salary) AS average_salary
FROM workers
--What are the"Aggreagate Functions" in SQL?
--SUM,COUNT,MAX,MIN,AVG.
--Intervju Question: Find the second highest salary

SELECT
MAX(Salary) AS ThirdLowestSalary
FROM workers 
WHERE salary< (SELECT
 MAX(Salary) AS SecondLowestSalary
FROM workers 
WHERE salary < (
SELECT MAX(Salary) FROM workers)
)

--2. way by using 'Order by' aggregate function
SELECT * FROM workers
ORDER BY salary DESC
OFFSET 3 ROW
FETCH NEXT 1 ROW ONLY



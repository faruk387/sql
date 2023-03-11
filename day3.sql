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

SELECT * FROM workers;

--Find the max and min salary values having records from the table
--1.way
SELECT * FROM workers
WHERE salary IN ((SELECT MAX (salary) FROM workers), (SELECT MIN(salary) FROM workers));

--2.way:
SELECT * FROM workers
WHERE salary=(SELECT MAX(salary)  FROM workers) OR salary=(SELECT MIN(salary) FROM workers);

--"AS" keyword is used to create a temporary field from your table
--Find the highest salary and display the data under "the highest salary" heading

SELECT MAX(salary) AS the_highest_salary
FROM workers;

--Find the lowest salary and use "AS" keyword
SELECT MIN(salary) AS minimum_salary
FROM workers;

--Find the average of salary column and use "AS" keyword
SELECT AVG(salary) AS average_salary
FROM workers;

--Find the total number of the records
SELECT COUNT(name) AS number_of_workers
FROM workers;

--Find the total value of salaries
SELECT SUM(salary) AS total_salary
FROM workers;

--What are the "Aggregate Functions" in SQL?
--SUM, COUNT, MAX, MIN, AVG.

--Interview Question: Find the second highest salary
SELECT MAX(salary) AS second_highst_salary
FROM workers
WHERE salary< (SELECT MAX(salary) FROM workers);

--Interview Question:Find the second lowest salary
SELECT MIN(salary) AS second_lowest_salary
FROM workers
WHERE salary > (SELECT MIN(salary) FROM workers);

--Find the third highest salary
--1.way:
SELECT MAX (salary) AS third_highest_salary
FROM workers
WHERE salary < (SELECT MAX (salary)
              FROM workers
              WHERE salary < (SELECT MAX(salary) FROM workers));
--Here we use sub-query because we use multiple select and where keyword 

--2.way:by using "ORDER BY" aggregate function
SELECT * FROM workers
ORDER BY salary DESC;
OFFSET 2 ROWS
FETCH NEXT 1 ROW ONLY;

--***********************************************

CREATE TABLE customers_products
( 
  product_id INT,
  customer_name VARCHAR(50),
  product_name VARCHAR(50)
);
 
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy', 'Palm');
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple');               

SELECT *
FROM customers_products;

--Find the records that has the product_name value as Orange, Apple or Palm
--1.way
SELECT * FROM customers_products

--2.way: IN
SELECT * FROM customers_products
WHERE product_name IN('Orange', 'Apple', 'Palm');


--Find the records that has not the product_name value as Orange, Apple or Palm
SELECT * FROM customers_products
WHERE product_name NOT IN('Orange', 'Apple', 'Palm');

--BETWEEN--> you can select or by using 'NOT BETWEEN' you can eliminate the reading options

--Find the product_names that have product_id less than 30 or equal to 30 and greater than 20 or equal to 20
--1.way:
SELECT * FROM customers_products 
WHERE product_id <=30 AND product_id>=20;

--2.way:
SELECT * FROM customers_products 
WHERE product_id BETWEEN 20 AND 30; 

-->BETWEEN CONDITION accepts the given values as "inclusive"
--Homework-->Find the product names whose id is less than 2o and greater than 30
--1.way:




--2.way: 
SELECT * FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 30;

---**************************************************

CREATE TABLE customers_likes
( 
  product_id CHAR(10),
  customer_name VARCHAR(50),
  liked_product VARCHAR(50)
);


INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers_likes;

--EXISTS CONDITION --> We use "EXISTS" condition with sub-query.If the sub-query selects a data then the "EXISTS" condition
--can be used.If the sub-query does not find any data then "Outer Query" can not be executed.
--We can use "EXISTS" condition with SELECT, INSERT, UPDATE, DELETE commands.

--If the customer_name field has "Lary" among the customer_name field, update all customer_name field as "No Name".
UPDATE customers_likes
SET customer_name='No Name'
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE customer_name='Lary');

SELECT * FROM customers_likes;

DROP TABLE customers_likes;

--If among the liked_product Orange or Pineapple or Avocado exists then update all customer names to "Murat".

UPDATE customers_likes
SET customer_name='Murat'
WHERE EXISTS(SELECT customer_name FROM customers_likes WHERE liked_product IN('Orange', 'Pineapple', 'Avocado'));

--Delete all the records if Orange exists among the liked_product

DELETE FROM customers_likes
WHERE EXISTS(SELECT liked_product FROM customers_likes WHERE liked_product='Orange');
SELECT * FROM customers_likes;

--SUBQUERY

CREATE TABLE employees 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM
INSERT INTO employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');

SELECT * FROM employees;


CREATE TABLE companies 
(  
  company_id CHAR(9), 
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;

--Find the names company names that has number_of_employees greater than 15000

SELECT name, company
FROM employees
WHERE company IN (SELECT company FROM companies WHERE number_of_employees > 15000);

--Find the company names and company ids which are in Florida.
SELECT company, company_id
FROM companies
    WHERE company IN (SELECT company FROM employees WHERE state='Florida');


--Find names and their states whose company id is greater than 100 
  SELECT name, state, company
    FROM employees
    WHERE company IN(SELECT company FROM companies WHERE company_id > 100);
    













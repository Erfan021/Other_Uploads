DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup
(
	dept_no CHAR(4) NULL,
	dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup
(
	dept_no,
	dept_name
)
SELECT * FROM departments;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE dept_no = 'd002'; 

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
emp_no INT NOT NULL,
dept_no CHAR(4) NULL,
from_date date NOT NULL,
to_date date NULL
);

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES (999904, '2017-01-01'),
(999905, '2017-01-01'),
(999906, '2017-01-01'),
(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE dept_no = 'd001';

-- INNER JOIN:

SELECT * FROM dept_manager_dup
ORDER BY dept_no;

SELECT * FROM departments_dup
ORDER BY dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d ON m.dept_no = d.dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup AS m
INNER JOIN departments_dup AS d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no;

-- Duplicate Rows:
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

--checking 'dept_manager_dup' and 'departments_dup'
SELECT * FROM dept_manager_dup
ORDER BY dept_no ASC;

SELECT * FROM departments_dup
ORDER BY dept_no ASC;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d ON m.dept_no = d.dept_no;

--Deleting the duplicate records:
DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM departments_dup
WHERE dept_no = 'd009';

--Adding original records back:
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

-- LEFT JOIN:

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup AS m
LEFT JOIN departments_dup AS d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup AS d
LEFT JOIN dept_manager_dup as m ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT d.dept_no, m.emp_no, d.dept_name
FROM departments_dup AS d
LEFT JOIN dept_manager_dup as m ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup AS m
LEFT JOIN departments_dup AS d ON m.dept_no = d.dept_no
WHERE dept_name IS NULL
ORDER BY m.dept_no;

--Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees 
--whose last name is Markovitch.
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC, e.emp_no;

-- RIGHT JOIN:

SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup AS d
RIGHT JOIN dept_manager_dup AS m ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Uing JOIN and WHERE toghether:

SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary > 145000;

--Select the first and last name, the hire date, 
--and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.
SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE first_name = 'Margareta'
AND last_name = 'Markovitch'
ORDER BY e.emp_no;

-- CROSS JOIN:

SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY dm.emp_no, d.dept_no;

SELECT dm.*, d.*
FROM dept_manager dm,
departments d
ORDER BY dm.emp_no, d.dept_no;

SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

SELECT e.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
JOIN employees e ON dm.emp_no = e.emp_no
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

--Use a CROSS JOIN to return a list with all possible combinations 
--between managers from the dept_manager table and department number 9.
SELECT dm.*, d.*
FROM departments d
CROSS JOIN dept_manager dm
WHERE d.dept_no = 'd009'
ORDER BY d.dept_name;

--Return a list with the first 10 employees 
--with all the departments they can be assigned to.
SELECT e.*, d.*
FROM employees e
CROSS JOIN departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

-- Combining aggegate functions with JOIN:

SELECT e.gender, AVG(CAST(s.salary AS BIGINT)) AS average_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

-- Joining multiple tables:

SELECT e.first_name, e.last_name, e.hire_date,
m.from_date, d.dept_name
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no;

SELECT e.first_name, e.last_name, e.hire_date,
m.from_date, d.dept_name
FROM departments d
JOIN dept_manager m ON d.dept_no = m.dept_no
JOIN employees e ON m.emp_no = e.emp_no;

--Select all managers’ first and last name, hire date, 
--job title, start date, and department name.
SELECT e.first_name, e.last_name, e.hire_date,
t.title, m.from_date, d.dept_name
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no
JOIN titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

SELECT e.first_name, e.last_name, e.hire_date,
t.title, m.from_date, d.dept_name
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no
JOIN titles t ON e.emp_no = t.emp_no
AND m.from_date = t.from_date
ORDER BY e.emp_no;

-- Tips for JOINS:

SELECT d.dept_name, AVG(salary)
FROM departments d
JOIN dept_manager m ON d.dept_no = m.dept_no
JOIN salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name;

--How many male and how many female managers do 
--we have in the ‘employees’ database?
SELECT e.gender, COUNT(dm.emp_no)
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

-- UNION and UNION ALL:

--create duplicate employee table
DROP TABLE IF EXISTS employees_dup;

CREATE TABLE employees_dup(
emp_no INT,
birth_date date,
first_name VARCHAR(40),
last_name VARCHAR(40),
gender	VARCHAR(1) CHECK (gender IN('M','F')),
hire_date date
);

INSERT INTO employees_dup
SELECT TOP 20 e.* 
FROM employees e;

--insert duplicate row
INSERT INTO employees_dup VALUES
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

SELECT e.emp_no, e.first_name, e.last_name,
NULL AS dept_no,
NULL AS from_date
FROM employees_dup e
WHERE e.emp_no = '10001'
UNION ALL SELECT 
NULL AS emp_no,
NULL AS first_name,
NULL AS last_name,
m.dept_no,
m.from_date
FROM dept_manager m;

SELECT e.emp_no, e.first_name, e.last_name,
NULL AS dept_no,
NULL AS from_date
FROM employees_dup e
WHERE e.emp_no = '10001'
UNION SELECT 
NULL AS emp_no,
NULL AS first_name,
NULL AS last_name,
m.dept_no,
m.from_date
FROM dept_manager m;

--Go forward to the solution and execute the query. 
--What do you think is the meaning of the minus sign before 
--subset A in the last row (ORDER BY -a.emp_no DESC)?
SELECT *
FROM (SELECT e.emp_no, e.first_name, e.last_name,
NULL AS dept_no,
NULL AS from_date
FROM employees e
WHERE last_name = 'Denis' UNION SELECT
NULL AS emp_no,
NULL AS first_name,
NULL AS last_name,
dm.dept_no,
dm.from_date
FROM dept_manager dm) as a
ORDER BY -a.emp_no DESC;


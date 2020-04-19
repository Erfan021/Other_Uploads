-- Using SELECT-FROM:
SELECT first_name, last_name FROM employees;

SELECT * FROM employees;

SELECT dept_no FROM departments;

SELECT * FROM departments;

-- Using WHERE:
SELECT * FROM employees
WHERE first_name = 'Denis';

SELECT * FROM employees
WHERE first_name = 'Elvis';

-- Using AND:
SELECT * FROM employees
WHERE first_name = 'Denis' AND gender = 'M';

SELECT * FROM employees
WHERE first_name = 'Kellie' AND gender = 'F';

-- Using OR:
SELECT * FROM employees
WHERE first_name = 'Denis' OR first_name = 'Elvis';

SELECT * FROM employees
WHERE first_name = 'Kellie' OR first_name = 'Aruna';

-- Order Precedence and Logical Order:
SELECT * FROM employees
WHERE last_name = 'Denis' AND (gender = 'M' OR gender = 'F');

SELECT * FROM employees
WHERE gender = 'F' AND (first_name = 'Aruna' OR first_name = 'Kellie');

-- Using IN - NOT IN:
SELECT * FROM employees
WHERE first_name IN ('Cathie', 'Mark', 'Nathan')

SELECT * FROM employees
WHERE first_name NOT IN ('Cathie', 'Mark', 'Nathan')

SELECT * FROM employees
WHERE first_name IN ('Denis', 'Elvis')

SELECT * FROM employees
WHERE first_name NOT IN ('Jacob', 'Mark', 'John')

-- Using LIKE-NOT LIKE:
SELECT * FROM employees
WHERE first_name LIKE('Mark%');

SELECT * FROM employees
WHERE hire_date LIKE ('%2000%');

SELECT * FROM employees
WHERE emp_no LIKE ('1000_');

-- Using Wildcard Characters:
SELECT * FROM employees
WHERE first_name LIKE ('%Jack%');

SELECT * FROM employees
WHERE first_name NOT LIKE ('%Jack%');

-- Using BETWEEN...AND:
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM employees
WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

SELECT dept_name FROM departments
WHERE dept_no BETWEEN 'd003' AND 'd006';

SELECT dept_name FROM departments
WHERE dept_no NOT BETWEEN 'd003' AND 'd006';

-- Using IS NULL-IS NOT NULL:
SELECT * FROM employees
WHERE first_name IS NOT NULL;

SELECT * FROM employees
WHERE first_name IS NULL;

SELECT dept_name FROM departments
WHERE dept_no IS NOT NULL;

-- Comaprison Operators:
SELECT * FROM employees
WHERE gender = 'F' 
AND hire_date >= '2000-01-01';

SELECT * FROM salaries
WHERE salary > 150000;

-- Using SELECT DISTINCT:
SELECT DISTINCT gender
FROM employees;

SELECT DISTINCT hire_date
FROM employees;

-- Aggregate Functions:
SELECT COUNT(emp_no)
FROM employees;

SELECT COUNT(DISTINCT first_name)
FROM employees;

SELECT COUNT(*) FROM salaries
WHERE salary >= 100000;

SELECT COUNT(*)
FROM dept_manager;

-- Using ORDER BY:
SELECT * FROM employees
ORDER BY first_name, last_name ASC;

SELECT * FROM employees
ORDER BY emp_no DESC;

-- Using GROUP BY:
SELECT first_name FROM employees
GROUP BY first_name;

SELECT first_name, COUNT(first_name) FROM employees
GROUP BY first_name
ORDER BY first_name DESC;

-- Aliases:
SELECT first_name, COUNT(first_name) as name_count FROM employees
GROUP BY first_name
ORDER BY first_name;

SELECT salary, COUNT(emp_no) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary;

-- Using HAVING:
SELECT first_name, COUNT(first_name) as name_count FROM employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

SELECT emp_no, AVG(salary) FROM salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

-- WHERE vs. HAVING:
--Extract a list of all names that are encountered less than 200 times. Let the data refer to 
--people hired after the 1st of January 1999
SELECT first_name, COUNT(first_name) as name_counts
FROM employees
WHERE hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

--Select the employee numbers of all individuals who have signed 
--more than 1 contract after the 1st of January 2000.
SELECT emp_no FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

-- Using LIMIT:
SELECT * FROM salaries
ORDER BY salary DESC;

SELECT TOP 10 * FROM salaries
ORDER BY salary DESC;

SELECT TOP 10 * FROM salaries
ORDER BY salary ASC;

SELECT TOP 100 first_name, COUNT(first_name) as name_counts
FROM employees
WHERE hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

SELECT TOP 100 * FROM dept_emp;

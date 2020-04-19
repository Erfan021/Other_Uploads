-- Applying COUNT():
SELECT COUNT(salary) 
FROM salaries;

SELECT COUNT(DISTINCT from_date)
FROM salaries;

SELECT COUNT(*)
FROM salaries;

SELECT COUNT(DISTINCT dept_no)
FROM dept_emp;

-- Applying SUM():
SELECT SUM(CAST(salary AS BIGINT))
FROM salaries;

SELECT SUM(CAST(salary AS BIGINT))
FROM salaries
WHERE from_date > '1997-01-01';

-- Applying MAX() and MIN():
SELECT MAX(salary)
FROM salaries;

SELECT MIN(salary)
FROM salaries;

SELECT MIN(emp_no)
FROM employees;

SELECT MAX(emp_no)
FROM employees;

-- Applying AVG():
SELECT AVG(CAST(salary AS BIGINT))
FROM salaries;

SELECT AVG(CAST(salary AS BIGINT))
FROM salaries
WHERE from_date > '1997-01-01';

-- Applying ROUND():
SELECT ROUND(AVG(CAST(salary AS BIGINT)),2)
FROM salaries
WHERE from_date > '1997-01-01';


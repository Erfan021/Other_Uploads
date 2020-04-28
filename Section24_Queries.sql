-- SUBQUERIES

SELECT * 
FROM dept_manager;

--Select the first and last name from the Employees table for the same
--employee numbers that can be found in the Department Manager table.
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.emp_no IN 
	(SELECT dm.emp_no
	 FROM dept_manager dm);

--Extract the information about all department managers who
--were hired between the 1st of January 1990 and the 1st of January 1995.
SELECT *
FROM dept_manager
WHERE emp_no IN 
	(SELECT emp_no
	 FROM employees
	 WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');

-- EXISTS..NOT EXISTS

SELECT e.first_name, e.last_name
FROM employees e
WHERE
	EXISTS(SELECT *
	FROM dept_manager dm
	WHERE dm.emp_no = e.emp_no);

SELECT e.first_name, e.last_name
FROM employees e
WHERE 
	EXISTS(SELECT *
	FROM dept_manager dm
	WHERE dm.emp_no = e.emp_no)
ORDER BY emp_no;

--Select the entire information for all employees whose job 
--title is “Assistant Engineer”.
SELECT *
FROM employees e
WHERE
	EXISTS( SELECT *
	FROM titles t
	WHERE t.emp_no = e.emp_no
	AND title = 'Assistant Engineer'); 

--Assign employee number 110022 as a manager to all employees
--from 10001 to 10020, and employee number 110039 as a manager to all
--employees from 10021 to 10040
SELECT subset_A.*
FROM
	(SELECT e.emp_no AS employee_ID,
	MIN(de.dept_no) AS department_code,
		(SELECT emp_no
		FROM dept_manager
		WHERE emp_no = '110022') as manager_ID
	FROM employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
	WHERE e.emp_no <= '10020'
	GROUP BY e.emp_no
	ORDER BY e.emp_no OFFSET 0 ROWS) AS subset_A
UNION SELECT subset_B.*
FROM
	(SELECT e.emp_no AS employee_ID,
	MIN(de.dept_no) AS department_code,
		(SELECT emp_no
		FROM dept_manager
		WHERE emp_no = '110039') as manager_ID
	FROM employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
	WHERE e.emp_no > '10020'
	GROUP BY e.emp_no
	ORDER BY e.emp_no OFFSET 20 ROWS) AS subset_B;

--Fill emp_manager with data about employees, 
--the number of the department they are working in, and their managers.
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (
emp_no INT NOT NULL,
dept_no CHAR(4) NULL,
manager_no INT NOT NULL);

INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no OFFSET 0 ROWS) AS a UNION SELECT 
        b.*
    FROM
        (SELECT
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no OFFSET 20 ROWS) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;

SELECT *
FROM emp_manager;


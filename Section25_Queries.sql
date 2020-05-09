-- Stored Routines

DROP PROCEDURE IF EXISTS select_employees;

DROP PROCEDURE IF EXISTS SP_emp_salary;

--Stored Procedure # 1
GO
CREATE PROCEDURE SP_emp_salary (
@p_emp_no INT)
AS
BEGIN
SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
	FROM employees e
	JOIN salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = @p_emp_no;
END;

EXECUTE SP_emp_salary 
	@p_emp_no = '11300';


/*
-> Getstudentname is the name of the stored procedure

Create  PROCEDURE Getstudentname(

@studentid INT                   --Input parameter ,  Studentid of the student 

)
AS
BEGIN
SELECT Firstname+' '+Lastname FROM tbl_Students WHERE studentid=@studentid 
END

-> GetstudentnameInOutputVariable is the name of the stored procedure which
uses output variable @Studentname to collect the student name returns by the
stored procedure

Create  PROCEDURE GetstudentnameInOutputVariable
(

@studentid INT,                       --Input parameter ,  Studentid of the student
@studentname VARCHAR(200)  OUT        -- Out parameter declared with the help of OUT keyword
)
AS
BEGIN
SELECT @studentname= Firstname+' '+Lastname FROM tbl_Students WHERE studentid=@studentid
END

Execute Getstudentname 1

Declare @Studentname as nvarchar(200)   -- Declaring the variable to collect the Studentname
Declare @Studentemail as nvarchar(50)     -- Declaring the variable to collect the Studentemail
Execute GetstudentnameInOutputVariable 1 , @Studentname output, @Studentemail output
select @Studentname,@Studentemail      -- "Select" Statement is used to show the output from Procedure
*/

-- Stored Procedure # 2
/*GO
CREATE PROCEDURE SP_emp_avg_salary_out(
@p_emp_no INT,
@p_avg_salary DECIMAL(10,2) OUTPUT
)
AS 
BEGIN
SELECT @p_avg_salary = AVG(s.salary)
FROM
employees e JOIN
salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = @p_emp_no;
END;

DECLARE @AVG_Salary AS DECIMAL(10,2);
EXECUTE SP_emp_avg_salary_out @p_emp_no = '11300', @p_avg_salary = @AVG_Salary;
SELECT @AVG_Salary;
*/



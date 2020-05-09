-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Irfan>
-- Create date: <09-May-2020>
-- Description:	<Output Stored Procedure>
-- =============================================
CREATE PROCEDURE SP_emp_avg_salary_OUT 
	-- Add the parameters for the stored procedure here
	@p_emp_no int = 0, 
	@p_avg_salary DECIMAL(10,2) OUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @p_avg_salary = AVG(CAST(s.salary AS BIGINT))
	FROM
	employees e JOIN
	salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = @p_emp_no;
END
GO

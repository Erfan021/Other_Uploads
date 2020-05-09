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
-- Author:		Irfan
-- Create date: 09-May-2020
-- Description:	Emoployee Info
-- =============================================
CREATE PROCEDURE SP_emp_info 
	-- Add the parameters for the stored procedure here
	@p_first_name NVARCHAR(50), 
	@p_last_name NVARCHAR(50),
	@p_emp_no INT OUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @p_emp_no = e.emp_no
	FROM employees e
	WHERE e.first_name = @p_first_name AND e.last_name = @p_last_name;
END
GO

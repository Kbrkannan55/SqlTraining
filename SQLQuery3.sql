-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Boopathiraja Kannan
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION udf_source
(	
	-- Add the parameters for the function here
	
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT source from bus where routeno=6
)
GO

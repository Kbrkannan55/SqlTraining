USE [sample]
GO
/****** Object:  StoredProcedure [dbo].[EmpNameDisplay]    Script Date: 13-03-2023 15:52:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		boo
-- Create date: 13/03/2023	
-- Description:	First Stored Procedure 
-- =============================================
ALTER PROCEDURE [dbo].[EmpNameDisplay] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here\
	begin transaction
	insert into student (rno, sname) values (112, 'AAA');
	commit
 	SELECT rno, sname from student;
END

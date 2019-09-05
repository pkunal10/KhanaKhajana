﻿/*
Deployment script for D:\ASP.NET\FINAL PROJECT\KHANAKHAJANA\KHANAKHAJANA\APP_DATA\KHANAKHAJANA.MDF

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "D:\ASP.NET\FINAL PROJECT\KHANAKHAJANA\KHANAKHAJANA\APP_DATA\KHANAKHAJANA.MDF"
:setvar DefaultFilePrefix "D_\ASP.NET\FINAL PROJECT\KHANAKHAJANA\KHANAKHAJANA\APP_DATA\KHANAKHAJANA.MDF_"
:setvar DefaultDataPath "C:\Users\ADMIN\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\v11.0\"
:setvar DefaultLogPath "C:\Users\ADMIN\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\v11.0\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO

IF (SELECT OBJECT_ID('tempdb..#tmpErrors')) IS NOT NULL DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
BEGIN TRANSACTION
GO
PRINT N'Starting rebuilding table [dbo].[Discounts]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Discounts] (
    [DiscountId]      INT        IDENTITY (1, 1) NOT NULL,
    [ProductId]       INT        NOT NULL,
    [DiscountPercent] FLOAT (53) NOT NULL,
    PRIMARY KEY CLUSTERED ([DiscountId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Discounts])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Discounts] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Discounts] ([DiscountId], [ProductId], [DiscountPercent])
        SELECT   [DiscountId],
                 [ProductId],
                 [DiscountPercent]
        FROM     [dbo].[Discounts]
        ORDER BY [DiscountId] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Discounts] OFF;
    END

DROP TABLE [dbo].[Discounts];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Discounts]', N'Discounts';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO

IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT N'The transacted portion of the database update succeeded.'
COMMIT TRANSACTION
END
ELSE PRINT N'The transacted portion of the database update failed.'
GO
DROP TABLE #tmpErrors
GO
PRINT N'Update complete.';


GO
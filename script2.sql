USE [master]
GO
/****** Object:  Database [KaficiProjekat]    Script Date: 12-Jun-2022 12:09:03 PM ******/
CREATE DATABASE [KaficiProjekat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KaficiProjekat', FILENAME = N'D:\Program Files (x86)\MSSQL14.MSSQLSERVER\MSSQL\DATA\KaficiProjekat.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KaficiProjekat_log', FILENAME = N'D:\Program Files (x86)\MSSQL14.MSSQLSERVER\MSSQL\DATA\KaficiProjekat_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [KaficiProjekat] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KaficiProjekat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KaficiProjekat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KaficiProjekat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KaficiProjekat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KaficiProjekat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KaficiProjekat] SET ARITHABORT OFF 
GO
ALTER DATABASE [KaficiProjekat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KaficiProjekat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KaficiProjekat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KaficiProjekat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KaficiProjekat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KaficiProjekat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KaficiProjekat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KaficiProjekat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KaficiProjekat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KaficiProjekat] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KaficiProjekat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KaficiProjekat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KaficiProjekat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KaficiProjekat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KaficiProjekat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KaficiProjekat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KaficiProjekat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KaficiProjekat] SET RECOVERY FULL 
GO
ALTER DATABASE [KaficiProjekat] SET  MULTI_USER 
GO
ALTER DATABASE [KaficiProjekat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KaficiProjekat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KaficiProjekat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KaficiProjekat] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KaficiProjekat] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'KaficiProjekat', N'ON'
GO
ALTER DATABASE [KaficiProjekat] SET QUERY_STORE = OFF
GO
USE [KaficiProjekat]
GO
/****** Object:  User [test1]    Script Date: 12-Jun-2022 12:09:03 PM ******/
CREATE USER [test1] FOR LOGIN [test1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Programer]    Script Date: 12-Jun-2022 12:09:03 PM ******/
CREATE USER [Programer] FOR LOGIN [Programer] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[FullNameFunction]    Script Date: 12-Jun-2022 12:09:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[FullNameFunction]
(
	-- Add the parameters for the function here
	@FirstName nvarchar,
	@LastName nvarchar
)
RETURNS nvarchar
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FullName nvarchar

	-- Add the T-SQL statements to compute the return value here
	SELECT @FullName = @FirstName + ' ' + @LastName

	-- Return the result of the function
	RETURN @FullName

END
GO
/****** Object:  Table [dbo].[Cafes]    Script Date: 12-Jun-2022 12:09:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cafes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[Adress] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cafes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Search_Kafici]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Search_Kafici] 
(	
	-- Add the parameters for the function here
	@CafeName nvarchar
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT * from Cafes where Name IN(@CafeName)
)
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ImageId] [int] NULL,
	[ParentId] [int] NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Amount] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[SearchProducts]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[SearchProducts] 
(	
	-- Add the parameters for the function here
	@ProductName nvarchar,
	@CategoryName nvarchar
)
RETURNS TABLE 
AS
RETURN 
(
	
	-- Add the SELECT statement with parameter references here
	SELECT Categories.Name as Category, Products.Name AS Product 
	FROM  Products INNER JOIN Categories ON Products.CategoryId = Categories.Id 
	where Categories.Name in(@CategoryName) or Products.Name in(@ProductName)
)
GO
/****** Object:  Table [dbo].[CafeProducts]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CafeProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CafeId] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CafeProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Cafe_Product_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Cafe_Product_View]
AS
SELECT        dbo.Products.Name, dbo.Products.Price, dbo.Products.Amount, dbo.Products.Description, dbo.Categories.Name AS Category, dbo.Cafes.Name AS Cafe
FROM            dbo.CafeProducts INNER JOIN
                         dbo.Products ON dbo.CafeProducts.ProductID = dbo.Products.Id INNER JOIN
                         dbo.Categories ON dbo.Products.CategoryId = dbo.Categories.Id INNER JOIN
                         dbo.Cafes ON dbo.CafeProducts.CafeId = dbo.Cafes.Id
GO
/****** Object:  View [dbo].[Product_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Product_View]
AS
SELECT        dbo.Products.Name, dbo.Products.Price, dbo.Products.Amount, dbo.Products.Description, dbo.Categories.Name AS [Category Name]
FROM            dbo.Products INNER JOIN
                         dbo.Categories ON dbo.Products.CategoryId = dbo.Categories.Id
GO
/****** Object:  View [dbo].[Cafe_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Cafe_View]
AS
SELECT        Name, Description, Adress, Id
FROM            dbo.Cafes
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Seats] [int] NOT NULL,
	[CafeId] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](max) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableId] [int] NOT NULL,
	[DateAndTime] [datetime2](7) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CafeProductOrder]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CafeProductOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CafeProductId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductName] [nvarchar](max) NULL,
	[ProductPrice] [decimal](18, 2) NULL,
	[ProductAmount] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](max) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
 CONSTRAINT [PK_CafeProductOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[CafeProductOrder_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CafeProductOrder_View]
AS
SELECT        dbo.Cafes.Name AS [Cafe Name], dbo.Tables.Name AS [Table Name], dbo.Products.Name AS [Product name], dbo.Products.Price AS [Price per], dbo.Products.Amount AS [Amount per], 
                         dbo.CafeProductOrder.ProductAmount AS [Amount of products], dbo.CafeProductOrder.ProductPrice AS [Total Price], dbo.Orders.DateAndTime
FROM            dbo.CafeProductOrder INNER JOIN
                         dbo.CafeProducts ON dbo.CafeProductOrder.CafeProductId = dbo.CafeProducts.Id INNER JOIN
                         dbo.Cafes ON dbo.CafeProducts.CafeId = dbo.Cafes.Id INNER JOIN
                         dbo.Products ON dbo.CafeProducts.ProductID = dbo.Products.Id INNER JOIN
                         dbo.Orders ON dbo.CafeProductOrder.OrderId = dbo.Orders.Id INNER JOIN
                         dbo.Tables ON dbo.Cafes.Id = dbo.Tables.CafeId AND dbo.Orders.TableId = dbo.Tables.Id
GO
/****** Object:  Table [dbo].[Images]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](200) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Image_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Image_View]
AS
SELECT        Path
FROM            dbo.Images
GO
/****** Object:  View [dbo].[Category_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Category_View]
AS
SELECT        Id, Name, Description, ParentId
FROM            dbo.Categories
GO
/****** Object:  View [dbo].[Order_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Order_View]
AS
SELECT        dbo.CafeProductOrder.ProductName, dbo.CafeProductOrder.ProductPrice AS [Product price], dbo.CafeProductOrder.ProductAmount AS [Product Amount], dbo.Tables.Name AS [Table name], dbo.Orders.DateAndTime
FROM            dbo.Orders INNER JOIN
                         dbo.Tables ON dbo.Orders.TableId = dbo.Tables.Id INNER JOIN
                         dbo.CafeProductOrder ON dbo.Orders.Id = dbo.CafeProductOrder.OrderId
GO
/****** Object:  View [dbo].[Table_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Table_View]
AS
SELECT        dbo.Tables.Name, dbo.Tables.Seats, dbo.Cafes.Name AS [Cafe Name]
FROM            dbo.Tables INNER JOIN
                         dbo.Cafes ON dbo.Tables.CafeId = dbo.Cafes.Id
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[IsSuperUser] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shifts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](max) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
 CONSTRAINT [PK_Shifts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserShifts]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserShifts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ShiftId] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserShifts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkersInCafe]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkersInCafe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserShiftId] [int] NOT NULL,
	[CafeId] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[DeletedBy] [nvarchar](max) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[Date] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_WorkersInCafe] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Workers_In_Cafe_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Workers_In_Cafe_View]
AS
SELECT        dbo.Users.Name, dbo.Users.LastName, dbo.Shifts.Name AS Shift, dbo.Cafes.Name AS Cafe, dbo.WorkersInCafe.Date
FROM            dbo.WorkersInCafe INNER JOIN
                         dbo.UserShifts ON dbo.WorkersInCafe.UserShiftId = dbo.UserShifts.Id INNER JOIN
                         dbo.Users ON dbo.UserShifts.UserId = dbo.Users.Id INNER JOIN
                         dbo.Shifts ON dbo.UserShifts.ShiftId = dbo.Shifts.Id INNER JOIN
                         dbo.Cafes ON dbo.WorkersInCafe.CafeId = dbo.Cafes.Id
GO
/****** Object:  View [dbo].[UserShift_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserShift_View]
AS
SELECT        dbo.Users.Name, dbo.Users.LastName, dbo.Shifts.Name AS Shift, dbo.WorkersInCafe.Date
FROM            dbo.UserShifts INNER JOIN
                         dbo.Users ON dbo.UserShifts.UserId = dbo.Users.Id INNER JOIN
                         dbo.Shifts ON dbo.UserShifts.ShiftId = dbo.Shifts.Id INNER JOIN
                         dbo.WorkersInCafe ON dbo.UserShifts.Id = dbo.WorkersInCafe.UserShiftId
GO
/****** Object:  View [dbo].[Shifts_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Shifts_View]
AS
SELECT        Name
FROM            dbo.Shifts
GO
/****** Object:  View [dbo].[Users_View]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Users_View]
AS
SELECT        Name, LastName, UserName, KafeId, Uloga, CreatedAt, IsActive, DeletedAt
FROM            dbo.Users
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Activities]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User] [nvarchar](max) NULL,
	[DateTime] [datetime2](7) NOT NULL,
	[Action] [nvarchar](max) NOT NULL,
	[DataDeleted] [nvarchar](max) NULL,
	[DataInserted] [nvarchar](max) NULL,
 CONSTRAINT [PK_Activities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImageProduct]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageProduct](
	[ImagesId] [int] NOT NULL,
	[ProductsId] [int] NOT NULL,
 CONSTRAINT [PK_ImageProduct] PRIMARY KEY CLUSTERED 
(
	[ImagesId] ASC,
	[ProductsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UseCaseLogs]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UseCaseLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UseCaseName] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[UserId] [int] NOT NULL,
	[ExcecutionTime] [datetime] NOT NULL,
	[Data] [nvarchar](max) NOT NULL,
	[IsAuthorized] [bit] NOT NULL,
 CONSTRAINT [PK_UseCases] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserUseCase]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserUseCase](
	[UserId] [int] NOT NULL,
	[UseCaseId] [int] NOT NULL,
 CONSTRAINT [PK_UserUseCase] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[UseCaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220527130151_inital', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220528174459_second', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220531122235_third', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220531140208_fourth', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220531152901_fifth', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220602143001_sixth', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220606182337_bezDiskriminatora', N'5.0.17')
SET IDENTITY_INSERT [dbo].[Activities] ON 

INSERT [dbo].[Activities] ([Id], [User], [DateTime], [Action], [DataDeleted], [DataInserted]) VALUES (2, N'dbo', CAST(N'2022-05-31T17:08:25.9066667' AS DateTime2), N'insert', NULL, N'{"Products":[{"Id":8,"Name":"Prod 8","Price":20.00,"Amount":"300ml","Description":"Activity","CategoryId":3,"CreatedAt":"2022-01-01T00:00:00","IsActive":true}]}')
INSERT [dbo].[Activities] ([Id], [User], [DateTime], [Action], [DataDeleted], [DataInserted]) VALUES (3, N'dbo', CAST(N'2022-05-31T18:36:04.3300000' AS DateTime2), N'insert', NULL, N'{"Products":[{"Id":9,"Name":"test5","Price":5.00,"Amount":"150ml","Description":"asd","CategoryId":2,"CreatedAt":"2022-05-31T18:36:04.3000000","IsActive":true}]}')
INSERT [dbo].[Activities] ([Id], [User], [DateTime], [Action], [DataDeleted], [DataInserted]) VALUES (4, N'dbo', CAST(N'2022-06-01T16:44:41.2166667' AS DateTime2), N'insert', NULL, N'{"Products":[{"Id":10,"Name":"procedura","Price":20.00,"Amount":"150ml","Description":"procedura","CategoryId":2,"CreatedAt":"2022-06-01T16:44:41.1500000","IsActive":true}]}')
SET IDENTITY_INSERT [dbo].[Activities] OFF
SET IDENTITY_INSERT [dbo].[CafeProductOrder] ON 

INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, 4, 1, N'Kafa', CAST(22.00 AS Decimal(18, 2)), 2, CAST(N'2022-01-11T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (17, 5, 1, NULL, CAST(30.00 AS Decimal(18, 2)), 5, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (18, 5, 1, N'test2', CAST(50.00 AS Decimal(18, 2)), 5, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (19, 5, 1, N'test2', CAST(55.00 AS Decimal(18, 2)), 5, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (20, 5, 1, N'test2', CAST(44.00 AS Decimal(18, 2)), 4, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (21, 5, 1, N'test2', CAST(77.00 AS Decimal(18, 2)), 7, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (22, 5, 1, N'test2', CAST(105.00 AS Decimal(18, 2)), 7, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (27, 4, 1, N'test', CAST(30.00 AS Decimal(18, 2)), 3, CAST(N'2022-06-09T16:42:56.4945416' AS DateTime2), 0, CAST(N'2022-06-09T19:20:34.7015628' AS DateTime2), NULL, CAST(N'2022-06-09T19:20:34.7070692' AS DateTime2), NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (28, 4, 2, N'test', CAST(240.00 AS Decimal(18, 2)), 24, CAST(N'2022-06-09T16:43:39.1034204' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-09T17:41:55.3230707' AS DateTime2), NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (29, 4, 2, N'test', CAST(30.00 AS Decimal(18, 2)), 3, CAST(N'2022-06-09T16:44:18.9664818' AS DateTime2), 0, CAST(N'2022-06-09T17:31:32.6295252' AS DateTime2), NULL, CAST(N'2022-06-09T17:31:32.6561221' AS DateTime2), NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (30, 4, 2, N'test', CAST(30.00 AS Decimal(18, 2)), 3, CAST(N'2022-06-09T16:44:19.7167140' AS DateTime2), 0, CAST(N'2022-06-09T17:31:43.8385572' AS DateTime2), NULL, CAST(N'2022-06-09T17:31:43.8386502' AS DateTime2), NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (31, 9, 2, N'kafa1', CAST(150.00 AS Decimal(18, 2)), 12, CAST(N'2022-06-09T17:43:04.3080145' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-09T17:52:23.7183957' AS DateTime2), NULL)
INSERT [dbo].[CafeProductOrder] ([Id], [CafeProductId], [OrderId], [ProductName], [ProductPrice], [ProductAmount], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (32, 8, 2, N'kafa1', CAST(150.00 AS Decimal(18, 2)), 15, CAST(N'2022-06-09T17:52:41.4747581' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-11T09:29:17.4619237' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[CafeProductOrder] OFF
SET IDENTITY_INSERT [dbo].[CafeProducts] ON 

INSERT [dbo].[CafeProducts] ([Id], [CafeId], [ProductID], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, 6, 2, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-06-09T19:18:18.8370244' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3325143' AS DateTime2), NULL)
INSERT [dbo].[CafeProducts] ([Id], [CafeId], [ProductID], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, 6, 3, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-06-09T19:18:18.8371712' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3327300' AS DateTime2), NULL)
INSERT [dbo].[CafeProducts] ([Id], [CafeId], [ProductID], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, 7, 4, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProducts] ([Id], [CafeId], [ProductID], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (7, 9, 12, CAST(N'2022-06-08T19:12:58.3245288' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProducts] ([Id], [CafeId], [ProductID], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (8, 9, 12, CAST(N'2022-06-08T19:13:01.6888886' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[CafeProducts] ([Id], [CafeId], [ProductID], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (9, 9, 12, CAST(N'2022-06-08T19:13:03.8183857' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CafeProducts] OFF
SET IDENTITY_INSERT [dbo].[Cafes] ON 

INSERT [dbo].[Cafes] ([Id], [Name], [Description], [Adress], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, N'Kafic 1', N'test opis', N'test adresa', CAST(N'2022-01-31T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-06-09T19:18:19.3208996' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3327324' AS DateTime2), NULL)
INSERT [dbo].[Cafes] ([Id], [Name], [Description], [Adress], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (7, N'kafic 2', N'test opis 2 ', N'test adresa 2 ', CAST(N'2022-02-15T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-06-06T14:54:00.0616947' AS DateTime2), NULL, CAST(N'2022-06-06T14:54:00.0618930' AS DateTime2), NULL)
INSERT [dbo].[Cafes] ([Id], [Name], [Description], [Adress], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (8, N'asd', N'asdqwe', N'asasdzxc', CAST(N'2022-06-05T10:17:29.0454760' AS DateTime2), 0, CAST(N'2022-06-05T12:24:42.4762839' AS DateTime2), NULL, CAST(N'2022-06-06T14:53:25.3602018' AS DateTime2), NULL)
INSERT [dbo].[Cafes] ([Id], [Name], [Description], [Adress], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (9, N'Update request', N'test 110 jun', N'100. juna', CAST(N'2022-06-05T14:41:06.6876438' AS DateTime2), 0, NULL, NULL, CAST(N'2022-06-10T13:13:52.3105551' AS DateTime2), NULL)
INSERT [dbo].[Cafes] ([Id], [Name], [Description], [Adress], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (10, N'test9', N'test 9 jun', N'9. juna', CAST(N'2022-06-09T19:17:15.1285475' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cafes] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, N'Kafa', N'test', 1, NULL, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N'Hladna Kafa', N'test', 2, 1, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'Topla Kafa', N'test', 1, 1, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'kategorija sa slikom', NULL, 3, NULL, CAST(N'2022-06-07T14:05:33.6748928' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, N'Kafa', NULL, 4, NULL, CAST(N'2022-06-07T16:48:36.0810797' AS DateTime2), 0, CAST(N'2022-06-07T17:31:08.9814009' AS DateTime2), NULL, CAST(N'2022-06-07T17:31:27.5114657' AS DateTime2), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, N'Kafa', NULL, 5, 5, CAST(N'2022-06-07T16:50:01.0887554' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (7, N'Hladne kafe', NULL, 6, 5, CAST(N'2022-06-07T16:50:21.8549533' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ImageId], [ParentId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (8, N'Kategorija sa autorizacijom', NULL, NULL, NULL, CAST(N'2022-06-10T15:54:03.6177332' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[ImageProduct] ([ImagesId], [ProductsId]) VALUES (1, 2)
INSERT [dbo].[ImageProduct] ([ImagesId], [ProductsId]) VALUES (1, 3)
INSERT [dbo].[ImageProduct] ([ImagesId], [ProductsId]) VALUES (2, 4)
INSERT [dbo].[ImageProduct] ([ImagesId], [ProductsId]) VALUES (1, 5)
INSERT [dbo].[ImageProduct] ([ImagesId], [ProductsId]) VALUES (7, 12)
SET IDENTITY_INSERT [dbo].[Images] ON 

INSERT [dbo].[Images] ([Id], [Path], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, N'123.jpg', CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Images] ([Id], [Path], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N'231', CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Images] ([Id], [Path], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'd95d67a8-07ca-40de-8c97-30827759605c.png', CAST(N'2022-06-07T14:05:33.6750228' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Images] ([Id], [Path], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'c5afb98f-6cb3-4386-a2f7-55b94965043e.JPG', CAST(N'2022-06-07T16:48:36.0811410' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Images] ([Id], [Path], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, N'c5820772-da43-47ab-85ce-7e5726128e05.JPG', CAST(N'2022-06-07T16:50:01.0887567' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Images] ([Id], [Path], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, N'd4981214-67fd-4491-9fe8-791af6e60387.JPG', CAST(N'2022-06-07T16:50:21.8549550' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Images] ([Id], [Path], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (7, N'c9f6de45-abaa-466f-ace4-f8c2a9376782.JPG', CAST(N'2022-06-08T15:37:04.2250797' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Images] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [TableId], [DateAndTime], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, 2, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [TableId], [DateAndTime], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, 3, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2022-01-02T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [TableId], [DateAndTime], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, 3, CAST(N'2022-07-05T00:00:00.0000000' AS DateTime2), CAST(N'2022-06-05T16:38:05.5009570' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [TableId], [DateAndTime], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, 3, CAST(N'2022-06-05T18:42:43.2417212' AS DateTime2), CAST(N'2022-06-05T16:41:45.3305622' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [TableId], [DateAndTime], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, 3, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2022-06-05T16:42:31.6963276' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [TableId], [DateAndTime], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, 5, CAST(N'2022-10-05T00:00:00.0000000' AS DateTime2), CAST(N'2022-06-11T11:38:20.6464577' AS DateTime2), 0, CAST(N'2022-06-11T11:39:56.8287875' AS DateTime2), NULL, CAST(N'2022-06-11T11:39:56.8290419' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N'test', CAST(10.00 AS Decimal(18, 2)), N'300ml', N'Trigger', 3, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-05-31T19:35:36.0100000' AS DateTime2), NULL, CAST(N'2022-05-31T19:35:36.0333333' AS DateTime2), NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'test2', CAST(15.00 AS Decimal(18, 2)), N'350ml', N'test', 2, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-05-31T19:38:33.7866667' AS DateTime2), N'dbo', CAST(N'2022-05-31T19:40:55.5533333' AS DateTime2), N'dbo')
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'test3', CAST(20.00 AS Decimal(18, 2)), N'500ml', N'Trigger', 2, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-05-31T14:44:46.4466667' AS DateTime2), NULL, CAST(N'2022-05-31T19:28:49.8500000' AS DateTime2), NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, N'test4', CAST(15.00 AS Decimal(18, 2)), N'200ml', N'test', 3, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (8, N'Prod 8', CAST(20.00 AS Decimal(18, 2)), N'300ml', N'Activity', 3, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (9, N'test5', CAST(50.00 AS Decimal(18, 2)), N'150ml', N'asd', 2, CAST(N'2022-05-31T18:36:04.3000000' AS DateTime2), 1, NULL, NULL, CAST(N'2022-05-31T20:28:00.8566667' AS DateTime2), N'dbo')
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (10, N'procedura', CAST(20.00 AS Decimal(18, 2)), N'150ml', N'procedura', 2, CAST(N'2022-06-01T16:44:41.1500000' AS DateTime2), 0, CAST(N'2022-06-01T16:45:27.2600000' AS DateTime2), N'dbo', CAST(N'2022-06-01T16:45:27.2633333' AS DateTime2), N'dbo')
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (11, N'kafa1', CAST(150.00 AS Decimal(18, 2)), N'200ml', N'Najbolja hladna kafa', 7, CAST(N'2022-06-08T15:32:31.8805458' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Amount], [Description], [CategoryId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (12, N'kafa1', CAST(150.00 AS Decimal(18, 2)), N'200ml', N'Najbolja hladna kafa', 7, CAST(N'2022-06-08T15:37:04.2250155' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Shifts] ON 

INSERT [dbo].[Shifts] ([Id], [Name], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, N'asd', CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2022-06-04T11:27:16.0250066' AS DateTime2), NULL, CAST(N'2022-06-04T13:40:10.8845213' AS DateTime2), NULL)
INSERT [dbo].[Shifts] ([Id], [Name], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N'Second', CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Shifts] ([Id], [Name], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'Third', CAST(N'2022-06-03T12:35:52.0335768' AS DateTime2), 0, NULL, NULL, CAST(N'2022-06-03T14:02:01.3712690' AS DateTime2), NULL)
INSERT [dbo].[Shifts] ([Id], [Name], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'fourth', CAST(N'2022-06-03T17:22:15.9751133' AS DateTime2), 0, CAST(N'2022-06-04T11:27:43.4342675' AS DateTime2), NULL, CAST(N'2022-06-04T11:27:43.4343966' AS DateTime2), NULL)
INSERT [dbo].[Shifts] ([Id], [Name], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, N'QWE', CAST(N'2022-06-10T14:45:25.8087960' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Shifts] OFF
SET IDENTITY_INSERT [dbo].[Tables] ON 

INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, N's1', 4, 6, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-06-05T15:17:29.8226050' AS DateTime2), NULL, CAST(N'2022-06-05T15:17:29.8486925' AS DateTime2), NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N's2', 5, 6, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'Updated with endpoint', 6, 7, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-05T15:09:57.1373134' AS DateTime2), NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'Api endpoint', 0, 8, CAST(N'2022-06-05T14:39:15.6959559' AS DateTime2), 0, CAST(N'2022-06-09T19:18:18.8869742' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3327312' AS DateTime2), NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, N'a1', 0, 9, CAST(N'2022-06-10T08:34:54.6522361' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, N'3', 0, 9, CAST(N'2022-06-10T08:34:59.3957989' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-10T13:39:26.6473083' AS DateTime2), NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (7, N'3', 0, 9, CAST(N'2022-06-10T08:35:03.3046416' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-10T13:40:16.5917183' AS DateTime2), NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (8, N'a4', 0, 9, CAST(N'2022-06-10T08:35:06.8134195' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (9, N'a6', 0, 9, CAST(N'2022-06-10T08:35:10.1537218' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-10T13:19:34.7360383' AS DateTime2), NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (10, N'a6', 0, 9, CAST(N'2022-06-10T08:35:13.5470968' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (11, N'389', 0, 9, CAST(N'2022-06-10T19:12:22.6639782' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tables] ([Id], [Name], [Seats], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (12, N'389', 0, 8, CAST(N'2022-06-10T19:15:57.4935233' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tables] OFF
SET IDENTITY_INSERT [dbo].[UseCaseLogs] ON 

INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1, N'test', N'test', 2, CAST(N'2022-06-07T21:32:34.963' AS DateTime), N'1', 0)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2, N'User reigstration (Using EF)', N'anonymous', 0, CAST(N'2022-06-07T19:47:01.483' AS DateTime), N'{"UserName":"filipicthost@mail.com","Password":"Lozinka123$","Name":"Filip","LastName":"Asdasd"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (3, N'Get cafes', N'EFC', 3, CAST(N'2022-06-07T19:48:49.473' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (4, N'Search use case logs', N'EFC', 3, CAST(N'2022-06-07T20:37:01.747' AS DateTime), N'{"DateFrom":null,"DateTo":null,"UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (5, N'Search use case logs', N'EFC', 3, CAST(N'2022-06-07T20:37:56.043' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1003, N'Get products', N'EFC', 3, CAST(N'2022-06-08T14:50:29.267' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1004, N'Search use case logs', N'anonymous', 0, CAST(N'2022-06-08T15:29:32.483' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 0)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1005, N'Search use case logs', N'EFC', 3, CAST(N'2022-06-08T15:30:12.493' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1006, N'Create a new product', N'anonymous', 0, CAST(N'2022-06-08T15:31:46.633' AS DateTime), N'{"Image":null,"Name":"kafa1","Description":"Najbolja hladna kafa","Price":150.0,"CategoryID":7,"ImageFileName":null,"Amount":"200ml"}', 0)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1007, N'Create a new product', N'EFC', 3, CAST(N'2022-06-08T15:32:01.050' AS DateTime), N'{"Image":null,"Name":"kafa1","Description":"Najbolja hladna kafa","Price":150.0,"CategoryID":7,"ImageFileName":null,"Amount":"200ml"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1008, N'Create a new product', N'EFC', 3, CAST(N'2022-06-08T15:34:13.443' AS DateTime), N'{"Image":null,"Name":"kafa1","Description":"Najbolja hladna kafa","Price":150.0,"CategoryID":7,"ImageFileName":null,"Amount":"200ml"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1009, N'Create a new product', N'EFC', 3, CAST(N'2022-06-08T15:36:33.860' AS DateTime), N'{"Image":{"ContentDisposition":"form-data; name=\"image\"; filename=\"coffee.JPG\"","ContentType":"image/jpeg","Headers":{"Content-Disposition":["form-data; name=\"image\"; filename=\"coffee.JPG\""],"Content-Type":["image/jpeg"]},"Length":165927,"Name":"image","FileName":"coffee.JPG"},"Name":"kafa1","Description":"Najbolja hladna kafa","Price":150.0,"CategoryID":7,"ImageFileName":"c9f6de45-abaa-466f-ace4-f8c2a9376782.JPG","Amount":"200ml"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1010, N'Get products', N'EFC', 3, CAST(N'2022-06-08T15:37:54.683' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1011, N'Get workers in cafe', N'EFC', 3, CAST(N'2022-06-08T17:50:36.173' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1012, N'Get products', N'anonymous', 0, CAST(N'2022-06-08T17:51:02.080' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 0)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1013, N'Get products', N'EFC', 3, CAST(N'2022-06-08T17:51:11.827' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1014, N'Search use case logs', N'EFC', 3, CAST(N'2022-06-08T17:51:36.833' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1015, N'Get categories', N'EFC', 3, CAST(N'2022-06-08T17:51:57.630' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1016, N'Get superusers', N'EFC', 3, CAST(N'2022-06-08T17:52:12.347' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1017, N'Get users', N'EFC', 3, CAST(N'2022-06-08T17:52:35.080' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1018, N'Search use case logs', N'EFC', 3, CAST(N'2022-06-08T17:52:55.223' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1019, N'Get users', N'EFC', 3, CAST(N'2022-06-08T17:57:14.780' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1020, N'Get superusers', N'EFC', 3, CAST(N'2022-06-08T17:57:28.487' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1021, N'Search use case logs', N'EFC', 3, CAST(N'2022-06-08T17:57:54.300' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1022, N'Get workers in cafe', N'Filip', 6, CAST(N'2022-06-08T18:02:36.237' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1023, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-08T18:02:43.173' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1024, N'Get products', N'Filip', 6, CAST(N'2022-06-08T18:07:26.737' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1025, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-08T18:09:18.423' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1026, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-08T18:10:43.497' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-01T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1027, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-08T18:11:20.577' AS DateTime), N'{"DateFrom":"2023-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1028, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-08T18:11:27.920' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1029, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-08T18:13:41.900' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1030, N'Get workers in cafe', N'Filip', 6, CAST(N'2022-06-08T18:14:06.330' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1031, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-08T18:14:11.897' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1032, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:44:44.377' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1033, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:45:11.743' AS DateTime), N'{"Keyword":"test","PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1034, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:45:21.983' AS DateTime), N'{"Keyword":"300","PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1035, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:45:31.340' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1036, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:45:41.353' AS DateTime), N'{"Keyword":"topla","PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1037, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:46:31.790' AS DateTime), N'{"Keyword":"topla","PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1038, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:46:38.160' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1039, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:46:45.137' AS DateTime), N'{"Keyword":"kafic 1","PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1040, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T18:46:50.133' AS DateTime), N'{"Keyword":"kafic 2","PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1041, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-08T19:11:59.633' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1042, N'Add product to Cafe''s menu', N'Filip', 6, CAST(N'2022-06-08T19:12:56.693' AS DateTime), N'{"ProductID":12,"CafeID":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1043, N'Add product to Cafe''s menu', N'Filip', 6, CAST(N'2022-06-08T19:13:01.650' AS DateTime), N'{"ProductID":12,"CafeID":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1044, N'Add product to Cafe''s menu', N'Filip', 6, CAST(N'2022-06-08T19:13:03.803' AS DateTime), N'{"ProductID":12,"CafeID":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1045, N'Add product to Cafe''s menu', N'Filip', 6, CAST(N'2022-06-08T19:13:32.070' AS DateTime), N'{"ProductID":12,"CafeID":15}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1046, N'Add product to Cafe''s menu', N'Filip', 6, CAST(N'2022-06-08T19:17:17.177' AS DateTime), N'{"ProductID":12,"CafeID":15}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1047, N'Add product to Cafe''s menu', N'Filip', 6, CAST(N'2022-06-08T19:17:33.630' AS DateTime), N'{"ProductID":12,"CafeID":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (1048, N'Delete a product from cafe''s menu', N'Filip', 6, CAST(N'2022-06-08T19:24:03.070' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2003, N'Get Cafe Product Orders', N'anonymous', 0, CAST(N'2022-06-09T11:23:51.243' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 0)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2004, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:24:20.280' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2005, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:24:34.947' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2006, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:25:52.380' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2007, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-09T11:26:34.103' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2008, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-09T11:27:13.507' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2009, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:27:20.697' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2010, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:29:34.883' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2011, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:30:55.290' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2012, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:31:32.500' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2013, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:33:44.813' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2014, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T11:38:11.583' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2015, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T12:16:39.883' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2016, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T12:17:12.177' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2017, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T12:17:50.850' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2018, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T12:19:27.617' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2019, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T12:22:50.737' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2020, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T12:55:54.690' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2021, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T13:00:57.833' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2022, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T13:05:35.860' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2023, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T13:07:08.270' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2024, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T13:10:07.840' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2025, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T13:11:33.203' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2026, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T13:13:02.247' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2027, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T15:22:36.363' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2028, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T15:24:04.047' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2029, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T15:24:09.123' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2030, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T15:29:37.970' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2031, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T15:33:27.670' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2032, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-09T15:33:59.413' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2033, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T15:34:46.807' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2034, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T16:27:54.983' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2035, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:28:14.080' AS DateTime), N'{"CafeProductId":4,"OrderId":1,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2036, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:31:30.863' AS DateTime), N'{"CafeProductId":4,"OrderId":1,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2037, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-09T16:32:30.907' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2038, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T16:33:50.310' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2039, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T16:34:10.080' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2040, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:36:19.173' AS DateTime), N'{"CafeProductId":4,"OrderId":1,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2041, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:39:48.523' AS DateTime), N'{"CafeProductId":4,"OrderId":1,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2042, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:42:11.273' AS DateTime), N'{"CafeProductId":4,"OrderId":1,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2043, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:42:52.687' AS DateTime), N'{"CafeProductId":4,"OrderId":1,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2044, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T16:43:06.533' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2045, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:43:36.527' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2046, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T16:43:45.557' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2047, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T16:44:13.273' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2048, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:44:18.960' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2049, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T16:44:19.713' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2050, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T16:44:22.900' AS DateTime), N'2', 1)
GO
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2051, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:20:13.373' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2052, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:25:00.490' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2053, N'Delete Cafe Product Order', N'Filip', 6, CAST(N'2022-06-09T17:31:30.913' AS DateTime), N'29', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2054, N'Delete Cafe Product Order', N'Filip', 6, CAST(N'2022-06-09T17:31:43.683' AS DateTime), N'30', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2055, N'Delete Cafe Product Order', N'Filip', 6, CAST(N'2022-06-09T17:32:04.707' AS DateTime), N'35', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2056, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:33:30.400' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2057, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:41:32.897' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2058, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:41:51.893' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2059, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:41:52.670' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2060, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:41:53.383' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2061, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:41:54.097' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2062, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:41:54.770' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2063, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:41:55.303' AS DateTime), N'{"CafeProductId":4,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2064, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:41:58.330' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2065, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-09T17:42:48.887' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2066, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:43:04.280' AS DateTime), N'{"CafeProductId":9,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2067, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:43:08.793' AS DateTime), N'{"CafeProductId":9,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2068, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:43:12.000' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2069, N'Get cafe products', N'Filip', 6, CAST(N'2022-06-09T17:44:04.407' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2070, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:45:39.603' AS DateTime), N'{"CafeProductId":9,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2071, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:47:49.403' AS DateTime), N'{"CafeProductId":9,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2072, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:47:54.807' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2073, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:52:21.857' AS DateTime), N'{"CafeProductId":9,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2074, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:52:27.663' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2075, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:52:41.423' AS DateTime), N'{"CafeProductId":8,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2076, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:52:43.700' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2077, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:53:13.527' AS DateTime), N'{"CafeProductId":8,"OrderId":2,"ProductAmount":3}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2078, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:53:20.733' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2079, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T17:53:42.617' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2080, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T17:56:48.863' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2081, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:57:16.003' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2082, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T17:58:17.493' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2083, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:58:42.517' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2084, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T17:59:28.127' AS DateTime), N'{"CafeProductId":8,"OrderId":2,"ProductAmount":7}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2085, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T17:59:31.430' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2086, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T17:59:43.133' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2087, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-09T18:00:07.980' AS DateTime), N'{"CafeProductId":8,"OrderId":2,"ProductAmount":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2088, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T18:00:11.013' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2089, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-09T18:00:20.073' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2090, N'Get cafes', N'Filip', 6, CAST(N'2022-06-09T19:08:26.957' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2091, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-09T19:09:33.120' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2092, N'Get cafes', N'Filip', 6, CAST(N'2022-06-09T19:09:51.003' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2093, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-09T19:09:57.180' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2094, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-09T19:13:26.980' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2095, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-09T19:13:53.357' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2096, N'Get cafes', N'Filip', 6, CAST(N'2022-06-09T19:13:59.250' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2097, N'Create a cafe', N'Filip', 6, CAST(N'2022-06-09T19:15:28.437' AS DateTime), N'{"Name":"asd","Description":"asdqwe","Adress":"asasdzxc"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2098, N'Get cafes', N'Filip', 6, CAST(N'2022-06-09T19:15:43.630' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2099, N'Create a cafe', N'Filip', 6, CAST(N'2022-06-09T19:17:14.963' AS DateTime), N'{"Name":"test9","Description":"test 9 jun","Adress":"9. juna"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2100, N'Get cafes', N'Filip', 6, CAST(N'2022-06-09T19:17:20.283' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2101, N'Update a cafe', N'Filip', 6, CAST(N'2022-06-09T19:17:47.227' AS DateTime), N'{"Name":"test-9","Description":"test 9 jun","Adress":"9. juna","IsActive":false,"Id":10}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2102, N'Get cafes', N'Filip', 6, CAST(N'2022-06-09T19:18:04.397' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2103, N'Deactivate a cafe', N'Filip', 6, CAST(N'2022-06-09T19:18:18.650' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2104, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-09T19:18:22.220' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2105, N'Get cafes', N'Filip', 6, CAST(N'2022-06-09T19:18:35.647' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2106, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T19:19:03.017' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2107, N'Delete Cafe Product Order', N'Filip', 6, CAST(N'2022-06-09T19:20:34.663' AS DateTime), N'27', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2108, N'Get all products from an order with its total pric', N'Filip', 6, CAST(N'2022-06-09T19:20:38.423' AS DateTime), N'27', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2109, N'Get Cafe Product Orders', N'Filip', 6, CAST(N'2022-06-09T19:20:46.407' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2110, N'Get users', N'Filip', 6, CAST(N'2022-06-09T19:21:07.027' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2111, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-10T07:06:54.383' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2112, N'Get orders', N'Filip', 6, CAST(N'2022-06-10T07:08:05.790' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2113, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:05:11.267' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2114, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:05:40.973' AS DateTime), N'1', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2115, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:06:05.957' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2116, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:13:59.633' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2117, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:14:16.407' AS DateTime), N'7', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2118, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:14:29.773' AS DateTime), N'7', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2119, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:14:53.607' AS DateTime), N'6', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2120, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:15:14.507' AS DateTime), N'8', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2121, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:15:41.913' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2122, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:18:37.263' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2123, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:24:21.517' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2124, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:27:35.353' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2125, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:30:01.377' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2126, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:30:34.873' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2127, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:31:26.067' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2128, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:31:51.490' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2129, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:32:50.043' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2130, N'Create table', N'Filip', 6, CAST(N'2022-06-10T08:34:52.897' AS DateTime), N'{"Name":"a1","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2131, N'Create table', N'Filip', 6, CAST(N'2022-06-10T08:34:59.357' AS DateTime), N'{"Name":"a2","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2132, N'Create table', N'Filip', 6, CAST(N'2022-06-10T08:35:03.257' AS DateTime), N'{"Name":"a3","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2133, N'Create table', N'Filip', 6, CAST(N'2022-06-10T08:35:06.790' AS DateTime), N'{"Name":"a4","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2134, N'Create table', N'Filip', 6, CAST(N'2022-06-10T08:35:10.147' AS DateTime), N'{"Name":"a5","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2135, N'Create table', N'Filip', 6, CAST(N'2022-06-10T08:35:13.533' AS DateTime), N'{"Name":"a6","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2136, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T08:35:30.500' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2137, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T09:26:17.757' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2138, N'Get workers in cafe', N'Filip', 6, CAST(N'2022-06-10T09:28:49.790' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2139, N'Get workers in cafe', N'Filip', 6, CAST(N'2022-06-10T09:28:55.533' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2140, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:29:10.227' AS DateTime), N'{"UserId":6,"ShiftId":2,"CafeId":9,"Date":"2022-01-08T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2141, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:29:29.867' AS DateTime), N'{"UserId":6,"ShiftId":2,"CafeId":9,"Date":"2022-08-01T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2142, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:29:35.957' AS DateTime), N'{"UserId":6,"ShiftId":3,"CafeId":9,"Date":"2022-08-01T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2143, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:29:40.753' AS DateTime), N'{"UserId":6,"ShiftId":3,"CafeId":9,"Date":"2022-08-02T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2144, N'Get workers in cafe', N'Filip', 6, CAST(N'2022-06-10T09:29:45.313' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2145, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T09:31:34.623' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2146, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T09:31:49.800' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2147, N'Get workers in cafe', N'Filip', 6, CAST(N'2022-06-10T09:33:54.230' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2148, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:34:04.500' AS DateTime), N'{"UserId":6,"ShiftId":3,"CafeId":9,"Date":"2022-08-02T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2149, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:34:39.957' AS DateTime), N'{"UserId":6,"ShiftId":3,"CafeId":9,"Date":"2022-08-02T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2150, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:34:45.127' AS DateTime), N'{"UserId":6,"ShiftId":3,"CafeId":9,"Date":"2022-08-02T00:00:00"}', 1)
GO
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2151, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:34:49.843' AS DateTime), N'{"UserId":6,"ShiftId":3,"CafeId":9,"Date":"2022-08-02T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2152, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:34:54.217' AS DateTime), N'{"UserId":6,"ShiftId":2,"CafeId":9,"Date":"2022-08-02T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2153, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:35:01.107' AS DateTime), N'{"UserId":6,"ShiftId":1,"CafeId":9,"Date":"2022-08-02T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2154, N'Create WorkersInCafe', N'Filip', 6, CAST(N'2022-06-10T09:35:06.150' AS DateTime), N'{"UserId":6,"ShiftId":1,"CafeId":9,"Date":"2022-08-01T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2155, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T09:35:09.990' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2156, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T09:37:14.867' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2157, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-10T10:33:25.447' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2158, N'Update a cafe', N'Filip', 6, CAST(N'2022-06-10T12:47:29.387' AS DateTime), N'{"Name":null,"Description":"test 9 jun","Adress":"10. juna","IsActive":false,"Id":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2159, N'Update a cafe', N'Filip', 6, CAST(N'2022-06-10T12:47:58.593' AS DateTime), N'{"Name":null,"Description":"test 10 jun","Adress":"10. juna","IsActive":false,"Id":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2160, N'Get a single cafe', N'Filip', 6, CAST(N'2022-06-10T12:48:09.913' AS DateTime), N'9', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2161, N'Update a cafe', N'Filip', 6, CAST(N'2022-06-10T12:49:02.597' AS DateTime), N'{"Name":"q","Description":"test 100 jun","Adress":"100. juna","IsActive":false,"Id":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2162, N'Update a cafe', N'Filip', 6, CAST(N'2022-06-10T13:13:11.563' AS DateTime), N'{"Name":"Update req","Description":null,"Adress":"100. juna","IsActive":false,"Id":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2163, N'Update a cafe', N'Filip', 6, CAST(N'2022-06-10T13:13:38.073' AS DateTime), N'{"Name":"Update req","Description":"test 110 jun","Adress":null,"IsActive":false,"Id":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2164, N'Update a cafe', N'Filip', 6, CAST(N'2022-06-10T13:13:52.297' AS DateTime), N'{"Name":"Update request","Description":"test 110 jun","Adress":null,"IsActive":false,"Id":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2165, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:18:16.373' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2166, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:19:12.137' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2167, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:19:17.637' AS DateTime), N'{"Id":9,"Name":"a6","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2168, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:19:21.737' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2169, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:19:34.730' AS DateTime), N'{"Id":9,"Name":"a6","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2170, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:19:37.847' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2171, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:30:15.007' AS DateTime), N'{"Id":60,"Name":"a6","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2172, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:31:01.970' AS DateTime), N'{"Id":60,"Name":"a6","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2173, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:32:44.400' AS DateTime), N'{"Id":60,"Name":"a6","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2174, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:34:26.597' AS DateTime), N'{"Id":6,"Name":null,"IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2175, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:34:37.360' AS DateTime), N'{"Id":60,"Name":null,"IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2176, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:34:51.043' AS DateTime), N'{"Id":60,"Name":null,"IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2177, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:34:57.480' AS DateTime), N'{"Id":6,"Name":null,"IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2178, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:16.747' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2179, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:20.187' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2180, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:22.173' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2181, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:22.853' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2182, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:23.437' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2183, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:23.977' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2184, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:24.470' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2185, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:24.920' AS DateTime), N'{"Id":6,"Name":"3","IsActive":false}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2186, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:36:32.833' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2187, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:36:55.210' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2188, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:36:58.247' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2189, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:37:13.487' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2190, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:37:24.580' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2191, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:38:27.803' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2192, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:39:20.053' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2193, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:39:29.133' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2194, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:39:47.617' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2195, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:39:51.390' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2196, N'Get tables', N'Filip', 6, CAST(N'2022-06-10T13:40:12.287' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2197, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:40:16.583' AS DateTime), N'{"Id":7,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2198, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:42:21.950' AS DateTime), N'{"Id":7,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2199, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:42:33.357' AS DateTime), N'{"Id":7,"Name":null,"IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2200, N'Update table table :)', N'Filip', 6, CAST(N'2022-06-10T13:42:45.390' AS DateTime), N'{"Id":6,"Name":"3","IsActive":true}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2201, N'Create Shift EF', N'Filip', 6, CAST(N'2022-06-10T14:44:46.730' AS DateTime), N'{"Name":"d"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2202, N'Create Shift EF', N'Filip', 6, CAST(N'2022-06-10T14:45:24.287' AS DateTime), N'{"Name":"QWE"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2203, N'Search Shifts', N'Filip', 6, CAST(N'2022-06-10T14:45:31.157' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2204, N'Get cafes', N'anonymous', 0, CAST(N'2022-06-10T15:40:54.217' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 0)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2205, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-10T15:42:50.813' AS DateTime), N'{"DateFrom":"2022-01-01T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2206, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-10T15:44:00.930' AS DateTime), N'{"DateFrom":"2022-10-06T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2207, N'Search use case logs', N'Filip', 6, CAST(N'2022-06-10T15:44:14.670' AS DateTime), N'{"DateFrom":"2022-06-10T00:00:00","DateTo":"2023-01-02T00:00:00","UseCaseName":null,"User":null,"UserId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2208, N'Create category', N'Filip', 6, CAST(N'2022-06-10T15:50:49.963' AS DateTime), N'{"Image":null,"ImageFileName":null,"Name":null,"ParentCategoryId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2209, N'Create category', N'Filip', 6, CAST(N'2022-06-10T15:51:44.110' AS DateTime), N'{"Image":null,"ImageFileName":null,"Name":null,"ParentCategoryId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2210, N'Create category', N'Filip', 6, CAST(N'2022-06-10T15:53:08.193' AS DateTime), N'{"Image":null,"ImageFileName":null,"Name":null,"ParentCategoryId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2211, N'Create category', N'Filip', 6, CAST(N'2022-06-10T15:53:57.400' AS DateTime), N'{"Image":null,"ImageFileName":null,"Name":"Kategorija sa autorizacijom","ParentCategoryId":null}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2212, N'Get categories', N'Filip', 6, CAST(N'2022-06-10T15:54:15.450' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2213, N'Deactivate a cafe', N'Filip', 6, CAST(N'2022-06-10T18:01:21.390' AS DateTime), N'6666', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2214, N'Deactivate a cafe', N'Filip', 6, CAST(N'2022-06-10T18:01:59.427' AS DateTime), N'6666', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2215, N'Create a new product', N'Filip', 6, CAST(N'2022-06-10T18:44:21.497' AS DateTime), N'{"Image":{"ContentDisposition":"form-data; name=\"image\"; filename=\"coffee.JPG\"","ContentType":"image/jpeg","Headers":{"Content-Disposition":["form-data; name=\"image\"; filename=\"coffee.JPG\""],"Content-Type":["image/jpeg"]},"Length":165927,"Name":"image","FileName":"coffee.JPG"},"Name":null,"Description":null,"Price":0.0,"CategoryID":7,"ImageFileName":"66dd2e45-e1f6-4f1f-9455-986a0f6f7a98.JPG","Amount":"200ml"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2216, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:07:36.800' AS DateTime), N'{"Name":"3","CafeId":0}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2217, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:08:37.530' AS DateTime), N'{"Name":"3","CafeId":0}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2218, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:09:05.537' AS DateTime), N'{"Name":"3","CafeId":0}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2219, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:09:37.197' AS DateTime), N'{"Name":"3","CafeId":0}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2220, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:09:53.403' AS DateTime), N'{"Name":"389","CafeId":0}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2221, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:12:20.903' AS DateTime), N'{"Name":"389","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2222, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:12:24.897' AS DateTime), N'{"Name":"389","CafeId":9}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2223, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:12:33.187' AS DateTime), N'{"Name":"389","CafeId":8}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2224, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:15:55.753' AS DateTime), N'{"Name":"389","CafeId":8}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2225, N'Create table', N'Filip', 6, CAST(N'2022-06-10T19:15:59.193' AS DateTime), N'{"Name":"389","CafeId":8}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2226, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-11T09:27:25.577' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2227, N'Add cafeproduct to an order', N'Filip', 6, CAST(N'2022-06-11T09:29:16.650' AS DateTime), N'{"CafeProductId":8,"OrderId":2,"ProductAmount":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2228, N'Make a reciept', N'Filip', 6, CAST(N'2022-06-11T09:29:24.013' AS DateTime), N'2', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2229, N'Delete order', N'Filip', 6, CAST(N'2022-06-11T11:36:34.990' AS DateTime), N'20', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2230, N'Create a new order', N'Filip', 6, CAST(N'2022-06-11T11:38:20.263' AS DateTime), N'{"TableId":5,"DateAndTime":"2022-10-05T00:00:00"}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2231, N'Get orders', N'Filip', 6, CAST(N'2022-06-11T11:38:24.067' AS DateTime), N'{"Keyword":null,"PerPage":15,"Page":1}', 1)
INSERT [dbo].[UseCaseLogs] ([Id], [UseCaseName], [Username], [UserId], [ExcecutionTime], [Data], [IsAuthorized]) VALUES (2232, N'Delete order', N'Filip', 6, CAST(N'2022-06-11T11:39:56.797' AS DateTime), N'6', 1)
SET IDENTITY_INSERT [dbo].[UseCaseLogs] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (1, N'test', N'test', N'test', N'test', CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (2, N'test2', N'test2', N'test2', N'test2', CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (3, N'Entity', N'Framework', N'EFC', N'$2a$11$hJYEZE5kqUdPsUOwckLwKuBLLKZ8jurqqWoYKtxL.QcaewZfopNyC', CAST(N'2022-06-04T16:05:43.6791436' AS DateTime2), 0, CAST(N'2022-06-04T16:10:56.7989694' AS DateTime2), NULL, CAST(N'2022-06-06T20:02:16.9920114' AS DateTime2), NULL, 1)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (4, N'Novi', N'User', N'Novi', N'$2a$11$MQo.Bt1xV.ijuCWt.bQgfeyC4fojSoel4vFAATk0H4bfaj1.D1Cqy', CAST(N'2022-06-06T17:42:01.9076605' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-06T19:49:37.1724564' AS DateTime2), NULL, 1)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (5, N'Novi', N'Admin', N'NoviAdmin', N'$2a$11$L09.5qeld9D5tSFkVLTqguhVQv8z.YI4tK5yhn.C3n24fR18DDm2.', CAST(N'2022-06-06T19:51:21.4012137' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-06T19:56:50.7235285' AS DateTime2), NULL, 1)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (6, N'Filip', N'Asdasd', N'Filip', N'$2a$11$sH6aszrg6Ilc1ic5EcZnS.m/4XLyPnxU8ziovwkF7AZPUbhWXv2GK', CAST(N'2022-06-07T09:55:18.5186565' AS DateTime2), 1, NULL, NULL, CAST(N'2022-06-07T17:27:46.3994520' AS DateTime2), NULL, 1)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (7, N'Filip', N'Asdasd', N'emailproba', N'$2a$11$Bk/oyDhJ/okKdBl9BlskDe/n6DcjwWnYUsBizaKudSTg0/a.jZ6xG', CAST(N'2022-06-07T14:34:29.9189976' AS DateTime2), 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (8, N'Filip', N'Asdasd', N'emailproba@mail.com', N'$2a$11$hebdjqTLchY0qn2Syun6S.F90cmHOaJplPmD7lFYUXNfl0BhVrteS', CAST(N'2022-06-07T14:41:39.1314068' AS DateTime2), 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Users] ([Id], [Name], [LastName], [UserName], [Password], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [IsSuperUser]) VALUES (9, N'Filip', N'Asdasd', N'filipicthost@mail.com', N'$2a$11$whHfgbullA7Hnm7VAWw24OgeXw6mfNcmuqHExAQ7msHSqRPKNOuPu', CAST(N'2022-06-07T19:47:04.4456881' AS DateTime2), 1, NULL, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[UserShifts] ON 

INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, 1, 1, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, 2, 1, CAST(N'2022-03-01T00:00:00.0000000' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, 1, 1, CAST(N'2022-06-04T19:54:48.2077061' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, 1, 1, CAST(N'2022-06-04T19:58:09.2677487' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, 1, 1, CAST(N'2022-06-04T20:00:04.2060317' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, 2, 3, CAST(N'2022-06-04T20:02:01.3178911' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (7, 2, 3, CAST(N'2022-06-04T23:09:34.5329304' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (8, 6, 2, CAST(N'2022-06-10T09:29:29.9452762' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (9, 6, 3, CAST(N'2022-06-10T09:29:35.9647456' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (10, 6, 3, CAST(N'2022-06-10T09:29:40.7562937' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (11, 6, 3, CAST(N'2022-06-10T09:34:41.4714031' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (12, 6, 3, CAST(N'2022-06-10T09:34:45.1638708' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (13, 6, 3, CAST(N'2022-06-10T09:34:49.8537804' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (14, 6, 2, CAST(N'2022-06-10T09:34:54.2187197' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (15, 6, 1, CAST(N'2022-06-10T09:35:01.1099428' AS DateTime2), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserShifts] ([Id], [UserId], [ShiftId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy]) VALUES (16, 6, 1, CAST(N'2022-06-10T09:35:06.1569451' AS DateTime2), 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[UserShifts] OFF
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 1)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 2)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 3)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 4)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 5)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 6)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 7)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 8)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 9)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 10)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (2, 11)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 0)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 1)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 2)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 3)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 4)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 5)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 6)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 7)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 8)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 9)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 10)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 11)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 12)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 13)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 14)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 15)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 16)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 17)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 18)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 19)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 20)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 21)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 22)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 23)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 24)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 25)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 26)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 27)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 28)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 29)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 30)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 31)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 32)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 33)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 34)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 35)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 36)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 37)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 38)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 39)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 40)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 41)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 42)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 43)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 44)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 45)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 46)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 47)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 48)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 49)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 50)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 51)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 52)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 53)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 54)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 55)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 56)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 57)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 58)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 59)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 60)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 61)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 62)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 63)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 64)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 65)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 66)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 67)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 68)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 69)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 70)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 71)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 72)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 73)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 74)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 75)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 76)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 77)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 78)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 79)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 80)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 81)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 82)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 83)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 84)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 85)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 86)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 87)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 88)
GO
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 89)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 90)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 91)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 92)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 93)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 94)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 95)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 96)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 97)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 98)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (3, 99)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 0)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 1)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 2)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 3)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 4)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 5)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 6)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 7)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 8)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 9)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 10)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 11)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 12)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 13)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 14)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 15)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 16)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 17)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 18)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 19)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 20)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 21)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 22)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 23)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 24)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 25)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 26)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 27)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 28)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 29)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 30)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 31)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 32)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 33)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 34)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 35)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 36)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 37)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 38)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 39)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 40)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 41)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 42)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 43)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 44)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 45)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 46)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 47)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 48)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 49)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 50)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 51)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 52)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 53)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 54)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 55)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 56)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 57)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 58)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 59)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 60)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 61)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 62)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 63)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 64)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 65)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 66)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 67)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 68)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 69)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 70)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 71)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 72)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 73)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 74)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 75)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 76)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 77)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 78)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 79)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 80)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 81)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 82)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 83)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 84)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 85)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 86)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 87)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 88)
GO
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 89)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 90)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 91)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 92)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 93)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 94)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 95)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 96)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 97)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 98)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (4, 99)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 0)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 1)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 2)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 3)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 4)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 5)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 6)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 7)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 8)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 9)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 10)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 11)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 12)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 13)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 14)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 15)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 16)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 17)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 18)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 19)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 20)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 21)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 22)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 23)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 24)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 25)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 26)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 27)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 28)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 29)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 30)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 31)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 32)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 33)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 34)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 35)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 36)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 37)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 38)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 39)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 40)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 41)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 42)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 43)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 44)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 45)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 46)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 47)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 48)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 49)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 50)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 51)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 52)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 53)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 54)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 55)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 56)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 57)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 58)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 59)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 60)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 61)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 62)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 63)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 64)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 65)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 66)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 67)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 68)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 69)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 70)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 71)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 72)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 73)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 74)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 75)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 76)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 77)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 78)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 79)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 80)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 81)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 82)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 83)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 84)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 85)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 86)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 87)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 88)
GO
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 89)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 90)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 91)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 92)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 93)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 94)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 95)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 96)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 97)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 98)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (5, 99)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 0)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 1)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 2)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 3)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 4)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 5)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 6)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 7)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 8)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 9)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 10)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 11)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 12)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 13)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 14)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 15)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 16)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 17)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 18)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 19)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 20)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 21)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 22)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 23)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 24)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 25)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 26)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 27)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 28)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 29)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 30)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 31)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 32)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 33)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 34)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 35)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 36)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 37)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 38)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 39)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 40)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 41)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 42)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 43)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 44)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 45)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 46)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 47)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 48)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 49)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 50)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 51)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 52)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 53)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 54)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 55)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 56)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 57)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 58)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 59)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 60)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 61)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 62)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 63)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 64)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 65)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 66)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 67)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 68)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 69)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 70)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 71)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 72)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 73)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 74)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 75)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 76)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 77)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 78)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 79)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 80)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 81)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 82)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 83)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 84)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 85)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 86)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 87)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 88)
GO
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 89)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 90)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 91)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 92)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 93)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 94)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 95)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 96)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 97)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 98)
INSERT [dbo].[UserUseCase] ([UserId], [UseCaseId]) VALUES (6, 99)
SET IDENTITY_INSERT [dbo].[WorkersInCafe] ON 

INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (4, 1, 6, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'2022-06-09T19:18:19.3036648' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3327315' AS DateTime2), NULL, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (7, 5, 6, CAST(N'2022-06-04T20:00:09.4033147' AS DateTime2), 0, CAST(N'2022-06-09T19:18:19.3037211' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3327318' AS DateTime2), NULL, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (8, 6, 6, CAST(N'2022-06-04T20:02:10.3908341' AS DateTime2), 0, CAST(N'2022-06-09T19:18:19.3037310' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3327319' AS DateTime2), NULL, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (9, 7, 6, CAST(N'2022-06-04T23:09:34.9796872' AS DateTime2), 0, CAST(N'2022-06-09T19:18:19.3037405' AS DateTime2), NULL, CAST(N'2022-06-09T19:18:19.3327322' AS DateTime2), NULL, CAST(N'2022-07-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (10, 11, 9, CAST(N'2022-06-10T09:34:41.4714652' AS DateTime2), 1, NULL, NULL, NULL, NULL, CAST(N'2022-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (11, 12, 9, CAST(N'2022-06-10T09:34:45.1638722' AS DateTime2), 1, NULL, NULL, NULL, NULL, CAST(N'2022-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (12, 13, 9, CAST(N'2022-06-10T09:34:49.8537821' AS DateTime2), 1, NULL, NULL, NULL, NULL, CAST(N'2022-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (13, 14, 9, CAST(N'2022-06-10T09:34:54.2187204' AS DateTime2), 1, NULL, NULL, NULL, NULL, CAST(N'2022-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (14, 15, 9, CAST(N'2022-06-10T09:35:01.1099440' AS DateTime2), 1, NULL, NULL, NULL, NULL, CAST(N'2022-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkersInCafe] ([Id], [UserShiftId], [CafeId], [CreatedAt], [IsActive], [DeletedAt], [DeletedBy], [UpdatedAt], [UpdatedBy], [Date]) VALUES (15, 16, 9, CAST(N'2022-06-10T09:35:06.1569473' AS DateTime2), 1, NULL, NULL, NULL, NULL, CAST(N'2022-08-01T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[WorkersInCafe] OFF
/****** Object:  Index [IX_CafeProductOrder_CafeProductId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_CafeProductOrder_CafeProductId] ON [dbo].[CafeProductOrder]
(
	[CafeProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CafeProductOrder_OrderId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_CafeProductOrder_OrderId] ON [dbo].[CafeProductOrder]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CafeProducts_CafeId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_CafeProducts_CafeId] ON [dbo].[CafeProducts]
(
	[CafeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CafeProducts_ProductID]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_CafeProducts_ProductID] ON [dbo].[CafeProducts]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Cafes_Adress]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Cafes_Adress] ON [dbo].[Cafes]
(
	[Adress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Cafes_Description]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Cafes_Description] ON [dbo].[Cafes]
(
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Cafes_Name]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Cafes_Name] ON [dbo].[Cafes]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Categories_ImageId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Categories_ImageId] ON [dbo].[Categories]
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Categories_Name]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Categories_Name] ON [dbo].[Categories]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Categories_ParentId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Categories_ParentId] ON [dbo].[Categories]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ImageProduct_ProductsId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_ImageProduct_ProductsId] ON [dbo].[ImageProduct]
(
	[ProductsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_TableId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_TableId] ON [dbo].[Orders]
(
	[TableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CategoryId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [dbo].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Products_Name]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_Name] ON [dbo].[Products]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Tables_CafeId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Tables_CafeId] ON [dbo].[Tables]
(
	[CafeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20220607-212407]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20220607-212407] ON [dbo].[UseCaseLogs]
(
	[UseCaseName] ASC,
	[Username] ASC,
	[UserId] ASC,
	[ExcecutionTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_LastName]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Users_LastName] ON [dbo].[Users]
(
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_Name]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_Users_Name] ON [dbo].[Users]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_UserName]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_UserName] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserShifts_ShiftId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserShifts_ShiftId] ON [dbo].[UserShifts]
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserShifts_UserId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserShifts_UserId] ON [dbo].[UserShifts]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_WorkersInCafe_CafeId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_WorkersInCafe_CafeId] ON [dbo].[WorkersInCafe]
(
	[CafeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_WorkersInCafe_UserShiftId]    Script Date: 12-Jun-2022 12:09:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_WorkersInCafe_UserShiftId] ON [dbo].[WorkersInCafe]
(
	[UserShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Activities] ADD  DEFAULT (user_name()) FOR [User]
GO
ALTER TABLE [dbo].[Activities] ADD  DEFAULT (getdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[CafeProducts] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Cafes] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Images] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__IsActive__412EB0B6]  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__IsSuperUs__2739D489]  DEFAULT (CONVERT([bit],(0))) FOR [IsSuperUser]
GO
ALTER TABLE [dbo].[UserShifts] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsActive]
GO
ALTER TABLE [dbo].[WorkersInCafe] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [Date]
GO
ALTER TABLE [dbo].[CafeProductOrder]  WITH CHECK ADD  CONSTRAINT [FK_CafeProductOrder_CafeProducts_CafeProductId] FOREIGN KEY([CafeProductId])
REFERENCES [dbo].[CafeProducts] ([Id])
GO
ALTER TABLE [dbo].[CafeProductOrder] CHECK CONSTRAINT [FK_CafeProductOrder_CafeProducts_CafeProductId]
GO
ALTER TABLE [dbo].[CafeProductOrder]  WITH CHECK ADD  CONSTRAINT [FK_CafeProductOrder_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[CafeProductOrder] CHECK CONSTRAINT [FK_CafeProductOrder_Orders_OrderId]
GO
ALTER TABLE [dbo].[CafeProducts]  WITH CHECK ADD  CONSTRAINT [FK_CafeProducts_Cafes_CafeId] FOREIGN KEY([CafeId])
REFERENCES [dbo].[Cafes] ([Id])
GO
ALTER TABLE [dbo].[CafeProducts] CHECK CONSTRAINT [FK_CafeProducts_Cafes_CafeId]
GO
ALTER TABLE [dbo].[CafeProducts]  WITH CHECK ADD  CONSTRAINT [FK_CafeProducts_Products_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CafeProducts] CHECK CONSTRAINT [FK_CafeProducts_Products_ProductID]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Categories_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Categories_ParentId]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Images_ImageId] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Images] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Images_ImageId]
GO
ALTER TABLE [dbo].[ImageProduct]  WITH CHECK ADD  CONSTRAINT [FK_ImageProduct_Images_ImagesId] FOREIGN KEY([ImagesId])
REFERENCES [dbo].[Images] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImageProduct] CHECK CONSTRAINT [FK_ImageProduct_Images_ImagesId]
GO
ALTER TABLE [dbo].[ImageProduct]  WITH CHECK ADD  CONSTRAINT [FK_ImageProduct_Products_ProductsId] FOREIGN KEY([ProductsId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImageProduct] CHECK CONSTRAINT [FK_ImageProduct_Products_ProductsId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Tables_TableId] FOREIGN KEY([TableId])
REFERENCES [dbo].[Tables] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Tables_TableId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Tables]  WITH CHECK ADD  CONSTRAINT [FK_Tables_Cafes_CafeId] FOREIGN KEY([CafeId])
REFERENCES [dbo].[Cafes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [FK_Tables_Cafes_CafeId]
GO
ALTER TABLE [dbo].[UserShifts]  WITH CHECK ADD  CONSTRAINT [FK_UserShifts_Shifts_ShiftId] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Shifts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserShifts] CHECK CONSTRAINT [FK_UserShifts_Shifts_ShiftId]
GO
ALTER TABLE [dbo].[UserShifts]  WITH CHECK ADD  CONSTRAINT [FK_UserShifts_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserShifts] CHECK CONSTRAINT [FK_UserShifts_Users_UserId]
GO
ALTER TABLE [dbo].[UserUseCase]  WITH CHECK ADD  CONSTRAINT [FK_UserUseCase_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserUseCase] CHECK CONSTRAINT [FK_UserUseCase_Users_UserId]
GO
ALTER TABLE [dbo].[WorkersInCafe]  WITH CHECK ADD  CONSTRAINT [FK_WorkersInCafe_Cafes_CafeId] FOREIGN KEY([CafeId])
REFERENCES [dbo].[Cafes] ([Id])
GO
ALTER TABLE [dbo].[WorkersInCafe] CHECK CONSTRAINT [FK_WorkersInCafe_Cafes_CafeId]
GO
ALTER TABLE [dbo].[WorkersInCafe]  WITH CHECK ADD  CONSTRAINT [FK_WorkersInCafe_UserShifts_UserShiftId] FOREIGN KEY([UserShiftId])
REFERENCES [dbo].[UserShifts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WorkersInCafe] CHECK CONSTRAINT [FK_WorkersInCafe_UserShifts_UserShiftId]
GO
/****** Object:  StoredProcedure [dbo].[AddLogRecord]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddLogRecord] 
	-- Add the parameters for the stored procedure here
	@useCaseName nvarchar(50), 
	@username nvarchar(50),
	@userId int,
	@excecutionTime datetime,
	@data nvarchar(max),
	@isAuthorized bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into UseCaseLogs(UseCaseName,Username,UserId,ExcecutionTime,Data,IsAuthorized)
	values(@useCaseName,@username,@userId,@excecutionTime,@data,@isAuthorized)
END
GO
/****** Object:  StoredProcedure [dbo].[Change_Product_Price]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Change_Product_Price]
	-- Add the parameters for the stored procedure here
	@ProductId int,
	@Price decimal = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	if @Price>0
		begin
			update Products 
			set Price = @Price where Id = @ProductId
		end
END
GO
/****** Object:  StoredProcedure [dbo].[Create_Product]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Create_Product] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(30),
	@price DECIMAL(18,2),
	@amount nvarchar(10),
	@description nvarchar(50),
	@categoryId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	
		

	IF @price <= 0
		THROW 50001, 'Price must be greater than 0!', 1;


	IF EXISTS(SELECT * FROM Categories c WHERE c.Id = @categoryId)
	 BEGIN
		INSERT into Products (Name,Price,Amount,Description,CategoryId,CreatedAt,IsActive)
		values (@name,@price,@amount,@description,@categoryId,GETDATE(),'true')

	 END
	
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Product]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Delete_Product]
	-- Add the parameters for the stored procedure here
	@ProductId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Products where Id = @ProductId
END
GO
/****** Object:  StoredProcedure [dbo].[FindProductsInCafe]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindProductsInCafe]
	-- Add the parameters for the stored procedure here
	@CafeName nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Products.Name, Products.Price, Products.Amount, Products.Description, Categories.Name AS Category
FROM   Cafes INNER JOIN CafeProducts ON Cafes.Id = CafeProducts.CafeId INNER JOIN Products 
ON CafeProducts.ProductID = Products.Id INNER JOIN  Categories ON Products.CategoryId = Categories.Id
where Cafes.Name in(@CafeName) and Products.IsActive = 'true'
END
GO
/****** Object:  StoredProcedure [dbo].[SearchUseCaseLogs]    Script Date: 12-Jun-2022 12:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchUseCaseLogs]
	-- Add the parameters for the stored procedure here
	@dateFrom datetime,
	@dateTo datetime,
	@usecasename nvarchar(50),
	@userid int,
	@user nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UseCaseName,Username as [User], UserId,ExcecutionTime, Data,IsAuthorized
	from UseCaseLogs where ExcecutionTime between @datefrom and @dateto and 
	(@usecasename is null or UseCaseName like '%' + @usecasename + '%') and
	(@userid is null or UserId = @userid) and 
	(@user is null or Username like '%' + @user + '%')
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[15] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CafeProducts"
            Begin Extent = 
               Top = 94
               Left = 356
               Bottom = 224
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 87
               Left = 562
               Bottom = 303
               Right = 786
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Categories"
            Begin Extent = 
               Top = 101
               Left = 865
               Bottom = 305
               Right = 1109
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cafes"
            Begin Extent = 
               Top = 114
               Left = 114
               Bottom = 244
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cafe_Product_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cafe_Product_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cafe_Product_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cafes"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 223
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cafe_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cafe_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[11] 2[6] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CafeProductOrder"
            Begin Extent = 
               Top = 32
               Left = 103
               Bottom = 325
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CafeProducts"
            Begin Extent = 
               Top = 44
               Left = 431
               Bottom = 249
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cafes"
            Begin Extent = 
               Top = 181
               Left = 913
               Bottom = 311
               Right = 1083
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 160
               Left = 1097
               Bottom = 290
               Right = 1267
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 8
               Left = 846
               Bottom = 138
               Right = 1041
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Tables"
            Begin Extent = 
               Top = 200
               Left = 702
               Bottom = 330
               Right = 872
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Wid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CafeProductOrder_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'th = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1935
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CafeProductOrder_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CafeProductOrder_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Categories"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 291
               Right = 374
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Category_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Category_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Images"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 285
               Right = 307
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Image_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Image_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Orders"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 256
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tables"
            Begin Extent = 
               Top = 133
               Left = 375
               Bottom = 263
               Right = 545
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CafeProductOrder"
            Begin Extent = 
               Top = 13
               Left = 840
               Bottom = 251
               Right = 1184
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Order_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Order_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[7] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 260
               Right = 302
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Categories"
            Begin Extent = 
               Top = 6
               Left = 340
               Bottom = 278
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Product_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Product_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Shifts"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 231
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Shifts_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Shifts_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tables"
            Begin Extent = 
               Top = 24
               Left = 747
               Bottom = 276
               Right = 1012
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cafes"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 270
               Right = 598
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Table_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Table_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 307
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Users_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Users_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UserShifts"
            Begin Extent = 
               Top = 27
               Left = 474
               Bottom = 157
               Right = 644
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 202
               Left = 499
               Bottom = 332
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Shifts"
            Begin Extent = 
               Top = 114
               Left = 746
               Bottom = 244
               Right = 916
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WorkersInCafe"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserShift_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserShift_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserShift_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkersInCafe"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 265
               Right = 287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserShifts"
            Begin Extent = 
               Top = 6
               Left = 325
               Bottom = 196
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 169
               Left = 565
               Bottom = 299
               Right = 735
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Shifts"
            Begin Extent = 
               Top = 148
               Left = 932
               Bottom = 278
               Right = 1102
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cafes"
            Begin Extent = 
               Top = 49
               Left = 1103
               Bottom = 179
               Right = 1273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Workers_In_Cafe_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Workers_In_Cafe_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Workers_In_Cafe_View'
GO
USE [master]
GO
ALTER DATABASE [KaficiProjekat] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [ME]    Script Date: 20/02/2022 00:39:10 ******/
CREATE DATABASE [ME]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ME', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ME.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ME_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ME_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ME] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ME].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ME] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ME] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ME] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ME] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ME] SET ARITHABORT OFF 
GO
ALTER DATABASE [ME] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ME] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ME] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ME] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ME] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ME] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ME] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ME] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ME] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ME] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ME] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ME] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ME] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ME] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ME] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ME] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ME] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ME] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ME] SET  MULTI_USER 
GO
ALTER DATABASE [ME] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ME] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ME] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ME] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ME] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ME] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ME] SET QUERY_STORE = OFF
GO
USE [ME]
GO
/****** Object:  Sequence [dbo].[POSTS_SEQ]    Script Date: 20/02/2022 00:39:10 ******/
CREATE SEQUENCE [dbo].[POSTS_SEQ] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9999999999999
 CACHE 
GO
/****** Object:  Table [dbo].[POST_LIKES]    Script Date: 20/02/2022 00:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POST_LIKES](
	[POST_ID] [int] NOT NULL,
	[USER_ID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[POSTS]    Script Date: 20/02/2022 00:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POSTS](
	[POST_ID] [int] NOT NULL,
	[POST_TITLE] [nvarchar](50) NOT NULL,
	[POST_CONTENT] [ntext] NOT NULL,
	[CRT_USER_ID] [int] NOT NULL,
	[INS_DATE] [date] NULL,
	[UPD_DATE] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[POST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[NUM_LIKES_PER_POST]    Script Date: 20/02/2022 00:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[NUM_LIKES_PER_POST]
AS
SELECT        dbo.POSTS.POST_ID, COUNT(dbo.POST_LIKES.USER_ID) AS NUM_LIKES
FROM            dbo.POST_LIKES INNER JOIN
                         dbo.POSTS ON dbo.POST_LIKES.POST_ID = dbo.POSTS.POST_ID
GROUP BY dbo.POSTS.POST_ID
GO
/****** Object:  Table [dbo].[ERRORS]    Script Date: 20/02/2022 00:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERRORS](
	[DATE_TIME] [datetime] NOT NULL,
	[FUNCTION_NAME] [nvarchar](50) NULL,
	[ERROR] [ntext] NOT NULL,
	[USER_ID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 20/02/2022 00:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[USER_ID] [int] NOT NULL,
	[POST_BLOG_ALLOWED] [bit] NULL,
	[USER_NAME] [nvarchar](50) NULL,
	[PASSWORD] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[USER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[POST_LIKES]  WITH NOCHECK ADD FOREIGN KEY([USER_ID])
REFERENCES [dbo].[USERS] ([USER_ID])
GO
ALTER TABLE [dbo].[POSTS]  WITH CHECK ADD FOREIGN KEY([CRT_USER_ID])
REFERENCES [dbo].[USERS] ([USER_ID])
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
         Begin Table = "POST_LIKES"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "POSTS"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
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
      Begin ColumnWidths = 12
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NUM_LIKES_PER_POST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NUM_LIKES_PER_POST'
GO
USE [master]
GO
ALTER DATABASE [ME] SET  READ_WRITE 
GO

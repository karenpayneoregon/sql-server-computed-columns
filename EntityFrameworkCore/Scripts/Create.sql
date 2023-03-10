USE [master]
GO
/****** Object:  Database [ComputedSample]    Script Date: 12/18/2022 2:33:22 PM ******/
CREATE DATABASE [ComputedSample]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ComputedSample', FILENAME = N'C:\Users\paynek\ComputedSample.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ComputedSample_log', FILENAME = N'C:\Users\paynek\ComputedSample_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ComputedSample] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ComputedSample].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ComputedSample] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ComputedSample] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ComputedSample] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ComputedSample] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ComputedSample] SET ARITHABORT OFF 
GO
ALTER DATABASE [ComputedSample] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ComputedSample] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ComputedSample] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ComputedSample] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ComputedSample] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ComputedSample] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ComputedSample] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ComputedSample] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ComputedSample] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ComputedSample] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ComputedSample] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ComputedSample] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ComputedSample] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ComputedSample] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ComputedSample] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ComputedSample] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ComputedSample] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ComputedSample] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ComputedSample] SET  MULTI_USER 
GO
ALTER DATABASE [ComputedSample] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ComputedSample] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ComputedSample] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ComputedSample] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ComputedSample] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ComputedSample] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ComputedSample] SET QUERY_STORE = OFF
GO
USE [ComputedSample]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 12/18/2022 2:33:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[BirthDate] [date] NULL,
	[YearsOld]  AS (datediff(year,[BirthDate],getdate())),
	[FullName]  AS (([FirstName]+' ')+[LastName]),
	[BirthYear]  AS (datepart(year,[BirthDate])),
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [BirthDate]) VALUES (1, N'Karen', N'Payne', CAST(N'1956-09-24' AS Date))
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [BirthDate]) VALUES (2, N'Mike', N'Williams', CAST(N'1999-11-02' AS Date))
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [BirthDate]) VALUES (3, N'Jane', N'Adams', CAST(N'1999-10-11' AS Date))
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [BirthDate]) VALUES (4, N'Greg', N'Smith', CAST(N'1970-01-05' AS Date))
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [BirthDate]) VALUES (5, N'Anne', N'Harrison', CAST(N'1955-04-05' AS Date))
SET IDENTITY_INSERT [dbo].[Contact] OFF
GO
/****** Object:  Index [NonClusteredIndexYearsOld]    Script Date: 12/18/2022 2:33:22 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndexYearsOld] ON [dbo].[Contact]
(
	[BirthDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [ComputedSample] SET  READ_WRITE 
GO

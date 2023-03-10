USE [master]
GO
/****** Object:  Database [ComputedSample]    Script Date: 1/6/2023 4:29:56 AM ******/
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
/****** Object:  Table [dbo].[Contact]    Script Date: 1/6/2023 4:29:56 AM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 1/6/2023 4:29:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[PriceRaw] [decimal](18, 6) NOT NULL,
	[Price]  AS (CONVERT([decimal](18,2),[PriceRaw])),
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
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
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (1, N'Inquestamazz', CAST(369.961658 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (2, N'Doperover', CAST(433.765234 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (3, N'Barnipax', CAST(465.553451 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (4, N'Surnipopistor', CAST(279.797906 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (5, N'Froeramar', CAST(220.897055 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (6, N'Trudimar', CAST(97.236881 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (7, N'Tupsapentor', CAST(309.977408 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (8, N'Gronipentor', CAST(93.483829 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (9, N'Indudower', CAST(456.333346 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (10, N'Winkilaquax', CAST(310.042013 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (11, N'Endnipefax', CAST(96.939697 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (12, N'Suppebentor', CAST(245.364373 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (13, N'Dopmunan', CAST(479.148274 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (14, N'Trueriman', CAST(133.194888 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (15, N'Refropazz', CAST(85.109887 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (16, N'Barquestackicator', CAST(396.515228 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (17, N'Tuprobommistor', CAST(83.880299 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (18, N'Surwerpin', CAST(66.181753 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (19, N'Sursapazz', CAST(231.184796 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (20, N'Parwerar', CAST(297.532558 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (21, N'Cipsapazz', CAST(79.619261 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (22, N'Sursipicator', CAST(286.116701 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (23, N'Hapjuban', CAST(201.610972 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (24, N'Barnipilantor', CAST(236.133720 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (25, N'Supcadefower', CAST(134.363964 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (26, N'Thrukiledistor', CAST(221.705911 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (27, N'Groveninin', CAST(35.907038 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (28, N'Parcadegex', CAST(208.639596 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (29, N'Parcadantor', CAST(471.261173 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (30, N'Tupcadamex', CAST(196.224508 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (31, N'Hapglibefan', CAST(482.108872 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (32, N'Frotumantor', CAST(357.276071 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (33, N'Endpebefax', CAST(439.417103 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (34, N'Barmunedar', CAST(358.391714 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (35, N'Upfropinover', CAST(450.982976 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (36, N'Monpebor', CAST(121.606637 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (37, N'Grosipin', CAST(459.223387 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (38, N'Advenar', CAST(303.407945 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (39, N'Parkilin', CAST(33.324212 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (40, N'Varglibplicator', CAST(266.472764 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (41, N'Zeenipin', CAST(88.972995 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (42, N'Insapar', CAST(383.982648 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (43, N'Grofropimistor', CAST(79.320558 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (44, N'Vartumin', CAST(196.060955 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (45, N'Emwerpollex', CAST(427.093373 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (46, N'Tipglibamin', CAST(172.356693 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (47, N'Tippebazz', CAST(208.082226 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (48, N'Tiperentor', CAST(269.904282 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (49, N'Adtinadicator', CAST(196.479651 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (50, N'Cipquestantor', CAST(415.273833 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (51, N'Supdimistor', CAST(308.950697 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (52, N'Unwerpanex', CAST(77.322471 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (53, N'Hapglibin', CAST(143.796766 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (54, N'Lomsipower', CAST(260.772091 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (55, N'Unsapackentor', CAST(318.968376 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (56, N'Vartanommicator', CAST(93.844957 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (57, N'Cipdimar', CAST(242.154261 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (58, N'Thrutinaquower', CAST(239.419731 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (59, N'Tipglibentor', CAST(155.433942 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (60, N'Tipcadedgentor', CAST(499.191145 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (61, N'Zeejubopan', CAST(71.329843 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (62, N'Thrunipor', CAST(111.337811 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (63, N'Emdimommar', CAST(122.222657 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (64, N'Adwerpover', CAST(270.108837 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (65, N'Lomhupommentor', CAST(327.933142 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (66, N'Zeetumefower', CAST(239.663626 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (67, N'Trusipupax', CAST(305.947270 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (68, N'Injubollentor', CAST(130.756560 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (69, N'Tiptanax', CAST(182.211912 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (70, N'Suptanedgazz', CAST(463.503251 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (71, N'Truvenower', CAST(437.291842 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (72, N'Ciptinedar', CAST(280.472354 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (73, N'Tipglibax', CAST(42.857540 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (74, N'Lompickex', CAST(464.712032 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (75, N'Thruwerpantor', CAST(218.559563 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (76, N'Tuprobonicator', CAST(195.636613 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (77, N'Tuppebor', CAST(216.796142 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (78, N'Tuppickupistor', CAST(15.550017 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (79, N'Repebazz', CAST(309.040347 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (80, N'Grovenar', CAST(462.007272 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (81, N'Rappickentor', CAST(23.623684 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (82, N'Infropackentor', CAST(266.002757 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (83, N'Klisipackax', CAST(22.159945 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (84, N'Happebplower', CAST(65.987339 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (85, N'Qwibanin', CAST(387.273812 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (86, N'Supcadefan', CAST(414.786400 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (87, N'Klifropimower', CAST(223.479304 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (88, N'Qwiwerpantor', CAST(188.645012 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (89, N'Grorobonover', CAST(49.423338 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (90, N'Barbanewar', CAST(367.138019 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (91, N'Tipzapedgistor', CAST(379.452376 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (92, N'Windudopover', CAST(229.803656 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (93, N'Zeepebopor', CAST(157.974003 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (94, N'Tipkilaquex', CAST(34.133067 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (95, N'Raphupover', CAST(205.142921 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (96, N'Tupjubax', CAST(477.635184 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (97, N'Intanax', CAST(271.759991 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (98, N'Intuman', CAST(309.211721 AS Decimal(18, 6)))
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (99, N'Thrupebinover', CAST(368.127813 AS Decimal(18, 6)))
GO
INSERT [dbo].[Products] ([Id], [ProductName], [PriceRaw]) VALUES (100, N'Klifropin', CAST(197.429747 AS Decimal(18, 6)))
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
/****** Object:  Index [NonClusteredIndexYearsOld]    Script Date: 1/6/2023 4:29:56 AM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndexYearsOld] ON [dbo].[Contact]
(
	[BirthDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [ComputedSample] SET  READ_WRITE 
GO

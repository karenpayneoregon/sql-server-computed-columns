--- First create the database 
--- Note the connection string is in appsettings.json

USE [ComputedSample4]
GO
/****** Object:  Table [dbo].[Office]    Script Date: 5/18/2024 4:38:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Office](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Computed]  AS (case when [Id]<(9999) then 'OF'+right('000'+CONVERT([varchar],[Id],(10)),(4)) else 'OF'+CONVERT([varchar],[Id],(10)) end) PERSISTED,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Office1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

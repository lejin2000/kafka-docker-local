USE [db1]
GO
/****** Object:  Table [dbo].[Table1]    Script Date: 20/3/2025 2:57:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table1](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[col1] [nvarchar](50) NULL,
	[col2] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Table1] ON 
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (1, N'1', N'a')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (2, N'2', N'b')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (3, N'3', N'c')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (4, N'4', N'd')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (5, N'5', N'c')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (6, N'6', N'd')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (7, N'7', N'e')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (8, N'8', N'd')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (9, N'9', N'e')
GO
INSERT [dbo].[Table1] ([id], [col1], [col2]) VALUES (10, N'10', N'f')
GO
SET IDENTITY_INSERT [dbo].[Table1] OFF
GO

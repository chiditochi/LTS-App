USE [LongTermSegApp]
GO
/****** Object:  Table [dbo].[data]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[data](
	[ClientID] [int] NOT NULL,
	[AssessmentDate] [nvarchar](50) NULL,
	[system_ValidationData] [nvarchar](50) NULL,
	[type12_NoteID] [tinyint] NOT NULL,
	[type12_OriginalNoteID] [nvarchar](50) NULL,
	[type12_DeletedDate] [nvarchar](50) NULL,
	[type12_UpdatedBy] [nvarchar](50) NULL,
	[type12_UpdatedDate] [nvarchar](50) NULL,
	[type12_NoteGroup] [tinyint] NOT NULL,
	[patward] [nvarchar](50) NULL,
	[patRC] [nvarchar](50) NULL,
	[LTStart] [nvarchar](50) NULL,
	[LTSReason] [nvarchar](50) NULL,
	[IR1SUISecRef] [nvarchar](50) NULL,
	[LTSReview] [nvarchar](50) NULL,
	[LTSreviewoutcome] [nvarchar](50) NULL,
	[LTSComments] [nvarchar](50) NULL,
	[LTSExit] [nvarchar](50) NULL,
	[sg_CreatedBy] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DutyTypes]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DutyTypes](
	[DutyTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DutyTypes] PRIMARY KEY CLUSTERED 
(
	[DutyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[PatientId] [bigint] IDENTITY(1,1) NOT NULL,
	[WardId] [bigint] NULL,
	[UserId] [bigint] NOT NULL,
	[DutyTypeId] [bigint] NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewOutcomes]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewOutcomes](
	[ReviewOutcomeId] [bigint] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_LTSreviewoutcome] PRIMARY KEY CLUSTERED 
(
	[ReviewOutcomeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAssessltsrevpatients]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAssessltsrevpatients](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[system_ValidationData] [xml] NULL,
	[LTSreviewoutcome] [nvarchar](20) NULL,
	[LTSComments] [ntext] NULL,
	[ClientID] [nvarchar](15) NOT NULL,
	[AssessmentDate] [datetime] NULL,
	[LTSReview] [datetime] NULL,
	[LTStart] [datetime] NULL,
	[type12_NoteID] [int] NOT NULL,
	[type12_OriginalNoteID] [int] NULL,
	[type12_DeletedDate] [datetime] NULL,
	[type12_UpdatedBy] [nvarchar](20) NULL,
	[type12_UpdatedDate] [datetime] NULL,
	[type12_NoteGroup]  AS (isnull([type12_OriginalNoteID],[type12_NoteID])) PERSISTED NOT NULL,
	[LTSExit] [datetime] NULL,
	[patward] [nvarchar](40) NULL,
	[patRC] [nvarchar](40) NULL,
	[LTSReason] [nvarchar](20) NULL,
	[IR1SUISecRef] [nvarchar](200) NULL,
 CONSTRAINT [PK_UserAssessltsrevpatients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserTypeId] [bigint] NOT NULL,
	[DutyTypeId] [bigint] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[UserTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Label] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[UserTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wards]    Script Date: 2023-09-04 11:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wards](
	[WardId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PatWard] PRIMARY KEY CLUSTERED 
(
	[WardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[data] ([ClientID], [AssessmentDate], [system_ValidationData], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [type12_NoteGroup], [patward], [patRC], [LTStart], [LTSReason], [IR1SUISecRef], [LTSReview], [LTSreviewoutcome], [LTSComments], [LTSExit], [sg_CreatedBy]) VALUES (1000343, N'1900-01-00', N'NULL', 8, N'NULL', N'NULL', N'APIUSER', N'1900-01-00', 8, N'contcare', N'John Doe', N'1900-01-00', N'RP05', N'3000', N'1900-01-00', N'AO101', N'Remain in LTS', N'NULL', N'APIUSER')
INSERT [dbo].[data] ([ClientID], [AssessmentDate], [system_ValidationData], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [type12_NoteGroup], [patward], [patRC], [LTStart], [LTSReason], [IR1SUISecRef], [LTSReview], [LTSreviewoutcome], [LTSComments], [LTSExit], [sg_CreatedBy]) VALUES (1000343, N'1900-01-00', N'NULL', 7, N'NULL', N'NULL', N'APIUSER', N'1900-01-00', 7, N'contcare', N'John Doe', N'1900-01-00', N'RP05', N'3000', N'1900-01-00', N'AO101', N'Remain in LTS', N'NULL', N'APIUSER')
INSERT [dbo].[data] ([ClientID], [AssessmentDate], [system_ValidationData], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [type12_NoteGroup], [patward], [patRC], [LTStart], [LTSReason], [IR1SUISecRef], [LTSReview], [LTSreviewoutcome], [LTSComments], [LTSExit], [sg_CreatedBy]) VALUES (1000343, N'1900-01-00', N'NULL', 6, N'NULL', N'NULL', N'osemej', N'1900-01-00', 6, N'aintree', N'Dr Carlo Thomas  (thocar)', N'1900-01-00', N'RP05', N'NULL', N'1900-01-00', N'AO101', N'Stay on LTS.', N'NULL', N'osemej')
INSERT [dbo].[data] ([ClientID], [AssessmentDate], [system_ValidationData], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [type12_NoteGroup], [patward], [patRC], [LTStart], [LTSReason], [IR1SUISecRef], [LTSReview], [LTSreviewoutcome], [LTSComments], [LTSExit], [sg_CreatedBy]) VALUES (1000343, N'1900-01-00', N'NULL', 5, N'4', N'NULL', N'meakii', N'1900-01-00', 4, N'aintree', N'Dr Carlo Thomas  (thocar)', N'1900-01-00', N'RP05', N'NULL', N'NULL', N'NULL', N'Hello this is a comment', N'NULL', N'meakii')
INSERT [dbo].[data] ([ClientID], [AssessmentDate], [system_ValidationData], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [type12_NoteGroup], [patward], [patRC], [LTStart], [LTSReason], [IR1SUISecRef], [LTSReview], [LTSreviewoutcome], [LTSComments], [LTSExit], [sg_CreatedBy]) VALUES (1000668, N'1900-01-00', N'NULL', 3, N'NULL', N'NULL', N'stanij', N'1900-01-00', 3, N'contcare', N'Dr Darran Bloye  (bloyed)', N'1900-01-00', N'RP06', N'NULL', N'NULL', N'NULL', N'NULL', N'NULL', N'stanij')
GO
SET IDENTITY_INSERT [dbo].[DutyTypes] ON 

INSERT [dbo].[DutyTypes] ([DutyTypeId], [Name], [CreatedAt], [UpdatedAt]) VALUES (1, N'Ward', CAST(N'2023-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2023-08-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[DutyTypes] ([DutyTypeId], [Name], [CreatedAt], [UpdatedAt]) VALUES (2, N'Clinician', CAST(N'2023-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2023-08-29T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[DutyTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Patients] ON 

INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 1, 1, N'Mercedes', N'Donnelly', CAST(N'2023-08-29T23:28:28.1535425' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (2, 1, 1, 1, N'Dolores', N'Dickens', CAST(N'2023-08-29T23:28:28.1535519' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (3, 2, 1, 1, N'Roberto', N'Sporer', CAST(N'2023-08-29T23:28:28.1535521' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (4, 2, 1, 1, N'Samantha', N'Brown', CAST(N'2023-08-29T23:28:28.1535523' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (5, 3, 1, 1, N'Benjamin', N'Weber', CAST(N'2023-08-29T23:28:28.1535525' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (6, 2, 1, 1, N'Doyle', N'Roob', CAST(N'2023-08-29T23:28:28.1535568' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (7, 3, 1, 1, N'Lisa', N'Ortiz', CAST(N'2023-08-29T23:28:28.1535571' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (8, 1, 1, 1, N'Floyd', N'Connelly', CAST(N'2023-08-29T23:28:28.1535573' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (9, 3, 1, 1, N'Pat', N'Smith', CAST(N'2023-08-29T23:28:28.1535575' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (10, 1, 1, 1, N'Willie', N'Hegmann', CAST(N'2023-08-29T23:28:28.1535580' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (11, 2, 1, 1, N'Boyd', N'Balistreri', CAST(N'2023-08-29T23:28:28.1535583' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (12, 2, 1, 1, N'Janis', N'Mitchell', CAST(N'2023-08-29T23:28:28.1535585' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (13, 1, 1, 1, N'Rosie', N'Oberbrunner', CAST(N'2023-08-29T23:28:28.1535586' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (14, 3, 1, 1, N'Melissa', N'Mayert', CAST(N'2023-08-29T23:28:28.1535587' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (15, 3, 1, 1, N'Derek', N'Harris', CAST(N'2023-08-29T23:28:28.1535588' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (16, 1, 1, 1, N'Edna', N'Lowe', CAST(N'2023-08-29T23:28:28.1535590' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (17, 1, 1, 1, N'Crystal', N'Aufderhar', CAST(N'2023-08-29T23:28:28.1535595' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (18, 1, 1, 1, N'Sheila', N'Stanton', CAST(N'2023-08-29T23:28:28.1535598' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (19, 3, 1, 1, N'Peter', N'Rolfson', CAST(N'2023-08-29T23:28:28.1535599' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (20, 2, 1, 1, N'Amelia', N'Glover', CAST(N'2023-08-29T23:28:28.1535601' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (21, 3, 1, 1, N'Jenny', N'Jenkins', CAST(N'2023-08-29T23:28:28.1535605' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (22, 1, 1, 1, N'Randolph', N'Paucek', CAST(N'2023-08-29T23:28:28.1535606' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (23, 1, 1, 1, N'Cody', N'Denesik', CAST(N'2023-08-29T23:28:28.1535607' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (24, 1, 1, 1, N'Cecilia', N'Breitenberg', CAST(N'2023-08-29T23:28:28.1535609' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (25, 1, 1, 1, N'Shane', N'Pacocha', CAST(N'2023-08-29T23:28:28.1535610' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (26, 1, 1, 1, N'Fredrick', N'Kuhn', CAST(N'2023-08-29T23:28:28.1535611' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (27, 1, 1, 1, N'Shari', N'Kling', CAST(N'2023-08-29T23:28:28.1535614' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (28, 1, 1, 1, N'Willie', N'Smitham', CAST(N'2023-08-29T23:28:28.1535615' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (29, 1, 1, 1, N'Cecil', N'Klocko', CAST(N'2023-08-29T23:28:28.1535617' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (30, 3, 1, 1, N'Pedro', N'Wisozk', CAST(N'2023-08-29T23:28:28.1535619' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (31, 1, 1, 1, N'Darrin', N'Gutkowski', CAST(N'2023-08-29T23:28:28.1535623' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (32, 3, 1, 1, N'Lewis', N'Daniel', CAST(N'2023-08-29T23:28:28.1535624' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (33, 2, 1, 1, N'Jacqueline', N'Tromp', CAST(N'2023-08-29T23:28:28.1535625' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (34, 2, 1, 1, N'Kathryn', N'Towne', CAST(N'2023-08-29T23:28:28.1535629' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (35, 1, 1, 1, N'Jeannie', N'Emmerich', CAST(N'2023-08-29T23:28:28.1535630' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (36, 1, 1, 1, N'Owen', N'Herman', CAST(N'2023-08-29T23:28:28.1535631' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (37, 3, 1, 1, N'June', N'Stoltenberg', CAST(N'2023-08-29T23:28:28.1535632' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (38, 3, 1, 1, N'Tony', N'Padberg', CAST(N'2023-08-29T23:28:28.1535634' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (39, 3, 1, 1, N'Bradley', N'Kilback', CAST(N'2023-08-29T23:28:28.1535635' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (40, 1, 1, 1, N'Kyle', N'O''Connell', CAST(N'2023-08-29T23:28:28.1535637' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (41, 2, 1, 1, N'Ray', N'Muller', CAST(N'2023-08-29T23:28:28.1535668' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (42, 1, 1, 1, N'Timmy', N'Parker', CAST(N'2023-08-29T23:28:28.1535671' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (43, 1, 1, 1, N'Janis', N'Mueller', CAST(N'2023-08-29T23:28:28.1535672' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (44, 3, 1, 1, N'Rhonda', N'Beatty', CAST(N'2023-08-29T23:28:28.1535675' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (45, 3, 1, 1, N'Elsa', N'Jones', CAST(N'2023-08-29T23:28:28.1535676' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (46, 2, 1, 1, N'Brooke', N'Goodwin', CAST(N'2023-08-29T23:28:28.1535678' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (47, 2, 1, 1, N'Drew', N'Torp', CAST(N'2023-08-29T23:28:28.1535679' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (48, 3, 1, 1, N'Mark', N'Pagac', CAST(N'2023-08-29T23:28:28.1535681' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (49, 3, 1, 1, N'Emmett', N'Bins', CAST(N'2023-08-29T23:28:28.1535682' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (50, 2, 1, 1, N'Joseph', N'McClure', CAST(N'2023-08-29T23:28:28.1535793' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (51, 1, 1, 1, N'Randy', N'Kessler', CAST(N'2023-08-29T23:28:28.1535799' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (52, 1, 1, 1, N'Willard', N'Marquardt', CAST(N'2023-08-29T23:28:28.1535802' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (53, 3, 1, 1, N'Cecilia', N'Abshire', CAST(N'2023-08-29T23:28:28.1535803' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (54, 3, 1, 1, N'Gabriel', N'Douglas', CAST(N'2023-08-29T23:28:28.1535805' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (55, 2, 1, 1, N'Anita', N'Terry', CAST(N'2023-08-29T23:28:28.1535806' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (56, 3, 1, 1, N'Flora', N'Rolfson', CAST(N'2023-08-29T23:28:28.1535807' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (57, 2, 1, 1, N'Adrienne', N'Denesik', CAST(N'2023-08-29T23:28:28.1535809' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (58, 2, 1, 1, N'Tommy', N'Kilback', CAST(N'2023-08-29T23:28:28.1535811' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (59, 2, 1, 1, N'Sheri', N'Wiegand', CAST(N'2023-08-29T23:28:28.1535814' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (60, 2, 1, 1, N'Valerie', N'Ruecker', CAST(N'2023-08-29T23:28:28.1535816' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (61, NULL, 1, 2, N'Bobby', N'Wyman', CAST(N'2023-08-29T23:28:28.1535818' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (62, NULL, 1, 2, N'Sherri', N'Williamson', CAST(N'2023-08-29T23:28:28.1535819' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (63, NULL, 1, 2, N'Antoinette', N'Hilll', CAST(N'2023-08-29T23:28:28.1535820' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (64, NULL, 1, 2, N'Kelly', N'Hagenes', CAST(N'2023-08-29T23:28:28.1535821' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (65, NULL, 1, 2, N'Tina', N'Gutmann', CAST(N'2023-08-29T23:28:28.1535822' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (66, NULL, 1, 2, N'Omar', N'Mante', CAST(N'2023-08-29T23:28:28.1535828' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (67, NULL, 1, 2, N'Melissa', N'Corkery', CAST(N'2023-08-29T23:28:28.1535830' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (68, NULL, 1, 2, N'Darrell', N'Yost', CAST(N'2023-08-29T23:28:28.1535835' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (69, NULL, 1, 2, N'William', N'Mills', CAST(N'2023-08-29T23:28:28.1535837' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (70, NULL, 1, 2, N'Muriel', N'Johns', CAST(N'2023-08-29T23:28:28.1535842' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (71, NULL, 1, 2, N'Meredith', N'Rowe', CAST(N'2023-08-29T23:28:28.1535843' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (72, NULL, 1, 2, N'Garrett', N'Mann', CAST(N'2023-08-29T23:28:28.1535844' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (73, NULL, 1, 2, N'Ignacio', N'Reichert', CAST(N'2023-08-29T23:28:28.1535846' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (74, NULL, 1, 2, N'Ross', N'Shanahan', CAST(N'2023-08-29T23:28:28.1535847' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (75, NULL, 1, 2, N'Luke', N'Littel', CAST(N'2023-08-29T23:28:28.1535847' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (76, NULL, 1, 2, N'Doris', N'Kris', CAST(N'2023-08-29T23:28:28.1535848' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (77, NULL, 1, 2, N'Judith', N'White', CAST(N'2023-08-29T23:28:28.1535850' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (78, NULL, 1, 2, N'Lowell', N'Boehm', CAST(N'2023-08-29T23:28:28.1535851' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (79, NULL, 1, 2, N'Emily', N'Dibbert', CAST(N'2023-08-29T23:28:28.1535852' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
INSERT [dbo].[Patients] ([PatientId], [WardId], [UserId], [DutyTypeId], [FirstName], [LastName], [StartDate], [CreatedAt], [UpdatedAt]) VALUES (80, NULL, 1, 2, N'Maureen', N'Trantow', CAST(N'2023-08-29T23:28:28.1535854' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2), CAST(N'2023-08-29T23:31:04.6166667' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Patients] OFF
GO
SET IDENTITY_INSERT [dbo].[ReviewOutcomes] ON 

INSERT [dbo].[ReviewOutcomes] ([ReviewOutcomeId], [Text], [CreatedAt], [UpdatedAt]) VALUES (1, N'No Issues', CAST(N'2023-08-29T05:05:06.3300000' AS DateTime2), CAST(N'2023-08-29T05:05:06.3300000' AS DateTime2))
INSERT [dbo].[ReviewOutcomes] ([ReviewOutcomeId], [Text], [CreatedAt], [UpdatedAt]) VALUES (2, N'Requires Follow up', CAST(N'2023-08-29T05:05:23.6700000' AS DateTime2), CAST(N'2023-08-29T05:05:23.6700000' AS DateTime2))
INSERT [dbo].[ReviewOutcomes] ([ReviewOutcomeId], [Text], [CreatedAt], [UpdatedAt]) VALUES (3, N'No Longer In LTS', CAST(N'2023-08-29T05:05:41.4533333' AS DateTime2), CAST(N'2023-08-29T05:05:41.4533333' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ReviewOutcomes] OFF
GO
SET IDENTITY_INSERT [dbo].[UserAssessltsrevpatients] ON 

INSERT [dbo].[UserAssessltsrevpatients] ([Id], [system_ValidationData], [LTSreviewoutcome], [LTSComments], [ClientID], [AssessmentDate], [LTSReview], [LTStart], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [LTSExit], [patward], [patRC], [LTSReason], [IR1SUISecRef]) VALUES (1, NULL, NULL, N'Hello this is a comment', N'1000343', CAST(N'2023-08-16T12:36:00.000' AS DateTime), NULL, CAST(N'2023-08-16T10:00:00.000' AS DateTime), 5, 4, NULL, N'meakii', CAST(N'2023-08-16T13:23:41.227' AS DateTime), NULL, N'aintree', N'Dr Carlo Thomas  (thocar)', N'RP05', NULL)
INSERT [dbo].[UserAssessltsrevpatients] ([Id], [system_ValidationData], [LTSreviewoutcome], [LTSComments], [ClientID], [AssessmentDate], [LTSReview], [LTStart], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [LTSExit], [patward], [patRC], [LTSReason], [IR1SUISecRef]) VALUES (2, NULL, N'AO101', N'Stay on LTS.', N'1000343', CAST(N'2023-08-23T14:23:00.000' AS DateTime), CAST(N'2023-08-23T13:23:00.000' AS DateTime), CAST(N'2023-08-16T10:00:00.000' AS DateTime), 6, NULL, NULL, N'osemej', CAST(N'2023-08-23T14:24:33.070' AS DateTime), NULL, N'aintree', N'Dr Carlo Thomas  (thocar)', N'RP05', NULL)
INSERT [dbo].[UserAssessltsrevpatients] ([Id], [system_ValidationData], [LTSreviewoutcome], [LTSComments], [ClientID], [AssessmentDate], [LTSReview], [LTStart], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [LTSExit], [patward], [patRC], [LTSReason], [IR1SUISecRef]) VALUES (3, NULL, NULL, NULL, N'1000668', CAST(N'2023-08-11T11:00:00.000' AS DateTime), NULL, CAST(N'2023-08-11T11:00:00.000' AS DateTime), 2, 1, NULL, N'stanij', CAST(N'2023-08-11T11:02:04.917' AS DateTime), CAST(N'2023-08-11T11:01:00.000' AS DateTime), N'contcare', N'Dr Darran Bloye  (bloyed)', N'RP05', N'54123213213213')
INSERT [dbo].[UserAssessltsrevpatients] ([Id], [system_ValidationData], [LTSreviewoutcome], [LTSComments], [ClientID], [AssessmentDate], [LTSReview], [LTStart], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [LTSExit], [patward], [patRC], [LTSReason], [IR1SUISecRef]) VALUES (4, NULL, NULL, NULL, N'1000668', CAST(N'2023-08-11T11:02:00.000' AS DateTime), NULL, CAST(N'2023-08-11T11:02:00.000' AS DateTime), 3, NULL, NULL, N'stanij', CAST(N'2023-08-11T11:02:21.910' AS DateTime), NULL, N'contcare', N'Dr Darran Bloye  (bloyed)', N'RP06', NULL)
INSERT [dbo].[UserAssessltsrevpatients] ([Id], [system_ValidationData], [LTSreviewoutcome], [LTSComments], [ClientID], [AssessmentDate], [LTSReview], [LTStart], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [LTSExit], [patward], [patRC], [LTSReason], [IR1SUISecRef]) VALUES (7, NULL, NULL, N'Please Follow up', N'1', CAST(N'2023-09-04T03:37:49.197' AS DateTime), CAST(N'2023-09-04T03:37:49.197' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2023-09-13T00:00:00.000' AS DateTime), N'Annabelle Bernier', N'Dr. Mabel Schmeler', N'RP05', NULL)
INSERT [dbo].[UserAssessltsrevpatients] ([Id], [system_ValidationData], [LTSreviewoutcome], [LTSComments], [ClientID], [AssessmentDate], [LTSReview], [LTStart], [type12_NoteID], [type12_OriginalNoteID], [type12_DeletedDate], [type12_UpdatedBy], [type12_UpdatedDate], [LTSExit], [patward], [patRC], [LTSReason], [IR1SUISecRef]) VALUES (8, NULL, NULL, N'Connelly, Floyd is to be discharged soon ...', N'8', CAST(N'2023-09-04T04:08:04.713' AS DateTime), CAST(N'2023-09-04T04:08:04.713' AS DateTime), CAST(N'2023-08-29T00:00:00.000' AS DateTime), 8, NULL, NULL, NULL, NULL, CAST(N'2023-09-30T00:00:00.000' AS DateTime), N'Annabelle Bernier', N'Dr. Mabel Schmeler', N'RP05', NULL)
SET IDENTITY_INSERT [dbo].[UserAssessltsrevpatients] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserTypeId], [DutyTypeId], [Title], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 1, N'Dr.', N'Mabel', N'Schmeler', CAST(N'2023-08-29T05:09:41.3366667' AS DateTime2), CAST(N'2023-08-29T05:09:41.3366667' AS DateTime2))
INSERT [dbo].[Users] ([UserId], [UserTypeId], [DutyTypeId], [Title], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (2, 1, 2, N'Dr.', N'Mabel', N'Schmeler', CAST(N'2023-08-29T05:10:28.9566667' AS DateTime2), CAST(N'2023-08-29T05:10:28.9566667' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON 

INSERT [dbo].[UserTypes] ([UserTypeId], [Name], [Label], [CreatedAt], [UpdatedAt]) VALUES (1, N'Doctor', N'Dr.', CAST(N'2023-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2023-08-29T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Wards] ON 

INSERT [dbo].[Wards] ([WardId], [Name], [CreatedAt], [UpdatedAt]) VALUES (1, N'Annabelle Bernier', CAST(N'2023-08-29T05:01:39.1866667' AS DateTime2), CAST(N'2023-08-29T05:01:39.1866667' AS DateTime2))
INSERT [dbo].[Wards] ([WardId], [Name], [CreatedAt], [UpdatedAt]) VALUES (2, N'Phyllis Shields', CAST(N'2023-08-29T05:01:53.4700000' AS DateTime2), CAST(N'2023-08-29T05:01:53.4700000' AS DateTime2))
INSERT [dbo].[Wards] ([WardId], [Name], [CreatedAt], [UpdatedAt]) VALUES (3, N'Devante Lakin', CAST(N'2023-08-29T05:02:05.6900000' AS DateTime2), CAST(N'2023-08-29T05:02:05.6900000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Wards] OFF
GO

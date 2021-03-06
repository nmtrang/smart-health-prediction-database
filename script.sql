USE [master]
GO
/****** Object:  Database [SHPS]    Script Date: 6/11/2021 5:00:24 PM ******/
CREATE DATABASE [SHPS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SmartHealthPredictionSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SHPS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SmartHealthPredictionSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SHPS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SHPS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SHPS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SHPS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SHPS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SHPS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SHPS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SHPS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SHPS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SHPS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SHPS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SHPS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SHPS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SHPS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SHPS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SHPS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SHPS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SHPS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SHPS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SHPS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SHPS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SHPS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SHPS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SHPS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SHPS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SHPS] SET RECOVERY FULL 
GO
ALTER DATABASE [SHPS] SET  MULTI_USER 
GO
ALTER DATABASE [SHPS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SHPS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SHPS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SHPS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SHPS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SHPS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SHPS', N'ON'
GO
ALTER DATABASE [SHPS] SET QUERY_STORE = OFF
GO
USE [SHPS]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[username] [nchar](20) NOT NULL,
	[password] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Declaration]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Declaration](
	[patient_id] [int] NOT NULL,
	[symptom_id] [int] NOT NULL,
	[date] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diagnosis]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnosis](
	[patient_id] [int] NOT NULL,
	[disease_id] [int] NOT NULL,
	[date] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Disease]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Disease](
	[d_id] [int] IDENTITY(1,1) NOT NULL,
	[d_name] [nchar](20) NOT NULL,
	[description] [nchar](1000) NULL,
 CONSTRAINT [PK_Disease] PRIMARY KEY CLUSTERED 
(
	[d_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiseaseClassification]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiseaseClassification](
	[disease_id] [int] NOT NULL,
	[specialty_id] [int] NOT NULL,
 CONSTRAINT [PK_DiseaseClassification] PRIMARY KEY CLUSTERED 
(
	[disease_id] ASC,
	[specialty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[d_id] [int] IDENTITY(1,1) NOT NULL,
	[d_firstname] [nchar](20) NOT NULL,
	[d_middlename] [nchar](20) NULL,
	[d_lastname] [nchar](20) NOT NULL,
	[phone] [nchar](11) NOT NULL,
	[email] [nchar](50) NULL,
	[address] [nchar](100) NOT NULL,
	[dob] [date] NOT NULL,
	[specialty_id] [int] NOT NULL,
	[username] [nchar](20) NOT NULL,
	[password] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[d_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[patient_id] [int] NOT NULL,
	[doctor_id] [int] NOT NULL,
	[description] [nchar](1000) NOT NULL,
	[date] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[p_firstname] [nchar](20) NOT NULL,
	[p_middlename] [nchar](20) NULL,
	[p_lastname] [nchar](20) NOT NULL,
	[phone] [nchar](11) NOT NULL,
	[email] [nchar](50) NULL,
	[address] [nchar](100) NOT NULL,
	[dob] [date] NOT NULL,
	[username] [nchar](20) NOT NULL,
	[password] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientDoctor]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientDoctor](
	[patient_id] [int] NOT NULL,
	[doctor_id] [int] NOT NULL,
 CONSTRAINT [PK_PatientDoctor] PRIMARY KEY CLUSTERED 
(
	[patient_id] ASC,
	[doctor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specialty]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specialty](
	[s_id] [int] IDENTITY(1,1) NOT NULL,
	[s_name] [nchar](30) NOT NULL,
 CONSTRAINT [PK_Speciality] PRIMARY KEY CLUSTERED 
(
	[s_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Symptom]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Symptom](
	[s_id] [int] IDENTITY(1,1) NOT NULL,
	[s_name] [nchar](20) NOT NULL,
	[s_description] [nchar](1000) NULL,
 CONSTRAINT [PK_Symptom] PRIMARY KEY CLUSTERED 
(
	[s_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SymptomClassification]    Script Date: 6/11/2021 5:00:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SymptomClassification](
	[symptom_id] [int] NOT NULL,
	[disease_id] [int] NOT NULL,
 CONSTRAINT [PK_SymptomClassification] PRIMARY KEY CLUSTERED 
(
	[symptom_id] ASC,
	[disease_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Declaration] ADD  CONSTRAINT [DF_Declaration_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[Diagnosis] ADD  CONSTRAINT [DF_Diagnosis_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[Feedback] ADD  CONSTRAINT [DF_Feedback_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[Declaration]  WITH CHECK ADD  CONSTRAINT [FK_Declaration_Patient] FOREIGN KEY([patient_id])
REFERENCES [dbo].[Patient] ([p_id])
GO
ALTER TABLE [dbo].[Declaration] CHECK CONSTRAINT [FK_Declaration_Patient]
GO
ALTER TABLE [dbo].[Declaration]  WITH CHECK ADD  CONSTRAINT [FK_Declaration_Symptom] FOREIGN KEY([symptom_id])
REFERENCES [dbo].[Symptom] ([s_id])
GO
ALTER TABLE [dbo].[Declaration] CHECK CONSTRAINT [FK_Declaration_Symptom]
GO
ALTER TABLE [dbo].[Diagnosis]  WITH CHECK ADD  CONSTRAINT [FK_Disease_Diagnosis] FOREIGN KEY([disease_id])
REFERENCES [dbo].[Disease] ([d_id])
GO
ALTER TABLE [dbo].[Diagnosis] CHECK CONSTRAINT [FK_Disease_Diagnosis]
GO
ALTER TABLE [dbo].[Diagnosis]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Diagnosis] FOREIGN KEY([patient_id])
REFERENCES [dbo].[Patient] ([p_id])
GO
ALTER TABLE [dbo].[Diagnosis] CHECK CONSTRAINT [FK_Patient_Diagnosis]
GO
ALTER TABLE [dbo].[DiseaseClassification]  WITH CHECK ADD  CONSTRAINT [FK_DC_Disease] FOREIGN KEY([disease_id])
REFERENCES [dbo].[Disease] ([d_id])
GO
ALTER TABLE [dbo].[DiseaseClassification] CHECK CONSTRAINT [FK_DC_Disease]
GO
ALTER TABLE [dbo].[DiseaseClassification]  WITH CHECK ADD  CONSTRAINT [FK_DC_Specialty] FOREIGN KEY([specialty_id])
REFERENCES [dbo].[Specialty] ([s_id])
GO
ALTER TABLE [dbo].[DiseaseClassification] CHECK CONSTRAINT [FK_DC_Specialty]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_Specialty] FOREIGN KEY([specialty_id])
REFERENCES [dbo].[Specialty] ([s_id])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_Specialty]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Doctor] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[Doctor] ([d_id])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Doctor]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Patient] FOREIGN KEY([patient_id])
REFERENCES [dbo].[Patient] ([p_id])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Patient]
GO
ALTER TABLE [dbo].[PatientDoctor]  WITH CHECK ADD  CONSTRAINT [FK_PD_Doctor] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[Doctor] ([d_id])
GO
ALTER TABLE [dbo].[PatientDoctor] CHECK CONSTRAINT [FK_PD_Doctor]
GO
ALTER TABLE [dbo].[PatientDoctor]  WITH CHECK ADD  CONSTRAINT [FK_PD_Patient] FOREIGN KEY([patient_id])
REFERENCES [dbo].[Patient] ([p_id])
GO
ALTER TABLE [dbo].[PatientDoctor] CHECK CONSTRAINT [FK_PD_Patient]
GO
ALTER TABLE [dbo].[SymptomClassification]  WITH CHECK ADD  CONSTRAINT [FK_SC_Disease] FOREIGN KEY([disease_id])
REFERENCES [dbo].[Disease] ([d_id])
GO
ALTER TABLE [dbo].[SymptomClassification] CHECK CONSTRAINT [FK_SC_Disease]
GO
ALTER TABLE [dbo].[SymptomClassification]  WITH CHECK ADD  CONSTRAINT [FK_SC_Symptom] FOREIGN KEY([symptom_id])
REFERENCES [dbo].[Symptom] ([s_id])
GO
ALTER TABLE [dbo].[SymptomClassification] CHECK CONSTRAINT [FK_SC_Symptom]
GO
USE [master]
GO
ALTER DATABASE [SHPS] SET  READ_WRITE 
GO

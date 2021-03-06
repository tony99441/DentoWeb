USE [master]
GO
/****** Object:  Database [DentoWeb]    Script Date: 16/11/2020 19:38:03 ******/
CREATE DATABASE [DentoWeb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DentoWeb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DentoWeb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DentoWeb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DentoWeb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DentoWeb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DentoWeb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DentoWeb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DentoWeb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DentoWeb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DentoWeb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DentoWeb] SET ARITHABORT OFF 
GO
ALTER DATABASE [DentoWeb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DentoWeb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DentoWeb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DentoWeb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DentoWeb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DentoWeb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DentoWeb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DentoWeb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DentoWeb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DentoWeb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DentoWeb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DentoWeb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DentoWeb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DentoWeb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DentoWeb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DentoWeb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DentoWeb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DentoWeb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DentoWeb] SET  MULTI_USER 
GO
ALTER DATABASE [DentoWeb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DentoWeb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DentoWeb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DentoWeb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DentoWeb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DentoWeb] SET QUERY_STORE = OFF
GO
USE [DentoWeb]
GO
/****** Object:  Table [dbo].[Cita]    Script Date: 16/11/2020 19:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cita](
	[idCita] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [date] NULL,
	[idHorario] [int] NULL,
	[estado] [varchar](10) NULL,
	[idCliente] [int] NULL,
	[idDoctor] [int] NULL,
	[monto] [decimal](8, 4) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 16/11/2020 19:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](50) NULL,
	[nombres] [varchar](50) NULL,
	[apellidos] [varchar](50) NULL,
	[dni] [nvarchar](8) NULL,
	[fechaNac] [date] NULL,
	[correo] [varchar](100) NULL,
	[telefono] [varchar](20) NULL,
	[usuario] [varchar](50) NULL,
	[passwd] [varchar](200) NULL,
	[numeroHistoria] [varchar](100) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 16/11/2020 19:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[idDoctor] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](50) NULL,
	[apellidos] [varchar](50) NULL,
	[codigoCol] [varchar](50) NULL,
	[casaEstudio] [varchar](100) NULL,
	[titulo] [varchar](100) NULL,
	[dni] [nvarchar](8) NULL,
	[correo] [varchar](100) NULL,
	[telefono] [varchar](20) NULL,
	[usuario] [varchar](50) NULL,
	[passwd] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[idDoctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Historia]    Script Date: 16/11/2020 19:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historia](
	[idHistoria] [int] IDENTITY(1,1) NOT NULL,
	[idCita] [int] NULL,
	[observacion] [varchar](500) NULL,
	[motivo] [varchar](500) NULL,
	[fecha] [date] NULL,
	[descripcion] [varchar](500) NULL,
	[examenes] [varchar](500) NULL,
	[diagnostico] [varchar](500) NULL,
	[tratamiento] [varchar](500) NULL,
 CONSTRAINT [PK_Historia] PRIMARY KEY CLUSTERED 
(
	[idHistoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Horario]    Script Date: 16/11/2020 19:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Horario](
	[idHorario] [int] IDENTITY(1,1) NOT NULL,
	[horaInicio] [varchar](10) NULL,
	[horaFin] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idHorario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cita] ON 

INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1, CAST(N'2020-11-22' AS Date), 2, N'PENDIENTE', 3, 1, CAST(50.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (2, CAST(N'2020-11-14' AS Date), 2, N'CANCELADA', 2, 3, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1002, CAST(N'2020-11-15' AS Date), 3, N'CANCELADA', 2, 3, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1003, CAST(N'2020-11-20' AS Date), 3, N'CANCELADA', 2, 3, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1004, CAST(N'2020-11-20' AS Date), 3, N'CANCELADA', 2, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1005, CAST(N'2020-11-20' AS Date), 4, N'CANCELADA', 2, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1006, CAST(N'2020-11-28' AS Date), 2, N'ATENDIDO', 2, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1007, CAST(N'2020-11-21' AS Date), 4, N'CANCELADA', 2, 3, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1008, CAST(N'2020-11-21' AS Date), 4, N'ATENDIDO', 2, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1009, CAST(N'2020-11-21' AS Date), 3, N'ATENDIDO', 1004, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (1010, CAST(N'2020-11-28' AS Date), 3, N'ATENDIDO', 1004, 3, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (2009, CAST(N'2020-11-20' AS Date), 2, N'PENDIENTE', 2004, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (2010, CAST(N'2020-11-17' AS Date), 1, N'CANCELADA', 2004, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (2011, CAST(N'2020-11-27' AS Date), 1, N'PENDIENTE', 2004, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (2012, CAST(N'2020-11-28' AS Date), 1, N'PENDIENTE', 2004, 4, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (2013, CAST(N'2020-11-28' AS Date), 2, N'ATENDIDO', 2, 3, CAST(0.0000 AS Decimal(8, 4)))
INSERT [dbo].[Cita] ([idCita], [fecha], [idHorario], [estado], [idCliente], [idDoctor], [monto]) VALUES (2014, CAST(N'2020-11-30' AS Date), 3, N'ATENDIDO', 2, 3, CAST(0.0000 AS Decimal(8, 4)))
SET IDENTITY_INSERT [dbo].[Cita] OFF
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([idCliente], [codigo], [nombres], [apellidos], [dni], [fechaNac], [correo], [telefono], [usuario], [passwd], [numeroHistoria]) VALUES (1, N'C  - cesar', N'Cesar', N'Sarmiento', N'78410256', CAST(N'1992-11-08' AS Date), N'cesars@hotmail.com', N'976854214', N'cesar', N'ky0MGWs71WJ/g1qG1VjHXZBKmXsOeQslnbHr2WoMLG0=', N'1')
INSERT [dbo].[Cliente] ([idCliente], [codigo], [nombres], [apellidos], [dni], [fechaNac], [correo], [telefono], [usuario], [passwd], [numeroHistoria]) VALUES (2, N'C - pedro', N'Pedro', N'Rivera', N'55524111', CAST(N'2020-11-09' AS Date), N'pedro@hotmail.com', N'975241789', N'pedro', N'7hkAUWTMmaV5ahCVq1WMQtXFxTSinoihdhESHKlutaQ=', NULL)
INSERT [dbo].[Cliente] ([idCliente], [codigo], [nombres], [apellidos], [dni], [fechaNac], [correo], [telefono], [usuario], [passwd], [numeroHistoria]) VALUES (1002, N'C - cris', N'Cristina', N'Mantilla', N'45789632', CAST(N'1992-06-18' AS Date), N'cristina@hotmail.com', N'976584213', N'cris', N'ky0MGWs71WJ/g1qG1VjHXZBKmXsOeQslnbHr2WoMLG0=', NULL)
INSERT [dbo].[Cliente] ([idCliente], [codigo], [nombres], [apellidos], [dni], [fechaNac], [correo], [telefono], [usuario], [passwd], [numeroHistoria]) VALUES (1004, N'C - manuel', N'Manuel', N'Briones', N'78542879', CAST(N'1992-06-18' AS Date), N'manuel@hotmail.com', N'976584179', N'manuel', N'T998vrCEtwvMTkHP0xRXPj/MbJrmVr1q2OpO+ZG7LPk=', NULL)
INSERT [dbo].[Cliente] ([idCliente], [codigo], [nombres], [apellidos], [dni], [fechaNac], [correo], [telefono], [usuario], [passwd], [numeroHistoria]) VALUES (2004, N'C - angela', N'angela', N'guerrero', N'96742354', CAST(N'2008-02-13' AS Date), N'angela@hotmail.com', N'976854210', N'angela', N'lESHvXxcw8AHgV/xnvILxhv0tKtd94bg1BIdxfdpSq0=', NULL)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctor] ON 

INSERT [dbo].[Doctor] ([idDoctor], [nombres], [apellidos], [codigoCol], [casaEstudio], [titulo], [dni], [correo], [telefono], [usuario], [passwd]) VALUES (3, N'Julio', N'Barros', N'157842', N'Zeta', N'Cirujano Dentista', N'25417895', N'juliob@hotmail.com', N'976584123', N'admin', N'ky0MGWs71WJ/g1qG1VjHXZBKmXsOeQslnbHr2WoMLG0=')
INSERT [dbo].[Doctor] ([idDoctor], [nombres], [apellidos], [codigoCol], [casaEstudio], [titulo], [dni], [correo], [telefono], [usuario], [passwd]) VALUES (4, N'Moises', N'Cabrera', N'257413', N'Mosho', N'Cirujano Dentista', N'89754123', N'moiseschotmail.com', N'976854271', N'mosho', N'ky0MGWs71WJ/g1qG1VjHXZBKmXsOeQslnbHr2WoMLG0=')
SET IDENTITY_INSERT [dbo].[Doctor] OFF
GO
SET IDENTITY_INSERT [dbo].[Historia] ON 

INSERT [dbo].[Historia] ([idHistoria], [idCita], [observacion], [motivo], [fecha], [descripcion], [examenes], [diagnostico], [tratamiento]) VALUES (1, 1006, N'inflamacion', N'inflamacion', CAST(N'2020-11-14' AS Date), N'inflimacion', N'inflamacion', N'inflamacion', N'pastilla')
INSERT [dbo].[Historia] ([idHistoria], [idCita], [observacion], [motivo], [fecha], [descripcion], [examenes], [diagnostico], [tratamiento]) VALUES (2, 1010, N'dolor', N'dolor', CAST(N'2020-11-14' AS Date), N'dolor', N'tres', N'dolor', N'ampolla')
INSERT [dbo].[Historia] ([idHistoria], [idCita], [observacion], [motivo], [fecha], [descripcion], [examenes], [diagnostico], [tratamiento]) VALUES (1002, 1009, N'dolor', N'dolor', CAST(N'2020-11-15' AS Date), N'dolor', N'tres', N'dolor', N'ampolla')
INSERT [dbo].[Historia] ([idHistoria], [idCita], [observacion], [motivo], [fecha], [descripcion], [examenes], [diagnostico], [tratamiento]) VALUES (1003, 1008, N'dolor', N'inflamacion', CAST(N'2020-11-15' AS Date), N'inflimacion', N'tres', N'dolor', N'pastilla')
INSERT [dbo].[Historia] ([idHistoria], [idCita], [observacion], [motivo], [fecha], [descripcion], [examenes], [diagnostico], [tratamiento]) VALUES (1004, 2013, NULL, NULL, CAST(N'2020-11-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Historia] ([idHistoria], [idCita], [observacion], [motivo], [fecha], [descripcion], [examenes], [diagnostico], [tratamiento]) VALUES (1005, 2014, N'dolor', N'dolor', CAST(N'2020-11-16' AS Date), N'inflimacion', N'tres', N'dolor', N'ampolla')
SET IDENTITY_INSERT [dbo].[Historia] OFF
GO
SET IDENTITY_INSERT [dbo].[Horario] ON 

INSERT [dbo].[Horario] ([idHorario], [horaInicio], [horaFin]) VALUES (1, N'08:00 AM', N'10:00 AM')
INSERT [dbo].[Horario] ([idHorario], [horaInicio], [horaFin]) VALUES (2, N'10:00 AM', N'12:00 PM')
INSERT [dbo].[Horario] ([idHorario], [horaInicio], [horaFin]) VALUES (3, N'03:00 PM', N'05:00 PM')
INSERT [dbo].[Horario] ([idHorario], [horaInicio], [horaFin]) VALUES (4, N'05:00 PM', N'07:00 PM')
SET IDENTITY_INSERT [dbo].[Horario] OFF
GO
USE [master]
GO
ALTER DATABASE [DentoWeb] SET  READ_WRITE 
GO

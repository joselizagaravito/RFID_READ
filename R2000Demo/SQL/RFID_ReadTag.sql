USE [master]
GO
/****** Object:  Database [RFID]    Script Date: 31/01/2021 03:19:01 ******/
CREATE DATABASE [RFID]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RFID', FILENAME = N'C:\Mis Documentos\PedroClavijo\BaseDeDatos\RFID.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RFID_log', FILENAME = N'C:\Mis Documentos\PedroClavijo\BaseDeDatos\RFID_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [RFID] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RFID].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RFID] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RFID] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RFID] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RFID] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RFID] SET ARITHABORT OFF 
GO
ALTER DATABASE [RFID] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RFID] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RFID] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RFID] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RFID] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RFID] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RFID] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RFID] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RFID] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RFID] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RFID] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RFID] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RFID] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RFID] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RFID] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RFID] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RFID] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RFID] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RFID] SET  MULTI_USER 
GO
ALTER DATABASE [RFID] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RFID] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RFID] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RFID] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RFID] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RFID] SET QUERY_STORE = OFF
GO
USE [RFID]
GO
/****** Object:  User [user_sga]    Script Date: 31/01/2021 03:19:02 ******/
CREATE USER [user_sga] FOR LOGIN [user_sga] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [user_sga]
GO
/****** Object:  Table [dbo].[ReadTag]    Script Date: 31/01/2021 03:19:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReadTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EPC] [varchar](40) NULL,
	[TID] [varchar](250) NULL,
	[InvTimes] [int] NULL,
	[RSSI] [int] NULL,
	[AntID] [int] NULL,
	[LastTime] [datetime] NULL,
	[FirstReadTime] [datetime] NULL,
	[Color] [varchar](10) NULL,
 CONSTRAINT [PK_Lecturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddNewReadTag]    Script Date: 31/01/2021 03:19:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[AddNewReadTag]  
(  
	@EPC varchar (40),  
	@TID varchar (250),  
	@InvTimes int,
	@RSSI int,
	@AntID int,
	@LastTime datetime,
	@FirstReadTime datetime,
	@Color varchar(10)
)  
as  
Begin  
   INSERT INTO ReadTag
                         (EPC, TID, InvTimes, RSSI, AntID, LastTime, FirstReadTime, Color)
VALUES        (@EPC, @TID, @InvTimes, @RSSI, @AntID, @LastTime, @FirstReadTime, @Color)
   
End 
GO
/****** Object:  StoredProcedure [dbo].[DeleteReadTag]    Script Date: 31/01/2021 03:19:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[DeleteReadTag]  
(  
   @Id int  
)  
as   
begin  
   Delete from [dbo].[ReadTag] where Id=@Id  
End 
GO
/****** Object:  StoredProcedure [dbo].[GetReadTag]    Script Date: 31/01/2021 03:19:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetReadTag]  
as  
begin  
	SELECT        Id, EPC, TID, InvTimes, RSSI, AntID, LastTime, FirstReadTime, Color
	FROM            ReadTag
End 
GO
/****** Object:  StoredProcedure [dbo].[UpdateReadTag]    Script Date: 31/01/2021 03:19:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[UpdateReadTag]  
(  
	@Id int,
	@EPC varchar (40),  
	@TID varchar (250),  
	@InvTimes int,
	@RSSI int,
	@AntID int,
	@LastTime datetime,
	@FirstReadTime datetime,
	@Color varchar(10) 
)  
as  
begin  
   Update ReadTag   
		set EPC=@EPC,  
		TID=@TID,  
		InvTimes=@InvTimes,
		RSSI=@RSSI,
		AntID=@AntID,
		LastTime=@LastTime,
		FirstReadTime=@FirstReadTime,
		Color=@Color
   where 
		Id=@Id  
End
GO
USE [master]
GO
ALTER DATABASE [RFID] SET  READ_WRITE 
GO

/*
Proyect II: RevisTEC (SQL Server 2017)

Bases de Datos, Área Acádemica de Ingenería en Computadores

Semestre II, 2017

Members:
	Ricardo Chang Villalobos - 2014040801
	Gustavo Fallas Carrera - 2014035394
	Pablo García Brenes - 2015083681
	Randy Martínez Sandí - 2014047395

Index:
	1- Creation of tables.
    2- Declaration of SP's for filling the DB.
    3- Executing the SP's.
*/

-- Creation of the database --
CREATE DATABASE revistec;
GO

-- Change to revistec --
USE revistec;
GO

----------Start: Creating tables.----------

-- Table for Clients -- 
CREATE TABLE Client(
	IdClient INT IDENTITY PRIMARY KEY,
	XMLData XML,
);
GO

-- Table for Magazines -- 
CREATE TABLE Magazine(
	IdMagazine INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(256) NOT NULL,
	Price INT NOT NULL,
	EditionDate DATE NOT NULL,
);
GO

-- Table for Addresses of the Magazines -- 
CREATE TABLE Address(
	IdAddress INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Country VARCHAR(256) NOT NULL,
	Province VARCHAR(256) NOT NULL,
	City VARCHAR(256) NOT NULL,
	ZipCode INTEGER NOT NULL,
);
GO

-- Table for the Routes for the Magazines -- 
CREATE TABLE Route(
	IdRoute INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(256) NOT NULL,
	StartTime DATETIME NOT NULL,
);
GO

-- Table for the Roles for the Persons -- 
CREATE TABLE Role(
	IdRole INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(256) NOT NULL,	
);
GO

-- Table for the Local --
CREATE TABLE Local(
	IdLocal INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(256) NOT NULL,
	IdAddress INT NOT NULL,
	FOREIGN KEY (IdAddress) REFERENCES Address(IdAddress)
);
GO

-- Table for Contracts for each Client --
CREATE TABLE Contract(
	IdContract INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdClient INT NOT NULL,	
	Payment INT NOT NULL,
	PayRecurrence INT NOT NULL,
	AmountLocal INT,
	FOREIGN KEY (IdClient) REFERENCES Client(IdClient)
);
GO

-- Table for the Persons -- 
CREATE TABLE Person(
	IdPerson INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(256) NOT NULL,	
	LastName VARCHAR(256) NOT NULL,	
	Gender VARCHAR (256) NOT NULL,
	BirthDate DATE NOT NULL,
);
GO

-- Table for Employee of RevisTEC --
CREATE TABLE Employee(
	IdEmployee INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SSN INT NOT NULL,	
	IdRole INT NOT NULL,
	IdPerson INT NOT NULL,
	PhoneNumber INT NOT NULL,
	FOREIGN KEY (IdRole) REFERENCES Role(IdRole),
	FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
GO

-- Table for the Users --
CREATE TABLE Users(
	IdUser INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdPerson INT NOT NULL,
	Email VARCHAR(256) NOT NULL,
	Password VARCHAR(256) NOT NULL,
	BankAccount INT NOT NULL,
	FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
GO

-- Table for the Register--
CREATE TABLE Register(
	IdRegistry INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdEmployee INT NOT NULL,
	IdLocal INT NOT NULL,
	ArriveDate DATETIME,
    FOREIGN KEY (IdEmployee) REFERENCES Employee(IdEmployee),
    FOREIGN KEY (IdLocal) REFERENCES Local (IdLocal)
);
GO

-- Table of Client and Magazine --  
CREATE TABLE Client_Magazine_Local(
	IdClient INT NOT NULL,
	IdMagazine INT NOT NULL,
	IdLocal INT NOT NULL,
	DeliveryRecurrence INT NOT NULL,
    FOREIGN KEY (IdMagazine) REFERENCES Magazine(IdMagazine),
    FOREIGN KEY (IdClient) REFERENCES Client(IdClient),
	FOREIGN KEY (IdLocal) REFERENCES Local(IdLocal)
);
GO

-- Table of Route and Address -- 
CREATE TABLE Route_Address(
	IdRoute INT NOT NULL,
	IdAddress INT NOT NULL,
    FOREIGN KEY (IdRoute) REFERENCES Route(IdRoute),
    FOREIGN KEY (IdAddress) REFERENCES Address(IdAddress)
);
GO

-- Table of Subscription of User for digital Magazine --
CREATE TABLE Subscriptions(
	IdUser INT NOT NULL, 
	IdMagazine INT NOT NULL, 
	FOREIGN KEY (IdUser) REFERENCES Users(IdUser),
	FOREIGN KEY (IdMagazine) REFERENCES Magazine(IdMagazine)
);
GO
---------- End: Creating Tables.----------

---------- Start: SPs for bulkcopy the tables.----------
CREATE PROCEDURE sp_allTableFill
AS
BEGIN
-- Filling Person table -- 
    BULK INSERT Person
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Person.txt'
    WITH
    ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )

-- Filling Employee table -- 
    BULK INSERT Employee
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Employee.txt'
    WITH
    (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )

-- Filling Address table -- 
    BULK INSERT Address
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Address.txt'
    WITH
    (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )

-- Filling Magazine table --    
    BULK INSERT Magazine
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Magazine.txt'
    WITH
    (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )

-- Filling Users table --
    BULK INSERT Users
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Users.txt'
    WITH
    (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )
   
-- Filling Local table --
    BULK INSERT Local
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Local.txt'
    WITH
    (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )

-- Filling Roles table --
    BULK INSERT Role
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Role.txt'
    WITH
    (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )

-- Filling Route table --
    BULK INSERT Route
    FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Route.txt'
    WITH
    (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
    )

	BULK INSERT Register
	FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Register.txt'
	WITH
	(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a'
	)

	BULK INSERT Client_Magazine_Local
	FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\CML.txt'
	WITH
	(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a'
	)
	BULK INSERT Contract
	FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Contract.txt'
	WITH
	(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a'
	)
	BULK INSERT Route_Address
	FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\RouteAddress.txt'
	WITH
	(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a'
	)
	BULK INSERT Subscipstions
	FROM 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Subscipstions.txt'
	WITH
	(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a'
	)
END
GO

-- Filling Client table --
CREATE PROCEDURE sp_xmlFill
AS
BEGIN 
    INSERT INTO Client(XMLData)
    SELECT CONVERT(XML, BulkColumn) AS BulkColumn 
    FROM OPENROWSET(BULK 'T:\2017\II S 2017\CE -  3101\Proyecto Final\txt data\Clients.xml', SINGLE_BLOB) AS x;

    SELECT * FROM Client;
END 
GO

-- Read Client Table --
CREATE PROCEDURE sp_getAllClients
AS 
BEGIN
	DECLARE @XML AS XML;
    DECLARE @hDoc AS INT;
    DECLARE @SQL NVARCHAR (MAX);

    SELECT @XML = XMLData FROM Client
    EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML

    SELECT IdClient, Name, Address
    FROM OPENXML(@hDoc, 'ROOT/Clients/Client')
    WITH 
    (
    IdClient [varchar](50) '@IdClient',
    Name [varchar](100) '@Name',
    Address [varchar](100) 'Address'
    )
    EXEC sp_xml_removedocument @hDoc
END
GO
---------- End: SPs for bulkcopy the tables.-------------

---------- Start: Executing the SPs for bulkcopy the tables.-------------

EXEC sp_allTableFill; 
EXEC sp_xmlFill;

---------- End: Executing the SPs for bulkcopy the tables.-------------

CREATE DATABASE REVISTEC;
USE REVISTEC;

DROP TABLE CLIENT IF EXISTS;
CREATE TABLE CLIENT(
	IdClient INTEGER AUTOINCREMENT,
	CliName VARCHAR(256),
	 PRIMARY KEY (IdClient)
);

CREATE TABLE MAGAZINE(
	IdMagazine INTEGER AUTOINCREMENT,
	MagName VARCHAR(256),
	MagPice INTEGER,
	MagEditionDate DATE,
	PRIMARY KEY (IdMagazine)
);

CREATE TABLE ADDRESS(
	IdAddress INTEGER AUTOINCREMENT,
	Country VARCHAR(256),
	Province VARCHAR(256),
	City VARCHAR(256),
	District VARCHAR(256),
	Street VARCHAR(256),
	ZipCode INTEGER,
	PRIMARY KEY (IdAddress)
);
CREATE TABLE ROUTE(
	IdRoute INTEGER AUTOINCREMENT,
	Name VARCHAR(256),
	StartTime DATETIME,
	PRIMARY KEY (IdRoute)
);

CREATE TABLE PERSON(
	IdPerson INTEGER AUTOINCREMENT,
	FirstName VARCHAR(256),	
	LastName VARCHAR(256),	
	Gender BOOLEAN,
	BirthDate DATE,
	PRIMARY KEY (IdPerson)
);
CREATE TABLE ROLE(
	IdRole INTEGER AUTOINCREMENT,
	Name VARCHAR(256),	
	PRIMARY KEY (IdRole)
);

CREATE TABLE LOCAL(
	IdLocal INTEGER AUTOINCREMENT,
	Name VARCHAR(256),
	IdAddress INTEGER,
	PRIMARY KEY (IdLocal)
	FOREIGN KEY (IdAddress) REFERENCES ADDRESS(IdAddress)
);

CREATE TABLE CONTRACT(
	IdContract INTEGER AUTOINCREMENT,
	IdClient INTEGER,	
	PRIMARY KEY (IdContract),
	FOREIGN KEY (IdClient) REFERENCES CONTRACT(IdClient)
);

CREATE TABLE EMPLOYEE(
	IdEmployee INTEGER AUTOINCREMENT,
	SSN INTEGER,	
	IdRole INTEGER,
	IdPerson INTEGER,
	PhoneNumber INTEGER,
	PRIMARY KEY (IdEmployee),
	FOREIGN KEY (IdRole) REFERENCES ROLE(IdRole),
	FOREIGN KEY (IdPerson) REFERENCES PERSON(IdPerson)
);
CREATE TABLE USER(
	IdUser INTEGER AUTOINCREMENT,
	Email VARCHAR(256),
	Password VARCHAR(256),
	BankAccount INTEGER,
	PRIMARY KEY (IdUser),
	FOREIGN KEY (IdPerson) REFERENCES PERSON(IdPerson)
);

CREATE TABLE REGISTRY(
	IdRegistry INTEGER AUTOINCREMENT,
	Name VARCHAR(256),
	IdEmployee INTEGER,
	IdLocal INTEGER,
	ArriveDate DATETIME,
	PRIMARY KEY (IdRegistry)
    FOREIGN KEY (IdEmployee) REFERENCES EMPLOYEE(IdEmployee),
    FOREIGN KEY (IdLocal) REFERENCES LOCAL(IdLocal)
);


CREATE TABLE CLIENTLOCAL(
	IdLocal INTEGER,
	IdClient INTEGER,
	IdMagazine INTEGER,
	Quantity INTEGER,
	DeliverDate DATETIME,
    FOREIGN KEY (IdMagazine) REFERENCES MAGAZINE(IdMagazine),
    FOREIGN KEY (IdClient) REFERENCES CLIENT(IdClient),
    FOREIGN KEY (IdLocal) REFERENCES LOCAL(IdLocal)
);

/*Revisar esta tabla y comparar con clientlocal*/
CREATE TABLE CLIENTMAGAZINE(
	IdClient INTEGER,
	IdMagazine INTEGER,
    FOREIGN KEY (IdMagazine) REFERENCES MAGAZINE(IdMagazine),
    FOREIGN KEY (IdClient) REFERENCES CLIENT(IdClient)
);

CREATE TABLE ROUTEADDRESS(
	IdRoute INTEGER,
	IdAddress INTEGER,
    FOREIGN KEY (IdRoute) REFERENCES ROUTE(IdRoute),
    FOREIGN KEY (IdAddress) REFERENCES ADDRESS(IdAddress)
);

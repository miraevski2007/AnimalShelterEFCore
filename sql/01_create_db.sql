-- ============================================================
-- Лабораторная работа: Приют для животных (вариант 12)
-- Скрипт 1: Создание базы данных и таблиц
-- ============================================================

USE master;
GO

IF DB_ID('AnimalShelter') IS NOT NULL
BEGIN
    ALTER DATABASE AnimalShelter SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AnimalShelter;
END
GO

CREATE DATABASE AnimalShelter;
GO

USE AnimalShelter;
GO

-- ============================================================
-- Справочники (сторона «один»)
-- ============================================================

CREATE TABLE Species (
    id   INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Breeds (
    id         INT IDENTITY(1,1) PRIMARY KEY,
    species_id INT NOT NULL,
    name       NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_Breeds_Species FOREIGN KEY (species_id) REFERENCES Species(id),
    CONSTRAINT UQ_Breeds UNIQUE (species_id, name)
);
GO

CREATE TABLE Statuses (
    id   INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE VolierTypes (
    id       INT IDENTITY(1,1) PRIMARY KEY,
    name     NVARCHAR(50) NOT NULL UNIQUE,
    capacity INT NOT NULL CHECK (capacity > 0)
);
GO

CREATE TABLE Voliers (
    id              INT IDENTITY(1,1) PRIMARY KEY,
    volier_type_id  INT NOT NULL,
    number          NVARCHAR(20) NOT NULL UNIQUE,
    capacity        INT NOT NULL CHECK (capacity > 0),
    CONSTRAINT FK_Voliers_Type FOREIGN KEY (volier_type_id) REFERENCES VolierTypes(id)
);
GO

CREATE TABLE Owners (
    id                INT IDENTITY(1,1) PRIMARY KEY,
    full_name         NVARCHAR(200) NOT NULL,
    address           NVARCHAR(300),
    phone             NVARCHAR(30),
    housing_conditions NVARCHAR(500),
    has_other_animals BIT NOT NULL DEFAULT 0
);
GO

-- ============================================================
-- Оперативные таблицы (сторона «многие»)
-- ============================================================

CREATE TABLE Animals (
    id             INT IDENTITY(1,1) PRIMARY KEY,
    name           NVARCHAR(100) NOT NULL,
    species_id     INT NOT NULL,
    breed_id       INT,
    gender         NCHAR(1) NOT NULL CHECK (gender IN (N'М', N'Ж')),
    age            INT CHECK (age >= 0),
    color          NVARCHAR(50),
    special_marks  NVARCHAR(500),
    arrival_date   DATE NOT NULL,
    arrival_source NVARCHAR(200),
    status_id      INT NOT NULL,
    volier_id      INT,
    CONSTRAINT FK_Animals_Species  FOREIGN KEY (species_id) REFERENCES Species(id),
    CONSTRAINT FK_Animals_Breeds   FOREIGN KEY (breed_id)   REFERENCES Breeds(id),
    CONSTRAINT FK_Animals_Statuses FOREIGN KEY (status_id)  REFERENCES Statuses(id),
    CONSTRAINT FK_Animals_Voliers  FOREIGN KEY (volier_id)  REFERENCES Voliers(id)
);
GO

CREATE TABLE VetProcedures (
    id              INT IDENTITY(1,1) PRIMARY KEY,
    animal_id       INT NOT NULL,
    procedure_date  DATE NOT NULL,
    procedure_type  NVARCHAR(50) NOT NULL,
    description     NVARCHAR(500),
    doctor          NVARCHAR(200),
    cost            DECIMAL(10,2) CHECK (cost >= 0),
    CONSTRAINT FK_Vet_Animals FOREIGN KEY (animal_id) REFERENCES Animals(id)
);
GO

CREATE TABLE Applications (
    id                INT IDENTITY(1,1) PRIMARY KEY,
    owner_id          INT NOT NULL,
    animal_id         INT NOT NULL,
    application_date  DATE NOT NULL,
    status            NVARCHAR(50) NOT NULL,
    interview_result  NVARCHAR(500),
    CONSTRAINT FK_Applications_Owners  FOREIGN KEY (owner_id)  REFERENCES Owners(id),
    CONSTRAINT FK_Applications_Animals FOREIGN KEY (animal_id) REFERENCES Animals(id)
);
GO

CREATE TABLE AdoptionContracts (
    id                   INT IDENTITY(1,1) PRIMARY KEY,
    application_id       INT NOT NULL UNIQUE,
    contract_date        DATE NOT NULL,
    control_visit_date   DATE,
    visit_result         NVARCHAR(500),
    CONSTRAINT FK_Contracts_Applications FOREIGN KEY (application_id) REFERENCES Applications(id)
);
GO

PRINT 'База данных AnimalShelter создана успешно.';
GO
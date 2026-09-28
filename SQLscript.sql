Section C: SQL Database Script
The script below matches the ERD in Section A exactly and was written for SQL Server (SSMS). It creates the RaceDayDB database, all six tables with primary/foreign keys and constraints, and inserts sample data.
-- =========================================================
-- RaceDay Database Script
-- Part 1, Section C
-- Matches the ERD in /docs (User, Event, Category, Venue,
-- Enrolment, Result)
-- =========================================================
 
IF DB_ID('RaceDayDB') IS NULL
    CREATE DATABASE RaceDayDB;
GO
 
USE RaceDayDB;
GO
 
-- =========================================================
-- Tables
-- =========================================================
 
CREATE TABLE [User] (
    UserId        INT IDENTITY(1,1) PRIMARY KEY,
    FirstName     NVARCHAR(50)  NOT NULL,
    LastName      NVARCHAR(50)  NOT NULL,
    Email         NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash  NVARCHAR(255) NOT NULL,
    Role          NVARCHAR(20)  NOT NULL CHECK (Role IN ('Organiser', 'Participant')),
    CreatedAt     DATETIME2     NOT NULL DEFAULT SYSDATETIME()
);
 
CREATE TABLE Event (
    EventId       INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId   INT NOT NULL,
    Name          NVARCHAR(100) NOT NULL,
    Description   NVARCHAR(MAX) NULL,
    EventDate     DATE NOT NULL,
    Location      NVARCHAR(150) NOT NULL,
    Distance      NVARCHAR(50)  NULL,
    CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrganiserId)
        REFERENCES [User](UserId)
);
 
CREATE TABLE Venue (
    VenueId       INT IDENTITY(1,1) PRIMARY KEY,
    EventId       INT NOT NULL UNIQUE,
    Address       NVARCHAR(150) NOT NULL,
    City          NVARCHAR(100) NOT NULL,
    Province      NVARCHAR(100) NULL,
    CONSTRAINT FK_Venue_Event FOREIGN KEY (EventId)
        REFERENCES Event(EventId)
);
 
CREATE TABLE Category (
    CategoryId      INT IDENTITY(1,1) PRIMARY KEY,
    EventId         INT NOT NULL,
    Name            NVARCHAR(50) NOT NULL,
    MaxParticipants INT NOT NULL,
    EntryFee        DECIMAL(8,2) NOT NULL DEFAULT 0,
    CONSTRAINT FK_Category_Event FOREIGN KEY (EventId)
        REFERENCES Event(EventId)
);
 
CREATE TABLE Enrolment (
    EnrolmentId     INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId   INT NOT NULL,
    CategoryId      INT NOT NULL,
    EnrolmentDate   DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    Status          NVARCHAR(20) NOT NULL DEFAULT 'Confirmed'
                        CHECK (Status IN ('Confirmed', 'Cancelled')),
    CONSTRAINT FK_Enrolment_User FOREIGN KEY (ParticipantId)
        REFERENCES [User](UserId),
    CONSTRAINT FK_Enrolment_Category FOREIGN KEY (CategoryId)
        REFERENCES Category(CategoryId),
    CONSTRAINT UQ_Enrolment UNIQUE (ParticipantId, CategoryId)
);
 
CREATE TABLE Result (
    ResultId       INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId    INT NOT NULL UNIQUE,
    FinishTime     TIME NULL,
    Position       INT NULL,
    CapturedBy     INT NOT NULL,
    CONSTRAINT FK_Result_Enrolment FOREIGN KEY (EnrolmentId)
        REFERENCES Enrolment(EnrolmentId),
    CONSTRAINT FK_Result_CapturedBy FOREIGN KEY (CapturedBy)
        REFERENCES [User](UserId)
);
GO
 
-- =========================================================
-- Sample data
-- =========================================================
 
INSERT INTO [User] (FirstName, LastName, Email, PasswordHash, Role) VALUES
('Thabo', 'Nkosi', 'thabo.nkosi@example.com', 'hashed_pw_1', 'Organiser'),
('Lerato', 'Dube', 'lerato.dube@example.com', 'hashed_pw_2', 'Participant'),
('Sipho', 'Mahlangu', 'sipho.m@example.com', 'hashed_pw_3', 'Participant');
 
INSERT INTO Event (OrganiserId, Name, Description, EventDate, Location, Distance) VALUES
(1, 'Joburg City Run', 'Annual road running event through the CBD', '2026-11-15', 'Johannesburg', '10km/21km');
 
INSERT INTO Venue (EventId, Address, City, Province) VALUES
(1, 'Mary Fitzgerald Square', 'Johannesburg', 'Gauteng');
 
INSERT INTO Category (EventId, Name, MaxParticipants, EntryFee) VALUES
(1, '10km', 500, 150.00),
(1, '21km', 300, 250.00);
 
INSERT INTO Enrolment (ParticipantId, CategoryId, Status) VALUES
(2, 1, 'Confirmed'),
(3, 2, 'Confirmed');
 
INSERT INTO Result (EnrolmentId, FinishTime, Position, CapturedBy) VALUES
(1, '00:52:14', 12, 1);
GO
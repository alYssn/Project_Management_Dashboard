-- ========================================
-- Star Schema
-- ========================================

-- Use transaction block
BEGIN;

-- ============================
-- 0. DROP TABLES IF EXIST (in dependency order)
-- ============================
DROP TABLE IF EXISTS FactProjects CASCADE;
DROP TABLE IF EXISTS DimManager CASCADE;
DROP TABLE IF EXISTS DimLocation CASCADE;
DROP TABLE IF EXISTS DimType CASCADE;
DROP TABLE IF EXISTS DimStatus CASCADE;
DROP TABLE IF EXISTS DimHealthStatus CASCADE;

-- ============================
-- 1. CREATE DIMENSION TABLES
-- ============================
CREATE TABLE DimManager (
    ManagerID TEXT PRIMARY KEY,
    ManagerName TEXT NOT NULL
);

CREATE TABLE DimLocation (
    LocationID TEXT PRIMARY KEY,
    LocationName TEXT NOT NULL
);

CREATE TABLE DimType (
    TypeID TEXT PRIMARY KEY,
    TypeName TEXT NOT NULL
);

CREATE TABLE DimStatus (
    StatusID TEXT PRIMARY KEY,
    StatusName TEXT NOT NULL
);

CREATE TABLE DimHealthStatus (
    HealthStatusID TEXT PRIMARY KEY,
    HealthStatusName TEXT NOT NULL
);

-- ============================
-- 2. CREATE FACT TABLE
-- ============================
CREATE TABLE FactProjects (
    ProjectID TEXT PRIMARY KEY,
    "Project Name" TEXT NOT NULL,
    Created DATE NOT NULL,
    Budget NUMERIC NOT NULL,
    Expense NUMERIC NOT NULL,
    ManagerID TEXT NOT NULL REFERENCES DimManager(ManagerID),
    LocationID TEXT NOT NULL REFERENCES DimLocation(LocationID),
    TypeID TEXT NOT NULL REFERENCES DimType(TypeID),
    StatusID TEXT NOT NULL REFERENCES DimStatus(StatusID),
    HealthStatusID TEXT NOT NULL REFERENCES DimHealthStatus(HealthStatusID),
    OnSchedule BOOLEAN NOT NULL
);

-- ============================
-- 3. INSERT INTO DIMENSION TABLES
-- ============================

INSERT INTO DimManager (ManagerID, ManagerName) VALUES
('M1', 'Ross Geller'),
('M2', 'Phoebe Buffay'),
('M3', 'Monica Geller'),
('M4', 'Chandler Bing'),
('M5', 'Joey Tribbiani');

INSERT INTO DimLocation (LocationID, LocationName) VALUES
('L1', 'Adelaide'),
('L2', 'Sydney'),
('L3', 'Perth'),
('L4', 'Brisbane'),
('L5', 'Melbourne');

INSERT INTO DimType (TypeID, TypeName) VALUES
('T1', 'Safety Check'),
('T2', 'Design Review'),
('T3', 'Site Management'),
('T4', 'Subcontractor Inspections');

INSERT INTO DimStatus (StatusID, StatusName) VALUES
('S1', 'Open'),
('S2', 'In Progress'),
('S3', 'On Hold'),
('S4', 'Completed');

INSERT INTO DimHealthStatus (HealthStatusID, HealthStatusName) VALUES
('H1', 'Overdue'),
('H2', 'On Track'),
('H3', 'Completed');

-- ============================
-- 4. INSERT INTO FACT TABLE
-- ============================

INSERT INTO FactProjects (ProjectID, "Project Name", Created, Budget, Expense, ManagerID, LocationID, TypeID, StatusID, HealthStatusID, OnSchedule) VALUES
('P1000', 'Auditorium Setup 1', TO_DATE('31/01/2023', 'DD/MM/YYYY'), 307750, 250397.62, 'M1', 'L1', 'T1', 'S1', 'H1', TRUE),
('P1001', 'Lab Implementation 1', TO_DATE('30/12/2023', 'DD/MM/YYYY'), 403531, 305281.13, 'M1', 'L2', 'T2', 'S2', 'H1', FALSE),
('P1002', 'Park Place 1', TO_DATE('10/05/2022', 'DD/MM/YYYY'), 313160, 161356.15, 'M2', 'L3', 'T2', 'S3', 'H1', FALSE),
('P1003', 'Science Park Phase 2', TO_DATE('18/07/2023', 'DD/MM/YYYY'), 105591, 59630.92, 'M3', 'L2', 'T3', 'S3', 'H1', FALSE),
('P1004', 'Research Offices', TO_DATE('04/02/2023', 'DD/MM/YYYY'), 270884, 140550.20, 'M3', 'L3', 'T1', 'S4', 'H3', TRUE);

-- ============================
-- 5. COMMIT TRANSACTION
-- ============================
COMMIT;

-- ============================
-- End
-- ============================


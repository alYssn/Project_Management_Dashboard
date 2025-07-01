-- Postgres SQL
-- 1. Create dimension tables
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

-- 2. Create fact table
CREATE TABLE FactProjects (
    ProjectID TEXT PRIMARY KEY,
    "Project Name" TEXT,
    Created DATE,
    Budget NUMERIC,
    Expense NUMERIC,
    ManagerID TEXT REFERENCES DimManager(ManagerID),
    LocationID TEXT REFERENCES DimLocation(LocationID),
    TypeID TEXT REFERENCES DimType(TypeID),
    StatusID TEXT REFERENCES DimStatus(StatusID),
    HealthStatusID TEXT REFERENCES DimHealthStatus(HealthStatusID),
    OnSchedule TEXT
);

-- 3. Insert data into dimension tables
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

-- 4. Insert data into fact table
INSERT INTO FactProjects (ProjectID, "Project Name", Created, Budget, Expense, ManagerID, LocationID, TypeID, StatusID, HealthStatusID, OnSchedule) VALUES
('P1000', 'Auditorium Setup 1', TO_DATE('31/01/2023', 'DD/MM/YYYY'), 307750, 250397.62, 'M1', 'L1', 'T1', 'S1', 'H1', 'Yes'),
('P1001', 'Lab Implementation 1', TO_DATE('30/12/2023', 'DD/MM/YYYY'), 403531, 305281.13, 'M1', 'L2', 'T2', 'S2', 'H1', 'No'),
('P1002', 'Park Place 1', TO_DATE('10/05/2022', 'DD/MM/YYYY'), 313160, 161356.15, 'M2', 'L3', 'T2', 'S3', 'H1', 'No'),
('P1003', 'Science Park Phase 2', TO_DATE('18/07/2023', 'DD/MM/YYYY'), 105591, 59630.92, 'M3', 'L2', 'T3', 'S3', 'H1', 'No'),
('P1004', 'Research Offices', TO_DATE('04/02/2023', 'DD/MM/YYYY'), 270884, 140550.20, 'M3', 'L3', 'T1', 'S4', 'H3', 'Yes');

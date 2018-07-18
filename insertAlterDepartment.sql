use StationeryStore

Alter table Departments
ADD DepartmentHeadID	nvarchar(20),
FOREIGN KEY (DepartmentHeadID) REFERENCES Employees(EmployeeID);

go


UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E010' 
WHERE 
  DepartmentID = 'ARCH';

/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E008' 
WHERE 
  DepartmentID = 'CHEM';
/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E004' 
WHERE 
  DepartmentID = 'COMM';


/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E003' 
WHERE 
  DepartmentID = 'CPSC';
/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E009' 
WHERE 
  DepartmentID = 'ELEC';
/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E002' 
WHERE 
  DepartmentID = 'ENGL';
/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E007' 
WHERE 
  DepartmentID = 'PHYS';
/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E005' 
WHERE 
  DepartmentID = 'REGR';
/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E011' 
WHERE 
  DepartmentID = 'STOR';
/* UPDATE QUERY */
UPDATE 
  Departments 
SET 
  DepartmentHeadID = 'E006' 
WHERE 
  DepartmentID = 'ZOOL';

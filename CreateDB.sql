USE master; 
IF EXISTS(SELECT name FROM sys.databases WHERE name = 'StationaryStore') 
	BEGIN     
		ALTER DATABASE StationaryStore SET SINGLE_USER WITH ROLLBACK IMMEDIATE;     
		DROP DATABASE StationaryStore; 
	END 
GO 

CREATE DATABASE StationaryStore; 
GO

use StationaryStore;

create table Categories (
	CategoryID	int		not null	identity(1,1),
	CategoryName	nvarchar(50)	not null,
	primary key (CategoryID)
);
go

create table Items (
	ItemID			int		not null	identity(1,1),
	ItemName		nvarchar(64)	not null,
	CategoryID		int		not null,
	UnitOfMeasure		nvarchar(20)	not null,
	primary key (ItemID),
	foreign key (CategoryID) references Categories(CategoryID)
);
go

create table Suppliers (
	SupplierID		int		not null	identity(1,1),
	SupplierName		nvarchar(64)	not null,
	ContactName		nvarchar(64)	not null,
	PhoneNumber		nvarchar(15)	not null,
	FaxNumber		nvarchar(15),
	Address			nvarchar(64),	
	primary key (SupplierID)
);
go

create table SupplierItems(
	SupplierItemID		int		not null	identity(1,1),
	SupplierID		int		not null,
	ItemID			int		not null,
	Rank			int,
	Cost 			numeric(8,2),
	primary key(SupplierItemID),
	foreign key (ItemID) references Items(ItemID),	
	foreign key (SupplierID) references Suppliers(SupplierID)
);
go

create table Orders (
	OrderID		int		not null	identity(1,1),
	OrderDate	datetime	not null,
	primary key (OrderID)
);
go

create table OrderSuppliers (
	OrderSupplierID		int		not null	identity(1,1),
	OrderID			int		not null,
	SupplierID		int		not null,
	OrderStatus		nvarchar(20)	not null,
	InvoiceUploadStatus	nvarchar(20),
	primary key (OrderSupplierID),
	foreign key(OrderID) references Orders(OrderID),
	foreign key(SupplierID) references Suppliers(SupplierID)
);
go

create table OrderSupplierDetails (
	OrderSupplierDetailsID		int		not null	identity(1,1),
	OrderSupplierID			int		not null,
	ItemID				int		not null,
	Quantity 			int		not null,
	UnitCost			numeric(8,2)	not null,
	ActualQuanityReceived		int,
	primary key (OrderSupplierDetailsID),
	foreign key(OrderSupplierID) references OrderSuppliers(OrderSupplierID),
	foreign key(ItemID) references Items(ItemID)
);
go

create table CollectionPoint (
	CollectionPointID	int		not null,	
	CollectionPointName	nvarchar(64)	not null,
	CollectionPointTime Time(0) not null,
	primary key (CollectionPointID)
);
go

create table Departments (
	DepartmentID	nvarchar(4)		not null,
	DepartmentName	nvarchar(20)	not null,
	DepartmentHeadID	nvarchar(20)		not null,
	CollectionPointID	int	not null,
	primary key (DepartmentID),
	foreign key (CollectionPointID) references CollectionPoint(CollectionPointID)
);
go

create table Employees (
	EmployeeID	nvarchar(20)		not null,
	DepartmentID	nvarchar(4)		not null,
	EmployeeName	nvarchar(20)	not null,
	PhoneNumber	nvarchar(20)		not null,
	EmailID	nvarchar(40)		not null,
	Sex	nvarchar(6)		not null,	
	primary key (EmployeeID	),
	foreign key (DepartmentID) references Departments(DepartmentID)
);
go


Alter table Departments 
ADD FOREIGN KEY (DepartmentHeadID) REFERENCES Employees(EmployeeID);


create table Authority (
	AuthorityID	int		not null  identity(1,1),
	EmployeeID	nvarchar(20)		not null,
	StartDate	Datetime	not null,
	EndDate	DateTime		not null,	
	primary key (AuthorityID),
	foreign key (EmployeeID) references Employees(EmployeeID)
);
go

create table DepartmentRepresentative (
	DeptRepID	int		not null  identity(1,1),
	EmployeeID	nvarchar(20)		not null,
	StartDate	Datetime	not null,
	EndDate	DateTime		not null,	
	primary key (DeptRepID),
	foreign key (EmployeeID) references Employees(EmployeeID)
);
go


create table RetreivalStatus (
	RetreivalStatusID	int		not null,
	RetrevialStatusName	nvarchar(20)		not null,		
	primary key (RetreivalStatusID)	
);
go

create table ApprovalStatus (
	ApprovalStatusID	int		not null,
	ApprovalStatusName	nvarchar(20)		not null,		
	primary key (ApprovalStatusID)	
);
go


create table Requisition (
	RequisitionID	int		not null  identity(1,1),
	EmployeeID	nvarchar(20)		not null,
	RequestedDate	Datetime	not null,
	AuthorityID	int		not null,
	ApproveDate Datetime not null,
	RetreivalStatusID int		not null,
	ApprovalStatusID	int		not null,		
	primary key (RequisitionID),
	foreign key (EmployeeID) references Employees(EmployeeID),
	foreign key (AuthorityID) references Authority(AuthorityID),
	foreign key (RetreivalStatusID) references RetreivalStatus(RetreivalStatusID),
	foreign key (ApprovalStatusID) references ApprovalStatus(ApprovalStatusID)

);
go

create table RequisitionDetails (
	RequisitionDetailsID		int		not null	identity(1,1),
	RequisitionID			int		not null,
	ItemID				int		not null,
	Quantity 			int		not null,	
	primary key (RequisitionDetailsID),
	foreign key(RequisitionID) references Requisition(RequisitionID),
	foreign key(ItemID) references Items(ItemID)
);
go


create table Disbursement (
	DisbursementID		int		not null	identity(1,1),
	EmployeeID			nvarchar(20)	not null,
	DisbursementDate	Datetime		not null,
	Passcode 			nvarchar(4)	not null,	
	RequisitionID			int		not null,
	CollectedBy int not null, 
	primary key (DisbursementID),
    foreign key(EmployeeID) references Employees(EmployeeID),
	foreign key(RequisitionID) references Requisition(RequisitionID),
	foreign key(CollectedBy) references DepartmentRepresentative(DeptRepID)
);
go


create table DisbursementDetails (
	DisbursementDetailsID		int		not null	identity(1,1),
	ItemID			int	not null,
	DisbursementID	int		not null,
	Quantity  int		not null,
	CollectedQty int not null,	
	Reason nvarchar(40)	not null,
	 RequisitionDetailsID int not null,
	primary key (DisbursementDetailsID),
    foreign key(ItemID) references Items(ItemID),
	foreign key(DisbursementID) references Disbursement(DisbursementID),
	foreign key(RequisitionDetailsID) references RequisitionDetails(RequisitionDetailsID)
);
go


create table StockTransaction (
	TransactionID		int		not null	identity(1,1),
	ItemID			int		not null,
	Description		nvarchar(50),
	Adjustment 		int,
	EmployeeID		nvarchar(20),	
	primary key (TransactionID),
	foreign key(ItemID) references Items(ItemID),
	foreign key(EmployeeID) references Employees(EmployeeID)
);
go

create table StockVouchers (
	DiscrepancyID		int		not null	identity(1,1),
	ItemID			int		not null,
	OriginalCount		int		not null,
	ActualCount 		int		not null,
	ItemCost		numeric(8,2)    not null,
	Reason			nvarchar(50),
	RaisedBy		nvarchar(20),
	ApprovedBy		nvarchar(20),
	RaisedByDate		datetime,
	ApprovedDate		datetime,
	primary key (DiscrepancyID),
	foreign key(ItemID) references Items(ItemID),
	foreign key(RaisedBy) references Employees(EmployeeID),
	foreign key(ApprovedBy) references Employees(EmployeeID),
);
go


create view StockCountView AS
select i.ItemID,i.ItemName,sum(t.Adjustment) AS  TotalAdjustment from
Items i,StockTransaction t
where i.ItemID=t.ItemID
group by i.ItemID,i.ItemName














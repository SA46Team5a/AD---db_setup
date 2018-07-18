USE master; 
IF EXISTS(SELECT name FROM sys.databases WHERE name = 'StationeryStore') 
	BEGIN     
		ALTER DATABASE StationeryStore SET SINGLE_USER WITH ROLLBACK IMMEDIATE;     
		DROP DATABASE StationeryStore; 
	END 
GO 

CREATE DATABASE StationeryStore; 
GO

use StationeryStore;

create table Categories (
	CategoryID	int		not null	identity(1,1),
	CategoryName	nvarchar(50)	not null,
	primary key (CategoryID)
);
go

create table Items (
	ItemID			nvarchar(4)	not null,
	ItemName		nvarchar(64)	not null,
	CategoryID		int		not null,
	UnitOfMeasure		nvarchar(20)	not null,
	primary key (ItemID),
	foreign key (CategoryID) references Categories(CategoryID)
);
go

create table Suppliers (
	SupplierID		nvarchar(4)		not null,
	SupplierName	nvarchar(64)	not null,
	ContactName		nvarchar(64)	not null,
	PhoneNumber		nvarchar(15)	not null,
	FaxNumber		nvarchar(15),
	Address			nvarchar(64),	
	primary key (SupplierID)
);
go

create table SupplierItems(
	SupplierItemID		int		not null	identity(1,1),
	SupplierID		nvarchar(4)		not null,
	ItemID			nvarchar(4)		not null,
	Rank			int,
	Cost 			numeric(8,2),
	primary key(SupplierItemID),
	foreign key (ItemID) references Items(ItemID),	
	foreign key (SupplierID) references Suppliers(SupplierID)
);
go

create table DeliveryStatus (
	DeliveryStatusID		int		not null	identity(1,1),
	DeliveryStatusName		nvarchar(30)	not null,
	primary key (DeliveryStatusID)
);
go

create table InvoiceUploadStatus (
	InvoiceUploadStatusID		int		not null	identity(1,1),
	InvoiceUploadStatusName		nvarchar(30)	not null,
	primary key (InvoiceUploadStatusID)
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
	SupplierID		nvarchar(4)		not null,
	DeliveryStatusID		int	not null,
	InvoiceUploadStatusID	int not null,
	primary key (OrderSupplierID),
	foreign key(OrderID) references Orders(OrderID),
	foreign key(SupplierID) references Suppliers(SupplierID),
	foreign key(DeliveryStatusID) references DeliveryStatus(DeliveryStatusID),
	foreign key(InvoiceUploadStatusID) references InvoiceUploadStatus(InvoiceUploadStatusID)
);
go

create table OrderSupplierDetails (
	OrderSupplierDetailsID		int		not null	identity(1,1),
	OrderSupplierID				int		not null,
	ItemID						nvarchar(4)		not null,
	Quantity 					int		not null,
	UnitCost					numeric(8,2)	not null,
	ActualQuantityReceived		int,
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
	CollectionPointID	int	not null,
	primary key (DepartmentID),
	foreign key (CollectionPointID) references CollectionPoint(CollectionPointID)
);
go

create table Employees (
	EmployeeID		nvarchar(20)		not null,
	DepartmentID	nvarchar(4)		not null,
	EmployeeName	nvarchar(20)	not null,
	PhoneNumber		nvarchar(20)		not null,
	EmailID			nvarchar(40)		not null,
	Sex				nvarchar(6)		not null,	
	primary key (EmployeeID	),
	foreign key (DepartmentID) references Departments(DepartmentID)
);
go


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
	ItemID				nvarchar(4)		not null,
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
	ItemID			nvarchar(4)	not null,
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

create table DisbursementDuty (
	DisbursementDutyID		int		not null	identity(1,1),
	StoreClerkID			nvarchar(20)	not null,
	isRetreived	 	bit 	not null,	
	primary key (DisbursementDutyID),
    foreign key(StoreClerkID) references Employees(EmployeeID)
	
);
go


create table StockTransaction (
	TransactionID		int		not null	identity(1,1),
	ItemID			nvarchar(4)		not null,
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
	ItemID			nvarchar(4)	not null,
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


create view StockCountItems AS
select 
	ISNULL(i.ItemID, -1),
	i.ItemName,
	i.UnitOfMeasure,
	sum(t.Adjustment) AS QtyInStock 
from
	Items i,
	StockTransaction t
where 
	i.ItemID=t.ItemID
group by 
	i.ItemID,
	i.ItemName,
	i.UnitOfMeasure

go

create view OutstandingRequisitionView As
Select d.RequisitionDetailsID,rd.Quantity-d.Quantity as OutStandingQuantity,
rd.itemID,dp.DepartmentID,r.ApproveDate
From (Select RequisitionDetailsID,Sum(CollectedQty)as Quantity
      From DisbursementDetails
	  Group by RequisitionDetailsID, ItemID)d,
RequisitionDetails rd,Employees e,Departments dp,Requisition r
where d.RequisitionDetailsID=rd.RequisitionDetailsID and 
      rd.RequisitionID=r.RequisitionID and
	  r.EmployeeID=e.EmployeeID and
	  e.DepartmentID=dp.DepartmentID

go

create view ReorderDetails As
Select rl.ItemID, rl.ReorderLevel,0.5*rl.ReorderLevel+rq.OutstandingQty as ReorderQuantity
From (select rd.ItemID,SUM(rd.Quantity)as ReorderLevel
      From RequisitionDetails rd,Requisition r
	  where rd.RequisitionID=r.RequisitionID and
	        month(r.requestedDate)=month(getDate())
	 group by rd.ItemID)rl,
	 (select ItemID,sum(OutStandingQuantity)as OutstandingQty
	  From OutStandingRequisitionView 
	  group by ItemID)rq
GO

create view RetreivalItems As
Select ret.ItemID ,ret.QtyToRetrieve,sci.QtyInStock
From (Select rd.ItemID,Sum(rd.Quantity) as QtyToRetrieve
      From RequisitionDetails rd, Requisition r
	  Where r.RequisitionID=rd.RequisitionID and
	        r.RetreivalStatusID in (1,3)
	 group by rd.ItemID) ret,StockCountItems sci
where sci.ItemID=ret.ItemID
GO












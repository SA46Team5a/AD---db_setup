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
	CollectionPointDetails	nvarchar(64)	not null,	
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
	primary key (EmployeeID),
	foreign key (DepartmentID) references Departments(DepartmentID)
);
go


create table Authority (
	AuthorityID	int		not null  identity(1,1),
	EmployeeID	nvarchar(20)		not null,
	StartDate	Datetime	not null,
	EndDate	DateTime,	
	primary key (AuthorityID),
	foreign key (EmployeeID) references Employees(EmployeeID)
);
go

create table DepartmentRepresentative (
	DeptRepID	int		not null  identity(1,1),
	EmployeeID	nvarchar(20)		not null,
	StartDate	Datetime	not null,
	EndDate	DateTime,	
	Passcode 	nvarchar(4) not null,	
	primary key (DeptRepID),
	foreign key (EmployeeID) references Employees(EmployeeID)
);
go


create table RetrievalStatus (
	RetrievalStatusID	int		not null,
	RetrievalStatusName	nvarchar(20)		not null,		
	primary key (RetrievalStatusID)	
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
	RequestedDate	Datetime,
	AuthorityID	int,
	ApproveDate Datetime,
	RetrievalStatusID int,
	ApprovalStatusID	int		not null,		
	primary key (RequisitionID),
	foreign key (EmployeeID) references Employees(EmployeeID),
	foreign key (AuthorityID) references Authority(AuthorityID),
	foreign key (RetrievalStatusID) references RetrievalStatus(RetrievalStatusID),
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

create table DisbursementDuty (
	DisbursementDutyID		int		not null	identity(1,1),
	StoreClerkID			nvarchar(20)	not null,
	DisbursementDate DateTime not null,
	isRetreived	 	bit 	not null,	
	primary key (DisbursementDutyID),
    foreign key(StoreClerkID) references Employees(EmployeeID)
	
);
go

create table Disbursement (
	DisbursementID		int		not null	identity(1,1),
	CollectionDate	Datetime	not null,
	RequisitionID			int		not null,
	CollectedBy int, 
	DisbursementDutyID		int not null,
	primary key (DisbursementID),
		foreign key(RequisitionID) references Requisition(RequisitionID),
		foreign key(CollectedBy) references DepartmentRepresentative(DeptRepID),
		foreign key(DisbursementDutyID) references DisbursementDuty(DisbursementDutyID)
);
go


create table DisbursementDetails (
	DisbursementDetailsID		int		not null	identity(1,1),
	DisbursementID	int		not null,
	Quantity  int		not null,
	CollectedQty int,	
	Reason nvarchar(40),
	RequisitionDetailsID int not null,
	primary key (DisbursementDetailsID),
	foreign key(DisbursementID) references Disbursement(DisbursementID),
	foreign key(RequisitionDetailsID) references RequisitionDetails(RequisitionDetailsID)
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
		ISNULL(i.ItemID, -1) as ItemID,
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
SELECT 
	rq.RequisitionID,
	rq.ApproveDate,
	rq.RequisitionDetailsID,
	rq.ItemID,
	Quantity - ISNULL(CollectedQty, 0) as OutStandingQuantity
FROM
	(
		SELECT
			r.RequisitionID,
			r.ApproveDate,
			rd.RequisitionDetailsID,
			rd.ItemId,
			rd.Quantity
		FROM
			Requisition r RIGHT JOIN RequisitionDetails rd ON r.RequisitionId = rd.RequisitionId
		WHERE
			r.RetrievalStatusID = 3 --Partially retrieved
	) rq 
	LEFT JOIN
	(
		SELECT
			RequisitionDetailsID,
			SUM(CollectedQty) as CollectedQty
		FROM
			DisbursementDetails
		GROUP BY
			RequisitionDetailsID
	) d
	ON 
		rq.RequisitionDetailsID = d.RequisitionDetailsID


go

create view ReorderDetails As
	SELECT
		rl.ItemID,
		ISNULL(rl.ReorderLevel,0) as ReorderLevel,
		CAST(0.5 * ISNULL(ReorderLevel,0) + ISNULL(rq.OutstandingQuantity, 0) as INT)as ReorderQuantity
	FROM
	(
		SELECT 
			i.ItemID,
			rl.ReorderLevel
		FROM
		(
			SELECT
				ItemID
			FROM
				Items
		) i
		LEFT JOIN
		(
			SELECT
				rd.ItemID,
				SUM(rd.Quantity) as ReorderLevel
			FROM
				RequisitionDetails rd, Requisition r
			WHERE
				rd.RequisitionID = r.RequisitionID AND
				MONTH(r.RequestedDate) = MONTH(GETDATE())
			GROUP BY
				rd.ItemID
		) rl
		ON 
		rl.ItemID = i.ItemID
	) rl
	LEFT JOIN
	(
		SELECT
			orv.ItemID,
			SUM(orv.OutstandingQuantity) as OutstandingQuantity
		FROM
			OutstandingRequisitionView orv,
			StockCountItems sci
		WHERE
			orv.itemID = sci.ItemID AND
			orv.OutStandingQuantity > sci.QtyInStock 
		GROUP BY
			orv.ItemID
	) rq
	ON
		rq.ItemID = rl.ItemID
GO

create view RetrievalItems As
	SELECT
		ret.ItemID,
		ret.QtyToRetrieve,
		sci.QtyInStock
	FROM
		(
			SELECT
				rd.ItemID,
				SUM(rd.Quantity) as QtyToRetrieve
			FROM 
				RequisitionDetails rd, 
				Requisition r
			WHERE 
				r.RequisitionID = rd.RequisitionID AND
				r.RetrievalStatusID IN (1,3)
			GROUP BY rd.ItemID
		) ret,
		StockCountItems sci
	WHERE 
		sci.ItemID=ret.ItemID AND
		sci.QtyInStock > ret.QtyToRetrieve
GO


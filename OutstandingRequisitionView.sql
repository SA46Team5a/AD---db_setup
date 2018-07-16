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
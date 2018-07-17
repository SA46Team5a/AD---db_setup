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


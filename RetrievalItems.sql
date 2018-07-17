create view RetreivalItems As
Select ret.ItemID ,ret.QtyToRetrieve,sci.QtyInStock
From (Select rd.ItemID,Sum(rd.Quantity) as QtyToRetrieve
      From RequisitionDetails rd, Requisition r
	  Where r.RequisitionID=rd.RequisitionID and
	        r.RetreivalStatusID in (1,3)
	 group by rd.ItemID) ret,StockCountItems sci
where sci.ItemID=ret.ItemID
GO

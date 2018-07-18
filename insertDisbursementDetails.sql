use StationeryStore;
/* INSERT QUERY */
INSERT INTO DisbursementDetails(
  ItemID, DisbursementID, Quantity, 
  CollectedQty, Reason, RequisitionDetailsID
) 
VALUES 
  ('C006', 1, 10, 9, 'Broken', 1);
/* INSERT QUERY */
INSERT INTO DisbursementDetails(
  ItemID, DisbursementID, Quantity, 
  CollectedQty, Reason, RequisitionDetailsID
) 
VALUES 
  ('S012', 2, 20, 19, 'Shortage', 2);


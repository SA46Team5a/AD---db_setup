use StationeryStore;/* INSERT QUERY */
INSERT INTO Requisition(
  EmployeeID, RequestedDate, AuthorityID, 
  ApproveDate, RetrievalStatusID,
  ApprovalStatusID
) 
VALUES 
  (
    'E025', '2016-05-08', 1, '2016-05-10', 
    4, 4
  );
/* INSERT QUERY */
INSERT INTO Requisition(
  EmployeeID, RequestedDate, AuthorityID, 
  ApproveDate, RetrievalStatusID, 
  ApprovalStatusID
) 
VALUES 
  (
    'E026', '2018-06-12', 2, '2018-06-14', 
    4, 3
  );

 
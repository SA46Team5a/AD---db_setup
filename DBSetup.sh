echo "start setup"
sqlcmd -i CreateDB.sql
echo "1"
sqlcmd -i insertCategories.sql
echo "2"
sqlcmd -i insertItems.sql
sqlcmd -i insertSuppliers.sql
sqlcmd -i insertSupplierItems.sql
sqlcmd -i insertDeliveryStatus.sql
sqlcmd -i insertInvoiceUploadStatus.sql
sqlcmd -i insertOrders.sql
sqlcmd -i insertOrderSuppliers.sql
sqlcmd -i insertOrderSupplierDetails.sql
sqlcmd -i insertCollectionPoint.sql
sqlcmd -i insertDepartments.sql
sqlcmd -i insertEmployees.sql
sqlcmd -i insertAuthority.sql
sqlcmd -i insertApprovalStatus.sql
sqlcmd -i insertRetrievalStatus.sql
sqlcmd -i insertRequisition.sql
sqlcmd -i insertStockTransaction.sql
sqlcmd -i insertVouchers.sql

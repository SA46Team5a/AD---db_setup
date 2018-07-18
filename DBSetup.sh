echo "start setup"
sqlcmd -i CreateDB.sql
echo "categories"
sqlcmd -i insertCategories.sql
echo "items"
sqlcmd -i insertItems.sql
echo "suppliers"
sqlcmd -i insertSuppliers.sql
echo "supplier items"
sqlcmd -i insertSupplierItems.sql
echo "delivery status"
sqlcmd -i insertDeliveryStatus.sql
echo "invoice upload status"
sqlcmd -i insertInvoiceUploadStatus.sql
echo "insert orders"
sqlcmd -i insertOrders.sql
echo "insert order suppliers"
sqlcmd -i insertOrderSuppliers.sql
echo "insert order supplier details"
sqlcmd -i insertOrderSupplierDetails.sql
echo "insert collection point"
sqlcmd -i insertCollectionPoint.sql
echo "insert departments"
sqlcmd -i insertDepartments.sql
echo "insert employees"
sqlcmd -i insertEmployees.sql
sqlcmd -i insertAlterDepartment.sql
sqlcmd -i insertAuthority.sql
sqlcmd -i insertApprovalStatus.sql
sqlcmd -i insertRetrievalStatus.sql
sqlcmd -i insertRequisition.sql
sqlcmd -i insertRequisitionDetails.sql
sqlcmd -i insertDisbursementDuty.sql
sqlcmd -i insertDisbursement.sql
sqlcmd -i insertDisbursementDetails.sql
sqlcmd -i insertStockTransaction.sql
sqlcmd -i insertVouchers.sql

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
echo "alter department"
sqlcmd -i insertAlterDepartment.sql
echo "authority"
sqlcmd -i insertAuthority.sql
echo "approval status"
sqlcmd -i insertApprovalStatus.sql
echo "retrieval status"
sqlcmd -i insertRetrievalStatus.sql
echo "requisition"
sqlcmd -i insertRequisition.sql
echo "requisition details"
sqlcmd -i insertRequisitionDetails.sql
echo "department representative"
sqlcmd -i insertDepartmentRepresentative.sql
echo "disbursement duty"
sqlcmd -i insertDisbursementDuty.sql
echo "disbursement"
sqlcmd -i insertDisbursement.sql
echo "disbursementDetails"
sqlcmd -i insertDisbursementDetails.sql
echo "stock transaction"
sqlcmd -i insertStockTransaction.sql
echo "vouchers"
sqlcmd -i insertStockVouchers.sql

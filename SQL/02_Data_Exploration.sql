
-- =============================================================================
-- FILE: 02_Data_Quality.sql
-- PROJECT: UPI Fraud Detection and Risk Analytics
-- DATABASE: upi_fraud_analytics
-- DESCRIPTION: Data quality audits, duplicate checks, null audits, and boundary checks.
-- =============================================================================

USE upi_fraud_analytics;

-- QUESTION 1: Duplicate Transaction ID Check
SELECT
    Transaction_ID,
    COUNT(*) AS Duplicate_Count
FROM cleaned_upi_transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;


-- QUESTION 2: Null and Missing Value Audit
SELECT
    COUNT(*) - COUNT(Transaction_ID) AS Null_IDs,
    COUNT(*) - COUNT(Customer_ID) AS Null_Customers,
    COUNT(*) - COUNT(Amount) AS Null_Amounts,
    COUNT(*) - COUNT(Transaction_Status) AS Null_Statuses,
    COUNT(*) - COUNT(Failure_Reason) AS Null_Failures
FROM cleaned_upi_transactions;


-- QUESTION 3: Invalid Value Boundary Audit
SELECT
    Transaction_ID,
    Customer_ID,
    Amount,
    Processing_Time_sec,
    Bank_Response_Time_ms
FROM cleaned_upi_transactions
WHERE Amount <= 0
   OR Processing_Time_sec < 0
   OR Bank_Response_Time_ms < 0;


-- QUESTION 4: Status and Failure Reason Consistency Check
SELECT
    Transaction_ID,
    Transaction_Status,
    Failure_Reason
FROM cleaned_upi_transactions
WHERE Transaction_Status = 'Success'
  AND Failure_Reason <> 'Not Applicable';


-- QUESTION 5: High Response Time Outlier Query
SELECT
    Transaction_ID,
    Customer_ID,
    Sender_Bank,
    Bank_Response_Time_ms,
    Fraud_Label
FROM cleaned_upi_transactions
ORDER BY Bank_Response_Time_ms DESC
LIMIT 5;

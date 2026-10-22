
-- =============================================================================
-- FILE: 05_Fraud_Analysis.sql
-- PROJECT: UPI Fraud Detection and Risk Analytics
-- DATABASE: upi_fraud_analytics
-- DESCRIPTION: Fraud metrics, UPI app risk, payment method risk,
--              failure reason analysis, and high-risk transaction screening.
-- =============================================================================

USE upi_fraud_analytics;


-- QUESTION 1: Overall Fraud Metrics

SELECT
    COUNT(*) AS Total_Transactions,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(
        SUM(CASE WHEN Fraud_Label = 1 THEN Amount ELSE 0 END),
        2
    ) AS Total_Fraud_Amount
FROM cleaned_upi_transactions;


-- QUESTION 2: Fraud Analysis by UPI Application

SELECT
    UPI_App,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(
        SUM(CASE WHEN Fraud_Label = 1 THEN Amount ELSE 0 END),
        2
    ) AS Fraud_Amount
FROM cleaned_upi_transactions
GROUP BY UPI_App
ORDER BY Fraud_Rate_Pct DESC;


-- QUESTION 3: Fraud Analysis by Payment Method

SELECT
    Payment_Method,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct
FROM cleaned_upi_transactions
GROUP BY Payment_Method
ORDER BY Fraud_Rate_Pct DESC;


-- QUESTION 4: Fraud Breakdown by Failure Reason

SELECT
    Failure_Reason,
    COUNT(*) AS Transaction_Count,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct
FROM cleaned_upi_transactions
WHERE Failure_Reason <> 'Not Applicable'
GROUP BY Failure_Reason
ORDER BY Fraud_Count DESC;


-- QUESTION 5: High-Amount and High-Latency Transactions

SELECT
    Transaction_ID,
    Customer_ID,
    Amount,
    Bank_Response_Time_ms,
    Payment_Method,
    Fraud_Label
FROM cleaned_upi_transactions
WHERE Amount > 5000
  AND Bank_Response_Time_ms > 800
ORDER BY Amount DESC
LIMIT 5;

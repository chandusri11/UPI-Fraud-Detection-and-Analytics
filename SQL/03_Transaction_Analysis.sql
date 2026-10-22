
-- =============================================================================
-- FILE: 03_Transaction_Analysis.sql
-- PROJECT: UPI Fraud Detection and Risk Analytics
-- DATABASE: upi_fraud_analytics
-- DESCRIPTION: Transaction KPIs, transaction types, payment methods, failure rates, and largest transfers.
-- =============================================================================

USE upi_fraud_analytics;


-- QUESTION 1: Overall Transaction KPI Summary
-- Total volume, monetary value, average, minimum, and maximum transaction amounts.

SELECT
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Monetary_Value,
    ROUND(AVG(Amount), 2) AS Avg_Transaction_Amount,
    ROUND(MIN(Amount), 2) AS Min_Amount,
    ROUND(MAX(Amount), 2) AS Max_Amount
FROM cleaned_upi_transactions;


-- QUESTION 2: Transaction Volume by Transaction Type

SELECT
    Transaction_Type,
    COUNT(*) AS Txn_Count,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    ROUND(AVG(Amount), 2) AS Avg_Amount
FROM cleaned_upi_transactions
GROUP BY Transaction_Type
ORDER BY Txn_Count DESC;


-- QUESTION 3: Payment Method Financial Distribution

SELECT
    Payment_Method,
    COUNT(*) AS Txn_Count,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    ROUND(AVG(Amount), 2) AS Avg_Amount
FROM cleaned_upi_transactions
GROUP BY Payment_Method
ORDER BY Txn_Count DESC;


-- QUESTION 4: Transaction Status and Failure Rate by Payment Method

SELECT
    Payment_Method,
    COUNT(*) AS Total_Txns,
    SUM(
        CASE
            WHEN Transaction_Status = 'Failed' THEN 1
            ELSE 0
        END
    ) AS Failed_Count,
    ROUND(
        AVG(
            CASE
                WHEN Transaction_Status = 'Failed' THEN 1.0
                ELSE 0.0
            END
        ) * 100,
        2
    ) AS Failure_Rate_Pct
FROM cleaned_upi_transactions
GROUP BY Payment_Method
ORDER BY Failure_Rate_Pct DESC;


-- QUESTION 5: Top 5 Largest Transactions

SELECT
    Transaction_ID,
    Customer_ID,
    Amount,
    Sender_Bank,
    Receiver_Bank,
    UPI_App,
    Transaction_Status,
    Fraud_Label
FROM cleaned_upi_transactions
ORDER BY Amount DESC
LIMIT 5;

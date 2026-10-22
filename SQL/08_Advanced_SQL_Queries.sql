-- =============================================================================
-- FILE: 08_Advanced_SQL.sql
-- PROJECT: UPI Fraud Detection and Risk Analytics
-- DESCRIPTION: Window Functions and Conditional Aggregation
-- =============================================================================

USE upi_fraud_analytics;


-- QUESTION 1: Customer Cumulative Running Total Amount

SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Date,
    Amount,
    SUM(Amount) OVER (
        PARTITION BY Customer_ID
        ORDER BY Transaction_Date, Transaction_ID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Running_Total_Amount
FROM cleaned_upi_transactions
ORDER BY Customer_ID, Transaction_Date, Transaction_ID
LIMIT 5;


-- QUESTION 2: Customer Moving Average Amount (3-Transaction Window)

SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Date,
    Amount,
    ROUND(
        AVG(Amount) OVER (
            PARTITION BY Customer_ID
            ORDER BY Transaction_Date, Transaction_ID
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS Moving_Avg_Amount
FROM cleaned_upi_transactions
ORDER BY Customer_ID, Transaction_Date, Transaction_ID
LIMIT 5;


-- QUESTION 3: Rank Transactions by Amount per UPI App

SELECT
    Transaction_ID,
    UPI_App,
    Amount,
    DENSE_RANK() OVER (
        PARTITION BY UPI_App
        ORDER BY Amount DESC
    ) AS Rank_In_App
FROM cleaned_upi_transactions
ORDER BY UPI_App, Rank_In_App, Transaction_ID
LIMIT 5;


-- QUESTION 4: Previous Transaction Amount Using LAG()

SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Date,
    Amount,
    LAG(Amount, 1) OVER (
        PARTITION BY Customer_ID
        ORDER BY Transaction_Date, Transaction_ID
    ) AS Prev_Amount
FROM cleaned_upi_transactions
ORDER BY Customer_ID, Transaction_Date, Transaction_ID
LIMIT 5;


-- QUESTION 5: UPI App vs Transaction Status

SELECT
    UPI_App,
    COUNT(*) AS Total_Txns,
    SUM(CASE
        WHEN Transaction_Status = 'Success' THEN 1
        ELSE 0
    END) AS Success_Count,
    SUM(CASE
        WHEN Transaction_Status = 'Failed' THEN 1
        ELSE 0
    END) AS Failed_Count,
    SUM(CASE
        WHEN Transaction_Status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending_Count
FROM cleaned_upi_transactions
GROUP BY UPI_App
ORDER BY Total_Txns DESC;
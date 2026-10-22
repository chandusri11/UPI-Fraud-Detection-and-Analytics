
-- =============================================================================
-- FILE: 04_Customer_Analysis.sql
-- PROJECT: UPI Fraud Detection and Risk Analytics
-- DATABASE: upi_fraud_analytics
-- DESCRIPTION: Customer activity, spending tiers, daily transaction bursts,
--              bank diversification, and fraudulent transactions.
-- =============================================================================

USE upi_fraud_analytics;


-- QUESTION 1: Top 5 Most Active Customers

SELECT
    Customer_ID,
    COUNT(*) AS Txn_Count,
    ROUND(SUM(Amount), 2) AS Total_Spent,
    ROUND(AVG(Amount), 2) AS Avg_Spent
FROM cleaned_upi_transactions
GROUP BY Customer_ID
ORDER BY Txn_Count DESC, Total_Spent DESC
LIMIT 5;


-- QUESTION 2: Customer Spending Tier Breakdown

SELECT
    CASE
        WHEN Amount >= 5000 THEN 'High Spender (>=5000)'
        WHEN Amount >= 1000 THEN 'Medium Spender (1000-4999)'
        ELSE 'Low Spender (<1000)'
    END AS Spend_Tier,
    COUNT(*) AS Txn_Count,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM cleaned_upi_transactions
GROUP BY Spend_Tier
ORDER BY Total_Amount DESC;


-- QUESTION 3: Customers with 3 or More Transactions on One Date

SELECT
    Customer_ID,
    Transaction_Date,
    COUNT(*) AS Daily_Txns,
    ROUND(SUM(Amount), 2) AS Daily_Amount
FROM cleaned_upi_transactions
GROUP BY Customer_ID, Transaction_Date
HAVING COUNT(*) >= 3
ORDER BY Daily_Txns DESC
LIMIT 5;


-- QUESTION 4: Customers Using 3 or More Distinct Sender Banks

SELECT
    Customer_ID,
    COUNT(DISTINCT Sender_Bank) AS Unique_Sender_Banks,
    COUNT(*) AS Total_Txns
FROM cleaned_upi_transactions
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Sender_Bank) >= 3
ORDER BY Unique_Sender_Banks DESC, Total_Txns DESC
LIMIT 5;


-- QUESTION 5: Customers with Fraudulent Transactions

SELECT
    Customer_ID,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM cleaned_upi_transactions
GROUP BY Customer_ID
HAVING SUM(Fraud_Label) >= 1
ORDER BY Fraud_Count DESC, Total_Amount DESC
LIMIT 5;

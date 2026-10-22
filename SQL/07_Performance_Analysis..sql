-- =============================================================================
-- FILE: 07_Time_Analysis.sql
-- PROJECT: UPI Fraud Detection and Risk Analytics
-- DESCRIPTION: Monthly trends, day-of-week patterns, weekend analysis, and peak dates.
-- =============================================================================

USE upi_fraud_analytics;


-- QUESTION 1: Monthly Transaction Volume and Fraud Trend

SELECT
    YEAR(Transaction_Date) AS Transaction_Year,
    MONTH(Transaction_Date) AS Transaction_Month,
    MONTHNAME(Transaction_Date) AS Month_Name,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM cleaned_upi_transactions
GROUP BY
    YEAR(Transaction_Date),
    MONTH(Transaction_Date),
    MONTHNAME(Transaction_Date)
ORDER BY
    Transaction_Year,
    Transaction_Month
LIMIT 6;


-- QUESTION 2: Day of Week Behavior Pattern

SELECT
    DAYNAME(Transaction_Date) AS Day_of_Week,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM cleaned_upi_transactions
GROUP BY
    DAYOFWEEK(Transaction_Date),
    DAYNAME(Transaction_Date)
ORDER BY Total_Txns DESC;


-- QUESTION 3: Weekend vs Weekday Risk Comparison
-- DAYOFWEEK(): Sunday = 1, Saturday = 7.

SELECT
    CASE
        WHEN DAYOFWEEK(Transaction_Date) IN (1, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(AVG(Amount), 2) AS Avg_Amount
FROM cleaned_upi_transactions
GROUP BY
    CASE
        WHEN DAYOFWEEK(Transaction_Date) IN (1, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END;


-- QUESTION 4: Quarterly Financial and Risk Summary

SELECT
    YEAR(Transaction_Date) AS Transaction_Year,
    QUARTER(Transaction_Date) AS Quarter,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM cleaned_upi_transactions
GROUP BY
    YEAR(Transaction_Date),
    QUARTER(Transaction_Date)
ORDER BY
    Transaction_Year,
    Quarter;


-- QUESTION 5: Top 5 Dates by Transaction Volume

SELECT
    Transaction_Date,
    COUNT(*) AS Daily_Txns,
    SUM(Fraud_Label) AS Daily_Fraud,
    ROUND(SUM(Amount), 2) AS Daily_Amount
FROM cleaned_upi_transactions
GROUP BY Transaction_Date
ORDER BY
    Daily_Txns DESC,
    Transaction_Date ASC
LIMIT 5;
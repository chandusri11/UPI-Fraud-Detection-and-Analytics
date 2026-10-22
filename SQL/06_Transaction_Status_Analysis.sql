USE upi_fraud_analytics;

-- QUESTION 1: Sender Bank Performance and Fraud Rate
SELECT
    Sender_Bank,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(Amount), 2) AS Total_Volume
FROM cleaned_upi_transactions
GROUP BY Sender_Bank
ORDER BY Fraud_Rate_Pct DESC;


-- QUESTION 2: Receiver Bank Performance and Fraud Rate
SELECT
    Receiver_Bank,
    COUNT(*) AS Total_Txns,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(AVG(Fraud_Label) * 100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(Amount), 2) AS Total_Volume
FROM cleaned_upi_transactions
GROUP BY Receiver_Bank
ORDER BY Fraud_Rate_Pct DESC;


-- QUESTION 3: Bank Technical Latency Benchmarking
SELECT
    Sender_Bank,
    COUNT(*) AS Total_Txns,
    ROUND(AVG(Bank_Response_Time_ms), 2) AS Avg_Response_Time_Ms,
    MIN(Bank_Response_Time_ms) AS Min_Response_Time_Ms,
    MAX(Bank_Response_Time_ms) AS Max_Response_Time_Ms
FROM cleaned_upi_transactions
GROUP BY Sender_Bank
ORDER BY Avg_Response_Time_Ms DESC;


-- QUESTION 4: Top 5 Bank Pairs by Transaction Volume
SELECT
    Sender_Bank,
    Receiver_Bank,
    COUNT(*) AS Pair_Txn_Count,
    SUM(Fraud_Label) AS Fraud_Count,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM cleaned_upi_transactions
GROUP BY Sender_Bank, Receiver_Bank
ORDER BY Pair_Txn_Count DESC
LIMIT 5;


-- QUESTION 5: Sender Bank Total Outbound Volume Summary
SELECT
    Sender_Bank AS Bank_Name,
    COUNT(*) AS Outbound_Txns,
    ROUND(SUM(Amount), 2) AS Outbound_Amount
FROM cleaned_upi_transactions
GROUP BY Sender_Bank
ORDER BY Outbound_Amount DESC
LIMIT 5;
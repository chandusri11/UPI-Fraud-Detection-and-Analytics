USE upi_fraud_analytics;

-- =============================================================================
-- FILE: 01_Database_Setup.sql
-- PROJECT: UPI Fraud Detection and Risk Analytics
-- DATABASE: upi_fraud_analytics
-- DESCRIPTION: Staging schema, production table, and ETL.
-- =============================================================================

-- QUESTION 1: Select existing database
USE upi_fraud_analytics;

-- QUESTION 2: Create raw staging table
DROP TABLE IF EXISTS raw_upi_transactions;

CREATE TABLE raw_upi_transactions (
    Transaction_ID VARCHAR(50),
    Transaction_Date VARCHAR(30),
    Customer_ID VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Sender_Bank VARCHAR(100),
    Receiver_Bank VARCHAR(100),
    UPI_App VARCHAR(50),
    Transaction_Type VARCHAR(50),
    Payment_Method VARCHAR(50),
    Amount DECIMAL(12, 2),
    Transaction_Status VARCHAR(30),
    Failure_Reason VARCHAR(100),
    Processing_Time_sec DECIMAL(8, 2),
    Bank_Response_Time_ms INT,
    Fraud_Label INT
);

-- QUESTION 3: Copy imported data into staging
INSERT INTO raw_upi_transactions (
    Transaction_ID, Transaction_Date, Customer_ID, City, State,
    Sender_Bank, Receiver_Bank, UPI_App, Transaction_Type,
    Payment_Method, Amount, Transaction_Status, Failure_Reason,
    Processing_Time_sec, Bank_Response_Time_ms, Fraud_Label
)
SELECT
    Transaction_ID,
    CAST(Transaction_Date AS CHAR),
    Customer_ID,
    City,
    State,
    Sender_Bank,
    Receiver_Bank,
    UPI_App,
    Transaction_Type,
    Payment_Method,
    Amount,
    Transaction_Status,
    Failure_Reason,
    Processing_Time_sec,
    Bank_Response_Time_ms,
    Fraud_Label
FROM upi_transactions_cleaned;

-- QUESTION 4: Create production cleaned table
DROP TABLE IF EXISTS cleaned_upi_transactions;

CREATE TABLE cleaned_upi_transactions (
    Transaction_ID VARCHAR(50) PRIMARY KEY,
    Transaction_Date DATE NOT NULL,
    Customer_ID VARCHAR(50) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Sender_Bank VARCHAR(100) NOT NULL,
    Receiver_Bank VARCHAR(100) NOT NULL,
    UPI_App VARCHAR(50) NOT NULL,
    Transaction_Type VARCHAR(50) NOT NULL,
    Payment_Method VARCHAR(50) NOT NULL,
    Amount DECIMAL(12, 2) NOT NULL,
    Transaction_Status VARCHAR(30) NOT NULL,
    Failure_Reason VARCHAR(100) DEFAULT 'Not Applicable',
    Processing_Time_sec DECIMAL(8, 2) NOT NULL,
    Bank_Response_Time_ms INT NOT NULL,
    Fraud_Label INT NOT NULL
);

CREATE INDEX idx_customer
ON cleaned_upi_transactions(Customer_ID);

CREATE INDEX idx_date
ON cleaned_upi_transactions(Transaction_Date);

CREATE INDEX idx_fraud
ON cleaned_upi_transactions(Fraud_Label);

-- QUESTION 5: Load data into production table
INSERT INTO cleaned_upi_transactions (
    Transaction_ID, Transaction_Date, Customer_ID, City, State,
    Sender_Bank, Receiver_Bank, UPI_App, Transaction_Type,
    Payment_Method, Amount, Transaction_Status, Failure_Reason,
    Processing_Time_sec, Bank_Response_Time_ms, Fraud_Label
)
SELECT
    Transaction_ID,
    STR_TO_DATE(Transaction_Date, '%Y-%m-%d'),
    Customer_ID,
    City,
    State,
    Sender_Bank,
    Receiver_Bank,
    UPI_App,
    Transaction_Type,
    Payment_Method,
    Amount,
    Transaction_Status,
    COALESCE(NULLIF(Failure_Reason, ''), 'Not Applicable'),
    Processing_Time_sec,
    Bank_Response_Time_ms,
    Fraud_Label
FROM raw_upi_transactions;

-- QUESTION 6: Verify the results
SELECT COUNT(*) AS staging_rows
FROM raw_upi_transactions;

SELECT COUNT(*) AS cleaned_rows
FROM cleaned_upi_transactions;

SELECT Fraud_Label, COUNT(*) AS transaction_count
FROM cleaned_upi_transactions
GROUP BY Fraud_Label
ORDER BY Fraud_Label;


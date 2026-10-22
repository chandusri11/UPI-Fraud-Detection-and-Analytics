# UPI Transaction Fraud & Risk Analytics

An end-to-end analytics project exploring UPI transaction activity and
fraud patterns using **Python, SQL, and Power BI**. The project is
designed to demonstrate data preparation, exploratory analysis,
SQL-based investigation, fraud-label analysis, and dashboard
development.

> **Project status:** Python/data preparation and SQL work have been
> completed. The Power BI dashboard is currently being developed; the
> report visuals and screenshots should be updated after the dashboard
> is finalized.

## Project objectives

-   Prepare and inspect UPI transaction data.
-   Explore transaction volumes, amounts, outcomes, and fraud labels.
-   Use SQL to answer analytical questions about transactions, fraud,
    banks, apps, and processing performance.
-   Build a Power BI dashboard to communicate key findings.
-   Present a reproducible, clearly documented analytics workflow.

## Tools and technologies

-   **Python:** data cleaning, analysis, and machine-learning
    experimentation
-   **Pandas:** data preparation and tabular analysis
-   **MySQL:** database storage and analytical SQL queries
-   **Power BI Desktop:** dashboard development
-   **Jupyter Notebook:** interactive analysis and experimentation

## Dataset overview

The working dataset contains **10,000 transactions** covering **1
January 2025 to 31 December 2025**.

Fields include:

-   `Transaction_ID`
-   `Transaction_Date`
-   `Customer_ID`
-   `City`, `State`
-   `Sender_Bank`, `Receiver_Bank`
-   `UPI_App`
-   `Transaction_Type`, `Payment_Method`
-   `Amount`
-   `Transaction_Status`
-   `Failure_Reason`
-   `Processing_Time_sec`
-   `Bank_Response_Time_ms`
-   `Fraud_Label`

The fraud label is binary: `1` indicates a transaction labelled as fraud
and `0` indicates a transaction not labelled as fraud.

### Initial data summary

  Metric                                                   Value
  ----------------------------------- --------------------------
  Total transactions                                      10,000
  Fraud-labelled transactions                                 99
  Fraud-labelled transaction rate                          0.99%
  Total transaction amount                        ₹13,391,148.51
  Fraud-labelled transaction amount                  ₹116,610.40
  Minimum transaction amount                              ₹19.89
  Maximum transaction amount                          ₹63,776.84
  Date range                            2025-01-01 to 2025-12-31

These are descriptive dataset statistics, not evidence that a real
financial institution experienced this fraud rate. Interpret them in the
context of the dataset and its labelling assumptions.

## Repository structure

``` text
UPI-Transaction-Fraud-and-Risk-Analytics/
├── data/
│   ├── UPI_Transactions_Cleaned.csv
│   └── UPI_Transactions_Raw.csv       # include only if permitted
├── notebooks/
│   └── your analysis and modelling notebooks
├── sql/
│   ├── 01_Database_Setup.sql
│   ├── 02_Data_Exploration.sql
│   ├── 03_Transaction_Analysis.sql
│   ├── 04_Fraud_Analysis.sql
│   ├── 05_Fraud_by_UPI_App_and_Bank.sql
│   ├── 06_Transaction_Status_Analysis.sql
│   ├── 07_Performance_Analysis.sql
│   └── 08_Advanced_SQL_Queries.sql
├── powerbi/
│   └── UPI_Fraud_Risk_Analytics.pbix  # add after dashboard is ready
├── docs/
│   └── PROJECT_DOCUMENTATION.md
├── reports/
│   └── PROJECT_REPORT.md
└── README.md
```

The structure above is a recommended layout. Keep only the files and
folders that actually exist in your repository, and adjust filenames to
match your saved work.

## Workflow

1.  **Data preparation:** inspect the raw transaction data, standardize
    fields, and create a cleaned dataset.
2.  **Database and SQL:** load the data into MySQL and use analytical
    queries to inspect transactions, fraud labels, transaction outcomes,
    bank/app patterns, and timing metrics.
3.  **Python analysis and modelling:** use notebooks for exploratory
    analysis and any modelling experiments. Record the actual
    algorithms, evaluation method, and metrics in the notebooks and
    documentation.
4.  **Power BI:** connect to the cleaned MySQL table, create KPI
    measures, and build charts and filters.
5.  **Interpretation:** compare findings across tools and explain
    limitations, especially class imbalance and the meaning of the fraud
    label.

## Power BI dashboard plan

The intended first page includes:

-   Total transactions
-   Fraud-labelled transactions
-   Fraud rate
-   Monthly transaction trend
-   Transaction status distribution
-   Fraud count by UPI app
-   Slicers for state, UPI app, and transaction type

Add the `.pbix` file and dashboard screenshots once the report is
complete. Do not describe unfinished visuals as completed.

## How to reproduce

1.  Clone or download this repository.
2.  Install Python and the libraries used by the notebooks.
3.  Open the notebooks in Jupyter and update any file paths to your
    local environment.
4.  Create a MySQL schema and run the SQL scripts in order, checking
    that table and column names match the scripts.
5.  Open the Power BI `.pbix` file after it is added and update the
    database connection credentials locally.

Database credentials should never be committed to the repository.

## Important limitations

-   The dataset's fraud labels and patterns may not represent real-world
    UPI fraud prevalence.
-   Fraud-labelled transactions are a small minority of the data, so
    accuracy alone would be a misleading model metric. Use precision,
    recall, F1-score, confusion matrix, and PR-AUC where appropriate if
    modelling is included.
-   Associations in the data do not prove that a bank, app, city, or
    transaction type causes fraud.
-   Results depend on the quality, coverage, and assumptions of the
    supplied data.

## Data privacy

Only publish data that you have permission to share. Remove personal or
sensitive information, database credentials, and any confidential
records before committing files to GitHub.

## Author

**Your Name**\
B.Tech, Civil Engineering\
IIT Indore

Replace the author details with the name and contact links you want to
publish.

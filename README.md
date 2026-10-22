UPI Transaction Fraud Detection & Risk Analytics
End-to-End Data Analytics Portfolio Project using Python, SQL, Machine Learning, and Power BI
1. Project Overview
Unified Payments Interface (UPI) has made digital payments fast and accessible across India. Analyzing transaction behaviour, identifying fraud-related patterns, and understanding payment performance are important parts of digital payment risk analytics.

This project uses a dataset of 10,000 UPI transactions from 2025 to explore transaction behaviour and fraud-labelled records. It combines Python-based data preparation and analysis, SQL investigations in MySQL, machine-learning experiments, and Power BI visualizations.

The project is designed as a data analytics portfolio project demonstrating an end-to-end workflow: preparing transaction data, exploring patterns, querying structured data, evaluating fraud-prediction approaches, and communicating findings through visual reporting.
Scope note: The dataset's labels and statistics describe this dataset only. They should not be interpreted as confirmed real-world UPI fraud rates or verified financial losses.

2. Business Problem
Payment platforms need to understand transaction behaviour, monitor payment performance, and investigate suspicious activity. Transaction data can help analysts explore questions such as:
1. How many transactions are recorded, and what is their total value?
2. What proportion of records are labelled as fraudulent?
3. How do transaction outcomes vary across transaction categories and payment applications?
4. How do processing time and bank response time vary across transactions?
5. Can transaction features help a machine-learning model identify fraud-labelled records?
This project investigates these questions through descriptive analytics, SQL queries, visualizations, and machine-learning experimentation.
3. Project Objectives
- Clean and prepare transaction records using Python and Pandas.
- Explore transaction amounts, dates, statuses, and available categorical fields.
- Calculate transaction volume, transaction value, and fraud-label metrics.
- Use MySQL to query and compare transaction and fraud patterns.
- Explore fraud-label distributions across available banks, UPI applications, locations, transaction types, and payment methods.
- Investigate processing time and bank response time.
- Explore machine-learning methods for fraud classification and evaluate them using appropriate metrics.
- Present important metrics and patterns through Power BI.
- Document findings, limitations, and possible next steps.
4. Tools and Technologies
Tool / Technology	Purpose
Python	Data preparation, exploratory analysis, and machine-learning experiments
Pandas	Data cleaning and manipulation
NumPy	Numerical operations
Scikit-learn	Machine-learning preprocessing, classification, and evaluation where implemented
MySQL	Structured data storage and SQL-based analysis
MySQL Workbench	Running and managing SQL scripts
Power BI	Data visualization and dashboard development
Jupyter Notebook	Python development and analysis
GitHub	Project documentation and portfolio presentation


5. Dataset Description
The dataset contains 10,000 transaction records dated from January 1, 2025, to December 31, 2025.
Data Dictionary
Column	Description
Transaction_ID	Unique transaction identifier
Transaction_Date	Date of the transaction
Customer_ID	Customer identifier
City	City associated with the transaction
State	State associated with the transaction
Sender_Bank	Bank associated with the sender
Receiver_Bank	Bank associated with the receiver
UPI_App	UPI application used for the transaction
Transaction_Type	Recorded transaction category
Payment_Method	Payment method recorded for the transaction
Amount	Transaction amount in Indian rupees
Transaction_Status	Recorded transaction outcome
Failure_Reason	Recorded reason for failure, where applicable
Processing_Time_sec	Transaction processing time in seconds
Bank_Response_Time_ms	Bank response time in milliseconds
Fraud_Label	Binary label: 1 for fraud-labelled and 0 for non-fraud-labelled transactions


Dataset Notes
- The analysis uses the fields available in the dataset.
- Fraud_Label is treated as the provided target label; the project does not independently verify the underlying labels.
- Additional features should only be described as implemented if they exist in the actual data or notebooks.
6. Data Cleaning and Preparation
Python and Pandas are used to prepare the transaction data for analysis.

The preparation workflow includes inspecting the dataset, checking column names and data types, reviewing missing values, standardizing fields where needed, and preparing a cleaned CSV for use in MySQL and Power BI.

Key checks include:
- Inspecting the number of rows and columns.
- Reviewing data types and missing values.
- Checking transaction identifiers for duplicates.
- Preparing transaction dates for time-based analysis.
- Checking transaction amount and processing-time fields for invalid values.
- Exporting the prepared dataset for downstream analysis.
The exact cleaning steps should be interpreted alongside the Python notebook included in the repository.
7. Exploratory Data Analysis (EDA)
Exploratory analysis helps establish the main characteristics of the transaction dataset.
7.1 Transaction Volume and Amount
The analysis examines total transaction count, transaction value, average transaction amount, and the range of recorded transaction amounts.
7.2 Fraud-Label Distribution
Fraud-labelled and non-fraud-labelled transactions are compared to understand the distribution of the target variable and the class imbalance relevant to classification.
7.3 Transaction Status
Transaction statuses are summarized to understand the recorded distribution of successful, failed, and pending transactions.
7.4 Bank and UPI Application Patterns
Available bank and UPI application fields can be grouped to compare transaction volumes and fraud-label distributions.
7.5 Processing and Response Times
Processing time and bank response time are explored as operational variables. Any relationship with fraud labels requires further validation and should not be interpreted as proof of causation.
8. Key Dataset Statistics
Metric	Value
Total transactions	10,000
Fraud-labelled transactions	99
Non-fraud-labelled transactions	9,901
Fraud-label percentage	0.99%
Total transaction amount	₹13,391,148.51
Amount associated with fraud-labelled transactions	₹116,610.40
Average transaction amount	₹1,339.11
Minimum transaction amount	₹19.89
Maximum transaction amount	₹63,776.84


Interpretation
Fraud-labelled transactions account for 0.99% of the dataset. This is a strongly imbalanced target distribution, so a classification model can appear accurate while missing most fraud cases.

The ₹116,610.40 figure is the transaction amount associated with fraud-labelled records; it is not necessarily a confirmed financial loss. These figures describe this dataset and are not estimates of fraud across the entire UPI ecosystem.
9. SQL Analysis Using MySQL
The cleaned transaction dataset is stored in the MySQL database upi_fraud_analytics. The table used for Power BI is cleaned_upi_transactions.

SQL is used to calculate metrics and investigate transaction patterns in a repeatable way.
Analysis Areas
Analysis Area	Example Questions
Transaction overview	What is the total number and value of transactions?
Amount analysis	What are the average, minimum, and maximum transaction amounts?
Status analysis	How are transactions distributed by status?
Fraud analysis	How many records are fraud-labelled, and what percentage do they represent?
UPI application analysis	How do transaction volumes and fraud labels vary by application?
Bank analysis	How do transaction counts and fraud labels vary by sender or receiver bank?
Location analysis	How do transaction metrics vary across states and cities?
Performance analysis	What are the average processing and bank response times?
Category comparisons	How do transaction patterns differ by type and payment method?


The repository's SQL directory should contain the saved query files. The filenames and descriptions below are suggested organization; retain only names that match the scripts actually uploaded.
Suggested SQL file	Purpose
01_Database_Setup.sql	Database and table setup
02_Data_Exploration.sql	Initial data checks and summary statistics
03_Transaction_Analysis.sql	Transaction volume, amount, and category analysis
04_Fraud_Analysis.sql	Fraud counts, rates, and comparisons
05_Fraud_by_UPI_App_and_Bank.sql	Application- and bank-level analysis
06_Transaction_Status_Analysis.sql	Status and failure-pattern analysis
07_Performance_Analysis.sql	Processing-time and response-time analysis
08_Advanced_SQL_Queries.sql	Additional analytical queries, if implemented


10. Fraud Detection and Machine-Learning Experiments
The project documentation describes a supervised binary-classification experiment using Fraud_Label as the target. Three algorithms were benchmarked using balanced class weights and an 80/20 stratified train/test split. The test set contained 2,000 transactions, including 20 fraud-labelled cases.
10.1 Model Comparison
Model	Accuracy	Precision	Recall	F1-score	ROC-AUC	Interpretation
Logistic Regression (balanced)	72.90%	1.85%	50.00%	3.56%	60.31%	Highest recall of the three models; identified 10 of the 20 fraud-labelled test cases.
Decision Tree Classifier (balanced)	81.90%	0.86%	15.00%	1.63%	51.93%	Identified 3 of the 20 fraud-labelled test cases.
Random Forest Classifier (balanced)	99.00%	0.00%	0.00%	0.00%	46.93%	Did not identify fraud-labelled cases at the evaluated classification threshold despite high accuracy.


Source note: These are the results recorded in the project documentation. Before publishing, check that the final notebook reproduces these values and uses the same split and preprocessing.
10.2 What the Results Mean
The target is highly imbalanced: 99 of 10,000 transactions (0.99%) are labelled as fraud. Because non-fraud records dominate the dataset, a model can achieve high accuracy while failing to detect fraud.
- Accuracy measures the proportion of all predictions that are correct, but can be misleading with a rare fraud class.
- Precision measures how many transactions predicted as fraud are actually labelled as fraud.
- Recall measures how many actual fraud-labelled transactions the model detects.
- F1-score balances precision and recall.
- ROC-AUC measures how well the model ranks positive cases above negative cases across thresholds.
In the documented comparison, Logistic Regression had the highest recall at 50%, detecting 10 of the 20 fraud-labelled test records. Its precision was low (1.85%), so many transactions flagged by the model were false positives. This trade-off should be discussed rather than choosing a model on accuracy alone.
10.3 Preprocessing and Leakage Checks
The project documentation describes a scikit-learn preprocessing workflow using imputation, scaling, and one-hot encoding. It also states that Risk_Score and Risk_Level were excluded from model features to avoid target leakage. Keep these details in the final README only if the submitted notebook contains the corresponding preprocessing pipeline and exclusions.
10.4 Important Limitations
- Results are based on this dataset and its labels; they do not establish real-world UPI fraud detection performance.
- The test set contains only 20 fraud-labelled cases, so the recall estimate can change substantially with a different split.
- Low precision can produce many false alarms, even when recall is comparatively higher.
- A model should not be described as production-ready without further validation, threshold analysis, and testing on representative unseen data.
11. Power BI Dashboard
Power BI is used to summarize transaction and fraud metrics visually. The data model uses the UPI table loaded from the MySQL table cleaned_upi_transactions.
Measures Created
Measure	Purpose
Total Transactions	Counts transaction rows
Fraud Transactions	Counts records where Fraud_Label = 1
Fraud Rate	Divides fraud transactions by total transactions


Visuals Developed or Explored
Visual	Purpose
KPI card — Total Transactions	Displays the total number of transaction records
KPI card — Fraud Transactions	Displays the number of fraud-labelled records
KPI card — Fraud Rate	Displays the fraud-label percentage
Transaction trend chart	Explores transaction activity over time
Transaction status donut chart	Shows the distribution of transaction statuses
UPI application fraud chart	Intended to compare fraud counts across UPI applications
Slicers	Intended to filter by fields such as state, UPI application, and transaction type


The dashboard is a work in progress. The final README and screenshots should be updated to reflect the visuals that are completed and verified in the final .pbix file.
12. Key Findings and Interpretation
The currently verified dataset-level findings are:
1. Low fraud-label prevalence: 99 of 10,000 transactions are labelled as fraud, giving a dataset fraud-label rate of 0.99%.
2. Class imbalance: The target distribution is heavily skewed toward non-fraud-labelled records, making precision and recall important for model evaluation.
3. Transaction value: The total recorded transaction amount is ₹13,391,148.51.
4. Fraud-labelled amount: Records labelled as fraud account for ₹116,610.40 in transaction amount; this should not be treated as confirmed financial loss.
5. Multiple analysis dimensions: The dataset supports investigation by transaction date, status, amount, UPI application, bank, location, transaction type, payment method, and processing metrics.
Further claims about which application, bank, state, or time period has the highest fraud rate should be added only after confirming the corresponding analysis output.
13. Business Recommendations
The analysis workflow can inform further investigation in the following areas:
- Monitor fraud-label trends: Track changes in fraud-label rates across relevant transaction categories.
- Evaluate models beyond accuracy: Consider precision, recall, F1-score, and false-positive counts when evaluating fraud classifiers.
- Investigate unusual patterns: Use bank, application, location, amount, and transaction-status comparisons to identify areas that merit further review.
- Monitor operational performance: Review processing and bank response times alongside transaction outcomes.
- Communicate results clearly: Use Power BI to present key metrics and enable category-level exploration.
- Validate before operational use: Any model or risk rule should be tested on representative unseen data before being considered for real-world decisions.
These are analytical recommendations, not claims that the project has prevented fraud or reduced losses.
14. Repository Structure
The following is a suggested structure. Keep the files and folders that actually exist in the repository and adjust the names to match your saved work.
UPI-Fraud-Detection-and-Analytics/
│
├── README.md
├── data/
│   └── README.md
├── notebooks/
│   └── Python analysis and machine-learning notebooks
├── sql/
│   └── Saved MySQL query scripts
├── powerbi/
│   └── Power BI report (.pbix), if included
├── docs/
│   └── PROJECT_DOCUMENTATION.md
└── reports/
    └── PROJECT_REPORT.md
Do not upload credentials, passwords, or data that you do not have permission to share.
15. How to Run the Project
Python
1. Install Python and Jupyter Notebook.
2. Install the packages required by the notebooks.
3. Place the permitted dataset file in the expected location or update the notebook's file path.
4. Run the notebooks in the required order.
If a requirements.txt file is included, install dependencies using:
pip install -r requirements.txt
Launch Jupyter Notebook:
jupyter notebook
MySQL
1. Open MySQL Workbench.
2. Select or create the upi_fraud_analytics database.
3. Import the cleaned CSV into cleaned_upi_transactions.
4. Open and execute the saved SQL scripts.
5. Review the query outputs.
Power BI
1. Open the Power BI report if it is included in the repository.
2. Reconfigure the data source if the original local connection is unavailable.
3. Refresh the data.
4. Explore the completed KPI cards, charts, and filters.
Exact execution steps may vary with the filenames and connections used in the final repository.
16. Limitations
- The analysis depends on the quality and representativeness of the available dataset.
- Fraud labels are accepted as supplied and are not independently verified.
- The dataset's fraud-label rate should not be generalized to all UPI transactions.
- The amount associated with fraud-labelled records is not necessarily a confirmed financial loss.
- Machine-learning performance must be evaluated on unseen data.
- Class imbalance can make accuracy misleading.
- Associations in the data do not prove causation.
- This project is for educational and portfolio purposes and is not a production fraud-monitoring system.
17. Future Improvements
- Document and compare verified machine-learning model results.
- Investigate suitable methods for handling class imbalance.
- Improve feature engineering using information legitimately available at prediction time.
- Evaluate classification thresholds using precision-recall trade-offs.
- Complete and refine the Power BI dashboard.
- Add dashboard screenshots and a data dictionary.
- Add a reproducible requirements.txt and exact setup instructions.
- Explore how validated fraud indicators could support a transaction-review workflow.
18. Conclusion
This project brings together Python, MySQL, machine-learning experimentation, and Power BI to explore UPI transaction behaviour and fraud-related patterns.

It demonstrates a data analytics workflow from data preparation and exploratory analysis to SQL-based investigation, fraud classification experiments, and visual reporting. It also highlights the challenges of evaluating fraud detection when the positive class represents a small fraction of the dataset.

Project type: Data Analytics Portfolio Project

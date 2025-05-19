WITH MonthlyTransactions AS (
#Calculate number of trasaction per owner using year and month
  SELECT
    SA.owner_id,
    Year(SA.transaction_date) AS year,
    month(SA.transaction_date) AS month,
    COUNT(*) AS transactions_count
  FROM
    savings_savingsaccount SA
  GROUP BY
    SA.owner_id,
    year,
    month
),

AvgTransactionsPerCustomer AS (

#Calculate average monthly transaction for all months
  SELECT
    owner_id,
    AVG(transactions_count) AS avg_transactions_per_month
  FROM
    MonthlyTransactions
  GROUP BY
    owner_id
),

CategorizedCustomers AS (
#Categorize the outputs based on their frequency
  SELECT
    owner_id,
    avg_transactions_per_month,
    CASE
      WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
      WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
      ELSE 'Low Frequency'
    END AS frequency_category
  FROM
    AvgTransactionsPerCustomer
)

SELECT
#select stament to show the number of customer and average trasanctions per frequency
  frequency_category,
  COUNT(owner_id) AS customer_count,
  Round(AVG(avg_transactions_per_month), 2)  AS avg_transactions_per_month
FROM
  CategorizedCustomers
GROUP BY
  frequency_category

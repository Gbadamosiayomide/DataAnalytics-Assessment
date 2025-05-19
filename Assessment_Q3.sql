#Create a CTE to get the last transaction date
WITH LastTransactions AS (
  SELECT
    owner_id,
    plan_id,
    MAX(transaction_date) AS last_transaction_date
  FROM
    savings_savingsaccount 
  GROUP BY
    owner_id,
    plan_id
)
# Select plans that are inactive for over a year or have no transactions
SELECT
  PP.id AS plan_id,
  PP.owner_id,
  PP.description,
  SA.last_transaction_date,
  DATEDIFF(CURDATE(), SA.last_transaction_date) AS inactivity_days
FROM
  plans_plan PP
LEFT JOIN
  LastTransactions SA ON PP.id = SA.plan_id AND PP.owner_id = SA.owner_id
WHERE
   
PP.is_deleted = 0 AND (  PP.description LIKE '%Savings%' OR PP.description LIKE '%Investment%' OR PP.description LIKE '%Mutual Fund%' OR PP.description LIKE '%Portfolio%') 
  # Flag plans with either no transaction or inactivity for over 365 days
  AND (

    SA.last_transaction_date IS NULL OR
    DATEDIFF(CURDATE(), SA.last_transaction_date) > 365
  );

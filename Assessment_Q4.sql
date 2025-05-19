# Got the User Id and full name
SELECT 
    UD.id AS customer_id,
    CONCAT(UD.first_name, ' ', UD.last_name) AS name,
    #To get the month difference and curdate to get today's date
    TIMESTAMPDIFF(MONTH, UD.date_joined, CURDATE()) AS tenure_months,
    
    IFNULL(SA.total_inflow, 0) + IFNULL(WW.total_withdrawal, 0) AS total_transaction_value,

    (
        (IFNULL(SA.total_inflow, 0) + IFNULL(WW.total_withdrawal, 0))
        / TIMESTAMPDIFF(MONTH, UD.date_joined, CURDATE())
    ) * 12 * 0.001 AS estimated_clv
# use the formular given in the assesment 
FROM users_customuser UD

# summarize total inflow pfrom confirmed amount
LEFT JOIN (
    SELECT owner_id, SUM(confirmed_amount) AS total_inflow
    FROM savings_savingsaccount
    GROUP BY owner_id
) SA ON SA.owner_id = UD.id

# summarize total inflow pfrom amout withdrawn
LEFT JOIN (
    SELECT owner_id, SUM(amount_withdrawn) AS total_withdrawal
    FROM withdrawals_withdrawal
    GROUP BY owner_id
) WW ON WW.owner_id = UD.id

#To show one row for each user
ORDER BY estimated_clv DESC;

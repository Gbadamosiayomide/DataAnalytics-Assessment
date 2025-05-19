#Select ID and full name ( Concatenate first and last name )

SELECT 
  UC.id AS owner_id,
  CONCAT(UC.first_name, ' ', UC.last_name) AS name,
  
#Count of savings account with confirmed account greater than zero and the corresponding investment plan
  COUNT(DISTINCT CASE 
        WHEN (PP.description LIKE '%Savings%') AND SA.confirmed_amount > 0 THEN SA.id 
        ELSE NULL END) AS savings_count,
  COUNT(DISTINCT CASE 
        WHEN (PP.is_fixed_investment = 1 ) 
             AND SA.confirmed_amount > 0 THEN SA.id 
        ELSE NULL END) AS investment_count,
  SUM(CASE WHEN SA.confirmed_amount > 0 THEN SA.confirmed_amount ELSE 0 END) AS total_deposits
FROM 
  users_customuser UC
JOIN 
  savings_savingsaccount SA ON UC.id = SA.owner_id
JOIN
  plans_plan PP ON SA.plan_id = PP.id
GROUP BY
  UC.id, UC.first_name, UC.last_name
HAVING 
  savings_count > 0 AND investment_count > 0
ORDER BY 
  total_deposits DESC;









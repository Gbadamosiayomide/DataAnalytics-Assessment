# DataAnalytics-Assessment
Data Analyst Assessment

Assessment_Q1
Approach: I first needed to undersyand the gaol and go through the dataset and find colums that stores savings and investment information.

            Then i Had to join the savings_savingsaccount with the plans_plan and User_customuser
            
            Filter savings and investment plans separately:
            
            Savings:  Description is savings AND confirmed_amount > 0
            
            Investment: is_fixed_investment = 1 AND confirmed_amount > 0
            
            Group by customer to get total deposits per type.
            
            Join savings and investment subqueries on customer to find those who have both.
            
            Sum total deposits and sort.

Challenges: For the savings account, I had to go with Description because the question said 'least', and they were several saving plan that is_regular_savings doesn't show.

Assessment_Q2
Approach : I create a CTE MonthlyTransactions to count the number of transactions per customer per month.

            This is done by extracting YEAR() and MONTH() from the transaction_date field.
            
            The AvgTransactionsPerCustomer CTE, i had to  compute the average number of transactions per month for each customer.
            
            CategorizedCustomers CTE uses a CASE statement to segment customers into:
            
            "High Frequency": ≥ 10 transactions/month
            
            "Medium Frequency": 3–9 transactions/month
            
            "Low Frequency": ≤ 2 transactions/month
            
            Then the final SELECT groups by frequency category and reports:
            
            Number of customers per category.
            
            Average transactions per customer within each category (rounded to 2 decimals).
            
Challenges: The Join was making the query ambiguous, i assumed the owner_id and id in the customer table are the same.

Assessment_Q3
Approach: I had to  create a CTE LastTransactions that:

            Groups by owner_id and plan_id
            
            Gets the MAX(transaction_date) as the most recent inflow
            
            Used filter for plans that are not deleted 
            
            Used description to capture all types of active financial plans: "Savings", "Investment", "Mutual Fund", "Portfolio"
            
            Use a LEFT JOIN to retain plans with no transactions ever
            
            Use DATEDIFF() to compute how long it’s been since the last transaction

Challeges: I had to settle for a  description based filtering after going through the data 

Assessment_Q4
Approach: I got user sign_up dates, I use date_joined to calculate account tenure in months
            I included inflows (confirmed_amount) and withdrawals (amount_withdrawn) to define total transaction volume
            I  implementended the CLC formular
            I then ranked  customers by estimated_clv DESC

Challenges: The Null values. I had to use ifnull to correct that




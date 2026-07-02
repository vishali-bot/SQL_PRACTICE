--Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.


SELECT account_id, total_amt_usd,
CASE WHEN total_amt_usd >= 3000 THEN 'Large' ELSE 'Small' 
END AS Level_order
FROM orders ;


--Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.

SELECT 
    CASE 
        WHEN total >= 2000 THEN 'At Least 2000'
        WHEN total BETWEEN 1000 AND 1999 THEN 'Between 1000 and 2000'
        ELSE 'Less than 1000'
    END AS Order_Category,
    COUNT(*) AS Num_Orders
FROM orders
GROUP BY 1;



--We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.


SELECT a.name, sum(o.total_amt_usd) AS Total_sales,
CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'FIRST' 
WHEN SUM(o.total_amt_usd) BETWEEN 200000 AND 100000 THEN 'SECOND' 
ELSE 'LOWEST' END AS Level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY Total_sales desc ;


--We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.

SELECT a.name, sum(o.total_amt_usd) AS Total_sales,
CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'FIRST' 
WHEN SUM(o.total_amt_usd) BETWEEN 200000 AND 100000 THEN 'SECOND' 
ELSE 'LOWEST' END AS Level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE EXTRACT(YEAR FROM o.occurred_at) IN (2016, 2017)
GROUP BY a.name
ORDER BY Total_sales desc ;


--We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.

SELECT a.name, SUM(total_amt_usd) total_spent, 
        CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
        WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
        ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31' 
GROUP BY 1
ORDER BY 2 DESC;


--We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.

SELECT s.name, COUNT(*) num_ords,
        CASE WHEN COUNT(*) > 200 THEN 'top'
        ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;


--The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table.

SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
        CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
        WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
        ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;
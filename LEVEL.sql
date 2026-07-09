CREATE TABLE expense_data (
    date_time TEXT,
    account VARCHAR(100),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    note TEXT,
    inr DECIMAL(10,2),
    income_expense VARCHAR(20),
    note1 TEXT,
    amount DECIMAL(10,2),
    currency VARCHAR(20),
    account1 DECIMAL(10,2)
);

--Display all the records from the expense_data table.
SELECT * FROM expense_data ;

--Display only these columns: date_time ,category ,amount
SELECT date_time ,category ,amount FROM expense_data;

--Find the total number of transactions.
SELECT COUNT(*) FROM expense_data;

--Display all unique categories.
SELECT category FROM expense_data GROUP BY 1;

--Find the total income.
SELECT SUM(amount) AS Total_income  FROM expense_data WHERE income_expense = 'Income';

--Find the total expense.
SELECT SUM(amount) AS Total_expense FROM expense_data WHERE income_expense = 'Expense';

--Find the net savings.
SELECT ( SELECT SUM(amount) FROM expense_data WHERE income_expense = 'Income'
) - (SELECT SUM(amount) FROM expense_data WHERE income_expense = 'Expense'
) AS net_savings;

--Which category has the highest expense?
SELECT category, SUM(amount) AS total_expense FROM expense_data WHERE income_expense = 'Expense'
GROUP BY 1
ORDER BY total_expense DESC 
LIMIT 1;

--Find the top 5 highest expense transactions.
SELECT date_time ,category,amount FROM expense_data
WHERE income_expense = 'Expense'
ORDER BY amount DESC
LIMIT 5;

--How many transactions belong to each category?
SELECT category , COUNT(*) AS Transactions FROM expense_data
GROUP BY 1; 

--Show the total income and total expense in a single query.
SELECT  SUM(
CASE WHEN income_expense = 'Income' THEN amount ELSE 0 END ) AS total_income ,
SUM(CASE WHEN income_expense = 'Expense' THEN amount ELSE 0 END) AS total_expense
FROM expense_data;

--Total Income and Expense by Category
SELECT category, SUM(
CASE WHEN income_expense = 'Income' THEN amount ELSE 0 END ) AS total_income ,
SUM(CASE WHEN income_expense = 'Expense' THEN amount ELSE 0 END) AS total_expense
FROM expense_data
GROUP BY category;

--Categories with High Expenses
SELECT category, SUM(amount) AS total_expense
FROM expense_data WHERE income_expense = 'Expense'
GROUP BY category HAVING (SUM(amount) > 10000) ;

--Show categories that have at least 5 expense transactions.
SELECT category, AVG(amount) AS avg_expense
FROM expense_data
WHERE income_expense = 'Expense'
GROUP BY category
HAVING COUNT(*) >= 5;

--Monthly Expense Report
SELECT SUBSTRING(date_time, 1, 7) AS month, SUM(amount) AS total_expense
FROM expense_data
WHERE income_expense = 'Expense'
GROUP BY month;

--Which month had the highest total expense?
SELECT  SUBSTRING(date_time, 1, 7) AS month, SUM(amount) AS total_expense
FROM expense_data
WHERE income_expense = 'Expense'
GROUP BY month
ORDER BY total_expense DESC
LIMIT 1;

--Show the top 5 highest expense transactions
SELECT  date_time, category, amount
FROM expense_data
WHERE income_expense = 'Expense'
ORDER BY amount DESC
LIMIT 5;

--Find the category that has the highest average expense.
SELECT category, AVG(amount) AS avg_expense
FROM expense_data
WHERE income_expense = 'Expense'
GROUP BY category
ORDER BY avg_expense DESC
LIMIT 1;

--How many income transactions and expense transactions are there in the dataset
SELECT income_expense, COUNT(*) AS total_transactions
FROM expense_data 
GROUP BY income_expense;

--Show the top 5 categories with the highest total expenses
SELECT category, SUM(amount) AS total_expense
FROM expense_data
WHERE income_expense = 'Expense'
GROUP BY category
ORDER BY total_expense DESC
LIMIT 5;

--Find all expense transactions that are greater than the average expense amount.
SELECT date_time, category ,  amount
FROM expense_data
WHERE income_expense = 'Expense'
AND amount > (SELECT AVG(amount) AS avg_expense FROM expense_data
    WHERE income_expense = 'Expense');

--Find all income transactions whose amount is greater than the average income amount
SELECT date_time, category,amount
FROM expense_data WHERE income_expense ='Income'
AND amount > (SELECT AVG(amount) AS avg_income FROM expense_data
WHERE income_expense ='Income' ); 

--Show all transactions whose amount is greater than the maximum expense amount.
SELECT amount FROM expense_data 
WHERE amount > 
(SELECT MAX(amount)  FROM expense_data WHERE income_expense = 'Expense' 
);

--Show all expense transactions whose amount is equal to the highest expense
SELECT SUBSTRING(date_time,1,7), amount ,category FROM expense_data
WHERE amount =
(SELECT MAX(amount) FROM expense_data WHERE income_expense ='Expense');


--Write the SQL query to display:
--| customer_name | order_id |
| ------------- | -------: |
| Alice         |      101 |
| Alice         |      102 |
| Bob           |      103 |

SELECT c.customer_name, o.order_id
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

--Display all customers who have NOT placed any orders.
SELECT c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--Write a query to display: Joining 3 Tables
--customer_name	order_id	payment_mode
SELECT c.customer_name,
       o.order_id,
       p.payment_mode
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
INNER JOIN Payments p
ON o.order_id = p.order_id;

--Write a query to display the total order amount for each customer.
--| customer_name | total_amount |
| ------------- | -----------: |
| Alice         |          800 |
| Bob           |          700 |

SELECT
    c.customer_name,
    SUM(o.amount) AS total_amount
FROM Orders o
INNER JOIN Customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

--Display every customer along with their total order amount.
--COALESCE() to replace NULL with 0 so the report is easier to read
SELECT
    c.customer_name,
    COALESCE(SUM(o.amount), 0) AS total_amount
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

--Display the names of customers who have placed more than one order.
SELECT c.customer_name
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

--Show the customer who spent the highest total amount.
SELECT
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

--Show all customers whose total spending is greater than ₹600.
SELECT
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.amount) > 600;
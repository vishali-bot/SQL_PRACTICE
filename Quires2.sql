/* JOINS Questions

1) Provide a table that provides the region for each sales_rep along with their associated accounts.
 This time only for the Midwest region. Your final table should include 
 three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) 
 according to account name.



2)Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
 Your final table should include three columns: the region name, the sales rep name, and the account name. 
 Sort the accounts alphabetically (A-Z) according to account name.

3)Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.

4)Provide the name for each region for every order, as well as the account name and the unit price they paid 
(total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, account name, and unit price. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

5)Provide the name for each region for every order, as well as the account name and the unit price 
they paid (total_amt_usd/total) for the order. However, you should only provide the results 
if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. 
Sort for the smallest unit price first. In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

6)Provide the name for each region for every order, as well as the account name and the unit price 
they paid (total_amt_usd/total) for the order. However, you should only provide the results 
if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. 
Sort for the largest unit price first. In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

7)What are the different channels used by account id 1001? 
Your final table should have only 2 columns: account name and the different channels. 
You can try SELECT DISTINCT to narrow down the results to only the unique values.

8)Find all the orders that occurred in 2015. 
Your final table should have 4 columns: occurred_at, account name, order total, 
and order total_amt_usd.  */


-- SOLUTIONS

1) SELECT region.name, 
sales_reps.name,
accounts.name
FROM accounts
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
JOIN region
ON region.id = sales_reps.region_id
WHERE region.name = 'Midwest'
ORDER BY accounts.name;

2) SELECT region.name, 
sales_reps.name,
accounts.name
FROM accounts
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
JOIN region
ON sales_reps.region_id = region.id
WHERE sales_reps.name LIKE 'S%'
AND region.name = 'Midwest';

3) SELECT region.name, 
sales_reps.name,
accounts.name
FROM accounts
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
JOIN region
ON sales_reps.region_id = region.id
WHERE sales_reps.name LIKE '% K%'
AND region.name = 'Midwest' 
ORDER BY accounts.name ;

4) SELECT region.name, 
accounts.name,
orders.total_amt_usd/(total+0.01)
AS unit_price
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id
JOIN orders
ON orders.account_id = accounts.id
WHERE standard_qty > 100;

5) SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

6) SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

7) SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

8) SELECT accounts.name,orders.occurred_at,
orders.total, orders.total_amt_usd
FROM orders
INNER JOIN accounts
ON accounts.id = orders.account_id
WHERE orders.occurred_at
BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY o.occurred_at DESC;


--Find the total amount for each individual order that was spent on 
--standard and gloss paper in the orders table. This should give a dollar amount for each order 
--in the table.


SELECT standard_amt_usd + gloss_amt_usd 
AS total_standard_gloss
FROM orders;

--Though the price/standard_qty paper varies from one order to the next. 
--I would like this ratio across all of the sales made in the orders table.


SELECT SUM(standard_amt_usd)/SUM(standard_qty) 
AS standard_price_per_unit
FROM orders;


/*Find the mean (AVERAGE) amount spent per order on each paper type, 
as well as the mean amount of each paper type purchased per order. Your final 
answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.*/

SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
              AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
              AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

/*LEARNING -- This is more advanced than what we have covered so far 
try finding - what is the MEDIAN total_usd spent on all orders? 
Note, this is more advanced than the topics we have covered thus far to build a general solution, 
but we can hard code a solution in the following way. */

SELECT *
FROM (SELECT total_amt_usd
         FROM orders
         ORDER BY total_amt_usd
         LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;


/*GROUP BY Questions

1)Which account (by name) placed the earliest order? 
Your solution should have the account name and the date of the order.

2)Find the total sales in usd for each account.
 You should include two columns - the total sales for each company's orders in usd and the company name.

3)Via what channel did the most recent (latest) web_event occur,
 which account was associated with this web_event? 
 Your query should return only three values - the date, channel, and account name.

4)Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the number of times the channel was used.

5)Who was the primary contact associated with the earliest web_event?

6)What was the smallest order placed by each account in terms of total usd. 
Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

7)Find the number of sales reps in each region. 
Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.*/


1)SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1;


2)SELECT a.name, SUM(total_amt_usd) AS Total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;


3)SELECT  w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;


4)SELECT channel, COUNT(*)
FROM web_events
GROUP BY channel;

5)SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

6)SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;


7)SELECT r.name, COUNT(*) AS no
FROM sales_reps s
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
ORDER BY no;

/*GROUP BY Part II
Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

1)For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

2)For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

3)Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

4)Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.*/

1) SELECT a.name, AVG(o.standard_qty) avg_stand, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

2)SELECT a.name, AVG(o.standard_amt_usd) avg_stand, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

3)SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

4)SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

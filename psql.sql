SELECT * FROM walmart;

SELECT COUNT(*) FROM walmart;

SELECT DISTINCT payment_method FROM walmart;

select payment_method , count(*)
from walmart
group by payment_method;

select count(distinct Branch) from walmart;

SELECT MAX(quantity) FROM walmart;

SELECT MIN(quantity) FROM walmart;

--Business problems
--Q1. Find different payment method and for each payment method 
--    find the no. of transactions and no. of quantity sold


SELECT payment_method , COUNT(*) AS no_payments, SUM(quantity) AS no_qnty_sold
FROM walmart
GROUP BY payment_method;

--Q2. Identify the highest rated category in each branch, 
--    displaying the branch, category and AVG Rating

SELECT
	branch,
	category,
	AVG(rating) as avg_rating,
	RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
FROM walmart
GROUP BY 1,2;

SELECT * FROM
(	SELECT
		branch,
		category,
		AVG(rating) as avg_rating,
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
	FROM walmart
	GROUP BY 1,2
)
WHERE rank = 1;

--Q3. Identify the busiest day for each branch based on the no. of transactions

SELECT branch, 
	TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS day_name,
	COUNT(*) as no_transactions
FROM walmart
GROUP BY 1,2
ORDER BY 3 desc;

--Q4. Calculate the total quantity of items sold per payment method.
--    List the payment_method and total_quantity

SELECT payment_method, 
	SUM(quantity) as total_quantity
FROM walmart
GROUP BY 1;

--Q5. Determine the average, min and max rating of products for each city.
--	  List the city, avg_rating, min_rating and max_rating.

SELECT city, category,
	AVG(rating) as average_rating,
	MIN(rating) as min_rating,
	MAX(rating) as max_rating

FROM walmart
GROUP BY 1,2;

--Q6. Calculate the total profit for each category by considering total_profit 
--	  as (unit_price * quantity * profit_margin). List category and total_profit,
--	  ordered from highest to lowest profit.

SELECT category, 
	SUM(total*profit_margin) as total_profit
FROM walmart
GROUP BY 1;

--Q7. Determine most common payment method for each branch. 
--	  Display branch and preferred_payment_method.

SELECT branch, payment_method as pref_payment_method,
	count(*) as total_transactions,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart
GROUP BY 1,2;

WITH cte
as
(SELECT branch, payment_method as pref_payment_method,
	count(*) as total_transactions,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart
GROUP BY 1,2
)
SELECT * FROM cte
WHERE rank=1;










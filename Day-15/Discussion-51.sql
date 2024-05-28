-- Part 1: Mastering Pattern Matching with LIKE
-- Scenario: Product Catalog Search
-- You're tasked with improving the search functionality in the classicmodels product catalog, allowing for more flexible search patterns.

-- Task 1.1: Wildcard Searches for Product Names
-- Objective: Create a query to find product names that start with "Classic", include any characters in the middle, and end with "Car".
-- Query Instructions:
-- Use the LIKE operator with appropriate wildcards to match the pattern.
-- SQL Constructs: SELECT, FROM, WHERE, LIKE
select * from product where product_name like "classic%car";


-- Task 1.2: Flexible Search for Customer Addresses
-- Objective: Identify all customer addresses that contain the word "Street" or "Avenue" in any part of the address field.
-- Query Instructions:
-- Utilize the LIKE operator with wildcards to match both "Street" and "Avenue" within any part of the address string.
-- SQL Constructs: SELECT, FROM, WHERE, LIKE
select * from product where address like "%street%" or address like "%avenue%";


-- Part 2: Utilizing Range Queries with BETWEEN
-- Scenario: Sales and Payment Analysis
-- Your goal is to analyze sales and payments within specific ranges to identify trends and outliers.

-- Task 2.1: Orders within a Price Range
-- Objective: Find all orders with total amounts between two values, indicating mid-range transactions.
-- Query Instructions:
-- Sum the order details to get total order amounts and use BETWEEN to filter orders within the specified range.
-- SQL Constructs: SELECT, FROM, JOIN, GROUP BY, HAVING, BETWEEN
select order,sum(amount) as total_amount from product having sum(amount) between max(amount) and min(amount) group by order;;


-- Task 2.2: Payments within a Date Range
-- Objective: Retrieve all payments made within a specific date range, focusing on a high-activity period.
-- Query Instructions:
-- Use the BETWEEN operator to filter payments in the payments table that fall within the given date range.
-- SQL Constructs: SELECT, FROM, WHERE, BETWEEN
select * from product where date between 'start_date' and 'end_date';


-- Part 3: Exploring Subqueries with ANY and ALL
-- Scenario: Comparative Sales Analysis
-- You are analyzing sales data to compare individual sales against broader trends and performance metrics.

-- Task 3.1: Orders Exceeding Average Sale Amount
-- Objective: Identify orders where the total amount exceeds the average sale amount across all orders.
-- Query Instructions:
-- Use a subquery to calculate the average sale amount and compare individual order totals using the > ANY operator against this average.
-- SQL Constructs: SELECT, FROM, WHERE, GROUP BY, HAVING, ANY, subquery
select order,sum(amount) as total_amount from product havinwhag sum(amount)>any(select avg(amount) from product) group by order;


-- Task 3.2: Products with Maximum Order Quantity
-- Objective: Find products that have been ordered in quantities equal to the maximum quantity ordered for any product.
-- Query Instructions:
-- Use a subquery to find the maximum order quantity and then use the = ALL operator to identify products matching this quantity.
-- SQL Constructs: SELECT, FROM, WHERE, ALL, subquery
select product_name,quantiy from product where quantity= all(select max(quantity) from product);


-- Part 4: Combining Operators for Complex Queries
-- Scenario: Customer and Sales Insight
-- Conduct a comprehensive analysis of customer orders, payments, and geographic distribution to gain insights into customer behavior and sales performance.

-- Task 4.1: High-Value Customers in Specific Regions
-- Objective: Identify customers who have made payments in the top 10% of all payments and are located in specific geographic regions.
-- Query Instructions:
-- Combine LIKE for geographic matching, BETWEEN for date ranges, and a subquery with ANY to compare against top payments.
-- SQL Constructs: SELECT, FROM, JOIN, WHERE, LIKE, BETWEEN, ANY, subquery
SELECT * FROM customers c JOIN payment p ON c.customer_id = p.customer_id WHERE c.geographic_region IN ('region1', 'region2', 'region3')
AND p.payment_amount >= (SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY payment_amount DESC) FROM payment);

-- Task 4.2: Seasonal Sales Analysis
-- Objective: Analyze sales data to identify products with significantly higher sales in specific seasons compared to their annual sales average.
-- Query Instructions:
-- Use BETWEEN to define seasonal date ranges, aggregate functions to calculate averages, and ANY or ALL in combination with subqueries to compare seasonal sales against annual averages.
-- SQL Constructs:
-- SELECT, FROM, JOIN, GROUP BY, HAVING, BETWEEN, ANY, ALL, subquery
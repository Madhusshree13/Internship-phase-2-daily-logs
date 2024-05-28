-- 1. Create an inline view to calculate the daily total sales.
-- Create an updatable view to show the number of orders for each day. Also include a functionality to update the order status in the same view.
-- Create a view to identify the most purchased product of each day.
-- Finally, combine these views to produce the required daily report.
CREATE VIEW daily_sales AS SELECT DATE(orderDate) AS order_date, SUM(quantityOrdered * priceEach) AS total_sales FROM orders JOIN orderdetails USING (orderNumber) GROUP BY order_date;
CREATE VIEW daily_orders AS SELECT DATE(orderDate) AS order_date, COUNT(orderNumber) AS num_orders, status FROM orders GROUP BY order_date, status;
UPDATE daily_orders SET status = 'new_status' WHERE order_date = 'some_date';
CREATE VIEW daily_top_product AS SELECT DATE(orderDate) AS order_date, productCode, SUM(quantityOrdered) AS total_quantity FROM orders JOIN orderdetails 
USING (orderNumber) GROUP BY order_date, productCode ORDER BY total_quantity DESC;


-- 2. Create a view that shows the total number of customers handled by each sales rep.
-- Create a view that displays the total payments received by each sales rep.
-- Create another view that shows the total number of orders handled by each sales rep.
-- Finally, create a combined view that uses the above views to display the performance of each sales rep.
CREATE VIEW rep_customers AS SELECT employeeNumber, COUNT(DISTINCT customerNumber) AS num_customers FROM customers GROUP BY employeeNumber;
CREATE VIEW rep_payments AS SELECT employeeNumber, SUM(amount) AS total_payments FROM customers JOIN payments USING (customerNumber) GROUP BY employeeNumber;
CREATE VIEW rep_orders AS SELECT employeeNumber, COUNT(DISTINCT orderNumber) AS num_orders FROM customers JOIN orders USING (customerNumber) GROUP BY employeeNumber;


-- 3. Create a view in the hr database that shows the department and age of each employee.
-- Create a view in the classicmodels database that shows the sales performance of each employee.
-- As MySQL doesn't support cross-database queries in the form of database.schema.table, 
-- you may need to combine the data in one database or manually join the exported data from these views in a tool like Python or Excel to analyze the combined data.
CREATE VIEW emp_details AS SELECT employee_id, department_id, TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age FROM employees;
CREATE VIEW emp_sales_performance AS SELECT employeeNumber, SUM(amount) AS total_sales FROM customers JOIN payments USING (customerNumber) GROUP BY employeeNumber;

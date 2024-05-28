-- Updatable View:
-- Create an updatable view that includes customerNumber, customerName, contactLastName, and contactFirstName from the customers table. 
-- Then, try to update the contactFirstName for a specific customerNumber.
create view customer_view as select customerNumber, customerName, contactLastName,contactFirstName from customers;
update customer_view set contactFirstName = "New" and contactLastName = "New" where customerNumber =101;


-- Read-Only View:
-- Create a read-only view that joins the orderdetails table and the products table on productCode and includes orderNumber, productName, and quantityOrdered. 
-- Try to update the quantityOrdered for a specific orderNumber and see what happens.
create view order_product as select od.orderNumber, p.productName, od.quantityOrdered from orderdetails od join productCode p using (productCode);


-- Inline View:
-- Write a query that uses an inline view to get the total number of orders for each customer. The inline view should select customerNumber and orderNumber from the orders table.
-- The main query should then group by customerNumber.
select count(iv.orderNumber) as total_orders,iv.customerNumber from (select orderNumber,customerNumber from orders) as iv group by iv.customerNumber;



-- Materialized View:
-- Note that MySQL does not natively support materialized views, but you can mimic them with a combination of stored procedures and triggers. 
-- The task here would be to create a stored procedure that creates a new table with productName and totalQuantityOrdered (this total should be aggregated from the orderdetails table). 
-- Then, create an AFTER INSERT trigger on the orderdetails table that calls this stored procedure to update the table (acting as a materialized view) whenever a new order detail is inserted.
create procedure new_procedure 
begin 
drop table if exists materialized_view;
create table materialized_view as select p.productName, sum(od.quantityOrdered) as totalQuantityOrdered from orderdetails od join products p on p.productCode=od.productCode group by p.productName;
end;
create trigger materialized_view_after_insert after insert on orderdetails
for each row call new_procedure();
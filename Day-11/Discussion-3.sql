-- 1.) Write a query to display a list of customers who locate in the same city by joining the customers table to itself.
select c1.city, c1.customerName, c2.customerName from customers c1 join customers c2 on c1.city = c2.city where c1.customerName != c2.customerName order by a.city;

-- 2.) Write a query to get:
-- The productCode and productName from the products table.
-- The textDescription of product lines from the productlines table.
select p.productCode, p.productName, pl.textDescription from products p inner join productlines pl on p.productline = pl.productline;

-- 3.) Write a query that returns order number, order status, and total sales from the orders and orderdetails tables as follows:
select a.orderNumber,status,SUM(quantityOrdered * priceEach) as total from orders a inner join orderdetails b on a.orderNumber=b.orderNumber group by a.orderNumber;

-- 4.) Write a query to fetch the complete details of orders from the orders, orderDetails, and products table, and sort them by orderNumber and orderLineNumber as follows:
select orderNumber,orderDate,orderLineNumber,productName,quantityOrdered,priceEach from orders inner join orderdetails using (orderNumber) inner join products using (productCode) order by orderNumber,orderLineNumber;

-- 5.) Write a query to perform INNER JOIN of four tables:
select orderNumber,orderDate,customerName,orderLineNumber,productName,quantityOrdered,priceEach from orders inner join orderdetails using (orderNumber) inner join products using (productCode) inner join customers using(customerNumber) order by orderNumber,orderLineNumber;

-- 6.) Write a query to find the sales price of the product whose code is S10_1678 that is less than the manufacturer’s suggested retail price (MSRP) for that product as follows:
select orderNumber,productName,msrp,priceEach from products a inner join orderdetails b on a.productcode=b.productcode and a.msrp>b.priceEach where a.productCode='S10_1678';
 
-- 7.) Each customer can have zero or more orders while each order must belong to one customer. Write a query to find all the customers and their orders as follows:
select a.customerNumber,a.customerName,b.orderNumber,b.status from customers a inner join orders b on a.customerNumber=b.customerNumber order by a.customerNumber;

-- 8.) Write a query that uses the LEFT JOIN to find customers who have no order:
select a.customerNumber,a.customerName,b.orderNumber,b.status from customers a left join orders b on a.customernumber=b.customernumber and b.ordernumber is null;

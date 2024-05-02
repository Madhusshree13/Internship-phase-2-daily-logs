create table customers(
    customerNumber varchar(20) not null,
    customerName varchar(30) not null,
    contactLastName varchar(30) not null,
    contactFirstName varchar(30) not null,
    phone int(10) not null,
    addressLine1 varchar(30) not null,
    addressLine2 varchar(30),
    city varchar(30) not null,
    state varchar(30) not null,
    postalCode varchar(30) not null,
    country varchar(30) not null,
    salesRepEmployeeNumber varchar(20) not null,
    creditLimit int(10),
    constraint pk_customers primary key (customerNumber),
    index idx_salesRepEmployeeNumber (salesRepEmployeeNumber) 
    
);

create table employees(
    employeeNumber varchar(20) not null,
    lastName varchar(30) not null,
    firstName varchar(30) not null,
    extension varchar(20) not null,
    email varchar(30) not null,
    officeCode int(10) not null,
    reportsTo varchar(20) not null,
    jobTitle varchar(20),
    constraint uq_email_id_employees unique (email),
    constraint pk_employees primary key (employeeNumber),
    constraint fk_employees_customers foreign key (employeeNumber) references customers(salesRepEmployeeNumber),
    constraint fk_employees_employees foreign key (reportsTo) references employees(employeeNumber)
);

create table productlines(
    productLine varchar(30) not null,
    textDescription varchar(30) not null,
    htmlDescription text,
    image varchar(255),
    constraint pk_productlines primary key(productLine)
);


create table products(
    productCode varchar(10) not null,
    productName varchar(30) not null,
    productLine varchar(30) not null,
    productScale varchar(30) not null,
    productVendor varchar(30) not null,
    productDescription varchar(50) not null,
    quantityInStock int(8) not null,
    buyPrice int(10) not null,
    MSRP int(10),
    constraint pk_products primary key (productCode),
    index idx_productLine (productLine), -- Adding index for productLine
    constraint fk_product_productlines foreign key(productLine) references productlines(productLine)
);

create table orderdetails(
    orderNumber varchar(10) not null,
    productCode varchar(10) not null,
    quantityOrdered int(5) not null,
    priceEach int(8) not null,
    orderLineNumber varchar(10) not null,
    constraint uq_orderNumber unique (orderNumber),
    constraint pk_orderdetails primary key (orderNumber,productCode),
    index idx_productCode (productCode), -- Adding index for productCode
    constraint fk_product_orderdetails foreign key(productCode)  references products(productCode)
);

create table orders(
    orderNumber varchar(10) not null,
    orderDate datetime not null,
    requiredDate datetime,
    shippedDate datetime not null,
    status varchar(10) not null,
    comments text,
    customerNumber varchar(20) not null,
    constraint pk_orders primary key (orderNumber),
    index idx_customerNumber (customerNumber), 
    constraint fk_orders_orderdetails foreign key (orderNumber) references orderdetails(orderNumber),
    constraint fk_orders_customers foreign key (customerNumber) references customers(customerNumber)
);

ALTER TABLE customers
ADD INDEX idx_customerName (customerName);

create table payments(
    customerName varchar(30) not null,
    checkNumber varchar(6) not null,
    paymentDate datetime,
    amount int(10),
    constraint pk_payments primary key(customerName,checkNumber),
    index idx_customerName (customerName),
    constraint fk_customers_payments foreign key (customerName) references customers(customerName)
);


create table offices(
    officeCode int(10) not null,
    city varchar(30) not null,
    phone int(10) not null,
    addressLine1 varchar(30) not null,
    addressLine2 varchar(30) not null,
    state varchar(20) not null,
    country varchar(20) not null,
    postalCode varchar(10),
    territory varchar(10),
    constraint pk_offices primary key(officeCode),
    index idx_officeCode (officeCode) 
);


show tables;

USE classicmodels;

-- Q1_721424060_S92064060

CREATE VIEW SalesRepresentative AS
SELECT *
FROM employees
WHERE jobTitle = 'Sales Rep';

-- Q2_721424060_S92064060

CREATE VIEW EmpCity AS
SELECT CONCAT(employees.firstname, ' ', employees.lastname) AS name,
employees.email,
employees.jobTitle,
offices.city
FROM employees
JOIN offices ON employees.officeCode = offices.officeCode;

-- Q3_721424060_S92064060

SELECT *FROM empcity
WHERE jobTitle = 'Sales Rep' AND city = 'San Francisco';

-- Q4_721424060_S92064060

CREATE VIEW Customer_Products AS
SELECT customers.customerName, customers.country, products.productName, orderdetails.quantityOrdered
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode;

-- Q5_721424060_S92064060 (details of customers who ordered the product '1911 Ford Town Car':)

SELECT customerName, country
FROM Customer_Products
WHERE productName = '1911 Ford Town Car';

-- Q5_721424060_S92064060 (number of customers who ordered the product '1911 Ford Town Car':)

SELECT COUNT(DISTINCT customerName) AS numCustomers
FROM Customer_Products
WHERE productName = '1911 Ford Town Car';

-- Q6_721424060_S92064060

CREATE TABLE Product_Text (
  productCode varchar(15) NOT NULL,
  productName varchar(70) NOT NULL,
  productVendor varchar(50),
  quantityInStock smallint,
  PRIMARY KEY (productCode)
);

CREATE TRIGGER insert_product
AFTER INSERT ON products
FOR EACH ROW
INSERT INTO Product_Text (productCode, productName, productVendor, quantityInStock)
VALUES (NEW.productCode, NEW.productName, NEW.productVendor, NEW.quantityInStock);

-- Q7_721424060_S92064060

insert  into `products`(`productCode`,`productName`,`productLine`,`productScale`,`productVendor`,`productDescription`,`quantityInStock`,`buyPrice`,`MSRP`) values 
('S01_2000','GM125','Motorcycles','5:10','Susuki','oldest version motorbike ',100,'20.05','90.50'),
('S01_2001','Audi i3','Classic Cars','10:10','Lenova ','This is new model car ',20,'130.55','200.20'),
('S01_2002','CT 100','Motorcycles','6:11','Bajaj','Best fule saving bike',11,'90.00','110.50');

select *from product_text;


-- Q8_721424060_S92064060

CREATE TRIGGER delete_product
AFTER DELETE ON products
FOR EACH ROW
DELETE FROM Product_Text
WHERE productCode = OLD.productCode;

-- Q9_721424060_S92064060

DELETE FROM products WHERE productCode = 'S01_2002';

SELECT *
FROM Product_Text;
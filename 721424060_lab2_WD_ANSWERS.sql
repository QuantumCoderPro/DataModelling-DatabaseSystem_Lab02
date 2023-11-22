USE classicmodels;

-- Q1_721424060_S92064060

CREATE VIEW USACustomers AS
SELECT *
FROM customers
WHERE country = 'USA';

-- Q2_721424060_S92064060

CREATE VIEW CustomerOrders AS
SELECT CONCAT(c.contactFirstName, ' ', c.contactLastName) AS contactName,
c.phone,
o.orderDate,
o.status
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber;

-- Q3_721424060_S92064060 (Obtain details of all orders which have the status as ‘Cancelled’ or ‘Disputed’)

SELECT *
FROM CustomerOrders
WHERE status IN ('Cancelled', 'Disputed');

-- Q3_721424060_S92064060 (modify the status of cancelled or disputed)

UPDATE CustomerOrders
SET status = 'Removed'
WHERE status IN ('Cancelled', 'Disputed');

-- Q4_721424060_S92064060

CREATE VIEW SalesRepOrders AS
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
c.customerName,
c.salesRepEmployeeNumber,
o.orderDate,
o.orderNumber
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

-- Q5_721424060_S92064060

SELECT employeeName, COUNT(orderNumber) AS orderCount
FROM SalesRepOrders
GROUP BY employeeName
HAVING COUNT(orderNumber) > 20;

-- Q6_721424060_S92064060

CREATE TABLE customer_contact (
  customerNumber INT NOT NULL ,
  customerName VARCHAR(100),
  phone VARCHAR(20),
  PRIMARY KEY (customerNumber)
);

CREATE TRIGGER insert_customer
AFTER INSERT ON customers
FOR EACH ROW
  INSERT INTO customer_contact (customerNumber, customerName, phone)
  VALUES (NEW.customerNumber, NEW.customerName, NEW.phone);
  
select *from customer_contact;

-- Q7_721424060_S92064060

INSERT INTO `customers` (`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `phone`, `addressLine1`, `city`, `country`)
VALUES
  (770, 'ousl', 'Safran', 'mohammed', '721424060', 'main street', 'pottuvil', 'srilanka'),
  (880, 'Signal clogat', 'clogat', 'Signal', '0718415070', 'Spill road', 'shanghung', 'Japan');

SELECT * FROM customer_contact;



-- Q8_721424060_S92064060

CREATE TRIGGER delete_customer
AFTER DELETE ON customers
FOR EACH ROW
  DELETE FROM customer_contact
  WHERE customerNumber = OLD.customerNumber;
  
select *from customer_contact;

-- Q9_721424060_S92064060

DELETE FROM customers
WHERE customerNumber IN (770, 880);

SELECT * FROM customer_contact;
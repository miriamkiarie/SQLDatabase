use classicmodels;
-- Question 1 : What is the total number of orders placed in the year 2005?
-- Question 2 : Find the names and contact information (city, country) 
-- of all customers from Germany who have placed orders with a total amount exceeding $500.
-- Question 3 : Find the product line with the highest average order quantity.
-- Question 4 : How many different employee offices are there in the database?
-- Question 5 : Find the names of all employees who manage at least one employee 
-- who has completed more orders than the average number of orders per employee.
-- Question 6 : Find the total number of orders placed between the first day of the current month and today's date.
-- Question 7 : List all products with a price exceeding $100. 
-- Include an additional column indicating "High Price" for these products and "Low Price" for products with a price of $100 or less.
-- Question 8 : Find the product with the most orders placed in total.
-- Question 9 : Find the top 5 customer cities (by city name) with the highest total order amounts.


-- Question 1 : What is the total number of orders placed in the year 2005?
Select* from orders;
SELECT COUNT(*) AS TotalOrders
FROM Orders
WHERE YEAR(OrderDate) = 2005;

-- Question 2 : Find the names and contact information (city, country)
-- of all customers from Germany who have placed orders with a total amount exceeding $500.

SELECT c.CustomerNumber, c.CustomerName, c.City, c.Country
FROM Customers c
JOIN Orders o ON c.CustomerNumber = o.CustomerNumber
JOIN (
    SELECT CustomerNumber, SUM(Ordernumber) AS TotalAmount
    FROM Orders
    GROUP BY CustomerNumber
    HAVING SUM(ordernumber) > 500
) sub ON c.CustomerNumber = sub.CustomerNumber
WHERE c.Country = 'Germany'

-- Question 3 : Find the product line with the highest average order quantity.
SELECT  max(productline)
FROM OrderDetails
JOIN Products 
ON orderdetails.ProductCode =products.productcode
GROUP BY ProductLine
ORDER BY AVG(orderdetails.Quantityordered) DESC
LIMIT 1;

-- Question 4 : How many different employee offices are there in the database?
SELECT COUNT(DISTINCT Officecode) AS DifferentOffices
FROM Employees;

-- Question 5 : Find the names of all employees who manage at least one employee
-- who has completed more orders than the average number of orders per employee.
 select firstName,lastName
from employees where
employeeNumber in 
 (select distinct e.reportsTo from 
 Employees e join Customers c
 on e.reportsTo = c.salesRepEmployeeNumber);
 
-- Question 6 : Find the total number of orders placed between the first day of the current month and today's date.
select* from orders;
SELECT COUNT(*) AS TotalOrders
FROM Orders
WHERE OrderDate BETWEEN DATE_FORMAT(NOW(), '%Y-%m-01') AND CURDATE();

-- Question 7 : List all products with a price exceeding $100.
-- Include an additional column indicating "High Price" for these products and "Low Price" for products with a price of $100 or less.
Select* from products;
SELECT ProductCode, ProductName, buyPrice,
    CASE
        WHEN buyPrice > 100 THEN 'High Price'
        ELSE 'Low Price'
    END AS PriceCategory
FROM Products
WHERE buyPrice > 100 OR buyPrice = 100;

-- Question 8 : Find the product with the most orders placed in total.
select* from products;
Select * from Orderdetails;
SELECT Productcode, COUNT(*) AS TotalOrders
FROM OrderDetails
GROUP BY Productcode
ORDER BY TotalOrders DESC
LIMIT 1;

-- Question 9 : Find the top 5 customer cities (by city name) with the highest total order amounts.
Select* from customers;
Select * from orderdetails;
Select * from orders;
sELECT c.City, SUM(quantityordered*priceeach) AS TotalOrderAmount
FROM Customers c
JOIN Orders o ON c.CustomerNumber = o.CustomerNumber
join orderdetails od
on o.ordernumber = od.ordernumber
GROUP BY c.City
ORDER BY TotalOrderAmount DESC
LIMIT 5;
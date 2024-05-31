Use classicmodels;



-- Question 1: Create a view named high_value_customers that lists the customer number, customer name, and total order amount for customers who have placed orders exceeding $10,000.
Select* from orders;
Select * from orderdetails;
Select * from Customers;
Create view high_value_customers AS
Select c.CustomerNumber, c.CustomerName, SUM(priceeach*Quantityordered) AS TotalOrderAmount
From  Customers c
Join  Orders o 
On c.CustomerNumber = o.CustomerNumber
join orderdetails od
on o.ordernumber=od.ordernumber

GROUP BY c.CustomerNumber, c.CustomerName
HAVING TotalOrderAmount > 10000;
Drop view high_value_customers;
-- Question 2: Find the names of customers who have placed orders for products from the 'Classic Cars' product line.
select* from customers;
select *from orders;
select*from products;
select* from productline;
Select  distinct Customers.customername,products.productline
From customers
Join Orders
on customers.customernumber=orders.customernumber
join orderdetails
on orders.ordernumber=orderdetails.ordernumber
join products 
on orderdetails.productcode=products.productcode
where products.productline='classic Cars';
-- Question 3: List the employees who work in the office with the maximum number of employees.
Select* from employees;
SELECT e.EmployeeID, e.EmployeeName, e.OfficeCode
FROM Employees e
JOIN (
    Select  Offices, COUNT(*) as NumEmployees
    From Employees
   group by Office
    Order by NumEmployees desc
    Limit 1
) as max_office on e.Office = max_office.Office;
-- Question 4: Write a stored procedure named get_customer_orders that takes a customer number as input and returns the order numbers and order dates for that customer.
DELIMITER //

CREATE PROCEDURE get_customer_orders (IN customerNumber INT)
BEGIN
    SELECT OrderNumber, OrderDate
    FROM Orders
    WHERE CustomerID = customerNumber;
END //

DELIMITER ;

-- Question 5: Write a stored procedure named total_sales_by_employee that takes an employee number as input and returns the total sales amount for that employee.
DELIMITER //

CREATE PROCEDURE total_sales_by_employee (IN empNumber INT)
BEGIN
    SELECT SUM(Amount) AS TotalSales
    FROM Orders
    WHERE EmployeeID = empNumber;
END //

DELIMITER ;

-- Question 6: Use a CTE to find the top 3 employees by the number of customers they manage.
Select * from employees;
SELECT * FROM Customers;
WITH EmployeeCustomerCount AS (
    SELECT SalesrepEmployeeNumber, COUNT(DISTINCT CustomerNumber) AS NumCustomers
    FROM Orders
    GROUP BY SalesrepEmployeeNumber
)
SELECT e.EmployeeNumber, e.EmployeeName, ecc.NumCustomers
FROM Employees e
JOIN EmployeeCustomerCount ecc 
ON e.EmployeeNumber = ecc.SalesrepEmployeeNumber
ORDER BY ecc.NumCustomers DESC
LIMIT 3;
-- Question 7: Use a CTE to find the average payment amount for each customer and list those with an average payment greater than $2000.
Select * from customers;
SELECT * from Payments;
WITH AvgPaymentPerCustomer AS (
    SELECT CustomerNumber, AVG(Amount) AS AvgPayment
    FROM Payments
    GROUP BY CustomerNumber
)
SELECT c.CustomerNumber, c.CustomerName, ap.AvgPayment
FROM Customers c
JOIN AvgPaymentPerCustomer ap 
ON c.CustomerNumber= ap.CustomerNumber
WHERE ap.AvgPayment > 2000;
-- Question 8: Create a union query that lists all customer names and employee names.
select * from employees;
SELECT *from customers;
SELECT Customername AS Name
FROM Customers

UNION

SELECT FirstName AS Name
FROM Employees;
-- Question 9: Write a union query to list all office cities and customer cities, making sure there are no duplicates.
SELECT City AS Location
FROM Offices

UNION

SELECT City AS Location
FROM Customers;
-- Question 10: Create a union query that lists all product codes from the orderdetails table along with the respective order number and indicates whether it is from the 'Classic Cars' or 'Motorcycles' product line.
Select* from orderdetails;
SELECT orderdetails.OrderNumber, products.ProductCode, 'Classic Cars' AS ProductLine
FROM OrderDetails
JOIN Products ON OrderDetails.ProductCode= Products.Productcode
WHERE Products.ProductLine = 'Classic Cars'

UNION

SELECT orderdetails.OrderNumber, products.ProductCode, 'Motorcycles' AS ProductLine
FROM OrderDetails
JOIN Products ON OrderDetails.Productcode = Products.Productcode
WHERE Products.ProductLine = 'Motorcycles';
-- Aggregations
-- Select 
-- Conditions
-- joins

Use salesdb;

-- Calculate the average quantity

select avg(Quantity) as Average_Quantity from Sales;

-- Calculate the number of sales made
-- count of sales (how many sales)
select count(*) as No_of_Sales from Sales;

-- Calculate the maximum quantity sold
select max(Quantity) as Max_Qty from Sales;

-- Calculate the minimum quantity sold
select min(Quantity) as Min_Qty from Sales;

-- Calculate the total sales made
select Sales.Quantity,Products.Price,(Sales.Quantity * Products.Price)
from Sales 
join Products on Sales.ProductID = Products.ProductID;
select sum(Quantity * Price) as Tot_Sales
from Sales 
join Products on Sales.ProductID = Products.ProductID;

-- Calculate the Total Sales Amount by Customer
SELECT CustomerID, SUM(Quantity) AS TotalSalesAmount
FROM Sales
GROUP BY CustomerID;

-- Calculate the Total Quantity Sold by Product
SELECT Products.ProductID, SUM(Quantity) AS TotalQuantitySold
FROM Products
JOIN sales
On Products.ProductID=Sales.ProductID
GROUP BY ProductID;

-- Calculate the Average Quantity Sold per Customer
SELECT Customers.CustomerID, AVG(Quantity) AS AvgQuantitySoldPerCustomer
FROM Customers
Join sales
on Customers.CustomerID=Sales.CustomerID
GROUP BY CustomerID;


-- Customers with Total Sales Amount Greater Than $1500

SELECT Customers.CustomerID, SUM(quantity*price) AS TotalSalesAmount
FROM Customers
join Sales
on Customers.CustomerID=Sales.CustomerID
Join Products
on Sales.productID=Products.ProductID
Group  by customerID
HAVING TotalSalesAmount > 1500;
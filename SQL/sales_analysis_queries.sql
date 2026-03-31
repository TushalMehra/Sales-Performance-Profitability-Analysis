-- ==========================================
-- Sales Data Analysis Project
-- Dataset: Superstore Sales
-- Author: Tushar Mehra
-- Database: sales_data_analysis
-- ==========================================

USE sales_data_analysis;

-- ==========================================
-- 1. Data Exploration
-- ==========================================

-- Preview dataset
SELECT *
FROM Sales_Data
LIMIT 10;

-- Count total records
SELECT COUNT(*) AS total_rows
FROM sales_data;

-- View columns
SELECT *
FROM sales_data
LIMIT 1;

-- Unique categories
SELECT DISTINCT Category
FROM sales_data;

-- Unique regions
SELECT DISTINCT Region
FROM sales_data;


-- ======================================
-- 2. DATA QUALITY CHECKS
-- ======================================

-- Check NULL values
SELECT *
FROM sales_data
WHERE Sales IS NULL
   OR Profit IS NULL;

-- Check duplicate orders
SELECT `Order ID`, COUNT(*)
FROM sales_data
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

-- Orders with negative profit
SELECT *
FROM sales_data
WHERE Profit < 0;


-- ======================================
-- 3. FILTERING AND SORTING
-- ======================================

-- Orders with sales above 500
SELECT *
FROM sales_data
WHERE Sales > 500;

-- Top 10 highest sales
SELECT `Customer Name`, Sales
FROM sales_data
ORDER BY Sales DESC
LIMIT 10;

-- Lowest profit orders
SELECT `Customer Name`, Profit
FROM sales_data
ORDER BY Profit ASC
LIMIT 10;

-- ======================================
-- 4. AGGREGATION ANALYSIS
-- ======================================

-- Total sales
SELECT SUM(Sales) AS total_sales
FROM sales_data;

-- Average profit
SELECT AVG(Profit) AS avg_profit
FROM sales_data;

-- Maximum sale
SELECT MAX(Sales) AS highest_sale
FROM sales_data;

-- Minimum profit
SELECT MIN(Profit) AS lowest_profit
FROM sales_data;

-- ======================================
-- 5. GROUP BY ANALYSIS
-- ======================================

-- Sales by category

SELECT Category,
       SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Category;


-- Profit by region

SELECT Region,
       SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Region;

-- Orders by state

SELECT State,
       COUNT(*) AS total_orders
FROM sales_data
GROUP BY State
ORDER BY total_orders DESC;

-- ======================================
-- 6. BUSINESS INSIGHTS
-- ======================================

-- Top 10 customers by sales

SELECT `Customer Name`,
       SUM(Sales) AS total_sales
FROM sales_data
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;


-- Top 5 states by revenue

SELECT State,
       SUM(Sales) AS total_sales
FROM sales_data
GROUP BY State
ORDER BY total_sales DESC
LIMIT 5;

-- Most profitable category

SELECT Category,
       SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Category
ORDER BY total_profit DESC;

-- ======================================
-- 7. TIME SERIES ANALYSIS
-- ======================================

-- Monthly sales

SELECT MONTH(`Order Date`) AS month,
       SUM(Sales) AS monthly_sales
FROM sales_data
GROUP BY month
ORDER BY month;

-- Yearly sales

SELECT YEAR(`Order Date`) AS year,
       round(SUM(Sales),2) AS yearly_sales
FROM sales_data
GROUP BY year;

-- ======================================
-- 8. SUBQUERY ANALYSIS
-- ======================================

-- Orders above average sales

SELECT *
FROM sales_data
WHERE Sales >
(
SELECT AVG(Sales)
FROM sales_data
);

-- ======================================
-- 9. WINDOW FUNCTIONS
-- ======================================

-- Rank customers by total sales

SELECT `Customer Name`,
       SUM(Sales) AS total_sales,
       Rank() OVER(ORDER BY SUM(Sales) DESC) AS sales_rank
FROM sales_data
GROUP BY `Customer Name`;

-- ======================================
-- 10. RUNNING TOTAL
-- ======================================

SELECT `Order Date`,
       SUM(Sales) AS daily_sales,
       SUM(SUM(Sales)) OVER(ORDER BY `Order Date`) AS running_total
FROM sales_data
GROUP BY `Order Date`;


-- ======================================
-- 11. CTE ANALYSIS
-- ======================================

-- Top 10 customers by sales

WITH CustomerSales AS
(
SELECT `Customer Name`,
       SUM(Sales) AS total_sales
FROM sales_data
GROUP BY `Customer Name`
)

SELECT *
FROM CustomerSales
ORDER BY total_sales DESC
LIMIT 10;






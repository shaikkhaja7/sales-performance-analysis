-- 1. Total Sales
SELECT SUM(sales) AS total_sales
FROM sales;

-- 2. Total Profit
SELECT SUM(profit) AS total_profit
FROM sales;

-- 3. Total Quantity Sold
SELECT SUM(quantity) AS total_quantity
FROM sales;

-- 4. Total Number of Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM sales;

-- 5. Average Order Value
SELECT SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM sales;
-- 6. Monthly Sales Trend
SELECT
  DATE_TRUNC('month', order_date) AS month,
  SUM(sales) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY month;

-- 7. Monthly Profit Trend
SELECT
  DATE_TRUNC('month', order_date) AS month,
  SUM(profit) AS monthly_profit
FROM sales
GROUP BY month
ORDER BY month;

-- 8. Yearly Sales
SELECT
  EXTRACT(YEAR FROM order_date) AS year,
  SUM(sales) AS yearly_sales
FROM sales
GROUP BY year
ORDER BY year;
-- 9. Sales by Region
SELECT region, SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- 10. Profit by Region
SELECT region, SUM(profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_profit DESC;

-- 11. Sales by Category
SELECT category, SUM(sales) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- 12. Profit by Category
SELECT category, SUM(profit) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_profit DESC;
-- 13. Top 10 Products by Sales
SELECT product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 14. Top 10 Products by Profit
SELECT product_name, SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- 15. Products with Loss (Negative Profit)
SELECT product_name, SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;
-- 16. Average Discount by Category
SELECT category, AVG(discount) AS avg_discount
FROM sales
GROUP BY category;

-- 17. Profit by Discount Level
SELECT discount, SUM(profit) AS total_profit
FROM sales
GROUP BY discount
ORDER BY discount;

-- 18. High Discount Orders (Above 30%)
SELECT *
FROM sales
WHERE discount > 0.30;
-- 19. Sales by Customer Segment
SELECT segment, SUM(sales) AS total_sales
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;

-- 20. Profit by Customer Segment
SELECT segment, SUM(profit) AS total_profit
FROM sales
GROUP BY segment
ORDER BY total_profit DESC;
-- 21. Rank Regions by Sales
SELECT
  region,
  SUM(sales) AS total_sales,
  RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM sales
GROUP BY region;

-- 22. Running Total of Sales (Monthly)
SELECT
  DATE_TRUNC('month', order_date) AS month,
  SUM(sales) AS monthly_sales,
  SUM(SUM(sales)) OVER (ORDER BY DATE_TRUNC('month', order_date)) AS running_total
FROM sales
GROUP BY month
ORDER BY month;
-- 23. Orders with Loss
SELECT order_id, SUM(profit) AS order_profit
FROM sales
GROUP BY order_id
HAVING SUM(profit) < 0;

-- 24. Average Profit per Order
SELECT AVG(order_profit) AS avg_profit_per_order
FROM (
  SELECT order_id, SUM(profit) AS order_profit
  FROM sales
  GROUP BY order_id
) sub;

-- 25. Percentage Contribution of Each Category to Total Sales
SELECT
  category,
  SUM(sales) AS category_sales,
  ROUND(
    SUM(sales) * 100.0 / (SELECT SUM(sales) FROM sales),
    2
  ) AS sales_percentage
FROM sales
GROUP BY category
ORDER BY sales_percentage DESC;

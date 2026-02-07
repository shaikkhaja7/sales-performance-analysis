-- Total Sales, Profit, Orders
SELECT
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit,
  COUNT(DISTINCT order_id) AS total_orders
FROM sales;

-- Monthly Sales Trend
SELECT
  DATE_TRUNC('month', order_date) AS month,
  SUM(sales) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY month;

-- Sales by Region
SELECT region, SUM(sales) AS total_sales
FROM sales
GROUP BY region;

-- Top 10 Products
SELECT product_name, SUM(sales) AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;

-- Discount vs Profit
SELECT discount, SUM(profit) AS total_profit
FROM sales
GROUP BY discount
ORDER BY discount;

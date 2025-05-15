
-- 1. Basic Selection and Filtering
SELECT * FROM public."Superstore" LIMIT 10;
SELECT * FROM public."Superstore" WHERE order_date >= '2017-01-01' AND order_date <= '2017-12-31';

-- 2. Aggregate Functions
SELECT SUM(sales) AS total_sales FROM public."Superstore";
SELECT AVG(discount) AS average_discount FROM public."Superstore";

-- 3. Grouping and Aggregation
SELECT category, SUM(sales) AS total_sales FROM public."Superstore" GROUP BY category ORDER BY total_sales DESC;
SELECT region, AVG(profit) AS avg_profit FROM public."Superstore" GROUP BY region;

-- 4. Example JOIN (hypothetical case)
-- SELECT o.order_id, c.customer_name, o.sales FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 5. Subqueries
SELECT customer_name, SUM(sales) AS total_sales
FROM public."Superstore"
GROUP BY customer_name
HAVING SUM(sales) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT customer_name, SUM(sales) AS total_sales
        FROM public."Superstore"
        GROUP BY customer_name
    ) AS sub
);

-- 6. Views for Analysis
CREATE OR REPLACE VIEW monthly_sales AS
SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) AS total_sales
FROM public."Superstore"
GROUP BY month
ORDER BY month;

-- 7. Query Optimization with Indexes
CREATE INDEX idx_order_date ON public."Superstore"(order_date);
CREATE INDEX idx_customer_id ON public."Superstore"(customer_id);

-- 8. Handling NULLs
SELECT COALESCE(profit, 0) AS adjusted_profit FROM public."Superstore";
SELECT COUNT(*) AS null_discount_count FROM public."Superstore" WHERE discount IS NULL;

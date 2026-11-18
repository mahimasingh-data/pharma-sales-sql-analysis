--Query 1: Which drug category has the highest total sales?
SELECT ROUND(SUM(M01AB),0) AS M01AB, ROUND(SUM(M01AE),0) AS M01AE, ROUND(SUM(N02BA),0) AS N02BA, ROUND(SUM(N02BE),0) AS N02BE, ROUND(SUM(N05B),0) AS N05B, ROUND(SUM(N05C),0) AS N05C, ROUND(SUM(R03),0) AS R03, ROUND(SUM(R06),0) AS R06
FROM sales;
-- Query 2: Month-over-month growth in N02BE sales
SELECT Sales_Date, N02BE AS sales,
LAG(N02BE) OVER (ORDER BY Sales_Date) AS prev_month,
ROUND((N02BE - LAG(N02BE) OVER (ORDER BY Sales_Date)) * 100.0 / LAG(N02BE) OVER (ORDER BY Sales_Date), 1) AS growth_pct
FROM sales;
-- Query 3: Biggest monthly increases in N02BE (Jan 2017 excluded as a data gap)
WITH growth AS (
SELECT Sales_Date, N02BE AS sales,
ROUND((N02BE - LAG(N02BE) OVER (ORDER BY Sales_Date)) * 100.0 / LAG(N02BE) OVER (ORDER BY Sales_Date), 1) AS growth_pct
FROM sales
WHERE Sales_Date <> '2017-01-31'
)
SELECT * FROM growth
WHERE growth_pct IS NOT NULL
ORDER BY growth_pct DESC
LIMIT 5;
-- Query 4: Biggest monthly drops in N02BE (Jan 2017 excluded as a data gap)
WITH growth AS (
SELECT Sales_Date, N02BE AS sales,
ROUND((N02BE - LAG(N02BE) OVER (ORDER BY Sales_Date)) * 100.0 / LAG(N02BE) OVER (ORDER BY Sales_Date), 1) AS growth_pct
FROM sales
WHERE Sales_Date <> '2017-01-31'
)
SELECT * FROM growth
WHERE growth_pct IS NOT NULL
ORDER BY growth_pct ASC
LIMIT 5;
-- Query 5: Data gap check around January 2017
SELECT * FROM sales
WHERE Sales_Date BETWEEN '2016-11-30' AND '2017-03-31';
-- Query 6: Share of total sales by drug category
WITH totals AS (
SELECT 'M01AB' AS category, SUM(M01AB) AS total FROM sales
UNION ALL SELECT 'M01AE', SUM(M01AE) FROM sales
UNION ALL SELECT 'N02BA', SUM(N02BA) FROM sales
UNION ALL SELECT 'N02BE', SUM(N02BE) FROM sales
UNION ALL SELECT 'N05B', SUM(N05B) FROM sales
UNION ALL SELECT 'N05C', SUM(N05C) FROM sales
UNION ALL SELECT 'R03', SUM(R03) FROM sales
UNION ALL SELECT 'R06', SUM(R06) FROM sales
)
SELECT category, ROUND(total, 0) AS total_sales,
ROUND(total * 100.0 / SUM(total) OVER (), 1) AS share_pct,
RANK() OVER (ORDER BY total DESC) AS rank_no
FROM totals
ORDER BY rank_no;
WITH monthly_sales AS (
    SELECT
        p.category,
        EXTRACT(MONTH FROM s.date) AS month,
        EXTRACT(YEAR FROM s.date) AS year,
        SUM(s.quantity * s.price) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY p.category, EXTRACT(YEAR FROM s.date), EXTRACT(MONTH FROM s.date) ORDER BY EXTRACT(YEAR FROM s.date), EXTRACT(MONTH FROM s.date)) AS rn
    FROM
        product p
    INNER JOIN
        sale s ON p.id = s.product_id
    GROUP BY
        p.category, EXTRACT(YEAR FROM s.date), EXTRACT(MONTH FROM s.date)
),
lagged_sales AS (
    SELECT
        category,
        month,
        year,
        total_sales,
        LAG(total_sales) OVER (PARTITION BY category ORDER BY year, month) AS previous_month_sales
    FROM
        monthly_sales
)
SELECT
    category,
    month,
    total_sales,
    CASE
        WHEN previous_month_sales IS NULL THEN 100.0
        ELSE ROUND(((total_sales - previous_month_sales) / previous_month_sales) * 100, 2)
    END AS growth_percentage
FROM
    lagged_sales
ORDER BY
    category, year, month;
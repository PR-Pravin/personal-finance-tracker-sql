-- ============================================================
-- File: Analytics Queries
-- Description: Insights & Reporting Queries
-- ============================================================


-- ============================================================
-- 1. Monthly Expense Trend
-- ============================================================
SELECT 
    MONTH(date) AS month,
    SUM(amount) AS total_expense
FROM expenses
WHERE user_id = 1
GROUP BY MONTH(date)
ORDER BY month;


-- ============================================================
-- 2. Savings & Savings Percentage (Correct Calculation)
-- ============================================================
SELECT 
    u.name,
    i.total_income,
    IFNULL(e.total_expense, 0) AS total_expense,
    (i.total_income - IFNULL(e.total_expense, 0)) AS savings,
    ROUND(
        ((i.total_income - IFNULL(e.total_expense, 0)) / i.total_income) * 100,
        2
    ) AS savings_percentage
FROM users u
JOIN (
    SELECT user_id, SUM(amount) AS total_income
    FROM income
    GROUP BY user_id
) i ON u.user_id = i.user_id
LEFT JOIN (
    SELECT user_id, SUM(amount) AS total_expense
    FROM expenses
    GROUP BY user_id
) e ON u.user_id = e.user_id
WHERE u.user_id = 1;


-- ============================================================
-- 3. Top Spending Category
-- ============================================================
SELECT 
    category,
    SUM(amount) AS total_spent
FROM expenses
WHERE user_id = 1
GROUP BY category
ORDER BY total_spent DESC
LIMIT 1;
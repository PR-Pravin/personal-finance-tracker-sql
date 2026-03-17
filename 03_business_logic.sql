-- ============================================================
-- Project: Personal Finance Tracker (MySQL)
-- File: Business Logic (Views, Procedures, Triggers)
-- Description: Contains analytical views, stored procedures,
--              and triggers for enforcing business rules.
-- ============================================================


-- ============================================================
-- 1. View: Monthly Summary
-- Provides total income, expenses, and savings per user
-- ============================================================
CREATE OR REPLACE VIEW monthly_summary AS
SELECT 
    u.user_id,
    u.name,
    (SELECT IFNULL(SUM(amount),0) FROM income WHERE user_id = u.user_id) AS total_income,
    (SELECT IFNULL(SUM(amount),0) FROM expenses WHERE user_id = u.user_id) AS total_expense,
    (
        (SELECT IFNULL(SUM(amount),0) FROM income WHERE user_id = u.user_id)
        -
        (SELECT IFNULL(SUM(amount),0) FROM expenses WHERE user_id = u.user_id)
    ) AS savings
FROM users u;

-- View data
SELECT * FROM monthly_summary;


-- ============================================================
-- 2. Stored Procedure: MonthlyReport
-- Generates income, expense, and savings for a given user,
-- month, and year
-- ============================================================
DELIMITER //

CREATE PROCEDURE MonthlyReport(
    IN uid INT,
    IN m INT,
    IN y INT
)
BEGIN
    DECLARE total_income DECIMAL(10,2) DEFAULT 0;
    DECLARE total_expense DECIMAL(10,2) DEFAULT 0;

    -- Calculate total income
    SELECT IFNULL(SUM(amount),0)
    INTO total_income
    FROM income
    WHERE user_id = uid
      AND MONTH(date) = m
      AND YEAR(date) = y;

    -- Calculate total expense
    SELECT IFNULL(SUM(amount),0)
    INTO total_expense
    FROM expenses
    WHERE user_id = uid
      AND MONTH(date) = m
      AND YEAR(date) = y;

    -- Return final report
    SELECT 
        u.user_id,
        u.name,
        total_income AS total_income,
        total_expense AS total_expense,
        (total_income - total_expense) AS savings
    FROM users u
    WHERE u.user_id = uid;

END //

DELIMITER ;

-- Execute procedure (example)
CALL MonthlyReport(1, 3, 2026);


-- ============================================================
-- 3. Trigger: Budget Alert
-- Prevents expenses from exceeding the defined budget
-- ============================================================
DELIMITER //

CREATE TRIGGER budget_alert
AFTER INSERT ON expenses
FOR EACH ROW
BEGIN
    DECLARE total_spent DECIMAL(10,2) DEFAULT 0;
    DECLARE budget_limit DECIMAL(10,2) DEFAULT 0;

    -- Calculate total spending for the category in given month
    SELECT IFNULL(SUM(amount),0)
    INTO total_spent
    FROM expenses
    WHERE user_id = NEW.user_id
      AND category = NEW.category
      AND MONTH(date) = MONTH(NEW.date)
      AND YEAR(date) = YEAR(NEW.date);

    -- Fetch budget limit
    SELECT IFNULL(limit_amount,0)
    INTO budget_limit
    FROM budget
    WHERE user_id = NEW.user_id
      AND category = NEW.category
      AND month = MONTH(NEW.date)
      AND year = YEAR(NEW.date)
    LIMIT 1;

    -- Validate budget constraint
    IF total_spent > budget_limit AND budget_limit > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Budget Exceeded!';
    END IF;

END //

DELIMITER ;


-- ============================================================
-- 4. Testing & Verification Queries (Optional)
-- ============================================================

-- Check trigger existence
SHOW TRIGGERS;

-- View user expenses
SELECT * FROM expenses WHERE user_id = 1;

-- View user budget
SELECT * FROM budget
WHERE user_id = 1 AND category = 'Food';

-- Check total spending
SELECT SUM(amount) AS total_spent
FROM expenses
WHERE user_id = 1
  AND category = 'Food'
  AND MONTH(date) = 3
  AND YEAR(date) = 2026;

-- Test trigger (within budget)
INSERT INTO expenses(user_id, amount, category, date)
VALUES (1, 2000, 'Food', '2026-03-05');

-- Verify insert
SELECT * FROM expenses WHERE user_id = 1;

-- Test trigger (exceed budget)
INSERT INTO expenses(user_id, amount, category, date)
VALUES (1, 9000, 'Food', '2026-03-10');
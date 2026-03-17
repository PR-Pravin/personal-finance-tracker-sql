-- ============================================================
-- Project: Personal Finance Tracker (MySQL)
-- File: Sample Data Insertion
-- Description: Inserts demo data for users, income, expenses,
--              and budget tables for testing and analysis.
-- ============================================================


-- ============================================================
-- 1. Insert Data into Users Table
-- ============================================================
INSERT INTO users (name, email) VALUES
('Pravin', 'pravin@email.com'),
('Arun', 'arun@gmail.com'),
('Karthik', 'karthik@gmail.com'),
('Meena', 'meena@gmail.com'),
('Divya', 'divya@gmail.com');


-- ============================================================
-- 2. Insert Data into Income Table
-- ============================================================
INSERT INTO income (user_id, amount, source, date) VALUES
(1, 50000, 'Salary', '2026-03-01'),
(1, 5000, 'Freelance', '2026-03-10'),
(2, 60000, 'Salary', '2026-03-01'),
(3, 45000, 'Salary', '2026-03-01'),
(4, 70000, 'Business', '2026-03-05');


-- ============================================================
-- 3. Insert Data into Expenses Table
-- Categorized spending for each user
-- ============================================================
INSERT INTO expenses (user_id, amount, category, date) VALUES
(1, 5000, 'Food', '2026-03-05'),
(1, 2000, 'Travel', '2026-03-06'),
(1, 3000, 'Shopping', '2026-03-08'),
(2, 4000, 'Food', '2026-03-04'),
(2, 1500, 'Bills', '2026-03-07'),
(3, 6000, 'Travel', '2026-03-09'),
(3, 2500, 'Food', '2026-03-11'),
(4, 7000, 'Shopping', '2026-03-03'),
(4, 3000, 'Bills', '2026-03-12'),
(5, 3500, 'Food', '2026-03-15');


-- ============================================================
-- 4. Insert Data into Budget Table
-- Defines monthly budget limits per category
-- ============================================================
INSERT INTO budget (user_id, category, limit_amount, month, year) VALUES
(1, 'Food', 10000, 3, 2026),
(1, 'Travel', 5000, 3, 2026),
(2, 'Food', 8000, 3, 2026),
(3, 'Travel', 7000, 3, 2026),
(4, 'Shopping', 12000, 3, 2026);


-- ============================================================
-- 5. Verification Queries (Optional - For Testing)
-- ============================================================

-- View all users
SELECT * FROM users;

-- View all income records
SELECT * FROM income;

-- View all expense records
SELECT * FROM expenses;

-- View all budget records
SELECT * FROM budget;
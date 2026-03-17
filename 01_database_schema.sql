-- ============================================================
-- Project: Personal Finance Tracker (MySQL)
-- Description: Database schema for managing users, income,
--              expenses, and budget tracking.
-- Author: Pravin
-- ============================================================


-- ============================================================
-- 1. Create Database
-- ============================================================
CREATE DATABASE IF NOT EXISTS personal_finance_db;

-- Select the database
USE personal_finance_db;


-- ============================================================
-- 2. Users Table
-- Stores user basic information
-- ============================================================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 3. Income Table
-- Stores all income transactions of users
-- ============================================================
CREATE TABLE income (
    income_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(10,2) NOT NULL,
    source VARCHAR(100),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- ============================================================
-- 4. Expenses Table
-- Stores all expense transactions categorized by type
-- ============================================================
CREATE TABLE expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(10,2) NOT NULL,
    category VARCHAR(50),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- ============================================================
-- 5. Budget Table
-- Defines monthly budget limits per category
-- ============================================================
CREATE TABLE budget (
    budget_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category VARCHAR(50),
    limit_amount DECIMAL(10,2),
    month INT,
    year INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- ============================================================
-- 6. Indexes (Performance Optimization)
-- Improves query speed for frequent searches
-- ============================================================

-- Index on income table for faster user-based queries
CREATE INDEX idx_income_user ON income(user_id);

-- Index on expenses table for faster user-based queries
CREATE INDEX idx_expense_user ON expenses(user_id);
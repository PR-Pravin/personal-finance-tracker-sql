# 💰 Personal Finance Tracker (MySQL)

A structured SQL-based system for managing and analyzing personal financial data, including income, expenses, and budgeting. This project demonstrates strong database design, optimized queries, and implementation of real-world business logic using MySQL.

---

## 📌 Features

* Track and manage **income and expenses**
* Maintain **category-based budgets**
* Generate **monthly financial reports**
* Calculate **savings and savings percentage**
* Identify **top spending categories**
* Enforce **budget constraints using triggers**
* Perform **analytical queries for insights**

---

## 🏗️ Database Design

### Core Tables

* `users` – Stores user information
* `income` – Records income transactions
* `expenses` – Stores expense details
* `budget` – Defines monthly category limits

---

## ⚙️ Technologies Used

* MySQL
* SQL (DDL, DML, DQL)
* Stored Procedures
* Triggers
* Views

---

## 📂 Project Structure

```
personal-finance-tracker-sql/
│
├── 01_schema.sql              # Database & table definitions
├── 02_sample_data.sql         # Sample dataset
├── 03_business_logic.sql      # Views, procedures, triggers
├── 04_analytics_queries.sql   # Reporting & analysis queries
```

---

## 📊 Key Components

### 🔹 View

* `monthly_summary`
  Provides total income, expenses, and savings per user

### 🔹 Stored Procedure

* `get_monthly_report(user_id, month, year)`
  Generates monthly financial summary for a user

### 🔹 Trigger

* `trg_budget_check`
  Prevents inserting expenses beyond defined budget limits

---

## 📈 Sample Queries

* Monthly expense trends
* Savings and savings percentage
* Top spending category

---

## 🚀 How to Run

1. Create schema and tables

   ```
   SOURCE 01_schema.sql;
   ```

2. Insert sample data

   ```
   SOURCE 02_sample_data.sql;
   ```

3. Load business logic

   ```
   SOURCE 03_business_logic.sql;
   ```

4. Execute analytics queries

   ```
   SOURCE 04_analytics_queries.sql;
   ```

---

## 🧠 Learning Outcomes

* Database normalization principles
* Writing optimized SQL queries
* Effective use of joins and aggregations
* Implementing constraints using triggers
* Designing real-world reporting systems

---

## 🎯 Project Objective

To demonstrate **entry-level software engineering skills** with a focus on database design, backend logic, and data-driven analysis using SQL.

---

## 👨‍💻 Author

**Pravin**
Aspiring Software Engineer

---

## ⭐ Future Enhancements

* Frontend dashboard (React / HTML)
* Backend integration (Java / Node.js)
* Data visualization (charts & reports)
* User authentication system

---

⭐ Feel free to fork, explore, and star this repository!

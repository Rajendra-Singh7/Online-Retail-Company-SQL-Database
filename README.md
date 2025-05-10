# Online Retail Database (SQL Server Project)

## Overview

This project simulates the core database operations of a fictional online retail company using SQL Server. It demonstrates relational database design, data insertion, reporting and analytics queries, triggers for logging changes, and performance optimization through indexes. The project is ideal for showcasing SQL skills in a data analyst portfolio.

---

## Features

- **Database Design:** Normalized schema for Customers, Products, Orders, OrderItems, and Categories.
- **Sample Data:** Realistic sample data for all tables to enable meaningful analysis.
- **Business Queries:** 20+ reporting and analysis queries, including aggregations, joins, CTEs, and subqueries.
- **Triggers & Logging:** Automated logging of data changes (INSERT, UPDATE, DELETE) on key tables.
- **Indexes:** Performance optimization with clustered and non-clustered indexes.
- **Modular Scripts:** Well-organized, reusable scripts for each step.

---

## Project Structure

```
Online-Retail-Company-SQL-Database/
├── README.md
├── schema/
│   ├── create_database.sql         # Create the database
│   ├── create_tables.sql           # Create all tables (including ChangeLog)
│   ├── insert_sample_data.sql      # Populate tables with sample data
│   ├── create_views.sql            # (Optional) Create useful SQL views
│   └── create_indexes.sql          # Create indexes for optimization
├── queries/
│   ├── reporting_queries.sql       # Standard business/reporting queries
│   └── analysis_queries.sql        # Deeper analysis/insight queries
├── triggers/
│   └── triggers_and_logging.sql    # Triggers for logging changes
└── LICENSE
```

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Rajendra-Singh7/Online-Retail-Company-SQL-Database.git
cd Online-Retail-Company-SQL-Database
```

### 2. Set Up the Database

1. Open SQL Server Management Studio (SSMS) or your preferred SQL client.
2. Run the scripts in the following order:
   - `schema/create_database.sql`
   - `schema/create_tables.sql`
   - `schema/insert_sample_data.sql`
   - `schema/create_views.sql` 
   - `schema/create_indexes.sql`
   - `triggers/triggers_and_logging.sql`

### 3. Explore the Data

- Use the queries in `queries/reporting_queries.sql` and `queries/analysis_queries.sql` to explore and analyze the data.

---

## Example Queries

**Reporting Queries:**
- Total sales for each product
- Average order value
- Orders per month
- Customers by country
- Out-of-stock products

**Analysis Queries:**
- Top 5 customers by spending
- Most popular product category
- Customers who never placed an order
- Top 3 most frequently ordered products
- Orders with more than a specified number of items

---

## Logging & Triggers

- All INSERT, UPDATE, and DELETE operations on `Products` and `Customers` are automatically logged in the `ChangeLog` table via triggers.
- The `ChangeLog` table records the table name, operation, record ID, timestamp, and user.

---

## Indexing

- Clustered indexes are created automatically on primary keys.
- Additional non-clustered indexes are provided on commonly queried columns (e.g., `Email`, `Country`, `CategoryID`, `OrderDate`) to improve query performance.

---

## Requirements

- SQL Server (2016 or later recommended)
- SQL Server Management Studio (SSMS) or compatible client

---

## How to Use This Project in Your Portfolio

- Demonstrates end-to-end SQL skills: schema design, data loading, reporting, analytics, triggers, and optimization.
- Well-documented and modular, making it easy to showcase or extend.
- Use screenshots or sample outputs from your queries in your portfolio or resume.

---

## Contributing

Contributions and suggestions are welcome! Please open an issue or submit a pull request.


## Author

- [Your Name](https://github.com/Rajendra-Singh7)

---

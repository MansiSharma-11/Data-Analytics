<div align="center">

# 📚 Library Management System

### A Full-Stack SQL Project — Database Design · Automation · Business Analytics

<img src="SQL Projects/Project 2/erd.png" alt="Library Management System ERD" width="850">

<br>

![SQL](https://img.shields.io/badge/SQL-Database-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-RDBMS-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Data Analysis](https://img.shields.io/badge/Data%20Analysis-SQL-2ea44f?style=for-the-badge)
![Portfolio](https://img.shields.io/badge/Project-Portfolio-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-success?style=for-the-badge)

</div>

---

## 🧭 Table of Contents

- [Overview](#-project-overview)
- [Business Objectives](#-business-objectives)
- [Database Schema](#️-database-schema)
- [Tech Stack](#-tech-stack)
- [SQL Skills Demonstrated](#-sql-skills-demonstrated)
- [Business Problems Solved](#-business-problems-solved)
- [Stored Procedures](#️-stored-procedures)
- [Reports Generated](#-reports-generated)
- [Project Structure](#-project-structure)
- [Key Learnings](#-key-learnings)
- [Author](#-author)

---

## 📌 Project Overview

The **Library Management System** is an end-to-end SQL database project built to streamline how a multi-branch library tracks books, members, employees, and transactions.

It goes beyond simple table design — the project implements **automated workflows via stored procedures**, **revenue and performance analytics**, and **operational reports** that a real library could use to make data-driven decisions.

**The system manages:**

| 🗂️ Module | Description |
|---|---|
| 📖 Book Inventory | Tracks every title, category, author, and availability status |
| 👥 Member Records | Stores registration, contact, and activity history |
| 🏢 Branch Operations | Links employees and managers to specific branches |
| 👨‍💼 Employee Management | Tracks staff, roles, and productivity |
| 🔄 Issue & Return Tracking | Logs every checkout and return transaction |
| 💰 Revenue Analysis | Calculates rental income by category and branch |

---

## 🎯 Business Objectives

- Maintain accurate, centralized records of books, members, employees, and branches
- Track which books are issued, returned, or overdue in real time
- Automate book issuance and returns through stored procedures
- Detect overdue books and flag inactive vs. active members
- Measure rental revenue and book demand across categories
- Generate branch-level and employee-level performance reports

---

## 🏗️ Database Schema

Six interconnected tables form the relational backbone of this system:

| Table | Purpose | Key Fields |
|---|---|---|
| `branch` | Stores library branch information | `branch_id`, `manager_id`, `branch_address`, `contact_no` |
| `employees` | Maintains employee records | `emp_id`, `emp_name`, `position`, `salary`, `branch_id` |
| `members` | Member registration details | `member_id`, `member_name`, `member_address`, `reg_date` |
| `books` | Library inventory | `isbn`, `book_title`, `category`, `rental_price`, `status`, `author`, `publisher` |
| `issued_status` | Issued-book transactions | `issued_id`, `issued_member_id`, `issued_book_isbn`, `issued_date`, `issued_emp_id` |
| `return_status` | Returned-book transactions | `return_id`, `issued_id`, `return_date`, `book_quality` |

### 🔗 Entity Relationships

```
branch  1 ──── * employees
members 1 ──── * issued_status
books   1 ──── * issued_status
issued_status 1 ──── 1 return_status
```

> One branch has many employees → employees process many issues → each issue maps to one return.

---

## 🧰 Tech Stack

`SQL` · `PostgreSQL` · `MySQL Stored Procedures` · `RDBMS Design` · `Data Analysis` · `Git & GitHub`

---

## 🚀 SQL Skills Demonstrated

<table>
<tr>
<td valign="top" width="33%">

**🏛️ Database Design**
- `CREATE DATABASE`
- `CREATE TABLE`
- Primary & Foreign Keys
- Constraints

</td>
<td valign="top" width="33%">

**✍️ Data Manipulation**
- `INSERT`
- `UPDATE`
- `DELETE`
- `SELECT`

</td>
<td valign="top" width="33%">

**📊 Advanced SQL**
- `JOIN` (Inner / Left)
- `GROUP BY` / `HAVING`
- Aggregate Functions
- Subqueries · `CTAS`

</td>
</tr>
</table>

**Database Programming:** Stored Procedures · Conditional Logic (`IF / ELSEIF`) · Business Rule Automation

---

## 📊 Business Problems Solved

Each task below maps to a real query in [`librarymanagementsystem.sql`](librarymanagementsystem.sql).

| # | Business Problem | SQL Concepts Applied |
|---|---|---|
| 1 | Add new book records to inventory | `INSERT`, data validation |
| 2 | Update member contact information | `UPDATE` |
| 3 | Remove obsolete issue transactions | `DELETE` |
| 4 | Retrieve books issued by a specific employee | `WHERE`, filtering |
| 5 | Find members who issued more than one book | `GROUP BY`, `HAVING`, `COUNT()` |
| 6 | Build a book-demand summary table | `CTAS`, aggregation |
| 7 | Calculate rental revenue by category | `SUM()`, `GROUP BY` |
| 8 | Detect overdue books (30-day rule) | Date arithmetic, `JOIN`, business logic |
| 9 | Generate branch performance reports | Multi-table `JOIN`, aggregation |
| 10 | Rank employees by issues processed | Aggregation, ranking |
| 11 | Flag members registered in the last 180 days | Date filtering |
| 12 | List employees with their branch manager | Self-`JOIN` |
| 13 | Identify high-value books (rental price threshold) | `CTAS`, filtering |
| 14 | List books not yet returned | `LEFT JOIN`, `NULL` checks |

<details>
<summary>📝 <b>Click to see a featured query — Overdue Book Detection</b></summary>

```sql
SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    CURRENT_DATE - ist.issued_date AS over_due_days
FROM issued_status AS ist
JOIN members AS m ON m.member_id = ist.issued_member_id
JOIN books AS bk ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status AS rs ON rs.issued_id = ist.issued_id
WHERE rs.return_date IS NULL
  AND (CURRENT_DATE - ist.issued_date) > 30
ORDER BY 1;
```

This query flags every book still checked out **30+ days** after issuance, joining across three tables to surface the member, the book, and how overdue it is.

</details>

---

## ⚙️ Stored Procedures

### 🔁 `add_return_records()` — Automated Return Processing
Handles the full return lifecycle in a single call:
1. Inserts the new record into `return_status`
2. Looks up the book's ISBN and title from `issued_status`
3. Updates the book's status back to `'yes'` (available)
4. Returns a friendly confirmation message

```sql
CALL add_return_records('RS138', 'IS135', 'Good');
```

### 📕 `IssueBook()` — Automated Issue Processing with Error Handling
Before issuing a book, the procedure checks real-time availability:
- ✅ If available → updates status to `'no'` and confirms success
- ❌ If already issued → returns *"Book is currently not available"*
- ⚠️ If the ISBN doesn't exist → returns a not-found error

```sql
CALL library.IssueBook('101', @response_msg);
SELECT @response_msg;
```

---

## 📈 Reports Generated

| Report | What It Shows |
|---|---|
| 📚 **Book Demand Report** | Most frequently borrowed titles |
| 👥 **Active Members Report** | Members who borrowed a book in the last 2 months |
| ⏰ **Overdue Books Report** | Books past the 30-day return window |
| 🏢 **Branch Performance Report** | Books issued, returned, and revenue per branch |
| 👨‍💼 **Employee Performance Report** | Top employees ranked by issues processed |

---

## 🏆 Project Highlights

- ✔ Designed a normalized relational database with 6 interconnected tables
- ✔ Implemented complete CRUD operations across all tables
- ✔ Built **2 stored procedures** to automate issue/return workflows with error handling
- ✔ Created **5 analytical reports** answering real library business questions
- ✔ Applied advanced SQL — `JOIN`s, `GROUP BY`, `HAVING`, `CTAS`, aggregations, subqueries
- ✔ Solved 14+ real-world data problems end to end, from raw inserts to executive reporting

---

## 📂 Project Structure

```text
Library-Management-System/
│
├── README.md
├── librarymanagementsystem.sql
│
└── ERD/
    └── erd.png
```

---

## 💡 Key Learnings

Through this project, I gained hands-on experience in:

- Relational database design & data modeling
- Writing and optimizing complex multi-table queries
- Translating business questions into SQL logic
- Building stored procedures with conditional, error-aware logic
- Producing analytics-ready reporting tables
- Managing transactional data integrity across a live schema

---

## 👩‍💻 Author

<div align="center">

### Mansi Sharma
**Aspiring Data Analyst · SQL Enthusiast · Excel & Power BI Learner · Cyber Security Enthusiast**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mansi-sharma-3894a8339/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/MansiSharma11)

</div>

---

<div align="center">

⭐ **If you found this project useful, consider giving it a star!** ⭐

</div>

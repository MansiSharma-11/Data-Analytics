<div align="center">

# 📚 Student AI Usage Analysis
### SQL Business Intelligence Project

*Understanding how Generative AI is reshaping the university learning experience*

![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sqlite&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)

</div>

---

## 📌 Project Overview

This SQL Business Intelligence project analyzes how university students use Generative AI tools — such as **ChatGPT**, **Gemini**, **Copilot**, and other AI assistants — throughout their academic journey.

The project explores the relationship between **AI adoption, academic performance, study behavior, prompt engineering skills, institutional policies, and student well-being** through structured SQL analysis.

The objective is to demonstrate practical SQL skills while answering real-world business questions that educational institutions, researchers, and policymakers face regarding AI adoption in higher education.

---

## 🎯 Business Problem

With Generative AI becoming an integral part of education, institutions need to understand:

- 📊 How frequently do students use AI?
- 📈 Does AI usage improve academic performance?
- 🎓 Which academic disciplines rely most on AI?
- 🔗 What's the relationship between AI usage and GPA?
- 🏛️ How do institutional policies influence AI adoption?
- ✍️ How proficient are students at prompt engineering?
- 📅 How does AI usage trend across different academic years?

This project answers these questions using SQL-based Business Intelligence techniques.

---

## 📂 Dataset Information

The dataset contains information about students and their interaction with Generative AI tools.

| Attribute | Description |
|---|---|
| `Student_ID` | Unique identifier for each student |
| `Year_of_Study` | Academic year (1st–4th year, etc.) |
| `Major_Category` | Student's field of study |
| `Primary_Use_Case` | Main purpose of AI usage |
| `Weekly_GenAI_Hours` | Hours spent using AI tools per week |
| `Pre_Semester_GPA` | GPA before semester |
| `Post_Semester_GPA` | GPA after semester |
| `Prompt_Engineering_Skill` | Self-rated prompting skill level |
| `Paid_Subscription` | Whether the student pays for an AI tool |
| `Institutional_Policy` | AI policy in effect at the student's institution |
| `Anxiety_Level_During_Exams` | Self-reported exam anxiety |
| `Burnout_Risk_Level` | Self-reported burnout risk |

---

## 🛠️ Tools & Technologies

![MySQL](https://img.shields.io/badge/MySQL-005C84?style=flat-square&logo=mysql&logoColor=white)
![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-00618A?style=flat-square&logo=mysql&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)

---

## 📊 SQL Concepts Used

This project demonstrates:

- `SELECT`, `WHERE`, `ORDER BY`
- `GROUP BY` with Aggregate Functions
- `COUNT()`, `AVG()`, `ROUND()`
- `CASE WHEN` conditional logic
- `UNION`
- Subqueries
- Business KPI design

---

## 📈 Business Questions Solved

### Beginner Level
- Count total students in the dataset
- Calculate average academic performance
- Analyze primary AI use cases
- Measure average weekly AI usage
- Study distribution across academic disciplines

### Intermediate Level
- Which academic discipline has the highest AI adoption?
- Does AI usage improve academic performance?
- Compare AI users vs. non-AI users
- Impact of paid AI subscriptions on GPA
- Burnout risk analysis
- Institutional policy vs. AI usage
- AI adoption trends across academic years

---

## 📌 Sample SQL Analysis

**Total Students**
```sql
SELECT COUNT(*) AS Total_Students
FROM impact_of_ai_on_student;
```

**Average Weekly AI Usage**
```sql
SELECT
    ROUND(AVG(Weekly_GenAI_Hours), 2) AS Avg_AI_Hours
FROM impact_of_ai_on_student;
```

**AI Usage vs. Academic Performance**
```sql
SELECT
    CASE
        WHEN Weekly_GenAI_Hours < 5 THEN 'Low Usage'
        WHEN Weekly_GenAI_Hours BETWEEN 5 AND 10 THEN 'Moderate Usage'
        ELSE 'High Usage'
    END AS Usage_Level,
    ROUND(AVG(Post_Semester_GPA), 2) AS Average_GPA
FROM impact_of_ai_on_student
GROUP BY Usage_Level;
```

---

## 📊 Key Insights

- 🎓 Students from different academic disciplines show varying levels of AI adoption
- 📈 Higher AI usage is associated with differences in academic performance
- ✍️ Prompt engineering skills vary significantly depending on students' primary AI use cases
- 🏛️ Institutional AI policies influence weekly AI usage
- 💳 Paid AI subscribers demonstrate different usage patterns compared to free users
- 😰 Burnout risk and anxiety levels can be analyzed alongside AI usage habits

---

## 📁 Repository Structure

```
Student-AI-Usage-SQL/
│
├── Dataset/
│   └── impact_of_ai_on_student.csv
│
├── SQL/
│   ├── Database_Creation.sql
│   ├── Beginner_Queries.sql
│   ├── Intermediate_Queries.sql
│   └── Advanced_Queries.sql
│
├── Images/
│   ├── ER_Diagram.png
│   ├── Query1.png
│   ├── Query2.png
│   └── ...
│
└── README.md
```

---

## 💼 Skills Demonstrated

`SQL Query Writing` · `Business Intelligence` · `Data Aggregation` · `KPI Analysis` · `Analytical Thinking` · `Educational Data Analytics` · `Data Exploration` · `Data Interpretation`

---

## 📚 Learning Outcomes

Through this project, I strengthened my understanding of:

- Writing optimized SQL queries
- Performing exploratory data analysis using SQL
- Translating business questions into SQL queries
- Extracting actionable insights from educational datasets
- Presenting analytical findings for decision-making

---

## 🚀 Future Improvements

- [ ] Add Window Functions (`RANK()`, `ROW_NUMBER()`, `DENSE_RANK()`)
- [ ] Implement Common Table Expressions (CTEs)
- [ ] Create SQL Views for KPI reporting
- [ ] Develop interactive Power BI dashboards
- [ ] Build predictive models using Python

---

## 👩‍💻 Author

**Mansi Sharma**
*Aspiring Data Analyst | Business Intelligence Analyst | SQL Developer*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mansi-sharma-3894a8339/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/MansiSharma11)

---

<div align="center">

⭐ **If you found this project useful, consider giving it a star!** ⭐

</div>

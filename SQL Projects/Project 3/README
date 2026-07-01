📚 Student AI Usage Analysis | SQL Business Intelligence Project

📌 Project Overview

This SQL Business Intelligence project analyzes how university students use Generative AI tools such as ChatGPT, Gemini, Copilot, and other AI assistants in their academic journey.

The project explores the relationship between AI adoption, academic performance, study behavior, prompt engineering skills, institutional policies, and student well-being through structured SQL analysis.

The objective is to demonstrate practical SQL skills while answering real-world business questions that educational institutions, researchers, and policymakers may face regarding AI adoption in higher education.

🎯 Business Problem

With Generative AI becoming an integral part of education, institutions need to understand:

How frequently students use AI?
Whether AI improves academic performance
Which academic disciplines rely most on AI?
The relationship between AI usage and GPA?
How institutional policies influence AI adoption?
Student prompt engineering proficiency
AI usage trends across different academic years

This project answers these questions using SQL-based Business Intelligence techniques.

📂 Dataset Information

The dataset contains information about students and their interaction with Generative AI.

Main Attributes

Student ID
Year of Study
Major Category
Primary Use Case
Weekly GenAI Hours
Pre Semester GPA
Post Semester GPA
Prompt Engineering Skill
Paid Subscription
Institutional Policy
Anxiety Level During Exams
Burnout Risk Level


🛠️ Tools & Technologies
MySQL
SQL
MySQL Workbench
Git & GitHub

📊 SQL Concepts Used
This project demonstrates:

SELECT
WHERE
ORDER BY
GROUP BY
Aggregate Functions
COUNT()
AVG()
ROUND()
CASE WHEN
UNION
Subqueries
Business KPIs

📈 Business Questions Solved
                    
Beginner Level
Count total students in the dataset
Calculate average academic performance
Analyze primary AI use cases
Measure average weekly AI usage
Study distribution across academic disciplines
Intermediate Level
Which academic discipline has the highest AI adoption?
Does AI usage improve academic performance?
Compare AI users vs non-AI users
Impact of paid AI subscriptions on GPA
Burnout risk analysis
Institutional policy vs AI usage
AI adoption across academic years

📌 Sample SQL Analysis

Total Students
SELECT COUNT(*) AS Total_Students
FROM impact_of_ai_on_student;
Average Weekly AI Usage
SELECT
ROUND(AVG(Weekly_GenAI_Hours),2) AS Avg_AI_Hours
FROM impact_of_ai_on_student;
AI Usage vs Academic Performance
SELECT

CASE
WHEN Weekly_GenAI_Hours < 5 THEN 'Low Usage'
WHEN Weekly_GenAI_Hours BETWEEN 5 AND 10 THEN 'Moderate Usage'
ELSE 'High Usage'
END AS Usage_Level,

ROUND(AVG(Post_Semester_GPA),2) AS Average_GPA

FROM impact_of_ai_on_student

GROUP BY Usage_Level;

📊 Key Insights
Students from different academic disciplines show varying levels of AI adoption.
Higher AI usage is associated with differences in academic performance.
Prompt engineering skills vary significantly depending on students' primary AI use cases.
Institutional AI policies influence weekly AI usage.
Paid AI subscribers demonstrate different usage patterns compared to free users.
Burnout risk and anxiety levels can be analyzed alongside AI usage habits.

📁 Repository Structure
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
├── README.md

💼 Skills Demonstrated
SQL Query Writing
Business Intelligence
Data Aggregation
KPI Analysis
Analytical Thinking
Educational Data Analytics
Data Exploration
Data Interpretation

📚 Learning Outcomes

Through this project, I strengthened my understanding of:

Writing optimized SQL queries
Performing exploratory data analysis using SQL
Translating business questions into SQL queries
Extracting actionable insights from educational datasets
Presenting analytical findings for decision-making

🚀 Future Improvements
Add Window Functions (RANK(), ROW_NUMBER(), DENSE_RANK())
Implement Common Table Expressions (CTEs)
Create SQL Views for KPI reporting
Develop interactive Power BI dashboards
Build predictive models using Python

👩‍💻 Author
Mansi Sharma
Aspiring Data Analyst | Business Intelligence Analyst | SQL Developer

Connect with me
LinkedIn: https://www.linkedin.com/in/mansi-sharma-3894a8339/
GitHub: https://github.com/MansiSharma11

⭐ If you found this project useful, consider giving it a star!

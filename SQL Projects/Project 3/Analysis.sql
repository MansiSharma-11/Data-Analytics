-- STEP 1
-- CREATE DATABASE student;  -- Database Creation
-- USE student;                 -- USE DATABASE student

-- SELECT * FROM impact_of_ai_on_student;

-- STEP 2 BEGINNERS QUESTIONS
-- Q1) How many students are present in the dataset? (Count total students)
-- Q2) What is the average academic performance of students? (Average GPA/Score)
-- Q3)According to the primary AI use case, what prompt engineering skill levels do students have?
-- Q4) What is the average number of hours spent using AI per week? (Weekly AI usage)
-- Q5) How are students distributed across different fields of study? (Engineering, Business, Arts, etc.)

-- Q1) How many students are present in the dataset? (Count total students)
SELECT COUNT(*) AS Total_Students 
FROM impact_of_ai_on_student;

-- Q2)  What is the average academic performance of students? (Average GPA/Score)
SELECT
    Year_of_Study,
    ROUND(AVG(Pre_Semester_GPA),2) AS Avg_Pre_GPA,
    ROUND(AVG(Post_Semester_GPA),2) AS Avg_Post_GPA
FROM impact_of_ai_on_student
GROUP BY Year_of_Study
ORDER BY Year_of_Study;

-- Q3) According to the primary AI use case, what prompt engineering skill levels do students have?
SELECT
    Primary_Use_Case,
    Prompt_Engineering_Skill,
    COUNT(*) AS Total_Students
FROM impact_of_ai_on_student
GROUP BY
    Primary_Use_Case,
    Prompt_Engineering_Skill
ORDER BY
    Primary_Use_Case,
    Total_Students DESC;


-- Q4) What is the average number of hours spent using AI per week? (Weekly AI usage)
SELECT
    ROUND(AVG(Weekly_GenAI_Hours),2) AS Average_Weekly_AI_Hours
FROM impact_of_ai_on_student;

-- Q5) How are students distributed across different fields of study? (Engineering, Business, Arts, etc.)
SELECT
    Major_Category,
    COUNT(*) AS Total_Students
FROM impact_of_ai_on_student
GROUP BY Major_Category
ORDER BY Total_Students DESC;


-- STEP 3 INTERMEDIATE QUESTIONS
-- Q6) Which academic discipline has the highest AI adoption rate? (Business Insight: Identify departments most influenced by AI.)
-- Q7) Do students who use AI more frequently achieve higher academic performance? (Business Insight: Measure relationship between AI usage and grades.)
-- Q8) Compare academic performance between AI users and non-AI users. (Business Insight: Evaluate effectiveness of AI tools.)
-- Q9) Which AI tool is associated with the highest average GPA? Business Insight: Determine which platform contributes most to learning outcomes.
-- Q10) What percentage of students use AI daily, weekly, and occasionally? Business Insight: Understand usage behavior.
-- Q11) Which institutions have the highest average AI usage? Business Insight: Compare universities and colleges.
-- Q12) How does AI usage vary across academic years? Business Insight: Freshman vs Senior adoption patterns.


-- Q6) Which academic discipline has the highest AI adoption rate? (Business Insight: Identify departments most influenced by AI.)

SELECT
    Major_Category,
    ROUND(AVG(Weekly_GenAI_Hours),2) AS Avg_AI_Hours
FROM impact_of_ai_on_student
GROUP BY Major_Category
ORDER BY Avg_AI_Hours DESC;

-- Q7) Do students who use AI more frequently achieve higher academic performance? (Business Insight: Measure relationship between AI usage and grades.)

SELECT

CASE
    WHEN Weekly_GenAI_Hours < 5 THEN 'Low Usage'
    WHEN Weekly_GenAI_Hours BETWEEN 5 AND 10 THEN 'Moderate Usage'
    ELSE 'High Usage'
END AS AI_Usage_Level,

ROUND(AVG(Post_Semester_GPA - Pre_Semester_GPA),2) AS GPA_Improvement

FROM impact_of_ai_on_student

GROUP BY AI_Usage_Level

ORDER BY GPA_Improvement DESC;

-- Q8) Compare academic performance between AI users and non-AI users. (Business Insight: Evaluate effectiveness of AI tools.)

SELECT

CASE
    WHEN Weekly_GenAI_Hours > 0 THEN 'AI User'
    ELSE 'Non-AI User'
END AS User_Type,

COUNT(*) AS Students,

ROUND(AVG(Post_Semester_GPA),2) AS Average_GPA

FROM impact_of_ai_on_student

GROUP BY User_Type;

-- Q9) Which paid AI tool is associated with the highest average GPA? Business Insight: Determine which platform  is paid subscription contributes most to learning outcomes.

SELECT

Paid_Subscription,

COUNT(*) AS Students,

ROUND(AVG(Post_Semester_GPA),2) AS Average_GPA,

ROUND(AVG(Weekly_GenAI_Hours),2) AS Average_AI_Hours

FROM impact_of_ai_on_student

GROUP BY Paid_Subscription

ORDER BY Average_GPA DESC;
-- Q10) What percentage of students use AI AVG weekly and AVG Anxiety_Level_During_Exams and Burnout_Risk_Level

SELECT

Burnout_Risk_Level,

COUNT(*) AS Students,

ROUND(
COUNT(*) * 100.0 /
(SELECT COUNT(*) FROM impact_of_ai_on_student),2
) AS Percentage

FROM impact_of_ai_on_student

GROUP BY Burnout_Risk_Level

ORDER BY Percentage DESC;

-- Q11) Which major_category have the highest average AI usage with Institutional_Policy is strict_an ? 

SELECT

Major_Category,

ROUND(AVG(Weekly_GenAI_Hours),2) AS Average_AI_Hours

FROM impact_of_ai_on_student

WHERE Institutional_Policy='Strict_Ban'

GROUP BY Major_Category

ORDER BY Average_AI_Hours DESC;

-- Q12) How does AI usage vary across academic years? Business Insight: Freshman vs Senior adoption patterns.

SELECT

Year_of_Study,

COUNT(*) AS Students,

ROUND(AVG(Weekly_GenAI_Hours),2) AS Average_AI_Hours

FROM impact_of_ai_on_student

GROUP BY Year_of_Study

ORDER BY Year_of_Study;








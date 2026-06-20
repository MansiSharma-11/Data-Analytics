-- STEP 2 PROJECT TASKS 


-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;


-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '456 Main Street'
WHERE member_id = 'C101';


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id = 'IS134';


-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_member_id , count(issued_id)
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(issued_member_id)>1 
ORDER BY COUNT(issued_id) DESC;

-- STEP 3 CTAS (Create Table As Select)
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

CREATE TABLE summary  -- -- ctas syntax is this thus it creates a table 
AS                      
SELECT 
b.isbn,
b.book_title,
count(ist.issued_id) as no_issued
FROM 
books AS b
JOIN 
issued_status AS ist
ON 
ist.issued_book_isbn = b.isbn
GROUP BY 1,2;

select * from summary;

-- STEP 4 DATA ANALYSIS & FINDINGS
-- Task 7. Retrieve All Books in a Specific Category
SELECT * FROM books 
WHERE category = 'Fantasy';

-- Task 8: Find Total Rental Income by Category:
SELECT 
    b.category,
    SUM(b.rental_price) AS total_rental_income,
    COUNT(i.issued_id) AS total_books_rented
FROM issued_status i
JOIN books b 
    ON i.issued_book_isbn = b.isbn
GROUP BY b.category
ORDER BY total_rental_income DESC;

-- Task 9: List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL 180 DAY;

 
-- Task 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT e1.*,
b.manager_id,
e2.emp_name as manager
FROM employees as e1
JOIN
branch as b
ON b.branch_id = e1.branch_id
JOIN
employees as e2
ON b.manager_id = e2.emp_id;


-- Task 11: Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE books_7
AS 
SELECT * FROM books
WHERE rental_price>7;
SELECT * FROM books_7;

-- Task 12: Retrieve the List of Books Not Yet Returned:
SELECT DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;



## Advanced SQL Operations

-- Task 13: Identify Members with Overdue Books:
-- Write a query to identify members who have overdue books (assume a 30-day return period).
-- Display the member's id, member's name, book title, issue date, and days overdue

SELECT CURRENT_DATE;
SELECT ist.issued_member_id,
m.member_name,
bk.book_title,
ist.issued_date,
	CURRENT_DATE - ist.issued_date as over_dues_days
FROM issued_status as ist
JOIN
members as m
	ON m.member_id = ist.issued_member_id
JOIN 
books as bk
ON bk.isbn = ist.issued_book_isbn
LEFT JOIN 
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE 
	rs.return_date IS NULL
	AND  
    (CURRENT_DATE - ist.issued_date ) > 30
ORDER BY 1;

-- Task 14: Update Book Status on Return:
-- Write a query to update the status of books in the books table to "Yes" when they are returned
 -- (based on entries in the return_status table).

SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-451-52994-2';

SELECT * FROM books
WHERE isbn = '978-0-451-52994-2';

UPDATE books
SET status = 'no'
WHERE isbn = '978-0-451-52994-2';

SELECT * FROM return_status
WHERE issued_id = 'IS130';

INSERT INTO return_status(return_id, issued_id, return_date, book_quality)
VALUES
('RS125', 'IS130', CURRENT_DATE, 'Good');
SELECT * FROM return_status
WHERE issued_id = 'IS130';


-- Stored Procedure
DELIMITER $$

CREATE PROCEDURE add_return_records(
    IN p_return_id VARCHAR(10), 
    IN p_issued_id VARCHAR(10), 
    IN p_book_quality VARCHAR(10)
)
BEGIN
    -- Declare variables at the very beginning of the BEGIN block
    DECLARE v_isbn VARCHAR(50);
    DECLARE v_book_name VARCHAR(80);

    -- 1. Insert into return_status table
    INSERT INTO return_status(return_id, issued_id, return_date, book_quality) 
    VALUES (p_return_id, p_issued_id, CURDATE(), p_book_quality);

    -- 2. Fetch ISBN and Book Name from issued_status
    SELECT issued_book_isbn, issued_book_name 
    INTO v_isbn, v_book_name 
    FROM issued_status 
    WHERE issued_id = p_issued_id;

    -- 3. Update the books status to 'yes'
    UPDATE books 
    SET status = 'yes' 
    WHERE isbn = v_isbn;

    -- 4. Output a confirmation message (MySQL replacement for RAISE NOTICE)
    SELECT CONCAT('Thank you for returning the book: ', v_book_name) AS Message;

END$$

DELIMITER ;


-- Testing Verification
SELECT * FROM books WHERE isbn = '978-0-307-58837-1';
SELECT * FROM issued_status WHERE issued_book_isbn = '978-0-307-58837-1';

-- Call the MySQL Procedure
CALL add_return_records('RS138', 'IS135', 'Good');
CALL add_return_records('RS148', 'IS140', 'Good');

-- Double-check the status updates
SELECT * FROM return_status WHERE issued_id = 'IS135';
SELECT * FROM books WHERE isbn = '978-0-307-58837-1';

-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued,
-- the number of books returned, and the total revenue generated from book rentals.

SELECT * FROM branch;

SELECT * FROM issued_status;

SELECT * FROM employees;

SELECT * FROM books;

SELECT * FROM return_status;

CREATE TABLE branch_report               -- CTAS
AS
SELECT 
b.branch_id,
b.manager_id,
COUNT(ist.issued_id) as number_books_issued,
COUNT(rs.return_id) as number_of_book_return,
SUM(bk.rental_price) as total_revenue
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
LEFT JOIN 
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1,2;

SELECT * FROM branch_report;          

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
-- containing members who have issued at least one book in the last 2 months.

CREATE TABLE active_members AS 
SELECT * 
FROM members 
WHERE member_id IN (
    SELECT DISTINCT issued_member_id 
    FROM issued_status 
    WHERE issued_date >= CURRENT_DATE - INTERVAL 2 MONTH
);
SELECT * FROM active_members;

-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. 
-- Display the employee name, number of books processed, and their branch.

SELECT 
e.emp_name,
b.*,
COUNT(ist.issued_id) as book_issued
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
GROUP BY 1,2;

/*
Task 18: Stored Procedure Objective: 

Create a stored procedure to manage the status of books in a library system. 

Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 

The procedure should function as follows: 

The stored procedure should take the book_id as an input parameter. 

The procedure should first check if the book is available (status = 'yes'). 

If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 

If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/


DROP PROCEDURE IF EXISTS library.IssueBook;

DELIMITER //

CREATE PROCEDURE library.IssueBook(
    IN p_isbn VARCHAR(20),       -- Changed to match the varchar(20) type of isbn
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_status VARCHAR(15) DEFAULT NULL; -- Changed to match varchar(15) of status

    -- Check the status using the correct 'isbn' column
    SELECT status INTO v_status
    FROM library.books
    WHERE isbn = p_isbn;

    -- Evaluation logic
    IF v_status IS NULL THEN
        SET p_message = 'Error: Book ID does not exist.';
    ELSEIF v_status = 'yes' THEN
        UPDATE library.books SET status = 'no' WHERE isbn = p_isbn;
        SET p_message = 'Success: Book has been successfully issued.';
    ELSE
        SET p_message = 'Error: The book is currently not available.';
    END IF;
END //

DELIMITER ;
-- 1. Run the call using a valid ISBN string from your table
CALL library.IssueBook('101', @response_msg);

-- 2. Check the message output
SELECT @response_msg;

-- End of my SQL project

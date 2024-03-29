1. How many books have been borrowed in total in the last three months?

SELECT 
COUNT(borrowID) AS "total borrows" 
FROM checkout;

OUTPUT
654

2. How many books were borrowed each month?

SELECT 
MONTH(borrow_date) AS "month", 
COUNT(borrowID) AS "total borrows" 
FROM checkout
GROUP BY MONTH(borrow_date)
ORDER BY MONTH(borrow_date);

OUTPUT
December - 83
January - 166
February - 405

3. How many users of the reading room are students of the school?

SELECT 
is_student, 
COUNT(userID) AS "sum" 
FROM users 
GROUP BY is_student;

OUTPUT
students - 150
others - 122

4. Who borrows more books, students or people outside the school?

SELECT
is_student,
SUM(no_borrowed_books) AS "borrows"
FROM users 
JOIN accounts ON users.userID = accounts.userID
GROUP BY is_student;

OUTPUT
uczniowie - 356
osoby spoza szkoły - 303

5. How many men and women use the library?

SELECT
gender,
COUNT(gender) AS "total"
FROM users
GROUP BY gender;

OUTPUT
men - 137
women - 135

6. How many books were borrowed by men and how many by women?

SELECT
gender,
SUM(no_borrowed_books) AS "total"
FROM accounts
JOIN users ON accounts.userID = users.userID
GROUP BY gender;

OUTPUT
women - 314
men - 345

7. How many books of what genre are currently in the library?

SELECT
genre,
COUNT(genre) AS "total"
FROM books 
GROUP BY genre
ORDER BY COUNT(genre) DESC;

OUTPUT
literatura piękna - 117
dramat komedia tragedia - 41
klasyka - 49
fantasy science-fiction - 117
powieść młodzieżowa - 36
powieść historyczna - 9
literatura faktu biografia autobiografia - 10
kryminał sensacja thriller - 48
poezja - 14
horror - 7
literatura obyczajowa romans - 18

8. What genres of books are most often borrowed?

SELECT
genre,
COUNT(genre) AS "total"
FROM books
JOIN checkout ON books.bookID = checkout.bookID 
GROUP BY genre
ORDER BY COUNT(genre) DESC;

9. Which author's books are most often borrowed?

SELECT
CONCAT_WS(" ", author_firstName, author_lastName) AS "authors name",
COUNT(checkout.bookID) AS "total"
FROM books
JOIN checkout ON books.bookID = checkout.bookID
GROUP BY author_firstName, author_lastName
ORDER BY COUNT(checkout.bookID) DESC;

10. Which publisher's books are most frequently borrowed?

SELECT
publisher,
COUNT(checkout.bookID) AS "total"
FROM books
JOIN checkout ON books.bookID = checkout.bookID
GROUP BY publisher
ORDER BY COUNT(checkout.bookID) DESC;

11. Which readers borrowed the most books?

SELECT 
CONCAT_WS(" ", user_firstName, user_lastName) AS "users name",
no_borrowed_books AS "number of books"
FROM users 
JOIN accounts ON users.userID = accounts.userID
ORDER BY no_borrowed_books DESC;

12. What books were supposed to be delivered by 2023-03-01 and were not?
What email address should I send a message requesting the return of books?

SELECT 
(SELECT email FROM accounts WHERE accounts.accountID = checkout.accountID) AS "email",
(SELECT title FROM books WHERE books.bookID = checkout.bookID) AS "title",
checkout.borrow_date AS "borrow date",
checkout.return_date AS "return date"
FROM checkout
LEFT JOIN book_returns ON checkout.borrowID = book_returns.borrowID
WHERE book_returns.bookID IS NULL AND checkout.return_date < "2023-03-01";


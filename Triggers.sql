--- books (is_available) ---
--- if bookID is going to checkout than switch boolean to FALSE ---

DELIMITER $$

CREATE TRIGGER set_unavailable
AFTER INSERT ON checkout FOR EACH ROW
	BEGIN 
		IF NEW.bookID > 0
		THEN
			UPDATE books SET is_available = '0' WHERE books.bookID = NEW.bookID;
		END IF;
	END;
$$

DELIMITER ;


------------------------------------------------------------------------------------------
--- books (is_available) ---
--- if bookID is goint to return than switch boolean to TRUE ---

DELIMITER $$

CREATE TRIGGER set_available
AFTER INSERT ON book_returns FOR EACH ROW
	BEGIN 
		IF NEW.bookID > 0
		THEN
			UPDATE books SET is_available = '1' WHERE books.bookID = NEW.bookID;
		END IF;
	END;
$$

DELIMITER ;


------------------------------------------------------------------------------------------
--- accounts (no_borrowed_books) ---
--- if account borrows a book than add +1 to counter of borrowed books ---

DELIMITER $$

CREATE TRIGGER borrowed_books_counter
AFTER INSERT ON checkout FOR EACH ROW
	BEGIN
		IF NEW.bookID > 0
		THEN
		UPDATE accounts SET no_borrowed_books = no_borrowed_books + 1 WHERE accounts.accountID = NEW.accountID;
		END IF;
	END;
$$

DELIMITER ;


------------------------------------------------------------------------------------------
--- accounts (no_returned_books) ---
--- if account returns a book than add +1 to counter of returned books ----

DELIMITER $$

CREATE TRIGGER returned_books_counter
AFTER INSERT ON book_returns FOR EACH ROW
	BEGIN 
		IF NEW.bookID > 0
		THEN 
		UPDATE accounts SET no_returned_books = no_returned_books + 1 WHERE accounts.accountID = NEW.accountID;
		END IF;
	END;
$$

DELIMITER ;


------------------------------------------------------------------------------------------

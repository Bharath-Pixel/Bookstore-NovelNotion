package model;

import java.sql.*;

public class AdminBookDAO {

	
    public boolean insertBook(Book book) {
        try {
        	Connection conn = DBConnection.getConnection();
            String query = "INSERT INTO books (book_title, author, ISBN, description, publisher, publication_date, quantity, rating, genre, price, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setString(3, book.getISBN());
            statement.setString(4, book.getDescription());
            statement.setString(5, book.getPublisher());
            statement.setDate(6, book.getPublicationDate());
            statement.setInt(7, book.getQuantity());
            statement.setInt(8, book.getRating());
            statement.setString(9, book.getGenre());
            statement.setDouble(10, book.getPrice());
            statement.setString(11, book.getImage());
            statement.setInt(12, book.getId());

            // Execute the update query
            int rowsUpdated = statement.executeUpdate();

            // Close the statement
            statement.close();

            // Return true if the update was successful
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error (you may want to throw an exception or log the error here)
            return false;
        }
    }
    
    public boolean updateBook(Book book) {
        try {
            Connection conn = DBConnection.getConnection();
            String query = "UPDATE books SET book_title = ?, author = ?, ISBN = ?, description = ?, publisher = ?, publication_date = ?, quantity = ?, rating = ?, genre = ?, price = ?, image = ? WHERE book_id = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setString(3, book.getISBN());
            statement.setString(4, book.getDescription());
            statement.setString(5, book.getPublisher());
            statement.setDate(6, book.getPublicationDate());
            statement.setInt(7, book.getQuantity());
            statement.setInt(8, book.getRating());
            statement.setString(9, book.getGenre());
            statement.setDouble(10, book.getPrice());
            statement.setString(11, book.getImage());
            statement.setInt(12, book.getId());

            // Execute the update query
            int rowsUpdated = statement.executeUpdate();

            // Close the statement
            statement.close();

            // Return true if the update was successful
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error (you may want to throw an exception or log the error here)
            return false;
        }
    }
}

package model;

import java.sql.*;
import java.util.List;


import java.util.ArrayList;

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
    
    public boolean deleteBook(int bookIdToDelete) {
        try {
            Connection conn = DBConnection.getConnection();
            String query = "DELETE FROM books WHERE book_id = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, bookIdToDelete);

            // Execute the delete query
            int rowsDeleted = statement.executeUpdate();

            // Close the statement
            statement.close();

            // Return true if the delete was successful
            return rowsDeleted > 0;
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
    
    public List<Book> getAllBooks() {
        List<Book> bookList = new ArrayList<>();
        try {
            // Create the database connection
            Connection connection = DBConnection.getConnection();

            // Create and execute the SQL query
            String query = "SELECT * FROM books";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            // Process the result set and populate the book list
            while (resultSet.next()) {
                
                Book book = new Book();	
                // Create a Book object with the retrieved data
				book.setId(resultSet.getInt("book_id"));
				book.setTitle(resultSet.getString("title"));
				book.setAuthor(resultSet.getString("author"));
				book.setDescription(resultSet.getString("author"));
				book.setGenre(resultSet.getString("genre"));
				book.setPrice(resultSet.getInt("price"));
				book.setQuantity(resultSet.getInt("quantity"));
				book.setPrice(resultSet.getDouble("price"));
				book.setTitle(resultSet.getString("title"));
				book.setPublisher(resultSet.getString("publisher"));
				book.setPublicationDate(resultSet.getDate("publication_date"));
				book.setISBN(resultSet.getString("ISBN"));
				book.setRating(resultSet.getInt("rating"));
				
				
                bookList.add(book);

            }

            // Close the resources
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }

        return bookList;
    }
    public String getBookImagePath(int bookId) {
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT image FROM books WHERE book_id = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, bookId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("image");
            }
            return null; // Return null if book with given ID is not found
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error (you may want to throw an exception or log the error here)
            return null;
        }
}
}

package model;

import java.sql.*;
import java.util.*;

public class CartDAO {
    public boolean addToCart(Cart cart) {
        try {
            Connection conn = DBConnection.getConnection();

            // Check if the book_id already exists in the cart for the user
            String selectQuery = "SELECT * FROM cart WHERE user_id = ? AND book_id = ?";
            PreparedStatement selectStmt = conn.prepareStatement(selectQuery);
            selectStmt.setString(1, cart.getUserID());
            selectStmt.setInt(2, cart.getBookID());
            ResultSet resultSet = selectStmt.executeQuery();

            if (resultSet.next()) {
                // The book_id already exists in the cart, update the quantity by stacking
                int existingQuantity = resultSet.getInt("quantity");
                int updatedQuantity = existingQuantity + cart.getQuantity();

                String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND book_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, updatedQuantity);
                updateStmt.setString(2, cart.getUserID());
                updateStmt.setInt(3, cart.getBookID());
                int updateCount = updateStmt.executeUpdate();

                resultSet.close();
                updateStmt.close();

                return updateCount > 0;
            } else {
                // The book_id does not exist in the cart, insert a new row
                String insertQuery = "INSERT INTO cart (user_id, book_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, cart.getUserID());
                insertStmt.setInt(2, cart.getBookID());
                insertStmt.setInt(3, cart.getQuantity());
                int insertCount = insertStmt.executeUpdate();

                resultSet.close();
                insertStmt.close();

                return insertCount > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Cart> getCartItems(String id) {
        List<Cart> cartItems = new ArrayList<>();
        System.out.println("fetching from cart");
        try {
            Connection conn = DBConnection.getConnection();

            String sqlQuery = "SELECT books.book_title, books.author, books.image, cart.quantity, books.price "
            		+ "FROM cart INNER JOIN books ON cart.book_id = books.book_id " + "WHERE cart.user_id = ?";

            PreparedStatement stmt = conn.prepareStatement(sqlQuery);
            stmt.setString(1, id);
            ResultSet resultSet = stmt.executeQuery();

            // Iterate over the result set and retrieve book information
            while (resultSet.next()) {
                String title = resultSet.getString("book_title");
                String author = resultSet.getString("author");
                int quantity = resultSet.getInt("quantity");
                double price = resultSet.getDouble("price");
                double total = quantity * price;
                String image = resultSet.getString("image");

                // Create a Cart object to hold the book information
                Cart cartItem = new Cart();
                cartItem.setBookTitle(title);
                cartItem.setAuthor(author);
                cartItem.setQuantity(quantity);
                cartItem.setPrice(price);
                cartItem.setTotal(total);
                cartItem.setBookImage(image);
                
                System.out.println("fetching from cart");

                // Add the Cart object to the list
                cartItems.add(cartItem);
                System.out.println(cartItems);
            }

            resultSet.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }
}

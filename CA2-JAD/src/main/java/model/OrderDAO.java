package model;

import java.sql.*;
import java.util.ArrayList;


public class OrderDAO {
    public int createOrder(String userid, Date date, float total) throws SQLException, ClassNotFoundException {
        int record = 0;
        int nrow = 0;
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sqlString = "INSERT INTO orders (customer_id, order_date, total_amount) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sqlString, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, userid);
            pstmt.setDate(2, date);
            pstmt.setFloat(3, total);
            nrow = pstmt.executeUpdate();
            if (nrow > 0) {
                ResultSet orderid = pstmt.getGeneratedKeys();
                if (orderid.next()) {
                    record = orderid.getInt(1);
                }
            }
            System.out.println("Order Created in DB");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return record;
    }

    public int createOrderItems(ArrayList<Integer> book_id, int order_id, ArrayList<Integer> quantity)
            throws SQLException, ClassNotFoundException {
        int record = 0;
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            for (int i = 0; i < book_id.size(); i++) {
                String sqlString = "INSERT INTO order_items (book_id, order_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sqlString);
                pstmt.setInt(1, book_id.get(i));
                pstmt.setInt(2, order_id);
                pstmt.setInt(3, quantity.get(i));
                record = pstmt.executeUpdate();
            }
            System.out.println("Order Items Created in DB");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return record;
    }

    public int removeFromCart(String userId) {
        Connection conn = null;
        int rowsDeleted = 0;
        try {
            conn = DBConnection.getConnection();
            String query = "DELETE FROM cart WHERE cart.user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rowsDeleted = pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return rowsDeleted;
    }

    
    public void saveAddressDetails(String userId, String address, String city, String postalCode, String country)
            throws SQLException, ClassNotFoundException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();

            // Retrieve user details from the orders and users tables
            String userQuery = "SELECT email,fname,lname FROM users WHERE user_id = ?";
            PreparedStatement userStmt = conn.prepareStatement(userQuery);
            userStmt.setString(1, userId);
            ResultSet userResult = userStmt.executeQuery();
            
            String email = "";
            String firstName = "";
            String lastName = "";

            if (userResult.next()) {
                email = userResult.getString("email");
                firstName = userResult.getString("fname");
                lastName = userResult.getString("lname");
            } else {
                // If no customer with the specified customer_id found, throw an exception or handle the error accordingly.
                throw new SQLException("User with user_id " + userId + " not found.");
            }

            // Insert the data into customer_details table
            String sqlQuery = "INSERT INTO customer_details(user_id,customer_id, address, city, postal_code, country, email, first_name, last_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sqlQuery);
            stmt.setString(1, userId);
            stmt.setString(2, userId);
            stmt.setString(3, address);
            stmt.setString(4, city);
            stmt.setString(5, postalCode);
            stmt.setString(6, country);
            stmt.setString(7, email);
            stmt.setString(8, firstName);
            stmt.setString(9, lastName);

            stmt.executeUpdate();

            userResult.close();
            userStmt.close();
            stmt.close();
            System.out.println("Address details saved in DB");
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }
}

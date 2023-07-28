package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Order;


public class OrderDAO {
	public int saveOrder(Order order) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        int nrow = 0;

        try {
            conn = DBConnection.getConnection();
            String query = "INSERT INTO orders (first_name, last_name, email, book_title, book_price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, order.getFirstName());
            pstmt.setString(2, order.getLastName());
            pstmt.setString(3, order.getEmail());
            pstmt.setString(4, order.getBookTitle());
            pstmt.setString(5, order.getBookPrice());
            nrow = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return nrow;
    }
}
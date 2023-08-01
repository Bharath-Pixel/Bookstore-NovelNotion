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
            // TODO: handle exception
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return record;
    }
	
	public int createOrderItems(ArrayList<Integer> book_id, int order_id, ArrayList<Integer> quantity) throws SQLException, ClassNotFoundException {
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
            // TODO: handle exception
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return record;
    }
	
	public int removeFromCart(String userId,int bookId) {
        Connection conn = null;
        int rowsDeleted = 0;
        try {
            conn = DBConnection.getConnection();
            String query = "DELETE FROM cart WHERE cart.user_id = ? AND cart.book_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            pstmt.setInt(2, bookId);
            rowsDeleted = pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return rowsDeleted;
    }
	
	
}
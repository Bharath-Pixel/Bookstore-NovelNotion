package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class SalesDAO {
	int record = 0;
    int nrow = 0;
    Connection conn = null;
    
    public List<Sales> getSalesByDate(Date startDate, Date endDate) throws SQLException {
        List<Sales> salesList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT a.order_id, b.username, a.total_amount,a.order_date FROM orders a, users b WHERE b.user_id=a.customer_id AND a.order_date BETWEEN ? AND ?;";
            pstmt = conn.prepareStatement(query);
            pstmt.setDate(1, startDate);
            pstmt.setDate(2, endDate);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                double purchaseAmount = rs.getDouble("total_amount");
                Date purchaseDate = rs.getDate("order_date");
                String customerName = rs.getString("username");

                Sales sales = new Sales();
                sales.setSalesId(orderId);
                sales.setPurchaseAmount(purchaseAmount);
                sales.setCustomerName(customerName);
                sales.setPurchaseDate(purchaseDate);

                salesList.add(sales);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources properly to avoid leaks
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return salesList;
    }
    
    public List<Book> getBooksAndOrderIdByDate(int order_id) throws SQLException {
        List<Book> booksList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT * FROM order_items a, books b WHERE a.order_id=? AND b.book_id=a.book_id ";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, order_id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
            	int orderId = rs.getInt("order_id");

                Sales sales = new Sales();
                sales.setSalesId(orderId);
            
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources properly to avoid leaks
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return booksList;
    }

    
    
    
    

    public ArrayList<User> getTopCustomers() throws SQLException {
        ArrayList<User> topCustomers = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String query = "SELECT c.username, SUM(s.total_amount) AS quantity FROM users c, orders s WHERE c.user_id = s.customer_id GROUP BY c.username ORDER BY quantity DESC LIMIT 10;";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String customerName = rs.getString("username");
                double totalPurchase = rs.getDouble("quantity");
                
                User user = new User(customerName,totalPurchase);
                topCustomers.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources properly to avoid leaks
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return topCustomers;
    }


    public List<String> getCustomersByBook(String bookTitle) throws SQLException {
        List<String> customersByBook = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT a.username FROM users a, order_items b, orders c, books d WHERE b.order_id=c.order_id AND b.book_id=d.book_id AND c.customer_id=a.user_id AND d.book_title=?;";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, bookTitle);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String customerName = rs.getString("username");
                customersByBook.add(customerName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources properly to avoid leaks
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return customersByBook;
    }
}

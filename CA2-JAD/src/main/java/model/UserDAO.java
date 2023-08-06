package model;

import java.sql.*;
import java.util.ArrayList;

public class UserDAO {
	public User loginUser(String username, String password) throws SQLException {
	    User uBean = null;
	    Connection conn = null;
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "SELECT * FROM users WHERE username = ? AND password = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        pstmt.setString(1, username);
	        pstmt.setString(2, password);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            uBean = new User();
	            uBean.setUserid(rs.getString("user_id"));
	            uBean.setUsername(rs.getString("username"));
	            uBean.setRole(rs.getString("role"));
	            uBean.setEmail(rs.getString("email"));
	            uBean.setFname(rs.getString("fname"));
	            uBean.setLname(rs.getString("lname"));
	            System.out.println(".....done writing to bean!......");
	        }
	    } catch (Exception e) {
	        System.out.println("....UserDetailsDB!" + e);
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }
	    return uBean;
	}


	public int insertUser(String email, String username, String password, String fname, String lname) throws SQLException, ClassNotFoundException {
		Connection conn = null;
		int nrow = 0;
		try {
			conn = DBConnection.getConnection();
            String query = "INSERT INTO users (fname, lname, username, password, email, role) VALUES (?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, fname);
			pstmt.setString(2, lname);
			pstmt.setString(3, username);
			pstmt.setString(4, password);
			pstmt.setString(5, email);
			pstmt.setString(6, "member");
			nrow = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return nrow;
	}
	
	public ArrayList<User> listAllUsers() throws SQLException {
	    ArrayList<User> userList = new ArrayList<User>();
	    Connection conn = null;
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "SELECT * FROM users";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            User uBean = new User();
	            uBean.setUserid(rs.getString("user_id"));
	            uBean.setUsername(rs.getString("username"));
	            uBean.setRole(rs.getString("role"));
	            userList.add(uBean);
	        }
	    } catch (Exception e) {
	        System.out.print("...Error in fetching users: " + e);
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }
	    return userList;
	}
	
	public int updateUser(String userid, User user) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int nrow = 0;
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "UPDATE user_details SET age = ?, gender = ? WHERE user_id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        nrow = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        conn.close();
	    }
	    return nrow;
	}
	
	public boolean deleteCustomer(int customerId) {
	    Connection conn = null;

        try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "DELETE FROM customer_details WHERE user_id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
            pstmt.setInt(1, customerId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Returns true if the delete operation was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false in case of any exception or unsuccessful delete operation
        }
    }
	
	public Customer getCustomerById(int customerId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection(); // Assuming you have a method to get a database connection
            String sqlStr = "SELECT * FROM customer_details WHERE customer_id = ?";
            pstmt = conn.prepareStatement(sqlStr);
            pstmt.setInt(1, customerId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Retrieve customer details from the result set and create a Customer object
                Customer customer = new Customer();
                customer.setId(rs.getInt("customer_id"));
                customer.setEmail(rs.getString("email"));
                customer.setAddress(rs.getString("address"));
                customer.setCity(rs.getString("city"));
                customer.setPostalCode(rs.getString("postal_code"));
                customer.setCountry(rs.getString("country"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                // Add other relevant customer fields as needed

                return customer;
            } else {
                // Customer with the given ID not found
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
	
	
	public boolean updateCustomer(Customer customer) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sqlStr = "UPDATE customer_details SET email = ?, address = ?, city = ?, postal_code = ?, country = ?, first_name = ?, last_name = ? WHERE customer_id = ?";
            pstmt = conn.prepareStatement(sqlStr);
            pstmt.setString(1, customer.getEmail());
            pstmt.setString(2, customer.getAddress());
            pstmt.setString(3, customer.getCity());
            pstmt.setString(4, customer.getPostalCode());
            pstmt.setString(5, customer.getCountry());
            pstmt.setString(6, customer.getFirstName());
            pstmt.setString(7, customer.getLastName());
            pstmt.setInt(8, customer.getId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Returns true if the update operation was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false in case of any exception or unsuccessful update operation
        } finally {
            // Close the resources
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

	public int deleteUser(int userId) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int nrow = 0;
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "DELETE FROM users WHERE user_id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        pstmt.setInt(1, userId);
	        nrow = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        conn.close();
	    }
	    return nrow;
	}



}
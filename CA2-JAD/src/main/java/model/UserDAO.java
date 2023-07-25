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

	public int deleteUser(String userid) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int nrow = 0;
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "DELETE FROM user_details WHERE user_id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        pstmt.setString(1, userid);
	        nrow = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        conn.close();
	    }
	    return nrow;
	}



}
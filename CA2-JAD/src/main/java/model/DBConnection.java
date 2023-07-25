package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	 public static Connection getConnection() {
		 try {
			 Class.forName("com.mysql.jdbc.Driver");
			 
		 }catch(ClassNotFoundException e){
			 e.printStackTrace();
		 }
         String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
         Connection conn = null;
         try {
        	 conn = DriverManager.getConnection(connURL);
         }catch(SQLException e){
        	 e.printStackTrace();
         }
         return conn;
	 }
}

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>


<%
    // Retrieve the userId parameter from the request
    String userId = request.getParameter("userId");

    try {
    	String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";

        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(connURL);
        // Execute the query to delete the user
        Statement statement = connection.createStatement();
        String query = "DELETE FROM users WHERE user_id = " + userId;
        statement.executeUpdate(query);

        // Close the statement
        statement.close();

        // Redirect back to the user list page after deletion
        response.sendRedirect("../pages/userInfo.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
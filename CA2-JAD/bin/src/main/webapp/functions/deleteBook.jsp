<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>


<%
// Retrieve the database connection from the request attribute
	String bookId = request.getParameter("bookId");
	
try {
	
	 String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";

     Class.forName("com.mysql.jdbc.Driver");
     Connection connection = DriverManager.getConnection(connURL);
    // Prepare the update statement
	String query = "DELETE FROM books WHERE book_id = ?";
    PreparedStatement statement = connection.prepareStatement(query);
    statement.setString(1, bookId);

    // Execute the update query
    int rowsUpdated = statement.executeUpdate();

    // Check if the update was successful
    if (rowsUpdated > 0) {
        response.sendRedirect("../pages/adminpanel.jsp"); // Redirect to the admin panel page
        request.setAttribute("changesSaved", true);

    } else {
        // Handle update failure
        response.getWriter().println("Failed to update the book details.");
    }

    // Close the statement
    statement.close();
} catch (SQLException e) {
    e.printStackTrace();
    // Handle database error
    response.getWriter().println("Database error: " + e.getMessage());
}
%>

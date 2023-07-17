<%@ page import="java.sql.*"%>
<%
String cartId = request.getParameter("bookId");

try {
    String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(connURL);
    
    // Prepare the delete statement
    String query = "DELETE FROM cart WHERE cart_id = ?";
    PreparedStatement statement = connection.prepareStatement(query);
    statement.setString(1, cartId);

    // Execute the delete query
    int rowsDeleted = statement.executeUpdate();

    // Check if the delete was successful
    if (rowsDeleted > 0) {
        response.sendRedirect("../pages/cartItems.jsp"); // Redirect to the cart page
    } else {
        // Handle delete failure
        response.getWriter().println("Failed to remove the item from the cart.");
    }

    // Close the statement and connection
    statement.close();
    connection.close();
} catch (ClassNotFoundException e) {
    e.printStackTrace();
    // Handle driver error
    response.getWriter().println("Driver error: " + e.getMessage());
} catch (SQLException e) {
    e.printStackTrace();
    // Handle database error
    response.getWriter().println("Database error: " + e.getMessage());
}
%>

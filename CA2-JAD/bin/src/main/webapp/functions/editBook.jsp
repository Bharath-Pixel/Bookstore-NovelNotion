<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>


<%
// Retrieve the database connection from the request attribute
	String bookId = request.getParameter("bookId");

    // Retrieve the form data
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String ISBN = request.getParameter("isbn");
    String publisher= request.getParameter("publisher");
    String publicationDateStr = request.getParameter("publication_date");
    java.sql.Date sqlPublicationDate = java.sql.Date.valueOf(publicationDateStr);
    String description = request.getParameter("description");
    String genre = request.getParameter("genre");
    double price = Double.parseDouble(request.getParameter("price"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    int rating = Integer.parseInt(request.getParameter("rating"));
    String image = request.getParameter("image");
	
try {
	
	 String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";

     Class.forName("com.mysql.jdbc.Driver");
     Connection connection = DriverManager.getConnection(connURL);
    // Prepare the update statement
    String query = "UPDATE books SET book_title = ?, author = ? ,ISBN = ?, description = ?, publisher = ?, publication_date = ? ,quantity = ?, rating = ?, genre = ?, price = ?, image= ? WHERE book_id = ?";
    PreparedStatement statement = connection.prepareStatement(query);
    statement.setString(1, title);
    statement.setString(2, author);
    statement.setString(3, ISBN);
    statement.setString(4, description);
    statement.setString(5, publisher);
    statement.setDate(6, sqlPublicationDate);
    statement.setInt(7, quantity);
    statement.setInt(8, rating);
    statement.setString(9, genre);
    statement.setDouble(10, price);
    statement.setString(11, image);
    statement.setString(12, bookId);

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

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
String userID = (String) session.getAttribute("sessUserId");
int bookID = 0;
int amountToBuy = 1;
String error = null;

try {
    bookID = Integer.parseInt(request.getParameter("bookId"));
    amountToBuy = Integer.parseInt(request.getParameter("quantity"));

    System.out.println(bookID);
    System.out.println(amountToBuy);
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    // Check if the book_id already exists in the cart for the user
    String selectQuery = "SELECT * FROM cart WHERE user_id = ? AND book_id = ?";
    PreparedStatement selectStmt = conn.prepareStatement(selectQuery);
    selectStmt.setString(1, userID);
    selectStmt.setInt(2, bookID);
    ResultSet resultSet = selectStmt.executeQuery();

    if (resultSet.next()) {
        // The book_id already exists in the cart, update the quantity by stacking
        int existingQuantity = resultSet.getInt("quantity");
        int updatedQuantity = existingQuantity + amountToBuy;
        
        String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND book_id = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
        updateStmt.setInt(1, updatedQuantity);
        updateStmt.setString(2, userID);
        updateStmt.setInt(3, bookID);
        int updateCount = updateStmt.executeUpdate();

        if (updateCount > 0) {
            response.sendRedirect("../pages/cartItems.jsp");
        }
    } else {
        // The book_id does not exist in the cart, insert a new row
        String insertQuery = "INSERT INTO cart (user_id, book_id, quantity) VALUES (?, ?, ?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setString(1, userID);
        insertStmt.setInt(2, bookID);
        insertStmt.setInt(3, amountToBuy);
        int insertCount = insertStmt.executeUpdate();

        if (insertCount > 0) {
            response.sendRedirect("../pages/cartItems.jsp");
        }
    }

    resultSet.close();
    selectStmt.close();
    conn.close();

} catch (NumberFormatException e) {
    e.printStackTrace();
} catch (ClassNotFoundException e) {
    e.printStackTrace();
} catch (SQLException e) {
    e.printStackTrace();
}
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
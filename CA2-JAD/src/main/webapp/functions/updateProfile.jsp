<%@ page import="java.sql.*" %>

<%
    // Check if the user is logged in
    String loggedInUser = (String) session.getAttribute("sessUserName");
    if (loggedInUser == null) {
        // Redirect to login page or display an error message
        response.sendRedirect("login.jsp");
    } else {
        // Retrieve the form data
        int userId = Integer.parseInt(request.getParameter("userId"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String password = request.getParameter("password");
        try {
            // Establish a database connection
            String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(connURL);
            request.setAttribute("dbConnection", connection);
            Statement statement = connection.createStatement();
            // Update the user profile in the database for the logged-in user
            String query = "UPDATE users SET username=?, email=?, fname=?, lname=?, password=? WHERE user_id=? AND username=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, fname);
            preparedStatement.setString(4, lname);
            preparedStatement.setString(5, password);
            preparedStatement.setInt(6, userId);
            preparedStatement.setString(7, loggedInUser);
            preparedStatement.executeUpdate();
            // Close the database connection
            preparedStatement.close();
            statement.close();
            connection.close();
            // Redirect back to the profile page with a success message
            response.sendRedirect("../pages/profile.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Redirect back to the profile page with an error message
            response.sendRedirect("../pages/profile.jsp?update=error");
        }
    }
%>
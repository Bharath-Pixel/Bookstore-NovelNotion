<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>

<%

    // Retrieve user details from the database
    List<Object[]> users = new ArrayList<>();
    try {
        // Establish a database connection
        String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";

        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(connURL);
        request.setAttribute("dbConnection", connection);
        Statement statement = connection.createStatement();

        // Execute the query to retrieve users from the database
        String query = "SELECT * FROM users";
        ResultSet resultSet = statement.executeQuery(query);

        // Process the result set and populate the user list
        while (resultSet.next()) {
            int userId = resultSet.getInt("user_id");
            String username = resultSet.getString("username");
            String email = resultSet.getString("email");
            String fname = resultSet.getString("fname");
            String lname = resultSet.getString("lname");


            // Create an array of user data
            Object[] userData = { userId, username, email , fname, lname};

            // Add the user data array to the list
            users.add(userData);
        }

        // Close the database connection
        resultSet.close();
        statement.close();
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }

    // Store the user list in a request attribute
    request.setAttribute("userList", users);
    
%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>

<%

    // Retrieve user details from the database
    List<Object[]> customers = new ArrayList<>();
    try {
        // Establish a database connection
        String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";

        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(connURL);
        request.setAttribute("dbConnection", connection);
        Statement statement = connection.createStatement();

        // Execute the query to retrieve users from the database
        String query = "SELECT * FROM customer_details";
        ResultSet resultSet = statement.executeQuery(query);

        // Process the result set and populate the user list
        while (resultSet.next()) {
            int customer_id = resultSet.getInt("customer_id");
            String email = resultSet.getString("email");
            String phonenumber = resultSet.getString("phone_number");
            String address = resultSet.getString("address");


            // Create an array of user data
            Object[] userData = { customer_id, email , phonenumber, address};

            // Add the user data array to the list
            customers.add(userData);
        }

        // Close the database connection
        resultSet.close();
        statement.close();
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }

    // Store the user list in a request attribute
    request.setAttribute("customerList", customers);
    
%>

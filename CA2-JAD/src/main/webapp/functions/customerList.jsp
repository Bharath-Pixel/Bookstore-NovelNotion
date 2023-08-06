<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>

<%
    // Initialize the list to hold customer details along with their ordered books
    List<Object[]> customersWithOrders = new ArrayList<>();

    try {
        // Establish a database connection
        String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(connURL);
        Statement statement = connection.createStatement();

        // Execute the query to retrieve customers from the database
        String query = "SELECT cd.customer_id, cd.email, cd.address, cd.city, cd.postal_code, cd.country, cd.first_name, cd.last_name, oi.order_id, b.book_id, b.title FROM customer_details cd"
                        + " INNER JOIN orders o ON cd.customer_id = o.customer_id"
                        + " INNER JOIN order_items oi ON o.order_id = oi.order_id"
                        + " INNER JOIN books b ON oi.book_id = b.book_id";

        ResultSet resultSet = statement.executeQuery(query);

        // Process the result set and populate the customer list with their ordered books
        while (resultSet.next()) {
            int customerId = resultSet.getInt("customer_id");
            String email = resultSet.getString("email");
            String address = resultSet.getString("address");
            String city = resultSet.getString("city");
            String postal_code = resultSet.getString("postal_code");
            String country = resultSet.getString("country");
            String first_name = resultSet.getString("first_name");
            String last_name = resultSet.getString("last_name");
            int orderId = resultSet.getInt("order_id");
            int bookId = resultSet.getInt("book_id");
            String bookTitle = resultSet.getString("title");

            // Check if the customer already exists in the list
            boolean customerExists = false;
            for (Object[] customerData : customersWithOrders) {
                if ((int) customerData[0] == customerId) {
                    customerExists = true;
                    break;
                }
            }

            // Create an array of customer data and ordered book details
            if (customerExists) {
                for (Object[] customerData : customersWithOrders) {
                    if ((int) customerData[0] == customerId) {
                        List<Object[]> orderedBooks = (List<Object[]>) customerData[8];
                        orderedBooks.add(new Object[]{orderId, bookId, bookTitle});
                        break;
                    }
                }
            } else {
                List<Object[]> orderedBooks = new ArrayList<>();
                orderedBooks.add(new Object[]{orderId, bookId, bookTitle});
                Object[] customerData = new Object[]{customerId, email, address, city, postal_code, country, first_name, last_name, orderedBooks};
                customersWithOrders.add(customerData);
            }
        }

        // Close the database connection
        resultSet.close();
        statement.close();
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }

    // Store the customer list with ordered books in a request attribute
    request.setAttribute("customerListWithOrders", customersWithOrders);
%>

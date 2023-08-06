<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>

<%
    String searchBy = request.getParameter("searchBy");
    String searchQuery = request.getParameter("search");
    String bookId = request.getParameter("bookId");
   

    // Retrieve book details from the database
    
    List<Object[]> books = new ArrayList<>();
    Object[] selectedBook = null;
    try {
        // Establish a database connection
        String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";

        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(connURL);
        request.setAttribute("dbConnection", connection);
        Statement statement = connection.createStatement();

        // Execute the query to retrieve books from the database
        String query = "SELECT * FROM books";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            if (searchBy.equals("title")) {
                query += " WHERE book_title LIKE '%" + searchQuery + "%'";
            } else if (searchBy.equals("author")) {
                query += " WHERE author LIKE '%" + searchQuery + "%'";
            }
        }
        ResultSet resultSet = statement.executeQuery(query);

        // Process the result set and populate the book list
        while (resultSet.next()) {
            int book_id = resultSet.getInt("book_id");
            String image = resultSet.getString("image");
            String description = resultSet.getString("description");
            String title = resultSet.getString("book_title");
            String author = resultSet.getString("author");
            String genre = resultSet.getString("genre");
            double price = resultSet.getDouble("price");
            int quantity = resultSet.getInt("quantity");
            String publisher = resultSet.getString("publisher");
            String publication_date = resultSet.getString("publication_date");
            String ISBN = resultSet.getString("ISBN");
            int rating = resultSet.getInt("rating");

            // Create an array of book data
            Object[] bookData = { book_id, image, description, title, author, genre, price, quantity, publisher, publication_date, ISBN, rating };

            // Add the book data array to the list
            books.add(bookData);

            if (String.valueOf(book_id).equals(bookId)) {
                selectedBook = bookData;
            }
        }

        // Close the database connection
        resultSet.close();
        statement.close();
        connection.close();

        
        
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }

    // Store the book list in a request attribute
    request.setAttribute("bookList", books);   
	
%>

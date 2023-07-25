package myServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;


@WebServlet("/EditBooksServlet")
public class EditBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve the form data
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String ISBN = request.getParameter("isbn");
            String publisher = request.getParameter("publisher");
            String publicationDateStr = request.getParameter("publication_date");
            java.sql.Date sqlPublicationDate = java.sql.Date.valueOf(publicationDateStr);
            String description = request.getParameter("description");
            String genre = request.getParameter("genre");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String image = request.getParameter("image");

            // Create a Book object with the updated data
            Book book = new Book(bookId, title, author, ISBN, publisher, sqlPublicationDate, description, genre, price, quantity, rating, image);

            // Create a BookDAO object and update the book in the database
            AdminBookDAO bookDAO = new AdminBookDAO();
            boolean isUpdated = bookDAO.updateBook(book);

            // Check if the book was successfully updated
            if (isUpdated) {
                response.sendRedirect("./pages/adminpanel.jsp"); // Redirect to the admin panel page
                request.setAttribute("changesSaved", true);
            } else {
                // Handle update failure
                response.getWriter().println("Failed to update the book details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle error (you may want to throw an exception or log the error here)
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}


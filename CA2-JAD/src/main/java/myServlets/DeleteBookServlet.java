package myServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AdminBookDAO;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdParam = request.getParameter("bookId");

        if (bookIdParam != null) {
            try {
                int bookIdToDelete = Integer.parseInt(bookIdParam);

                // Create a BookDAO object
                AdminBookDAO bookDAO = new AdminBookDAO();

                // Call the deleteBook method and store the result in a boolean variable
                boolean isDeleted = bookDAO.deleteBook(bookIdToDelete);

                if (isDeleted) {
                    // Book was deleted successfully
                    response.sendRedirect("./pages/adminpanel.jsp"); // Redirect to the admin panel page
                    request.setAttribute("changesSaved", true);
                } else {
                    // Handle delete failure
                    response.getWriter().println("Failed to delete the book.");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.getWriter().println("Invalid bookId parameter.");
            }
        } else {
            response.getWriter().println("No bookId parameter specified.");
        }
    }
}

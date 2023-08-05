package myServlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

@WebServlet("/CustomerByBookServlet")
public class CustomerByBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookTitle = request.getParameter("bookTitle");

        if (bookTitle == null || bookTitle.isEmpty()) {
            response.getWriter().println("Please enter a book title.");
            return;
        }

        SalesDAO salesDAO = new SalesDAO();

        try {
            List<String> customersByBook = salesDAO.getCustomersByBook(bookTitle);
            request.setAttribute("customersByBook", customersByBook);
            String redirectURL = "pages/salesReport.jsp";
            response.sendRedirect(redirectURL);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred while fetching data from the database.");
            return;
        }
    }
}

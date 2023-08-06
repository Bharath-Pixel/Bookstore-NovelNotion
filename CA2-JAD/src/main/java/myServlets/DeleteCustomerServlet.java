package myServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the customer ID from the query parameter in the request URL
        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr != null && !customerIdStr.isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdStr);

                // Call the DAO to delete the customer record
                UserDAO userDAO = new UserDAO();
                boolean deletionResult = userDAO.deleteCustomer(customerId);

                if (deletionResult) {
                    // Deletion was successful, redirect back to the customer_details.jsp
                    response.sendRedirect("./pages/customerDetails.jsp");
                } else {
                    // Deletion failed, show an error message
                    response.sendRedirect("error.jsp");
                }
            } catch (NumberFormatException e) {
                // Invalid customer ID, show an error message
                response.sendRedirect("error.jsp");
            }
        } else {
            // Invalid request, show an error message
            response.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST requests, if necessary (e.g., for additional security)
        // Since this servlet only handles deletion, we can leave this method empty
    }
}

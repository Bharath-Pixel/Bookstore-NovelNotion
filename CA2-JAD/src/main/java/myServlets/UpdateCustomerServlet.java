package myServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form data from the request
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");

        // Create a Customer object with the updated details
        Customer customer = new Customer(customerId, email, address, city, postalCode, country, firstName, lastName);

        // Call the updateCustomer method in CustomerDAO to update the customer details in the database
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateCustomer(customer);

        if (success) {
            // If the update was successful, redirect back to the CustomerDetails.jsp page
            response.sendRedirect("./pages/customerDetails.jsp");
        } else {
            // If there was an error updating the customer details, display an error message
            response.getWriter().println("Error updating customer details.");
        }
    }
}

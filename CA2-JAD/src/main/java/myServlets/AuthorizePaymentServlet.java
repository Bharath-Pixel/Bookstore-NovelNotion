package myServlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.paypal.base.rest.PayPalRESTException;

import model.*;

@WebServlet("/AuthorizePayment")
public class AuthorizePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AuthorizePaymentServlet() {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId =request.getParameter("userId");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");

        try {
            // Step 1: Save order details in the orders table
            OrderDAO orderDAO = new OrderDAO();

            // Step 2: Save address details in the customer_details table
            orderDAO.saveAddressDetails(userId, address, city, postalCode, country);

            // Rest of the code to authorize payment with PayPal and redirect user
            String product = request.getParameter("product");
            String subtotal = request.getParameter("subtotal");
            String shipping = request.getParameter("shipping");
            String tax = request.getParameter("tax");
            String total = request.getParameter("total");
            OrderDetail orderDetail = new OrderDetail(product, subtotal, shipping, tax, total);

            PaymentServices paymentServices = new PaymentServices();
            String approvalLink = paymentServices.authorizePayment(orderDetail);
            response.sendRedirect(approvalLink);

        } catch (PayPalRESTException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            // Handle database related errors
            e.printStackTrace();
            // Redirect to an error page or show an error message to the user
        }
    }
}

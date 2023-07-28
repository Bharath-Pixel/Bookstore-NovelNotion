package myServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CartDAO;

@WebServlet("/RemoveCartItemServlet")
public class RemoveCartItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
		// Prepare the delete statement
		CartDAO cartDAO = new CartDAO();
		cartDAO.removeFromCart(bookId);
		request.setAttribute("changesSaved", true);

		// Check if the delete was successful
		
		    response.sendRedirect("./pages/cartItems.jsp"); // Redirect to the cart page
    }
}

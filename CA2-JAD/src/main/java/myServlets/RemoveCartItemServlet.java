package myServlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CartDAO;

@WebServlet("/RemoveCartItemServlet")
public class RemoveCartItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession();
    	String user_id = (String) session.getAttribute("sessUserId");
        int bookId = Integer.parseInt(request.getParameter("bookId"));
		// Prepare the delete statement
		CartDAO cartDAO = new CartDAO();
		cartDAO.removeFromCart(user_id, bookId);
		request.setAttribute("changesSaved", true);

		// Check if the delete was successful
		
		    response.sendRedirect("./pages/cartItems.jsp"); // Redirect to the cart page
    }
}

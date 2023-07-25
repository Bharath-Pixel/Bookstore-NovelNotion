package myServlets;

import java.io.IOException;
import java.util.*;
import java.util.logging.Logger;

import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ViewCart")
public class ViewCartServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("sessUserId");
	    String userRole = (String) session.getAttribute("sessUserRole");

	    // Check if the user is logged in and is a member
	    if (id == null || userRole == null || !userRole.equals("member")) {
	        response.sendRedirect("./login.jsp"); // Redirect to login.jsp
	        return; // Terminate further processing of the page
	    }

	    try {
	        // Retrieve cart items from the database using CartDAO
	        CartDAO cartDAO = new CartDAO();
	        List<Cart> cartItems = cartDAO.getCartItems(id);

	        // Pass the cart items to the JSP page
	        session.setAttribute("cartItems", cartItems);
	        System.out.println("food is good");
	        request.getRequestDispatcher("./pages/cartItems.jsp").forward(request, response);
	    } catch (Exception e) {
	        // Handle any exceptions that might occur while fetching cart items
	        e.printStackTrace(); // You can log the exception for debugging purposes
	        response.sendRedirect("./errorPage.jsp"); // Redirect to an error page or handle the error gracefully
	    }
	}


}

package myServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = (String) request.getSession().getAttribute("sessUserId");
        int bookID = 0;
        int amountToBuy = 1;

        try {
            bookID = Integer.parseInt(request.getParameter("bookId"));
            amountToBuy = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        Cart cart = new Cart();
        cart.setUserID(userID);
        cart.setBookID(bookID);
        cart.setQuantity(amountToBuy);

        CartDAO cartDAO = new CartDAO();
        boolean success = cartDAO.addToCart(cart);

        if (success) {
            response.sendRedirect("./pages/cartItems.jsp");
        } else {
            response.sendRedirect("./pages/login.jsp");
        }
    }

}

package myServlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;;


@WebServlet("/SalesTopCustomerServlet")
public class SalesTopCustomerServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		HttpSession session = request.getSession();
		SalesDAO salesDAO = new SalesDAO();

        try {
            ArrayList<User> topCustomersList = salesDAO.getTopCustomers();
            session.setAttribute("topCustomersList", topCustomersList);
           //ArrayList<String> customersByBooks = salesDAO.getCustomersByBook();
            
            request.getRequestDispatcher("./pages/salesReport.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred while fetching data from the database.");
            return;
        }
    }
    
}

package myServlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;

@WebServlet("/SalesDateServlet")
public class SalesDateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession();
        String startDateStr = request.getParameter("start_date");
        String endDateStr = request.getParameter("end_date");

        if (startDateStr == null || endDateStr == null || startDateStr.isEmpty() || endDateStr.isEmpty()) {
            response.getWriter().println("Please provide start and end dates.");
            return;
        }

        Date startDate = Date.valueOf(startDateStr);
        Date endDate = Date.valueOf(endDateStr);

        SalesDAO salesDAO = new SalesDAO();

        try {
            List<Sales> salesList = salesDAO.getSalesByDate(startDate, endDate);
            session.setAttribute("salesList", salesList);
            
            int orderId = 1;

            List<Book> booksAndOrderIdList = salesDAO.getBooksAndOrderIdByDate(orderId);
            session.setAttribute("booksAndOrderIdList", booksAndOrderIdList);
            
            String redirectURL = "pages/salesReport.jsp" + "?start_date=" + startDateStr + "&end_date=" + endDateStr;
            response.sendRedirect(redirectURL);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred while fetching data from the database.");
            return;
        }

    	
    }
}


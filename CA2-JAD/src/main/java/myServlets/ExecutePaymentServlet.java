package myServlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.*;
 
import com.paypal.api.payments.*;
import com.paypal.base.rest.PayPalRESTException;
 
@WebServlet("/ExecutePayment")
public class ExecutePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public ExecutePaymentServlet() {
    }
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        HttpSession session = request.getSession();
		ArrayList<Integer> bookIds = (ArrayList<Integer>)session.getAttribute("bookIDs");
		ArrayList<Integer> quantity = (ArrayList<Integer>)session.getAttribute("bookQuantity");
        Date date = Date.valueOf(LocalDate.now());
        String user_id = (String)session.getAttribute("sessUserId");
        
        try {
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.executePayment(paymentId, payerId);
             
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);
            
            OrderDAO orders = new OrderDAO();
            int orderID = orders.createOrder(user_id, date, Float.parseFloat(transaction.getAmount().getTotal()));
            
            if (orderID>0) {
            	int orderItemsCreated = orders.createOrderItems(bookIds, orderID, quantity);
            	if(orderItemsCreated>0) {
            		orders.removeFromCart(user_id);
            	}	
            }
             
            request.setAttribute("payer", payerInfo);
            request.setAttribute("transaction", transaction);    
            
 
            request.getRequestDispatcher("./pages/receipt.jsp").forward(request, response);
             
        } catch (PayPalRESTException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
 
}
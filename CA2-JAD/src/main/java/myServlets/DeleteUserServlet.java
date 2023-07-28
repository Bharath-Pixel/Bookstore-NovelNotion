package myServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import model.UserDAO;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));

            

            UserDAO userDAO = new UserDAO();
            userDAO.deleteUser(userId);
            response.sendRedirect("./pages/userInfo.jsp"); // Redirect to the admin panel page
            request.setAttribute("changesSaved", true);

            // Don't forget to close the connection when it's no longer needed
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle any database-related errors
        
    } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}

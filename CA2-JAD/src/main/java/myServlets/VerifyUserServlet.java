package myServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;
import model.UserDAO;

@WebServlet("/VerifyUserServlet")
public class VerifyUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public VerifyUserServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        // Handle logout action
        String logout = request.getParameter("logout");
        if (logout != null && logout.equals("true")) {
            session.invalidate();
            response.sendRedirect("./login.jsp");
            return; // Return to exit the method and prevent further execution
        }

        // Handle login action
        String user = request.getParameter("loginid");
        String pwd = request.getParameter("password");
        String url = "./pages/landing.jsp?loginid=" + user;

        try {
        	UserDAO DAO = new UserDAO();
        	User loginUser = DAO.loginUser(user, pwd);
        	if(loginUser==null) {
        		response.sendRedirect("./pages/login.jsp");
        	}
        	session.setAttribute("sessUserName", user);
            session.setAttribute("sessUserId", loginUser.getUserid());
            session.setAttribute("sessUserRole", loginUser.getRole());
        	
        	if(loginUser.getRole().equals("admin")) {
        		response.sendRedirect(url + "&role=admin");
        	}
        	else {
        		response.sendRedirect(url + "&role=member");
        	}
            
        } catch (Exception e) {
            out.println("Error: " + e);
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String guestLogin = request.getParameter("guest");
        if (guestLogin != null && guestLogin.equals("true")) {
            HttpSession session = request.getSession();
            session.setAttribute("sessUserRole", "guest");
            response.sendRedirect("./pages/landing.jsp");
        } else {
            doGet(request, response);
        }
    }
}

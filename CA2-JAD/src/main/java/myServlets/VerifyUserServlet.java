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
            Class.forName("com.mysql.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);
            Statement stmt = conn.createStatement();

            String sqlStr = "SELECT * FROM users WHERE username='" + user + "' AND password='" + pwd + "'";
            ResultSet rs = stmt.executeQuery(sqlStr);

            if (rs.next()) {
                String userRole = rs.getString("role");
                String userId = rs.getString("user_id");
                session.setAttribute("sessUserName", user);
                session.setAttribute("sessUserId", userId);
                session.setAttribute("sessUserRole", userRole);

                if (userRole.equals("admin") && request.getParameter("role") == null) {
                    // Admin login from admin form
                    response.sendRedirect(url + "&role=admin");
                } else if (userRole.equals("member") && request.getParameter("role") != null && request.getParameter("role").equals("admin")) {
                    // Customer login from admin form, redirect to login page
                    response.sendRedirect("./login.jsp");
                } else {
                    response.sendRedirect(url + "&role=member");
                }
            } else {
                response.sendRedirect("./pages/login.jsp");
            }

            conn.close();
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

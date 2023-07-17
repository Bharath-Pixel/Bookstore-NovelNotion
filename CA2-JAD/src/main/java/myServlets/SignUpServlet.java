package myServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Database connection details
        String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(connURL);
            Statement stmt = conn.createStatement();
            String query = "INSERT INTO users (fname, lname, username, password, email, role) VALUES ('" + firstName + "', '" + lastName + "', '" + username + "', '" + password + "', '" + email + "', 'member')";
            stmt.executeUpdate(query);
            stmt.close();
            conn.close();

            // Redirect to success page or any other desired page
            response.sendRedirect("./pages/login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to error page or display an error message
            response.sendRedirect("signUp.jsp");
        }
    }
}

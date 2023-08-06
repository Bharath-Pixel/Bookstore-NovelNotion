package myServlets;

import model.CustomerData;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CustomerChartDataServlet")
public class CustomerChartDataServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Assuming you have a method to retrieve customer data from the database
        List<CustomerData> customerDataList = retrieveCustomerData();

        // Process customer data to get the most and least purchases
        int maxQuantity = 0;
        int minQuantity = Integer.MAX_VALUE;
        String maxCustomer = "";
        String minCustomer = "";

        for (CustomerData data : customerDataList) {
            int quantity = data.getTotalQuantity();
            if (quantity > maxQuantity) {
                maxQuantity = quantity;
                maxCustomer = data.getCustomerName();
            }
            if (quantity < minQuantity) {
                minQuantity = quantity;
                minCustomer = data.getCustomerName();
            }
        }

        // Create the bar chart representation
        String chartHTML = "<div class='chart-container'>";
        for (CustomerData data : customerDataList) {
            int quantity = data.getTotalQuantity();
            String customerName = data.getCustomerName();
            String barStyle = (quantity == maxQuantity) ? "max-bar" : "bar";

            chartHTML += "<div class='bar-container'>";
            chartHTML += "<span class='bar-text'>" + quantity + "</span>";
            chartHTML += "<div class='" + barStyle + "' style='height: " + quantity + "px;'></div>";
            chartHTML += "<span class='bar-text'>" + customerName + "</span>";
            chartHTML += "</div>";
        }
        chartHTML += "</div>";

        // Set the chart representation as a request attribute
        request.setAttribute("chartHTML", chartHTML);

        // Forward the request to the JSP for visualization
        request.getRequestDispatcher("./pages/chart.jsp").forward(request, response);
    }

    // Sample method to retrieve customer data (replace with your implementation)
    private List<CustomerData> retrieveCustomerData() {
        List<CustomerData> customerDataList = new ArrayList<>();
        try {
            // Establish a database connection
            String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(connURL);
            Statement statement = connection.createStatement();

            // Execute the query to retrieve customer data
            String query = "SELECT cd.customer_id, cd.first_name, cd.last_name, SUM(oi.quantity) AS total_quantity " +
                    "FROM customer_details cd " +
                    "INNER JOIN orders o ON cd.customer_id = o.customer_id " +
                    "INNER JOIN order_items oi ON o.order_id = oi.order_id " +
                    "GROUP BY cd.customer_id, cd.first_name, cd.last_name " +
                    "ORDER BY total_quantity DESC";

            ResultSet resultSet = statement.executeQuery(query);

            // Process the result set and create CustomerData objects
            while (resultSet.next()) {
                int customerId = resultSet.getInt("customer_id");
                String firstName = resultSet.getString("first_name");
                String lastName = resultSet.getString("last_name");
                int totalQuantity = resultSet.getInt("total_quantity");
                String customerName = firstName + " " + lastName;
                customerDataList.add(new CustomerData(customerName, totalQuantity));
            }

            // Close the database resources
            resultSet.close();
            statement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return customerDataList;
    }
}

package myServlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.*;

@WebServlet("/AddBooksServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024, // 5 MB
        maxRequestSize = 20 * 1024 * 1024) // 20 MB
public class AddBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve the form data
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String ISBN = request.getParameter("isbn");
            String publisher = request.getParameter("publisher");
            String publicationDateStr = request.getParameter("publication_date");
            java.sql.Date sqlPublicationDate = java.sql.Date.valueOf(publicationDateStr);
            String description = request.getParameter("description");
            String genre = request.getParameter("genre");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int rating = Integer.parseInt(request.getParameter("rating"));

            // Get the uploaded image
            Part filePart = request.getPart("image");
            String fileName = getFileName(filePart);

            // Save the image to the server
            String uploadPath = "uploads";
            String absolutePath = getServletContext().getRealPath("") + File.separator + uploadPath;

            // Create the "uploads" directory if it does not exist
            File uploadDir = new File(absolutePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = uploadPath + File.separator + fileName;
            absolutePath += File.separator + fileName;
            filePart.write(absolutePath);

            // Create a Book object with the data from the form, including the image file path
            String relativeFilePath = "../" + filePath; // Add the "../" prefix to the filePath
            Book book = new Book(title, author, ISBN, publisher, sqlPublicationDate, description, genre, price, quantity, rating, relativeFilePath);

            // Create a BookDAO object and insert the book into the database
            AdminBookDAO bookDAO = new AdminBookDAO();
            boolean isInserted = bookDAO.insertBook(book);

            // Check if the book was successfully inserted
            if (isInserted) {
                response.sendRedirect("./pages/adminpanel.jsp"); // Redirect to the admin panel page
                request.setAttribute("changesSaved", true);
            } else {
                // Handle insertion failure
                response.getWriter().println("Failed to insert the book details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle error (you may want to throw an exception or log the error here)
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // Extracts file name from content-disposition header of the part
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}

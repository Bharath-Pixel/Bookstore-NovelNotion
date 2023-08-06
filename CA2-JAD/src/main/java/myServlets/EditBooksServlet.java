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

@WebServlet("/EditBooksServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024, // 5 MB
        maxRequestSize = 20 * 1024 * 1024) // 20 MB
public class EditBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve the form data
            int bookId = Integer.parseInt(request.getParameter("bookId"));
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

            // Get the existing file path for the book from the database
            AdminBookDAO bookDAO = new AdminBookDAO();
            String existingFilePath = bookDAO.getBookImagePath(bookId);

            // Get the uploaded image
            Part filePart = request.getPart("newImage");
            String fileName = getFileName(filePart);

            String newFilePath;
            if (filePart != null && filePart.getSize() > 0) {
                // Save the new image to the server
                String uploadPath = "uploads";
                newFilePath = uploadPath + File.separator + fileName;
                String absolutePath = getServletContext().getRealPath("") + File.separator + newFilePath;
                filePart.write(absolutePath);

                // Add the "../" prefix to the new file path
                newFilePath = "../" + newFilePath;
            } else {
                // If no new image is uploaded, keep the existing image file path
                newFilePath = existingFilePath;
            }

            // Create a Book object with the updated data, including the image file path
            Book book = new Book(bookId, title, author, ISBN, publisher, sqlPublicationDate, description, genre, price, quantity, rating, newFilePath);

            // Create a BookDAO object and update the book in the database
            boolean isUpdated = bookDAO.updateBook(book);

            // Check if the book was successfully updated
            if (isUpdated) {
                response.sendRedirect("./pages/adminpanel.jsp"); // Redirect to the admin panel page
                request.setAttribute("changesSaved", true);
            } else {
                // Handle update failure
                response.getWriter().println("Failed to update the book details.");
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

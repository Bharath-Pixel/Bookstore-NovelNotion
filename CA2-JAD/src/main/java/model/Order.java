package model;

public class Order {
    private String firstName;
    private String lastName;
    private String email;
    private String bookTitle;
    private String bookPrice;

    public Order(String firstName, String lastName, String email, String bookTitle, String bookPrice) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.bookTitle = bookTitle;
        this.bookPrice = bookPrice;
    }

    // Getters and setters for the fields
    // You can generate them using your IDE or write them manually

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(String bookPrice) {
        this.bookPrice = bookPrice;
    }
}

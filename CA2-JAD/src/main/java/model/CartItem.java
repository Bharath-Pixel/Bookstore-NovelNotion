package model;

public class CartItem {
    private int bookId;
    private String bookTitle;
    private double bookPrice;
    private int quantity;

    public CartItem(int bookId, String bookTitle, double bookPrice, int quantity) {
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.bookPrice = bookPrice;
        this.quantity = quantity;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

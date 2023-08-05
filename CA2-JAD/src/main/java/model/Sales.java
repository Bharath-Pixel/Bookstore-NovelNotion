package model;

import java.sql.Date;

public class Sales {
	private int salesId;
    private String bookTitle;
    private String customerName;
    private double purchaseAmount;
    private Date purchaseDate;
    
	public int getSalesId() {
		return salesId;
	}
	public void setSalesId(int salesId) {
		this.salesId = salesId;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public double getPurchaseAmount() {
		return purchaseAmount;
	}
	public void setPurchaseAmount(double purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	@Override
    public String toString() {
        return "Sales{" +
                "orderId=" + salesId +
                ", bookTitle='" + bookTitle + '\'' +
                ", customerName='" + customerName + '\'' +
                ", purchaseAmount=" + purchaseAmount +
                ", purchaseDate=" + purchaseDate +
                '}';
    }
}

package model;

public class CustomerData {
    private String customerName;
    private int totalQuantity;

    public CustomerData(String customerName, int totalQuantity) {
        this.customerName = customerName;
        this.totalQuantity = totalQuantity;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }
}

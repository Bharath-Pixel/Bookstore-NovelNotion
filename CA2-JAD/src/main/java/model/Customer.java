package model;

public class Customer {
    private int id;
    private String email;
    private String address;
    private String city;
    private String postalCode;
    private String country;
    private String firstName;
    private String lastName;

    // Default constructor
    public Customer() {
    }

    // Parameterized constructor
    public Customer(int id, String email, String address, String city, String postalCode, String country,
                    String firstName, String lastName) {
        this.id = id;
        this.email = email;
        this.address = address;
        this.city = city;
        this.postalCode = postalCode;
        this.country = country;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    // Getters and setters for attributes

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

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
}

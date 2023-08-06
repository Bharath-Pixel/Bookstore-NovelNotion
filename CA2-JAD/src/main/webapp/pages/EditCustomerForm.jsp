<%@ page import="model.User" %>
<%@ page import="model.UserDAO" %>
<%@ page import="model.Customer" %>
<%@ include file="../components/header.jsp"%>

<head>
    <title>Edit Customer Details</title>
    <!-- Add any necessary CSS or other header content here -->
</head>
<body>
    <h1>Edit Customer Details</h1>
    <%
    // Get the customerId from the URL parameter
    String customerIdParam = request.getParameter("customerId");
    
    // Check if the customerId is valid and not empty
    if (customerIdParam != null && !customerIdParam.isEmpty()) {
        int customerId = Integer.parseInt(customerIdParam);
        
        // Retrieve the customer details using the DAO
        UserDAO userDAO = new UserDAO(); 
        Customer customer = userDAO.getCustomerById(customerId);

        // Check if the customer object is not null
        if (customer != null) {
    %>
    <form action="/CA2-JAD/UpdateCustomerServlet" method="post">
     <input type="hidden" name="customerId" value="<%=request.getParameter("customerId")%>">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%=customer.getEmail()%>" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%=customer.getAddress()%>" required>
            </div>
            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" id="city" name="city" value="<%=customer.getCity()%>" required>
            </div>
            <div class="form-group">
                <label for="postalCode">Postal Code:</label>
                <input type="text" id="postalCode" name="postalCode" value="<%=customer.getPostalCode()%>" required>
            </div>
            <div class="form-group">
                <label for="country">Country:</label>
                <input type="text" id="country" name="country" value="<%=customer.getCountry()%>" required>
            </div>
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="<%=customer.getFirstName()%>" required>
            </div>
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="<%=customer.getLastName()%>" required>
            </div>
            <div class="form-group text-center">
            <button type="submit">Save Changes</button>
            </div>
        </form>
    <%
        } else {
            out.println("<p>Customer not found.</p>");
        }
    } else {
        out.println("<p>Invalid customer ID.</p>");
    }
    %>
</body>
</html>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">

<style>
/* Your custom styles here */
@import
	url("https://fonts.googleapis.com/css2?family=DM+Sans&display=swap");

body {
	margin: 0;
	padding: 0;
	font-family: "DM Sans", sans-serif;
	-webkit-animation: fadein 1.5s; /* Safari, Chrome and Opera > 12.1 */
	-moz-animation: fadein 1.5s; /* Firefox < 16 */
	-ms-animation: fadein 1.5s; /* Internet Explorer */
	-o-animation: fadein 1.5s; /* Opera < 12.1 */
	animation: fadein 1.5s;
}

@
keyframes fadein {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Firefox < 16 */
@
-moz-keyframes fadein {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Safari, Chrome and Opera > 12.1 */
@
-webkit-keyframes fadein {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Internet Explorer */
@
-ms-keyframes fadein {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Opera < 12.1 */
@
-o-keyframes fadein {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
header {
	background: transparent;
	color: #fff;
	padding: 1rem;
	background-image: url(../images/bookstoreBG.jpg);
	background-size: cover;
	background-position: center;
	background-attachment: fixed;
	height: 30vh;
}

/* Height for devices larger than 576px */
.navbar .nav-link {
	color: #fff !important;
}

a {
	text-decoration: none;
	color: #000000;
}

a:hover {
	color: #000000;
}

h1 {
	margin: 0;
}

nav ul {
	list-style: none;
	margin: 0;
	padding: 0;
	display: flex;
}

nav ul li {
	margin-right: 1rem;
}

nav ul li a:hover {
	border-bottom: 2px solid #fff;
	padding-bottom: 5px;
}

nav ul li:last-child {
	margin-right: 0;
}

nav ul li a {
	color: #fff;
	text-decoration: none;
}
h1 {
        text-align: center;
        margin-bottom: 20px;
    }

 form {
        max-width: 400px;
        margin: 0 auto;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    input[type="text"],
    input[type="email"] {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    button {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3;
    }


</style>
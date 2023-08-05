<%
String id = (String) session.getAttribute("sessUserId");
String userRole = (String) session.getAttribute("sessUserRole");
// Handle logout request
String logout = request.getParameter("logout");
if (logout != null && logout.equals("true")) {
	session.invalidate(); // Invalidate the session
	response.sendRedirect("./login.jsp"); // Redirect to login.jsp
	return; // Terminate further processing of the page
}

if (id == null || userRole == null) {
	session.invalidate(); // Invalidate the session
	response.sendRedirect("./login.jsp"); // Redirect to login.jsp
	return; // Terminate further processing of the page
}

if (!userRole.equals("member")) {
	session.invalidate(); // Invalidate the session
	response.sendRedirect("./login.jsp"); // Redirect to login.jsp
	return; // Terminate further processing of the page
}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style type="text/css">
        @import url("https://fonts.googleapis.com/css2?family=DM+Sans&display=swap");
        body {
            background-image: url(./images/bookstoreBG.jpg);
            background-repeat: no-repeat;
            background-size: cover; /* Resize the background image to cover the entire container */
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        table { 
            border: 0; 
        }
        table td { 
            padding: 5px; 
        }
        input[type="submit"] {
            margin-top: 10px;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-4">Please Review Before Paying</h1>
        <form action="/CA2-JAD/ExecutePayment" method="post">
            <table class="table table-bordered">
                <tr>
                    <td colspan="2"><b>Transaction Details:</b></td>
                    <td>
                        <input type="hidden" name="paymentId" value="${param.paymentId}" />
                        <input type="hidden" name="PayerID" value="${param.PayerID}" />
                    </td>
                </tr>
                <!-- Transaction Details -->
                <tr>
                    <td>Description:</td>
                    <td colspan="2">${transaction.description}</td>
                </tr>
                <tr>
                    <td>Subtotal:</td>
                    <td colspan="2">${transaction.amount.details.subtotal} SGD</td>
                </tr>
                <tr>
                    <td>Shipping:</td>
                    <td colspan="2">${transaction.amount.details.shipping} SGD</td>
                </tr>
                <tr>
                    <td>Tax:</td>
                    <td colspan="2">${transaction.amount.details.tax} SGD</td>
                </tr>
                <tr>
                    <td>Total:</td>
                    <td colspan="2">${transaction.amount.total} SGD</td>
                </tr>
                <tr><td colspan="3"></td></tr>
                <!-- Payer Information -->
                <tr>
                    <td colspan="2"><b>Payer Information:</b></td>
                    <td></td>
                </tr>
                <tr>
                    <td>First Name:</td>
                    <td colspan="2">${payer.firstName}</td>
                </tr>
                <tr>
                    <td>Last Name:</td>
                    <td colspan="2">${payer.lastName}</td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td colspan="2">${payer.email}</td>
                </tr>
                <tr><td colspan="3"></td></tr>
                <!-- Shipping Address -->
                <tr>
                    <td colspan="2"><b>Shipping Address:</b></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Recipient Name:</td>
                    <td colspan="2">${shippingAddress.recipientName}</td>
                </tr>
                <tr>
                    <td>Line 1:</td>
                    <td colspan="2">${shippingAddress.line1}</td>
                </tr>
                <tr>
                    <td>City:</td>
                    <td colspan="2">${shippingAddress.city}</td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td colspan="2">${shippingAddress.state}</td>
                </tr>
                <tr>
                    <td>Country Code:</td>
                    <td colspan="2">${shippingAddress.countryCode}</td>
                </tr>
                <tr>
                    <td>Postal Code:</td>
                    <td colspan="2">${shippingAddress.postalCode}</td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <input type="submit" value="Pay Now" />
                    </td>
                </tr>
            </table>
            
        </form>
    </div>
</body>
</html>

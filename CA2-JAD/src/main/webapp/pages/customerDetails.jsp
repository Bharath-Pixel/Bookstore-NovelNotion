<%@ include file="../components/header.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Customer Details</title>
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

main {
	max-width: 1200px;
	margin: 0 auto;
	padding: 2rem;
}

.bookHeader {
	padding: 30px;
	margin-top:30px;
	text-align: center;
}

.container {
	text-align: center;
}

.result {
	margin-top: 20px;
}

.table {
	width: 100%;
	margin-bottom: 20px;
}

.center-table {
	margin: 0 auto;
}

th, td {
	text-align: center;
	white-space: nowrap;
	  vertical-align: middle;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
}

body {
	font-family: "DM Sans", sans-serif;
}

.book-container {
	margin-top: 20px;
}

.book-item {
	display: inline-block;
	text-align: center;
	margin: 10px;
}

.book-item img {
	width: 100px;
	height: 150px;
	display: block;
	margin: 0 auto;
}

.book-title {
	text-align: center;
	margin-top: 5px;
	font-size: 12px;
}

.ordered-books {
	display: flex;
	flex-direction: row;
	overflow-x: auto;
	white-space: nowrap;
	justify-content:center;
	-webkit-overflow-scrolling: touch;
	margin-top: 10px;
}

.edit-btn {
	display: inline-block;
	margin-left: 10px;
	background-color: #008000
}

.delete-btn {
	display: inline-block;
	margin-left: 10px;
	background-color: red;
}


</style>
</head>
<body>
	<div class="container">
		<h1 class="bookHeader">Customer Details</h1>
		<div class="row book-container">
			<table class="table">
				<!-- Table headers here -->
				<thead>
					<tr>
						<th>Customer ID</th>
						<th>Email</th>
						<th>Address</th>
						<th>City</th>
						<th>Postal Code</th>
						<th>Country</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>EDIT/DELETE</th>
						<th>Ordered Books</th>
					</tr>
				</thead>
				<tbody>
					<%
					// Initialize variables to keep track of the current customer and book
					int currentCustomerId = -1;
					int currentBookId = -1;
					int totalQuantity = 0;

					try {
						// Establish a database connection
						String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection connection = DriverManager.getConnection(connURL);
						Statement statement = connection.createStatement();

						// Execute the query to retrieve customers and ordered books from the database
						String query = "SELECT cd.customer_id, cd.email, cd.address, cd.city, cd.postal_code, cd.country, cd.first_name, cd.last_name, b.book_id, b.book_title, b.image, oi.quantity FROM customer_details cd"
						+ " INNER JOIN orders o ON cd.customer_id = o.customer_id"
						+ " INNER JOIN order_items oi ON o.order_id = oi.order_id" + " INNER JOIN books b ON oi.book_id = b.book_id"
						+ " ORDER BY cd.customer_id, b.book_id"; // Order by customer_id and book_id

						ResultSet resultSet = statement.executeQuery(query);

						// Process the result set and display customer details and ordered books
						while (resultSet.next()) {
							int customerId = resultSet.getInt("customer_id");
							String email = resultSet.getString("email");
							String address = resultSet.getString("address");
							String city = resultSet.getString("city");
							String postalCode = resultSet.getString("postal_code");
							String country = resultSet.getString("country");
							String firstName = resultSet.getString("first_name");
							String lastName = resultSet.getString("last_name");
							String bookTitle = resultSet.getString("book_title");
							int quantity = resultSet.getInt("quantity");
							String imageUrl = resultSet.getString("image");
							int bookId = resultSet.getInt("book_id");

							// Check if the customer ID is different from the current one (i.e., a new customer)
							if (customerId != currentCustomerId) {
						// If it's a new customer, display their details in a new row
					%>
					<tr>
						<td><%=customerId%></td>
						<td><%=email%></td>
						<td><%=address%></td>
						<td><%=city%></td>
						<td><%=postalCode%></td>
						<td><%=country%></td>
						<td><%=firstName%></td>
						<td><%=lastName%></td>
						<td>
            <div class="button-container">
				<a href="./EditCustomerForm.jsp?customerId=<%=customerId%>" class="btn btn-primary">Edit</a>
                <a href="/CA2-JAD/DeleteCustomerServlet?customerId=<%=customerId%>" class="btn btn-danger delete-btn">Delete</a>
            </div>
        </td>
						<td>
						
							<div class="ordered-books">
								<%-- Display ordered books for the current customer --%>
								<%
								// Update current customer and book information
								currentCustomerId = customerId;
								currentBookId = bookId;
								totalQuantity = quantity;
								%>
								<div class="book-item">
									<img src="<%=imageUrl%>" alt="<%=bookTitle%>" height="100"
										width="70">
									<div class="book-title"><%=bookTitle%></div>
									<%=quantity%>
									copies
								</div>
								<%
								} else {
								// If it's the same customer, check if it's the same book or a different book
								if (bookId != currentBookId) {
									// If it's a different book, display the previous book's total quantity and the new book
								%>
								<div class="book-item">
									<img src="<%=imageUrl%>" alt="<%=bookTitle%>" height="100"
										width="70">
									<div class="book-title"><%=bookTitle%></div>
									<%=quantity%>
									copies
								</div>
								<%
								// Update current book information
								currentBookId = bookId;
								totalQuantity = quantity;
								} else {
								// If it's the same book, update the total quantity
								totalQuantity += quantity;
								}
								}
								}

								// Close the database connection
								resultSet.close();
								statement.close();
								connection.close();
								} catch (ClassNotFoundException | SQLException e) {
								e.printStackTrace();
								}
								%>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<form action="/CA2-JAD/CustomerChartDataServlet" method="GET">
			<button type="submit" class="btn btn-primary">Generate Chart</button>
		</form>
</body>
</html>

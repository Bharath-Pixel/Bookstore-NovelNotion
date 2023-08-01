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

//Retrieve cart items from the database
List<String> bookTitles = new ArrayList<String>();
List<String> bookAuthors = new ArrayList<String>();
List<Integer> quantities = new ArrayList<Integer>();
List<Double> prices = new ArrayList<Double>();
List<Double> totals = new ArrayList<Double>();
List<String> bookImages = new ArrayList<String>();
List<Integer> bookIDs = new ArrayList<Integer>();

try {
	Class.forName("com.mysql.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

	// Query the cart items for the user
	String sqlQuery = "SELECT books.book_title, books.author, books.image, books.book_id, cart.quantity, books.price "
	+ "FROM cart INNER JOIN books ON cart.book_id = books.book_id " + "WHERE cart.user_id = ?";

	PreparedStatement stmt = conn.prepareStatement(sqlQuery);
	stmt.setString(1, id);
	ResultSet resultSet = stmt.executeQuery();

	// Iterate over the result set and retrieve book information
	while (resultSet.next()) {
		String title = resultSet.getString("book_title");
		String author = resultSet.getString("author");
		int quantity = resultSet.getInt("quantity");
		double price = resultSet.getDouble("price");
		double total = quantity * price;
		String image = resultSet.getString("image");
		int bookID = resultSet.getInt("book_id");

		// Add the book information to the lists
		bookImages.add(image);
		bookTitles.add(title);
		bookAuthors.add(author);
		quantities.add(quantity);
		prices.add(price);
		totals.add(total);
		bookIDs.add(bookID);
	}

	resultSet.close();
	stmt.close();
	conn.close();

} catch (Exception e) {
	e.printStackTrace();
}

session.setAttribute("bookIDs",bookIDs);
session.setAttribute("bookQuantity",quantities);

%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Cart</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid">
				<!-- Navbar brand -->
				<a class="navbar-brand nav-link disabled" href="#">
					<h2 style="font-weight: bold">Novel Notion</h2>
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="landing.jsp">Home</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
								New in! </a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="#">Action</a></li>
								<li><a class="dropdown-item" href="#">Another action</a></li>
								<li><hr class="dropdown-divider" /></li>
								<li><a class="dropdown-item" href="#">Something else
										here</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="#"
							tabindex="-1">Deals </a></li>
					</ul>
					<ul class="navbar-nav navbar-right ms-auto">
						<%
						if (userRole != null && userRole.equals("member")) {
						%>
						<li class="nav-item"><a class="nav-link" href="cartItems.jsp">Cart
								items</a></li>
						<li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="?logout=true">Log
								out</a></li>
						<%
						} else if (userRole != null && userRole.equals("admin")) {
						%>
						<li class="nav-item"><a class="nav-link"
							href="adminpanel.jsp">Inventory</a></li>
						<li class="nav-item"><a class="nav-link" href="userInfo.jsp">User
								Info </a></li>
						<li class="nav-item"><a class="nav-link" href="?logout=true">Log
								out</a></li>
						<%
						} else {
						%>
						<li class="nav-item"><a class="nav-link" href="login.jsp">Log
								In</a></li>
						<li class="nav-item"><a class="nav-link" href="signUp.jsp">Sign
								Up</a></li>
						<%
						}
						%>
					</ul>
				</div>
			</div>
		</nav>
	</header>

		<div class="container">
			<h1 class="cartHeading">Cart Items</h1>
			<%
			if (bookTitles.isEmpty()) {
			%>
			<p>No items in your cart.</p>
			<%
			} else {
			%>
			<table class="cart-table">
				<thead>
					<tr>
						<th>Item</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Total</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<%
					double grandTotal = 0.00;
					for (int i = 0; i < bookTitles.size(); i++) {
						grandTotal += totals.get(i);
					%>
					<tr>
						<td>
							<div class="media">
								<!-- Use the retrieved book information -->
								<img src="<%=bookImages.get(i)%>" class="img-fluid"
									alt="Book Cover" onerror="this.src='../images/book1.jpg'" />
								<div class="media-body">
									<h4 class="book-title"><%=bookTitles.get(i)%></h4>
									<p class="book-author">
										by
										<%=bookAuthors.get(i)%></p>
								</div>
							</div>
						</td>
						<td>
							<!-- Use the retrieved quantity --> <%=quantities.get(i) != null ? quantities.get(i) : 0%>
						</td>
						<td>$<%=prices.get(i)%></td>
						<td>$<%=totals.get(i)%></td>
						<td>
							<form method="post" action="/CA2-JAD/RemoveCartItemServlet">
							<input type="hidden" name="bookId" value="<%=bookIDs%>" /> <input
									type="submit" class="btn btn-danger" value="Remove" />
															</form>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<hr>
			<div class="cart-total">
				<%
				DecimalFormat decimalFormat = new DecimalFormat("0.00");
				String formattedGrandTotal = decimalFormat.format(grandTotal);
				%>
				<p class="total">
					Subtotal: $<%=formattedGrandTotal%>
				</p>
	<form method="post" action="./checkout.jsp">
	  <input type="hidden" name="total" value="<%=formattedGrandTotal%>" />
	  <button type="submit" class="btn btn-primary btn-long">Checkout</button>
	</form>
		
			</div>
			<%
			}
			%>
		</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<style>
@import
	url("https://fonts.googleapis.com/css2?family=DM+Sans&display=swap");

body {
	margin: 0;
	padding: 0;
	font-family: "DM Sans", sans-serif;
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

.navbar .nav-link {
	color: #fff !important;
}

h1 {
	margin: 0;
}

form {
	margin-bottom: 5%
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

.cartHeading {
	margin-top: 50px;
	margin-bottom: 60px;
	justify-content: center;
	text-align: center;
}

.container {
	margin-top: 5%;
}

.book-cover {
	max-width: 100%;
	height: 20vh;
}

.book-title {
	font-size: 24px;
	font-weight: 700;
	margin-bottom: 5px;
}

.book-author {
	font-style: italic;
	color: #777;
}

.book-price {
	font-weight: bold;
	margin-bottom: 5px;
}

.book-description {
	margin-bottom: 20px;
}

.btn-primary {
	background-color: #007bff;
	color: #fff;
	padding: 10px 20px;
	border-radius: 4px;
	text-decoration: none;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.quantity {
	margin-bottom: 10px;
	display: flex;
	align-items: center;
}

.quantity label {
	margin-right: 10px;
}

.add-to-cart {
	display: flex;
	align-items: center;
}

.add-to-cart .btn {
	margin-left: 10px;
}

/* Cart Table Styling */
.cart-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 30px;
}

.cart-table th, .cart-table td {
	padding: 10px;
	text-align: center;
}

.cart-table th {
	background-color: #f1f1f1;
}

.cart-table td img {
	max-width: 80px;
	height: auto;
}

.cart-total {
	margin-top: 5%;
	text-align: center;
	font-weight: bold;
}
.btn-long{
	width:30%;
	cursor: pointer;
	color:black;
	 background: transparent;
	 transition: 0.7s ease-in-out;
	 border: 1px solid #000000;
	 outline: none;
}

.btn-long:hover{
  transition: 0.7s ease-in-out;
  background: black;
  color:white;
}
</style>
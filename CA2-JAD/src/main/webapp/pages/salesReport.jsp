
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

if (!userRole.equals("admin")) {
	session.invalidate(); // Invalidate the session
	response.sendRedirect("./login.jsp"); // Redirect to login.jsp
	return; // Terminate further processing of the page
}
%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="model.*"%>
<%@ page import="java.text.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Novel Notion</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles.css" />
</head>
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
	background-image: url(<%=request.getContextPath() %>/images/bookstoreBG.jpg);
	background-size: cover;
	background-position: center;
	background-attachment: fixed;
	height: 30vh;
}

.bookHeader {
	text-align: center;
}

.navbar .nav-link {
	color: #fff !important;
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

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #f2f2f2;
}

tr:hover {
	background-color: #f5f5f5;
}

.no-records {
	text-align: center;
	font-style: italic;
	color: #888;
	padding: 20px;
}

.salesHeader {
	margin-top: 20px;
	text-align: center;
	color: #333;
}

/* Add styles for the form */
form {
	text-align: center;
	margin: 20px auto;
	max-width: 400px;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 10px;
}

.form-group label {
	display: block;
}

.form-group input[type="date"] {
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.form-group button {
	padding: 10px 20px;
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.form-group button:hover {
	background-color: #0056b3;
}

label {
	display: block;
	margin-bottom: 10px;
}

input[type="date"] {
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

button {
	padding: 10px 20px;
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
}
</style>
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
						<li class="nav-item"><a class="nav-link" href="landing.jsp">Home</a>
						</li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
								Hello World </a>
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
						<li class="nav-item"><a class="nav-link" href="addToCart.jsp">Cart
								items</a></li>
						<li class="nav-item"><a class="nav-link" href="?logout=true">Log
								out</a></li>
						<%
						} else if (userRole != null && userRole.equals("admin")) {
						%>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath() %>/pages/adminpanel.jsp">Inventory</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath() %>/pages/userInfo.jsp">User
								Info</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath() %>/SalesTopCustomerServlet">Sales Management</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath() %>/pages/customerDetails.jsp">Customer Management</a></li>

						<li class="nav-item"><a class="nav-link" href="/VerifyUserServlet/?logout=true">Log
								out</a></li>
						<%
						} else {
						%>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath() %>/login.jsp">Log
								In</a></li>
						<li class="nav-item"><a class="nav-link" href="#">Sign Up</a>
						</li>
						<%
						}
						%>
					</ul>
				</div>
			</div>
		</nav>
	</header>

	<section>
		<h2 class="salesHeader">Sales Report</h2>
		<%-- Sales report form --%>
		<form action="<%=request.getContextPath()%>/SalesDateServlet"
			method="POST">
			<label for="startDate">Start Date:</label> <input type="date"
				id="start_date" name="start_date" required>

			<div class="form-group">
				<label for="endDate">End Date:</label> <input type="date"
					id="end_date" name="end_date" required>
			</div>

			<div class="form-group">
				<button type="submit">Generate Report</button>
			</div>
		</form>

		<h3 class="salesHeader">Sales Report Results:</h3>
		<%
		List<Sales> salesList = (List<Sales>) session.getAttribute("salesList");
		%>

		<table>
			<tr>
				<th>Order Date</th>
				<th>Customer Name</th>
				<th>Total Amount</th>
			</tr>
			<%
			if (salesList != null && !salesList.isEmpty()) {
			%>
			<%
			for (Sales sale : salesList) {
			%>
			<tr>
				<td><%=sale.getPurchaseDate()%></td>
				<td><%=sale.getCustomerName()%></td>
				<td>$<%=sale.getPurchaseAmount()%></td>
			</tr>
			<%
			}
			%>
			<%
			} else {
			%>
			<tr>
				<td colspan="3" class="no-records">No sales records found.</td>
			</tr>
			<%
			}
			%>
		</table>


		<hr>

		<h3 class="salesHeader">Top 10 Customers by Purchase Amount</h3>
		<%
		ArrayList<User> topCustomersList = (ArrayList<User>) session.getAttribute("topCustomersList");
		if (topCustomersList != null && !topCustomersList.isEmpty()) {
		%>
		<table>
			<tr>
				<th>Customer Name</th>
				<th>Total Purchase Amount</th>
			</tr>
			<%
			for (User user : topCustomersList) {
				String customerName = user.getUsername();
				double totalPurchase = user.getTotalPurchase();
			%>
			<tr>
				<td><%=customerName%></td>
				<td>$<%=new DecimalFormat("#0.00").format(totalPurchase)%></td>
			</tr>
			<%
			}
			%>
		</table>
		<%
		} else {
		%>
		<p class="no-records">No top customers found.</p>
		<%
		}
		%>


	</section>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
		integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
		crossorigin="anonymous"></script>

</body>
</html>


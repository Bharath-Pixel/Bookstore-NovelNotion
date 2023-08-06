<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ include file="../components/header.jsp"%>

<%
// Retrieve cart items from the database
List<String> bookTitles = new ArrayList<String>(); 
List<String> bookAuthors = new ArrayList<String>();
List<Integer> quantities = new ArrayList<Integer>(); 
List<Double> prices = new ArrayList<Double>();
List<Double> totals = new ArrayList<Double>(); 
List<String> bookImages = new ArrayList<String>();

try {
	Class.forName("com.mysql.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

	// Query the cart items for the user
	String sqlQuery = "SELECT books.book_title, books.author, books.image, cart.quantity, books.price "
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

		// Add the book information to the lists
		bookImages.add(image);
		bookTitles.add(title);
		bookAuthors.add(author);
		quantities.add(quantity);
		prices.add(price);
		totals.add(total);
	}

	resultSet.close();
	stmt.close();
	conn.close();

} catch (Exception e) {
	e.printStackTrace();
}
%>

<div class="container mt-4 p-0">
	<div class="row px-md-4 px-2 pt-4">
		<!-- Cart items -->
		<div class="col-lg-8">
			<p class="pb-2 fw-bold">Order</p>
			<div class="card">
				<div class="table-responsive px-md-4 px-2 pt-3">
					<table class="table table-borderless">
						<tbody>
							<%-- Iterate through the cart items and display them --%>
							<%
							for (int i = 0; i < bookTitles.size(); i++) {
							%>
							<tr class="border-bottom">
								<td>
									<div class="d-flex align-items-center">
										<div>
											<img class="pic" src="<%=bookImages.get(i)%>"
												alt="Book Cover" />
										</div>
										<div class="ps-3 d-flex flex-column justify-content">
											<p class="fw-bold"><%=bookTitles.get(i)%></p>
											<small class="d-flex"> <span class="text-muted">Author:</span>
												<span class="fw-bold"><%=bookAuthors.get(i)%></span>
											</small>
										</div>
									</div>
								</td>
								<td>
									<div class="d-flex">
										<p class="text-muted">
											$<%=prices.get(i)%></p>
									</div>
								</td>
								<td>
									<div class="d-flex align-items-center">
										<span class="pe-3 text-muted">Quantity</span> <span
											class="pe-3"><%=quantities.get(i)%></span>
									</div>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<!-- Payment summary -->
		<div class="col-lg-4 payment-summary">
			<p class="fw-bold pt-lg-0 pt-3 pb-2">Payment Summary</p>
			<div class="card px-md-3 px-2 pt-4">
				<div class="d-flex flex-column b-bottom">
					<%-- Iterate through the cart items and calculate total amount --%>
					<%
					double totalAmount = 0.0;
					for (int i = 0; i < bookTitles.size(); i++) {
						totalAmount += totals.get(i);
					}

					/// Format the amounts to two decimal places
					DecimalFormat df = new DecimalFormat("#0.00");
					totalAmount = Double.parseDouble(df.format(totalAmount));
					double shippingCost = Double.parseDouble(df.format(5.00)); // Assuming shipping cost is a flat rate of $5.00
					double gst = Double.parseDouble(df.format(totalAmount * 0.07));
					double totalWithShippingAndGst = Double.parseDouble(df.format(totalAmount + shippingCost + gst));
					%>

					<div class="d-flex justify-content-between py-3">
						<small class="text-muted">Sub-Total</small>
						<p>
							$<%=totalAmount%></p>
					</div>
					<div class="d-flex justify-content-between pb-3">
						<small class="text-muted">Shipping</small>
						<p>$5.00</p>
					</div>
					<div class="d-flex justify-content-between">
						<small class="text-muted">GST (7%)</small>
						<p>
							$<%=gst%></p>
					</div>
					<hr class="my-1">
					<div class="d-flex justify-content-between">
						<small class="text-muted">Total Amount</small>
						<p>
							$<%=totalWithShippingAndGst%></p>
					</div>
				</div>
			</div>
			<div class="d-flex justify-content-center mt-3">
				<form action="/CA2-JAD/AuthorizePayment" method="post">
					<!-- Hidden input fields to store the payment details -->
					<input type="hidden" name="subtotal" value="<%=totalAmount%>">
					<input type="hidden" name="shipping" value="5.00"> <input
						type="hidden" name="tax" value="<%=gst%>"> <input
						type="hidden" name="total" value="<%=totalWithShippingAndGst%>">
					<%
					for (String title : bookTitles) {
					%>
					<input type="hidden" name="product" value="<%=title%>">
					<%
					}
					%>

					<!-- Address details form fields -->


					<div class="mb-3">
						<label for="address" class="form-label">Address</label> <input
							type="text" class="form-control" id="address" name="address"
							required>
					</div>
					<div class="mb-3">
						<label for="city" class="form-label">City</label> <input
							type="text" class="form-control" id="city" name="city" required>
					</div>
					<div class="mb-3">
						<label for="postalCode" class="form-label">Postal Code</label> <input
							type="text" class="form-control" id="postalCode"
							name="postalCode" required>
					</div>
					<div class="mb-3">
						<label for="country" class="form-label">Country</label> <input
							type="text" class="form-control" id="country" name="country"
							required>
					</div>

					<!-- Hidden input field for session user ID -->
					<!-- Hidden input field for session user ID -->
					<input type="hidden" id="userId" name="userId" value="<%=id%>">


					<!-- Checkout button -->
					<button type="submit" class="btn btn-primary">Checkout</button>

				</form>
			</div>
		</div>
	</div>
</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


<style>
@import
	url("https://fonts.googleapis.com/css2?family=DM+Sans&display=swap");

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	list-style: none;
	font-family: "DM Sans", sans-serif;
}

body {
	line-height: 1rem;
	font-size: 14px;
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

nav ul {
	list-style: none;
	margin: 0;
	padding: 0;
	display: flex;
	color: white;
}

nav ul li {
	margin-right: 1rem;
	color: white;
}

nav ul li a:hover {
	border-bottom: 2px solid #fff;
	padding-bottom: 5px;
	color: white;
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
	padding: 3rem;
}

.navbar-nav {
	margin-left: auto;
}

.container-1 {
	border-top-left-radius: 20px;
	border-top-right-radius: 20px;
	border-bottom-left-radius: 20px;
	border-bottom-right-radius: 20px;
	background-color: #eee;
}

small {
	font-size: 12px;
}

.cart {
	line-height: 1;
}

.icon {
	background-color: #eee;
	width: 40px;
	height: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 50%;
}

.pic {
	width: 70px;
	height: 90px;
	border-radius: 5px;
}

td {
	vertical-align: middle;
}

.red {
	color: #fd1c1c;
	font-weight: 600;
}

.b-bottom {
	padding-bottom: 30px;
}

p {
	margin: 0px;
}

table input {
	width: 40px;
	border: 1px solid #eee;
}

input:focus {
	border: 1px solid #eee;
	outline: none;
}

.round {
	background-color: #eee;
	height: 40px;
	width: 40px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.payment-summary .unregistered {
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #eee;
	text-transform: uppercase;
	font-size: 14px;
}

.del {
	width: 35px;
	height: 35px;
	object-fit: cover;
}

.col-lg-4 {
	order: 1; /* Place the address form first in the row */
}

.col-lg-4 .card {
	display: block; /* Make the card a block element */
}

.col-lg-4 h5 {
	text-align: center; /* Center the "Shipping Address" heading */
}
</style>
</body>
</html>

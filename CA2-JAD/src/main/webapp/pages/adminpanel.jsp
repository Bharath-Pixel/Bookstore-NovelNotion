<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ include file="../components/header.jsp"%>
<%@ include file="../functions/bookList.jsp" %>


<%
if (!userRole.equals("admin")) {
	session.invalidate(); // Invalidate the session
	response.sendRedirect("./login.jsp"); // Redirect to login.jsp
	return; // Terminate further processing of the page
}
%>
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
<link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>

	<section>


		<div class="container">
			<!-- Add New Book Button -->
			<div class="add-book-button">
				<label for="add-book-toggle" class="add-book-btn">Add New
					Book</label> <input type="checkbox" class="add-book-toggle"
					id="add-book-toggle" />
				<div class="add-book-popup">
					<div class="add-book-popup-content">
						<h2>Add New Book</h2>
						<a href="" class="book-close-btn">&times;</a>
						<div class="form-container">
							<form action="/CA2-JAD/AddBooksServlet" method="post"
								enctype="multipart/form-data">
								<div class="form-group">
									<label for="title">Title:</label> <input type="text" id="title"
										name="title" required>
								</div>
								<div class="form-group">
									<label for="author">Author:</label> <input type="text"
										id="author" name="author" required>
								</div>
								<div class="form-group">
									<label for="isbn">ISBN:</label> <input type="text" id="isbn"
										name="isbn" pattern="\d{3}-\d{10}"
										placeholder="Enter ISBN (e.g., 978-0525576129)" required>
								</div>
								<div class="form-group">
									<label for="description">Description:</label>
									<textarea id="description" name="description" required
										style="height: 150px; width: 100%; max-width: 500px;"></textarea>
								</div>
								<div class="form-group">
									<label for="price">Price:</label> <input type="number"
										id="price" name="price" step="0.01" required
										style="height: 40px; width: 70%; max-width: 500px;" min="1">
								</div>
								<div class="form-group">
									<label for="genre">Genre:</label> <input type="text" id="genre"
										name="genre" required>
								</div>
								<div class="form-group">
									<label for="publisher">Publisher:</label> <input type="text"
										id="publisher" name="publisher" required>
								</div>
								<div class="form-group">
									<label for="publication_date">Publication Date:</label> <input
										type="date" id="publication_date" name="publication_date"
										required style="height: 40px; width: 70%; max-width: 500px;">
								</div>
								<div class="form-group">
									<label for="rating">Rating:</label> <input type="number"
										id="rating" name="rating" required
										style="height: 40px; width: 70%; max-width: 500px;" min="0"
										max="5">
								</div>
								<div class="form-group">
									<label for="quantity">Quantity:</label> <input type="number"
										id="quantity" name="quantity" required
										style="height: 40px; width: 70%; max-width: 500px;" min="1">
								</div>
								<div class="form-group">
									<label for="image">Image:</label> <input type="file" id="image"
										name="image" accept="image/*" required>
								</div>
								<button type="submit" class="btn btn-primary">Add Book</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<h2 class="bookHeader">Inventory List</h2>
		<div class="center-container">
		<div class="button1-container">
		<div class="genre-buttons">
		<form method="get">
			<input type="hidden" name="sortBy" value="best"> <input
				type="submit" value="Best Selling Books" class="genre-button">
		</form>
		<form method="get">
			<input type="hidden" name="sortBy" value="least"> <input
				type="submit" value="Least Selling Books" class="genre-button">
		</form>
		</div>
		</div>
		</div>

		<%
		List<Object[]> bookList = (List<Object[]>) request.getAttribute("bookList");

		// Sort the bookList based on the "sortBy" parameter
		String sortBy = request.getParameter("sortBy");
		if (sortBy != null && !sortBy.isEmpty()) {
			if (sortBy.equals("best")) {
				bookList.sort((book1, book2) -> {
			return Integer.compare((int) book1[7], (int) book2[7]); // Descending order
				});
			} else if (sortBy.equals("least")) {
				bookList.sort((book1, book2) -> {
			return Integer.compare((int) book2[7], (int) book1[7]); // Ascending order
				});
			}
		}
		%>

		<%
		if (bookList == null || bookList.isEmpty()) {
		%>
		<p class="result">No results found</p>
		<%
		} else {
		%>
		<table class="table center-table">
			<thead>
				<tr>
					<th>Title</th>
					<th>Author</th>
					<th>Stock</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Object[] book : bookList) {
				%>
				<tr>
					<td><%=book[3]%></td>
					<td><%=book[4]%></td>
					<td><%=book[7]%></td>
					<td>
						<div class="button-container">
							<a href="#popup_<%=book[0]%>" class="btn btn-primary edit-btn">Edit</a>
						</div>
						<div class="button-container">
							<form action="/CA2-JAD/DeleteBookServlet" method="post">
								<input type="hidden" name="bookId" value="<%=book[0]%>">
								<button type="submit" class="btn btn-danger delete-btn">Delete</button>
							</form>
						</div>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		%>
		<%
		for (Object[] book : bookList) {
		%>
		<div id="popup_<%=book[0]%>" class="popup">
			<div class="popup-content">
				<h2>Edit Book</h2>
				<a href="" class="close-btn">&times;</a>
				<div class="form-container">
					<form action="/CA2-JAD/EditBooksServlet" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="bookId" value="<%=book[0]%>">
						<div class="form-group">
							<label for="title">Title:</label> <input type="text" id="title"
								name="title" value="<%=book[3]%>" required>
						</div>
						<div class="form-group">
							<label for="author">Author:</label> <input type="text"
								id="author" name="author" value="<%=book[4]%>" required>
						</div>
						<div class="form-group">
							<label for="isbn">ISBN:</label> <input type="text" id="isbn"
								name="isbn" pattern="\d{3}-\d{10}"
								placeholder="Enter ISBN (e.g., 978-0525576129)"
								value="<%=book[10]%>" required>
						</div>
						<div class="form-group">
							<label for="description">Description:</label>
							<textarea id="description" name="description" required
								style="height: 150px; width: 100%; max-width: 500px;"><%=book[2]%></textarea>
						</div>
						<div class="form-group">
							<label for="price">Price($):</label> <input type="number"
								id="price" name="price" step="0.01"
								style="height: 40px; width: 70%; max-width: 500px;" min="1"
								value="<%=book[6]%>" required>
						</div>
						<div class="form-group">
							<label for="genre">Genre:</label> <input type="text" id="genre"
								name="genre" value="<%=book[5]%>" required>
						</div>
						<div class="form-group">
							<label for="publisher">Publisher:</label> <input type="text"
								id="publisher" name="publisher" value="<%=book[8]%>" required>
						</div>
						<div class="form-group">
							<label for="publication_date">Publication Date:</label> <input
								type="date" id="publication_date" name="publication_date"
								style="height: 40px; width: 70%; max-width: 500px;"
								value="<%=book[9]%>" required>
						</div>
						<div class="form-group">
							<label for="quantity">Quantity:</label> <input type="number"
								id="quantity" name="quantity"
								style="height: 40px; width: 70%; max-width: 500px;" min="1"
								value="<%=book[7]%>" required>
						</div>
						<div class="form-group">
							<label for="rating">Rating:</label> <input type="number"
								id="rating" name="rating"
								style="height: 40px; width: 70%; max-width: 500px;" min="0"
								max="5" value="<%=book[11]%>" required>
						</div>
						<div class="form-group">
							<label for="image">Current Image:</label> <img src="<%=book[1]%>"
								alt="Current Book Image" style="max-width: 200px;">
						</div>
						<div class="form-group">
							<label for="newImage">New Image:</label> <input type="file"
								id="newImage" name="newImage" accept="image/*">
						</div>
						<div class="form-group">
							<input type="submit" value="Save Changes" class="btn btn-primary">
						</div>
					</form>
				</div>
			</div>
		</div>
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
	padding: 15px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
}

.edit-btn {
	display: inline-block;
	margin-left: 10px;
	background-color: #008000
}

.popup {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: none;
	justify-content: center;
	align-items: center;
	z-index: 9999;
}

.popup:target {
	display: flex;
}

.popup.show {
	display: block;
}

.popup-content {
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	height: 600px;
	width: 500px;
	position: relative;
	text-align: center;
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 20px;
	font-size: 30px;
	color: #FF0000;
	text-decoration: none;
	cursor: pointer;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	font-weight: bold;
}

.form-group input[type="text"] {
	width: 100%;
	padding: 5px;
}

.form-group input[type="submit"] {
	padding: 5px 15px;
	background-color: #007bff;
	color: #fff;
	border: none;
	cursor: pointer;
}

.form-container {
	height: 500px;
	overflow-y: auto;
}

.button-container {
	float: left;
	margin-left: 5%; /* Optional: Add some spacing between the buttons */
}

.add-book-button {
	position: relative;
	margin-bottom: 3%;
	margin-top: 1%;
}

.add-book-btn {
	display: inline-block;
	padding: 10px 20px;
	border-radius: 10px;
	background-color: #007bff;
	color: #fff;
	cursor: pointer;
}

.add-book-toggle {
	display: none;
}

.add-book-popup {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: none;
	justify-content: center;
	align-items: center;
	z-index: 9999;
}

.add-book-toggle:checked+.add-book-popup {
	display: flex;
}

.add-book-popup-content {
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	height: 600px;
	width: 500px;
	position: relative;
	text-align: center;
}

.book-close-btn {
	position: absolute;
	top: 10px;
	right: 20px;
	font-size: 30px;
	color: #FF0000;
	text-decoration: none;
	cursor: pointer;
}

.center-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 15vh; /* Adjust this if needed to control vertical centering */
}
.button1-container {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.genre-buttons {
  display: flex;
  margin-top: 10px;
}

.genre-button {
  padding: 8px 16px;
  margin-right: 10px;
  background-color: #f2f2f2;
  color: #333;
  text-decoration: none;
  border-radius: 4px;
}

.genre-button:focus,
.genre-button:active,
.genre-button:hover {
  background-color: #666;
  color: #fff;
}


</style>



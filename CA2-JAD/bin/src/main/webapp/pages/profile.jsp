<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%
String id = (String) session.getAttribute("sessUserId");
String userName = (String) session.getAttribute("sessUserName");
String userRole = (String) session.getAttribute("sessUserRole");
//Handle logout request
String logout = request.getParameter("logout");
if (logout != null && logout.equals("true")) {
	session.invalidate(); // Invalidate the session
	response.sendRedirect("./login.jsp"); // Redirect to login.jsp
	return; // Terminate further processing of the page
}
%>

<%
if (id == null) {
	// Redirect to login page or display an error message
	response.sendRedirect("login.jsp");
} else {
	// Retrieve user details from the database for the logged-in user
	List<Object[]> users = new ArrayList<>();
	try {
		// Establish a database connection
		String connURL = "jdbc:mysql://localhost/novelnotion_db?user=root&password=password&serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(connURL);
		request.setAttribute("dbConnection", connection);
		Statement statement = connection.createStatement();
		// Execute the query to retrieve the logged-in user from the database
		String query = "SELECT * FROM users WHERE username='" + userName + "'";
		ResultSet resultSet = statement.executeQuery(query);
		// Process the result set and populate the user list
		while (resultSet.next()) {
	int userId = resultSet.getInt("user_id");
	String username = resultSet.getString("username");
	String email = resultSet.getString("email");
	String fname = resultSet.getString("fname");
	String lname = resultSet.getString("lname");
	String password = resultSet.getString("password");
	// Create an array of user data
	Object[] userData = { userId, username, email, fname, lname, password };
	// Add the user data array to the list
	users.add(userData);
		}
		// Close the database connection
		resultSet.close();
		statement.close();
		connection.close();
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
	// Store the user list in a request attribute
	request.setAttribute("userList", users);
	// Render the profile information and edit form
%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>

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
                        <li class="nav-item">
                			<a class="nav-link" href="cartItems.jsp">Cart items</a>
            			</li>
                        <li class="nav-item">
                        <a class="nav-link" href="profile.jsp">Profile</a>
                        </li>
                        <li class="nav-item">
                        <a class="nav-link" href="?logout=true">Log out</a>
                        </li>
                        <%
                        } else if (userRole != null && userRole.equals("admin")) {
                        %>
                        <li class="nav-item"><a class="nav-link" href="adminpanel.jsp">Inventory</a></li>
                        <li class="nav-item"><a class="nav-link" href="userInfo.jsp">User Info
                                </a></li>
                        <li class="nav-item">
                        <a class="nav-link" href="?logout=true">Log out</a>
                        </li>
                        <%
                        } else {
                        %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Log
                                In</a></li>
                        <li class="nav-item"><a class="nav-link" href="signUp.jsp">Sign Up</a>
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

		<div class="container">
			<h2 class="profile-header">Your Profile</h2>
			<form class="profile-form" action="../functions/updateProfile.jsp"
				method="post">
				<%
				for (Object[] user : users) {
				%>
				<input type="hidden" name="userId" value="<%=user[0]%>">
				<div class="form-group">
					<label for="username">Username:</label> <input type="text"
						class="form-control" name="username" value="<%=user[1]%>"
						required>
				</div>
				<div class="form-group">
					<label for="email">Email:</label> <input type="text"
						class="form-control" name="email" value="<%=user[2]%>" required>
				</div>
				<div class="form-group">
					<label for="fname">First Name:</label> <input type="text"
						class="form-control" name="fname" value="<%=user[3]%>" required>
				</div>
				<div class="form-group">
					<label for="lname">Last Name:</label> <input type="text"
						class="form-control" name="lname" value="<%=user[4]%>" required>
				</div>
				<div class="form-group">
					<label for="password">Password:</label> <input type="password"
						class="form-control" name="password" value="<%=user[5]%>"
						required>
				</div>
				<!-- Add additional input fields for changing password or any other personal information -->
				<%
				}
				}
				%>

				<input type="submit" class="btn btn-primary" value="Save Changes">
			</form>
		</div>
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
	max-width: 500px;
	margin: 0 auto;
	padding: 20px;
}

.profile-header {
	text-align: center;
	margin-bottom: 20px;
}

.profile-form .form-group {
	margin-bottom: 10px;
}

.profile-form label {
	display: block;
	font-weight: bold;
}

.profile-form .form-control {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.profile-form .btn {
	display: block;
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.profile-form .btn:hover {
	background-color: #0069d9;
}
</style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Login Page</title>
<link
	href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap"
	rel="stylesheet" />
</head>
<!-- Back button at top left of screen -->
<ul>
	<li><a href="landing.jsp">Back to home</a></li>
</ul>
<body>
	<div class="main">
		<input type="checkbox" id="chk" aria-hidden="true" />
		<div class="customer">
			<form action="/CA2-JAD/VerifyUserServlet" name="customerLoginForm"
				method="post">
				<label for="chk" aria-hidden="true">Customer</label> <input
					type="text" name="loginid" placeholder="Username" /> <input
					type="password" name="password" placeholder="Password" />
				<button type="submit">Sign in as customer</button>
			</form>
			<a class="signUpPage" href="signUp.jsp">Don't have an account? <span
				class="signUpBtn">Sign Up</span></a>
		</div>
		<div class="admin">
			<form action="/CA2-JAD/VerifyUserServlet" name="adminLoginForm"
				method="post">
				<label for="chk" aria-hidden="true">Admin</label> <input type="text"
					name="loginid" placeholder="Username" /> <input type="password"
					name="password" placeholder="Password" />
				<button type="submit" class="adminBtn">Login as Admin</button>
			</form>
		</div>
	</div>
	<button class="continueGuestButton"
		onclick="window.location.href='landing.jsp?role=guest'">Continue
		as Guest</button>
</body>
</html>


<style>
@import
	url("https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap")
	;

body {
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
.title {
	margin-top: 0;
}

.back-button {
	position: absolute;
	top: 3vh;
	left: 2vw;
	font-size: 32px;
}

/* CSS properties for navigation */
ul {
	position: absolute;
	top: 3vh;
	left: 2vw;
	font-size: 32px;
	list-style: none;
	margin: 0;
	padding: 0;
	display: flex;
}

ul li {
	margin-right: 1rem;
}

ul li:last-child {
	margin-right: 0;
}

ul li a {
	color: #fff;
	text-decoration: none;
	display: flex;
	justify-content: center;
	align-items: flex-start;
}

/* Hover effect for the link */
ul li a:hover {
	border-bottom: 2px solid #fff;
	padding-bottom: 5px;
}

body {
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	font-family: "Kaushan Script", cursive;
	background-image: url(../images/bookstoreBG.jpg);
	background-repeat: no-repeat;
	background-size: cover;
	/* Resize the background image to cover the entire container */
}

.main {
	width: 350px;
	height: 500px;
	background: red;
	overflow: hidden;
	background: linear-gradient(to bottom, #383557, #373364, #2b2b3d);
	border-radius: 10px;
	box-shadow: 5px 20px 50px #000;
}

#chk {
	display: none;
}

.customer {
	position: relative;
	width: 100%;
	height: 100%;
}

label {
	color: #fff;
	font-size: 2.3em;
	justify-content: center;
	display: flex;
	margin: 60px;
	font-weight: bold;
	cursor: pointer;
	transition: 0.5s ease-in-out;
}

.customer label:hover {
	border-bottom: 1px solid #ffffff;
	padding-bottom: 5px;
}

input {
	width: 60%;
	height: 20px;
	background: #e0dede;
	justify-content: center;
	display: flex;
	margin: 20px auto;
	padding: 10px;
	border: none;
	outline: none;
	border-radius: 5px;
}

button {
	width: 60%;
	height: 40px;
	margin: 10px auto;
	justify-content: center;
	display: block;
	color: #fff;
	background: #573b8a;
	font-size: 1em;
	font-weight: bold;
	margin-top: 30px;
	font-family: "Jost", sans-serif;
	outline: none;
	border: none;
	border-radius: 5px;
	transition: 0.2s ease-in;
	cursor: pointer;
}

button:hover {
	background: #6d44b8;
}

.signUpPage {
	color: #fff;
	font-size: 1em;
	margin-top: 30px;
	font-family: "Jost", sans-serif;
	outline: none;
	border: none;
	border-radius: 5px;
	transition: 0.2s ease-in;
	cursor: pointer;
	text-decoration: none;
	display: flex;
	justify-content: center;
	align-items: flex-start;
}

/*Underline effect on signup button*/
.signUpBtn {
	margin-left: 6px;
	border-bottom: 1px solid #ffffff;
	padding-bottom: 5px;
}

/*Hover effect for the sign up button*/
.signUpBtn:hover {
	border-bottom: 3px solid #ffffff;
	transform: scale(1.05);
	padding-bottom: 5px;
}

.continueGuestButton {
	position: absolute;
	bottom: 3%;
	right: 50%;
	font-size: 20px;
	transform: translateX(50%);
	background-color: #573b8a;
	color: #ffffff;
	border: none;
	cursor: pointer;
	width: 25%;
	height: 7%;
}

.continueGuestButton:hover {
	background-color: #6d44b8;
}

.admin {
	height: 460px;
	background: #eee;
	border-radius: 60%/10%;
	transform: translateY(-180px);
	transition: 0.8s ease-in-out;
}

.admin label {
	color: #573b8a;
	transform: scale(0.6);
}

/*Hover effect that gives underline below the label that immediately increases length upon hover*/
.admin label:hover {
	border-bottom: 2px solid #573b8a;
	padding-bottom: 5px;
}

#chk:checked ~ .admin {
	transform: translateY(-500px);
}

#chk:checked ~ .admin label {
	transform: scale(1);
}

#chk:checked ~ .customer label {
	transform: scale(0.6);
}
</style>

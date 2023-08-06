<%
String id = (String) session.getAttribute("sessUserId");
String userRole = (String) session.getAttribute("sessUserRole");

//Handle logout request
String logout = request.getParameter("logout");
if (logout != null && logout.equals("true")) {
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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
</body>
</html>
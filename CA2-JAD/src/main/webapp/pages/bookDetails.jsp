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
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ include file="../functions/bookList.jsp" %>

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
      crossorigin="anonymous"
    />
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

<div class="container">
  <h1 class="detailsHeading">Book Details</h1>
  <div class="row">
    <div class="col-md-4">
      <img src="<%= selectedBook[1] %>" class="img-fluid book-cover" alt="Book Cover" onerror="this.src='../images/book1.jpg'" />
      <p class="book-quantity">
        <% 
        int quantityLeft = (int) selectedBook[7];
        if (quantityLeft < 10) {
            %><span class="less-stock"><%= quantityLeft %> copies left - order soon</span><% 
          } else {
              %><span class="in-stock">In Stock - <%= quantityLeft %> copies left</span><% 
          }
          %>      </p>
    </div>
    <div class="col-md-8 w-50">
      <h2 class="book-title"><%= selectedBook[3] %></h2>
      <p class="book-author">By <%= selectedBook[4] %></p>
      <p class="book-price">Price: $<%= selectedBook[6] %></p>
      <p class="book-genre">Genre: <%= selectedBook[5] %></p>
      <p class="book-description">Description: <%= selectedBook[2] %></p>
      <p class="book-publisher">Publisher: <%= selectedBook[8] %></p>
      <p class="book-publication_date">Publication-Date: <%= selectedBook[9] %></p>
      <p class="book-ISBN">ISBN-13: <%=selectedBook[10] %></p>
      <p class="book-ISBN">Rating: <%=selectedBook[11] %></p>
		<form action="../functions/addToCart.jsp" method="POST">
  <input type="hidden" name="bookId" value="<%= selectedBook[0] %>" />
  <div class="add-to-cart">
    <div class="quantity">
      <label for="quantityInput">Quantity:</label>
      <input type="number" id="quantityInput" name="quantity" min="1" value="1" />
    </div>
    <% if (userRole != null && userRole.equals("member")) { %>
      <button type="submit" class="btn btn-primary">Add to Cart</button>
    <% } else { %>
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
        Add to Cart
      </button>
    <% } %>
  </div>
</form>

    </div>
  </div>
</div>

<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">Log In Required</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Please log in to your account to add items to the cart.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <a href="login.jsp" class="btn btn-primary">Log In</a>
      </div>
    </div>
  </div>
</div>


    <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
      integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
      integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
      crossorigin="anonymous"
    ></script>
  </body>
</html>



<style>
    @import url("https://fonts.googleapis.com/css2?family=DM+Sans&display=swap");
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

  /* Height for devices larger than 576px */

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

  .detailsHeading{
    margin-top: 40px;
    margin-bottom: 40px;
    /* make css code shorter but same effect */
  }
  /* styles.css */

.container {
    margin-top: 20px;
  }
  
  .book-cover {
    max-width: 100%;
    height: 40vh;
    margin-bottom:5px;
  }
  
  .book-title {
    font-size: 48px;
    font-weight: 700;
    margin-bottom: 10px;
  }
  
  .book-author {
    font-style: italic;
    color: #777;
  }
  
  .book-price {
    font-weight: bold;
    margin-bottom: 10px;
  }
  
  .book-description {
    margin-bottom: 10%;
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

.less-stock {
    color: red;
  }
  
  .in-stock {
    color: green;
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
    margin-left: 20px;
    margin-bottom: 20px;
  }
</style>

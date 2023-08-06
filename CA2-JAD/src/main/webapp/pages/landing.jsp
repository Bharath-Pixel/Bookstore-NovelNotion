<%@ include file="../components/header.jsp" %>
<%@ include file="../functions/bookList.jsp" %>
<%@ page import="model.Book" %>


        <!-- Navbar -->
    <div class="welcomesection">
      <h1 class="welcome-title my-5">Welcome to Novel Notion!</h1>
      <div class="search mt-5 w-50">
        <form action="" method="GET" id="searchForm">
          <input
            type="text"
            class="form-control"
            name="search"
            placeholder="Search..."
          />
          <select
            name="searchBy"
            class="form-select text-center border-3 border-primary rounded-5"
            id="search"
          >
            <option value="title" class="text-start" selected>By Title</option>
            <option value="author" class="text-start">By Author</option>
          </select>
        </form>
      </div>
    </div>
   

<section>
    <div class="container">
        <h2 class="bookHeader">Our collection</h2>
        <div class="genre-filter">
            <div class="genre-buttons">
                <a href="?genre=all" class="genre-button">All</a>
                <a href="?genre=romance" class="genre-button">Romance</a>
                <a href="?genre=mystery" class="genre-button">Mystery</a>
                <a href="?genre=fiction" class="genre-button">Fiction</a>
                <a href="?genre=historical fiction" class="genre-button">Historical Fiction</a>
                
          	</div>
        </div>
        <% 
            String selectedGenre = request.getParameter("genre");
            List<Object[]> bookList = (List<Object[]>) request.getAttribute("bookList");

            if (bookList.isEmpty()) { 
        %>
        <p class="result">No results found</p>
        <% } else { %>
        <div class="row">
            <% for (Object[] book : bookList) { %>
                <% 
                    String genre = book[5].toString();
                    if (selectedGenre == null || selectedGenre.equals("all") || genre.equalsIgnoreCase(selectedGenre)) { 
                %>
                    <div class="col-md-4 book-card">
                        <a href="bookDetails.jsp?bookId=<%= book[0] %>" class="card-link">
                            <div class="card">
                                <img src="<%= book[1] %>" class="card-img-top" alt="Book Cover" onerror="this.src='../images/book1.jpg'" />
                                <div class="card-body">
                                    <h5 class="card-title"><%= book[3] %></h5>
                                    <p class="card-author">By <%= book[4] %></p>
                                    <p class="card-text">$<%= book[6] %></p>
                                </div>
                            </div>
                        </a>
                    </div>
                <% } %>
            <% } %>
        </div>
        <% } %>
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
    -webkit-animation: fadein 1.5s; /* Safari, Chrome and Opera > 12.1 */
       -moz-animation: fadein 1.5s; /* Firefox < 16 */
        -ms-animation: fadein 1.5s; /* Internet Explorer */
         -o-animation: fadein 1.5s; /* Opera < 12.1 */
            animation: fadein 1.5s;
}

@keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Firefox < 16 */
@-moz-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Safari, Chrome and Opera > 12.1 */
@-webkit-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Internet Explorer */
@-ms-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Opera < 12.1 */
@-o-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

header {
	background: transparent;
	color: #fff;
	padding: 1rem;
	background-image: url(../images/bookstoreBG.jpg);
	background-size: cover;
	background-position: center;
	background-attachment: fixed;
	height: 70vh;
}

/* Height for devices larger than 576px */
.navbar .nav-link {
	color: #fff !important;
}

a{
	text-decoration: none;
	color: #000000;
}

a:hover{
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

section {
	margin-bottom: 3rem;
}

h2 {
	margin-top: 0;
}

.navbar-nav {
	margin-left: auto;
}

  .welcomesection{
    margin-top: 1% ;
    text-align: center;
  }
  .search {
    position: relative;
    box-shadow: 0 0 40px rgba(51, 51, 51, 0.1);
    border-radius: 50px;
    margin: 0 auto;
    width: 50%;
    height: 60px;
    margin-top: 20px;
  }

  .search input {
    height: 60px;
    text-indent: 25px;
    border: 2px solid #d6d4d4;
    border-radius: 50px;
  }

  .search input:focus {
    box-shadow: none;
    border: 2px solid rgb(145, 34, 235);
  }

  .search .form-select {
    font-family: "DM Sans", sans-serif;
    position: absolute;
    top: 5px;
    right: 5px;
    height: 50px;
    width: auto;
  }

.container {
	text-align: center;
	margin-top: 5%;
}

.bookHeader {
	margin-bottom: 5%
}

.card {
	justify-content: center;
	display: flex;
	margin: 0 auto;
	margin-top: 5%;
	margin-bottom: 15%;
	border: none;
	transition: transform 0.3s ease-in-out;
	cursor: pointer;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.card-img-top {
	margin-top: 5%;
	padding: 5%;
	height: 300px;
	max-width: 100%;
	object-fit: contain;
	object-position: center top;
	transition: transform 0.3s ease-in-out;
}

.genre-filter {
    margin-top: 20px;
    text-align: center;
  }

  .filter-label {
    font-weight: bold;
  }

  .genre-buttons {
    margin-top: 10px;
  }

  .genre-button {
    display: inline-block;
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
footer {
	background-color: #555;
	color: #fff;
	text-align: center;
	padding: 1rem;
}
</style>
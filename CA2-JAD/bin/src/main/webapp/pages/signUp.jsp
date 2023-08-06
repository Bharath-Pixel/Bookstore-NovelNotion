<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Sign Up Page</title>
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap"
    />
  </head>
  <body>
    <div class="main">
      <ul>
        <li><a href="login.jsp">Back to Login</a></li>
      </ul>
      <h1 class="title">Sign Up</h1>
      <div class="form-container">
        <form action="/CA2-JAD/SignUpServlet" method="post">
          <div class="name-container">
            <div>
              <input
                type="text"
                id="fname"
                name="fname"
                placeholder="First Name"
                required
              />
            </div>
            <div>
              <input
                type="text"
                id="lname"
                name="lname"
                placeholder="Last Name"
                required
              />
            </div>
          </div>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Username"
            required
          />
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Password"
            required
          />

          <input
            type="email"
            id="email"
            name="email"
            placeholder="Email"
            required
          />

          <button type="submit">Sign Up as Customer</button>
        </form>
      </div>

      <a class="signUpPage" href="login.jsp"
        >Already have an account? <span class="signUpBtn">Log In</span></a
      >
    </div>
  </body>
</html>

<style>
  /* Add your custom styles here */
  @import url("https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap");

  .title {
    color: white;
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
  }

  .form-container {
    margin-top: 20px;
    width: 100%;
    overflow: hidden;
  }

  form {
    margin: 0 auto;
    width: 90%;
  }

  .main {
    width: 400px;
    height: 600px;
    background: linear-gradient(to bottom, #383557, #373364, #2b2b3d);
    border-radius: 10px;
    box-shadow: 5px 20px 50px #000;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  label {
    display: none;
  }

  input {
    width: 100%;
    height: 40px;
    background: #e0dede;
    margin-bottom: 15px;
    padding: 5px;
    border: none;
    outline: none;
    border-radius: 5px;
    font-family: "Jost", sans-serif;
    font-size: 14px;
  }

  .name-container {
    display: flex;
  }

  .name-container input {
    width: auto;
    margin-right: 50px;
  }

  button {
    width: 100%;
    height: 40px;
    color: #fff;
    background: #573b8a;
    font-size: 1em;
    font-weight: bold;
    margin-top: 30px;
    margin-bottom: 30px;
    outline: none;
    border: none;
    font-family: "Jost", sans-serif;
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
    outline: none;
    border: none;
    border-radius: 5px;
    transition: 0.2s ease-in;
    cursor: pointer;
    font-family: "Jost", sans-serif;
    text-decoration: none;
  }

  /*Underline effect on log in button*/
  .signUpBtn {
    margin-left: 6px;
    border-bottom: 1px solid #ffffff;
    padding-bottom: 5px;
  }

  /*Hover effect for the log in button*/
  .signUpBtn:hover {
    border-bottom: 3px solid #ffffff;
    transform: scale(1.05);
    padding-bottom: 5px;
  }
</style>

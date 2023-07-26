<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Receipt</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style type="text/css">
      @import url("https://fonts.googleapis.com/css2?family=DM+Sans&display=swap");
      body {
        background-image: url(./images/bookstoreBG.jpg);
        background-repeat: no-repeat;
        background-size: cover; /* Resize the background image to cover the entire container */
        font-family: "DM Sans", sans-serif;
        display: flex; /* Use flexbox to center the container */
        justify-content: center; /* Horizontally center the container */
        align-items: center; /* Vertically center the container */
        height: 100vh; /* Set the body to full viewport height */
    }
    .container {
        max-width: 600px;
        background-color: #f7f7f7;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
        table { 
            border: 0; 
        }
        table td { 
            padding: 5px; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-4">Payment Done. Thank you for purchasing our products</h1>
        <br/>
        <h2 class="text-center mb-3">Receipt Details:</h2>
        <table class="table table-bordered">
            <!-- Receipt Details -->
            <tr>
                <td><b>Merchant:</b></td>
                <td>Company ABC Ltd.</td>
            </tr>
            <tr>
                <td><b>Payer:</b></td>
                <td>${payer.firstName} ${payer.lastName}</td>      
            </tr>
            <tr>
                <td><b>Description:</b></td>
                <td>${transaction.description}</td>
            </tr>
            <tr>
                <td><b>Subtotal:</b></td>
                <td>${transaction.amount.details.subtotal} SGD</td>
            </tr>
            <tr>
                <td><b>Shipping:</b></td>
                <td>${transaction.amount.details.shipping} SGD</td>
            </tr>
            <tr>
                <td><b>Tax:</b></td>
                <td>${transaction.amount.details.tax} SGD</td>
            </tr>
            <tr>
                <td><b>Total:</b></td>
                <td>${transaction.amount.total} SGD</td>
            </tr>                    
        </table>
    </div>
</body>
</html>

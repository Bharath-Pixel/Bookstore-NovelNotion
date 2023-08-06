<!DOCTYPE html>
<html>
<head>
    <title>Customer Chart</title>
     <style>
    .chart-container {
        display: flex;
        align-items: flex-end;
        justify-content: center;
        height: 400px;
    }

    .bar-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-right: 10px;
    }

    .bar {
        background-color: #007bff;
        width: 20px;
        height: 100px;
        margin-bottom: 5px;
    }

    .max-bar {
        background-color: #28a745;
        width: 20px;
        height: 100px;
        margin-bottom: 5px;
    }

    .bar-text {
        font-size: 14px;
        writing-mode: horizontal-tb; /* Set the text to be horizontal */
        text-align: center; /* Center the text horizontally */
    }
</style>
</head>
<body>
   <div class="chart-container">
			<%= request.getAttribute("chartHTML") %>
		</div>
</body>
</html>

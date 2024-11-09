<%@page language="java  contentType="text/html; charset=ISO-8859-1"%>
<!Doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Institute Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/foodimage.jpg'); 
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            color: #333;
        }
        .container {
            background:rgb(255 255 255 / 43%);;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            height: 17vw;
        }
        .d1{
           display: flex; 
           justify-content: center;
        }
        button{
            height: 4vw;
            width: 7vw;
            border-radius: 10px;
            border: none;
            color: white;
            background-color: #86a509;
            font-size: larger;
            font-family: math;
        }
        a{
            margin: 10px 105px;
            color: #0066cc;
            text-decoration: none;
            font-size: 18px;
        }
        a:hover {
            text-decoration: underline;
        }
        h1{
            font-family: math;
            color: #cc6d00;
            font-size: 3vw;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Food Ordering</h1>
        <div class="d1">
            <a href="admin.jsp"><button>Admin</button></a>
            <a href="login.jsp"><button>Login</button></a>
        </div>
    </div>
</body>
</html>

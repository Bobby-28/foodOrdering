<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }
        body{
            background: url('images/images.jpg');
            background-position: center;
            background-size: cover;
            min-height: 100vh;
            width: 100%;
        }
        .container{
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-box{
            position: relative;
            width: 400px;
            height: 550px;
            border: 2px solid rgba(255, 255, 255);
            border-radius: 20px;
            backdrop-filter: blur(15px);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .form-box h2{
            color: #fff;
            text-align: center;
            font-size: 32px;
        }
        .form-box .input-box{
            position: relative;
            margin: 30px 0;
            width: 310px;
            border-bottom: 2px solid #fff;
        }
        .form-box .input-box input{
            width: 100%;
            height: 45px;
            background: transparent;
            border: none;
            outline: none;
            padding: 0 20px 0 5px;
            color: #fff;
            font-size: 16px;
        }
        input::placeholder{
            color: #fff;
        }
        .btn{
            color: #fff;
            background: blue;
            width: 100%;
            height: 50px;
            border-radius: 5px;
            outline: none;
            border: none;
            font-size: 17px;
            cursor: pointer;
            box-shadow: 3px 0 10px rgba(0,0,0,.5);
        }
        .group{
            display: flex;
            justify-content: space-between;
        }
        .group span a{
            color: #fff;
            position: relative;
            top: 10px;
            text-decoration: none;
            font-weight: 500;
        }
        .group a:focus{
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
			String url = "jdbc:mysql://localhost:3306/food_ordering";
			String user = "root";
			String urlpassword = "aditya(2003)";

			Connection conn = null;
			PreparedStatement pstmt = null;
            HttpSession session1 = request.getSession();
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            if (name != null && password != null && phone != null && address != null){
            	try{
            		Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, urlpassword);
                    
                    String insertQuery = "INSERT INTO users (name, password, address, email, phone) VALUES (?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setString(1, name);
                    pstmt.setString(2, password); 
                    pstmt.setString(3, address);
                    pstmt.setString(4, email);
                    pstmt.setString(5, phone);
                    pstmt.executeUpdate();
                    out.println("<p>User registered successfully!</p>");
            	}catch (SQLException e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                } catch (ClassNotFoundException e) {
                    out.println("<p class='error'>Driver not found: " + e.getMessage() + "</p>");
                } finally {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            }
 %>
    <div class="container">
        <div class="form-box">
            <form action="register.jsp" method="post">
                <h2>Register</h2>
                <div class="input-box">
                    <input type="text" name="name" placeholder="Username">
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Password:">
                </div>
                <div class="input-box">
                    <input type="text" name="email" placeholder="Email:">
                </div>
                <div class="input-box">
                    <input type="text" name="address" placeholder="Address:">
                </div>
                <div class="input-box">
                    <input type="text" name="phone" placeholder="Phone Number:">
                </div>
                <div class="button">
                    <input type="submit" class="btn" value="Register">
                </div>
                <div class="group">
                    <span><a href="index.jsp">Go Back</a></span>
                    <span><a href="login.jsp">Login</a></span>
                </div>
            </form>
        </div>
    </div>
</body>
</html>



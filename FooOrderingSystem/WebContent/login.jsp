<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login</title>
    <style>
        body{
            background: #011c1c;
        }
        .box{
            width: 60vw;
            height: 40vw;
            background: #043739;
            margin: 50px 18vw;
            display: flex;
            border-radius: 10px;
        }
        .d1{
            background: white;
            width: 30vw;
            margin: 0 16vw;
            background: #043739;
        }
        .d2 h1{
            text-align: center;
            color: white;
        }
        .d2 p{
            text-align: center;
            color: white;
        }
        .d2 h2{
            text-align: center;
            color: white;
        }
        .d3 input{
            width: 27vw;
            background: #043739;
            border:none;
            color: white;
        }
        .d3 p{
            color: white;
        }
        button{
            width: 27vw;
            padding: 0;
            margin: 0 8px;
            border-radius: 10px;
            background-color: #369db6;
            height: 30px;
            border: none;
        }
    </style>
</head>
<body>
<%
String username = request.getParameter("name");
String password = request.getParameter("password");

if (username != null && password != null) {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_ordering", "root", "aditya(2003)");

        String query = "SELECT * FROM users WHERE name=? AND password=?";
        ps = conn.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password);
        rs = ps.executeQuery();

        if (rs.next()) {
        	session.setAttribute("address", rs.getString("address"));
        	session.setAttribute("id", rs.getInt("id")); 
            session.setAttribute("username", username); 
            out.println("Session ID set: " + session.getAttribute("id"));
            response.sendRedirect("menu.jsp"); 
        } else {
            out.println("<p>Invalid username or password.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
}
%>
<div class="box">
    <div class="d1">
        <div class="d2">
            <h1>Login</h1>
            <p>Fast & easy product management</p>
            <h2>Welcome Back!</h2>
        </div>
        <div class="d3">
            <form action="login.jsp" method="post">
                <p>UserName:</p>
                <input type="text" name="name" required>
                <hr>
                <p>Password:</p>
                <input type="password" name="password" required>
                <hr>
                <button type="submit">Login</button>
            </form>
        </div>
        <a href="register.jsp">Register</a>
    </div>
</div>
</body>
</html>

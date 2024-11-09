<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
try{
	String name= request.getParameter("name");
	String password= request.getParameter("password");
	if(name.equals("admin")&&password.equals("@123")){
		response.sendRedirect("addItems.jsp");
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
<div class="box">
        <div class="d1">
            <div class="d2">
                <h1>Login</h1>
                <p>fast & easy product management</p>
                <h2>Welcome Back!</h2>
            </div>
            <div class="d3">
                <form action="admin.jsp" method="post">
                    <p>Admin Name:</p>
                    <input type="text" name="name">
                    <hr>
                    <p>Password:</p>
                    <input type="password" name="password">
                    <hr>
                    <br>
                    <br>
                    <button type="submit" Value="Login">Login</button>
                    <br>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
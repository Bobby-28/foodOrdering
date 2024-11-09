<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
try{
	String category= request.getParameter("category");
	String name= request.getParameter("name");
	String price= request.getParameter("price");
	String item_type= request.getParameter("item_type");
	String url= request.getParameter("url");
	
	String d_url="jdbc:mysql://localhost:3306/food_ordering";
	String urlName= "root";
	String urlPassword="aditya(2003)";
	String sql= "insert into item1(category,name, price, item_type, url) values(?,?,?,?,?)";
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn= DriverManager.getConnection(d_url, urlName, urlPassword);
	PreparedStatement ps= conn.prepareStatement(sql);
	ps.setString(1, category);
	ps.setString(2, name);
	ps.setString(3, price);
	ps.setString(4, item_type);
	ps.setString(5, url);
	ps.executeUpdate();
	out.println("<p>Item added successfully!</p>");
	
}catch(Exception e){
	e.printStackTrace();
}

%>
<div class="container">
        <div class="form-box">
            <form action="items.jsp" method="post">
                <h2>Add Items</h2>
                <div class="input-box">
                    <input type="text" name="category" placeholder="Category:">
                </div>
                <div class="input-box">
                    <input type="text" name="name" placeholder="Item Name:">
                </div>
                <div class="input-box">
                    <input type="text" name="price" placeholder="Price">
                </div>
                <div class="input-box">
                    <input type="text" name="item_type" placeholder="Type:">
                </div>
                <div class="input-box">
                    <input type="text" name="url" placeholder="Image Url:">
                </div>
                <div class="button">
                    <input type="submit" class="btn" value="Add">
                </div>
                <div class="group">
                    <span><a href="index.jsp">Go Back</a></span>
                    <span><a href="login.jsp">Login</a></span>
                </div>
            </form>
        </div>
    </div>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Order</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: sans-serif;
            box-sizing: border-box;
        }
        h1 {
            text-align: center;
            color: orangered;
            padding: 20px;
        }
        nav {
            background-color: orangered;
    		display: flex;
    		justify-content: space-around;
    		align-items: center;
        }
        nav p{
        	display: inline-block;
    		padding: 20px;
    		text-decoration: none;
    		color: #fff;
    		transition: 0.2s ease-in;
    		font-size: 18px;
        }
        nav span{
        	color: #fff;
        }
        nav input{
        	height: 6vh;
    		border: none;
    		border-radius: 10px;
    		width: 50vh;
    		font-size: large;
    		text-align: center;
        }
        nav ul {
            list-style-type: none;
            display: flex;
        }
        nav ul a {
            display: inline-block;
            padding: 20px;
            text-decoration: none;
            color: #fff;
            transition: 0.2s ease-in;
            font-size: 18px;
        }
        nav ul a:hover {
            background-color: orange;
            color: white;
        }
        .items {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            padding: 30px 20px;
            grid-row-gap: 30px;
        }
        .item img {
            background: #eef0f5;
			width: 254px;
			height: 160px;
			position: relative;
        }
        .item img:hover {
            transform: scale(1.04);
        }
        .item h4, .item h3, .item p {
        	margin-right: 6vw;
            text-align: center;
            padding: 5px;
        }
        .item button {
        	margin-left: 60px;
            padding: 5px 30px;
            border: none;
            outline: none;
            background-color: orangered;
            color: white;
            cursor: pointer;
            border-radius: 4px;
            font-size: 20px;
            display: block;
            transition: 0.2s all;
        }
        .item button:hover {
            transform: scale(1.08);
        }
        @media screen and (max-width: 1000px) {
            .items {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media screen and (max-width: 600px) {
            .items {
                grid-template-columns: 1fr;
            }
        }
        .search button{
        	background-color: orangered;
    		border: none;
        }
        .search img{
        	height: 27px;
        }
    </style>
</head>
<body>
    <h1>Food Order</h1>
    <nav>
    	<div class="search">
        <form action="menu.jsp" method="get">
            <input type="text" name="query" placeholder="Search for items..." required>
            <button type="submit"><img alt="search" src="images/searchf.png"></button>
        </form>
    	</div>
        <ul>
        	<li>
        	<% 
                String userName = (String) session.getAttribute("username");
                if (userName != null) {
            %>
                <p>Welcome, <%= userName %>!</p>
            <% 
                } 
            %>
        	</li>
            <li><a href="viewcart.jsp">Cart</a></li>
            <li><a href="orderHistory.jsp">History</a></li>
        </ul>
    </nav>

    <section class="items">
        <%
        String query = request.getParameter("query");
        

        try {
            String d_url = "jdbc:mysql://localhost:3306/food_ordering";
            String urlName = "root";
            String urlPassword = "aditya(2003)"; 
            String sql = "SELECT name, category, price, item_type, url FROM item";

            if (query != null && !query.trim().isEmpty()) {
                sql += " WHERE name LIKE ? OR category LIKE ?";
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(d_url, urlName, urlPassword);
            PreparedStatement pstmt = conn.prepareStatement(sql);

            if (query != null && !query.trim().isEmpty()) {
                pstmt.setString(1, "%" + query + "%");
                pstmt.setString(2, "%" + query + "%");
            }

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String category = rs.getString("category");
                double price = rs.getDouble("price");
                String item_type= rs.getString("item_type");
                String url= rs.getString("url");
        %>
        <div class="item">
            <img src="<%= url %>" alt="<%= name %>">
            <h3>Category:<%=category %></h3>
            <h3>Type:<%=item_type %></h3>
            <h3>Name:<%= name %></h3>
            <p>Price: <%= price %> Rs</p>
            <form action="addToCart.jsp" method="post">
    		<input type="hidden" name="itemName" value="<%= name %>">
    		<input type="hidden" name="itemPrice" value="<%= price %>">
    		<input type="hidden" name="itemImage" value="<%= url %>">
    		<button type="submit">Add to Cart</button>
			</form>
        </div>
        <%
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </section>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .order {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        button {
            background-color: orangered;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: darkorange;
        }
    </style>
</head>
<body>

<h2>Your Order History</h2>

<%
    int userId = (Integer) session.getAttribute("id"); 
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_ordering", "root", "aditya(2003)");

        String query = "SELECT * FROM orders WHERE user_id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            int orderId = rs.getInt("order_id");
            String itemName = rs.getString("item_name");
            double itemPrice = rs.getDouble("item_price");
            String orderDate = rs.getString("order_date");
%>
            <div class="order">
                <p><strong>Order ID:</strong> <%= orderId %></p>
                <p><strong>Item:</strong> <%= itemName %></p>
                <p><strong>Price:</strong> <%= itemPrice %> RS.</p>
                <p><strong>Order Date:</strong> <%= orderDate %></p>
                <form action="addToCart.jsp" method="post">
                    <input type="hidden" name="itemName" value="<%= itemName %>">
                    <input type="hidden" name="itemPrice" value="<%= itemPrice %>">
                    <button type="submit">Reorder</button>
                </form>
            </div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .confirmation {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
    </style>
</head>
<body>

<%
    String userName = request.getParameter("userName");
    String userAddress = request.getParameter("address");
    double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
    Integer userId = (Integer) session.getAttribute("id"); 
    List<String> cartItems = (List<String>) session.getAttribute("cartItems");
    List<String> cartPrices = (List<String>) session.getAttribute("cartPrices");
    List<String> cartImages= (List<String>) session.getAttribute("cartImages");
    List<Integer> cartQuantities= (List<Integer>) session.getAttribute("cartQuantities");
    

    if (userId == null || cartItems == null || cartPrices == null || cartQuantities==null || cartImages==null) {
        out.println("Session attributes are not set. Please add items to your cart and try again.");
        return; 
    }
    if (cartItems.size() != cartPrices.size()) {
        out.println("Cart items and prices do not match.");
        return; 
    }

    int itemCount = cartItems.size();
    int estimatedTime = itemCount * 10; 

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_ordering", "root", "aditya(2003)");

        String insertOrderQuery = "INSERT INTO orders (user_id, item_name, item_price, order_date) VALUES (?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(insertOrderQuery);

        for (int i = 0; i < cartItems.size(); i++) {
            pstmt.setInt(1, userId); 
            pstmt.setString(2, cartItems.get(i));
            pstmt.setDouble(3, Double.parseDouble(cartPrices.get(i))); 
            pstmt.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace(); 
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<div class="confirmation">
    <h2>Order Confirmation</h2>
    <p><strong>Name:</strong> <%= userName %></p>
    <p><strong>Address:</strong> <%= userAddress %></p>
    <p><strong>Total Price:</strong> <%= totalPrice %> RS.</p>
    <p><strong>Estimated Delivery Time:</strong> <%= estimatedTime %> minutes</p>
</div>

<%
    session.removeAttribute("cartItems");
    session.removeAttribute("cartPrices");
%>
<a href="menu.jsp">Continue Shopping</a>
</body>
</html>

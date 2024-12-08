<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Your Cart</title>
    <style>
        .box1{
        display: flex;
        justify-content: space-between;
    }
    .box1 img{
    		background: #eef0f5;
			width: 254px;
			height: 160px;
			position: relative;
    }
    button{
        height: 35px;
        width: 20vh;
        background-color: orangered;
        border: solid black;
        border-radius: 15px;
        color: white;
    }
    button:hover{
        background-color: orange;
    }
    button:active{
        background-color: rgb(165, 135, 78);
    }
    .box2{
        display: flex;
        justify-content: space-between;
        width: 30vw;
    }
    </style>
</head>
<body>
    <h2>Your Cart</h2>
    <%
        List<String> cartItems = (List<String>) session.getAttribute("cartItems");
        List<String> cartPrices = (List<String>) session.getAttribute("cartPrices");
        List<String> cartImages= (List<String>) session.getAttribute("cartImages");
        List<Integer> cartQuantities= (List<Integer>) session.getAttribute("cartQuantities");
        double total = 0;
        
        if (cartItems != null && !cartItems.isEmpty()) {
            for (int i = 0; i < cartItems.size(); i++) {
                String itemName = cartItems.get(i);
                int quantity= cartQuantities.get(i);
                double itemPrice = Double.parseDouble(cartPrices.get(i))*quantity;
                String itemImage= cartImages.get(i);
                total += itemPrice;
    %>
                <div class="box1">
                    <h3>Item: <%= itemName %></h3>
                    <h3>Price: <%= itemPrice %> RS.</h3>
                    <form action="quantityCart.jsp" method="post">
                    	<input type="hidden" name="index" value="<%=i %>">
                    	<input type="number" name="quantity" value="<%=quantity%>">
                    	<button type="submit">submit</button>
                    </form>
                    <img src="<%= itemImage%>">
                    <form action="removeItem.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="itemIndex" value="<%= i %>">
                        <button type="submit">Remove</button>
                    </form>
                </div>
    <%
            }
            out.println("cartItems size: " + (cartItems != null ? cartItems.size() : "null"));
            out.println("cartPrices size: " + (cartPrices != null ? cartPrices.size() : "null"));
            out.println("cartImages size: " + (cartImages != null ? cartImages.size() : "null"));
            out.println("cartQuantities size: " + (cartQuantities != null ? cartQuantities.size() : "null"));
            out.println("cartItems: " + cartItems);
            out.println("cartPrices: " + cartPrices);
            out.println("cartImages: " + cartImages);
            out.println("cartQuantities: " + cartQuantities);
    %>
            <h3>Total: <%= total %> RS.</h3>
            <div class="box2">
        		<form action="confirm.jsp" method="post">
            		<input type="hidden" name="totalPrice" value="<%= total %>">
            		<input type="hidden" name="userName" value="<%= session.getAttribute("username") %>">
            		<input type="hidden" name="address" value="<%= session.getAttribute("address") %>">
            		<button type="submit">Place Order</button>
        		</form>
        	<button onclick="location.href='menu.jsp'">Continue Shopping</button>
    		</div>
    <%
        } else {
    %>
            <p>Your cart is empty.</p>
    <%
        }
    %>
</body>
</html>

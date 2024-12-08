<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    String itemName = request.getParameter("itemName");
    String itemPrice = request.getParameter("itemPrice");
    String itemImage = request.getParameter("itemImage");

    
    List<String> cartItems = (List<String>) session.getAttribute("cartItems");
    List<String> cartPrices = (List<String>) session.getAttribute("cartPrices");
    List<String> cartImages= (List<String>) session.getAttribute("cartImages");
    List<Integer> cartQuantities= (List<Integer>) session.getAttribute("cartQuantities");

    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }
    if (cartPrices == null) {
        cartPrices = new ArrayList<>();
    }
    if(cartImages==null){
    	cartImages= new ArrayList();
    }
    if(cartQuantities==null){
    	cartQuantities= new ArrayList();
    }

    cartItems.add(itemName);
    cartPrices.add(itemPrice);
    cartImages.add(itemImage);
    cartQuantities.add(1);
    
    out.print(cartImages);
    
    session.setAttribute("cartItems", cartItems);
    session.setAttribute("cartPrices", cartPrices);
    session.setAttribute("cartImages", cartImages);
    session.setAttribute("cartQuantities", cartQuantities);
   
    response.sendRedirect("menu.jsp?message=Item+added+to+cart");
%>
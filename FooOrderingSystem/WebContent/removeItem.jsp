<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    List<String> cartItems = (List<String>) session.getAttribute("cartItems");
    List<String> cartPrices = (List<String>) session.getAttribute("cartPrices");
    
    int indexToRemove = Integer.parseInt(request.getParameter("itemIndex"));
    
    if (cartItems != null && cartItems.size() > indexToRemove) {
        cartItems.remove(indexToRemove);
        cartPrices.remove(indexToRemove);
    }
    session.setAttribute("cartItems", cartItems);
    session.setAttribute("cartPrices", cartPrices);
    
    response.sendRedirect("viewcart.jsp");
%>

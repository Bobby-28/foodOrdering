<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
//Retrieve cart session attributes
List<String> cartItems = (List<String>) session.getAttribute("cartItems");
List<String> cartPrices = (List<String>) session.getAttribute("cartPrices");
List<String> cartImages = (List<String>) session.getAttribute("cartImages");
List<Integer> cartQuantities = (List<Integer>) session.getAttribute("cartQuantities");


int indexToRemove = Integer.parseInt(request.getParameter("itemIndex"));


if (cartItems != null && indexToRemove >= 0 && indexToRemove < cartItems.size()) {
    cartItems.remove(indexToRemove);
    cartPrices.remove(indexToRemove);
    if (cartImages != null && indexToRemove < cartImages.size()) {
        cartImages.remove(indexToRemove);
    }
    if (cartQuantities != null && indexToRemove < cartQuantities.size()) {
        cartQuantities.remove(indexToRemove);
    }
}


session.setAttribute("cartItems", cartItems);
session.setAttribute("cartPrices", cartPrices);
session.setAttribute("cartImages", cartImages);
session.setAttribute("cartQuantities", cartQuantities);


response.sendRedirect("viewcart.jsp");
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import= "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		int index= Integer.parseInt(request.getParameter("index"));
		int quantity= Integer.parseInt(request.getParameter("quantity"));
		List<Integer> cartQuantities= (List<Integer>) session.getAttribute("cartQuantities");
		
		if(cartQuantities!=null && index >= 0 && index<cartQuantities.size()){
			cartQuantities.set(index, quantity);
			session.setAttribute("cartQuantities", cartQuantities);
		}
		
		response.sendRedirect("viewcart.jsp");
	%>
</body>
</html>
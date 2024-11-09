<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.*, javax.servlet.http.*, java.io.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Main Menu</title>
<style>
* {
	margin: 0;
	padding: 0;
	font-family: 'Mulish', sans-serif;
}

.filter-options {
	font-size: 21px;
	margin-left: 100px;
}

.search-bar {
	margin: 20px 100px;
}

h1 {
	font-size: 50px;
}

.search-bar{
margin-left:1350px;
margin-top:55px;
}

.search-bar input {
    width: 80%; /* Full width */
    max-width: 400px; /* Max width */
    padding: 10px; /* Padding */
    border: 3px solid #ccc; /* Border color */
    border-radius: 10px; /* Rounded corners */
    font-size: 16px; /* Font size */
    transition: border 0.3s; /* Transition effect */
}

.search-bar input:focus {
    border-color: #5d8ed5; /* Border color on focus */
    outline: none; /* Remove outline */
    box-shadow: 0 0 5px rgba(93, 142, 213, 0.5);
    }
    
.restaurants .container {
	max-width: 1200px;
	min-width: 1200px;
	position: relative;
	margin: 0 auto;
	padding-top: 42px;
	top: 80px;
	background: #fff;
	left: 31px;
}

.restaurant-list {
	margin-bottom: 85px;
	display: grid;
	grid-template-columns: repeat(4, 25%);
	justify-content: space-between;
	padding-top: 39px;
	margin-top: 25px;
}

.restaurant-list .place-link {
	background: #fff;
	display: block;
	text-decoration: none;
	color: inherit;
}

.restaurant-list .list-item {
	padding: 25px 25px 57px;
	border: 1px solid #fff;
	contain: content;
}

.restaurant-list .list-item:hover {
	border-color: #d3d5df;
	box-shadow: 0 4px 7px 0 rgb(218 220 230/ 60%);
}

.restaurant-list .item-content {
	width: 254px;
	position: relative;
}

.top-img {
	background: #eef0f5;
	width: 254px;
	height: 160px;
	position: relative;
}

.top-img img {
	opacity: 1;
}

.status {
	position: absolute;
	left: -8px;
	top: 0;
	color: #fff;
	font-size: 13px;
	font-weight: 500;
	padding: 5px 9px 4px;
	max-width: 50%;
	text-transform: uppercase;
}

.status::before {
	position: absolute;
	bottom: -9px;
	content: '';
	width: 0;
	height: 0;
	border-style: solid;
	border-color: inherit;
	left: 0;
	border-width: 9px 0 0 9px;
}

.place-name-div {
	margin-top: 14px;
}

.place-name-div .name {
	font-size: 17px;
	font-weight: 500;
	word-break: break-word;
}

.place-name-div .food-items {
	color: #686b78;
	font-size: 13px;
	margin-top: 4px;
	font-weight: 300;
}

.info-div {
	display: flex;
	align-items: center;
	margin-top: 18px;
	font-size: 12px;
	justify-content: space-between;
	color: #535665;
	font-weight: 300;
}

.info-div .rating {
	background-color: #db7c38;
	color: #fff;
	height: 20px;
	width: 36px;
	padding: 0 5px;
	font-weight: 400;
	display: flex;
	align-items: center;
}

.icon-star {
	font-size: 10px;
	margin-right: 4px;
	position: relative;
	top: -1px;
}

.offer-div {
	border-top: 1px solid #e9e9eb;
	padding-top: 14px;
	margin-top: 14px;
	color: #8a584b;
	display: flex;
	align-items: center;
	font-weight: 600;
}

.offer-div .icon-offer-filled {
	font-size: 16px;
	width: 20px;
	height: 16px;
	margin-right: 4px;
}

.place {
    position: relative; 
}

.quick-view {
    color: #686b78;
    margin-left: 150px;
    font-size: 13px;
    visibility: hidden; /* Initially hidden */
    border-top: 1px solid #e9e9eb;
    padding-top: 14px;
    margin-top: 14px;
    position: absolute; /* Position it relative to the place container */
    left: 20px;
    right: 20px;
    bottom: 14px;
}

.list-item:hover .quick-view {
    visibility: visible; /* Show on hover */
}

.quick-view a {
	text-decoration: none;
	font-size: 17px;
	marign:center;
}
</style>
<script>
function filterRestaurants() {
    const isVeg = document.getElementById("pureVeg").checked;
    const isNonVeg = document.getElementById("nonVeg").checked;
    const searchQuery = document.getElementById("searchInput").value.toLowerCase();
    
    const restaurants = document.querySelectorAll(".place");
  
    restaurants.forEach(restaurant => {
        const type = restaurant.getAttribute("data-type");
        const name = restaurant.querySelector(".name").textContent.toLowerCase();
        
        const matchesSearch = name.includes(searchQuery);
        const matchesType = (isVeg && type === "pureVeg") || (isNonVeg && type === "nonVeg") || (!isVeg && !isNonVeg);
        
        if (matchesSearch && matchesType) {
            restaurant.style.display = "block";
        } else {
            restaurant.style.display = "none";
        }
    });
}
</script>
</head>
<body>
    <% 
     String userName = (String) session.getAttribute("userName");
     if (userName != null) {
 %>
     <p>Welcome, <%= userName %>!</p>
 <% 
     } 
 %>

  <%
  String query = request.getParameter("query");

  try {
      String url = "jdbc:mysql://localhost:3306/food_ordering";
      String urlName = "root";
      String urlPassword = "aditya(2003)"; 
      String sql = "SELECT name, category, price, item_type FROM item";

      if (query != null && !query.trim().isEmpty()) {
          sql += " WHERE name LIKE ? OR category LIKE ?";
      }

      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(url, urlName, urlPassword);
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

  %>
<div class="search-bar">
    <input type="text" id="searchInput" placeholder="Search for food....." oninput="filterRestaurants()" />
</div>

<div class="filter-options">
    <label><input type="checkbox" id="pureVeg" onchange="filterRestaurants()"> Pure Veg</label>
    <label><input type="checkbox" id="nonVeg" onchange="filterRestaurants()"> Non Veg</label>
</div>

<div class="restaurant-list">
<%
String[][] restaurants = { 
    {"Foodies Cafeteria's Sandwich", "200", "pureVeg", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2024/4/20/c36ea002-0339-493d-9334-b93011c2c716_871305.jpg"},
    { "AD'S RESTAURANT's Noodles", "120", "pureVeg", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2024/5/20/2d86ab53-4a0c-4217-ab51-ab7a5747288e_890120.JPG"}, 
    { "Bikanervala's Chole Bhature", "90", "pureVeg","https://b.zmtcdn.com/data/pictures/chains/0/19061510/72674cf256e79b518781baef80ba5814_o2_featured_v2.jpg?output-format=webp"},
    { "Hyderabadi Chicken Biryani", "349", "nonVeg", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/oz1780upqnfzisd5gi3s"}, 
    { "Pizza'S Company", "220", "pureVeg", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/eohdm5sdnq6e2u46xeux"},
    { "Mac D Veg Burger Meal", "199", "pureVeg", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2024/9/18/05e097da-9200-492b-ba00-963364e606b8_33859.jpg"}, 
    { "Butter Chicken", "380", "nonVeg", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_240,h_240/upd8jqjpumdfxc3m6liu"},
    { "Tandoori Chicken", "310", "nonVeg", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_240,h_240/lbypymuaxku7kfz5rslw"} ,
    {"Bharat Mewad Ice Cream","180","pureVeg","https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/auczcmkdvvxzt2mswvcc"},
    {"Dev International Parathas","189","pureVeg","https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/4bb2b61f5e51d11eb73a0a3e54ec10d7"},
    {"Chatpata Double Egg Roll","169","nonVeg","https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/a5be439e731c63a9cb6a914aebc21579"},
    {"Subway","249","pureVeg","https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_292,h_300/TopPicks/CVG"}
};

for (String[] restaurant : restaurants) {
%>
   <div class="place" data-type="<%=restaurant[2]%>" data-price="<%=restaurant[1]%>">
    <div class="list-item">
        <center>
            <div class="item-content">
                <div class="top-img">
                    <img class="sc-bXCLTC jRHowI" src="<%=restaurant[3]%>" height="160" width="254">
                </div>
                <div class="place-name-div">
                    <div class="name"><%=restaurant[0]%></div>
                    <div class="food-items"></div>
                </div>
                <div class="info-div">
                    <div class="rating">3.8</div>
                    <div>
                        <h3>15-25 mins</h3>
                    </div>
                    <div class="price"><%=restaurant[1]%> RS.</div>
                </div>
            </div>
        </center>
        <div class="quick-view">
            <a href="addToCart.jsp?itemName=<%=restaurant[0]%>&itemPrice=<%=restaurant[1]%>">ADD TO CART</a>
        </div>
    </div>
</div>
</div>
<%
	}
%>
 <%
 		}
            rs.close();
            pstmt.close();
            conn.close();
  		}catch (Exception e) {
            e.printStackTrace();
        }
 %>
</body>
</html>
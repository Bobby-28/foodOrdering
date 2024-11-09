<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            }

            body {
            
            
                display: flex;
                align-items: center;
                justify-content: center;
                background-image: url(https://png.pngtree.com/thumb_back/fh260/background/20220204/pngtree-big-isolated-motorcycle-vector-colorful-icons-flat-illustrations-of-delivery-by-image_984802.jpg);
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;

            }

            .container {
                width: 400px;
                height: 500px;
                background-color: aqua;

                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;

            }

            h2 {
                color: #171515;
                text-transform: uppercase;
                padding: 20px 0;
                font-size: 2em;
                align-content: center;
                border: #151515
                width: 10px;
                height: 10px;

            }


            .form-group {
                position: relative;
                border-bottom: 3px solid #fff;

                width: 230px;
                margin: 30px;

            }

            .form-group input {
                width: 100px;
                height: 40px;
                background: transparent;
                border: 10px;
                outline: #dc1111;
                font-size: 10px;
                color: #151515;

            }

            .form-group label {
                position: absolute;
                top: 50px;
                left: 10px;
                transform: translateY(-50%);
                font-size: 1.2em;
                color: #fff;
                transition: 0.5s;

            }

            input:focus~label,
            input:valid~label {
                top: -5px;
            }

            .form-group i {
                position: absolute;
                top: 50%;
                right: 20px;

            }


            p {
                text-align: center;
                color: #ffffff;
                padding: 10px 0;

            }

            p>a {
                color: #dc1111;
                text-decoration: none;
                font-weight: 600;


            }

            p>a:hover {
                text-decoration: underline;
                font-style: italic;


            }

            #btn {
                width: 100px;
                height: 50px;
                border-radius: 40px;
                border: none;
                font-size: 1.5em;
                text-transform: uppercase;
                font-weight: 600;
                margin: 10px 0;
                cursor: pointer;
                transition: 0.5ms;
                align-content:center;


            }


            #btn:hover {
                background: rgba(0, 0, 0, 0.3);
                color: #fff;

            }
        </style>
    </head>

    <body>
    <% try{
    	String name = request.getParameter("name");
    	String password = request.getParameter("password");
    	String sql = "select * from registration where name=? and password=?";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/food_ordering", "root","aditya(2003)");
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, password);
        ResultSet rs= ps.executeQuery();   
        if (rs.next()) {
            response.sendRedirect("menu.jsp");
            
        } else {
            out.println("<p>Invalid username or password.</p>");
        } 
    }
    
    catch (ClassNotFoundException e){
    	e.printStackTrace();  	
    } catch (SQLException e) {
    	e.printStackTrace();
    }
    %>
        <div id="container">
            <h2>User Login Details</h2>
            <form action="new.jsp" method="post">
                <div class="form-group">
                    <input type="text" name="name" required><br>
                    <label for="">username:</label>
                    <i class="fa-solid fa-envelope"></i>
                </div>
                <div class="form-group">
                    <input type="password" name="password" required><br>
                    <label for="">Password:</label>
                    <i class="fa-solid fa-lock"></i>
                </div>
                <p><input type="checkbox">Remember Me?<a href="#">Forget Password</a></p>
                <button id="btn" type="submit" value="Login">Login</button>
            </form>
            <p>Don't have a account?<a href="#">Register</a></p>
        </div>

    </body>

</html>
<%-- 
    Document   : viewMyDrives
    Created on : Apr 28, 2015, 8:54:00 AM
    Author     : VAV
--%>

<%@page import="taxi.data.UserDB"%>
<%@page import="taxi.model.User"%>
<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
   <jsp:include page="/includes/header.jsp" />
<html>
<head>
<title>View Messages</title>
</head>
<body>
 <%
     HttpSession httpsession = request.getSession();
     String uIDString = httpsession.getAttribute("UserId").toString();
     int uID = Integer.parseInt(uIDString);
 %>

 <%
Connection conn=null;
ResultSet result=null;
Statement stmt=null;
ResultSetMetaData rsmd=null;

User customerInfo = new User();
UserDB userDataObject = new UserDB();
try {
  Class c=Class.forName("com.mysql.jdbc.Driver");
  conn=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/my_taxi_service",
   "root","Iphone@89");
//  out.write("Connected!");
          stmt = conn.createStatement();                 
          String query = "SELECT Ride.Request_ID,Ride.Ride_ID,Ride.miles,(Ride.miles * Ride.avgCost_mile) AS COST,Ride.Driver_ID,Ride.Customer_ID,user.Firstname,rating.customer_rating FROM Ride JOIN USER ON Ride.customer_id = user.userID LEFT JOIN rating ON rating.ride_ID = Ride.Ride_ID WHERE ride.driver_ID = ? ORDER BY Ride_ID desc";
          PreparedStatement ps = conn.prepareStatement(query);
          ps.setInt(1, uID);
          result = ps.executeQuery();
 %>

 <table border="1" width="100%">
<tr>
   <th>RequestID</th>
   <th>Customer Name</th>
   <th>Miles</th>
   <th>Cost</th>
   <th>Rating</th>
</tr>

<%
          while(result.next())
          {
%>
<tr>
   <td> <%= result.getString("Request_ID") %> </td>
   <td> <%= result.getString("Firstname") %> </td>
   <td> <%= result.getString("miles") %> </td>
   <td> $<%= result.getString("Cost") %> </td>
   <% if(null == result.getString("customer_rating")) {%>
   <td><a href ="rateCustomer.jsp?Ride_ID=<%= result.getString("Ride_ID") %>&Driver_ID=<%= result.getString("Driver_ID") %>&Customer_ID=<%= result.getString("Customer_ID") %>" target="_blank"> Rate Customer</a></td>
   <% } else {%>
   <td> <%= result.getString("customer_rating") %>/5 </td>
   <% }; %>
  </tr>
<%
          }
          conn.close();
}
catch(Exception e){
  out.write("Error!!!!!!" + e);
}
%>
</table>
</body>
</html>


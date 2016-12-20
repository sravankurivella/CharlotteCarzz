<%-- 
    Document   : pendingRides
    Created on : Apr 27, 2015, 11:42:04 PM
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
<title>SELECT The Ride</title>
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
          String query = "SELECT CCR.* from Customer_Requests CCR LEFT JOIN customer_confirmation CC on CCR.request_ID = CC.request_ID WHERE CC.Confirmation_ID IS NULL AND CCR.selected_driver_id = ?";
          PreparedStatement ps = conn.prepareStatement(query);
          ps.setInt(1, uID);
          result = ps.executeQuery();
 %>

<form name="driver_conf" id="driver_conf" action="driverConfirm">
 <table border="1" width="100%">
<tr>
    <th>RequestID</th>
   <th>Destination Address</th>
   <th>Billable Distance</th>
   <th>PickUp Address</th>
   <th>Customer Info</th>
   <th>Contact Info</th>
   <th>Action</th>
</tr>

<%
          while(result.next())
          {
              customerInfo = userDataObject.selectUser(result.getInt("customer_id"));
%>
<tr>
    <td> <%= result.getString("request_id") %> </td>
   <td> <%= result.getString("destination_addressline") %> </td>
   <td> <%= result.getString("distance") %> </td>
   <td> <%= result.getString("source_addressline") %> </td>
   <td> <%= customerInfo.getFirstname() %>,<%= customerInfo.getLastname() %> </td>
   <td> <%= customerInfo.getPhone() %> </td>
   <td> <button type="submit" name="RequestID" value="<%= result.getString("request_id") %>" onclick= "submit();"> Accept Ride </button></td>
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
</form>
</body>
</html>

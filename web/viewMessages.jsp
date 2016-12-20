<%-- 
    Document   : viewMessages
    Created on : Apr 28, 2015, 4:08:44 AM
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
          String query = "SELECT Messages.Message,Messages.Request_ID,USER.Firstname FROM Messages JOIN USER ON Messages.MessageFromID = USER.USERID WHERE MessageToID  = ? ORDER BY messageID desc";
          PreparedStatement ps = conn.prepareStatement(query);
          ps.setInt(1, uID);
          result = ps.executeQuery();
 %>

 <table border="1" width="100%">
<tr>
   <th>Message From</th>
   <th>Message</th>
   <th>RequestID</th>
</tr>

<%
          while(result.next())
          {
%>
<tr>
   <td> <%= result.getString("Firstname") %> </td>
   <td> <%= result.getString("Message") %> </td>
   <td> <%= result.getString("Request_ID") %> </td>
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




<!DOCTYPE html>
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
<title>My Rewards</title>
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
          String query = "SELECT SUM(miles) AS RewardMiles,COUNT(miles) AS TotalTransactions,SUM(miles * avgCost_mile) AS TotalDollar FROM ride WHERE customer_ID = ?";
          PreparedStatement ps = conn.prepareStatement(query);
          ps.setInt(1, uID);
          result = ps.executeQuery();
 %>

 <table border="1" width="100%">
<tr>
   <th>Current Rewards Program</th>
   <th>Total Miles</th>
   <th>Reward Eligible</th>
   <th>Notes From Us</th>
</tr>

<%        double RewardMoney = 0;
          while(result.next())
          {
%>
<tr>
   <td> <% if(result.getInt("RewardMiles") > 500)
            { 
                RewardMoney = 0.10 * result.getDouble("TotalTransactions");
         %>
            Silver Rewards Program
                <%    }
            else  if(result.getInt("RewardMiles") > 1000) {
              RewardMoney = 0.15 * result.getDouble("TotalTransactions");  %>
            Gold Rewards Program
                <%    }
            else  { 
                RewardMoney = 0.05 * result.getDouble("TotalTransactions");
                %>
            Bronze Rewards Program
                <%    }  
   %> </td>
   <td> <%= result.getString("RewardMiles") %> </td>
   <td> $<%= RewardMoney %> </td>
   <% if(result.getInt("RewardMiles") > 1000) {%>
   <td>You Are Our Elite Customer</td>
   <% } else {%>
   <td> Get to Gold Rewards Program for 15% Cash Back</td>
   <% }; %>
  </tr>
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

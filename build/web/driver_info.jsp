<%-- 
    Document   : driver_info
    Created on : Apr 26, 2015, 8:36:29 PM
    Author     : vav
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/user_navigation1.jsp" />

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Registration Page</title>
	<style type="text/css">
<!--
.style1 {font-family: Arial, Helvetica, sans-serif}
-->
    </style>
	</head>
	<body>
              <% HttpSession httpsession = request.getSession(); %>
    <h2><b>Update Your Information
        <% String user = httpsession.getAttribute("userName").toString();%>
        <%= user%></b>
        <br>
    <h2 align="center"> </h2>
	<form action="update_info" method="get" class="style1">
       	<table align="center" style="padding-top:5px">
           	
           	<tr>
           <tr>
           		<td>Rate Per Mile</td>
           		<td><input name="rate" type="decimal"></td>
           	</tr>
                <tr>
           		<td>Available ZipCode</td>
           		<td><input name="zip" type="text"></td>
           	</tr>
                
            <tr align="center">
                <td><a href="reg_driver.jsp"><input name="Register" type="submit"  value="Update"></a></td>
                      
            </tr>
        </table>
  </form>
    </body>
</html>

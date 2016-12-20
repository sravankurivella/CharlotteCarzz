<%-- 
    Document   : login
    Created on : Apr 14, 2015, 11:12:59 AM
    Author     : vav
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link rel="stylesheet" href="styles/style.css" property="">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<h1> Charlotte Carzz </h1>
</head>

<form method="get" action="check">    
    
<center>
<table align="center" >
<tr>
<td><label for="uname">UserName</label></td>
<td><input type="text" name="UserName" id="uname"/></td>
</tr>
<tr>
<td><label for="pass">Password</label></td>
<td><input type="password" name="Password" id="pass"/></td>
</tr>
<tr>
<td><input type="submit" name="login" id="login" value="Login"/></td>
<td><input type="reset" name="reset" id="clear" value="Clear"/></td>
</tr>
<tr>
</table>
</center>
</form>
</body>
</html>

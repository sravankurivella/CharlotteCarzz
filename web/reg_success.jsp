<%-- 
    Document   : login_success
    Created on : Apr 21, 2015, 9:21:26 AM
    Author     : vav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:include page="/includes/header.jsp" />


<html>
    <article>
    <body>
        <h3>You are successfully registered ! Please login and continue!</h3>
        
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
    </article>
</html>

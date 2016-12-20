<%-- 
    Document   : register
    Created on : Apr 14, 2015, 10:46:17 AM
    Author     : vav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:include page="/includes/header.jsp" />

	<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">	</head>
	<body>
    <h2 align="center">Registration Form</h2>
	<form action="register" method="get" class="style1"> 
       	<table align="center" style="padding-top:5px">
           	
           <tr>
           		<td>Role</td>
    <td><select name="role" type="text">
                <option value="Driver">Driver</option>
                    <option value="Customer">Customer</option>
</select></td>
           		
           	</tr>
                
                 <tr>
           		<td>Select a UserName</td>
                        <td><input name="UserName" type="text"></td>

           	</tr>
            
            <tr>
           		<td>First Name</td>
                        <td><input name="FirstName" type="text"></td>

           	</tr>
            <tr>
           		<td>Last Name</td>
           		<td><input name="LastName" type="text"></td>
           	</tr>
            <tr>
           		<td>Email</td>
           		<td><input name="Email" type="text"></td>
           	</tr>
                
                <tr>
           		<td>Password</td>
           		<td><input name="Password" type="password"></td>
           	</tr>
          
            <tr>
           		<td>Address 1</td>
           		<td><textarea name="Address1"></textarea></td>
           	</tr>
            <tr>
           		<td>Address 2</td>
           		<td><textarea name="Address2"></textarea></td>
           	</tr>
            <tr>
           		<td>City</td>
           		<td><input name="City" type="text"></td>
           	</tr>
            <tr>
           		<td>State</td>
           		<td><input name="State" type="text"></td>
           	</tr>
            <tr>
           		<td>Postal Code</td>
           		<td><input name="PostalCode" type="text"></td>
           	</tr>
            <tr>
           		<td>Phone</td>
           		<td><input name="Phone" type="numbers"></td>
           	</tr>
             
            <tr align="center">
                <td colspan=2><input  type="submit"  value="Register"></a></td>
           
            </tr>
        </table>
    </form>
    </body>
</html>

<%-- 
    Document   : reg_driver
    Created on : Apr 14, 2015, 10:53:18 AM
    Author     : vav
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/includes/header.jsp" />

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
    <h2 align="center">Driver Details</h2>
	<form action="reg_driver" method="get" class="style1">
       	<table align="center" style="padding-top:5px">
           	
           	<tr>
           		<td>Age</td>
           		<td><input name="age" type="text"></td>
           	</tr>
            <tr>
           		<td>Driver's License number</td>
           		<td><input name="d_license" type="text"></td>
           	</tr>
            <tr>
           		<td>Vehicle Registration Number</td>
           		<td><input name="veh_reg" type="text"></td>
           	</tr>
          
            <tr>
           		<td>Insurance Company</td>
                        <td><input name="ins_company" type="text"></td>
           	</tr>
            <tr>
           		<td>Insurance Number</td>
           		<td><input name="ins_number" type = "text"></td>
           	</tr>
            <tr>
           		<td>Insurance Expiry Date</td>
           		<td><input name="insurance_date" type="date"></td>
           	</tr>
            <tr>
           		<td>Vehicle Name</td>
           		<td><input name="v_name" type="text"></td>
           	</tr>
            <tr>
           		<td>Vehicle color</td>
           		<td><input name="v_color" type="text"></td>
           	</tr>
            <tr>
           		<td>Vehicle Capacity</td>
           		<td><input name="v_capacity" type="text"></td>
           	</tr>
                <tr>
           		<td>Rate Per Mile</td>
           		<td><input name="rate" type="decimal"></td>
           	</tr>
                <tr>
           		<td>Available ZipCode</td>
           		<td><input name="zip" type="text"></td>
           	</tr>
                
            <tr align="center">
                <td><input type="submit"  value="Confirm Registration as Driver"></a></td>
                      
            </tr>
        </table>
    </form>
    </body>
</html>


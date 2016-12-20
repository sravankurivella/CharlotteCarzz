<%-- 
    Document   : rateCustomer
    Created on : Apr 28, 2015, 9:14:08 AM
    Author     : VAV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rating Page</title>
        <jsp:include page="/includes/header.jsp" />
    </head>
    <body>
        <h1>Please Rate the Driver</h1>
        <form action="drate" method="get">
            <input type="radio" name="drating" value="1">1
            <br>
            <input type="radio" name="drating" value="2">2
            <br>
            <input type="radio" name="drating" value="3">3
            <br>
            <input type="radio" name="drating" value="4">4
            <br>
            <input type="radio" name="drating" value="5">5
            
            <input type="hidden" name="Ride_ID" value="<%= request.getParameter("Ride_ID") %>">
            <input type="hidden" name="Driver_ID" value="<%= request.getParameter("Driver_ID") %>">
            <input type="hidden" name="Customer_ID" value="<%= request.getParameter("Customer_ID") %>">
            <br>
            <input type="Submit" name="Submit" value="Submit Rating">
        </form>
    </body>
</html>

<%-- 
    Document   : confirmDriver
    Created on : Apr 27, 2015, 2:36:13 PM
    Author     : vav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
        <jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/user_navigation.jsp" />
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
     <body>
    <article>
        
        <body>
              <% HttpSession httpsession = request.getSession(); %>
    <h2><b>Dear
        <% String user = httpsession.getAttribute("userName").toString();%>
        <%= user%></b>
        <br>
        Your request has been notified to the driver you have selected.
        As soon as he accepts your ride request , you will be notified.
        
    </article>
     </body>
</html>

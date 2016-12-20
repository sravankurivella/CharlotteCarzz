<%-- 
    Document   : confirmCustomer
    Created on : Apr 28, 2015, 7:31:04 AM
    Author     : VAV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
        <jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/user_navigation1.jsp" />
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
        Your confirmation will be sent to the customer , Please start your ride!
        
    </article>
     </body>
</html>

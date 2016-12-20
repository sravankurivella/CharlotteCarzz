<%-- 
    Document   : userLogin_suc
    Created on : Apr 15, 2015, 11:44:49 AM
    Author     : vav
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/user_navigation.jsp" />

<body>

<article>
    <% HttpSession httpsession = request.getSession(); %>
    <h2><b>Welcome 
        <% String user = httpsession.getAttribute("userName").toString();%>
        <%= user%></b>
        <br>
        
        <h3>You can book a ride whenever you want and the driver will approach 
        in minutes!! </h3>
    </h2> 
</article>
</body>

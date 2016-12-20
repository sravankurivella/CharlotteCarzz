<%-- 
    Document   : drivLogin
    Created on : Apr 26, 2015, 8:19:09 PM
    Author     : vav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/user_navigation1.jsp" />



<article>
    <% HttpSession httpsession = request.getSession(); %>
    <h2><b>Welcome 
        <% String user = httpsession.getAttribute("userName").toString();%>
        <%= user%></b>
        <br>
        
      
    </h2> 
    
          

        
  
</article>
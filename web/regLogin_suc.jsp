

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/user_navigation.jsp" />



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


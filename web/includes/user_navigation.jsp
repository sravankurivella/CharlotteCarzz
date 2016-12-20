<%-- 
    Document   : user_navigation
    Created on : Apr 26, 2015, 11:31:28 AM
    Author     : vav
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<section>
    <div id="rep" >
        
        <nav>
            <ul>
                &nbsp;
                &nbsp;
                <li><a href="viewMyRides.jsp">My Rides</a></li>
                <li><a href="newRide">New Ride</a></li>
                <li><a href="#">Payment</a></li>  
                <li><a href="viewMessages.jsp">Inbox</a></li>
                <li><a href="MyRewards.jsp">Rewards</a></li>
                 
                 <% HttpSession httpsession = request.getSession(false); 
    String user = null;
    if (null==httpsession.getAttribute("userName")){}
    else{user = httpsession.getAttribute("userName").toString();}
    %>
       <% String displayText="";
           String valueText="";
            if(user != null)  {
                    displayText = "Logout";
                    valueText = "logout"; 
            }
       %>   
    
   <li> <a href ="<%= valueText%>"><%= displayText%></a></li> 
                 
            </ul>

        </nav>
    </div >
</section>

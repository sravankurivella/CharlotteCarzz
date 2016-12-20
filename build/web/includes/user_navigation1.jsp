<%-- 
    Document   : user_navigation2
    Created on : Apr 26, 2015, 8:20:19 PM
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
                <li><a href="driver_info.jsp">My Info Update</a></li>
                <li><a href="viewMyDrives.jsp">My Drives</a></li>
                <li><a href="pendingRides.jsp">Pending Drives</a></li>
                <li><a href="viewMessages.jsp">Inbox</a></li>
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


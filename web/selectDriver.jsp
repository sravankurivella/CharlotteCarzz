<%-- 
    Document   : selectDriver
    Created on : Apr 27, 2015, 12:32:47 AM
    Author     : vav
--%>
<%@page import="taxi.data.UserDB"%>
<%@page import="taxi.model.Drivers"%>
<%@page import="taxi.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/user_navigation.jsp" />
    <%@page import="java.util.List"%>
    
<% HttpSession htpsession = request.getSession();
    
  List<Drivers> drivers = (List)htpsession.getAttribute("drivers");
%>


    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <h3>Select Driver</h3>
    </head>
    <body>
        <form name="SelectDriver" id="SelectDriver" action="confirmDriver">

            <table>
                  <tr>
                    <td>Rating</td>
                    <td>Availability Status</td>
                    <td>Max Miles</td>
                    <td>Driver Name</td>
                    <td></td>
                    </tr>
                    <%
                        User userData = new User();
                        UserDB userDataObject = new UserDB();
                    for(int i = 0; i < drivers.size(); i+=1) {
                        userData = userDataObject.selectUser(drivers.get(i).getUserid());
                    %>
                  
                    
                    
                    <tr><td> <%= drivers.get(i).getAvgRating()%></td>
                        <td>  <%= drivers.get(i).getAvailStatus() %></td>
                        <td>  <%= drivers.get(i).getMaxMilesToDest()%></td>
                         <td> <%= userData.getFirstname()%></td>                                              
                         <td><button type="submit" name="Driver" value="<%=drivers.get(i).getUserid()%>" onclick= "submit();"> Select Driver </button>
<!--                         <button type="submit" value="Submit" onclick= "submit();"><%= userData.getFirstname()%></button>-->
                         </td>
                    </form>          
                        </tr>
                    <% } %>
            </table>
        </form>
    </body>
</html>

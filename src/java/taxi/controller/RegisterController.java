package taxi.controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import taxi.data.UserDB;
import  taxi.model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;

import javax.persistence.StoredProcedureQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import taxi.data.DBUtil;
import taxi.model.CustomerRequests;
import taxi.model.Drivers;
/**
 *
 * @author vav
 */

@WebServlet(name="RegisterController", urlPatterns={"/drate","/crate","/confirmCustomer","/logout","/driverConfirm","/update_info","/confirmDriver","/search_driver","/SelectDriver1","/register","/ride","/newRide","/reg_success","/reg_driver","/index2","/check","/selectDriver"})
public class RegisterController
  extends HttpServlet
 {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
     HttpSession session = request.getSession();
    String userPath = request.getServletPath();

    switch(userPath)
    {
        case "/logout":
            session = request.getSession();
            session.invalidate();
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
         dispatcher.forward(request, response);
            
            
            break;
        case "/register":
        
        
        User u = new User();
        
        u.setRole(request.getParameter("role"));
        u.setUsername(request.getParameter("UserName"));
        u.setFirstname(request.getParameter("FirstName"));
        u.setLastname(request.getParameter("LastName"));
        u.setEmail(request.getParameter("Email"));
        u.setPassword(request.getParameter("Password"));
        u.setAddress1(request.getParameter("Address1"));
        u.setAddress2(request.getParameter("Address2"));
        u.setCity(request.getParameter("City"));
        u.setState(request.getParameter("State"));
        u.setPostalcode(request.getParameter("PostalCode"));
        u.setPhone(request.getParameter("Phone"));
       
        
    if(null!=u.getFirstname())
    {
        UserDB.addUser(u); 
      int id =  u.getUserid();
     session.setAttribute("UserId",id);
        
    }   
    String role = u.getRole();
    if("Driver".equals(role))
    {
         dispatcher = request.getRequestDispatcher("/reg_driver.jsp");
         dispatcher.forward(request, response);
            
    }
    else
    {
         dispatcher = request.getRequestDispatcher("/reg_success.jsp");
         dispatcher.forward(request, response);
    }
      break;  
        
        case "/check":
    
         String username = request.getParameter("UserName");
         String pwd = request.getParameter("Password");
         
           EntityManager em = DBUtil.getEmFactory().createEntityManager();
        // int userID = UserDB.loginAuthentication(username, pwd);
         StoredProcedureQuery storedProcedure = em.createStoredProcedureQuery("login_authentication");

        // set parameter
        storedProcedure.registerStoredProcedureParameter("UserName", String.class, ParameterMode.IN);
        storedProcedure.registerStoredProcedureParameter("Password", String.class, ParameterMode.IN);
        storedProcedure.registerStoredProcedureParameter("UserId", Integer.class, ParameterMode.OUT);
        storedProcedure.setParameter("UserName", username);
        storedProcedure.setParameter("Password", pwd);

        // execute SP
        storedProcedure.execute();        
        String userId = storedProcedure.getOutputParameterValue("UserId").toString();
        
        if (!"0".equals(userId))
        {
              session = request.getSession(true);
             int user_Id = Integer.parseInt(userId);
             session.setAttribute("UserId",user_Id);
             User currentUser = UserDB.selectUser(user_Id);
             session.setAttribute("userName",currentUser.getFirstname());
             String role1 = currentUser.getRole();
             if("Customer".equals(role1)) 
             {
              dispatcher = request.getRequestDispatcher("/userLogin_suc.jsp");
             dispatcher.forward(request, response);
             }
             else if("Driver".equals(role1))
             {
              dispatcher = request.getRequestDispatcher("/drivLogin_suc.jsp");
             dispatcher.forward(request, response);
             }
        }
        else
        {
             dispatcher = request.getRequestDispatcher("/nologin.jsp");
             dispatcher.forward(request, response);
        }
        break;
               
        case "/reg_driver":
             Drivers d1 = new Drivers();
//           HttpSession session = request.getSession();  
          Integer userId2 = (Integer)session.getAttribute("UserId");
     
         d1.setUserid(userId2);
         String age = request.getParameter("age");
        int age1 = Integer.parseInt(age);
        d1.setAge(age1);
        d1.setInsuranceComp(request.getParameter("ins_company"));
        d1.setInsuranceNum(request.getParameter("ins_number"));
        d1.setLicenseNum(request.getParameter("d_license"));
        String capacity = request.getParameter("v_capacity");
        int capacity2 = Integer.parseInt(capacity);
        d1.setVehCapacity(capacity2);
        d1.setVehColor(request.getParameter("v_color"));
        d1.setVehName(request.getParameter("v_name"));
        d1.setVehicleReg("veh_reg");
        String zip = request.getParameter("zip");
        int zip1 = Integer.parseInt(zip);
        d1.setZipCode(zip1);
        String rate= request.getParameter("rate");
        

         BigDecimal rate1 = new BigDecimal(rate);
         d1.setCurrentRatemile(rate1);
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar cal = Calendar.getInstance();
        d1.setDate(cal.getTime());
        d1.setAvailStatus("Y");
        d1.setAvgRating(4);
        d1.setMaxMilesToDest(200);
        
        UserDB.addDriver(d1);
         dispatcher = request.getRequestDispatcher("/reg_success.jsp");
             dispatcher.forward(request, response);
       
      break;
    
    case "/newRide":
        
    break;
        
    case "/selectDriver":
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String distance = request.getParameter("distance");
        String szip = request.getParameter("szip");
        String dzip = request.getParameter("dzip");
        Integer dzip1 = Integer.parseInt(dzip);
       Integer szip1 = Integer.parseInt(szip);
        
        CustomerRequests req = new CustomerRequests();
      
         Integer userId3 = (Integer)session.getAttribute("UserId");
     
        req.setCustomerId(userId3);
        req.setDestinationAddressline(to);
        req.setDestinationZipcode(dzip1);
        req.setSourceAddressline(from);
        req.setPresentZipcode(szip1);
       
        
        BigDecimal distance2 = new BigDecimal(distance);
        req.setDistance(distance2);
        UserDB.addRequest(req);
        session.setAttribute("req",req);
        
        int zipcode = req.getPresentZipcode();
         List<Drivers> drivers = UserDB.selectDrivers(zipcode);
         session.setAttribute("drivers",drivers); 
        
        dispatcher = request.getRequestDispatcher("/selectDriver.jsp");
             dispatcher.forward(request, response);
        break;

    case "/confirmDriver":
            String dr1 = request.getParameter("Driver");
            int dr1_id = Integer.parseInt(dr1);
           int userId5 = (Integer)session.getAttribute("UserId");
           //code to get request_ID
           CustomerRequests confirmReq = new CustomerRequests();
           confirmReq =(CustomerRequests) session.getAttribute("req");
           int confirmReqID = confirmReq.getRequestId();
          
            em = DBUtil.getEmFactory().createEntityManager();
      storedProcedure = em.createStoredProcedureQuery("update_request");
     // set parameter
     storedProcedure.registerStoredProcedureParameter("Driver", Integer.class, ParameterMode.IN);
      storedProcedure.registerStoredProcedureParameter("UserId", Integer.class, ParameterMode.IN);
      storedProcedure.registerStoredProcedureParameter("ReqId", Integer.class, ParameterMode.IN);
     storedProcedure.setParameter("Driver",dr1_id);
     storedProcedure.setParameter("UserId",userId5);
     storedProcedure.setParameter("ReqId",confirmReqID);
     
     // execute SP
     storedProcedure.execute();
  
        break;
    case "/update_info":
        
        Drivers d = new Drivers();
        Integer userId4 = (Integer)session.getAttribute("UserId");
        em = DBUtil.getEmFactory().createEntityManager();
        //d = em.find(Drivers.class, 1);
        String zip2 = request.getParameter("zip");
//        d.setZipCode(zip2);
        String rate2= request.getParameter("rate");
        BigDecimal rate3 = new BigDecimal(rate2);
        //d.setCurrentRatemile(rate3);
        //em.getTransaction().begin();
       // em.getTransaction().commit();
       // UserDB.updateDriver(d);
          em = DBUtil.getEmFactory().createEntityManager();
        // int userID = UserDB.loginAuthentication(username, pwd);
       storedProcedure = em.createStoredProcedureQuery("update_driver");
        // set parameter
        storedProcedure.registerStoredProcedureParameter("zip", String.class, ParameterMode.IN);
        storedProcedure.registerStoredProcedureParameter("rate", BigDecimal.class, ParameterMode.IN);
        storedProcedure.registerStoredProcedureParameter("UserId", Integer.class, ParameterMode.IN);         
        storedProcedure.setParameter("zip", zip2);
        storedProcedure.setParameter("rate", rate3);
        storedProcedure.setParameter("UserId", userId4);

        // execute SP
        storedProcedure.execute();  
           dispatcher = request.getRequestDispatcher("/index.jsp");
             dispatcher.forward(request, response);
        
        break;
        
    case "/driverConfirm":
            String rqIDString = request.getParameter("RequestID");
            int rqID = Integer.parseInt(rqIDString);
            int driverId = (Integer)session.getAttribute("UserId");
           //code to get request_ID          
            em = DBUtil.getEmFactory().createEntityManager();
            storedProcedure = em.createStoredProcedureQuery("confirmAccept_request");
           // set parameter
            storedProcedure.registerStoredProcedureParameter("ReqId", Integer.class, ParameterMode.IN);
            storedProcedure.setParameter("ReqId",rqID);     
     // execute SP
     storedProcedure.execute();
     
      dispatcher = request.getRequestDispatcher("/confirmCustomer.jsp");
             dispatcher.forward(request, response);
        
        break;
        
    case "/confirmCustomer":
           
        break;
         case "/crate":
             
               
   String rideId_S = request.getParameter("Ride_ID") ;
   int rideId = Integer.parseInt(rideId_S);
   String driverId_S =         request.getParameter("Driver_ID") ;
   int driverId_rate = Integer.parseInt(driverId_S);
   String custId_S =      request.getParameter("Customer_ID"); 
   int custId = Integer.parseInt(custId_S);
      String cRate_S =      request.getParameter("Crating");
      int cRate = Integer.parseInt(cRate_S);
      
           em = DBUtil.getEmFactory().createEntityManager();
            storedProcedure = em.createStoredProcedureQuery("customer_rating");
           // set parameter
            storedProcedure.registerStoredProcedureParameter("RidId", Integer.class, ParameterMode.IN);
             storedProcedure.registerStoredProcedureParameter("DriId", Integer.class, ParameterMode.IN);
              storedProcedure.registerStoredProcedureParameter("CusId", Integer.class, ParameterMode.IN);
               storedProcedure.registerStoredProcedureParameter("CRate", Integer.class, ParameterMode.IN);
            storedProcedure.setParameter("RidId",rideId);  
            storedProcedure.setParameter("DriId",driverId_rate);  
            storedProcedure.setParameter("CusId",custId);  
            storedProcedure.setParameter("CRate",cRate);  
     // execute SP
     storedProcedure.execute();
     
      dispatcher = request.getRequestDispatcher("/drivLogin_suc.jsp");
             dispatcher.forward(request, response);
        
        break;
             
     case "/drate":
                         
   String s1rideId_S = request.getParameter("Ride_ID");
   int s1rideId = Integer.parseInt(s1rideId_S);
   String s1driverId_S =         request.getParameter("Driver_ID") ;
   int s1driverId_rate = Integer.parseInt(s1driverId_S);
   String s1custId_S =      request.getParameter("Customer_ID"); 
   int s1custId = Integer.parseInt(s1custId_S);
      String s1cRate_S =      request.getParameter("drating");
      int s1cRate = Integer.parseInt(s1cRate_S);
      
           em = DBUtil.getEmFactory().createEntityManager();
            storedProcedure = em.createStoredProcedureQuery("driver_rating");
           // set parameter
            storedProcedure.registerStoredProcedureParameter("RidId", Integer.class, ParameterMode.IN);
             storedProcedure.registerStoredProcedureParameter("DriId", Integer.class, ParameterMode.IN);
              storedProcedure.registerStoredProcedureParameter("CusId", Integer.class, ParameterMode.IN);
               storedProcedure.registerStoredProcedureParameter("CRate", Integer.class, ParameterMode.IN);
            storedProcedure.setParameter("RidId",s1rideId);  
            storedProcedure.setParameter("DriId",s1driverId_rate);  
            storedProcedure.setParameter("CusId",s1custId);  
            storedProcedure.setParameter("CRate",s1cRate);  
     // execute SP
     storedProcedure.execute();
     
      dispatcher = request.getRequestDispatcher("/userLogin_suc.jsp");
             dispatcher.forward(request, response);
        
        break;
        
    }
  String url = userPath +".jsp";
    

   request.getRequestDispatcher(url).forward(request, response);
    }
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
  }

  public String getServletInfo()
  {
    return "Short description";
  }
    
}

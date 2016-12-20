/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package taxi.data;
import taxi.model.User;
import java.util.List;
import javax.persistence.*;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import taxi.model.CustomerRequests;
import taxi.model.Drivers;
/**
 *
 * @author Aneesha
 */
public class UserDB {
    
    
    public static User selectUser(int userId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT u FROM User u " +
                "WHERE u.userid = :userId";
        TypedQuery<User> q = em.createQuery(qString, User.class);
        q.setParameter("userId", userId);
        try {
            User user = q.getSingleResult();
            return user;
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
        public static List<User> selectUsers(int userId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT u FROM User u " +
                "WHERE u.userid = :userId";
        TypedQuery<User> q = em.createQuery(qString, User.class);
        q.setParameter("userId", userId);
        List<User> ur ;
        try {
             ur = q.getResultList();
            if (ur == null || ur.isEmpty())
                ur = null;
        } finally {
            em.close();
        }
        return ur;    
     }
        public static List<Drivers> selectDrivers(int zipcode) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT d FROM Drivers d " +
                "WHERE d.zipcode = :zipcode";
        TypedQuery<Drivers> q = em.createQuery(qString, Drivers.class);
        q.setParameter("zipcode", zipcode);
        List<Drivers> dr;
        try {
            dr = q.getResultList();
            if (dr == null || dr.isEmpty())
                dr = null;
        } finally {
            em.close();
        }
        return dr;    
     }
   
  
      public static User selectUserWithEmail(String email) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT u FROM User u " +
                "WHERE u.email = :email";
        TypedQuery<User> q = em.createQuery(qString, User.class);
        q.setParameter("email", email);
        try {
            User user = q.getSingleResult();
            return user;
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }  
    public static List<User> getAllUsers() 
     {
         EntityManager em = DBUtil.getEmFactory().createEntityManager();
         String qString = "SELECT u from User u ";
         TypedQuery<User> q = em.createQuery(qString, User.class);
        

         List<User> users;
         try {
            users = q.getResultList();
            if (users == null || users.isEmpty())
                users = null;
        } finally {
            em.close();
        }
        return users;
      }

    
        public static void addUser(User user) 
     {
         EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();        
        try {
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
     }
            public static void addDriver(Drivers drivers) 
     {
         EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();        
        try {
            em.persist(drivers);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
     }
         public static void addRequest(CustomerRequests custreq) 
     {
         EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();        
        try {
            em.persist(custreq);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
     }
        
       public static void updateDriver(Drivers drivers) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();       
        try {
           
            em.merge(drivers);   
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
    }
        public static void deleteUser(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();        
        try {
            em.remove(em.merge(user));
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }       
    }
        
    public static boolean isEmailCorrect(String email) 
  {
  Boolean value;
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT u FROM User u " +
                "WHERE u.email = :email";
        TypedQuery<User> q = em.createQuery(qString, User.class);
        q.setParameter("email",email );
        try {
           
            User user = q.getSingleResult();
           if (user == null)
               value = false;
           else 
               value = true;
           
           
        } catch (NoResultException e) {
            return false;
        } finally {
            em.close();
        }  return value;
  }
      public static boolean isPasswordCorrect(String email, String pwd) 
  {
  Boolean value;
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT u FROM User u " +
                "WHERE u.email = :email and u.password = :pwd";
        TypedQuery<User> q = em.createQuery(qString, User.class);
        q.setParameter("email",email );
        q.setParameter("pwd",pwd);
        try {
           
            User user = q.getSingleResult();
           if (user == null)
               value = false;
           else 
               value = true;
           
           
        } catch (NoResultException e) {
            return false;
        } finally {
            em.close();
        }  return value;
  }
    
      
}


    
    
  


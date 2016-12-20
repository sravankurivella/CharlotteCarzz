-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 127.0.0.1    Database: my_taxi_service
-- ------------------------------------------------------
-- Server version	5.6.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer_confirmation`
--

DROP TABLE IF EXISTS `customer_confirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_confirmation` (
  `confirmation_id` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) DEFAULT NULL,
  `selected_driver_status` varchar(10) DEFAULT NULL,
  `driver_confirmation` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`confirmation_id`),
  KEY `customer_confirmation_fk_customerRequests` (`request_id`),
  CONSTRAINT `customer_confirmation_fk_customerRequests` FOREIGN KEY (`request_id`) REFERENCES `customer_requests` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_confirmation`
--

LOCK TABLES `customer_confirmation` WRITE;
/*!40000 ALTER TABLE `customer_confirmation` DISABLE KEYS */;
INSERT INTO `customer_confirmation` VALUES (4,6902,'Available',1),(5,6953,'Available',1),(6,6953,'Available',1),(7,6954,'Available',1),(8,7153,'Available',1),(9,7151,'Available',1),(10,7151,'Available',1),(11,7151,'Available',1),(12,7151,'Available',1),(13,7151,'Available',1),(14,7301,'Available',1),(15,7355,'Available',1),(16,7356,'Available',1),(17,7401,'Available',1),(18,7451,'Available',1),(19,7454,'Available',1),(20,7659,'Available',1),(21,7702,'Available',1),(22,7702,'Available',1),(23,7754,'Available',1),(24,7804,'Available',1),(25,7854,'Available',1),(26,7858,'Available',1),(27,7906,'Available',1),(28,7951,'Available',1),(29,7808,'Available',1),(30,8004,'Available',1),(31,8054,'Available',1),(32,8101,'Available',1);
/*!40000 ALTER TABLE `customer_confirmation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `CreateMessage` AFTER INSERT ON `customer_confirmation` FOR EACH ROW BEGIN
	IF(NEW.driver_confirmation = 1) THEN
		INSERT INTO my_taxi_service.messages 
			(MessageFromID, 
			MessageToID, 
			Message,
			Request_ID)
			SELECT 
			selected_driver_id, 
			customer_id, 
			'Driver has accepted your ride request',  
			customer_requests.Request_ID
			FROM customer_requests JOIN customer_confirmation ON customer_requests.Request_ID = customer_confirmation.Request_ID
			WHERE customer_requests.Request_ID = NEW.Request_ID;
            
		INSERT INTO my_taxi_service.ride 
			(confirmation_id, 
			customer_id, 
			driver_id, 
			miles, 
			avgCost_mile, 
			request_id
			)
			SELECT
			confirmation_id, 
			customer_id, 
			selected_driver_id, 
			distance, 
			drivers.currentRate_mile,
			customer_confirmation.Request_id
			FROM customer_confirmation JOIN customer_requests ON customer_requests.request_id = customer_confirmation.request_id
			JOIN drivers ON drivers.userID = customer_requests.selected_driver_id
			WHERE customer_confirmation.request_id =  NEW.Request_ID;
	ELSE
		INSERT INTO my_taxi_service.messages 
			(MessageFromID, 
			MessageToID, 
			Message,
			Request_ID)
			SELECT 
			selected_driver_id, 
			customer_id, 
			'Driver has declined your ride request',  
			customer_requests.Request_ID
			FROM customer_requests JOIN customer_confirmation ON customer_requests.Request_ID = customer_confirmation.Request_ID
			WHERE customer_requests.Request_ID = NEW.Request_ID;
	END IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customer_requests`
--

DROP TABLE IF EXISTS `customer_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_requests` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `present_zipcode` int(5) DEFAULT NULL,
  `destination_addressline` varchar(255) DEFAULT NULL,
  `selected_driver_id` int(11) DEFAULT NULL,
  `destination_zipcode` int(5) DEFAULT NULL,
  `search_driverRating` int(1) DEFAULT NULL,
  `search_datetime` datetime DEFAULT NULL,
  `source_addressline` varchar(255) DEFAULT NULL,
  `distance` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`request_id`),
  KEY `customer_requests_fk_users` (`customer_id`),
  CONSTRAINT `customer_requests_fk_users` FOREIGN KEY (`customer_id`) REFERENCES `user` (`USERID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_requests`
--

LOCK TABLES `customer_requests` WRITE;
/*!40000 ALTER TABLE `customer_requests` DISABLE KEYS */;
INSERT INTO `customer_requests` VALUES (4351,3853,28262,'Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(4401,3853,28262,'Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(4451,3853,28262,'Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(4501,3853,28262,'Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(4551,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5001,1651,28262,'#2, Atlanta, GA 30303, USA',3853,30303,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',249.79),(5051,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9498 Grove Hill Drive, Charlotte, NC 28262, USA',31.28),(5052,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9498 Grove Hill Drive, Charlotte, NC 28262, USA',31.28),(5101,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5151,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5201,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5202,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5203,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5204,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5205,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5251,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5252,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5253,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5254,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5255,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5301,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(5351,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(5352,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(5401,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5402,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5451,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5501,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5551,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5552,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5601,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5651,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5701,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(5751,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(5801,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(5851,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(5901,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(5951,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6001,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6051,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6052,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6053,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6101,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6151,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6201,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6202,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6251,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6301,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6351,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6352,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6401,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6451,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6501,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6551,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6552,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6601,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6651,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6701,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6751,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6801,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6851,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6852,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6853,1651,28262,'ECPI University - Charlotte, NC, 4800 Airport Center Parkway, Charlotte, NC 28208, USA',3853,28208,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',15.01),(6854,1651,28214,'11905 Allforth Lane, Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',32.25),(6855,1651,28262,'Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',31.30),(6901,1651,28262,'Atlanta, Atlanta, GA 30309, USA',3853,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(6902,1701,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(6951,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(6952,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(6953,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(6954,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7001,1701,28262,'Atlanta, Atlanta, GA 30309, USA',NULL,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7051,1701,28262,'Atlanta, Atlanta, GA 30309, USA',NULL,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7052,1701,28262,'Atlanta, Atlanta, GA 30309, USA',NULL,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7101,1701,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3853,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7151,1701,28262,'Atlanta, Atlanta, GA 30309, USA',3952,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7152,1701,28262,'Atlanta, Atlanta, GA 30309, USA',3853,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7153,1701,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7201,1701,28262,'Atlanta, Atlanta, GA 30309, USA',NULL,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7202,1701,28262,'Atlanta, Atlanta, GA 30309, USA',3952,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7203,1701,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7204,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7205,1701,28262,'Atlanta, Atlanta, GA 30309, USA',3952,30309,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',246.78),(7251,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9509 Grove Hill Drive, Charlotte, NC 28262, USA',26.05),(7301,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9509 Grove Hill Drive, Charlotte, NC 28262, USA',26.05),(7351,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7352,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7353,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7354,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7355,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7356,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7401,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7451,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7454,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7455,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',3952,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7657,1651,28214,'Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',29.60),(7658,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',NULL,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7659,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',7501,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7660,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',NULL,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7661,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',NULL,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7662,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',NULL,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7663,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',NULL,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7664,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',NULL,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7665,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',NULL,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7666,1651,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',7651,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7701,1651,28262,'Mill Cove Circle, Charlotte, NC 28262, USA',NULL,28262,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',6.12),(7702,1651,28262,'University of North Carolina at Charlotte: Main Office, 9201 University City Boulevard, Charlotte, NC 28223, USA',7501,28223,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',0.25),(7754,7753,28262,'Charlotte, NC 28262, USA',7501,28262,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',1.92),(7804,7803,28262,'Charlotte, NC, USA',7501,0,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',11.90),(7808,7805,28262,'Charlotte, NC, USA',7501,0,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',11.90),(7854,7851,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',7852,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7858,7855,28262,'Home, University of North Carolina at Charlotte: Main Office, Poplar Terrace Drive, Charlotte, NC 28214, USA',7856,28214,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',2.23),(7904,7901,28027,'University of North Carolina at Charlotte: Main Office, 9201 University City Boulevard, Charlotte, NC 28223, USA',NULL,28223,NULL,NULL,'Concord Mills Boulevard, 2, Poplar Tent, NC 28027, USA',5.52),(7905,7901,0,'University of North Carolina at Charlotte: Main Office, 9201 University City Boulevard, Charlotte, NC 28223, USA',NULL,28223,NULL,NULL,'North Carolina, USA',135.77),(7906,7901,28262,'Mill Cove Circle, Charlotte, NC 28262, USA',7902,28262,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',6.12),(7951,1651,28262,'#2, Atlanta, GA 30303, USA',7501,30303,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',249.79),(7952,1651,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',NULL,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(7953,1651,28027,'University of North Carolina at Charlotte: Main Office, 9201 University City Boulevard, Charlotte, NC 28223, USA',7655,28223,NULL,NULL,'Concord Mills Boulevard, 2, Poplar Tent, NC 28027, USA',5.52),(7954,1651,28262,'Mill Cove Circle, Charlotte, NC 28262, USA',NULL,28262,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',6.12),(7955,1651,28223,'Mill Cove Circle, Charlotte, NC 28262, USA',7856,28262,NULL,NULL,'University of North Carolina at Charlotte: Main Office, 9201 University City Boulevard, Charlotte, NC 28223, USA',5.93),(8004,8001,28223,'Mill Cove Circle, Charlotte, NC 28262, USA',8002,28262,NULL,NULL,'University of North Carolina at Charlotte: Main Office, 9201 University City Boulevard, Charlotte, NC 28223, USA',5.93),(8054,8051,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',8052,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03),(8101,8051,28262,'11905 Allforth Lane, Charlotte, NC 28277, USA',8052,28277,NULL,NULL,'9401 Grove Hill Drive, Charlotte, NC 28262, USA',26.03);
/*!40000 ALTER TABLE `customer_requests` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `messageSelectedDriver` AFTER UPDATE ON `customer_requests` 
	FOR EACH ROW BEGIN
		INSERT INTO my_taxi_service.messages 
			(MessageFromID, 
			MessageToID, 
			Message,
			Request_ID)
			SELECT DISTINCT
			customer_id,
			selected_driver_id,  
			'Customer has selected your ride. Please respond to request',  
			customer_requests.Request_ID
			FROM customer_requests JOIN customer_confirmation ON customer_requests.Request_ID = customer_confirmation.Request_ID
			WHERE customer_requests.Request_ID = NEW.request_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `drivers`
--

DROP TABLE IF EXISTS `drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drivers` (
  `DRIVERID` int(11) NOT NULL,
  `INSURANCE_COMP` varchar(255) DEFAULT NULL,
  `AGE` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `INSURANCE_NUM` varchar(255) DEFAULT NULL,
  `LICENSE_NUM` varchar(255) DEFAULT NULL,
  `USERID` int(11) DEFAULT NULL,
  `VEH_CAPACITY` int(11) DEFAULT NULL,
  `VEH_COLOR` varchar(255) DEFAULT NULL,
  `VEH_NAME` varchar(255) DEFAULT NULL,
  `VEHICLE_REG` varchar(255) DEFAULT NULL,
  `currentRate_mile` decimal(9,2) DEFAULT NULL,
  `Zipcode` varchar(45) DEFAULT NULL,
  `AVAIL_STATUS` varchar(1) DEFAULT NULL,
  `MAX_MILES_TO_DEST` int(11) DEFAULT NULL,
  `AVG_RATING` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`DRIVERID`),
  KEY `drivers_users_idx` (`USERID`),
  CONSTRAINT `drivers_users` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers`
--

LOCK TABLES `drivers` WRITE;
/*!40000 ALTER TABLE `drivers` DISABLE KEYS */;
INSERT INTO `drivers` VALUES (7502,'Geico',23,'2015-04-28','392832','123456',7501,4,'White','Sonata','veh_reg',3.00,'28262','Y',100,'4'),(7652,'Geico',23,'2015-04-28','2323131','232434',7651,4,'red','Mini cooper','veh_reg',8.00,'28262','Y',100,'3'),(7654,'Geico',23,'2015-04-28','2323131','232434',7653,6,'purple','Nissan GTR','veh_reg',8.00,'28262','Y',50,'5'),(7656,'Geico',23,'2015-04-28','2323131','232434',7655,5,'silver','Benz','veh_reg',3.00,'28027','Y',100,'4'),(7752,'Geico',23,'2015-04-28','2323131','232434',7751,4,'White','Mini cooper','veh_reg',12.00,'28027','Y',100,'4'),(7802,'Geico',23,'2015-04-28','2323131','232434',7801,5,'red','Mini cooper','veh_reg',3.00,'28262','Y',450,'3'),(7807,'Geico',23,'2015-04-28','2323131','232434',7806,5,'red','Sonata','veh_reg',3.00,'28223','Y',120,'4'),(7853,'Geico',23,'2015-04-28','2323131','232434',7852,5,'red','Sonata','veh_reg',12.00,'28027','Y',200,'4'),(7857,'Geico',23,'2015-04-28','2323131','232434',7856,5,'White','Mini cooper','veh_reg',3.00,'28223','Y',200,'4'),(7903,'Geico',23,'2015-04-28','2323131','232434',7902,5,'White','Nissan GTR','veh_reg',12.00,'28262','Y',200,'4'),(8003,'Geico',23,'2015-04-28','2323131','232434',8002,4,'White','Mini cooper','veh_reg',5.00,'28262','Y',200,'4'),(8053,'Geico',23,'2015-04-30','2323131','232434',8052,4,'White','Mini cooper','veh_reg',3.00,'28262','Y',200,'4');
/*!40000 ALTER TABLE `drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `MessageID` int(11) NOT NULL AUTO_INCREMENT,
  `MessageFromID` int(11) NOT NULL,
  `MessageToID` int(11) NOT NULL,
  `Message` varchar(250) DEFAULT NULL,
  `MarkForDelete` int(11) DEFAULT NULL,
  `Request_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`MessageID`),
  KEY `req_idx` (`Request_ID`),
  CONSTRAINT `req` FOREIGN KEY (`Request_ID`) REFERENCES `customer_requests` (`request_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,3952,1701,'Driver has declined your ride request',NULL,6902),(2,3952,1651,'Driver has accepted your ride request',NULL,6953),(3,3952,1651,'Driver has accepted your ride request',NULL,6953),(4,3952,1651,'Driver has accepted your ride request',NULL,6953),(6,3952,1651,'Driver has accepted your ride request',NULL,6954),(7,3952,1701,'Driver has accepted your ride request',NULL,7153),(8,3952,1701,'Driver has accepted your ride request',NULL,7151),(9,3952,1701,'Driver has accepted your ride request',NULL,7151),(10,3952,1701,'Driver has accepted your ride request',NULL,7151),(12,3952,1701,'Driver has accepted your ride request',NULL,7151),(13,3952,1701,'Driver has accepted your ride request',NULL,7151),(14,3952,1701,'Driver has accepted your ride request',NULL,7151),(15,3952,1701,'Driver has accepted your ride request',NULL,7151),(16,3952,1701,'Driver has accepted your ride request',NULL,7151),(17,3952,1701,'Driver has accepted your ride request',NULL,7151),(18,3952,1701,'Driver has accepted your ride request',NULL,7151),(22,3952,1701,'Driver has accepted your ride request',NULL,7151),(23,3952,1701,'Driver has accepted your ride request',NULL,7151),(24,3952,1701,'Driver has accepted your ride request',NULL,7151),(25,3952,1701,'Driver has accepted your ride request',NULL,7151),(26,3952,1701,'Driver has accepted your ride request',NULL,7151),(27,3952,1651,'Driver has accepted your ride request',NULL,7301),(28,3952,1651,'Driver has accepted your ride request',NULL,7355),(29,3952,1651,'Driver has accepted your ride request',NULL,7356),(30,3952,1651,'Driver has accepted your ride request',NULL,7401),(31,3952,1651,'Driver has accepted your ride request',NULL,7451),(32,3952,1651,'Driver has accepted your ride request',NULL,7454),(33,7501,1651,'Driver has accepted your ride request',NULL,7659),(34,7501,1651,'Driver has accepted your ride request',NULL,7702),(35,7501,1651,'Driver has accepted your ride request',NULL,7702),(36,7501,1651,'Driver has accepted your ride request',NULL,7702),(38,7501,7753,'Driver has accepted your ride request',NULL,7754),(39,7501,7803,'Driver has accepted your ride request',NULL,7804),(40,7852,7851,'Driver has accepted your ride request',NULL,7854),(41,7856,7855,'Driver has accepted your ride request',NULL,7858),(42,7902,7901,'Driver has accepted your ride request',NULL,7906),(43,7901,7902,'Customer has selected your ride. Please respond to request',NULL,7906),(44,7901,7902,'Customer has selected your ride. Please respond to request',NULL,7906),(45,7501,1651,'Driver has accepted your ride request',NULL,7951),(46,7501,7805,'Driver has accepted your ride request',NULL,7808),(47,8002,8001,'Driver has accepted your ride request',NULL,8004),(48,8052,8051,'Driver has accepted your ride request',NULL,8054),(49,8052,8051,'Driver has accepted your ride request',NULL,8101);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `ride_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `credit_card_num` varchar(20) DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `cvv_num` int(11) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `ride_id` (`ride_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`ride_id`) REFERENCES `ride` (`Ride_id`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ride` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `ride_id` int(11) DEFAULT NULL,
  `customer_rating` int(1) DEFAULT NULL,
  `driver_rating` int(1) DEFAULT NULL,
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `ride_id_UNIQUE` (`ride_id`),
  KEY `ride_id` (`ride_id`),
  KEY `customer_id` (`customer_id`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`ride_id`) REFERENCES `ride` (`Ride_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ride` (`customer_id`),
  CONSTRAINT `rating_ibfk_3` FOREIGN KEY (`driver_id`) REFERENCES `ride` (`driver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,1651,3952,24,NULL,3),(2,1651,3952,25,3,3),(4,1651,3952,26,NULL,3),(5,7753,7501,32,NULL,3),(6,7851,7852,34,3,3),(8,7855,7856,35,3,4),(10,7901,7902,36,3,NULL),(11,1701,3952,18,NULL,3),(12,8001,8002,39,NULL,5),(14,8051,8052,40,4,4),(17,8051,8052,41,5,5);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rewards_program`
--

DROP TABLE IF EXISTS `rewards_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rewards_program` (
  `program_id` int(11) NOT NULL,
  `program` varchar(20) DEFAULT NULL,
  `cashBack_percentage` int(11) DEFAULT NULL,
  `applicable_after_miles` int(11) DEFAULT NULL,
  PRIMARY KEY (`program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rewards_program`
--

LOCK TABLES `rewards_program` WRITE;
/*!40000 ALTER TABLE `rewards_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `rewards_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ride`
--

DROP TABLE IF EXISTS `ride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ride` (
  `Ride_id` int(11) NOT NULL AUTO_INCREMENT,
  `confirmation_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `miles` int(11) DEFAULT NULL,
  `avgCost_mile` decimal(10,2) DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `request_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Ride_id`),
  KEY `request_id` (`request_id`),
  KEY `ride_ibfk_3_idx` (`driver_id`),
  KEY `ride_ibfk_2` (`customer_id`),
  CONSTRAINT `ride_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `customer_requests` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ride_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `user` (`USERID`),
  CONSTRAINT `ride_ibfk_3` FOREIGN KEY (`driver_id`) REFERENCES `user` (`USERID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ride`
--

LOCK TABLES `ride` WRITE;
/*!40000 ALTER TABLE `ride` DISABLE KEYS */;
INSERT INTO `ride` VALUES (1,8,1701,3952,26,3.00,NULL,NULL,7153),(2,9,1701,3952,247,3.00,NULL,NULL,7151),(3,9,1701,3952,247,3.00,NULL,NULL,7151),(4,10,1701,3952,247,3.00,NULL,NULL,7151),(6,9,1701,3952,247,3.00,NULL,NULL,7151),(7,10,1701,3952,247,3.00,NULL,NULL,7151),(8,11,1701,3952,247,3.00,NULL,NULL,7151),(9,9,1701,3952,247,3.00,NULL,NULL,7151),(10,10,1701,3952,247,3.00,NULL,NULL,7151),(11,11,1701,3952,247,3.00,NULL,NULL,7151),(12,12,1701,3952,247,3.00,NULL,NULL,7151),(16,9,1701,3952,247,3.00,NULL,NULL,7151),(17,10,1701,3952,247,3.00,NULL,NULL,7151),(18,11,1701,3952,247,3.00,NULL,NULL,7151),(19,12,1701,3952,247,3.00,NULL,NULL,7151),(20,13,1701,3952,247,3.00,NULL,NULL,7151),(21,14,1651,3952,26,3.00,NULL,NULL,7301),(22,15,1651,3952,26,3.00,NULL,NULL,7355),(23,16,1651,3952,26,3.00,NULL,NULL,7356),(24,17,1651,3952,26,3.00,NULL,NULL,7401),(25,18,1651,3952,26,3.00,NULL,NULL,7451),(26,19,1651,3952,26,3.00,NULL,NULL,7454),(27,20,1651,7501,2,3.00,NULL,NULL,7659),(28,21,1651,7501,0,3.00,NULL,NULL,7702),(29,21,1651,7501,0,3.00,NULL,NULL,7702),(30,22,1651,7501,0,3.00,NULL,NULL,7702),(32,23,7753,7501,2,3.00,NULL,NULL,7754),(33,24,7803,7501,12,3.00,NULL,NULL,7804),(34,25,7851,7852,2,12.00,NULL,NULL,7854),(35,26,7855,7856,2,3.00,NULL,NULL,7858),(36,27,7901,7902,6,12.00,NULL,NULL,7906),(37,28,1651,7501,250,3.00,NULL,NULL,7951),(38,29,7805,7501,12,3.00,NULL,NULL,7808),(39,30,8001,8002,6,3.00,NULL,NULL,8004),(40,31,8051,8052,26,3.00,NULL,NULL,8054),(41,32,8051,8052,26,3.00,NULL,NULL,8101);
/*!40000 ALTER TABLE `ride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL,
  PRIMARY KEY (`SEQ_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequence`
--

LOCK TABLES `sequence` WRITE;
/*!40000 ALTER TABLE `sequence` DISABLE KEYS */;
INSERT INTO `sequence` VALUES ('SEQ_GEN',8150);
/*!40000 ALTER TABLE `sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `USERID` int(11) NOT NULL,
  `ADDRESS1` varchar(255) DEFAULT NULL,
  `ADDRESS2` varchar(255) DEFAULT NULL,
  `CITY` varchar(255) DEFAULT NULL,
  `COUNTRY` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `FIRSTNAME` varchar(255) DEFAULT NULL,
  `LASTNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `POSTALCODE` varchar(255) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  `PHONE` varchar(45) DEFAULT NULL,
  `USERNAME` varchar(45) DEFAULT NULL,
  `ROLE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1651,'9518 Grove Hill Dr','Apt 303','Charlotte','USA','avelagap@uncc.edu','Aneesha','Velagapudi','roadrash','28262','NC','7328902789','avelag','Customer'),(1701,'9518 Grove Hill De','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Vishrut','Konijeti','roadrash','28262','NC','7328902789','vishru','Customer'),(1901,'9203 Walden Station ','Apt 4','Charlotte',NULL,'aneeshav.au@gmail.com','Vinod','Palreddy','roadrash','28262','NC','7328902789','vinod','Customer'),(2101,'9518 Grove hill Dr','Apt 303','Charlotte',NULL,'avelagap@uncc.edu','Hemanth','Kumar','roadrash','28262','NC','7328902789','abc','Driver'),(3101,'9518 Grove Hill De','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Vinya','Konijeti','roadrash','28262','NC','7328902789','cdv','Driver'),(3853,'9518 Grove Hill Dr','Apt 505','Charlotte',NULL,'ankita@gmail.com','Ankita ','Sharma','roadrash','28262','NC','7328902789','dfsd','Driver'),(3952,'9518 gsdkh','lkjskldj','Charlotte',NULL,'aneeshav.au@gmail.com','Surya','Teja','roadrash','28262','NC','7328902789','sdffds','Driver'),(4301,'9518 Grove hill dr','Apt 303','Charlotte',NULL,'manisha@gmail.com','Manisha','Mishra','roadrash','28262','NC','7328902789','sfsd','Driver'),(7501,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Hemanth','Kumar','roadrash','28262','NC','7328902789','phemanth','Driver'),(7651,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Vaibav','Kamat','roadrash','28262','NC','7328902789','vaibhav','Driver'),(7653,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Anikta','Sharma','roadrash','28262','NC','7328902789','anikita','Driver'),(7655,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Vinay','Chanchlani','roadrash','28262','NC','7328902789','vinay','Driver'),(7751,'9518 Grove Hil Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Akshay','Vadachari','roadrash','28262','NC','7328902789','akshay','Driver'),(7753,'11905 Allforth Lane','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Ashritha','Donepudi','roadrash','28262','NC','7328902789','ashu','Customer'),(7801,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Harshini','Donepudi','roadrash','28277','NC','7328902789','harshini','Driver'),(7803,'98723jkfj','lkjdfslk','Charlotte',NULL,'aneeshav.au@gmail.com','Vinya','Chow','roadrash','28262','NC','7328902789','vinya','Customer'),(7805,'9518 sfjskdj','ksjfsdk','Charlotte',NULL,'aneeshav.au@gmail.com','Lakshmi ','Donepudi','roadrash','28262','NC','7328902789','lakshmi','Customer'),(7806,'09238kdjflskdj','fjsldkjfkslj','Charlotte',NULL,'aneeshav.au@gmail.com','rani','donepudi','roadrash','28277','NC','','rani','Driver'),(7851,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Vineela','Peddi','roadrash','28262','NC','7328902789','vineela','Customer'),(7852,'ksdhfskdj','ksjdklsdj','Charlotte',NULL,'aneeshav.au@gmail.com','Deepthi','Rokkam','roadrash','28262','NC','7328902789','deepti','Driver'),(7855,'sklfjsdlkj','skdjfksdlj','Charlotte',NULL,'aneeshav.au@gmail.com','Sneha','P','roadrash','28262','NC','7328902789','sneha','Customer'),(7856,'9sdkfjsdkl','sjdkflskj','Charlotte',NULL,'aneeshav.au@gmail.com','Gopi','Sai','roadrash','28262','NC','7328902789','gopi','Driver'),(7901,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Sagarika','Patnaik','roadrash','28262','NC','7328902789','sagarika','Customer'),(7902,'951kdfjd','kjdfjk','Charlotte',NULL,'aneeshav.au@gmail.com','Sri','Latha','roadrash','28262','NC','7328902789','latha','Driver'),(8001,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','David','Wilson','roadrash','28262','NC','7328902789','dave','Customer'),(8002,'9518 Grove','APt 303','Charlotte',NULL,'aneeshav.au@gmail.com','RAvi','Penubakula','roadrash','28262','NC','7328902789','ravi','Driver'),(8051,'9518 Grove Hill Dr','Apt 303 ','Charlotte',NULL,'aneeshav.au@gmail.com','Disha','Bharadwaj','roadrash','28262','NC','7328902789','disha','Customer'),(8052,'9518 Grove Hill Dr','Apt 303','Charlotte',NULL,'aneeshav.au@gmail.com','Purvesh','Jadav','roadrash','28262','NC','7328902789','purvesh','Driver');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'my_taxi_service'
--

--
-- Dumping routines for database 'my_taxi_service'
--
/*!50003 DROP PROCEDURE IF EXISTS `confirmAccept_request` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `confirmAccept_request`(IN reqst_ID INT)
begin
INSERT INTO customer_confirmation
	(request_id, 
	selected_driver_status, 
	driver_confirmation
	)
	values
	(reqst_ID, 
	'Available', 
	1
	);
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customer_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_rating`(IN rideID INT,IN dID INT,IN cID INT,IN crate INT)
BEGIN
		INSERT INTO my_taxi_service.rating 
			( 
			customer_id, 
			driver_id, 
			ride_id, 
			customer_rating, 
			driver_rating
			)
			VALUES
			( 
			cID, 
			dID, 
			rideID, 
			crate, 
			NULL
			)ON DUPLICATE KEY UPDATE customer_rating= crate;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `driver_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `driver_rating`(IN rideID INT,IN dID INT,IN cID INT,IN drate INT)
BEGIN
		INSERT INTO my_taxi_service.rating 
			( 
			customer_id, 
			driver_id, 
			ride_id, 
			customer_rating, 
			driver_rating
			)
			VALUES
			( 
			cID, 
			dID, 
			rideID, 
			NULL, 
			drate
			)ON DUPLICATE KEY UPDATE driver_rating= drate;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login_authentication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login_authentication`(IN userName CHAR(20),IN xyz Char(30),OUT userID INT)
BEGIN
  SELECT my_taxi_service.USER.USERID INTO userID FROM my_taxi_service.USER
  WHERE my_taxi_service.USER.USERNAME = userName AND my_taxi_service.USER.PASSWORD = xyz;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_driver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_driver`(IN zip int(10), IN rate DECIMAL(9,2) , IN usr INT(10))
begin
update drivers 
set Zipcode = zip , currentRate_mile = rate 
where userid = usr;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_request` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_request`(IN dr_id int, IN us_id INT,IN reqst_ID INT)
begin
update customer_requests
set selected_driver_id = dr_id
where customer_id = us_id AND request_id = reqst_ID;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-30 17:43:12

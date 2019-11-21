-- MySQL dump 10.13  Distrib 8.0.18, for osx10.15 (x86_64)
--
-- Host: localhost    Database: itesm_exchange
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `all_grades_vw`
--

DROP TABLE IF EXISTS `all_grades_vw`;
/*!50001 DROP VIEW IF EXISTS `all_grades_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_grades_vw` AS SELECT 
 1 AS `id_course`,
 1 AS `course_description`,
 1 AS `student`,
 1 AS `student_name`,
 1 AS `student_last_name`,
 1 AS `professor`,
 1 AS `professor_name`,
 1 AS `professor_last_name`,
 1 AS `grade`,
 1 AS `grade_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `id_campus` int(11) NOT NULL AUTO_INCREMENT,
  `campus_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id_campus`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
INSERT INTO `campus` VALUES (1,'CSF','2019-11-16 00:00:00'),(2,'CCM','2019-11-16 00:00:00'),(3,'CEM','2019-11-16 00:00:00'),(4,'CCV','2019-11-16 00:00:00'),(5,'CCJ','2019-11-16 00:00:00'),(6,'CSP','2019-11-16 00:00:00'),(7,'CSN','2019-11-16 00:00:00'),(8,'CTO','2019-11-16 00:00:00');
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id_course` int(11) NOT NULL AUTO_INCREMENT,
  `course_description` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `first_day` datetime DEFAULT NULL,
  `last_day` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id_course`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Phisics 1','2019-07-01 00:00:00','2019-08-01 00:00:00','2019-11-16 00:00:00'),(2,'Global History','2019-07-01 00:00:00','2019-08-01 00:00:00','2019-11-16 00:00:00'),(3,'French I','2019-07-01 00:00:00','2019-08-01 00:00:00','2019-11-16 00:00:00'),(4,'Chemistry','2019-07-01 00:00:00','2019-08-01 00:00:00','2019-11-16 00:00:00'),(5,'Biology','2019-07-01 00:00:00','2019-08-01 00:00:00','2019-11-16 00:00:00'),(6,'Math I','2019-07-01 00:00:00','2019-08-01 00:00:00','2019-11-16 00:00:00');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_course` int(11) NOT NULL,
  `student` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `professor` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `grade` int(11) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grades_to_course_fk01` (`id_course`),
  KEY `grades_to_student_fk02` (`student`),
  KEY `grades_to_student_fk03` (`professor`),
  CONSTRAINT `grades_to_course_fk01` FOREIGN KEY (`id_course`) REFERENCES `courses` (`id_course`),
  CONSTRAINT `grades_to_student_fk02` FOREIGN KEY (`student`) REFERENCES `users` (`username`),
  CONSTRAINT `grades_to_student_fk03` FOREIGN KEY (`professor`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (1,1,'a01018992@itesm.mx','carlos.vega@mail.com',100,'2019-11-20 00:00:00'),(2,2,'a01018992@itesm.mx','vicente.cubells@mail.com',100,'2019-11-20 00:00:00'),(3,3,'a01018992@itesm.mx','profesor1@mail.com',90,'2019-11-20 00:00:00'),(4,4,'a01018992@itesm.mx','profesor2@mail.com',85,'2019-11-20 00:00:00'),(5,5,'a01018992@itesm.mx','profesor3@mail.com',92,'2019-11-20 00:00:00'),(6,6,'a01018992@itesm.mx','profesor4@mail.com',80,'2019-11-20 00:00:00');
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_type` (
  `id_user_type` int(11) NOT NULL AUTO_INCREMENT,
  `description_user_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES (1,'Student','2019-11-16 00:00:00'),(2,'Professor','2019-11-16 00:00:00'),(3,'PI','2019-11-16 00:00:00');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `userid` varchar(9) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'A00XXXXXX',
  `password` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `id_user_type` int(11) NOT NULL,
  `id_campus` int(11) NOT NULL,
  PRIMARY KEY (`username`),
  KEY `users_to_usertype_fk01` (`id_user_type`),
  KEY `users_to_campus_fk02` (`id_campus`),
  CONSTRAINT `users_to_campus_fk02` FOREIGN KEY (`id_campus`) REFERENCES `campus` (`id_campus`),
  CONSTRAINT `users_to_usertype_fk01` FOREIGN KEY (`id_user_type`) REFERENCES `user_type` (`id_user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('a01018990@itesm.mx','a01018990','$6$rounds=656000$qcAJj9Rm49PMvx9e$gIA2ffeTqdZvZlcldrDkNqtjE0ya5QiReI3Pys06bVZeI9oh2.DpUwPhj51z0bZiSGd5w2uNFXAHovrbuCeId1','Michell Yolotzin','Gomez Sanchez','2019-01-01 00:00:00',1,1),('a01018992@itesm.mx','a01018992','$6$rounds=656000$xdzZACkfSG/4cobR$fdxxZ2oy2KW.Y7l4.nAAOeUf62CHFw2mSJ/Cf7XZTDdAiV2XRdBO8cqKBodaaat3P3ehyGQYRFb7kMYHbhfmA.','Diego Kaleb','Valenzuela Carrillo','2019-01-01 00:00:00',1,1),('a01022089@itesm.mx','a01018992','$6$rounds=656000$8wCpxTt7RzJbhGzK$bjVFssHaSholTwEemZULxsC8inwQHVCoW2OR8iDc1JTwFW2uhpt.mejQm0f6y8lBV2j8NZORm4Zlvl6KUXEi01','Manuel Alejandro','Hernandez Pena','2019-01-01 00:00:00',1,1),('a01024385@itesm.mx','a01024385','$6$rounds=656000$lfm7f73CFRf//yAD$BiOanTBAmt2lj1pLfpOWOiwW3KqTChoURI4ltS5JeFNBWNQPzfaDnonNnRC.lH5a1WgRL4GkDrYUY6L3RzQ0l.','Andres','Campos Tams','2019-01-01 00:00:00',1,1),('a01027643@itesm.mx','a01027643','$6$rounds=656000$5801tQh6xuSwTjZT$IvXSFZjjD5YyBjXyXjp9xKzGUMaVL3MT4bHkx2LKYHoKO0RfTmkE9U2Vu/SrJ.Rvi7B4YWaMZtGze4mnLcJvh0','Stephanie','Olivares Flores','2019-01-01 00:00:00',1,1),('alumno10@itesm.mx','a01010010','$6$rounds=656000$3zjBLAfDn1sgZcl/$l3nygy/2laDt3p2rkOWL3cMR274ISlLM49Y0UJYAbAhKIogtUg9ebRzF6FEfSYkLORTlyrSpn9TN0dz21hSko.','Alumno','10','2019-01-01 00:00:00',1,2),('alumno11@itesm.mx','a01010011','$6$rounds=656000$78oJQmGa0UnTiXWb$3rjoOBxWatgBMtmuX1Eo6fMsPJXfHshJDLvEIX.bOIPbTkIKU0P5kdw49p8JO.pquwtn/tmtDKopKj3I1ImEZ.','Alumno','11','2019-01-01 00:00:00',1,3),('alumno12@itesm.mx','a01010012','$6$rounds=656000$HyoZb4qWcDOhmyt9$DOhs0uio9vK5A5VFv6FWevprCc./jOiHkKCvngmm8jUqpIxVPO6pirP3sB5VvsL7j2IzZIDawmWXIg7ddvwPD1','Alumno','12','2019-01-01 00:00:00',1,4),('alumno13@itesm.mx','a01010013','$6$rounds=656000$3DC7.nqKVixr2Yey$OwKzPVrcv8iTL/PYuXR2XsGPW39XJU968F7CtGdGeWXyRKV.3r1iFDUqILTJGhGzQJ0bVc9XByoS12nk3sNIm0','Alumno','13','2019-01-01 00:00:00',1,5),('alumno14@itesm.mx','a01010014','$6$rounds=656000$gIh7Pj2Z0M35p1xs$LvKtSKKn6TqU7XR3Lm5tNGFL7c2VsIXgx4h/whRleTm8F2CFmNGi4W0E5kwUhxxB9zJHeXR7GVG3oLW5DB63N0','Alumno','14','2019-01-01 00:00:00',1,6),('alumno15@itesm.mx','a01010015','$6$rounds=656000$JsM.c8VSZGTSHcFY$fhFVV9pnYJPkw6u0rM88TRe2VcLnczDSDyARrgA4eZq4nsjRzemBnjOq4ao8rqPKBo2h7QooujaW.XqgHnBJ2/','Alumno','15','2019-01-01 00:00:00',1,7),('alumno1@itesm.mx','a01010001','$6$rounds=656000$pm7VLdFXalB7O7OT$AOTZ7QSesEi3KiuvdpEFO7UJIXxcoeGPTeDgGYRAUmRTLyu2OM48jMe1fXytQS62g6cawBGIcm4coCDdb7FH00','Alumno','1','2019-01-01 00:00:00',1,5),('alumno2@itesm.mx','a01010002','$6$rounds=656000$PXd/TeepfpRyUutE$e/FghOZOvrvXtv4sFPtapXoGJdsqTNN1pKQLbMThvUBlJp3V5HaO1KNo2W1y0cJILVoWo9QiQZRm5GT9ZKA2u1','Alumno','2','2019-01-01 00:00:00',1,8),('alumno3@itesm.mx','a01010003','$6$rounds=656000$DZattHwbZDfKoHiz$HCty4eo0qTPxwoXdg1qfu.Gzc09soO1Uu7jnMLeNAAkHsdCgg.oD1QFDsdBZtsrt30PpW7nSJ77ZbnvI38Uci.','Alumno','3','2019-01-01 00:00:00',1,3),('alumno4@itesm.mx','a01010004','$6$rounds=656000$0JPe/K0.tCQAhzUb$yqYRTfYIL.lGtff3LA.qvY3JWP8P1LGeaRvumu799mUAkMfMniJrZigcOLxGGZpCmPIVAivzM/bexcQxizL3d/','Alumno','4','2019-01-01 00:00:00',1,4),('alumno5@itesm.mx','a01010005','$6$rounds=656000$oKhc5Vptvzb1YzSE$RwcXMeojikulediWGZlS7mtxpkh6QY/DIpL2E89.2KwAMQc2eUxwJq86Uw81NSt1a01YMucG70xM8AJeQHTew/','Alumno','5','2019-01-01 00:00:00',1,5),('alumno6@itesm.mx','a01010006','$6$rounds=656000$rcG3Gp4cDm.1lXGQ$3UN2nTAV27qCdI.m5.2K8Hv670i7V5.Mtb9IpRdjQIXP79wFKpxg.QMUHIkTIujKXUcqKQBCGnz0UkuFnolPn.','Alumno','6','2019-01-01 00:00:00',1,6),('alumno7@itesm.mx','a01010007','$6$rounds=656000$vmoagOoEVid8qo7p$M14AXlCFJi88ZCUQ1Hws1tsWWByFpDk82NWB2JZtT9SnqqGhiqCKHL3FbRnz64eKAZH6j/ihUwL6Wy92nQJtq.','Alumno','7','2019-01-01 00:00:00',1,7),('alumno8@itesm.mx','a01010008','$6$rounds=656000$zdpHzaNLxeW0qy0w$xbhufABm4qHk1ffUSYNnuPPKb4/wrc1ZdoKYgd7LMES/anOar9kPuY6IibZfMUxKfmRUk1ODWhkwqQ54M4hjN/','Alumno','8','2019-01-01 00:00:00',1,8),('alumno9@itesm.mx','a01010009','$6$rounds=656000$KV3eTVnnWgLqud34$lEmCV.6Eb3nxw6JV4xabqnV0lDhP3cAo4R3jaxj/QIjHbwhoMA8voqm18hM7UOguyQhzEbkeRRjoQRY2KFYSE.','Alumno','9','2019-01-01 00:00:00',1,1),('carlos.vega@mail.com','A00XXXXXX','$6$rounds=656000$SY5MJa.jSfSqrQ.k$ygjhIbMgUOE7mneQmwKOV0s9l6BaZSob0cdR6oDihNN3TM3qJBQIHTs5KaQiuSDwbsp1tTPH1Ds5c8P/GPh5Y0','Carlos Enrique','Vega Alvares','2019-01-01 00:00:00',2,1),('profesor1@mail.com','A00XXXXXX','$6$rounds=656000$UYPulxh0ItYqobEC$2jEN.cWvZzxtyzjsce9sOmB4MeiFb.yapGa5nqXkhsCel77YH/R/b8IGvRM7j/vECZU0OKchpUUo4zc4VkhWY/','Profesor','1','2019-01-01 00:00:00',2,1),('profesor2@mail.com','A00XXXXXX','$6$rounds=656000$5ff4SAD1UM7J9wu0$6tdttpHC3jQGbHL7Fl89LX802g.12BPiqe.N1X3qhwxE/PwPmxkPyO8zjyyTZi/Y26Tuejo8N89KrPPynTAHn/','Profesor','2','2019-01-01 00:00:00',2,1),('profesor3@mail.com','A00XXXXXX','$6$rounds=656000$of0SGflc9xo8Bz7u$ydIe2AGPXsqf8YriCUx1Zkzzfo/f5z/wWhMXS6bSaa2VwO1XLu06xUXzOPDmHts7EhG8ggQ8jD6g6ejrdnPYa1','Profesor','3','2019-01-01 00:00:00',2,1),('profesor4@mail.com','A00XXXXXX','$6$rounds=656000$/TwAjhmCO9I8zKJ0$fmmUWDoBrb25MJfTf/oRRWvQzy2OJNCOm.EkZD1t0SjKK0hRq6NIMT40WbH0LWyYIk4caYPdm2eD.boEsNz2I1','Profesor','4','2019-01-01 00:00:00',2,1),('vicente.cubells@mail.com','A00XXXXXX','$6$rounds=656000$WVmcLNc.g0wNUR9X$ypnwsEIE5DfGky9hY17HRzMy.Yhwnd873qx0S5wfWVABygLjdB027Su/WvODOhw6o.ZtKoUvbqcvKgyV/b11V.','Vicente','Cubells Nonell','2019-01-01 00:00:00',2,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'itesm_exchange'
--

--
-- Final view structure for view `all_grades_vw`
--

/*!50001 DROP VIEW IF EXISTS `all_grades_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_grades_vw` AS select `g`.`id_course` AS `id_course`,`c`.`course_description` AS `course_description`,`g`.`student` AS `student`,`u1`.`name` AS `student_name`,`u1`.`last_name` AS `student_last_name`,`g`.`professor` AS `professor`,`u2`.`name` AS `professor_name`,`u2`.`last_name` AS `professor_last_name`,`g`.`grade` AS `grade`,`g`.`created` AS `grade_date` from (((`grades` `g` join `users` `u1`) join `users` `u2`) join `courses` `c`) where ((1 = 1) and (`g`.`student` = `u1`.`username`) and (`g`.`professor` = `u2`.`username`) and (`g`.`id_course` = `c`.`id_course`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-19 13:25:22

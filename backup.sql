-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: db_prueba_backend_sql
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

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
-- Table structure for table `bodegas`
--

DROP TABLE IF EXISTS `bodegas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bodegas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `id_responsable` bigint unsigned NOT NULL,
  `estado` tinyint NOT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `update_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bodegas_users_responsable` (`id_responsable`),
  KEY `fk_bodegas_users_created` (`created_by`),
  KEY `fk_bodegas_users_update` (`update_by`),
  CONSTRAINT `fk_bodegas_users_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_bodegas_users_responsable` FOREIGN KEY (`id_responsable`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_bodegas_users_update` FOREIGN KEY (`update_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bodegas`
--

LOCK TABLES `bodegas` WRITE;
/*!40000 ALTER TABLE `bodegas` DISABLE KEYS */;
/*!40000 ALTER TABLE `bodegas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historiales`
--

DROP TABLE IF EXISTS `historiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historiales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `id_bodega_origen` bigint unsigned NOT NULL,
  `id_bodega_destino` bigint unsigned NOT NULL,
  `id_inventario` bigint unsigned NOT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `update_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_historiales_inventarios` (`id_inventario`),
  KEY `fk_historiales_bodegas_origen` (`id_bodega_origen`),
  KEY `fk_historiales_bodegas_destino` (`id_bodega_destino`),
  KEY `fk_historiales_users_created` (`created_by`),
  KEY `fk_historiales_users_update` (`update_by`),
  CONSTRAINT `fk_historiales_bodegas_destino` FOREIGN KEY (`id_bodega_destino`) REFERENCES `bodegas` (`id`),
  CONSTRAINT `fk_historiales_bodegas_origen` FOREIGN KEY (`id_bodega_origen`) REFERENCES `bodegas` (`id`),
  CONSTRAINT `fk_historiales_inventarios` FOREIGN KEY (`id_inventario`) REFERENCES `inventarios` (`id`),
  CONSTRAINT `fk_historiales_ users_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_historiales_users_update` FOREIGN KEY (`update_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historiales`
--

LOCK TABLES `historiales` WRITE;
/*!40000 ALTER TABLE `historiales` DISABLE KEYS */;
/*!40000 ALTER TABLE `historiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarios`
--

DROP TABLE IF EXISTS `inventarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventarios` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_bodega` bigint unsigned NOT NULL,
  `id_producto` bigint unsigned NOT NULL,
  `cantidad` int NOT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `update_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_inventarios_users_created` (`created_by`),
  KEY `fk_inventarios_users_update` (`update_by`),
  CONSTRAINT `fk_inventarios_bodegas` FOREIGN KEY (`id_bodega`) REFERENCES `bodegas` (`id`),
  CONSTRAINT `fk_inventarios_productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `fk_inventarios_users_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_inventarios_users_update` FOREIGN KEY (`update_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios`
--

LOCK TABLES `inventarios` WRITE;
/*!40000 ALTER TABLE `inventarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estado` tinyint NOT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `update_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productos_users_created` (`created_by`),
  KEY `fk_productos_users_uptade` (`update_by`),
  CONSTRAINT `fk_productos_users_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_productos_users_uptade` FOREIGN KEY (`update_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `estado` tinyint NOT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `update_by` bigint unsigned DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'juan0','juan 0@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(12,'juan1','juan 1@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(13,'juan2','juan 2@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(14,'juan3','juan 3@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(15,'juan4','juan 4@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(16,'juan5','juan 5@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(17,'juan6','juan 6@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(18,'juan7','juan 7@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(19,'juan8','juan 8@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL),(20,'juan9','juan 9@hotmail.com',NULL,1,NULL,NULL,NULL,'12345',NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-05  9:13:34

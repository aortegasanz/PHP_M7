-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.17-MariaDB


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema youtube
--

CREATE DATABASE IF NOT EXISTS youtube;
USE youtube;

--
-- Definition of table `canales`
--

DROP TABLE IF EXISTS `canales`;
CREATE TABLE `canales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `canales_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `canales`
--

/*!40000 ALTER TABLE `canales` DISABLE KEYS */;
INSERT INTO `canales` (`id`,`nombre`,`descripcion`,`fecha_creacion`,`usuario_id`) VALUES 
 (1,'Del Saló a la Discoteque','Canal DJ\'s música techno remember','2020-02-25 15:33:22',1),
 (2,'La última y nos vamos','Programa Radio Música de todos los tiempos','2020-02-25 16:33:22',2);
/*!40000 ALTER TABLE `canales` ENABLE KEYS */;


--
-- Definition of table `comentariosregistro`
--

DROP TABLE IF EXISTS `comentariosregistro`;
CREATE TABLE `comentariosregistro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `tipovaloracion_id` int(11) DEFAULT NULL,
  `fecha_comentario` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_id` (`comment_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `tipovaloracion_id` (`tipovaloracion_id`),
  CONSTRAINT `comentariosregistro_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `videoscomentario` (`id`),
  CONSTRAINT `comentariosregistro_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `comentariosregistro_ibfk_3` FOREIGN KEY (`tipovaloracion_id`) REFERENCES `tiposvaloracion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comentariosregistro`
--

/*!40000 ALTER TABLE `comentariosregistro` DISABLE KEYS */;
INSERT INTO `comentariosregistro` (`id`,`comment_id`,`usuario_id`,`tipovaloracion_id`,`fecha_comentario`) VALUES 
 (1,1,1,1,'2021-02-25 17:50:33'),
 (2,1,2,1,'2021-02-25 17:53:33'),
 (3,2,1,1,'2021-02-25 17:57:33'),
 (5,2,3,1,'2021-02-25 17:58:33'),
 (6,2,2,2,'2021-02-25 17:54:33');
/*!40000 ALTER TABLE `comentariosregistro` ENABLE KEYS */;


--
-- Definition of table `estados`
--

DROP TABLE IF EXISTS `estados`;
CREATE TABLE `estados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `estados`
--

/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` (`id`,`nombre`) VALUES 
 (1,'Público'),
 (2,'Oculto'),
 (3,'Privado');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;


--
-- Definition of table `estadosplaylist`
--

DROP TABLE IF EXISTS `estadosplaylist`;
CREATE TABLE `estadosplaylist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `estadosplaylist`
--

/*!40000 ALTER TABLE `estadosplaylist` DISABLE KEYS */;
INSERT INTO `estadosplaylist` (`id`,`nombre`) VALUES 
 (1,'Pública'),
 (2,'Privada');
/*!40000 ALTER TABLE `estadosplaylist` ENABLE KEYS */;


--
-- Definition of table `etiquetas`
--

DROP TABLE IF EXISTS `etiquetas`;
CREATE TABLE `etiquetas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `etiquetas`
--

/*!40000 ALTER TABLE `etiquetas` DISABLE KEYS */;
INSERT INTO `etiquetas` (`id`,`nombre`) VALUES 
 (1,'Música'),
 (2,'Techno'),
 (3,'80\'s'),
 (4,'Remember');
/*!40000 ALTER TABLE `etiquetas` ENABLE KEYS */;


--
-- Definition of table `etiquetasvideo`
--

DROP TABLE IF EXISTS `etiquetasvideo`;
CREATE TABLE `etiquetasvideo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` int(11) DEFAULT NULL,
  `etiqueta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_id` (`video_id`),
  KEY `etiqueta_id` (`etiqueta_id`),
  CONSTRAINT `etiquetasvideo_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`),
  CONSTRAINT `etiquetasvideo_ibfk_2` FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `etiquetasvideo`
--

/*!40000 ALTER TABLE `etiquetasvideo` DISABLE KEYS */;
INSERT INTO `etiquetasvideo` (`id`,`video_id`,`etiqueta_id`) VALUES 
 (1,1,1),
 (2,1,2),
 (3,1,4),
 (4,2,1),
 (5,2,3);
/*!40000 ALTER TABLE `etiquetasvideo` ENABLE KEYS */;


--
-- Definition of table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
CREATE TABLE `playlists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `estadoplaylist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `estadoplaylist_id` (`estadoplaylist_id`),
  CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `playlists_ibfk_2` FOREIGN KEY (`estadoplaylist_id`) REFERENCES `estadosplaylist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `playlists`
--

/*!40000 ALTER TABLE `playlists` DISABLE KEYS */;
INSERT INTO `playlists` (`id`,`nombre`,`usuario_id`,`fecha_creacion`,`estadoplaylist_id`) VALUES 
 (1,'Toda la música',3,'2021-02-25 18:42:33',1),
 (2,'Mi música',3,'2021-02-25 17:42:33',2);
/*!40000 ALTER TABLE `playlists` ENABLE KEYS */;


--
-- Definition of table `playlistsvideo`
--

DROP TABLE IF EXISTS `playlistsvideo`;
CREATE TABLE `playlistsvideo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playlist_id` int(11) DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `playlist_id` (`playlist_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `playlistsvideo_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`),
  CONSTRAINT `playlistsvideo_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `playlistsvideo`
--

/*!40000 ALTER TABLE `playlistsvideo` DISABLE KEYS */;
INSERT INTO `playlistsvideo` (`id`,`playlist_id`,`video_id`) VALUES 
 (1,1,1),
 (2,1,2),
 (3,2,1);
/*!40000 ALTER TABLE `playlistsvideo` ENABLE KEYS */;


--
-- Definition of table `suscripciones`
--

DROP TABLE IF EXISTS `suscripciones`;
CREATE TABLE `suscripciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `canal_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `canal_id` (`canal_id`),
  CONSTRAINT `suscripciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `suscripciones_ibfk_2` FOREIGN KEY (`canal_id`) REFERENCES `canales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `suscripciones`
--

/*!40000 ALTER TABLE `suscripciones` DISABLE KEYS */;
INSERT INTO `suscripciones` (`id`,`usuario_id`,`canal_id`) VALUES 
 (1,1,1),
 (2,1,2);
/*!40000 ALTER TABLE `suscripciones` ENABLE KEYS */;


--
-- Definition of table `tiposusuario`
--

DROP TABLE IF EXISTS `tiposusuario`;
CREATE TABLE `tiposusuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tiposusuario`
--

/*!40000 ALTER TABLE `tiposusuario` DISABLE KEYS */;
INSERT INTO `tiposusuario` (`id`,`nombre`) VALUES 
 (1,'Premium'),
 (2,'Free');
/*!40000 ALTER TABLE `tiposusuario` ENABLE KEYS */;


--
-- Definition of table `tiposvaloracion`
--

DROP TABLE IF EXISTS `tiposvaloracion`;
CREATE TABLE `tiposvaloracion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tiposvaloracion`
--

/*!40000 ALTER TABLE `tiposvaloracion` DISABLE KEYS */;
INSERT INTO `tiposvaloracion` (`id`,`nombre`) VALUES 
 (1,'Like'),
 (2,'Dislike');
/*!40000 ALTER TABLE `tiposvaloracion` ENABLE KEYS */;


--
-- Definition of table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `usuari` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` varchar(255) DEFAULT NULL,
  `pais` varchar(255) DEFAULT NULL,
  `poblacion` varchar(255) DEFAULT NULL,
  `tiposusuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tiposusuario_id` (`tiposusuario_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tiposusuario_id`) REFERENCES `tiposusuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuarios`
--

/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`,`email`,`password`,`usuari`,`fecha_nacimiento`,`sexo`,`pais`,`poblacion`,`tiposusuario_id`) VALUES 
 (1,'delsalonaladiscoteque@gmail.com','1234','salontodisco','1980-01-01','s/d','España','Sant Fost de Campsentelles',1),
 (2,'laultimaynosvamos@gmail.com','3212','lautilmaynosvamos','1975-01-01','s/d','España','Mollet del Vallés',1),
 (3,'ortegasanz@gmail.com','123213','ortegasanz','1980-03-29','H','España','Martorelles',2);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;


--
-- Definition of table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `tamano` double DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `duracion` time DEFAULT NULL,
  `thumbnail` blob DEFAULT NULL,
  `num_reprod` bigint(20) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_publicacion` datetime DEFAULT NULL,
  `estado_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `estado_id` (`estado_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `videos_ibfk_2` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `videos`
--

/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` (`id`,`titulo`,`descripcion`,`tamano`,`archivo`,`duracion`,`thumbnail`,`num_reprod`,`usuario_id`,`fecha_publicacion`,`estado_id`) VALUES 
 (1,'Sesión Techno Remember','Sesión Remember Techno Fin de Año 2020',248556,'\\AS3KDKFJ1.mp3','01:23:00',NULL,0,1,'2020-02-25 16:00:23',1),
 (2,'Programa Radio los 80','Programa Radio los 80',1315643,'\\AK3434DF1.mp3','10:33:00',NULL,0,2,'2020-02-25 16:10:23',2);
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;


--
-- Definition of table `videoscomentario`
--

DROP TABLE IF EXISTS `videoscomentario`;
CREATE TABLE `videoscomentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `texto` varchar(255) DEFAULT NULL,
  `fecha_comentario` datetime DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `videoscomentario_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `videoscomentario_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `videoscomentario`
--

/*!40000 ALTER TABLE `videoscomentario` DISABLE KEYS */;
INSERT INTO `videoscomentario` (`id`,`texto`,`fecha_comentario`,`usuario_id`,`video_id`) VALUES 
 (1,'Musicónnnn','2021-02-25 17:42:33',3,1),
 (2,'Aquí tenéis una sesionaka','2021-02-25 17:00:00',1,1),
 (3,'Que recuerdosss!!!','2021-02-25 17:45:33',3,2),
 (4,'Pelos de Punta','2021-02-25 17:48:33',1,2);
/*!40000 ALTER TABLE `videoscomentario` ENABLE KEYS */;


--
-- Definition of table `videosvaloraciones`
--

DROP TABLE IF EXISTS `videosvaloraciones`;
CREATE TABLE `videosvaloraciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  `tipovaloracion_id` int(11) DEFAULT NULL,
  `fecha_valoracion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `video_id` (`video_id`),
  KEY `tipovaloracion_id` (`tipovaloracion_id`),
  CONSTRAINT `videosvaloraciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `videosvaloraciones_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`),
  CONSTRAINT `videosvaloraciones_ibfk_3` FOREIGN KEY (`tipovaloracion_id`) REFERENCES `tiposvaloracion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `videosvaloraciones`
--

/*!40000 ALTER TABLE `videosvaloraciones` DISABLE KEYS */;
INSERT INTO `videosvaloraciones` (`id`,`usuario_id`,`video_id`,`tipovaloracion_id`,`fecha_valoracion`) VALUES 
 (1,1,1,1,'2021-02-25 18:42:33'),
 (2,1,2,1,'2021-02-25 18:43:33'),
 (3,2,1,1,'2021-02-25 18:41:00'),
 (4,2,2,2,'2021-02-25 18:42:00'),
 (5,3,1,1,'2021-02-25 18:44:51'),
 (6,3,2,2,'2021-02-25 18:48:32');
/*!40000 ALTER TABLE `videosvaloraciones` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

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
-- Create schema optica
--

CREATE DATABASE IF NOT EXISTS optica;
USE optica;

--
-- Definition of table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `dir_calle` varchar(45) NOT NULL,
  `dir_numero` varchar(5) NOT NULL,
  `dir_piso` varchar(5) DEFAULT NULL,
  `dir_puerta` varchar(5) DEFAULT NULL,
  `dir_codposta` varchar(6) NOT NULL,
  `dir_ciudad` varchar(45) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `email` varchar(45) NOT NULL,
  `pais_id` int(10) unsigned NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT '1980-01-01 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_clientes_paises` (`pais_id`),
  CONSTRAINT `FK_clientes_paises` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='Maestros Clientes';

--
-- Dumping data for table `clientes`
--

/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`,`nombre`,`dir_calle`,`dir_numero`,`dir_piso`,`dir_puerta`,`dir_codposta`,`dir_ciudad`,`telefono`,`email`,`pais_id`,`fecha_alta`) VALUES 
 (1,'alberto','navarra','27','1','2','08107','Martorlles','666111222','ortegasanz@gmail.com',1,'2021-02-18 15:45:23'),
 (10,'antonio','paris','23','2','4','08100','Mollet del Vallés','666222111','a@a.com',1,'2021-02-18 15:45:23');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;


--
-- Definition of table `clientesreferencia`
--

DROP TABLE IF EXISTS `clientesreferencia`;
CREATE TABLE `clientesreferencia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cli_id` int(10) unsigned NOT NULL,
  `cli_idRefe` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_clientesreferencia_clientes` (`cli_id`),
  KEY `FK_clientesreferencia_clientesrefe` (`cli_idRefe`),
  CONSTRAINT `FK_clientesreferencia_clientes` FOREIGN KEY (`cli_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_clientesreferencia_clientesrefe` FOREIGN KEY (`cli_idRefe`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='Clientes Referenciados';

--
-- Dumping data for table `clientesreferencia`
--

/*!40000 ALTER TABLE `clientesreferencia` DISABLE KEYS */;
INSERT INTO `clientesreferencia` (`id`,`cli_id`,`cli_idRefe`) VALUES 
 (1,10,1);
/*!40000 ALTER TABLE `clientesreferencia` ENABLE KEYS */;


--
-- Definition of table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='Maestros Empleados';

--
-- Dumping data for table `empleados`
--

/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` (`id`,`nombre`) VALUES 
 (1,'ALBERTO'),
 (2,'ANTONIO'),
 (3,'MARIA');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;


--
-- Definition of table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
CREATE TABLE `marcas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Marcas';

--
-- Dumping data for table `marcas`
--

/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` (`id`,`nombre`) VALUES 
 (1,'VERSACCE'),
 (2,'DOLCEGABANNA'),
 (3,'MULTIOPTICAS');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;


--
-- Definition of table `paises`
--

DROP TABLE IF EXISTS `paises`;
CREATE TABLE `paises` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='Maestros Países';

--
-- Dumping data for table `paises`
--

/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` (`id`,`nombre`) VALUES 
 (1,'ESPAÑA'),
 (2,'PORTUGAL');
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;


--
-- Definition of table `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `marca_id` int(10) unsigned NOT NULL,
  `tipomontura_id` int(10) unsigned NOT NULL,
  `colormonutra` varchar(20) NOT NULL COMMENT 'Nombre del Color',
  `proveedor_id` int(10) unsigned NOT NULL,
  `gradua_izq` double NOT NULL,
  `gradua_der` double NOT NULL,
  `color_izq` varchar(20) NOT NULL COMMENT 'Almacenamos Codigo #00ff00',
  `color_der` varchar(20) NOT NULL COMMENT 'Almacenamos Codigo #00ff00',
  `importe` decimal(10,2) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_productos_marcas` (`marca_id`),
  KEY `FK_productos_tiposmontura` (`tipomontura_id`),
  KEY `FK_productos_proveedores` (`proveedor_id`),
  CONSTRAINT `FK_productos_marcas` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_productos_proveedores` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_productos_tiposmontura` FOREIGN KEY (`tipomontura_id`) REFERENCES `tiposmontura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='Maestros Productos';

--
-- Dumping data for table `productos`
--

/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`id`,`marca_id`,`tipomontura_id`,`colormonutra`,`proveedor_id`,`gradua_izq`,`gradua_der`,`color_izq`,`color_der`,`importe`,`nombre`) VALUES 
 (1,1,1,'ROJO',1,0.2,0.3,'TRANSPARENTE','TRANSPARENTE','100.00','Gafas Rojas 0.2-0.3 Cristal Transparente'),
 (2,1,2,'NEGRO',1,0.4,0.5,'OPACO 75%','OPACO 75%','123.00','Gafas Negras 0.4-0.5 Cristal Opacidad 75%'),
 (3,2,1,'ROJO',2,0.2,0.3,'TRANSPARENTE','TRANSPARENTE','110.00','Gafas Rojas 0.2-0.3 Cristal Transparente'),
 (4,2,2,'NEGRO',2,0.4,0.5,'OPACO 75%','OPACO 75%','133.00','Gafas Negras 0.4-0.5 Cristal Opacidad 75%');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;


--
-- Definition of table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE `proveedores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `dir_calle` varchar(45) NOT NULL,
  `dir_numero` varchar(5) NOT NULL,
  `dir_piso` varchar(5) DEFAULT NULL,
  `dir_puerta` varchar(5) DEFAULT NULL,
  `dir_codposta` varchar(6) NOT NULL,
  `dir_ciudad` varchar(45) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `fax` varchar(15) NOT NULL,
  `nif` varchar(10) NOT NULL,
  `pais_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_proveedores_paises` (`pais_id`),
  CONSTRAINT `FK_proveedores_paises` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Proveedores';

--
-- Dumping data for table `proveedores`
--

/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` (`id`,`nombre`,`dir_calle`,`dir_numero`,`dir_piso`,`dir_puerta`,`dir_codposta`,`dir_ciudad`,`telefono`,`fax`,`nif`,`pais_id`) VALUES 
 (1,'GAFAS S.L.','Circunvalación','123','','','08080','Barcelona','931112233','931112244','B12345678',1),
 (2,'SOLOGAFAS S.A.','Avda. Terrestre','422','','','21000','Madrid','912223344','912223355','A87654321',1),
 (3,'GAFIOES','Terra Ferreira','13','','','41111','Oporto','111111222','111111223','45555444G',2);
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;


--
-- Definition of table `tiposmontura`
--

DROP TABLE IF EXISTS `tiposmontura`;
CREATE TABLE `tiposmontura` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Tipos Montura';

--
-- Dumping data for table `tiposmontura`
--

/*!40000 ALTER TABLE `tiposmontura` DISABLE KEYS */;
INSERT INTO `tiposmontura` (`id`,`nomb`) VALUES 
 (1,'FLOTANTE'),
 (2,'PASTA'),
 (3,'METÁLICA');
/*!40000 ALTER TABLE `tiposmontura` ENABLE KEYS */;


--
-- Definition of table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_venta` datetime NOT NULL,
  `cliente_id` int(10) unsigned NOT NULL,
  `empleado_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ventas_clientes` (`cliente_id`),
  KEY `FK_ventas_empleados` (`empleado_id`),
  CONSTRAINT `FK_ventas_clientes` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `FK_ventas_empleados` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='Producción Ventas';

--
-- Dumping data for table `ventas`
--

/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` (`id`,`fecha_venta`,`cliente_id`,`empleado_id`) VALUES 
 (1,'2021-02-18 17:25:13',1,1),
 (3,'2021-02-18 17:05:12',10,1);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;


--
-- Definition of table `ventasdetalle`
--

DROP TABLE IF EXISTS `ventasdetalle`;
CREATE TABLE `ventasdetalle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ventas_id` int(10) unsigned NOT NULL,
  `producto_id` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='Producción Detalle Ventas';

--
-- Dumping data for table `ventasdetalle`
--

/*!40000 ALTER TABLE `ventasdetalle` DISABLE KEYS */;
INSERT INTO `ventasdetalle` (`id`,`ventas_id`,`producto_id`,`cantidad`) VALUES 
 (1,1,1,1),
 (2,1,2,1),
 (3,3,3,2);
/*!40000 ALTER TABLE `ventasdetalle` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

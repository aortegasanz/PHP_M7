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
-- Create schema pizzeria
--

CREATE DATABASE IF NOT EXISTS pizzeria;
USE pizzeria;

--
-- Definition of table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Categorias Productos';

--
-- Dumping data for table `categorias`
--

/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;


--
-- Definition of table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `poblacion_id` int(11) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_clientes_poblaciones` (`poblacion_id`),
  CONSTRAINT `FK_clientes_poblaciones` FOREIGN KEY (`poblacion_id`) REFERENCES `poblaciones` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Clientes';

--
-- Dumping data for table `clientes`
--

/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;


--
-- Definition of table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `nif` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `tipoempleado_id` int(11) NOT NULL,
  `tienda_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_empleados_tiposempleado` (`tipoempleado_id`),
  KEY `FK_empleados_tiendas` (`tienda_id`),
  CONSTRAINT `FK_empleados_tiendas` FOREIGN KEY (`tienda_id`) REFERENCES `tiendas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_empleados_tiposempleado` FOREIGN KEY (`tipoempleado_id`) REFERENCES `tiposempleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Empleados';

--
-- Dumping data for table `empleados`
--

/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;


--
-- Definition of table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `feche_operacion` datetime NOT NULL,
  `tipopedido_id` int(11) NOT NULL,
  `empleado_id` int(11) DEFAULT NULL,
  `fecha_entrega` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pedidos_clientes` (`cliente_id`),
  KEY `FK_pedidos_tipospedido` (`tipopedido_id`),
  KEY `FK_pedidos_empleados` (`empleado_id`),
  CONSTRAINT `FK_pedidos_clientes` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_pedidos_empleados` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_pedidos_tipospedido` FOREIGN KEY (`tipopedido_id`) REFERENCES `tipospedido` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Producción Pedidos';

--
-- Dumping data for table `pedidos`
--

/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;


--
-- Definition of table `pedidosdetalle`
--

DROP TABLE IF EXISTS `pedidosdetalle`;
CREATE TABLE `pedidosdetalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pedidosdetalle_productos` (`producto_id`),
  KEY `FK_pedidosdetalle_pedidos` (`pedido_id`),
  CONSTRAINT `FK_pedidosdetalle_pedidos` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_pedidosdetalle_productos` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Producción Detalle Pedidos';

--
-- Dumping data for table `pedidosdetalle`
--

/*!40000 ALTER TABLE `pedidosdetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidosdetalle` ENABLE KEYS */;


--
-- Definition of table `poblaciones`
--

DROP TABLE IF EXISTS `poblaciones`;
CREATE TABLE `poblaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codposta` varchar(10) NOT NULL,
  `cpnu` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `provincia_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_poblaciones_provincias` (`provincia_id`),
  CONSTRAINT `FK_poblaciones_provincias` FOREIGN KEY (`provincia_id`) REFERENCES `provincias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Poblaciones';

--
-- Dumping data for table `poblaciones`
--

/*!40000 ALTER TABLE `poblaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `poblaciones` ENABLE KEYS */;


--
-- Definition of table `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `imagen` blob DEFAULT NULL,
  `importe` double NOT NULL,
  `categoria_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_productos_categorias` (`categoria_id`),
  CONSTRAINT `FK_productos_categorias` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Productos';

--
-- Dumping data for table `productos`
--

/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;


--
-- Definition of table `provincias`
--

DROP TABLE IF EXISTS `provincias`;
CREATE TABLE `provincias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Províncias';

--
-- Dumping data for table `provincias`
--

/*!40000 ALTER TABLE `provincias` DISABLE KEYS */;
/*!40000 ALTER TABLE `provincias` ENABLE KEYS */;


--
-- Definition of table `tiendas`
--

DROP TABLE IF EXISTS `tiendas`;
CREATE TABLE `tiendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `direccion` varchar(255) NOT NULL,
  `poblacion_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tiendas_poblaciones` (`poblacion_id`),
  CONSTRAINT `FK_tiendas_poblaciones` FOREIGN KEY (`poblacion_id`) REFERENCES `poblaciones` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Tiendas';

--
-- Dumping data for table `tiendas`
--

/*!40000 ALTER TABLE `tiendas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiendas` ENABLE KEYS */;


--
-- Definition of table `tiposempleado`
--

DROP TABLE IF EXISTS `tiposempleado`;
CREATE TABLE `tiposempleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestro Tipos Empleado';

--
-- Dumping data for table `tiposempleado`
--

/*!40000 ALTER TABLE `tiposempleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiposempleado` ENABLE KEYS */;


--
-- Definition of table `tipospedido`
--

DROP TABLE IF EXISTS `tipospedido`;
CREATE TABLE `tipospedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maestros Tipos Pedido';

--
-- Dumping data for table `tipospedido`
--

/*!40000 ALTER TABLE `tipospedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipospedido` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

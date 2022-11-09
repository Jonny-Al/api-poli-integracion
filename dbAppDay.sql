/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 10.4.14-MariaDB : Database - appday
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`appday` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `appday`;

/*Table structure for table `areas` */

CREATE TABLE `areas` (
  `Ar_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Ar_Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Ar_Id`),
  UNIQUE KEY `Gr_Id_UNIQUE` (`Ar_Id`),
  UNIQUE KEY `Ar_Nombre_UNIQUE` (`Ar_Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `areas` */

insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (4,'Administración');
insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (7,'Comercial y ventas');
insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (1,'Gerencia');
insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (2,'Marketing y desarrollo');
insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (3,'Mercadeo y comunicaciones');
insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (6,'Seguridad ocupacional');
insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (8,'Sistemas');
insert  into `areas`(`Ar_Id`,`Ar_Nombre`) values (5,'Talento humano');

/*Table structure for table `blocdenotas` */

CREATE TABLE `blocdenotas` (
  `Bn_IdNotas` int(11) NOT NULL AUTO_INCREMENT,
  `Bn_NombreNota` varchar(100) DEFAULT NULL,
  `Bn_Nota` mediumtext DEFAULT NULL,
  `IdUsuarioCrea` int(11) NOT NULL,
  PRIMARY KEY (`Bn_IdNotas`),
  UNIQUE KEY `Bn_IdNotas_UNIQUE` (`Bn_IdNotas`),
  KEY `Fk_UsCreaNota_idx` (`IdUsuarioCrea`),
  CONSTRAINT `Fk_UsCreaNota` FOREIGN KEY (`IdUsuarioCrea`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `blocdenotas` */

/*Table structure for table `chats` */

CREATE TABLE `chats` (
  `Ch_IdChat` int(11) NOT NULL AUTO_INCREMENT,
  `Ch_FechaEnvio` date NOT NULL,
  `Ch_HoraMensaje` time DEFAULT NULL,
  `Ch_Mensaje` mediumtext NOT NULL,
  `IdUsuario` int(11) NOT NULL,
  PRIMARY KEY (`Ch_IdChat`),
  UNIQUE KEY `Ch_IdChat_UNIQUE` (`Ch_IdChat`),
  KEY `Fk_ChatUsuario_idx` (`IdUsuario`),
  CONSTRAINT `Fk_ChatUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `chats` */

/*Table structure for table `comentarios` */

CREATE TABLE `comentarios` (
  `Cm_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Cm_Comentarios` mediumtext DEFAULT NULL,
  `IdUsuario` int(11) NOT NULL,
  `IdTarea` int(11) NOT NULL,
  PRIMARY KEY (`Cm_Id`),
  UNIQUE KEY `Cm_Id_UNIQUE` (`Cm_Id`),
  KEY `Fk_ComentarioUsuario_idx` (`IdUsuario`),
  KEY `Fk_ComentarioTareas` (`IdTarea`),
  CONSTRAINT `Fk_ComentarioTareas` FOREIGN KEY (`IdTarea`) REFERENCES `tareas` (`Tr_Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `Fk_ComentarioUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `comentarios` */

/*Table structure for table `estados` */

CREATE TABLE `estados` (
  `Es_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Es_Estado` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Es_Id`),
  UNIQUE KEY `Es_Id_UNIQUE` (`Es_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `estados` */

insert  into `estados`(`Es_Id`,`Es_Estado`) values (1,'Activo');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (2,'Inactivo');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (3,'Importante');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (4,'Desaprobada');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (5,'En proceso');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (6,'Restaurada');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (7,'En espera');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (8,'Regular');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (9,'Mal');
insert  into `estados`(`Es_Id`,`Es_Estado`) values (10,'Perfecto');

/*Table structure for table `eventos` */

CREATE TABLE `eventos` (
  `Ev_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Ev_NombreEvento` varchar(100) DEFAULT NULL,
  `Ev_FechaInicio` date NOT NULL,
  `Ev_FechaFinal` date NOT NULL,
  `Ev_HoraInicio` time DEFAULT NULL,
  `Ev_HoraFinal` time DEFAULT NULL,
  `IdUsuario` int(11) NOT NULL,
  PRIMARY KEY (`Ev_Id`),
  UNIQUE KEY `Ev_Id_UNIQUE` (`Ev_Id`),
  KEY `Fk_UsuarioEvento_idx` (`IdUsuario`),
  CONSTRAINT `Fk_UsuarioEvento` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eventos` */

/*Table structure for table `eventos_objetos` */

CREATE TABLE `eventos_objetos` (
  `IdEvento` int(11) NOT NULL,
  `IdObjeto` int(11) NOT NULL,
  PRIMARY KEY (`IdEvento`,`IdObjeto`),
  UNIQUE KEY `IdObjeto_UNIQUE` (`IdObjeto`),
  KEY `fk_Eventos_has_Objetos_Objetos1_idx` (`IdObjeto`),
  KEY `fk_Eventos_has_Objetos_Eventos1_idx` (`IdEvento`),
  CONSTRAINT `Fk_Eventos` FOREIGN KEY (`IdEvento`) REFERENCES `eventos` (`Ev_Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `Fk_Objetos` FOREIGN KEY (`IdObjeto`) REFERENCES `objetos` (`Ob_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eventos_objetos` */

/*Table structure for table `historialtareas` */

CREATE TABLE `historialtareas` (
  `Hs_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Hs_Nombretarea` varchar(100) NOT NULL,
  `Hs_Anotacion` varchar(255) DEFAULT NULL,
  `Hs_FechaAprobacion` date DEFAULT NULL,
  `Hs_FechaAsignada` date DEFAULT NULL,
  `Hs_FechaInicio` date DEFAULT NULL,
  `Hs_FechaFin` date DEFAULT NULL,
  `Hs_Caracteristicas` mediumtext DEFAULT NULL,
  `IdUsDesarrollo` int(11) NOT NULL,
  `IdUsAsigna` int(11) NOT NULL,
  PRIMARY KEY (`Hs_Id`),
  UNIQUE KEY `Hs_Id_UNIQUE` (`Hs_Id`),
  KEY `Fk_HsEmpleado_idx` (`IdUsDesarrollo`),
  KEY `Fk_UsuarioAsigna_idx` (`IdUsAsigna`),
  CONSTRAINT `Fk_UsDesarrolla` FOREIGN KEY (`IdUsDesarrollo`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Fk_UsuarioAsigna` FOREIGN KEY (`IdUsAsigna`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `historialtareas` */

/*Table structure for table `modificacion` */

CREATE TABLE `modificacion` (
  `Md_IdModificacion` int(11) NOT NULL AUTO_INCREMENT,
  `Md_FechaModificacion` date NOT NULL,
  `Md_InfoModificacion` varchar(255) NOT NULL,
  `IdUsuarioModifica` int(11) NOT NULL,
  PRIMARY KEY (`Md_IdModificacion`),
  UNIQUE KEY `Md_IdModificacion` (`Md_IdModificacion`),
  KEY `Fk_UsuarioModifica` (`IdUsuarioModifica`),
  CONSTRAINT `Fk_UsuarioModifica` FOREIGN KEY (`IdUsuarioModifica`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `modificacion` */

/*Table structure for table `objetos` */

CREATE TABLE `objetos` (
  `Ob_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Ob_Nombre` varchar(45) NOT NULL,
  `Ob_Marca` varchar(100) DEFAULT NULL,
  `Ob_Serial` varchar(100) NOT NULL,
  `Ob_Caracteristicas` varchar(200) DEFAULT NULL,
  `IdEstado` int(11) NOT NULL,
  PRIMARY KEY (`Ob_Id`),
  UNIQUE KEY `Ob_Id_UNIQUE` (`Ob_Id`),
  UNIQUE KEY `Ob_Serial_UNIQUE` (`Ob_Serial`),
  KEY `Fk_ObjetoEstado_idx` (`IdEstado`),
  CONSTRAINT `Fk_ObjetoEstado` FOREIGN KEY (`IdEstado`) REFERENCES `estados` (`Es_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `objetos` */

insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (1,'Iphone 7','Apple','SDAD78DSA','12 Mpx, 32 Gb internas, 2 Gb ram',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (2,'Tablet','Lenovo','DAS78DS','12 Mpx, 16 Gb internas, 2 Gb ram',8);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (3,'Televisor','Samsung','SMU7JDJD7','Tv de 43 pulgadas y Smart TV',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (4,'Portatil','ASUS','DSA897D89','iNTEL CORE I5 DE OCTAVA',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (5,'Panel','samsung','DAS7dSA788DS','De energia para celulares',8);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (6,'Mesa','Touru','S54MUA7JDDJD7','De madera',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (7,'Sillas','Touru','DSAD76SA8D68','Sillas de madera para eventos',8);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (8,'Base  Monitor','Samsung','DS89FDSFDSR','Solo para monitores de 24 pulgadas',8);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (9,'Cargador ','Samsung','DASD87979','De cuatro cables puerto mini usb',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (10,'Mouse inalambrico','Genius','FDS87FD','Mouse genius con botones adiciones',8);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (11,'Camara IP','Dahua','678S6FD8S','Camara ip  de carca',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (12,'Modem de sim','tplink','DS7F8S7','Router pequeño para insertar sim card con datos para compartir internet ',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (13,'Vasos de cristal','corona','FDSFDS768','Caja de 15 vasos corona para reuniones importantes serial es de la caja',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (14,'Gafas realidad virtual','Samsung','DSADAS78','Gafas de realidad virtual, solo funcionan con celulares samsung S6, S7 y S8',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (15,'Gafas realidad virtual','Samsung','DSADAS79','Gafas de realidad virtual, solo funcionan con celulares samsung S6, S7 y S8',8);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (16,'Celular S8','Samsung','SM89JKU7S','Celular samsung S8 de 32 Gb de memoria interna,4 en ram con camara de 8 mpx frontal y trasera de 16 mpx',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (17,'Equipo de sonido','Panasonic','PJDSA8NDS8','Equipo de sonido con 2 parlantes con 3000 wts ',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (18,'Parlante y microfono','Sony','SN87DS','Parlante con microfono va con cargador se entrega caja completa',7);
insert  into `objetos`(`Ob_Id`,`Ob_Nombre`,`Ob_Marca`,`Ob_Serial`,`Ob_Caracteristicas`,`IdEstado`) values (19,'Banco de carga','Adata','ADT768HJSDS','Banco de carga para recarga de cualquier aparato va con cable de entrada usb',7);

/*Table structure for table `reunion` */

CREATE TABLE `reunion` (
  `Ru_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Ru_Nombrereunion` varchar(100) DEFAULT NULL,
  `Ru_FechaInicio` date NOT NULL,
  `Ru_FechaFinal` date NOT NULL,
  `Ru_HoraInicio` time NOT NULL,
  `Ru_HoraFinal` time NOT NULL,
  `Ru_Comentarios` mediumtext DEFAULT NULL,
  `IdUsuario` int(11) NOT NULL,
  PRIMARY KEY (`Ru_Id`),
  UNIQUE KEY `Ru_Id_UNIQUE` (`Ru_Id`),
  UNIQUE KEY `Ru_Nombrereunion_UNIQUE` (`Ru_Nombrereunion`),
  KEY `Fk_UserCreaReunion_idx` (`IdUsuario`),
  CONSTRAINT `Fk_UserCreaReunion` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `reunion` */

/*Table structure for table `rol` */

CREATE TABLE `rol` (
  `Rol_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rol_Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Rol_Id`),
  UNIQUE KEY `Rol_Id_UNIQUE` (`Rol_Id`),
  UNIQUE KEY `Rol_Nombre_UNIQUE` (`Rol_Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `rol` */

insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (7,'Comercial');
insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (3,'Coordinador');
insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (6,'Desarrollador');
insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (2,'Director');
insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (5,'Diseñador');
insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (8,'Forestal');
insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (1,'Gerente');
insert  into `rol`(`Rol_Id`,`Rol_Nombre`) values (4,'Lider');

/*Table structure for table `tareacompartida` */

CREATE TABLE `tareacompartida` (
  `IdTareaComparte` int(11) NOT NULL,
  `IdUsuarioCompartido` int(11) NOT NULL,
  `IdUsuarioComparte` int(11) NOT NULL,
  KEY `Fk_UsuarioCompartido` (`IdUsuarioCompartido`),
  KEY `Fk_TareaCompartida` (`IdTareaComparte`),
  KEY `Fk_UsuarioComparte` (`IdUsuarioComparte`),
  CONSTRAINT `Fk_TareaCompartida` FOREIGN KEY (`IdTareaComparte`) REFERENCES `tareas` (`Tr_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_UsuarioComparte` FOREIGN KEY (`IdUsuarioComparte`) REFERENCES `usuarios` (`Us_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_UsuarioCompartido` FOREIGN KEY (`IdUsuarioCompartido`) REFERENCES `usuarios` (`Us_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tareacompartida` */

insert  into `tareacompartida`(`IdTareaComparte`,`IdUsuarioCompartido`,`IdUsuarioComparte`) values (1,7,3);
insert  into `tareacompartida`(`IdTareaComparte`,`IdUsuarioCompartido`,`IdUsuarioComparte`) values (1,8,3);
insert  into `tareacompartida`(`IdTareaComparte`,`IdUsuarioCompartido`,`IdUsuarioComparte`) values (2,3,4);
insert  into `tareacompartida`(`IdTareaComparte`,`IdUsuarioCompartido`,`IdUsuarioComparte`) values (3,3,4);

/*Table structure for table `tareas` */

CREATE TABLE `tareas` (
  `Tr_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Tr_Nombre` varchar(255) NOT NULL,
  `Tr_Anotacion` varchar(255) DEFAULT NULL,
  `Tr_Caracteristicas` mediumtext DEFAULT NULL,
  `Tr_FechaAsignada` date DEFAULT NULL,
  `Tr_FechaInicio` date DEFAULT NULL,
  `Tr_FechaFinal` date DEFAULT NULL,
  `IdEstado` int(11) DEFAULT 0,
  `IdUsDesarrolla` int(11) NOT NULL,
  `IdUsAsigna` int(11) NOT NULL,
  PRIMARY KEY (`Tr_Id`),
  UNIQUE KEY `Tr_Id_UNIQUE` (`Tr_Id`),
  KEY `Fk_TrEm_Desarrolla_idx` (`IdUsDesarrolla`),
  KEY `Fk_TareaEstado_idx` (`IdEstado`),
  KEY `Fk_TrUsCrea_idx` (`IdUsAsigna`),
  CONSTRAINT `Fk_TareaEstado` FOREIGN KEY (`IdEstado`) REFERENCES `estados` (`Es_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Fk_TrEm_Desarrolla` FOREIGN KEY (`IdUsDesarrolla`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Fk_TrUsCrea` FOREIGN KEY (`IdUsAsigna`) REFERENCES `usuarios` (`Us_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `tareas` */

insert  into `tareas`(`Tr_Id`,`Tr_Nombre`,`Tr_Anotacion`,`Tr_Caracteristicas`,`Tr_FechaAsignada`,`Tr_FechaInicio`,`Tr_FechaFinal`,`IdEstado`,`IdUsDesarrolla`,`IdUsAsigna`) values (1,'Holis','anotacionupdate','caractupdate','2020-11-05','2020-11-06','2020-11-30',3,3,1);
insert  into `tareas`(`Tr_Id`,`Tr_Nombre`,`Tr_Anotacion`,`Tr_Caracteristicas`,`Tr_FechaAsignada`,`Tr_FechaInicio`,`Tr_FechaFinal`,`IdEstado`,`IdUsDesarrolla`,`IdUsAsigna`) values (2,'TrImportante','ANotaciontradri','dsadsadsadsa','2020-11-07','2020-11-14','2020-11-21',3,4,4);
insert  into `tareas`(`Tr_Id`,`Tr_Nombre`,`Tr_Anotacion`,`Tr_Caracteristicas`,`Tr_FechaAsignada`,`Tr_FechaInicio`,`Tr_FechaFinal`,`IdEstado`,`IdUsDesarrolla`,`IdUsAsigna`) values (3,'TrDesaprobada','daaaas','dadasd','2020-11-07','2020-11-14','2020-12-03',4,4,4);
insert  into `tareas`(`Tr_Id`,`Tr_Nombre`,`Tr_Anotacion`,`Tr_Caracteristicas`,`Tr_FechaAsignada`,`Tr_FechaInicio`,`Tr_FechaFinal`,`IdEstado`,`IdUsDesarrolla`,`IdUsAsigna`) values (6,'TrProceso','dsadsa','sadasddsadas','2020-11-13','2020-11-22','2020-11-30',5,4,4);
insert  into `tareas`(`Tr_Id`,`Tr_Nombre`,`Tr_Anotacion`,`Tr_Caracteristicas`,`Tr_FechaAsignada`,`Tr_FechaInicio`,`Tr_FechaFinal`,`IdEstado`,`IdUsDesarrolla`,`IdUsAsigna`) values (7,'TrRestaurada','dsdasd','sadsaddsadas','2020-11-17','2020-11-30','2020-12-03',6,4,4);
insert  into `tareas`(`Tr_Id`,`Tr_Nombre`,`Tr_Anotacion`,`Tr_Caracteristicas`,`Tr_FechaAsignada`,`Tr_FechaInicio`,`Tr_FechaFinal`,`IdEstado`,`IdUsDesarrolla`,`IdUsAsigna`) values (8,'TrEnEspera','dsadad','sadasdsadsad','2020-11-24','2020-11-30','2020-12-05',7,4,4);

/*Table structure for table `usuarios` */

CREATE TABLE `usuarios` (
  `Us_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Us_Nombres` varchar(45) NOT NULL,
  `Us_Apellidos` varchar(45) NOT NULL,
  `Us_Telefono` varchar(45) DEFAULT NULL,
  `Us_Correo` varchar(45) NOT NULL,
  `Us_CorreoAlternativo` varchar(45) DEFAULT NULL,
  `Us_Clave` varchar(45) NOT NULL,
  `Us_FotoPerfil` varchar(255) DEFAULT 'fotodefecto.png',
  `IdEstado` int(11) NOT NULL DEFAULT 2,
  `IdArea` int(11) NOT NULL,
  `IdRol` int(11) NOT NULL,
  PRIMARY KEY (`Us_Id`),
  UNIQUE KEY `Us_Id_UNIQUE` (`Us_Id`),
  UNIQUE KEY `Us_Correo_UNIQUE` (`Us_Correo`),
  UNIQUE KEY `Us_CorreoAlternativo` (`Us_CorreoAlternativo`),
  KEY `Fk_IdGrupos_idx` (`IdArea`),
  KEY `Fk_RolEmp_idx` (`IdRol`),
  KEY `Fk_Estado_idx` (`IdEstado`),
  CONSTRAINT `Fk_AreaEmp` FOREIGN KEY (`IdArea`) REFERENCES `areas` (`Ar_Id`),
  CONSTRAINT `Fk_EstadoUser` FOREIGN KEY (`IdEstado`) REFERENCES `estados` (`Es_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Fk_RolEmp` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`Rol_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `usuarios` */

insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (1,'Jesus','Muñoz','3117770284','jesus@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,1,1);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (2,'Manolo','Perez','3116287814','manolo@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,5,4);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (3,'Jonny Alejandro','Garcia Sánchez','3059006868','jonnyal96@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,2,2);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (4,'Adriana Lorena','Cubides Ballen','3158048975','adrilore@outlook.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,2,3);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (5,'Juan Alejandro','Acevedo','3114587412','juan@yahoo.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,5,4);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (6,'Julian','Jimenez','3134187945','julian@hotmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,2,4);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (7,'Alexander','Parra','3112435245','alexander@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,5,2);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (8,'Jenny Katherine','Perez Sanchez','3177530820','jennykaperez@yahoo.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,5,3);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (9,'Pedro ','Guzman','3114785263','pedrog@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',1,5,4);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (10,'Harold','Garcia','3026458715','harold@yahoo.es',NULL,'/PMcH8Rc13A=','fotodefecto.png',2,2,1);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (11,'Camilo','Mendoza','3124587156','camilo@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',2,5,3);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (12,'Emilio','Quevedo','352874562','emilio@yahoo.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',2,5,4);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (13,'Marin','Jimenez','3134154129','marin@hotmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',2,6,4);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (14,'Alexandra','Guzman','3112557196','alexandra@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',2,3,2);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (15,' Katherine','Mendez','3125556973','katherine@yahoo.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',2,3,3);
insert  into `usuarios`(`Us_Id`,`Us_Nombres`,`Us_Apellidos`,`Us_Telefono`,`Us_Correo`,`Us_CorreoAlternativo`,`Us_Clave`,`Us_FotoPerfil`,`IdEstado`,`IdArea`,`IdRol`) values (16,'Carlos','Guevara','3125416952','carlos@gmail.com',NULL,'/PMcH8Rc13A=','fotodefecto.png',2,6,4);

/* Procedure structure for procedure `Area_Add` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Area_Add`(
_Area VARCHAR (45)
)
BEGIN
INSERT INTO areas (Ar_Nombre) VALUES (_Area);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Area_ComprobarAreaUsada` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Area_ComprobarAreaUsada`(
_IdArea INT (11)
)
BEGIN
SELECT IdArea FROM usuarios WHERE IdArea = _IdArea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Area_EliminaraArea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Area_EliminaraArea`(
IdArea INT (11)
)
BEGIN
DELETE FROM areas WHERE Ar_Id = IdArea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Area_ListarAreas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Area_ListarAreas`()
BEGIN
SELECT * FROM view_Ar_ListarAreas;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Area_Update` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Area_Update`(
_IdArea INT(11),
_ArNombre VARCHAR (45)
)
BEGIN
UPDATE areas SET Ar_Nombre = _ArNombre
WHERE Ar_Id = _IdArea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Area_ValidarArea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Area_ValidarArea`(
_Area VARCHAR (45)
)
BEGIN
SELECT * FROM view_Ar_ListarAreas WHERE Ar_Nombre = _Area;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ar_ValidarAreaExiste` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ar_ValidarAreaExiste`(
_area INT
)
BEGIN
select * from areas where Ar_Id = _area;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Bn_ActualizarNota` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Bn_ActualizarNota`(
_IdNota INT (11),
_NombreNota VARCHAR (100),
_Textonota MEDIUMTEXT
)
BEGIN
UPDATE blocdenotas SET Bn_NombreNota = _NombreNota, Bn_Nota = _Textonota
WHERE Bn_IdNotas = _IdNota;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Bn_CrearNota` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Bn_CrearNota`(
_IdUsuario INT (11),
_Nombrenota VARCHAR (100),
_Textonota MEDIUMTEXT
)
BEGIN
INSERT INTO blocdenotas (IdUsuarioCrea,Bn_NombreNota, Bn_Nota)
VALUES (_IdUsuario, _Nombrenota, _Textonota );
END */$$
DELIMITER ;

/* Procedure structure for procedure `Bn_EliminarNota` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Bn_EliminarNota`(
_IdNota INT (11)
)
BEGIN
DELETE FROM blocdenotas WHERE Bn_IdNotas = _IdNota;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Bn_ListNotas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Bn_ListNotas`(
_IdUsuario INT (11)
)
BEGIN
SELECT * FROM view_ListNotas WHERE IdUsuarioCrea = _IdUsuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Bn_ValidaNotaUsuario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Bn_ValidaNotaUsuario`(
_IdNota INT (11),
_IdUsuario INT (11)
)
BEGIN
SELECT Bn_IdNotas, IdUsuarioCrea FROM blocdenotas WHERE Bn_IdNotas = _IdNota AND IdUsuarioCrea = _IdUsuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Bn_VerTextoNota` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Bn_VerTextoNota`(
_IdNota int
)
begin
select * from blocdenotas where Bn_IdNotas = _IdNota;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Ch_ListChats` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ch_ListChats`()
BEGIN
SELECT * FROM view_Ch_ListChats;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ch_Mensajeria` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ch_Mensajeria`(
_FechaEnvio DATETIME,
_HoraMensaje TIME,
_Mensaje MEDIUMTEXT,
_IdUsuario INT (11)
)
BEGIN
INSERT INTO chats (Ch_FechaEnvio, Ch_HoraMensaje , Ch_Mensaje,IdUsuario)
VALUES (_FechaEnvio, _HoraMensaje , _Mensaje, _IdUsuario);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Cm_ActualizarComentario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Cm_ActualizarComentario`(
_IdComentario INT (11),
_Comentario MEDIUMTEXT
)
BEGIN
UPDATE comentarios SET Cm_Comentarios = _Comentario
WHERE Cm_Id = _IdComentario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Cm_ComprobarComentario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Cm_ComprobarComentario`(
_IdComentario int(11),
_IdUsuario int (11)
)
begin
select Cm_Id, IdUsuario from comentarios where Cm_Id = _IdComentario and IdUsuario = _IdUsuario;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Es_ListEstadosObjetos` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Es_ListEstadosObjetos`()
BEGIN
SELECT * FROM view_Es_ListEstadosObjetos;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ev_CrearEvento` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ev_CrearEvento`(
_EvNombreEvento VARCHAR (100), 
_EvFechaInicio DATE, 
_EvFechaFinal DATE, 
_EvHoraInicio TIME, 
_EvHoraFinal TIME, 
_IdUsuario INT(11)
)
BEGIN
INSERT INTO Eventos( Ev_NombreEvento , Ev_FechaInicio, Ev_FechaFinal, Ev_HoraInicio, Ev_HoraFinal, IdUsuario)
VALUES (_EvNombreEvento, _EvFechaInicio, _EvFechaFinal, _EvHoraInicio, _EvHoraFinal, _IdUsuario);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ev_Delete` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ev_Delete`(
_IdEvento INT(11)
)
BEGIN
DELETE FROM eventos WHERE Ev_Id = _IdEvento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ev_ListEventosUsuario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ev_ListEventosUsuario`(
_IdUsuario INT (11)
)
BEGIN
SELECT * FROM view_EventosUsuario WHERE IdUsuario = _IdUsuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ev_Update` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ev_Update`(
_IdEvento INT(11),
_EvNombreEvento VARCHAR (100),
_EvFechaInicio DATE, 
_EvFechaFinal DATE, 
_EvHoraInicio TIME, 
_EvHoraFinal TIME
)
BEGIN
UPDATE eventos SET Ev_NombreEvento = _EvNombreEvento, Ev_FechaInicio = _EvFechaInicio, Ev_FechaFinal = _EvFechaFinal,
Ev_HoraInicio = _EvHoraInicio, Ev_HoraFinal = _EvHoraFinal
WHERE Ev_Id = _IdEvento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ev_ValidarEvento` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ev_ValidarEvento`(
_IdEvento INT(11),
_IdUusario INT (11)
)
BEGIN
SELECT Ev_Id, IdUsuario FROM Eventos WHERE Ev_Id = _IdEvento AND IdUsuario =  _IdUusario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Hs_EliminarTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Hs_EliminarTarea`(
_IdTarea INT (11)
)
BEGIN 
DELETE FROM historialtareas
WHERE Hs_Id = _IdTarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Hs_ListTareasUsuario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Hs_ListTareasUsuario`(
_IdUsuarioDesarrolla INT (11),
_IdUsuarioAsigna INT (11)
)
BEGIN
SELECT * FROM view_Hs_ListTareas WHERE IdUsDesarrollo = _IdUsuarioDesarrolla AND IdUsAsigna = _IdUsuarioAsigna;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Hs_RestaurarTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Hs_RestaurarTarea`(
_IdTarea INT (11),
_FechaRestaurada DATE
)
BEGIN
INSERT INTO tareas (Tr_Nombre, Tr_Caracteristicas, Tr_Anotacion,  Tr_FechaAsignada, Tr_FechaInicio, Tr_FechaFinal, IdEstado ,IdUsDesarrolla, IdUsAsigna)
SELECT historialtareas.`Hs_Nombretarea`, historialtareas.`Hs_Caracteristicas`, historialtareas.`Hs_Anotacion`, _FechaRestaurada,
Hs_FechaInicio , Hs_FechaFin , 6,historialtareas.`IdUsDesarrollo`, historialtareas.IdUsAsigna
FROM historialtareas WHERE Hs_Id = _IdTarea;
DELETE FROM historialtareas WHERE Hs_Id = _IdTarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Hs_ValidarTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Hs_ValidarTarea`(
_Idtarea int,
_IdUsuarioasigna int
)
begin
select Hs_Id, IdUsAsigna from historialtareas where Hs_Id = _Idtarea and IdUsAsigna = _IdUsuarioasigna;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Hs_VerTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Hs_VerTarea`(
_IdTarea INT (11)
)
BEGIN
SELECT * FROM view_Hs_VerTarea WHERE Hs_Id = _IdTarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Md_AddModificacion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Md_AddModificacion`(
Usuario INT ,
Fecha DATE ,
InfoModificacion VARCHAR(255)
)
BEGIN 
INSERT INTO modificacion(Md_FechaModificacion,Md_InfoModificacion,IdUsuarioModifica)
VALUES 
(Fecha,InfoModificacion,Usuario);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Md_ListModificaciones` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Md_ListModificaciones`(
usuario int
)
BEGIN
SELECT * FROM view_md_modificaciones where IdUsuarioModifica = usuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_ActualizarObjeto` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_ActualizarObjeto`(
_IdObjeto INT(11),
_ObNombre VARCHAR (45),
_ObMarca VARCHAR(100),
_ObSerial VARCHAR (100),
_ObCaracteristicas VARCHAR (200),
_ObEstado INT (11)	
)
BEGIN
UPDATE objetos SET Ob_Nombre = _ObNombre, Ob_Marca = _ObMarca, Ob_Serial = _ObSerial, Ob_Caracteristicas = _ObCaracteristicas, IdEstado = _ObEstado
WHERE Ob_Id = _IdObjeto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_AddObjeto` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_AddObjeto`(
_ObNombre VARCHAR (45),
_ObMarca VARCHAR(100),
_ObSerial VARCHAR (100),
_ObCaracteristicas VARCHAR (200),
_ObEstado INT (11)
)
BEGIN
INSERT INTO objetos (Ob_Nombre, Ob_Marca, Ob_Serial, Ob_Caracteristicas, IdEstado)
VALUES
(_ObNombre, _ObMarca ,_ObSerial, _ObCaracteristicas, _ObEstado);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_AddObjetoEnEvento` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_AddObjetoEnEvento`(
_IdEvento INT (11),
_IdObjeto INT (11)
)
BEGIN
INSERT INTO eventos_objetos (IdEvento,IdObjeto)
VALUES (_IdEvento,_IdObjeto);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_Comprobarestado` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_Comprobarestado`(
_Estado varchar (100)
)
begin
select Es_Id , Es_Estado from estados where Es_Estado = _Estado;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_Disponibilidad` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_Disponibilidad`(
_IdObjeto INT(11)
)
BEGIN
SELECT * FROM view_Ob_ConsultarDisponibilidad WHERE IdObjeto = _IdObjeto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_EliminarObjeto` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_EliminarObjeto`(
_IdObjeto INT(11)
)
BEGIN
DELETE FROM objetos WHERE Ob_Id = _IdObjeto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_ListDisponibles` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_ListDisponibles`()
BEGIN
SELECT * FROM view_Ob_Disponibles;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_ListObjetosEvento` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_ListObjetosEvento`(
_IdUsuario INT (11)
)
BEGIN
SELECT * FROM view_Ob_ObjetosEvento WHERE IdUsuario = _IdUsuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_ListObjetosReportes` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_ListObjetosReportes`()
BEGIN
SELECT * FROM view_Ob_ListTodosObjetosReporte;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_ListTodosObjetos` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_ListTodosObjetos`()
begin
select * from view_Ob_ListTodosObjetos;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_Quitar` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_Quitar`(
_IdObjeto INT (11)
)
BEGIN
DELETE FROM Eventos_Objetos WHERE IdObjeto = _IdObjeto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_TraspasoEvento` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_TraspasoEvento`(
_IdObjeto INT (11),
_IdEvento INT (11)
)
BEGIN
UPDATE Eventos_Objetos SET IdEvento = _IdEvento
WHERE IdObjeto = _IdObjeto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_ValidaObjUser` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_ValidaObjUser`(
_IdObjeto INT (11)
)
BEGIN
SELECT * FROM  Eventos_Objetos WHERE IdObjeto = _IdObjeto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_ValidarSerial` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_ValidarSerial`(
_ObSerial VARCHAR (100)
)
BEGIN
SELECT Ob_Id ,Ob_Serial FROM objetos WHERE Ob_Serial = _ObSerial;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_VerInformacion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_VerInformacion`(
_IdObjeto int
)
begin
select Ob_Nombre, Ob_Marca, Ob_Serial, Ob_Caracteristicas, IdEstado from objetos 
where Ob_Id = _IdObjeto;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Ob_VerObjetosDeEvento` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ob_VerObjetosDeEvento`(
_IdEvento int
)
begin
select * from view_Ob_ObjetosDeEvento where IdEvento = _IdEvento;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Rol_Add` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Add`(
_Rol VARCHAR (45)
)
BEGIN
INSERT INTO rol (Rol_Nombre) VALUES (_Rol);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Rol_ComprobarRolUsado` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_ComprobarRolUsado`(
_IdRol int (11)
)
begin
select IdRol from usuarios where IdRol = _IdRol;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Rol_EliminarRol` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_EliminarRol`(
IdRol int (11)
)
begin
delete from rol where Rol_Id = IdRol;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Rol_ListarRoles` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_ListarRoles`()
BEGIN
SELECT * FROM view_Rol_ListarRoles;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Rol_Update` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Update`(
_IdRol INT(11),
_RolNombre VARCHAR (45)
)
BEGIN
UPDATE rol SET Rol_Nombre = _RolNombre
WHERE Rol_Id = _IdRol;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Rol_ValidarRol` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_ValidarRol`(
_Rol VARCHAR (45)
)
BEGIN 
SELECT * FROM view_Rol_ListarRoles WHERE Rol_Nombre = _Rol;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Rol_ValidarRolExiste` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_ValidarRolExiste`(
_rol INT
)
BEGIN
SELECT * FROM rol WHERE Rol_Id = _rol;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ru_CrearReunion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ru_CrearReunion`(
_NombreReunion VARCHAR (100),
_FechaInicio DATE,
_FechaFin DATE,
_HoraInicio TIME,
_HoraFin TIME,
_Comentarios MEDIUMTEXT,
_IdUsuario INT (11)
)
BEGIN
INSERT INTO reunion (Ru_NombreReunion, Ru_FechaInicio, Ru_FechaFinal, Ru_HoraInicio, Ru_HoraFinal, Ru_Comentarios,IdUsuario)
VALUES (_NombreReunion, _FechaInicio , _FechaFin , _HoraInicio, _HoraFin, _Comentarios,_IdUsuario);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ru_EliminarReunion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ru_EliminarReunion`(
_IdReunion INT (11)
)
BEGIN
DELETE FROM reunion WHERE Ru_Id = _IdReunion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ru_ListarReunionesUsuario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ru_ListarReunionesUsuario`(
_IdUsuario INT (11)
)
BEGIN
SELECT * FROM view_Ru_ListAsignaciones WHERE IdUsuario = _IdUsuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ru_ListAsignaciones` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ru_ListAsignaciones`()
BEGIN
SELECT * FROM view_Ru_ListAsignaciones;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ru_UpdateReunion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ru_UpdateReunion`(
_IdReunion INT (11),
_RuNombre VARCHAR (45),
_RuFechaInicio DATE,
_RuFechaFinal DATE,
_RuHoraInicio TIME,
_RuHoraFin TIME,
_Comentarios MEDIUMTEXT
)
BEGIN																				
UPDATE reunion SET Ru_NombreReunion = _RuNombre, Ru_FechaInicio = _RuFechaInicio, Ru_FechaFinal = _RuFechaFinal, 
Ru_HoraInicio = _RuHoraInicio, Ru_HoraFinal = _RuHoraFin, Ru_Comentarios = _Comentarios
WHERE Ru_Id = _IdReunion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ru_ValidaReunionUser` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Ru_ValidaReunionUser`(
_IdUsuario INT (11),
_IdReunion INT (11)
)
BEGIN
SELECT Ru_Id, IdUsuario FROM reunion WHERE IdUsuario = _IdUsuario AND  Ru_Id = _IdReunion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tc_CompartirTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tc_CompartirTarea`(
_UsuarioCompartir int (11),
_UsuarioComparte int(11),
_IdTarea int (11)
)
begin
insert into tareacompartida (IdTareaComparte,IdUsuarioCompartido,IdUsuarioComparte) 
values (_IdTarea,_UsuarioCompartir,_UsuarioComparte);
end */$$
DELIMITER ;

/* Procedure structure for procedure `Tc_DejarDeCompartirTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tc_DejarDeCompartirTarea`(
_Usuario int (11),
_Tarea int (11)
)
begin
delete from tareacompartida where IdTareaComparte = _Tarea and IdUsuarioCompartido = _Usuario;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Tc_ListarTareasCompartidas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tc_ListarTareasCompartidas`(
_Usuario int(11)
)
begin
SELECT * from view_Tc_ListTareasCompartidas where IdUsuarioCompartido = _Usuario;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Tc_ListUsuariosComparte` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tc_ListUsuariosComparte`(
_IdTarea INT (11)
)
BEGIN
SELECT * FROM view_Tc_Usuarioscompartetarea WHERE Tr_Id = _IdTarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tc_UsuarioCompartido` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tc_UsuarioCompartido`(
_Usuario int (11),
_Tarea int (11)
)
begin
select * from tareacompartida where IdUsuarioCompartido = _Usuario and IdTareaComparte = _Tarea;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_AddTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_AddTarea`(
_TrNombre VARCHAR (255),
_TrAnotacion VARCHAR (255),
_TrCaracteristicas MEDIUMTEXT,
_ComentariosDirector MEDIUMTEXT,
_TrFechaAsignada DATE,
_TrFechainicio DATE,
_TrFechafinal DATE,
_IdUsdesarrolla INT(11),
_IdUsAsigna INT (11)
)
BEGIN
INSERT INTO tareas (Tr_Nombre, Tr_Anotacion ,Tr_Caracteristicas, Tr_FechaAsignada, Tr_FechaInicio, Tr_FechaFinal, IdEstado , IdUsDesarrolla, IdUsAsigna) 
VALUES (_TrNombre, _TrAnotacion,_TrCaracteristicas , _TrFechaAsignada, _TrFechainicio, _TrFechafinal, 3,_IdUsdesarrolla, _IdUsAsigna );
INSERT INTO comentarios (Cm_Comentarios, IdUsuario, IdTarea)
VALUES (_ComentariosDirector, _IdUsAsigna, LAST_INSERT_ID()); 
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_AddTareapersonal` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_AddTareapersonal`(
_TrNombre VARCHAR (255),
_Tr_Anotacion VARCHAR (255),
_TrCaracteristicas MEDIUMTEXT,
_TrFechaAsignada DATE,
_TrFechainicio DATE,
_TrFechafinal DATE,
_IdUsdesarrolla INT(11),
_IdUsAsigna INT (11)
)
BEGIN
INSERT INTO tareas (Tr_Nombre, Tr_Anotacion, Tr_Caracteristicas ,Tr_FechaAsignada, Tr_FechaInicio,Tr_FechaFinal, IdEstado ,IdUsDesarrolla, IdUsAsigna) 
VALUES (_TrNombre, _Tr_Anotacion, _TrCaracteristicas ,_TrFechaAsignada, _TrFechainicio, _TrFechafinal, 7,_IdUsdesarrolla, _IdUsAsigna );
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_AgregarComentario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_AgregarComentario`(
_Comentarios MEDIUMTEXT,
_IdUsuario INT(11),
_IdTarea INT (11)
)
BEGIN
INSERT INTO comentarios (Cm_Comentarios, IdUsuario, IdTarea)
VALUES (_Comentarios, _IdUsuario, _IdTarea);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_Aprobacion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_Aprobacion`(
_IdTarea INT(11),
_FechaAprobacion DATE
)
BEGIN
DELETE FROM comentarios WHERE IdTarea = _IdTarea;
INSERT INTO historialtareas ( Hs_Nombretarea, Hs_Anotacion ,Hs_FechaAsignada, Hs_FechaInicio, Hs_FechaFin, Hs_FechaAprobacion, Hs_Caracteristicas, IdUsDesarrollo, IdUsAsigna)
SELECT  tareas.`Tr_Nombre`, tareas.Tr_Anotacion ,tareas.`Tr_FechaAsignada`, tareas.`Tr_FechaInicio`, tareas.`Tr_FechaFinal`, _FechaAprobacion , tareas.`Tr_Caracteristicas`,
tareas.`IdUsDesarrolla`, tareas.IdUsAsigna
FROM tareas WHERE Tr_Id = _IdTarea;
DELETE FROM tareas WHERE Tr_Id = _IdTarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_Archivar` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_Archivar`(
_IdTarea int (11),
_IdUsuario int (11)
)
begin
DELETE FROM comentarios WHERE IdTarea = _IdTarea;
insert into historialtareas (Hs_Nombretarea, Hs_Anotacion, Hs_FechaInicio, Hs_FechaFin ,Hs_Caracteristicas, IdUsDesarrollo, IdUsAsigna)
select tareas.Tr_Nombre, tareas.Tr_Anotacion, tareas.Tr_FechaInicio, tareas.Tr_FechaFinal, tareas.Tr_Caracteristicas, tareas.IdUsDesarrolla, tareas.IdUsAsigna
from tareas where Tr_Id = _IdTarea;
DELETE FROM tareas WHERE Tr_Id = _IdTarea;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_Eliminar` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_Eliminar`(
_TrId INT
)
BEGIN
DELETE FROM comentarios WHERE IdTarea = _TrId;
DELETE FROM tareas WHERE Tr_Id = _TrId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_InfoTareacompartida` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_InfoTareacompartida`(
tarea int (11)
)
begin
select * from view_Tr_VerTarea where Tr_Id = tarea;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_ListarActuales` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_ListarActuales`(
_IdUsAsina INT (11),
_IdUsDesarrolla INT (11),
_opcion INT(11)
)
BEGIN 
IF _opcion = 1 THEN /*Opcion 1 para tasks.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_List WHERE Tr_FechaInicio <= CURRENT_DATE() AND Tr_FechaFinal > CURRENT_DATE() AND IdUsDesarrolla = _IdUsDesarrolla  AND IdUsAsigna != _IdUsAsina ORDER BY Tr_Id asc;
ELSEIF _opcion = 2 THEN /*Opcion 2 para tasksofgroup.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_List WHERE Tr_FechaInicio <= CURRENT_DATE() AND Tr_FechaFinal > CURRENT_DATE() AND IdUsDesarrolla = _IdUsDesarrolla  AND IdUsAsigna = _IdUsAsina ORDER BY Tr_Id asc;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_ListarAFuturo` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_ListarAFuturo`(
_IdUsAsina INT (11),
_IdUsDesarrolla INT (11),
_opcion INT(11)
)
BEGIN
IF _opcion = 1 THEN /*Opcion 1 para tasks.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_List WHERE Tr_FechaInicio >= CURRENT_DATE() AND IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna != _IdUsAsina ORDER BY Tr_Id DESC; 
ELSEIF _opcion = 2 THEN /*Opcion 2 para tasksofgroup.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_List WHERE Tr_FechaInicio >= CURRENT_DATE() AND IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna = _IdUsAsina ORDER BY Tr_Id DESC;
END IF; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_ListarComentarios` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_ListarComentarios`(
_IdTarea INT (11)
)
BEGIN
SELECT * FROM view_Tr_ComentariosTarea WHERE IdTarea = _IdTarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_ListarDesaprobadas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_ListarDesaprobadas`(
_IdUsAsina INT (11),
_IdUsDesarrolla INT (11),
_opcion INT (11)
)
BEGIN
IF _opcion = 1 THEN /*Opcion 1 para tasks.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_ListDesaprobadas WHERE IdEstado = 4 AND IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna != _IdUsAsina ORDER BY Tr_Id DESC;
ELSEIF _opcion = 2 THEN /*Opcion 2 para tasksofgroup.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_ListDesaprobadas WHERE IdEstado = 4 AND IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna = _IdUsAsina ORDER BY Tr_Id DESC;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_Listareasestado` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_Listareasestado`(
_IdUsAsina INT (11),
_IdUsDesarrolla INT (11),
_opcion INT (11),
_estado int (11)
)
BEGIN
IF _opcion = 1 THEN /*Opcion 1 para tasks.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_ListRestauradas WHERE IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna != _IdUsAsina AND IdEstado = _estado;
ELSEIF _opcion = 2 THEN /*Opcion 2 para tasksofgroup.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_ListRestauradas WHERE IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna = _IdUsAsina AND IdEstado = _estado;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_ListarTareas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_ListarTareas`(
_IdUsAsina INT (11),
_IdUsDesarrolla INT (11),
_opcion INT(11)
)
BEGIN
IF _opcion = 1 THEN /* Select para ver las tareas que le asigno el direcor por eso esta != el id del usuario que solicita */
SELECT * FROM view_Tr_List WHERE IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna != _IdUsAsina; 
ELSEIF _opcion = 2 THEN
/* Select para ver tareas creadas por uno como personales o como asignadas a un usuario */
SELECT * FROM view_Tr_List WHERE IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna = _IdUsAsina; 
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_ListarTerminadas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_ListarTerminadas`(
_IdUsAsina INT (11),
_IdUsDesarrolla INT (11),
_opcion INT (11)
)
BEGIN
IF _opcion = 1 THEN /*Opcion 1 para tasks.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_ListTerminadas  WHERE Tr_FechaFinal < CURRENT_DATE() AND IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna != _IdUsAsina  ORDER BY Tr_Id DESC;
ELSEIF _opcion = 2 THEN /*Opcion 2 para tasksofgroup.jsp = el Select para ver las tareas que asigno el direcor a un usuario */
SELECT * FROM view_Tr_ListTerminadas  WHERE Tr_FechaFinal < CURRENT_DATE() AND IdUsDesarrolla = _IdUsDesarrolla AND IdUsAsigna = _IdUsAsina  ORDER BY Tr_Id DESC;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_UpdateEstado` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_UpdateEstado`(
_TrId INT (11),
_EstadoTarea VARCHAR (45)
)
BEGIN
UPDATE tareas SET IdEstado = _EstadoTarea
WHERE Tr_Id = _TrId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_UpdateTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_UpdateTarea`(
_TrId INT (11),
_TrNombre VARCHAR (255),
_Tr_Anotacion VARCHAR (255),
_TrCaracteristicas MEDIUMTEXT,
_TrFechaInicio DATE,
_TrFechaFinal DATE
)
BEGIN	
UPDATE tareas SET Tr_Nombre = _TrNombre, Tr_Anotacion =	_Tr_Anotacion,Tr_Caracteristicas = _TrCaracteristicas,
Tr_FechaInicio = _TrFechaInicio  , Tr_FechaFinal = _TrFechaFinal
WHERE Tr_Id = _TrId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_ValidarUsuario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_ValidarUsuario`(
_IdTarea INT (11)
)
BEGIN
SELECT Tr_Id, IdUsDesarrolla, IdUsAsigna FROM tareas WHERE Tr_Id = _IdTarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_Validatareacompartida` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_Validatareacompartida`(
_IdTareacompartida INT (11)
)
BEGIN
SELECT * FROM view_Tr_tareacompartida WHERE IdTareaComparte = _IdTareacompartida;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Tr_VerTarea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Tr_VerTarea`(
_IdTarea INT (11),
_usuariodesarrolla int (11)
)
BEGIN
SELECT * FROM view_Tr_VerTarea WHERE Tr_Id = _IdTarea and IdUsDesarrolla = _usuariodesarrolla;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_Add` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_Add`(
_Nombres VARCHAR(45),
_Apellidos VARCHAR (45),
_Telefono VARCHAR (45),
_Correo VARCHAR (45),
_Clave VARCHAR (45),
_IdArea INT(11),
_IdRol INT(11)
)
BEGIN
INSERT INTO usuarios (Us_Nombres, Us_Apellidos, Us_Telefono, Us_Correo , Us_Clave, IdEstado ,IdArea, IdRol) 
VALUES ( _Nombres, _Apellidos, _Telefono, _Correo, _Clave, 1 ,_IdArea, _IdRol);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_AddEstadoUsuario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_AddEstadoUsuario`(
_IdUs INT(11),
_Estado int (11)
)
BEGIN
UPDATE usuarios SET IdEstado = _Estado WHERE Us_Id = _IdUs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_AgregarFotoPerfil` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_AgregarFotoPerfil`(
_IdUsuario int (11),
_RutaFoto varchar (45)
)
begin
update usuarios set Us_FotoPerfil = _RutaFoto
where Us_Id = _IdUsuario;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ConfirmaPass` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ConfirmaPass`(
_IdUs INT (11),
_Clave VARCHAR (45)
)
BEGIN
SELECT Us_Clave FROM usuarios WHERE Us_Id = _IdUs AND Us_Clave = _Clave;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_Eliminar` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_Eliminar`(
_IdUs INT(11)   
)
BEGIN
DELETE FROM usuarios WHERE Us_Id = _IdUs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_InfoPerfil` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_InfoPerfil`(
_IdUs INT (11)
)
BEGIN
SELECT * FROM view_Us_Perfil WHERE Us_Id = _IdUs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_IngresarLogin` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_IngresarLogin`(
_UsCorreo VARCHAR (45),
_UsClave VARCHAR (45)
)
BEGIN
SELECT Us_Id, Us_Nombres, Us_Correo, Us_Clave, IdEstado ,IdRol, IdArea FROM usuarios 
WHERE Us_Correo = _UsCorreo AND Us_Clave = _UsClave AND IdEstado = 1;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ListarGrupo` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ListarGrupo`(
_IdArea INT (11),
_Usuario INT (11)
)
BEGIN
SELECT * FROM view_Us_ListarGrupo WHERE IdArea = _IdArea AND IdEstado = 1 AND Us_Id != _Usuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ListDirectores` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ListDirectores`()
BEGIN
SELECT * FROM view_Us_ListarGrupo WHERE IdRol = 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ListUsuariosActivos` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ListUsuariosActivos`()
BEGIN
SELECT * FROM view_Us_Informacion WHERE Es_Id = 1;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ListUsuariosInactivos` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ListUsuariosInactivos`()
BEGIN
SELECT * FROM view_Us_Informacion WHERE Es_Id = 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ListUsuariosTodos` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ListUsuariosTodos`()
BEGIN
SELECT * FROM view_Us_Informacion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_UpdateDatosPersonales` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_UpdateDatosPersonales`(
_IdUsuario INT (11),
_Nombres VARCHAR (45),
_Apellidos VARCHAR (45),
_CorreoAlterno varchar (45),
_Telefono VARCHAR (45)
)
BEGIN 
UPDATE usuarios SET Us_Nombres = _Nombres, Us_Apellidos = _Apellidos, Us_CorreoAlternativo = _CorreoAlterno ,Us_Telefono = _Telefono
WHERE Us_Id = _IdUsuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_UpdateInfoTrabajo` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_UpdateInfoTrabajo`(
_IdUs INT(11),
_Correo VARCHAR (45),
_IdArea INT(11),
_IdRol INT(11)
)
BEGIN
UPDATE usuarios SET Us_Correo = _Correo, IdArea = _IdArea, IdRol = _IdRol
WHERE Us_Id = _IdUs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_UpdatePassword` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_UpdatePassword`(
_IdUs INT(11),
_Clave VARCHAR(45)
)
BEGIN
UPDATE usuarios SET Us_Clave = _Clave 
WHERE Us_Id = _IdUs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ValidarEmail` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ValidarEmail`(
_UsEmail VARCHAR (45)
)
BEGIN
SELECT Us_Id, Us_Correo,Us_CorreoAlternativo FROM usuarios WHERE Us_Correo = _UsEmail OR Us_CorreoAlternativo = _UsEmail;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Us_ValidarIdArea` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Us_ValidarIdArea`(
_IdUs INT (11)
)
BEGIN 
SELECT IdArea FROM usuarios WHERE Us_Id = _IdUs;
END */$$
DELIMITER ;

/*Table structure for table `view_ar_listarareas` */

DROP TABLE IF EXISTS `view_ar_listarareas`;

/*!50001 CREATE TABLE  `view_ar_listarareas`(
 `Ar_Id` int(11) ,
 `Ar_Nombre` varchar(45) 
)*/;

/*Table structure for table `view_ch_listchats` */

DROP TABLE IF EXISTS `view_ch_listchats`;

/*!50001 CREATE TABLE  `view_ch_listchats`(
 `Ch_FechaEnvio` date ,
 `DATE_FORMAT((Ch_HoraMensaje),"%H:%i")` varchar(10) ,
 `Ch_Mensaje` mediumtext ,
 `Us_Nombres` varchar(45) 
)*/;

/*Table structure for table `view_es_listestadosobjetos` */

DROP TABLE IF EXISTS `view_es_listestadosobjetos`;

/*!50001 CREATE TABLE  `view_es_listestadosobjetos`(
 `Es_Id` int(11) ,
 `Es_Estado` varchar(100) 
)*/;

/*Table structure for table `view_eventosusuario` */

DROP TABLE IF EXISTS `view_eventosusuario`;

/*!50001 CREATE TABLE  `view_eventosusuario`(
 `Ev_Id` int(11) ,
 `Ev_NombreEvento` varchar(100) ,
 `Ev_FechaInicio` date ,
 `Ev_FechaFinal` date ,
 `DATE_FORMAT(Ev_HoraInicio, '%H:%i')` varchar(10) ,
 `DATE_FORMAT(Ev_HoraFinal, '%H:%i')` varchar(10) ,
 `IdUsuario` int(11) 
)*/;

/*Table structure for table `view_hs_listtareas` */

DROP TABLE IF EXISTS `view_hs_listtareas`;

/*!50001 CREATE TABLE  `view_hs_listtareas`(
 `Hs_Id` int(11) ,
 `Hs_Nombretarea` varchar(100) ,
 `IdUsDesarrollo` int(11) ,
 `IdUsAsigna` int(11) 
)*/;

/*Table structure for table `view_hs_vertarea` */

DROP TABLE IF EXISTS `view_hs_vertarea`;

/*!50001 CREATE TABLE  `view_hs_vertarea`(
 `Hs_Id` int(11) ,
 `Hs_Nombretarea` varchar(100) ,
 `Hs_Anotacion` varchar(255) ,
 `Hs_FechaAprobacion` date ,
 `Hs_FechaAsignada` date ,
 `Hs_FechaInicio` date ,
 `Hs_FechaFin` date ,
 `Hs_Caracteristicas` mediumtext ,
 `IdUsDesarrollo` int(11) ,
 `IdUsAsigna` int(11) 
)*/;

/*Table structure for table `view_listnotas` */

DROP TABLE IF EXISTS `view_listnotas`;

/*!50001 CREATE TABLE  `view_listnotas`(
 `Bn_IdNotas` int(11) ,
 `Bn_NombreNota` varchar(100) ,
 `Bn_Nota` mediumtext ,
 `IdUsuarioCrea` int(11) 
)*/;

/*Table structure for table `view_md_modificaciones` */

DROP TABLE IF EXISTS `view_md_modificaciones`;

/*!50001 CREATE TABLE  `view_md_modificaciones`(
 `Md_FechaModificacion` date ,
 `Md_InfoModificacion` varchar(255) ,
 `Us_Nombres` varchar(45) ,
 `Us_Apellidos` varchar(45) ,
 `IdUsuarioModifica` int(11) 
)*/;

/*Table structure for table `view_ob_consultardisponibilidad` */

DROP TABLE IF EXISTS `view_ob_consultardisponibilidad`;

/*!50001 CREATE TABLE  `view_ob_consultardisponibilidad`(
 `IdObjeto` int(11) 
)*/;

/*Table structure for table `view_ob_disponibles` */

DROP TABLE IF EXISTS `view_ob_disponibles`;

/*!50001 CREATE TABLE  `view_ob_disponibles`(
 `Ob_Id` int(11) ,
 `Ob_Nombre` varchar(45) ,
 `Ob_Marca` varchar(100) ,
 `Es_Estado` varchar(100) 
)*/;

/*Table structure for table `view_ob_listtodosobjetos` */

DROP TABLE IF EXISTS `view_ob_listtodosobjetos`;

/*!50001 CREATE TABLE  `view_ob_listtodosobjetos`(
 `Ob_Id` int(11) ,
 `Ob_Nombre` varchar(45) ,
 `Ob_Marca` varchar(100) ,
 `Es_Estado` varchar(100) 
)*/;

/*Table structure for table `view_ob_listtodosobjetosreporte` */

DROP TABLE IF EXISTS `view_ob_listtodosobjetosreporte`;

/*!50001 CREATE TABLE  `view_ob_listtodosobjetosreporte`(
 `Ob_Id` int(11) ,
 `Ob_Nombre` varchar(45) ,
 `Ob_Marca` varchar(100) ,
 `Es_Estado` varchar(100) ,
 `Ob_Serial` varchar(100) ,
 `Ob_Caracteristicas` varchar(200) 
)*/;

/*Table structure for table `view_ob_objetosdeevento` */

DROP TABLE IF EXISTS `view_ob_objetosdeevento`;

/*!50001 CREATE TABLE  `view_ob_objetosdeevento`(
 `IdObjeto` int(11) ,
 `Ob_Nombre` varchar(45) ,
 `IdEvento` int(11) 
)*/;

/*Table structure for table `view_ob_objetosevento` */

DROP TABLE IF EXISTS `view_ob_objetosevento`;

/*!50001 CREATE TABLE  `view_ob_objetosevento`(
 `Ev_NombreEvento` varchar(100) ,
 `IdObjeto` int(11) ,
 `Ob_Nombre` varchar(45) ,
 `Es_Estado` varchar(100) ,
 `IdUsuario` int(11) 
)*/;

/*Table structure for table `view_rol_listarroles` */

DROP TABLE IF EXISTS `view_rol_listarroles`;

/*!50001 CREATE TABLE  `view_rol_listarroles`(
 `Rol_Id` int(11) ,
 `Rol_Nombre` varchar(45) 
)*/;

/*Table structure for table `view_ru_listasignaciones` */

DROP TABLE IF EXISTS `view_ru_listasignaciones`;

/*!50001 CREATE TABLE  `view_ru_listasignaciones`(
 `Ru_Id` int(11) ,
 `Ru_NombreReunion` varchar(100) ,
 `Ru_FechaInicio` date ,
 `Ru_FechaFinal` date ,
 `DATE_FORMAT(Ru_HoraInicio, '%H:%i')` varchar(10) ,
 `DATE_FORMAT(Ru_HoraFinal, '%H:%i')` varchar(10) ,
 `Ru_Comentarios` mediumtext ,
 `IdUsuario` int(11) ,
 `Us_Nombres` varchar(45) 
)*/;

/*Table structure for table `view_tc_listtareascompartidas` */

DROP TABLE IF EXISTS `view_tc_listtareascompartidas`;

/*!50001 CREATE TABLE  `view_tc_listtareascompartidas`(
 `IdTareaComparte` int(11) ,
 `IdUsuarioCompartido` int(11) ,
 `IdUsuarioComparte` int(11) ,
 `Us_Nombres` varchar(45) ,
 `Tr_Nombre` varchar(255) ,
 `Tr_FechaInicio` date ,
 `Tr_FechaFinal` date ,
 `IdEstado` int(11) 
)*/;

/*Table structure for table `view_tc_usuarioscompartetarea` */

DROP TABLE IF EXISTS `view_tc_usuarioscompartetarea`;

/*!50001 CREATE TABLE  `view_tc_usuarioscompartetarea`(
 `Us_Id` int(11) ,
 `Us_Nombres` varchar(45) ,
 `IdTareaComparte` int(11) ,
 `IdUsuarioCompartido` int(11) ,
 `Tr_Id` int(11) 
)*/;

/*Table structure for table `view_tr_comentariostarea` */

DROP TABLE IF EXISTS `view_tr_comentariostarea`;

/*!50001 CREATE TABLE  `view_tr_comentariostarea`(
 `Cm_Id` int(11) ,
 `Cm_Comentarios` mediumtext ,
 `IdUsuario` int(11) ,
 `IdTarea` int(11) ,
 `Us_Nombres` varchar(45) 
)*/;

/*Table structure for table `view_tr_list` */

DROP TABLE IF EXISTS `view_tr_list`;

/*!50001 CREATE TABLE  `view_tr_list`(
 `Tr_Id` int(11) ,
 `Tr_Nombre` varchar(255) ,
 `Tr_FechaInicio` date ,
 `Tr_FechaFinal` date ,
 `IdEstado` int(11) ,
 `IdUsDesarrolla` int(11) ,
 `IdUsAsigna` int(11) 
)*/;

/*Table structure for table `view_tr_listdesaprobadas` */

DROP TABLE IF EXISTS `view_tr_listdesaprobadas`;

/*!50001 CREATE TABLE  `view_tr_listdesaprobadas`(
 `Tr_Id` int(11) ,
 `Tr_Nombre` varchar(255) ,
 `Tr_FechaInicio` date ,
 `Tr_FechaFinal` date ,
 `IdEstado` int(11) ,
 `IdUsDesarrolla` int(11) ,
 `IdUsAsigna` int(11) 
)*/;

/*Table structure for table `view_tr_listrestauradas` */

DROP TABLE IF EXISTS `view_tr_listrestauradas`;

/*!50001 CREATE TABLE  `view_tr_listrestauradas`(
 `Tr_Id` int(11) ,
 `Tr_Nombre` varchar(255) ,
 `Tr_FechaInicio` date ,
 `Tr_FechaFinal` date ,
 `IdEstado` int(11) ,
 `IdUsDesarrolla` int(11) ,
 `IdUsAsigna` int(11) 
)*/;

/*Table structure for table `view_tr_listterminadas` */

DROP TABLE IF EXISTS `view_tr_listterminadas`;

/*!50001 CREATE TABLE  `view_tr_listterminadas`(
 `Tr_Id` int(11) ,
 `Tr_Nombre` varchar(255) ,
 `Tr_FechaInicio` date ,
 `Tr_FechaFinal` date ,
 `IdUsDesarrolla` int(11) ,
 `IdUsAsigna` int(11) 
)*/;

/*Table structure for table `view_tr_tareacompartida` */

DROP TABLE IF EXISTS `view_tr_tareacompartida`;

/*!50001 CREATE TABLE  `view_tr_tareacompartida`(
 `IdTareaComparte` int(11) ,
 `IdUsuarioCompartido` int(11) ,
 `IdUsuarioComparte` int(11) 
)*/;

/*Table structure for table `view_tr_vertarea` */

DROP TABLE IF EXISTS `view_tr_vertarea`;

/*!50001 CREATE TABLE  `view_tr_vertarea`(
 `Tr_Id` int(11) ,
 `Tr_Nombre` varchar(255) ,
 `Tr_Anotacion` varchar(255) ,
 `Tr_Caracteristicas` mediumtext ,
 `Tr_FechaAsignada` date ,
 `Tr_FechaInicio` date ,
 `Tr_FechaFinal` date ,
 `Es_Estado` varchar(100) ,
 `IdUsDesarrolla` int(11) ,
 `IdUsAsigna` int(11) 
)*/;

/*Table structure for table `view_us_informacion` */

DROP TABLE IF EXISTS `view_us_informacion`;

/*!50001 CREATE TABLE  `view_us_informacion`(
 `Us_Id` int(11) ,
 `Us_Nombres` varchar(45) ,
 `Us_Apellidos` varchar(45) ,
 `Us_Correo` varchar(45) ,
 `Us_Telefono` varchar(45) ,
 `Es_Id` int(11) ,
 `Rol_Nombre` varchar(45) ,
 `Ar_Nombre` varchar(45) 
)*/;

/*Table structure for table `view_us_listargrupo` */

DROP TABLE IF EXISTS `view_us_listargrupo`;

/*!50001 CREATE TABLE  `view_us_listargrupo`(
 `Us_Id` int(11) ,
 `Us_Nombres` varchar(45) ,
 `IdEstado` int(11) ,
 `IdArea` int(11) ,
 `IdRol` int(11) 
)*/;

/*Table structure for table `view_us_perfil` */

DROP TABLE IF EXISTS `view_us_perfil`;

/*!50001 CREATE TABLE  `view_us_perfil`(
 `Us_Id` int(11) ,
 `Us_Nombres` varchar(45) ,
 `Us_Apellidos` varchar(45) ,
 `Us_Correo` varchar(45) ,
 `Us_CorreoAlternativo` varchar(45) ,
 `Us_Telefono` varchar(45) ,
 `Us_FotoPerfil` varchar(255) ,
 `Rol_Nombre` varchar(45) ,
 `Ar_Nombre` varchar(45) ,
 `IdRol` int(11) ,
 `IdArea` int(11) 
)*/;

/*View structure for view view_ar_listarareas */

/*!50001 DROP TABLE IF EXISTS `view_ar_listarareas` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ar_listarareas` AS select `areas`.`Ar_Id` AS `Ar_Id`,`areas`.`Ar_Nombre` AS `Ar_Nombre` from `areas` */;

/*View structure for view view_ch_listchats */

/*!50001 DROP TABLE IF EXISTS `view_ch_listchats` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ch_listchats` AS select `chats`.`Ch_FechaEnvio` AS `Ch_FechaEnvio`,date_format(`chats`.`Ch_HoraMensaje`,'%H:%i') AS `DATE_FORMAT((Ch_HoraMensaje),"%H:%i")`,`chats`.`Ch_Mensaje` AS `Ch_Mensaje`,`usuarios`.`Us_Nombres` AS `Us_Nombres` from (`chats` join `usuarios` on(`usuarios`.`Us_Id` = `chats`.`IdUsuario`)) order by `chats`.`Ch_HoraMensaje` */;

/*View structure for view view_es_listestadosobjetos */

/*!50001 DROP TABLE IF EXISTS `view_es_listestadosobjetos` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_es_listestadosobjetos` AS select `estados`.`Es_Id` AS `Es_Id`,`estados`.`Es_Estado` AS `Es_Estado` from `estados` where `estados`.`Es_Id` between 7 and 9 */;

/*View structure for view view_eventosusuario */

/*!50001 DROP TABLE IF EXISTS `view_eventosusuario` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_eventosusuario` AS select `eventos`.`Ev_Id` AS `Ev_Id`,`eventos`.`Ev_NombreEvento` AS `Ev_NombreEvento`,`eventos`.`Ev_FechaInicio` AS `Ev_FechaInicio`,`eventos`.`Ev_FechaFinal` AS `Ev_FechaFinal`,date_format(`eventos`.`Ev_HoraInicio`,'%H:%i') AS `DATE_FORMAT(Ev_HoraInicio, '%H:%i')`,date_format(`eventos`.`Ev_HoraFinal`,'%H:%i') AS `DATE_FORMAT(Ev_HoraFinal, '%H:%i')`,`eventos`.`IdUsuario` AS `IdUsuario` from `eventos` */;

/*View structure for view view_hs_listtareas */

/*!50001 DROP TABLE IF EXISTS `view_hs_listtareas` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_hs_listtareas` AS select `historialtareas`.`Hs_Id` AS `Hs_Id`,`historialtareas`.`Hs_Nombretarea` AS `Hs_Nombretarea`,`historialtareas`.`IdUsDesarrollo` AS `IdUsDesarrollo`,`historialtareas`.`IdUsAsigna` AS `IdUsAsigna` from `historialtareas` */;

/*View structure for view view_hs_vertarea */

/*!50001 DROP TABLE IF EXISTS `view_hs_vertarea` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_hs_vertarea` AS select `historialtareas`.`Hs_Id` AS `Hs_Id`,`historialtareas`.`Hs_Nombretarea` AS `Hs_Nombretarea`,`historialtareas`.`Hs_Anotacion` AS `Hs_Anotacion`,`historialtareas`.`Hs_FechaAprobacion` AS `Hs_FechaAprobacion`,`historialtareas`.`Hs_FechaAsignada` AS `Hs_FechaAsignada`,`historialtareas`.`Hs_FechaInicio` AS `Hs_FechaInicio`,`historialtareas`.`Hs_FechaFin` AS `Hs_FechaFin`,`historialtareas`.`Hs_Caracteristicas` AS `Hs_Caracteristicas`,`historialtareas`.`IdUsDesarrollo` AS `IdUsDesarrollo`,`historialtareas`.`IdUsAsigna` AS `IdUsAsigna` from `historialtareas` */;

/*View structure for view view_listnotas */

/*!50001 DROP TABLE IF EXISTS `view_listnotas` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_listnotas` AS select `blocdenotas`.`Bn_IdNotas` AS `Bn_IdNotas`,`blocdenotas`.`Bn_NombreNota` AS `Bn_NombreNota`,`blocdenotas`.`Bn_Nota` AS `Bn_Nota`,`blocdenotas`.`IdUsuarioCrea` AS `IdUsuarioCrea` from `blocdenotas` order by `blocdenotas`.`Bn_IdNotas` */;

/*View structure for view view_md_modificaciones */

/*!50001 DROP TABLE IF EXISTS `view_md_modificaciones` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_md_modificaciones` AS select `modificacion`.`Md_FechaModificacion` AS `Md_FechaModificacion`,`modificacion`.`Md_InfoModificacion` AS `Md_InfoModificacion`,`usuarios`.`Us_Nombres` AS `Us_Nombres`,`usuarios`.`Us_Apellidos` AS `Us_Apellidos`,`modificacion`.`IdUsuarioModifica` AS `IdUsuarioModifica` from (`modificacion` join `usuarios` on(`modificacion`.`IdUsuarioModifica` = `usuarios`.`Us_Id`)) order by `usuarios`.`Us_Id` */;

/*View structure for view view_ob_consultardisponibilidad */

/*!50001 DROP TABLE IF EXISTS `view_ob_consultardisponibilidad` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ob_consultardisponibilidad` AS select `eventos_objetos`.`IdObjeto` AS `IdObjeto` from `eventos_objetos` */;

/*View structure for view view_ob_disponibles */

/*!50001 DROP TABLE IF EXISTS `view_ob_disponibles` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ob_disponibles` AS select `objetos`.`Ob_Id` AS `Ob_Id`,`objetos`.`Ob_Nombre` AS `Ob_Nombre`,`objetos`.`Ob_Marca` AS `Ob_Marca`,`estados`.`Es_Estado` AS `Es_Estado` from (`objetos` join `estados` on(`objetos`.`IdEstado` = `estados`.`Es_Id`)) where !(`objetos`.`Ob_Id` in (select `eventos_objetos`.`IdObjeto` from `eventos_objetos`)) order by `objetos`.`Ob_Nombre` */;

/*View structure for view view_ob_listtodosobjetos */

/*!50001 DROP TABLE IF EXISTS `view_ob_listtodosobjetos` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ob_listtodosobjetos` AS select `objetos`.`Ob_Id` AS `Ob_Id`,`objetos`.`Ob_Nombre` AS `Ob_Nombre`,`objetos`.`Ob_Marca` AS `Ob_Marca`,`estados`.`Es_Estado` AS `Es_Estado` from (`objetos` join `estados` on(`objetos`.`IdEstado` = `estados`.`Es_Id`)) order by `objetos`.`Ob_Id` */;

/*View structure for view view_ob_listtodosobjetosreporte */

/*!50001 DROP TABLE IF EXISTS `view_ob_listtodosobjetosreporte` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ob_listtodosobjetosreporte` AS select `objetos`.`Ob_Id` AS `Ob_Id`,`objetos`.`Ob_Nombre` AS `Ob_Nombre`,`objetos`.`Ob_Marca` AS `Ob_Marca`,`estados`.`Es_Estado` AS `Es_Estado`,`objetos`.`Ob_Serial` AS `Ob_Serial`,`objetos`.`Ob_Caracteristicas` AS `Ob_Caracteristicas` from (`objetos` join `estados` on(`objetos`.`IdEstado` = `estados`.`Es_Id`)) order by `objetos`.`Ob_Id` */;

/*View structure for view view_ob_objetosdeevento */

/*!50001 DROP TABLE IF EXISTS `view_ob_objetosdeevento` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ob_objetosdeevento` AS select `eventos_objetos`.`IdObjeto` AS `IdObjeto`,`objetos`.`Ob_Nombre` AS `Ob_Nombre`,`eventos_objetos`.`IdEvento` AS `IdEvento` from (`objetos` join `eventos_objetos` on(`objetos`.`Ob_Id` = `eventos_objetos`.`IdObjeto`)) order by `eventos_objetos`.`IdObjeto` */;

/*View structure for view view_ob_objetosevento */

/*!50001 DROP TABLE IF EXISTS `view_ob_objetosevento` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ob_objetosevento` AS select `eventos`.`Ev_NombreEvento` AS `Ev_NombreEvento`,`eventos_objetos`.`IdObjeto` AS `IdObjeto`,`objetos`.`Ob_Nombre` AS `Ob_Nombre`,`estados`.`Es_Estado` AS `Es_Estado`,`eventos`.`IdUsuario` AS `IdUsuario` from (((`eventos_objetos` join `objetos` on(`objetos`.`Ob_Id` = `eventos_objetos`.`IdObjeto`)) join `eventos` on(`eventos`.`Ev_Id` = `eventos_objetos`.`IdEvento`)) join `estados` on(`estados`.`Es_Id` = `objetos`.`IdEstado`)) order by `eventos`.`Ev_Id` */;

/*View structure for view view_rol_listarroles */

/*!50001 DROP TABLE IF EXISTS `view_rol_listarroles` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_rol_listarroles` AS select `rol`.`Rol_Id` AS `Rol_Id`,`rol`.`Rol_Nombre` AS `Rol_Nombre` from `rol` */;

/*View structure for view view_ru_listasignaciones */

/*!50001 DROP TABLE IF EXISTS `view_ru_listasignaciones` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ru_listasignaciones` AS select `reunion`.`Ru_Id` AS `Ru_Id`,`reunion`.`Ru_Nombrereunion` AS `Ru_NombreReunion`,`reunion`.`Ru_FechaInicio` AS `Ru_FechaInicio`,`reunion`.`Ru_FechaFinal` AS `Ru_FechaFinal`,date_format(`reunion`.`Ru_HoraInicio`,'%H:%i') AS `DATE_FORMAT(Ru_HoraInicio, '%H:%i')`,date_format(`reunion`.`Ru_HoraFinal`,'%H:%i') AS `DATE_FORMAT(Ru_HoraFinal, '%H:%i')`,`reunion`.`Ru_Comentarios` AS `Ru_Comentarios`,`reunion`.`IdUsuario` AS `IdUsuario`,`usuarios`.`Us_Nombres` AS `Us_Nombres` from (`reunion` join `usuarios` on(`usuarios`.`Us_Id` = `reunion`.`IdUsuario`)) order by `reunion`.`Ru_FechaInicio` */;

/*View structure for view view_tc_listtareascompartidas */

/*!50001 DROP TABLE IF EXISTS `view_tc_listtareascompartidas` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tc_listtareascompartidas` AS select `tareacompartida`.`IdTareaComparte` AS `IdTareaComparte`,`tareacompartida`.`IdUsuarioCompartido` AS `IdUsuarioCompartido`,`tareacompartida`.`IdUsuarioComparte` AS `IdUsuarioComparte`,`usuarios`.`Us_Nombres` AS `Us_Nombres`,`tareas`.`Tr_Nombre` AS `Tr_Nombre`,`tareas`.`Tr_FechaInicio` AS `Tr_FechaInicio`,`tareas`.`Tr_FechaFinal` AS `Tr_FechaFinal`,`tareas`.`IdEstado` AS `IdEstado` from ((`tareas` join `tareacompartida` on(`tareas`.`Tr_Id` = `tareacompartida`.`IdTareaComparte`)) join `usuarios` on(`tareacompartida`.`IdUsuarioComparte` = `usuarios`.`Us_Id`)) */;

/*View structure for view view_tc_usuarioscompartetarea */

/*!50001 DROP TABLE IF EXISTS `view_tc_usuarioscompartetarea` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tc_usuarioscompartetarea` AS select `usuarios`.`Us_Id` AS `Us_Id`,`usuarios`.`Us_Nombres` AS `Us_Nombres`,`tareacompartida`.`IdTareaComparte` AS `IdTareaComparte`,`tareacompartida`.`IdUsuarioCompartido` AS `IdUsuarioCompartido`,`tareas`.`Tr_Id` AS `Tr_Id` from ((`tareas` join `tareacompartida` on(`tareas`.`Tr_Id` = `tareacompartida`.`IdTareaComparte`)) join `usuarios` on(`tareacompartida`.`IdUsuarioCompartido` = `usuarios`.`Us_Id`)) */;

/*View structure for view view_tr_comentariostarea */

/*!50001 DROP TABLE IF EXISTS `view_tr_comentariostarea` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tr_comentariostarea` AS select `comentarios`.`Cm_Id` AS `Cm_Id`,`comentarios`.`Cm_Comentarios` AS `Cm_Comentarios`,`comentarios`.`IdUsuario` AS `IdUsuario`,`comentarios`.`IdTarea` AS `IdTarea`,`usuarios`.`Us_Nombres` AS `Us_Nombres` from (`comentarios` join `usuarios` on(`comentarios`.`IdUsuario` = `usuarios`.`Us_Id`)) order by `comentarios`.`Cm_Id` */;

/*View structure for view view_tr_list */

/*!50001 DROP TABLE IF EXISTS `view_tr_list` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tr_list` AS select `tareas`.`Tr_Id` AS `Tr_Id`,`tareas`.`Tr_Nombre` AS `Tr_Nombre`,`tareas`.`Tr_FechaInicio` AS `Tr_FechaInicio`,`tareas`.`Tr_FechaFinal` AS `Tr_FechaFinal`,`tareas`.`IdEstado` AS `IdEstado`,`tareas`.`IdUsDesarrolla` AS `IdUsDesarrolla`,`tareas`.`IdUsAsigna` AS `IdUsAsigna` from `tareas` */;

/*View structure for view view_tr_listdesaprobadas */

/*!50001 DROP TABLE IF EXISTS `view_tr_listdesaprobadas` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tr_listdesaprobadas` AS select `tareas`.`Tr_Id` AS `Tr_Id`,`tareas`.`Tr_Nombre` AS `Tr_Nombre`,`tareas`.`Tr_FechaInicio` AS `Tr_FechaInicio`,`tareas`.`Tr_FechaFinal` AS `Tr_FechaFinal`,`tareas`.`IdEstado` AS `IdEstado`,`tareas`.`IdUsDesarrolla` AS `IdUsDesarrolla`,`tareas`.`IdUsAsigna` AS `IdUsAsigna` from `tareas` */;

/*View structure for view view_tr_listrestauradas */

/*!50001 DROP TABLE IF EXISTS `view_tr_listrestauradas` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tr_listrestauradas` AS select `tareas`.`Tr_Id` AS `Tr_Id`,`tareas`.`Tr_Nombre` AS `Tr_Nombre`,`tareas`.`Tr_FechaInicio` AS `Tr_FechaInicio`,`tareas`.`Tr_FechaFinal` AS `Tr_FechaFinal`,`tareas`.`IdEstado` AS `IdEstado`,`tareas`.`IdUsDesarrolla` AS `IdUsDesarrolla`,`tareas`.`IdUsAsigna` AS `IdUsAsigna` from `tareas` */;

/*View structure for view view_tr_listterminadas */

/*!50001 DROP TABLE IF EXISTS `view_tr_listterminadas` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tr_listterminadas` AS select `tareas`.`Tr_Id` AS `Tr_Id`,`tareas`.`Tr_Nombre` AS `Tr_Nombre`,`tareas`.`Tr_FechaInicio` AS `Tr_FechaInicio`,`tareas`.`Tr_FechaFinal` AS `Tr_FechaFinal`,`tareas`.`IdUsDesarrolla` AS `IdUsDesarrolla`,`tareas`.`IdUsAsigna` AS `IdUsAsigna` from `tareas` */;

/*View structure for view view_tr_tareacompartida */

/*!50001 DROP TABLE IF EXISTS `view_tr_tareacompartida` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tr_tareacompartida` AS select `tareacompartida`.`IdTareaComparte` AS `IdTareaComparte`,`tareacompartida`.`IdUsuarioCompartido` AS `IdUsuarioCompartido`,`tareacompartida`.`IdUsuarioComparte` AS `IdUsuarioComparte` from `tareacompartida` */;

/*View structure for view view_tr_vertarea */

/*!50001 DROP TABLE IF EXISTS `view_tr_vertarea` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tr_vertarea` AS select `tareas`.`Tr_Id` AS `Tr_Id`,`tareas`.`Tr_Nombre` AS `Tr_Nombre`,`tareas`.`Tr_Anotacion` AS `Tr_Anotacion`,`tareas`.`Tr_Caracteristicas` AS `Tr_Caracteristicas`,`tareas`.`Tr_FechaAsignada` AS `Tr_FechaAsignada`,`tareas`.`Tr_FechaInicio` AS `Tr_FechaInicio`,`tareas`.`Tr_FechaFinal` AS `Tr_FechaFinal`,`estados`.`Es_Estado` AS `Es_Estado`,`tareas`.`IdUsDesarrolla` AS `IdUsDesarrolla`,`tareas`.`IdUsAsigna` AS `IdUsAsigna` from (`tareas` join `estados` on(`tareas`.`IdEstado` = `estados`.`Es_Id`)) order by `tareas`.`Tr_Nombre` */;

/*View structure for view view_us_informacion */

/*!50001 DROP TABLE IF EXISTS `view_us_informacion` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_us_informacion` AS select `usuarios`.`Us_Id` AS `Us_Id`,`usuarios`.`Us_Nombres` AS `Us_Nombres`,`usuarios`.`Us_Apellidos` AS `Us_Apellidos`,`usuarios`.`Us_Correo` AS `Us_Correo`,`usuarios`.`Us_Telefono` AS `Us_Telefono`,`estados`.`Es_Id` AS `Es_Id`,`rol`.`Rol_Nombre` AS `Rol_Nombre`,`areas`.`Ar_Nombre` AS `Ar_Nombre` from (((`usuarios` join `estados` on(`usuarios`.`IdEstado` = `estados`.`Es_Id`)) join `rol` on(`usuarios`.`IdRol` = `rol`.`Rol_Id`)) join `areas` on(`usuarios`.`IdArea` = `areas`.`Ar_Id`)) order by `usuarios`.`Us_Id` */;

/*View structure for view view_us_listargrupo */

/*!50001 DROP TABLE IF EXISTS `view_us_listargrupo` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_us_listargrupo` AS select `usuarios`.`Us_Id` AS `Us_Id`,`usuarios`.`Us_Nombres` AS `Us_Nombres`,`usuarios`.`IdEstado` AS `IdEstado`,`usuarios`.`IdArea` AS `IdArea`,`usuarios`.`IdRol` AS `IdRol` from `usuarios` */;

/*View structure for view view_us_perfil */

/*!50001 DROP TABLE IF EXISTS `view_us_perfil` */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_us_perfil` AS select `usuarios`.`Us_Id` AS `Us_Id`,`usuarios`.`Us_Nombres` AS `Us_Nombres`,`usuarios`.`Us_Apellidos` AS `Us_Apellidos`,`usuarios`.`Us_Correo` AS `Us_Correo`,`usuarios`.`Us_CorreoAlternativo` AS `Us_CorreoAlternativo`,`usuarios`.`Us_Telefono` AS `Us_Telefono`,`usuarios`.`Us_FotoPerfil` AS `Us_FotoPerfil`,`rol`.`Rol_Nombre` AS `Rol_Nombre`,`areas`.`Ar_Nombre` AS `Ar_Nombre`,`usuarios`.`IdRol` AS `IdRol`,`usuarios`.`IdArea` AS `IdArea` from (((`usuarios` join `estados` on(`usuarios`.`IdEstado` = `estados`.`Es_Id`)) join `rol` on(`usuarios`.`IdRol` = `rol`.`Rol_Id`)) join `areas` on(`usuarios`.`IdArea` = `areas`.`Ar_Id`)) order by `usuarios`.`Us_Id` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

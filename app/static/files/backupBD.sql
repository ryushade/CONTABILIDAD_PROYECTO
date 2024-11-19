CREATE TABLE `almacen` (
  `id_almacen` int NOT NULL AUTO_INCREMENT,
  `nom_almacen` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ubicacion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado_almacen` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO almacen VALUES (1, 'ALM CENTRAL ESCALERA', '', 1);
INSERT INTO almacen VALUES (2, 'ALMACEN CENTRAL 22', '', 1);
INSERT INTO almacen VALUES (3, 'ALM CENTRAL 52-53', '', 1);
INSERT INTO almacen VALUES (4, 'ALM PRODUCCION', '', 1);
INSERT INTO almacen VALUES (5, 'ALM BALTA 7-8', '', 1);

CREATE TABLE `anular_sunat` (
  `id_anular` int NOT NULL,
  `anular` int NOT NULL,
  PRIMARY KEY (`id_anular`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO anular_sunat VALUES (4, 3);

CREATE TABLE `anular_sunat_b` (
  `id_anular_b` int NOT NULL,
  `anular_b` int DEFAULT NULL,
  PRIMARY KEY (`id_anular_b`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO anular_sunat_b VALUES (5, 6);

CREATE TABLE `asiento_contable` (
  `id_asiento` int NOT NULL AUTO_INCREMENT,
  `id_periodo` int NOT NULL,
  `fecha_asiento` date NOT NULL,
  `glosa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tipo_asiento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_asiento` tinyint(1) NOT NULL,
  `total_debe` decimal(20,6) NOT NULL,
  `total_haber` decimal(20,6) NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `id_comprobante` int DEFAULT NULL,
  PRIMARY KEY (`id_asiento`),
  KEY `id_periodo` (`id_periodo`),
  KEY `id_usuario` (`id_usuario`),
  KEY `fk_id_comprobante` (`id_comprobante`),
  CONSTRAINT `asiento_contable_ibfk_1` FOREIGN KEY (`id_periodo`) REFERENCES `periodo_contable` (`id_periodo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `asiento_contable_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_id_comprobante` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO asiento_contable VALUES (142, 1, 2024-11-19, 'POR LA VENTA DE MERCADERÍA SEGÚN BOLETA B100-00000017', 'venta_contado', 1, 171.360000, 171.360000, None, 385);
INSERT INTO asiento_contable VALUES (143, 1, 2024-11-19, 'POR EL REGISTRO DE LA COMPRA DE MERCADERÍA', 'compra_contado', 1, 737.500000, 737.500000, None, 386);
INSERT INTO asiento_contable VALUES (144, 1, 2024-11-19, 'POR EL INGRESO DE LA MERCADERÍA AL ALMACÉN', 'compra_contado_3', 1, 625.000000, 625.000000, None, 386);
INSERT INTO asiento_contable VALUES (145, 1, 2024-11-19, 'POR EL PAGO DE LA FACTURA DEL PROVEEDOR B000-212', 'compra_contado_2', 1, 737.500000, 737.500000, None, 386);
INSERT INTO asiento_contable VALUES (146, 1, 2024-11-19, 'POR LA VENTA DE MERCADERÍA SEGÚN BOLETA B100-00000018', 'venta_contado', 1, 171.360000, 171.360000, None, 387);

CREATE TABLE `bitacora_nota` (
  `id_bitacora` int NOT NULL AUTO_INCREMENT,
  `id_nota` int DEFAULT NULL,
  `id_producto` int DEFAULT NULL,
  `id_almacen` int DEFAULT NULL,
  `id_detalle_nota` int DEFAULT NULL,
  `entra` int DEFAULT NULL,
  `sale` int DEFAULT NULL,
  `stock_anterior` int DEFAULT NULL,
  `stock_actual` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id_bitacora`),
  KEY `id_nota` (`id_nota`),
  KEY `id_producto` (`id_producto`),
  KEY `id_almacen` (`id_almacen`),
  KEY `id_detalle_nota` (`id_detalle_nota`),
  CONSTRAINT `bitacora_nota_ibfk_1` FOREIGN KEY (`id_nota`) REFERENCES `nota` (`id_nota`),
  CONSTRAINT `bitacora_nota_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `bitacora_nota_ibfk_3` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `bitacora_nota_ibfk_4` FOREIGN KEY (`id_detalle_nota`) REFERENCES `detalle_nota` (`id_detalle_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nom_categoria` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_categoria` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nom_categoria` (`nom_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO categoria VALUES (2, 'Producto', 1);
INSERT INTO categoria VALUES (3, 'Materia Prima', 1);

CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `dni` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ruc` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `apellidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `razon_social` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado_cliente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO cliente VALUES (1, '73747576', '', 'Ruben', 'Meladoblas', '', '', 0);
INSERT INTO cliente VALUES (2, '', '10524578961', '', '', 'Empresa VALDOS I.R.L', '', 0);
INSERT INTO cliente VALUES (3, '76070007', '', 'LEYDI VANESSA', 'IDROGO TANTAJULCA', '', '', 0);
INSERT INTO cliente VALUES (15, '99999999', '', 'Cliente', 'Varios', '', '', 0);

CREATE TABLE `compra` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `id_proveedor` int NOT NULL,
  `nro_comprobante` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_compra` int DEFAULT NULL,
  `f_compra` date DEFAULT NULL,
  `igv` decimal(10,2) DEFAULT NULL,
  `monto_total` decimal(10,2) DEFAULT NULL,
  `id_comprobante` int DEFAULT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO compra VALUES (32, 1, 'B000-212', 1, 2024-11-19, 112.50, 737.50, 386);

CREATE TABLE `comprobante` (
  `id_comprobante` int NOT NULL AUTO_INCREMENT,
  `id_tipocomprobante` int NOT NULL,
  `num_comprobante` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_comprobante`),
  UNIQUE KEY `num_comprobante` (`num_comprobante`,`id_comprobante`,`id_tipocomprobante`) USING BTREE,
  KEY `FKcomprobant701552` (`id_tipocomprobante`),
  CONSTRAINT `FKcomprobant701552` FOREIGN KEY (`id_tipocomprobante`) REFERENCES `tipo_comprobante` (`id_tipocomprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO comprobante VALUES (386, 1, 'B000-212');
INSERT INTO comprobante VALUES (359, 1, 'B001-000010');
INSERT INTO comprobante VALUES (367, 1, 'B001-000020');
INSERT INTO comprobante VALUES (363, 1, 'B001-312');
INSERT INTO comprobante VALUES (365, 1, 'B001-321');
INSERT INTO comprobante VALUES (360, 1, 'B001-359');
INSERT INTO comprobante VALUES (362, 1, 'B001-361');
INSERT INTO comprobante VALUES (380, 1, 'B001-3612');
INSERT INTO comprobante VALUES (356, 1, 'B001-362');
INSERT INTO comprobante VALUES (355, 1, 'B001-365');
INSERT INTO comprobante VALUES (358, 1, 'B001-366');
INSERT INTO comprobante VALUES (364, 1, 'B001-368');
INSERT INTO comprobante VALUES (368, 1, 'B001-380');
INSERT INTO comprobante VALUES (369, 1, 'B001-382');
INSERT INTO comprobante VALUES (309, 1, 'B100-00000001');
INSERT INTO comprobante VALUES (315, 1, 'B100-00000001');
INSERT INTO comprobante VALUES (329, 1, 'B100-00000001');
INSERT INTO comprobante VALUES (338, 1, 'B100-00000001');
INSERT INTO comprobante VALUES (347, 1, 'B100-00000001');
INSERT INTO comprobante VALUES (352, 1, 'B100-00000001');
INSERT INTO comprobante VALUES (312, 1, 'B100-00000002');
INSERT INTO comprobante VALUES (332, 1, 'B100-00000003');
INSERT INTO comprobante VALUES (340, 1, 'B100-00000004');
INSERT INTO comprobante VALUES (354, 1, 'B100-00000005');
INSERT INTO comprobante VALUES (361, 1, 'B100-00000006');
INSERT INTO comprobante VALUES (366, 1, 'B100-00000007');
INSERT INTO comprobante VALUES (370, 1, 'B100-00000008');
INSERT INTO comprobante VALUES (373, 1, 'B100-00000009');
INSERT INTO comprobante VALUES (374, 1, 'B100-00000010');
INSERT INTO comprobante VALUES (377, 1, 'B100-00000011');
INSERT INTO comprobante VALUES (378, 1, 'B100-00000012');
INSERT INTO comprobante VALUES (381, 1, 'B100-00000013');
INSERT INTO comprobante VALUES (382, 1, 'B100-00000014');
INSERT INTO comprobante VALUES (383, 1, 'B100-00000015');
INSERT INTO comprobante VALUES (384, 1, 'B100-00000016');
INSERT INTO comprobante VALUES (385, 1, 'B100-00000017');
INSERT INTO comprobante VALUES (387, 1, 'B100-00000018');
INSERT INTO comprobante VALUES (305, 2, 'F100-00000001');
INSERT INTO comprobante VALUES (316, 2, 'F100-00000001');
INSERT INTO comprobante VALUES (333, 2, 'F100-00000001');
INSERT INTO comprobante VALUES (350, 2, 'F100-00000001');
INSERT INTO comprobante VALUES (351, 2, 'F100-00000001');
INSERT INTO comprobante VALUES (371, 2, 'F100-00000001');
INSERT INTO comprobante VALUES (311, 2, 'F100-00000002');
INSERT INTO comprobante VALUES (313, 2, 'F100-00000003');
INSERT INTO comprobante VALUES (314, 2, 'F100-00000004');
INSERT INTO comprobante VALUES (318, 2, 'F100-00000005');
INSERT INTO comprobante VALUES (337, 2, 'F100-00000006');
INSERT INTO comprobante VALUES (341, 2, 'F100-00000007');
INSERT INTO comprobante VALUES (343, 2, 'F100-00000008');
INSERT INTO comprobante VALUES (344, 2, 'F100-00000009');
INSERT INTO comprobante VALUES (346, 2, 'F100-00000010');
INSERT INTO comprobante VALUES (375, 2, 'F100-00000011');
INSERT INTO comprobante VALUES (379, 2, 'F100-00000012');
INSERT INTO comprobante VALUES (310, 3, 'N100-00000001');
INSERT INTO comprobante VALUES (353, 3, 'N100-00000001');

CREATE TABLE `cuenta` (
  `id_cuenta` int NOT NULL AUTO_INCREMENT,
  `codigo_cuenta` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nombre_cuenta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tipo_cuenta` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `naturaleza` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_cuenta` tinyint(1) NOT NULL DEFAULT '1',
  `cuenta_padre` int DEFAULT NULL,
  `nivel` int NOT NULL,
  PRIMARY KEY (`id_cuenta`),
  UNIQUE KEY `codigo_cuenta` (`codigo_cuenta`),
  KEY `cuenta_padre` (`cuenta_padre`),
  CONSTRAINT `cuenta_ibfk_1` FOREIGN KEY (`cuenta_padre`) REFERENCES `cuenta` (`id_cuenta`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1782 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO cuenta VALUES (1, '1', 'ACTIVO DISPONIBLE Y EXIGIBLE ', 'Activo', 'Deudora', 1, None, 1);
INSERT INTO cuenta VALUES (2, '10', 'EFECTIVO Y EQUIVALENTES DE EFECTIVO', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (3, '101', 'Caja', 'Activo', 'Deudora', 1, 2, 3);
INSERT INTO cuenta VALUES (4, '102', 'Fondos fijos', 'Activo', 'Deudora', 1, 2, 3);
INSERT INTO cuenta VALUES (5, '103', ' Efectivo y cheques en tránsito', 'Activo', 'Deudora', 1, 2, 3);
INSERT INTO cuenta VALUES (6, '104', 'Cuentas corrientes en instituciones financieras', 'Activo', 'Deudora', 1, 2, 3);
INSERT INTO cuenta VALUES (7, '105', 'Otros equivalentes de efectivo', 'Activo', 'Deudora', 1, 2, 3);
INSERT INTO cuenta VALUES (8, '106', 'Depósitos en instituciones financieras', 'Activo', 'Deudora', 1, 2, 3);
INSERT INTO cuenta VALUES (9, '107', 'Fondos sujetos a restricción', 'Activo', 'Deudora', 1, 2, 3);
INSERT INTO cuenta VALUES (10, '1041', 'Cuentas corrientes operativas', 'Activo', 'Deudora', 1, 6, 4);
INSERT INTO cuenta VALUES (11, '1042', 'Cuentas corrientes para fines específicos', 'Activo', 'Deudora', 1, 6, 4);
INSERT INTO cuenta VALUES (12, '1051', 'Otros equivalentes de efectivo', 'Activo', 'Deudora', 1, 7, 4);
INSERT INTO cuenta VALUES (13, '1061', 'Depósitos de ahorro', 'Activo', 'Deudora', 1, 8, 4);
INSERT INTO cuenta VALUES (14, '1062', 'Depósitos a plazo', 'Activo', 'Deudora', 1, 8, 4);
INSERT INTO cuenta VALUES (15, '1071', 'Fondos en garantía', 'Activo', 'Deudora', 1, 9, 4);
INSERT INTO cuenta VALUES (16, '1072', 'Fondos retenidos por mandato de la autoridad', 'Activo', 'Deudora', 1, 9, 4);
INSERT INTO cuenta VALUES (17, '1073', 'Otros fondos sujetos a restricción', 'Activo', 'Deudora', 1, 9, 4);
INSERT INTO cuenta VALUES (18, '11', 'INVERSIONES FINANCIERAS', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (19, '111', 'Inversiones mantenidas para negociación', 'Activo', 'Deudora', 1, 18, 3);
INSERT INTO cuenta VALUES (20, '1111', 'Valores emitidos o garantizados por el Estado', 'Activo', 'Deudora', 1, 19, 4);
INSERT INTO cuenta VALUES (21, '11111', 'Costo', 'Activo', 'Deudora', 1, 20, 5);
INSERT INTO cuenta VALUES (22, '11112', 'Valor Razonable', 'Activo', 'Deudora', 1, 20, 5);
INSERT INTO cuenta VALUES (23, '1112', 'Valores emitidos por el sistema financiero', 'Activo', 'Deudora', 1, 19, 4);
INSERT INTO cuenta VALUES (24, '11121', 'Costo', 'Activo', 'Deudora', 1, 23, 5);
INSERT INTO cuenta VALUES (25, '11122', 'Valor Razonable', 'Activo', 'Deudora', 1, 23, 5);
INSERT INTO cuenta VALUES (26, '1113', 'Valores emitidos por entidades', 'Activo', 'Deudora', 1, 19, 4);
INSERT INTO cuenta VALUES (27, '11131', 'Costo', 'Activo', 'Deudora', 1, 26, 5);
INSERT INTO cuenta VALUES (28, '11132', 'Valor Razonable', 'Activo', 'Deudora', 1, 26, 5);
INSERT INTO cuenta VALUES (29, '1114', 'Otros títulos representativos de deuda', 'Activo', 'Deudora', 1, 19, 4);
INSERT INTO cuenta VALUES (30, '11141', 'Costo', 'Activo', 'Deudora', 1, 29, 5);
INSERT INTO cuenta VALUES (31, '11142', 'Valor Razonable', 'Activo', 'Deudora', 1, 29, 5);
INSERT INTO cuenta VALUES (32, '1115', 'Participaciones en entidades', 'Activo', 'Deudora', 1, 19, 4);
INSERT INTO cuenta VALUES (33, '11151', 'Costo', 'Activo', 'Deudora', 1, 32, 5);
INSERT INTO cuenta VALUES (34, '11152', 'Valor Razonable', 'Activo', 'Deudora', 1, 32, 5);
INSERT INTO cuenta VALUES (35, '112', 'Otras inversiones financieras', 'Activo', 'Deudora', 1, 18, 3);
INSERT INTO cuenta VALUES (36, '1121', 'Otras inversiones financieras', 'Activo', 'Deudora', 1, 35, 4);
INSERT INTO cuenta VALUES (37, '11211', 'Costo', 'Activo', 'Deudora', 1, 36, 5);
INSERT INTO cuenta VALUES (38, '11212', 'Valor Razonable', 'Activo', 'Deudora', 1, 36, 5);
INSERT INTO cuenta VALUES (39, '113', 'Activos financieros – Acuerdo de compra', 'Activo', 'Deudora', 1, 18, 3);
INSERT INTO cuenta VALUES (40, '1131', 'Inversiones mantenidas para negociación – Acuerdo de compra', 'Activo', 'Deudora', 1, 39, 4);
INSERT INTO cuenta VALUES (41, '11311', 'Costo', 'Activo', 'Deudora', 1, 40, 5);
INSERT INTO cuenta VALUES (42, '11312', 'Valor Razonable', 'Activo', 'Deudora', 1, 40, 5);
INSERT INTO cuenta VALUES (43, '1132', 'Otras inversiones financieras', 'Activo', 'Deudora', 1, 39, 4);
INSERT INTO cuenta VALUES (44, '11321', 'Costo', 'Activo', 'Deudora', 1, 43, 5);
INSERT INTO cuenta VALUES (45, '11322', 'Valor Razonable', 'Activo', 'Deudora', 1, 43, 5);
INSERT INTO cuenta VALUES (46, '12', 'CUENTAS POR COBRAR COMERCIALES – TERCEROS', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (47, '121', 'Facturas, boletas y otros comprobantes por cobrar', 'Activo', 'Deudora', 1, 46, 3);
INSERT INTO cuenta VALUES (48, '1211', 'No emitidas', 'Activo', 'Deudora', 1, 47, 4);
INSERT INTO cuenta VALUES (49, '1212', 'Emitidas en cartera', 'Activo', 'Deudora', 1, 47, 4);
INSERT INTO cuenta VALUES (50, '1213', 'En cobranza', 'Activo', 'Deudora', 1, 47, 4);
INSERT INTO cuenta VALUES (51, '1214', 'En descuento', 'Activo', 'Deudora', 1, 47, 4);
INSERT INTO cuenta VALUES (52, '122', 'Anticipos de clientes', 'Activo', 'Deudora', 1, 46, 3);
INSERT INTO cuenta VALUES (53, '123', 'Letras por cobrar', 'Activo', 'Deudora', 1, 46, 3);
INSERT INTO cuenta VALUES (54, '1232', 'En cartera', 'Activo', 'Deudora', 1, 53, 4);
INSERT INTO cuenta VALUES (55, '1233', 'En cobranza', 'Activo', 'Deudora', 1, 53, 4);
INSERT INTO cuenta VALUES (56, '1234', 'En descuento', 'Activo', 'Deudora', 1, 53, 4);
INSERT INTO cuenta VALUES (57, '13', 'CUENTAS POR COBRAR COMERCIALES – RELACIONADAS', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (58, '131', 'Facturas, boletas y otros comprobantes por cobrar', 'Activo', 'Deudora', 1, 57, 3);
INSERT INTO cuenta VALUES (59, '1311', 'No emitidas', 'Activo', 'Deudora', 1, 58, 4);
INSERT INTO cuenta VALUES (60, '1312', 'En cartera', 'Activo', 'Deudora', 1, 58, 4);
INSERT INTO cuenta VALUES (61, '1313', 'En cobranza', 'Activo', 'Deudora', 1, 58, 4);
INSERT INTO cuenta VALUES (62, '1314', 'En descuento', 'Activo', 'Deudora', 1, 58, 4);
INSERT INTO cuenta VALUES (63, '132', 'Anticipos recibidos', 'Activo', 'Deudora', 1, 57, 3);
INSERT INTO cuenta VALUES (64, '1321', 'Anticipos recibidos', 'Activo', 'Deudora', 1, 63, 4);
INSERT INTO cuenta VALUES (65, '133', 'Letras por cobrar', 'Activo', 'Deudora', 1, 57, 3);
INSERT INTO cuenta VALUES (66, '1331', 'En cartera', 'Activo', 'Deudora', 1, 65, 4);
INSERT INTO cuenta VALUES (67, '1332', 'En cobranza', 'Activo', 'Deudora', 1, 65, 4);
INSERT INTO cuenta VALUES (68, '1333', 'En descuento', 'Activo', 'Deudora', 1, 65, 4);
INSERT INTO cuenta VALUES (69, '14', 'CUENTAS POR COBRAR AL PERSONAL, A LOS ACCIONISTAS (SOCIOS) Y DIRECTORES', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (70, '141', 'Personal', 'Activo', 'Deudora', 1, 69, 3);
INSERT INTO cuenta VALUES (71, '1411', 'Préstamos', 'Activo', 'Deudora', 1, 70, 4);
INSERT INTO cuenta VALUES (72, '1412', 'Adelanto de remuneraciones', 'Activo', 'Deudora', 1, 70, 4);
INSERT INTO cuenta VALUES (73, '1413', 'Entregas a rendir cuenta', 'Activo', 'Deudora', 1, 70, 4);
INSERT INTO cuenta VALUES (74, '1419', 'Otras cuentas por cobrar al personal', 'Activo', 'Deudora', 1, 70, 4);
INSERT INTO cuenta VALUES (75, '142', 'Accionistas (o socios)', 'Activo', 'Deudora', 1, 69, 3);
INSERT INTO cuenta VALUES (76, '1421', 'Suscripciones por cobrar a socios o accionistas', 'Activo', 'Deudora', 1, 75, 4);
INSERT INTO cuenta VALUES (77, '1422', 'Préstamos', 'Activo', 'Deudora', 1, 75, 4);
INSERT INTO cuenta VALUES (78, '143', 'Directores', 'Activo', 'Deudora', 1, 69, 3);
INSERT INTO cuenta VALUES (79, '1431', 'Préstamos', 'Activo', 'Deudora', 1, 78, 4);
INSERT INTO cuenta VALUES (80, '16', 'CUENTAS POR COBRAR DIVERSAS – TERCEROS', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (81, '161', 'Préstamos', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (82, '1611', 'Con garantía', 'Activo', 'Deudora', 1, 81, 4);
INSERT INTO cuenta VALUES (83, '1612', 'Sin garantía', 'Activo', 'Deudora', 1, 81, 4);
INSERT INTO cuenta VALUES (84, '162', 'Reclamaciones a terceros', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (85, '1621', 'Compañías aseguradoras', 'Activo', 'Deudora', 1, 84, 4);
INSERT INTO cuenta VALUES (86, '1622', 'Transportadoras', 'Activo', 'Deudora', 1, 84, 4);
INSERT INTO cuenta VALUES (87, '1623', 'Servicios públicos', 'Activo', 'Deudora', 1, 84, 4);
INSERT INTO cuenta VALUES (88, '1624', 'Tributos', 'Activo', 'Deudora', 1, 84, 4);
INSERT INTO cuenta VALUES (89, '1629', 'Otras', 'Activo', 'Deudora', 1, 84, 4);
INSERT INTO cuenta VALUES (90, '163', 'Intereses, regalías y dividendos', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (91, '1631', 'Intereses', 'Activo', 'Deudora', 1, 90, 4);
INSERT INTO cuenta VALUES (92, '1632', 'Regalías', 'Activo', 'Deudora', 1, 90, 4);
INSERT INTO cuenta VALUES (93, '1633', 'Dividendos', 'Activo', 'Deudora', 1, 90, 4);
INSERT INTO cuenta VALUES (94, '164', 'Depósitos otorgados en garantía', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (95, '1641', 'Préstamos de instituciones financieras', 'Activo', 'Deudora', 1, 94, 4);
INSERT INTO cuenta VALUES (96, '1642', 'Préstamos de instituciones no financieras', 'Activo', 'Deudora', 1, 94, 4);
INSERT INTO cuenta VALUES (97, '1643', 'Depósitos en garantía por alquileres', 'Activo', 'Deudora', 1, 94, 4);
INSERT INTO cuenta VALUES (98, '1649', 'Otros depósitos en garantía', 'Activo', 'Deudora', 1, 94, 4);
INSERT INTO cuenta VALUES (99, '165', 'Venta de activo inmovilizado', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (100, '1651', 'Inversión mobiliaria', 'Activo', 'Deudora', 1, 99, 4);
INSERT INTO cuenta VALUES (101, '1652', 'Propiedades de inversión', 'Activo', 'Deudora', 1, 99, 4);
INSERT INTO cuenta VALUES (102, '1653', 'Propiedad, planta y equipo', 'Activo', 'Deudora', 1, 99, 4);
INSERT INTO cuenta VALUES (103, '1654', 'Intangibles', 'Activo', 'Deudora', 1, 99, 4);
INSERT INTO cuenta VALUES (104, '1655', 'Activos biológicos', 'Activo', 'Deudora', 1, 99, 4);
INSERT INTO cuenta VALUES (105, '1659', 'Otros activos inmovilizados', 'Activo', 'Deudora', 1, 99, 4);
INSERT INTO cuenta VALUES (106, '166', 'Activos por instrumentos financieros', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (107, '1661', 'Instrumentos financieros primarios', 'Activo', 'Deudora', 1, 106, 4);
INSERT INTO cuenta VALUES (108, '16611', 'Costo', 'Activo', 'Deudora', 1, 107, 5);
INSERT INTO cuenta VALUES (109, '16612', 'Valor razonable', 'Activo', 'Deudora', 1, 107, 5);
INSERT INTO cuenta VALUES (110, '1662', 'Instrumentos financieros derivados', 'Activo', 'Deudora', 1, 106, 4);
INSERT INTO cuenta VALUES (111, '16621', 'Costo', 'Activo', 'Deudora', 1, 110, 5);
INSERT INTO cuenta VALUES (112, '16622', 'Valor razonable', 'Activo', 'Deudora', 1, 110, 5);
INSERT INTO cuenta VALUES (113, '167', 'Tributos por acreditar', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (114, '1671', 'Pagos a cuenta del impuesto a la renta', 'Activo', 'Deudora', 1, 113, 4);
INSERT INTO cuenta VALUES (115, '1672', 'Pagos a cuenta de ITAN', 'Activo', 'Deudora', 1, 113, 4);
INSERT INTO cuenta VALUES (116, '1673', 'IGV por acreditar en compras', 'Activo', 'Deudora', 1, 113, 4);
INSERT INTO cuenta VALUES (117, '1674', 'IGV por acreditar no domiciliados', 'Activo', 'Deudora', 1, 113, 4);
INSERT INTO cuenta VALUES (118, '1675', 'Obras por impuestos', 'Activo', 'Deudora', 1, 113, 4);
INSERT INTO cuenta VALUES (119, '169', 'Otras cuentas por cobrar diversas', 'Activo', 'Deudora', 1, 80, 3);
INSERT INTO cuenta VALUES (120, '1691', 'Entregas a rendir cuenta a terceros', 'Activo', 'Deudora', 1, 119, 4);
INSERT INTO cuenta VALUES (121, '1699', 'Otras cuentas por cobrar diversas', 'Activo', 'Deudora', 1, 119, 4);
INSERT INTO cuenta VALUES (122, '17', 'CUENTAS POR COBRAR DIVERSAS – RELACIONADAS', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (123, '171', 'Préstamos', 'Activo', 'Deudora', 1, 122, 3);
INSERT INTO cuenta VALUES (124, '1711', 'Con garantía', 'Activo', 'Deudora', 1, 123, 4);
INSERT INTO cuenta VALUES (125, '1712', 'Sin garantía', 'Activo', 'Deudora', 1, 123, 4);
INSERT INTO cuenta VALUES (126, '173', 'Intereses, regalías y dividendos', 'Activo', 'Deudora', 1, 122, 3);
INSERT INTO cuenta VALUES (127, '1731', 'Intereses', 'Activo', 'Deudora', 1, 126, 4);
INSERT INTO cuenta VALUES (128, '1732', 'Regalías', 'Activo', 'Deudora', 1, 126, 4);
INSERT INTO cuenta VALUES (129, '1733', 'Dividendos', 'Activo', 'Deudora', 1, 126, 4);
INSERT INTO cuenta VALUES (130, '174', 'Depósitos otorgados en garantía', 'Activo', 'Deudora', 1, 122, 3);
INSERT INTO cuenta VALUES (131, '1741', 'Préstamos de instituciones financieras', 'Activo', 'Deudora', 1, 130, 4);
INSERT INTO cuenta VALUES (132, '1742', 'Préstamos de instituciones no financieras', 'Activo', 'Deudora', 1, 130, 4);
INSERT INTO cuenta VALUES (133, '1743', 'Depósitos en garantía por alquileres', 'Activo', 'Deudora', 1, 130, 4);
INSERT INTO cuenta VALUES (134, '1749', 'Otros depósitos en garantía', 'Activo', 'Deudora', 1, 130, 4);
INSERT INTO cuenta VALUES (135, '175', 'Venta de activo inmovilizado', 'Activo', 'Deudora', 1, 122, 3);
INSERT INTO cuenta VALUES (136, '1751', 'Inversión mobiliaria', 'Activo', 'Deudora', 1, 135, 4);
INSERT INTO cuenta VALUES (137, '1752', 'Propiedades de inversión', 'Activo', 'Deudora', 1, 135, 4);
INSERT INTO cuenta VALUES (138, '1753', 'Propiedad, planta y equipo', 'Activo', 'Deudora', 1, 135, 4);
INSERT INTO cuenta VALUES (139, '1754', 'Intangibles', 'Activo', 'Deudora', 1, 135, 4);
INSERT INTO cuenta VALUES (140, '1755', 'Activos biológicos', 'Activo', 'Deudora', 1, 135, 4);
INSERT INTO cuenta VALUES (141, '1759', 'Otros activos inmovilizados', 'Activo', 'Deudora', 1, 135, 4);
INSERT INTO cuenta VALUES (142, '176', 'Activos por instrumentos financieros', 'Activo', 'Deudora', 1, 122, 3);
INSERT INTO cuenta VALUES (143, '1761', 'Instrumentos financieros primarios', 'Activo', 'Deudora', 1, 142, 4);
INSERT INTO cuenta VALUES (144, '17611', 'Costo', 'Activo', 'Deudora', 1, 143, 5);
INSERT INTO cuenta VALUES (145, '17612', 'Valor razonable', 'Activo', 'Deudora', 1, 143, 5);
INSERT INTO cuenta VALUES (146, '1762', 'Instrumentos financieros derivados', 'Activo', 'Deudora', 1, 142, 4);
INSERT INTO cuenta VALUES (147, '17621', 'Costo', 'Activo', 'Deudora', 1, 146, 5);
INSERT INTO cuenta VALUES (148, '17622', 'Valor razonable', 'Activo', 'Deudora', 1, 146, 5);
INSERT INTO cuenta VALUES (149, '179', 'Otras cuentas por cobrar diversas', 'Activo', 'Deudora', 1, 122, 3);
INSERT INTO cuenta VALUES (150, '18', 'SERVICIOS Y OTROS CONTRATADOS POR ANTICIPADO', 'Activo', 'Deudora', 1, 1, 2);
INSERT INTO cuenta VALUES (151, '181', 'Costos financieros', 'Activo', 'Deudora', 1, 150, 3);
INSERT INTO cuenta VALUES (152, '182', 'Seguros', 'Activo', 'Deudora', 1, 150, 3);
INSERT INTO cuenta VALUES (153, '183', 'Alquileres', 'Activo', 'Deudora', 1, 150, 3);
INSERT INTO cuenta VALUES (154, '184', 'Primas pagadas por opciones', 'Activo', 'Deudora', 1, 150, 3);
INSERT INTO cuenta VALUES (155, '185', 'Mantenimiento de activos inmovilizados', 'Activo', 'Deudora', 1, 150, 3);
INSERT INTO cuenta VALUES (156, '189', 'Otros gastos contratados por anticipado', 'Activo', 'Deudora', 1, 150, 3);
INSERT INTO cuenta VALUES (157, '19', 'ESTIMACIÓN DE CUENTAS DE COBRANZA DUDOSA', 'Activo', 'Acreedora', 1, 1, 2);
INSERT INTO cuenta VALUES (158, '191', 'Cuentas por cobrar comerciales – Terceros', 'Activo', 'Acreedora', 1, 157, 3);
INSERT INTO cuenta VALUES (159, '1911', 'Facturas, boletas y otros comprobantes por cobrar', 'Activo', 'Acreedora', 1, 158, 4);
INSERT INTO cuenta VALUES (160, '1913', 'Letras por cobrar', 'Activo', 'Acreedora', 1, 158, 4);
INSERT INTO cuenta VALUES (161, '192', 'Cuentas por cobrar comerciales – Relacionadas', 'Activo', 'Acreedora', 1, 157, 3);
INSERT INTO cuenta VALUES (162, '1921', 'Facturas, boletas y otros comprobantes por cobrar', 'Activo', 'Acreedora', 1, 161, 4);
INSERT INTO cuenta VALUES (163, '1923', 'Letras por cobrar', 'Activo', 'Acreedora', 1, 161, 4);
INSERT INTO cuenta VALUES (164, '193', 'Cuentas por cobrar al personal, a los accionistas (socios) y directores', 'Activo', 'Acreedora', 1, 157, 3);
INSERT INTO cuenta VALUES (165, '2', 'ACTIVO REALIZABLE', 'Activo', 'Deudora', 1, None, 1);
INSERT INTO cuenta VALUES (166, '20', 'MERCADERÍAS', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (167, '201', 'Mercaderías', 'Activo', 'Deudora', 1, 166, 3);
INSERT INTO cuenta VALUES (168, '2011', 'Mercaderías', 'Activo', 'Deudora', 1, 167, 4);
INSERT INTO cuenta VALUES (169, '20111', 'Costo', 'Activo', 'Deudora', 1, 168, 5);
INSERT INTO cuenta VALUES (170, '20114', 'Valor razonable', 'Activo', 'Deudora', 1, 168, 5);
INSERT INTO cuenta VALUES (171, '21', 'PRODUCTOS TERMINADOS', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (172, '211', 'Productos terminados', 'Activo', 'Deudora', 1, 171, 3);
INSERT INTO cuenta VALUES (173, '2111', 'Productos terminados', 'Activo', 'Deudora', 1, 172, 4);
INSERT INTO cuenta VALUES (174, '21111', 'Costo', 'Activo', 'Deudora', 1, 173, 5);
INSERT INTO cuenta VALUES (175, '21113', 'Costo de financiación', 'Activo', 'Deudora', 1, 173, 5);
INSERT INTO cuenta VALUES (176, '21114', 'Valor razonable', 'Activo', 'Deudora', 1, 173, 5);
INSERT INTO cuenta VALUES (177, '215', 'Inventario de servicios terminados', 'Activo', 'Deudora', 1, 171, 3);
INSERT INTO cuenta VALUES (178, '2151', 'Servicios terminados', 'Activo', 'Deudora', 1, 177, 4);
INSERT INTO cuenta VALUES (179, '21511', 'Costo', 'Activo', 'Deudora', 1, 178, 5);
INSERT INTO cuenta VALUES (180, '22', 'SUBPRODUCTOS, DESECHOS Y DESPERDICIOS', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (181, '221', 'Subproductos', 'Activo', 'Deudora', 1, 180, 3);
INSERT INTO cuenta VALUES (182, '222', 'Desechos y desperdicios', 'Activo', 'Deudora', 1, 180, 3);
INSERT INTO cuenta VALUES (183, '23', 'PRODUCTOS EN PROCESO', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (184, '231', 'Productos en proceso', 'Activo', 'Deudora', 1, 183, 3);
INSERT INTO cuenta VALUES (185, '2311', 'Productos en proceso', 'Activo', 'Deudora', 1, 184, 4);
INSERT INTO cuenta VALUES (186, '23111', 'Costo', 'Activo', 'Deudora', 1, 185, 5);
INSERT INTO cuenta VALUES (187, '23113', 'Costo de financiación', 'Activo', 'Deudora', 1, 185, 5);
INSERT INTO cuenta VALUES (188, '235', 'Inventario de servicios en proceso', 'Activo', 'Deudora', 1, 183, 3);
INSERT INTO cuenta VALUES (189, '2351', 'Servicios en proceso', 'Activo', 'Deudora', 1, 188, 4);
INSERT INTO cuenta VALUES (190, '23511', 'Costo', 'Activo', 'Deudora', 1, 189, 5);
INSERT INTO cuenta VALUES (191, '24', 'MATERIAS PRIMAS', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (192, '241', 'Materias primas', 'Activo', 'Deudora', 1, 191, 3);
INSERT INTO cuenta VALUES (193, '2411', 'Materias primas', 'Activo', 'Deudora', 1, 192, 4);
INSERT INTO cuenta VALUES (194, '24111', 'Costo', 'Activo', 'Deudora', 1, 193, 5);
INSERT INTO cuenta VALUES (195, '24114', 'Valor razonable', 'Activo', 'Deudora', 1, 193, 5);
INSERT INTO cuenta VALUES (196, '25', 'MATERIALES AUXILIARES, SUMINISTROS Y REPUESTOS', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (197, '251', 'Materiales auxiliares', 'Activo', 'Deudora', 1, 196, 3);
INSERT INTO cuenta VALUES (198, '252', 'Suministros', 'Activo', 'Deudora', 1, 196, 3);
INSERT INTO cuenta VALUES (199, '2521', 'Combustibles', 'Activo', 'Deudora', 1, 198, 4);
INSERT INTO cuenta VALUES (200, '2522', 'Lubricantes', 'Activo', 'Deudora', 1, 198, 4);
INSERT INTO cuenta VALUES (201, '2523', 'Energía', 'Activo', 'Deudora', 1, 198, 4);
INSERT INTO cuenta VALUES (202, '2524', 'Otros suministros', 'Activo', 'Deudora', 1, 198, 4);
INSERT INTO cuenta VALUES (203, '253', 'Repuestos', 'Activo', 'Deudora', 1, 196, 3);
INSERT INTO cuenta VALUES (204, '26', 'ENVASES Y EMBALAJES', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (205, '261', 'Envases', 'Activo', 'Deudora', 1, 204, 3);
INSERT INTO cuenta VALUES (206, '262', 'Embalajes', 'Activo', 'Deudora', 1, 204, 3);
INSERT INTO cuenta VALUES (207, '27', 'ACTIVOS NO CORRIENTES MANTENIDOS PARA LA VENTA', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (211, '271', 'Propiedades de inversión', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (212, '2711', 'Terrenos', 'Activo', 'Deudora', 1, 211, 4);
INSERT INTO cuenta VALUES (213, '27111', 'Costo', 'Activo', 'Deudora', 1, 212, 5);
INSERT INTO cuenta VALUES (214, '27112', 'Revaluación', 'Activo', 'Deudora', 1, 212, 5);
INSERT INTO cuenta VALUES (215, '27114', 'Valor razonable', 'Activo', 'Deudora', 1, 212, 5);
INSERT INTO cuenta VALUES (216, '2712', 'Edificaciones', 'Activo', 'Deudora', 1, 211, 4);
INSERT INTO cuenta VALUES (217, '27121', 'Costo', 'Activo', 'Deudora', 1, 216, 5);
INSERT INTO cuenta VALUES (218, '27122', 'Revaluación', 'Activo', 'Deudora', 1, 216, 5);
INSERT INTO cuenta VALUES (219, '27123', 'Costos de financiación', 'Activo', 'Deudora', 1, 216, 5);
INSERT INTO cuenta VALUES (220, '27124', 'Valor razonable', 'Activo', 'Deudora', 1, 216, 5);
INSERT INTO cuenta VALUES (221, '272', 'Propiedad, planta y equipo', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (222, '2720', 'Planta productora en producción', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (223, '27201', 'Costo', 'Activo', 'Deudora', 1, 222, 5);
INSERT INTO cuenta VALUES (224, '27202', 'Revaluación', 'Activo', 'Deudora', 1, 222, 5);
INSERT INTO cuenta VALUES (225, '27203', 'Costo de financiación', 'Activo', 'Deudora', 1, 222, 5);
INSERT INTO cuenta VALUES (226, '27204', 'Valor razonable', 'Activo', 'Deudora', 1, 222, 5);
INSERT INTO cuenta VALUES (227, '2721', 'Planta productora en desarrollo', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (228, '27211', 'Costo', 'Activo', 'Deudora', 1, 227, 5);
INSERT INTO cuenta VALUES (229, '27212', 'Revaluación', 'Activo', 'Deudora', 1, 227, 5);
INSERT INTO cuenta VALUES (230, '27213', 'Costo de financiación', 'Activo', 'Deudora', 1, 227, 5);
INSERT INTO cuenta VALUES (231, '27214', 'Valor razonable', 'Activo', 'Deudora', 1, 227, 5);
INSERT INTO cuenta VALUES (232, '2722', 'Terrenos', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (233, '27221', 'Costo', 'Activo', 'Deudora', 1, 232, 5);
INSERT INTO cuenta VALUES (234, '27222', 'Revaluación', 'Activo', 'Deudora', 1, 232, 5);
INSERT INTO cuenta VALUES (235, '2723', 'Edificaciones', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (236, '27231', 'Costo', 'Activo', 'Deudora', 1, 235, 5);
INSERT INTO cuenta VALUES (237, '27232', 'Revaluación', 'Activo', 'Deudora', 1, 235, 5);
INSERT INTO cuenta VALUES (238, '27233', 'Costo de financiación', 'Activo', 'Deudora', 1, 235, 5);
INSERT INTO cuenta VALUES (239, '2724', 'Maquinarias y equipos de explotación', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (240, '27241', 'Costo', 'Activo', 'Deudora', 1, 239, 5);
INSERT INTO cuenta VALUES (241, '27242', 'Revaluación', 'Activo', 'Deudora', 1, 239, 5);
INSERT INTO cuenta VALUES (242, '27243', 'Costo de financiación', 'Activo', 'Deudora', 1, 239, 5);
INSERT INTO cuenta VALUES (243, '2725', 'Unidades de transporte', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (244, '27251', 'Costo', 'Activo', 'Deudora', 1, 243, 5);
INSERT INTO cuenta VALUES (245, '27252', 'Revaluación', 'Activo', 'Deudora', 1, 243, 5);
INSERT INTO cuenta VALUES (246, '2726', 'Muebles y enseres', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (247, '27261', 'Costo', 'Activo', 'Deudora', 1, 246, 5);
INSERT INTO cuenta VALUES (248, '27262', 'Revaluación', 'Activo', 'Deudora', 1, 246, 5);
INSERT INTO cuenta VALUES (249, '2727', 'Equipos diversos', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (250, '27271', 'Costo', 'Activo', 'Deudora', 1, 249, 5);
INSERT INTO cuenta VALUES (251, '27272', 'Revaluación', 'Activo', 'Deudora', 1, 249, 5);
INSERT INTO cuenta VALUES (252, '2728', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (253, '27281', 'Costo', 'Activo', 'Deudora', 1, 252, 5);
INSERT INTO cuenta VALUES (254, '27282', 'Revaluación', 'Activo', 'Deudora', 1, 252, 5);
INSERT INTO cuenta VALUES (255, '2729', 'Obras en curso', 'Activo', 'Deudora', 1, 221, 4);
INSERT INTO cuenta VALUES (256, '27291', 'Costo', 'Activo', 'Deudora', 1, 255, 5);
INSERT INTO cuenta VALUES (257, '27292', 'Revaluación', 'Activo', 'Deudora', 1, 255, 5);
INSERT INTO cuenta VALUES (258, '273', 'Intangibles', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (259, '2731', 'Concesiones, licencias y derechos', 'Activo', 'Deudora', 1, 258, 4);
INSERT INTO cuenta VALUES (260, '27311', 'Costo', 'Activo', 'Deudora', 1, 259, 5);
INSERT INTO cuenta VALUES (261, '27312', 'Revaluación', 'Activo', 'Deudora', 1, 259, 5);
INSERT INTO cuenta VALUES (262, '2732', 'Patentes y propiedad industrial', 'Activo', 'Deudora', 1, 258, 4);
INSERT INTO cuenta VALUES (263, '27321', 'Costo', 'Activo', 'Deudora', 1, 262, 5);
INSERT INTO cuenta VALUES (264, '27322', 'Revaluación', 'Activo', 'Deudora', 1, 262, 5);
INSERT INTO cuenta VALUES (265, '2733', 'Programas de computadora (software)', 'Activo', 'Deudora', 1, 258, 4);
INSERT INTO cuenta VALUES (266, '27331', 'Costo', 'Activo', 'Deudora', 1, 265, 5);
INSERT INTO cuenta VALUES (267, '27332', 'Revaluación', 'Activo', 'Deudora', 1, 265, 5);
INSERT INTO cuenta VALUES (268, '2734', 'Costos de exploración y desarrollo', 'Activo', 'Deudora', 1, 258, 4);
INSERT INTO cuenta VALUES (269, '27341', 'Costo', 'Activo', 'Deudora', 1, 268, 5);
INSERT INTO cuenta VALUES (270, '27342', 'Revaluación', 'Activo', 'Deudora', 1, 268, 5);
INSERT INTO cuenta VALUES (271, '2735', 'Fórmulas, diseños y prototipos', 'Activo', 'Deudora', 1, 258, 4);
INSERT INTO cuenta VALUES (272, '27351', 'Costo', 'Activo', 'Deudora', 1, 271, 5);
INSERT INTO cuenta VALUES (273, '27352', 'Revaluación', 'Activo', 'Deudora', 1, 271, 5);
INSERT INTO cuenta VALUES (274, '2739', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 258, 4);
INSERT INTO cuenta VALUES (275, '27391', 'Costo', 'Activo', 'Deudora', 1, 274, 5);
INSERT INTO cuenta VALUES (276, '27392', 'Revaluación', 'Activo', 'Deudora', 1, 274, 5);
INSERT INTO cuenta VALUES (277, '274', 'Activos biológicos', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (278, '2741', 'Activos biológicos en producción', 'Activo', 'Deudora', 1, 277, 4);
INSERT INTO cuenta VALUES (279, '27411', 'Costo', 'Activo', 'Deudora', 1, 278, 5);
INSERT INTO cuenta VALUES (280, '27413', 'Costos de financiación', 'Activo', 'Deudora', 1, 278, 5);
INSERT INTO cuenta VALUES (281, '27414', 'Valor razonable', 'Activo', 'Deudora', 1, 278, 5);
INSERT INTO cuenta VALUES (282, '2742', 'Activos biológicos en desarrollo', 'Activo', 'Deudora', 1, 277, 4);
INSERT INTO cuenta VALUES (283, '27421', 'Costo', 'Activo', 'Deudora', 1, 282, 5);
INSERT INTO cuenta VALUES (284, '27423', 'Costos de financiación', 'Activo', 'Deudora', 1, 282, 5);
INSERT INTO cuenta VALUES (285, '27424', 'Valor razonable', 'Activo', 'Deudora', 1, 282, 5);
INSERT INTO cuenta VALUES (286, '275', 'Depreciación acumulada – Propiedades de inversión', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (287, '2752', 'Edificaciones', 'Activo', 'Deudora', 1, 286, 4);
INSERT INTO cuenta VALUES (288, '27521', 'Costo', 'Activo', 'Deudora', 1, 287, 5);
INSERT INTO cuenta VALUES (289, '27522', 'Revaluación', 'Activo', 'Deudora', 1, 287, 5);
INSERT INTO cuenta VALUES (290, '27523', 'Costo de financiación', 'Activo', 'Deudora', 1, 287, 5);
INSERT INTO cuenta VALUES (291, '276', 'Depreciación acumulada – Propiedad, planta y equipo', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (292, '2760', 'Planta productora en producción', 'Activo', 'Deudora', 1, 291, 4);
INSERT INTO cuenta VALUES (293, '27601', 'Costo', 'Activo', 'Deudora', 1, 292, 5);
INSERT INTO cuenta VALUES (294, '27602', 'Revaluación', 'Activo', 'Deudora', 1, 292, 5);
INSERT INTO cuenta VALUES (295, '27603', 'Costo de financiación', 'Activo', 'Deudora', 1, 292, 5);
INSERT INTO cuenta VALUES (296, '27604', 'Valor razonable', 'Activo', 'Deudora', 1, 292, 5);
INSERT INTO cuenta VALUES (297, '2762', 'Edificaciones', 'Activo', 'Deudora', 1, 291, 4);
INSERT INTO cuenta VALUES (298, '27621', 'Costo', 'Activo', 'Deudora', 1, 297, 5);
INSERT INTO cuenta VALUES (299, '27622', 'Revaluación', 'Activo', 'Deudora', 1, 297, 5);
INSERT INTO cuenta VALUES (300, '27623', 'Costo de financiación', 'Activo', 'Deudora', 1, 297, 5);
INSERT INTO cuenta VALUES (301, '2763', 'Maquinarias y equipo de explotación', 'Activo', 'Deudora', 1, 291, 4);
INSERT INTO cuenta VALUES (302, '27631', 'Costo', 'Activo', 'Deudora', 1, 301, 5);
INSERT INTO cuenta VALUES (303, '27632', 'Revaluación', 'Activo', 'Deudora', 1, 301, 5);
INSERT INTO cuenta VALUES (304, '27633', 'Costo de financiación', 'Activo', 'Deudora', 1, 301, 5);
INSERT INTO cuenta VALUES (305, '2764', 'Unidades de transporte', 'Activo', 'Deudora', 1, 291, 4);
INSERT INTO cuenta VALUES (306, '27641', 'Costo', 'Activo', 'Deudora', 1, 305, 5);
INSERT INTO cuenta VALUES (307, '27642', 'Revaluación', 'Activo', 'Deudora', 1, 305, 5);
INSERT INTO cuenta VALUES (308, '2765', 'Muebles y enseres', 'Activo', 'Deudora', 1, 291, 4);
INSERT INTO cuenta VALUES (309, '27651', 'Costo', 'Activo', 'Deudora', 1, 308, 5);
INSERT INTO cuenta VALUES (310, '27652', 'Revaluación', 'Activo', 'Deudora', 1, 308, 5);
INSERT INTO cuenta VALUES (311, '2766', 'Equipos diversos', 'Activo', 'Deudora', 1, 291, 4);
INSERT INTO cuenta VALUES (312, '27661', 'Costo', 'Activo', 'Deudora', 1, 311, 5);
INSERT INTO cuenta VALUES (313, '27662', 'Revaluación', 'Activo', 'Deudora', 1, 311, 5);
INSERT INTO cuenta VALUES (314, '2767', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 291, 4);
INSERT INTO cuenta VALUES (315, '27671', 'Costo', 'Activo', 'Deudora', 1, 314, 5);
INSERT INTO cuenta VALUES (316, '27672', 'Revaluación', 'Activo', 'Deudora', 1, 314, 5);
INSERT INTO cuenta VALUES (317, '277', 'Amortización acumulada – Intangibles', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (318, '2771', 'Concesiones, licencias y derechos', 'Activo', 'Deudora', 1, 317, 4);
INSERT INTO cuenta VALUES (319, '27711', 'Costo', 'Activo', 'Deudora', 1, 318, 5);
INSERT INTO cuenta VALUES (320, '27712', 'Revaluación', 'Activo', 'Deudora', 1, 318, 5);
INSERT INTO cuenta VALUES (321, '2772', 'Patentes y propiedad industrial', 'Activo', 'Deudora', 1, 317, 4);
INSERT INTO cuenta VALUES (322, '27721', 'Costo', 'Activo', 'Deudora', 1, 321, 5);
INSERT INTO cuenta VALUES (323, '27722', 'Revaluación', 'Activo', 'Deudora', 1, 321, 5);
INSERT INTO cuenta VALUES (324, '2773', 'Programas de computadora (software)', 'Activo', 'Deudora', 1, 317, 4);
INSERT INTO cuenta VALUES (325, '27731', 'Costo', 'Activo', 'Deudora', 1, 324, 5);
INSERT INTO cuenta VALUES (326, '27732', 'Revaluación', 'Activo', 'Deudora', 1, 324, 5);
INSERT INTO cuenta VALUES (327, '2774', 'Costos de exploración y desarrollo', 'Activo', 'Deudora', 1, 317, 4);
INSERT INTO cuenta VALUES (328, '27741', 'Costo', 'Activo', 'Deudora', 1, 327, 5);
INSERT INTO cuenta VALUES (329, '27742', 'Revaluación', 'Activo', 'Deudora', 1, 327, 5);
INSERT INTO cuenta VALUES (330, '2775', 'Fórmulas, diseños y prototipos', 'Activo', 'Deudora', 1, 317, 4);
INSERT INTO cuenta VALUES (331, '27751', 'Costo', 'Activo', 'Deudora', 1, 330, 5);
INSERT INTO cuenta VALUES (332, '27752', 'Revaluación', 'Activo', 'Deudora', 1, 330, 5);
INSERT INTO cuenta VALUES (333, '2779', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 317, 4);
INSERT INTO cuenta VALUES (334, '27791', 'Costo', 'Activo', 'Deudora', 1, 333, 5);
INSERT INTO cuenta VALUES (335, '27792', 'Revaluación', 'Activo', 'Deudora', 1, 333, 5);
INSERT INTO cuenta VALUES (336, '278', 'Depreciación acumulada – Activos biológicos', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (337, '2781', 'Activos biológicos en producción', 'Activo', 'Deudora', 1, 336, 4);
INSERT INTO cuenta VALUES (338, '27811', 'Costo', 'Activo', 'Deudora', 1, 337, 5);
INSERT INTO cuenta VALUES (339, '27813', 'Costo de financiación', 'Activo', 'Deudora', 1, 337, 5);
INSERT INTO cuenta VALUES (340, '2782', 'Activos biológicos en desarrollo', 'Activo', 'Deudora', 1, 336, 4);
INSERT INTO cuenta VALUES (341, '27821', 'Costo', 'Activo', 'Deudora', 1, 340, 5);
INSERT INTO cuenta VALUES (342, '27823', 'Costo de financiación', 'Activo', 'Deudora', 1, 340, 5);
INSERT INTO cuenta VALUES (343, '279', 'Desvalorización acumulada', 'Activo', 'Deudora', 1, 207, 3);
INSERT INTO cuenta VALUES (344, '2791', 'Propiedad de inversión', 'Activo', 'Deudora', 1, 343, 4);
INSERT INTO cuenta VALUES (345, '27910', 'Planta productora en producción', 'Activo', 'Deudora', 1, 344, 5);
INSERT INTO cuenta VALUES (346, '27911', 'Planta productora en desarrollo', 'Activo', 'Deudora', 1, 344, 5);
INSERT INTO cuenta VALUES (347, '27912', 'Terrenos', 'Activo', 'Deudora', 1, 344, 5);
INSERT INTO cuenta VALUES (348, '27913', 'Edificaciones', 'Activo', 'Deudora', 1, 344, 5);
INSERT INTO cuenta VALUES (349, '2793', 'Propiedad, planta y equipo', 'Activo', 'Deudora', 1, 343, 4);
INSERT INTO cuenta VALUES (350, '27930', 'Plantas productoras en producción', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (351, '27931', 'Planta productora en desarrollo', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (352, '27932', 'Terrenos', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (353, '27933', 'Edificaciones', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (354, '27934', 'Maquinarias y equipos de explotación', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (355, '27935', 'Unidades de transporte', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (356, '27936', 'Muebles y enseres', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (357, '27937', 'Equipos diversos', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (358, '27938', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 349, 5);
INSERT INTO cuenta VALUES (359, '2794', 'Intangibles', 'Activo', 'Deudora', 1, 343, 4);
INSERT INTO cuenta VALUES (360, '27941', 'Concesiones, licencias y otros derechos', 'Activo', 'Deudora', 1, 359, 5);
INSERT INTO cuenta VALUES (361, '27942', 'Patentes y propiedad industrial', 'Activo', 'Deudora', 1, 359, 5);
INSERT INTO cuenta VALUES (362, '27943', 'Programas de computadora (software)', 'Activo', 'Deudora', 1, 359, 5);
INSERT INTO cuenta VALUES (363, '27944', 'Costos de exploración y desarrollo', 'Activo', 'Deudora', 1, 359, 5);
INSERT INTO cuenta VALUES (364, '27945', 'Fórmulas, diseños y prototipos', 'Activo', 'Deudora', 1, 359, 5);
INSERT INTO cuenta VALUES (365, '27949', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 359, 5);
INSERT INTO cuenta VALUES (366, '2795', 'Activos biológicos', 'Activo', 'Deudora', 1, 343, 4);
INSERT INTO cuenta VALUES (367, '27951', 'Activos biológicos en producción', 'Activo', 'Deudora', 1, 366, 5);
INSERT INTO cuenta VALUES (368, '27952', 'Activos biológicos en desarrollo', 'Activo', 'Deudora', 1, 366, 5);
INSERT INTO cuenta VALUES (369, '28', 'INVENTARIOS POR RECIBIR', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (370, '281', 'Mercaderías', 'Activo', 'Deudora', 1, 369, 3);
INSERT INTO cuenta VALUES (371, '284', 'Materias primas', 'Activo', 'Deudora', 1, 369, 3);
INSERT INTO cuenta VALUES (372, '285', 'Materiales auxiliares, suministros y repuestos', 'Activo', 'Deudora', 1, 369, 3);
INSERT INTO cuenta VALUES (373, '286', 'Envases y embalajes', 'Activo', 'Deudora', 1, 369, 3);
INSERT INTO cuenta VALUES (374, '29', 'DESVALORIZACIÓN DE INVENTARIOS', 'Activo', 'Deudora', 1, 165, 2);
INSERT INTO cuenta VALUES (375, '291', 'Mercaderías', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (376, '2911', 'Mercaderías', 'Activo', 'Deudora', 1, 375, 4);
INSERT INTO cuenta VALUES (377, '29111', 'Costo', 'Activo', 'Deudora', 1, 376, 5);
INSERT INTO cuenta VALUES (378, '292', 'Productos terminados', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (379, '2921', 'Productos terminados', 'Activo', 'Deudora', 1, 378, 4);
INSERT INTO cuenta VALUES (380, '29211', 'Costo', 'Activo', 'Deudora', 1, 379, 5);
INSERT INTO cuenta VALUES (381, '29213', 'Costo de financiación', 'Activo', 'Deudora', 1, 379, 5);
INSERT INTO cuenta VALUES (382, '2925', 'Inventario de servicios terminados', 'Activo', 'Deudora', 1, 378, 4);
INSERT INTO cuenta VALUES (388, '29251', 'Costo', 'Activo', 'Deudora', 1, 382, 5);
INSERT INTO cuenta VALUES (389, '293', 'Subproductos, desechos y desperdicios', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (390, '2931', 'Subproductos', 'Activo', 'Deudora', 1, 389, 4);
INSERT INTO cuenta VALUES (391, '2932', 'Desechos y desperdicios', 'Activo', 'Deudora', 1, 389, 4);
INSERT INTO cuenta VALUES (392, '294', 'Productos en proceso', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (393, '2941', 'Productos en proceso', 'Activo', 'Deudora', 1, 392, 4);
INSERT INTO cuenta VALUES (394, '29411', 'Costo', 'Activo', 'Deudora', 1, 393, 5);
INSERT INTO cuenta VALUES (395, '29413', 'Costo de financiación', 'Activo', 'Deudora', 1, 393, 5);
INSERT INTO cuenta VALUES (396, '2945', 'Inventario de servicios en proceso', 'Activo', 'Deudora', 1, 392, 4);
INSERT INTO cuenta VALUES (397, '295', 'Materias primas', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (398, '2951', 'Materias primas', 'Activo', 'Deudora', 1, 397, 4);
INSERT INTO cuenta VALUES (399, '29511', 'Costo', 'Activo', 'Deudora', 1, 398, 5);
INSERT INTO cuenta VALUES (400, '296', 'Materiales auxiliares, suministros y repuestos', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (401, '2961', 'Materiales auxiliares', 'Activo', 'Deudora', 1, 400, 4);
INSERT INTO cuenta VALUES (402, '2962', 'Suministros', 'Activo', 'Deudora', 1, 400, 4);
INSERT INTO cuenta VALUES (403, '2963', 'Repuestos', 'Activo', 'Deudora', 1, 400, 4);
INSERT INTO cuenta VALUES (404, '297', 'Envases y embalajes', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (405, '2971', 'Envases', 'Activo', 'Deudora', 1, 404, 4);
INSERT INTO cuenta VALUES (406, '2972', 'Embalajes', 'Activo', 'Deudora', 1, 404, 4);
INSERT INTO cuenta VALUES (407, '298', 'Existencias por recibir', 'Activo', 'Deudora', 1, 374, 3);
INSERT INTO cuenta VALUES (408, '2981', 'Mercaderías', 'Activo', 'Deudora', 1, 407, 4);
INSERT INTO cuenta VALUES (409, '2982', 'Materias primas', 'Activo', 'Deudora', 1, 407, 4);
INSERT INTO cuenta VALUES (410, '2983', 'Materiales auxiliares, suministros y repuestos', 'Activo', 'Deudora', 1, 407, 4);
INSERT INTO cuenta VALUES (411, '2984', 'Envases y embalajes', 'Activo', 'Deudora', 1, 407, 4);
INSERT INTO cuenta VALUES (412, '3', 'ACTIVO INMOVILIZADO', 'Activo', 'Deudora', 1, None, 1);
INSERT INTO cuenta VALUES (413, '30', 'INVERSIONES MOBILIARIAS', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (414, '301', 'Inversiones a ser mantenidas hasta el vencimiento', 'Activo', 'Deudora', 1, 413, 3);
INSERT INTO cuenta VALUES (415, '3011', 'Instrumentos financieros representativos de deuda', 'Activo', 'Deudora', 1, 414, 4);
INSERT INTO cuenta VALUES (416, '30111', 'Costo', 'Activo', 'Deudora', 1, 415, 5);
INSERT INTO cuenta VALUES (417, '30114', 'Valor razonable', 'Activo', 'Deudora', 1, 415, 5);
INSERT INTO cuenta VALUES (418, '302', 'Instrumentos financieros representativos de derecho patrimonial', 'Activo', 'Deudora', 1, 413, 3);
INSERT INTO cuenta VALUES (419, '3021', 'Certificados de suscripción preferente', 'Activo', 'Deudora', 1, 418, 4);
INSERT INTO cuenta VALUES (420, '3022', 'Acciones representativas de capital social – Comunes', 'Activo', 'Deudora', 1, 418, 4);
INSERT INTO cuenta VALUES (421, '30221', 'Costo', 'Activo', 'Deudora', 1, 420, 5);
INSERT INTO cuenta VALUES (422, '30224', 'Valor razonable', 'Activo', 'Deudora', 1, 420, 5);
INSERT INTO cuenta VALUES (423, '30225', 'Participación patrimonial', 'Activo', 'Deudora', 1, 420, 5);
INSERT INTO cuenta VALUES (424, '3023', 'Acciones representativas de capital social – Preferentes', 'Activo', 'Deudora', 1, 418, 4);
INSERT INTO cuenta VALUES (425, '30231', 'Costo', 'Activo', 'Deudora', 1, 424, 5);
INSERT INTO cuenta VALUES (426, '30234', 'Valor razonable', 'Activo', 'Deudora', 1, 424, 5);
INSERT INTO cuenta VALUES (427, '30235', 'Participación patrimonial', 'Activo', 'Deudora', 1, 424, 5);
INSERT INTO cuenta VALUES (428, '3024', 'Acciones de inversión', 'Activo', 'Deudora', 1, 418, 4);
INSERT INTO cuenta VALUES (429, '30241', 'Costo', 'Activo', 'Deudora', 1, 428, 5);
INSERT INTO cuenta VALUES (430, '30244', 'Valor razonable', 'Activo', 'Deudora', 1, 428, 5);
INSERT INTO cuenta VALUES (431, '30245', 'Participación patrimonial', 'Activo', 'Deudora', 1, 428, 5);
INSERT INTO cuenta VALUES (432, '3028', 'Otros títulos representativos de patrimonio', 'Activo', 'Deudora', 1, 418, 4);
INSERT INTO cuenta VALUES (433, '30281', 'Costo', 'Activo', 'Deudora', 1, 432, 5);
INSERT INTO cuenta VALUES (434, '30284', 'Valor razonable', 'Activo', 'Deudora', 1, 432, 5);
INSERT INTO cuenta VALUES (435, '30285', 'Participación patrimonial', 'Activo', 'Deudora', 1, 432, 5);
INSERT INTO cuenta VALUES (436, '303', 'Certificados de participación en fondos – Cuotas', 'Activo', 'Deudora', 1, 413, 3);
INSERT INTO cuenta VALUES (437, '3031', 'Fondos de inversión', 'Activo', 'Deudora', 1, 436, 4);
INSERT INTO cuenta VALUES (438, '30311', 'Costo', 'Activo', 'Deudora', 1, 437, 5);
INSERT INTO cuenta VALUES (439, '30314', 'Valor razonable', 'Activo', 'Deudora', 1, 437, 5);
INSERT INTO cuenta VALUES (440, '3032', 'Fondos mutuos', 'Activo', 'Deudora', 1, 436, 4);
INSERT INTO cuenta VALUES (441, '30321', 'Costo', 'Activo', 'Deudora', 1, 440, 5);
INSERT INTO cuenta VALUES (442, '30324', 'Valor razonable', 'Activo', 'Deudora', 1, 440, 5);
INSERT INTO cuenta VALUES (443, '304', 'Participaciones en acuerdos conjuntos', 'Activo', 'Deudora', 1, 413, 3);
INSERT INTO cuenta VALUES (444, '3041', 'Operaciones conjuntas', 'Activo', 'Deudora', 1, 443, 4);
INSERT INTO cuenta VALUES (445, '30411', 'Costo', 'Activo', 'Deudora', 1, 444, 5);
INSERT INTO cuenta VALUES (446, '30414', 'Valor razonable', 'Activo', 'Deudora', 1, 444, 5);
INSERT INTO cuenta VALUES (447, '30415', 'Participación patrimonial', 'Activo', 'Deudora', 1, 444, 5);
INSERT INTO cuenta VALUES (448, '3042', 'Negocios conjuntos', 'Activo', 'Deudora', 1, 443, 4);
INSERT INTO cuenta VALUES (449, '30421', 'Costo', 'Activo', 'Deudora', 1, 448, 5);
INSERT INTO cuenta VALUES (450, '30424', 'Valor razonable', 'Activo', 'Deudora', 1, 448, 5);
INSERT INTO cuenta VALUES (451, '30425', 'Participación patrimonial', 'Activo', 'Deudora', 1, 448, 5);
INSERT INTO cuenta VALUES (452, '308', 'Inversiones mobiliarias – Acuerdos de compra', 'Activo', 'Deudora', 1, 413, 3);
INSERT INTO cuenta VALUES (453, '3081', 'Instrumentos financieros representativos de deuda – Acuerdo de compra', 'Activo', 'Deudora', 1, 452, 4);
INSERT INTO cuenta VALUES (454, '30811', 'Costo', 'Activo', 'Deudora', 1, 453, 5);
INSERT INTO cuenta VALUES (455, '30814', 'Valor razonable', 'Activo', 'Deudora', 1, 453, 5);
INSERT INTO cuenta VALUES (456, '3082', 'Instrumentos financieros representativos de derecho patrimonial – Acuerdo de compra', 'Activo', 'Deudora', 1, 452, 4);
INSERT INTO cuenta VALUES (457, '30821', 'Costo', 'Activo', 'Deudora', 1, 456, 5);
INSERT INTO cuenta VALUES (458, '30824', 'Valor razonable', 'Activo', 'Deudora', 1, 456, 5);
INSERT INTO cuenta VALUES (459, '31', 'PROPIEDADES DE INVERSIÓN', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (460, '311', 'Terrenos', 'Activo', 'Deudora', 1, 459, 3);
INSERT INTO cuenta VALUES (461, '3111', 'Urbanos', 'Activo', 'Deudora', 1, 460, 4);
INSERT INTO cuenta VALUES (462, '31111', 'Costo', 'Activo', 'Deudora', 1, 461, 5);
INSERT INTO cuenta VALUES (463, '31112', 'Revaluación', 'Activo', 'Deudora', 1, 461, 5);
INSERT INTO cuenta VALUES (464, '31114', 'Valor razonable', 'Activo', 'Deudora', 1, 461, 5);
INSERT INTO cuenta VALUES (465, '3112', 'Rurales', 'Activo', 'Deudora', 1, 460, 4);
INSERT INTO cuenta VALUES (466, '31121', 'Costo', 'Activo', 'Deudora', 1, 465, 5);
INSERT INTO cuenta VALUES (467, '31122', 'Revaluación', 'Activo', 'Deudora', 1, 465, 5);
INSERT INTO cuenta VALUES (468, '31124', 'Valor razonable', 'Activo', 'Deudora', 1, 465, 5);
INSERT INTO cuenta VALUES (469, '312', 'Edificaciones', 'Activo', 'Deudora', 1, 459, 3);
INSERT INTO cuenta VALUES (470, '3121', 'Edificaciones', 'Activo', 'Deudora', 1, 469, 4);
INSERT INTO cuenta VALUES (471, '31211', 'Costo', 'Activo', 'Deudora', 1, 470, 5);
INSERT INTO cuenta VALUES (472, '31212', 'Revaluación', 'Activo', 'Deudora', 1, 470, 5);
INSERT INTO cuenta VALUES (473, '31213', 'Costos de financiación', 'Activo', 'Deudora', 1, 470, 5);
INSERT INTO cuenta VALUES (474, '31214', 'Valor razonable', 'Activo', 'Deudora', 1, 470, 5);
INSERT INTO cuenta VALUES (475, '313', 'Construcciones en curso', 'Activo', 'Deudora', 1, 459, 3);
INSERT INTO cuenta VALUES (476, '3131', 'Edificaciones', 'Activo', 'Deudora', 1, 475, 4);
INSERT INTO cuenta VALUES (477, '31311', 'Costo', 'Activo', 'Deudora', 1, 476, 5);
INSERT INTO cuenta VALUES (478, '31312', 'Revaluación', 'Activo', 'Deudora', 1, 476, 5);
INSERT INTO cuenta VALUES (479, '31313', 'Costos de financiación', 'Activo', 'Deudora', 1, 476, 5);
INSERT INTO cuenta VALUES (480, '31314', 'Valor razonable', 'Activo', 'Deudora', 1, 476, 5);
INSERT INTO cuenta VALUES (481, '32', 'ACTIVOS POR DERECHO DE USO', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (482, '321', 'Propiedades de inversión – Arrendamiento financiero', 'Activo', 'Deudora', 1, 481, 3);
INSERT INTO cuenta VALUES (483, '3211', 'Terrenos', 'Activo', 'Deudora', 1, 482, 4);
INSERT INTO cuenta VALUES (484, '32111', 'Costo', 'Activo', 'Deudora', 1, 483, 5);
INSERT INTO cuenta VALUES (485, '32112', 'Revaluación', 'Activo', 'Deudora', 1, 483, 5);
INSERT INTO cuenta VALUES (486, '32114', 'Valor razonable', 'Activo', 'Deudora', 1, 483, 5);
INSERT INTO cuenta VALUES (487, '3212', 'Edificaciones', 'Activo', 'Deudora', 1, 482, 4);
INSERT INTO cuenta VALUES (488, '32121', 'Costo', 'Activo', 'Deudora', 1, 487, 5);
INSERT INTO cuenta VALUES (489, '32122', 'Revaluación', 'Activo', 'Deudora', 1, 487, 5);
INSERT INTO cuenta VALUES (490, '32123', 'Costo de financiación', 'Activo', 'Deudora', 1, 487, 5);
INSERT INTO cuenta VALUES (491, '32124', 'Valor razonable', 'Activo', 'Deudora', 1, 487, 5);
INSERT INTO cuenta VALUES (492, '322', 'Propiedad, planta y equipo – Arrendamiento financiero', 'Activo', 'Deudora', 1, 481, 3);
INSERT INTO cuenta VALUES (493, '3220', 'Planta productora en producción', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (494, '32201', 'Costo', 'Activo', 'Deudora', 1, 493, 5);
INSERT INTO cuenta VALUES (495, '32202', 'Revaluación', 'Activo', 'Deudora', 1, 493, 5);
INSERT INTO cuenta VALUES (496, '32203', 'Costo de financiación', 'Activo', 'Deudora', 1, 493, 5);
INSERT INTO cuenta VALUES (497, '3221', 'Planta productora en desarrollo', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (498, '32211', 'Costo', 'Activo', 'Deudora', 1, 497, 5);
INSERT INTO cuenta VALUES (499, '32212', 'Revaluación', 'Activo', 'Deudora', 1, 497, 5);
INSERT INTO cuenta VALUES (500, '32213', 'Costo de financiación', 'Activo', 'Deudora', 1, 497, 5);
INSERT INTO cuenta VALUES (501, '3222', 'Terrenos', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (502, '32221', 'Costo', 'Activo', 'Deudora', 1, 501, 5);
INSERT INTO cuenta VALUES (503, '32222', 'Revaluación', 'Activo', 'Deudora', 1, 501, 5);
INSERT INTO cuenta VALUES (504, '3223', 'Edificaciones', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (505, '32231', 'Costo', 'Activo', 'Deudora', 1, 504, 5);
INSERT INTO cuenta VALUES (506, '32232', 'Revaluación', 'Activo', 'Deudora', 1, 504, 5);
INSERT INTO cuenta VALUES (507, '32233', 'Costo de financiación', 'Activo', 'Deudora', 1, 504, 5);
INSERT INTO cuenta VALUES (508, '3224', 'Maquinaria y equipo de explotación', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (509, '32241', 'Costo', 'Activo', 'Deudora', 1, 508, 5);
INSERT INTO cuenta VALUES (510, '32242', 'Revaluación', 'Activo', 'Deudora', 1, 508, 5);
INSERT INTO cuenta VALUES (511, '32243', 'Costo de financiación', 'Activo', 'Deudora', 1, 508, 5);
INSERT INTO cuenta VALUES (512, '3225', 'Unidades de transporte', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (513, '32251', 'Costo', 'Activo', 'Deudora', 1, 512, 5);
INSERT INTO cuenta VALUES (514, '32252', 'Revaluación', 'Activo', 'Deudora', 1, 512, 5);
INSERT INTO cuenta VALUES (515, '3226', 'Muebles y enseres', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (516, '32261', 'Costo', 'Activo', 'Deudora', 1, 515, 5);
INSERT INTO cuenta VALUES (517, '32262', 'Revaluación', 'Activo', 'Deudora', 1, 515, 5);
INSERT INTO cuenta VALUES (518, '3227', 'Equipos diversos', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (519, '32271', 'Costo', 'Activo', 'Deudora', 1, 518, 5);
INSERT INTO cuenta VALUES (520, '32272', 'Revaluación', 'Activo', 'Deudora', 1, 518, 5);
INSERT INTO cuenta VALUES (521, '3228', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 492, 4);
INSERT INTO cuenta VALUES (522, '32281', 'Costo', 'Activo', 'Deudora', 1, 521, 5);
INSERT INTO cuenta VALUES (523, '32282', 'Revaluación', 'Activo', 'Deudora', 1, 521, 5);
INSERT INTO cuenta VALUES (524, '323', 'Propiedad, planta y equipo – Arrendamiento operativo', 'Activo', 'Deudora', 1, 481, 3);
INSERT INTO cuenta VALUES (525, '3230', 'Planta productora en producción', 'Activo', 'Deudora', 1, 524, 4);
INSERT INTO cuenta VALUES (526, '32301', 'Costo', 'Activo', 'Deudora', 1, 525, 5);
INSERT INTO cuenta VALUES (527, '32302', 'Revaluación', 'Activo', 'Deudora', 1, 525, 5);
INSERT INTO cuenta VALUES (528, '3232', 'Terrenos', 'Activo', 'Deudora', 1, 524, 4);
INSERT INTO cuenta VALUES (529, '32321', 'Costo', 'Activo', 'Deudora', 1, 528, 5);
INSERT INTO cuenta VALUES (530, '3233', 'Edificaciones', 'Activo', 'Deudora', 1, 524, 4);
INSERT INTO cuenta VALUES (531, '32331', 'Costo', 'Activo', 'Deudora', 1, 530, 5);
INSERT INTO cuenta VALUES (532, '32332', 'Revaluación', 'Activo', 'Deudora', 1, 530, 5);
INSERT INTO cuenta VALUES (533, '3234', 'Maquinaria y equipo de explotación', 'Activo', 'Deudora', 1, 524, 4);
INSERT INTO cuenta VALUES (534, '32341', 'Costo', 'Activo', 'Deudora', 1, 533, 5);
INSERT INTO cuenta VALUES (535, '32342', 'Revaluación', 'Activo', 'Deudora', 1, 533, 5);
INSERT INTO cuenta VALUES (536, '3235', 'Unidades de transporte', 'Activo', 'Deudora', 1, 524, 4);
INSERT INTO cuenta VALUES (537, '32351', 'Costo', 'Activo', 'Deudora', 1, 536, 5);
INSERT INTO cuenta VALUES (538, '32352', 'Revaluación', 'Activo', 'Deudora', 1, 536, 5);
INSERT INTO cuenta VALUES (539, '3236', 'Equipos diversos', 'Activo', 'Deudora', 1, 524, 4);
INSERT INTO cuenta VALUES (540, '32361', 'Costo', 'Activo', 'Deudora', 1, 539, 5);
INSERT INTO cuenta VALUES (541, '32362', 'Revaluación', 'Activo', 'Deudora', 1, 539, 5);
INSERT INTO cuenta VALUES (542, '33', 'PROPIEDAD, PLANTA Y EQUIPO', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (543, '330', 'Planta productora', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (544, '3301', 'Planta productora en producción', 'Activo', 'Deudora', 1, 543, 4);
INSERT INTO cuenta VALUES (545, '33011', 'Costo', 'Activo', 'Deudora', 1, 544, 5);
INSERT INTO cuenta VALUES (546, '33012', 'Revaluación', 'Activo', 'Deudora', 1, 544, 5);
INSERT INTO cuenta VALUES (547, '33013', 'Costo de financiación', 'Activo', 'Deudora', 1, 544, 5);
INSERT INTO cuenta VALUES (548, '33014', 'Valor razonable', 'Activo', 'Deudora', 1, 544, 5);
INSERT INTO cuenta VALUES (549, '3302', 'Planta productora en desarrollo', 'Activo', 'Deudora', 1, 543, 4);
INSERT INTO cuenta VALUES (550, '33021', 'Costo', 'Activo', 'Deudora', 1, 549, 5);
INSERT INTO cuenta VALUES (551, '33022', 'Revaluación', 'Activo', 'Deudora', 1, 549, 5);
INSERT INTO cuenta VALUES (552, '33023', 'Costo de financiación', 'Activo', 'Deudora', 1, 549, 5);
INSERT INTO cuenta VALUES (553, '33024', 'Valor razonable', 'Activo', 'Deudora', 1, 549, 5);
INSERT INTO cuenta VALUES (554, '331', 'Terrenos', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (555, '3311', 'Terrenos', 'Activo', 'Deudora', 1, 554, 4);
INSERT INTO cuenta VALUES (556, '33111', 'Costo', 'Activo', 'Deudora', 1, 555, 5);
INSERT INTO cuenta VALUES (557, '33112', 'Revaluación', 'Activo', 'Deudora', 1, 555, 5);
INSERT INTO cuenta VALUES (558, '332', 'Edificaciones', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (559, '3321', 'Edificaciones', 'Activo', 'Deudora', 1, 558, 4);
INSERT INTO cuenta VALUES (560, '33211', 'Costo', 'Activo', 'Deudora', 1, 559, 5);
INSERT INTO cuenta VALUES (561, '33212', 'Revaluación', 'Activo', 'Deudora', 1, 559, 5);
INSERT INTO cuenta VALUES (562, '33213', 'Costo de financiación', 'Activo', 'Deudora', 1, 559, 5);
INSERT INTO cuenta VALUES (563, '3324', 'Instalaciones', 'Activo', 'Deudora', 1, 558, 4);
INSERT INTO cuenta VALUES (564, '33241', 'Costo', 'Activo', 'Deudora', 1, 563, 5);
INSERT INTO cuenta VALUES (565, '33242', 'Revaluación', 'Activo', 'Deudora', 1, 563, 5);
INSERT INTO cuenta VALUES (566, '33243', 'Costo de financiación', 'Activo', 'Deudora', 1, 563, 5);
INSERT INTO cuenta VALUES (567, '3325', 'Mejoras en locales arrendados', 'Activo', 'Deudora', 1, 558, 4);
INSERT INTO cuenta VALUES (568, '33251', 'Costo', 'Activo', 'Deudora', 1, 567, 5);
INSERT INTO cuenta VALUES (569, '33252', 'Revaluación', 'Activo', 'Deudora', 1, 567, 5);
INSERT INTO cuenta VALUES (570, '33253', 'Costo de financiación', 'Activo', 'Deudora', 1, 567, 5);
INSERT INTO cuenta VALUES (571, '333', 'Maquinaria y equipo de explotación', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (572, '3331', 'Maquinaria y equipo de explotación', 'Activo', 'Deudora', 1, 571, 4);
INSERT INTO cuenta VALUES (573, '33311', 'Costo', 'Activo', 'Deudora', 1, 572, 5);
INSERT INTO cuenta VALUES (574, '33312', 'Revaluación', 'Activo', 'Deudora', 1, 572, 5);
INSERT INTO cuenta VALUES (575, '33313', 'Costo de financiación', 'Activo', 'Deudora', 1, 572, 5);
INSERT INTO cuenta VALUES (576, '334', 'Unidades de transporte', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (577, '3341', 'Vehículos motorizados', 'Activo', 'Deudora', 1, 576, 4);
INSERT INTO cuenta VALUES (578, '33411', 'Costo', 'Activo', 'Deudora', 1, 577, 5);
INSERT INTO cuenta VALUES (579, '33412', 'Revaluación', 'Activo', 'Deudora', 1, 577, 5);
INSERT INTO cuenta VALUES (580, '3342', 'Vehículos no motorizados', 'Activo', 'Deudora', 1, 576, 4);
INSERT INTO cuenta VALUES (581, '33421', 'Costo', 'Activo', 'Deudora', 1, 580, 5);
INSERT INTO cuenta VALUES (582, '33422', 'Revaluación', 'Activo', 'Deudora', 1, 580, 5);
INSERT INTO cuenta VALUES (583, '335', 'Muebles y enseres', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (584, '3351', 'Muebles', 'Activo', 'Deudora', 1, 583, 4);
INSERT INTO cuenta VALUES (585, '33511', 'Costo', 'Activo', 'Deudora', 1, 584, 5);
INSERT INTO cuenta VALUES (586, '33512', 'Revaluación', 'Activo', 'Deudora', 1, 584, 5);
INSERT INTO cuenta VALUES (587, '3352', 'Enseres', 'Activo', 'Deudora', 1, 583, 4);
INSERT INTO cuenta VALUES (588, '33521', 'Costo', 'Activo', 'Deudora', 1, 587, 5);
INSERT INTO cuenta VALUES (589, '33522', 'Revaluación', 'Activo', 'Deudora', 1, 587, 5);
INSERT INTO cuenta VALUES (590, '336', 'Equipos diversos', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (591, '3361', 'Equipo para procesamiento de información', 'Activo', 'Deudora', 1, 590, 4);
INSERT INTO cuenta VALUES (592, '33611', 'Costo', 'Activo', 'Deudora', 1, 591, 5);
INSERT INTO cuenta VALUES (593, '33612', 'Revaluación', 'Activo', 'Deudora', 1, 591, 5);
INSERT INTO cuenta VALUES (594, '3362', 'Equipo de comunicación', 'Activo', 'Deudora', 1, 590, 4);
INSERT INTO cuenta VALUES (595, '33621', 'Costo', 'Activo', 'Deudora', 1, 594, 5);
INSERT INTO cuenta VALUES (596, '33622', 'Revaluación', 'Activo', 'Deudora', 1, 594, 5);
INSERT INTO cuenta VALUES (597, '3363', 'Equipo de seguridad', 'Activo', 'Deudora', 1, 590, 4);
INSERT INTO cuenta VALUES (598, '33631', 'Costo', 'Activo', 'Deudora', 1, 597, 5);
INSERT INTO cuenta VALUES (599, '33632', 'Revaluación', 'Activo', 'Deudora', 1, 597, 5);
INSERT INTO cuenta VALUES (600, '3364', 'Equipo de medio ambiente', 'Activo', 'Deudora', 1, 590, 4);
INSERT INTO cuenta VALUES (601, '33641', 'Costo', 'Activo', 'Deudora', 1, 600, 5);
INSERT INTO cuenta VALUES (602, '33642', 'Revaluación', 'Activo', 'Deudora', 1, 600, 5);
INSERT INTO cuenta VALUES (603, '3369', 'Otros equipos', 'Activo', 'Deudora', 1, 590, 4);
INSERT INTO cuenta VALUES (604, '33691', 'Costo', 'Activo', 'Deudora', 1, 603, 5);
INSERT INTO cuenta VALUES (605, '33692', 'Revaluación', 'Activo', 'Deudora', 1, 603, 5);
INSERT INTO cuenta VALUES (606, '337', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (607, '3371', 'Herramientas', 'Activo', 'Deudora', 1, 606, 4);
INSERT INTO cuenta VALUES (608, '33711', 'Costo', 'Activo', 'Deudora', 1, 607, 5);
INSERT INTO cuenta VALUES (609, '33712', 'Revaluación', 'Activo', 'Deudora', 1, 607, 5);
INSERT INTO cuenta VALUES (610, '3372', 'Unidades de reemplazo', 'Activo', 'Deudora', 1, 606, 4);
INSERT INTO cuenta VALUES (611, '33721', 'Costo', 'Activo', 'Deudora', 1, 610, 5);
INSERT INTO cuenta VALUES (612, '33722', 'Revaluación', 'Activo', 'Deudora', 1, 610, 5);
INSERT INTO cuenta VALUES (613, '338', 'Unidades por recibir', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (614, '3381', 'Maquinaria y equipo de explotación', 'Activo', 'Deudora', 1, 613, 4);
INSERT INTO cuenta VALUES (615, '3382', 'Equipo de transporte', 'Activo', 'Deudora', 1, 613, 4);
INSERT INTO cuenta VALUES (616, '3383', 'Muebles y enseres', 'Activo', 'Deudora', 1, 613, 4);
INSERT INTO cuenta VALUES (617, '3386', 'Equipos diversos', 'Activo', 'Deudora', 1, 613, 4);
INSERT INTO cuenta VALUES (618, '3387', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 613, 4);
INSERT INTO cuenta VALUES (619, '339', 'Obras en curso', 'Activo', 'Deudora', 1, 542, 3);
INSERT INTO cuenta VALUES (620, '3391', 'Adecuación de terrenos', 'Activo', 'Deudora', 1, 619, 4);
INSERT INTO cuenta VALUES (621, '3392', 'Edificaciones en curso', 'Activo', 'Deudora', 1, 619, 4);
INSERT INTO cuenta VALUES (622, '33921', 'Costo', 'Activo', 'Deudora', 1, 621, 5);
INSERT INTO cuenta VALUES (623, '33922', 'Costo de financiación', 'Activo', 'Deudora', 1, 621, 5);
INSERT INTO cuenta VALUES (624, '3393', 'Maquinaria en montaje', 'Activo', 'Deudora', 1, 619, 4);
INSERT INTO cuenta VALUES (625, '33931', 'Costo', 'Activo', 'Deudora', 1, 624, 5);
INSERT INTO cuenta VALUES (626, '33932', 'Costo de financiación', 'Activo', 'Deudora', 1, 624, 5);
INSERT INTO cuenta VALUES (627, '34', 'INTANGIBLES', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (628, '341', 'Concesiones, licencias y otros derechos', 'Activo', 'Deudora', 1, 627, 3);
INSERT INTO cuenta VALUES (629, '3411', 'Derechos por concesiones', 'Activo', 'Deudora', 1, 628, 4);
INSERT INTO cuenta VALUES (630, '34111', 'Costo', 'Activo', 'Deudora', 1, 629, 5);
INSERT INTO cuenta VALUES (631, '34112', 'Revaluación', 'Activo', 'Deudora', 1, 629, 5);
INSERT INTO cuenta VALUES (632, '3412', 'Licencias', 'Activo', 'Deudora', 1, 628, 4);
INSERT INTO cuenta VALUES (633, '34121', 'Costo', 'Activo', 'Deudora', 1, 632, 5);
INSERT INTO cuenta VALUES (634, '34122', 'Revaluación', 'Activo', 'Deudora', 1, 632, 5);
INSERT INTO cuenta VALUES (635, '3419', 'Otros derechos', 'Activo', 'Deudora', 1, 628, 4);
INSERT INTO cuenta VALUES (636, '34191', 'Costo', 'Activo', 'Deudora', 1, 635, 5);
INSERT INTO cuenta VALUES (637, '34192', 'Revaluación', 'Activo', 'Deudora', 1, 635, 5);
INSERT INTO cuenta VALUES (638, '342', 'Patentes y propiedad industrial', 'Activo', 'Deudora', 1, 627, 3);
INSERT INTO cuenta VALUES (639, '3421', 'Patentes', 'Activo', 'Deudora', 1, 638, 4);
INSERT INTO cuenta VALUES (640, '34211', 'Costo', 'Activo', 'Deudora', 1, 639, 5);
INSERT INTO cuenta VALUES (641, '34212', 'Revaluación', 'Activo', 'Deudora', 1, 639, 5);
INSERT INTO cuenta VALUES (642, '3422', 'Marcas', 'Activo', 'Deudora', 1, 638, 4);
INSERT INTO cuenta VALUES (643, '34221', 'Costo', 'Activo', 'Deudora', 1, 642, 5);
INSERT INTO cuenta VALUES (644, '34222', 'Revaluación', 'Activo', 'Deudora', 1, 642, 5);
INSERT INTO cuenta VALUES (645, '343', 'Programas de computadora (software)', 'Activo', 'Deudora', 1, 627, 3);
INSERT INTO cuenta VALUES (646, '3431', 'Aplicaciones informáticas', 'Activo', 'Deudora', 1, 645, 4);
INSERT INTO cuenta VALUES (647, '34311', 'Costo', 'Activo', 'Deudora', 1, 646, 5);
INSERT INTO cuenta VALUES (648, '34312', 'Revaluación', 'Activo', 'Deudora', 1, 646, 5);
INSERT INTO cuenta VALUES (649, '344', 'Costos de exploración y desarrollo', 'Activo', 'Deudora', 1, 627, 3);
INSERT INTO cuenta VALUES (650, '3441', 'Costos de exploración', 'Activo', 'Deudora', 1, 649, 4);
INSERT INTO cuenta VALUES (651, '34411', 'Costo', 'Activo', 'Deudora', 1, 650, 5);
INSERT INTO cuenta VALUES (652, '34412', 'Revaluación', 'Activo', 'Deudora', 1, 650, 5);
INSERT INTO cuenta VALUES (653, '34413', 'Costo de financiación', 'Activo', 'Deudora', 1, 650, 5);
INSERT INTO cuenta VALUES (654, '3442', 'Costos de desarrollo', 'Activo', 'Deudora', 1, 649, 4);
INSERT INTO cuenta VALUES (655, '34421', 'Costo', 'Activo', 'Deudora', 1, 654, 5);
INSERT INTO cuenta VALUES (656, '34422', 'Revaluación', 'Activo', 'Deudora', 1, 654, 5);
INSERT INTO cuenta VALUES (657, '34423', 'Costo de financiación', 'Activo', 'Deudora', 1, 654, 5);
INSERT INTO cuenta VALUES (658, '345', 'Fórmulas, diseños y prototipos', 'Activo', 'Deudora', 1, 627, 3);
INSERT INTO cuenta VALUES (659, '3451', 'Fórmulas', 'Activo', 'Deudora', 1, 658, 4);
INSERT INTO cuenta VALUES (660, '34511', 'Costo', 'Activo', 'Deudora', 1, 659, 5);
INSERT INTO cuenta VALUES (661, '34512', 'Revaluación', 'Activo', 'Deudora', 1, 659, 5);
INSERT INTO cuenta VALUES (662, '3452', 'Diseños y prototipos', 'Activo', 'Deudora', 1, 658, 4);
INSERT INTO cuenta VALUES (663, '34521', 'Costo', 'Activo', 'Deudora', 1, 662, 5);
INSERT INTO cuenta VALUES (664, '34522', 'Revaluación', 'Activo', 'Deudora', 1, 662, 5);
INSERT INTO cuenta VALUES (665, '347', 'Plusvalía mercantil', 'Activo', 'Deudora', 1, 627, 3);
INSERT INTO cuenta VALUES (666, '3471', 'Plusvalía mercantil', 'Activo', 'Deudora', 1, 665, 4);
INSERT INTO cuenta VALUES (667, '349', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 627, 3);
INSERT INTO cuenta VALUES (668, '3491', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 667, 4);
INSERT INTO cuenta VALUES (669, '34911', 'Costo', 'Activo', 'Deudora', 1, 668, 5);
INSERT INTO cuenta VALUES (670, '34912', 'Revaluación', 'Activo', 'Deudora', 1, 668, 5);
INSERT INTO cuenta VALUES (671, '35', 'ACTIVOS BIOLÓGICOS', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (672, '351', 'Activos biológicos en producción', 'Activo', 'Deudora', 1, 671, 3);
INSERT INTO cuenta VALUES (673, '3511', 'De origen animal', 'Activo', 'Deudora', 1, 672, 4);
INSERT INTO cuenta VALUES (674, '35111', 'Costo', 'Activo', 'Deudora', 1, 673, 5);
INSERT INTO cuenta VALUES (675, '35113', 'Costo de financiación', 'Activo', 'Deudora', 1, 673, 5);
INSERT INTO cuenta VALUES (676, '35114', 'Valor razonable', 'Activo', 'Deudora', 1, 673, 5);
INSERT INTO cuenta VALUES (677, '3512', 'De origen vegetal', 'Activo', 'Deudora', 1, 672, 4);
INSERT INTO cuenta VALUES (678, '35121', 'Costo', 'Activo', 'Deudora', 1, 677, 5);
INSERT INTO cuenta VALUES (679, '35123', 'Costo de financiación', 'Activo', 'Deudora', 1, 677, 5);
INSERT INTO cuenta VALUES (680, '35124', 'Valor razonable', 'Activo', 'Deudora', 1, 677, 5);
INSERT INTO cuenta VALUES (681, '352', 'Activos biológicos en desarrollo', 'Activo', 'Deudora', 1, 671, 3);
INSERT INTO cuenta VALUES (682, '3521', 'De origen animal', 'Activo', 'Deudora', 1, 681, 4);
INSERT INTO cuenta VALUES (683, '35211', 'Costo', 'Activo', 'Deudora', 1, 682, 5);
INSERT INTO cuenta VALUES (684, '35213', 'Costo de financiación', 'Activo', 'Deudora', 1, 682, 5);
INSERT INTO cuenta VALUES (685, '35214', 'Valor razonable', 'Activo', 'Deudora', 1, 682, 5);
INSERT INTO cuenta VALUES (686, '3522', 'De origen vegetal', 'Activo', 'Deudora', 1, 681, 4);
INSERT INTO cuenta VALUES (687, '35221', 'Costo', 'Activo', 'Deudora', 1, 686, 5);
INSERT INTO cuenta VALUES (688, '35223', 'Costo de financiación', 'Activo', 'Deudora', 1, 686, 5);
INSERT INTO cuenta VALUES (689, '35224', 'Valor razonable', 'Activo', 'Deudora', 1, 686, 5);
INSERT INTO cuenta VALUES (690, '36', 'DESVALORIZACIÓN DE ACTIVO INMOVILIZADO', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (691, '361', 'Desvalorización de propiedades de inversión', 'Activo', 'Deudora', 1, 690, 3);
INSERT INTO cuenta VALUES (692, '3611', 'Terrenos', 'Activo', 'Deudora', 1, 691, 4);
INSERT INTO cuenta VALUES (693, '36111', 'Costo', 'Activo', 'Deudora', 1, 692, 5);
INSERT INTO cuenta VALUES (694, '36112', 'Revaluación', 'Activo', 'Deudora', 1, 692, 5);
INSERT INTO cuenta VALUES (695, '3612', 'Edificaciones', 'Activo', 'Deudora', 1, 691, 4);
INSERT INTO cuenta VALUES (696, '36121', 'Costo', 'Activo', 'Deudora', 1, 695, 5);
INSERT INTO cuenta VALUES (697, '36122', 'Revaluación', 'Activo', 'Deudora', 1, 695, 5);
INSERT INTO cuenta VALUES (698, '36123', 'Costo de financiación', 'Activo', 'Deudora', 1, 695, 5);
INSERT INTO cuenta VALUES (699, '3613', 'Construcciones en curso – edificaciones', 'Activo', 'Deudora', 1, 691, 4);
INSERT INTO cuenta VALUES (700, '36131', 'Costo', 'Activo', 'Deudora', 1, 699, 5);
INSERT INTO cuenta VALUES (701, '36132', 'Revaluación', 'Activo', 'Deudora', 1, 699, 5);
INSERT INTO cuenta VALUES (702, '36133', 'Costo de financiación', 'Activo', 'Deudora', 1, 699, 5);
INSERT INTO cuenta VALUES (703, '362', 'Desvalorización de propiedades de inversión – Arrendamiento financiero', 'Activo', 'Deudora', 1, 690, 3);
INSERT INTO cuenta VALUES (704, '3621', 'Terrenos', 'Activo', 'Deudora', 1, 703, 4);
INSERT INTO cuenta VALUES (705, '36211', 'Costo', 'Activo', 'Deudora', 1, 704, 5);
INSERT INTO cuenta VALUES (706, '36212', 'Revaluación', 'Activo', 'Deudora', 1, 704, 5);
INSERT INTO cuenta VALUES (707, '3622', 'Edificaciones', 'Activo', 'Deudora', 1, 703, 4);
INSERT INTO cuenta VALUES (708, '36221', 'Costo', 'Activo', 'Deudora', 1, 707, 5);
INSERT INTO cuenta VALUES (709, '36222', 'Revaluación', 'Activo', 'Deudora', 1, 707, 5);
INSERT INTO cuenta VALUES (710, '36223', 'Costo de financiación', 'Activo', 'Deudora', 1, 707, 5);
INSERT INTO cuenta VALUES (711, '363', 'Desvalorización de propiedad, planta y equipo – Arrendamiento financiero', 'Activo', 'Deudora', 1, 690, 3);
INSERT INTO cuenta VALUES (712, '3631', 'Terrenos', 'Activo', 'Deudora', 1, 711, 4);
INSERT INTO cuenta VALUES (713, '36311', 'Costo', 'Activo', 'Deudora', 1, 712, 5);
INSERT INTO cuenta VALUES (714, '36312', 'Revaluación', 'Activo', 'Deudora', 1, 712, 5);
INSERT INTO cuenta VALUES (715, '3632', 'Edificaciones', 'Activo', 'Deudora', 1, 711, 4);
INSERT INTO cuenta VALUES (716, '36321', 'Costo', 'Activo', 'Deudora', 1, 715, 5);
INSERT INTO cuenta VALUES (717, '36322', 'Revaluación', 'Activo', 'Deudora', 1, 715, 5);
INSERT INTO cuenta VALUES (718, '36323', 'Costo de financiación', 'Activo', 'Deudora', 1, 715, 5);
INSERT INTO cuenta VALUES (719, '3633', 'Maquinaria y equipo de explotación', 'Activo', 'Deudora', 1, 711, 4);
INSERT INTO cuenta VALUES (720, '36331', 'Costo', 'Activo', 'Deudora', 1, 719, 5);
INSERT INTO cuenta VALUES (721, '36332', 'Revaluación', 'Activo', 'Deudora', 1, 719, 5);
INSERT INTO cuenta VALUES (722, '36333', 'Costo de financiación', 'Activo', 'Deudora', 1, 719, 5);
INSERT INTO cuenta VALUES (723, '3634', 'Unidades de transporte', 'Activo', 'Deudora', 1, 711, 4);
INSERT INTO cuenta VALUES (724, '36341', 'Costo', 'Activo', 'Deudora', 1, 723, 5);
INSERT INTO cuenta VALUES (725, '36342', 'Revaluación', 'Activo', 'Deudora', 1, 723, 5);
INSERT INTO cuenta VALUES (726, '3635', 'Muebles y enseres', 'Activo', 'Deudora', 1, 711, 4);
INSERT INTO cuenta VALUES (727, '36351', 'Costo', 'Activo', 'Deudora', 1, 726, 5);
INSERT INTO cuenta VALUES (728, '36352', 'Revaluación', 'Activo', 'Deudora', 1, 726, 5);
INSERT INTO cuenta VALUES (729, '3636', 'Equipos diversos', 'Activo', 'Deudora', 1, 711, 4);
INSERT INTO cuenta VALUES (730, '36361', 'Costo', 'Activo', 'Deudora', 1, 729, 5);
INSERT INTO cuenta VALUES (731, '36362', 'Revaluación', 'Activo', 'Deudora', 1, 729, 5);
INSERT INTO cuenta VALUES (732, '364', 'Desvalorización de propiedad, planta y equipo', 'Activo', 'Deudora', 1, 690, 3);
INSERT INTO cuenta VALUES (733, '3640', 'Planta productora en producción', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (742, '36401', 'Costo', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (750, '36402', 'Planta productora en producción – Revaluación', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (751, '36403', 'Planta productora en producción – Costo de financiación', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (752, '36404', 'Planta productora en producción – Valor razonable', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (753, '36405', 'Planta productora en desarrollo – Costo', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (754, '36406', 'Planta productora en desarrollo – Revaluación', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (755, '36407', 'Planta productora en desarrollo – Costo de financiación', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (756, '36408', 'Planta productora en desarrollo – Valor razonable', 'Activo', 'Deudora', 1, 733, 5);
INSERT INTO cuenta VALUES (757, '3641', 'Terrenos', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (758, '36411', 'Costo', 'Activo', 'Deudora', 1, 757, 5);
INSERT INTO cuenta VALUES (759, '36412', 'Revaluación', 'Activo', 'Deudora', 1, 757, 5);
INSERT INTO cuenta VALUES (760, '3642', 'Edificaciones', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (761, '36421', 'Edificaciones – Costo', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (762, '36422', 'Edificaciones – Revaluación', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (763, '36423', 'Edificaciones – Costo de financiación', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (764, '36424', 'Instalaciones – Costo', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (765, '36425', 'Instalaciones – Revaluación', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (766, '36426', 'Instalaciones – Costo de financiación', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (767, '36427', 'Mejoras en locales arrendados – Costo', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (768, '36428', 'Mejoras en locales arrendados – Revaluación', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (769, '36429', 'Mejoras en locales arrendados – Costo de financiación', 'Activo', 'Deudora', 1, 760, 5);
INSERT INTO cuenta VALUES (770, '3643', 'Maquinaria y equipo de explotación', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (771, '36431', 'Costo', 'Activo', 'Deudora', 1, 770, 5);
INSERT INTO cuenta VALUES (772, '36432', 'Revaluación', 'Activo', 'Deudora', 1, 770, 5);
INSERT INTO cuenta VALUES (773, '36433', 'Costo de financiación', 'Activo', 'Deudora', 1, 770, 5);
INSERT INTO cuenta VALUES (774, '3644', 'Unidades de transporte', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (775, '36441', 'Costo', 'Activo', 'Deudora', 1, 774, 5);
INSERT INTO cuenta VALUES (776, '36442', 'Revaluación', 'Activo', 'Deudora', 1, 774, 5);
INSERT INTO cuenta VALUES (777, '3645', 'Muebles y enseres', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (778, '36451', 'Costo', 'Activo', 'Deudora', 1, 777, 5);
INSERT INTO cuenta VALUES (779, '36452', 'Revaluación', 'Activo', 'Deudora', 1, 777, 5);
INSERT INTO cuenta VALUES (780, '3646', 'Equipos diversos', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (781, '36461', 'Costo', 'Activo', 'Deudora', 1, 780, 5);
INSERT INTO cuenta VALUES (782, '36462', 'Revaluación', 'Activo', 'Deudora', 1, 780, 5);
INSERT INTO cuenta VALUES (783, '3647', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (788, '36471', 'Herramientas – Costo', 'Activo', 'Deudora', 1, 783, 5);
INSERT INTO cuenta VALUES (789, '38472', 'Herramientas – Revaluación', 'Activo', 'Deudora', 1, 783, 5);
INSERT INTO cuenta VALUES (790, '38473', 'Unidades de reemplazo – costo', 'Activo', 'Deudora', 1, 783, 5);
INSERT INTO cuenta VALUES (791, '38474', 'Unidades de reemplazo – Revaluación', 'Activo', 'Deudora', 1, 783, 5);
INSERT INTO cuenta VALUES (792, '3649', 'Obras en curso', 'Activo', 'Deudora', 1, 732, 4);
INSERT INTO cuenta VALUES (793, '36491', 'Costo', 'Activo', 'Deudora', 1, 792, 5);
INSERT INTO cuenta VALUES (794, '36492', 'Revaluación', 'Activo', 'Deudora', 1, 792, 5);
INSERT INTO cuenta VALUES (795, '365', 'Desvalorización de intangibles', 'Activo', 'Deudora', 1, 690, 3);
INSERT INTO cuenta VALUES (796, '3651', 'Concesiones, licencias y otros derechos', 'Activo', 'Deudora', 1, 795, 4);
INSERT INTO cuenta VALUES (797, '36511', 'Costo', 'Activo', 'Deudora', 1, 796, 5);
INSERT INTO cuenta VALUES (798, '36512', 'Revaluación', 'Activo', 'Deudora', 1, 796, 5);
INSERT INTO cuenta VALUES (799, '3652', 'Patentes y propiedad industrial', 'Activo', 'Deudora', 1, 795, 4);
INSERT INTO cuenta VALUES (800, '36521', 'Costo', 'Activo', 'Deudora', 1, 799, 5);
INSERT INTO cuenta VALUES (801, '36522', 'Revaluación', 'Activo', 'Deudora', 1, 799, 5);
INSERT INTO cuenta VALUES (802, '3653', 'Programas de computadora (software)', 'Activo', 'Deudora', 1, 795, 4);
INSERT INTO cuenta VALUES (803, '36531', 'Costo', 'Activo', 'Deudora', 1, 802, 5);
INSERT INTO cuenta VALUES (804, '36532', 'Revaluación', 'Activo', 'Deudora', 1, 802, 5);
INSERT INTO cuenta VALUES (805, '3654', 'Costos de exploración y desarrollo', 'Activo', 'Deudora', 1, 795, 4);
INSERT INTO cuenta VALUES (806, '36541', 'Costo', 'Activo', 'Deudora', 1, 805, 5);
INSERT INTO cuenta VALUES (807, '36542', 'Revaluación', 'Activo', 'Deudora', 1, 805, 5);
INSERT INTO cuenta VALUES (808, '36543', 'Costo de financiación', 'Activo', 'Deudora', 1, 805, 5);
INSERT INTO cuenta VALUES (809, '3655', 'Fórmulas, diseños y prototipos', 'Activo', 'Deudora', 1, 795, 4);
INSERT INTO cuenta VALUES (810, '36551', 'Costo', 'Activo', 'Deudora', 1, 809, 5);
INSERT INTO cuenta VALUES (811, '36552', 'Revaluación', 'Activo', 'Deudora', 1, 809, 5);
INSERT INTO cuenta VALUES (812, '3657', 'Plusvalía mercantil', 'Activo', 'Deudora', 1, 795, 4);
INSERT INTO cuenta VALUES (813, '3659', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 795, 4);
INSERT INTO cuenta VALUES (814, '36591', 'Costo', 'Activo', 'Deudora', 1, 813, 5);
INSERT INTO cuenta VALUES (815, '36592', 'Revaluación', 'Activo', 'Deudora', 1, 813, 5);
INSERT INTO cuenta VALUES (816, '366', 'Desvalorización de activos biológicos', 'Activo', 'Deudora', 1, 690, 3);
INSERT INTO cuenta VALUES (817, '3661', 'Activos biológicos en producción', 'Activo', 'Deudora', 1, 816, 4);
INSERT INTO cuenta VALUES (818, '36611', 'Costo', 'Activo', 'Deudora', 1, 817, 5);
INSERT INTO cuenta VALUES (819, '36613', 'Costo de financiación', 'Activo', 'Deudora', 1, 817, 5);
INSERT INTO cuenta VALUES (820, '3662', 'Activos biológicos en desarrollo', 'Activo', 'Deudora', 1, 816, 4);
INSERT INTO cuenta VALUES (821, '36621', 'Costo', 'Activo', 'Deudora', 1, 820, 5);
INSERT INTO cuenta VALUES (822, '36622', 'Costo de financiación', 'Activo', 'Deudora', 1, 820, 5);
INSERT INTO cuenta VALUES (823, '367', 'Desvalorización de inversiones mobiliarias', 'Activo', 'Deudora', 1, 690, 3);
INSERT INTO cuenta VALUES (824, '3671', 'Inversiones a ser mantenidas hasta el vencimiento', 'Activo', 'Deudora', 1, 823, 4);
INSERT INTO cuenta VALUES (825, '36711', 'Costo', 'Activo', 'Deudora', 1, 824, 5);
INSERT INTO cuenta VALUES (826, '3672', 'Inversiones financieras representativas de derecho patrimonial', 'Activo', 'Deudora', 1, 823, 4);
INSERT INTO cuenta VALUES (827, '36721', 'Costo', 'Activo', 'Deudora', 1, 826, 5);
INSERT INTO cuenta VALUES (828, '3673', 'Otras inversiones financieras', 'Activo', 'Deudora', 1, 823, 4);
INSERT INTO cuenta VALUES (829, '36731', 'Costo', 'Activo', 'Deudora', 1, 828, 5);
INSERT INTO cuenta VALUES (830, '37', 'ACTIVO DIFERIDO', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (831, '371', 'Impuesto a la renta diferido', 'Activo', 'Deudora', 1, 830, 3);
INSERT INTO cuenta VALUES (832, '3711', 'Impuesto a la renta diferido – Patrimonio', 'Activo', 'Deudora', 1, 831, 4);
INSERT INTO cuenta VALUES (833, '3712', 'Impuesto a la renta diferido – Resultados', 'Activo', 'Deudora', 1, 831, 4);
INSERT INTO cuenta VALUES (834, '372', 'Participaciones de los trabajadores diferidas', 'Activo', 'Deudora', 1, 830, 3);
INSERT INTO cuenta VALUES (835, '3721', 'Participaciones de los trabajadores diferidas – Patrimonio', 'Activo', 'Deudora', 1, 834, 4);
INSERT INTO cuenta VALUES (836, '3722', 'Participaciones de los trabajadores diferidas – Resultados', 'Activo', 'Deudora', 1, 834, 4);
INSERT INTO cuenta VALUES (837, '373', 'Intereses diferidos', 'Activo', 'Deudora', 1, 830, 3);
INSERT INTO cuenta VALUES (838, '3731', 'Intereses no devengados en transacciones con terceros', 'Activo', 'Deudora', 1, 837, 4);
INSERT INTO cuenta VALUES (839, '3732', 'Intereses no devengados en medición a valor descontado', 'Activo', 'Deudora', 1, 837, 4);
INSERT INTO cuenta VALUES (840, '38', 'OTROS ACTIVOS', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (841, '381', 'Bienes de arte y cultura', 'Activo', 'Deudora', 1, 840, 3);
INSERT INTO cuenta VALUES (842, '3811', 'Obras de arte', 'Activo', 'Deudora', 1, 841, 4);
INSERT INTO cuenta VALUES (843, '3812', 'Biblioteca', 'Activo', 'Deudora', 1, 841, 4);
INSERT INTO cuenta VALUES (844, '3813', 'Otros', 'Activo', 'Deudora', 1, 841, 4);
INSERT INTO cuenta VALUES (845, '382', 'Diversos', 'Activo', 'Deudora', 1, 840, 3);
INSERT INTO cuenta VALUES (846, '3821', 'Monedas y joyas', 'Activo', 'Deudora', 1, 845, 4);
INSERT INTO cuenta VALUES (847, '3822', 'Bienes entregados en comodato', 'Activo', 'Deudora', 1, 845, 4);
INSERT INTO cuenta VALUES (848, '3823', 'Bienes recibidos en pago (adjudicados y realizables)', 'Activo', 'Deudora', 1, 845, 4);
INSERT INTO cuenta VALUES (849, '3829', 'Otros', 'Activo', 'Deudora', 1, 845, 4);
INSERT INTO cuenta VALUES (850, '39', 'DEPRECIACIÓN y AMORTIZACIÓN ACUMULADOS', 'Activo', 'Deudora', 1, 412, 2);
INSERT INTO cuenta VALUES (851, '391', 'Depreciación acumulada propiedades de inversión', 'Activo', 'Deudora', 1, 850, 3);
INSERT INTO cuenta VALUES (852, '3911', 'Edificaciones', 'Activo', 'Deudora', 1, 851, 4);
INSERT INTO cuenta VALUES (853, '39111', 'Costo', 'Activo', 'Deudora', 1, 852, 5);
INSERT INTO cuenta VALUES (854, '39112', 'Revaluación', 'Activo', 'Deudora', 1, 852, 5);
INSERT INTO cuenta VALUES (855, '39113', 'Costo de financiación', 'Activo', 'Deudora', 1, 852, 5);
INSERT INTO cuenta VALUES (856, '392', 'Depreciación acumulada propiedades de inversión – Arrendamiento financiero', 'Activo', 'Deudora', 1, 850, 3);
INSERT INTO cuenta VALUES (857, '3921', 'Edificaciones', 'Activo', 'Deudora', 1, 856, 4);
INSERT INTO cuenta VALUES (858, '39211', 'Costo', 'Activo', 'Deudora', 1, 857, 5);
INSERT INTO cuenta VALUES (859, '39212', 'Revaluación', 'Activo', 'Deudora', 1, 857, 5);
INSERT INTO cuenta VALUES (860, '39213', 'Costo de financiación', 'Activo', 'Deudora', 1, 857, 5);
INSERT INTO cuenta VALUES (861, '393', 'Depreciación acumulada propiedad, planta y equipo – Arrendamiento financiero', 'Activo', 'Deudora', 1, 850, 3);
INSERT INTO cuenta VALUES (862, '3932', 'Edificaciones', 'Activo', 'Deudora', 1, 861, 4);
INSERT INTO cuenta VALUES (863, '39321', 'Costo', 'Activo', 'Deudora', 1, 862, 5);
INSERT INTO cuenta VALUES (864, '39322', 'Revaluación', 'Activo', 'Deudora', 1, 862, 5);
INSERT INTO cuenta VALUES (865, '39323', 'Costo de financiación', 'Activo', 'Deudora', 1, 862, 5);
INSERT INTO cuenta VALUES (866, '3933', 'Maquinarias y equipos de explotación', 'Activo', 'Deudora', 1, 861, 4);
INSERT INTO cuenta VALUES (867, '39331', 'Costo', 'Activo', 'Deudora', 1, 866, 5);
INSERT INTO cuenta VALUES (868, '39332', 'Revaluación', 'Activo', 'Deudora', 1, 866, 5);
INSERT INTO cuenta VALUES (869, '39333', 'Costo de financiación', 'Activo', 'Deudora', 1, 866, 5);
INSERT INTO cuenta VALUES (870, '3934', 'Unidades de transporte', 'Activo', 'Deudora', 1, 861, 4);
INSERT INTO cuenta VALUES (871, '39341', 'Costo', 'Activo', 'Deudora', 1, 870, 5);
INSERT INTO cuenta VALUES (872, '39342', 'Revaluación', 'Activo', 'Deudora', 1, 870, 5);
INSERT INTO cuenta VALUES (873, '3935', 'Muebles y enseres', 'Activo', 'Deudora', 1, 861, 4);
INSERT INTO cuenta VALUES (874, '39351', 'Costo', 'Activo', 'Deudora', 1, 873, 5);
INSERT INTO cuenta VALUES (875, '38352', 'Revaluación', 'Activo', 'Deudora', 1, 873, 5);
INSERT INTO cuenta VALUES (876, '3936', 'Equipos diversos', 'Activo', 'Deudora', 1, 861, 4);
INSERT INTO cuenta VALUES (877, '39361', 'Costo', 'Activo', 'Deudora', 1, 876, 5);
INSERT INTO cuenta VALUES (878, '39362', 'Revaluación', 'Activo', 'Deudora', 1, 876, 5);
INSERT INTO cuenta VALUES (879, '394', 'Depreciación acumulada – Arrendamiento operativo', 'Activo', 'Deudora', 1, 850, 3);
INSERT INTO cuenta VALUES (880, '3941', 'Activos por derecho de uso – arrendamiento operativo', 'Activo', 'Deudora', 1, 879, 4);
INSERT INTO cuenta VALUES (881, '39410', 'Plantas productoras', 'Activo', 'Deudora', 1, 880, 5);
INSERT INTO cuenta VALUES (882, '39411', 'Terrenos', 'Activo', 'Deudora', 1, 880, 5);
INSERT INTO cuenta VALUES (883, '39412', 'Edificaciones', 'Activo', 'Deudora', 1, 880, 5);
INSERT INTO cuenta VALUES (884, '39413', 'Maquinarias y equipos de explotación', 'Activo', 'Deudora', 1, 880, 5);
INSERT INTO cuenta VALUES (885, '39414', 'Unidades de transporte', 'Activo', 'Deudora', 1, 880, 5);
INSERT INTO cuenta VALUES (886, '39415', 'Equipos diversos', 'Activo', 'Deudora', 1, 880, 5);
INSERT INTO cuenta VALUES (887, '395', 'Depreciación acumulada de propiedad, planta y equipo', 'Activo', 'Deudora', 1, 850, 3);
INSERT INTO cuenta VALUES (888, '3952', 'Depreciación acumulada – Costo', 'Activo', 'Deudora', 1, 887, 4);
INSERT INTO cuenta VALUES (889, '39520', 'Plantas productoras', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (890, '39521', 'Edificaciones', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (891, '39522', 'Instalaciones', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (892, '39523', 'Mejoras en locales arrendados', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (893, '39524', 'Maquinarias y equipos de explotación', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (894, '39525', 'Unidades de transporte', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (895, '39526', 'Muebles y enseres', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (896, '39527', 'Equipos diversos', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (897, '39528', 'Herramientas', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (898, '39529', 'Unidades de reemplazo', 'Activo', 'Deudora', 1, 888, 5);
INSERT INTO cuenta VALUES (899, '3953', 'Propiedad, planta y equipo – Revaluación', 'Activo', 'Deudora', 1, 887, 4);
INSERT INTO cuenta VALUES (900, '39530', 'Plantas productoras', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (901, '39531', 'Edificaciones', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (902, '39532', 'Instalaciones', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (903, '39533', 'Mejoras en locales arrendados', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (904, '39534', 'Maquinarias y equipos de explotación', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (905, '39535', 'Unidades de transporte', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (906, '39536', 'Muebles y enseres', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (907, '39537', 'Equipos diversos', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (908, '39538', 'Herramientas y unidades de reemplazo', 'Activo', 'Deudora', 1, 899, 5);
INSERT INTO cuenta VALUES (909, '3954', 'Propiedad, planta y equipo – Costo de financiación', 'Activo', 'Deudora', 1, 887, 4);
INSERT INTO cuenta VALUES (910, '39540', 'Plantas productoras', 'Activo', 'Deudora', 1, 909, 5);
INSERT INTO cuenta VALUES (911, '39541', 'Edificaciones', 'Activo', 'Deudora', 1, 909, 5);
INSERT INTO cuenta VALUES (912, '39542', 'Maquinarias y equipos de explotación', 'Activo', 'Deudora', 1, 909, 5);
INSERT INTO cuenta VALUES (913, '3955', 'Propiedad, planta y equipo – Valor razonable', 'Activo', 'Deudora', 1, 887, 4);
INSERT INTO cuenta VALUES (914, '39550', 'Plantas productoras', 'Activo', 'Deudora', 1, 913, 5);
INSERT INTO cuenta VALUES (915, '396', 'Amortización acumulada', 'Activo', 'Deudora', 1, 850, 3);
INSERT INTO cuenta VALUES (916, '3961', 'Intangibles – Costo', 'Activo', 'Deudora', 1, 915, 4);
INSERT INTO cuenta VALUES (917, '39611', 'Concesiones, licencias y otros derechos', 'Activo', 'Deudora', 1, 916, 5);
INSERT INTO cuenta VALUES (918, '39612', 'Patentes y propiedad industrial', 'Activo', 'Deudora', 1, 916, 5);
INSERT INTO cuenta VALUES (919, '39613', 'Programas de computadora (software)', 'Activo', 'Deudora', 1, 916, 5);
INSERT INTO cuenta VALUES (920, '39614', 'Costos de exploración y desarrollo', 'Activo', 'Deudora', 1, 916, 5);
INSERT INTO cuenta VALUES (921, '39615', 'Fórmulas, diseños y prototipos', 'Activo', 'Deudora', 1, 916, 5);
INSERT INTO cuenta VALUES (922, '39619', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 916, 5);
INSERT INTO cuenta VALUES (923, '3962', 'Intangibles – Revaluación', 'Activo', 'Deudora', 1, 915, 4);
INSERT INTO cuenta VALUES (924, '39621', 'Concesiones, licencias y otros derechos', 'Activo', 'Deudora', 1, 923, 5);
INSERT INTO cuenta VALUES (925, '39622', 'Patentes y propiedad industrial', 'Activo', 'Deudora', 1, 923, 5);
INSERT INTO cuenta VALUES (926, '39623', 'Programas de computadora (software)', 'Activo', 'Deudora', 1, 923, 5);
INSERT INTO cuenta VALUES (927, '39624', 'Costos de exploración y desarrollo', 'Activo', 'Deudora', 1, 923, 5);
INSERT INTO cuenta VALUES (928, '39625', 'Fórmulas, diseños y prototipos', 'Activo', 'Deudora', 1, 923, 5);
INSERT INTO cuenta VALUES (929, '39629', 'Otros activos intangibles', 'Activo', 'Deudora', 1, 923, 5);
INSERT INTO cuenta VALUES (930, '3963', 'Intangibles – Costos de financiación', 'Activo', 'Deudora', 1, 915, 4);
INSERT INTO cuenta VALUES (931, '39633', 'Programas de computadora', 'Activo', 'Deudora', 1, 930, 5);
INSERT INTO cuenta VALUES (932, '39634', 'Costos de exploración', 'Activo', 'Deudora', 1, 930, 5);
INSERT INTO cuenta VALUES (933, '39635', 'Costos de desarrollo', 'Activo', 'Deudora', 1, 930, 5);
INSERT INTO cuenta VALUES (934, '398', 'Depreciación acumulada – Activos biológicos en producción', 'Activo', 'Deudora', 1, 850, 3);
INSERT INTO cuenta VALUES (935, '3981', 'Activos biológicos en producción – Costo', 'Activo', 'Deudora', 1, 934, 4);
INSERT INTO cuenta VALUES (936, '39811', 'Activos biológicos en producción', 'Activo', 'Deudora', 1, 935, 5);
INSERT INTO cuenta VALUES (937, '4', 'PASIVO', 'Pasivo', 'Acreedora', 1, None, 1);
INSERT INTO cuenta VALUES (938, '40', 'TRIBUTOS, CONTRAPRESTACIONES Y APORTES AL SISTEMA PÚBLICO DE PENSIONES Y DE SALUD POR PAGAR', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (939, '401', 'Gobierno nacional', 'Pasivo', 'Acreedora', 1, 938, 3);
INSERT INTO cuenta VALUES (940, '4011', 'Impuesto general a las ventas', 'Pasivo', 'Acreedora', 1, 939, 4);
INSERT INTO cuenta VALUES (941, '40111', 'IGV – Cuenta propia', 'Pasivo', 'Acreedora', 1, 940, 5);
INSERT INTO cuenta VALUES (942, '40112', 'IGV – Servicios prestados por no domiciliados', 'Pasivo', 'Acreedora', 1, 940, 5);
INSERT INTO cuenta VALUES (943, '40113', 'IGV – Régimen de percepciones', 'Pasivo', 'Acreedora', 1, 940, 5);
INSERT INTO cuenta VALUES (944, '40114', 'IGV – Régimen de retenciones', 'Pasivo', 'Acreedora', 1, 940, 5);
INSERT INTO cuenta VALUES (945, '40115', 'IGV – Importaciones', 'Pasivo', 'Acreedora', 1, 940, 5);
INSERT INTO cuenta VALUES (946, '40116', 'IGV – Destinado a operaciones gravadas', 'Pasivo', 'Acreedora', 1, 940, 5);
INSERT INTO cuenta VALUES (947, '40117', 'IGV – Destinado a operaciones comunes', 'Pasivo', 'Acreedora', 1, 940, 5);
INSERT INTO cuenta VALUES (948, '4012', 'Impuesto selectivo al consumo', 'Pasivo', 'Acreedora', 1, 939, 4);
INSERT INTO cuenta VALUES (949, '4015', 'Derechos aduaneros', 'Pasivo', 'Acreedora', 1, 939, 4);
INSERT INTO cuenta VALUES (950, '40151', 'Derechos arancelarios', 'Pasivo', 'Acreedora', 1, 949, 5);
INSERT INTO cuenta VALUES (951, '40152', 'Otros derechos arancelarios', 'Pasivo', 'Acreedora', 1, 949, 5);
INSERT INTO cuenta VALUES (952, '4017', 'Impuesto a la renta', 'Pasivo', 'Acreedora', 1, 939, 4);
INSERT INTO cuenta VALUES (953, '40171', 'Renta de tercera categoría', 'Pasivo', 'Acreedora', 1, 952, 5);
INSERT INTO cuenta VALUES (954, '40172', 'Renta de cuarta categoría', 'Pasivo', 'Acreedora', 1, 952, 5);
INSERT INTO cuenta VALUES (955, '40173', 'Renta de quinta categoría', 'Pasivo', 'Acreedora', 1, 952, 5);
INSERT INTO cuenta VALUES (956, '40174', 'Renta de no domiciliados', 'Pasivo', 'Acreedora', 1, 952, 5);
INSERT INTO cuenta VALUES (957, '40175', 'Otras retenciones', 'Pasivo', 'Acreedora', 1, 952, 5);
INSERT INTO cuenta VALUES (958, '4018', 'Otros impuestos y contraprestaciones', 'Pasivo', 'Acreedora', 1, 939, 4);
INSERT INTO cuenta VALUES (959, '40181', 'Impuesto a las transacciones financieras', 'Pasivo', 'Acreedora', 1, 958, 5);
INSERT INTO cuenta VALUES (960, '40182', 'Impuesto a los juegos de casino y tragamonedas', 'Pasivo', 'Acreedora', 1, 958, 5);
INSERT INTO cuenta VALUES (961, '40183', 'Tasas por la prestación de servicios públicos', 'Pasivo', 'Acreedora', 1, 958, 5);
INSERT INTO cuenta VALUES (962, '40184', 'Regalías', 'Pasivo', 'Acreedora', 1, 958, 5);
INSERT INTO cuenta VALUES (963, '40185', 'Impuesto a los dividendos', 'Pasivo', 'Acreedora', 1, 958, 5);
INSERT INTO cuenta VALUES (964, '40186', 'Impuesto temporal a los activos netos', 'Pasivo', 'Acreedora', 1, 958, 5);
INSERT INTO cuenta VALUES (965, '40189', 'Otros impuestos', 'Pasivo', 'Acreedora', 1, 958, 5);
INSERT INTO cuenta VALUES (966, '402', 'Certificados tributarios', 'Pasivo', 'Acreedora', 1, 938, 3);
INSERT INTO cuenta VALUES (967, '403', 'Instituciones públicas', 'Pasivo', 'Acreedora', 1, 938, 3);
INSERT INTO cuenta VALUES (968, '4031', 'ESSALUD', 'Pasivo', 'Acreedora', 1, 967, 4);
INSERT INTO cuenta VALUES (969, '4032', 'ONP', 'Pasivo', 'Acreedora', 1, 967, 4);
INSERT INTO cuenta VALUES (970, '4033', 'Contribución al SENATI', 'Pasivo', 'Acreedora', 1, 967, 4);
INSERT INTO cuenta VALUES (971, '4034', 'Contribución al SENCICO', 'Pasivo', 'Acreedora', 1, 967, 4);
INSERT INTO cuenta VALUES (972, '4039', 'Otras instituciones', 'Pasivo', 'Acreedora', 1, 967, 4);
INSERT INTO cuenta VALUES (973, '405', 'Gobiernos regionales', 'Pasivo', 'Acreedora', 1, 938, 3);
INSERT INTO cuenta VALUES (974, '406', 'Gobiernos locales', 'Pasivo', 'Acreedora', 1, 938, 3);
INSERT INTO cuenta VALUES (975, '4061', 'Impuestos', 'Pasivo', 'Acreedora', 1, 974, 4);
INSERT INTO cuenta VALUES (976, '40611', 'Impuesto al patrimonio vehicular', 'Pasivo', 'Acreedora', 1, 975, 5);
INSERT INTO cuenta VALUES (977, '40612', 'Impuesto a las apuestas', 'Pasivo', 'Acreedora', 1, 975, 5);
INSERT INTO cuenta VALUES (978, '40613', 'Impuesto a los juegos', 'Pasivo', 'Acreedora', 1, 975, 5);
INSERT INTO cuenta VALUES (979, '40614', 'Impuesto de alcabala', 'Pasivo', 'Acreedora', 1, 975, 5);
INSERT INTO cuenta VALUES (980, '40615', 'Impuesto predial', 'Pasivo', 'Acreedora', 1, 975, 5);
INSERT INTO cuenta VALUES (981, '40616', 'Impuesto a los espectáculos públicos no deportivos', 'Pasivo', 'Acreedora', 1, 975, 5);
INSERT INTO cuenta VALUES (982, '4062', 'Contribuciones', 'Pasivo', 'Acreedora', 1, 974, 4);
INSERT INTO cuenta VALUES (983, '4063', 'Tasas', 'Pasivo', 'Acreedora', 1, 974, 4);
INSERT INTO cuenta VALUES (984, '40631', 'Licencia de apertura de establecimientos', 'Pasivo', 'Acreedora', 1, 983, 5);
INSERT INTO cuenta VALUES (985, '40632', 'Transporte público', 'Pasivo', 'Acreedora', 1, 983, 5);
INSERT INTO cuenta VALUES (986, '40633', 'Estacionamiento de vehículos', 'Pasivo', 'Acreedora', 1, 983, 5);
INSERT INTO cuenta VALUES (987, '40634', 'Servicios públicos o arbitrios', 'Pasivo', 'Acreedora', 1, 983, 5);
INSERT INTO cuenta VALUES (988, '40635', 'Servicios administrativos o derechos', 'Pasivo', 'Acreedora', 1, 983, 5);
INSERT INTO cuenta VALUES (989, '409', 'Otros costos administrativos e intereses', 'Pasivo', 'Acreedora', 1, 938, 3);
INSERT INTO cuenta VALUES (990, '41', 'REMUNERACIONES Y PARTICIPACIONES POR PAGAR', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (991, '411', 'Remuneraciones por pagar', 'Pasivo', 'Acreedora', 1, 990, 3);
INSERT INTO cuenta VALUES (992, '4111', 'Sueldos y salarios por pagar', 'Pasivo', 'Acreedora', 1, 991, 4);
INSERT INTO cuenta VALUES (993, '4112', 'Comisiones por pagar', 'Pasivo', 'Acreedora', 1, 991, 4);
INSERT INTO cuenta VALUES (994, '4113', 'Remuneraciones en especie por pagar', 'Pasivo', 'Acreedora', 1, 991, 4);
INSERT INTO cuenta VALUES (995, '4114', 'Gratificaciones por pagar', 'Pasivo', 'Acreedora', 1, 991, 4);
INSERT INTO cuenta VALUES (996, '4115', 'Vacaciones por pagar', 'Pasivo', 'Acreedora', 1, 991, 4);
INSERT INTO cuenta VALUES (997, '413', 'Participaciones de los trabajadores por pagar', 'Pasivo', 'Acreedora', 1, 990, 3);
INSERT INTO cuenta VALUES (998, '415', 'Beneficios sociales de los trabajadores por pagar', 'Pasivo', 'Acreedora', 1, 990, 3);
INSERT INTO cuenta VALUES (999, '4151', 'Compensación por tiempo de servicios', 'Pasivo', 'Acreedora', 1, 998, 4);
INSERT INTO cuenta VALUES (1000, '4152', 'Adelanto de compensación por tiempo de servicios', 'Pasivo', 'Acreedora', 1, 998, 4);
INSERT INTO cuenta VALUES (1001, '4153', 'Pensiones y jubilaciones', 'Pasivo', 'Acreedora', 1, 998, 4);
INSERT INTO cuenta VALUES (1002, '417', 'Administradoras de fondos de pensiones', 'Pasivo', 'Acreedora', 1, 990, 3);
INSERT INTO cuenta VALUES (1003, '419', 'Otras remuneraciones y participaciones por pagar', 'Pasivo', 'Acreedora', 1, 990, 3);
INSERT INTO cuenta VALUES (1004, '42', 'CUENTAS POR PAGAR COMERCIALES TERCEROS', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1005, '421', 'Facturas, boletas y otros comprobantes por pagar', 'Pasivo', 'Acreedora', 1, 1004, 3);
INSERT INTO cuenta VALUES (1006, '4211', 'No emitidas', 'Pasivo', 'Acreedora', 1, 1005, 4);
INSERT INTO cuenta VALUES (1007, '4212', 'Emitidas', 'Pasivo', 'Acreedora', 1, 1005, 4);
INSERT INTO cuenta VALUES (1008, '422', 'Anticipos a proveedores', 'Pasivo', 'Acreedora', 1, 1004, 3);
INSERT INTO cuenta VALUES (1009, '423', 'Letras por pagar', 'Pasivo', 'Acreedora', 1, 1004, 3);
INSERT INTO cuenta VALUES (1010, '424', 'Honorarios por pagar', 'Pasivo', 'Acreedora', 1, 1004, 3);
INSERT INTO cuenta VALUES (1011, '43', 'CUENTAS POR PAGAR COMERCIALES RELACIONADAS', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1012, '431', 'Facturas, boletas y otros comprobantes por pagar', 'Pasivo', 'Acreedora', 1, 1011, 3);
INSERT INTO cuenta VALUES (1013, '4311', 'No emitidas', 'Pasivo', 'Acreedora', 1, 1012, 4);
INSERT INTO cuenta VALUES (1014, '4312', 'Emitidas', 'Pasivo', 'Acreedora', 1, 1012, 4);
INSERT INTO cuenta VALUES (1015, '432', 'Anticipos otorgados', 'Pasivo', 'Acreedora', 1, 1011, 3);
INSERT INTO cuenta VALUES (1016, '4321', 'Anticipos otorgados', 'Pasivo', 'Acreedora', 1, 1015, 4);
INSERT INTO cuenta VALUES (1017, '433', 'Letras por pagar', 'Pasivo', 'Acreedora', 1, 1011, 3);
INSERT INTO cuenta VALUES (1018, '4331', 'Letras por pagar', 'Pasivo', 'Acreedora', 1, 1017, 4);
INSERT INTO cuenta VALUES (1019, '434', 'Honorarios por pagar', 'Pasivo', 'Acreedora', 1, 1011, 3);
INSERT INTO cuenta VALUES (1020, '4341', 'Honorarios por pagar', 'Pasivo', 'Acreedora', 1, 1019, 4);
INSERT INTO cuenta VALUES (1021, '44', 'CUENTAS POR PAGAR A LOS ACCIONISTAS (SOCIOS, PARTÍCIPES) Y DIRECTORES', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1022, '441', 'Accionistas (socios, partícipes)', 'Pasivo', 'Acreedora', 1, 1021, 3);
INSERT INTO cuenta VALUES (1023, '4411', 'Préstamos', 'Pasivo', 'Acreedora', 1, 1022, 4);
INSERT INTO cuenta VALUES (1024, '4412', 'Dividendos', 'Pasivo', 'Acreedora', 1, 1022, 4);
INSERT INTO cuenta VALUES (1025, '4419', 'Otras cuentas por pagar', 'Pasivo', 'Acreedora', 1, 1022, 4);
INSERT INTO cuenta VALUES (1026, '442', 'Directores', 'Pasivo', 'Acreedora', 1, 1021, 3);
INSERT INTO cuenta VALUES (1027, '4421', 'Dietas', 'Pasivo', 'Acreedora', 1, 1026, 4);
INSERT INTO cuenta VALUES (1028, '4429', 'Otras cuentas por pagar', 'Pasivo', 'Acreedora', 1, 1026, 4);
INSERT INTO cuenta VALUES (1029, '45', 'OBLIGACIONES FINANCIERAS', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1030, '451', 'Préstamos de instituciones financieras y otras entidades', 'Pasivo', 'Acreedora', 1, 1029, 3);
INSERT INTO cuenta VALUES (1031, '4511', 'Instituciones financieras', 'Pasivo', 'Acreedora', 1, 1030, 4);
INSERT INTO cuenta VALUES (1032, '4512', 'Otras entidades', 'Pasivo', 'Acreedora', 1, 1030, 4);
INSERT INTO cuenta VALUES (1033, '452', 'Contratos de arrendamiento financiero', 'Pasivo', 'Acreedora', 1, 1029, 3);
INSERT INTO cuenta VALUES (1034, '453', 'Obligaciones emitidas', 'Pasivo', 'Acreedora', 1, 1029, 3);
INSERT INTO cuenta VALUES (1035, '4531', 'Bonos emitidos', 'Pasivo', 'Acreedora', 1, 1034, 4);
INSERT INTO cuenta VALUES (1036, '4532', 'Bonos titulizados', 'Pasivo', 'Acreedora', 1, 1034, 4);
INSERT INTO cuenta VALUES (1037, '4533', 'Papeles comerciales', 'Pasivo', 'Acreedora', 1, 1034, 4);
INSERT INTO cuenta VALUES (1038, '4539', 'Otras obligaciones', 'Pasivo', 'Acreedora', 1, 1034, 4);
INSERT INTO cuenta VALUES (1039, '454', 'Otros Instrumentos financieros por pagar', 'Pasivo', 'Acreedora', 1, 1029, 3);
INSERT INTO cuenta VALUES (1040, '4541', 'Letras', 'Pasivo', 'Acreedora', 1, 1039, 4);
INSERT INTO cuenta VALUES (1041, '4542', 'Papeles comerciales', 'Pasivo', 'Acreedora', 1, 1039, 4);
INSERT INTO cuenta VALUES (1042, '4543', 'Bonos', 'Pasivo', 'Acreedora', 1, 1039, 4);
INSERT INTO cuenta VALUES (1043, '4544', 'Pagarés', 'Pasivo', 'Acreedora', 1, 1039, 4);
INSERT INTO cuenta VALUES (1044, '4545', 'Facturas conformadas', 'Pasivo', 'Acreedora', 1, 1039, 4);
INSERT INTO cuenta VALUES (1045, '4549', 'Otras obligaciones financieras', 'Pasivo', 'Acreedora', 1, 1039, 4);
INSERT INTO cuenta VALUES (1046, '455', 'Costos de financiación por pagar', 'Pasivo', 'Acreedora', 1, 1029, 3);
INSERT INTO cuenta VALUES (1047, '4551', 'Préstamos de instituciones financieras y otras entidades', 'Pasivo', 'Acreedora', 1, 1046, 4);
INSERT INTO cuenta VALUES (1048, '45511', 'Instituciones financieras', 'Pasivo', 'Acreedora', 1, 1047, 5);
INSERT INTO cuenta VALUES (1049, '45512', 'Otras entidades', 'Pasivo', 'Acreedora', 1, 1047, 5);
INSERT INTO cuenta VALUES (1050, '4552', 'Contratos de arrendamiento financiero', 'Pasivo', 'Acreedora', 1, 1046, 4);
INSERT INTO cuenta VALUES (1051, '4553', 'Obligaciones emitidas', 'Pasivo', 'Acreedora', 1, 1046, 4);
INSERT INTO cuenta VALUES (1052, '45531', 'Bonos emitidos', 'Pasivo', 'Acreedora', 1, 1051, 5);
INSERT INTO cuenta VALUES (1053, '45532', 'Bonos titulizados', 'Pasivo', 'Acreedora', 1, 1051, 5);
INSERT INTO cuenta VALUES (1054, '45533', 'Papeles comerciales', 'Pasivo', 'Acreedora', 1, 1051, 5);
INSERT INTO cuenta VALUES (1055, '45539', 'Otras obligaciones', 'Pasivo', 'Acreedora', 1, 1051, 5);
INSERT INTO cuenta VALUES (1056, '4554', 'Otros instrumentos financieros por pagar', 'Pasivo', 'Acreedora', 1, 1046, 4);
INSERT INTO cuenta VALUES (1057, '45541', 'Letras', 'Pasivo', 'Acreedora', 1, 1056, 5);
INSERT INTO cuenta VALUES (1058, '45542', 'Papeles comerciales', 'Pasivo', 'Acreedora', 1, 1056, 5);
INSERT INTO cuenta VALUES (1059, '45543', 'Bonos', 'Pasivo', 'Acreedora', 1, 1056, 5);
INSERT INTO cuenta VALUES (1060, '45544', 'Pagarés', 'Pasivo', 'Acreedora', 1, 1056, 5);
INSERT INTO cuenta VALUES (1061, '45545', 'Facturas conformadas', 'Pasivo', 'Acreedora', 1, 1056, 5);
INSERT INTO cuenta VALUES (1062, '45549', 'Otras obligaciones financieras', 'Pasivo', 'Acreedora', 1, 1056, 5);
INSERT INTO cuenta VALUES (1063, '456', 'Préstamos con compromisos de recompra', 'Pasivo', 'Acreedora', 1, 1029, 3);
INSERT INTO cuenta VALUES (1064, '46', 'CUENTAS POR PAGAR DIVERSAS – TERCEROS', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1065, '461', 'Reclamaciones de terceros', 'Pasivo', 'Acreedora', 1, 1064, 3);
INSERT INTO cuenta VALUES (1066, '464', 'Pasivos por instrumentos financieros', 'Pasivo', 'Acreedora', 1, 1064, 3);
INSERT INTO cuenta VALUES (1067, '4641', 'Instrumentos financieros primarios', 'Pasivo', 'Acreedora', 1, 1066, 4);
INSERT INTO cuenta VALUES (1068, '4642', 'Instrumentos financieros derivados', 'Pasivo', 'Acreedora', 1, 1066, 4);
INSERT INTO cuenta VALUES (1069, '46421', 'Cartera de negociación', 'Pasivo', 'Acreedora', 1, 1068, 5);
INSERT INTO cuenta VALUES (1070, '46422', 'Instrumentos de cobertura', 'Pasivo', 'Acreedora', 1, 1068, 5);
INSERT INTO cuenta VALUES (1071, '465', 'Pasivos por compra de activo inmovilizado', 'Pasivo', 'Acreedora', 1, 1064, 3);
INSERT INTO cuenta VALUES (1072, '4651', 'Inversiones mobiliarias', 'Pasivo', 'Acreedora', 1, 1071, 4);
INSERT INTO cuenta VALUES (1073, '4652', 'Propiedades de inversión', 'Pasivo', 'Acreedora', 1, 1071, 4);
INSERT INTO cuenta VALUES (1074, '4653', 'Activos adquiridos en arrendamiento financiero', 'Pasivo', 'Acreedora', 1, 1071, 4);
INSERT INTO cuenta VALUES (1075, '4654', 'Propiedad, planta y equipo', 'Pasivo', 'Acreedora', 1, 1071, 4);
INSERT INTO cuenta VALUES (1076, '4655', 'Intangibles', 'Pasivo', 'Acreedora', 1, 1071, 4);
INSERT INTO cuenta VALUES (1077, '4656', 'Activos biológicos', 'Pasivo', 'Acreedora', 1, 1071, 4);
INSERT INTO cuenta VALUES (1078, '466', 'Participación de terceros en acuerdos conjuntos', 'Pasivo', 'Acreedora', 1, 1064, 3);
INSERT INTO cuenta VALUES (1079, '467', 'Depósitos recibidos en garantía', 'Pasivo', 'Acreedora', 1, 1064, 3);
INSERT INTO cuenta VALUES (1080, '469', 'Otras cuentas por pagar diversas', 'Pasivo', 'Acreedora', 1, 1064, 3);
INSERT INTO cuenta VALUES (1081, '4691', 'Subsidios gubernamentales', 'Pasivo', 'Acreedora', 1, 1080, 4);
INSERT INTO cuenta VALUES (1082, '4692', 'Donaciones condicionadas', 'Pasivo', 'Acreedora', 1, 1080, 4);
INSERT INTO cuenta VALUES (1083, '4699', 'Otras cuentas por pagar', 'Pasivo', 'Acreedora', 1, 1080, 4);
INSERT INTO cuenta VALUES (1084, '47', 'CUENTAS POR PAGAR DIVERSAS – RELACIONADAS', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1085, '471', 'Préstamos', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1086, '472', 'Costos de financiación', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1087, '473', 'Anticipos recibidos', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1088, '474', 'Regalías', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1089, '475', 'Dividendos', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1090, '476', 'Depósitos recibidos en garantía', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1091, '477', 'Pasivo por compra de activo inmovilizado', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1092, '4771', 'Inversiones mobiliarias', 'Pasivo', 'Acreedora', 1, 1091, 4);
INSERT INTO cuenta VALUES (1093, '4772', 'Inversiones inmobiliarias', 'Pasivo', 'Acreedora', 1, 1091, 4);
INSERT INTO cuenta VALUES (1094, '4773', 'Activos adquiridos en arrendamiento financiero', 'Pasivo', 'Acreedora', 1, 1091, 4);
INSERT INTO cuenta VALUES (1095, '4774', 'Propiedad, planta y equipo', 'Pasivo', 'Acreedora', 1, 1091, 4);
INSERT INTO cuenta VALUES (1096, '4775', 'Intangibles', 'Pasivo', 'Acreedora', 1, 1091, 4);
INSERT INTO cuenta VALUES (1097, '4776', 'Activos biológicos', 'Pasivo', 'Acreedora', 1, 1091, 4);
INSERT INTO cuenta VALUES (1098, '479', 'Otras cuentas por pagar diversas', 'Pasivo', 'Acreedora', 1, 1084, 3);
INSERT INTO cuenta VALUES (1099, '4791', 'Otras cuentas por pagar diversas', 'Pasivo', 'Acreedora', 1, 1098, 4);
INSERT INTO cuenta VALUES (1100, '48', 'PROVISIONES', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1101, '481', 'Provisión para litigios', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1102, '482', 'Provisión por desmantelamiento, retiro o rehabilitación del inmovilizado', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1103, '483', 'Provisión para reestructuraciones', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1104, '484', 'Provisión para protección y remediación del medio ambiente', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1105, '485', 'Provisión para gastos de responsabilidad social', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1106, '486', 'Provisión para garantías', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1107, '487', 'Provisión por activos por derecho de uso', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1108, '489', 'Otras provisiones', 'Pasivo', 'Acreedora', 1, 1100, 3);
INSERT INTO cuenta VALUES (1109, '49', 'PASIVO DIFERIDO', 'Pasivo', 'Acreedora', 1, 937, 2);
INSERT INTO cuenta VALUES (1110, '491', 'Impuesto a la renta diferido', 'Pasivo', 'Acreedora', 1, 1109, 3);
INSERT INTO cuenta VALUES (1111, '4911', 'Impuesto a la renta diferido – Patrimonio', 'Pasivo', 'Acreedora', 1, 1110, 4);
INSERT INTO cuenta VALUES (1112, '4912', 'Impuesto a la renta diferido – Resultados', 'Pasivo', 'Acreedora', 1, 1110, 4);
INSERT INTO cuenta VALUES (1113, '492', 'Participaciones de los trabajadores diferidas', 'Pasivo', 'Acreedora', 1, 1109, 3);
INSERT INTO cuenta VALUES (1114, '4921', 'Participaciones de los trabajadores diferidas – Patrimonio', 'Pasivo', 'Acreedora', 1, 1113, 4);
INSERT INTO cuenta VALUES (1115, '4922', 'Participaciones de los trabajadores diferidas – Resultados', 'Pasivo', 'Acreedora', 1, 1113, 4);
INSERT INTO cuenta VALUES (1116, '493', 'Intereses diferidos', 'Pasivo', 'Acreedora', 1, 1109, 3);
INSERT INTO cuenta VALUES (1117, '4931', 'Intereses no devengados en transacciones con terceros', 'Pasivo', 'Acreedora', 1, 1116, 4);
INSERT INTO cuenta VALUES (1118, '4932', 'Intereses no devengados en medición a valor descontado', 'Pasivo', 'Acreedora', 1, 1116, 4);
INSERT INTO cuenta VALUES (1119, '494', 'Ganancia en venta con arrendamiento financiero paralelo', 'Pasivo', 'Acreedora', 1, 1109, 3);
INSERT INTO cuenta VALUES (1120, '495', 'Subsidios recibidos diferidos', 'Pasivo', 'Acreedora', 1, 1109, 3);
INSERT INTO cuenta VALUES (1121, '496', 'Ingresos diferidos', 'Pasivo', 'Acreedora', 1, 1109, 3);
INSERT INTO cuenta VALUES (1122, '497', 'Costos diferidos', 'Pasivo', 'Acreedora', 1, 1109, 3);
INSERT INTO cuenta VALUES (1123, '5', 'PATRIMONIO NETO', 'Patrimonio Neto', 'Acreedora', 1, None, 1);
INSERT INTO cuenta VALUES (1124, '50', 'CAPITAL', 'Patrimonio Neto', 'Acreedora', 1, 1123, 2);
INSERT INTO cuenta VALUES (1125, '501', 'Capital social', 'Patrimonio Neto', 'Acreedora', 1, 1124, 3);
INSERT INTO cuenta VALUES (1126, '5011', 'Acciones', 'Patrimonio Neto', 'Acreedora', 1, 1125, 4);
INSERT INTO cuenta VALUES (1127, '5012', 'Participaciones', 'Patrimonio Neto', 'Acreedora', 1, 1125, 4);
INSERT INTO cuenta VALUES (1128, '502', 'Acciones en tesorería', 'Patrimonio Neto', 'Acreedora', 1, 1124, 3);
INSERT INTO cuenta VALUES (1129, '51', 'ACCIONES DE INVERSIÓN', 'Patrimonio Neto', 'Acreedora', 1, 1123, 2);
INSERT INTO cuenta VALUES (1130, '511', 'Acciones de inversión', 'Patrimonio Neto', 'Acreedora', 1, 1129, 3);
INSERT INTO cuenta VALUES (1131, '512', 'Acciones de inversión en tesorería', 'Patrimonio Neto', 'Acreedora', 1, 1129, 3);
INSERT INTO cuenta VALUES (1132, '52', 'CAPITAL ADICIONAL', 'Patrimonio Neto', 'Acreedora', 1, 1123, 2);
INSERT INTO cuenta VALUES (1133, '521', 'Primas (descuento) de acciones', 'Patrimonio Neto', 'Acreedora', 1, 1132, 3);
INSERT INTO cuenta VALUES (1134, '522', 'Capitalizaciones en trámite', 'Patrimonio Neto', 'Acreedora', 1, 1132, 3);
INSERT INTO cuenta VALUES (1135, '5221', 'Aportes', 'Patrimonio Neto', 'Acreedora', 1, 1134, 4);
INSERT INTO cuenta VALUES (1136, '5222', 'Reservas', 'Patrimonio Neto', 'Acreedora', 1, 1134, 4);
INSERT INTO cuenta VALUES (1137, '5223', 'Acreencias', 'Patrimonio Neto', 'Acreedora', 1, 1134, 4);
INSERT INTO cuenta VALUES (1138, '5224', 'Utilidades', 'Patrimonio Neto', 'Acreedora', 1, 1134, 4);
INSERT INTO cuenta VALUES (1139, '523', 'Reducciones de capital pendientes de formalización', 'Patrimonio Neto', 'Acreedora', 1, 1132, 3);
INSERT INTO cuenta VALUES (1140, '56', 'RESULTADOS NO REALIZADOS', 'Patrimonio Neto', 'Acreedora', 1, 1123, 2);
INSERT INTO cuenta VALUES (1141, '561', 'Diferencia en cambio de inversiones permanentes en entidades extranjeras', 'Patrimonio Neto', 'Acreedora', 1, 1140, 3);
INSERT INTO cuenta VALUES (1142, '562', 'Instrumentos financieros – Coberturas', 'Patrimonio Neto', 'Acreedora', 1, 1140, 3);
INSERT INTO cuenta VALUES (1143, '563', 'Resultado en activos o pasivos financieros mantenidos para negociación', 'Patrimonio Neto', 'Acreedora', 1, 1140, 3);
INSERT INTO cuenta VALUES (1144, '5631', 'Ganancia', 'Patrimonio Neto', 'Acreedora', 1, 1143, 4);
INSERT INTO cuenta VALUES (1145, '5632', 'Pérdida', 'Patrimonio Neto', 'Acreedora', 1, 1143, 4);
INSERT INTO cuenta VALUES (1146, '564', 'Resultado en otros activos o pasivos por inversiones financieras', 'Patrimonio Neto', 'Acreedora', 1, 1140, 3);
INSERT INTO cuenta VALUES (1147, '5641', 'Ganancia', 'Patrimonio Neto', 'Acreedora', 1, 1146, 4);
INSERT INTO cuenta VALUES (1148, '5642', 'Pérdida', 'Patrimonio Neto', 'Acreedora', 1, 1146, 4);
INSERT INTO cuenta VALUES (1149, '565', 'Resultado en activos o pasivos financieros mantenidos para negociación – Compra o venta convencional fecha de liquidación', 'Patrimonio Neto', 'Acreedora', 1, 1140, 3);
INSERT INTO cuenta VALUES (1150, '5651', 'Ganancia', 'Patrimonio Neto', 'Acreedora', 1, 1149, 4);
INSERT INTO cuenta VALUES (1151, '5652', 'Pérdida', 'Patrimonio Neto', 'Acreedora', 1, 1149, 4);
INSERT INTO cuenta VALUES (1152, '57', 'EXCEDENTE DE REVALUACIÓN', 'Patrimonio Neto', 'Acreedora', 1, 1123, 2);
INSERT INTO cuenta VALUES (1153, '571', 'Excedente de revaluación', 'Patrimonio Neto', 'Acreedora', 1, 1152, 3);
INSERT INTO cuenta VALUES (1154, '5711', 'Propiedad de inversión', 'Patrimonio Neto', 'Acreedora', 1, 1153, 4);
INSERT INTO cuenta VALUES (1155, '57111', 'Adquisición directa', 'Patrimonio Neto', 'Acreedora', 1, 1154, 5);
INSERT INTO cuenta VALUES (1156, '57112', 'Arrendamiento financiero', 'Patrimonio Neto', 'Acreedora', 1, 1154, 5);
INSERT INTO cuenta VALUES (1157, '5712', 'Propiedad, planta y equipo', 'Patrimonio Neto', 'Acreedora', 1, 1153, 4);
INSERT INTO cuenta VALUES (1158, '57121', 'Adquisición directa', 'Patrimonio Neto', 'Acreedora', 1, 1157, 5);
INSERT INTO cuenta VALUES (1159, '57122', 'Arrendamiento financiero', 'Patrimonio Neto', 'Acreedora', 1, 1157, 5);
INSERT INTO cuenta VALUES (1160, '5713', 'Intangibles', 'Patrimonio Neto', 'Acreedora', 1, 1153, 4);
INSERT INTO cuenta VALUES (1161, '5714', 'Activos por derecho de uso – arrendamiento operativo', 'Patrimonio Neto', 'Acreedora', 1, 1153, 4);
INSERT INTO cuenta VALUES (1162, '572', 'Excedente de revaluación – Acciones liberadas recibidas', 'Patrimonio Neto', 'Acreedora', 1, 1152, 3);
INSERT INTO cuenta VALUES (1163, '573', 'Participación en excedente de revaluación – Inversiones en entidades relacionadas', 'Patrimonio Neto', 'Acreedora', 1, 1152, 3);
INSERT INTO cuenta VALUES (1164, '58', 'RESERVAS', 'Patrimonio Neto', 'Acreedora', 1, 1123, 2);
INSERT INTO cuenta VALUES (1165, '581', 'Reinversión', 'Patrimonio Neto', 'Acreedora', 1, 1164, 3);
INSERT INTO cuenta VALUES (1166, '582', 'Legal', 'Patrimonio Neto', 'Acreedora', 1, 1164, 3);
INSERT INTO cuenta VALUES (1167, '583', 'Contractuales', 'Patrimonio Neto', 'Acreedora', 1, 1164, 3);
INSERT INTO cuenta VALUES (1168, '584', 'Estatutarias', 'Patrimonio Neto', 'Acreedora', 1, 1164, 3);
INSERT INTO cuenta VALUES (1169, '585', 'Facultativas', 'Patrimonio Neto', 'Acreedora', 1, 1164, 3);
INSERT INTO cuenta VALUES (1170, '589', 'Otras reservas', 'Patrimonio Neto', 'Acreedora', 1, 1164, 3);
INSERT INTO cuenta VALUES (1171, '59', 'RESULTADOS ACUMULADOS', 'Patrimonio Neto', 'Acreedora', 1, 1123, 2);
INSERT INTO cuenta VALUES (1172, '591', 'Utilidades no distribuidas', 'Patrimonio Neto', 'Acreedora', 1, 1171, 3);
INSERT INTO cuenta VALUES (1173, '5911', 'Utilidades acumuladas', 'Patrimonio Neto', 'Acreedora', 1, 1172, 4);
INSERT INTO cuenta VALUES (1174, '5912', 'Ingresos de años anteriores', 'Patrimonio Neto', 'Acreedora', 1, 1172, 4);
INSERT INTO cuenta VALUES (1175, '592', 'Pérdidas acumuladas', 'Patrimonio Neto', 'Acreedora', 1, 1171, 3);
INSERT INTO cuenta VALUES (1176, '5921', 'Pérdidas acumuladas', 'Patrimonio Neto', 'Acreedora', 1, 1175, 4);
INSERT INTO cuenta VALUES (1177, '5922', 'Gastos de años anteriores', 'Patrimonio Neto', 'Acreedora', 1, 1175, 4);
INSERT INTO cuenta VALUES (1178, '6', 'GASTOS POR NATURALEZA', 'Gastos por Naturaleza', 'Deudora', 1, None, 1);
INSERT INTO cuenta VALUES (1179, '60', 'COMPRAS', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1180, '601', 'Mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1179, 3);
INSERT INTO cuenta VALUES (1181, '6011', 'Mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1180, 4);
INSERT INTO cuenta VALUES (1182, '602', 'Materias primas', 'Gastos por Naturaleza', 'Deudora', 1, 1179, 3);
INSERT INTO cuenta VALUES (1183, '603', 'Materiales auxiliares, suministros y repuestos', 'Gastos por Naturaleza', 'Deudora', 1, 1179, 3);
INSERT INTO cuenta VALUES (1184, '6031', 'Materiales auxiliares', 'Gastos por Naturaleza', 'Deudora', 1, 1183, 4);
INSERT INTO cuenta VALUES (1185, '6032', 'Suministros', 'Gastos por Naturaleza', 'Deudora', 1, 1183, 4);
INSERT INTO cuenta VALUES (1186, '6033', 'Repuestos', 'Gastos por Naturaleza', 'Deudora', 1, 1183, 4);
INSERT INTO cuenta VALUES (1187, '604', 'Envases y embalajes', 'Gastos por Naturaleza', 'Deudora', 1, 1179, 3);
INSERT INTO cuenta VALUES (1188, '6041', 'Envases', 'Gastos por Naturaleza', 'Deudora', 1, 1187, 4);
INSERT INTO cuenta VALUES (1189, '6042', 'Embalajes', 'Gastos por Naturaleza', 'Deudora', 1, 1187, 4);
INSERT INTO cuenta VALUES (1190, '609', 'Costos vinculados con las compras', 'Gastos por Naturaleza', 'Deudora', 1, 1179, 3);
INSERT INTO cuenta VALUES (1191, '6091', 'Costos vinculados con las compras de mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1190, 4);
INSERT INTO cuenta VALUES (1192, '60911', 'Transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1191, 5);
INSERT INTO cuenta VALUES (1193, '60912', 'Seguros', 'Gastos por Naturaleza', 'Deudora', 1, 1191, 5);
INSERT INTO cuenta VALUES (1194, '60913', 'Derechos aduaneros', 'Gastos por Naturaleza', 'Deudora', 1, 1191, 5);
INSERT INTO cuenta VALUES (1195, '60914', 'Comisiones', 'Gastos por Naturaleza', 'Deudora', 1, 1191, 5);
INSERT INTO cuenta VALUES (1196, '60919', 'Otros costos', 'Gastos por Naturaleza', 'Deudora', 1, 1191, 5);
INSERT INTO cuenta VALUES (1197, '6092', 'Costos vinculados con las compras de materias primas', 'Gastos por Naturaleza', 'Deudora', 1, 1190, 4);
INSERT INTO cuenta VALUES (1198, '60921', 'Transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1197, 5);
INSERT INTO cuenta VALUES (1199, '60922', 'Seguros', 'Gastos por Naturaleza', 'Deudora', 1, 1197, 5);
INSERT INTO cuenta VALUES (1200, '60923', 'Derechos aduaneros', 'Gastos por Naturaleza', 'Deudora', 1, 1197, 5);
INSERT INTO cuenta VALUES (1201, '60924', 'Comisiones', 'Gastos por Naturaleza', 'Deudora', 1, 1197, 5);
INSERT INTO cuenta VALUES (1202, '60925', 'Otros costos', 'Gastos por Naturaleza', 'Deudora', 1, 1197, 5);
INSERT INTO cuenta VALUES (1203, '6093', 'Costos vinculados con las compras de materiales, suministros y repuestos', 'Gastos por Naturaleza', 'Deudora', 1, 1190, 4);
INSERT INTO cuenta VALUES (1204, '60931', 'Transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1203, 5);
INSERT INTO cuenta VALUES (1205, '60932', 'Seguros', 'Gastos por Naturaleza', 'Deudora', 1, 1203, 5);
INSERT INTO cuenta VALUES (1206, '60933', 'Derechos aduaneros', 'Gastos por Naturaleza', 'Deudora', 1, 1203, 5);
INSERT INTO cuenta VALUES (1207, '60934', 'Comisiones', 'Gastos por Naturaleza', 'Deudora', 1, 1203, 5);
INSERT INTO cuenta VALUES (1208, '60935', 'Otros costos', 'Gastos por Naturaleza', 'Deudora', 1, 1203, 5);
INSERT INTO cuenta VALUES (1209, '6094', 'Costos vinculados con las compras de envases y embalajes', 'Gastos por Naturaleza', 'Deudora', 1, 1190, 4);
INSERT INTO cuenta VALUES (1210, '60941', 'Transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1209, 5);
INSERT INTO cuenta VALUES (1211, '60942', 'Seguros', 'Gastos por Naturaleza', 'Deudora', 1, 1209, 5);
INSERT INTO cuenta VALUES (1212, '60943', 'Derechos aduaneros', 'Gastos por Naturaleza', 'Deudora', 1, 1209, 5);
INSERT INTO cuenta VALUES (1213, '60944', 'Comisiones', 'Gastos por Naturaleza', 'Deudora', 1, 1209, 5);
INSERT INTO cuenta VALUES (1214, '60945', 'Otros costos', 'Gastos por Naturaleza', 'Deudora', 1, 1209, 5);
INSERT INTO cuenta VALUES (1215, '61', 'VARIACIÓN DE INVENTARIOS', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1216, '611', 'Mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1215, 3);
INSERT INTO cuenta VALUES (1217, '6111', 'Mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1216, 4);
INSERT INTO cuenta VALUES (1218, '612', 'Materias primas', 'Gastos por Naturaleza', 'Deudora', 1, 1215, 3);
INSERT INTO cuenta VALUES (1219, '6121', 'Materias primas', 'Gastos por Naturaleza', 'Deudora', 1, 1218, 4);
INSERT INTO cuenta VALUES (1220, '613', 'Materiales auxiliares, suministros y repuestos', 'Gastos por Naturaleza', 'Deudora', 1, 1215, 3);
INSERT INTO cuenta VALUES (1221, '6131', 'Materiales auxiliares', 'Gastos por Naturaleza', 'Deudora', 1, 1220, 4);
INSERT INTO cuenta VALUES (1222, '6132', 'Suministros', 'Gastos por Naturaleza', 'Deudora', 1, 1220, 4);
INSERT INTO cuenta VALUES (1223, '6133', 'Repuestos', 'Gastos por Naturaleza', 'Deudora', 1, 1220, 4);
INSERT INTO cuenta VALUES (1224, '614', 'Envases y embalajes', 'Gastos por Naturaleza', 'Deudora', 1, 1215, 3);
INSERT INTO cuenta VALUES (1225, '6141', 'Envases', 'Gastos por Naturaleza', 'Deudora', 1, 1224, 4);
INSERT INTO cuenta VALUES (1226, '6142', 'Embalajes', 'Gastos por Naturaleza', 'Deudora', 1, 1224, 4);
INSERT INTO cuenta VALUES (1227, '62', 'GASTOS DE PERSONAL Y DIRECTORES', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1228, '621', 'Remuneraciones', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1229, '6211', 'Sueldos y salarios', 'Gastos por Naturaleza', 'Deudora', 1, 1228, 4);
INSERT INTO cuenta VALUES (1230, '6212', 'Comisiones', 'Gastos por Naturaleza', 'Deudora', 1, 1228, 4);
INSERT INTO cuenta VALUES (1231, '6213', 'Remuneraciones en especie', 'Gastos por Naturaleza', 'Deudora', 1, 1228, 4);
INSERT INTO cuenta VALUES (1232, '6214', 'Gratificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1228, 4);
INSERT INTO cuenta VALUES (1233, '6215', 'Vacaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1228, 4);
INSERT INTO cuenta VALUES (1234, '622', 'Otras remuneraciones', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1235, '623', 'Indemnizaciones al personal', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1236, '624', 'Capacitación', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1237, '625', 'Atención al personal', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1238, '627', 'Seguridad, previsión social y otras contribuciones', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1239, '6271', 'Régimen de prestaciones de salud', 'Gastos por Naturaleza', 'Deudora', 1, 1238, 4);
INSERT INTO cuenta VALUES (1240, '6272', 'Régimen de pensiones – Aporte de empresa', 'Gastos por Naturaleza', 'Deudora', 1, 1238, 4);
INSERT INTO cuenta VALUES (1241, '6273', 'Seguro complementario de trabajo de riesgo, accidentes de trabajo y enfermedades profesionales', 'Gastos por Naturaleza', 'Deudora', 1, 1238, 4);
INSERT INTO cuenta VALUES (1242, '6274', 'Seguro de vida', 'Gastos por Naturaleza', 'Deudora', 1, 1238, 4);
INSERT INTO cuenta VALUES (1243, '6275', 'Seguros particulares de prestaciones de salud – EPS y otros particulares', 'Gastos por Naturaleza', 'Deudora', 1, 1238, 4);
INSERT INTO cuenta VALUES (1244, '6276', 'Caja de beneficios de seguridad social del pescador', 'Gastos por Naturaleza', 'Deudora', 1, 1238, 4);
INSERT INTO cuenta VALUES (1245, '6277', 'Contribuciones al SENATI', 'Gastos por Naturaleza', 'Deudora', 1, 1238, 4);
INSERT INTO cuenta VALUES (1246, '628', 'Retribuciones al directorio', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1247, '629', 'Beneficios sociales de los trabajadores', 'Gastos por Naturaleza', 'Deudora', 1, 1227, 3);
INSERT INTO cuenta VALUES (1248, '6291', 'Compensación por tiempo de servicio', 'Gastos por Naturaleza', 'Deudora', 1, 1247, 4);
INSERT INTO cuenta VALUES (1249, '6292', 'Pensiones y jubilaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1247, 4);
INSERT INTO cuenta VALUES (1250, '6293', 'Otros beneficios post-empleo', 'Gastos por Naturaleza', 'Deudora', 1, 1247, 4);
INSERT INTO cuenta VALUES (1251, '6294', 'Participación en las utilidades', 'Gastos por Naturaleza', 'Deudora', 1, 1247, 4);
INSERT INTO cuenta VALUES (1252, '62941', 'Participación corriente', 'Gastos por Naturaleza', 'Deudora', 1, 1251, 5);
INSERT INTO cuenta VALUES (1253, '62942', 'Participación diferida', 'Gastos por Naturaleza', 'Deudora', 1, 1251, 5);
INSERT INTO cuenta VALUES (1254, '63', 'GASTOS DE SERVICIOS PRESTADOS POR TERCEROS', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1255, '631', 'Transporte, correos y gastos de viaje', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1256, '6311', 'Transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1255, 4);
INSERT INTO cuenta VALUES (1257, '63111', 'De carga', 'Gastos por Naturaleza', 'Deudora', 1, 1256, 5);
INSERT INTO cuenta VALUES (1258, '63112', 'De pasajeros', 'Gastos por Naturaleza', 'Deudora', 1, 1256, 5);
INSERT INTO cuenta VALUES (1259, '6312', 'Correos', 'Gastos por Naturaleza', 'Deudora', 1, 1255, 4);
INSERT INTO cuenta VALUES (1260, '6313', 'Alojamiento', 'Gastos por Naturaleza', 'Deudora', 1, 1255, 4);
INSERT INTO cuenta VALUES (1261, '6314', 'Alimentación', 'Gastos por Naturaleza', 'Deudora', 1, 1255, 4);
INSERT INTO cuenta VALUES (1262, '6315', 'Otros gastos de viaje', 'Gastos por Naturaleza', 'Deudora', 1, 1255, 4);
INSERT INTO cuenta VALUES (1263, '632', 'Asesoría y consultoría', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1264, '6321', 'Administrativa', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1265, '6322', 'Legal y tributaria', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1266, '6323', 'Auditoría y contable', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1267, '6324', 'Mercadotecnia', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1268, '6325', 'Medioambiental', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1269, '6326', 'Investigación y desarrollo', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1270, '6327', 'Producción', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1271, '6329', 'Otros', 'Gastos por Naturaleza', 'Deudora', 1, 1263, 4);
INSERT INTO cuenta VALUES (1272, '633', 'Producción encargada a terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1273, '634', 'Mantenimiento y reparaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1274, '6341', 'Propiedad de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1273, 4);
INSERT INTO cuenta VALUES (1275, '6342', 'Activos por derecho de uso', 'Gastos por Naturaleza', 'Deudora', 1, 1273, 4);
INSERT INTO cuenta VALUES (1276, '63421', 'Financiero', 'Gastos por Naturaleza', 'Deudora', 1, 1275, 5);
INSERT INTO cuenta VALUES (1277, '63432', 'Operativo', 'Gastos por Naturaleza', 'Deudora', 1, 1275, 5);
INSERT INTO cuenta VALUES (1278, '6343', 'Propiedad, planta y equipo', 'Gastos por Naturaleza', 'Deudora', 1, 1273, 4);
INSERT INTO cuenta VALUES (1279, '6344', 'Intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1273, 4);
INSERT INTO cuenta VALUES (1280, '6345', 'Activos biológicos', 'Gastos por Naturaleza', 'Deudora', 1, 1273, 4);
INSERT INTO cuenta VALUES (1281, '635', 'Alquileres', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1282, '6351', 'Terrenos', 'Gastos por Naturaleza', 'Deudora', 1, 1281, 4);
INSERT INTO cuenta VALUES (1283, '6352', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1281, 4);
INSERT INTO cuenta VALUES (1284, '6353', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1281, 4);
INSERT INTO cuenta VALUES (1285, '6354', 'Equipo de transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1281, 4);
INSERT INTO cuenta VALUES (1286, '6355', 'Muebles y enseres', 'Gastos por Naturaleza', 'Deudora', 1, 1281, 4);
INSERT INTO cuenta VALUES (1287, '6356', 'Equipos diversos', 'Gastos por Naturaleza', 'Deudora', 1, 1281, 4);
INSERT INTO cuenta VALUES (1288, '636', 'Servicios básicos', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1289, '6361', 'Energía eléctrica', 'Gastos por Naturaleza', 'Deudora', 1, 1288, 4);
INSERT INTO cuenta VALUES (1290, '6362', 'Gas', 'Gastos por Naturaleza', 'Deudora', 1, 1288, 4);
INSERT INTO cuenta VALUES (1291, '6363', 'Agua', 'Gastos por Naturaleza', 'Deudora', 1, 1288, 4);
INSERT INTO cuenta VALUES (1292, '6364', 'Teléfono', 'Gastos por Naturaleza', 'Deudora', 1, 1288, 4);
INSERT INTO cuenta VALUES (1293, '6365', 'Internet', 'Gastos por Naturaleza', 'Deudora', 1, 1288, 4);
INSERT INTO cuenta VALUES (1294, '6366', 'Radio', 'Gastos por Naturaleza', 'Deudora', 1, 1288, 4);
INSERT INTO cuenta VALUES (1295, '6367', 'Cable', 'Gastos por Naturaleza', 'Deudora', 1, 1288, 4);
INSERT INTO cuenta VALUES (1296, '637', 'Publicidad, publicaciones, relaciones públicas', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1297, '6371', 'Publicidad', 'Gastos por Naturaleza', 'Deudora', 1, 1296, 4);
INSERT INTO cuenta VALUES (1298, '6372', 'Publicaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1296, 4);
INSERT INTO cuenta VALUES (1299, '6373', 'Relaciones públicas', 'Gastos por Naturaleza', 'Deudora', 1, 1296, 4);
INSERT INTO cuenta VALUES (1300, '638', 'Servicios de contratistas', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1301, '639', 'Otros servicios prestados por terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1254, 3);
INSERT INTO cuenta VALUES (1302, '6391', 'Gastos bancarios', 'Gastos por Naturaleza', 'Deudora', 1, 1301, 4);
INSERT INTO cuenta VALUES (1303, '6392', 'Gastos de laboratorio', 'Gastos por Naturaleza', 'Deudora', 1, 1301, 4);
INSERT INTO cuenta VALUES (1304, '64', 'GASTOS POR TRIBUTOS', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1305, '641', 'Gobierno nacional', 'Gastos por Naturaleza', 'Deudora', 1, 1304, 3);
INSERT INTO cuenta VALUES (1306, '6411', 'Impuesto general a las ventas y selectivo al consumo', 'Gastos por Naturaleza', 'Deudora', 1, 1305, 4);
INSERT INTO cuenta VALUES (1307, '6412', 'Impuesto a las transacciones financieras', 'Gastos por Naturaleza', 'Deudora', 1, 1305, 4);
INSERT INTO cuenta VALUES (1308, '6413', 'Impuesto temporal a los activos netos', 'Gastos por Naturaleza', 'Deudora', 1, 1305, 4);
INSERT INTO cuenta VALUES (1309, '6414', 'Impuesto a los juegos de casino y máquinas tragamonedas', 'Gastos por Naturaleza', 'Deudora', 1, 1305, 4);
INSERT INTO cuenta VALUES (1310, '6415', 'Regalías mineras', 'Gastos por Naturaleza', 'Deudora', 1, 1305, 4);
INSERT INTO cuenta VALUES (1311, '6416', 'Cánones', 'Gastos por Naturaleza', 'Deudora', 1, 1305, 4);
INSERT INTO cuenta VALUES (1312, '6419', 'Otros', 'Gastos por Naturaleza', 'Deudora', 1, 1305, 4);
INSERT INTO cuenta VALUES (1313, '642', 'Gobierno regional', 'Gastos por Naturaleza', 'Deudora', 1, 1304, 3);
INSERT INTO cuenta VALUES (1314, '643', 'Gobierno local', 'Gastos por Naturaleza', 'Deudora', 1, 1304, 3);
INSERT INTO cuenta VALUES (1315, '6431', 'Impuesto predial', 'Gastos por Naturaleza', 'Deudora', 1, 1314, 4);
INSERT INTO cuenta VALUES (1316, '6432', 'Arbitrios municipales y seguridad ciudadana', 'Gastos por Naturaleza', 'Deudora', 1, 1314, 4);
INSERT INTO cuenta VALUES (1317, '6433', 'Impuesto al patrimonio vehicular', 'Gastos por Naturaleza', 'Deudora', 1, 1314, 4);
INSERT INTO cuenta VALUES (1318, '6434', 'Licencia de funcionamiento', 'Gastos por Naturaleza', 'Deudora', 1, 1314, 4);
INSERT INTO cuenta VALUES (1319, '6439', 'Otros', 'Gastos por Naturaleza', 'Deudora', 1, 1314, 4);
INSERT INTO cuenta VALUES (1320, '644', 'Otros gastos por tributos', 'Gastos por Naturaleza', 'Deudora', 1, 1304, 3);
INSERT INTO cuenta VALUES (1321, '6442', 'Contribución al SENCICO', 'Gastos por Naturaleza', 'Deudora', 1, 1320, 4);
INSERT INTO cuenta VALUES (1322, '6443', 'Otros', 'Gastos por Naturaleza', 'Deudora', 1, 1320, 4);
INSERT INTO cuenta VALUES (1323, '645', 'Gastos en deuda tributaria', 'Gastos por Naturaleza', 'Deudora', 1, 1304, 3);
INSERT INTO cuenta VALUES (1324, '6451', 'Intereses', 'Gastos por Naturaleza', 'Deudora', 1, 1323, 4);
INSERT INTO cuenta VALUES (1325, '6452', 'Intereses – fraccionamiento', 'Gastos por Naturaleza', 'Deudora', 1, 1323, 4);
INSERT INTO cuenta VALUES (1326, '6453', 'Multas', 'Gastos por Naturaleza', 'Deudora', 1, 1323, 4);
INSERT INTO cuenta VALUES (1327, '6454', 'Costas y otros', 'Gastos por Naturaleza', 'Deudora', 1, 1323, 4);
INSERT INTO cuenta VALUES (1328, '65', 'OTROS GASTOS DE GESTION', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1329, '651', 'Seguros', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1330, '652', 'Regalías', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1331, '653', 'Suscripciones', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1332, '654', 'Licencias y derechos de vigencia', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1333, '655', 'Costo neto de enajenación de activos inmovilizados y operaciones discontinuadas', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1334, '6551', 'Costo neto de enajenación de activos inmovilizados', 'Gastos por Naturaleza', 'Deudora', 1, 1333, 4);
INSERT INTO cuenta VALUES (1335, '65511', 'Inversiones mobiliarias', 'Gastos por Naturaleza', 'Deudora', 1, 1334, 5);
INSERT INTO cuenta VALUES (1336, '65512', 'Propiedades de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1334, 5);
INSERT INTO cuenta VALUES (1337, '65513', 'Activos por derecho de uso – arrendamiento financiero', 'Gastos por Naturaleza', 'Deudora', 1, 1334, 5);
INSERT INTO cuenta VALUES (1338, '65514', 'Propiedad, planta y equipo', 'Gastos por Naturaleza', 'Deudora', 1, 1334, 5);
INSERT INTO cuenta VALUES (1339, '65515', 'Intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1334, 5);
INSERT INTO cuenta VALUES (1340, '65516', 'Activos biológicos', 'Gastos por Naturaleza', 'Deudora', 1, 1334, 5);
INSERT INTO cuenta VALUES (1341, '6552', 'Operaciones discontinuadas – Abandono de activos', 'Gastos por Naturaleza', 'Deudora', 1, 1333, 4);
INSERT INTO cuenta VALUES (1342, '65521', 'Propiedades de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1341, 5);
INSERT INTO cuenta VALUES (1343, '65522', 'Activos por derecho de uso – Arrendamiento financiero', 'Gastos por Naturaleza', 'Deudora', 1, 1341, 5);
INSERT INTO cuenta VALUES (1344, '65523', 'Propiedad, planta y equipo', 'Gastos por Naturaleza', 'Deudora', 1, 1341, 5);
INSERT INTO cuenta VALUES (1345, '65524', 'Intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1341, 5);
INSERT INTO cuenta VALUES (1346, '65525', 'Activos biológicos', 'Gastos por Naturaleza', 'Deudora', 1, 1341, 5);
INSERT INTO cuenta VALUES (1347, '656', 'Suministros', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1348, '658', 'Gestión medioambiental', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1349, '659', 'Otros gastos de gestión', 'Gastos por Naturaleza', 'Deudora', 1, 1328, 3);
INSERT INTO cuenta VALUES (1350, '6591', 'Donaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1349, 4);
INSERT INTO cuenta VALUES (1351, '6592', 'Sanciones administrativas', 'Gastos por Naturaleza', 'Deudora', 1, 1349, 4);
INSERT INTO cuenta VALUES (1352, '66', 'PERDIDA POR MEDICIÓN DE ACTIVOS NO FINANCIEROS AL VALOR RAZONABLE', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1353, '661', 'Activo realizable', 'Gastos por Naturaleza', 'Deudora', 1, 1352, 3);
INSERT INTO cuenta VALUES (1354, '6611', 'Mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1353, 4);
INSERT INTO cuenta VALUES (1355, '6612', 'Productos terminados', 'Gastos por Naturaleza', 'Deudora', 1, 1353, 4);
INSERT INTO cuenta VALUES (1356, '6613', 'Activos no corrientes mantenidos para la venta', 'Gastos por Naturaleza', 'Deudora', 1, 1353, 4);
INSERT INTO cuenta VALUES (1357, '66131', 'Propiedades de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1356, 5);
INSERT INTO cuenta VALUES (1358, '66132', 'Propiedad, planta y equipo', 'Gastos por Naturaleza', 'Deudora', 1, 1356, 5);
INSERT INTO cuenta VALUES (1359, '66133', 'Intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1356, 5);
INSERT INTO cuenta VALUES (1360, '66134', 'Activos biológicos', 'Gastos por Naturaleza', 'Deudora', 1, 1356, 5);
INSERT INTO cuenta VALUES (1361, '662', 'Activo inmovilizado', 'Gastos por Naturaleza', 'Deudora', 1, 1352, 3);
INSERT INTO cuenta VALUES (1362, '6621', 'Propiedades de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1361, 4);
INSERT INTO cuenta VALUES (1363, '6622', 'Activos biológicos', 'Gastos por Naturaleza', 'Deudora', 1, 1361, 4);
INSERT INTO cuenta VALUES (1364, '67', 'GASTOS FINANCIEROS', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1365, '671', 'Gastos en operaciones de endeudamiento y otros', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1366, '6711', 'Préstamos de instituciones financieras y otras entidades', 'Gastos por Naturaleza', 'Deudora', 1, 1365, 4);
INSERT INTO cuenta VALUES (1367, '6712', 'Contratos de arrendamiento financiero', 'Gastos por Naturaleza', 'Deudora', 1, 1365, 4);
INSERT INTO cuenta VALUES (1368, '6713', 'Emisión y colocación de instrumentos representativos de deuda y patrimonio', 'Gastos por Naturaleza', 'Deudora', 1, 1365, 4);
INSERT INTO cuenta VALUES (1369, '6714', 'Documentos vendidos o descontados', 'Gastos por Naturaleza', 'Deudora', 1, 1365, 4);
INSERT INTO cuenta VALUES (1370, '672', 'Pérdida por instrumentos financieros derivados', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1371, '673', 'Intereses por préstamos y otras obligaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1372, '6731', 'Préstamos de instituciones financieras y otras entidades', 'Gastos por Naturaleza', 'Deudora', 1, 1371, 4);
INSERT INTO cuenta VALUES (1373, '67311', 'Instituciones financieras', 'Gastos por Naturaleza', 'Deudora', 1, 1372, 5);
INSERT INTO cuenta VALUES (1374, '67312', 'Otras entidades', 'Gastos por Naturaleza', 'Deudora', 1, 1372, 5);
INSERT INTO cuenta VALUES (1375, '6732', 'Contratos de arrendamiento financiero', 'Gastos por Naturaleza', 'Deudora', 1, 1371, 4);
INSERT INTO cuenta VALUES (1376, '6733', 'Otros instrumentos financieros por pagar', 'Gastos por Naturaleza', 'Deudora', 1, 1371, 4);
INSERT INTO cuenta VALUES (1377, '6734', 'Documentos vendidos o descontados', 'Gastos por Naturaleza', 'Deudora', 1, 1371, 4);
INSERT INTO cuenta VALUES (1378, '6735', 'Obligaciones emitidas', 'Gastos por Naturaleza', 'Deudora', 1, 1371, 4);
INSERT INTO cuenta VALUES (1379, '6736', 'Obligaciones comerciales', 'Gastos por Naturaleza', 'Deudora', 1, 1371, 4);
INSERT INTO cuenta VALUES (1380, '674', 'Gastos en operaciones de factoraje (factoring)', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1382, '6741', 'Pérdida en instrumentos vendidos', 'Gastos por Naturaleza', 'Deudora', 1, 1380, 4);
INSERT INTO cuenta VALUES (1383, '675', 'Descuentos concedidos por pronto pago', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1384, '676', 'Diferencia de cambio', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1385, '677', 'Pérdida por medición de activos y pasivos financieros al valor razonable', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1386, '6771', 'Inversiones mantenidas para negociación', 'Gastos por Naturaleza', 'Deudora', 1, 1385, 4);
INSERT INTO cuenta VALUES (1387, '6772', 'Otras inversiones financieras', 'Gastos por Naturaleza', 'Deudora', 1, 1385, 4);
INSERT INTO cuenta VALUES (1388, '6773', 'Otros', 'Gastos por Naturaleza', 'Deudora', 1, 1385, 4);
INSERT INTO cuenta VALUES (1389, '678', 'Participación en resultados de entidades relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1390, '6781', 'Participación en los resultados de subsidiarias y asociadas bajo el método del valor patrimonial', 'Gastos por Naturaleza', 'Deudora', 1, 1389, 4);
INSERT INTO cuenta VALUES (1391, '6782', 'Participaciones en negocios conjuntos', 'Gastos por Naturaleza', 'Deudora', 1, 1389, 4);
INSERT INTO cuenta VALUES (1392, '679', 'Otros gastos financieros', 'Gastos por Naturaleza', 'Deudora', 1, 1364, 3);
INSERT INTO cuenta VALUES (1393, '6791', 'Primas por opciones', 'Gastos por Naturaleza', 'Deudora', 1, 1392, 4);
INSERT INTO cuenta VALUES (1394, '6792', 'Gastos financieros en medición a valor descontado', 'Gastos por Naturaleza', 'Deudora', 1, 1392, 4);
INSERT INTO cuenta VALUES (1395, '6793', 'Gastos financieros en actualización de activos por derecho de uso', 'Gastos por Naturaleza', 'Deudora', 1, 1392, 4);
INSERT INTO cuenta VALUES (1396, '68', 'VALUACIÓN Y DETERIORO DE ACTIVOS Y PROVISIONES', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1397, '681', 'Depreciación de propiedades de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1398, '6811', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1397, 4);
INSERT INTO cuenta VALUES (1399, '68111', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1398, 5);
INSERT INTO cuenta VALUES (1400, '68112', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1398, 5);
INSERT INTO cuenta VALUES (1401, '68113', 'Costo de financiación', 'Gastos por Naturaleza', 'Deudora', 1, 1398, 5);
INSERT INTO cuenta VALUES (1402, '682', 'Depreciación de activos por derecho de uso – arrendamiento financiero', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1403, '6821', 'Propiedades de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1402, 4);
INSERT INTO cuenta VALUES (1404, '68211', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1403, 5);
INSERT INTO cuenta VALUES (1405, '682111', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1404, 6);
INSERT INTO cuenta VALUES (1406, '682112', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1404, 6);
INSERT INTO cuenta VALUES (1407, '682113', 'Costo de financiación', 'Gastos por Naturaleza', 'Deudora', 1, 1404, 6);
INSERT INTO cuenta VALUES (1408, '6822', 'Propiedad, planta y equipo', 'Gastos por Naturaleza', 'Deudora', 1, 1402, 4);
INSERT INTO cuenta VALUES (1409, '68221', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1408, 5);
INSERT INTO cuenta VALUES (1410, '682211', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1409, 6);
INSERT INTO cuenta VALUES (1411, '682212', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1409, 6);
INSERT INTO cuenta VALUES (1412, '682213', 'Costo de financiación', 'Gastos por Naturaleza', 'Deudora', 1, 1409, 6);
INSERT INTO cuenta VALUES (1413, '68222', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1408, 5);
INSERT INTO cuenta VALUES (1414, '682221', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1413, 6);
INSERT INTO cuenta VALUES (1415, '682222', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1413, 6);
INSERT INTO cuenta VALUES (1416, '682223', 'Costo de financiación', 'Gastos por Naturaleza', 'Deudora', 1, 1413, 6);
INSERT INTO cuenta VALUES (1417, '68223', 'Unidades de transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1408, 5);
INSERT INTO cuenta VALUES (1418, '682231', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1417, 6);
INSERT INTO cuenta VALUES (1419, '682232', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1417, 6);
INSERT INTO cuenta VALUES (1420, '68225', 'Equipos diversos', 'Gastos por Naturaleza', 'Deudora', 1, 1408, 5);
INSERT INTO cuenta VALUES (1421, '682251', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1420, 6);
INSERT INTO cuenta VALUES (1422, '682252', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1420, 6);
INSERT INTO cuenta VALUES (1423, '683', 'Depreciación de activos por derecho de uso – arrendamiento operativo', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1424, '6831', 'Depreciación de activos por derecho de uso – arrendamiento operativo', 'Gastos por Naturaleza', 'Deudora', 1, 1423, 4);
INSERT INTO cuenta VALUES (1425, '68311', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1424, 5);
INSERT INTO cuenta VALUES (1426, '683111', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1425, 6);
INSERT INTO cuenta VALUES (1427, '683112', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1425, 6);
INSERT INTO cuenta VALUES (1428, '68312', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1424, 5);
INSERT INTO cuenta VALUES (1429, '683121', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1428, 6);
INSERT INTO cuenta VALUES (1430, '683122', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1428, 6);
INSERT INTO cuenta VALUES (1431, '68313', 'Unidades de transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1424, 5);
INSERT INTO cuenta VALUES (1432, '683131', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1431, 6);
INSERT INTO cuenta VALUES (1433, '683132', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1431, 6);
INSERT INTO cuenta VALUES (1434, '68315', 'Equipos diversos', 'Gastos por Naturaleza', 'Deudora', 1, 1424, 5);
INSERT INTO cuenta VALUES (1435, '683351', 'Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1434, 6);
INSERT INTO cuenta VALUES (1436, '683152', 'Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1434, 6);
INSERT INTO cuenta VALUES (1437, '684', 'Depreciación de propiedad, planta y equipo', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1438, '6841', 'Depreciación de propiedad, planta y equipo – Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1437, 4);
INSERT INTO cuenta VALUES (1439, '68410', 'Plantas productoras', 'Gastos por Naturaleza', 'Deudora', 1, 1438, 5);
INSERT INTO cuenta VALUES (1440, '68411', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1438, 5);
INSERT INTO cuenta VALUES (1441, '68412', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1438, 5);
INSERT INTO cuenta VALUES (1442, '68413', 'Unidades de transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1438, 5);
INSERT INTO cuenta VALUES (1443, '68414', 'Muebles y enseres', 'Gastos por Naturaleza', 'Deudora', 1, 1438, 5);
INSERT INTO cuenta VALUES (1444, '68415', 'Equipos diversos', 'Gastos por Naturaleza', 'Deudora', 1, 1438, 5);
INSERT INTO cuenta VALUES (1445, '68416', 'Herramientas y unidades de reemplazo', 'Gastos por Naturaleza', 'Deudora', 1, 1438, 5);
INSERT INTO cuenta VALUES (1446, '6842', 'Depreciación de propiedad, planta y equipo – Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1437, 4);
INSERT INTO cuenta VALUES (1447, '68420', 'Plantas productoras', 'Gastos por Naturaleza', 'Deudora', 1, 1446, 5);
INSERT INTO cuenta VALUES (1448, '68421', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1446, 5);
INSERT INTO cuenta VALUES (1449, '68422', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1446, 5);
INSERT INTO cuenta VALUES (1450, '68423', 'Unidades de transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1446, 5);
INSERT INTO cuenta VALUES (1451, '68424', 'Muebles y enseres', 'Gastos por Naturaleza', 'Deudora', 1, 1446, 5);
INSERT INTO cuenta VALUES (1452, '68425', 'Equipos diversos', 'Gastos por Naturaleza', 'Deudora', 1, 1446, 5);
INSERT INTO cuenta VALUES (1453, '68426', 'Herramientas y unidades de reemplazo', 'Gastos por Naturaleza', 'Deudora', 1, 1446, 5);
INSERT INTO cuenta VALUES (1454, '6843', 'Depreciación de propiedad, planta y equipo – Costos de financiación', 'Gastos por Naturaleza', 'Deudora', 1, 1437, 4);
INSERT INTO cuenta VALUES (1455, '68430', 'Plantas productoras', 'Gastos por Naturaleza', 'Deudora', 1, 1454, 5);
INSERT INTO cuenta VALUES (1456, '68431', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1454, 5);
INSERT INTO cuenta VALUES (1457, '68432', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1454, 5);
INSERT INTO cuenta VALUES (1458, '685', 'Depreciación de activos biológicos en producción', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1459, '6851', 'Depreciación de activos biológicos en producción – costo', 'Gastos por Naturaleza', 'Deudora', 1, 1458, 4);
INSERT INTO cuenta VALUES (1460, '68511', 'Activos biológicos de origen animal', 'Gastos por Naturaleza', 'Deudora', 1, 1459, 5);
INSERT INTO cuenta VALUES (1461, '68512', 'Activos biológicos de origen vegetal', 'Gastos por Naturaleza', 'Deudora', 1, 1459, 5);
INSERT INTO cuenta VALUES (1462, '6852', 'Depreciación de activos biológicos en producción – costo de financiación', 'Gastos por Naturaleza', 'Deudora', 1, 1458, 4);
INSERT INTO cuenta VALUES (1463, '68521', 'Activos biológicos de origen animal', 'Gastos por Naturaleza', 'Deudora', 1, 1462, 5);
INSERT INTO cuenta VALUES (1464, '68522', 'Activos biológicos de origen vegetal', 'Gastos por Naturaleza', 'Deudora', 1, 1462, 5);
INSERT INTO cuenta VALUES (1465, '686', 'Amortización de intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1466, '6861', 'Amortización de intangibles – Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1465, 4);
INSERT INTO cuenta VALUES (1467, '68611', 'Concesiones, licencias y otros derechos', 'Gastos por Naturaleza', 'Deudora', 1, 1466, 5);
INSERT INTO cuenta VALUES (1468, '68612', 'Patentes y propiedad industrial', 'Gastos por Naturaleza', 'Deudora', 1, 1466, 5);
INSERT INTO cuenta VALUES (1469, '68613', 'Programas de computadora (software)', 'Gastos por Naturaleza', 'Deudora', 1, 1466, 5);
INSERT INTO cuenta VALUES (1470, '68614', 'Costos de exploración y desarrollo', 'Gastos por Naturaleza', 'Deudora', 1, 1466, 5);
INSERT INTO cuenta VALUES (1471, '68615', 'Fórmulas, diseños y prototipos', 'Gastos por Naturaleza', 'Deudora', 1, 1466, 5);
INSERT INTO cuenta VALUES (1472, '68619', 'Otros activos intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1466, 5);
INSERT INTO cuenta VALUES (1473, '6862', 'Amortización de intangibles – Revaluación', 'Gastos por Naturaleza', 'Deudora', 1, 1465, 4);
INSERT INTO cuenta VALUES (1474, '68621', 'Concesiones, licencias y otros derechos', 'Gastos por Naturaleza', 'Deudora', 1, 1473, 5);
INSERT INTO cuenta VALUES (1475, '68622', 'Patentes y propiedad industrial', 'Gastos por Naturaleza', 'Deudora', 1, 1473, 5);
INSERT INTO cuenta VALUES (1476, '68623', 'Programas de computadora (software)', 'Gastos por Naturaleza', 'Deudora', 1, 1473, 5);
INSERT INTO cuenta VALUES (1477, '68624', 'Costos de exploración y desarrollo', 'Gastos por Naturaleza', 'Deudora', 1, 1473, 5);
INSERT INTO cuenta VALUES (1478, '68625', 'Fórmulas, diseños y prototipos', 'Gastos por Naturaleza', 'Deudora', 1, 1473, 5);
INSERT INTO cuenta VALUES (1479, '68629', 'Otros activos intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1473, 5);
INSERT INTO cuenta VALUES (1480, '687', 'Valuación de activos', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1481, '6871', 'Estimación de cuentas de cobranza dudosa', 'Gastos por Naturaleza', 'Deudora', 1, 1480, 4);
INSERT INTO cuenta VALUES (1482, '68711', 'Cuentas por cobrar comerciales – Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1481, 5);
INSERT INTO cuenta VALUES (1483, '68712', 'Cuentas por cobrar comerciales – Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1481, 5);
INSERT INTO cuenta VALUES (1484, '68713', 'Cuentas por cobrar al personal, a los accionistas (socios) y directores', 'Gastos por Naturaleza', 'Deudora', 1, 1481, 5);
INSERT INTO cuenta VALUES (1485, '68714', 'Cuentas por cobrar diversas – Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1481, 5);
INSERT INTO cuenta VALUES (1486, '68715', 'Cuentas por cobrar diversas – Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1481, 5);
INSERT INTO cuenta VALUES (1487, '6873', 'Desvalorización de inversiones mobiliarias', 'Gastos por Naturaleza', 'Deudora', 1, 1480, 4);
INSERT INTO cuenta VALUES (1488, '68731', 'Inversiones a ser mantenidas hasta el vencimiento', 'Gastos por Naturaleza', 'Deudora', 1, 1487, 5);
INSERT INTO cuenta VALUES (1489, '68732', 'Instrumentos financieros representativos de derecho patrimonial', 'Gastos por Naturaleza', 'Deudora', 1, 1487, 5);
INSERT INTO cuenta VALUES (1490, '688', 'Deterioro del valor de los activos', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1491, '6881', 'Desvalorización de propiedad de inversión', 'Gastos por Naturaleza', 'Deudora', 1, 1490, 4);
INSERT INTO cuenta VALUES (1492, '68812', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1491, 5);
INSERT INTO cuenta VALUES (1493, '68813', 'Construcciones en curso', 'Gastos por Naturaleza', 'Deudora', 1, 1491, 5);
INSERT INTO cuenta VALUES (1494, '6882', 'Desvalorización de activos por derecho de uso – arrendamiento financiero', 'Gastos por Naturaleza', 'Deudora', 1, 1490, 4);
INSERT INTO cuenta VALUES (1495, '68820', 'Planta productora en producción', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1496, '68821', 'Planta productora en desarrollo', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1497, '68822', 'Terrenos', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1498, '68823', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1499, '68824', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1500, '68825', 'Unidades de transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1501, '68826', 'Muebles y enseres', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1502, '68827', 'Equipos diversos', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1503, '68828', 'Herramientas y unidades de reemplazo', 'Gastos por Naturaleza', 'Deudora', 1, 1494, 5);
INSERT INTO cuenta VALUES (1504, '6883', 'Desvalorización de propiedad, planta y equipo', 'Gastos por Naturaleza', 'Deudora', 1, 1490, 4);
INSERT INTO cuenta VALUES (1505, '68830', 'Planta productora en producción', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1506, '68831', 'Planta productora en desarrollo', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1507, '68832', 'Terrenos', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1508, '68833', 'Edificaciones', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1509, '68834', 'Maquinarias y equipos de explotación', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1510, '68835', 'Unidades de transporte', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1511, '68836', 'Muebles y enseres', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1512, '68837', 'Equipos diversos', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1513, '68838', 'Herramientas y unidades de reemplazo', 'Gastos por Naturaleza', 'Deudora', 1, 1504, 5);
INSERT INTO cuenta VALUES (1514, '6884', 'Desvalorización de intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1490, 4);
INSERT INTO cuenta VALUES (1515, '68841', 'Concesiones, licencias y otros derechos', 'Gastos por Naturaleza', 'Deudora', 1, 1514, 5);
INSERT INTO cuenta VALUES (1516, '68842', 'Patentes y propiedad industrial', 'Gastos por Naturaleza', 'Deudora', 1, 1514, 5);
INSERT INTO cuenta VALUES (1517, '68843', 'Programas de computadora (software)', 'Gastos por Naturaleza', 'Deudora', 1, 1514, 5);
INSERT INTO cuenta VALUES (1518, '68844', 'Costos de exploración y desarrollo', 'Gastos por Naturaleza', 'Deudora', 1, 1514, 5);
INSERT INTO cuenta VALUES (1519, '68845', 'Fórmulas, diseños y prototipos', 'Gastos por Naturaleza', 'Deudora', 1, 1514, 5);
INSERT INTO cuenta VALUES (1520, '68846', 'Otros activos intangibles', 'Gastos por Naturaleza', 'Deudora', 1, 1514, 5);
INSERT INTO cuenta VALUES (1521, '68847', 'Plusvalía mercantil', 'Gastos por Naturaleza', 'Deudora', 1, 1514, 5);
INSERT INTO cuenta VALUES (1522, '6889', 'Desvalorización de activos biológicos en producción', 'Gastos por Naturaleza', 'Deudora', 1, 1490, 4);
INSERT INTO cuenta VALUES (1523, '68891', 'Activos biológicos de origen animal', 'Gastos por Naturaleza', 'Deudora', 1, 1522, 5);
INSERT INTO cuenta VALUES (1524, '68892', 'Activos biológicos de origen vegetal', 'Gastos por Naturaleza', 'Deudora', 1, 1522, 5);
INSERT INTO cuenta VALUES (1525, '689', 'Provisiones', 'Gastos por Naturaleza', 'Deudora', 1, 1396, 3);
INSERT INTO cuenta VALUES (1526, '6891', 'Provisión para litigios', 'Gastos por Naturaleza', 'Deudora', 1, 1525, 4);
INSERT INTO cuenta VALUES (1527, '68911', 'Provisión para litigios – Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1526, 5);
INSERT INTO cuenta VALUES (1528, '68912', 'Provisión para litigios – Actualización financiera', 'Gastos por Naturaleza', 'Deudora', 1, 1526, 5);
INSERT INTO cuenta VALUES (1529, '6892', 'Provisión por desmantelamiento, retiro o rehabilitación del inmovilizado', 'Gastos por Naturaleza', 'Deudora', 1, 1525, 4);
INSERT INTO cuenta VALUES (1530, '68921', 'Provisión por desmantelamiento, retiro o rehabilitación del inmovilizado – Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1529, 5);
INSERT INTO cuenta VALUES (1531, '68922', 'Provisión por desmantelamiento, retiro o rehabilitación del inmovilizado – Actualización financiera', 'Gastos por Naturaleza', 'Deudora', 1, 1529, 5);
INSERT INTO cuenta VALUES (1532, '6893', 'Provisión para reestructuraciones', 'Gastos por Naturaleza', 'Deudora', 1, 1525, 4);
INSERT INTO cuenta VALUES (1533, '6894', 'Provisión para protección y remediación del medio ambiente', 'Gastos por Naturaleza', 'Deudora', 1, 1525, 4);
INSERT INTO cuenta VALUES (1534, '68941', 'Provisión para protección y remediación del medio ambiente – Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1533, 5);
INSERT INTO cuenta VALUES (1535, '68942', 'Provisión para protección y remediación del medio ambiente – Actualización financiera', 'Gastos por Naturaleza', 'Deudora', 1, 1533, 5);
INSERT INTO cuenta VALUES (1536, '6896', 'Provisión para garantías', 'Gastos por Naturaleza', 'Deudora', 1, 1525, 4);
INSERT INTO cuenta VALUES (1537, '68961', 'Provisión para garantías – Costo', 'Gastos por Naturaleza', 'Deudora', 1, 1536, 5);
INSERT INTO cuenta VALUES (1538, '68962', 'Provisión para garantías – Actualización financiera', 'Gastos por Naturaleza', 'Deudora', 1, 1536, 5);
INSERT INTO cuenta VALUES (1539, '6897', 'Provisión por activos por derecho de uso', 'Gastos por Naturaleza', 'Deudora', 1, 1525, 4);
INSERT INTO cuenta VALUES (1540, '68971', 'Provisión por activos por derecho de uso arrendamiento operativo', 'Gastos por Naturaleza', 'Deudora', 1, 1539, 5);
INSERT INTO cuenta VALUES (1541, '68972', 'Provisión por activos por derecho de uso arrendamiento operativo – actualización financiera', 'Gastos por Naturaleza', 'Deudora', 1, 1539, 5);
INSERT INTO cuenta VALUES (1542, '6899', 'Otras provisiones', 'Gastos por Naturaleza', 'Deudora', 1, 1525, 4);
INSERT INTO cuenta VALUES (1543, '69', 'COSTO DE VENTAS', 'Gastos por Naturaleza', 'Deudora', 1, 1178, 2);
INSERT INTO cuenta VALUES (1544, '691', 'Mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1543, 3);
INSERT INTO cuenta VALUES (1545, '6911', 'Mercaderías – exportación', 'Gastos por Naturaleza', 'Deudora', 1, 1544, 4);
INSERT INTO cuenta VALUES (1546, '69111', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1545, 5);
INSERT INTO cuenta VALUES (1547, '69112', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1545, 5);
INSERT INTO cuenta VALUES (1548, '6912', 'Mercaderías – venta local', 'Gastos por Naturaleza', 'Deudora', 1, 1544, 4);
INSERT INTO cuenta VALUES (1549, '69121', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1548, 5);
INSERT INTO cuenta VALUES (1550, '69122', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1548, 5);
INSERT INTO cuenta VALUES (1551, '692', 'Productos terminados', 'Gastos por Naturaleza', 'Deudora', 1, 1543, 3);
INSERT INTO cuenta VALUES (1552, '6921', 'Productos terminados – Exportación', 'Gastos por Naturaleza', 'Deudora', 1, 1551, 4);
INSERT INTO cuenta VALUES (1553, '69211', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1552, 5);
INSERT INTO cuenta VALUES (1554, '69212', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1552, 5);
INSERT INTO cuenta VALUES (1555, '6922', 'Productos terminados – Venta local', 'Gastos por Naturaleza', 'Deudora', 1, 1551, 4);
INSERT INTO cuenta VALUES (1556, '69221', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1555, 5);
INSERT INTO cuenta VALUES (1557, '69222', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1555, 5);
INSERT INTO cuenta VALUES (1558, '6923', 'Costos de financiación – Productos terminados', 'Gastos por Naturaleza', 'Deudora', 1, 1551, 4);
INSERT INTO cuenta VALUES (1559, '69231', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1558, 5);
INSERT INTO cuenta VALUES (1560, '69232', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1558, 5);
INSERT INTO cuenta VALUES (1561, '6924', 'Costos de producción no absorbido – Productos terminados', 'Gastos por Naturaleza', 'Deudora', 1, 1551, 4);
INSERT INTO cuenta VALUES (1562, '6925', 'Costo de ineficiencia – Productos terminados', 'Gastos por Naturaleza', 'Deudora', 1, 1551, 4);
INSERT INTO cuenta VALUES (1563, '693', 'Servicios terminados', 'Gastos por Naturaleza', 'Deudora', 1, 1543, 3);
INSERT INTO cuenta VALUES (1564, '6931', 'Servicios – Exportación', 'Gastos por Naturaleza', 'Deudora', 1, 1563, 4);
INSERT INTO cuenta VALUES (1565, '69311', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1564, 5);
INSERT INTO cuenta VALUES (1566, '69312', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1564, 5);
INSERT INTO cuenta VALUES (1567, '6932', 'Servicios – local', 'Gastos por Naturaleza', 'Deudora', 1, 1563, 4);
INSERT INTO cuenta VALUES (1568, '69321', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1567, 5);
INSERT INTO cuenta VALUES (1569, '69322', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1567, 5);
INSERT INTO cuenta VALUES (1570, '694', 'Subproductos, desechos y desperdicios', 'Gastos por Naturaleza', 'Deudora', 1, 1543, 3);
INSERT INTO cuenta VALUES (1571, '6941', 'Subproductos', 'Gastos por Naturaleza', 'Deudora', 1, 1570, 4);
INSERT INTO cuenta VALUES (1572, '69411', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1571, 5);
INSERT INTO cuenta VALUES (1573, '69412', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1571, 5);
INSERT INTO cuenta VALUES (1574, '6942', 'Desechos y desperdicios', 'Gastos por Naturaleza', 'Deudora', 1, 1570, 4);
INSERT INTO cuenta VALUES (1575, '69421', 'Terceros', 'Gastos por Naturaleza', 'Deudora', 1, 1574, 5);
INSERT INTO cuenta VALUES (1576, '69422', 'Relacionadas', 'Gastos por Naturaleza', 'Deudora', 1, 1574, 5);
INSERT INTO cuenta VALUES (1577, '695', 'Gastos por desvalorización de inventarios al costo', 'Gastos por Naturaleza', 'Deudora', 1, 1543, 3);
INSERT INTO cuenta VALUES (1578, '6951', 'Mercaderías', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1579, '6952', 'Productos terminados', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1580, '6953', 'Subproductos, desechos y desperdicios', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1581, '6954', 'Productos en proceso', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1582, '6955', 'Materias primas', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1583, '6956', 'Materiales auxiliares, suministros y repuestos', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1584, '6957', 'Envases y embalajes', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1585, '6958', 'Inventarios por recibir', 'Gastos por Naturaleza', 'Deudora', 1, 1577, 4);
INSERT INTO cuenta VALUES (1587, '7', 'INGRESOS', 'Ingresos', 'Acreedora', 1, None, 1);
INSERT INTO cuenta VALUES (1588, '70', 'VENTAS', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1589, '701', 'Mercaderías', 'Ingresos', 'Acreedora', 1, 1588, 3);
INSERT INTO cuenta VALUES (1590, '7011', 'Mercaderías – venta de exportación', 'Ingresos', 'Acreedora', 1, 1589, 4);
INSERT INTO cuenta VALUES (1591, '70111', 'Terceros', 'Ingresos', 'Acreedora', 1, 1590, 5);
INSERT INTO cuenta VALUES (1592, '70112', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1590, 5);
INSERT INTO cuenta VALUES (1593, '7012', 'Mercaderías – venta local', 'Ingresos', 'Acreedora', 1, 1589, 4);
INSERT INTO cuenta VALUES (1594, '70121', 'Terceros', 'Ingresos', 'Acreedora', 1, 1593, 5);
INSERT INTO cuenta VALUES (1595, '70122', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1593, 5);
INSERT INTO cuenta VALUES (1596, '702', 'Productos terminados', 'Ingresos', 'Acreedora', 1, 1588, 3);
INSERT INTO cuenta VALUES (1597, '7021', 'Productos terminados – venta de exportación', 'Ingresos', 'Acreedora', 1, 1596, 4);
INSERT INTO cuenta VALUES (1598, '70211', 'Terceros', 'Ingresos', 'Acreedora', 1, 1597, 5);
INSERT INTO cuenta VALUES (1599, '70212', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1597, 5);
INSERT INTO cuenta VALUES (1600, '7022', 'Productos terminados – venta local', 'Ingresos', 'Acreedora', 1, 1596, 4);
INSERT INTO cuenta VALUES (1601, '70221', 'Terceros', 'Ingresos', 'Acreedora', 1, 1600, 5);
INSERT INTO cuenta VALUES (1602, '70222', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1600, 5);
INSERT INTO cuenta VALUES (1603, '703', 'Servicios terminados', 'Ingresos', 'Acreedora', 1, 1588, 3);
INSERT INTO cuenta VALUES (1604, '7031', 'Servicios – exportación', 'Ingresos', 'Acreedora', 1, 1603, 4);
INSERT INTO cuenta VALUES (1605, '70311', 'Terceros', 'Ingresos', 'Acreedora', 1, 1604, 5);
INSERT INTO cuenta VALUES (1606, '70312', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1604, 5);
INSERT INTO cuenta VALUES (1607, '7032', 'Servicios – local', 'Ingresos', 'Acreedora', 1, 1603, 4);
INSERT INTO cuenta VALUES (1608, '70321', 'Terceros', 'Ingresos', 'Acreedora', 1, 1607, 5);
INSERT INTO cuenta VALUES (1609, '70322', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1607, 5);
INSERT INTO cuenta VALUES (1610, '704', 'Subproductos, desechos y desperdicios', 'Ingresos', 'Acreedora', 1, 1588, 3);
INSERT INTO cuenta VALUES (1611, '7041', 'Subproductos', 'Ingresos', 'Acreedora', 1, 1610, 4);
INSERT INTO cuenta VALUES (1612, '70411', 'Terceros', 'Ingresos', 'Acreedora', 1, 1611, 5);
INSERT INTO cuenta VALUES (1613, '70412', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1611, 5);
INSERT INTO cuenta VALUES (1614, '7042', 'Desechos y desperdicios', 'Ingresos', 'Acreedora', 1, 1610, 4);
INSERT INTO cuenta VALUES (1615, '70421', 'Terceros', 'Ingresos', 'Acreedora', 1, 1614, 5);
INSERT INTO cuenta VALUES (1616, '70422', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1614, 5);
INSERT INTO cuenta VALUES (1617, '709', 'Devoluciones sobre ventas', 'Ingresos', 'Deudora', 1, 1588, 3);
INSERT INTO cuenta VALUES (1618, '7091', 'Mercaderías – Venta de exportación', 'Ingresos', 'Deudora', 1, 1617, 4);
INSERT INTO cuenta VALUES (1619, '70911', 'Terceros', 'Ingresos', 'Deudora', 1, 1618, 5);
INSERT INTO cuenta VALUES (1620, '70912', 'Relacionadas', 'Ingresos', 'Deudora', 1, 1618, 5);
INSERT INTO cuenta VALUES (1621, '7092', 'Mercaderías – Venta local', 'Ingresos', 'Deudora', 1, 1617, 4);
INSERT INTO cuenta VALUES (1622, '70921', 'Terceros', 'Ingresos', 'Deudora', 1, 1621, 5);
INSERT INTO cuenta VALUES (1623, '70922', 'Relacionadas', 'Ingresos', 'Deudora', 1, 1621, 5);
INSERT INTO cuenta VALUES (1624, '7093', 'Productos terminados – Venta de exportación', 'Ingresos', 'Deudora', 1, 1617, 4);
INSERT INTO cuenta VALUES (1625, '70931', 'Terceros', 'Ingresos', 'Deudora', 1, 1624, 5);
INSERT INTO cuenta VALUES (1626, '70932', 'Relacionadas', 'Ingresos', 'Deudora', 1, 1624, 5);
INSERT INTO cuenta VALUES (1627, '7094', 'Productos terminados – Venta local', 'Ingresos', 'Deudora', 1, 1617, 4);
INSERT INTO cuenta VALUES (1628, '70941', 'Terceros', 'Ingresos', 'Deudora', 1, 1627, 5);
INSERT INTO cuenta VALUES (1629, '70942', 'Relacionadas', 'Ingresos', 'Deudora', 1, 1627, 5);
INSERT INTO cuenta VALUES (1630, '7095', 'Inventarios de servicios rechazados', 'Ingresos', 'Deudora', 1, 1617, 4);
INSERT INTO cuenta VALUES (1631, '70951', 'Terceros', 'Ingresos', 'Deudora', 1, 1630, 5);
INSERT INTO cuenta VALUES (1632, '70952', 'Relacionadas', 'Ingresos', 'Deudora', 1, 1630, 5);
INSERT INTO cuenta VALUES (1633, '7096', 'Subproductos, desechos y desperdicios', 'Ingresos', 'Deudora', 1, 1617, 4);
INSERT INTO cuenta VALUES (1634, '70961', 'Terceros', 'Ingresos', 'Deudora', 1, 1633, 5);
INSERT INTO cuenta VALUES (1635, '70962', 'Relacionadas', 'Ingresos', 'Deudora', 1, 1633, 5);
INSERT INTO cuenta VALUES (1636, '71', 'VARIACIÓN DE LA PRODUCCIÓN ALMACENADA', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1637, '711', 'Variación de productos terminados', 'Ingresos', 'Acreedora', 1, 1636, 3);
INSERT INTO cuenta VALUES (1638, '7111', 'Productos terminados', 'Ingresos', 'Acreedora', 1, 1637, 4);
INSERT INTO cuenta VALUES (1639, '712', 'Variación de subproductos, desechos y desperdicios', 'Ingresos', 'Acreedora', 1, 1636, 3);
INSERT INTO cuenta VALUES (1640, '7121', 'Subproductos', 'Ingresos', 'Acreedora', 1, 1639, 4);
INSERT INTO cuenta VALUES (1641, '7122', 'Desechos y desperdicios', 'Ingresos', 'Acreedora', 1, 1639, 4);
INSERT INTO cuenta VALUES (1642, '713', 'Variación de productos en proceso', 'Ingresos', 'Acreedora', 1, 1636, 3);
INSERT INTO cuenta VALUES (1643, '7131', 'Productos en proceso de manufactura', 'Ingresos', 'Acreedora', 1, 1642, 4);
INSERT INTO cuenta VALUES (1644, '714', 'Variación de envases y embalajes', 'Ingresos', 'Acreedora', 1, 1636, 3);
INSERT INTO cuenta VALUES (1645, '7141', 'Envases', 'Ingresos', 'Acreedora', 1, 1644, 4);
INSERT INTO cuenta VALUES (1646, '7142', 'Embalajes', 'Ingresos', 'Acreedora', 1, 1644, 4);
INSERT INTO cuenta VALUES (1647, '715', 'Variación de inventarios de servicios', 'Ingresos', 'Acreedora', 1, 1636, 3);
INSERT INTO cuenta VALUES (1648, '7151', 'Inventarios de servicios en proceso', 'Ingresos', 'Acreedora', 1, 1647, 4);
INSERT INTO cuenta VALUES (1649, '72', 'PRODUCCIÓN DE ACTIVO INMOVILIZADO', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1650, '721', 'Propiedades de inversión', 'Ingresos', 'Acreedora', 1, 1649, 3);
INSERT INTO cuenta VALUES (1651, '7211', 'Edificaciones', 'Ingresos', 'Acreedora', 1, 1650, 4);
INSERT INTO cuenta VALUES (1652, '722', 'Propiedad, planta y equipo', 'Ingresos', 'Acreedora', 1, 1649, 3);
INSERT INTO cuenta VALUES (1653, '7220', 'Planta productora', 'Ingresos', 'Acreedora', 1, 1652, 4);
INSERT INTO cuenta VALUES (1654, '7221', 'Edificaciones', 'Ingresos', 'Acreedora', 1, 1652, 4);
INSERT INTO cuenta VALUES (1655, '7222', 'Maquinarias y otros equipos de explotación', 'Ingresos', 'Acreedora', 1, 1652, 4);
INSERT INTO cuenta VALUES (1656, '7223', 'Unidades de transporte', 'Ingresos', 'Acreedora', 1, 1652, 4);
INSERT INTO cuenta VALUES (1657, '7224', 'Muebles y enseres', 'Ingresos', 'Acreedora', 1, 1652, 4);
INSERT INTO cuenta VALUES (1658, '7225', 'Equipos diversos', 'Ingresos', 'Acreedora', 1, 1652, 4);
INSERT INTO cuenta VALUES (1659, '723', 'Intangibles', 'Ingresos', 'Acreedora', 1, 1649, 3);
INSERT INTO cuenta VALUES (1660, '7231', 'Programas de computadora (software)', 'Ingresos', 'Acreedora', 1, 1659, 4);
INSERT INTO cuenta VALUES (1661, '7232', 'Costos de exploración y desarrollo', 'Ingresos', 'Acreedora', 1, 1659, 4);
INSERT INTO cuenta VALUES (1662, '7233', 'Fórmulas, diseños y prototipos', 'Ingresos', 'Acreedora', 1, 1659, 4);
INSERT INTO cuenta VALUES (1663, '724', 'Activos biológicos', 'Ingresos', 'Acreedora', 1, 1649, 3);
INSERT INTO cuenta VALUES (1664, '7241', 'Activos biológicos en desarrollo de origen animal', 'Ingresos', 'Acreedora', 1, 1663, 4);
INSERT INTO cuenta VALUES (1665, '7242', 'Activos biológicos en desarrollo de origen vegetal', 'Ingresos', 'Acreedora', 1, 1663, 4);
INSERT INTO cuenta VALUES (1666, '725', 'Costos de financiación capitalizados', 'Ingresos', 'Acreedora', 1, 1649, 3);
INSERT INTO cuenta VALUES (1667, '7251', 'Costos de financiación – Propiedades de inversión', 'Ingresos', 'Acreedora', 1, 1666, 4);
INSERT INTO cuenta VALUES (1668, '72511', 'Plantas productoras en desarrollo', 'Ingresos', 'Acreedora', 1, 1667, 5);
INSERT INTO cuenta VALUES (1669, '72512', 'Edificaciones', 'Ingresos', 'Acreedora', 1, 1667, 5);
INSERT INTO cuenta VALUES (1670, '7252', 'Costos de financiación – Propiedad, planta y equipo', 'Ingresos', 'Acreedora', 1, 1666, 4);
INSERT INTO cuenta VALUES (1671, '72521', 'Plantas productoras en desarrollo', 'Ingresos', 'Acreedora', 1, 1670, 5);
INSERT INTO cuenta VALUES (1672, '72522', 'Edificaciones', 'Ingresos', 'Acreedora', 1, 1670, 5);
INSERT INTO cuenta VALUES (1673, '72523', 'Maquinarias y otros equipos de explotación', 'Ingresos', 'Acreedora', 1, 1670, 5);
INSERT INTO cuenta VALUES (1674, '7253', 'Costos de financiación – Intangibles', 'Ingresos', 'Acreedora', 1, 1666, 4);
INSERT INTO cuenta VALUES (1675, '7254', 'Costos de financiación – Activos biológicos en desarrollo', 'Ingresos', 'Acreedora', 1, 1666, 4);
INSERT INTO cuenta VALUES (1676, '72541', 'Activos biológicos de origen animal', 'Ingresos', 'Acreedora', 1, 1675, 5);
INSERT INTO cuenta VALUES (1677, '72542', 'Activos biológicos de origen vegetal', 'Ingresos', 'Acreedora', 1, 1675, 5);
INSERT INTO cuenta VALUES (1678, '73', 'DESCUENTOS, REBAJAS Y BONIFICACIONES OBTENIDOS', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1679, '731', 'Descuentos, rebajas y bonificaciones obtenidos', 'Ingresos', 'Acreedora', 1, 1678, 3);
INSERT INTO cuenta VALUES (1680, '7311', 'Terceros', 'Ingresos', 'Acreedora', 1, 1679, 4);
INSERT INTO cuenta VALUES (1681, '7312', 'Relacionadas', 'Ingresos', 'Acreedora', 1, 1679, 4);
INSERT INTO cuenta VALUES (1682, '74', 'DESCUENTOS, REBAJAS y BONIFICACIONES CONCEDIDOS', 'Ingresos', 'Deudora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1683, '741', 'Descuentos, rebajas y bonificaciones concedidos', 'Ingresos', 'Deudora', 1, 1682, 3);
INSERT INTO cuenta VALUES (1684, '7411', 'Terceros', 'Ingresos', 'Deudora', 1, 1683, 4);
INSERT INTO cuenta VALUES (1685, '7412', 'Relacionadas', 'Ingresos', 'Deudora', 1, 1683, 4);
INSERT INTO cuenta VALUES (1687, '75', 'OTROS INGRESOS DE GESTIÓN', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1688, '751', 'Servicios en beneficio del personal', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1689, '752', 'Comisiones y corretajes', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1690, '753', 'Regalías', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1691, '754', 'Alquileres', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1692, '7540', 'Plantas productoras', 'Ingresos', 'Acreedora', 1, 1691, 4);
INSERT INTO cuenta VALUES (1693, '7541', 'Terrenos', 'Ingresos', 'Acreedora', 1, 1691, 4);
INSERT INTO cuenta VALUES (1694, '7542', 'Edificaciones', 'Ingresos', 'Acreedora', 1, 1691, 4);
INSERT INTO cuenta VALUES (1695, '7543', 'Maquinarias y equipos de explotación', 'Ingresos', 'Acreedora', 1, 1691, 4);
INSERT INTO cuenta VALUES (1696, '7544', 'Unidades de transporte', 'Ingresos', 'Acreedora', 1, 1691, 4);
INSERT INTO cuenta VALUES (1697, '7545', 'Equipos diversos', 'Ingresos', 'Acreedora', 1, 1691, 4);
INSERT INTO cuenta VALUES (1698, '755', 'Recuperación de cuentas de valuación', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1699, '7551', 'Recuperación – Cuentas de cobranza dudosa', 'Ingresos', 'Acreedora', 1, 1698, 4);
INSERT INTO cuenta VALUES (1700, '7552', 'Recuperación – Desvalorización de inventarios', 'Ingresos', 'Acreedora', 1, 1698, 4);
INSERT INTO cuenta VALUES (1701, '7553', 'Recuperación – Desvalorización de inversiones mobiliarias', 'Ingresos', 'Acreedora', 1, 1698, 4);
INSERT INTO cuenta VALUES (1702, '756', 'Enajenación de activos inmovilizados', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1703, '7561', 'Inversiones mobiliarias', 'Ingresos', 'Acreedora', 1, 1702, 4);
INSERT INTO cuenta VALUES (1704, '7562', 'Propiedades de inversión', 'Ingresos', 'Acreedora', 1, 1702, 4);
INSERT INTO cuenta VALUES (1705, '7563', 'Activos adquiridos en arrendamiento financiero', 'Ingresos', 'Acreedora', 1, 1702, 4);
INSERT INTO cuenta VALUES (1706, '7564', 'Propiedad, planta y equipo', 'Ingresos', 'Acreedora', 1, 1702, 4);
INSERT INTO cuenta VALUES (1707, '7565', 'Intangibles', 'Ingresos', 'Acreedora', 1, 1702, 4);
INSERT INTO cuenta VALUES (1708, '7566', 'Activos biológicos', 'Ingresos', 'Acreedora', 1, 1702, 4);
INSERT INTO cuenta VALUES (1709, '757', 'Recuperación de deterioro de cuentas de activos inmovilizados', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1710, '7571', 'Recuperación de deterioro de propiedades de inversión', 'Ingresos', 'Acreedora', 1, 1709, 4);
INSERT INTO cuenta VALUES (1711, '7572', 'Recuperación de deterioro de propiedad, planta y equipo', 'Ingresos', 'Acreedora', 1, 1709, 4);
INSERT INTO cuenta VALUES (1712, '7573', 'Recuperación de deterioro de intangibles', 'Ingresos', 'Acreedora', 1, 1709, 4);
INSERT INTO cuenta VALUES (1713, '7574', 'Recuperación de deterioro de activos biológicos', 'Ingresos', 'Acreedora', 1, 1709, 4);
INSERT INTO cuenta VALUES (1714, '759', 'Otros ingresos de gestión', 'Ingresos', 'Acreedora', 1, 1687, 3);
INSERT INTO cuenta VALUES (1715, '7591', 'Subsidios gubernamentales', 'Ingresos', 'Acreedora', 1, 1714, 4);
INSERT INTO cuenta VALUES (1716, '7592', 'Reclamos al seguro', 'Ingresos', 'Acreedora', 1, 1714, 4);
INSERT INTO cuenta VALUES (1717, '7593', 'Donaciones', 'Ingresos', 'Acreedora', 1, 1714, 4);
INSERT INTO cuenta VALUES (1718, '7594', 'Devoluciones tributarias', 'Ingresos', 'Acreedora', 1, 1714, 4);
INSERT INTO cuenta VALUES (1719, '7599', 'Otros ingresos de gestión', 'Ingresos', 'Acreedora', 1, 1714, 4);
INSERT INTO cuenta VALUES (1720, '76', 'GANANCIA POR MEDICIÓN DE ACTIVOS NO FINANCIEROS AL VALOR RAZONABLE', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1721, '761', 'Activo realizable', 'Ingresos', 'Acreedora', 1, 1720, 3);
INSERT INTO cuenta VALUES (1722, '7611', 'Mercaderías', 'Ingresos', 'Acreedora', 1, 1721, 4);
INSERT INTO cuenta VALUES (1723, '7612', 'Productos terminados', 'Ingresos', 'Acreedora', 1, 1721, 4);
INSERT INTO cuenta VALUES (1724, '7613', 'Activos no corrientes mantenidos para la venta', 'Ingresos', 'Acreedora', 1, 1721, 4);
INSERT INTO cuenta VALUES (1725, '76131', 'Propiedades de inversión', 'Ingresos', 'Acreedora', 1, 1724, 5);
INSERT INTO cuenta VALUES (1726, '76132', 'Propiedad, planta y equipo', 'Ingresos', 'Acreedora', 1, 1724, 5);
INSERT INTO cuenta VALUES (1727, '76133', 'Intangibles', 'Ingresos', 'Acreedora', 1, 1724, 5);
INSERT INTO cuenta VALUES (1728, '76134', 'Activos biológicos', 'Ingresos', 'Acreedora', 1, 1724, 5);
INSERT INTO cuenta VALUES (1729, '762', 'Activo inmovilizado', 'Ingresos', 'Acreedora', 1, 1720, 3);
INSERT INTO cuenta VALUES (1730, '7621', 'Propiedades de inversión', 'Ingresos', 'Acreedora', 1, 1729, 4);
INSERT INTO cuenta VALUES (1731, '7622', 'Activos biológicos', 'Ingresos', 'Acreedora', 1, 1729, 4);
INSERT INTO cuenta VALUES (1732, '77', 'INGRESOS FINANCIEROS', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1733, '771', 'Ganancia por instrumento financiero derivado', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1734, '772', 'Rendimientos ganados', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1735, '7721', 'Depósitos en instituciones financieras', 'Ingresos', 'Acreedora', 1, 1734, 4);
INSERT INTO cuenta VALUES (1736, '7722', 'Cuentas por cobrar comerciales', 'Ingresos', 'Acreedora', 1, 1734, 4);
INSERT INTO cuenta VALUES (1737, '7723', 'Préstamos otorgados', 'Ingresos', 'Acreedora', 1, 1734, 4);
INSERT INTO cuenta VALUES (1738, '7724', 'Inversiones a ser mantenidas hasta el vencimiento', 'Ingresos', 'Acreedora', 1, 1734, 4);
INSERT INTO cuenta VALUES (1739, '7725', 'Instrumentos financieros representativos de derecho patrimonial', 'Ingresos', 'Acreedora', 1, 1734, 4);
INSERT INTO cuenta VALUES (1740, '773', 'Dividendos', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1741, '774', 'Ingresos en operaciones de factoraje (factoring)', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1742, '775', 'Descuentos obtenidos por pronto pago', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1743, '776', 'Diferencia en cambio', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1744, '777', 'Ganancia por medición de activos y pasivos financieros al valor razonable', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1745, '7771', 'Inversiones mantenidas para negociación', 'Ingresos', 'Acreedora', 1, 1744, 4);
INSERT INTO cuenta VALUES (1746, '7772', 'Otras inversiones', 'Ingresos', 'Acreedora', 1, 1744, 4);
INSERT INTO cuenta VALUES (1747, '7773', 'Otras', 'Ingresos', 'Acreedora', 1, 1744, 4);
INSERT INTO cuenta VALUES (1748, '778', 'Participación en resultados de entidades relacionadas', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1749, '7781', 'Participación en los resultados de subsidiarias y asociadas bajo el método del valor patrimonial', 'Ingresos', 'Acreedora', 1, 1748, 4);
INSERT INTO cuenta VALUES (1750, '7782', 'Ingresos por participaciones en negocios conjuntos', 'Ingresos', 'Acreedora', 1, 1748, 4);
INSERT INTO cuenta VALUES (1751, '779', 'Otros ingresos financieros', 'Ingresos', 'Acreedora', 1, 1732, 3);
INSERT INTO cuenta VALUES (1752, '7792', 'Ingresos financieros en medición a valor descontado', 'Ingresos', 'Acreedora', 1, 1751, 4);
INSERT INTO cuenta VALUES (1753, '78', 'CARGAS CUBIERTAS POR PROVISIONES', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1754, '781', 'Cargas cubiertas por provisiones', 'Ingresos', 'Acreedora', 1, 1753, 3);
INSERT INTO cuenta VALUES (1755, '79', 'CARGAS IMPUTABLES A CUENTAS DE COSTOS Y GASTOS', 'Ingresos', 'Acreedora', 1, 1587, 2);
INSERT INTO cuenta VALUES (1756, '791', 'Cargas imputables a cuentas de costos y gastos', 'Ingresos', 'Acreedora', 1, 1755, 3);
INSERT INTO cuenta VALUES (1757, '792', 'Gastos financieros imputables a cuentas de inventarios', 'Ingresos', 'Acreedora', 1, 1755, 3);
INSERT INTO cuenta VALUES (1758, '8', 'SALDOS INTERMEDIARIOS DE GESTIÓN Y DETERMINACIÓN DEL RESULTADO DEL EJERCICIO', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, None, 1);
INSERT INTO cuenta VALUES (1759, '80', 'MARGEN COMERCIAL', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1760, '801', 'Margen comercial', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1759, 3);
INSERT INTO cuenta VALUES (1761, '81', 'PRODUCCIÓN DEL EJERCICIO', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1762, '811', 'Producción de bienes', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1761, 3);
INSERT INTO cuenta VALUES (1763, '812', 'Producción de servicios', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1761, 3);
INSERT INTO cuenta VALUES (1764, '813', 'Producción de activo inmovilizado', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1761, 3);
INSERT INTO cuenta VALUES (1765, '82', 'VALOR AGREGADO', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1766, '821', 'Valor agregado', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1765, 3);
INSERT INTO cuenta VALUES (1767, '83', 'EXCEDENTE BRUTO (INSUFICIENCIA BRUTA) DE EXPLOTACIÓN', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1768, '831', 'Excedente bruto (insuficiencia bruta) de explotación', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1767, 3);
INSERT INTO cuenta VALUES (1769, '84', 'RESULTADO DE EXPLOTACIÓN', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1770, '841', 'Resultado de explotación', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1769, 3);
INSERT INTO cuenta VALUES (1771, '85', 'RESULTADO ANTES DE PARTICIPACIONES E IMPUESTOS', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1772, '851', 'Resultado antes del impuesto a las ganancias', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1771, 3);
INSERT INTO cuenta VALUES (1773, '88', 'IMPUESTO A LA RENTA', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1774, '881', 'Impuesto a las ganancias – Corriente', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1773, 3);
INSERT INTO cuenta VALUES (1775, '882', 'Impuesto a las ganancias – Diferido', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1773, 3);
INSERT INTO cuenta VALUES (1776, '89', 'DETERMINACIÓN DEL RESULTADO DEL EJERCICIO', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1758, 2);
INSERT INTO cuenta VALUES (1777, '891', 'Utilidad', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1776, 3);
INSERT INTO cuenta VALUES (1778, '892', 'Pérdida', 'Saldos Intermediarios de Gestión', 'Acreedora', 1, 1776, 3);
INSERT INTO cuenta VALUES (1779, '1031', 'Efectivo en tránsito', 'Activo', 'Deudora', 1, 5, 4);
INSERT INTO cuenta VALUES (1780, '1032', 'Cheques en tránsito', 'Activo', 'Deudora', 1, 5, 4);

CREATE TABLE `destinatario` (
  `id_destinatario` int NOT NULL AUTO_INCREMENT,
  `ruc` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dni` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `apellidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `razon_social` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ubicacion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_destinatario`),
  UNIQUE KEY `ruc` (`ruc`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO destinatario VALUES (1, '12345678910', None, None, None, 'INGRESO - TALLER', 'Balta', None, None, None);
INSERT INTO destinatario VALUES (2, '10452136547', None, None, None, 'INGRESO 2 - TALLER', 'Chiclayo', None, None, None);
INSERT INTO destinatario VALUES (3, '20541236987', None, None, None, 'EMPRESA DEST 3', 'Chiclayo', None, None, None);
INSERT INTO destinatario VALUES (4, None, '45678912', 'Karhy', 'Urtecho', None, 'Chiclayo', None, None, None);
INSERT INTO destinatario VALUES (5, None, '74766053', 'Juan', 'Perez', None, 'Chiclayo', None, None, None);

CREATE TABLE `detalle_asiento` (
  `id_detalle_asiento` int NOT NULL AUTO_INCREMENT,
  `id_asiento` int NOT NULL,
  `id_cuenta` int NOT NULL,
  `debe` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `haber` decimal(20,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`id_detalle_asiento`),
  KEY `id_asiento` (`id_asiento`),
  KEY `id_cuenta` (`id_cuenta`),
  CONSTRAINT `detalle_asiento_ibfk_1` FOREIGN KEY (`id_asiento`) REFERENCES `asiento_contable` (`id_asiento`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_asiento_ibfk_2` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`id_cuenta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_asiento VALUES (263, 142, 49, 171.360000, 0.000000);
INSERT INTO detalle_asiento VALUES (264, 142, 941, 0.000000, 22.680000);
INSERT INTO detalle_asiento VALUES (265, 142, 1594, 0.000000, 148.680000);
INSERT INTO detalle_asiento VALUES (266, 143, 1181, 625.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (267, 143, 941, 112.500000, 0.000000);
INSERT INTO detalle_asiento VALUES (268, 143, 1007, 0.000000, 737.500000);
INSERT INTO detalle_asiento VALUES (269, 144, 167, 625.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (270, 144, 1216, 0.000000, 625.000000);
INSERT INTO detalle_asiento VALUES (271, 145, 1005, 737.500000, 0.000000);
INSERT INTO detalle_asiento VALUES (272, 145, 6, 0.000000, 737.500000);
INSERT INTO detalle_asiento VALUES (273, 146, 49, 171.360000, 0.000000);
INSERT INTO detalle_asiento VALUES (274, 146, 941, 0.000000, 22.680000);
INSERT INTO detalle_asiento VALUES (275, 146, 1594, 0.000000, 148.680000);

CREATE TABLE `detalle_compra` (
  `id_detalle_compra` int NOT NULL AUTO_INCREMENT,
  `id_compra` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle_compra`),
  KEY `id_compra` (`id_compra`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`),
  CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_compra VALUES (39, 32, 16, 5, 69.00, 345.00);
INSERT INTO detalle_compra VALUES (40, 32, 13, 5, 56.00, 280.00);

CREATE TABLE `detalle_envio` (
  `id_guiaremision` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT (0),
  `undm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_guiaremision`,`id_producto`),
  KEY `FKdetalle_en483320` (`id_producto`),
  KEY `FKdetalle_en343443` (`id_guiaremision`),
  CONSTRAINT `FK_detalle_envio_guia_remision` FOREIGN KEY (`id_guiaremision`) REFERENCES `guia_remision` (`id_guiaremision`),
  CONSTRAINT `FKdetalle_en483320` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_envio VALUES (76, 3, 10, 'KGM');
INSERT INTO detalle_envio VALUES (77, 3, 25, 'KGM');
INSERT INTO detalle_envio VALUES (78, 3, 40, 'KGM');
INSERT INTO detalle_envio VALUES (79, 3, 5, 'KGM');
INSERT INTO detalle_envio VALUES (80, 3, 10, 'KGM');
INSERT INTO detalle_envio VALUES (81, 4, 10, 'KGM');
INSERT INTO detalle_envio VALUES (82, 4, 20, 'KGM');
INSERT INTO detalle_envio VALUES (83, 4, 20, 'KGM');
INSERT INTO detalle_envio VALUES (84, 4, 50, 'KGM');
INSERT INTO detalle_envio VALUES (85, 4, 17, 'KGM');

CREATE TABLE `detalle_nota` (
  `id_detalle_nota` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_nota` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(20,6) NOT NULL DEFAULT (0),
  `total` decimal(20,6) NOT NULL DEFAULT (0),
  PRIMARY KEY (`id_detalle_nota`) USING BTREE,
  KEY `FKdetalle_no414204` (`id_producto`),
  KEY `FKdetalle_no200596` (`id_nota`) USING BTREE,
  CONSTRAINT `FKdetalle_no200596` FOREIGN KEY (`id_nota`) REFERENCES `nota` (`id_nota`),
  CONSTRAINT `FKdetalle_no414204` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_nota VALUES (12, 4, 9, 34, 50.000000, 1700.000000);
INSERT INTO detalle_nota VALUES (13, 4, 10, 23, 50.000000, 1150.000000);

CREATE TABLE `detalle_venta` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_venta` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(9,2) NOT NULL,
  `descuento` int DEFAULT NULL,
  `total` decimal(9,2) NOT NULL,
  PRIMARY KEY (`id_detalle`) USING BTREE,
  KEY `FKdetalle_ve758085` (`id_venta`),
  KEY `FKdetalle_ve323232` (`id_producto`),
  CONSTRAINT `FKdetalle_ve758085` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  CONSTRAINT `FKdetalle_ve907712` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_venta VALUES (268, 16, 338, 1, 69.00, 0, 69.00);
INSERT INTO detalle_venta VALUES (269, 15, 338, 1, 57.00, 0, 57.00);
INSERT INTO detalle_venta VALUES (270, 16, 339, 1, 69.00, 0, 69.00);
INSERT INTO detalle_venta VALUES (271, 15, 339, 1, 57.00, 0, 57.00);

CREATE TABLE `detalle_venta_boucher` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta_boucher` int DEFAULT NULL,
  `id_producto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `undm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nom_marca` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `sub_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_venta_boucher` (`id_venta_boucher`),
  CONSTRAINT `detalle_venta_boucher_ibfk_1` FOREIGN KEY (`id_venta_boucher`) REFERENCES `venta_boucher` (`id_venta_boucher`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_venta_boucher VALUES (1, 1, None, None, None, None, None, None, None, None);
INSERT INTO detalle_venta_boucher VALUES (2, 2, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (3, 3, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 2, 50.00, 0.00, 100.00);
INSERT INTO detalle_venta_boucher VALUES (4, 4, '13', 'PANTALON 03', 'KGM', 'tormenta', 1, 56.00, 0.00, 56.00);
INSERT INTO detalle_venta_boucher VALUES (5, 5, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (6, 6, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (7, 7, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (8, 8, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (9, 9, '7', 'Chaqueta de mezclilla ajustada', 'NIU', 'tormenta', 1, 79.99, 0.00, 79.99);
INSERT INTO detalle_venta_boucher VALUES (10, 10, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (11, 11, '7', 'Chaqueta de mezclilla ajustada', 'NIU', 'tormenta', 1, 79.99, 0.00, 79.99);
INSERT INTO detalle_venta_boucher VALUES (12, 12, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (13, 12, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (14, 13, '7', 'Chaqueta de mezclilla ajustada', 'NIU', 'tormenta', 1, 79.99, 0.00, 79.99);
INSERT INTO detalle_venta_boucher VALUES (15, 14, '11', 'PANTALON 01', 'KGM', 'tormenta', 1, 68.00, 0.00, 68.00);
INSERT INTO detalle_venta_boucher VALUES (16, 15, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 5, 50.00, 0.00, 250.00);
INSERT INTO detalle_venta_boucher VALUES (17, 16, '13', 'PANTALON 03', 'KGM', 'tormenta', 1, 56.00, 0.00, 56.00);
INSERT INTO detalle_venta_boucher VALUES (18, 17, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 3, 50.00, 0.00, 150.00);
INSERT INTO detalle_venta_boucher VALUES (19, 18, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 4, 50.00, 0.00, 200.00);
INSERT INTO detalle_venta_boucher VALUES (20, 19, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (21, 20, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 9, 50.00, 0.00, 450.00);
INSERT INTO detalle_venta_boucher VALUES (22, 21, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 9, 50.00, 0.00, 450.00);
INSERT INTO detalle_venta_boucher VALUES (23, 22, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 5, 89.99, 0.00, 449.95);
INSERT INTO detalle_venta_boucher VALUES (24, 23, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 8, 50.00, 0.00, 400.00);
INSERT INTO detalle_venta_boucher VALUES (25, 24, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 4, 89.99, 0.00, 359.96);
INSERT INTO detalle_venta_boucher VALUES (26, 25, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 4, 89.99, 0.00, 359.96);
INSERT INTO detalle_venta_boucher VALUES (27, 26, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 1, 89.99, 0.00, 89.99);
INSERT INTO detalle_venta_boucher VALUES (28, 27, '8', 'Pantalones de lino beige', 'NIU', 'tormenta', 5, 69.99, 0.00, 349.95);
INSERT INTO detalle_venta_boucher VALUES (29, 28, '7', 'Chaqueta de mezclilla ajustada', 'NIU', 'tormenta', 6, 79.99, 0.00, 479.94);
INSERT INTO detalle_venta_boucher VALUES (30, 29, '7', 'Chaqueta de mezclilla ajustada', 'NIU', 'tormenta', 5, 79.99, 0.00, 399.95);
INSERT INTO detalle_venta_boucher VALUES (31, 30, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (32, 31, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (33, 32, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (34, 33, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (35, 34, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (36, 35, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 1, 89.99, 0.00, 89.99);
INSERT INTO detalle_venta_boucher VALUES (37, 36, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 1, 50.00, 0.00, 50.00);
INSERT INTO detalle_venta_boucher VALUES (38, 37, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 1, 89.99, 0.00, 89.99);
INSERT INTO detalle_venta_boucher VALUES (39, 38, '11', 'PANTALON 01', 'KGM', 'tormenta', 1, 68.00, 0.00, 68.00);
INSERT INTO detalle_venta_boucher VALUES (40, 39, '4', 'Pantalones de lino con ajuste relajado', 'KGM', 'tormenta', 4, 50.00, 0.00, 200.00);
INSERT INTO detalle_venta_boucher VALUES (41, 40, '3', 'Chaqueta de mezclilla con parches decorativos', 'KGM', 'tormenta', 4, 50.00, 0.00, 200.00);
INSERT INTO detalle_venta_boucher VALUES (42, 41, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 5, 89.99, 0.00, 449.95);
INSERT INTO detalle_venta_boucher VALUES (43, 42, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 3, 89.99, 0.00, 269.97);
INSERT INTO detalle_venta_boucher VALUES (44, 43, '10', 'Pantalon jean rasgado azul marino', 'NIU', 'tormenta', 6, 70.00, 0.00, 420.00);
INSERT INTO detalle_venta_boucher VALUES (45, 47, '7', 'Chaqueta de mezclilla ajustada', 'NIU', 'tormenta', 2, 79.99, 0.00, 159.98);
INSERT INTO detalle_venta_boucher VALUES (46, 47, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 2, 89.99, 0.00, 179.98);
INSERT INTO detalle_venta_boucher VALUES (47, 50, '6', 'Vestido largo negro de terciopelo', 'NIU', 'tormenta', 2, 89.99, 0.00, 179.98);
INSERT INTO detalle_venta_boucher VALUES (48, 50, '13', 'PANTALON 03', 'KGM', 'tormenta', 2, 56.00, 0.00, 112.00);

CREATE TABLE `guia_remision` (
  `id_guiaremision` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int NOT NULL,
  `id_ubigeo_o` int NOT NULL,
  `id_ubigeo_d` int NOT NULL,
  `id_destinatario` int NOT NULL,
  `id_transportista` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_comprobante` int NOT NULL,
  `glosa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `dir_partida` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dir_destino` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `peso` decimal(20,6) DEFAULT NULL,
  `observacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `f_generacion` date NOT NULL,
  `h_generacion` time NOT NULL,
  `estado_guia` tinyint(1) NOT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`id_guiaremision`),
  KEY `FKguia_remis858090` (`id_sucursal`),
  KEY `FKguia_remis135328` (`id_destinatario`),
  KEY `FKguia_remis14384` (`id_transportista`),
  KEY `FKguia_remis242932` (`id_comprobante`),
  KEY `FKguia_remis315482` (`id_ubigeo_o`) USING BTREE,
  KEY `FKguia_remis315483` (`id_ubigeo_d`) USING BTREE,
  CONSTRAINT `FKguia_remis135328` FOREIGN KEY (`id_destinatario`) REFERENCES `destinatario` (`id_destinatario`),
  CONSTRAINT `FKguia_remis14384` FOREIGN KEY (`id_transportista`) REFERENCES `transportista` (`id_transportista`),
  CONSTRAINT `FKguia_remis242932` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`),
  CONSTRAINT `FKguia_remis315483` FOREIGN KEY (`id_ubigeo_d`) REFERENCES `ubigeo` (`id_ubigeo`),
  CONSTRAINT `FKguia_remis454313` FOREIGN KEY (`id_ubigeo_o`) REFERENCES `ubigeo` (`id_ubigeo`),
  CONSTRAINT `FKguia_remis858090` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO guia_remision VALUES (76, 1, 1208, 1222, 1, 'T0000001', 9, 'Entrega de 10 jeans', '', '', None, None, '', 2024-04-21, 10:30:00, 1, 340.000000);
INSERT INTO guia_remision VALUES (77, 1, 1222, 1219, 1, 'T0000002', 107, 'Entrega de 25 jeans', '', '', None, None, '', 2024-05-12, 15:15:00, 1, 850.000000);
INSERT INTO guia_remision VALUES (78, 2, 1219, 1208, 1, 'T0000001', 108, 'Entrega de 40 jeans', '', '', None, None, '', 2024-04-14, 9:45:00, 1, 1360.000000);
INSERT INTO guia_remision VALUES (79, 1, 1219, 1208, 1, 'T0000003', 109, 'Entrega de 5 jeans', '', '', None, None, '', 2024-05-14, 14:00:00, 1, 170.000000);
INSERT INTO guia_remision VALUES (80, 1, 1208, 1222, 2, 'T0000001', 110, 'Entrega de 10 jeans', '', '', None, None, '', 2024-06-01, 11:00:00, 1, 340.000000);
INSERT INTO guia_remision VALUES (81, 1, 1208, 1222, 2, 'T0000002', 111, 'Entrega de 10 jeans', '', '', None, None, '', 2024-06-15, 14:30:00, 1, 340.000000);
INSERT INTO guia_remision VALUES (82, 1, 1222, 1208, 3, 'T0000005', 112, 'Entrega de 20 jeans', '', '', None, None, '', 2024-05-05, 10:15:00, 1, 680.000000);
INSERT INTO guia_remision VALUES (83, 1, 1222, 1208, 3, 'T0000002', 113, 'Entrega de 20 jeans', '', '', None, None, '', 2024-05-20, 15:45:00, 1, 680.000000);
INSERT INTO guia_remision VALUES (84, 2, 1219, 1208, 4, 'T0000004', 114, 'Entrega de 30 jeans', '', '', None, None, '', 2024-03-01, 9:30:00, 1, 1020.000000);
INSERT INTO guia_remision VALUES (85, 1, 98, 133, 3, 'T0000001', 239, 'TRASLADO ENTRE ALMACENES DE LA MISMA CIA.', 'Por aqui', 'Chiclayo', None, None, 'Marlon, vete a la mierda', 2024-08-16, 22:40:35, 0, None);

CREATE TABLE `inventario` (
  `id_producto` int NOT NULL,
  `id_almacen` int NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id_producto`,`id_almacen`),
  KEY `FKinventario620330` (`id_almacen`),
  CONSTRAINT `FKinventario399278` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `FKinventario620330` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`id_almacen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO inventario VALUES (3, 1, 28);
INSERT INTO inventario VALUES (3, 2, 70);
INSERT INTO inventario VALUES (4, 1, 33);
INSERT INTO inventario VALUES (4, 2, 68);
INSERT INTO inventario VALUES (4, 3, 34);
INSERT INTO inventario VALUES (4, 5, 23);
INSERT INTO inventario VALUES (6, 1, 49);
INSERT INTO inventario VALUES (7, 1, 56);
INSERT INTO inventario VALUES (8, 1, 65);
INSERT INTO inventario VALUES (9, 1, 68);
INSERT INTO inventario VALUES (10, 1, 65);
INSERT INTO inventario VALUES (11, 1, 78);
INSERT INTO inventario VALUES (12, 1, 74);
INSERT INTO inventario VALUES (13, 1, 65);
INSERT INTO inventario VALUES (14, 1, 118);
INSERT INTO inventario VALUES (15, 1, 157);
INSERT INTO inventario VALUES (16, 1, 74);

CREATE TABLE `marca` (
  `id_marca` int NOT NULL AUTO_INCREMENT,
  `nom_marca` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_marca` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `nom_marca` (`nom_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO marca VALUES (1, 'tormenta', 1);
INSERT INTO marca VALUES (2, 'Dashir', 1);
INSERT INTO marca VALUES (5, 'A', 1);

CREATE TABLE `nota` (
  `id_nota` int NOT NULL AUTO_INCREMENT,
  `id_almacenO` int NOT NULL,
  `id_almacenD` int DEFAULT NULL,
  `id_tiponota` int NOT NULL,
  `id_destinatario` int DEFAULT NULL,
  `id_comprobante` int NOT NULL,
  `glosa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `nom_nota` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_nota` tinyint(1) NOT NULL,
  `observacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`id_nota`),
  KEY `FKnota867576` (`id_tiponota`),
  KEY `FKnota453423` (`id_destinatario`) USING BTREE,
  KEY `FKnota546432` (`id_almacenO`),
  KEY `FKnota436412` (`id_almacenD`),
  KEY `FKnota593821` (`id_comprobante`) USING BTREE,
  KEY `fk_id_usuario` (`id_usuario`),
  CONSTRAINT `fk_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_nota_5458363` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`),
  CONSTRAINT `FK_nota_db_tormenta.destinatario` FOREIGN KEY (`id_destinatario`) REFERENCES `destinatario` (`id_destinatario`),
  CONSTRAINT `FKnota867576` FOREIGN KEY (`id_tiponota`) REFERENCES `tipo_nota` (`id_tiponota`),
  CONSTRAINT `FKnota_34567343` FOREIGN KEY (`id_almacenO`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `FKnota_54363455` FOREIGN KEY (`id_almacenD`) REFERENCES `almacen` (`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO nota VALUES (9, 1, 3, 1, 4, 240, 'COMPRA EN EL PAIS', 2024-08-16, 'INGRESO - ANGIE', 0, 'No se, Angie solo tiene un buen rabazo', 1);
INSERT INTO nota VALUES (10, 3, 5, 1, 5, 241, 'COMPRA EN EL PAIS', 2024-08-16, 'INGRESO - ANGIE - 2', 0, 'Nada de nada', 1);

CREATE TABLE `periodo_contable` (
  `id_periodo` int NOT NULL AUTO_INCREMENT,
  `nombre_periodo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado_periodo` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_periodo`),
  UNIQUE KEY `nombre_periodo` (`nombre_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO periodo_contable VALUES (1, 'Periodo 2024', 2024-01-01, 2024-12-31, 1);

CREATE TABLE `producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `id_marca` int NOT NULL,
  `id_subcategoria` int NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `precio` decimal(5,2) DEFAULT NULL,
  `cod_barras` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `undm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `estado_producto` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `descripcion` (`descripcion`),
  UNIQUE KEY `cod_barras` (`cod_barras`),
  KEY `FKproducto768968` (`id_subcategoria`),
  KEY `FKproducto132770` (`id_marca`),
  CONSTRAINT `FKproducto132770` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`),
  CONSTRAINT `FKproducto768968` FOREIGN KEY (`id_subcategoria`) REFERENCES `sub_categoria` (`id_subcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO producto VALUES (3, 1, 4, 'Chaqueta de mezclilla con parches decorativos', 50.00, '1335567890123', 'KGM', 1);
INSERT INTO producto VALUES (4, 1, 1, 'Pantalones de lino con ajuste relajado', 50.00, 'PROSCN23210098', 'KGM', 1);
INSERT INTO producto VALUES (6, 1, 12, 'Vestido largo negro de terciopelo', 89.99, '1234567890124', 'NIU', 1);
INSERT INTO producto VALUES (7, 1, 4, 'Chaqueta de mezclilla ajustada', 79.99, '1234567890125', 'NIU', 1);
INSERT INTO producto VALUES (8, 1, 1, 'Pantalones de lino beige', 69.99, '1234567890126', 'NIU', 1);
INSERT INTO producto VALUES (9, 1, 6, 'Falda recortada con estampado de cuadros', 60.00, '1234567890127', 'KGM', 1);
INSERT INTO producto VALUES (10, 1, 1, 'Pantalon jean rasgado azul marino', 70.00, 'P00000000010', 'NIU', 1);
INSERT INTO producto VALUES (11, 1, 1, 'PANTALON 01', 68.00, 'P00000000011', 'KGM', 1);
INSERT INTO producto VALUES (12, 1, 1, 'PANTALON 02', 78.00, 'P00000000012', 'KGM', 1);
INSERT INTO producto VALUES (13, 1, 1, 'PANTALON 03', 56.00, 'P00000000013', 'KGM', 1);
INSERT INTO producto VALUES (14, 1, 1, 'PANTALON 04', 47.00, 'P00000000014', 'KGM', 1);
INSERT INTO producto VALUES (15, 1, 1, 'PANTALON 05', 57.00, 'P00000000015', 'KGM', 1);
INSERT INTO producto VALUES (16, 1, 1, 'PANTALON 06', 69.00, 'P00000000016', 'KGM', 1);
INSERT INTO producto VALUES (17, 2, 4, 'adssa', 222.00, 'P00000000017', 'KGM', 1);

CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `ruc` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado_proveedor` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_proveedor`),
  UNIQUE KEY `ruc` (`ruc`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO proveedor VALUES (1, '20123456789', 'Proveedor ABC S.A.', 'Av. Principal 123, Lima', '0123456789', 'contacto@proveedorabc.com', 1);
INSERT INTO proveedor VALUES (2, '20198765432', 'Servicios XYZ E.I.R.L.', 'Calle Secundaria 456, Arequipa', '0987654321', 'info@serviciosxyz.com', 1);
INSERT INTO proveedor VALUES (3, '20111122233', 'Distribuidora LMN', 'Jr. Comercio 789, Trujillo', '0155555555', 'ventas@distribuidoralmn.com', 1);
INSERT INTO proveedor VALUES (4, '20144455566', 'Importaciones OPQ SAC', 'Av. Industrial 111, Chiclayo', '0144444444', 'soporte@importacionesopq.com', 0);
INSERT INTO proveedor VALUES (5, '20155566677', 'Tecnología RST', 'Pasaje Innovación 222, Cusco', '0133333333', 'contacto@tecnologiarst.com', 1);

CREATE TABLE `reglas_contabilizacion` (
  `id_regla` int NOT NULL AUTO_INCREMENT,
  `tipo_transaccion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cuenta_debe` int DEFAULT NULL,
  `cuenta_haber` int DEFAULT NULL,
  `nombre_regla` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tipo_monto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_regla`),
  KEY `idx_tipo_transaccion` (`tipo_transaccion`),
  KEY `fk_cuenta_debe` (`cuenta_debe`),
  KEY `fk_cuenta_haber` (`cuenta_haber`),
  CONSTRAINT `fk_regla_cuenta_debe` FOREIGN KEY (`cuenta_debe`) REFERENCES `cuenta` (`id_cuenta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_regla_cuenta_haber` FOREIGN KEY (`cuenta_haber`) REFERENCES `cuenta` (`id_cuenta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO reglas_contabilizacion VALUES (1, 'venta_contado', 49, None, 'Registro del monto total en Cuentas por Cobrar (1212)', 1, 2024-10-19 21:31:07, 2024-11-06 21:01:42, 'monto_total');
INSERT INTO reglas_contabilizacion VALUES (2, 'venta_contado', None, 941, 'Registro del IGV por pagar (40111)', 1, 2024-10-19 21:32:50, 2024-10-25 23:10:19, 'igv');
INSERT INTO reglas_contabilizacion VALUES (3, 'venta_contado', None, 1594, 'Registro de la venta neta en Ventas (70121)', 1, 2024-10-19 21:32:55, 2024-10-25 23:10:00, 'base_imponible');
INSERT INTO reglas_contabilizacion VALUES (8, 'compra_contado', 1181, None, 'Mercaderias (Compra contado 1)', 1, 2024-10-30 07:45:32, 2024-11-06 04:45:57, 'base_imponible');
INSERT INTO reglas_contabilizacion VALUES (10, 'compra_contado', 941, None, 'IGV (Compra contado)', 1, 2024-10-30 07:52:35, 2024-10-30 07:52:35, 'igv');
INSERT INTO reglas_contabilizacion VALUES (12, 'compra_contado', None, 1007, 'Emitidas haber (Compra contado)', 1, 2024-10-30 07:55:39, 2024-10-30 07:55:39, 'monto_total');
INSERT INTO reglas_contabilizacion VALUES (22, 'compra_contado_2', 1005, None, 'Registro de compras cuentas por pagar segundo asiento', 1, 2024-11-05 02:04:04, 2024-11-05 02:34:49, 'monto_total');
INSERT INTO reglas_contabilizacion VALUES (23, 'compra_contado_2', None, 6, 'Registro de compras efectivo segundo asiento', 1, 2024-11-05 02:07:24, 2024-11-05 02:35:40, 'monto_total');
INSERT INTO reglas_contabilizacion VALUES (24, 'compra_contado_3', 167, None, 'Registro de base imponible (Compra contado) tercer asiento', 1, 2024-11-05 02:08:10, 2024-11-05 09:28:17, 'base_imponible');
INSERT INTO reglas_contabilizacion VALUES (25, 'compra_contado_3', None, 1216, 'Registro de compras var. invent. tercer asiento', 1, 2024-11-05 02:08:58, 2024-11-05 02:28:41, 'base_imponible');

CREATE TABLE `rol` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nom_rol` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_rol` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nom_rol` (`nom_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO rol VALUES (1, 'ADMIN', 0);
INSERT INTO rol VALUES (2, 'CONTADOR', 0);
INSERT INTO rol VALUES (3, 'EMPLEADO', 0);

CREATE TABLE `sub_categoria` (
  `id_subcategoria` int NOT NULL AUTO_INCREMENT,
  `id_categoria` int NOT NULL,
  `nom_subcat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_subcat` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_subcategoria`),
  UNIQUE KEY `nom_subcat` (`nom_subcat`),
  KEY `FKsub_catego159123` (`id_categoria`),
  CONSTRAINT `FKsub_catego159123` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO sub_categoria VALUES (1, 2, 'Pantalon', 1);
INSERT INTO sub_categoria VALUES (2, 3, 'Materia Prima', 1);
INSERT INTO sub_categoria VALUES (3, 2, 'Blusas Jeans', 1);
INSERT INTO sub_categoria VALUES (4, 2, 'Casacas Jeans', 1);
INSERT INTO sub_categoria VALUES (5, 2, 'Conjunto Deportivos', 1);
INSERT INTO sub_categoria VALUES (6, 2, 'Minifaldas', 1);
INSERT INTO sub_categoria VALUES (7, 2, 'Overoles', 1);
INSERT INTO sub_categoria VALUES (8, 2, 'Poleras Franeladas', 1);
INSERT INTO sub_categoria VALUES (9, 2, 'Polos', 1);
INSERT INTO sub_categoria VALUES (10, 2, 'Shorts', 1);
INSERT INTO sub_categoria VALUES (11, 2, 'Torero', 1);
INSERT INTO sub_categoria VALUES (12, 2, 'Vestidos Jeans', 1);

CREATE TABLE `sucursal` (
  `id_sucursal` int NOT NULL AUTO_INCREMENT,
  `dni` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombre_sucursal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ubicacion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_sucursal` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_sucursal`),
  KEY `FKsucursal936123` (`dni`),
  CONSTRAINT `FKsucursal936123` FOREIGN KEY (`dni`) REFERENCES `vendedor` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO sucursal VALUES (1, '25713047', 'Tienda Arica-3', 'Por aqui', 1);
INSERT INTO sucursal VALUES (2, '23541234', 'Tienda Arica-2', 'AV. ARICA 1028 INT 22 GALERIA CENTRAL', 1);
INSERT INTO sucursal VALUES (3, '26436789', 'Tienda Arica-1', 'CA. ARICA #1028 INT. 52-53', 1);
INSERT INTO sucursal VALUES (4, '26465789', 'Tienda Balta', 'AV. BALTA 1444 INT. 01 GALERIA D ANGELO', 1);
INSERT INTO sucursal VALUES (5, '45678921', 'Oficina', 'CAL. SAN MARTIN NRO. 1573', 1);

CREATE TABLE `sucursal_almacen` (
  `id_sucursal` int NOT NULL,
  `id_almacen` int NOT NULL,
  PRIMARY KEY (`id_sucursal`,`id_almacen`),
  KEY `FKsucursal_a442696` (`id_almacen`),
  CONSTRAINT `FKsucursal_a442696` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `FKsucursal_a640333` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO sucursal_almacen VALUES (1, 1);
INSERT INTO sucursal_almacen VALUES (2, 2);
INSERT INTO sucursal_almacen VALUES (3, 3);
INSERT INTO sucursal_almacen VALUES (5, 4);
INSERT INTO sucursal_almacen VALUES (4, 5);

CREATE TABLE `tipo_comprobante` (
  `id_tipocomprobante` int NOT NULL AUTO_INCREMENT,
  `nom_tipocomp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_tipocomprobante`),
  UNIQUE KEY `nom_tipocomp` (`nom_tipocomp`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO tipo_comprobante VALUES (1, 'Boleta');
INSERT INTO tipo_comprobante VALUES (2, 'Factura');
INSERT INTO tipo_comprobante VALUES (5, 'Guia de remision');
INSERT INTO tipo_comprobante VALUES (4, 'Nota de credito');
INSERT INTO tipo_comprobante VALUES (6, 'Nota de ingreso');
INSERT INTO tipo_comprobante VALUES (7, 'Nota de salida');
INSERT INTO tipo_comprobante VALUES (3, 'Nota de venta');

CREATE TABLE `tipo_nota` (
  `id_tiponota` int NOT NULL AUTO_INCREMENT,
  `nom_tiponota` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_tiponota`),
  UNIQUE KEY `nom_tiponota` (`nom_tiponota`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO tipo_nota VALUES (1, 'Nota de ingreso');
INSERT INTO tipo_nota VALUES (2, 'Nota de salida');

CREATE TABLE `transportista` (
  `id_transportista` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `placa` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dni` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ruc` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `apellidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `razon_social` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_transportista`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `ruc` (`ruc`),
  KEY `FKtransporti173737` (`placa`),
  CONSTRAINT `FKtransporti173737` FOREIGN KEY (`placa`) REFERENCES `vehiculo` (`placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO transportista VALUES ('T0000001', 'XYZ456', None, '12345678912', None, None, 'Transportes ABC S.A.', '074777333');
INSERT INTO transportista VALUES ('T0000002', 'XYZ786', None, '98765432109', None, None, 'Transportes XYZ S.A.', '074777333');
INSERT INTO transportista VALUES ('T0000003', 'XYZ900', '12345678', None, 'Alvaro', 'Yong', None, '987654321');
INSERT INTO transportista VALUES ('T0000004', 'ABC123', '98765432', None, 'Joe', 'Torres', None, '953764311');
INSERT INTO transportista VALUES ('T0000005', 'ABC124', None, '87654321087', None, None, 'Autos XYZ S.A.', '543210987');
INSERT INTO transportista VALUES ('T0000006', 'MNO789', '54321098', None, 'Pedro', 'Quispe', None, '987731344');
INSERT INTO transportista VALUES ('T0000007', 'PRS432', '21098765', None, 'Chano', 'Rappi', None, '951748422');

CREATE TABLE `ubigeo` (
  `id_ubigeo` int NOT NULL AUTO_INCREMENT,
  `codigo_ubigeo` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `departamento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `provincia` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `distrito` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_ubigeo`)
) ENGINE=InnoDB AUTO_INCREMENT=1839 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `almacen` (
  `id_almacen` int(11) NOT NULL AUTO_INCREMENT,
  `nom_almacen` varchar(100) NOT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `estado_almacen` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO almacen VALUES (1, 'ALM CENTRAL ESCALERA', '', 1);
INSERT INTO almacen VALUES (2, 'ALMACEN CENTRAL 22', '', 1);
INSERT INTO almacen VALUES (3, 'ALM CENTRAL 52-53', '', 1);
INSERT INTO almacen VALUES (4, 'ALM PRODUCCION', '', 1);
INSERT INTO almacen VALUES (5, 'ALM BALTA 7-8', '', 1);

CREATE TABLE `anular_sunat` (
  `id_anular` int(11) NOT NULL,
  `anular` int(11) NOT NULL,
  PRIMARY KEY (`id_anular`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO anular_sunat VALUES (4, 3);

CREATE TABLE `anular_sunat_b` (
  `id_anular_b` int(11) NOT NULL,
  `anular_b` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_anular_b`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO anular_sunat_b VALUES (5, 6);

CREATE TABLE `asiento_contable` (
  `id_asiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_periodo` int(11) NOT NULL,
  `fecha_asiento` date NOT NULL,
  `glosa` varchar(255) NOT NULL,
  `tipo_asiento` varchar(50) NOT NULL,
  `estado_asiento` tinyint(1) NOT NULL,
  `total_debe` decimal(20,6) NOT NULL,
  `total_haber` decimal(20,6) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_comprobante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_asiento`),
  KEY `id_periodo` (`id_periodo`),
  KEY `id_usuario` (`id_usuario`),
  KEY `fk_id_comprobante` (`id_comprobante`),
  CONSTRAINT `asiento_contable_ibfk_1` FOREIGN KEY (`id_periodo`) REFERENCES `periodo_contable` (`id_periodo`) ON UPDATE CASCADE,
  CONSTRAINT `asiento_contable_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_id_comprobante` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO asiento_contable VALUES (127, 1, 2024-11-06, 'POR EL REGISTRO DE LA COMPRA DE MERCADER�A', 'compra_contado', 1, 825.940000, 825.940000, None, 380);
INSERT INTO asiento_contable VALUES (128, 1, 2024-11-06, 'POR EL INGRESO DE LA MERCADER�A AL ALMAC�N', 'compra_contado_3', 1, 699.950000, 699.950000, None, 380);
INSERT INTO asiento_contable VALUES (129, 1, 2024-11-06, 'POR EL PAGO DE LA FACTURA DEL PROVEEDOR B001-3612', 'compra_contado_2', 1, 825.940000, 825.940000, None, 380);
INSERT INTO asiento_contable VALUES (130, 1, 2024-11-06, 'POR EL REGISTRO DE LA COMPRA DE MERCADER�A', 'compra_contado', 1, 6136.000000, 6136.000000, None, 368);
INSERT INTO asiento_contable VALUES (131, 1, 2024-11-06, 'POR EL INGRESO DE LA MERCADER�A AL ALMAC�N', 'compra_contado_3', 1, 5200.000000, 5200.000000, None, 368);
INSERT INTO asiento_contable VALUES (132, 1, 2024-11-06, 'POR EL PAGO DE LA FACTURA DEL PROVEEDOR B001-380', 'compra_contado_2', 1, 6136.000000, 6136.000000, None, 368);
INSERT INTO asiento_contable VALUES (133, 1, 2024-11-06, 'POR EL REGISTRO DE LA COMPRA DE MERCADER�A', 'compra_contado', 1, 12272.000000, 12272.000000, None, 380);
INSERT INTO asiento_contable VALUES (134, 1, 2024-11-06, 'POR EL INGRESO DE LA MERCADER�A AL ALMAC�N', 'compra_contado_3', 1, 10400.000000, 10400.000000, None, 380);
INSERT INTO asiento_contable VALUES (135, 1, 2024-11-06, 'POR EL PAGO DE LA FACTURA DEL PROVEEDOR B001-3612', 'compra_contado_2', 1, 12272.000000, 12272.000000, None, 380);
INSERT INTO asiento_contable VALUES (137, 1, 2024-11-06, 'POR LA VENTA DE MERCADER�A SEG�N BOLETA B100-00000015', 'venta_contado', 1, 748.000000, 748.000000, None, 383);
INSERT INTO asiento_contable VALUES (138, 1, 2024-11-10, 'POR EL REGISTRO DE LA COMPRA DE MERCADER�A', 'compra_contado', 1, 814.200000, 814.200000, None, 380);
INSERT INTO asiento_contable VALUES (139, 1, 2024-11-10, 'POR EL INGRESO DE LA MERCADER�A AL ALMAC�N', 'compra_contado_3', 1, 690.000000, 690.000000, None, 380);
INSERT INTO asiento_contable VALUES (140, 1, 2024-11-10, 'POR EL PAGO DE LA FACTURA DEL PROVEEDOR B001-3612', 'compra_contado_2', 1, 814.200000, 814.200000, None, 380);
INSERT INTO asiento_contable VALUES (141, 1, 2024-11-19, 'POR EL REGISTRO DE LA COMPRA DE MERCADER�A', 'compra_contado', 1, 81.420000, 81.420000, None, 384);
INSERT INTO asiento_contable VALUES (142, 1, 2024-11-19, 'POR EL INGRESO DE LA MERCADER�A AL ALMAC�N', 'compra_contado_3', 1, 69.000000, 69.000000, None, 384);
INSERT INTO asiento_contable VALUES (143, 1, 2024-11-19, 'POR EL PAGO DE LA FACTURA DEL PROVEEDOR B11001100', 'compra_contado_2', 1, 81.420000, 81.420000, None, 384);
INSERT INTO asiento_contable VALUES (144, 1, 2024-11-19, 'POR EL REGISTRO DE LA COMPRA DE MERCADER�A', 'compra_contado', 1, 148.680000, 148.680000, None, 385);
INSERT INTO asiento_contable VALUES (145, 1, 2024-11-19, 'POR EL INGRESO DE LA MERCADER�A AL ALMAC�N', 'compra_contado_3', 1, 126.000000, 126.000000, None, 385);
INSERT INTO asiento_contable VALUES (146, 1, 2024-11-19, 'POR EL PAGO DE LA FACTURA DEL PROVEEDOR B001-3617', 'compra_contado_2', 1, 148.680000, 148.680000, None, 385);

CREATE TABLE `bitacora_nota` (
  `id_bitacora` int(11) NOT NULL AUTO_INCREMENT,
  `id_nota` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_almacen` int(11) DEFAULT NULL,
  `id_detalle_nota` int(11) DEFAULT NULL,
  `entra` int(11) DEFAULT NULL,
  `sale` int(11) DEFAULT NULL,
  `stock_anterior` int(11) DEFAULT NULL,
  `stock_actual` int(11) DEFAULT NULL,
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
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nom_categoria` varchar(255) NOT NULL,
  `estado_categoria` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nom_categoria` (`nom_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO categoria VALUES (2, 'Producto', 1);
INSERT INTO categoria VALUES (3, 'Materia Prima', 1);

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `dni` char(8) DEFAULT NULL,
  `ruc` char(11) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `razon_social` varchar(100) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `estado_cliente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO cliente VALUES (1, '73747576', '', 'Ruben', 'Meladoblas', '', '', 0);
INSERT INTO cliente VALUES (2, '', '10524578961', '', '', 'Empresa VALDOS I.R.L', '', 0);
INSERT INTO cliente VALUES (3, '76070007', '', 'LEYDI VANESSA', 'IDROGO TANTAJULCA', '', '', 0);
INSERT INTO cliente VALUES (15, '99999999', '', 'Cliente', 'Varios', '', '', 0);

CREATE TABLE `compra` (
  `id_compra` int(11) NOT NULL AUTO_INCREMENT,
  `id_proveedor` int(11) NOT NULL,
  `nro_comprobante` varchar(255) NOT NULL,
  `estado_compra` int(11) DEFAULT NULL,
  `f_compra` date DEFAULT NULL,
  `igv` decimal(10,2) DEFAULT NULL,
  `monto_total` decimal(10,2) DEFAULT NULL,
  `id_comprobante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO compra VALUES (23, 1, 'B001-380', 1, 2024-11-05, 9.00, 59.00, 368);
INSERT INTO compra VALUES (24, 5, 'B001-382', 1, 2024-11-05, 25.20, 165.20, 369);
INSERT INTO compra VALUES (25, 1, 'B001-382', 1, 2024-11-05, 131.40, 861.40, 369);
INSERT INTO compra VALUES (27, 1, 'B001-3612', 1, 2024-11-05, 104.40, 684.40, 380);
INSERT INTO compra VALUES (28, 1, 'B001-3612', 1, 2024-11-06, 125.99, 825.94, 380);
INSERT INTO compra VALUES (29, 1, 'B001-380', 1, 2024-11-06, 936.00, 6136.00, 368);
INSERT INTO compra VALUES (30, 2, 'B001-3612', 1, 2024-11-06, 1872.00, 12272.00, 380);
INSERT INTO compra VALUES (31, 1, 'B001-3612', 1, 2024-11-10, 124.20, 814.20, 380);
INSERT INTO compra VALUES (33, 1, 'B001-3617', 1, 2024-11-19, 22.68, 148.68, 385);

CREATE TABLE `comprobante` (
  `id_comprobante` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipocomprobante` int(11) NOT NULL,
  `num_comprobante` varchar(255) NOT NULL,
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
INSERT INTO comprobante VALUES (384, 1, 'B11001100');
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
INSERT INTO comprobante VALUES (385, 2, 'F100-00000013');
INSERT INTO comprobante VALUES (310, 3, 'N100-00000001');
INSERT INTO comprobante VALUES (353, 3, 'N100-00000001');

CREATE TABLE `cuenta` (
  `id_cuenta` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_cuenta` varchar(20) NOT NULL,
  `nombre_cuenta` varchar(255) NOT NULL,
  `tipo_cuenta` varchar(50) NOT NULL,
  `naturaleza` varchar(10) NOT NULL,
  `estado_cuenta` tinyint(1) NOT NULL DEFAULT 1,
  `cuenta_padre` int(11) DEFAULT NULL,
  `nivel` int(11) NOT NULL,
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
INSERT INTO cuenta VALUES (169, '20111', 'Costo', 'Activo', 'Deudora', 0, 168, 5);
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
INSERT INTO cuenta VALUES (181, '221', 'Subproductos', 'Activo', 'Deudora', 0, 180, 3);
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
  `id_destinatario` int(11) NOT NULL AUTO_INCREMENT,
  `ruc` char(11) DEFAULT NULL,
  `dni` char(8) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `razon_social` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
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
  `id_detalle_asiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_asiento` int(11) NOT NULL,
  `id_cuenta` int(11) NOT NULL,
  `debe` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `haber` decimal(20,6) NOT NULL DEFAULT 0.000000,
  PRIMARY KEY (`id_detalle_asiento`),
  KEY `id_asiento` (`id_asiento`),
  KEY `id_cuenta` (`id_cuenta`),
  CONSTRAINT `detalle_asiento_ibfk_1` FOREIGN KEY (`id_asiento`) REFERENCES `asiento_contable` (`id_asiento`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_asiento_ibfk_2` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`id_cuenta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_asiento VALUES (227, 127, 1181, 699.950000, 0.000000);
INSERT INTO detalle_asiento VALUES (228, 127, 941, 125.990000, 0.000000);
INSERT INTO detalle_asiento VALUES (229, 127, 1007, 0.000000, 825.940000);
INSERT INTO detalle_asiento VALUES (230, 128, 167, 699.950000, 0.000000);
INSERT INTO detalle_asiento VALUES (231, 128, 1216, 0.000000, 699.950000);
INSERT INTO detalle_asiento VALUES (232, 129, 1005, 825.940000, 0.000000);
INSERT INTO detalle_asiento VALUES (233, 129, 6, 0.000000, 825.940000);
INSERT INTO detalle_asiento VALUES (234, 130, 1181, 5200.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (235, 130, 941, 936.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (236, 130, 1007, 0.000000, 6136.000000);
INSERT INTO detalle_asiento VALUES (237, 131, 167, 5200.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (238, 131, 1216, 0.000000, 5200.000000);
INSERT INTO detalle_asiento VALUES (239, 132, 1005, 6136.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (240, 132, 6, 0.000000, 6136.000000);
INSERT INTO detalle_asiento VALUES (241, 133, 1181, 10400.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (242, 133, 941, 1872.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (243, 133, 1007, 0.000000, 12272.000000);
INSERT INTO detalle_asiento VALUES (244, 134, 167, 10400.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (245, 134, 1216, 0.000000, 10400.000000);
INSERT INTO detalle_asiento VALUES (246, 135, 1005, 12272.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (247, 135, 6, 0.000000, 12272.000000);
INSERT INTO detalle_asiento VALUES (250, 137, 49, 748.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (251, 137, 941, 0.000000, 99.000000);
INSERT INTO detalle_asiento VALUES (252, 137, 1594, 0.000000, 649.000000);
INSERT INTO detalle_asiento VALUES (253, 138, 1181, 690.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (254, 138, 941, 124.200000, 0.000000);
INSERT INTO detalle_asiento VALUES (255, 138, 1007, 0.000000, 814.200000);
INSERT INTO detalle_asiento VALUES (256, 139, 167, 690.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (257, 139, 1216, 0.000000, 690.000000);
INSERT INTO detalle_asiento VALUES (258, 140, 1005, 814.200000, 0.000000);
INSERT INTO detalle_asiento VALUES (259, 140, 6, 0.000000, 814.200000);
INSERT INTO detalle_asiento VALUES (260, 141, 1181, 69.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (261, 141, 941, 12.420000, 0.000000);
INSERT INTO detalle_asiento VALUES (262, 141, 1007, 0.000000, 81.420000);
INSERT INTO detalle_asiento VALUES (263, 142, 167, 69.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (264, 142, 1216, 0.000000, 69.000000);
INSERT INTO detalle_asiento VALUES (265, 143, 1005, 81.420000, 0.000000);
INSERT INTO detalle_asiento VALUES (266, 143, 6, 0.000000, 81.420000);
INSERT INTO detalle_asiento VALUES (267, 144, 1181, 126.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (268, 144, 941, 22.680000, 0.000000);
INSERT INTO detalle_asiento VALUES (269, 144, 1007, 0.000000, 148.680000);
INSERT INTO detalle_asiento VALUES (270, 145, 167, 126.000000, 0.000000);
INSERT INTO detalle_asiento VALUES (271, 145, 1216, 0.000000, 126.000000);
INSERT INTO detalle_asiento VALUES (272, 146, 1005, 148.680000, 0.000000);
INSERT INTO detalle_asiento VALUES (273, 146, 6, 0.000000, 148.680000);

CREATE TABLE `detalle_compra` (
  `id_detalle_compra` int(11) NOT NULL AUTO_INCREMENT,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle_compra`),
  KEY `id_compra` (`id_compra`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`),
  CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_compra VALUES (25, 23, 4, 1, 50.00, 50.00);
INSERT INTO detalle_compra VALUES (26, 24, 10, 2, 70.00, 140.00);
INSERT INTO detalle_compra VALUES (27, 25, 12, 5, 78.00, 390.00);
INSERT INTO detalle_compra VALUES (28, 25, 11, 5, 68.00, 340.00);
INSERT INTO detalle_compra VALUES (29, 27, 16, 5, 69.00, 345.00);
INSERT INTO detalle_compra VALUES (30, 27, 14, 5, 47.00, 235.00);
INSERT INTO detalle_compra VALUES (31, 28, 6, 5, 89.99, 449.95);
INSERT INTO detalle_compra VALUES (32, 28, 4, 5, 50.00, 250.00);
INSERT INTO detalle_compra VALUES (33, 29, 15, 50, 57.00, 2850.00);
INSERT INTO detalle_compra VALUES (34, 29, 14, 50, 47.00, 2350.00);
INSERT INTO detalle_compra VALUES (35, 30, 15, 100, 57.00, 5700.00);
INSERT INTO detalle_compra VALUES (36, 30, 14, 100, 47.00, 4700.00);
INSERT INTO detalle_compra VALUES (37, 31, 10, 5, 70.00, 350.00);
INSERT INTO detalle_compra VALUES (38, 31, 11, 5, 68.00, 340.00);
INSERT INTO detalle_compra VALUES (39, 32, 16, 1, 69.00, 69.00);
INSERT INTO detalle_compra VALUES (40, 33, 16, 1, 69.00, 69.00);
INSERT INTO detalle_compra VALUES (41, 33, 15, 1, 57.00, 57.00);

CREATE TABLE `detalle_envio` (
  `id_guiaremision` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0,
  `undm` varchar(50) NOT NULL,
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
  `id_detalle_nota` int(11) NOT NULL AUTO_INCREMENT,
  `id_producto` int(11) NOT NULL,
  `id_nota` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total` decimal(20,6) NOT NULL DEFAULT 0.000000,
  PRIMARY KEY (`id_detalle_nota`) USING BTREE,
  KEY `FKdetalle_no414204` (`id_producto`),
  KEY `FKdetalle_no200596` (`id_nota`) USING BTREE,
  CONSTRAINT `FKdetalle_no200596` FOREIGN KEY (`id_nota`) REFERENCES `nota` (`id_nota`),
  CONSTRAINT `FKdetalle_no414204` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_nota VALUES (12, 4, 9, 34, 50.000000, 1700.000000);
INSERT INTO detalle_nota VALUES (13, 4, 10, 23, 50.000000, 1150.000000);

CREATE TABLE `detalle_venta` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_producto` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(9,2) NOT NULL,
  `descuento` int(11) DEFAULT NULL,
  `total` decimal(9,2) NOT NULL,
  PRIMARY KEY (`id_detalle`) USING BTREE,
  KEY `FKdetalle_ve758085` (`id_venta`),
  KEY `FKdetalle_ve323232` (`id_producto`),
  CONSTRAINT `FKdetalle_ve758085` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  CONSTRAINT `FKdetalle_ve907712` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO detalle_venta VALUES (249, 7, 325, 2, 79.99, 0, 159.98);
INSERT INTO detalle_venta VALUES (250, 6, 325, 2, 89.99, 0, 179.98);
INSERT INTO detalle_venta VALUES (253, 14, 328, 2, 47.00, 0, 94.00);
INSERT INTO detalle_venta VALUES (254, 13, 328, 2, 56.00, 0, 112.00);
INSERT INTO detalle_venta VALUES (255, 6, 329, 2, 89.99, 0, 179.98);
INSERT INTO detalle_venta VALUES (256, 13, 329, 2, 56.00, 0, 112.00);
INSERT INTO detalle_venta VALUES (257, 13, 331, 1, 56.00, 0, 56.00);
INSERT INTO detalle_venta VALUES (258, 13, 332, 2, 56.00, 0, 112.00);
INSERT INTO detalle_venta VALUES (259, 12, 332, 2, 78.00, 0, 156.00);
INSERT INTO detalle_venta VALUES (260, 15, 333, 5, 57.00, 0, 285.00);
INSERT INTO detalle_venta VALUES (261, 3, 333, 5, 50.00, 0, 250.00);
INSERT INTO detalle_venta VALUES (262, 14, 334, 4, 47.00, 0, 188.00);
INSERT INTO detalle_venta VALUES (263, 15, 334, 4, 57.00, 0, 228.00);
INSERT INTO detalle_venta VALUES (264, 16, 334, 4, 69.00, 0, 276.00);
INSERT INTO detalle_venta VALUES (265, 4, 336, 11, 50.00, 0, 550.00);

CREATE TABLE `detalle_venta_boucher` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_venta_boucher` int(11) DEFAULT NULL,
  `id_producto` varchar(50) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `undm` varchar(50) DEFAULT NULL,
  `nom_marca` varchar(100) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
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
  `id_guiaremision` int(11) NOT NULL AUTO_INCREMENT,
  `id_sucursal` int(11) NOT NULL,
  `id_ubigeo_o` int(11) NOT NULL,
  `id_ubigeo_d` int(11) NOT NULL,
  `id_destinatario` int(11) NOT NULL,
  `id_transportista` char(8) NOT NULL,
  `id_comprobante` int(11) NOT NULL,
  `glosa` varchar(100) NOT NULL DEFAULT '',
  `dir_partida` varchar(255) DEFAULT NULL,
  `dir_destino` varchar(255) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `peso` decimal(20,6) DEFAULT NULL,
  `observacion` text DEFAULT NULL,
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
  `id_producto` int(11) NOT NULL,
  `id_almacen` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
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
INSERT INTO inventario VALUES (13, 1, 60);
INSERT INTO inventario VALUES (14, 1, 218);
INSERT INTO inventario VALUES (15, 1, 212);
INSERT INTO inventario VALUES (16, 1, 73);

CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL AUTO_INCREMENT,
  `nom_marca` varchar(100) NOT NULL,
  `estado_marca` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `nom_marca` (`nom_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO marca VALUES (1, 'tormenta', 1);
INSERT INTO marca VALUES (2, 'Dashir', 1);
INSERT INTO marca VALUES (5, 'A', 1);

CREATE TABLE `nota` (
  `id_nota` int(11) NOT NULL AUTO_INCREMENT,
  `id_almacenO` int(11) NOT NULL,
  `id_almacenD` int(11) DEFAULT NULL,
  `id_tiponota` int(11) NOT NULL,
  `id_destinatario` int(11) DEFAULT NULL,
  `id_comprobante` int(11) NOT NULL,
  `glosa` varchar(100) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `nom_nota` varchar(50) NOT NULL,
  `estado_nota` tinyint(1) NOT NULL,
  `observacion` text DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_nota`),
  KEY `FKnota867576` (`id_tiponota`),
  KEY `FKnota453423` (`id_destinatario`) USING BTREE,
  KEY `FKnota546432` (`id_almacenO`),
  KEY `FKnota436412` (`id_almacenD`),
  KEY `FKnota593821` (`id_comprobante`) USING BTREE,
  KEY `fk_id_usuario` (`id_usuario`),
  CONSTRAINT `FK_nota_5458363` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`),
  CONSTRAINT `FK_nota_db_tormenta.destinatario` FOREIGN KEY (`id_destinatario`) REFERENCES `destinatario` (`id_destinatario`),
  CONSTRAINT `FKnota867576` FOREIGN KEY (`id_tiponota`) REFERENCES `tipo_nota` (`id_tiponota`),
  CONSTRAINT `FKnota_34567343` FOREIGN KEY (`id_almacenO`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `FKnota_54363455` FOREIGN KEY (`id_almacenD`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `fk_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO nota VALUES (9, 1, 3, 1, 4, 240, 'COMPRA EN EL PAIS', 2024-08-16, 'INGRESO - ANGIE', 0, 'No se, Angie solo tiene un buen rabazo', 1);
INSERT INTO nota VALUES (10, 3, 5, 1, 5, 241, 'COMPRA EN EL PAIS', 2024-08-16, 'INGRESO - ANGIE - 2', 0, 'Nada de nada', 1);

CREATE TABLE `periodo_contable` (
  `id_periodo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_periodo` varchar(50) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado_periodo` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_periodo`),
  UNIQUE KEY `nombre_periodo` (`nombre_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO periodo_contable VALUES (1, 'Periodo 2024', 2024-01-01, 2024-12-31, 1);

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `id_marca` int(11) NOT NULL,
  `id_subcategoria` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL DEFAULT '',
  `precio` decimal(5,2) DEFAULT NULL,
  `cod_barras` varchar(100) DEFAULT NULL,
  `undm` varchar(50) NOT NULL DEFAULT '',
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
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `ruc` char(11) NOT NULL,
  `razon_social` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `estado_proveedor` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE KEY `ruc` (`ruc`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO proveedor VALUES (1, '20123456789', 'Proveedor ABC S.A.', 'Av. Principal 123, Lima', '0123456789', 'contacto@proveedorabc.com', 1);
INSERT INTO proveedor VALUES (2, '20198765432', 'Servicios XYZ E.I.R.L.', 'Calle Secundaria 456, Arequipa', '0987654321', 'info@serviciosxyz.com', 1);
INSERT INTO proveedor VALUES (3, '20111122233', 'Distribuidora LMN', 'Jr. Comercio 789, Trujillo', '0155555555', 'ventas@distribuidoralmn.com', 1);
INSERT INTO proveedor VALUES (4, '20144455566', 'Importaciones OPQ SAC', 'Av. Industrial 111, Chiclayo', '0144444444', 'soporte@importacionesopq.com', 0);
INSERT INTO proveedor VALUES (5, '20155566677', 'Tecnología RST', 'Pasaje Innovación 222, Cusco', '0133333333', 'contacto@tecnologiarst.com', 1);

CREATE TABLE `reglas_contabilizacion` (
  `id_regla` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_transaccion` varchar(50) NOT NULL,
  `cuenta_debe` int(11) DEFAULT NULL,
  `cuenta_haber` int(11) DEFAULT NULL,
  `nombre_regla` varchar(255) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tipo_monto` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_regla`),
  KEY `idx_tipo_transaccion` (`tipo_transaccion`),
  KEY `fk_cuenta_debe` (`cuenta_debe`),
  KEY `fk_cuenta_haber` (`cuenta_haber`),
  CONSTRAINT `fk_regla_cuenta_debe` FOREIGN KEY (`cuenta_debe`) REFERENCES `cuenta` (`id_cuenta`) ON UPDATE CASCADE,
  CONSTRAINT `fk_regla_cuenta_haber` FOREIGN KEY (`cuenta_haber`) REFERENCES `cuenta` (`id_cuenta`) ON UPDATE CASCADE
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
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nom_rol` varchar(20) NOT NULL,
  `estado_rol` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nom_rol` (`nom_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO rol VALUES (1, 'ADMIN', 0);
INSERT INTO rol VALUES (2, 'CONTADOR', 0);
INSERT INTO rol VALUES (3, 'EMPLEADO', 0);

CREATE TABLE `sub_categoria` (
  `id_subcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) NOT NULL,
  `nom_subcat` varchar(255) NOT NULL,
  `estado_subcat` tinyint(1) NOT NULL DEFAULT 1,
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
  `id_sucursal` int(11) NOT NULL AUTO_INCREMENT,
  `dni` char(8) DEFAULT NULL,
  `nombre_sucursal` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(100) NOT NULL,
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
  `id_sucursal` int(11) NOT NULL,
  `id_almacen` int(11) NOT NULL,
  PRIMARY KEY (`id_sucursal`,`id_almacen`),
  KEY `FKsucursal_a442696` (`id_almacen`),
  CONSTRAINT `FKsucursal_a442696` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `FKsucursal_a640333` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO sucursal_almacen VALUES (1, 1);
INSERT INTO sucursal_almacen VALUES (2, 2);
INSERT INTO sucursal_almacen VALUES (3, 3);
INSERT INTO sucursal_almacen VALUES (4, 5);
INSERT INTO sucursal_almacen VALUES (5, 4);

CREATE TABLE `tipo_comprobante` (
  `id_tipocomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `nom_tipocomp` varchar(50) NOT NULL DEFAULT '',
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
  `id_tiponota` int(11) NOT NULL AUTO_INCREMENT,
  `nom_tiponota` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tiponota`),
  UNIQUE KEY `nom_tiponota` (`nom_tiponota`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO tipo_nota VALUES (1, 'Nota de ingreso');
INSERT INTO tipo_nota VALUES (2, 'Nota de salida');

CREATE TABLE `transportista` (
  `id_transportista` char(8) NOT NULL,
  `placa` varchar(10) DEFAULT NULL,
  `dni` char(8) DEFAULT NULL,
  `ruc` char(11) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `razon_social` varchar(100) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
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
  `id_ubigeo` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_ubigeo` varchar(12) DEFAULT NULL,
  `departamento` varchar(50) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  `distrito` varchar(50) NOT NULL,
  PRIMARY KEY (`id_ubigeo`)
) ENGINE=InnoDB AUTO_INCREMENT=1839 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO ubigeo VALUES (1, '﻿010101', 'Amazonas', 'Chachapoyas', 'Chachapoyas');
INSERT INTO ubigeo VALUES (2, '010102', 'Amazonas', 'Chachapoyas', 'Asuncion');
INSERT INTO ubigeo VALUES (3, '010103', 'Amazonas', 'Chachapoyas', 'Balsas');
INSERT INTO ubigeo VALUES (4, '010104', 'Amazonas', 'Chachapoyas', 'Cheto');
INSERT INTO ubigeo VALUES (5, '010105', 'Amazonas', 'Chachapoyas', 'Chiliquin');
INSERT INTO ubigeo VALUES (6, '010106', 'Amazonas', 'Chachapoyas', 'Chuquibamba');
INSERT INTO ubigeo VALUES (7, '010107', 'Amazonas', 'Chachapoyas', 'Granada');
INSERT INTO ubigeo VALUES (8, '010108', 'Amazonas', 'Chachapoyas', 'Huancas');
INSERT INTO ubigeo VALUES (9, '010109', 'Amazonas', 'Chachapoyas', 'La Jalca');
INSERT INTO ubigeo VALUES (10, '010110', 'Amazonas', 'Chachapoyas', 'Leimebamba');
INSERT INTO ubigeo VALUES (11, '010111', 'Amazonas', 'Chachapoyas', 'Levanto');
INSERT INTO ubigeo VALUES (12, '010112', 'Amazonas', 'Chachapoyas', 'Magdalena');
INSERT INTO ubigeo VALUES (13, '010113', 'Amazonas', 'Chachapoyas', 'Mariscal Castilla');
INSERT INTO ubigeo VALUES (14, '010114', 'Amazonas', 'Chachapoyas', 'Molinopampa');
INSERT INTO ubigeo VALUES (15, '010115', 'Amazonas', 'Chachapoyas', 'Montevideo');
INSERT INTO ubigeo VALUES (16, '010116', 'Amazonas', 'Chachapoyas', 'Olleros');
INSERT INTO ubigeo VALUES (17, '010117', 'Amazonas', 'Chachapoyas', 'Quinjalca');
INSERT INTO ubigeo VALUES (18, '010118', 'Amazonas', 'Chachapoyas', 'San Francisco de Daguas');
INSERT INTO ubigeo VALUES (19, '010119', 'Amazonas', 'Chachapoyas', 'San Isidro de Maino');
INSERT INTO ubigeo VALUES (20, '010120', 'Amazonas', 'Chachapoyas', 'Soloco');
INSERT INTO ubigeo VALUES (21, '010121', 'Amazonas', 'Chachapoyas', 'Sonche');
INSERT INTO ubigeo VALUES (22, '010201', 'Amazonas', 'Bagua', 'La Peca');
INSERT INTO ubigeo VALUES (23, '010202', 'Amazonas', 'Bagua', 'Aramango');
INSERT INTO ubigeo VALUES (24, '010203', 'Amazonas', 'Bagua', 'Copallin');
INSERT INTO ubigeo VALUES (25, '010204', 'Amazonas', 'Bagua', 'El Parco');
INSERT INTO ubigeo VALUES (26, '010205', 'Amazonas', 'Bagua', 'Bagua');
INSERT INTO ubigeo VALUES (27, '010206', 'Amazonas', 'Bagua', 'Imaza');
INSERT INTO ubigeo VALUES (28, '010301', 'Amazonas', 'Bongara', 'Jumbilla');
INSERT INTO ubigeo VALUES (29, '010302', 'Amazonas', 'Bongara', 'Corosha');
INSERT INTO ubigeo VALUES (30, '010303', 'Amazonas', 'Bongara', 'Cuispes');
INSERT INTO ubigeo VALUES (31, '010304', 'Amazonas', 'Bongara', 'Chisquilla');
INSERT INTO ubigeo VALUES (32, '010305', 'Amazonas', 'Bongara', 'Churuja');
INSERT INTO ubigeo VALUES (33, '010306', 'Amazonas', 'Bongara', 'Florida');
INSERT INTO ubigeo VALUES (34, '010307', 'Amazonas', 'Bongara', 'Recta');
INSERT INTO ubigeo VALUES (35, '010308', 'Amazonas', 'Bongara', 'San Carlos');
INSERT INTO ubigeo VALUES (36, '010309', 'Amazonas', 'Bongara', 'Shipasbamba');
INSERT INTO ubigeo VALUES (37, '010310', 'Amazonas', 'Bongara', 'Valera');
INSERT INTO ubigeo VALUES (38, '010311', 'Amazonas', 'Bongara', 'Yambrasbamba');
INSERT INTO ubigeo VALUES (39, '010312', 'Amazonas', 'Bongara', 'Jazan');
INSERT INTO ubigeo VALUES (40, '010401', 'Amazonas', 'Luya', 'Lamud');
INSERT INTO ubigeo VALUES (41, '010402', 'Amazonas', 'Luya', 'Camporredondo');
INSERT INTO ubigeo VALUES (42, '010403', 'Amazonas', 'Luya', 'Cocabamba');
INSERT INTO ubigeo VALUES (43, '010404', 'Amazonas', 'Luya', 'Colcamar');
INSERT INTO ubigeo VALUES (44, '010405', 'Amazonas', 'Luya', 'Conila');
INSERT INTO ubigeo VALUES (45, '010406', 'Amazonas', 'Luya', 'Inguilpata');
INSERT INTO ubigeo VALUES (46, '010407', 'Amazonas', 'Luya', 'Longuita');
INSERT INTO ubigeo VALUES (47, '010408', 'Amazonas', 'Luya', 'Lonya Chico');
INSERT INTO ubigeo VALUES (48, '010409', 'Amazonas', 'Luya', 'Luya');
INSERT INTO ubigeo VALUES (49, '010410', 'Amazonas', 'Luya', 'Luya Viejo');
INSERT INTO ubigeo VALUES (50, '010411', 'Amazonas', 'Luya', 'Maria');
INSERT INTO ubigeo VALUES (51, '010412', 'Amazonas', 'Luya', 'Ocalli');
INSERT INTO ubigeo VALUES (52, '010413', 'Amazonas', 'Luya', 'Ocumal');
INSERT INTO ubigeo VALUES (53, '010414', 'Amazonas', 'Luya', 'Pisuquia');
INSERT INTO ubigeo VALUES (54, '010415', 'Amazonas', 'Luya', 'San Cristobal');
INSERT INTO ubigeo VALUES (55, '010416', 'Amazonas', 'Luya', 'San Francisco del Yeso');
INSERT INTO ubigeo VALUES (56, '010417', 'Amazonas', 'Luya', 'San Jeronimo');
INSERT INTO ubigeo VALUES (57, '010418', 'Amazonas', 'Luya', 'San Juan de Lopecancha');
INSERT INTO ubigeo VALUES (58, '010419', 'Amazonas', 'Luya', 'Santa Catalina');
INSERT INTO ubigeo VALUES (59, '010420', 'Amazonas', 'Luya', 'Santo Tomas');
INSERT INTO ubigeo VALUES (60, '010421', 'Amazonas', 'Luya', 'Tingo');
INSERT INTO ubigeo VALUES (61, '010422', 'Amazonas', 'Luya', 'Trita');
INSERT INTO ubigeo VALUES (62, '010423', 'Amazonas', 'Luya', 'Providencia');
INSERT INTO ubigeo VALUES (63, '010501', 'Amazonas', 'Rodriguez de Mendoza', 'San Nicolas');
INSERT INTO ubigeo VALUES (64, '010502', 'Amazonas', 'Rodriguez de Mendoza', 'Cochamal');
INSERT INTO ubigeo VALUES (65, '010503', 'Amazonas', 'Rodriguez de Mendoza', 'Chirimoto');
INSERT INTO ubigeo VALUES (66, '010504', 'Amazonas', 'Rodriguez de Mendoza', 'Huambo');
INSERT INTO ubigeo VALUES (67, '010505', 'Amazonas', 'Rodriguez de Mendoza', 'Limabamba');
INSERT INTO ubigeo VALUES (68, '010506', 'Amazonas', 'Rodriguez de Mendoza', 'Longar');
INSERT INTO ubigeo VALUES (69, '010507', 'Amazonas', 'Rodriguez de Mendoza', 'Milpuc');
INSERT INTO ubigeo VALUES (70, '010508', 'Amazonas', 'Rodriguez de Mendoza', 'Mariscal Benavides');
INSERT INTO ubigeo VALUES (71, '010509', 'Amazonas', 'Rodriguez de Mendoza', 'Omia');
INSERT INTO ubigeo VALUES (72, '010510', 'Amazonas', 'Rodriguez de Mendoza', 'Santa Rosa');
INSERT INTO ubigeo VALUES (73, '010511', 'Amazonas', 'Rodriguez de Mendoza', 'Totora');
INSERT INTO ubigeo VALUES (74, '010512', 'Amazonas', 'Rodriguez de Mendoza', 'Vista Alegre');
INSERT INTO ubigeo VALUES (75, '010601', 'Amazonas', 'Condorcanqui', 'Nieva');
INSERT INTO ubigeo VALUES (76, '010602', 'Amazonas', 'Condorcanqui', 'Rio Santiago');
INSERT INTO ubigeo VALUES (77, '010603', 'Amazonas', 'Condorcanqui', 'El Cenepa');
INSERT INTO ubigeo VALUES (78, '010701', 'Amazonas', 'Utcubamba', 'Bagua Grande');
INSERT INTO ubigeo VALUES (79, '010702', 'Amazonas', 'Utcubamba', 'Cajaruro');
INSERT INTO ubigeo VALUES (80, '010703', 'Amazonas', 'Utcubamba', 'Cumba');
INSERT INTO ubigeo VALUES (81, '010704', 'Amazonas', 'Utcubamba', 'El Milagro');
INSERT INTO ubigeo VALUES (82, '010705', 'Amazonas', 'Utcubamba', 'Jamalca');
INSERT INTO ubigeo VALUES (83, '010706', 'Amazonas', 'Utcubamba', 'Lonya Grande');
INSERT INTO ubigeo VALUES (84, '010707', 'Amazonas', 'Utcubamba', 'Yamon');
INSERT INTO ubigeo VALUES (85, '020101', 'Ancash', 'Huaraz', 'Huaraz');
INSERT INTO ubigeo VALUES (86, '020102', 'Ancash', 'Huaraz', 'Independencia');
INSERT INTO ubigeo VALUES (87, '020103', 'Ancash', 'Huaraz', 'Cochabamba');
INSERT INTO ubigeo VALUES (88, '020104', 'Ancash', 'Huaraz', 'Colcabamba');
INSERT INTO ubigeo VALUES (89, '020105', 'Ancash', 'Huaraz', 'Huanchay');
INSERT INTO ubigeo VALUES (90, '020106', 'Ancash', 'Huaraz', 'Jangas');
INSERT INTO ubigeo VALUES (91, '020107', 'Ancash', 'Huaraz', 'La Libertad');
INSERT INTO ubigeo VALUES (92, '020108', 'Ancash', 'Huaraz', 'Olleros');
INSERT INTO ubigeo VALUES (93, '020109', 'Ancash', 'Huaraz', 'Pampas');
INSERT INTO ubigeo VALUES (94, '020110', 'Ancash', 'Huaraz', 'Pariacoto');
INSERT INTO ubigeo VALUES (95, '020111', 'Ancash', 'Huaraz', 'Pira');
INSERT INTO ubigeo VALUES (96, '020112', 'Ancash', 'Huaraz', 'Tarica');
INSERT INTO ubigeo VALUES (97, '020201', 'Ancash', 'Aija', 'Aija');
INSERT INTO ubigeo VALUES (98, '020203', 'Ancash', 'Aija', 'Coris');
INSERT INTO ubigeo VALUES (99, '020205', 'Ancash', 'Aija', 'Huacllan');
INSERT INTO ubigeo VALUES (100, '020206', 'Ancash', 'Aija', 'La Merced');
INSERT INTO ubigeo VALUES (101, '020208', 'Ancash', 'Aija', 'Succha');
INSERT INTO ubigeo VALUES (102, '020301', 'Ancash', 'Bolognesi', 'Chiquian');
INSERT INTO ubigeo VALUES (103, '020302', 'Ancash', 'Bolognesi', 'Abelardo Pardo Lezameta');
INSERT INTO ubigeo VALUES (104, '020304', 'Ancash', 'Bolognesi', 'Aquia');
INSERT INTO ubigeo VALUES (105, '020305', 'Ancash', 'Bolognesi', 'Cajacay');
INSERT INTO ubigeo VALUES (106, '020310', 'Ancash', 'Bolognesi', 'Huayllacayan');
INSERT INTO ubigeo VALUES (107, '020311', 'Ancash', 'Bolognesi', 'Huasta');
INSERT INTO ubigeo VALUES (108, '020313', 'Ancash', 'Bolognesi', 'Mangas');
INSERT INTO ubigeo VALUES (109, '020315', 'Ancash', 'Bolognesi', 'Pacllon');
INSERT INTO ubigeo VALUES (110, '020317', 'Ancash', 'Bolognesi', 'San Miguel de Corpanqui');
INSERT INTO ubigeo VALUES (111, '020320', 'Ancash', 'Bolognesi', 'Ticllos');
INSERT INTO ubigeo VALUES (112, '020321', 'Ancash', 'Bolognesi', 'Antonio Raymondi');
INSERT INTO ubigeo VALUES (113, '020322', 'Ancash', 'Bolognesi', 'Canis');
INSERT INTO ubigeo VALUES (114, '020323', 'Ancash', 'Bolognesi', 'Colquioc');
INSERT INTO ubigeo VALUES (115, '020324', 'Ancash', 'Bolognesi', 'La Primavera');
INSERT INTO ubigeo VALUES (116, '020325', 'Ancash', 'Bolognesi', 'Huallanca');
INSERT INTO ubigeo VALUES (117, '020401', 'Ancash', 'Carhuaz', 'Carhuaz');
INSERT INTO ubigeo VALUES (118, '020402', 'Ancash', 'Carhuaz', 'Acopampa');
INSERT INTO ubigeo VALUES (119, '020403', 'Ancash', 'Carhuaz', 'Amashca');
INSERT INTO ubigeo VALUES (120, '020404', 'Ancash', 'Carhuaz', 'Anta');
INSERT INTO ubigeo VALUES (121, '020405', 'Ancash', 'Carhuaz', 'Ataquero');
INSERT INTO ubigeo VALUES (122, '020406', 'Ancash', 'Carhuaz', 'Marcara');
INSERT INTO ubigeo VALUES (123, '020407', 'Ancash', 'Carhuaz', 'Pariahuanca');
INSERT INTO ubigeo VALUES (124, '020408', 'Ancash', 'Carhuaz', 'San Miguel de Aco');
INSERT INTO ubigeo VALUES (125, '020409', 'Ancash', 'Carhuaz', 'Shilla');
INSERT INTO ubigeo VALUES (126, '020410', 'Ancash', 'Carhuaz', 'Tinco');
INSERT INTO ubigeo VALUES (127, '020411', 'Ancash', 'Carhuaz', 'Yungar');
INSERT INTO ubigeo VALUES (128, '020501', 'Ancash', 'Casma', 'Casma');
INSERT INTO ubigeo VALUES (129, '020502', 'Ancash', 'Casma', 'Buena Vista Alta');
INSERT INTO ubigeo VALUES (130, '020503', 'Ancash', 'Casma', 'Comandante Noel');
INSERT INTO ubigeo VALUES (131, '020505', 'Ancash', 'Casma', 'Yautan');
INSERT INTO ubigeo VALUES (132, '020601', 'Ancash', 'Corongo', 'Corongo');
INSERT INTO ubigeo VALUES (133, '020602', 'Ancash', 'Corongo', 'Aco');
INSERT INTO ubigeo VALUES (134, '020603', 'Ancash', 'Corongo', 'Bambas');
INSERT INTO ubigeo VALUES (135, '020604', 'Ancash', 'Corongo', 'Cusca');
INSERT INTO ubigeo VALUES (136, '020605', 'Ancash', 'Corongo', 'La Pampa');
INSERT INTO ubigeo VALUES (137, '020606', 'Ancash', 'Corongo', 'Yanac');
INSERT INTO ubigeo VALUES (138, '020607', 'Ancash', 'Corongo', 'Yupan');
INSERT INTO ubigeo VALUES (139, '020701', 'Ancash', 'Huaylas', 'Caraz');
INSERT INTO ubigeo VALUES (140, '020702', 'Ancash', 'Huaylas', 'Huallanca');
INSERT INTO ubigeo VALUES (141, '020703', 'Ancash', 'Huaylas', 'Huata');
INSERT INTO ubigeo VALUES (142, '020704', 'Ancash', 'Huaylas', 'Huaylas');
INSERT INTO ubigeo VALUES (143, '020705', 'Ancash', 'Huaylas', 'Mato');
INSERT INTO ubigeo VALUES (144, '020706', 'Ancash', 'Huaylas', 'Pamparomas');
INSERT INTO ubigeo VALUES (145, '020707', 'Ancash', 'Huaylas', 'Pueblo Libre');
INSERT INTO ubigeo VALUES (146, '020708', 'Ancash', 'Huaylas', 'Santa Cruz');
INSERT INTO ubigeo VALUES (147, '020709', 'Ancash', 'Huaylas', 'Yuracmarca');
INSERT INTO ubigeo VALUES (148, '020710', 'Ancash', 'Huaylas', 'Santo Toribio');
INSERT INTO ubigeo VALUES (149, '020801', 'Ancash', 'Huari', 'Huari');
INSERT INTO ubigeo VALUES (150, '020802', 'Ancash', 'Huari', 'Cajay');
INSERT INTO ubigeo VALUES (151, '020803', 'Ancash', 'Huari', 'Chavin de Huantar');
INSERT INTO ubigeo VALUES (152, '020804', 'Ancash', 'Huari', 'Huacachi');
INSERT INTO ubigeo VALUES (153, '020805', 'Ancash', 'Huari', 'Huachis');
INSERT INTO ubigeo VALUES (154, '020806', 'Ancash', 'Huari', 'Huacchis');
INSERT INTO ubigeo VALUES (155, '020807', 'Ancash', 'Huari', 'Huantar');
INSERT INTO ubigeo VALUES (156, '020808', 'Ancash', 'Huari', 'Masin');
INSERT INTO ubigeo VALUES (157, '020809', 'Ancash', 'Huari', 'Paucas');
INSERT INTO ubigeo VALUES (158, '020810', 'Ancash', 'Huari', 'Ponto');
INSERT INTO ubigeo VALUES (159, '020811', 'Ancash', 'Huari', 'Rahuapampa');
INSERT INTO ubigeo VALUES (160, '020812', 'Ancash', 'Huari', 'Rapayan');
INSERT INTO ubigeo VALUES (161, '020813', 'Ancash', 'Huari', 'San Marcos');
INSERT INTO ubigeo VALUES (162, '020814', 'Ancash', 'Huari', 'San Pedro de Chana');
INSERT INTO ubigeo VALUES (163, '020815', 'Ancash', 'Huari', 'Uco');
INSERT INTO ubigeo VALUES (164, '020816', 'Ancash', 'Huari', 'Anra');
INSERT INTO ubigeo VALUES (165, '020901', 'Ancash', 'Mariscal Luzuriaga', 'Piscobamba');
INSERT INTO ubigeo VALUES (166, '020902', 'Ancash', 'Mariscal Luzuriaga', 'Casca');
INSERT INTO ubigeo VALUES (167, '020903', 'Ancash', 'Mariscal Luzuriaga', 'Lucma');
INSERT INTO ubigeo VALUES (168, '020904', 'Ancash', 'Mariscal Luzuriaga', 'Fidel Olivas Escudero');
INSERT INTO ubigeo VALUES (169, '020905', 'Ancash', 'Mariscal Luzuriaga', 'Llama');
INSERT INTO ubigeo VALUES (170, '020906', 'Ancash', 'Mariscal Luzuriaga', 'Llumpa');
INSERT INTO ubigeo VALUES (171, '020907', 'Ancash', 'Mariscal Luzuriaga', 'Musga');
INSERT INTO ubigeo VALUES (172, '020908', 'Ancash', 'Mariscal Luzuriaga', 'Eleazar Guzman Barron');
INSERT INTO ubigeo VALUES (173, '021001', 'Ancash', 'Pallasca', 'Cabana');
INSERT INTO ubigeo VALUES (174, '021002', 'Ancash', 'Pallasca', 'Bolognesi');
INSERT INTO ubigeo VALUES (175, '021003', 'Ancash', 'Pallasca', 'Conchucos');
INSERT INTO ubigeo VALUES (176, '021004', 'Ancash', 'Pallasca', 'Huacaschuque');
INSERT INTO ubigeo VALUES (177, '021005', 'Ancash', 'Pallasca', 'Huandoval');
INSERT INTO ubigeo VALUES (178, '021006', 'Ancash', 'Pallasca', 'Lacabamba');
INSERT INTO ubigeo VALUES (179, '021007', 'Ancash', 'Pallasca', 'Llapo');
INSERT INTO ubigeo VALUES (180, '021008', 'Ancash', 'Pallasca', 'Pallasca');
INSERT INTO ubigeo VALUES (181, '021009', 'Ancash', 'Pallasca', 'Pampas');
INSERT INTO ubigeo VALUES (182, '021010', 'Ancash', 'Pallasca', 'Santa Rosa');
INSERT INTO ubigeo VALUES (183, '021011', 'Ancash', 'Pallasca', 'Tauca');
INSERT INTO ubigeo VALUES (184, '021101', 'Ancash', 'Pomabamba', 'Pomabamba');
INSERT INTO ubigeo VALUES (185, '021102', 'Ancash', 'Pomabamba', 'Huayllan');
INSERT INTO ubigeo VALUES (186, '021103', 'Ancash', 'Pomabamba', 'Parobamba');
INSERT INTO ubigeo VALUES (187, '021104', 'Ancash', 'Pomabamba', 'Quinuabamba');
INSERT INTO ubigeo VALUES (188, '021201', 'Ancash', 'Recuay', 'Recuay');
INSERT INTO ubigeo VALUES (189, '021202', 'Ancash', 'Recuay', 'Cotaparaco');
INSERT INTO ubigeo VALUES (190, '021203', 'Ancash', 'Recuay', 'Huayllapampa');
INSERT INTO ubigeo VALUES (191, '021204', 'Ancash', 'Recuay', 'Marca');
INSERT INTO ubigeo VALUES (192, '021205', 'Ancash', 'Recuay', 'Pampas Chico');
INSERT INTO ubigeo VALUES (193, '021206', 'Ancash', 'Recuay', 'Pararin');
INSERT INTO ubigeo VALUES (194, '021207', 'Ancash', 'Recuay', 'Tapacocha');
INSERT INTO ubigeo VALUES (195, '021208', 'Ancash', 'Recuay', 'Ticapampa');
INSERT INTO ubigeo VALUES (196, '021209', 'Ancash', 'Recuay', 'Llacllin');
INSERT INTO ubigeo VALUES (197, '021210', 'Ancash', 'Recuay', 'Catac');
INSERT INTO ubigeo VALUES (198, '021301', 'Ancash', 'Santa', 'Chimbote');
INSERT INTO ubigeo VALUES (199, '021302', 'Ancash', 'Santa', 'Caceres del Peru');
INSERT INTO ubigeo VALUES (200, '021303', 'Ancash', 'Santa', 'Macate');
INSERT INTO ubigeo VALUES (201, '021304', 'Ancash', 'Santa', 'Moro');
INSERT INTO ubigeo VALUES (202, '021305', 'Ancash', 'Santa', 'Nepeña');
INSERT INTO ubigeo VALUES (203, '021306', 'Ancash', 'Santa', 'Samanco');
INSERT INTO ubigeo VALUES (204, '021307', 'Ancash', 'Santa', 'Santa');
INSERT INTO ubigeo VALUES (205, '021308', 'Ancash', 'Santa', 'Coishco');
INSERT INTO ubigeo VALUES (206, '021309', 'Ancash', 'Santa', 'Nuevo Chimbote');
INSERT INTO ubigeo VALUES (207, '021401', 'Ancash', 'Sihuas', 'Sihuas');
INSERT INTO ubigeo VALUES (208, '021402', 'Ancash', 'Sihuas', 'Alfonso Ugarte');
INSERT INTO ubigeo VALUES (209, '021403', 'Ancash', 'Sihuas', 'Chingalpo');
INSERT INTO ubigeo VALUES (210, '021404', 'Ancash', 'Sihuas', 'Huayllabamba');
INSERT INTO ubigeo VALUES (211, '021405', 'Ancash', 'Sihuas', 'Quiches');
INSERT INTO ubigeo VALUES (212, '021406', 'Ancash', 'Sihuas', 'Sicsibamba');
INSERT INTO ubigeo VALUES (213, '021407', 'Ancash', 'Sihuas', 'Acobamba');
INSERT INTO ubigeo VALUES (214, '021408', 'Ancash', 'Sihuas', 'Cashapampa');
INSERT INTO ubigeo VALUES (215, '021409', 'Ancash', 'Sihuas', 'Ragash');
INSERT INTO ubigeo VALUES (216, '021410', 'Ancash', 'Sihuas', 'San Juan');
INSERT INTO ubigeo VALUES (217, '021501', 'Ancash', 'Yungay', 'Yungay');
INSERT INTO ubigeo VALUES (218, '021502', 'Ancash', 'Yungay', 'Cascapara');
INSERT INTO ubigeo VALUES (219, '021503', 'Ancash', 'Yungay', 'Mancos');
INSERT INTO ubigeo VALUES (220, '021504', 'Ancash', 'Yungay', 'Matacoto');
INSERT INTO ubigeo VALUES (221, '021505', 'Ancash', 'Yungay', 'Quillo');
INSERT INTO ubigeo VALUES (222, '021506', 'Ancash', 'Yungay', 'Ranrahirca');
INSERT INTO ubigeo VALUES (223, '021507', 'Ancash', 'Yungay', 'Shupluy');
INSERT INTO ubigeo VALUES (224, '021508', 'Ancash', 'Yungay', 'Yanama');
INSERT INTO ubigeo VALUES (225, '021601', 'Ancash', 'Antonio Raymondi', 'Llamellin');
INSERT INTO ubigeo VALUES (226, '021602', 'Ancash', 'Antonio Raymondi', 'Aczo');
INSERT INTO ubigeo VALUES (227, '021603', 'Ancash', 'Antonio Raymondi', 'Chaccho');
INSERT INTO ubigeo VALUES (228, '021604', 'Ancash', 'Antonio Raymondi', 'Chingas');
INSERT INTO ubigeo VALUES (229, '021605', 'Ancash', 'Antonio Raymondi', 'Mirgas');
INSERT INTO ubigeo VALUES (230, '021606', 'Ancash', 'Antonio Raymondi', 'San Juan de Rontoy');
INSERT INTO ubigeo VALUES (231, '021701', 'Ancash', 'Carlos Fermin Fitzca', 'San Luis');
INSERT INTO ubigeo VALUES (232, '021702', 'Ancash', 'Carlos Fermin Fitzca', 'Yauya');
INSERT INTO ubigeo VALUES (233, '021703', 'Ancash', 'Carlos Fermin Fitzca', 'San Nicolas');
INSERT INTO ubigeo VALUES (234, '021801', 'Ancash', 'Asuncion', 'Chacas');
INSERT INTO ubigeo VALUES (235, '021802', 'Ancash', 'Asuncion', 'Acochaca');
INSERT INTO ubigeo VALUES (236, '021901', 'Ancash', 'Huarmey', 'Huarmey');
INSERT INTO ubigeo VALUES (237, '021902', 'Ancash', 'Huarmey', 'Cochapeti');
INSERT INTO ubigeo VALUES (238, '021903', 'Ancash', 'Huarmey', 'Huayan');
INSERT INTO ubigeo VALUES (239, '021904', 'Ancash', 'Huarmey', 'Malvas');
INSERT INTO ubigeo VALUES (240, '021905', 'Ancash', 'Huarmey', 'Culebras');
INSERT INTO ubigeo VALUES (241, '022001', 'Ancash', 'Ocros', 'Acas');
INSERT INTO ubigeo VALUES (242, '022002', 'Ancash', 'Ocros', 'Cajamarquilla');
INSERT INTO ubigeo VALUES (243, '022003', 'Ancash', 'Ocros', 'Carhuapampa');
INSERT INTO ubigeo VALUES (244, '022004', 'Ancash', 'Ocros', 'Cochas');
INSERT INTO ubigeo VALUES (245, '022005', 'Ancash', 'Ocros', 'Congas');
INSERT INTO ubigeo VALUES (246, '022006', 'Ancash', 'Ocros', 'Llipa');
INSERT INTO ubigeo VALUES (247, '022007', 'Ancash', 'Ocros', 'Ocros');
INSERT INTO ubigeo VALUES (248, '022008', 'Ancash', 'Ocros', 'San Cristobal de Rajan');
INSERT INTO ubigeo VALUES (249, '022009', 'Ancash', 'Ocros', 'San Pedro');
INSERT INTO ubigeo VALUES (250, '022010', 'Ancash', 'Ocros', 'Santiago de Chilcas');
INSERT INTO ubigeo VALUES (251, '030101', 'Apurimac', 'Abancay', 'Abancay');
INSERT INTO ubigeo VALUES (252, '030102', 'Apurimac', 'Abancay', 'Circa');
INSERT INTO ubigeo VALUES (253, '030103', 'Apurimac', 'Abancay', 'Curahuasi');
INSERT INTO ubigeo VALUES (254, '030104', 'Apurimac', 'Abancay', 'Chacoche');
INSERT INTO ubigeo VALUES (255, '030105', 'Apurimac', 'Abancay', 'Huanipaca');
INSERT INTO ubigeo VALUES (256, '030106', 'Apurimac', 'Abancay', 'Lambrama');
INSERT INTO ubigeo VALUES (257, '030107', 'Apurimac', 'Abancay', 'Pichirhua');
INSERT INTO ubigeo VALUES (258, '030108', 'Apurimac', 'Abancay', 'San Pedro de Cachora');
INSERT INTO ubigeo VALUES (259, '030109', 'Apurimac', 'Abancay', 'Tamburco');
INSERT INTO ubigeo VALUES (260, '030201', 'Apurimac', 'Aymaraes', 'Chalhuanca');
INSERT INTO ubigeo VALUES (261, '030202', 'Apurimac', 'Aymaraes', 'Capaya');
INSERT INTO ubigeo VALUES (262, '030203', 'Apurimac', 'Aymaraes', 'Caraybamba');
INSERT INTO ubigeo VALUES (263, '030204', 'Apurimac', 'Aymaraes', 'Colcabamba');
INSERT INTO ubigeo VALUES (264, '030205', 'Apurimac', 'Aymaraes', 'Cotaruse');
INSERT INTO ubigeo VALUES (265, '030206', 'Apurimac', 'Aymaraes', 'Chapimarca');
INSERT INTO ubigeo VALUES (266, '030207', 'Apurimac', 'Aymaraes', 'Huayllo');
INSERT INTO ubigeo VALUES (267, '030208', 'Apurimac', 'Aymaraes', 'Lucre');
INSERT INTO ubigeo VALUES (268, '030209', 'Apurimac', 'Aymaraes', 'Pocohuanca');
INSERT INTO ubigeo VALUES (269, '030210', 'Apurimac', 'Aymaraes', 'Sañayca');
INSERT INTO ubigeo VALUES (270, '030211', 'Apurimac', 'Aymaraes', 'Soraya');
INSERT INTO ubigeo VALUES (271, '030212', 'Apurimac', 'Aymaraes', 'Tapairihua');
INSERT INTO ubigeo VALUES (272, '030213', 'Apurimac', 'Aymaraes', 'Tintay');
INSERT INTO ubigeo VALUES (273, '030214', 'Apurimac', 'Aymaraes', 'Toraya');
INSERT INTO ubigeo VALUES (274, '030215', 'Apurimac', 'Aymaraes', 'Yanaca');
INSERT INTO ubigeo VALUES (275, '030216', 'Apurimac', 'Aymaraes', 'San Juan de Chacña');
INSERT INTO ubigeo VALUES (276, '030217', 'Apurimac', 'Aymaraes', 'Justo Apu Sahuaraura');
INSERT INTO ubigeo VALUES (277, '030301', 'Apurimac', 'Andahuaylas', 'Andahuaylas');
INSERT INTO ubigeo VALUES (278, '030302', 'Apurimac', 'Andahuaylas', 'Andarapa');
INSERT INTO ubigeo VALUES (279, '030303', 'Apurimac', 'Andahuaylas', 'Chiara');
INSERT INTO ubigeo VALUES (280, '030304', 'Apurimac', 'Andahuaylas', 'Huancarama');
INSERT INTO ubigeo VALUES (281, '030305', 'Apurimac', 'Andahuaylas', 'Huancaray');
INSERT INTO ubigeo VALUES (282, '030306', 'Apurimac', 'Andahuaylas', 'Kishuara');
INSERT INTO ubigeo VALUES (283, '030307', 'Apurimac', 'Andahuaylas', 'Pacobamba');
INSERT INTO ubigeo VALUES (284, '030308', 'Apurimac', 'Andahuaylas', 'Pampachiri');
INSERT INTO ubigeo VALUES (285, '030309', 'Apurimac', 'Andahuaylas', 'San Antonio de Cachi');
INSERT INTO ubigeo VALUES (286, '030310', 'Apurimac', 'Andahuaylas', 'San Jeronimo');
INSERT INTO ubigeo VALUES (287, '030311', 'Apurimac', 'Andahuaylas', 'Talavera');
INSERT INTO ubigeo VALUES (288, '030312', 'Apurimac', 'Andahuaylas', 'Turpo');
INSERT INTO ubigeo VALUES (289, '030313', 'Apurimac', 'Andahuaylas', 'Pacucha');
INSERT INTO ubigeo VALUES (290, '030314', 'Apurimac', 'Andahuaylas', 'Pomacocha');
INSERT INTO ubigeo VALUES (291, '030315', 'Apurimac', 'Andahuaylas', 'Santa Maria de Chicmo');
INSERT INTO ubigeo VALUES (292, '030316', 'Apurimac', 'Andahuaylas', 'Tumay Huaraca');
INSERT INTO ubigeo VALUES (293, '030317', 'Apurimac', 'Andahuaylas', 'Huayana');
INSERT INTO ubigeo VALUES (294, '030318', 'Apurimac', 'Andahuaylas', 'San Miguel de Chaccrampa');
INSERT INTO ubigeo VALUES (295, '030319', 'Apurimac', 'Andahuaylas', 'Kaquiabamba');
INSERT INTO ubigeo VALUES (296, '030401', 'Apurimac', 'Antabamba', 'Antabamba');
INSERT INTO ubigeo VALUES (297, '030402', 'Apurimac', 'Antabamba', 'El Oro');
INSERT INTO ubigeo VALUES (298, '030403', 'Apurimac', 'Antabamba', 'Huaquirca');
INSERT INTO ubigeo VALUES (299, '030404', 'Apurimac', 'Antabamba', 'Juan Espinoza Medrano');
INSERT INTO ubigeo VALUES (300, '030405', 'Apurimac', 'Antabamba', 'Oropesa');
INSERT INTO ubigeo VALUES (301, '030406', 'Apurimac', 'Antabamba', 'Pachaconas');
INSERT INTO ubigeo VALUES (302, '030407', 'Apurimac', 'Antabamba', 'Sabaino');
INSERT INTO ubigeo VALUES (303, '030501', 'Apurimac', 'Cotabambas', 'Tambobamba');
INSERT INTO ubigeo VALUES (304, '030502', 'Apurimac', 'Cotabambas', 'Coyllurqui');
INSERT INTO ubigeo VALUES (305, '030503', 'Apurimac', 'Cotabambas', 'Cotabambas');
INSERT INTO ubigeo VALUES (306, '030504', 'Apurimac', 'Cotabambas', 'Haquira');
INSERT INTO ubigeo VALUES (307, '030505', 'Apurimac', 'Cotabambas', 'Mara');
INSERT INTO ubigeo VALUES (308, '030506', 'Apurimac', 'Cotabambas', 'Challhuahuacho');
INSERT INTO ubigeo VALUES (309, '030601', 'Apurimac', 'Grau', 'Chuquibambilla');
INSERT INTO ubigeo VALUES (310, '030602', 'Apurimac', 'Grau', 'Curpahuasi');
INSERT INTO ubigeo VALUES (311, '030603', 'Apurimac', 'Grau', 'Huayllati');
INSERT INTO ubigeo VALUES (312, '030604', 'Apurimac', 'Grau', 'Mamara');
INSERT INTO ubigeo VALUES (313, '030605', 'Apurimac', 'Grau', 'Gamarra');
INSERT INTO ubigeo VALUES (314, '030606', 'Apurimac', 'Grau', 'Micaela Bastidas');
INSERT INTO ubigeo VALUES (315, '030607', 'Apurimac', 'Grau', 'Progreso');
INSERT INTO ubigeo VALUES (316, '030608', 'Apurimac', 'Grau', 'Pataypampa');
INSERT INTO ubigeo VALUES (317, '030609', 'Apurimac', 'Grau', 'San Antonio');
INSERT INTO ubigeo VALUES (318, '030610', 'Apurimac', 'Grau', 'Turpay');
INSERT INTO ubigeo VALUES (319, '030611', 'Apurimac', 'Grau', 'Vilcabamba');
INSERT INTO ubigeo VALUES (320, '030612', 'Apurimac', 'Grau', 'Virundo');
INSERT INTO ubigeo VALUES (321, '030613', 'Apurimac', 'Grau', 'Santa Rosa');
INSERT INTO ubigeo VALUES (322, '030614', 'Apurimac', 'Grau', 'Curasco');
INSERT INTO ubigeo VALUES (323, '030701', 'Apurimac', 'Chincheros', 'Chincheros');
INSERT INTO ubigeo VALUES (324, '030702', 'Apurimac', 'Chincheros', 'Ongoy');
INSERT INTO ubigeo VALUES (325, '030703', 'Apurimac', 'Chincheros', 'Ocobamba');
INSERT INTO ubigeo VALUES (326, '030704', 'Apurimac', 'Chincheros', 'Cocharcas');
INSERT INTO ubigeo VALUES (327, '030705', 'Apurimac', 'Chincheros', 'Anco_Huallo');
INSERT INTO ubigeo VALUES (328, '030706', 'Apurimac', 'Chincheros', 'Huaccana');
INSERT INTO ubigeo VALUES (329, '030707', 'Apurimac', 'Chincheros', 'Uranmarca');
INSERT INTO ubigeo VALUES (330, '030708', 'Apurimac', 'Chincheros', 'Ranracancha');
INSERT INTO ubigeo VALUES (331, '040101', 'Arequipa', 'Arequipa', 'Arequipa');
INSERT INTO ubigeo VALUES (332, '040102', 'Arequipa', 'Arequipa', 'Cayma');
INSERT INTO ubigeo VALUES (333, '040103', 'Arequipa', 'Arequipa', 'Cerro Colorado');
INSERT INTO ubigeo VALUES (334, '040104', 'Arequipa', 'Arequipa', 'Characato');
INSERT INTO ubigeo VALUES (335, '040105', 'Arequipa', 'Arequipa', 'Chiguata');
INSERT INTO ubigeo VALUES (336, '040106', 'Arequipa', 'Arequipa', 'La Joya');
INSERT INTO ubigeo VALUES (337, '040107', 'Arequipa', 'Arequipa', 'Miraflores');
INSERT INTO ubigeo VALUES (338, '040108', 'Arequipa', 'Arequipa', 'Mollebaya');
INSERT INTO ubigeo VALUES (339, '040109', 'Arequipa', 'Arequipa', 'Paucarpata');
INSERT INTO ubigeo VALUES (340, '040110', 'Arequipa', 'Arequipa', 'Pocsi');
INSERT INTO ubigeo VALUES (341, '040111', 'Arequipa', 'Arequipa', 'Polobaya');
INSERT INTO ubigeo VALUES (342, '040112', 'Arequipa', 'Arequipa', 'Quequeña');
INSERT INTO ubigeo VALUES (343, '040113', 'Arequipa', 'Arequipa', 'Sabandia');
INSERT INTO ubigeo VALUES (344, '040114', 'Arequipa', 'Arequipa', 'Sachaca');
INSERT INTO ubigeo VALUES (345, '040115', 'Arequipa', 'Arequipa', 'San Juan de Siguas');
INSERT INTO ubigeo VALUES (346, '040116', 'Arequipa', 'Arequipa', 'San Juan de Tarucani');
INSERT INTO ubigeo VALUES (347, '040117', 'Arequipa', 'Arequipa', 'Santa Isabel de Siguas');
INSERT INTO ubigeo VALUES (348, '040118', 'Arequipa', 'Arequipa', 'Santa Rita de Siguas');
INSERT INTO ubigeo VALUES (349, '040119', 'Arequipa', 'Arequipa', 'Socabaya');
INSERT INTO ubigeo VALUES (350, '040120', 'Arequipa', 'Arequipa', 'Tiabaya');
INSERT INTO ubigeo VALUES (351, '040121', 'Arequipa', 'Arequipa', 'Uchumayo');
INSERT INTO ubigeo VALUES (352, '040122', 'Arequipa', 'Arequipa', 'Vitor');
INSERT INTO ubigeo VALUES (353, '040123', 'Arequipa', 'Arequipa', 'Yanahuara');
INSERT INTO ubigeo VALUES (354, '040124', 'Arequipa', 'Arequipa', 'Yarabamba');
INSERT INTO ubigeo VALUES (355, '040125', 'Arequipa', 'Arequipa', 'Yura');
INSERT INTO ubigeo VALUES (356, '040126', 'Arequipa', 'Arequipa', 'Mariano Melgar');
INSERT INTO ubigeo VALUES (357, '040127', 'Arequipa', 'Arequipa', 'Jacobo Hunter');
INSERT INTO ubigeo VALUES (358, '040128', 'Arequipa', 'Arequipa', 'Alto Selva Alegre');
INSERT INTO ubigeo VALUES (359, '040129', 'Arequipa', 'Arequipa', 'Jose Luis Bustamante y Rivero');
INSERT INTO ubigeo VALUES (360, '040201', 'Arequipa', 'Caylloma', 'Chivay');
INSERT INTO ubigeo VALUES (361, '040202', 'Arequipa', 'Caylloma', 'Achoma');
INSERT INTO ubigeo VALUES (362, '040203', 'Arequipa', 'Caylloma', 'Cabanaconde');
INSERT INTO ubigeo VALUES (363, '040204', 'Arequipa', 'Caylloma', 'Caylloma');
INSERT INTO ubigeo VALUES (364, '040205', 'Arequipa', 'Caylloma', 'Callalli');
INSERT INTO ubigeo VALUES (365, '040206', 'Arequipa', 'Caylloma', 'Coporaque');
INSERT INTO ubigeo VALUES (366, '040207', 'Arequipa', 'Caylloma', 'Huambo');
INSERT INTO ubigeo VALUES (367, '040208', 'Arequipa', 'Caylloma', 'Huanca');
INSERT INTO ubigeo VALUES (368, '040209', 'Arequipa', 'Caylloma', 'Ichupampa');
INSERT INTO ubigeo VALUES (369, '040210', 'Arequipa', 'Caylloma', 'Lari');
INSERT INTO ubigeo VALUES (370, '040211', 'Arequipa', 'Caylloma', 'Lluta');
INSERT INTO ubigeo VALUES (371, '040212', 'Arequipa', 'Caylloma', 'Maca');
INSERT INTO ubigeo VALUES (372, '040213', 'Arequipa', 'Caylloma', 'Madrigal');
INSERT INTO ubigeo VALUES (373, '040214', 'Arequipa', 'Caylloma', 'San Antonio de Chuca');
INSERT INTO ubigeo VALUES (374, '040215', 'Arequipa', 'Caylloma', 'Sibayo');
INSERT INTO ubigeo VALUES (375, '040216', 'Arequipa', 'Caylloma', 'Tapay');
INSERT INTO ubigeo VALUES (376, '040217', 'Arequipa', 'Caylloma', 'Tisco');
INSERT INTO ubigeo VALUES (377, '040218', 'Arequipa', 'Caylloma', 'Tuti');
INSERT INTO ubigeo VALUES (378, '040219', 'Arequipa', 'Caylloma', 'Yanque');
INSERT INTO ubigeo VALUES (379, '040220', 'Arequipa', 'Caylloma', 'Majes');
INSERT INTO ubigeo VALUES (380, '040301', 'Arequipa', 'Camana', 'Camana');
INSERT INTO ubigeo VALUES (381, '040302', 'Arequipa', 'Camana', 'Jose Maria Quimper');
INSERT INTO ubigeo VALUES (382, '040303', 'Arequipa', 'Camana', 'Mariano Nicolas Valcarcel');
INSERT INTO ubigeo VALUES (383, '040304', 'Arequipa', 'Camana', 'Mariscal Caceres');
INSERT INTO ubigeo VALUES (384, '040305', 'Arequipa', 'Camana', 'Nicolas de Pierola');
INSERT INTO ubigeo VALUES (385, '040306', 'Arequipa', 'Camana', 'Ocoña');
INSERT INTO ubigeo VALUES (386, '040307', 'Arequipa', 'Camana', 'Quilca');
INSERT INTO ubigeo VALUES (387, '040308', 'Arequipa', 'Camana', 'Samuel Pastor');
INSERT INTO ubigeo VALUES (388, '040401', 'Arequipa', 'Caraveli', 'Caraveli');
INSERT INTO ubigeo VALUES (389, '040402', 'Arequipa', 'Caraveli', 'Acari');
INSERT INTO ubigeo VALUES (390, '040403', 'Arequipa', 'Caraveli', 'Atico');
INSERT INTO ubigeo VALUES (391, '040404', 'Arequipa', 'Caraveli', 'Atiquipa');
INSERT INTO ubigeo VALUES (392, '040405', 'Arequipa', 'Caraveli', 'Bella Union');
INSERT INTO ubigeo VALUES (393, '040406', 'Arequipa', 'Caraveli', 'Cahuacho');
INSERT INTO ubigeo VALUES (394, '040407', 'Arequipa', 'Caraveli', 'Chala');
INSERT INTO ubigeo VALUES (395, '040408', 'Arequipa', 'Caraveli', 'Chaparra');
INSERT INTO ubigeo VALUES (396, '040409', 'Arequipa', 'Caraveli', 'Huanuhuanu');
INSERT INTO ubigeo VALUES (397, '040410', 'Arequipa', 'Caraveli', 'Jaqui');
INSERT INTO ubigeo VALUES (398, '040411', 'Arequipa', 'Caraveli', 'Lomas');
INSERT INTO ubigeo VALUES (399, '040412', 'Arequipa', 'Caraveli', 'Quicacha');
INSERT INTO ubigeo VALUES (400, '040413', 'Arequipa', 'Caraveli', 'Yauca');
INSERT INTO ubigeo VALUES (401, '040501', 'Arequipa', 'Castilla', 'Aplao');
INSERT INTO ubigeo VALUES (402, '040502', 'Arequipa', 'Castilla', 'Andagua');
INSERT INTO ubigeo VALUES (403, '040503', 'Arequipa', 'Castilla', 'Ayo');
INSERT INTO ubigeo VALUES (404, '040504', 'Arequipa', 'Castilla', 'Chachas');
INSERT INTO ubigeo VALUES (405, '040505', 'Arequipa', 'Castilla', 'Chilcaymarca');
INSERT INTO ubigeo VALUES (406, '040506', 'Arequipa', 'Castilla', 'Choco');
INSERT INTO ubigeo VALUES (407, '040507', 'Arequipa', 'Castilla', 'Huancarqui');
INSERT INTO ubigeo VALUES (408, '040508', 'Arequipa', 'Castilla', 'Machaguay');
INSERT INTO ubigeo VALUES (409, '040509', 'Arequipa', 'Castilla', 'Orcopampa');
INSERT INTO ubigeo VALUES (410, '040510', 'Arequipa', 'Castilla', 'Pampacolca');
INSERT INTO ubigeo VALUES (411, '040511', 'Arequipa', 'Castilla', 'Tipan');
INSERT INTO ubigeo VALUES (412, '040512', 'Arequipa', 'Castilla', 'Uraca');
INSERT INTO ubigeo VALUES (413, '040513', 'Arequipa', 'Castilla', 'Uñon');
INSERT INTO ubigeo VALUES (414, '040514', 'Arequipa', 'Castilla', 'Viraco');
INSERT INTO ubigeo VALUES (415, '040601', 'Arequipa', 'Condesuyos', 'Chuquibamba');
INSERT INTO ubigeo VALUES (416, '040602', 'Arequipa', 'Condesuyos', 'Andaray');
INSERT INTO ubigeo VALUES (417, '040603', 'Arequipa', 'Condesuyos', 'Cayarani');
INSERT INTO ubigeo VALUES (418, '040604', 'Arequipa', 'Condesuyos', 'Chichas');
INSERT INTO ubigeo VALUES (419, '040605', 'Arequipa', 'Condesuyos', 'Iray');
INSERT INTO ubigeo VALUES (420, '040606', 'Arequipa', 'Condesuyos', 'Salamanca');
INSERT INTO ubigeo VALUES (421, '040607', 'Arequipa', 'Condesuyos', 'Yanaquihua');
INSERT INTO ubigeo VALUES (422, '040608', 'Arequipa', 'Condesuyos', 'Rio Grande');
INSERT INTO ubigeo VALUES (423, '040701', 'Arequipa', 'Islay', 'Mollendo');
INSERT INTO ubigeo VALUES (424, '040702', 'Arequipa', 'Islay', 'Cocachacra');
INSERT INTO ubigeo VALUES (425, '040703', 'Arequipa', 'Islay', 'Dean Valdivia');
INSERT INTO ubigeo VALUES (426, '040704', 'Arequipa', 'Islay', 'Islay');
INSERT INTO ubigeo VALUES (427, '040705', 'Arequipa', 'Islay', 'Mejia');
INSERT INTO ubigeo VALUES (428, '040706', 'Arequipa', 'Islay', 'Punta de Bombon');
INSERT INTO ubigeo VALUES (429, '040801', 'Arequipa', 'La Union', 'Cotahuasi');
INSERT INTO ubigeo VALUES (430, '040802', 'Arequipa', 'La Union', 'Alca');
INSERT INTO ubigeo VALUES (431, '040803', 'Arequipa', 'La Union', 'Charcana');
INSERT INTO ubigeo VALUES (432, '040804', 'Arequipa', 'La Union', 'Huaynacotas');
INSERT INTO ubigeo VALUES (433, '040805', 'Arequipa', 'La Union', 'Pampamarca');
INSERT INTO ubigeo VALUES (434, '040806', 'Arequipa', 'La Union', 'Puyca');
INSERT INTO ubigeo VALUES (435, '040807', 'Arequipa', 'La Union', 'Quechualla');
INSERT INTO ubigeo VALUES (436, '040808', 'Arequipa', 'La Union', 'Sayla');
INSERT INTO ubigeo VALUES (437, '040809', 'Arequipa', 'La Union', 'Tauria');
INSERT INTO ubigeo VALUES (438, '040810', 'Arequipa', 'La Union', 'Tomepampa');
INSERT INTO ubigeo VALUES (439, '040811', 'Arequipa', 'La Union', 'Toro');
INSERT INTO ubigeo VALUES (440, '050101', 'Ayacucho', 'Huamanga', 'Ayacucho');
INSERT INTO ubigeo VALUES (441, '050102', 'Ayacucho', 'Huamanga', 'Acos Vinchos');
INSERT INTO ubigeo VALUES (442, '050103', 'Ayacucho', 'Huamanga', 'Carmen Alto');
INSERT INTO ubigeo VALUES (443, '050104', 'Ayacucho', 'Huamanga', 'Chiara');
INSERT INTO ubigeo VALUES (444, '050105', 'Ayacucho', 'Huamanga', 'Quinua');
INSERT INTO ubigeo VALUES (445, '050106', 'Ayacucho', 'Huamanga', 'San Jose de Ticllas');
INSERT INTO ubigeo VALUES (446, '050107', 'Ayacucho', 'Huamanga', 'San Juan Bautista');
INSERT INTO ubigeo VALUES (447, '050108', 'Ayacucho', 'Huamanga', 'Santiago de Pischa');
INSERT INTO ubigeo VALUES (448, '050109', 'Ayacucho', 'Huamanga', 'Vinchos');
INSERT INTO ubigeo VALUES (449, '050110', 'Ayacucho', 'Huamanga', 'Tambillo');
INSERT INTO ubigeo VALUES (450, '050111', 'Ayacucho', 'Huamanga', 'Acocro');
INSERT INTO ubigeo VALUES (451, '050112', 'Ayacucho', 'Huamanga', 'Socos');
INSERT INTO ubigeo VALUES (452, '050113', 'Ayacucho', 'Huamanga', 'Ocros');
INSERT INTO ubigeo VALUES (453, '050114', 'Ayacucho', 'Huamanga', 'Pacaycasa');
INSERT INTO ubigeo VALUES (454, '050115', 'Ayacucho', 'Huamanga', 'Jesus Nazareno');
INSERT INTO ubigeo VALUES (455, '050201', 'Ayacucho', 'Cangallo', 'Cangallo');
INSERT INTO ubigeo VALUES (456, '050204', 'Ayacucho', 'Cangallo', 'Chuschi');
INSERT INTO ubigeo VALUES (457, '050206', 'Ayacucho', 'Cangallo', 'Los Morochucos');
INSERT INTO ubigeo VALUES (458, '050207', 'Ayacucho', 'Cangallo', 'Paras');
INSERT INTO ubigeo VALUES (459, '050208', 'Ayacucho', 'Cangallo', 'Totos');
INSERT INTO ubigeo VALUES (460, '050211', 'Ayacucho', 'Cangallo', 'Maria Parado de Bellido');
INSERT INTO ubigeo VALUES (461, '050301', 'Ayacucho', 'Huanta', 'Huanta');
INSERT INTO ubigeo VALUES (462, '050302', 'Ayacucho', 'Huanta', 'Ayahuanco');
INSERT INTO ubigeo VALUES (463, '050303', 'Ayacucho', 'Huanta', 'Huamanguilla');
INSERT INTO ubigeo VALUES (464, '050304', 'Ayacucho', 'Huanta', 'Iguain');
INSERT INTO ubigeo VALUES (465, '050305', 'Ayacucho', 'Huanta', 'Luricocha');
INSERT INTO ubigeo VALUES (466, '050307', 'Ayacucho', 'Huanta', 'Santillana');
INSERT INTO ubigeo VALUES (467, '050308', 'Ayacucho', 'Huanta', 'Sivia');
INSERT INTO ubigeo VALUES (468, '050309', 'Ayacucho', 'Huanta', 'Llochegua');
INSERT INTO ubigeo VALUES (469, '050401', 'Ayacucho', 'La Mar', 'San Miguel');
INSERT INTO ubigeo VALUES (470, '050402', 'Ayacucho', 'La Mar', 'Anco');
INSERT INTO ubigeo VALUES (471, '050403', 'Ayacucho', 'La Mar', 'Ayna');
INSERT INTO ubigeo VALUES (472, '050404', 'Ayacucho', 'La Mar', 'Chilcas');
INSERT INTO ubigeo VALUES (473, '050405', 'Ayacucho', 'La Mar', 'Chungui');
INSERT INTO ubigeo VALUES (474, '050406', 'Ayacucho', 'La Mar', 'Tambo');
INSERT INTO ubigeo VALUES (475, '050407', 'Ayacucho', 'La Mar', 'Luis Carranza');
INSERT INTO ubigeo VALUES (476, '050408', 'Ayacucho', 'La Mar', 'Santa Rosa');
INSERT INTO ubigeo VALUES (477, '050409', 'Ayacucho', 'La Mar', 'Samugari');
INSERT INTO ubigeo VALUES (478, '050501', 'Ayacucho', 'Lucanas', 'Puquio');
INSERT INTO ubigeo VALUES (479, '050502', 'Ayacucho', 'Lucanas', 'Aucara');
INSERT INTO ubigeo VALUES (480, '050503', 'Ayacucho', 'Lucanas', 'Cabana');
INSERT INTO ubigeo VALUES (481, '050504', 'Ayacucho', 'Lucanas', 'Carmen Salcedo');
INSERT INTO ubigeo VALUES (482, '050506', 'Ayacucho', 'Lucanas', 'Chaviña');
INSERT INTO ubigeo VALUES (483, '050508', 'Ayacucho', 'Lucanas', 'Chipao');
INSERT INTO ubigeo VALUES (484, '050510', 'Ayacucho', 'Lucanas', 'Huac-Huas');
INSERT INTO ubigeo VALUES (485, '050511', 'Ayacucho', 'Lucanas', 'Laramate');
INSERT INTO ubigeo VALUES (486, '050512', 'Ayacucho', 'Lucanas', 'Leoncio Prado');
INSERT INTO ubigeo VALUES (487, '050513', 'Ayacucho', 'Lucanas', 'Lucanas');
INSERT INTO ubigeo VALUES (488, '050514', 'Ayacucho', 'Lucanas', 'Llauta');
INSERT INTO ubigeo VALUES (489, '050516', 'Ayacucho', 'Lucanas', 'Ocaña');
INSERT INTO ubigeo VALUES (490, '050517', 'Ayacucho', 'Lucanas', 'Otoca');
INSERT INTO ubigeo VALUES (491, '050520', 'Ayacucho', 'Lucanas', 'Sancos');
INSERT INTO ubigeo VALUES (492, '050521', 'Ayacucho', 'Lucanas', 'San Juan');
INSERT INTO ubigeo VALUES (493, '050522', 'Ayacucho', 'Lucanas', 'San Pedro');
INSERT INTO ubigeo VALUES (494, '050524', 'Ayacucho', 'Lucanas', 'Santa Ana de Huaycahuacho');
INSERT INTO ubigeo VALUES (495, '050525', 'Ayacucho', 'Lucanas', 'Santa Lucia');
INSERT INTO ubigeo VALUES (496, '050529', 'Ayacucho', 'Lucanas', 'Saisa');
INSERT INTO ubigeo VALUES (497, '050531', 'Ayacucho', 'Lucanas', 'San Pedro de Palco');
INSERT INTO ubigeo VALUES (498, '050532', 'Ayacucho', 'Lucanas', 'San Cristobal');
INSERT INTO ubigeo VALUES (499, '050601', 'Ayacucho', 'Parinacochas', 'Coracora');
INSERT INTO ubigeo VALUES (500, '050604', 'Ayacucho', 'Parinacochas', 'Coronel Castañeda');
INSERT INTO ubigeo VALUES (501, '050605', 'Ayacucho', 'Parinacochas', 'Chumpi');
INSERT INTO ubigeo VALUES (502, '050608', 'Ayacucho', 'Parinacochas', 'Pacapausa');
INSERT INTO ubigeo VALUES (503, '050611', 'Ayacucho', 'Parinacochas', 'Pullo');
INSERT INTO ubigeo VALUES (504, '050612', 'Ayacucho', 'Parinacochas', 'Puyusca');
INSERT INTO ubigeo VALUES (505, '050615', 'Ayacucho', 'Parinacochas', 'San Francisco de Ravacayco');
INSERT INTO ubigeo VALUES (506, '050616', 'Ayacucho', 'Parinacochas', 'Upahuacho');
INSERT INTO ubigeo VALUES (507, '050701', 'Ayacucho', 'Victor Fajardo', 'Huancapi');
INSERT INTO ubigeo VALUES (508, '050702', 'Ayacucho', 'Victor Fajardo', 'Alcamenca');
INSERT INTO ubigeo VALUES (509, '050703', 'Ayacucho', 'Victor Fajardo', 'Apongo');
INSERT INTO ubigeo VALUES (510, '050704', 'Ayacucho', 'Victor Fajardo', 'Canaria');
INSERT INTO ubigeo VALUES (511, '050706', 'Ayacucho', 'Victor Fajardo', 'Cayara');
INSERT INTO ubigeo VALUES (512, '050707', 'Ayacucho', 'Victor Fajardo', 'Colca');
INSERT INTO ubigeo VALUES (513, '050708', 'Ayacucho', 'Victor Fajardo', 'Huaya');
INSERT INTO ubigeo VALUES (514, '050709', 'Ayacucho', 'Victor Fajardo', 'Huamanquiquia');
INSERT INTO ubigeo VALUES (515, '050710', 'Ayacucho', 'Victor Fajardo', 'Huancaraylla');
INSERT INTO ubigeo VALUES (516, '050713', 'Ayacucho', 'Victor Fajardo', 'Sarhua');
INSERT INTO ubigeo VALUES (517, '050714', 'Ayacucho', 'Victor Fajardo', 'Vilcanchos');
INSERT INTO ubigeo VALUES (518, '050715', 'Ayacucho', 'Victor Fajardo', 'Asquipata');
INSERT INTO ubigeo VALUES (519, '050801', 'Ayacucho', 'Huanca Sancos', 'Sancos');
INSERT INTO ubigeo VALUES (520, '050802', 'Ayacucho', 'Huanca Sancos', 'Sacsamarca');
INSERT INTO ubigeo VALUES (521, '050803', 'Ayacucho', 'Huanca Sancos', 'Santiago de Lucanamarca');
INSERT INTO ubigeo VALUES (522, '050804', 'Ayacucho', 'Huanca Sancos', 'Carapo');
INSERT INTO ubigeo VALUES (523, '050901', 'Ayacucho', 'Vilcas Huaman', 'Vilcas Huaman');
INSERT INTO ubigeo VALUES (524, '050902', 'Ayacucho', 'Vilcas Huaman', 'Vischongo');
INSERT INTO ubigeo VALUES (525, '050903', 'Ayacucho', 'Vilcas Huaman', 'Accomarca');
INSERT INTO ubigeo VALUES (526, '050904', 'Ayacucho', 'Vilcas Huaman', 'Carhuanca');
INSERT INTO ubigeo VALUES (527, '050905', 'Ayacucho', 'Vilcas Huaman', 'Concepcion');
INSERT INTO ubigeo VALUES (528, '050906', 'Ayacucho', 'Vilcas Huaman', 'Huambalpa');
INSERT INTO ubigeo VALUES (529, '050907', 'Ayacucho', 'Vilcas Huaman', 'Saurama');
INSERT INTO ubigeo VALUES (530, '050908', 'Ayacucho', 'Vilcas Huaman', 'Independencia');
INSERT INTO ubigeo VALUES (531, '051001', 'Ayacucho', 'Paucar del Sara Sara', 'Pausa');
INSERT INTO ubigeo VALUES (532, '051002', 'Ayacucho', 'Paucar del Sara Sara', 'Colta');
INSERT INTO ubigeo VALUES (533, '051003', 'Ayacucho', 'Paucar del Sara Sara', 'Corculla');
INSERT INTO ubigeo VALUES (534, '051004', 'Ayacucho', 'Paucar del Sara Sara', 'Lampa');
INSERT INTO ubigeo VALUES (535, '051005', 'Ayacucho', 'Paucar del Sara Sara', 'Marcabamba');
INSERT INTO ubigeo VALUES (536, '051006', 'Ayacucho', 'Paucar del Sara Sara', 'Oyolo');
INSERT INTO ubigeo VALUES (537, '051007', 'Ayacucho', 'Paucar del Sara Sara', 'Pararca');
INSERT INTO ubigeo VALUES (538, '051008', 'Ayacucho', 'Paucar del Sara Sara', 'San Javier de Alpabamba');
INSERT INTO ubigeo VALUES (539, '051009', 'Ayacucho', 'Paucar del Sara Sara', 'San Jose de Ushua');
INSERT INTO ubigeo VALUES (540, '051010', 'Ayacucho', 'Paucar del Sara Sara', 'Sara Sara');
INSERT INTO ubigeo VALUES (541, '051101', 'Ayacucho', 'Sucre', 'Querobamba');
INSERT INTO ubigeo VALUES (542, '051102', 'Ayacucho', 'Sucre', 'Belen');
INSERT INTO ubigeo VALUES (543, '051103', 'Ayacucho', 'Sucre', 'Chalcos');
INSERT INTO ubigeo VALUES (544, '051104', 'Ayacucho', 'Sucre', 'San Salvador de Quije');
INSERT INTO ubigeo VALUES (545, '051105', 'Ayacucho', 'Sucre', 'Paico');
INSERT INTO ubigeo VALUES (546, '051106', 'Ayacucho', 'Sucre', 'Santiago de Paucaray');
INSERT INTO ubigeo VALUES (547, '051107', 'Ayacucho', 'Sucre', 'San Pedro de Larcay');
INSERT INTO ubigeo VALUES (548, '051108', 'Ayacucho', 'Sucre', 'Soras');
INSERT INTO ubigeo VALUES (549, '051109', 'Ayacucho', 'Sucre', 'Huacaña');
INSERT INTO ubigeo VALUES (550, '051110', 'Ayacucho', 'Sucre', 'Chilcayoc');
INSERT INTO ubigeo VALUES (551, '051111', 'Ayacucho', 'Sucre', 'Morcolla');
INSERT INTO ubigeo VALUES (552, '060101', 'Cajamarca', 'Cajamarca', 'Cajamarca');
INSERT INTO ubigeo VALUES (553, '060102', 'Cajamarca', 'Cajamarca', 'Asuncion');
INSERT INTO ubigeo VALUES (554, '060103', 'Cajamarca', 'Cajamarca', 'Cospan');
INSERT INTO ubigeo VALUES (555, '060104', 'Cajamarca', 'Cajamarca', 'Chetilla');
INSERT INTO ubigeo VALUES (556, '060105', 'Cajamarca', 'Cajamarca', 'Encañada');
INSERT INTO ubigeo VALUES (557, '060106', 'Cajamarca', 'Cajamarca', 'Jesus');
INSERT INTO ubigeo VALUES (558, '060107', 'Cajamarca', 'Cajamarca', 'Los Baños del Inca');
INSERT INTO ubigeo VALUES (559, '060108', 'Cajamarca', 'Cajamarca', 'Llacanora');
INSERT INTO ubigeo VALUES (560, '060109', 'Cajamarca', 'Cajamarca', 'Magdalena');
INSERT INTO ubigeo VALUES (561, '060110', 'Cajamarca', 'Cajamarca', 'Matara');
INSERT INTO ubigeo VALUES (562, '060111', 'Cajamarca', 'Cajamarca', 'Namora');
INSERT INTO ubigeo VALUES (563, '060112', 'Cajamarca', 'Cajamarca', 'San Juan');
INSERT INTO ubigeo VALUES (564, '060201', 'Cajamarca', 'Cajabamba', 'Cajabamba');
INSERT INTO ubigeo VALUES (565, '060202', 'Cajamarca', 'Cajabamba', 'Cachachi');
INSERT INTO ubigeo VALUES (566, '060203', 'Cajamarca', 'Cajabamba', 'Condebamba');
INSERT INTO ubigeo VALUES (567, '060205', 'Cajamarca', 'Cajabamba', 'Sitacocha');
INSERT INTO ubigeo VALUES (568, '060301', 'Cajamarca', 'Celendin', 'Celendin');
INSERT INTO ubigeo VALUES (569, '060302', 'Cajamarca', 'Celendin', 'Cortegana');
INSERT INTO ubigeo VALUES (570, '060303', 'Cajamarca', 'Celendin', 'Chumuch');
INSERT INTO ubigeo VALUES (571, '060304', 'Cajamarca', 'Celendin', 'Huasmin');
INSERT INTO ubigeo VALUES (572, '060305', 'Cajamarca', 'Celendin', 'Jorge Chavez');
INSERT INTO ubigeo VALUES (573, '060306', 'Cajamarca', 'Celendin', 'Jose Galvez');
INSERT INTO ubigeo VALUES (574, '060307', 'Cajamarca', 'Celendin', 'Miguel Iglesias');
INSERT INTO ubigeo VALUES (575, '060308', 'Cajamarca', 'Celendin', 'Oxamarca');
INSERT INTO ubigeo VALUES (576, '060309', 'Cajamarca', 'Celendin', 'Sorochuco');
INSERT INTO ubigeo VALUES (577, '060310', 'Cajamarca', 'Celendin', 'Sucre');
INSERT INTO ubigeo VALUES (578, '060311', 'Cajamarca', 'Celendin', 'Utco');
INSERT INTO ubigeo VALUES (579, '060312', 'Cajamarca', 'Celendin', 'La Libertad de Pallan');
INSERT INTO ubigeo VALUES (580, '060401', 'Cajamarca', 'Contumaza', 'Contumaza');
INSERT INTO ubigeo VALUES (581, '060403', 'Cajamarca', 'Contumaza', 'Chilete');
INSERT INTO ubigeo VALUES (582, '060404', 'Cajamarca', 'Contumaza', 'Guzmango');
INSERT INTO ubigeo VALUES (583, '060405', 'Cajamarca', 'Contumaza', 'San Benito');
INSERT INTO ubigeo VALUES (584, '060406', 'Cajamarca', 'Contumaza', 'Cupisnique');
INSERT INTO ubigeo VALUES (585, '060407', 'Cajamarca', 'Contumaza', 'Tantarica');
INSERT INTO ubigeo VALUES (586, '060408', 'Cajamarca', 'Contumaza', 'Yonan');
INSERT INTO ubigeo VALUES (587, '060409', 'Cajamarca', 'Contumaza', 'Santa Cruz de Toled');
INSERT INTO ubigeo VALUES (588, '060501', 'Cajamarca', 'Cutervo', 'Cutervo');
INSERT INTO ubigeo VALUES (589, '060502', 'Cajamarca', 'Cutervo', 'Callayuc');
INSERT INTO ubigeo VALUES (590, '060503', 'Cajamarca', 'Cutervo', 'Cujillo');
INSERT INTO ubigeo VALUES (591, '060504', 'Cajamarca', 'Cutervo', 'Choros');
INSERT INTO ubigeo VALUES (592, '060505', 'Cajamarca', 'Cutervo', 'La Ramada');
INSERT INTO ubigeo VALUES (593, '060506', 'Cajamarca', 'Cutervo', 'Pimpingos');
INSERT INTO ubigeo VALUES (594, '060507', 'Cajamarca', 'Cutervo', 'Querocotillo');
INSERT INTO ubigeo VALUES (595, '060508', 'Cajamarca', 'Cutervo', 'San Andres de Cutervo');
INSERT INTO ubigeo VALUES (596, '060509', 'Cajamarca', 'Cutervo', 'San Juan de Cutervo');
INSERT INTO ubigeo VALUES (597, '060510', 'Cajamarca', 'Cutervo', 'San Luis de Lucma');
INSERT INTO ubigeo VALUES (598, '060511', 'Cajamarca', 'Cutervo', 'Santa Cruz');
INSERT INTO ubigeo VALUES (599, '060512', 'Cajamarca', 'Cutervo', 'Santo Domingo de La Capilla');
INSERT INTO ubigeo VALUES (600, '060513', 'Cajamarca', 'Cutervo', 'Santo Tomas');
INSERT INTO ubigeo VALUES (601, '060514', 'Cajamarca', 'Cutervo', 'Socota');
INSERT INTO ubigeo VALUES (602, '060515', 'Cajamarca', 'Cutervo', 'Toribio Casanova');
INSERT INTO ubigeo VALUES (603, '060601', 'Cajamarca', 'Chota', 'Chota');
INSERT INTO ubigeo VALUES (604, '060602', 'Cajamarca', 'Chota', 'Anguia');
INSERT INTO ubigeo VALUES (605, '060603', 'Cajamarca', 'Chota', 'Cochabamba');
INSERT INTO ubigeo VALUES (606, '060604', 'Cajamarca', 'Chota', 'Conchan');
INSERT INTO ubigeo VALUES (607, '060605', 'Cajamarca', 'Chota', 'Chadin');
INSERT INTO ubigeo VALUES (608, '060606', 'Cajamarca', 'Chota', 'Chiguirip');
INSERT INTO ubigeo VALUES (609, '060607', 'Cajamarca', 'Chota', 'Chimban');
INSERT INTO ubigeo VALUES (610, '060608', 'Cajamarca', 'Chota', 'Huambos');
INSERT INTO ubigeo VALUES (611, '060609', 'Cajamarca', 'Chota', 'Lajas');
INSERT INTO ubigeo VALUES (612, '060610', 'Cajamarca', 'Chota', 'Llama');
INSERT INTO ubigeo VALUES (613, '060611', 'Cajamarca', 'Chota', 'Miracosta');
INSERT INTO ubigeo VALUES (614, '060612', 'Cajamarca', 'Chota', 'Paccha');
INSERT INTO ubigeo VALUES (615, '060613', 'Cajamarca', 'Chota', 'Pion');
INSERT INTO ubigeo VALUES (616, '060614', 'Cajamarca', 'Chota', 'Querocoto');
INSERT INTO ubigeo VALUES (617, '060615', 'Cajamarca', 'Chota', 'Tacabamba');
INSERT INTO ubigeo VALUES (618, '060616', 'Cajamarca', 'Chota', 'Tocmoche');
INSERT INTO ubigeo VALUES (619, '060617', 'Cajamarca', 'Chota', 'San Juan de Licupis');
INSERT INTO ubigeo VALUES (620, '060618', 'Cajamarca', 'Chota', 'Choropampa');
INSERT INTO ubigeo VALUES (621, '060619', 'Cajamarca', 'Chota', 'Chalamarca');
INSERT INTO ubigeo VALUES (622, '060701', 'Cajamarca', 'Hualgayoc', 'Bambamarca');
INSERT INTO ubigeo VALUES (623, '060702', 'Cajamarca', 'Hualgayoc', 'Chugur');
INSERT INTO ubigeo VALUES (624, '060703', 'Cajamarca', 'Hualgayoc', 'Hualgayoc');
INSERT INTO ubigeo VALUES (625, '060801', 'Cajamarca', 'Jaen', 'Jaen');
INSERT INTO ubigeo VALUES (626, '060802', 'Cajamarca', 'Jaen', 'Bellavista');
INSERT INTO ubigeo VALUES (627, '060803', 'Cajamarca', 'Jaen', 'Colasay');
INSERT INTO ubigeo VALUES (628, '060804', 'Cajamarca', 'Jaen', 'Chontali');
INSERT INTO ubigeo VALUES (629, '060805', 'Cajamarca', 'Jaen', 'Pomahuaca');
INSERT INTO ubigeo VALUES (630, '060806', 'Cajamarca', 'Jaen', 'Pucara');
INSERT INTO ubigeo VALUES (631, '060807', 'Cajamarca', 'Jaen', 'Sallique');
INSERT INTO ubigeo VALUES (632, '060808', 'Cajamarca', 'Jaen', 'San Felipe');
INSERT INTO ubigeo VALUES (633, '060809', 'Cajamarca', 'Jaen', 'San Jose del Alto');
INSERT INTO ubigeo VALUES (634, '060810', 'Cajamarca', 'Jaen', 'Santa Rosa');
INSERT INTO ubigeo VALUES (635, '060811', 'Cajamarca', 'Jaen', 'Las Pirias');
INSERT INTO ubigeo VALUES (636, '060812', 'Cajamarca', 'Jaen', 'Huabal');
INSERT INTO ubigeo VALUES (637, '060901', 'Cajamarca', 'Santa Cruz', 'Santa Cruz');
INSERT INTO ubigeo VALUES (638, '060902', 'Cajamarca', 'Santa Cruz', 'Catache');
INSERT INTO ubigeo VALUES (639, '060903', 'Cajamarca', 'Santa Cruz', 'Chancaybaños');
INSERT INTO ubigeo VALUES (640, '060904', 'Cajamarca', 'Santa Cruz', 'La Esperanza');
INSERT INTO ubigeo VALUES (641, '060905', 'Cajamarca', 'Santa Cruz', 'Ninabamba');
INSERT INTO ubigeo VALUES (642, '060906', 'Cajamarca', 'Santa Cruz', 'Pulan');
INSERT INTO ubigeo VALUES (643, '060907', 'Cajamarca', 'Santa Cruz', 'Sexi');
INSERT INTO ubigeo VALUES (644, '060908', 'Cajamarca', 'Santa Cruz', 'Uticyacu');
INSERT INTO ubigeo VALUES (645, '060909', 'Cajamarca', 'Santa Cruz', 'Yauyucan');
INSERT INTO ubigeo VALUES (646, '060910', 'Cajamarca', 'Santa Cruz', 'Andabamba');
INSERT INTO ubigeo VALUES (647, '060911', 'Cajamarca', 'Santa Cruz', 'Saucepampa');
INSERT INTO ubigeo VALUES (648, '061001', 'Cajamarca', 'San Miguel', 'San Miguel');
INSERT INTO ubigeo VALUES (649, '061002', 'Cajamarca', 'San Miguel', 'Calquis');
INSERT INTO ubigeo VALUES (650, '061003', 'Cajamarca', 'San Miguel', 'La Florida');
INSERT INTO ubigeo VALUES (651, '061004', 'Cajamarca', 'San Miguel', 'Llapa');
INSERT INTO ubigeo VALUES (652, '061005', 'Cajamarca', 'San Miguel', 'Nanchoc');
INSERT INTO ubigeo VALUES (653, '061006', 'Cajamarca', 'San Miguel', 'Niepos');
INSERT INTO ubigeo VALUES (654, '061007', 'Cajamarca', 'San Miguel', 'San Gregorio');
INSERT INTO ubigeo VALUES (655, '061008', 'Cajamarca', 'San Miguel', 'San Silvestre de Cochan');
INSERT INTO ubigeo VALUES (656, '061009', 'Cajamarca', 'San Miguel', 'El Prado');
INSERT INTO ubigeo VALUES (657, '061010', 'Cajamarca', 'San Miguel', 'Union Agua Blanca');
INSERT INTO ubigeo VALUES (658, '061011', 'Cajamarca', 'San Miguel', 'Tongod');
INSERT INTO ubigeo VALUES (659, '061012', 'Cajamarca', 'San Miguel', 'Catilluc');
INSERT INTO ubigeo VALUES (660, '061013', 'Cajamarca', 'San Miguel', 'Bolivar');
INSERT INTO ubigeo VALUES (661, '061101', 'Cajamarca', 'San Ignacio', 'San Ignacio');
INSERT INTO ubigeo VALUES (662, '061102', 'Cajamarca', 'San Ignacio', 'Chirinos');
INSERT INTO ubigeo VALUES (663, '061103', 'Cajamarca', 'San Ignacio', 'Huarango');
INSERT INTO ubigeo VALUES (664, '061104', 'Cajamarca', 'San Ignacio', 'Namballe');
INSERT INTO ubigeo VALUES (665, '061105', 'Cajamarca', 'San Ignacio', 'La Coipa');
INSERT INTO ubigeo VALUES (666, '061106', 'Cajamarca', 'San Ignacio', 'San Jose de Lourdes');
INSERT INTO ubigeo VALUES (667, '061107', 'Cajamarca', 'San Ignacio', 'Tabaconas');
INSERT INTO ubigeo VALUES (668, '061201', 'Cajamarca', 'San Marcos', 'Pedro Galvez');
INSERT INTO ubigeo VALUES (669, '061202', 'Cajamarca', 'San Marcos', 'Ichocan');
INSERT INTO ubigeo VALUES (670, '061203', 'Cajamarca', 'San Marcos', 'Gregorio Pita');
INSERT INTO ubigeo VALUES (671, '061204', 'Cajamarca', 'San Marcos', 'Jose Manuel Quiroz');
INSERT INTO ubigeo VALUES (672, '061205', 'Cajamarca', 'San Marcos', 'Eduardo Villanueva');
INSERT INTO ubigeo VALUES (673, '061206', 'Cajamarca', 'San Marcos', 'Jose Sabogal');
INSERT INTO ubigeo VALUES (674, '061207', 'Cajamarca', 'San Marcos', 'Chancay');
INSERT INTO ubigeo VALUES (675, '061301', 'Cajamarca', 'San Pablo', 'San Pablo');
INSERT INTO ubigeo VALUES (676, '061302', 'Cajamarca', 'San Pablo', 'San Bernardino');
INSERT INTO ubigeo VALUES (677, '061303', 'Cajamarca', 'San Pablo', 'San Luis');
INSERT INTO ubigeo VALUES (678, '061304', 'Cajamarca', 'San Pablo', 'Tumbaden');
INSERT INTO ubigeo VALUES (679, '070101', 'Cusco', 'Cusco', 'Cusco');
INSERT INTO ubigeo VALUES (680, '070102', 'Cusco', 'Cusco', 'Ccorca');
INSERT INTO ubigeo VALUES (681, '070103', 'Cusco', 'Cusco', 'Poroy');
INSERT INTO ubigeo VALUES (682, '070104', 'Cusco', 'Cusco', 'San Jeronimo');
INSERT INTO ubigeo VALUES (683, '070105', 'Cusco', 'Cusco', 'San Sebastian');
INSERT INTO ubigeo VALUES (684, '070106', 'Cusco', 'Cusco', 'Santiago');
INSERT INTO ubigeo VALUES (685, '070107', 'Cusco', 'Cusco', 'Saylla');
INSERT INTO ubigeo VALUES (686, '070108', 'Cusco', 'Cusco', 'Wanchaq');
INSERT INTO ubigeo VALUES (687, '070201', 'Cusco', 'Acomayo', 'Acomayo');
INSERT INTO ubigeo VALUES (688, '070202', 'Cusco', 'Acomayo', 'Acopia');
INSERT INTO ubigeo VALUES (689, '070203', 'Cusco', 'Acomayo', 'Acos');
INSERT INTO ubigeo VALUES (690, '070204', 'Cusco', 'Acomayo', 'Pomacanchi');
INSERT INTO ubigeo VALUES (691, '070205', 'Cusco', 'Acomayo', 'Rondocan');
INSERT INTO ubigeo VALUES (692, '070206', 'Cusco', 'Acomayo', 'Sangarara');
INSERT INTO ubigeo VALUES (693, '070207', 'Cusco', 'Acomayo', 'Mosoc Llacta');
INSERT INTO ubigeo VALUES (694, '070301', 'Cusco', 'Anta', 'Anta');
INSERT INTO ubigeo VALUES (695, '070302', 'Cusco', 'Anta', 'Chinchaypujio');
INSERT INTO ubigeo VALUES (696, '070303', 'Cusco', 'Anta', 'Huarocondo');
INSERT INTO ubigeo VALUES (697, '070304', 'Cusco', 'Anta', 'Limatambo');
INSERT INTO ubigeo VALUES (698, '070305', 'Cusco', 'Anta', 'Mollepata');
INSERT INTO ubigeo VALUES (699, '070306', 'Cusco', 'Anta', 'Pucyura');
INSERT INTO ubigeo VALUES (700, '070307', 'Cusco', 'Anta', 'Zurite');
INSERT INTO ubigeo VALUES (701, '070308', 'Cusco', 'Anta', 'Cachimayo');
INSERT INTO ubigeo VALUES (702, '070309', 'Cusco', 'Anta', 'Ancahuasi');
INSERT INTO ubigeo VALUES (703, '070401', 'Cusco', 'Calca', 'Calca');
INSERT INTO ubigeo VALUES (704, '070402', 'Cusco', 'Calca', 'Coya');
INSERT INTO ubigeo VALUES (705, '070403', 'Cusco', 'Calca', 'Lamay');
INSERT INTO ubigeo VALUES (706, '070404', 'Cusco', 'Calca', 'Lares');
INSERT INTO ubigeo VALUES (707, '070405', 'Cusco', 'Calca', 'Pisac');
INSERT INTO ubigeo VALUES (708, '070406', 'Cusco', 'Calca', 'San Salvador');
INSERT INTO ubigeo VALUES (709, '070407', 'Cusco', 'Calca', 'Taray');
INSERT INTO ubigeo VALUES (710, '070408', 'Cusco', 'Calca', 'Yanatile');
INSERT INTO ubigeo VALUES (711, '070501', 'Cusco', 'Canas', 'Yanaoca');
INSERT INTO ubigeo VALUES (712, '070502', 'Cusco', 'Canas', 'Checca');
INSERT INTO ubigeo VALUES (713, '070503', 'Cusco', 'Canas', 'Kunturkanki');
INSERT INTO ubigeo VALUES (714, '070504', 'Cusco', 'Canas', 'Langui');
INSERT INTO ubigeo VALUES (715, '070505', 'Cusco', 'Canas', 'Layo');
INSERT INTO ubigeo VALUES (716, '070506', 'Cusco', 'Canas', 'Pampamarca');
INSERT INTO ubigeo VALUES (717, '070507', 'Cusco', 'Canas', 'Quehue');
INSERT INTO ubigeo VALUES (718, '070508', 'Cusco', 'Canas', 'Tupac Amaru');
INSERT INTO ubigeo VALUES (719, '070601', 'Cusco', 'Canchis', 'Sicuani');
INSERT INTO ubigeo VALUES (720, '070602', 'Cusco', 'Canchis', 'Combapata');
INSERT INTO ubigeo VALUES (721, '070603', 'Cusco', 'Canchis', 'Checacupe');
INSERT INTO ubigeo VALUES (722, '070604', 'Cusco', 'Canchis', 'Marangani');
INSERT INTO ubigeo VALUES (723, '070605', 'Cusco', 'Canchis', 'Pitumarca');
INSERT INTO ubigeo VALUES (724, '070606', 'Cusco', 'Canchis', 'San Pablo');
INSERT INTO ubigeo VALUES (725, '070607', 'Cusco', 'Canchis', 'San Pedro');
INSERT INTO ubigeo VALUES (726, '070608', 'Cusco', 'Canchis', 'Tinta');
INSERT INTO ubigeo VALUES (727, '070701', 'Cusco', 'Chumbivilcas', 'Santo Tomas');
INSERT INTO ubigeo VALUES (728, '070702', 'Cusco', 'Chumbivilcas', 'Capacmarca');
INSERT INTO ubigeo VALUES (729, '070703', 'Cusco', 'Chumbivilcas', 'Colquemarca');
INSERT INTO ubigeo VALUES (730, '070704', 'Cusco', 'Chumbivilcas', 'Chamaca');
INSERT INTO ubigeo VALUES (731, '070705', 'Cusco', 'Chumbivilcas', 'Livitaca');
INSERT INTO ubigeo VALUES (732, '070706', 'Cusco', 'Chumbivilcas', 'Llusco');
INSERT INTO ubigeo VALUES (733, '070707', 'Cusco', 'Chumbivilcas', 'Quiñota');
INSERT INTO ubigeo VALUES (734, '070708', 'Cusco', 'Chumbivilcas', 'Velille');
INSERT INTO ubigeo VALUES (735, '070801', 'Cusco', 'Espinar', 'Espinar');
INSERT INTO ubigeo VALUES (736, '070802', 'Cusco', 'Espinar', 'Condoroma');
INSERT INTO ubigeo VALUES (737, '070803', 'Cusco', 'Espinar', 'Coporaque');
INSERT INTO ubigeo VALUES (738, '070804', 'Cusco', 'Espinar', 'Ocoruro');
INSERT INTO ubigeo VALUES (739, '070805', 'Cusco', 'Espinar', 'Pallpata');
INSERT INTO ubigeo VALUES (740, '070806', 'Cusco', 'Espinar', 'Pichigua');
INSERT INTO ubigeo VALUES (741, '070807', 'Cusco', 'Espinar', 'Suyckutambo');
INSERT INTO ubigeo VALUES (742, '070808', 'Cusco', 'Espinar', 'Alto Pichigua');
INSERT INTO ubigeo VALUES (743, '070901', 'Cusco', 'La Convencion', 'Santa Ana');
INSERT INTO ubigeo VALUES (744, '070902', 'Cusco', 'La Convencion', 'Echarate');
INSERT INTO ubigeo VALUES (745, '070903', 'Cusco', 'La Convencion', 'Huayopata');
INSERT INTO ubigeo VALUES (746, '070904', 'Cusco', 'La Convencion', 'Maranura');
INSERT INTO ubigeo VALUES (747, '070905', 'Cusco', 'La Convencion', 'Ocobamba');
INSERT INTO ubigeo VALUES (748, '070906', 'Cusco', 'La Convencion', 'Santa Teresa');
INSERT INTO ubigeo VALUES (749, '070907', 'Cusco', 'La Convencion', 'Vilcabamba');
INSERT INTO ubigeo VALUES (750, '070908', 'Cusco', 'La Convencion', 'Quellouno');
INSERT INTO ubigeo VALUES (751, '070909', 'Cusco', 'La Convencion', 'Kimbiri');
INSERT INTO ubigeo VALUES (752, '070910', 'Cusco', 'La Convencion', 'Pichari');
INSERT INTO ubigeo VALUES (753, '071001', 'Cusco', 'Paruro', 'Paruro');
INSERT INTO ubigeo VALUES (754, '071002', 'Cusco', 'Paruro', 'Accha');
INSERT INTO ubigeo VALUES (755, '071003', 'Cusco', 'Paruro', 'Ccapi');
INSERT INTO ubigeo VALUES (756, '071004', 'Cusco', 'Paruro', 'Colcha');
INSERT INTO ubigeo VALUES (757, '071005', 'Cusco', 'Paruro', 'Huanoquite');
INSERT INTO ubigeo VALUES (758, '071006', 'Cusco', 'Paruro', 'Omacha');
INSERT INTO ubigeo VALUES (759, '071007', 'Cusco', 'Paruro', 'Yaurisque');
INSERT INTO ubigeo VALUES (760, '071008', 'Cusco', 'Paruro', 'Paccaritambo');
INSERT INTO ubigeo VALUES (761, '071009', 'Cusco', 'Paruro', 'Pillpinto');
INSERT INTO ubigeo VALUES (762, '071101', 'Cusco', 'Paucartambo', 'Paucartambo');
INSERT INTO ubigeo VALUES (763, '071102', 'Cusco', 'Paucartambo', 'Caicay');
INSERT INTO ubigeo VALUES (764, '071103', 'Cusco', 'Paucartambo', 'Colquepata');
INSERT INTO ubigeo VALUES (765, '071104', 'Cusco', 'Paucartambo', 'Challabamba');
INSERT INTO ubigeo VALUES (766, '071105', 'Cusco', 'Paucartambo', 'Kosñipata');
INSERT INTO ubigeo VALUES (767, '071106', 'Cusco', 'Paucartambo', 'Huancarani');
INSERT INTO ubigeo VALUES (768, '071201', 'Cusco', 'Quispicanchi', 'Urcos');
INSERT INTO ubigeo VALUES (769, '071202', 'Cusco', 'Quispicanchi', 'Andahuaylillas');
INSERT INTO ubigeo VALUES (770, '071203', 'Cusco', 'Quispicanchi', 'Camanti');
INSERT INTO ubigeo VALUES (771, '071204', 'Cusco', 'Quispicanchi', 'Ccarhuayo');
INSERT INTO ubigeo VALUES (772, '071205', 'Cusco', 'Quispicanchi', 'Ccatca');
INSERT INTO ubigeo VALUES (773, '071206', 'Cusco', 'Quispicanchi', 'Cusipata');
INSERT INTO ubigeo VALUES (774, '071207', 'Cusco', 'Quispicanchi', 'Huaro');
INSERT INTO ubigeo VALUES (775, '071208', 'Cusco', 'Quispicanchi', 'Lucre');
INSERT INTO ubigeo VALUES (776, '071209', 'Cusco', 'Quispicanchi', 'Marcapata');
INSERT INTO ubigeo VALUES (777, '071210', 'Cusco', 'Quispicanchi', 'Ocongate');
INSERT INTO ubigeo VALUES (778, '071211', 'Cusco', 'Quispicanchi', 'Oropesa');
INSERT INTO ubigeo VALUES (779, '071212', 'Cusco', 'Quispicanchi', 'Quiquijana');
INSERT INTO ubigeo VALUES (780, '071301', 'Cusco', 'Urubamba', 'Urubamba');
INSERT INTO ubigeo VALUES (781, '071302', 'Cusco', 'Urubamba', 'Chinchero');
INSERT INTO ubigeo VALUES (782, '071303', 'Cusco', 'Urubamba', 'Huayllabamba');
INSERT INTO ubigeo VALUES (783, '071304', 'Cusco', 'Urubamba', 'Machupicchu');
INSERT INTO ubigeo VALUES (784, '071305', 'Cusco', 'Urubamba', 'Maras');
INSERT INTO ubigeo VALUES (785, '071306', 'Cusco', 'Urubamba', 'Ollantaytambo');
INSERT INTO ubigeo VALUES (786, '071307', 'Cusco', 'Urubamba', 'Yucay');
INSERT INTO ubigeo VALUES (787, '080101', 'Huancavelica', 'Huancavelica', 'Huancavelica');
INSERT INTO ubigeo VALUES (788, '080102', 'Huancavelica', 'Huancavelica', 'Acobambilla');
INSERT INTO ubigeo VALUES (789, '080103', 'Huancavelica', 'Huancavelica', 'Acoria');
INSERT INTO ubigeo VALUES (790, '080104', 'Huancavelica', 'Huancavelica', 'Conayca');
INSERT INTO ubigeo VALUES (791, '080105', 'Huancavelica', 'Huancavelica', 'Cuenca');
INSERT INTO ubigeo VALUES (792, '080106', 'Huancavelica', 'Huancavelica', 'Huachocolpa');
INSERT INTO ubigeo VALUES (793, '080108', 'Huancavelica', 'Huancavelica', 'Huayllahuara');
INSERT INTO ubigeo VALUES (794, '080109', 'Huancavelica', 'Huancavelica', 'Izcuchaca');
INSERT INTO ubigeo VALUES (795, '080110', 'Huancavelica', 'Huancavelica', 'Laria');
INSERT INTO ubigeo VALUES (796, '080111', 'Huancavelica', 'Huancavelica', 'Manta');
INSERT INTO ubigeo VALUES (797, '080112', 'Huancavelica', 'Huancavelica', 'Mariscal Caceres');
INSERT INTO ubigeo VALUES (798, '080113', 'Huancavelica', 'Huancavelica', 'Moya');
INSERT INTO ubigeo VALUES (799, '080114', 'Huancavelica', 'Huancavelica', 'Nuevo Occoro');
INSERT INTO ubigeo VALUES (800, '080115', 'Huancavelica', 'Huancavelica', 'Palca');
INSERT INTO ubigeo VALUES (801, '080116', 'Huancavelica', 'Huancavelica', 'Pilchaca');
INSERT INTO ubigeo VALUES (802, '080117', 'Huancavelica', 'Huancavelica', 'Vilca');
INSERT INTO ubigeo VALUES (803, '080118', 'Huancavelica', 'Huancavelica', 'Yauli');
INSERT INTO ubigeo VALUES (804, '080119', 'Huancavelica', 'Huancavelica', 'Ascension');
INSERT INTO ubigeo VALUES (805, '080120', 'Huancavelica', 'Huancavelica', 'Huando');
INSERT INTO ubigeo VALUES (806, '080201', 'Huancavelica', 'Acobamba', 'Acobamba');
INSERT INTO ubigeo VALUES (807, '080202', 'Huancavelica', 'Acobamba', 'Anta');
INSERT INTO ubigeo VALUES (808, '080203', 'Huancavelica', 'Acobamba', 'Andabamba');
INSERT INTO ubigeo VALUES (809, '080204', 'Huancavelica', 'Acobamba', 'Caja');
INSERT INTO ubigeo VALUES (810, '080205', 'Huancavelica', 'Acobamba', 'Marcas');
INSERT INTO ubigeo VALUES (811, '080206', 'Huancavelica', 'Acobamba', 'Paucara');
INSERT INTO ubigeo VALUES (812, '080207', 'Huancavelica', 'Acobamba', 'Pomacocha');
INSERT INTO ubigeo VALUES (813, '080208', 'Huancavelica', 'Acobamba', 'Rosario');
INSERT INTO ubigeo VALUES (814, '080301', 'Huancavelica', 'Angaraes', 'Lircay');
INSERT INTO ubigeo VALUES (815, '080302', 'Huancavelica', 'Angaraes', 'Anchonga');
INSERT INTO ubigeo VALUES (816, '080303', 'Huancavelica', 'Angaraes', 'Callanmarca');
INSERT INTO ubigeo VALUES (817, '080304', 'Huancavelica', 'Angaraes', 'Congalla');
INSERT INTO ubigeo VALUES (818, '080305', 'Huancavelica', 'Angaraes', 'Chincho');
INSERT INTO ubigeo VALUES (819, '080306', 'Huancavelica', 'Angaraes', 'Huayllay Grande');
INSERT INTO ubigeo VALUES (820, '080307', 'Huancavelica', 'Angaraes', 'Huanca-Huanca');
INSERT INTO ubigeo VALUES (821, '080308', 'Huancavelica', 'Angaraes', 'Julcamarca');
INSERT INTO ubigeo VALUES (822, '080309', 'Huancavelica', 'Angaraes', 'San Antonio de Antaparco');
INSERT INTO ubigeo VALUES (823, '080310', 'Huancavelica', 'Angaraes', 'Santo Tomas de Pata');
INSERT INTO ubigeo VALUES (824, '080311', 'Huancavelica', 'Angaraes', 'Secclla');
INSERT INTO ubigeo VALUES (825, '080312', 'Huancavelica', 'Angaraes', 'Ccochaccasa');
INSERT INTO ubigeo VALUES (826, '080401', 'Huancavelica', 'Castrovirreyna', 'Castrovirreyna');
INSERT INTO ubigeo VALUES (827, '080402', 'Huancavelica', 'Castrovirreyna', 'Arma');
INSERT INTO ubigeo VALUES (828, '080403', 'Huancavelica', 'Castrovirreyna', 'Aurahua');
INSERT INTO ubigeo VALUES (829, '080405', 'Huancavelica', 'Castrovirreyna', 'Capillas');
INSERT INTO ubigeo VALUES (830, '080406', 'Huancavelica', 'Castrovirreyna', 'Cocas');
INSERT INTO ubigeo VALUES (831, '080408', 'Huancavelica', 'Castrovirreyna', 'Chupamarca');
INSERT INTO ubigeo VALUES (832, '080409', 'Huancavelica', 'Castrovirreyna', 'Huachos');
INSERT INTO ubigeo VALUES (833, '080410', 'Huancavelica', 'Castrovirreyna', 'Huamatambo');
INSERT INTO ubigeo VALUES (834, '080414', 'Huancavelica', 'Castrovirreyna', 'Mollepampa');
INSERT INTO ubigeo VALUES (835, '080422', 'Huancavelica', 'Castrovirreyna', 'San Juan');
INSERT INTO ubigeo VALUES (836, '080427', 'Huancavelica', 'Castrovirreyna', 'Tantara');
INSERT INTO ubigeo VALUES (837, '080428', 'Huancavelica', 'Castrovirreyna', 'Ticrapo');
INSERT INTO ubigeo VALUES (838, '080429', 'Huancavelica', 'Castrovirreyna', 'Santa Ana');
INSERT INTO ubigeo VALUES (839, '080501', 'Huancavelica', 'Tayacaja', 'Pampas');
INSERT INTO ubigeo VALUES (840, '080502', 'Huancavelica', 'Tayacaja', 'Acostambo');
INSERT INTO ubigeo VALUES (841, '080503', 'Huancavelica', 'Tayacaja', 'Acraquia');
INSERT INTO ubigeo VALUES (842, '080504', 'Huancavelica', 'Tayacaja', 'Ahuaycha');
INSERT INTO ubigeo VALUES (843, '080506', 'Huancavelica', 'Tayacaja', 'Colcabamba');
INSERT INTO ubigeo VALUES (844, '080509', 'Huancavelica', 'Tayacaja', 'Daniel Hernandez');
INSERT INTO ubigeo VALUES (845, '080511', 'Huancavelica', 'Tayacaja', 'Huachocolpa');
INSERT INTO ubigeo VALUES (846, '080512', 'Huancavelica', 'Tayacaja', 'Huaribamba');
INSERT INTO ubigeo VALUES (847, '080515', 'Huancavelica', 'Tayacaja', 'Ñahuimpuquio');
INSERT INTO ubigeo VALUES (848, '080517', 'Huancavelica', 'Tayacaja', 'Pazos');
INSERT INTO ubigeo VALUES (849, '080518', 'Huancavelica', 'Tayacaja', 'Quishuar');
INSERT INTO ubigeo VALUES (850, '080519', 'Huancavelica', 'Tayacaja', 'Salcabamba');
INSERT INTO ubigeo VALUES (851, '080520', 'Huancavelica', 'Tayacaja', 'San Marcos de Rocchac');
INSERT INTO ubigeo VALUES (852, '080523', 'Huancavelica', 'Tayacaja', 'Surcubamba');
INSERT INTO ubigeo VALUES (853, '080525', 'Huancavelica', 'Tayacaja', 'Tintay Puncu');
INSERT INTO ubigeo VALUES (854, '080526', 'Huancavelica', 'Tayacaja', 'Salcahuasi');
INSERT INTO ubigeo VALUES (855, '080601', 'Huancavelica', 'Huaytara', 'Ayavi');
INSERT INTO ubigeo VALUES (856, '080602', 'Huancavelica', 'Huaytara', 'Cordova');
INSERT INTO ubigeo VALUES (857, '080603', 'Huancavelica', 'Huaytara', 'Huayacundo Arma');
INSERT INTO ubigeo VALUES (858, '080604', 'Huancavelica', 'Huaytara', 'Huaytara');
INSERT INTO ubigeo VALUES (859, '080605', 'Huancavelica', 'Huaytara', 'Laramarca');
INSERT INTO ubigeo VALUES (860, '080606', 'Huancavelica', 'Huaytara', 'Ocoyo');
INSERT INTO ubigeo VALUES (861, '080607', 'Huancavelica', 'Huaytara', 'Pilpichaca');
INSERT INTO ubigeo VALUES (862, '080608', 'Huancavelica', 'Huaytara', 'Querco');
INSERT INTO ubigeo VALUES (863, '080609', 'Huancavelica', 'Huaytara', 'Quito-Arma');
INSERT INTO ubigeo VALUES (864, '080610', 'Huancavelica', 'Huaytara', 'San Antonio de Cusicancha');
INSERT INTO ubigeo VALUES (865, '080611', 'Huancavelica', 'Huaytara', 'San Francisco de Sangayaico');
INSERT INTO ubigeo VALUES (866, '080612', 'Huancavelica', 'Huaytara', 'San Isidro');
INSERT INTO ubigeo VALUES (867, '080613', 'Huancavelica', 'Huaytara', 'Santiago de Chocorvos');
INSERT INTO ubigeo VALUES (868, '080614', 'Huancavelica', 'Huaytara', 'Santiago de Quirahuara');
INSERT INTO ubigeo VALUES (869, '080615', 'Huancavelica', 'Huaytara', 'Santo Domingo de Capillas');
INSERT INTO ubigeo VALUES (870, '080616', 'Huancavelica', 'Huaytara', 'Tambo');
INSERT INTO ubigeo VALUES (871, '080701', 'Huancavelica', 'Churcampa', 'Churcampa');
INSERT INTO ubigeo VALUES (872, '080702', 'Huancavelica', 'Churcampa', 'Anco');
INSERT INTO ubigeo VALUES (873, '080703', 'Huancavelica', 'Churcampa', 'Chinchihuasi');
INSERT INTO ubigeo VALUES (874, '080704', 'Huancavelica', 'Churcampa', 'El Carmen');
INSERT INTO ubigeo VALUES (875, '080705', 'Huancavelica', 'Churcampa', 'La Merced');
INSERT INTO ubigeo VALUES (876, '080706', 'Huancavelica', 'Churcampa', 'Locroja');
INSERT INTO ubigeo VALUES (877, '080707', 'Huancavelica', 'Churcampa', 'Paucarbamba');
INSERT INTO ubigeo VALUES (878, '080708', 'Huancavelica', 'Churcampa', 'San Miguel de Mayocc');
INSERT INTO ubigeo VALUES (879, '080709', 'Huancavelica', 'Churcampa', 'San Pedro de Coris');
INSERT INTO ubigeo VALUES (880, '080710', 'Huancavelica', 'Churcampa', 'Pachamarca');
INSERT INTO ubigeo VALUES (881, '080711', 'Huancavelica', 'Churcampa', 'Cosme');
INSERT INTO ubigeo VALUES (882, '090101', 'Huanuco', 'Huanuco', 'Huanuco');
INSERT INTO ubigeo VALUES (883, '090102', 'Huanuco', 'Huanuco', 'Chinchao');
INSERT INTO ubigeo VALUES (884, '090103', 'Huanuco', 'Huanuco', 'Churubamba');
INSERT INTO ubigeo VALUES (885, '090104', 'Huanuco', 'Huanuco', 'Margos');
INSERT INTO ubigeo VALUES (886, '090105', 'Huanuco', 'Huanuco', 'Quisqui');
INSERT INTO ubigeo VALUES (887, '090106', 'Huanuco', 'Huanuco', 'San Francisco de Cayran');
INSERT INTO ubigeo VALUES (888, '090107', 'Huanuco', 'Huanuco', 'San Pedro de Chaulan');
INSERT INTO ubigeo VALUES (889, '090108', 'Huanuco', 'Huanuco', 'Santa Maria del Valle');
INSERT INTO ubigeo VALUES (890, '090109', 'Huanuco', 'Huanuco', 'Yarumayo');
INSERT INTO ubigeo VALUES (891, '090110', 'Huanuco', 'Huanuco', 'Amarilis');
INSERT INTO ubigeo VALUES (892, '090111', 'Huanuco', 'Huanuco', 'Pillco Marca');
INSERT INTO ubigeo VALUES (893, '090112', 'Huanuco', 'Huanuco', 'Yacus');
INSERT INTO ubigeo VALUES (894, '090201', 'Huanuco', 'Ambo', 'Ambo');
INSERT INTO ubigeo VALUES (895, '090202', 'Huanuco', 'Ambo', 'Cayna');
INSERT INTO ubigeo VALUES (896, '090203', 'Huanuco', 'Ambo', 'Colpas');
INSERT INTO ubigeo VALUES (897, '090204', 'Huanuco', 'Ambo', 'Conchamarca');
INSERT INTO ubigeo VALUES (898, '090205', 'Huanuco', 'Ambo', 'Huacar');
INSERT INTO ubigeo VALUES (899, '090206', 'Huanuco', 'Ambo', 'San Francisco');
INSERT INTO ubigeo VALUES (900, '090207', 'Huanuco', 'Ambo', 'San Rafael');
INSERT INTO ubigeo VALUES (901, '090208', 'Huanuco', 'Ambo', 'Tomay Kichwa');
INSERT INTO ubigeo VALUES (902, '090301', 'Huanuco', 'Dos de Mayo', 'La Union');
INSERT INTO ubigeo VALUES (903, '090307', 'Huanuco', 'Dos de Mayo', 'Chuquis');
INSERT INTO ubigeo VALUES (904, '090312', 'Huanuco', 'Dos de Mayo', 'Marias');
INSERT INTO ubigeo VALUES (905, '090314', 'Huanuco', 'Dos de Mayo', 'Pachas');
INSERT INTO ubigeo VALUES (906, '090316', 'Huanuco', 'Dos de Mayo', 'Quivilla');
INSERT INTO ubigeo VALUES (907, '090317', 'Huanuco', 'Dos de Mayo', 'Ripan');
INSERT INTO ubigeo VALUES (908, '090321', 'Huanuco', 'Dos de Mayo', 'Shunqui');
INSERT INTO ubigeo VALUES (909, '090322', 'Huanuco', 'Dos de Mayo', 'Sillapata');
INSERT INTO ubigeo VALUES (910, '090323', 'Huanuco', 'Dos de Mayo', 'Yanas');
INSERT INTO ubigeo VALUES (911, '090401', 'Huanuco', 'Huamalies', 'Llata');
INSERT INTO ubigeo VALUES (912, '090402', 'Huanuco', 'Huamalies', 'Arancay');
INSERT INTO ubigeo VALUES (913, '090403', 'Huanuco', 'Huamalies', 'Chavin de Pariarca');
INSERT INTO ubigeo VALUES (914, '090404', 'Huanuco', 'Huamalies', 'Jacas Grande');
INSERT INTO ubigeo VALUES (915, '090405', 'Huanuco', 'Huamalies', 'Jircan');
INSERT INTO ubigeo VALUES (916, '090406', 'Huanuco', 'Huamalies', 'Miraflores');
INSERT INTO ubigeo VALUES (917, '090407', 'Huanuco', 'Huamalies', 'Monzon');
INSERT INTO ubigeo VALUES (918, '090408', 'Huanuco', 'Huamalies', 'Punchao');
INSERT INTO ubigeo VALUES (919, '090409', 'Huanuco', 'Huamalies', 'Puños');
INSERT INTO ubigeo VALUES (920, '090410', 'Huanuco', 'Huamalies', 'Singa');
INSERT INTO ubigeo VALUES (921, '090411', 'Huanuco', 'Huamalies', 'Tantamayo');
INSERT INTO ubigeo VALUES (922, '090501', 'Huanuco', 'Marañon', 'Huacrachuco');
INSERT INTO ubigeo VALUES (923, '090502', 'Huanuco', 'Marañon', 'Cholon');
INSERT INTO ubigeo VALUES (924, '090505', 'Huanuco', 'Marañon', 'San Buenaventura');
INSERT INTO ubigeo VALUES (925, '090601', 'Huanuco', 'Leoncio Prado', 'Rupa-Rupa');
INSERT INTO ubigeo VALUES (926, '090602', 'Huanuco', 'Leoncio Prado', 'Daniel Alomias Robles');
INSERT INTO ubigeo VALUES (927, '090603', 'Huanuco', 'Leoncio Prado', 'Hermilio Valdizan');
INSERT INTO ubigeo VALUES (928, '090604', 'Huanuco', 'Leoncio Prado', 'Luyando');
INSERT INTO ubigeo VALUES (929, '090605', 'Huanuco', 'Leoncio Prado', 'Mariano Damaso Beraun');
INSERT INTO ubigeo VALUES (930, '090606', 'Huanuco', 'Leoncio Prado', 'Jose Crespo y Castillo');
INSERT INTO ubigeo VALUES (931, '090701', 'Huanuco', 'Pachitea', 'Panao');
INSERT INTO ubigeo VALUES (932, '090702', 'Huanuco', 'Pachitea', 'Chaglla');
INSERT INTO ubigeo VALUES (933, '090704', 'Huanuco', 'Pachitea', 'Molino');
INSERT INTO ubigeo VALUES (934, '090706', 'Huanuco', 'Pachitea', 'Umari');
INSERT INTO ubigeo VALUES (935, '090801', 'Huanuco', 'Puerto Inca', 'Honoria');
INSERT INTO ubigeo VALUES (936, '090802', 'Huanuco', 'Puerto Inca', 'Puerto Inca');
INSERT INTO ubigeo VALUES (937, '090803', 'Huanuco', 'Puerto Inca', 'Codo del Pozuzo');
INSERT INTO ubigeo VALUES (938, '090804', 'Huanuco', 'Puerto Inca', 'Tournavista');
INSERT INTO ubigeo VALUES (939, '090805', 'Huanuco', 'Puerto Inca', 'Yuyapichis');
INSERT INTO ubigeo VALUES (940, '090901', 'Huanuco', 'Huacaybamba', 'Huacaybamba');
INSERT INTO ubigeo VALUES (941, '090902', 'Huanuco', 'Huacaybamba', 'Pinra');
INSERT INTO ubigeo VALUES (942, '090903', 'Huanuco', 'Huacaybamba', 'Canchabamba');
INSERT INTO ubigeo VALUES (943, '090904', 'Huanuco', 'Huacaybamba', 'Cochabamba');
INSERT INTO ubigeo VALUES (944, '091001', 'Huanuco', 'Lauricocha', 'Jesus');
INSERT INTO ubigeo VALUES (945, '091002', 'Huanuco', 'Lauricocha', 'Baños');
INSERT INTO ubigeo VALUES (946, '091003', 'Huanuco', 'Lauricocha', 'San Francisco de Asis');
INSERT INTO ubigeo VALUES (947, '091004', 'Huanuco', 'Lauricocha', 'Queropalca');
INSERT INTO ubigeo VALUES (948, '091005', 'Huanuco', 'Lauricocha', 'San Miguel de Cauri');
INSERT INTO ubigeo VALUES (949, '091006', 'Huanuco', 'Lauricocha', 'Rondos');
INSERT INTO ubigeo VALUES (950, '091007', 'Huanuco', 'Lauricocha', 'Jivia');
INSERT INTO ubigeo VALUES (951, '091101', 'Huanuco', 'Yarowilca', 'Chavinillo');
INSERT INTO ubigeo VALUES (952, '091102', 'Huanuco', 'Yarowilca', 'Aparicio Pomares');
INSERT INTO ubigeo VALUES (953, '091103', 'Huanuco', 'Yarowilca', 'Cahuac');
INSERT INTO ubigeo VALUES (954, '091104', 'Huanuco', 'Yarowilca', 'Chacabamba');
INSERT INTO ubigeo VALUES (955, '091105', 'Huanuco', 'Yarowilca', 'Jacas Chico');
INSERT INTO ubigeo VALUES (956, '091106', 'Huanuco', 'Yarowilca', 'Obas');
INSERT INTO ubigeo VALUES (957, '091107', 'Huanuco', 'Yarowilca', 'Pampamarca');
INSERT INTO ubigeo VALUES (958, '091108', 'Huanuco', 'Yarowilca', 'Choras');
INSERT INTO ubigeo VALUES (959, '100101', 'Ica', 'Ica', 'Ica');
INSERT INTO ubigeo VALUES (960, '100102', 'Ica', 'Ica', 'La Tinguiña');
INSERT INTO ubigeo VALUES (961, '100103', 'Ica', 'Ica', 'Los Aquijes');
INSERT INTO ubigeo VALUES (962, '100104', 'Ica', 'Ica', 'Parcona');
INSERT INTO ubigeo VALUES (963, '100105', 'Ica', 'Ica', 'Pueblo Nuevo');
INSERT INTO ubigeo VALUES (964, '100106', 'Ica', 'Ica', 'Salas');
INSERT INTO ubigeo VALUES (965, '100107', 'Ica', 'Ica', 'San Jose de los Molinos');
INSERT INTO ubigeo VALUES (966, '100108', 'Ica', 'Ica', 'San Juan Bautista');
INSERT INTO ubigeo VALUES (967, '100109', 'Ica', 'Ica', 'Santiago');
INSERT INTO ubigeo VALUES (968, '100110', 'Ica', 'Ica', 'Subtanjalla');
INSERT INTO ubigeo VALUES (969, '100111', 'Ica', 'Ica', 'Yauca del Rosario');
INSERT INTO ubigeo VALUES (970, '100112', 'Ica', 'Ica', 'Tate');
INSERT INTO ubigeo VALUES (971, '100113', 'Ica', 'Ica', 'Pachacutec');
INSERT INTO ubigeo VALUES (972, '100114', 'Ica', 'Ica', 'Ocucaje');
INSERT INTO ubigeo VALUES (973, '100201', 'Ica', 'Chincha', 'Chincha Alta');
INSERT INTO ubigeo VALUES (974, '100202', 'Ica', 'Chincha', 'Chavin');
INSERT INTO ubigeo VALUES (975, '100203', 'Ica', 'Chincha', 'Chincha Baja');
INSERT INTO ubigeo VALUES (976, '100204', 'Ica', 'Chincha', 'El Carmen');
INSERT INTO ubigeo VALUES (977, '100205', 'Ica', 'Chincha', 'Grocio Prado');
INSERT INTO ubigeo VALUES (978, '100206', 'Ica', 'Chincha', 'San Pedro de Huacarpana');
INSERT INTO ubigeo VALUES (979, '100207', 'Ica', 'Chincha', 'Sunampe');
INSERT INTO ubigeo VALUES (980, '100208', 'Ica', 'Chincha', 'Tambo de Mora');
INSERT INTO ubigeo VALUES (981, '100209', 'Ica', 'Chincha', 'Alto Laran');
INSERT INTO ubigeo VALUES (982, '100210', 'Ica', 'Chincha', 'Pueblo Nuevo');
INSERT INTO ubigeo VALUES (983, '100211', 'Ica', 'Chincha', 'San Juan de Yanac');
INSERT INTO ubigeo VALUES (984, '100301', 'Ica', 'Nazca', 'Nazca');
INSERT INTO ubigeo VALUES (985, '100302', 'Ica', 'Nazca', 'Changuillo');
INSERT INTO ubigeo VALUES (986, '100303', 'Ica', 'Nazca', 'El Ingenio');
INSERT INTO ubigeo VALUES (987, '100304', 'Ica', 'Nazca', 'Marcona');
INSERT INTO ubigeo VALUES (988, '100305', 'Ica', 'Nazca', 'Vista Alegre');
INSERT INTO ubigeo VALUES (989, '100401', 'Ica', 'Pisco', 'Pisco');
INSERT INTO ubigeo VALUES (990, '100402', 'Ica', 'Pisco', 'Huancano');
INSERT INTO ubigeo VALUES (991, '100403', 'Ica', 'Pisco', 'Humay');
INSERT INTO ubigeo VALUES (992, '100404', 'Ica', 'Pisco', 'Independencia');
INSERT INTO ubigeo VALUES (993, '100405', 'Ica', 'Pisco', 'Paracas');
INSERT INTO ubigeo VALUES (994, '100406', 'Ica', 'Pisco', 'San Andres');
INSERT INTO ubigeo VALUES (995, '100407', 'Ica', 'Pisco', 'San Clemente');
INSERT INTO ubigeo VALUES (996, '100408', 'Ica', 'Pisco', 'Tupac Amaru Inca');
INSERT INTO ubigeo VALUES (997, '100501', 'Ica', 'Palpa', 'Palpa');
INSERT INTO ubigeo VALUES (998, '100502', 'Ica', 'Palpa', 'Llipata');
INSERT INTO ubigeo VALUES (999, '100503', 'Ica', 'Palpa', 'Rio Grande');
INSERT INTO ubigeo VALUES (1000, '100504', 'Ica', 'Palpa', 'Santa Cruz');
INSERT INTO ubigeo VALUES (1001, '100505', 'Ica', 'Palpa', 'Tibillo');
INSERT INTO ubigeo VALUES (1002, '110101', 'Junin', 'Huancayo', 'Huancayo');
INSERT INTO ubigeo VALUES (1003, '110103', 'Junin', 'Huancayo', 'Carhuacallanga');
INSERT INTO ubigeo VALUES (1004, '110104', 'Junin', 'Huancayo', 'Colca');
INSERT INTO ubigeo VALUES (1005, '110105', 'Junin', 'Huancayo', 'Cullhuas');
INSERT INTO ubigeo VALUES (1006, '110106', 'Junin', 'Huancayo', 'Chacapampa');
INSERT INTO ubigeo VALUES (1007, '110107', 'Junin', 'Huancayo', 'Chicche');
INSERT INTO ubigeo VALUES (1008, '110108', 'Junin', 'Huancayo', 'Chilca');
INSERT INTO ubigeo VALUES (1009, '110109', 'Junin', 'Huancayo', 'Chongos Alto');
INSERT INTO ubigeo VALUES (1010, '110112', 'Junin', 'Huancayo', 'Chupuro');
INSERT INTO ubigeo VALUES (1011, '110113', 'Junin', 'Huancayo', 'El Tambo');
INSERT INTO ubigeo VALUES (1012, '110114', 'Junin', 'Huancayo', 'Huacrapuquio');
INSERT INTO ubigeo VALUES (1013, '110116', 'Junin', 'Huancayo', 'Hualhuas');
INSERT INTO ubigeo VALUES (1014, '110118', 'Junin', 'Huancayo', 'Huancan');
INSERT INTO ubigeo VALUES (1015, '110119', 'Junin', 'Huancayo', 'Huasicancha');
INSERT INTO ubigeo VALUES (1016, '110120', 'Junin', 'Huancayo', 'Huayucachi');
INSERT INTO ubigeo VALUES (1017, '110121', 'Junin', 'Huancayo', 'Ingenio');
INSERT INTO ubigeo VALUES (1018, '110122', 'Junin', 'Huancayo', 'Pariahuanca');
INSERT INTO ubigeo VALUES (1019, '110123', 'Junin', 'Huancayo', 'Pilcomayo');
INSERT INTO ubigeo VALUES (1020, '110124', 'Junin', 'Huancayo', 'Pucara');
INSERT INTO ubigeo VALUES (1021, '110125', 'Junin', 'Huancayo', 'Quichuay');
INSERT INTO ubigeo VALUES (1022, '110126', 'Junin', 'Huancayo', 'Quilcas');
INSERT INTO ubigeo VALUES (1023, '110127', 'Junin', 'Huancayo', 'San Agustin');
INSERT INTO ubigeo VALUES (1024, '110128', 'Junin', 'Huancayo', 'San Jeronimo de Tunan');
INSERT INTO ubigeo VALUES (1025, '110131', 'Junin', 'Huancayo', 'Santo Domingo de Acobamba');
INSERT INTO ubigeo VALUES (1026, '110132', 'Junin', 'Huancayo', 'Saño');
INSERT INTO ubigeo VALUES (1027, '110133', 'Junin', 'Huancayo', 'Sapallanga');
INSERT INTO ubigeo VALUES (1028, '110134', 'Junin', 'Huancayo', 'Sicaya');
INSERT INTO ubigeo VALUES (1029, '110136', 'Junin', 'Huancayo', 'Viques');
INSERT INTO ubigeo VALUES (1030, '110201', 'Junin', 'Concepcion', 'Concepcion');
INSERT INTO ubigeo VALUES (1031, '110202', 'Junin', 'Concepcion', 'Aco');
INSERT INTO ubigeo VALUES (1032, '110203', 'Junin', 'Concepcion', 'Andamarca');
INSERT INTO ubigeo VALUES (1033, '110204', 'Junin', 'Concepcion', 'Comas');
INSERT INTO ubigeo VALUES (1034, '110205', 'Junin', 'Concepcion', 'Cochas');
INSERT INTO ubigeo VALUES (1035, '110206', 'Junin', 'Concepcion', 'Chambara');
INSERT INTO ubigeo VALUES (1036, '110207', 'Junin', 'Concepcion', 'Heroinas Toledo');
INSERT INTO ubigeo VALUES (1037, '110208', 'Junin', 'Concepcion', 'Manzanares');
INSERT INTO ubigeo VALUES (1038, '110209', 'Junin', 'Concepcion', 'Mariscal Castilla');
INSERT INTO ubigeo VALUES (1039, '110210', 'Junin', 'Concepcion', 'Matahuasi');
INSERT INTO ubigeo VALUES (1040, '110211', 'Junin', 'Concepcion', 'Mito');
INSERT INTO ubigeo VALUES (1041, '110212', 'Junin', 'Concepcion', 'Nueve de Julio');
INSERT INTO ubigeo VALUES (1042, '110213', 'Junin', 'Concepcion', 'Orcotuna');
INSERT INTO ubigeo VALUES (1043, '110214', 'Junin', 'Concepcion', 'Santa Rosa de Ocopa');
INSERT INTO ubigeo VALUES (1044, '110215', 'Junin', 'Concepcion', 'San Jose de Quero');
INSERT INTO ubigeo VALUES (1045, '110301', 'Junin', 'Jauja', 'Jauja');
INSERT INTO ubigeo VALUES (1046, '110302', 'Junin', 'Jauja', 'Acolla');
INSERT INTO ubigeo VALUES (1047, '110303', 'Junin', 'Jauja', 'Apata');
INSERT INTO ubigeo VALUES (1048, '110304', 'Junin', 'Jauja', 'Ataura');
INSERT INTO ubigeo VALUES (1049, '110305', 'Junin', 'Jauja', 'Canchayllo');
INSERT INTO ubigeo VALUES (1050, '110306', 'Junin', 'Jauja', 'El Mantaro');
INSERT INTO ubigeo VALUES (1051, '110307', 'Junin', 'Jauja', 'Huamali');
INSERT INTO ubigeo VALUES (1052, '110308', 'Junin', 'Jauja', 'Huaripampa');
INSERT INTO ubigeo VALUES (1053, '110309', 'Junin', 'Jauja', 'Huertas');
INSERT INTO ubigeo VALUES (1054, '110310', 'Junin', 'Jauja', 'Janjaillo');
INSERT INTO ubigeo VALUES (1055, '110311', 'Junin', 'Jauja', 'Julcan');
INSERT INTO ubigeo VALUES (1056, '110312', 'Junin', 'Jauja', 'Leonor Ordoñez');
INSERT INTO ubigeo VALUES (1057, '110313', 'Junin', 'Jauja', 'Llocllapampa');
INSERT INTO ubigeo VALUES (1058, '110314', 'Junin', 'Jauja', 'Marco');
INSERT INTO ubigeo VALUES (1059, '110315', 'Junin', 'Jauja', 'Masma');
INSERT INTO ubigeo VALUES (1060, '110316', 'Junin', 'Jauja', 'Molinos');
INSERT INTO ubigeo VALUES (1061, '110317', 'Junin', 'Jauja', 'Monobamba');
INSERT INTO ubigeo VALUES (1062, '110318', 'Junin', 'Jauja', 'Muqui');
INSERT INTO ubigeo VALUES (1063, '110319', 'Junin', 'Jauja', 'Muquiyauyo');
INSERT INTO ubigeo VALUES (1064, '110320', 'Junin', 'Jauja', 'Paca');
INSERT INTO ubigeo VALUES (1065, '110321', 'Junin', 'Jauja', 'Paccha');
INSERT INTO ubigeo VALUES (1066, '110322', 'Junin', 'Jauja', 'Pancan');
INSERT INTO ubigeo VALUES (1067, '110323', 'Junin', 'Jauja', 'Parco');
INSERT INTO ubigeo VALUES (1068, '110324', 'Junin', 'Jauja', 'Pomacancha');
INSERT INTO ubigeo VALUES (1069, '110325', 'Junin', 'Jauja', 'Ricran');
INSERT INTO ubigeo VALUES (1070, '110326', 'Junin', 'Jauja', 'San Lorenzo');
INSERT INTO ubigeo VALUES (1071, '110327', 'Junin', 'Jauja', 'San Pedro de Chunan');
INSERT INTO ubigeo VALUES (1072, '110328', 'Junin', 'Jauja', 'Sincos');
INSERT INTO ubigeo VALUES (1073, '110329', 'Junin', 'Jauja', 'Tunan Marca');
INSERT INTO ubigeo VALUES (1074, '110330', 'Junin', 'Jauja', 'Yauli');
INSERT INTO ubigeo VALUES (1075, '110331', 'Junin', 'Jauja', 'Curicaca');
INSERT INTO ubigeo VALUES (1076, '110332', 'Junin', 'Jauja', 'Masma Chicche');
INSERT INTO ubigeo VALUES (1077, '110333', 'Junin', 'Jauja', 'Sausa');
INSERT INTO ubigeo VALUES (1078, '110334', 'Junin', 'Jauja', 'Yauyos');
INSERT INTO ubigeo VALUES (1079, '110401', 'Junin', 'Junin', 'Junin');
INSERT INTO ubigeo VALUES (1080, '110402', 'Junin', 'Junin', 'Carhuamayo');
INSERT INTO ubigeo VALUES (1081, '110403', 'Junin', 'Junin', 'Ondores');
INSERT INTO ubigeo VALUES (1082, '110404', 'Junin', 'Junin', 'Ulcumayo');
INSERT INTO ubigeo VALUES (1083, '110501', 'Junin', 'Tarma', 'Tarma');
INSERT INTO ubigeo VALUES (1084, '110502', 'Junin', 'Tarma', 'Acobamba');
INSERT INTO ubigeo VALUES (1085, '110503', 'Junin', 'Tarma', 'Huaricolca');
INSERT INTO ubigeo VALUES (1086, '110504', 'Junin', 'Tarma', 'Huasahuasi');
INSERT INTO ubigeo VALUES (1087, '110505', 'Junin', 'Tarma', 'La Union');
INSERT INTO ubigeo VALUES (1088, '110506', 'Junin', 'Tarma', 'Palca');
INSERT INTO ubigeo VALUES (1089, '110507', 'Junin', 'Tarma', 'Palcamayo');
INSERT INTO ubigeo VALUES (1090, '110508', 'Junin', 'Tarma', 'San Pedro de Cajas');
INSERT INTO ubigeo VALUES (1091, '110509', 'Junin', 'Tarma', 'Tapo');
INSERT INTO ubigeo VALUES (1092, '110601', 'Junin', 'Yauli', 'La Oroya');
INSERT INTO ubigeo VALUES (1093, '110602', 'Junin', 'Yauli', 'Chacapalpa');
INSERT INTO ubigeo VALUES (1094, '110603', 'Junin', 'Yauli', 'Huay-Huay');
INSERT INTO ubigeo VALUES (1095, '110604', 'Junin', 'Yauli', 'Marcapomacocha');
INSERT INTO ubigeo VALUES (1096, '110605', 'Junin', 'Yauli', 'Morococha');
INSERT INTO ubigeo VALUES (1097, '110606', 'Junin', 'Yauli', 'Paccha');
INSERT INTO ubigeo VALUES (1098, '110607', 'Junin', 'Yauli', 'Santa Barbara de Carhuacayan');
INSERT INTO ubigeo VALUES (1099, '110608', 'Junin', 'Yauli', 'Suitucancha');
INSERT INTO ubigeo VALUES (1100, '110609', 'Junin', 'Yauli', 'Yauli');
INSERT INTO ubigeo VALUES (1101, '110610', 'Junin', 'Yauli', 'Santa Rosa de Sacco');
INSERT INTO ubigeo VALUES (1102, '110701', 'Junin', 'Satipo', 'Satipo');
INSERT INTO ubigeo VALUES (1103, '110702', 'Junin', 'Satipo', 'Coviriali');
INSERT INTO ubigeo VALUES (1104, '110703', 'Junin', 'Satipo', 'Llaylla');
INSERT INTO ubigeo VALUES (1105, '110704', 'Junin', 'Satipo', 'Mazamari');
INSERT INTO ubigeo VALUES (1106, '110705', 'Junin', 'Satipo', 'Pampa Hermosa');
INSERT INTO ubigeo VALUES (1107, '110706', 'Junin', 'Satipo', 'Pangoa');
INSERT INTO ubigeo VALUES (1108, '110707', 'Junin', 'Satipo', 'Rio Negro');
INSERT INTO ubigeo VALUES (1109, '110708', 'Junin', 'Satipo', 'Rio Tambo');
INSERT INTO ubigeo VALUES (1110, '110801', 'Junin', 'Chanchamayo', 'Chanchamayo');
INSERT INTO ubigeo VALUES (1111, '110802', 'Junin', 'Chanchamayo', 'San Ramon');
INSERT INTO ubigeo VALUES (1112, '110803', 'Junin', 'Chanchamayo', 'Vitoc');
INSERT INTO ubigeo VALUES (1113, '110804', 'Junin', 'Chanchamayo', 'San Luis de Shuaro');
INSERT INTO ubigeo VALUES (1114, '110805', 'Junin', 'Chanchamayo', 'Pichanaqui');
INSERT INTO ubigeo VALUES (1115, '110806', 'Junin', 'Chanchamayo', 'Perene');
INSERT INTO ubigeo VALUES (1116, '110901', 'Junin', 'Chupaca', 'Chupaca');
INSERT INTO ubigeo VALUES (1117, '110902', 'Junin', 'Chupaca', 'Ahuac');
INSERT INTO ubigeo VALUES (1118, '110903', 'Junin', 'Chupaca', 'Chongos Bajo');
INSERT INTO ubigeo VALUES (1119, '110904', 'Junin', 'Chupaca', 'Huachac');
INSERT INTO ubigeo VALUES (1120, '110905', 'Junin', 'Chupaca', 'Huamancaca Chico');
INSERT INTO ubigeo VALUES (1121, '110906', 'Junin', 'Chupaca', 'San Juan de Yscos');
INSERT INTO ubigeo VALUES (1122, '110907', 'Junin', 'Chupaca', 'San Juan de Jarpa');
INSERT INTO ubigeo VALUES (1123, '110908', 'Junin', 'Chupaca', 'Tres de Diciembre');
INSERT INTO ubigeo VALUES (1124, '110909', 'Junin', 'Chupaca', 'Yanacancha');
INSERT INTO ubigeo VALUES (1125, '120101', 'La Libertad', 'Trujillo', 'Trujillo');
INSERT INTO ubigeo VALUES (1126, '120102', 'La Libertad', 'Trujillo', 'Huanchaco');
INSERT INTO ubigeo VALUES (1127, '120103', 'La Libertad', 'Trujillo', 'Laredo');
INSERT INTO ubigeo VALUES (1128, '120104', 'La Libertad', 'Trujillo', 'Moche');
INSERT INTO ubigeo VALUES (1129, '120105', 'La Libertad', 'Trujillo', 'Salaverry');
INSERT INTO ubigeo VALUES (1130, '120106', 'La Libertad', 'Trujillo', 'Simbal');
INSERT INTO ubigeo VALUES (1131, '120107', 'La Libertad', 'Trujillo', 'Victor Larco Herrera');
INSERT INTO ubigeo VALUES (1132, '120109', 'La Libertad', 'Trujillo', 'Poroto');
INSERT INTO ubigeo VALUES (1133, '120110', 'La Libertad', 'Trujillo', 'El Porvenir');
INSERT INTO ubigeo VALUES (1134, '120111', 'La Libertad', 'Trujillo', 'La Esperanza');
INSERT INTO ubigeo VALUES (1135, '120112', 'La Libertad', 'Trujillo', 'Florencia de Mora');
INSERT INTO ubigeo VALUES (1136, '120201', 'La Libertad', 'Bolivar', 'Bolivar');
INSERT INTO ubigeo VALUES (1137, '120202', 'La Libertad', 'Bolivar', 'Bambamarca');
INSERT INTO ubigeo VALUES (1138, '120203', 'La Libertad', 'Bolivar', 'Condormarca');
INSERT INTO ubigeo VALUES (1139, '120204', 'La Libertad', 'Bolivar', 'Longotea');
INSERT INTO ubigeo VALUES (1140, '120205', 'La Libertad', 'Bolivar', 'Ucuncha');
INSERT INTO ubigeo VALUES (1141, '120206', 'La Libertad', 'Bolivar', 'Uchumarca');
INSERT INTO ubigeo VALUES (1142, '120301', 'La Libertad', 'Sanchez Carrion', 'Huamachuco');
INSERT INTO ubigeo VALUES (1143, '120302', 'La Libertad', 'Sanchez Carrion', 'Cochorco');
INSERT INTO ubigeo VALUES (1144, '120303', 'La Libertad', 'Sanchez Carrion', 'Curgos');
INSERT INTO ubigeo VALUES (1145, '120304', 'La Libertad', 'Sanchez Carrion', 'Chugay');
INSERT INTO ubigeo VALUES (1146, '120305', 'La Libertad', 'Sanchez Carrion', 'Marcabal');
INSERT INTO ubigeo VALUES (1147, '120306', 'La Libertad', 'Sanchez Carrion', 'Sanagoran');
INSERT INTO ubigeo VALUES (1148, '120307', 'La Libertad', 'Sanchez Carrion', 'Sarin');
INSERT INTO ubigeo VALUES (1149, '120308', 'La Libertad', 'Sanchez Carrion', 'Sartimbamba');
INSERT INTO ubigeo VALUES (1150, '120401', 'La Libertad', 'Otuzco', 'Otuzco');
INSERT INTO ubigeo VALUES (1151, '120402', 'La Libertad', 'Otuzco', 'Agallpampa');
INSERT INTO ubigeo VALUES (1152, '120403', 'La Libertad', 'Otuzco', 'Charat');
INSERT INTO ubigeo VALUES (1153, '120404', 'La Libertad', 'Otuzco', 'Huaranchal');
INSERT INTO ubigeo VALUES (1154, '120405', 'La Libertad', 'Otuzco', 'La Cuesta');
INSERT INTO ubigeo VALUES (1155, '120408', 'La Libertad', 'Otuzco', 'Paranday');
INSERT INTO ubigeo VALUES (1156, '120409', 'La Libertad', 'Otuzco', 'Salpo');
INSERT INTO ubigeo VALUES (1157, '120410', 'La Libertad', 'Otuzco', 'Sinsicap');
INSERT INTO ubigeo VALUES (1158, '120411', 'La Libertad', 'Otuzco', 'Usquil');
INSERT INTO ubigeo VALUES (1159, '120413', 'La Libertad', 'Otuzco', 'Mache');
INSERT INTO ubigeo VALUES (1160, '120501', 'La Libertad', 'Pacasmayo', 'San Pedro de Lloc');
INSERT INTO ubigeo VALUES (1161, '120503', 'La Libertad', 'Pacasmayo', 'Guadalupe');
INSERT INTO ubigeo VALUES (1162, '120504', 'La Libertad', 'Pacasmayo', 'Jequetepeque');
INSERT INTO ubigeo VALUES (1163, '120506', 'La Libertad', 'Pacasmayo', 'Pacasmayo');
INSERT INTO ubigeo VALUES (1164, '120508', 'La Libertad', 'Pacasmayo', 'San Jose');
INSERT INTO ubigeo VALUES (1165, '120601', 'La Libertad', 'Pataz', 'Tayabamba');
INSERT INTO ubigeo VALUES (1166, '120602', 'La Libertad', 'Pataz', 'Buldibuyo');
INSERT INTO ubigeo VALUES (1167, '120603', 'La Libertad', 'Pataz', 'Chillia');
INSERT INTO ubigeo VALUES (1168, '120604', 'La Libertad', 'Pataz', 'Huaylillas');
INSERT INTO ubigeo VALUES (1169, '120605', 'La Libertad', 'Pataz', 'Huancaspata');
INSERT INTO ubigeo VALUES (1170, '120606', 'La Libertad', 'Pataz', 'Huayo');
INSERT INTO ubigeo VALUES (1171, '120607', 'La Libertad', 'Pataz', 'Ongon');
INSERT INTO ubigeo VALUES (1172, '120608', 'La Libertad', 'Pataz', 'Parcoy');
INSERT INTO ubigeo VALUES (1173, '120609', 'La Libertad', 'Pataz', 'Pataz');
INSERT INTO ubigeo VALUES (1174, '120610', 'La Libertad', 'Pataz', 'Pias');
INSERT INTO ubigeo VALUES (1175, '120611', 'La Libertad', 'Pataz', 'Taurija');
INSERT INTO ubigeo VALUES (1176, '120612', 'La Libertad', 'Pataz', 'Urpay');
INSERT INTO ubigeo VALUES (1177, '120613', 'La Libertad', 'Pataz', 'Santiago de Challas');
INSERT INTO ubigeo VALUES (1178, '120701', 'La Libertad', 'Santiago de Chuco', 'Santiago de Chuco');
INSERT INTO ubigeo VALUES (1179, '120702', 'La Libertad', 'Santiago de Chuco', 'Cachicadan');
INSERT INTO ubigeo VALUES (1180, '120703', 'La Libertad', 'Santiago de Chuco', 'Mollebamba');
INSERT INTO ubigeo VALUES (1181, '120704', 'La Libertad', 'Santiago de Chuco', 'Mollepata');
INSERT INTO ubigeo VALUES (1182, '120705', 'La Libertad', 'Santiago de Chuco', 'Quiruvilca');
INSERT INTO ubigeo VALUES (1183, '120706', 'La Libertad', 'Santiago de Chuco', 'Santa Cruz de Chuca');
INSERT INTO ubigeo VALUES (1184, '120707', 'La Libertad', 'Santiago de Chuco', 'Sitabamba');
INSERT INTO ubigeo VALUES (1185, '120708', 'La Libertad', 'Santiago de Chuco', 'Angasmarca');
INSERT INTO ubigeo VALUES (1186, '120801', 'La Libertad', 'Ascope', 'Ascope');
INSERT INTO ubigeo VALUES (1187, '120802', 'La Libertad', 'Ascope', 'Chicama');
INSERT INTO ubigeo VALUES (1188, '120803', 'La Libertad', 'Ascope', 'Chocope');
INSERT INTO ubigeo VALUES (1189, '120804', 'La Libertad', 'Ascope', 'Santiago de Cao');
INSERT INTO ubigeo VALUES (1190, '120805', 'La Libertad', 'Ascope', 'Magdalena de Cao');
INSERT INTO ubigeo VALUES (1191, '120806', 'La Libertad', 'Ascope', 'Paijan');
INSERT INTO ubigeo VALUES (1192, '120807', 'La Libertad', 'Ascope', 'Razuri');
INSERT INTO ubigeo VALUES (1193, '120808', 'La Libertad', 'Ascope', 'Casa Grande');
INSERT INTO ubigeo VALUES (1194, '120901', 'La Libertad', 'Chepen', 'Chepen');
INSERT INTO ubigeo VALUES (1195, '120902', 'La Libertad', 'Chepen', 'Pacanga');
INSERT INTO ubigeo VALUES (1196, '120903', 'La Libertad', 'Chepen', 'Pueblo Nuevo');
INSERT INTO ubigeo VALUES (1197, '121001', 'La Libertad', 'Julcan', 'Julcan');
INSERT INTO ubigeo VALUES (1198, '121002', 'La Libertad', 'Julcan', 'Carabamba');
INSERT INTO ubigeo VALUES (1199, '121003', 'La Libertad', 'Julcan', 'Calamarca');
INSERT INTO ubigeo VALUES (1200, '121004', 'La Libertad', 'Julcan', 'Huaso');
INSERT INTO ubigeo VALUES (1201, '121101', 'La Libertad', 'Gran Chimu', 'Cascas');
INSERT INTO ubigeo VALUES (1202, '121102', 'La Libertad', 'Gran Chimu', 'Lucma');
INSERT INTO ubigeo VALUES (1203, '121103', 'La Libertad', 'Gran Chimu', 'Marmot');
INSERT INTO ubigeo VALUES (1204, '121104', 'La Libertad', 'Gran Chimu', 'Sayapullo');
INSERT INTO ubigeo VALUES (1205, '121201', 'La Libertad', 'Viru', 'Viru');
INSERT INTO ubigeo VALUES (1206, '121202', 'La Libertad', 'Viru', 'Chao');
INSERT INTO ubigeo VALUES (1207, '121203', 'La Libertad', 'Viru', 'Guadalupito');
INSERT INTO ubigeo VALUES (1208, '130101', 'Lambayeque', 'Chiclayo', 'Chiclayo');
INSERT INTO ubigeo VALUES (1209, '130102', 'Lambayeque', 'Chiclayo', 'Chongoyape');
INSERT INTO ubigeo VALUES (1210, '130103', 'Lambayeque', 'Chiclayo', 'Eten');
INSERT INTO ubigeo VALUES (1211, '130104', 'Lambayeque', 'Chiclayo', 'Eten Puerto');
INSERT INTO ubigeo VALUES (1212, '130105', 'Lambayeque', 'Chiclayo', 'Lagunas');
INSERT INTO ubigeo VALUES (1213, '130106', 'Lambayeque', 'Chiclayo', 'Monsefu');
INSERT INTO ubigeo VALUES (1214, '130107', 'Lambayeque', 'Chiclayo', 'Nueva Arica');
INSERT INTO ubigeo VALUES (1215, '130108', 'Lambayeque', 'Chiclayo', 'Oyotun');
INSERT INTO ubigeo VALUES (1216, '130109', 'Lambayeque', 'Chiclayo', 'Picsi');
INSERT INTO ubigeo VALUES (1217, '130110', 'Lambayeque', 'Chiclayo', 'Pimentel');
INSERT INTO ubigeo VALUES (1218, '130111', 'Lambayeque', 'Chiclayo', 'Reque');
INSERT INTO ubigeo VALUES (1219, '130112', 'Lambayeque', 'Chiclayo', 'Jose Leonardo Ortiz');
INSERT INTO ubigeo VALUES (1220, '130113', 'Lambayeque', 'Chiclayo', 'Santa Rosa');
INSERT INTO ubigeo VALUES (1221, '130114', 'Lambayeque', 'Chiclayo', 'Saña');
INSERT INTO ubigeo VALUES (1222, '130115', 'Lambayeque', 'Chiclayo', 'La Victoria');
INSERT INTO ubigeo VALUES (1223, '130116', 'Lambayeque', 'Chiclayo', 'Cayalti');
INSERT INTO ubigeo VALUES (1224, '130117', 'Lambayeque', 'Chiclayo', 'Patapo');
INSERT INTO ubigeo VALUES (1225, '130118', 'Lambayeque', 'Chiclayo', 'Pomalca');
INSERT INTO ubigeo VALUES (1226, '130119', 'Lambayeque', 'Chiclayo', 'Pucala');
INSERT INTO ubigeo VALUES (1227, '130120', 'Lambayeque', 'Chiclayo', 'Tuman');
INSERT INTO ubigeo VALUES (1228, '130201', 'Lambayeque', 'Ferreñafe', 'Ferreñafe');
INSERT INTO ubigeo VALUES (1229, '130202', 'Lambayeque', 'Ferreñafe', 'Incahuasi');
INSERT INTO ubigeo VALUES (1230, '130203', 'Lambayeque', 'Ferreñafe', 'Cañaris');
INSERT INTO ubigeo VALUES (1231, '130204', 'Lambayeque', 'Ferreñafe', 'Pitipo');
INSERT INTO ubigeo VALUES (1232, '130205', 'Lambayeque', 'Ferreñafe', 'Pueblo Nuevo');
INSERT INTO ubigeo VALUES (1233, '130206', 'Lambayeque', 'Ferreñafe', 'Manuel Antonio Mesones Muro');
INSERT INTO ubigeo VALUES (1234, '130301', 'Lambayeque', 'Lambayeque', 'Lambayeque');
INSERT INTO ubigeo VALUES (1235, '130302', 'Lambayeque', 'Lambayeque', 'Chochope');
INSERT INTO ubigeo VALUES (1236, '130303', 'Lambayeque', 'Lambayeque', 'Illimo');
INSERT INTO ubigeo VALUES (1237, '130304', 'Lambayeque', 'Lambayeque', 'Jayanca');
INSERT INTO ubigeo VALUES (1238, '130305', 'Lambayeque', 'Lambayeque', 'Mochumi');
INSERT INTO ubigeo VALUES (1239, '130306', 'Lambayeque', 'Lambayeque', 'Morrope');
INSERT INTO ubigeo VALUES (1240, '130307', 'Lambayeque', 'Lambayeque', 'Motupe');
INSERT INTO ubigeo VALUES (1241, '130308', 'Lambayeque', 'Lambayeque', 'Olmos');
INSERT INTO ubigeo VALUES (1242, '130309', 'Lambayeque', 'Lambayeque', 'Pacora');
INSERT INTO ubigeo VALUES (1243, '130310', 'Lambayeque', 'Lambayeque', 'Salas');
INSERT INTO ubigeo VALUES (1244, '130311', 'Lambayeque', 'Lambayeque', 'San Jose');
INSERT INTO ubigeo VALUES (1245, '130312', 'Lambayeque', 'Lambayeque', 'Tucume');
INSERT INTO ubigeo VALUES (1246, '140101', 'Lima', 'Lima', 'Lima');
INSERT INTO ubigeo VALUES (1247, '140102', 'Lima', 'Lima', 'Ancon');
INSERT INTO ubigeo VALUES (1248, '140103', 'Lima', 'Lima', 'Ate');
INSERT INTO ubigeo VALUES (1249, '140104', 'Lima', 'Lima', 'Breña');
INSERT INTO ubigeo VALUES (1250, '140105', 'Lima', 'Lima', 'Carabayllo');
INSERT INTO ubigeo VALUES (1251, '140106', 'Lima', 'Lima', 'Comas');
INSERT INTO ubigeo VALUES (1252, '140107', 'Lima', 'Lima', 'Chaclacayo');
INSERT INTO ubigeo VALUES (1253, '140108', 'Lima', 'Lima', 'Chorrillos');
INSERT INTO ubigeo VALUES (1254, '140109', 'Lima', 'Lima', 'La Victoria');
INSERT INTO ubigeo VALUES (1255, '140110', 'Lima', 'Lima', 'La Molina');
INSERT INTO ubigeo VALUES (1256, '140111', 'Lima', 'Lima', 'Lince');
INSERT INTO ubigeo VALUES (1257, '140112', 'Lima', 'Lima', 'Lurigancho');
INSERT INTO ubigeo VALUES (1258, '140113', 'Lima', 'Lima', 'Lurin');
INSERT INTO ubigeo VALUES (1259, '140114', 'Lima', 'Lima', 'Magdalena del Mar');
INSERT INTO ubigeo VALUES (1260, '140115', 'Lima', 'Lima', 'Miraflores');
INSERT INTO ubigeo VALUES (1261, '140116', 'Lima', 'Lima', 'Pachacamac');
INSERT INTO ubigeo VALUES (1262, '140117', 'Lima', 'Lima', 'Pueblo Libre');
INSERT INTO ubigeo VALUES (1263, '140118', 'Lima', 'Lima', 'Pucusana');
INSERT INTO ubigeo VALUES (1264, '140119', 'Lima', 'Lima', 'Puente Piedra');
INSERT INTO ubigeo VALUES (1265, '140120', 'Lima', 'Lima', 'Punta Hermosa');
INSERT INTO ubigeo VALUES (1266, '140121', 'Lima', 'Lima', 'Punta Negra');
INSERT INTO ubigeo VALUES (1267, '140122', 'Lima', 'Lima', 'Rimac');
INSERT INTO ubigeo VALUES (1268, '140123', 'Lima', 'Lima', 'San Bartolo');
INSERT INTO ubigeo VALUES (1269, '140124', 'Lima', 'Lima', 'San Isidro');
INSERT INTO ubigeo VALUES (1270, '140125', 'Lima', 'Lima', 'Barranco');
INSERT INTO ubigeo VALUES (1271, '140126', 'Lima', 'Lima', 'San Martin de Porres');
INSERT INTO ubigeo VALUES (1272, '140127', 'Lima', 'Lima', 'San Miguel');
INSERT INTO ubigeo VALUES (1273, '140128', 'Lima', 'Lima', 'Santa Maria del Mar');
INSERT INTO ubigeo VALUES (1274, '140129', 'Lima', 'Lima', 'Santa Rosa');
INSERT INTO ubigeo VALUES (1275, '140130', 'Lima', 'Lima', 'Santiago de Surco');
INSERT INTO ubigeo VALUES (1276, '140131', 'Lima', 'Lima', 'Surquillo');
INSERT INTO ubigeo VALUES (1277, '140132', 'Lima', 'Lima', 'Villa Maria del Triunfo');
INSERT INTO ubigeo VALUES (1278, '140133', 'Lima', 'Lima', 'Jesus Maria');
INSERT INTO ubigeo VALUES (1279, '140134', 'Lima', 'Lima', 'Independencia');
INSERT INTO ubigeo VALUES (1280, '140135', 'Lima', 'Lima', 'El Agustino');
INSERT INTO ubigeo VALUES (1281, '140136', 'Lima', 'Lima', 'San Juan de Miraflores');
INSERT INTO ubigeo VALUES (1282, '140137', 'Lima', 'Lima', 'San Juan de Lurigancho');
INSERT INTO ubigeo VALUES (1283, '140138', 'Lima', 'Lima', 'San Luis');
INSERT INTO ubigeo VALUES (1284, '140139', 'Lima', 'Lima', 'Cieneguilla');
INSERT INTO ubigeo VALUES (1285, '140140', 'Lima', 'Lima', 'San Borja');
INSERT INTO ubigeo VALUES (1286, '140141', 'Lima', 'Lima', 'Villa El Salvador');
INSERT INTO ubigeo VALUES (1287, '140142', 'Lima', 'Lima', 'Los Olivos');
INSERT INTO ubigeo VALUES (1288, '140143', 'Lima', 'Lima', 'Santa Anita');
INSERT INTO ubigeo VALUES (1289, '140201', 'Lima', 'Cajatambo', 'Cajatambo');
INSERT INTO ubigeo VALUES (1290, '140205', 'Lima', 'Cajatambo', 'Copa');
INSERT INTO ubigeo VALUES (1291, '140206', 'Lima', 'Cajatambo', 'Gorgor');
INSERT INTO ubigeo VALUES (1292, '140207', 'Lima', 'Cajatambo', 'Huancapon');
INSERT INTO ubigeo VALUES (1293, '140208', 'Lima', 'Cajatambo', 'Manas');
INSERT INTO ubigeo VALUES (1294, '140301', 'Lima', 'Canta', 'Canta');
INSERT INTO ubigeo VALUES (1295, '140302', 'Lima', 'Canta', 'Arahuay');
INSERT INTO ubigeo VALUES (1296, '140303', 'Lima', 'Canta', 'Huamantanga');
INSERT INTO ubigeo VALUES (1297, '140304', 'Lima', 'Canta', 'Huaros');
INSERT INTO ubigeo VALUES (1298, '140305', 'Lima', 'Canta', 'Lachaqui');
INSERT INTO ubigeo VALUES (1299, '140306', 'Lima', 'Canta', 'San Buenaventura');
INSERT INTO ubigeo VALUES (1300, '140307', 'Lima', 'Canta', 'Santa Rosa de Quives');
INSERT INTO ubigeo VALUES (1301, '140401', 'Lima', 'Cañete', 'San Vicente de Cañete');
INSERT INTO ubigeo VALUES (1302, '140402', 'Lima', 'Cañete', 'Calango');
INSERT INTO ubigeo VALUES (1303, '140403', 'Lima', 'Cañete', 'Cerro Azul');
INSERT INTO ubigeo VALUES (1304, '140404', 'Lima', 'Cañete', 'Coayllo');
INSERT INTO ubigeo VALUES (1305, '140405', 'Lima', 'Cañete', 'Chilca');
INSERT INTO ubigeo VALUES (1306, '140406', 'Lima', 'Cañete', 'Imperial');
INSERT INTO ubigeo VALUES (1307, '140407', 'Lima', 'Cañete', 'Lunahuana');
INSERT INTO ubigeo VALUES (1308, '140408', 'Lima', 'Cañete', 'Mala');
INSERT INTO ubigeo VALUES (1309, '140409', 'Lima', 'Cañete', 'Nuevo Imperial');
INSERT INTO ubigeo VALUES (1310, '140410', 'Lima', 'Cañete', 'Pacaran');
INSERT INTO ubigeo VALUES (1311, '140411', 'Lima', 'Cañete', 'Quilmana');
INSERT INTO ubigeo VALUES (1312, '140412', 'Lima', 'Cañete', 'San Antonio');
INSERT INTO ubigeo VALUES (1313, '140413', 'Lima', 'Cañete', 'San Luis');
INSERT INTO ubigeo VALUES (1314, '140414', 'Lima', 'Cañete', 'Santa Cruz de Flores');
INSERT INTO ubigeo VALUES (1315, '140415', 'Lima', 'Cañete', 'Zuñiga');
INSERT INTO ubigeo VALUES (1316, '140416', 'Lima', 'Cañete', 'Asia');
INSERT INTO ubigeo VALUES (1317, '140501', 'Lima', 'Huaura', 'Huacho');
INSERT INTO ubigeo VALUES (1318, '140502', 'Lima', 'Huaura', 'Ambar');
INSERT INTO ubigeo VALUES (1319, '140504', 'Lima', 'Huaura', 'Caleta de Carquin');
INSERT INTO ubigeo VALUES (1320, '140505', 'Lima', 'Huaura', 'Checras');
INSERT INTO ubigeo VALUES (1321, '140506', 'Lima', 'Huaura', 'Hualmay');
INSERT INTO ubigeo VALUES (1322, '140507', 'Lima', 'Huaura', 'Huaura');
INSERT INTO ubigeo VALUES (1323, '140508', 'Lima', 'Huaura', 'Leoncio Prado');
INSERT INTO ubigeo VALUES (1324, '140509', 'Lima', 'Huaura', 'Paccho');
INSERT INTO ubigeo VALUES (1325, '140511', 'Lima', 'Huaura', 'Santa Leonor');
INSERT INTO ubigeo VALUES (1326, '140512', 'Lima', 'Huaura', 'Santa Maria');
INSERT INTO ubigeo VALUES (1327, '140513', 'Lima', 'Huaura', 'Sayan');
INSERT INTO ubigeo VALUES (1328, '140516', 'Lima', 'Huaura', 'Vegueta');
INSERT INTO ubigeo VALUES (1329, '140601', 'Lima', 'Huarochiri', 'Matucana');
INSERT INTO ubigeo VALUES (1330, '140602', 'Lima', 'Huarochiri', 'Antioquia');
INSERT INTO ubigeo VALUES (1331, '140603', 'Lima', 'Huarochiri', 'Callahuanca');
INSERT INTO ubigeo VALUES (1332, '140604', 'Lima', 'Huarochiri', 'Carampoma');
INSERT INTO ubigeo VALUES (1333, '140605', 'Lima', 'Huarochiri', 'San Pedro de Casta');
INSERT INTO ubigeo VALUES (1334, '140606', 'Lima', 'Huarochiri', 'Cuenca');
INSERT INTO ubigeo VALUES (1335, '140607', 'Lima', 'Huarochiri', 'Chicla');
INSERT INTO ubigeo VALUES (1336, '140608', 'Lima', 'Huarochiri', 'Huanza');
INSERT INTO ubigeo VALUES (1337, '140609', 'Lima', 'Huarochiri', 'Huarochiri');
INSERT INTO ubigeo VALUES (1338, '140610', 'Lima', 'Huarochiri', 'Lahuaytambo');
INSERT INTO ubigeo VALUES (1339, '140611', 'Lima', 'Huarochiri', 'Langa');
INSERT INTO ubigeo VALUES (1340, '140612', 'Lima', 'Huarochiri', 'Mariatana');
INSERT INTO ubigeo VALUES (1341, '140613', 'Lima', 'Huarochiri', 'Ricardo Palma');
INSERT INTO ubigeo VALUES (1342, '140614', 'Lima', 'Huarochiri', 'San Andres de Tupicocha');
INSERT INTO ubigeo VALUES (1343, '140615', 'Lima', 'Huarochiri', 'San Antonio');
INSERT INTO ubigeo VALUES (1344, '140616', 'Lima', 'Huarochiri', 'San Bartolome');
INSERT INTO ubigeo VALUES (1345, '140617', 'Lima', 'Huarochiri', 'San Damian');
INSERT INTO ubigeo VALUES (1346, '140618', 'Lima', 'Huarochiri', 'Sangallaya');
INSERT INTO ubigeo VALUES (1347, '140619', 'Lima', 'Huarochiri', 'San Juan de Tantaranche');
INSERT INTO ubigeo VALUES (1348, '140620', 'Lima', 'Huarochiri', 'San Lorenzo de Quinti');
INSERT INTO ubigeo VALUES (1349, '140621', 'Lima', 'Huarochiri', 'San Mateo');
INSERT INTO ubigeo VALUES (1350, '140622', 'Lima', 'Huarochiri', 'San Mateo de Otao');
INSERT INTO ubigeo VALUES (1351, '140623', 'Lima', 'Huarochiri', 'San Pedro de Huancayre');
INSERT INTO ubigeo VALUES (1352, '140624', 'Lima', 'Huarochiri', 'Santa Cruz de Cocachacra');
INSERT INTO ubigeo VALUES (1353, '140625', 'Lima', 'Huarochiri', 'Santa Eulalia');
INSERT INTO ubigeo VALUES (1354, '140626', 'Lima', 'Huarochiri', 'Santiago de Anchucaya');
INSERT INTO ubigeo VALUES (1355, '140627', 'Lima', 'Huarochiri', 'Santiago de Tuna');
INSERT INTO ubigeo VALUES (1356, '140628', 'Lima', 'Huarochiri', 'Santo Domingo de los Olleros');
INSERT INTO ubigeo VALUES (1357, '140629', 'Lima', 'Huarochiri', 'Surco');
INSERT INTO ubigeo VALUES (1358, '140630', 'Lima', 'Huarochiri', 'Huachupampa');
INSERT INTO ubigeo VALUES (1359, '140631', 'Lima', 'Huarochiri', 'Laraos');
INSERT INTO ubigeo VALUES (1360, '140632', 'Lima', 'Huarochiri', 'San Juan de Iris');
INSERT INTO ubigeo VALUES (1361, '140701', 'Lima', 'Yauyos', 'Yauyos');
INSERT INTO ubigeo VALUES (1362, '140702', 'Lima', 'Yauyos', 'Alis');
INSERT INTO ubigeo VALUES (1363, '140703', 'Lima', 'Yauyos', 'Ayauca');
INSERT INTO ubigeo VALUES (1364, '140704', 'Lima', 'Yauyos', 'Ayaviri');
INSERT INTO ubigeo VALUES (1365, '140705', 'Lima', 'Yauyos', 'Azangaro');
INSERT INTO ubigeo VALUES (1366, '140706', 'Lima', 'Yauyos', 'Cacra');
INSERT INTO ubigeo VALUES (1367, '140707', 'Lima', 'Yauyos', 'Carania');
INSERT INTO ubigeo VALUES (1368, '140708', 'Lima', 'Yauyos', 'Cochas');
INSERT INTO ubigeo VALUES (1369, '140709', 'Lima', 'Yauyos', 'Colonia');
INSERT INTO ubigeo VALUES (1370, '140710', 'Lima', 'Yauyos', 'Chocos');
INSERT INTO ubigeo VALUES (1371, '140711', 'Lima', 'Yauyos', 'Huampara');
INSERT INTO ubigeo VALUES (1372, '140712', 'Lima', 'Yauyos', 'Huancaya');
INSERT INTO ubigeo VALUES (1373, '140713', 'Lima', 'Yauyos', 'Huangascar');
INSERT INTO ubigeo VALUES (1374, '140714', 'Lima', 'Yauyos', 'Huantan');
INSERT INTO ubigeo VALUES (1375, '140715', 'Lima', 'Yauyos', 'Huañec');
INSERT INTO ubigeo VALUES (1376, '140716', 'Lima', 'Yauyos', 'Laraos');
INSERT INTO ubigeo VALUES (1377, '140717', 'Lima', 'Yauyos', 'Lincha');
INSERT INTO ubigeo VALUES (1378, '140718', 'Lima', 'Yauyos', 'Miraflores');
INSERT INTO ubigeo VALUES (1379, '140719', 'Lima', 'Yauyos', 'Omas');
INSERT INTO ubigeo VALUES (1380, '140720', 'Lima', 'Yauyos', 'Quinches');
INSERT INTO ubigeo VALUES (1381, '140721', 'Lima', 'Yauyos', 'Quinocay');
INSERT INTO ubigeo VALUES (1382, '140722', 'Lima', 'Yauyos', 'San Joaquin');
INSERT INTO ubigeo VALUES (1383, '140723', 'Lima', 'Yauyos', 'San Pedro de Pilas');
INSERT INTO ubigeo VALUES (1384, '140724', 'Lima', 'Yauyos', 'Tanta');
INSERT INTO ubigeo VALUES (1385, '140725', 'Lima', 'Yauyos', 'Tauripampa');
INSERT INTO ubigeo VALUES (1386, '140726', 'Lima', 'Yauyos', 'Tupe');
INSERT INTO ubigeo VALUES (1387, '140727', 'Lima', 'Yauyos', 'Tomas');
INSERT INTO ubigeo VALUES (1388, '140728', 'Lima', 'Yauyos', 'Viñac');
INSERT INTO ubigeo VALUES (1389, '140729', 'Lima', 'Yauyos', 'Vitis');
INSERT INTO ubigeo VALUES (1390, '140730', 'Lima', 'Yauyos', 'Hongos');
INSERT INTO ubigeo VALUES (1391, '140731', 'Lima', 'Yauyos', 'Madean');
INSERT INTO ubigeo VALUES (1392, '140732', 'Lima', 'Yauyos', 'Putinza');
INSERT INTO ubigeo VALUES (1393, '140733', 'Lima', 'Yauyos', 'Catahuasi');
INSERT INTO ubigeo VALUES (1394, '140801', 'Lima', 'Huaral', 'Huaral');
INSERT INTO ubigeo VALUES (1395, '140802', 'Lima', 'Huaral', 'Atavillos Alto');
INSERT INTO ubigeo VALUES (1396, '140803', 'Lima', 'Huaral', 'Atavillos Bajo');
INSERT INTO ubigeo VALUES (1397, '140804', 'Lima', 'Huaral', 'Aucallama');
INSERT INTO ubigeo VALUES (1398, '140805', 'Lima', 'Huaral', 'Chancay');
INSERT INTO ubigeo VALUES (1399, '140806', 'Lima', 'Huaral', 'Ihuari');
INSERT INTO ubigeo VALUES (1400, '140807', 'Lima', 'Huaral', 'Lampian');
INSERT INTO ubigeo VALUES (1401, '140808', 'Lima', 'Huaral', 'Pacaraos');
INSERT INTO ubigeo VALUES (1402, '140809', 'Lima', 'Huaral', 'San Miguel de Acos');
INSERT INTO ubigeo VALUES (1403, '140810', 'Lima', 'Huaral', 'Veintisiete de Noviembre');
INSERT INTO ubigeo VALUES (1404, '140811', 'Lima', 'Huaral', 'Santa Cruz de Andamarca');
INSERT INTO ubigeo VALUES (1405, '140812', 'Lima', 'Huaral', 'Sumbilca');
INSERT INTO ubigeo VALUES (1406, '140901', 'Lima', 'Barranca', 'Barranca');
INSERT INTO ubigeo VALUES (1407, '140902', 'Lima', 'Barranca', 'Paramonga');
INSERT INTO ubigeo VALUES (1408, '140903', 'Lima', 'Barranca', 'Pativilca');
INSERT INTO ubigeo VALUES (1409, '140904', 'Lima', 'Barranca', 'Supe');
INSERT INTO ubigeo VALUES (1410, '140905', 'Lima', 'Barranca', 'Supe Puerto');
INSERT INTO ubigeo VALUES (1411, '141001', 'Lima', 'Oyon', 'Oyon');
INSERT INTO ubigeo VALUES (1412, '141002', 'Lima', 'Oyon', 'Navan');
INSERT INTO ubigeo VALUES (1413, '141003', 'Lima', 'Oyon', 'Caujul');
INSERT INTO ubigeo VALUES (1414, '141004', 'Lima', 'Oyon', 'Andajes');
INSERT INTO ubigeo VALUES (1415, '141005', 'Lima', 'Oyon', 'Pachangara');
INSERT INTO ubigeo VALUES (1416, '141006', 'Lima', 'Oyon', 'Cochamarca');
INSERT INTO ubigeo VALUES (1417, '150101', 'Loreto', 'Maynas', 'Iquitos');
INSERT INTO ubigeo VALUES (1418, '150102', 'Loreto', 'Maynas', 'Alto Nanay');
INSERT INTO ubigeo VALUES (1419, '150103', 'Loreto', 'Maynas', 'Fernando Lores');
INSERT INTO ubigeo VALUES (1420, '150104', 'Loreto', 'Maynas', 'Las Amazonas');
INSERT INTO ubigeo VALUES (1421, '150105', 'Loreto', 'Maynas', 'Mazan');
INSERT INTO ubigeo VALUES (1422, '150106', 'Loreto', 'Maynas', 'Napo');
INSERT INTO ubigeo VALUES (1423, '150107', 'Loreto', 'Maynas', 'Putumayo');
INSERT INTO ubigeo VALUES (1424, '150108', 'Loreto', 'Maynas', 'Torres Causana');
INSERT INTO ubigeo VALUES (1425, '150110', 'Loreto', 'Maynas', 'Indiana');
INSERT INTO ubigeo VALUES (1426, '150111', 'Loreto', 'Maynas', 'Punchana');
INSERT INTO ubigeo VALUES (1427, '150112', 'Loreto', 'Maynas', 'Belen');
INSERT INTO ubigeo VALUES (1428, '150113', 'Loreto', 'Maynas', 'San Juan Bautista');
INSERT INTO ubigeo VALUES (1429, '150114', 'Loreto', 'Maynas', 'Teniente Manuel Clavero');
INSERT INTO ubigeo VALUES (1430, '150201', 'Loreto', 'Alto Amazonas', 'Yurimaguas');
INSERT INTO ubigeo VALUES (1431, '150202', 'Loreto', 'Alto Amazonas', 'Balsapuerto');
INSERT INTO ubigeo VALUES (1432, '150205', 'Loreto', 'Alto Amazonas', 'Jeberos');
INSERT INTO ubigeo VALUES (1433, '150206', 'Loreto', 'Alto Amazonas', 'Lagunas');
INSERT INTO ubigeo VALUES (1434, '150210', 'Loreto', 'Alto Amazonas', 'Santa Cruz');
INSERT INTO ubigeo VALUES (1435, '150211', 'Loreto', 'Alto Amazonas', 'Teniente Cesar Lopez Rojas');
INSERT INTO ubigeo VALUES (1436, '150301', 'Loreto', 'Loreto', 'Nauta');
INSERT INTO ubigeo VALUES (1437, '150302', 'Loreto', 'Loreto', 'Parinari');
INSERT INTO ubigeo VALUES (1438, '150303', 'Loreto', 'Loreto', 'Tigre');
INSERT INTO ubigeo VALUES (1439, '150304', 'Loreto', 'Loreto', 'Urarinas');
INSERT INTO ubigeo VALUES (1440, '150305', 'Loreto', 'Loreto', 'Trompeteros');
INSERT INTO ubigeo VALUES (1441, '150401', 'Loreto', 'Requena', 'Requena');
INSERT INTO ubigeo VALUES (1442, '150402', 'Loreto', 'Requena', 'Alto Tapiche');
INSERT INTO ubigeo VALUES (1443, '150403', 'Loreto', 'Requena', 'Capelo');
INSERT INTO ubigeo VALUES (1444, '150404', 'Loreto', 'Requena', 'Emilio San Martin');
INSERT INTO ubigeo VALUES (1445, '150405', 'Loreto', 'Requena', 'Maquia');
INSERT INTO ubigeo VALUES (1446, '150406', 'Loreto', 'Requena', 'Puinahua');
INSERT INTO ubigeo VALUES (1447, '150407', 'Loreto', 'Requena', 'Saquena');
INSERT INTO ubigeo VALUES (1448, '150408', 'Loreto', 'Requena', 'Soplin');
INSERT INTO ubigeo VALUES (1449, '150409', 'Loreto', 'Requena', 'Tapiche');
INSERT INTO ubigeo VALUES (1450, '150410', 'Loreto', 'Requena', 'Jenaro Herrera');
INSERT INTO ubigeo VALUES (1451, '150411', 'Loreto', 'Requena', 'Yaquerana');
INSERT INTO ubigeo VALUES (1452, '150501', 'Loreto', 'Ucayali', 'Contamana');
INSERT INTO ubigeo VALUES (1453, '150502', 'Loreto', 'Ucayali', 'Vargas Guerra');
INSERT INTO ubigeo VALUES (1454, '150503', 'Loreto', 'Ucayali', 'Padre Marquez');
INSERT INTO ubigeo VALUES (1455, '150504', 'Loreto', 'Ucayali', 'Pampa Hermosa');
INSERT INTO ubigeo VALUES (1456, '150505', 'Loreto', 'Ucayali', 'Sarayacu');
INSERT INTO ubigeo VALUES (1457, '150506', 'Loreto', 'Ucayali', 'Inahuaya');
INSERT INTO ubigeo VALUES (1458, '150601', 'Loreto', 'Mariscal Ramon Castilla', 'Ramon Castilla');
INSERT INTO ubigeo VALUES (1459, '150602', 'Loreto', 'Mariscal Ramon Castilla', 'Pebas');
INSERT INTO ubigeo VALUES (1460, '150603', 'Loreto', 'Mariscal Ramon Castilla', 'Yavari');
INSERT INTO ubigeo VALUES (1461, '150604', 'Loreto', 'Mariscal Ramon Castilla', 'San Pablo');
INSERT INTO ubigeo VALUES (1462, '150701', 'Loreto', 'Datem del Marañon', 'Barranca');
INSERT INTO ubigeo VALUES (1463, '150702', 'Loreto', 'Datem del Marañon', 'Andoas');
INSERT INTO ubigeo VALUES (1464, '150703', 'Loreto', 'Datem del Marañon', 'Cahuapanas');
INSERT INTO ubigeo VALUES (1465, '150704', 'Loreto', 'Datem del Marañon', 'Manseriche');
INSERT INTO ubigeo VALUES (1466, '150705', 'Loreto', 'Datem del Marañon', 'Morona');
INSERT INTO ubigeo VALUES (1467, '150706', 'Loreto', 'Datem del Marañon', 'Pastaza');
INSERT INTO ubigeo VALUES (1468, '160101', 'Madre de Dios', 'Tambopata', 'Tambopata');
INSERT INTO ubigeo VALUES (1469, '160102', 'Madre de Dios', 'Tambopata', 'Inambari');
INSERT INTO ubigeo VALUES (1470, '160103', 'Madre de Dios', 'Tambopata', 'Las Piedras');
INSERT INTO ubigeo VALUES (1471, '160104', 'Madre de Dios', 'Tambopata', 'Laberinto');
INSERT INTO ubigeo VALUES (1472, '160201', 'Madre de Dios', 'Manu', 'Manu');
INSERT INTO ubigeo VALUES (1473, '160202', 'Madre de Dios', 'Manu', 'Fitzcarrald');
INSERT INTO ubigeo VALUES (1474, '160203', 'Madre de Dios', 'Manu', 'Madre de Dios');
INSERT INTO ubigeo VALUES (1475, '160204', 'Madre de Dios', 'Manu', 'Huepetuhe');
INSERT INTO ubigeo VALUES (1476, '160301', 'Madre de Dios', 'Tahuamanu', 'Iñapari');
INSERT INTO ubigeo VALUES (1477, '160302', 'Madre de Dios', 'Tahuamanu', 'Iberia');
INSERT INTO ubigeo VALUES (1478, '160303', 'Madre de Dios', 'Tahuamanu', 'Tahuamanu');
INSERT INTO ubigeo VALUES (1479, '170101', 'Moquegua', 'Mariscal Nieto', 'Moquegua');
INSERT INTO ubigeo VALUES (1480, '170102', 'Moquegua', 'Mariscal Nieto', 'Carumas');
INSERT INTO ubigeo VALUES (1481, '170103', 'Moquegua', 'Mariscal Nieto', 'Cuchumbaya');
INSERT INTO ubigeo VALUES (1482, '170104', 'Moquegua', 'Mariscal Nieto', 'San Cristobal');
INSERT INTO ubigeo VALUES (1483, '170105', 'Moquegua', 'Mariscal Nieto', 'Torata');
INSERT INTO ubigeo VALUES (1484, '170106', 'Moquegua', 'Mariscal Nieto', 'Samegua');
INSERT INTO ubigeo VALUES (1485, '170201', 'Moquegua', 'General Sanchez Cerro', 'Omate');
INSERT INTO ubigeo VALUES (1486, '170202', 'Moquegua', 'General Sanchez Cerro', 'Coalaque');
INSERT INTO ubigeo VALUES (1487, '170203', 'Moquegua', 'General Sanchez Cerro', 'Chojata');
INSERT INTO ubigeo VALUES (1488, '170204', 'Moquegua', 'General Sanchez Cerro', 'Ichuña');
INSERT INTO ubigeo VALUES (1489, '170205', 'Moquegua', 'General Sanchez Cerro', 'La Capilla');
INSERT INTO ubigeo VALUES (1490, '170206', 'Moquegua', 'General Sanchez Cerro', 'Lloque');
INSERT INTO ubigeo VALUES (1491, '170207', 'Moquegua', 'General Sanchez Cerro', 'Matalaque');
INSERT INTO ubigeo VALUES (1492, '170208', 'Moquegua', 'General Sanchez Cerro', 'Puquina');
INSERT INTO ubigeo VALUES (1493, '170209', 'Moquegua', 'General Sanchez Cerro', 'Quinistaquillas');
INSERT INTO ubigeo VALUES (1494, '170210', 'Moquegua', 'General Sanchez Cerro', 'Ubinas');
INSERT INTO ubigeo VALUES (1495, '170211', 'Moquegua', 'General Sanchez Cerro', 'Yunga');
INSERT INTO ubigeo VALUES (1496, '170301', 'Moquegua', 'Ilo', 'Ilo');
INSERT INTO ubigeo VALUES (1497, '170302', 'Moquegua', 'Ilo', 'El Algarrobal');
INSERT INTO ubigeo VALUES (1498, '170303', 'Moquegua', 'Ilo', 'Pacocha');
INSERT INTO ubigeo VALUES (1499, '180101', 'Pasco', 'Pasco', 'Chaupimarca');
INSERT INTO ubigeo VALUES (1500, '180103', 'Pasco', 'Pasco', 'Huachon');
INSERT INTO ubigeo VALUES (1501, '180104', 'Pasco', 'Pasco', 'Huariaca');
INSERT INTO ubigeo VALUES (1502, '180105', 'Pasco', 'Pasco', 'Huayllay');
INSERT INTO ubigeo VALUES (1503, '180106', 'Pasco', 'Pasco', 'Ninacaca');
INSERT INTO ubigeo VALUES (1504, '180107', 'Pasco', 'Pasco', 'Pallanchacra');
INSERT INTO ubigeo VALUES (1505, '180108', 'Pasco', 'Pasco', 'Paucartambo');
INSERT INTO ubigeo VALUES (1506, '180109', 'Pasco', 'Pasco', 'San Francisco de Asis de Yarusyacan');
INSERT INTO ubigeo VALUES (1507, '180110', 'Pasco', 'Pasco', 'Simon Bolivar');
INSERT INTO ubigeo VALUES (1508, '180111', 'Pasco', 'Pasco', 'Ticlacayan');
INSERT INTO ubigeo VALUES (1509, '180112', 'Pasco', 'Pasco', 'Tinyahuarco');
INSERT INTO ubigeo VALUES (1510, '180113', 'Pasco', 'Pasco', 'Vicco');
INSERT INTO ubigeo VALUES (1511, '180114', 'Pasco', 'Pasco', 'Yanacancha');
INSERT INTO ubigeo VALUES (1512, '180201', 'Pasco', 'Daniel Alcides Carrion', 'Yanahuanca');
INSERT INTO ubigeo VALUES (1513, '180202', 'Pasco', 'Daniel Alcides Carrion', 'Chacayan');
INSERT INTO ubigeo VALUES (1514, '180203', 'Pasco', 'Daniel Alcides Carrion', 'Goyllarisquizga');
INSERT INTO ubigeo VALUES (1515, '180204', 'Pasco', 'Daniel Alcides Carrion', 'Paucar');
INSERT INTO ubigeo VALUES (1516, '180205', 'Pasco', 'Daniel Alcides Carrion', 'San Pedro de Pillao');
INSERT INTO ubigeo VALUES (1517, '180206', 'Pasco', 'Daniel Alcides Carrion', 'Santa Ana de Tusi');
INSERT INTO ubigeo VALUES (1518, '180207', 'Pasco', 'Daniel Alcides Carrion', 'Tapuc');
INSERT INTO ubigeo VALUES (1519, '180208', 'Pasco', 'Daniel Alcides Carrion', 'Vilcabamba');
INSERT INTO ubigeo VALUES (1520, '180301', 'Pasco', 'Oxapampa', 'Oxapampa');
INSERT INTO ubigeo VALUES (1521, '180302', 'Pasco', 'Oxapampa', 'Chontabamba');
INSERT INTO ubigeo VALUES (1522, '180303', 'Pasco', 'Oxapampa', 'Huancabamba');
INSERT INTO ubigeo VALUES (1523, '180304', 'Pasco', 'Oxapampa', 'Puerto Bermudez');
INSERT INTO ubigeo VALUES (1524, '180305', 'Pasco', 'Oxapampa', 'Villa Rica');
INSERT INTO ubigeo VALUES (1525, '180306', 'Pasco', 'Oxapampa', 'Pozuzo');
INSERT INTO ubigeo VALUES (1526, '180307', 'Pasco', 'Oxapampa', 'Palcazu');
INSERT INTO ubigeo VALUES (1527, '180308', 'Pasco', 'Oxapampa', 'Constitución');
INSERT INTO ubigeo VALUES (1528, '190101', 'Piura', 'Piura', 'Piura');
INSERT INTO ubigeo VALUES (1529, '190103', 'Piura', 'Piura', 'Castilla');
INSERT INTO ubigeo VALUES (1530, '190104', 'Piura', 'Piura', 'Catacaos');
INSERT INTO ubigeo VALUES (1531, '190105', 'Piura', 'Piura', 'La Arena');
INSERT INTO ubigeo VALUES (1532, '190106', 'Piura', 'Piura', 'La Union');
INSERT INTO ubigeo VALUES (1533, '190107', 'Piura', 'Piura', 'Las Lomas');
INSERT INTO ubigeo VALUES (1534, '190109', 'Piura', 'Piura', 'Tambo Grande');
INSERT INTO ubigeo VALUES (1535, '190113', 'Piura', 'Piura', 'Cura Mori');
INSERT INTO ubigeo VALUES (1536, '190114', 'Piura', 'Piura', 'El Tallan');
INSERT INTO ubigeo VALUES (1537, '190201', 'Piura', 'Ayabaca', 'Ayabaca');
INSERT INTO ubigeo VALUES (1538, '190202', 'Piura', 'Ayabaca', 'Frias');
INSERT INTO ubigeo VALUES (1539, '190203', 'Piura', 'Ayabaca', 'Lagunas');
INSERT INTO ubigeo VALUES (1540, '190204', 'Piura', 'Ayabaca', 'Montero');
INSERT INTO ubigeo VALUES (1541, '190205', 'Piura', 'Ayabaca', 'Pacaipampa');
INSERT INTO ubigeo VALUES (1542, '190206', 'Piura', 'Ayabaca', 'Sapillica');
INSERT INTO ubigeo VALUES (1543, '190207', 'Piura', 'Ayabaca', 'Sicchez');
INSERT INTO ubigeo VALUES (1544, '190208', 'Piura', 'Ayabaca', 'Suyo');
INSERT INTO ubigeo VALUES (1545, '190209', 'Piura', 'Ayabaca', 'Jilili');
INSERT INTO ubigeo VALUES (1546, '190210', 'Piura', 'Ayabaca', 'Paimas');
INSERT INTO ubigeo VALUES (1547, '190301', 'Piura', 'Huancabamba', 'Huancabamba');
INSERT INTO ubigeo VALUES (1548, '190302', 'Piura', 'Huancabamba', 'Canchaque');
INSERT INTO ubigeo VALUES (1549, '190303', 'Piura', 'Huancabamba', 'Huarmaca');
INSERT INTO ubigeo VALUES (1550, '190304', 'Piura', 'Huancabamba', 'Sondor');
INSERT INTO ubigeo VALUES (1551, '190305', 'Piura', 'Huancabamba', 'Sondorillo');
INSERT INTO ubigeo VALUES (1552, '190306', 'Piura', 'Huancabamba', 'El Carmen de La Frontera');
INSERT INTO ubigeo VALUES (1553, '190307', 'Piura', 'Huancabamba', 'San Miguel de El Faique');
INSERT INTO ubigeo VALUES (1554, '190308', 'Piura', 'Huancabamba', 'Lalaquiz');
INSERT INTO ubigeo VALUES (1555, '190401', 'Piura', 'Morropon', 'Chulucanas');
INSERT INTO ubigeo VALUES (1556, '190402', 'Piura', 'Morropon', 'Buenos Aires');
INSERT INTO ubigeo VALUES (1557, '190403', 'Piura', 'Morropon', 'Chalaco');
INSERT INTO ubigeo VALUES (1558, '190404', 'Piura', 'Morropon', 'Morropon');
INSERT INTO ubigeo VALUES (1559, '190405', 'Piura', 'Morropon', 'Salitral');
INSERT INTO ubigeo VALUES (1560, '190406', 'Piura', 'Morropon', 'Santa Catalina de Mossa');
INSERT INTO ubigeo VALUES (1561, '190407', 'Piura', 'Morropon', 'Santo Domingo');
INSERT INTO ubigeo VALUES (1562, '190408', 'Piura', 'Morropon', 'La Matanza');
INSERT INTO ubigeo VALUES (1563, '190409', 'Piura', 'Morropon', 'Yamango');
INSERT INTO ubigeo VALUES (1564, '190410', 'Piura', 'Morropon', 'San Juan de Bigote');
INSERT INTO ubigeo VALUES (1565, '190501', 'Piura', 'Paita', 'Paita');
INSERT INTO ubigeo VALUES (1566, '190502', 'Piura', 'Paita', 'Amotape');
INSERT INTO ubigeo VALUES (1567, '190503', 'Piura', 'Paita', 'Arenal');
INSERT INTO ubigeo VALUES (1568, '190504', 'Piura', 'Paita', 'La Huaca');
INSERT INTO ubigeo VALUES (1569, '190505', 'Piura', 'Paita', 'Colan');
INSERT INTO ubigeo VALUES (1570, '190506', 'Piura', 'Paita', 'Tamarindo');
INSERT INTO ubigeo VALUES (1571, '190507', 'Piura', 'Paita', 'Vichayal');
INSERT INTO ubigeo VALUES (1572, '190601', 'Piura', 'Sullana', 'Sullana');
INSERT INTO ubigeo VALUES (1573, '190602', 'Piura', 'Sullana', 'Bellavista');
INSERT INTO ubigeo VALUES (1574, '190603', 'Piura', 'Sullana', 'Lancones');
INSERT INTO ubigeo VALUES (1575, '190604', 'Piura', 'Sullana', 'Marcavelica');
INSERT INTO ubigeo VALUES (1576, '190605', 'Piura', 'Sullana', 'Miguel Checa');
INSERT INTO ubigeo VALUES (1577, '190606', 'Piura', 'Sullana', 'Querecotillo');
INSERT INTO ubigeo VALUES (1578, '190607', 'Piura', 'Sullana', 'Salitral');
INSERT INTO ubigeo VALUES (1579, '190608', 'Piura', 'Sullana', 'Ignacio Escudero');
INSERT INTO ubigeo VALUES (1580, '190701', 'Piura', 'Talara', 'Pariñas');
INSERT INTO ubigeo VALUES (1581, '190702', 'Piura', 'Talara', 'El Alto');
INSERT INTO ubigeo VALUES (1582, '190703', 'Piura', 'Talara', 'La Brea');
INSERT INTO ubigeo VALUES (1583, '190704', 'Piura', 'Talara', 'Lobitos');
INSERT INTO ubigeo VALUES (1584, '190705', 'Piura', 'Talara', 'Mancora');
INSERT INTO ubigeo VALUES (1585, '190706', 'Piura', 'Talara', 'Los Organos');
INSERT INTO ubigeo VALUES (1586, '190801', 'Piura', 'Sechura', 'Sechura');
INSERT INTO ubigeo VALUES (1587, '190802', 'Piura', 'Sechura', 'Vice');
INSERT INTO ubigeo VALUES (1588, '190803', 'Piura', 'Sechura', 'Bernal');
INSERT INTO ubigeo VALUES (1589, '190804', 'Piura', 'Sechura', 'Bellavista de La Union');
INSERT INTO ubigeo VALUES (1590, '190805', 'Piura', 'Sechura', 'Cristo Nos Valga');
INSERT INTO ubigeo VALUES (1591, '190806', 'Piura', 'Sechura', 'Rinconada Llicuar');
INSERT INTO ubigeo VALUES (1592, '200101', 'Puno', 'Puno', 'Puno');
INSERT INTO ubigeo VALUES (1593, '200102', 'Puno', 'Puno', 'Acora');
INSERT INTO ubigeo VALUES (1594, '200103', 'Puno', 'Puno', 'Atuncolla');
INSERT INTO ubigeo VALUES (1595, '200104', 'Puno', 'Puno', 'Capachica');
INSERT INTO ubigeo VALUES (1596, '200105', 'Puno', 'Puno', 'Coata');
INSERT INTO ubigeo VALUES (1597, '200106', 'Puno', 'Puno', 'Chucuito');
INSERT INTO ubigeo VALUES (1598, '200107', 'Puno', 'Puno', 'Huata');
INSERT INTO ubigeo VALUES (1599, '200108', 'Puno', 'Puno', 'Mañazo');
INSERT INTO ubigeo VALUES (1600, '200109', 'Puno', 'Puno', 'Paucarcolla');
INSERT INTO ubigeo VALUES (1601, '200110', 'Puno', 'Puno', 'Pichacani');
INSERT INTO ubigeo VALUES (1602, '200111', 'Puno', 'Puno', 'San Antonio');
INSERT INTO ubigeo VALUES (1603, '200112', 'Puno', 'Puno', 'Tiquillaca');
INSERT INTO ubigeo VALUES (1604, '200113', 'Puno', 'Puno', 'Vilque');
INSERT INTO ubigeo VALUES (1605, '200114', 'Puno', 'Puno', 'Plateria');
INSERT INTO ubigeo VALUES (1606, '200115', 'Puno', 'Puno', 'Amantani');
INSERT INTO ubigeo VALUES (1607, '200201', 'Puno', 'Azangaro', 'Azangaro');
INSERT INTO ubigeo VALUES (1608, '200202', 'Puno', 'Azangaro', 'Achaya');
INSERT INTO ubigeo VALUES (1609, '200203', 'Puno', 'Azangaro', 'Arapa');
INSERT INTO ubigeo VALUES (1610, '200204', 'Puno', 'Azangaro', 'Asillo');
INSERT INTO ubigeo VALUES (1611, '200205', 'Puno', 'Azangaro', 'Caminaca');
INSERT INTO ubigeo VALUES (1612, '200206', 'Puno', 'Azangaro', 'Chupa');
INSERT INTO ubigeo VALUES (1613, '200207', 'Puno', 'Azangaro', 'Jose Domingo Choquehuanca');
INSERT INTO ubigeo VALUES (1614, '200208', 'Puno', 'Azangaro', 'Muñani');
INSERT INTO ubigeo VALUES (1615, '200210', 'Puno', 'Azangaro', 'Potoni');
INSERT INTO ubigeo VALUES (1616, '200212', 'Puno', 'Azangaro', 'Saman');
INSERT INTO ubigeo VALUES (1617, '200213', 'Puno', 'Azangaro', 'San Anton');
INSERT INTO ubigeo VALUES (1618, '200214', 'Puno', 'Azangaro', 'San Jose');
INSERT INTO ubigeo VALUES (1619, '200215', 'Puno', 'Azangaro', 'San Juan de Salinas');
INSERT INTO ubigeo VALUES (1620, '200216', 'Puno', 'Azangaro', 'Santiago de Pupuja');
INSERT INTO ubigeo VALUES (1621, '200217', 'Puno', 'Azangaro', 'Tirapata');
INSERT INTO ubigeo VALUES (1622, '200301', 'Puno', 'Carabaya', 'Macusani');
INSERT INTO ubigeo VALUES (1623, '200302', 'Puno', 'Carabaya', 'Ajoyani');
INSERT INTO ubigeo VALUES (1624, '200303', 'Puno', 'Carabaya', 'Ayapata');
INSERT INTO ubigeo VALUES (1625, '200304', 'Puno', 'Carabaya', 'Coasa');
INSERT INTO ubigeo VALUES (1626, '200305', 'Puno', 'Carabaya', 'Corani');
INSERT INTO ubigeo VALUES (1627, '200306', 'Puno', 'Carabaya', 'Crucero');
INSERT INTO ubigeo VALUES (1628, '200307', 'Puno', 'Carabaya', 'Ituata');
INSERT INTO ubigeo VALUES (1629, '200308', 'Puno', 'Carabaya', 'Ollachea');
INSERT INTO ubigeo VALUES (1630, '200309', 'Puno', 'Carabaya', 'San Gaban');
INSERT INTO ubigeo VALUES (1631, '200310', 'Puno', 'Carabaya', 'Usicayos');
INSERT INTO ubigeo VALUES (1632, '200401', 'Puno', 'Chucuito', 'Juli');
INSERT INTO ubigeo VALUES (1633, '200402', 'Puno', 'Chucuito', 'Desaguadero');
INSERT INTO ubigeo VALUES (1634, '200403', 'Puno', 'Chucuito', 'Huacullani');
INSERT INTO ubigeo VALUES (1635, '200406', 'Puno', 'Chucuito', 'Pisacoma');
INSERT INTO ubigeo VALUES (1636, '200407', 'Puno', 'Chucuito', 'Pomata');
INSERT INTO ubigeo VALUES (1637, '200410', 'Puno', 'Chucuito', 'Zepita');
INSERT INTO ubigeo VALUES (1638, '200412', 'Puno', 'Chucuito', 'Kelluyo');
INSERT INTO ubigeo VALUES (1639, '200501', 'Puno', 'Huancane', 'Huancane');
INSERT INTO ubigeo VALUES (1640, '200502', 'Puno', 'Huancane', 'Cojata');
INSERT INTO ubigeo VALUES (1641, '200504', 'Puno', 'Huancane', 'Inchupalla');
INSERT INTO ubigeo VALUES (1642, '200506', 'Puno', 'Huancane', 'Pusi');
INSERT INTO ubigeo VALUES (1643, '200507', 'Puno', 'Huancane', 'Rosaspata');
INSERT INTO ubigeo VALUES (1644, '200508', 'Puno', 'Huancane', 'Taraco');
INSERT INTO ubigeo VALUES (1645, '200509', 'Puno', 'Huancane', 'Vilque Chico');
INSERT INTO ubigeo VALUES (1646, '200511', 'Puno', 'Huancane', 'Huatasani');
INSERT INTO ubigeo VALUES (1647, '200601', 'Puno', 'Lampa', 'Lampa');
INSERT INTO ubigeo VALUES (1648, '200602', 'Puno', 'Lampa', 'Cabanilla');
INSERT INTO ubigeo VALUES (1649, '200603', 'Puno', 'Lampa', 'Calapuja');
INSERT INTO ubigeo VALUES (1650, '200604', 'Puno', 'Lampa', 'Nicasio');
INSERT INTO ubigeo VALUES (1651, '200605', 'Puno', 'Lampa', 'Ocuviri');
INSERT INTO ubigeo VALUES (1652, '200606', 'Puno', 'Lampa', 'Palca');
INSERT INTO ubigeo VALUES (1653, '200607', 'Puno', 'Lampa', 'Paratia');
INSERT INTO ubigeo VALUES (1654, '200608', 'Puno', 'Lampa', 'Pucara');
INSERT INTO ubigeo VALUES (1655, '200609', 'Puno', 'Lampa', 'Santa Lucia');
INSERT INTO ubigeo VALUES (1656, '200610', 'Puno', 'Lampa', 'Vilavila');
INSERT INTO ubigeo VALUES (1657, '200701', 'Puno', 'Melgar', 'Ayaviri');
INSERT INTO ubigeo VALUES (1658, '200702', 'Puno', 'Melgar', 'Antauta');
INSERT INTO ubigeo VALUES (1659, '200703', 'Puno', 'Melgar', 'Cupi');
INSERT INTO ubigeo VALUES (1660, '200704', 'Puno', 'Melgar', 'Llalli');
INSERT INTO ubigeo VALUES (1661, '200705', 'Puno', 'Melgar', 'Macari');
INSERT INTO ubigeo VALUES (1662, '200706', 'Puno', 'Melgar', 'Nuñoa');
INSERT INTO ubigeo VALUES (1663, '200707', 'Puno', 'Melgar', 'Orurillo');
INSERT INTO ubigeo VALUES (1664, '200708', 'Puno', 'Melgar', 'Santa Rosa');
INSERT INTO ubigeo VALUES (1665, '200709', 'Puno', 'Melgar', 'Umachiri');
INSERT INTO ubigeo VALUES (1666, '200801', 'Puno', 'Sandia', 'Sandia');
INSERT INTO ubigeo VALUES (1667, '200803', 'Puno', 'Sandia', 'Cuyocuyo');
INSERT INTO ubigeo VALUES (1668, '200804', 'Puno', 'Sandia', 'Limbani');
INSERT INTO ubigeo VALUES (1669, '200805', 'Puno', 'Sandia', 'Phara');
INSERT INTO ubigeo VALUES (1670, '200806', 'Puno', 'Sandia', 'Patambuco');
INSERT INTO ubigeo VALUES (1671, '200807', 'Puno', 'Sandia', 'Quiaca');
INSERT INTO ubigeo VALUES (1672, '200808', 'Puno', 'Sandia', 'San Juan del Oro');
INSERT INTO ubigeo VALUES (1673, '200810', 'Puno', 'Sandia', 'Yanahuaya');
INSERT INTO ubigeo VALUES (1674, '200811', 'Puno', 'Sandia', 'Alto Inambari');
INSERT INTO ubigeo VALUES (1675, '200812', 'Puno', 'Sandia', 'San Pedro de Putina Punco');
INSERT INTO ubigeo VALUES (1676, '200901', 'Puno', 'San Roman', 'Juliaca');
INSERT INTO ubigeo VALUES (1677, '200902', 'Puno', 'San Roman', 'Cabana');
INSERT INTO ubigeo VALUES (1678, '200903', 'Puno', 'San Roman', 'Cabanillas');
INSERT INTO ubigeo VALUES (1679, '200904', 'Puno', 'San Roman', 'Caracoto');
INSERT INTO ubigeo VALUES (1680, '201001', 'Puno', 'Yunguyo', 'Yunguyo');
INSERT INTO ubigeo VALUES (1681, '201002', 'Puno', 'Yunguyo', 'Unicachi');
INSERT INTO ubigeo VALUES (1682, '201003', 'Puno', 'Yunguyo', 'Anapia');
INSERT INTO ubigeo VALUES (1683, '201004', 'Puno', 'Yunguyo', 'Copani');
INSERT INTO ubigeo VALUES (1684, '201005', 'Puno', 'Yunguyo', 'Cuturapi');
INSERT INTO ubigeo VALUES (1685, '201006', 'Puno', 'Yunguyo', 'Ollaraya');
INSERT INTO ubigeo VALUES (1686, '201007', 'Puno', 'Yunguyo', 'Tinicachi');
INSERT INTO ubigeo VALUES (1687, '201101', 'Puno', 'San Antonio de Putina', 'Putina');
INSERT INTO ubigeo VALUES (1688, '201102', 'Puno', 'San Antonio de Putina', 'Pedro Vilca Apaza');
INSERT INTO ubigeo VALUES (1689, '201103', 'Puno', 'San Antonio de Putina', 'Quilcapuncu');
INSERT INTO ubigeo VALUES (1690, '201104', 'Puno', 'San Antonio de Putina', 'Ananea');
INSERT INTO ubigeo VALUES (1691, '201105', 'Puno', 'San Antonio de Putina', 'Sina');
INSERT INTO ubigeo VALUES (1692, '201201', 'Puno', 'El Collao', 'Ilave');
INSERT INTO ubigeo VALUES (1693, '201202', 'Puno', 'El Collao', 'Pilcuyo');
INSERT INTO ubigeo VALUES (1694, '201203', 'Puno', 'El Collao', 'Santa Rosa');
INSERT INTO ubigeo VALUES (1695, '201204', 'Puno', 'El Collao', 'Capazo');
INSERT INTO ubigeo VALUES (1696, '201205', 'Puno', 'El Collao', 'Conduriri');
INSERT INTO ubigeo VALUES (1697, '201301', 'Puno', 'Moho', 'Moho');
INSERT INTO ubigeo VALUES (1698, '201302', 'Puno', 'Moho', 'Conima');
INSERT INTO ubigeo VALUES (1699, '201303', 'Puno', 'Moho', 'Tilali');
INSERT INTO ubigeo VALUES (1700, '201304', 'Puno', 'Moho', 'Huayrapata');
INSERT INTO ubigeo VALUES (1701, '210101', 'San Martin', 'Moyobamba', 'Moyobamba');
INSERT INTO ubigeo VALUES (1702, '210102', 'San Martin', 'Moyobamba', 'Calzada');
INSERT INTO ubigeo VALUES (1703, '210103', 'San Martin', 'Moyobamba', 'Habana');
INSERT INTO ubigeo VALUES (1704, '210104', 'San Martin', 'Moyobamba', 'Jepelacio');
INSERT INTO ubigeo VALUES (1705, '210105', 'San Martin', 'Moyobamba', 'Soritor');
INSERT INTO ubigeo VALUES (1706, '210106', 'San Martin', 'Moyobamba', 'Yantalo');
INSERT INTO ubigeo VALUES (1707, '210201', 'San Martin', 'Huallaga', 'Saposoa');
INSERT INTO ubigeo VALUES (1708, '210202', 'San Martin', 'Huallaga', 'Piscoyacu');
INSERT INTO ubigeo VALUES (1709, '210203', 'San Martin', 'Huallaga', 'Sacanche');
INSERT INTO ubigeo VALUES (1710, '210204', 'San Martin', 'Huallaga', 'Tingo de Saposoa');
INSERT INTO ubigeo VALUES (1711, '210205', 'San Martin', 'Huallaga', 'Alto Saposoa');
INSERT INTO ubigeo VALUES (1712, '210206', 'San Martin', 'Huallaga', 'El Eslabon');
INSERT INTO ubigeo VALUES (1713, '210301', 'San Martin', 'Lamas', 'Lamas');
INSERT INTO ubigeo VALUES (1714, '210303', 'San Martin', 'Lamas', 'Barranquita');
INSERT INTO ubigeo VALUES (1715, '210304', 'San Martin', 'Lamas', 'Caynarachi');
INSERT INTO ubigeo VALUES (1716, '210305', 'San Martin', 'Lamas', 'Cuñumbuqui');
INSERT INTO ubigeo VALUES (1717, '210306', 'San Martin', 'Lamas', 'Pinto Recodo');
INSERT INTO ubigeo VALUES (1718, '210307', 'San Martin', 'Lamas', 'Rumisapa');
INSERT INTO ubigeo VALUES (1719, '210311', 'San Martin', 'Lamas', 'Shanao');
INSERT INTO ubigeo VALUES (1720, '210313', 'San Martin', 'Lamas', 'Tabalosos');
INSERT INTO ubigeo VALUES (1721, '210314', 'San Martin', 'Lamas', 'Zapatero');
INSERT INTO ubigeo VALUES (1722, '210315', 'San Martin', 'Lamas', 'Alonso de Alvarado');
INSERT INTO ubigeo VALUES (1723, '210316', 'San Martin', 'Lamas', 'San Roque de Cumbaza');
INSERT INTO ubigeo VALUES (1724, '210401', 'San Martin', 'Mariscal Caceres', 'Juanjui');
INSERT INTO ubigeo VALUES (1725, '210402', 'San Martin', 'Mariscal Caceres', 'Campanilla');
INSERT INTO ubigeo VALUES (1726, '210403', 'San Martin', 'Mariscal Caceres', 'Huicungo');
INSERT INTO ubigeo VALUES (1727, '210404', 'San Martin', 'Mariscal Caceres', 'Pachiza');
INSERT INTO ubigeo VALUES (1728, '210405', 'San Martin', 'Mariscal Caceres', 'Pajarillo');
INSERT INTO ubigeo VALUES (1729, '210501', 'San Martin', 'Rioja', 'Rioja');
INSERT INTO ubigeo VALUES (1730, '210502', 'San Martin', 'Rioja', 'Posic');
INSERT INTO ubigeo VALUES (1731, '210503', 'San Martin', 'Rioja', 'Yorongos');
INSERT INTO ubigeo VALUES (1732, '210504', 'San Martin', 'Rioja', 'Yuracyacu');
INSERT INTO ubigeo VALUES (1733, '210505', 'San Martin', 'Rioja', 'Nueva Cajamarca');
INSERT INTO ubigeo VALUES (1734, '210506', 'San Martin', 'Rioja', 'Elias Soplin Vargas');
INSERT INTO ubigeo VALUES (1735, '210507', 'San Martin', 'Rioja', 'San Fernando');
INSERT INTO ubigeo VALUES (1736, '210508', 'San Martin', 'Rioja', 'Pardo Miguel');
INSERT INTO ubigeo VALUES (1737, '210509', 'San Martin', 'Rioja', 'Awajun');
INSERT INTO ubigeo VALUES (1738, '210601', 'San Martin', 'San Martin', 'Tarapoto');
INSERT INTO ubigeo VALUES (1739, '210602', 'San Martin', 'San Martin', 'Alberto Leveau');
INSERT INTO ubigeo VALUES (1740, '210604', 'San Martin', 'San Martin', 'Cacatachi');
INSERT INTO ubigeo VALUES (1741, '210606', 'San Martin', 'San Martin', 'Chazuta');
INSERT INTO ubigeo VALUES (1742, '210607', 'San Martin', 'San Martin', 'Chipurana');
INSERT INTO ubigeo VALUES (1743, '210608', 'San Martin', 'San Martin', 'El Porvenir');
INSERT INTO ubigeo VALUES (1744, '210609', 'San Martin', 'San Martin', 'Huimbayoc');
INSERT INTO ubigeo VALUES (1745, '210610', 'San Martin', 'San Martin', 'Juan Guerra');
INSERT INTO ubigeo VALUES (1746, '210611', 'San Martin', 'San Martin', 'Morales');
INSERT INTO ubigeo VALUES (1747, '210612', 'San Martin', 'San Martin', 'Papaplaya');
INSERT INTO ubigeo VALUES (1748, '210616', 'San Martin', 'San Martin', 'San Antonio');
INSERT INTO ubigeo VALUES (1749, '210619', 'San Martin', 'San Martin', 'Sauce');
INSERT INTO ubigeo VALUES (1750, '210620', 'San Martin', 'San Martin', 'Shapaja');
INSERT INTO ubigeo VALUES (1751, '210621', 'San Martin', 'San Martin', 'La Banda de Shilcayo');
INSERT INTO ubigeo VALUES (1752, '210701', 'San Martin', 'Bellavista', 'Bellavista');
INSERT INTO ubigeo VALUES (1753, '210702', 'San Martin', 'Bellavista', 'San Rafael');
INSERT INTO ubigeo VALUES (1754, '210703', 'San Martin', 'Bellavista', 'San Pablo');
INSERT INTO ubigeo VALUES (1755, '210704', 'San Martin', 'Bellavista', 'Alto Biavo');
INSERT INTO ubigeo VALUES (1756, '210705', 'San Martin', 'Bellavista', 'Huallaga');
INSERT INTO ubigeo VALUES (1757, '210706', 'San Martin', 'Bellavista', 'Bajo Biavo');
INSERT INTO ubigeo VALUES (1758, '210801', 'San Martin', 'Tocache', 'Tocache');
INSERT INTO ubigeo VALUES (1759, '210802', 'San Martin', 'Tocache', 'Nuevo Progreso');
INSERT INTO ubigeo VALUES (1760, '210803', 'San Martin', 'Tocache', 'Polvora');
INSERT INTO ubigeo VALUES (1761, '210804', 'San Martin', 'Tocache', 'Shunte');
INSERT INTO ubigeo VALUES (1762, '210805', 'San Martin', 'Tocache', 'Uchiza');
INSERT INTO ubigeo VALUES (1763, '210901', 'San Martin', 'Picota', 'Picota');
INSERT INTO ubigeo VALUES (1764, '210902', 'San Martin', 'Picota', 'Buenos Aires');
INSERT INTO ubigeo VALUES (1765, '210903', 'San Martin', 'Picota', 'Caspisapa');
INSERT INTO ubigeo VALUES (1766, '210904', 'San Martin', 'Picota', 'Pilluana');
INSERT INTO ubigeo VALUES (1767, '210905', 'San Martin', 'Picota', 'Pucacaca');
INSERT INTO ubigeo VALUES (1768, '210906', 'San Martin', 'Picota', 'San Cristobal');
INSERT INTO ubigeo VALUES (1769, '210907', 'San Martin', 'Picota', 'San Hilarion');
INSERT INTO ubigeo VALUES (1770, '210908', 'San Martin', 'Picota', 'Tingo de Ponasa');
INSERT INTO ubigeo VALUES (1771, '210909', 'San Martin', 'Picota', 'Tres Unidos');
INSERT INTO ubigeo VALUES (1772, '210910', 'San Martin', 'Picota', 'Shamboyacu');
INSERT INTO ubigeo VALUES (1773, '211001', 'San Martin', 'El Dorado', 'San Jose de Sisa');
INSERT INTO ubigeo VALUES (1774, '211002', 'San Martin', 'El Dorado', 'Agua Blanca');
INSERT INTO ubigeo VALUES (1775, '211003', 'San Martin', 'El Dorado', 'Shatoja');
INSERT INTO ubigeo VALUES (1776, '211004', 'San Martin', 'El Dorado', 'San Martin');
INSERT INTO ubigeo VALUES (1777, '211005', 'San Martin', 'El Dorado', 'Santa Rosa');
INSERT INTO ubigeo VALUES (1778, '220101', 'Tacna', 'Tacna', 'Tacna');
INSERT INTO ubigeo VALUES (1779, '220102', 'Tacna', 'Tacna', 'Calana');
INSERT INTO ubigeo VALUES (1780, '220104', 'Tacna', 'Tacna', 'Inclan');
INSERT INTO ubigeo VALUES (1781, '220107', 'Tacna', 'Tacna', 'Pachia');
INSERT INTO ubigeo VALUES (1782, '220108', 'Tacna', 'Tacna', 'Palca');
INSERT INTO ubigeo VALUES (1783, '220109', 'Tacna', 'Tacna', 'Pocollay');
INSERT INTO ubigeo VALUES (1784, '220110', 'Tacna', 'Tacna', 'Sama');
INSERT INTO ubigeo VALUES (1785, '220111', 'Tacna', 'Tacna', 'Alto de La Alianza');
INSERT INTO ubigeo VALUES (1786, '220112', 'Tacna', 'Tacna', 'Ciudad Nueva');
INSERT INTO ubigeo VALUES (1787, '220113', 'Tacna', 'Tacna', 'Coronel Gregorio Albarracin Lanchipa');
INSERT INTO ubigeo VALUES (1788, '220201', 'Tacna', 'Tarata', 'Tarata');
INSERT INTO ubigeo VALUES (1789, '220205', 'Tacna', 'Tarata', 'Heroes Albarracin');
INSERT INTO ubigeo VALUES (1790, '220206', 'Tacna', 'Tarata', 'Estique');
INSERT INTO ubigeo VALUES (1791, '220207', 'Tacna', 'Tarata', 'Estique-Pampa');
INSERT INTO ubigeo VALUES (1792, '220210', 'Tacna', 'Tarata', 'Sitajara');
INSERT INTO ubigeo VALUES (1793, '220211', 'Tacna', 'Tarata', 'Susapaya');
INSERT INTO ubigeo VALUES (1794, '220212', 'Tacna', 'Tarata', 'Tarucachi');
INSERT INTO ubigeo VALUES (1795, '220213', 'Tacna', 'Tarata', 'Ticaco');
INSERT INTO ubigeo VALUES (1796, '220301', 'Tacna', 'Jorge Basadre', 'Locumba');
INSERT INTO ubigeo VALUES (1797, '220302', 'Tacna', 'Jorge Basadre', 'Ite');
INSERT INTO ubigeo VALUES (1798, '220303', 'Tacna', 'Jorge Basadre', 'Ilabaya');
INSERT INTO ubigeo VALUES (1799, '220401', 'Tacna', 'Candarave', 'Candarave');
INSERT INTO ubigeo VALUES (1800, '220402', 'Tacna', 'Candarave', 'Cairani');
INSERT INTO ubigeo VALUES (1801, '220403', 'Tacna', 'Candarave', 'Curibaya');
INSERT INTO ubigeo VALUES (1802, '220404', 'Tacna', 'Candarave', 'Huanuara');
INSERT INTO ubigeo VALUES (1803, '220405', 'Tacna', 'Candarave', 'Quilahuani');
INSERT INTO ubigeo VALUES (1804, '220406', 'Tacna', 'Candarave', 'Camilaca');
INSERT INTO ubigeo VALUES (1805, '230101', 'Tumbes', 'Tumbes', 'Tumbes');
INSERT INTO ubigeo VALUES (1806, '230102', 'Tumbes', 'Tumbes', 'Corrales');
INSERT INTO ubigeo VALUES (1807, '230103', 'Tumbes', 'Tumbes', 'La Cruz');
INSERT INTO ubigeo VALUES (1808, '230104', 'Tumbes', 'Tumbes', 'Pampas de Hospital');
INSERT INTO ubigeo VALUES (1809, '230105', 'Tumbes', 'Tumbes', 'San Jacinto');
INSERT INTO ubigeo VALUES (1810, '230106', 'Tumbes', 'Tumbes', 'San Juan de La Virgen');
INSERT INTO ubigeo VALUES (1811, '230201', 'Tumbes', 'Contralmirante Villar', 'Zorritos');
INSERT INTO ubigeo VALUES (1812, '230202', 'Tumbes', 'Contralmirante Villar', 'Casitas');
INSERT INTO ubigeo VALUES (1813, '230203', 'Tumbes', 'Contralmirante Villar', 'Canoas de Punta Sal');
INSERT INTO ubigeo VALUES (1814, '230301', 'Tumbes', 'Zarumilla', 'Zarumilla');
INSERT INTO ubigeo VALUES (1815, '230302', 'Tumbes', 'Zarumilla', 'Matapalo');
INSERT INTO ubigeo VALUES (1816, '230303', 'Tumbes', 'Zarumilla', 'Papayal');
INSERT INTO ubigeo VALUES (1817, '230304', 'Tumbes', 'Zarumilla', 'Aguas Verdes');
INSERT INTO ubigeo VALUES (1818, '240101', 'Callao', 'Callao', 'Callao');
INSERT INTO ubigeo VALUES (1819, '240102', 'Callao', 'Callao', 'Bellavista');
INSERT INTO ubigeo VALUES (1820, '240103', 'Callao', 'Callao', 'La Punta');
INSERT INTO ubigeo VALUES (1821, '240104', 'Callao', 'Callao', 'Carmen de La Legua');
INSERT INTO ubigeo VALUES (1822, '240105', 'Callao', 'Callao', 'La Perla');
INSERT INTO ubigeo VALUES (1823, '240106', 'Callao', 'Callao', 'Ventanilla');
INSERT INTO ubigeo VALUES (1824, '250101', 'Ucayali', 'Coronel Portillo', 'Calleria');
INSERT INTO ubigeo VALUES (1825, '250102', 'Ucayali', 'Coronel Portillo', 'Yarinacocha');
INSERT INTO ubigeo VALUES (1826, '250103', 'Ucayali', 'Coronel Portillo', 'Masisea');
INSERT INTO ubigeo VALUES (1827, '250104', 'Ucayali', 'Coronel Portillo', 'Campoverde');
INSERT INTO ubigeo VALUES (1828, '250105', 'Ucayali', 'Coronel Portillo', 'Iparia');
INSERT INTO ubigeo VALUES (1829, '250106', 'Ucayali', 'Coronel Portillo', 'Nueva Requena');
INSERT INTO ubigeo VALUES (1830, '250107', 'Ucayali', 'Coronel Portillo', 'Manantay');
INSERT INTO ubigeo VALUES (1831, '250201', 'Ucayali', 'Padre Abad', 'Padre Abad');
INSERT INTO ubigeo VALUES (1832, '250202', 'Ucayali', 'Padre Abad', 'Irazola');
INSERT INTO ubigeo VALUES (1833, '250203', 'Ucayali', 'Padre Abad', 'Curimana');
INSERT INTO ubigeo VALUES (1834, '250301', 'Ucayali', 'Atalaya', 'Raymondi');
INSERT INTO ubigeo VALUES (1835, '250302', 'Ucayali', 'Atalaya', 'Tahuania');
INSERT INTO ubigeo VALUES (1836, '250303', 'Ucayali', 'Atalaya', 'Yurua');
INSERT INTO ubigeo VALUES (1837, '250304', 'Ucayali', 'Atalaya', 'Sepahua');
INSERT INTO ubigeo VALUES (1838, '250401', 'Ucayali', 'Purus', 'Purus');

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) NOT NULL,
  `usua` varchar(255) NOT NULL,
  `contra` varchar(128) NOT NULL,
  `estado_usuario` tinyint(1) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario` (`usua`) USING BTREE,
  KEY `FKusuario15234` (`id_rol`),
  CONSTRAINT `FKusuario15234` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO usuario VALUES (1, 1, 'tormenta', '123', 1, None, 1);
INSERT INTO usuario VALUES (2, 3, 'vendedor_1', '456', 1, None, 0);
INSERT INTO usuario VALUES (3, 3, 'vendedor_2', '567', 1, None, 0);
INSERT INTO usuario VALUES (4, 3, 'vendedor_3', '789', 1, None, 0);
INSERT INTO usuario VALUES (7, 3, 'vendedor_4', '1234', 1, None, 0);
INSERT INTO usuario VALUES (8, 1, 'javier', '123', 1, None, 1);
INSERT INTO usuario VALUES (9, 1, 'angel', '123', 1, '/static/img/image_1.png', 1);
INSERT INTO usuario VALUES (10, 1, 'ricardo', '123', 1, None, 1);
INSERT INTO usuario VALUES (11, 1, 'jamir', '123', 1, None, 1);
INSERT INTO usuario VALUES (12, 1, 'joseph', '123', 1, None, 1);
INSERT INTO usuario VALUES (13, 1, 'fernando', '123', 1, None, 1);
INSERT INTO usuario VALUES (14, 1, 'luis', '123', 1, None, 1);
INSERT INTO usuario VALUES (16, 1, 'Marco', '123', 1, '/app/static/fotos_perfil/Marco.jpg', 1);
INSERT INTO usuario VALUES (17, 2, 'contador_1', '123', 1, '/static/img/image_1.png', 0);
INSERT INTO usuario VALUES (18, 1, 'Tiahuanaco', '123', 1, '/app/static/fotos_perfil/Tiahuanaco.jpg', 0);
INSERT INTO usuario VALUES (19, 1, 'rioja21', '123', 1, None, 1);
INSERT INTO usuario VALUES (20, 2, 'Marco Rioja', '123', 1, '/app/static/fotos_perfil/Marco_Rioja.png', 0);

CREATE TABLE `vehiculo` (
  `placa` varchar(10) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  PRIMARY KEY (`placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO vehiculo VALUES ('ABC123', 'Auto 1');
INSERT INTO vehiculo VALUES ('ABC124', 'Auto 2');
INSERT INTO vehiculo VALUES ('MNO789', 'Moto 1');
INSERT INTO vehiculo VALUES ('PRS432', 'Moto 1');
INSERT INTO vehiculo VALUES ('XYZ456', 'Camion 1');
INSERT INTO vehiculo VALUES ('XYZ786', 'Camion 2');
INSERT INTO vehiculo VALUES ('XYZ900', 'Camion 3');

CREATE TABLE `vendedor` (
  `dni` char(8) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `estado_vendedor` tinyint(1) NOT NULL,
  PRIMARY KEY (`dni`),
  KEY `FKvendedor408505` (`id_usuario`),
  CONSTRAINT `FKvendedor408505` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO vendedor VALUES ('23541234', 3, 'Adrian Pipi', 'Portocarrero Sanchez', '976812344', 1);
INSERT INTO vendedor VALUES ('25713047', 2, 'Javier Pipi', 'Rojas Quiroz', '987654321', 1);
INSERT INTO vendedor VALUES ('26436789', 4, 'Lip Curo', 'Campos', '978654123', 1);
INSERT INTO vendedor VALUES ('26465789', 7, 'Jimena', 'Fernandez', '978631123', 1);
INSERT INTO vendedor VALUES ('45678921', 1, 'Administrador', '', '', 1);

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `id_sucursal` int(11) NOT NULL,
  `id_comprobante` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `estado_venta` tinyint(1) NOT NULL,
  `f_venta` date DEFAULT NULL,
  `igv` decimal(20,6) DEFAULT NULL,
  `monto_total` decimal(20,6) DEFAULT NULL,
  `base_imponible` decimal(20,6) DEFAULT NULL,
  `fecha_iso` varchar(100) DEFAULT NULL,
  `metodo_pago` varchar(250) DEFAULT NULL,
  `estado_sunat` tinyint(1) DEFAULT NULL,
  `id_anular` int(11) DEFAULT NULL,
  `id_anular_b` int(11) DEFAULT NULL,
  `id_venta_boucher` int(11) DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `FKventa598654` (`id_sucursal`),
  KEY `FKventa983495` (`id_comprobante`),
  KEY `FKVenta343434` (`id_cliente`),
  KEY `FKVenta343444` (`id_anular`),
  KEY `FKVenta343446` (`id_anular_b`),
  KEY `FKVenta343455` (`id_venta_boucher`),
  CONSTRAINT `FKVenta343434` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `FKventa598654` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`),
  CONSTRAINT `FKventa983444` FOREIGN KEY (`id_anular`) REFERENCES `anular_sunat` (`id_anular`),
  CONSTRAINT `FKventa983495` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`),
  CONSTRAINT `FKventa983496` FOREIGN KEY (`id_anular_b`) REFERENCES `anular_sunat_b` (`id_anular_b`),
  CONSTRAINT `FKventa983497` FOREIGN KEY (`id_venta_boucher`) REFERENCES `venta_boucher` (`id_venta_boucher`)
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO venta VALUES (325, 1, 371, 3, 2, 2024-11-05, 48.140000, None, None, '2024-11-05T14:43:40.156Z', 'EFECTIVO:315.56', None, 4, 5, 47, '');
INSERT INTO venta VALUES (327, 1, 373, 1, 2, 2024-11-05, 24.120000, 158.120000, None, '2024-11-05T15:14:57.519Z', 'EFECTIVO:158.12', None, 4, 5, 48, '');
INSERT INTO venta VALUES (328, 1, 374, 1, 2, 2024-11-05, 37.080000, 243.080000, None, '2024-11-05T15:17:07.589Z', 'EFECTIVO:243.08', None, 4, 5, 49, '');
INSERT INTO venta VALUES (329, 1, 375, 2, 2, 2024-11-05, 40.350000, None, None, '2024-11-05T15:14:26.248Z', 'EFECTIVO:264.52', None, 4, 5, 50, '');
INSERT INTO venta VALUES (331, 1, 377, 1, 2, 2024-11-05, 10.080000, 66.080000, None, '2024-11-05T15:41:36.662Z', 'EFECTIVO:66.08', None, 4, 5, 51, '');
INSERT INTO venta VALUES (332, 1, 378, 1, 2, 2024-11-05, 48.240000, 316.240000, None, '2024-11-05T15:42:02.323Z', 'EFECTIVO:316.24', None, 4, 5, 52, '');
INSERT INTO venta VALUES (333, 1, 379, 3, 2, 2024-11-05, 96.300000, 631.300000, None, '2024-11-06T02:50:12.797Z', 'EFECTIVO:631.30', None, 4, 5, 53, '');
INSERT INTO venta VALUES (334, 1, 381, 1, 2, 2024-11-05, 124.560000, 816.560000, None, '2024-11-06T04:58:44.744Z', 'EFECTIVO:816.56', None, 4, 5, 54, '');
INSERT INTO venta VALUES (336, 1, 383, 3, 2, 2024-11-06, 99.000000, 649.000000, None, '2024-11-07T02:01:53.408Z', 'EFECTIVO:649.00', None, 4, 5, 56, '');
INSERT INTO venta VALUES (337, 1, 384, 1, 2, 2024-11-19, 66.420000, 435.420000, None, '2024-11-19T16:56:44.655Z', 'EFECTIVO:435.42', None, 4, 5, 57, 'dasdsa');
INSERT INTO venta VALUES (338, 1, 385, 1, 2, 2024-11-19, 62.280000, 408.280000, None, '2024-11-19T17:00:24.558Z', 'EFECTIVO:408.28', None, 4, 5, 58, 'sa');

CREATE TABLE `venta_boucher` (
  `id_venta_boucher` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `nombre_cliente` varchar(255) DEFAULT NULL,
  `documento_cliente` varchar(20) DEFAULT NULL,
  `direccion_cliente` varchar(255) DEFAULT NULL,
  `igv` decimal(10,2) DEFAULT NULL,
  `total_t` decimal(10,2) DEFAULT NULL,
  `comprobante_pago` varchar(255) DEFAULT NULL,
  `totalImporte_venta` decimal(10,2) DEFAULT NULL,
  `descuento_venta` decimal(10,2) DEFAULT NULL,
  `vuelto` decimal(10,2) DEFAULT NULL,
  `recibido` decimal(10,2) DEFAULT NULL,
  `formadepago` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_venta_boucher`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO venta_boucher VALUES (1, 2024-08-13, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 7.63, 50.00, 'Boleta de venta electronica', 42.37, 0.00, 49.00, 99.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (2, 2024-08-13, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 7.63, 50.00, 'Boleta de venta electronica', 42.37, 0.00, 49.00, 99.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (3, 2024-08-14, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 15.25, 100.00, 'Boleta de venta electronica', 84.75, 0.00, 43.00, 143.00, 'EFECTIVO, YAPE');
INSERT INTO venta_boucher VALUES (4, 2024-08-14, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 8.54, 56.00, 'Factura de venta electronica', 47.46, 0.00, 21.00, 77.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (5, 2024-08-14, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 7.63, 50.00, 'Factura de venta electronica', 42.37, 0.00, 27.00, 77.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (6, 2024-08-14, 'Ruben Meladoblas', '73747576', '', 7.63, 50.00, 'Factura de venta electronica', 42.37, 0.00, 27.00, 77.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (7, 2024-08-14, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 7.63, 50.00, 'Boleta de venta electronica', 42.37, 0.00, 16.00, 66.00, 'YAPE');
INSERT INTO venta_boucher VALUES (8, 2024-08-14, 'Empresa VALDOS I.R.L', '10524578961', '', 7.63, 50.00, 'Nota de venta', 42.37, 0.00, 38.00, 88.00, 'YAPE');
INSERT INTO venta_boucher VALUES (9, 2024-08-24, 'Ruben Meladoblas', '73747576', '', 12.20, 79.99, 'Nota de venta', 67.79, 0.00, 0.00, 79.99, 'YAPE');
INSERT INTO venta_boucher VALUES (10, 2024-09-24, '', '', '', 7.63, 50.00, 'Nota de venta', 42.37, 0.00, 0.00, 50.00, 'DEPOSITO CAJA PIURA');
INSERT INTO venta_boucher VALUES (11, 2024-10-01, 'Empresa VALDOS I.R.L', '10524578961', '', 12.20, 79.99, 'Factura de venta electronica', 67.79, 0.00, 0.00, 79.99, 'AMERICAN EXPRESS');
INSERT INTO venta_boucher VALUES (12, 2024-10-20, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 15.25, 92.37, 'Factura de venta electronica', 84.75, 0.00, 0.00, 92.37, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (13, 2024-10-20, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 12.20, 79.99, 'Factura de venta electronica', 67.79, 0.00, 0.00, 79.99, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (14, 2024-10-20, 'Empresa VALDOS I.R.L', '10524578961', '', 10.37, 68.00, 'Factura de venta electronica', 57.63, 0.00, 0.00, 68.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (15, 2024-10-21, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 38.14, 249.99, 'Factura de venta electronica', 211.86, 0.00, 0.00, 249.99, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (16, 2024-10-21, 'Empresa VALDOS I.R.L', '10524578961', '', 8.54, 56.00, 'Nota de venta', 47.46, 0.00, 0.00, 56.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (17, 2024-10-22, 'Empresa VALDOS I.R.L', '10524578961', '', 22.88, 150.00, 'Boleta de venta electronica', 127.12, 0.00, 0.00, 150.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (18, 2024-10-22, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 30.51, 200.00, 'Factura de venta electronica', 169.49, 0.00, 0.00, 200.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (19, 2024-10-22, 'Empresa VALDOS I.R.L', '10524578961', '', 7.63, 50.00, 'Boleta de venta electronica', 42.37, 0.00, 0.00, 50.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (20, 2024-10-22, 'Cliente Varios', '99999999', '', 68.64, 450.00, 'Nota de venta', 381.36, 0.00, 0.00, 450.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (21, 2024-10-22, 'Cliente Varios', '99999999', '', 68.64, 450.00, 'Factura de venta electronica', 381.36, 0.00, 0.00, 450.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (22, 2024-10-22, 'Cliente Varios', '99999999', '', 68.64, 449.95, 'Boleta de venta electronica', 381.31, 0.00, 0.00, 449.95, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (23, 2024-10-22, 'Cliente Varios', '99999999', '', 61.02, 400.00, 'Factura de venta electronica', 338.98, 0.00, 0.00, 400.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (24, 2024-10-22, 'Cliente Varios', '99999999', '', 54.91, 359.96, 'Factura de venta electronica', 305.05, 0.00, 0.00, 359.96, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (25, 2024-10-22, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 54.91, 359.96, 'Boleta de venta electronica', 305.05, 0.00, 0.00, 359.96, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (26, 2024-10-23, 'Empresa VALDOS I.R.L', '10524578961', '', 13.73, 89.99, 'Factura de venta electronica', 76.26, 0.00, 0.00, 89.99, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (27, 2024-10-23, 'Empresa VALDOS I.R.L', '10524578961', '', 53.38, 349.95, 'Factura de venta electronica', 296.57, 0.00, 0.00, 349.95, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (28, 2024-10-26, 'Empresa VALDOS I.R.L', '10524578961', '', 73.21, 479.94, 'Boleta de venta electronica', 406.73, 0.00, 0.00, 479.94, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (29, 2024-10-26, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 61.01, 399.95, 'Boleta de venta electronica', 338.94, 0.00, 0.00, 399.95, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (30, 2024-10-26, 'Cliente Varios', '99999999', '', 7.63, 50.00, 'Factura de venta electronica', 42.37, 0.00, 0.00, 50.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (31, 2024-10-26, 'Empresa VALDOS I.R.L', '10524578961', '', 7.63, 50.00, 'Factura de venta electronica', 42.37, 0.00, 0.00, 50.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (32, 2024-10-26, 'Cliente Varios', '99999999', '', 7.63, 50.00, 'Boleta de venta electronica', 42.37, 0.00, 0.00, 50.00, 'PLIN');
INSERT INTO venta_boucher VALUES (33, 2024-10-26, 'Empresa VALDOS I.R.L', '10524578961', '', 7.63, 50.00, 'Boleta de venta electronica', 42.37, 0.00, 0.00, 50.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (34, 2024-10-26, 'Empresa VALDOS I.R.L', '10524578961', '', 7.63, 50.00, 'Factura de venta electronica', 42.37, 0.00, 0.00, 50.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (35, 2024-10-26, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 13.73, 89.99, 'Factura de venta electronica', 76.26, 0.00, 0.00, 89.99, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (36, 2024-10-26, 'Ruben Meladoblas', '73747576', '', 7.63, 50.00, 'Factura de venta electronica', 42.37, 0.00, 0.00, 50.00, 'PLIN');
INSERT INTO venta_boucher VALUES (37, 2024-10-26, 'Cliente Varios', '99999999', '', 13.73, 89.99, 'Factura de venta electronica', 76.26, 0.00, 0.00, 89.99, 'PLIN');
INSERT INTO venta_boucher VALUES (38, 2024-10-26, 'Cliente Varios', '99999999', '', 10.37, 68.00, 'Boleta de venta electronica', 57.63, 0.00, 0.00, 68.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (39, 2024-10-26, 'Empresa VALDOS I.R.L', '10524578961', '', 30.51, 200.00, 'Factura de venta electronica', 169.49, 0.00, 0.00, 200.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (40, 2024-10-26, 'Cliente Varios', '99999999', '', 30.51, 200.00, 'Factura de venta electronica', 169.49, 0.00, 0.00, 200.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (41, 2024-10-29, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 68.64, 449.95, 'Boleta de venta electronica', 381.31, 0.00, 0.00, 449.95, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (42, 2024-10-29, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 41.18, 269.97, 'Nota de venta', 228.79, 0.00, 0.00, 269.97, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (43, 2024-10-29, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 64.07, 420.00, 'Boleta de venta electronica', 355.93, 0.00, 0.00, 420.00, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (44, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (45, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (46, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (47, 2024-11-05, 'LEYDI VANESSA IDROGO TANTAJULCA', '76070007', '', 51.86, 315.56, 'Factura de venta electronica', 288.10, 0.00, 0.00, 315.56, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (48, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (49, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (50, 2024-11-05, 'Empresa VALDOS I.R.L', '10524578961', '', 44.54, 264.52, 'Factura de venta electronica', 247.44, 0.00, 0.00, 264.52, 'EFECTIVO');
INSERT INTO venta_boucher VALUES (51, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (52, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (53, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (54, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (55, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (56, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (57, None, None, None, None, None, None, None, None, None, None, None, None);
INSERT INTO venta_boucher VALUES (58, None, None, None, None, None, None, None, None, None, None, None, None);


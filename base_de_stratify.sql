CREATE DATABASE STRATIFY character set utf8mb4;;
USE STRATIFY;
-- ------------------------------------------------------------
-- DDL 
-- ------------------------------------------------------------

-- 1. Tipo_documento
CREATE TABLE Tipo_documento (
    idtipo_documento        INT          NOT NULL AUTO_INCREMENT,
    descripcion_tipo_documento VARCHAR(245) NOT NULL,
    PRIMARY KEY (idtipo_documento)
);

-- 2. Tipo_usuario
CREATE TABLE Tipo_usuario (
    idTipo_usuario          INT          NOT NULL AUTO_INCREMENT,
    descripcion_tipo_usuairo VARCHAR(245) NOT NULL,
    PRIMARY KEY (idTipo_usuario)
);

-- 3. Usuario
CREATE TABLE Usuario (
    idUsuario                     INT          NOT NULL AUTO_INCREMENT,
    nombre                        VARCHAR(100) NOT NULL,
    apellido                      VARCHAR(100) NOT NULL,
    clave                         VARCHAR(200) NOT NULL,
    gmail                         VARCHAR(100) NOT NULL,
    numero_documento              INT          NOT NULL,
    Tipo_usuario_idTipo_usuario   INT          NOT NULL,
    Tipo_documento_idtipo_documento INT        NOT NULL,
    PRIMARY KEY (idUsuario),
    CONSTRAINT fk_usuario_tipo_usuario
        FOREIGN KEY (Tipo_usuario_idTipo_usuario)
        REFERENCES Tipo_usuario (idTipo_usuario),
    CONSTRAINT fk_usuario_tipo_documento
        FOREIGN KEY (Tipo_documento_idtipo_documento)
        REFERENCES Tipo_documento (idtipo_documento)
);

-- 4. Unidades_medida
CREATE TABLE Unidades_medida (
    idUnidades_medida          INT          NOT NULL AUTO_INCREMENT,
    descripcion_unidades_medida VARCHAR(245) NOT NULL,
    PRIMARY KEY (idUnidades_medida)
);

-- 5. Proveedor
CREATE TABLE Proveedor (
    idProveedor       INT           NOT NULL AUTO_INCREMENT,
    direccion         VARCHAR(45)   NOT NULL,
    emai_proveedorl   VARCHAR(100)  NOT NULL,
    telefono          INT           NOT NULL,
    PRIMARY KEY (idProveedor)
);

-- 6. Estado_Local
CREATE TABLE Estado_Local (
    idEstado_Local         INT         NOT NULL AUTO_INCREMENT,
    descripcionEstado_loc  VARCHAR(45) NOT NULL,
    PRIMARY KEY (idEstado_Local)
);

-- 7. Local
CREATE TABLE Local (
    idUbicacion              INT          NOT NULL AUTO_INCREMENT,
    codigoLocal              VARCHAR(45)  NOT NULL,
    descripcionLocal         VARCHAR(45)  NOT NULL,
    direccion                VARCHAR(100) NOT NULL,
    telefono                 VARCHAR(100) NOT NULL,
    Estado_Local_idEstado_Local INT       NOT NULL,
    PRIMARY KEY (idUbicacion),
    CONSTRAINT fk_local_estado
        FOREIGN KEY (Estado_Local_idEstado_Local)
        REFERENCES Estado_Local (idEstado_Local)
);

-- 8. Producto
CREATE TABLE Producto (
    idProducto                         INT            NOT NULL AUTO_INCREMENT,
    codigo_producto                    INT            NOT NULL,
    nombre_producto                    VARCHAR(100)   NOT NULL,
    cantidad_producto                  INT            NOT NULL,
    costo_unitario                     DECIMAL(12,2)  NOT NULL,
    fecha_ingreso                      DATE           NOT NULL,
    fecha_vencimiento                  DATE,
    fecha_retiro                       DATE,
    Proveedor_idProveedor              INT            NOT NULL,
    Unidades_medida_idunidades_medida  INT            NOT NULL,
    Local_idUbicacion                  INT            NOT NULL,
    PRIMARY KEY (idProducto),
    CONSTRAINT fk_producto_proveedor
        FOREIGN KEY (Proveedor_idProveedor)
        REFERENCES Proveedor (idProveedor),
    CONSTRAINT fk_producto_unidad
        FOREIGN KEY (Unidades_medida_idunidades_medida)
        REFERENCES Unidades_medida (idUnidades_medida),
    CONSTRAINT fk_producto_local
        FOREIGN KEY (Local_idUbicacion)
        REFERENCES Local (idUbicacion)
);

-- 9. Inventario
CREATE TABLE Inventario (
    idInventario         INT  NOT NULL AUTO_INCREMENT,
    stockActual          INT  NOT NULL,
    stcokMinimo          INT  NOT NULL,
    fecha_actualizacion  DATE NOT NULL,
    Producto_idProducto  INT  NOT NULL,
    PRIMARY KEY (idInventario),
    CONSTRAINT fk_inventario_producto
        FOREIGN KEY (Producto_idProducto)
        REFERENCES Producto (idProducto)
);

-- 10. Metodo_de_pago
CREATE TABLE Metodo_de_pago (
    idMetodo_de_pago   INT          NOT NULL AUTO_INCREMENT,
    descripcion_metodo VARCHAR(245) NOT NULL,
    PRIMARY KEY (idMetodo_de_pago)
);

-- 11. Cabeza_Factura
CREATE TABLE Cabeza_Factura (
    idFactura        INT           NOT NULL AUTO_INCREMENT,
    numero_factura   INT           NOT NULL,
    fecha_emision    DATE          NOT NULL,
    totalFactura     DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idFactura)
);

-- 12. Detalle_Factura
CREATE TABLE Detalle_Factura (
    idVenta                  INT           NOT NULL AUTO_INCREMENT,
    cantidad                 INT           NOT NULL,
    subtotal_fact            DECIMAL(10,2) NOT NULL,
    Cabeza_Factura_idFactura INT           NOT NULL,
    Producto_idProducto      INT           NOT NULL,
    PRIMARY KEY (idVenta),
    CONSTRAINT fk_detalle_cabeza
        FOREIGN KEY (Cabeza_Factura_idFactura)
        REFERENCES Cabeza_Factura (idFactura),
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (Producto_idProducto)
        REFERENCES Producto (idProducto)
);

-- 13. Pago
CREATE TABLE Pago (
    idpago                        INT          NOT NULL AUTO_INCREMENT,
    referncia_pago                VARCHAR(100) NOT NULL,
    Metodo_de_pago_idMetodo_de_pago INT        NOT NULL,
    Cabeza_Factura_idFactura       INT         NOT NULL,
    PRIMARY KEY (idpago),
    CONSTRAINT fk_pago_metodo
        FOREIGN KEY (Metodo_de_pago_idMetodo_de_pago)
        REFERENCES Metodo_de_pago (idMetodo_de_pago),
    CONSTRAINT fk_pago_factura
        FOREIGN KEY (Cabeza_Factura_idFactura)
        REFERENCES Cabeza_Factura (idFactura)
);


-- ============================================================
-- DML 
-- ============================================================

-- 1. Tipo_documento
INSERT INTO Tipo_documento (descripcion_tipo_documento) VALUES
    ('Cédula de Ciudadanía'),
    ('Tarjeta de Identidad'),
    ('Pasaporte'),
    ('NIT');

-- 2. Tipo_usuario
INSERT INTO Tipo_usuario (descripcion_tipo_usuairo) VALUES
    ('Administrador'),
    ('Vendedor'),
    ('Bodeguero'),
    ('Cliente');

-- 3. Usuario
INSERT INTO Usuario (nombre, apellido, clave, gmail, numero_documento,
                     Tipo_usuario_idTipo_usuario, Tipo_documento_idtipo_documento) VALUES
    ('Carlos',   'Ramírez',  'clave123',  'carlos.ramirez@mail.com',  1023456789, 1, 1),
    ('Laura',    'Gómez',    'clave456',  'laura.gomez@mail.com',     987654321,  2, 1),
    ('Andrés',   'Torres',   'clave789',  'andres.torres@mail.com',   112233445,  3, 1),
    ('Patricia', 'Morales',  'clave000',  'patricia.morales@mail.com',556677889,  4, 2);

-- 4. Unidades_medida
INSERT INTO Unidades_medida (descripcion_unidades_medida) VALUES
    ('Litro'),
    ('Unidad'),
    ('Caja');
    

-- 5. Proveedor
INSERT INTO Proveedor (direccion, emai_proveedorl, telefono) VALUES
    ('Calle 10 # 5-20, Bogotá',    'prov1@empresa.com',  3001234567),
    ('Carrera 45 # 12-30, Medellín','prov2@empresa.com', 3019876543),
    ('Av. 68 # 30-15, Bogotá',     'prov3@empresa.com',  3024567890),
    ('Calle 50 # 8-10, Cali',      'prov4@empresa.com',  3038765432);

-- 6. Estado_Local
INSERT INTO Estado_Local (descripcionEstado_loc) VALUES
    ('Abierto'),
    ('Cerrado');

-- 7. Local
INSERT INTO Local (codigoLocal, descripcionLocal, direccion, telefono, Estado_Local_idEstado_Local) VALUES
    ('L001', 'Bodega Norte',   'Calle 80 # 20-10, Bogotá',    '6011234567', 1),
    ('L002', 'Bodega Sur',     'Carrera 30 # 5-40, Bogotá',   '6019876543', 1),
    ('L003', 'Punto de Venta', 'Av. Jiménez # 7-50, Bogotá',  '6024561234', 1),
    ('L004', 'Almacén Centro', 'Calle 19 # 3-20, Bogotá',     '6031239876', 2);

-- 8. Producto
INSERT INTO Producto (codigo_producto, nombre_producto, cantidad_producto, costo_unitario,
                      fecha_ingreso, fecha_vencimiento, fecha_retiro,
                      Proveedor_idProveedor, Unidades_medida_idunidades_medida, Local_idUbicacion) VALUES
    (1001, 'lager x24',       200, 12500.00, '2025-01-10', '2026-01-10', NULL, 1, 1, 1),
    (1002, ' 1L',     150,  8900.00, '2025-02-15', '2026-02-15', NULL, 2, 2, 2),
    (1003, 'poker 330',     80, 15300.00, '2025-03-05', NULL,         NULL, 3, 3, 3),
    (1004, ' lager x4',   300,  9800.00, '2025-03-20', NULL,         NULL, 4, 4, 1),
    (1005, 'Aguila',       500,  3200.00, '2025-04-01', '2025-05-01', NULL, 2, 2, 2);

-- 9. Inventario
INSERT INTO Inventario (stockActual, stcokMinimo, fecha_actualizacion, Producto_idProducto) VALUES
    (200, 20, '2025-04-10', 1),
    (150, 15, '2025-04-10', 2),
    ( 80, 10, '2025-04-10', 3),
    (300, 30, '2025-04-10', 4),
    (500, 50, '2025-04-10', 5);

-- 10. Metodo_de_pago
INSERT INTO Metodo_de_pago (descripcion_metodo) VALUES
    ('Efectivo'),
    ('Tarjeta de Crédito'),
    ('Tarjeta de Débito'),
    ('Transferencia Bancaria'),
    ('Nequi / Daviplata');

-- 11. Cabeza_Factura
INSERT INTO Cabeza_Factura (numero_factura, fecha_emision, totalFactura) VALUES
    (1001, '2025-04-10', 125000.00),
    (1002, '2025-04-11',  89000.00),
    (1003, '2025-04-12', 214500.00),
    (1004, '2025-04-13',  32000.00);

-- 12. Detalle_Factura
INSERT INTO Detalle_Factura (cantidad, subtotal_fact, Cabeza_Factura_idFactura, Producto_idProducto) VALUES
    (5,  62500.00, 1, 1),
    (3,  26700.00, 1, 2),
    (2,  30600.00, 2, 3),
    (6,  58800.00, 2, 4),
    (10, 32000.00, 3, 5),
    (12, 117600.00,3, 4),
    (10, 32000.00, 4, 5);

-- 13. Pago
INSERT INTO Pago (referncia_pago, Metodo_de_pago_idMetodo_de_pago, Cabeza_Factura_idFactura) VALUES
    ('REF-20250410-001', 1, 1),
    ('REF-20250411-002', 2, 2),
    ('REF-20250412-003', 4, 3),
    ('REF-20250413-004', 5, 4);



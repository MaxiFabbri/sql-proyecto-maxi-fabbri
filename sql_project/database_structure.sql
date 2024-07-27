-- GENERAR EL DDL

DROP DATABASE IF EXISTS merchanmanager;

CREATE DATABASE merchanmanager;

USE merchanmanager;

-- Tabla REMITO
CREATE TABLE remito(
	id_remito INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_usuario INT NOT NULL,
    numero_remito VARCHAR(15) NOT NULL DEFAULT 'R00001-00000001',
    fecha  DATE NOT NULL DEFAULT (CURRENT_DATE),
	transporte VARCHAR(245),
	detalle VARCHAR(245),
    PRIMARY KEY(id_remito)
);

-- Tabla ITEM_REMITO
CREATE TABLE item_remito(
	id_item_remito INT NOT NULL AUTO_INCREMENT,
    id_remito INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
	producto VARCHAR(245),
    PRIMARY KEY(id_item_remito)
);

-- Tabla PAIS
CREATE TABLE pais(
	id_pais INT NOT NULL AUTO_INCREMENT,
    nombre_pais VARCHAR(80),
	PRIMARY KEY(id_pais)
);

-- Tabla CLIENTE
CREATE TABLE cliente(
	id_cliente INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(245),
    cuit VARCHAR(13) UNIQUE,
    domicilio VARCHAR(245),
    id_pais INT,
    contacto VARCHAR(245),
	email VARCHAR(245),
    telefono VARCHAR(100),
    activo BOOL NOT NULL DEFAULT("1"),
    PRIMARY KEY(id_cliente)
);

-- Tabla PROVEEDOR
CREATE TABLE proveedor(
	id_proveedor INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(245),
    cuit VARCHAR(13) UNIQUE,
    domicilio VARCHAR(245),
	id_pais INT,
    contacto VARCHAR(245),
	email VARCHAR(245),
    telefono VARCHAR(100),
    activo BOOL NOT NULL DEFAULT("1"),
    PRIMARY KEY(id_proveedor)
);

-- Tabla ROL_USUARIO
CREATE TABLE rol_usuario(
	id_rol INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    descripcion VARCHAR(245),
    PRIMARY KEY(id_rol)
);

-- Tabla USUARIO
CREATE TABLE usuario(
	id_usuario INT NOT NULL AUTO_INCREMENT,
	id_rol INT NOT NULL,
    nombre VARCHAR(245),
    password VARCHAR(50),
	email VARCHAR(245),
    telefono VARCHAR(30),
    PRIMARY KEY(id_usuario)
);

-- Tabla ESTADO_PEDIDO
CREATE TABLE estado_pedido(
	id_estado_pedido INT NOT NULL AUTO_INCREMENT,
    estado_pedido VARCHAR(50),
    PRIMARY KEY(id_estado_pedido)
);

-- Tabla CONDICION_COBRO
CREATE TABLE condicion_cobro(
	id_condicion_cobro INT NOT NULL AUTO_INCREMENT,
    descripcion VARCHAR(245),
    dias_promedio INT,
    PRIMARY KEY(id_condicion_cobro)
);

-- Tabla PEDIDO
CREATE TABLE pedido(
	id_pedido INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_usuario INT NOT NULL,
    id_estado_pedido INT NOT NULL DEFAULT 1,
    fecha_inicio DATE NOT NULL DEFAULT(current_date),
	fecha_entrega DATE,
    tipo_cambio DECIMAL(10,2) NOT NULL DEFAULT("935.5"),
    cantidad INT NOT NULL,
	precio_unitario DECIMAL(10,2),
    id_condicion_cobro INT,
    observaciones VARCHAR(245),
    PRIMARY KEY(id_pedido)
);

-- Tabla ESTADO_ITEM
CREATE TABLE estado_item(
	id_estado_item INT NOT NULL AUTO_INCREMENT,
    estado_item VARCHAR(50),
    PRIMARY KEY(id_estado_item)
);

-- Tabla ITEM
CREATE TABLE item(
	id_item INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_proveedor INT NOT NULL,
    id_usuario INT NOT NULL,
    id_estado_item INT NOT NULL DEFAULT 1,
    detalle VARCHAR(245),
    costo_unitario DECIMAL(10,2),
    PRIMARY KEY(id_item)
);

-- Tabla MOVIMIENTO_PEDIDO
CREATE TABLE movimiento_pedido(
	id_movimiento_pedido INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT(current_timestamp),
    descripcion VARCHAR(245),
    id_estado_pedido INT NOT NULL,
    PRIMARY KEY(id_movimiento_pedido)
);

-- Tabla MOVIMIENTO_ITEM
CREATE TABLE movimiento_item(
	id_movimiento_item INT NOT NULL AUTO_INCREMENT,
    id_item INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT(current_timestamp),
    descripcion VARCHAR(245),
    id_estado_item INT NOT NULL,
    PRIMARY KEY(id_movimiento_item)
);


-- FOREIGN KEYS DEFINITIONS

-- REMITO
ALTER TABLE remito
	ADD CONSTRAINT fk_remito_pedido
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;

ALTER TABLE remito
    ADD CONSTRAINT fk_remito_usuario
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;

-- ITEM_REMITO    
ALTER TABLE item_remito
	ADD CONSTRAINT fk_item_remito_remito
    FOREIGN KEY(id_remito) REFERENCES remito(id_remito);

-- CLIENTE
ALTER TABLE cliente
	ADD CONSTRAINT fk_cliente_pais
    FOREIGN KEY(id_pais) REFERENCES pais(id_pais)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
-- PROVEEDOR
ALTER TABLE proveedor
	ADD CONSTRAINT fk_proveedor_pais
    FOREIGN KEY(id_pais) REFERENCES pais(id_pais)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;    

-- USUARIO
ALTER TABLE usuario
	ADD CONSTRAINT fk_usuario_rol
    FOREIGN KEY(id_rol) REFERENCES rol_usuario(id_rol)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;

-- PEDIDO
ALTER TABLE pedido
	ADD CONSTRAINT fk_pedido_cliente
    FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
ALTER TABLE pedido    
    ADD CONSTRAINT fk_pedido_usuario
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
ALTER TABLE pedido    
    ADD CONSTRAINT fk_pedido_estado_pedido
    FOREIGN KEY(id_estado_pedido) REFERENCES estado_pedido(id_estado_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;

ALTER TABLE pedido
	ADD CONSTRAINT fk_pedido_condicion_cobro
    FOREIGN KEY(id_condicion_cobro) REFERENCES condicion_cobro(id_condicion_cobro)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;    

-- ITEM
ALTER TABLE item
	ADD CONSTRAINT fk_item_pedido
    FOREIGN KEY(id_pedido) REFERENCES pedido(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
 ALTER TABLE item   
	ADD CONSTRAINT fk_item_proveedor
    FOREIGN KEY(id_proveedor) REFERENCES proveedor(id_proveedor)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
	
ALTER TABLE item  
  ADD CONSTRAINT fk_item_usuario
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
ALTER TABLE item    
	ADD CONSTRAINT fk_item_estado_item
    FOREIGN KEY(id_estado_item) REFERENCES estado_item(id_estado_item)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
   
-- MOVIMIENTO_PEDIDO    
ALTER TABLE movimiento_pedido
	ADD CONSTRAINT fk_movimiento_pedido_pedido
    FOREIGN KEY(id_pedido) REFERENCES pedido(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
    ALTER TABLE movimiento_pedido
	ADD CONSTRAINT fk_movimiento_pedido_usuario
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
ALTER TABLE movimiento_pedido
	ADD CONSTRAINT fk_movimiento_pedido_estado
    FOREIGN KEY(id_estado_pedido) REFERENCES estado_pedido(id_estado_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
    
-- MOVIMIENTO_ITEM
ALTER TABLE movimiento_item
	ADD CONSTRAINT fk_movimiento_items_item
    FOREIGN KEY(id_item) REFERENCES item(id_item)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
    ALTER TABLE movimiento_item
	ADD CONSTRAINT fk_movimiento_items_usuario
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;
    
ALTER TABLE movimiento_item    
	ADD CONSTRAINT fk_movimiento_item_estado
    FOREIGN KEY(id_estado_item) REFERENCES estado_item(id_estado_item)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ;

-- mysql -u root -p --local-infile=1
-- source init.sql

SET GLOBAL local_infile = true;


LOAD DATA LOCAL INFILE './data/Proveedores_Quattrum_Modif.csv' 
INTO TABLE merchanmanager.proveedor 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   nombre
,   cuit
,   domicilio
,   contacto
,   email
,   telefono
,   id_pais
,   activo
);

LOAD DATA LOCAL INFILE './data/Clientes_Quattrum_Modif.csv' 
INTO TABLE merchanmanager.cliente 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   nombre
,   cuit
,   domicilio
,   id_pais
,   contacto
,   email
,   telefono 
,   activo
);

LOAD DATA LOCAL INFILE './data/pedidos.csv' 
INTO TABLE merchanmanager.pedido 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   id_cliente
,   id_usuario
,   id_estado_pedido
,   fecha_inicio
,   fecha_entrega
,   tipo_cambio
,   cantidad 
,   precio_unitario
,   id_condicion_cobro
,   observaciones
);

LOAD DATA LOCAL INFILE './data/item.csv' 
INTO TABLE merchanmanager.item 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   id_pedido
,   id_proveedor
,   id_usuario
,   id_estado_item
,   detalle
,   costo_unitario
);

LOAD DATA LOCAL INFILE './data/remito.csv' 
INTO TABLE merchanmanager.remito 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   id_pedido
,   id_usuario
,   numero_remito
,   fecha
,   transporte
,   detalle
);

LOAD DATA LOCAL INFILE './data/item_remito.csv' 
INTO TABLE merchanmanager.item_remito 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   id_remito
,   cantidad
,	producto
);

LOAD DATA LOCAL INFILE './data/movimiento_pedido.csv' 
INTO TABLE merchanmanager.movimiento_pedido
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   id_pedido,
	id_usuario,
    descripcion,
    id_estado_pedido
);

LOAD DATA LOCAL INFILE './data/movimiento_item.csv' 
INTO TABLE merchanmanager.movimiento_item
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(   id_item,
	id_usuario,
    descripcion,
    id_estado_item
);
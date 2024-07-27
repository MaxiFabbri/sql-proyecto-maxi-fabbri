USE merchanmanager;

CREATE OR REPLACE VIEW
merchanmanager.view_pedidos_activos
AS (

SELECT
    c.nombre AS 'Cliente',
    e.estado_pedido AS 'Estado',
    fecha_entrega AS 'Entrega',
    cantidad AS 'Cantidad',
    observaciones
FROM merchanmanager.pedido AS p

JOIN merchanmanager.cliente AS c
	ON p.id_cliente = c.id_cliente
JOIN merchanmanager.estado_pedido AS e
	ON p.id_estado_pedido = e.id_estado_pedido
WHERE p.id_estado_pedido < 9
ORDER BY p.id_estado_pedido ASC
);

CREATE OR REPLACE VIEW
merchanmanager.view_remitos_cliente
AS (

SELECT
	r.fecha AS 'Fecha'
,   r.numero_remito AS 'Numero'
,   c.nombre AS 'Cliente'
,	p.id_pedido AS 'Numero Pedido'
,	i.cantidad AS 'Cantidad'
,   i.producto AS 'Producto'
,   r.transporte AS 'Transporte'
,   r.detalle AS 'Detalle'
   
FROM merchanmanager.remito AS r

JOIN merchanmanager.item_remito AS i
	ON r.id_remito = i.id_remito
JOIN merchanmanager.pedido AS p
	ON r.id_pedido = p.id_pedido
JOIN merchanmanager.cliente AS c
	ON c.id_cliente = p.id_cliente
WHERE p.id_estado_pedido < 8
ORDER BY p.id_pedido ASC
);

CREATE OR REPLACE VIEW
merchanmanager.view_pedidos_pesos
AS (
SELECT
	p.id_pedido AS 'Pedido',
    c.id_cliente AS 'Cliente',
    p.cantidad AS 'Cantidad',
    merchanmanager.pasar_a_pesos(p.id_pedido, p.precio_unitario) AS 'Precio Unitario',
    merchanmanager.pedidos_pesos(p.tipo_cambio, p.cantidad, p.precio_unitario) AS 'Total en Pesos'
FROM
	merchanmanager.pedido AS p
    JOIN merchanmanager.cliente AS c
		ON p.id_cliente = c.id_cliente
 );

CREATE OR REPLACE VIEW
merchanmanager.view_entregas_pedidos
AS (
SELECT
	p.id_pedido AS 'Pedido',
    i.producto AS 'Producto',
    i.cantidad AS 'Cantidad',
	r.numero_remito AS 'Remito'
    
FROM
	merchanmanager.pedido AS p
    JOIN merchanmanager.remito AS r
		ON p.id_pedido = r.id_pedido
	JOIN merchanmanager.item_remito AS i
		ON r.id_remito = i.id_remito
ORDER BY
	Pedido ASC, Producto ASC
 );
 
CREATE OR REPLACE VIEW
merchanmanager.view_items_por_proveedor
AS (
SELECT 
	p.nombre AS 'Proveedor',
    i.id_item AS 'Item',
    e.estado_item AS 'Estado',
    i.detalle AS 'Detalle',
    merchanmanager.pasar_a_pesos(i.id_pedido, i.costo_unitario) AS 'Costo en Pesos'
    
FROM merchanmanager.item AS i
JOIN merchanmanager.proveedor AS p
	ON i.id_proveedor = p.id_proveedor
JOIN merchanmanager.estado_item AS e
	ON i.id_estado_item = e.id_estado_item
WHERE i.id_estado_item < 6 AND i.id_estado_item != 2
ORDER BY i.id_proveedor
 );
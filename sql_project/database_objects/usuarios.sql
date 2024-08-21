DROP USER IF EXISTS 'socios'@'%';
CREATE USER 'socios'@'%' IDENTIFIED BY 'socios123';
GRANT ALL ON *.* TO 'socios'@'%';


DROP USER IF EXISTS 'admin'@'%';
CREATE USER 'admin'@'%' IDENTIFIED BY 'admin123';
GRANT SELECT ON merchanmanager.* TO 'admin'@'%';
GRANT SELECT, INSERT ON merchanmanager.movimiento_item TO 'admin'@'%';
GRANT SELECT, INSERT ON merchanmanager.movimiento_pedido TO 'admin'@'%';


DROP USER IF EXISTS 'ventas'@'%';
CREATE USER 'ventas'@'%' IDENTIFIED BY 'ventas123';
GRANT SELECT ON merchanmanager.view_entregas_pedidos TO 'ventas'@'%';
GRANT SELECT ON merchanmanager.view_items_por_proveedor TO 'ventas'@'%';
GRANT SELECT ON merchanmanager.view_pedidos_activos TO 'ventas'@'%';
GRANT SELECT ON merchanmanager.view_pedidos_pesos TO 'ventas'@'%';
GRANT SELECT ON merchanmanager.view_remitos_cliente TO 'ventas'@'%';

SHOW GRANTS FOR 'socios'@'%';



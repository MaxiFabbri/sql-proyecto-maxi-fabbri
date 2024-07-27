USE merchanmanager;

DROP PROCEDURE IF EXISTS merchanmanager.consulta_pedido_por_estado;

DELIMITER //

CREATE PROCEDURE consulta_pedido_por_estado (
  IN new_estado_pedido VARCHAR(50)
)
BEGIN
	DECLARE estado_num INT;
    
    SET estado_num = merchanmanager.devuelve_id_estado_pedido(new_estado_pedido);
	
    SET @clausula = CONCAT('
		SELECT
			c.nombre AS "Cliente",
			e.estado_pedido AS "Estado",
			fecha_entrega AS "Entrega",
			cantidad AS "Cantidad",
			observaciones
		FROM merchanmanager.pedido AS p
		JOIN merchanmanager.cliente AS c
			ON p.id_cliente = c.id_cliente
		JOIN merchanmanager.estado_pedido AS e
			ON p.id_estado_pedido = e.id_estado_pedido
		WHERE p.id_estado_pedido = ', estado_num,'
		ORDER BY p.id_estado_pedido ASC'
	);
    
    PREPARE runSQL FROM @clausula;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
END //

DELIMITER ;



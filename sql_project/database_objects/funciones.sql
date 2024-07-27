
USE merchanmanager;

DROP FUNCTION IF EXISTS pedidos_pesos;
DROP FUNCTION IF EXISTS devuelve_id_estado_pedido;
DROP FUNCTION IF EXISTS pasar_a_pesos;

-- CREACION DE LA FUNCION QUE DEVUELVE EL PRECIO DEL PEDIDO EN PESOS EN FORMATO STRING
DELIMITER //

CREATE FUNCTION pedidos_pesos (tipo_cambio DECIMAL(10,2), cantidad INT, precio_unitario DECIMAL(10,2)) RETURNS VARCHAR(50)
    DETERMINISTIC
    READS SQL DATA
BEGIN
	SET @total_pesos = (cantidad * precio_unitario * tipo_cambio);
    SET @total_en_texto = CONCAT('$ ', FORMAT(@total_pesos, 2));
    RETURN @total_en_texto;
END //
DELIMITER ;

-- CREACION FUNCION QUE DEVUELVA EL ESTADO DEL PEDIDO RECIVIENDO UN TEXTO
DELIMITER //
CREATE FUNCTION devuelve_id_estado_pedido
(texto_estado VARCHAR(50))
	RETURNS INT
    DETERMINISTIC
    READS SQL DATA
BEGIN
	DECLARE estado_num INT;

	IF texto_estado != '' THEN
		SET @new_texto_estado = CONCAT(texto_estado, '%');
		SELECT id_estado_pedido INTO estado_num
			FROM estado_pedido
			WHERE estado_pedido LIKE @new_texto_estado;
	ELSE
		SET estado_num = 0 ;
	END IF;
    RETURN estado_num;
END //

DELIMITER ;

-- FUNCION PARA PASAR A PESOS
-- CREACION FUNCION CONVIERTE A PESOS DEPENDIENDO DEL TC DEL PEDIDO

DELIMITER //
CREATE FUNCTION pasar_a_pesos
(pedido INT,  precio_en_dolares DECIMAL(10,2))
	RETURNS DECIMAL (14,2)
    DETERMINISTIC
    READS SQL DATA

BEGIN
	DECLARE tipo_de_cambio DECIMAL(10,2);
	DECLARE total_en_pesos DECIMAL(14,2);

	SELECT tipo_cambio INTO tipo_de_cambio FROM pedido WHERE id_pedido = pedido;
	SET total_en_pesos = tipo_de_cambio * precio_en_dolares;
    RETURN total_en_pesos;
END //

DELIMITER ;

USE merchanmanager;
-- TRIGGER CUANDO SE INSERTA UN MOVIMIENTO EN LA TABLA movimiento_pedido
DROP TRIGGER IF EXISTS `tr_add_movimiento_pedido`;

DELIMITER //
CREATE TRIGGER `tr_add_movimiento_pedido`
BEFORE INSERT ON `movimiento_pedido`
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM merchanmanager.estado_pedido WHERE id_estado_pedido = NEW.id_estado_pedido) THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El Estado de pedido no existe.';
 	END IF; 
    
	UPDATE merchanmanager.pedido 
    SET id_estado_pedido = NEW.id_estado_pedido 
    WHERE id_pedido = NEW.id_pedido; 
END //
DELIMITER ;

-- TRIGGER CUANDO SE INSERTA UN MOVIMIENTO EN LA TABLA movimiento_item
DROP TRIGGER IF EXISTS `tr_add_movimiento_item`;

DELIMITER //
CREATE TRIGGER `tr_add_movimiento_item`
BEFORE INSERT ON `movimiento_item`
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM merchanmanager.estado_item WHERE id_estado_item = NEW.id_estado_item) THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El Estado de item no existe.';
 	END IF; 

	UPDATE merchanmanager.item 
    SET id_estado_item = NEW.id_estado_item 
    WHERE id_item = NEW.id_item; 
END //
DELIMITER ;

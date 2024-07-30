USE merchanmanager;

-- INSERT DATA
-- ROL_USUARIO
INSERT INTO merchanmanager.rol_usuario
(nombre, descripcion)
VALUE
("admin", "Administrador"),
("vendedor", "Vendedor"),
("produccion", "Producción"),
("logistica", "Logistica")
;

-- USUARIOS
insert into merchanmanager.usuario
(id_rol, nombre, password, email, telefono)
values
(1, 'Natividad', 'xC5`JMvV', 'nescalera0@shop-pro.jp', '(806) 1196691'),
(1, 'Phylis', 'iR6\#>#W1DQ9*M|', 'pjumont1@chicagotribune.com', '(281) 5204105'),
(1, 'Sydelle', 'lN5}WzIC?a', 'scollcott2@europa.eu', '(328) 2255062'),
(2, 'Fredrick', 'xT2}Lhi`19e', 'fpelerin3@purevolume.com', '(992) 9933846'),
(2, 'Sara-ann', 'zU2?J2}FGAl', 'sverdey4@google.com.au', '(378) 7855184'),
(2, 'Helen-elizabeth', 'fU3`A,>$', 'hcampione5@i2i.jp', '(470) 9916102'),
(2, 'Jorry', 'aF4|Y3lU|fyp!5z', 'jjervois6@meetup.com', '(226) 5893852'),
(2, 'Wolfgang', 'mK3@<c7r",.', 'whundall7@free.fr', '(803) 6256483'),
(2, 'Koralle', 'qJ5`MT@Qasd7RZ', 'kenrrico8@state.gov', '(759) 6457084'),
(3, 'Duke', 'wP8*3GAok4M', 'dblatcher9@mediafire.com', '(621) 5302762'),
(3, 'Hirsch', 'xB3><A91|sNMo=', 'hdymicka@forbes.com', '(513) 4747996'),
(3, 'Alvin', 'rU2&&*ahAj', 'aclayworthb@phpbb.com', '(723) 5432602'),
(4, 'Johnny', 'fP8$FRWavq''', 'jcawc@youtu.be', '(701) 6117551'),
(4, 'Muriel', 'aT1_U(#r/.N@,io6', 'mugolettid@weebly.com', '(750) 3501616'),
(4, 'Gerrilee', 'xO8|*Oyw"Of*Knek', 'gelcomej@statcounter.com', '(997) 1893264');

-- ESTADO_PEDIDO
INSERT INTO merchanmanager.estado_pedido
(estado_pedido)
VALUES
("Confirmado"),
("Facturado"),
("Cobrado Anticipo"),
("Archivos Aprobados"),
("En Producción"),
("Terminado"),
("Entregado"),
("Cerrado"),
("Anulado");

-- ESTADO_ITEM
INSERT INTO merchanmanager.estado_item
(estado_item)
VALUES
("Confirmado"),
("Anulado"),
("En el Proveedor"),
("Pagado"),
("Terminado, Para retirar"),
("Retirado");

INSERT INTO merchanmanager.pais
(nombre_pais)
VALUE
("Argentina"),
("Chipre"),
("Uruguay"),
("Chile"),
("Paraguay"),
("Bolivia")
;

INSERT INTO merchanmanager.condicion_cobro
(descripcion, dias_promedio)
VALUE
("50% Anticipo y 50% contra entrega", 8),
("50% Anticipo y 50% a 15 dias", 15),
("50% Anticipo y 50% a 30 dias", 23),
("Contra Entrega", 15),
("a 15 dias", 30),
("a 30 dias", 45)
;
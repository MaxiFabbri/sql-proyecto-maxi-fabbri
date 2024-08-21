## Alumno: Maximiliano Fabbri

### Curso: Coderhouse - SQL

### Comision: 57190

### Proyecto: Merchanmanger

Detalle: Base de Datos para seguimiento de trabajos de una empresa de Merchandising

Los trabajos estan compuestos por un pedido, que tiene uno o más items, La base de datos, debe reflejar el estado de tanto los Items, como los Pedidos en general.
Registrando que usuario hace el cambio de estado en cada caso.
Tambien debe registrar los Remitos generados para cada pedido.

#### Instalación:
## Como levantar el proyecto en CodeSpaces GitHub
* env: Archivo con contraseñas y data secretas
* Makefile: Abstracción de creacción del proyecto
* docker-compose.yml: Permite generar las bases de datos en forma de contenedores

#### Pasos para arrancar el proyecto

* En la terminal de VisualStudio escribir :
    - `make` _si te da un error de que no conexion al socket, volver al correr el comando `make`_
   
## Como Crear la DB y sus elemento y poblarla Manualmente

- 1 Ejecutar: `database_structure.sql`
- 2 Ejecutar: `.\database_objects\funciones.sql`
- 3 Ejecutar: `.\database_objects\views.sql`
- 4 Ejecutar: `.\database_objects\stored_procedures.sql`
- 5 Ejecutar: `.\database_objects\triggers.sql`
- 6 Ejecutar: `carga_datos-por-script`
- 7 Abrir una consola en `.\sql_project\`
- 8 Ejecutar: `mysql -u root -p --local-infile=1`
- 9 Ejecutar: `source carga-datos-por-csv.sql`

#### TABLAS:
- remito: Registra los datos generales del remito.
- item_remito: Registra los items remitidos y su cantidad.
- cliente: Datos completos de los clientes.
- proveedor: Datos completos de los proveedores.
- rol_usuario: Registra los roles de usuario.
- usuario: Registra los usuarios.
- estado_pedido: Incluye todos los posibles estados en que pueden estar los pedidos.
- condicion_cobro: Lista de condiciones de cobro.
- pedido: Registra los datos genereales del pedido y su estado.
- estado_item: Incluye todos los posibles estados en que pueden estar los items.
- items: Detalle de cada item incluido en el pedido, los items, pueden ser productos o servicios a incluir en el producto (impresión, grabado, bordado, etc.).
- movimiento_pedido: Tabla de hechos, que registra los movimientos en el estado de los pedidos y que usuario los realizó.
- movimiento_item: tabla de hechos, que registra los movimientos en el estado de los items y que usuario los realizó.

#### VISTAS:
- view_entregas_pedidos: Se ordenan las entregas con su numero de Remito, ordenadas por numero de pedido.
- view_items_por_proveedor: Muestra los pedidos asignados a cada proveedor, con el costo del mismo, expresado en pesos al tipo de cambio utilizado en el pedido, ordenados por proveedor. Sirve para poder hacerle seguimiento a los proveedores de forma simple.
- view_pedidos_activos: Lista los pedidos activos, ordenados por el estado de avance de cada uno. Pensado para poder hacer el seguimiento general de los pedidos y su parte administrativa.
- view_pedidos_pesos: Describe los pedidos con su importe en Pesos al tipo de cambio acordado. Fue principalmente una prueba para examinar el funcionamiento de las funciones aprendidas. El precio unitario se calcula con una función que devuelve un DECIMAL(10,2) y el importe total con una función que devuelve un String con el formato de pesos ya aplicado.
- view_remitos_cliente: Muestra las entregas realizadas de cada pedido, con el cliente, y la descripcion el producto y la cantidad.

#### FUNCIONES:
- pedidos_pesos:
    Parametros [ tipo_cambio DECIMAL(10,2), cantidad INT, precio_unitario DECIMAL(10,2) ]
    Realiza el calculo del precio total en base a los parametros y lo devuelve en forma de String con el formato de pesos en un [ VARCHAR(50) ].
- devuelve_id_estado_pedido:
    Parametros [ texto_estado VARCHAR(50) ]
    Dado el string de entrada (que puede ser el inicio de un estado_pedido), devuelve el numero del estado, para proximos calculos.
- pasar_a_pesos:
    Parametros [ pedido INT,  precio_en_dolares DECIMAL(10,2) ]
    En base a los parametros ingresados, devuelve en forma de numero [ DECIMAL(14,2) ] el precio expresado en pesos. Lo bueno de esta función es que me sirve, tanto para calcular el precio de venta del PEDIDO, como los costos calculados de los ITEMS. 

#### STORED PROCEDURES:
- consulta_pedido_por_estado:
    Parametros: [ VARCHAR(50) ] Inicio del texto de un estado de pedido.
    Devuelve una lista de los pedidos en ese estado, utiliza la función 'devuelve_id_estado_pedido' para convertir a id_pedido el texto ingresado.
Ej:  
```
CALL consulta_pedido_por_estado("Arch");
```

#### TRIGGERS:
- tr_add_movimiento_pedido:
  Controla la tabla 'movimiento_pedido' y cuando se inserta un movimiento, verifica que el nuevo id_estado_pedido exista y en ese caso modifica el estado del pedido en la tabla 'pedido' y agrega el registro, para tener control de los cambios de estado.

- tr_add_movimiento_item:
  Controla la tabla 'movimiento_item' y cuando se inserta un movimiento, verifica que el nuevo id_estado_item exista y en ese caso modifica el estado del item en la tabla 'item' y agrega el registro, para tener control de los cambios de estado.

#### USUARIOS:
- Socios:
  Es el usuario pensado para los Socios=Gerentes (Administradores en una SRL de Argentina), tiene todos los privilegios.
- Admin:
  Es el usuario pensado para los empleados administrativos de la empresa, tiene los permisos para ver todas las tablas y las visatas, pero solo para insertar movimientos en los pedido y movimientos en los Items.
- Ventas:
  Es el usuario pensado para los vendedores, que pueden ver las vistas, sabiendo la información relevante para ellos.




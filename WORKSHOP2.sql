drop database if exists jardineria_makaia;
CREATE DATABASE jardineria_makaia;
use jardineria_makaia;

CREATE TABLE gama_productos(
	gama varchar(255) primary key,
    descripcion varchar(255) not null,
    imagen varchar(255) not null
);

CREATE TABLE inventario_productos(
	codigo_producto int primary key, 
    nombre varchar(50) not null, 
    gama varchar(255) not null, 
    dimensiones varchar(50) not null, 
    proveedor varchar(50) not null, 
    descripcion varchar(255) not null, 
    cantidad_en_stock int not null, 
    precio_venta double not null, 
    precio_proveedor double not null,
    foreign key (gama) references gama_productos(gama)
);

CREATE TABLE oficinas(
	codigo_oficina int primary key, 
    ciudad varchar(20) not null, 
    pais varchar(20) not null, 
    region varchar(30) not null, 
    codigo_postal int not null, 
    telefono varchar(15) not null, 
    direccion varchar(255) not null
);

CREATE TABLE empleados(
	codigo_empleado int primary key, 
    nombre varchar(30) not null, 
    apellido1 varchar(30) not null, 
    apellido2 varchar(30) not null, 
    extension varchar(10) not null, 
    email varchar(30) not null, 
    codigo_oficina int not null, 
    codigo_jefe int not null unique, 
    puesto varchar(30) not null,
    foreign key (codigo_oficina) references oficinas(codigo_oficina)
);

CREATE TABLE clientes(
	codigo_cliente int primary key,
    nombre_cliente varchar(30) not null,
    nombre_contacto varchar(40) not null,
    apellido_contacto varchar(40) not null,
    telefono varchar(15) not null,
    fax varchar(15) not null,
    direccion1 varchar(40) not null,
    direccion2 varchar(40) not null,
    ciudad varchar(30) not null,
    region varchar(30) not null,
    pais varchar(30) not null,
    codigo_postal varchar(30) not null,
    codigo_empleado int not null,
    limite_credito double not null,
    FOREIGN KEY (codigo_empleado) REFERENCES empleados(codigo_empleado)
);

CREATE TABLE pedidos(
	codigo_pedido int primary key,
    fecha_pedido datetime not null,
    fecha_esperada datetime not null,
    fecha_entrega datetime not null,
    estado varchar(30) not null,
    comentarios varchar(255),
    codigo_cliente int not null,
    foreign key (codigo_cliente) references clientes(codigo_cliente)
);

CREATE TABLE detalle_pedidos(
	codigo_pedido int not null, 
    codigo_producto int not null, 
    cantidad int not null,
    precio_unidad double not null,
    foreign key (codigo_pedido) references pedidos(codigo_pedido),
    foreign key (codigo_producto) references inventario_productos(codigo_producto)
);

CREATE TABLE pagos(
	codigo_cliente int not null,
    forma_pago varchar(20) not null,
    id_transaccion int primary key auto_increment,
    fecha_pago date not null,
    total_cada_pago double not null,
    foreign key (codigo_cliente) references clientes(codigo_cliente)
);


/***********************INSERTANDO GAMA DE PRODUCTOS****************************/
INSERT gama_productos VALUES("sustratos","Una amplia gama de turba y abonos orgánicos que te permiten proporcionar a la planta el medio radicular ideal para su desarrollo, garantizando tanto el anclaje de la planta como el suministro de aire, agua y elementos nutritivos.","not found"),
("huerta y jardin","Abonos complejos sólidos recomendados para todo tipo de cultivos de la huerta y el jardín. Mejoran el desarrollo de las raíces y proporciona mayor vigor y resistencia contra plagas y enfermedades","not found"),
("ecologicos","Una completa gama de abonos sólidos y líquidos, productos fitosanitarios y protectores para la nutrición y protección de las plantas de forma natural y aplicables en agricultura ecológica","not found"),
("cesped","Se trata de una completa gama de fertilizantes complejos NPK granulados para el correcto mantenimiento tu césped que te garantizan un crecimiento regular aumentando la densidad y resistencia del mismo","not found"),
("antiplagas","Un amplio rango de insecticidas en formatos sólidos y líquidos para controlar y eliminar los insectos voladores y rastreros, como hormigas, cucarachas y avispas, tanto en el interior como en el exterior de tu hogar","not found");

/**************INSERTANDO INVENTARIO DE PRODUCTOS ACTUALES********************/
INSERT inventario_productos(codigo_producto,nombre,gama,dimensiones,proveedor,descripcion,cantidad_en_stock,precio_venta,precio_proveedor)
VALUES(0000,"Universal","sustratos","70 L","Fertiberia","Sustrato de alta calidad adecuado para todo tipo de plantas y cultivos de interior y exterior. Presenta una estructura física equilibrada entre aireación y retención de agua.",50,250000,100000),
(0001,"Rosales","huerta y jardin","50 L","Fertiberia","Abono granulado para todas las variedades de rosales, arbustos de flor, enredaderas y plantas trepadoras.",150,50000,10000),
(0002,"Humus","ecologicos","1 L","Fertiberia","Enmienda húmica natural obtenida a partir de leonardita que mejora la estructura del suelo al incorporar materia orgánica en forma líquida.",200,30000,10000),
(0003,"Cesped plus - urea","cesped","3 KG","Fertiberia","Abono de liberación lenta formulado especialmente para la nutrición del césped. Actúa contra la formación del musgo, algas y líquenes en el césped.",350,350000,40000),
(0004,"Insecticida Avispas","antiplagas","750 ML","Fertiberia","Insecticida eficaz contra los nidos de insectos voladores como avispas, avispones, etc. Posee efecto inmediato y residual.",450,70000,25000);

/***************************INSERTANDO CODIGO OFICINAS**********************/
INSERT oficinas(codigo_oficina,ciudad,pais,region,codigo_postal,telefono,direccion)VALUES
(1001,"Cartagena","Colombia","Caribe",130005,"3132901690","123 Calle Principal, Ciudad ABC, Estado DEF, País XYZ"),
(1002,'Roma', 'Italia', 'Lacio', 0011, '3106946451', 'Via del Corso, 100'),
(1003,'Sídney', 'Australia', 'Nueva Gales del Sur', 2000, '3157472456', 'George Street, 123'),
(1004,'Tokio', 'Japón', 'Kanto', 100-0001, '3206802843', 'Ginza, 1-1'),
(1005,'Nueva York', 'Estados Unidos', 'Nueva York', 10001, '3504896325', 'Broadway, 123');

/****************************INSERTANDO EMPLEADOS*****************************/
INSERT empleados(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
VALUES
  (1, 'Juan', 'González', 'Pérez', 'Ext001', 'juan@gmail.com', 1001, 1, 'Empleado'),
  (2, 'María', 'López', 'Martínez', 'Ext002', 'maria@gmail.com', 1001, 2, 'Gerente'),
  (3, 'Carlos', 'García', 'Ramírez', 'Ext003', 'carlos@gmail.com', 1002, 3, 'Gerente'),
  (4, 'Laura', 'Fernández', 'Sánchez', 'Ext004', 'laura@gmail.com', 1003, 4, 'Supervisor'),
  (5, 'Pedro', 'Rodríguez', 'Hernández', 'Ext005', 'pedro@gmail.com', 1004, 5, 'Subgerente'),
  (6, 'Ana', 'Sánchez', 'Gómez', 'Ext006', 'ana@example.com', 1005, 6, 'Supervisor'),
  (7, 'Luis', 'Martínez', 'García', 'Ext007', 'luis@example.com', 1004, 7, 'Subgerente'),
  (8, 'Elena', 'Hernández', 'Fernández', 'Ext008', 'elena@example.com', 1003, 8, 'Supervisor'),
  (9, 'Mario', 'González', 'López', 'Ext009', 'mario@example.com', 1002, 9, 'Gerente'),
  (10, 'Isabel', 'Rodríguez', 'Vargas', 'Ext010', 'isabel@example.com', 1001, 10, 'Gerente');

/***************************INSERTANDO CLIENTES***********************/
INSERT clientes(codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, direccion1, direccion2, ciudad, region, pais, codigo_postal, codigo_empleado, limite_credito)
VALUES
  (101, 'Empresa A', 'John', 'Doe', '555-123456', '555-987654', 'Calle Principal', 'Colonia Centro', 'Ciudad A', 'Región A', 'País A', '12345', 1, 10000.00),
  (102, 'Empresa B', 'Jane', 'Smith', '555-234567', '555-876543', 'Avenida Central', 'Colonia Norte', 'Ciudad B', 'Región B', 'País B', '23456', 2, 20000.00),
  (103, 'Empresa C', 'Mark', 'Johnson', '555-345678', '555-765432', 'Calle Secundaria', 'Colonia Sur', 'Ciudad C', 'Región C', 'País C', '34567', 3, 30000.00),
  (104, 'Empresa D', 'Emily', 'Davis', '555-456789', '555-654321', 'Avenida Principal', 'Colonia Este', 'Ciudad D', 'Región D', 'País D', '45678', 4, 40000.00),
  (105, 'Empresa E', 'Michael', 'Anderson', '555-567890', '555-543210', 'Calle Central', 'Colonia Oeste', 'Ciudad E', 'Región E', 'País E', '56789', 5, 50000.00),
  (106, 'Empresa F', 'Jessica', 'Taylor', '555-678901', '555-432109', 'Avenida Principal', 'Colonia Centro', 'Ciudad F', 'Región F', 'País F', '67890', 6, 60000.00),
  (107, 'Empresa G', 'Christopher', 'Wilson', '555-789012', '555-321098', 'Calle Principal', 'Colonia Norte', 'Ciudad G', 'Región G', 'País G', '78901', 7, 70000.00),
  (108, 'Empresa H', 'Amanda', 'Thomas', '555-890123', '555-210987', 'Avenida Central', 'Colonia Sur', 'Ciudad H', 'Región H', 'País H', '89012', 8, 80000.00),
  (109, 'Empresa I', 'Daniel', 'Jackson', '555-901234', '555-109876', 'Calle Secundaria', 'Colonia Este', 'Ciudad I', 'Región I', 'País I', '90123', 9, 90000.00),
  (110, 'Empresa J', 'Sophia', 'Lee', '555-012345', '555-098765', 'Avenida Principal', 'Colonia Oeste', 'Ciudad J', 'Región J', 'País J', '01234', 10, 100000.00),
  (111, 'Empresa K', 'David', 'Hernandez', '555-123456', '555-987654', 'Calle Principal', 'Colonia Centro', 'Ciudad K', 'Región K', 'País K', '12345', 1, 110000.00),
  (112, 'Empresa L', 'Olivia', 'Lopez', '555-234567', '555-876543', 'Avenida Central', 'Colonia Norte', 'Ciudad L', 'Región L', 'País L', '23456', 2, 120000.00),
  (113, 'Empresa M', 'William', 'Garcia', '555-345678', '555-765432', 'Calle Secundaria', 'Colonia Sur', 'Ciudad M', 'Región M', 'País M', '34567', 3, 130000.00),
  (114, 'Empresa N', 'Sofia', 'Martinez', '555-456789', '555-654321', 'Avenida Principal', 'Colonia Este', 'Ciudad N', 'Región N', 'País N', '45678', 4, 140000.00),
  (115, 'Empresa O', 'James', 'Brown', '555-567890', '555-543210', 'Calle Central', 'Colonia Oeste', 'Ciudad O', 'Región O', 'País O', '56789', 5, 150000.00),
  (116, 'Empresa P', 'Isabella', 'Gomez', '555-678901', '555-432109', 'Avenida Principal', 'Colonia Centro', 'Ciudad P', 'Región P', 'País P', '67890', 6, 160000.00),
  (117, 'Empresa Q', 'Benjamin', 'Young', '555-789012', '555-321098', 'Calle Principal', 'Colonia Norte', 'Ciudad Q', 'Región Q', 'País Q', '78901', 7, 170000.00),
  (118, 'Empresa R', 'Emma', 'Walker', '555-890123', '555-210987', 'Avenida Central', 'Colonia Sur', 'Ciudad R', 'Región R', 'País R', '89012', 8, 180000.00),
  (119, 'Empresa S', 'Henry', 'King', '555-901234', '555-109876', 'Calle Secundaria', 'Colonia Este', 'Ciudad S', 'Región S', 'País S', '90123', 9, 190000.00),
  (120, 'Empresa T', 'Mia', 'Hill', '555-012345', '555-098765', 'Avenida Principal', 'Colonia Oeste', 'Ciudad T', 'Región T', 'País T', '01234', 10, 200000.00);

/******************************INSERTANDO PEDIDOS******************************/
INSERT pedidos(codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente)
VALUES
  (1, '2023-01-01 09:00:00', '2023-01-03 09:00:00', '2023-01-02 10:00:00', 'Entregado', 'Pedido entregado a tiempo', 101),
  (2, '2023-01-02 10:00:00', '2023-01-04 10:00:00', '2023-01-03 11:00:00', 'Entregado', 'Pedido entregado a tiempo', 102),
  (3, '2023-01-03 11:00:00', '2023-01-05 11:00:00', '2023-01-04 12:00:00', 'Entregado', 'Pedido entregado a tiempo', 103),
  (4, '2023-01-04 12:00:00', '2023-01-06 12:00:00', '2023-01-05 13:00:00', 'Entregado', 'Pedido entregado a tiempo', 104),
  (5, '2023-01-05 13:00:00', '2023-01-07 13:00:00', '2023-01-06 14:00:00', 'Entregado', 'Pedido entregado a tiempo', 105),
  (6, '2023-01-06 14:00:00', '2023-01-08 14:00:00', '2023-01-07 15:00:00', 'Entregado', 'Pedido entregado a tiempo', 106),
  (7, '2023-01-07 15:00:00', '2023-01-09 15:00:00', '2023-01-08 16:00:00', 'Entregado', 'Pedido entregado a tiempo', 107),
  (8, '2023-01-08 16:00:00', '2023-01-10 16:00:00', '2023-01-09 17:00:00', 'Entregado', 'Pedido entregado a tiempo', 108),
  (9, '2023-01-09 17:00:00', '2023-01-11 17:00:00', '2023-01-10 18:00:00', 'Entregado', 'Pedido entregado a tiempo', 109),
  (10, '2023-01-10 18:00:00', '2023-01-12 18:00:00', '2023-01-11 19:00:00', 'Entregado', 'Pedido entregado a tiempo', 110);


/*********************************************INSERTANDO INFORMACION EN DETALLE_PEDIDOS*******************************************/
INSERT detalle_pedidos(codigo_pedido, codigo_producto, cantidad, precio_unidad)
VALUES
  (1, 1, 10, 50000.00),
  (2, 2, 5, 30000.00),
  (3, 3, 8, 350000.00),
  (4, 4, 3, 70000.00),
  (5, 0, 12, 250000.00),
  (6, 1, 6, 50000.00),
  (7, 2, 9, 30000.00),
  (8, 3, 4, 350000.00),
  (9, 4, 7, 70000.00),
  (10, 0, 2, 350000.00);


-- ALTER TABLE `jardineria_makaia`.`pagos` 
-- CHANGE COLUMN `forma_pago` `forma_pago` VARCHAR(50) NOT NULL ;

INSERT pagos(codigo_cliente, forma_pago, fecha_pago, total_cada_pago)
VALUES
  (101, 'Tarjeta de crédito', '2023-01-01', 40000.00),
  (102, 'Transferencia bancaria', '2023-01-02', 20000.00),
  (103, 'Efectivo', '2023-01-03', 15000.00),
  (104, 'Cheque', '2023-01-04', 18000.00),
  (105, 'Tarjeta de crédito', '2023-01-05', 250000.00),
  (106, 'Transferencia bancaria', '2023-01-06', 220000.00),
  (107, 'Efectivo', '2023-01-07', 120000.00),
  (108, 'Cheque', '2023-01-08', 185000.00),
  (109, 'Tarjeta de crédito', '2023-01-09', 15000.00),
  (110, 'Transferencia bancaria', '2023-01-10', 30000.00);
INSERT pagos(codigo_cliente, forma_pago, fecha_pago, total_cada_pago)
VALUES (111, 'Efectivo', '2008-01-03', 25000.00), (112, 'Cheque', '2008-01-04', 38000.00);
INSERT pagos(codigo_cliente, forma_pago, fecha_pago, total_cada_pago)
VALUES (113, 'Efectivo', '2009-01-03', 25000.00), (114, 'Cheque', '2009-01-04', 13000.00), (115, 'Efectivo', '2009-01-03', 50000.00);

/*Devuelve un listado con el código de oficina y la ciudad donde hay oficinas*/
select codigo_oficina,ciudad from oficinas;


/*Devuelve un listado con la ciudad y el teléfono de las oficinas de España*/
select ciudad,telefono from oficinas where pais = "España";


/*Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.*/
select nombre,apellido1,apellido2,email from empleados where codigo_jefe=7;


/*Devuelve un listado con el código de cliente de aquellos clientes que 
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar 
aquellos códigos de cliente que aparezcan repetidos. Utilizando la función YEAR de MySQL.
• Utilizando la función DATE_FORMAT de MySQL.*/
select c.codigo_cliente,
c.nombre_contacto,
c.apellido_contacto 
from clientes c inner join pagos p ON c.codigo_cliente=p.codigo_cliente
where year(fecha_pago) = 2008 group by c.codigo_cliente;


/*¿Cuántos empleados hay en la compañía?*/
select count(*) from empleados;


/*¿Cuántos clientes tiene cada país?*/
select pais,count(*) from clientes group by pais;


/*¿Cuál fue el pago medio en 2009?*/
select avg(total_cada_pago) as pago_medio from pagos where year(fecha_pago) = 2009;


/*¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos*/
select estado,count(*) as contador_estado from pedidos group by estado order by count(*) DESC;


/*Calcula el precio de venta del producto más caro y barato en una misma consulta*/
select max(precio_venta) as precio_maximo, min(precio_venta) as precio_minimo from inventario_productos;


/*Devuelve el nombre del cliente con mayor límite de crédito*/
select nombre_cliente from clientes where limite_credito = (select max(limite_credito) from clientes);


/*Devuelve el nombre del producto que tenga el precio de venta más caro*/
select nombre from inventario_productos where precio_venta=(select max(precio_venta) from inventario_productos);


/*Devuelve el nombre del producto del que se han vendido más unidades. 
(Tenga en cuenta que tendrá que calcular cuál es el número total de 
unidades que se han vendido de cada producto a partir de los datos 
de la tabla detalle_pedidos)*/
select i.nombre from inventario_productos i 
inner join detalle_pedidos d ON i.codigo_producto=d.codigo_producto 
and cantidad=(select max(cantidad) from detalle_pedidos);


/*Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).*/
select * from clientes c,pagos p where c.codigo_cliente=p.codigo_cliente and limite_credito > total_cada_pago;


/*Devuelve el listado de clientes indicando el nombre del cliente y cuantos pedidos ha realizado. 
Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.*/
select c.nombre_cliente,
count(p.codigo_cliente) as pedidos_realizados 
from clientes c 
left join 
pedidos p 
ON 
c.codigo_cliente=p.codigo_cliente group by nombre_cliente;


/*Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que 
no sean representante de ventas de ningún cliente*/
SELECT e.nombre, 
e.apellido1,
e.apellido2, 
e.puesto, 
o.telefono
FROM empleados e
INNER JOIN oficinas o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT codigo_empleado
    FROM clientes
    WHERE codigo_empleado IS NOT NULL
);


/*Devuelve las oficinas donde no trabajan ninguno de los empleados que 
hayan sido los representantes de ventas de algún cliente que haya realizado 
la compra de algún producto de la gama Frutales*/
SELECT o.codigo_oficina, o.telefono
FROM oficinas o
WHERE NOT EXISTS (
    SELECT 1
    FROM empleados e
    INNER JOIN clientes c ON e.codigo_empleado = c.codigo_empleado
    INNER JOIN pedidos p ON c.codigo_cliente = p.codigo_cliente
    INNER JOIN inventario_productos ip ON ip.codigo_producto = p.codigo_pedido
    WHERE ip.gama = 'Frutales' AND e.codigo_oficina = o.codigo_oficina
);


/*Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. 
Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.*/
select c.nombre_cliente,
COALESCE(SUM(p.total_cada_pago), 0) as total_pagado
from clientes c 
left join pagos p ON c.codigo_cliente = p.codigo_cliente 
group by c.nombre_cliente;







--EJERCICIO 1
--########################################################################


SELECT * FROM producto_tipo

INSERT INTO producto_tipo(categ_tipo,id_tipo)


--EJERCICIO 2
--########################################################################





--EJERCICIO 3
--########################################################################





--EJERCICIO 4
--########################################################################


--Plantee en SQL estandar la implementacion completa del siguiente chequeo mediante el
--recurso DECLARATIVO mas adecuado y optimizado, JUSTIFICANDO su eleccion:
--La cantidad total de productos solicitados en una orden no puede ser mayor a 10.
--El recurso declarativo de SQL estandar seria una restriccion de tabla
ALTER TABLE producto_productoxorden ADD CONSTRAINT parcial_2016_max_10_prod
CHECK (NOT EXISTS ( SELECT nro_orden,count(*)
					FROM producto_productoxorden
					GROUP BY nro_orden
					HAVING count(*)>10))
;


--EJERCICIO 5
--########################################################################


SELECT * FROM producto_producto


--EJERCICIO 6
--########################################################################


--Cree la vista nro_libreta_ProductosNoOrdenados, teniendo en cuenta que debe ser
--actualizable para PostgreSQL.
--nro_libreta_ProductosNoOrdenados, debe contener todos los datos de los productos
--de precio_unitario menor a 1000 que no han sido incluidos en ninguna orden.
--(Nota: Reemplace "nro_libreta" por el suyo.)
CREATE VIEW parcial_2016_ProductosNoOrdenados AS
	SELECT p.* 
	FROM unc_esq_producto.producto p
	WHERE NOT EXISTS (	SELECT 1
						FROM unc_esq_producto.productoxorden
						WHERE id_producto=p.id_producto)
		 AND p.precio_unitario < 1000
;


--EJERCICIO 7
--########################################################################


--Si se aplica la clausula WITH CHECK OPTION sobre la vista ProductosNoOrdenados
--Seleccione una:
--c. Solo podran insertarse productos de precio_unitario menor a 1000


--EJERCICIO 8
--########################################################################


--Cree la vista nro_libreta_ClientesConOrdenes teniendo en cuenta que no debe ser actualizable
--nro_libreta_ClientesConOrdenes que contega todos los datos de TODOS los clientes y la cantidad
--de ordenes que cada uno realizo
--(Nota: Reemplace "nro_libreta" por el suyo.)
CREATE VIEW parciaul_2016_ClientesConOrdenes AS
	SELECT c.*,count(o.nro_orden)
	FROM producto_cliente c
	LEFT JOIN producto_orden o ON (c.id_cliente=o.id_cliente)
	GROUP BY c.id_cliente
;

SELECT c.*,count(o.nro_orden)
FROM producto_cliente c
LEFT JOIN producto_orden o ON (c.id_cliente=o.id_cliente)
GROUP BY c.id_cliente


--EJERCICIO 9
--########################################################################


--En la vita ClientesConOrdenes se podra:
--b. Ninguna de las anteriores


--EJERCICIO 10
--########################################################################



--EJERCICIO 11
--########################################################################


--Consideere que un usuario A es propietario del esquema de la BD y ejecuta los siguientes
--comandos SQL (NOTA: los usuarioos estan creados):
--A:
GRANT SELECT,INSERT ON cliente TO B WITH GRANT OPTION;
GRANT SELECT ON cliente TO C;
--B:
GRANT SELECT ON cliente TO C,D;
--Indique cual/es de los usuarios puede/n ejecutar exitosamente los siguiente comandos (si no
--explique porque no es posible):
--A queda con todos los permisos por ser owner
--B queda con select y insert con grant option (otorgados por A)
--C queda con select (otorgados por A y B)
--D queda con select (otorgado por B)
INSERT INTO A.cliente VALUES (...);--Solo A y B son los que tienen permisos
SELECT * FROM A.cliente;--A, B, C y D tienen permisos
GRANT SELECT ON A.cliente TO E;--Solo A y B tienen permisos 


--EJERCICIO 12
--########################################################################


--Explique que ocurriria despues de que el usuario A ejecuta REVOKE SELECT ON cliente FROM B CASCADE;
--y que permisos conservaria cada usuario despues de A:REVOKE SELECT ON cliente FROM B CASCADE;
--A con todos los permisos por ser owner
--B con insert con grant option
--C con select
--D sin permisos


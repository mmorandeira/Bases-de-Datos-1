
--EJERCICIO 1
--########################################################################

CREATE TABLE tp5_ej1_articulo (
	id_articulo varchar(10) NOT NULL,
	descripcion varchar(30) NOT NULL,
	peso numeric(5,2) NOT NULL,
	ciudad varchar(30) NOT NULL,
	CONSTRAINT pk_tp5_ej1_articulo primary key(id_articulo)
);

CREATE TABLE tp5_ej1_proveedor (
	id_proveedor varchar(10) NOT NULL,
	nombre varchar(30) NOT NULL,
	rubro varchar(15) NOT NULL,
	ciudad varchar(30) NOT NULL,
	CONSTRAINT pk_tp5_ej1_proveedor primary key(id_proveedor)
);

CREATE TABLE tp5_ej1_envio (
	id_proveedor varchar(10) NOT NULL,
	id_articulo varchar(10) NOT NULL,
	cantidad numeric(5,0) NOT NULL,
	CONSTRAINT pk_tp5_ej1_envio primary key(id_proveedor,id_articulo)
);

ALTER TABLE tp5_ej1_envio
	ADD CONSTRAINT fk_tp5_ej1_envio_tp5_ej1_articulo FOREIGN KEY(id_articulo)
	REFERENCES tp5_ej1_articulo(id_articulo)
;

ALTER TABLE tp5_ej1_envio
	ADD CONSTRAINT fk_tp5_ej1_envio_tp5_ej1_proveedor FOREIGN KEY(id_proveedor)
	REFERENCES tp5_ej1_proveedor(id_proveedor)
;

INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('1412u','Pepas marca vea',300,'Tandil');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('1412v','Leche entera marca vea',999.99,'Tandil');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('1412w','leche descremada marca vea',999.99,'Tandil');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('18249a','Atun natural marca carrefour',170,'Necochea');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('18249b','Atun aceite marca carrefour',300,'Necochea');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('18249c','Arbejas marca carrefour',475,'Necochea');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('24722a','Hamburguesas',190,'Tandil');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('A1','null',0,'null');
INSERT INTO tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) VALUES ('A2','null',0,'null');


INSERT INTO tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) VALUES ('18249','carrefour','cualquier cosa','Tandil');
INSERT INTO tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) VALUES ('1412','vea','cualquier cosa','Rauch');
INSERT INTO tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) VALUES ('19134','golopolis','golosinas','tandil');
INSERT INTO tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) VALUES ('24722','charcuteria','carnes','tandil');
INSERT INTO tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) VALUES ('95821','dana','niidea','tandil');
INSERT INTO tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) VALUES ('P1','null','null','null');
INSERT INTO tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) VALUES ('P2','null','null','null');


INSERT INTO tp5_ej1_envio(id_proveedor,id_articulo,cantidad) VALUES ('95821','24722a',500);
INSERT INTO tp5_ej1_envio(id_proveedor,id_articulo,cantidad) VALUES ('95821','18249a',999);
INSERT INTO tp5_ej1_envio(id_proveedor,id_articulo,cantidad) VALUES ('95821','18249b',1048);
INSERT INTO tp5_ej1_envio(id_proveedor,id_articulo,cantidad) VALUES ('95821','18249c',248);
INSERT INTO tp5_ej1_envio(id_proveedor,id_articulo,cantidad) VALUES ('95821','1412u',1820);
INSERT INTO tp5_ej1_envio(id_proveedor,id_articulo,cantidad) VALUES ('P1','A1',666);
INSERT INTO tp5_ej1_envio(id_proveedor,id_articulo,cantidad) VALUES ('P1','A2',820);



SELECT *
FROM tp5_ej1_articulo;

SELECT *
FROM tp5_ej1_proveedor;

SELECT *
FROM tp5_ej1_envio;

--esta vista es actualizable, ya que no se utilizan
--ni funciones de agregacion o select en el from
DROP VIEW tp5_ej1_envios500 cascade;

CREATE VIEW tp5_ej1_envios500 AS
	SELECT *
	FROM tp5_ej1_envio
	WHERE cantidad >= 500
--WITH LOCAL CHECK OPTION
;

DELETE FROM tp5_ej1_envio WHERE id_proveedor='95821' AND id_articulo='A2';

INSERT INTO "tp5_ej1_envios500-999"(id_proveedor,id_articulo,cantidad) VALUES ('95821','A2',300);

SELECT * FROM tp5_ej1_envio;

DROP VIEW "tp5_ej1_envios500-999";
--esta vista es actualizable, ya que no se utilizan
--ni funciones de agregacion o select en el from
CREATE VIEW "tp5_ej1_envios500-999" AS
	SELECT *
	FROM tp5_ej1_envios500
	WHERE cantidad <=999	
--WITH LOCAL CHECK OPTION
;

--esta vista es actualizable, ya que no se utilizan
--ni funciones de agregacion o SELECT en el from
CREATE VIEW tp5_ej1_productos_mas_pedidos AS
	SELECT *
	FROM tp5_ej1_articulo
	WHERE id_articulo IN (	SELECT id_articulo
							FROM tp5_ej1_envios500)
;

--esta vista no es actualizable debido al uso de una
--funcion de agregacion (el sum)
CREATE VIEW tp5_ej1_envios_prov AS
	SELECT id_proveedor,sum(cantidad)
	FROM tp5_ej1_envio
	GROUP BY id_proveedor
;

SELECT *
FROM tp5_ej1_envios500

SELECT *
FROM "tp5_ej1_envios500-999"

SELECT *
FROM tp5_ej1_envios_prov

DROP VIEW tp5_ej1_envios500 CASCADE;

CREATE VIEW tp5_ej1_envios500 AS
	SELECT *
	FROM tp5_ej1_envio
	WHERE  cantidad >= 500
	WITH CHECK OPTION
;

--c.1)
--con o sin check option se inserta el valor 
INSERT INTO tp5_ej1_envios500 VALUES ('P1', 'A1', 500);

DELETE FROM tp5_ej1_envio WHERE id_proveedor='P1' and id_articulo='A1';

--c.2)
--sin check option se inserta el valor, pero con el check option no
INSERT INTO tp5_ej1_envios500 VALUES ('P2', 'A2', 300);

UPDATE FROM tp5_ej1_envio WHERE id_proveedor='P2' AND id_articulo='A2';

--c.3)
--con o sin check option se inserta el valor 
UPDATE tp5_ej1_envios500 set cantidad=1000 WHERE id_proveedor='P1';

--c.4)
--sin check option se inserta el valor, pero con el check option no
UPDATE tp5_ej1_envios500 SET cantidad=100 WHERE id_proveedor='P1';

UPDATE tp5_ej1_envio SET cantidad=666 WHERE id_proveedor='P1' AND id_articulo='A1';
UPDATE tp5_ej1_envio SET cantidad=820 WHERE id_proveedor='P1' AND id_articulo='A2';


--EJERCICIO 2
--########################################################################

--esta vista es actualizable, ya que se muestra solo atributos de la tablas
--mas su primary key completa
CREATE VIEW tp5_ej2_distribuidor_200 AS
	SELECT id_distribuidor,nombre,tipo
	FROM pelicula_distribuidor
	WHERE  id_distribuidor > 200
;

--esta vista no es actualizable, ya que la entidad departamento
--es debil de distribuidor por lo tanto la clave es tanto id_departamento
--como id_distrobuidor y dado que no se seleciona la clave esto imposibilita
--la actualizacion de la misma
CREATE VIEW tp5_ej2_departamento_dist_200 AS
	SELECT id_departamento, nombre, id_ciudad, jefe_departamento
	FROM pelicula_departamento
	WHERE  id_distribuidor > 200
;

--
CREATE VIEW tp5_ej2_distribuidor_1000 AS
	SELECT *
	FROM pelicula_distribuidor
	WHERE id_distribuidor > 1000
;


INSERT INTO tp5_ej2_distribuidor_1000 VALUES (1050,'NuevoDistribuidor 1050','Montiel 340','569842-2643','N');


--EJERCICIO 3
--########################################################################

--1)
--Es actualizable (en SQL standard)
CREATE VIEW tp5_ej3_empleado_dist_20 AS
	SELECT id_empleado,nombre,apellido,sueldo,fecha_nacimiento
	FROM pelicula_empleado
	WHERE id_distribuidor=20
;

SELECT * FROM tp5_ej3_empleado_dist_20 
EXCEPT SELECT 

CREATE VIEW test AS 
SELECT id_empleado,nombre,apellido
FROM pelicula_empleado;

SELECT * FROM test;

SELECT * FROM pelicula_empleado WHERE id_empleado=8177


UPDATE tp5_ej3_empleado_dist_20 SET sueldo=50000 WHERE id_empleado=8177; 

--2)
--NO Es actualizable (en SQL standard)
CREATE VIEW tp5_ej3_empleado_dist_2000 AS
	SELECT nombre,apellido,sueldo
	FROM tp5_ej3_empleado_dist_20
	WHERE sueldo > 2000
;

--3)
--Es actualizable (en SQL standard)
CREATE VIEW tp5_ej3_empleado_dist_20_70 AS
	SELECT *
	FROM tp5_ej3_empleado_dist_20
	WHERE EXTRACT(YEAR FROM fecha_nacimiento) BETWEEN 1970 AND 1979
;

--4)
--No es actualizable (en SQL standard), porque se usa funcion de agregacion "sum"
CREATE VIEW tp5_ej3_peliculas_entregadas AS
	SELECT codigo_pelicula,sum(cantidad)
	FROM pelicula_renglon_entrega
	GROUP BY codigo_pelicula
;

--5)
--Es actualizable (en SQL standard)
CREATE VIEW tp5_ej3_distribuidoras_argentina AS
	SELECT d.id_distribuidor,d.nombre,d.direccion,d.telefono,n.nro_inscripcion,n.encargado
	FROM pelicula_distribuidor d
	JOIN pelicula_nacional n ON (d.id_distribuidor=n.id_distribuidor)
;

--6)
CREATE VIEW tp5_ej3_distribuidoras_mas_2_emp AS
	SELECT *
	FROM tp5_ej3_distribuidoras_argentina d
	WHERE  NOT EXISTS (	SELECT 1
						FROM pelicula_empleado e
						WHERE e.id_distribuidor=d.id_distribuidor
						GROUP BY e.id_departamento
						HAVING count(id_empleado)<=2)
		  AND EXISTS (	SELECT 1
		  				FROM pelicula_empleado e
		  				WHERE e.id_distribuidor=d.id_distribuidor)
;


--EJERCICIO 4
--########################################################################

--La vista tp5_ej3_empleado_dist_20 es actulizable y sin check option

--Si la vista tp5_ej3_empleado_dist_20_70 tiene activado el with local check option
--me dejaria agregar solo empleados de la decada del 70 sean o no del distribuidor 20

--Si la vista tp5_ej3_empleado_dist_20_70 tiene activado el with cascade check option
--solo me dejaria agregar empleados que sean de la decada del 70 y que ademas sean del
--distribuidor nro 20

--Si la vista tp5_ej3_empleado_dist_2000 tiene activado el with local check option
--me dejaria agregar solo empleados que ganen mas de 2000 pesos, pero podria agregar
--empleados que ganen mas de 2000 pesos y no sean del distribuidor 20

--Si la vista tp5_ej3_empleado_dist_2000 tiene activado el with cascade check option
--me dejaria agregar solo empleados que ganen mas de 2000 pesos y que ademas sean
--del del distribuidor 20


--EJERCICIO 5
--########################################################################


--Esta es una foreign key correspondiente a una relacion de subtipo
--en este caso todos los campos de ambas tablas serian actualizables
--la clave preservada es id_distribuidor
CREATE VIEW tp5_ej5_nacional_kp_1 AS
	SELECT n.id_distribuidor,nro_inscripcion,id_distrib_mayorista,encargado,nombre,direccion,telefono,tipo
	FROM pelicula_distribuidor d NATURAL JOIN pelicula_nacional n
;

--Esta es una foreign key correspondiente a un relacion 1:N
--en este caso 
CREATE VIEW tp5_ej5_ciudad_kp_2 AS
	SELECT id_ciudad,nombre_ciudad,c.id_pais,nombre_pais
	FROM pelicula_ciudad c NATURAL JOIN pelicula_pais p
;
 
--Esta es una foreign key correspondiente a una relacion N:N
CREATE VIEW tp5_ej5_entregas_kp_3 AS
	SELECT nro_entrega,re.codigo_pelicula,cantidad,titulo
	FROM pelicula_renglon_entrega re NATURAL JOIN pelicula_pelicula p
;

SELECT * FROM tp5_ej5_nacional_kp_1;

CREATE OR REPLACE FUNCTION tp5_ej5_nacional_kp_1()
RETURNS TRIGGER AS
$BODY$
BEGIN
	IF (tg_op='INSERT') THEN
		IF (NEW.tipo='N') THEN 
			INSERT INTO pelicula_distribuidor(id_distribuidor,nombre,direccion,telefono,tipo) 
			VALUES (NEW.id_distribuidor,NEW.nombre,NEW.direccion,NEW.telefono,'N');
			INSERT INTO pelicula_nacional(id_distribuidor,nro_inscripcion,encargado,id_distrib_mayorista)
			VALUES (NEW.id_distribuidor,NEW.nro_inscripcion,NEW.encargado,NEW.id_distrib_mayorista);
		ELSE 
			RAISE EXCEPTION 'No podes insertar distribuidores que no sean nacional';
		END IF;
	END IF;
	IF (tg_op='UPDATE') THEN 
		--como hago el update si me estan cambiando la clave, porque si me 
		--cambian la clave tengo que actulizar una tabla primero, y fallaria
		--por problemas de rirs
		IF EXISTS (SELECT 1
					FROM pelicula_nacional
					WHERE id_distribuidor=OLD.id_distribuidor) THEN
			IF (OLD.id_distribuidor=NEW.id_distribuidor) THEN
				IF (NEW.tipo='N') THEN 
					UPDATE pelicula_distribuidor SET nombre=NEW.nombre,direccion=NEW.direccion,telefono=NEW.telefono,tipo='N' WHERE id_distribuidor=OLD.id_distribuidor;
					UPDATE pelicula_nacional SET nro_inscripcion=NEW.nro_inscripcion,id_distrib_mayorista=NEW.id_distrib_mayorista,encargado=NEW.encargado WHERE id_distribuidor=OLD.id_distribuidor;
				ELSE 
					RAISE EXCEPTION 'No podes actualizar distribuidores que no sean de la vista';
				END IF;
			ELSE
				DELETE FROM pelicula_nacional WHERE id_distribuidor=OLD.id_distribuidor;
				DELETE FROM pelicula_distribuidor WHERE id_distribuidor=OLD.id_distribuidor;
				INSERT INTO pelicula_distribuidor(id_distribuidor,nombre,direccion,telefono,tipo) 
				VALUES (NEW.id_distribuidor,NEW.nombre,NEW.direccion,NEW.telefono,'N');
				INSERT INTO pelicula_nacional(id_distribuidor,nro_inscripcion,encargado,id_distrib_mayorista)
				VALUES (NEW.id_distribuidor,NEW.nro_inscripcion,NEW.encargado,NEW.id_distrib_mayorista);
			END IF;
		END IF;
	END IF;
	IF (tg_op='DELETE') THEN
		IF (OLD.tipo='N') THEN
			DELETE FROM pelicula_nacional WHERE id_distribuidor=OLD.id_distribuidor;
			DELETE FROM pelicula_distribuidor WHERE id_distribuidor=OLD.id_distribuidor;
			
		END IF;
	END IF;
	RETURN new;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tp5_ej5_nacional_kp_1
INSTEAD OF INSERT OR UPDATE OR DELETE ON tp5_ej5_nacional_kp_1
FOR EACH ROW
EXECUTE PROCEDURE tp5_ej5_nacional_kp_1();

SELECT *
FROM tp5_ej5_nacional_kp_1
WHERE id_distribuidor=-1;

SELECT *
FROM unc_esq_peliculas.nacional n
JOIN unc_esq_peliculas.distribuidor d ON (d.id_distribuidor=n.id_distribuidor)
WHERE d.id_distribuidor=278;

SELECT *
FROM pelicula_internacional


--Probando el update de tuplas (sin updatear la clave)
UPDATE tp5_ej5_nacional_kp_1 SET telefono='234-4152' WHERE id_distribuidor = 278;

UPDATE tp5_ej5_nacional_kp_1 SET encargado='Clemente U., Cabrera' WHERE id_distribuidor = 278;

--Probando la inserccion de tuplas
INSERT INTO tp5_ej5_nacional_kp_1(id_distribuidor,nro_inscripcion,id_distrib_mayorista,encargado,nombre,direccion,telefono,tipo)
VALUES (-1,-1,3,'Juan Eliel Viviant','distribuidorfalso','callefalsa123','celular','N');

--Probando el update de tuplas (updateando la clave)
UPDATE tp5_ej5_nacional_kp_1 SET id_distribuidor=-2 WHERE id_distribuidor=-1;

DELETE FROM tp5_ej5_nacional_kp_1 WHERE id_distribuidor=-1;

SELECT *
FROM pelicula_distribuidor
ORDER BY id_distribuidor;

SELECT *
FROM pelicula_nacional
ORDER BY id_distribuidor;



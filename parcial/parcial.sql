-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-11-04 02:40:49.494

-- tables
-- Table: CONTACTO
CREATE TABLE CONTACTO (
    nro_doc int  NOT NULL,
    tipo_doc char(3)  NOT NULL,
    nom_apell varchar(50)  NOT NULL,
    fecha_alta date  NOT NULL,
    e_mail varchar(25)  NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (nro_doc,tipo_doc)
);

-- Table: ESPACIO
CREATE TABLE ESPACIO (
    id_espacio int  NOT NULL,
    tipo_esp char(10)  NOT NULL,
    ubicacion varchar(40)  NOT NULL,
    costo_diario decimal(10,2)  NOT NULL,
    CONSTRAINT PK_POSICION PRIMARY KEY (id_espacio,tipo_esp)
);

-- Table: RESERVA
CREATE TABLE RESERVA (
    nro_reserva int  NOT NULL,
    nro_doc int  NULL,
    tipo_doc char(3)  NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    importe decimal(10,2)  NOT NULL,
    confirmacion boolean  NOT NULL,
    CONSTRAINT PK_ALQUILER PRIMARY KEY (nro_reserva)
);

-- Table: RESERVA_ESPACIO
CREATE TABLE RESERVA_ESPACIO (
    tipo_esp char(10)  NOT NULL,
    nro_reserva int  NOT NULL,
    id_esp int  NOT NULL,
    estado boolean  NOT NULL,
    CONSTRAINT PK_ALQUILER_POSICIONES PRIMARY KEY (tipo_esp,nro_reserva,id_esp)
);

-- Table: TIPO_ESPACIO
CREATE TABLE TIPO_ESPACIO (
    tipo_esp char(10)  NOT NULL,
    descrip varchar(50)  NOT NULL,
    superf_max decimal(10,2)  NOT NULL,
    volum_max decimal(10,2)  NULL,
    CONSTRAINT PK_FILA PRIMARY KEY (tipo_esp)
);

-- foreign keys
-- Reference: FK_ESPACIO_TIPO (table: ESPACIO)
ALTER TABLE ESPACIO ADD CONSTRAINT FK_ESPACIO_TIPO
    FOREIGN KEY (tipo_esp)
    REFERENCES TIPO_ESPACIO (tipo_esp)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_RESERVA_CONTACTO (table: RESERVA)
ALTER TABLE RESERVA ADD CONSTRAINT FK_RESERVA_CONTACTO
    FOREIGN KEY (nro_doc, tipo_doc)
    REFERENCES CONTACTO (nro_doc, tipo_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.






--EJERCICIO 1
--########################################################################


--a.
ALTER TABLE RESERVA_ESPACIO
	ADD CONSTRAINT FK_RESERVA_ESPACIO_RESERVA FOREIGN KEY(nro_reserva)
	REFERENCES RESERVA(nro_reserva)
		ON UPDATE CASCADE
		ON DELETE CASCADE
;

ALTER TABLE RESERVA_ESPACIO
	ADD CONSTRAINT FK_RESERVA_ESPACIO_ESPACIO FOREIGN KEY(id_esp,tipo_esp)
	REFERENCES ESPACIO(id_espacio,tipo_esp)
		ON UPDATE RESTRICT
		ON DELETE RESTRICT
;

--b.
--No tendria sentido, porque al tratarse de una relacion N:N tendriamos datos
--que no referencian a nadie, osea no tendria sentido. A su vez tambien por tratarse
--de una relacion N:N no se podria ya que las claves FK son tambien claves primarias
--y no se podria poner null a las claves primarias

--EJERCICIO 2
--########################################################################


INSERT INTO parcial019_tipo_espacio()

--Considerando la siguiente instancia de la BD (Nota: se incluyen sólo los atributos
--relevantes para el ejercicio, según el orden dado en las tablas):

--TIPO_ESPACIO:  ('T1', ‘ACA’,…); ('T2', ‘BRA’,…); ('T3', ‘MIR’, …)   
--
--ESPACIO:  (1, 'T1', …) ; (2, 'T3', …) (2, 'T1')                 	
--
--CONTACTO:  (1, ‘C1’, …) ; (2, ‘C2’, …)
--
--RESERVA:  (100, 1, ‘C1’, …); (101, 2, ‘C2’, …); (102, null, null, …)
--
--RESERVA_ESPACIO:  ( 'T1', 101, 1, ..) ; ('T3', 100, 2, ..) 

--Analice el resultado de las siguientes operaciones sobre la BD, indicando el efecto sobre las 
--tablas y justifique en cada caso, según la/s restriccion/es involucrada/s.
--Importante: considere los resultados de cada operación de manera no acumulativa.

delete from RESERVA where nro_reserva= 100;
delete from TIPO_ESPACIO where tipo_esp= 'T2';
update TIPO_ESPACIO set tipo_esp= ‘HH’ where tipo_esp= 'T1';
update RESERVA_ESPACIO set nro_reserva= nro_reserva-1 where nro_reserva=100;

--a. Se propaga y se elimina (100, 1, ‘C1’, …) de reserva y  ('T3', 100, 2, ..) de reserva espacio
--quedando de la siguiente manera:

--TIPO_ESPACIO:  ('T1', ‘ACA’,…); ('T2', ‘BRA’,…); ('T3', ‘MIR’, …)   
--
--ESPACIO:  (1, 'T1', …) ; (2, 'T3', …) (2, 'T1')                 	
--
--CONTACTO:  (1, ‘C1’, …) ; (2, ‘C2’, …)
--
--RESERVA:  (101, 2, ‘C2’, …); (102, null, null, …)
--
--RESERVA_ESPACIO:  ( 'T1', 101, 1, ..) ;

--b. Se borra la tupla ('T2', ‘BRA’,…) de tipo espacio, ya que no esta siendo referenciada
--qudando de la siguiente manera

--TIPO_ESPACIO:  ('T1', ‘ACA’,…); ('T3', ‘MIR’, …)   
--
--ESPACIO:  (1, 'T1', …) ; (2, 'T3', …) (2, 'T1')                 	
--
--CONTACTO:  (1, ‘C1’, …) ; (2, ‘C2’, …)
--
--RESERVA:  (100, 1, ‘C1’, …); (101, 2, ‘C2’, …); (102, null, null, …)
--
--RESERVA_ESPACIO:  ( 'T1', 101, 1, ..) ; ('T3', 100, 2, ..) 

--c. No se permite, porque r2 tiene restrict en el update y hay dos tuplas en espacio que esta
--referenciando a esa tupla (1, 'T1', …) ; (2, 'T1')    


--d. Falla porque al cambiar ('T3', 100, 2, ..) por ('T3', 99, 2, ..) no hay ninguna tupla
--en reserva que tenga nro_reserva=99  


--EJERCICIO 3
--########################################################################


--Para las restricciones definidas y la instancia original de la BD, determine el 
--resultado de las siguientes operaciones diferenciando según los 3 diferentes tipos 
--de matching si corresponde. Justifique en cada caso. 

--(Nota: se incluyen los atributos relevantes para el ej., según el orden dado en cada tabla)

insert into RESERVA values (103, null, S, …); 

insert into RESERVA values (110, 3, null, …);  

insert into RESERVA_ESPACIO values ( 'T1', 101, null, …);  

update ESPACIO set tipo_espacio= ‘T2’; 

--a. Al conter un null se puede en simple match, en partial no se puede porque no existe
--el contacto que tenga tipo doc 'S' y en full tambien falla porque la clave(FK) no es toda null
--b. Al conter un null se puede en simple match, en partial no se puede porque no existe
--el contacto que tenga nro doc=3 y en full tambien falla porque  la clave(FK) no es toda null
--c.falla porque id_esp no puede ser null por ser claver primaria
--d. falla por la restriccion r3 que es restrict, cuando se quiere cambiar el 
--valor de la tupla (1, 'T1', …) en espacio por (1, 'T2', …) 
--al estar siendo referenciada por ( 'T1', 101, 1, ..) y ser restricta falla toda la transaccion


--EJERCICIO 4
--########################################################################



--d. Es la opcion correcta



--EJERCICIO 5
--########################################################################


--a. Falla porque con que exista una reserva con un importe mayor a 5000 ya devolveria
--los nombre y apellido de todos los contactos
--b. Falla porque va a devolver los nombres y apellidos las personas que tiene una reserva
--de mas de 5000. ejemplo si una persona hizo muchas reservas todas menores de 5000 no lo va
--a listar este query, pero en el momento que esta misma persona haga una reserva de mas de 
--5000 va a ser listado siendo que tienen reservas de menos de 5000 
--c. Esta opcion no es porque hay una opcion correcta que es la d.
--d. Es la opcion correcta
--e. Esta consulta tiene el mismo problema que la del punto b.
--f. Esta consulta al hacerce con un not in y los campos que devuelve es nro_doc
--que puede ser null con que en la tabla de reserva haya un nro_doc que sea null
--va a listar todos los contactos independientemente de sus reservas.


--EJERCICIO 6
--########################################################################


--Se desea controlar lo siguiente: las reservas que se inicien a partir del 01/11/19 
--(considerar fecha_desde) pueden tener asociados hasta un máximo de 3 espacios del mismo tipo

--Implemente con el recurso declarativo más adecuado y optimizado dicho chequeo según 
--SQL estándar. Justifique el tipo de restricción considerada

SELECT *
FROM reserva;

SELECT * FROM espacio;

SELECT * FROM tipo_espacio;

INSERT INTO tipo_espacio(tipo_esp,descrip,superf_max,volum_max) 
VALUES ('T1','aaaa me quedo sin tiempo', 20,20);
INSERT INTO tipo_espacio(tipo_esp,descrip,superf_max,volum_max) 
VALUES ('T2','aaaa me quedo sin tiempo', 20,20);

INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (1,'T1','EN mi caasa', 20);
INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (2,'T1','EN mi caasa', 20);
INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (3,'T1','EN mi caasa', 20);
INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (4,'T1','EN mi caasa', 20);


INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (1,'T2','EN mi caasa', 20);
INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (2,'T2','EN mi caasa', 20);
INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (3,'T2','EN mi caasa', 20);
INSERT INTO espacio(id_espacio,tipo_esp,ubicacion,costo_diario)
VALUES (4,'T2','EN mi caasa', 20);

INSERT INTO reserva_espacio(tipo_esp,nro_reserva,id_esp,estado)
VALUES ('T1',1,1,true);
INSERT INTO reserva_espacio(tipo_esp,nro_reserva,id_esp,estado)
VALUES ('T1',1,2,true);
INSERT INTO reserva_espacio(tipo_esp,nro_reserva,id_esp,estado)
VALUES ('T1',1,3,true);

INSERT INTO reserva_espacio(tipo_esp,nro_reserva,id_esp,estado)
VALUES ('T2',1,1,true);
INSERT INTO reserva_espacio(tipo_esp,nro_reserva,id_esp,estado)
VALUES ('T2',1,2,true);
INSERT INTO reserva_espacio(tipo_esp,nro_reserva,id_esp,estado)
VALUES ('T2',1,3,true);
INSERT INTO reserva_espacio(tipo_esp,nro_reserva,id_esp,estado)
VALUES ('T2',1,4,true);


SELECT * FROM reserva

--El recurso de SQL estandar es una restriccion general (assertion)
--debido que esta restriccion debe controlar tanto que los espacios no
--cambien de tipo sino que tambien la  cantidad en reserva de espacio.
--Hay multiples puntos de acceso para romperlo, modificando en reserva_espacio
--el tipo de esp y en reserva la fecha desde
CREATE ASSERTION AS_max_mismo_tipo
CHECK (NOT EXISTS (	SELECT re.tipo_esp,count(re.tipo_esp)
					FROM reserva r
					JOIN reserva_espacio re ON (r.nro_reserva=re.nro_reserva)
					WHERE r.fecha_desde>=to_date('01/11/2019','DD/MM/YYYY')
					GROUP BY re.tipo_esp
					HAVING count(re.tipo_esp)>3)

);

SELECT re.tipo_esp,count(re.tipo_esp)
FROM reserva r
JOIN reserva_espacio re ON (r.nro_reserva=re.nro_reserva)
WHERE r.fecha_desde>=to_date('01/11/2019','DD/MM/YYYY')
GROUP BY re.tipo_esp
HAVING count(re.tipo_esp)>3



--EJERCICIO 7
--########################################################################


/*
+==============================+=========================================+=========================================+=========================================+
|            Tablas            |                 Insert                  |                 Update                  |                 Delete                  |
+==============================+=========================================+=========================================+=========================================+
| RESERVA                      | No                                      | fecha_desde                             | no                                      |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| RESERVA_ESPACIO              | Si                                      | tipo_esp,nro_reserva                    | no                                      |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
*/



--EJERCICIO 8
--########################################################################


--a) Construya una vista que contenga los identificadores de los contactos que poseen 
--antigüedad mayor a un año, junto con su nombre_apellido e importe total de las reservas
--iniciadas durante el corriente año que corresponden a espacios de más de 5 m2. 

--Determine si resulta actualizable o no en PosgreSQL, justificando adecuadamente su 
--respuesta e incluyendo un ejemplo.

--a. considero que me piden todos los contactos con antiguedad mayor a 1 año
--independientemente si han tenido reservas o no
CREATE VIEW CONTACTOS_ANT_MAYOR_1_AÑO AS	
	SELECT c.nro_doc,c.tipo_doc,sum(r.importe)
	FROM contacto c
	LEFT JOIN reserva r ON (c.nro_doc=r.nro_doc AND c.tipo_doc=r.tipo_doc)
	WHERE c.fecha_alta<current_date - INTERVAL '1 year'
	GROUP BY c.nro_doc,c.tipo_doc
;

--no es actualizable para PostgreSQL debido a que se utilizan funciones de agregacion
--y un join. El problema que tiene esto es que si queremos actualizar la suma de los importes
--de alguna tupla arrojada por esta vista, a cual de todos las reservas se le deberia sumar lo que falta
--o restar lo que sobra para llegar a ese valor que le estamos seteando

--En el caso de las insercciones se no se sabria que hacer, crear una reserva_espacio
--el tema es con cual de los espacios los vinculamos o que se deberia hacer.
--por esto estas vistas se podrian hacer actualizable utilizando un trigger instead of, 
--con alguna descisiones de negocio de que hacer ante el insert,update y delete

INSERT INTO contacto(nro_doc,tipo_doc,nom_apell,fecha_alta,e_mail)
VALUES (1,'a','holita',to_date('3-11-2018','DD-MM-YYYY'),'xD@gmail.com');
INSERT INTO contacto(nro_doc,tipo_doc,nom_apell,fecha_alta,e_mail)
VALUES (1,'b','holita',to_date('5-11-2018','DD-MM-YYYY'),'xD@gmail.com');

INSERT INTO reserva(nro_reserva,nro_doc,tipo_doc,fecha_desde,fecha_hasta,importe,confirmacion)
VALUES (2,1,'a',current_date,current_date,1000,true);
INSERT INTO reserva(nro_reserva,nro_doc,tipo_doc,fecha_desde,fecha_hasta,importe,confirmacion)
VALUES (1,1,'b',current_date,current_date,999,true);

SELECT c.nro_doc,c.tipo_doc,sum(r.importe)
FROM contacto c
LEFT JOIN reserva r ON (c.nro_doc=r.nro_doc AND c.tipo_doc=r.tipo_doc)
WHERE c.fecha_alta<current_date - INTERVAL '1 year'
GROUP BY c.nro_doc,c.tipo_doc


--EJERCICIO 9
--########################################################################


--Dadas las siguientes definiciones de vistas:

CREATE VIEW EspaciosAA AS 
SELECT  tipo_esp, descrip, superf_max, volum_max
FROM tipo_espacio
WHERE descrip LIKE ‘A%A’;
 

CREATE VIEW EspaciosSup AS 
SELECT *
FROM EspaciosAA
WHERE superf_max > 9
WITH LOCAL CHECK OPTION;

CREATE VIEW EspaciosVol AS 
SELECT *
FROM EspaciosAA
WHERE volum_max < 30
WITH CASCADED CHECK OPTION;


--Para las siguientes sentencias ejecutadas en el orden dado, indique si la operación procede
--o no, indicando cómo se propaga a la tabla tipo_espacio, justificando en cada caso. 
--(Nota: suponga la instancia original de la BD).

INSERT INTO EspaciosAA (tipo_esp, descrip, superf_max, volum_max) VALUES (‘T5’, ‘BIC’, 5, 10) ;

INSERT INTO EspaciosVol (tipo_esp, descrip, superf_max, volum_max) VALUES (‘T6’, ‘CRD’, 10, 29);

INSERT INTO EspaciosSup (tipo_esp, descrip, superf_max, volum_max) VALUES (‘T7’, ‘DRA’, 12, 36);

INSERT INTO EspaciosSup (tipo_esp, descrip, superf_max, volum_max) VALUES (‘T8’, ‘ARA’, 8, 20);

DELETE FROM EspaciosAA WHERE descrip= ‘BRA’; 

--1. Procede, pero cuando se consulte de nuevo sobre la vista no va a ser mostrada esta tupla
--2. Falla, EspaciosVol esta creado sobre la vista EspaciosAA y con cascaded check option,
--por lo tanto para poder insertar tiene que cumplir la condicion de la vista EspaciosAA
--que esta tupla en especifico no cumple dado que la descripcion 'CRD' no es del tipo 'A%A'
--3. Procede, ya que la EspaciosSup tiene una superf_max igual a 10 y al ser local check option
--solo se comprueba que cumpla la restriccion de la vista EspaciosSup
--4. Falla, porque se esta intentado insertar en EspaciosSup (que tiene local check option)
--una tupla que tiene un superf_max <= 9 lo cual falla por el local check option
--5. No se borra ninguna tupla, debido a que en la vista no se lista ninguna tupla que no tenga
--la descrip like 'A%A'


--EJERCICIO 10
--########################################################################


--Considere que se agrega a la tabla RESERVA el atributo espacios_distintos, 
--que registra la cantidad de espacios distintos asociados a cada reserva, el 
--cual se desea mantener automáticamente actualizado. 

--Provea en PosgreSQL la implementación completa de el/los trigger/s y la/s 
--funcion/es que sean necesario/s. 

--Considere soluciones lo más eficientes posible.

ALTER TABLE RESERVA DROP COLUMN espacios_distintos;

UPDATE reserva SET espacios_distintos=DEFAULT; 

ALTER TABLE RESERVA ADD COLUMN espacios_distintos int;
ALTER TABLE RESERVA ALTER COLUMN espacios_distintos SET DEFAULT 0;
ALTER TABLE RESERVA ALTER COLUMN espacios_distintos SET NOT NULL;

/*
+==============================+=========================================+=========================================+=========================================+
|            Tablas            |                 Insert                  |                 Update                  |                 Delete                  |
+==============================+=========================================+=========================================+=========================================+
| RESERVA_ESPACIO              | si                                      | tipo_esp                                | si                                      |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
*/

CREATE OR REPLACE FUNCTION FN_update_espacios_dist()
RETURNS TRIGGER AS
$BODY$
DECLARE 
	_cant int;
BEGIN
	IF (tg_op='INSERT') THEN
		IF NOT EXISTS ( SELECT 10
						FROM reserva_espacio
						WHERE tipo_esp=NEW.tipo_esp AND nro_reserva=NEW.nro_reserva) THEN
			UPDATE reserva SET espacios_distintos=espacios_distintos+1 WHERE nro_reserva=NEW.nro_reserva;
		END IF;
		RETURN NEW;
	END IF;
	IF (tg_op='UPDATE') THEN 
		IF NOT EXISTS ( SELECT 10
						FROM reserva_espacio
						WHERE tipo_esp=NEW.tipo_esp AND nro_reserva=NEW.nro_reserva) THEN
			UPDATE reserva SET espacios_distintos=espacios_distintos+1 WHERE nro_reserva=NEW.nro_reserva;
		END IF;
		SELECT count(*) INTO _cant
		FROM reserva_espacio 
		WHERE tipo_esp=OLD.tipo_esp AND nro_reserva=OLD.nro_reserva;
		IF (_cant = 1) THEN
			UPDATE reserva SET espacios_distintos=espacios_distintos-1 WHERE nro_reserva=OLD.nro_reserva;
		END IF;
		RETURN NEW;
	END IF;
	IF (tg_op='DELETE') THEN
		SELECT count(*) INTO _cant
		FROM reserva_espacio 
		WHERE tipo_esp=OLD.tipo_esp AND nro_reserva=OLD.nro_reserva;
		IF (_cant=1) THEN
			UPDATE reserva SET espacios_distintos=espacios_distintos-1 WHERE nro_reserva=OLD.nro_reserva;
		END IF;
		RETURN OLD;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_update_espacios_dist
BEFORE INSERT OR DELETE OR UPDATE OF tipo_esp ON reserva_espacio
FOR EACH ROW	
EXECUTE PROCEDURE FN_update_espacios_dist();





--EJERCICIO 11
--########################################################################


--A con todos los permisos (por ser OWNER)
--B con SELECT (otorgado por A)
--C con SELECT y UPDATE con grant option (otorgado por A)
--D con SELECT (otorgado por A)

--1. Solo A y C
--2. Solo A, B, C y D
--3. Solo A y C
--4. Solo A





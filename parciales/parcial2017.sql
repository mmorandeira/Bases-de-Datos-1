

--EJERCICIO 1
--########################################################################


--creacion de tablas
CREATE TABLE parcial_2017_turno (
	id_turno int NOT NULL,
	CONSTRAINT PK_parcial_2017_turno PRIMARY KEY(id_turno)
);

CREATE TABLE parcial_2017_comprobante (
	id_comprobante int NOT NULL,
	id_turno int NULL,
	CONSTRAINT PK_parcial_2017_comprobante PRIMARY KEY(id_comprobante)
);

--inserccion de elementos
INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (1,NULL);
INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (2,NULL);
INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (3,NULL);
INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (4,NULL);

INSERT INTO parcial_2017_turno(id_turno) VALUES (1);
INSERT INTO parcial_2017_turno(id_turno) VALUES (2);
INSERT INTO parcial_2017_turno(id_turno) VALUES (3);
INSERT INTO parcial_2017_turno(id_turno) VALUES (4);

--En que casos las siguientes consultas son equivalentes (dan el mismo resultado)

SELECT *
FROM wireless_turno
WHERE id_turno NOT IN (SELECT id_turno FROM parcial_2017_comprobante);
--En el subquery del de arriba se devuelven valores con null (si los hubiera) y conociendo
--el funcionamiento del not in es x (x<>y1 && x<>y2 && x<>y3 ... x<>yn) si ya hay uno con
--null cuando se tope con ese valor la comparacion entre x<>null es null que se toma como
--falso por lo tanto a cualquier valor de x, estaria diciendo que esta en ese subcojunto
					
SELECT *
FROM wireless_turno t
WHERE NOT EXISTS (SELECT 1 FROM parcial_2017_comprobante WHERE id_turno=t.id_turno);
--En el subquery del de arriba no se pueden devolver valores con null, debido que el
--filtrado de where al comparar x=null da null que es tomado como falso, entonces este
--valor no es incluido como parte de cojunto por lo tanto para que no se incluya ese 
--turno no tiene existir un comprobante con ese id de turno


--Cuando las tablas estan vacias
--Cuando hay varios comprobantes que referencian al mismo turno (siempre y cuando no haya alguno con nulls)
--Cuando todo comprobante referencia a turnos distintos
--Cuando todo comprobante referencia a un turno


--EJERCICIO 2
--########################################################################


--OPCION DE NOT IN
--En el subquery del de arriba se devuelven valores con null (si los hubiera) y conociendo
--el funcionamiento del not in es x (x<>y1 && x<>y2 && x<>y3 ... x<>yn) si ya hay uno con
--null cuando se tope con ese valor la comparacion entre x<>null es null que se toma como
--falso por lo tanto a cualquier valor de x, estaria diciendo que esta en ese subcojunto
					
--OPCION DE NOT EXISTS
--En el subquery del de arriba no se pueden devolver valores con null, debido que el
--filtrado de where al comparar x=null da null que es tomado como falso, entonces este
--valor no es incluido como parte de cojunto por lo tanto para


--EJERCICIO 3
--########################################################################


--Se desea controlar que no existan mas de 500 equipos por servicio. Marque el recurso
--SQL mas adecuado para implementarla

--El recurso seria un check de tabla.
ALTER TABLE wireless_equipo ADD CONSTRAINT CK_max_equipo_serv
CHECK (NOT EXISTS (	SELECT 1 
					FROM wireless_equipo
					GROUP BY id_servicio
					HAVING count(*)>500))
;


--EJERCICIO 4
--########################################################################


--Implementar en PostgreSQL la restriccion anterior de la manera mas eficiente posible

/*
+==============================+=========================================+=========================================+=========================================+
|            Tablas            |                 Insert                  |                 Update                  |                 Delete                  |
+==============================+=========================================+=========================================+=========================================+
| EQUIPO                       | Solo checkeo                            | id_servicio                             | no se checkea                           |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
*/


CREATE OR REPLACE FUNCTION FN_parcial2017_max_equipo_serv()
RETURNS TRIGGER AS
$BODY$
DECLARE
	_cantidad int;
BEGIN
	SELECT count(*) INTO _cantidad
	FROM wireless_equipo
	WHERE id_servicio = NEW.id_servicio;
	IF (_cantidad = NEW.id_servicio) THEN 
		RAISE EXCEPTION 'No se permiten servicios con mas de 500 equipos';
	END IF;
	RETURN new;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_max_equipo_serv
BEFORE INSERT OR UPDATE OF id_servicio ON wireless_equipo
FOR EACH ROW
EXECUTE PROCEDURE FN_parcial2017_max_equipo_serv();

--EJERCICIO 5
--########################################################################


--El recurso declarativo a utilizar seria un assertion


--EJERCICIO 6
--########################################################################
				

CREATE ASSERTION AS_no_mas_70
CHECK (NOT EXISTS (	SELECT 1
					FROM wireless_comprobante c
					JOIN wireless_turno t ON (c.id_turno=t.id_turno)
					GROUP BY t.id_personal
					HAVING count(*) > 0.7*(SELECT count(*) FROM wireless_comprobante))
);


--EJERCICIO 7
--########################################################################


--Se quiere implementar la restricion que ningun empleado genere mas del 70% del total de comprobantes
--mediante trigger/s en PostgreSQL. Ante que operaciones se deberia actualizar el Trigger? marque la/s
--opcione/es correcta/s
/*
+==============================+=========================================+=========================================+=========================================+
|            Tablas            |                 Insert                  |                 Update                  |                 Delete                  |
+==============================+=========================================+=========================================+=========================================+
| Comprobante                  | Si                                      | id_turno                                | No                                      |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| Turno                        | No                                      | id_personal                             | No                                      |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
*/

--a. Inserccion en Comprobante
--b. Actualizacion de idTurno en Comprobante
--e. Actualizacion de idPersonal en Turno

CREATE OR REPLACE FUNCTION FN_parcial2017_max_factura_70_comprobante()
RETURNS TRIGGER AS
$BODY$
DECLARE
	_empleado int;
BEGIN
	SELECT id_personal INTO _empleado
	FROM wireless_turno
	WHERE id_turno=NEW.id_turno;
	IF (_empleado IS NOT NULL) THEN
		IF EXISTS (	SELECT 1
					FROM wireless_comprobante c
					JOIN wireless_turno t ON (c.id_turno=t.id_turno)
					WHERE t.id_personal=_empleado
					GROUP BY t.id_personal
					HAVING count(*) > 0.7*(SELECT count(*) FROM wireless_comprobante)) THEN 
			RAISE EXCEPTION 'No se permite que un empleado tenga mas del 70% de facturas';
		END IF;
	ELSE
		IF (NEW.id_turno IS NOT NULL) THEN
			RAISE EXCEPTION 'id_turno no encontrado';
		END IF;
	END IF;
	RETURN new;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_parcial2017_max_factura_70
BEFORE INSERT OR UPDATE OF id_turno ON wireless_comprobante
FOR EACH ROW
EXECUTE PROCEDURE FN_parcial2017_max_factura_70_comprobante();

CREATE OR REPLACE FUNCTION FN_parcial2017_max_factura_70_turno()
RETURNS TRIGGER AS
$BODY$
DECLARE
	_cantidad int;
BEGIN
	SELECT count(*) INTO _cantidad
	FROM wireless_comprobante c
	JOIN wireless_turno t ON (c.id_turno=t.id_turno)
	WHERE t.id_personal=NEW.id_personal;
	IF EXISTS (	SELECT 1
				FROM wireless_comprobante c
				JOIN wireless_turno t ON (c.id_turno=t.id_turno)
				WHERE t.id_turno=OLD.id_turno
				GROUP BY t.id_personal
				HAVING count(*) + _cantidad > 0.7*(SELECT count(*) FROM wireless_comprobante)) THEN
		RAISE EXCEPTION 'No se permite que un empleado tenga mas del 70% de facturas';
	END IF;
	RETURN new;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_parcial2017_max_factura_70
BEFORE UPDATE OF id_personal ON wireless_turno
FOR EACH ROW
EXECUTE PROCEDURE FN_parcial2017_max_factura_70_turno();



--EJERCICIO 8
--########################################################################


--Indique cual/es de las siguientes afrimaciones es/son verdadera/s para la operacion:
DELETE FROM wireless_comprobante
WHERE id_comp=28 AND id_tcomp=1;

--La opcion correcta es:
--a. No se puede eliminar el comprobante (28,1) si no se eliminan previamente sus lineas asociadas

--28	1	2011-01-03 00:00:00	5	dolor elit,		2011-01-13 00:00:00		203.00000	89
SELECT *
FROM wireless_comprobante
WHERE id_comp=28 AND id_tcomp=1;

SELECT *
FROM wireless_lineacomprobante
WHERE id_comp=28 AND id_tcomp=1;


--EJERCICIO 9
--########################################################################







--EJERCICIO 16
--########################################################################


--A queda con todos
--B queda con insert y select con grant option(dado por B)
--C queda con select (dado por A y B)
--D queda con select (dado por b)
--INSERT INTO A.personal VALUES (...); -> solo A y B
--SELECT * FROM A.personal; -> A, B, C, D
--GRANT SELECT ON A.personal TO E; -> A y B


--EJERCICIO 17
--########################################################################


--A queda con todos
--B queda con insert con grant option(dado por B)
--C queda con select (dado por A)


--EJERCICIO 18
--########################################################################


--Opcion con la suma de los ultimos 7 años
SELECT p.id_persona,p.nombre,p.apellido,sum(importe)
FROM wireless_comprobante c
JOIN wireless_turno t ON (c.id_turno=t.id_turno)
JOIN wireless_persona p ON (t.id_personal=p.id_persona)
WHERE (to_date('4-11-2017','DD-MM-YYYY')-INTERVAL '7 year') <= fecha AND (c.id_tcomp=1 OR c.id_tcomp=3)
GROUP BY p.id_persona
ORDER BY sum(importe) 
LIMIT 1
OFFSET 2
--Fue Maris Barker con 352.49

--Otra opcion con la suma de todo el sistema
SELECT p.id_persona,p.nombre,p.apellido,sum(importe)
FROM wireless_comprobante c
JOIN wireless_turno t ON (c.id_turno=t.id_turno)
JOIN wireless_persona p ON (t.id_personal=p.id_persona)
WHERE p.id_persona IN ( SELECT t.id_personal
						FROM wireless_comprobante c
						JOIN wireless_turno t ON (c.id_turno=t.id_turno)
						WHERE (to_date('4-11-2017','DD-MM-YYYY')-INTERVAL '7 year') <= fecha AND (c.id_tcomp=1 OR c.id_tcomp=3))
GROUP BY p.id_persona
ORDER BY sum(importe) 
LIMIT 1
OFFSET 2
--Harding Hahn con 2,135 otra opcion


--EJERCICIO 19
--########################################################################


SELECT count(*)
FROM wireless_comprobante c
WHERE c.id_tcomp=1

--El total de comprobantes que son Facturas generados durantes turnos




















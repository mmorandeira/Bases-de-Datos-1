

--PREGUNTA 1
--########################################################################


--Este query devuelve "Las habitaciones ubicadas en la ciudad "Terrance" cuyo
--precio por noche de la habitacion es mayor a 45
SELECT h.*
FROM unc_esq_dptos.departamento d
NATURAL JOIN unc_esq_dptos.habitacion h
WHERE h.precio_noche > 45 AND d.cod_ciudad = 13;


--PREGUNTA 2
--########################################################################


--Se desea controlar que un mismo propietario no tenga mas de 4 departamentos en
--alquiler. El recurso declarativo en sql estandar seria restriccion de tabla


--PREGUNTA 3
--########################################################################

/*
ALTER TABLE unc_esq_dptos.departamento ADD CONSTRAINT max_4_dptos
CHECK (NOT EXISTS ( SELECT 1
					FROM unc_esq_dptos.departamento
					GROUP BY tipo_doc,nro_doc
					HAVING count(*)>4));*/

				
--PREGUNTA 4
--########################################################################				
				
				
--Se desea controlar que un propietario, en caso de tener algun departamento de una
--habitacion, no posea mas de 4 departamentos en total. El recurso declarativo en sql
--estandar seria restriccion general (assertion)
/*
CREATE ASSERTION as_mas_4_dptos_si_tiene_1hab CHECK (	SELECT d.tipo_doc,d.nro_doc
														FROM unc_esq_dptos.departamento d
														JOIN unc_esq_dptos.habitacion h ON (d.id_dpto=h.id_dpto)
														GROUP BY d.id_dpto 
														HAVING count(*)=1
														INTERSECT
														SELECT tipo_doc,nro_doc
														FROM unc_esq_dptos.departamento
														GROUP BY tipo_doc,nro_doc
														HAVING count(*)>2 );*/
												
													
--PREGUNTA 5
--########################################################################	


--Seleccione cual/es de las siguientes operaciones son evento/s critico/s asociado/s
--a la restriccion anterior
--Modificacion de id_dpto en Habitacion.
--Inserccion en Habitacion
--Eliminacion en Habitacion
--Inserccion en Departamento
--Modificacion de tipo_doc,nro_doc en Departamento

													
--PREGUNTA 6
--########################################################################

													
/*
+==============================+=========================================+=========================================+=========================================+
|            Tablas            |                 Insert                  |                 Update                  |                 Delete                  |
+==============================+=========================================+=========================================+=========================================+
| Departamento                 | Si                                      | tipo_doc,nro_doc                        | No                                      |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| Habitacion                   | Si                                      | id_dpto                                 | Si(por si queda con 1 habitacion)       |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
*/

CREATE OR REPLACE PROCEDURE parcial_2018_checkeo_new(_hab record)
LANGUAGE 'plpgsql'
AS
$BODY$
DECLARE
	_cant_dptos int;
	_propietario record;
BEGIN
	IF NOT EXISTS ( SELECT 1
					FROM dptos_habitacion
					WHERE id_dpto=_hab.id_dpto) THEN
		SELECT tipo_doc,nro_doc INTO _propietario
		FROM dptos_departamento
		WHERE id_dpto=_hab.id_dpto;
		IF (_propietario IS NULL) THEN
			RAISE EXCEPTION 'Departamento inexistente';
		END IF;
		SELECT count(*) INTO _cant_dptos
		FROM dptos_departamentos
		WHERE tipo_doc=propietario.tipo_doc AND nro_doc=propietario.nro_doc
		GROUP BY tipo_doc,nro_doc;
		IF (_cant_dptos>=4) THEN
			RAISE EXCEPTION 'No se permiten propietarios con mas de 4 departamentos si tienen uno de una habitación';
		END IF;
	END IF;
END;
$BODY$;



CREATE OR REPLACE FUNCTION parcial_2018_checkeo_old(_hab record)
RETURNS BOOLEAN AS
$BODY$
DECLARE
	_cant_dptos int;
	_propietario record;
BEGIN
	IF EXISTS(	SELECT 1
				FROM dptos_habitacion
				WHERE id_dpto=_hab.id_dpto
				GROUP BY id_dpto
				HAVING count(*)=2) THEN
		SELECT tipo_doc,nro_doc INTO _propietario
		FROM dptos_departamento
		WHERE id_dpto=_hab.id_dpto;
		IF (_propietario IS NOT NULL) THEN
			RAISE EXCEPTION 'Departamento inexistente';
		END IF;
		SELECT count(*) INTO _cant_dptos
		FROM dptos_departamento
		WHERE tipo_doc=propietario.tipo_doc AND nro_doc=propietario.nro_doc
		GROUP BY tipo_doc,nro_doc;
		IF (_cant_dptos>=4) THEN
			RAISE EXCEPTION 'No se permiten propietarios con mas de 4 departamentos si tienen uno de una habitación';
		END IF;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION parcial_2018_mas_4_dptos_departamento()
RETURNS TRIGGER AS
$BODY$
DECLARE 
	_cant_dptos int;
BEGIN
	IF (tg_op='INSERT') THEN
		IF EXISTS (	SELECT 1
					FROM dptos_habitacion h
					JOIN dptos_departamento d ON (h.id_dpto=d.id_dpto)
					WHERE d.tipo_doc=NEW.tipo_doc AND d.nro_doc=NEW.nro_doc
					GROUP BY id_dpto
					HAVING count(*)=1) THEN
			SELECT count(*) INTO _cant_dptos
			FROM dptos_departamento
			WHERE d.tipo_doc=NEW.tipo_doc AND d.nro_doc=NEW.nro_doc
			GROUP BY d.tipo_doc,d.nro_doc;
			IF (_cant_dptos>=4) THEN
				RAISE EXCEPTION 'No se permiten propietarios con mas de 4 departamentos si tienen uno de una habitación';
			END IF;
		END IF;
		RETURN NEW;
	END IF;
	IF (tg_op='UPDATE') THEN
		IF EXISTS (	SELECT 1
					FROM dptos_habitacion h
					WHERE h.id_dpto=OLD.id_dpto
					GROUP BY id_dpto
					HAVING count(*)=1  
					UNION
				   	SELECT 1
					FROM dptos_departamento d
					JOIN dptos_habitacion h ON (d.id_dpto=h.id_dpto)
					WHERE d.tipo_doc=NEW.tipo_doc AND d.nro_doc=NEW.nro_doc
					GROUP BY id_dpto
					HAVING count(*)=1) THEN
			--Si el departamento viejo tiene una sola habitacion o alguno de los que ya tenia el propietario tiene una
			--tengo que comprobar si supera la cantidad maxima de departamentos
			SELECT count(*) INTO _cant_dptos
			FROM dptos_departamento
			WHERE d.tipo_doc=NEW.tipo_doc AND d.nro_doc=NEW.nro_doc
			GROUP BY d.tipo_doc,d.nro_doc;
			IF (_cant_dptos>=4) THEN
				RAISE EXCEPTION 'No se permiten propietarios con mas de 4 departamentos si tienen uno de una habitación';
			END IF;
		END IF;
		RETURN NEW;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION parcial_2018_mas_4_dptos_habitacion()
RETURNS TRIGGER AS
$BODY$
BEGIN
	IF (tg_op='INSERT') THEN
		CALL parcial_2018_checkeo_new(NEW);
		RETURN NEW;
	END IF;
	IF (tg_op='UPDATE') THEN
		CALL parcial_2018_checkeo_old(OLD);
		CALL parcial_2018_checkeo_new(NEW);
		RETURN NEW;
	END IF;
	IF (tg_op='DELETE') THEN
		CALL parcial_2018_checkeo_old(OLD);
		RETURN OLD;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER parcial_2018_mas_4_dptos_habitacion
BEFORE INSERT OR DELETE OR UPDATE OF id_dpto ON dptos_habitacion
FOR EACH ROW
EXECUTE PROCEDURE parcial_2018_mas_4_dptos_habitacion();

CREATE TRIGGER parcial_2018_mas_4_dptos_departamento
BEFORE INSERT OR UPDATE OF tipo_doc,nro_doc ON dptos_departamento
FOR EACH ROW
EXECUTE PROCEDURE parcial_2018_mas_4_dptos_departamento();
				
				
				
SELECT id_dpto
FROM unc_esq_dptos.departamento


--PREGUNTA 7
--########################################################################


--Utilizando el metodo que Ud. crea mas adecuado, resolver e implementar en PostgreSQL el
--servicio que: dada dos fechas, permita obtener un listado por huesped con el tiempo total
--(en dias) que tuvo reservadas solo habitaciones con cocinas.


CREATE OR REPLACE FUNCTION FN_listar_huesped(_fecha_inf date,fecha_sup date)
RETURNS TABLE(	tipo_doc bpchar(3),
				nro_doc NUMERIC(11,0),
				duracion integer)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT r.tipo_doc,r.nro_doc,r.fecha_hasta-r.fecha_desde AS "duracion"
	FROM dptos_reserva r
	JOIN dptos_reserva_hab h ON (r.id_reserva=h.id_reserva)
	JOIN dptos_habitacion hab ON (h.id_habitacion=hab.id_habitacion AND h.id_dpto=hab.id_dpto)
	WHERE (r.fecha_reserva BETWEEN _fecha_inf AND fecha_sup) AND (hab.cocina);
END;
$BODY$
LANGUAGE 'plpgsql';

DROP FUNCTION FN_listar_huesped;


SELECT *
FROM fn_listar_huesped(to_date('2017-11-23','YYYY-MM-DD'), to_date('2017-12-04','YYYY-MM-DD'));

SELECT tipo_doc,nro_doc,EXTRACT( DAY FROM age(fecha_hasta,fecha_desde)) AS "duracion"
FROM dptos_reserva
JOIN 
WHERE fecha_reserva BETWEEN to_date('2017-11-23','YYYY-MM-DD') AND to_date('2017-12-04','YYYY-MM-DD')


--PREGUNTA 8
--########################################################################


--Proveea la sentencia SQL para definir la vista "EstadoReserva" conteniendo el indentificador
--y el estado de cancelacion de las reservas que hayan recibido algun pago mayor a $ 1050


CREATE VIEW parcial_2018_EstadoReserva AS
	SELECT id_reserva,cancelada
	FROM dptos_reserva
	WHERE id_reserva IN (	SELECT id_reserva
							FROM dptos_pago
							WHERE importe>1050)
;


--PREGUNTA 9
--########################################################################


CREATE VIEW parcial_2018_EstadoReserva_no_updateable AS
	SELECT r.id_reserva,r.cancelada
	FROM dptos_reserva r
	JOIN dptos_pago p ON (r.id_reserva=p.id_reserva)
	WHERE p.importe>1050
;


--PREGUNTA 10
--########################################################################


--Dadas las siguientes vistas
CREATE VIEW HabitacionSimple AS
SELECT H.*
FROM Habitacion H
WHERE H.posib_carnas simples > 3
WITH LOCAL CHECK OPTFON,

CREATE VIEW HabitacionMix AS
SELECT H.*
FROM HabitacionSimple H
WHERE H.frigObat = 1
WITH LOCAL CHECK OPTION;
--Cual seria el resultadc si se ejecutan las sigaientes sentencias (en el orden dada). Tener en cuenta que el 'ego de los valores se
--completan con datos validos.
INSERT INTO HabitacionMix (id_dpto,id_habitacion,posib_camas_simples,frigobar,...) VALUES (66, 1, 5, 2)
INSERT INTO HabitacionMix (id_dpto,id_habitacion,posib_camas_simples,frigobar,...) VALUES (66, 1, 4, 1)
INSERT INTO HabitacionSimple (id_dpto,id_habitacion,posib_camas_simples,frigobar,...) VALUES (330, 1, 2, 1)
INSERT INTO HabitacionSimple (id_dpto,id_habitacion,posib_camas_simples,frigobar,...) VALUES (66, 1, 5, 1)


--Si son acumulables falla, procede, falla, falla
--Si no son acumulables falla, procede, falla, procede
a

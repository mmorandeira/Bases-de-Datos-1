

--PREGUNTA 1
--########################################################################


--Este query devuelve "Las habitaciones ubicadas en la ciudad "Terrance" cuyo
--precio por noche de la habitación es mayor a 45
SELECT h.*
FROM unc_esq_dptos.departamento d
NATURAL JOIN unc_esq_dptos.habitacion h
WHERE h.precio_noche > 45 AND d.cod_ciudad = 13;


--PREGUNTA 2
--########################################################################


--Se desea controlar que un mismo propietario no tenga más de 4 departamentos en
--alquiler. El recurso declarativo en sql estándar seria restriccion de tabla


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
				
				
--Se desea controlar que un propietario, en caso de tener algún departamento de una
--habitación, no posea más de 4 departamentos en total. El recurso declarativo en sql
--estándar seria restriccion general (assertion)
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


--Seleccione cuál/es de las siguientes operaciones son evento/s crítico/s asociado/s
--a la restricción anterior
--Modificación de id_dpto en Habitación.
--Insercción en Habitación
--Eliminación en Habitacion
--Inserccion en Departamento
--Modificación de tipo_doc,nro_doc en Departamento

													
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


CREATE OR REPLACE FUNCTION parcial_2018_mas_4_dptos_dptos()
RETURNS TRIGGER AS
$BODY$
DECLARE 
	_cant_dptos int;
	_propietario record;
BEGIN
	IF (tg_op='INSERT') THEN
		IF NOT EXISTS ( SELECT 1
						FROM dptos_habitacion
						WHERE id_dpto=NEW.id_dpto) THEN
			SELECT tipo_doc,nro_doc INTO _propietario
			FROM dptos_departamento
			WHERE id_dpto=NEW.id_dpto;
			IF ( _propietario IS NOT NULL ) THEN
				RAISE EXCEPTION 'Departamento inexistente';
			END IF;
			SELECT count(*) INTO _cant_dptos
			FROM dptos_ciudad
			WHERE tipo_doc=propietario.tipo_doc AND nro_doc=propietario.nro_doc
			GROUP BY tipo_doc,nro_doc;
			IF ( _cant_dptos >= 4 ) THEN
				RAISE EXCEPTION 'No se permiten propietarios con mas de 4 departamentos si tienen uno de una habitación';
			END IF;
		END IF;
	END IF;
	/*
	IF (tg_op='UPDATE') THEN
	BEGIN
		
	END IF;*/
	IF (tg_op='DELETE' OR tg_op='UPDATE') THEN
		IF EXISTS(	SELECT 1
					FROM dptos_habitacion
					WHERE id_dpto=OLD.id_dpto
					GROUP BY id_dpto
					HAVING count(*)=1) THEN
		--si la habitacion que borraban era la unica de un dpto tengo que checkear
			SELECT tipo_doc,nro_doc INTO _propietario
			FROM dptos_departamento
			WHERE id_dpto=OLD.id_dpto;
			IF ( _propietario IS NOT NULL ) THEN
				RAISE EXCEPTION 'Departamento inexistente';
			END IF;
			SELECT count(*) INTO _cant_dptos
			FROM dptos_ciudad
			WHERE tipo_doc=propietario.tipo_doc AND nro_doc=propietario.nro_doc
			GROUP BY tipo_doc,nro_doc;
			IF ( _cant_dptos >= 4 ) THEN
				RAISE EXCEPTION 'No se permiten propietarios con mas de 4 departamentos si tienen uno de una habitación';
			END IF;
		END IF;
	END IF;
	RETURN new;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION parcial_2018_mas_4_dptos_habitacion()
RETURNS TRIGGER AS
$BODY$
BEGIN
	RETURN new;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER parcial_2018_mas_4_dptos_habitacion
BEFORE INSERT OR DELETE OR UPDATE OF id_dpto ON dptos_habitacion
FOR EACH ROW
EXECUTE PROCEDURE parcial_2018_mas_4_dptos_habitacion();

CREATE TRIGGER parcial_2018_mas_4_dptos_dptos
BEFORE INSERT OR UPDATE OF tipo_doc,nro_doc ON dptos_departamento
FOR EACH ROW
EXECUTE PROCEDURE parcial_2018_mas_4_dptos_dptos();
				
				
				
SELECT id_dpto
FROM unc_esq_dptos.departamento
EXCEPT
SELECT id_dpto
FROM unc_esq_dptos.habitacion







CREATE OR REPLACE FUNCTION FN_update_habitacion() RETURNS trigger AS
$BODY$
	DECLARE
		prop record;
	BEGIN
		--OBTENGO EL ID DEL PROPIETARIO NUEVO DEL DEPTO
		SELECT tipo_doc,nro_doc INTO id_prop_viejo
		FROM departamento
		WHERE id_depto = NEW.id_depto
		
		IF(id_prop_viejo IS NOT NULL)THEN 
			--SI EL DEPARTAMENTO NUEVO NO TENIA HABITACIONES (AHORA PASARIA A TENER UNA)
			IF(	((SELECT count(*) FROM habitacion WHERE id_depto = NEW.id_depto) = 0) 
				AND --Y ADEMAS EL PROPIETARIO DEL NUEVO DEPARTAMENTO TIENE MAS DE 4 DEPTOS
				((SELECT count(*) FROM departamento WHERE tipo_doc = prop.tipo_doc AND nro_doc = prop.nro_doc) > 4) 
			THEN
				RAISE EXCEPTION 'nain nain nain';
			END IF;
		END IF;
		
		--OBTENGO EL ID DEL PROPIETARIO VIEJO DEL DEPTO
		SELECT tipo_doc,nro_doc INTO id_prop_viejo
		FROM departamento
		WHERE id_depto = OLD.id_depto
		
		IF(id_prop_viejo IS NOT NULL)THEN 
			--SI EL DEPARTAMENTO VIEJO TENIA SOLO 2 HABITACIONES (AHORA PASARIA A TENER UNA)
			IF(	((SELECT count(*) FROM habitacion WHERE id_depto = OLD.id_depto) = 2) 
				AND --Y ADEMAS EL PROPIETARIO DEL VIEJO DEPARTAMENTO TIENE MAS DE 4 DEPTOS
				((SELECT count(*) FROM departamento WHERE tipo_doc = prop.tipo_doc AND nro_doc = prop.nro_doc) > 4) 
			THEN
				RAISE EXCEPTION 'nain nain nain';
			END IF;
		END IF;
		RETURN NEW;
	END 
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_update_habitacion
	BEFORE UPDATE OF id_depto
	ON habitacion
	FOR EACH ROW
	EXECUTE PROCEDURE FN_update_habitacion();










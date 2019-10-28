

--EJERCICIO 1
--########################################################################



--EJERCICIO 2
--########################################################################

--CREACION DE LA TABLA HIS_ENTREGA
CREATE table pelicula_his_entrega (
	nro_registro serial NOT NULL,
	fecha date NOT NULL,
	operacion varchar(10) NOT NULL,
	cant_reg_afectados int NOT NULL,
	usuario varchar(40) NOT NULL
);

CREATE OR REPLACE FUNCTION updateLog() RETURNS TRIGGER AS
$$
DECLARE
	cant integer;
BEGIN
	SELECT count(*) INTO cant
	FROM new_table;
	INSERT INTO pelicula_his_entrega(fecha,operacion,cant_reg_afectados,usuario) VALUES (CURRENT_DATE,TG_OP,cant,CURRENT_USER);
	RETURN NULL;
END
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_updateLog1
AFTER INSERT
ON pelicula_entrega
REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE PROCEDURE updateLog();
	
CREATE TRIGGER tr_updateLog2
AFTER update
ON pelicula_entrega
REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE PROCEDURE updateLog();
	
CREATE TRIGGER tr_updateLog3
AFTER delete
ON pelicula_entrega
REFERENCING OLD TABLE AS new_table
	FOR EACH STATEMENT EXECUTE PROCEDURE updateLog();
	
CREATE TRIGGER tr_updateLog4
AFTER INSERT
ON pelicula_renglon_entrega
REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE PROCEDURE updateLog();
	
CREATE TRIGGER tr_updateLog5
AFTER update
ON pelicula_renglon_entrega
REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE PROCEDURE updateLog();
	
CREATE TRIGGER tr_updateLog6
AFTER delete
ON pelicula_renglon_entrega
REFERENCING OLD TABLE AS new_table
	FOR EACH STATEMENT EXECUTE PROCEDURE updateLog();
	
SELECT *
FROM pelicula_entrega
WHERE nro_entrega=585

--borro el registro (585,2006-09-06,6469,869)
DELETE FROM pelicula_entrega WHERE nro_entrega=585

SELECT *
FROM pelicula_his_entrega

--EJERCICIO 3
--########################################################################

CREATE TABLE tp3p2_ej3_empleado_1 (
	id_empleado int NOT NULL,
	nombre varchar(30) NULL,
	apellido varchar(30) NULL,
	sueldo int NOT NULL,
	CONSTRAINT pk_tp3p2_ej3_empleado_1 PRIMARY KEY(id_empleado)
)

INSERT INTO tp3p2_ej3_empleado_1(id_empleado,sueldo) VALUES (100,500);

CREATE TABLE tp3p2_ej3_empleado_2 (
	id_empleado int NOT NULL,
	nombre varchar(30) NULL,
	apellido varchar(30) NULL,
	sueldo int NOT NULL,
	CONSTRAINT pk_tp3p2_ej3_empleado_2 PRIMARY KEY(id_empleado)
);

INSERT into tp3p2_ej3_empleado_2(id_empleado,sueldo) VALUES (2,700),(3,300),(4,700);

SELECT *
FROM tp3p2_ej3_empleado_1

SELECT *
FROM tp3p2_ej3_empleado_2

CREATE OR REPLACE FUNCTION autoIncremento()
RETURNS TRIGGER AS 
$$
BEGIN
	UPDATE tp3p2_ej3_empleado_1 SET
		sueldo=sueldo-(SELECT MIN(sueldo)*0.05 FROM tp3p2_ej3_empleado_1)
	;
	RETURN NEW;
END
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER trigger_autoincremento
BEFORE INSERT ON tp3p2_ej3_empleado_1
FOR EACH ROW
EXECUTE PROCEDURE autoIncremento()

INSERT INTO tp3p2_ej3_empleado_1
SELECT * FROM tp3p2_ej3_empleado_2

DELETE FROM tp3p2_ej3_empleado_1 WHERE id_empleado!=100

UPDATE tp3p2_ej3_empleado_1 SET sueldo=500 WHERE id_empleado=100


--EJERCICIO 4
--########################################################################

CREATE TABLE pelicula_historico (
	id_empleado numeric(6,0) NOT NULL,
	id_distribuidor numeric(5,0) NOT NULL,
	id_departamento numeric(4,0) NOT NULL,
	fecha_inicio timestamp NOT NULL,
	fecha_fin timestamp NULL,
	
	CONSTRAINT pk_pelicula_historico PRIMARY KEY(id_empleado,id_departamento,id_distribuidor,fecha_inicio)
);

ALTER TABLE pelicula_historico
	ADD CONSTRAINT FK_pelicula_historico_pelicula_empleado FOREIGN KEY(id_empleado)
	REFERENCES pelicula_empleado(id_empleado)
;

ALTER TABLE pelicula_historico
	ADD CONSTRAINT FK_pelicula_historico_pelicula_departamento FOREIGN KEY(id_departamento,id_distribuidor)
	REFERENCES pelicula_departamento(id_departamento,id_distribuidor)
;

CREATE TABLE pelicula_historico_empleado (
	id_empleado numeric(6,0) NOT NULL,
	id_distribuidor numeric(5,0) NOT NULL,
	id_departamento numeric(4,0) NOT NULL,
	promedio real NOT NULL,--numeric(a,b) a cantidad de digitos totales, b parte decimal de digitos
	CONSTRAINT pk_pelicula_historico_empleado PRIMARY KEY(id_empleado,id_departamento,id_distribuidor)
);

ALTER TABLE pelicula_historico_empleado
	ADD CONSTRAINT FK_pelicula_historico_empleado_pelicula_empleado FOREIGN KEY(id_empleado)
	REFERENCES pelicula_empleado(id_empleado)
;

ALTER TABLE pelicula_historico_empleado
	ADD CONSTRAINT FK_pelicula_historico_empleado_pelicula_departamento FOREIGN KEY(id_departamento,id_distribuidor)
	REFERENCES pelicula_departamento(id_departamento,id_distribuidor)
;

--AGREGAR TEMA DE HORAS TOTALES DEL SISTEMA
ALTER TABLE pelicula_empleado
ADD COLUMN horas_totales real;

--el tema de las horas totales es muy mala. yo en ves de agregar
--las horas agregaria la fecha de inicio del sistema, y que se calcule
--la horas que estuve haciendo una cuenta de fecha aactual-fecha de ingreso
--porque esta hora no va estar nunca actualizada, a no se que se llame a un
--stored procedure

--agrego el valor por defecto
ALTER TABLE pelicula_empleado
ALTER COLUMN horas_totales SET DEFAULT 0;

--updateo todos los registro con el valor por defecto
UPDATE pelicula_empleado 
SET horas_totales=DEFAULT;

--agrego la restriccion de NOT NULL
ALTER TABLE pelicula_empleado
ALTER COLUMN horas_totales SET NOT NULL;

--agrego la columna fecha_inicio
ALTER TABLE pelicula_empleado
ADD COLUMN fecha_inicio timestamp;

--agrego el valor por defecto de la columna como "ahora"
ALTER TABLE pelicula_empleado 
ALTER COLUMN fecha_inicio SET DEFAULT current_timestamp;

--seteo todos los valores de fecha_incio a "ahora"
UPDATE pelicula_empleado 
set fecha_inicio=default;

SELECT *
FROM pelicula_empleado AS pe;

--agrego la restriccion que no puede ser NULL
ALTER TABLE pelicula_empleado
ALTER COLUMN fecha_inicio SET NOT NULL;

CREATE OR REPLACE FUNCTION pelicula_logger()
RETURNS TRIGGER AS 
$$
declare 
	prom real;
begin
	--agrego al historico el cambio de departamento
	INSERT into pelicula_historico(id_empleado,id_distribuidor,id_departamento,fecha_inicio,fecha_fin) 
	VALUES(old.id_empleado,old.id_distribuidor,old.id_departamento,old.fecha_inicio,new.fecha_inicio); 
	--comprobar si existe el anterior	
	if exists(	SELECT 1
				FROM pelicula_historico_empleado AS phe
				WHERE 	phe.id_empleado=old.id_empleado and
						phe.id_departamento=old.id_departamento AND 
						phe.id_distribuidor=old.id_distribuidor) then
		--como ya existe, tengo que recalcular el promedio
		SELECT avg(dif) into prom 
		from
		(	SELECT (extract( epoch FROM fecha_fin-fecha_inicio)/3600.0) AS "dif"
			FROM pelicula_historico ph2
			WHERE (ph2.id_empleado=old.id_empleado AND ph2.id_distribuidor=old.id_distribuidor AND ph2.id_departamento=old.id_departamento)) t1;
		
		UPDATE pelicula_historico_empleado SET promedio=prom 
		WHERE id_empleado=old.id_empleado AND id_distribuidor=old.id_distribuidor AND id_departamento=old.id_departamento;
	else
		INSERT into pelicula_historico_empleado(id_empleado,id_distribuidor,id_departamento,promedio) 
		VALUES (old.id_empleado,old.id_distribuidor,old.id_departamento,extract(epoch FROM new.fecha_inicio-old.fecha_inicio)/3600.0);
	end if;
	return new;
	
end
$$
LANGUAGE 'plpgsql';

--CONSULTAR
--posibles problemas de trigger
--hay que evitar que se puedan modificar la fecha de inicio
--tambien hay que evitar que se modifquen los datos del historico 
--y los datos que hay en historico empleado
--tambien consultar porque cuando modifico el valor del new fecha_inicio mo se 
--ve afectado en la tupla agregada despues de la ejecucion del trigger
--
--posibles mejoras calcular el promedio de manera incremental
--esto se lograria teniendo en la tabla de historico de empleado 
--la cuenta de cuantas veces cambio de departament y las horas
--en ese departamento. Ademas de que esto podria facilitar 
--si se quisiera la eliminacion de la tabla de historico

--agregar TRIGGER BEFORE modificando la fecha:_inicioo
--y utilizarla en el TRIGGER after

CREATE OR REPLACE FUNCTION pelicula_logger_BEFORE()
RETURNS TRIGGER AS
$$
begin
	new.fecha_inicio:=current_timestamp;
	return new;
end
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER pelicula_logger_BEFORE
BEFORE UPDATE of id_departamento,id_distribuidor ON pelicula_empleado
FOR EACH ROW
EXECUTE PROCEDURE pelicula_logger_BEFORE();


--stored procedure que agrega los datos preexistentes, si los hubiera,
--en la tabla pelicula_historico_empleado
CREATE OR REPLACE PROCEDURE update_historico_empleado()
LANGUAGE 'plpgsql'
AS $$
declare
	var record;--un registro, esto esta op toma los valores segun lo que le mandes
	fechahoy timestamp;
begin
	fechahoy:=current_timestamp;
	for var in (
		SELECT id_empleado,id_departamento,id_distribuidor,avg((extract( epoch FROM fecha_fin-fecha_inicio)/3600.0)) AS "horas"
		FROM pelicula_historico AS ph
		GROUP BY id_empleado,id_departamento,id_distribuidor)
	loop
		INSERT into pelicula_historico_empleado(id_empleado,id_distribuidor,id_departamento,promedio) 
		VALUES (var.id_empleado,var.id_distribuidor,var.id_departamento,var.horas);
	end loop;
	for var in (
		SELECT id_empleado,min(fecha_inicio) AS "fecha_entrada"
		FROM pelicula_historico AS ph
		GROUP BY id_empleado
	)
	loop
		UPDATE pelicula_empleado emp SET horas_totales=(extract( epoch FROM fechahoy-var.fecha_entrada)/3600.0)
		WHERE emp.id_empleado=var.id_empleado;
	end loop;
end;
$$;

CREATE OR REPLACE PROCEDURE update_horas_empleado()
LANGUAGE 'plpgsql'
AS
$$
declare
	var record;
	fechahoy timestamp;
begin
	fechahoy:=current_timestamp;
	for var in (
		SELECT id_empleado,min(fecha_inicio) AS "fecha_entrada"
		FROM pelicula_historico AS ph
		GROUP BY id_empleado
	)
	loop
		UPDATE pelicula_empleado emp SET horas_totales=(extract( epoch FROM fechahoy-var.fecha_entrada)/3600.0)
		WHERE emp.id_empleado=var.id_empleado;
	end loop;
end;
$$;


SELECT id_empleado,id_departamento,id_distribuidor,avg((extract( epoch FROM fecha_fin-fecha_inicio)/3600.0))
FROM pelicula_historico AS ph
GROUP BY id_empleado,id_departamento,id_distribuidor

CREATE TRIGGER trigger_pelicula_logger
AFTER UPDATE of id_departamento,id_distribuidor ON pelicula_empleado
FOR EACH ROW
EXECUTE PROCEDURE pelicula_logger();

DROP TRIGGER trigger_pelicula_logger ON pelicula_empleado;

DROP function pelicula_logger();

--modifico el valor de 	(7104,Juan C.,De,NULL,3489.00,De@gmail.com,1983-06-08,738-5664,5157,58,242,8357,2019-10-09 13:25:50,0)
--por 					(7104,Juan C.,De,NULL,3489.00,De@gmail.com,1983-06-08,738-5664,5157,75,219,8357,2019-10-09 13:25:50,0)
--INSERT INTO pelicula_empleado (id_empleado,nombre,apellido,porc_comision,sueldo,e_mail,fecha_nacimiento,telefono,id_tarea,id_departamento,id_distribuidor,id_jefe,fecha_inicio,horas_totales) VALUES 
--(7104,'Juan C.','De ',NULL,3489.00,'De@gmail.com','1983-06-08','738-5664','5157',58,242,8357,'2019-10-09 13:25:50.936',0)
--;
UPDATE pelicula_empleado SET id_departamento=75,id_distribuidor=219 WHERE id_empleado=7104;

UPDATE pelicula_empleado SET id_departamento=95,id_distribuidor=977 WHERE id_empleado=7104;

SELECT *
FROM pelicula_departamento AS pd

SELECT id_departamento,id_distribuidor,fecha_inicio,horas_totales
FROM pelicula_empleado AS pe
WHERE id_empleado=7104;

SELECT *
FROM pelicula_historico AS ph;

SELECT *
FROM pelicula_historico_empleado AS phe;

DELETE FROM pelicula_historico;

DELETE FROM pelicula_historico_empleado;

CALL update_historico_empleado();--llamo al stored procedure para "añadir los datos preexistentes"

CALL update_horas_empleado();


--EJERCICIO 5
--########################################################################

CREATE OR REPLACE FUNCTION set_horas_aportadas()
RETURNS TRIGGER AS
$$
begin
	new.horas_aportadas:=0;
	return new;
end
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER set_horas_cero
BEFORE UPDATE of id_tarea ON voluntario_voluntario
FOR EACH ROW
EXECUTE PROCEDURE set_horas_aportadas();

CREATE OR REPLACE FUNCTION check_horas_aportadas()
RETURNS TRIGGER AS
$$
begin
	if(new.horas_aportadas NOT between old.horas_aportadas*0.9 AND old.horas_aportadas*1.1) then
		raise exception 'Las horas aportadas no son validas';
	end if;
	return new;
end;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER check_horas_aportadas
BEFORE UPDATE of horas_aportadas ON voluntario_voluntario
FOR EACH ROW
EXECUTE PROCEDURE check_horas_aportadas();

--Modifico la CONSTRAINT de horas aportadas >0 ya que sino no me deja probarlo
ALTER TABLE unc_248557.voluntario_voluntario DROP CONSTRAINT voluntario_chk_hs_ap;

ALTER TABLE unc_248557.voluntario_voluntario ADD CONSTRAINT voluntario_chk_hs_ap CHECK ((horas_aportadas >= (0)::numeric))

SELECT *
FROM voluntario_voluntario

--134 tiene 2900
UPDATE voluntario_voluntario SET horas_aportadas=3100 WHERE nro_voluntario=134;


--EJERCICIO 6
--########################################################################


CREATE table tp3p1_ej3_textosporautor (
	autor varchar(60) NOT NULL,
	cant_textos numeric(4,0) NOT NULL,
	fecha_ultima_public date NOT NULL,
	CONSTRAINT pk_tp3p1_ej3_textosporautor PRIMARY KEY(autor)
);

CREATE OR REPLACE PROCEDURE update_textosporautor()
LANGUAGE 'plpgsql'
AS
$$
declare
--	 var record;
begin
--	for var in (
--		SELECT autor,count(*) AS "cant_textos",max(fecha_pub) AS "ultima"
--		FROM tp3p1_ej3_articulo
--		GROUP BY autor
--		having autor is NOT NULL)
--	loop
--		INSERT into tp3p1_ej3_textosporautor(autor,cant_textos,fecha_ultima_public) VALUES (var.autor,var.cant_textos,var.ultima);
--		raise NOTice 'xD';
--	end loop;

	INSERT into tp3p1_ej3_textosporautor(autor,cant_textos,fecha_ultima_public)
	SELECT autor,count(*) AS "cant_textos",max(fecha_pub) AS "fecha_ultima_public"
	FROM tp3p1_ej3_articulo
	GROUP BY autor
	having autor is NOT NULL;
end;
$$;

SELECT autor,count(*),max(fecha_pub)
FROM tp3p1_ej3_articulo
GROUP BY autor
HAVING autor IS NOT NULL

SELECT *
FROM tp3p1_ej3_articulo
--WHERE id_articulo=9;

UPDATE tp3p1_ej3_articulo SET autor='Horacio Raul Casado', fecha_pub=to_date('2019-10-20','YYYY-MM-DD'),titulo='Ser otako en 10 pasos' WHERE id_articulo=2;

UPDATE tp3p1_ej3_articulo SET autor='Dana Mariel Alvarez y Martinez',fecha_pub=current_date,titulo='niidea' WHERE id_articulo=9;
UPDATE tp3p1_ej3_articulo SET autor='Juan Eliel Vivian',fecha_pub=to_date('2019-10-25','YYYY-MM-DD'),titulo='Como hacer 50 cosas en un dia' WHERE id_articulo=8;
UPDATE tp3p1_ej3_articulo SET autor='Thomas Agustin Ojeda',fecha_pub=to_date('2018-3-20','YYYY-MM-DD'),titulo='Como debugear mentalmente' WHERE id_articulo=7;
UPDATE tp3p1_ej3_articulo SET autor='Matias Morandeira',fecha_pub=to_date('2014-4-20','YYYY-MM-DD'),titulo='Aprender a que te caguen con las NOTas' WHERE id_articulo=6;
UPDATE tp3p1_ej3_articulo SET autor='Juan Pablo Correa',fecha_pub=to_date('2019-1-3','YYYY-MM-DD'),titulo='Como jugar al voley' WHERE id_articulo=5;
UPDATE tp3p1_ej3_articulo SET autor='Marcos Alejandro Lazarte',fecha_pub=to_date('2010-11-23','YYYY-MM-DD'),titulo='Aprendiendo a hablar' WHERE id_articulo=4;
UPDATE tp3p1_ej3_articulo SET autor='Exequiel Herrera de Rosa',fecha_pub=to_date('2019-05-22','YYYY-MM-DD'),titulo='Como tener todos los practicos al dia' WHERE id_articulo=3;
UPDATE tp3p1_ej3_articulo SET autor='Santiago Coria',fecha_pub=to_date('2017-7-13','YYYY-MM-DD'),titulo='El rey topo' WHERE id_articulo=1;


CALL update_textosporautor();

SELECT *
FROM tp3p1_ej3_textosporautor

DELETE FROM tp3p1_ej3_textosporautor;



CREATE OR REPLACE PROCEDURE update_single_row_textosporautor_INSERT(_autor varchar(60),_fecha date)
LANGUAGE 'plpgsql'
AS
$$
declare 
	_fecha_max date;
begin
	if exists(SELECT 1
				FROM tp3p1_ej3_textosporautor AS t
				WHERE t.autor=_autor) then
		SELECT fecha_ultima_public into _fecha_max
		FROM tp3p1_ej3_textosporautor t
		WHERE t.autor=_autor;
		if(_fecha_max<_fecha) then
			UPDATE tp3p1_ej3_textosporautor t SET cant_textos=cant_textos+1,fecha_ultima_public=_fecha WHERE t.autor=_autor;
		else
			UPDATE tp3p1_ej3_textosporautor t SET cant_textos=cant_textos+1 WHERE t.autor=_autor;
		end if;
	else
		INSERT into tp3p1_ej3_textosporautor(autor,cant_textos,fecha_ultima_public) VALUES (_autor,1,_fecha);
	end if;
end;
$$;

CREATE OR REPLACE FUNCTION update_textosporautor_INSERT()
RETURNS TRIGGER AS
$$
declare
begin
	call update_single_row_textosporautor_INSERT(new.autor,new.fecha_pub);
	return new;
end;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_textosporautor_INSERT
AFTER INSERT ON tp3p1_ej3_articulo
FOR EACH ROW
EXECUTE PROCEDURE update_textosporautor_INSERT();

INSERT INTO tp3p1_ej3_articulo(id_articulo,titulo,autor,nacionalidad,fecha_pub) VALUES(10,'Como ser forro','Horacio Raul Casado','Argentina',to_date('2019-12-25','YYYY-MM-DD'));

DELETE FROM tp3p1_ej3_articulo WHERE id_articulo = 10;

CREATE OR REPLACE PROCEDURE update_single_row_textosporautor_delete(_autor varchar(60),_fecha date)
LANGUAGE 'plpgsql'
AS
$$
declare
	_var record;
	_aux date;
begin
	raise NOTice 'despues de %',_autor;
	SELECT t.* into _var
	FROM tp3p1_ej3_textosporautor AS t
	WHERE t.autor=_autor;
	if(_var.cant_textos=1) then
		delete FROM tp3p1_ej3_textosporautor WHERE autor=_autor;
	else
		
		SELECT max(fecha_pub) into _aux
		FROM tp3p1_ej3_articulo a
		WHERE a.autor=_autor
		GROUP BY a.autor;
		if(_var.fecha_ultima_public=_fecha) then
			UPDATE tp3p1_ej3_textosporautor SET cant_textos=cant_textos-1,fecha_ultima_public=_aux WHERE autor=_autor;
		else
			UPDATE tp3p1_ej3_textosporautor SET cant_textos=cant_textos-1 WHERE autor=_autor;
		end if;
	end if;
end;
$$;


CREATE OR REPLACE FUNCTION update_textosporautor_update()
RETURNS TRIGGER AS
$$
declare 
	_var record;
	_aux date;
begin
	if(old.autor!=new.autor) then
		call update_single_row_textosporautor_INSERT(new.autor,new.fecha_pub);
		call update_single_row_textosporautor_delete(old.autor,old.fecha_pub);
	else
		IF(OLD.fecha_pub!=NEW.fecha_pub) then
			SELECT t.* into _var
			FROM tp3p1_ej3_textosporautor
			WHERE t.autor=old.autor;
			IF(NEW.fecha_pub>_var.fecha_ultima_public) THEN
				UPDATE tp3p1_ej3_textosporautor SET fecha_ultima_public=NEW.fecha_pub WHERE autor=old.autor;
			END IF;
		END IF;
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_textosporautor_update
AFTER UPDATE of autor,fecha_pub ON tp3p1_ej3_articulo
FOR EACH ROW
EXECUTE PROCEDURE update_textosporautor_update();

UPDATE tp3p1_ej3_articulo SET autor='Dana Mariel Alvarez y Martinez' WHERE id_articulo=9;

CREATE OR REPLACE FUNCTION update_textosporautor_delete()
RETURNS TRIGGER AS
$$
BEGIN
	CALL update_single_row_textosporautor_delete(old.autor,old.fecha_pub);
	RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_textosporautor_delete
AFTER delete ON tp3p1_ej3_articulo
FOR EACH ROW
EXECUTE PROCEDURE update_textosporautor_delete();

delete FROM tp3p1_ej3_articulo WHERE id_articulo=9;


SELECT *
FROM tp3p1_ej3_articulo

SELECT *
FROM tp3p1_ej3_textosporautor








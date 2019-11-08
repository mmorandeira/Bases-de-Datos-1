

--SERVICIO B1.2
--########################################################################


--Un movimiento de salida debe referenciar, en orden cronologico, al ultimo 
--movimiento interno, si los tuviera, o al movimiento de entrada (respecto del mismo pallet).

ALTER TABLE G06_MOVIMIENTO ADD CONSTRAINT CK_G06_MOV_ANTERIOR_NO_CONSISTENTE
CHECK (
		--no queresmos que exista un movimiento de salida
		NOT EXISTS (SELECT 1 
					FROM G06_MOVIMsIENTO m
					WHERE tipo = 'S'
					--cuyo movimiento anterior no sea el movimiento 
					--(entrada o interno) más reciente del mismo pallet
				    --se los ordena decendientemente para que quede el 
				    --mas reciente primero
					AND (id_mov_ant <> (SELECT id_movimiento
									    FROM G06_MOVIMIENTO
									    WHERE tipo <> 'S' AND cod_pallet = m.cod_pallet 
									    ORDER BY fecha DESC 
									    LIMIT 1)
					--cuyo fecha no sea mayor a su movimiento anterior
							OR fecha <= (SELECT fecha 
									  	 FROM G06_MOVIMIENTO
				 					  	 WHERE id_movimiento = m.id_mov_ant)))
		AND 
		--ademas se comprueba que no haya mas de un movimiento de salida por pallet
		NOT EXISTS (SELECT 1 
					FROM G06_MOVIMIENTO
					WHERE tipo = 'S'
					GROUP BY cod_pallet
					HAVING count(*) > 1))
;


/*
+==============================+=========================================+=========================================+=========================================+
|            Tablas            |                 Insert                  |                 Update                  |                 Delete                  |
+==============================+=========================================+=========================================+=========================================+
| movimiento                   |                                         |   fecha / cod_pallet / id_mov_ant       |                xxxx                     |
+------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
*/


CREATE OR REPLACE FUNCTION TRFN_G06_MOV_ANTERIOR_NO_CONSISTENTE() RETURNS TRIGGER AS
$BODY$
DECLARE 
	_ultimo_mov record;
BEGIN
	--primero se verifica si el pallet ya tiene un movimiento de salida
	--esto se controla solo cuando se hace un insert o no se cambia de pallet
	
	IF(TG_OP='INSERT' OR NEW.cod_pallet<>OLD.cod_pallet) THEN 
		IF(EXISTS (
				SELECT 0
				FROM G06_MOVIMIENTO
				WHERE cod_pallet=NEW.cod_pallet AND tipo='S'
			)
		) THEN
			RAISE EXCEPTION 'Ya existe un movimiento de salida para este pallet';
		END IF;
	END IF;
	
	--ahora obtenemos el ultimo movimiento del pallet
	
	SELECT * INTO _ultimo_mov
	FROM G06_MOVIMIENTO
	WHERE cod_pallet=NEW.cod_pallet
	ORDER BY fecha DESC
	LIMIT 1;
	
	--comparamos si el ultimo movimiento coincide con el que se ingreso
	
	IF(_ultimo_mov.id_movimiento<>NEW.id_mov_ant) THEN
		RAISE EXCEPTION 'El movimiento anterior no es el mas reciente del pallet';
	END IF;
	
	--finalmente se comprueba que el ultimo de todos los movimiento (cronologicamente)
	--sea el de salida
	
	IF (_ultimo_mov.fecha>=NEW.fecha) THEN
		RAISE EXCEPTION 'El ultimo movimiento (cronologicamente) debe ser de salida';
	END IF;
	RETURN NEW;
END 
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_G06_INSERT_MOV_ANTERIOR_NO_CONSISTENTE
BEFORE INSERT ON G06_MOVIMIENTO
FOR EACH ROW
WHEN (NEW.tipo='S')
EXECUTE PROCEDURE TRFN_G06_MOV_ANTERIOR_NO_CONSISTENTE();

CREATE TRIGGER TR_G06_UPDATE_MOV_ANTERIOR_NO_CONSISTENTE
BEFORE UPDATE OF id_mov_ant,fecha,cod_pallet ON G06_MOVIMIENTO
FOR EACH ROW
WHEN (OLD.tipo='S')
EXECUTE PROCEDURE TRFN_G06_MOV_ANTERIOR_NO_CONSISTENTE();

--sentencias que promueven la activacion de la restriccion
--INSERCION DE VALORES CONSISTENTES PARA REALIZAR PRUEBAS

INSERT INTO G06_MOVIMIENTO (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES
	--movimientos de un mismo pallet sin salida
	(1, to_timestamp('01/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'E', NULL, 3, 'DNI', 3206411, '00739448'),
	(2, to_timestamp('02/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'I', 1, 6, 'DNI', 3206411,'00739448'),
	(3, to_timestamp('03/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'I', 2, 8, 'DNI', 3206411,'00739448'),
	(4, to_timestamp('04/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'I', 3, 23, 'DNI', 3206411,'00739448'),
	--movimiento de un mismo pallet con salida
	(6, to_timestamp('06/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'E', NULL, 26,'DNI',3206411, '02596499'),
	(7, to_timestamp('07/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'I', 6, 35, 'DNI',3206411, '02596499'),
	(8, to_timestamp('08/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'I', 7, 44, 'DNI',3206411, '02596499'),
	(9, to_timestamp('09/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 8, 47, 'DNI',3206411, '02596499')
;

--eliminacion de valores cargados
DELETE FROM G06_MOVIMIENTO WHERE id_movimiento BETWEEN 1 AND 9;

--INSERTS Y UPDATES DE VALORES PARA REALIZAR PRUEBAS

--un nuevo movimiento cuyo movimiento anterior no es el mas reciente
INSERT INTO G06_MOVIMIENTO (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (5, to_timestamp('05/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 3, 57, 'DNI', 3206411, '00739448');

--un nuevo movimiento de salida con fecha menor al movimiento anterior
INSERT INTO G06_MOVIMIENTO (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (5, to_timestamp('03/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 4, 57, 'DNI', 3206411, '00739448');

--un nuevo movimiento de salida para un pallet que ya tiene movimiento de salida
INSERT INTO G06_MOVIMIENTO (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (10, to_timestamp('10/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 8, 57, 'DNI', 3206411, '02596499');

--un nuevo movimiento de salida con datos que no generan inconsistencia
INSERT INTO G06_MOVIMIENTO (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (5, to_timestamp('05/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 4, 57, 'DNI', 3206411, '00739448');

--borrado de tuplas que se insertaron para las pruebas
DELETE FROM G06_MOVIMIENTO WHERE id_movimiento=5;
DELETE FROM G06_MOVIMIENTO WHERE id_movimiento=10;

--updates

--se cambia el movimiento anterior a uno que no es el mas reciente
UPDATE G06_MOVIMIENTO SET id_mov_ant=7 WHERE id_movimiento=9;
--se restaura
UPDATE G06_MOVIMIENTO SET id_mov_ant=8 WHERE id_movimiento=9; 

--se cambia la fecha del movimiento de salida a una fecha previa a la del 
--movimiento anterior
UPDATE G06_MOVIMIENTO SET fecha=to_timestamp('07/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS') WHERE id_movimiento=9;
--se restaura
UPDATE G06_MOVIMIENTO SET fecha=to_timestamp('09/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS') WHERE id_movimiento=9; 

--se cambia el pallet de un movimiento de salida por lo que el movimiento 
--anterior no deberia ser el correcto
UPDATE G06_MOVIMIENTO SET cod_pallet='00739448' WHERE id_movimiento=9;
--se restaura
UPDATE G06_MOVIMIENTO SET cod_pallet='02596499' WHERE id_movimiento=9; 

--se cambia el pallet pero se agrega el movimiento anterior correspondiente (no se generan inconsistencias)
UPDATE G06_MOVIMIENTO SET cod_pallet='00739448',id_mov_ant=4 WHERE id_movimiento=9;
UPDATE G06_MOVIMIENTO SET cod_pallet='02596499',id_mov_ant=8 WHERE id_movimiento=9;


--SERVICIO B2.1
--########################################################################


--Mantener actualizado automaticamente el saldo de cada cliente

CREATE OR REPLACE FUNCTION TRFN_G06_ACTUALIZAR_SALDO() RETURNS TRIGGER AS
$BODY$
BEGIN 
	IF (TG_OP='INSERT') THEN
		UPDATE g06_cliente SET saldo=saldo+NEW.importe WHERE cuit_cuil=NEW.cuit_cuil;
	END IF;
	IF (TG_OP='UPDATE') THEN
		UPDATE g06_cliente SET saldo=saldo-OLD.importe WHERE cuit_cuil=OLD.cuit_cuil;
		UPDATE g06_cliente SET saldo=saldo+NEW.importe WHERE cuit_cuil=NEW.cuit_cuil;
	END IF;
	IF (TG_OP='DELETE') THEN
		UPDATE g06_cliente SET saldo=saldo-OLD.importe WHERE cuit_cuil=OLD.cuit_cuil;
	END IF;
	RETURN NEW;
END
$BODY$

CREATE TRIGGER TR_G06_ACTUALIZAR_SALDO
AFTER INSERT OR DELETE OR UPDATE OF cuit_cuil,importe ON g06_movimiento_cc
FOR EACH ROW 
EXECUTE PROCEDURE TRFN_G06_ACTUALIZAR_SALDO();

---Operacion que dispara el trigger 

DELETE FROM g06_linea_alquiler WHERE id_liquidacion=14;

UPDATE 

SELECT * FROM g06_movimiento_cc;

SELECT * FROM g06_empleado;

INSERT INTO g06_movimiento_cc (id_mov_cc,fecha,cuit_cuil,importe,tipo_doc,nro_doc) VALUES () 


--SERVICIO C1.1
--########################################################################


--Generar una lista de las estanterias que en este momento tienen mas de cierto
--procentaje (configurable) de las posiciones ocupadas


CREATE OR REPLACE FUNCTION FN_G06_ESTANTERIAS_OCUPADAS_MAS_DE(_porcentaje real)
RETURNS TABLE(	nro_estanteria int,
				nombre_estanteria varchar(80))
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT *
	FROM g06_estanteria e
	WHERE e.nro_estanteria IN (	SELECT ext.nro_estanteria
								FROM g06_posicion ext
								WHERE ext.estado = 'OCUPADO'
								GROUP BY ext.nro_estanteria
								HAVING count(ext.id_pos)>_porcentaje*(	SELECT count(*)
																		FROM g06_posicion p
																		WHERE ext.nro_estanteria = p.nro_estanteria));
	RETURN ;
END;
$BODY$
LANGUAGE 'plpgsql';

--La estateria 27 tiene tres posicion libres, para probarlo
--modificaremos una de esta para que este 1/3 ocupada, y asi
--poder utilizar el servicio con 0.3 y que devuelva la 27
--Posiciones relacionadas con la estanteria 27
--(id_pos,nro_pos,nro_estanteria,nro_fila,estado , pos_global)
--(283   ,4      ,27            ,2       ,'LIBRE', 17)
--(23    ,3      ,27            ,2       ,'LIBRE', 96)
--(684   ,7      ,27            ,2       ,'LIBRE', 109)

UPDATE g06_posicion SET estado='OCUPADO' WHERE id_pos=23;

--Utilizamos el servicio con 0.3, deberia devolver la estanteria 27
SELECT	*
FROM FN_G06_ESTANTERIAS_OCUPADAS_MAS_DE(0.3);

--Utilizamos el servicio con 0.4, no deberia devolver nada
SELECT	*
FROM FN_G06_ESTANTERIAS_OCUPADAS_MAS_DE(0.4);

--Ocupamos otra posicion de la estateria ahora la 27 esta 2/3 ocupada
UPDATE g06_posicion SET estado='OCUPADO' WHERE id_pos=283;

--Utilizamos el servicio con 0.4, no deberia devolver nada
SELECT	*
FROM FN_G06_ESTANTERIAS_OCUPADAS_MAS_DE(0.6);

--Revertimos los datos a los originles
UPDATE g06_posicion SET estado='LIBRE' WHERE id_pos=23;
UPDATE g06_posicion SET estado='LIBRE' WHERE id_pos=283;

--SERVICIO C2.2
--########################################################################


--Devolver todos los datos de las posiciones (estanteria, fila y nro de posicion) 
--que cambiaron de zona al reconfigurar el deposito, indicando si estan ocupadas 
--o no actualmente.

CREATE VIEW G06_ULTIMOS_CAMBIOS_DE_ZONA AS
	SELECT nro_estanteria,nro_fila,nro_posicion,estado
	FROM g06_posicion
	WHERE id_pos IN (	SELECT id_pos
						FROM g06_zona_posicion p
						WHERE fecha =  (SELECT max(fecha) 
										FROM g06_zona_posicion)
							   AND NOT EXISTS ( SELECT 1
							   					FROM g06_zona_posicion 
							   					WHERE id_pos = p.id_pos
												GROUP BY id_pos
												HAVING count(*)=1))
;

--La posicion 250 no tiene una zona asignada por eso le asignamos una primera zona
--en la misma fecha que fueron asignadas el resto de posiciones en el esquema
INSERT INTO g06_zona_posicion(id_pos,fecha,id_zona) VALUES (250,to_date('01/01/2018','DD/MM/YYYY'),26)

SELECT *
FROM G06_ULTIMOS_CAMBIOS_DE_ZONA;

--Insertamos algunas tuplas en zona posicion, simulando que el deposito se ha reconfigurado
INSERT INTO g06_zona_posicion(id_pos,fecha,id_zona) VALUES (396,to_date('7/11/2019','DD/MM/YYYY'),25);
INSERT INTO g06_zona_posicion(id_pos,fecha,id_zona) VALUES (836,to_date('7/11/2019','DD/MM/YYYY'),25);
INSERT INTO g06_zona_posicion(id_pos,fecha,id_zona) VALUES (92,to_date('7/11/2019','DD/MM/YYYY'),43);
INSERT INTO g06_zona_posicion(id_pos,fecha,id_zona) VALUES (837,to_date('7/11/2019','DD/MM/YYYY'),12);
INSERT INTO g06_zona_posicion(id_pos,fecha,id_zona) VALUES (296,to_date('7/11/2019','DD/MM/YYYY'),4);
INSERT INTO g06_zona_posicion(id_pos,fecha,id_zona) VALUES (732,to_date('7/11/2019','DD/MM/YYYY'),4);

--Borrado opcional, de las tuplas añadidas anteriormente
DELETE FROM g06_zona_posicion WHERE id_pos=396 AND fecha=to_date('7/11/2019','DD/MM/YYYY');
DELETE FROM g06_zona_posicion WHERE id_pos=836 AND fecha=to_date('7/11/2019','DD/MM/YYYY');
DELETE FROM g06_zona_posicion WHERE id_pos=92 AND fecha=to_date('7/11/2019','DD/MM/YYYY');
DELETE FROM g06_zona_posicion WHERE id_pos=837 AND fecha=to_date('7/11/2019','DD/MM/YYYY');
DELETE FROM g06_zona_posicion WHERE id_pos=296 AND fecha=to_date('7/11/2019','DD/MM/YYYY');
DELETE FROM g06_zona_posicion WHERE id_pos=732 AND fecha=to_date('7/11/2019','DD/MM/YYYY');

SELECT *
FROM G06_ULTIMOS_CAMBIOS_DE_ZONA;


--SERVICIO C3
--########################################################################


--Diariamente se debe actualizar la cuenta corriente de cada cliente con los alquileres
--que tienen activos, agregando un movimiento de debito (importe negativo en la cueta
--corriente del mismo

CREATE OR REPLACE PROCEDURE  PR_G06_GENERAR_FACTURAS AS ---Suponiendo que se ejecutaria diariamente
$body$
DECLARE 
	_fecha_de_hoy date;
	_movimientos_cc_agregar int;
	_aux int;
	_current_client_id char(11);
	_maximum_id_from_mov_cc int;
    _new_id_for_mov_cc int;
   	_cursor_for_join record;
    _maximum_id_from_linea_alq int;
  	_new_id_for_linea_alq int;
  	_current_id_mov_cc int;  	
BEGIN
	_fecha_de_hoy=current_date;

	---Se crea tabla auxiliar para guardar las tuplas alquiler-posicion
	
	CREATE TEMP TABLE tabla_join ( 
		id_alquiler int,
		id_cliente char(11),
		importe_dia decimal(10,2),
		id_pos int,
		nuevo_liq_linea int
	) ON COMMIT DROP;
	
	---Se crea tabla auxiliar para almacenar el mov_cc de cada cliente
	
	CREATE TEMP TABLE tabla_id_mov_de_clientes ( 
		id_mov_cc int,
		id_cliente char(11)
	) ON COMMIT DROP;
	
	---Se inserta en la tabla auxiliar de alquiler-posicion las tuplas correspondientes a alquileres cuya
	---fecha de finalizacion esta indefinida
	
	INSERT INTO tabla_join (id_alquiler,id_cliente,importe_dia,id_pos,nuevo_liq_linea)
	(
	SELECT alq.id_alquiler,alq.id_cliente,alq.importe_dia,alp.id_pos,(SELECT COALESCE(max(id_liquidacion),-1)+1
																	  FROM g06_linea_alquiler
																	  WHERE id_alquiler=alp.id_alquiler AND id_pos=alp.id_pos)
	FROM g06_alquiler alq JOIN g06_alquiler_posicion alp ON (alq.id_alquiler=alp.id_alquiler)
	WHERE fecha_hasta IS NULL
	);
	
	---por cada uno de los distintos clientes con alquileres indefinidos, se genera una tupla de movimiento_cc.
	
	FOR _current_client_id IN (SELECT DISTINCT id_cliente FROM tabla_join) 
    LOOP
    	_maximum_id_from_mov_cc = (SELECT max(id_mov_cc) FROM g06_movimiento_cc); --sujeto a cambios
    	_new_id_for_mov_cc= _maximum_id_from_mov_cc+1;
    	INSERT INTO g06_movimiento_cc VALUES (_new_id_for_mov_cc,current_date,_current_client_id,0,null,null);
		INSERT INTO tabla_id_mov_de_clientes VALUES (_new_id_for_mov_cc,_current_client_id);
	END LOOP;
    
	---por cada uno de los distintos alquileres en las posiciones, generar una tupla en alquiler_posicion cuya 
    ---clave extrangera id_mov_cc sea la correspondiente al movimiento_cc generado para el cliente.
    
	FOR _cursor_for_join IN (SELECT * FROM tabla_join)
    LOOP
    	_current_id_mov_cc=(SELECT id_mov_cc FROM tabla_id_mov_de_clientes WHERE id_cliente=_cursor_for_join.id_cliente);
    	INSERT INTO g06_linea_alquiler (id_liquidacion,id_alquiler,id_pos,importe,id_mov_cc) VALUES 
    	(_cursor_for_join.nuevo_liq_linea,_cursor_for_join.id_alquiler,_cursor_for_join.id_pos,_cursor_for_join.importe_dia,_current_id_mov_cc);
	
    	---actualizar el importe del movimiento_cc asociado a la linea_alquiler
		
    	UPDATE g06_movimiento_cc SET importe=importe-(_cursor_for_join.importe_dia) WHERE id_mov_cc=(_current_id_mov_cc);
	END LOOP;
END;
$body$
LANGUAGE plpgsql;

CREATE SEQUENCE movimiento_cc_id_sequence INCREMENT BY -1
MINVALUE (SELECT max(id_mov_cc) FROM g06_movimiento_cc) 
START (SELECT max(id_mov_cc) FROM g06_movimiento_cc) NO CYCLE;

--ANTES DE EJECUTAR: ASEGURARSE DE QUE LOS VALORES QUE SE SUPONE QUE INTRODUZCA
--NO ESTEN YA INTRODUCIDOS!!!

CALL PR_G06_GENERAR_FACTURAS; 

--A continuacion instrucciones para testear:

SELECT * FROM g06_alquiler_posicion;

SELECT * FROM g06_alquiler;

SELECT * FROM g06_cliente;

SELECT * FROM g06_posicion ORDER BY id_pos;

SELECT * FROM g06_movimiento_cc ;

DELETE FROM g06_linea_alquiler WHERE id_alquiler=6664;

SELECT * FROM unc_248557.g06_linea_alquiler WHERE id_alquiler=6661;

SELECT * FROM unc_248557.g06_linea_alquiler;

INSERT INTO g06_cliente (cuit_cuil,apellido,nombre,fecha_alta,saldo,cant_pos_alq) 
VALUES 
('666-66-0000','Apellido De Prueba 000','Nombre De Prueba 000',current_date,6666666,0),
('666-66-0001','Apellido De Prueba 001','Nombre De Prueba 001',current_date,6666666,0),
('666-66-0002','Apellido De Prueba 002','Nombre De Prueba 002',current_date,6666666,0),
('666-66-0003','Apellido De Prueba 003','Nombre De Prueba 003',current_date,6666666,0),
('666-66-0004','Apellido De Prueba 004','Nombre De Prueba 004',current_date,6666666,0),
('666-66-0005','Apellido De Prueba 005','Nombre De Prueba 005',current_date,6666666,0);

INSERT INTO g06_alquiler (id_alquiler,id_cliente,tipo_alquiler,fecha_desde,fecha_hasta,importe_dia) 
VALUES 
(6661,'666-66-0000','indefinido','2000-01-01',NULL,60),
(6662,'666-66-0000','indefinido','2000-01-01',NULL,60),
(6664,'666-66-0001','indefinido','2000-01-01',NULL,60);

INSERT INTO g06_alquiler_posicion (id_alquiler,id_pos)
VALUES 
(6661,3),
(6661,6),
(6661,8),
(6662,23),
(6664,35); 
--se mantienen en la base
--para testear funcionamiento rapido

INSERT INTO g06_alquiler_posicion (id_alquiler,id_pos) VALUES (6661,8);

SELECT * FROM g06_movimiento_cc;

INSERT INTO g06_alquiler_posicion VALUES ()

DELETE FROM g06_movimiento_cc WHERE id_mov_cc=232;

DELETE FROM g06_linea_alquiler WHERE id_liquidacion=14;

DELETE FROM g06_alquiler WHERE tipo_alquiler='indefinido';

DELETE FROM g06_cliente WHERE saldo=6666666;

SELECT * FROM g06_linea_alquiler;



--VISTA D1.1
--########################################################################


--Listar los datos de todos los clientes junto con el ultimo movimiento de pago de mayor
--importe que cada uno de estos realizo en los ultimos 12 meses, en el caso que corresponda

--Consideramos que con el ultimo movimiento se refiere a todos los datos
CREATE VIEW G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES AS
	SELECT c.*,mcc.id_mov_cc,mcc.fecha,mcc.importe,mcc.tipo_doc,mcc.nro_doc
	FROM g06_movimiento_cc mcc
	RIGHT JOIN g06_cliente c ON (mcc.cuit_cuil=c.cuit_cuil)
	WHERE mcc.fecha>=current_date-INTERVAL '1 year'
	
	GROUP BY c.cuit_cuil,c.apellido,c.nombre,c.fecha_alta,c.saldo,c.cant_pos_alq,
			 mcc.id_mov_cc,mcc.fecha,mcc.cuit_cuil,mcc.importe,mcc.tipo_doc,mcc.nro_doc
 	--lo de abajo seria lo mismo que lo de arriba debido a las dependencias funcionales de 
 	--las primary key
	--GROUP BY c.cuit_cuil,mcc.id_mov_cc
	HAVING mcc.importe=max(importe)
;

SELECT * FROM G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES;

CREATE OR REPLACE FUNCTION TRFN_G06_INSERT_CLIENTES_ULTIMOS_PAGOS_RELEVANTES()
RETURNS TRIGGER AS
$BODY$
BEGIN
	
	RETURN new;
END;
$BODY$
LANGUAGE 'plpgsql';


--VISTA D2.1
--########################################################################


--Listar todos los datos de las posiciones de la fila numero 5 en adelante que
--nunca han sido alquiladas
CREATE VIEW G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE AS
	SELECT p.*
	FROM g06_posicion p
	WHERE p.nro_fila >=5 AND NOT EXISTS (	SELECT 1
											FROM g06_alquiler_posicion ap
											WHERE ap.id_pos=p.id_pos)
	--WITH CHECK OPTION
;

DROP VIEW G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

SELECT * FROM G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

INSERT INTO G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE(id_pos,nro_posicion,nro_estanteria,nro_fila,pos_global,estado)
VALUES (-1,1,142,9,-1,'LIBRE');

--Este insert es para la vista con check option
--INSERT INTO G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE(id_pos,nro_posicion,nro_estanteria,nro_fila,pos_global,estado)
--VALUES (-1,1,142,4,-1,'LIBRE');

UPDATE G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE SET estado='OCUPADO' WHERE id_pos=-1;

SELECT * FROM G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

UPDATE G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE SET nro_fila=4 WHERE id_pos=-1;

SELECT * FROM G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

DELETE FROM g06_posicion WHERE id_pos=-1;

















GRANT ALL PRIVILEGES ON G06_CLIENTE TO unc_248570;
GRANT ALL PRIVILEGES ON G06_MOVIMIENTO_CC TO unc_248570;
GRANT ALL PRIVILEGES ON G06_EMPLEADO TO unc_248570;
GRANT ALL PRIVILEGES ON G06_PALLET TO unc_248570;
GRANT ALL PRIVILEGES ON G06_ALQUILER TO unc_248570;
GRANT ALL PRIVILEGES ON G06_ALQUILER_POSICION TO unc_248570;
GRANT ALL PRIVILEGES ON G06_LINEA_ALQUILER TO unc_248570;
GRANT ALL PRIVILEGES ON G06_MOV_ENTRADA TO unc_248570;
GRANT ALL PRIVILEGES ON G06_FILA TO unc_248570;
GRANT ALL PRIVILEGES ON G06_POSICION TO unc_248570;
GRANT ALL PRIVILEGES ON G06_MOVIMIENTO TO unc_248570;
GRANT ALL PRIVILEGES ON G06_MOV_SALIDA TO unc_248570;
GRANT ALL PRIVILEGES ON G06_ESTANTERIA TO unc_248570;
GRANT ALL PRIVILEGES ON G06_ZONA_POSICION TO unc_248570;
GRANT ALL PRIVILEGES ON G06_ZONA TO unc_248570;
GRANT ALL PRIVILEGES ON G06_MOV_INTERNO TO unc_248570;




GRANT ALL PRIVILEGES ON G06_CLIENTE TO unc_249039;
GRANT ALL PRIVILEGES ON G06_MOVIMIENTO_CC TO unc_249039;
GRANT ALL PRIVILEGES ON G06_EMPLEADO TO unc_249039;
GRANT ALL PRIVILEGES ON G06_PALLET TO unc_249039;
GRANT ALL PRIVILEGES ON G06_ALQUILER TO unc_249039;
GRANT ALL PRIVILEGES ON G06_ALQUILER_POSICION TO unc_249039;
GRANT ALL PRIVILEGES ON G06_LINEA_ALQUILER TO unc_249039;
GRANT ALL PRIVILEGES ON G06_MOV_ENTRADA TO unc_249039;
GRANT ALL PRIVILEGES ON G06_FILA TO unc_249039;
GRANT ALL PRIVILEGES ON G06_POSICION TO unc_249039;
GRANT ALL PRIVILEGES ON G06_MOVIMIENTO TO unc_249039;
GRANT ALL PRIVILEGES ON G06_MOV_SALIDA TO unc_249039;
GRANT ALL PRIVILEGES ON G06_ESTANTERIA TO unc_249039;
GRANT ALL PRIVILEGES ON G06_ZONA_POSICION TO unc_249039;
GRANT ALL PRIVILEGES ON G06_ZONA TO unc_249039;
GRANT ALL PRIVILEGES ON G06_MOV_INTERNO TO unc_249039;






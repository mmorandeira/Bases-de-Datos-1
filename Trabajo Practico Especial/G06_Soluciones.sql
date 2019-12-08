
--SERVICIO B1.2
--########################################################################


--Un movimiento de salida debe referenciar, en orden cronologico, al ultimo 
--movimiento interno, si los tuviera, o al movimiento de entrada (respecto del mismo pallet).

		--no queremos que exista un movimiento de salida
		--cuyo movimiento anterior no sea el movimiento 
		--(entrada o interno) mas reciente del mismo pallet
	    --se los ordena decendientemente para que quede el 
	    --mas reciente primero
ALTER TABLE g06_movimiento ADD CONSTRAINT CK_G06_MOV_ANTERIOR_NO_CONSISTENTE
CHECK (
		NOT EXISTS (SELECT 1 
					FROM g06_movimiento m
					WHERE tipo = 'S'	
					AND (id_mov_ant <> (SELECT id_movimiento
									    FROM g06_movimiento
									    WHERE tipo <> 'S' AND cod_pallet = m.cod_pallet 
									    ORDER BY fecha DESC 
									    LIMIT 1)
					--cuyo fecha no sea mayor a su movimiento anterior
							OR fecha <= (SELECT fecha 
									  	 FROM g06_movimiento
				 					  	 WHERE id_movimiento = m.id_mov_ant)))
		AND 
		--ademas se comprueba que no haya mas de un movimiento de salida por pallet
		NOT EXISTS (SELECT 1 
						FROM g06_movimiento
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


CREATE OR REPLACE FUNCTION TRFN_G06_MOV_ANTERIOR_NO_CONSISTENTE()
RETURNS TRIGGER AS
$BODY$
DECLARE 
	_ultimo_mov record;
BEGIN
	--primero se verifica si el pallet ya tiene un movimiento de salida
	--esto se controla solo cuando se hace un insert o no se cambia de pallet
	
	IF(TG_OP = 'INSERT' OR NEW.cod_pallet <> OLD.cod_pallet) THEN 
		IF(EXISTS (
				SELECT 0
				FROM g06_movimiento
				WHERE cod_pallet = NEW.cod_pallet AND tipo = 'S'
			)
		) THEN
			RAISE EXCEPTION 'Ya existe un movimiento de salida para este pallet';
		END IF;
	END IF;
	
	--ahora obtenemos el ultimo movimiento del pallet
	
	SELECT * INTO _ultimo_mov
	FROM g06_movimiento
	WHERE cod_pallet = NEW.cod_pallet
	ORDER BY fecha DESC
	LIMIT 1;
	
	--comparamos si el ultimo movimiento coincide con el que se ingreso
	
	IF(_ultimo_mov.id_movimiento <> NEW.id_mov_ant) THEN
		RAISE EXCEPTION 'El movimiento anterior no es el mas reciente del pallet';
	END IF;
	
	--finalmente se comprueba que el ultimo de todos los movimiento (cronologicamente)
	--sea el de salida
	
	IF (_ultimo_mov.fecha >= NEW.fecha) THEN
		RAISE EXCEPTION 'El ultimo movimiento (cronologicamente) debe ser de salida';
	END IF;
	RETURN NEW;
END 
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_G06_MOV_ANTERIOR_NO_CONSISTENTE_INSERT
BEFORE INSERT ON g06_movimiento
FOR EACH ROW
WHEN (NEW.tipo ='S')
EXECUTE PROCEDURE TRFN_G06_MOV_ANTERIOR_NO_CONSISTENTE();

CREATE TRIGGER TR_G06_MOV_ANTERIOR_NO_CONSISTENTE_UPDATE
BEFORE UPDATE OF id_mov_ant,fecha,cod_pallet ON g06_movimiento
FOR EACH ROW
WHEN (OLD.tipo ='S')
EXECUTE PROCEDURE TRFN_G06_MOV_ANTERIOR_NO_CONSISTENTE();

--sentencias que promueven la activacion de la restriccion
--INSERCION DE VALORES CONSISTENTES PARA REALIZAR PRUEBAS
/*
INSERT INTO g06_movimiento (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
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
DELETE FROM g06_movimiento WHERE id_movimiento BETWEEN 1 AND 9;

--INSERTS Y UPDATES DE VALORES PARA REALIZAR PRUEBAS

--un nuevo movimiento cuyo movimiento anterior no es el mas reciente
INSERT INTO g06_movimiento (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (5, to_timestamp('05/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 3, 57, 'DNI', 3206411, '00739448');

--un nuevo movimiento de salida con fecha menor al movimiento anterior
INSERT INTO g06_movimiento (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (5, to_timestamp('03/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 4, 57, 'DNI', 3206411, '00739448');

--un nuevo movimiento de salida para un pallet que ya tiene movimiento de salida
INSERT INTO g06_movimiento (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (10, to_timestamp('10/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 8, 57, 'DNI', 3206411, '02596499');

--un nuevo movimiento de salida con datos que no generan inconsistencia
INSERT INTO g06_movimiento (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
VALUES (5, to_timestamp('05/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS'), 'S', 4, 57, 'DNI', 3206411, '00739448');

--borrado de tuplas que se insertaron para las pruebas
DELETE FROM g06_movimiento WHERE id_movimiento=5;
DELETE FROM g06_movimiento WHERE id_movimiento=10;

--updates

--se cambia el movimiento anterior a uno que no es el mas reciente
UPDATE g06_movimiento SET id_mov_ant=7 WHERE id_movimiento=9;
--se restaura
UPDATE g06_movimiento SET id_mov_ant=8 WHERE id_movimiento=9; 

--se cambia la fecha del movimiento de salida a una fecha previa a la del 
--movimiento anterior
UPDATE g06_movimiento SET fecha=to_timestamp('07/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS') WHERE id_movimiento=9;
--se restaura
UPDATE g06_movimiento SET fecha=to_timestamp('09/11/2019/00/00/00','DD/MM/YYYY/HH24/MI/SS') WHERE id_movimiento=9; 

--se cambia el pallet de un movimiento de salida por lo que el movimiento 
--anterior no deberia ser el correcto
UPDATE g06_movimiento SET cod_pallet='00739448' WHERE id_movimiento=9;
--se restaura
UPDATE g06_movimiento SET cod_pallet='02596499' WHERE id_movimiento=9; 

--se cambia el pallet pero se agrega el movimiento anterior correspondiente (no se generan inconsistencias)
UPDATE g06_movimiento SET cod_pallet='00739448',id_mov_ant=4 WHERE id_movimiento=9;
UPDATE g06_movimiento SET cod_pallet='02596499',id_mov_ant=8 WHERE id_movimiento=9;
*/

--SERVICIO B2.1
--########################################################################

DELETE FROM g06_linea_alquiler WHERE id_liquidacion = 14;

CREATE OR REPLACE FUNCTION TRFN_G06_ACTUALIZAR_SALDO() 
RETURNS TRIGGER AS
$BODY$
BEGIN 
	IF (TG_OP='INSERT') THEN
		UPDATE g06_cliente SET saldo = saldo + NEW.importe WHERE cuit_cuil = NEW.cuit_cuil;
	END IF;
	IF (TG_OP='UPDATE') THEN
		UPDATE g06_cliente SET saldo = saldo - OLD.importe WHERE cuit_cuil = OLD.cuit_cuil;
		UPDATE g06_cliente SET saldo = saldo + NEW.importe WHERE cuit_cuil = NEW.cuit_cuil;
	END IF;
	IF (TG_OP='DELETE') THEN
		UPDATE g06_cliente SET saldo = saldo - OLD.importe WHERE cuit_cuil = OLD.cuit_cuil;
	END IF;
	RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'

CREATE TRIGGER TR_G06_ACTUALIZAR_SALDO
AFTER INSERT OR DELETE OR UPDATE OF cuit_cuil, importe ON g06_movimiento_cc
FOR EACH ROW 
EXECUTE PROCEDURE TRFN_G06_ACTUALIZAR_SALDO();

--Operacion que dispara el trigger

--Vamos a comprobar que el saldo de un cliente esta siendo actualizado con una 
--insercion de un movimiento_cc correspondiente a un credito. Para ello consideremos un nuevo cliente
--con cuit_cuil=666-66-0000 y saldo 6666666, y otro cliente con cuit_cuil=666-66-0001 y saldo 6666666

/*
INSERT INTO g06_cliente (cuit_cuil,apellido,nombre,fecha_alta,saldo,cant_pos_alq)
VALUES ('666-66-0000','Apellido De Prueba 000','Nombre De Prueba 000',current_date,6666666,0),
('666-66-0001','Apellido De Prueba 001','Nombre De Prueba 001',current_date,6666666,0);

--Consideremos un nuevo empleado perteneciente al tipo ADMINISTRACION

INSERT INTO g06_empleado (tipo_doc,nro_doc,apellido,nombre,tel_contacto,fecha_alta,fecha_baja,tipo)
VALUES ('DNI','99999999','Apellido De Prueba 000','Nombre De Prueba 000','999-99-9999',current_date,NULL,'ADMINISTRACION');

--El cliente 0000 realiza un credito de 100$ atendido por el empleado anterior.

INSERT INTO g06_movimiento_cc (id_mov_cc,fecha,cuit_cuil,importe,tipo_doc,nro_doc) 
VALUES ((select nextval('SQ_G06_MOVIMIENTO_CC_ID_MOVIMIENTO')),current_date,'666-66-0000',100,'DNI',99999999); 

--Por lo tanto en la cuenta del cliente su saldo debe modificarse a 6666666+100=6666766, y si realizamos la siguiente consulta:

SELECT * FROM G06_CLIENTE WHERE cuit_cuil='666-66-0000';

--El resultado es la tupla 

--cuit_cuil  |apellido              |nombre              |fecha_alta    |saldo     |cant_pos_alq|
-------------|----------------------|--------------------|--------------|----------|------------|
--666-66-0000|Apellido De Prueba 000|Nombre De Prueba 000|(fecha de hoy)|6666766.00|           0|

--que es lo que esperabamos.
--Si modificamos el valor del credito a 150 y el cuit_cuil asociado a 666-66-0001, este ultimo cliente debera tener
--saldo de 6666666+150=6666816, y el cliente 666-66-0000 debera tener saldo 6666766-100=6666666.

UPDATE G06_MOVIMIENTO_CC SET cuit_cuil='666-66-0001',importe=150 WHERE cuit_cuil='666-66-0000';

--Con la consulta:

SELECT * FROM G06_CLIENTE WHERE cuit_cuil IN ('666-66-0000','666-66-0001')

--cuit_cuil  |apellido              |nombre              |fecha_alta|saldo     |cant_pos_alq|
-------------|----------------------|--------------------|----------|----------|------------|
--666-66-0000|Apellido De Prueba 000|Nombre De Prueba 000|2019-11-11|6666666.00|           0|
--666-66-0001|Apellido De Prueba 001|Nombre De Prueba 001|2019-11-11|6666816.00|           0|

--Vemos que el resultado es correcto.
--Para deshacer los cambios en la base: 

DELETE FROM g06_movimiento_cc WHERE nro_doc='99999999';

DELETE FROM g06_cliente WHERE cuit_cuil IN ('666-66-0000','666-66-0001');

DELETE FROM g06_empleado WHERE tipo_doc='DNI' AND nro_doc='99999999';
*/

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

/*
UPDATE g06_posicion SET estado = 'OCUPADO' WHERE id_pos = 23;

--Utilizamos el servicio con 0.3, deberia devolver la estanteria 27
SELECT	*
FROM FN_G06_ESTANTERIAS_OCUPADAS_MAS_DE(0.3);

--Utilizamos el servicio con 0.4, no deberia devolver nada
SELECT	*
FROM FN_G06_ESTANTERIAS_OCUPADAS_MAS_DE(0.4);

--Ocupamos otra posicion de la estateria ahora la 27 esta 2/3 ocupada
UPDATE g06_posicion SET estado='OCUPADO' WHERE id_pos = 283;

--Utilizamos el servicio con 0.4, no deberia devolver nada
SELECT	*
FROM FN_G06_ESTANTERIAS_OCUPADAS_MAS_DE(0.6);

--Revertimos los datos a los originles
UPDATE g06_posicion SET estado = 'LIBRE' WHERE id_pos = 23;
UPDATE g06_posicion SET estado = 'LIBRE' WHERE id_pos = 283;
*/

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
/*
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
*/

--SERVICIO C3
--########################################################################

--Diariamente se debe actualizar la cuenta corriente de cada cliente con los alquileres
--que tienen activos, agregando un movimiento de debito (importe negativo en la cuenta
--corriente del mismo)

CREATE OR REPLACE PROCEDURE  PR_G06_GENERAR_FACTURAS() AS --Suponiendo que se ejecutaria diariamente
$body$
DECLARE
	_current_client g06_cliente.cuit_cuil%TYPE;
	_current_alq record;
	_current_alq_pos g06_alquiler_posicion%rowtype;
	_current_id_mov_cc g06_movimiento_cc.id_mov_cc%TYPE;
	_current_id_liq g06_linea_alquiler.id_liquidacion%TYPE;
	_current_date date;
	_amount_sum g06_movimiento_cc.importe%TYPE;
BEGIN
	_current_date=current_date;
	FOR _current_client IN
	(
		SELECT DISTINCT alquiler.id_cliente FROM G06_ALQUILER alquiler 
		WHERE alquiler.fecha_hasta IS NULL AND alquiler.fecha_desde<=_current_date
	)
	LOOP
		_amount_sum=0;
		_current_id_liq=(SELECT nextval ('SQ_G06_LINEA_ALQUILER_ID_LIQUIDACION'));
		_current_id_mov_cc=(SELECT nextval('SQ_G06_MOVIMIENTO_CC_ID_MOVIMIENTO'));
		INSERT INTO G06_MOVIMIENTO_CC (id_mov_cc,fecha,cuit_cuil,importe,tipo_doc,nro_doc)
		VALUES (_current_id_mov_cc,_current_date,_current_client,0,NULL,NULL);
		FOR _current_alq IN 
		(
			SELECT alquiler.id_alquiler,alquiler.importe_dia
			FROM G06_ALQUILER alquiler 
			WHERE id_cliente=_current_client
			AND fecha_desde<=_current_date AND fecha_hasta IS NULL
		)
		LOOP
			FOR _current_alq_pos IN 
			(
				SELECT alqpos.id_alquiler,alqpos.id_pos
				FROM G06_ALQUILER_POSICION alqpos
				WHERE alqpos.id_alquiler=_current_alq.id_alquiler
			)
			LOOP 
				INSERT INTO G06_LINEA_ALQUILER (id_liquidacion,id_alquiler,id_pos,importe,id_mov_cc)
				VALUES (_current_id_liq,_current_alq.id_alquiler,_current_alq_pos.id_pos,_current_alq.importe_dia,_current_id_mov_cc);
				_amount_sum=_amount_sum-_current_alq.importe_dia;
			END LOOP;
		END LOOP;
		UPDATE G06_MOVIMIENTO_CC SET importe=importe+_amount_sum WHERE id_mov_cc=_current_id_mov_cc;
	END LOOP;
END;
$body$
LANGUAGE plpgsql;


/*
--Para testear de manera clara, asegurarse de que los valores que la funcion introduce
--no se encuentren introducidos ya en la base eliminandolos con las sentencias especificadas al final.

--Supongamos que existen clientes con cuit_cuil 666-66-0000 y 666-66-0001 en la base:

INSERT INTO g06_cliente (cuit_cuil,apellido,nombre,fecha_alta,saldo,cant_pos_alq) 
VALUES 
('666-66-0000','Apellido De Prueba 000','Nombre De Prueba 000',current_date,6666666,0),
('666-66-0001','Apellido De Prueba 001','Nombre De Prueba 001',current_date,6666666,0);

--El cliente 666-66-0000 tiene 2 alquileres no definidos y el cliente
-- 666-66-0001 tiene 1 alquiler no definido (no existen en la base otros alquileres no definidos). 
--Todos los alquileres cuestan 60$ por dia:

INSERT INTO g06_alquiler (id_alquiler,id_cliente,tipo_alquiler,fecha_desde,fecha_hasta,importe_dia) 
VALUES 
(6661,'666-66-0000','indefinido','2000-01-01',NULL,60),
(6662,'666-66-0000','indefinido','2000-01-01',NULL,60),
(6664,'666-66-0001','indefinido','2000-01-01',NULL,60);

--El cliente 666-66-0000 tiene en su alquiler 6661 las posiciones 3,6 y 8. En su alquiler 6662 tiene la posicion 23.
--El cliente 666-66-0001 tiene en su alquiler 6664 la posicion 35.

INSERT INTO g06_alquiler_posicion (id_alquiler,id_pos)
VALUES 
(6661,3),
(6661,6),
(6661,8),
(6662,23),
(6664,35); 

--Llamamos al stored procedure para generar las facturas.

CALL PR_G06_GENERAR_FACTURAS(); ---SE DEBE LLAMAR A ESTA FUNCION DIARIAMENTE

--Esta actualizacion deberia dar como resultado 5 nuevas entradas en la tabla linea_alquiler, uno por cada
--alquiler en cada posicion. 4 de ellos deberian estar asociados a un nuevo movimiento_cc cuyo cuit_cuil debiera
--ser 666-66-0000. 1 de ellos deberia estar asociado a un nuevo movimiento_cc cuyo cuit_cuil tiene que ser 666-66-0001.
--Podemos comprobarlo de la siguiente manera: Nos fijamos los nuevos datos ingresados en g06_linea_alquiler:

SELECT * FROM g06_linea_alquiler WHERE id_alquiler IN (6661,6662,6664);

--Esta consulta da como resultado las siguientes tuplas:

--id_liquidacion|id_alquiler|id_pos|importe|id_mov_cc|
----------------|-----------|------|-------|---------|
--        100000|       6661|     3|     60|    80012|
--        100000|       6661|     6|     60|    80012|
--        100000|       6661|     8|     60|    80012|
--        100000|       6662|    23|     60|    80012|
--        100001|       6664|    35|     60|    80013|

--Ahora en la tabla g06_movimiento_cc comprobamos que el id_mov_cc=80012 se corresponde con el cuit_cuil=666-66-0000
--y que el id_mov_cc=80013 se corresponde con el cuit_cuil=666-66-0001 (Tener en cuenta que en diferentes ejecuciones
--los identificadores variarán, sin embargo el ejemplo es analogo).

SELECT * FROM g06_movimiento_cc WHERE id_mov_cc>=80000;

--id_mov_cc|fecha     |cuit_cuil  |importe|tipo_doc|nro_doc|
-----------|----------|-----------|-------|--------|-------|
--    80012|2019-11-11|666-66-0000|-240.00|        |       |
--    80013|2019-11-11|666-66-0001| -60.00|        |       |

--Por lo tanto se generaron de manera correcta las nuevas tuplas. No solo eso, sino que los importes correspondientes
--a los movimientos se sumaron de manera correcta (recordemos que 666-66-0000 tenia 4 alquileres de 60$ diarios lo que implica un
--importe de 240$ en la factura. Mientras que 666-66-0001 tenia un solo alquiler del mismo costo diario)

--Para deshacer los cambios introducidos a la base:
DELETE FROM g06_linea_alquiler WHERE id_alquiler IN (6661,6662,6664);

DELETE FROM g06_movimiento_cc WHERE id_mov_cc>=80000;

DELETE FROM g06_alquiler_posicion WHERE id_alquiler IN (6661,6662,6664);

DELETE FROM g06_alquiler WHERE id_alquiler IN (6661,6662,6664);

DELETE FROM g06_cliente WHERE cuit_cuil IN ('666-66-0000','666-66-0001');
*/

--VISTA D1.1
--########################################################################
SELECT *
FROM g06_movimiento gm

--Listar los datos de todos los clientes junto con el ultimo movimiento de pago de mayor
--importe que cada uno de estos realizo en los ultimos 12 meses, en el caso que corresponda

--Consideramos que con el ultimo movimiento se refiere a todos los datos
CREATE VIEW G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES AS
	SELECT c.*,mcc.id_mov_cc,mcc.fecha,mcc.importe,mcc.tipo_doc,mcc.nro_doc
	FROM g06_movimiento_cc mcc
	RIGHT JOIN g06_cliente c ON (mcc.cuit_cuil = c.cuit_cuil)
	WHERE mcc.fecha>=current_date-INTERVAL '1 year' AND mcc.nro_doc IS NOT NULL AND mcc.tipo_doc IS NOT NULL
			AND mcc.id_mov_cc = (	SELECT id_mov_cc
									FROM g06_movimiento_cc
									WHERE cuit_cuil=c.cuit_cuil
									ORDER BY importe DESC,fecha DESC
									LIMIT 1)
;

CREATE OR REPLACE FUNCTION TRFN_G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES_INSERT()
RETURNS TRIGGER AS
$BODY$
DECLARE 
	_cliente record;
	_mayor_pago record;
BEGIN	

	--Se verifica que el movimiento sea realizado dentro del ultimo a�o para simular un check option
	IF (NEW.fecha<current_date-INTERVAL '1 year') THEN
		RAISE EXCEPTION 'La fecha del movimiento tiene que ser dentro del ultimo a�o';
	END IF;

	--Se comprueba que sea efectivamente un pago, para esto se verifica que el saldo sea mayor que 0
	IF (NEW.importe<=0) THEN
		RAISE EXCEPTION 'El importe tiene que ser mayor a 0';
	END IF;
	
	--Se comprueba que el pago tenga asociado un empleado, en caso de no existir, va a fallar por las rirs
	IF (NEW.tipo_doc IS NULL OR NEW.nro_doc IS NULL) THEN
		RAISE EXCEPTION 'Tiene que referenciar a algun empleado';
	END IF;

	SELECT * INTO _cliente
	FROM g06_cliente
	WHERE cuit_cuil=NEW.cuit_cuil;

	IF (_cliente IS NULL) THEN
		
		--Se inserta tanto el cliente como el nuevo movimiento
		INSERT INTO g06_cliente (cuit_cuil,apellido,nombre,fecha_alta,saldo,cant_pos_alq)
		VALUES (NEW.cuit_cuil,NEW.apellido,NEW.nombre,NEW.fecha_alta,0,0);
		INSERT INTO g06_movimiento_cc (id_mov_cc,fecha,cuit_cuil,importe,tipo_doc,nro_doc)
		VALUES (NEW.id_mov_cc,NEW.fecha,NEW.cuit_cuil,NEW.importe,NEW.tipo_doc,NEW.nro_doc);
	ELSE
		
		--Se selecciona el maximo importe que tenia el cliente al cual se le esta agregando la factura
		SELECT mcc.* INTO _mayor_pago
		FROM g06_movimiento_cc mcc
		WHERE mcc.cuit_cuil=NEW.cuit_cuil AND mcc.nro_doc IS NOT NULL AND mcc.tipo_doc IS NOT NULL
		ORDER BY mcc.importe DESC, mcc.fecha DESC
		LIMIT 1;
	
		--Se simula el check option
		IF (NEW.importe<_mayor_pago.importe) THEN
			RAISE EXCEPTION 'El importe ingresado debe ser mayor o igual al maximo existente';
		END IF;
		IF (NEW.importe=_mayor_pago.importe AND NEW.fecha<=_mayor_pago.fecha) THEN
			RAISE EXCEPTION 'En caso de ser el mismo importe debe ser de una fecha mayor que la del pago existente';
		END IF;
		
		--Se inserta unicamente el movimiento cc ignorando si hubo o no cambios en el cliente
		INSERT INTO g06_movimiento_cc (id_mov_cc,fecha,cuit_cuil,importe,tipo_doc,nro_doc)
		VALUES (NEW.id_mov_cc,NEW.fecha,NEW.cuit_cuil,NEW.importe,NEW.tipo_doc,NEW.nro_doc);
	END IF;
	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';


CREATE TRIGGER TR_G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES_INSERT
INSTEAD OF INSERT ON G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES
FOR EACH ROW
EXECUTE PROCEDURE TRFN_G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES_INSERT();

/*
INSERT INTO G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES(cuit_cuil,apellido,nombre,fecha_alta,saldo,cant_pos_alq,id_mov_cc,fecha,importe,tipo_doc,nro_doc)
VALUES ('440-92-1464','Seymark','Abdul',to_date('2009-02-21','YYYY-MM-DD'),-723488.00,0,-1,to_date('2019-08-11','YYYY-MM-DD'),180900,'PAS',13170891)


--440-92-1464	Seymark	Abdul	2009-02-21	-723488.00	0	21	2019-08-11	180900.00	PAS       	13170891


SELECT * FROM G06_CLIENTES_ULTIMOS_PAGOS_RELEVANTES ORDER BY importe desc;

INSERT INTO g06_movimiento_cc (id_mov_cc,fecha,importe,tipo_doc,nro_doc,cuit_cuil)
VALUES (-1,current_date,156640.00,'PAS',32930773,'892-82-0758');

DELETE FROM g06_movimiento_cc WHERE id_mov_cc=-1;

SELECT * FROM g06_movimiento_cc WHERE cuit_cuil='892-82-0758';



SELECT *
FROM g06_cliente c 
WHERE EXISTS (	SELECT 1
				FROM g06_movimiento_cc mcc
				WHERE mcc.fecha<c.fecha_alta AND c.cuit_cuil=mcc.cuit_cuil)
;

SELECT * FROM g06_cliente WHERE cuit_cuil = '892-82-0758';

SELECT * FROM g06_movimiento_cc WHERE cuit_cuil = '892-82-0758';
*/

--VISTA D2.1
--########################################################################


--Listar todos los datos de las posiciones de la fila numero 5 en adelante que
--nunca han sido alquiladas

CREATE VIEW G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE AS
	SELECT p.*
	FROM g06_posicion p
	WHERE p.nro_fila >= 5 AND NOT EXISTS (	SELECT 1
											FROM g06_alquiler_posicion ap
											WHERE ap.id_pos=p.id_pos)
	--WITH CHECK OPTION
;

/*
DROP VIEW G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

SELECT * FROM G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

INSERT INTO G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE(id_pos,nro_posicion,nro_estanteria,nro_fila,pos_global,estado)
VALUES (-1,1,142,9,-1,'LIBRE');

--Este insert es para la vista con check option
--INSERT INTO G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE(id_pos,nro_posicion,nro_estanteria,nro_fila,pos_global,estado)
--VALUES (-1,1,142,4,-1,'LIBRE');

UPDATE G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE SET estado = 'OCUPADO' WHERE id_pos = -1;

SELECT * FROM G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

UPDATE G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE SET nro_fila =4  WHERE id_pos =- 1;

SELECT * FROM G06_POSICIONES_NUNCA_ALQUILADAS_FILA_5_EN_ADELANTE;

DELETE FROM g06_posicion WHERE id_pos = -1;
*/















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
GRANT ALL PRIVILEGES ON SQ_G06_MOVIMIENTO_CC_ID_MOVIMIENTO TO unc_248570;
GRANT ALL PRIVILEGES ON SQ_G06_LINEA_ALQUILER_ID_LIQUIDACION TO unc_248570;


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
GRANT ALL PRIVILEGES ON SQ_G06_MOVIMIENTO_CC_ID_MOVIMIENTO TO unc_249039;
GRANT ALL PRIVILEGES ON SQ_G06_LINEA_ALQUILER_ID_LIQUIDACION TO unc_249039;





CREATE TABLE G06_CLIENTE (
    cuit_cuil char(11) NOT NULL,
    apellido varchar(60) NOT NULL,
    nombre varchar(40) NOT NULL,
    fecha_alta date NOT NULL,
    saldo decimal(10,2) NOT NULL,
    cant_pos_alq smallint NOT NULL,
    CONSTRAINT PK_G06_CLIENTE PRIMARY KEY(cuit_cuil)
);

CREATE TABLE G06_MOVIMIENTO_CC (
    id_mov_cc int NOT NULL,
    fecha date NOT NULL,
    cuit_cuil char(11) NOT NULL,
    importe decimal(10,2) NOT NULL,
    tipo_doc char(10) NULL,
    nro_doc int NULL,
    CONSTRAINT PK_G06_MOVIMIENTO_CC PRIMARY KEY(id_mov_cc)
);

CREATE TABLE G06_EMPLEADO (
    tipo_doc char(10) NOT NULL,
    nro_doc int NOT NULL,
    apellido varchar(60) NOT NULL,
    nombre varchar(60) NOT NULL,
    tel_contacto varchar(15) NOT NULL,
    fecha_alta date NOT NULL,
    fecha_baja date NULL,
    tipo char(15) NOT NULL,
    CONSTRAINT PK_G06_EMPLEADO PRIMARY KEY(tipo_doc,nro_doc)
);

CREATE TABLE G06_PALLET (
    cod_pallet varchar(32) NOT NULL,
    descripcion varchar(200) NOT NULL,
    peso decimal(10,2) NOT NULL,
    tipo char(10) NOT NULL,
    CONSTRAINT PK_G06_PALLET PRIMARY KEY(cod_pallet)
);

CREATE TABLE G06_ALQUILER (
    id_alquiler int NOT NULL,
    id_cliente char(11) NOT NULL,
    tipo_alquiler char(10) NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NULL,
    importe_dia decimal(10,2) NOT NULL,
    CONSTRAINT PK_G06_ALQUILER PRIMARY KEY(id_alquiler)
);

CREATE TABLE G06_ALQUILER_POSICION (
    id_alquiler int NOT NULL, 
    id_pos int NOT NULL,
    CONSTRAINT PK_G06_ALQUILER_POSICION PRIMARY KEY (id_alquiler,id_pos)
);

CREATE TABLE G06_LINEA_ALQUILER (
    id_liquidacion int NOT NULL,
    id_alquiler int NOT NULL,
    id_pos int NOT NULL,
    importe decimal(10,0) NOT NULL,
    id_mov_cc int NOT NULL,
    CONSTRAINT PK_G06_LINEA_ALQUILER PRIMARY KEY (id_liquidacion,id_alquiler,id_pos)
);

CREATE TABLE G06_MOV_ENTRADA (
    id_movimiento int NOT NULL,
    transporte varchar(80) NOT NULL,
    guia varchar(80) NOT NULL,
    CONSTRAINT PK_G06_MOV_ENTRADA PRIMARY KEY (id_movimiento)
);

CREATE TABLE G06_FILA (
    nro_estanteria int NOT NULL,
    nro_fila int NOT NULL,
    nombre_fila varchar(80) NOT NULL,
    peso_max_kg decimal(10,2) NOT NULL,
    CONSTRAINT PK_G06_FILA PRIMARY KEY (nro_estanteria,nro_fila)
);

CREATE TABLE G06_POSICION (
    id_pos int NOT NULL,
    nro_posicion int NOT NULL,
    nro_estanteria int NOT NULL,
    nro_fila int NOT NULL,
    estado char(12) NOT NULL,
    por_global int NOT NULL,
    CONSTRAINT PK_G06_POSICION PRIMARY KEY (id_pos),
    CONSTRAINT UQ_G06_POSICION_NRO_POSICION_NRO_FILA_NRO_ESTANTERIA UNIQUE (nro_posicion, nro_fila, nro_estanteria)
);

CREATE TABLE G06_MOVIMIENTO (
    id_movimiento int NOT NULL,
    fecha timestamp NOT NULL,
    tipo char(1) NOT NULL,
    id_mov_ant int NULL,
    id_pos int NOT NULL,
    tipo_doc char(10) NOT NULL,
    nro_doc int  NOT NULL,
    cod_pallet varchar(32) NOT NULL,
    CONSTRAINT PK_MOVIMIENTO PRIMARY KEY (id_movimiento)
);

CREATE TABLE G06_MOV_SALIDA (
    id_movimiento int NOT NULL,
    transporte varchar(80) NOT NULL,
    guia varchar(80) NOT NULL,
    CONSTRAINT PK_G06_MOV_SALIDA PRIMARY KEY (id_movimiento)
);

CREATE TABLE G06_ESTANTERIA (
    nro_estanteria int NOT NULL,
    nombre_estanteria varchar(80) NOT NULL,
    CONSTRAINT PK_G06_ESTANTERIA PRIMARY KEY (nro_estanteria)
);

CREATE TABLE G06_ZONA_POSICION (
    id_pos int NOT NULL,
    fecha date NOT NULL,
    id_zona int NOT NULL,
    CONSTRAINT PK_G06_ZONA_POSICION PRIMARY KEY (id_pos,fecha)
);

CREATE TABLE G06_ZONA (
    id_zona int NOT NULL,
    descripcion varchar(40) NOT NULL,
    tipo char(10) NOT NULL,
    CONSTRAINT PK_G06_ZONA PRIMARY KEY (id_zona)
);

CREATE TABLE G06_MOV_INTERNO (
    id_movimiento int NOT NULL,
    razon varchar(200) NULL,
    id_pos int NOT NULL,
    CONSTRAINT PK_G06_MOV_INTERNO PRIMARY KEY(id_movimiento)
);

--########################################################################
--FOREIGN KEY
--########################################################################

ALTER TABLE G06_MOVIMIENTO_CC
	ADD CONSTRAINT FK_G06_MOVIMIENTO_CC_CLIENTE FOREIGN KEY(cuit_cuil)
	REFERENCES G06_CLIENTE(cuit_cuil)
;

ALTER TABLE G06_MOVIMIENTO_CC
	ADD CONSTRAINT FK_G06_MOVIMIENTO_CC_EMPLEADO FOREIGN KEY(tipo_doc,nro_doc)
	REFERENCES G06_EMPLEADO(tipo_doc,nro_doc)
;

ALTER TABLE G06_ALQUILER
	ADD CONSTRAINT FK_G06_ALQUILER_CLIENTE FOREIGN KEY(id_cliente)
	REFERENCES G06_CLIENTE(cuit_cuil)
;

ALTER TABLE G06_ALQUILER_POSICION
    ADD CONSTRAINT FK_G06_ALQUILER_POSICION_POSICION FOREIGN KEY (id_pos)
    REFERENCES G06_POSICION (id_pos)
;

ALTER TABLE G06_ALQUILER_POSICION
    ADD CONSTRAINT FK_G06_ALQUILER_POSICION_ALQUILER FOREIGN KEY (id_alquiler)
    REFERENCES G06_ALQUILER(id_alquiler)
;

ALTER TABLE G06_LINEA_ALQUILER
    ADD CONSTRAINT FK_G06_LINEA_ALQUILER_ALQUILER_POSICION FOREIGN KEY (id_alquiler,id_pos)
    REFERENCES G06_ALQUILER_POSICION (id_alquiler,id_pos)
;

ALTER TABLE G06_LINEA_ALQUILER
    ADD CONSTRAINT FK_G06_LINEA_ALQUILER_MOVIMIENTO_CC FOREIGN KEY (id_mov_cc)
    REFERENCES G06_MOVIMIENTO_CC (id_mov_cc)
;

ALTER TABLE G06_MOV_ENTRADA
	ADD CONSTRAINT FK_G06_MOV_ENTRADA_MOVIMIENTO FOREIGN KEY(id_movimiento)
	REFERENCES G06_MOVIMIENTO(id_movimiento)
;

ALTER TABLE G06_FILA
    ADD CONSTRAINT FK_G06_FILA_ESTANTERIA FOREIGN KEY (nro_estanteria)
    REFERENCES G06_ESTANTERIA (nro_estanteria)
;

ALTER TABLE G06_POSICION
    ADD CONSTRAINT FK_G06_POSICION_FILA FOREIGN KEY (nro_estanteria,nro_fila)
    REFERENCES G06_FILA (nro_estanteria,nro_fila)
;

ALTER TABLE G06_MOVIMIENTO
    ADD CONSTRAINT FK_G06_MOVIMIENTO_MOVIMIENTO FOREIGN KEY (id_movimiento)
    REFERENCES G06_MOVIMIENTO (id_movimiento)
;

ALTER TABLE G06_MOVIMIENTO
	ADD CONSTRAINT FK_G06_MOVIMIENTO_EMPLEADO FOREIGN KEY(tipo_doc,nro_doc)
	REFERENCES G06_EMPLEADO(tipo_doc,nro_doc)
;

ALTER TABLE G06_MOVIMIENTO
	ADD CONSTRAINT FK_G06_MOVIMIENTO_PALLET FOREIGN KEY(cod_pallet)
	REFERENCES G06_PALLET(cod_pallet)
;

ALTER TABLE G06_MOVIMIENTO
    ADD CONSTRAINT FK_G06_MOVIMIENTO_POSICION FOREIGN KEY (id_pos)
    REFERENCES _POSICION (id_pos)
;

ALTER TABLE G06_MOV_SALIDA
    ADD CONSTRAINT FK_G06_MOV_SALIDA_MOVIMIENTO FOREIGN KEY (id_movimiento)
    REFERENCES G06_MOVIMIENTO (id_movimiento)
;

ALTER TABLE G06_ZONA_POSICION
    ADD CONSTRAINT FK_G06_ZONA_POSICION_ZONA FOREIGN KEY (id_zona)
    REFERENCES G06_ZONA (id_zona)
;

ALTER TABLE G06_ZONA_POSICION
	ADD CONSTRAINT FK_G06_ZONA_POSICION_POSICION FOREIGN KEY(id_pos)
	REFERENCES G06_POSICION(id_pos)
;

ALTER TABLE G06_MOV_INTERNO
	ADD CONSTRAINT FK_G06_MOV_INTERNO_POSICION FOREIGN KEY(id_pos)
	REFERENCES G06_POSICION(id_pos)
;

ALTER TABLE G06_MOV_INTERNO
	ADD CONSTRAINT FK_G06_MOV_INTERNO_MOVIMIENTO FOREIGN KEY(id_movimiento)
	REFERENCES G06_MOVIMIENTO(id_movimiento)
;


--########################################################################
--INSERCCION DE DATOS DESDE EL ESQUEMA
--########################################################################


INSERT INTO g06_cliente
SELECT * FROM unc_tpe2019.cliente

INSERT INTO g06_pallet
SELECT * FROM unc_tpe2019.pallet

INSERT INTO g06_estanteria
SELECT * FROM unc_tpe2019.estanteria

INSERT INTO g06_fila 
SELECT * FROM unc_tpe2019.fila

INSERT INTO g06_posicion
SELECT * FROM unc_tpe2019.posicion 




SELECT *
FROM unc_tpe2019.mov_salida

SELECT *
FROM unc_tpe2019.movimiento a
WHERE cod_pallet='39214160'
ORDER BY fecha


SELECT *
FROM unc_tpe2019.movimiento




ALTER TABLE G06_MOVIMIENTO ADD CONSTRAINT ck_ultimo_movimiento
CHECK (
	NOT EXISTS (
		SELECT 1
		FROM G06_MOVIMIENTO
		WHERE tiipo = 's' AND m.id_mov_ant <> (	SELECT id_movimiento
												FROM G06_MOVIMIENTO
												WHERE tipo <> 's' AND cod_pallet = m.cod_pallet AND fecha < m.fecha
												ORDER BY fecha DESC
												LIMIT 1
		)
		
	)
);

CREATE OR REPLACE FUNCTION FN_G06_C11(_porcentaje real)
RETURNS TABLE(	nro_estanteria int,
				nombre_estanteria varchar(80))
AS
$$
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
$$
LANGUAGE 'plpgsql';

DROP FUNCTION FN_G06_C11;

SELECT	*
FROM FN_G06_C11(0.2);

INSERT INTO g06_fila
SELECT * FROM unc_tpe2019.fila;

INSERT INTO g06_estanteria
SELECT * FROM unc_tpe2019.estanteria AS e;

INSERT INTO g06_posicion
SELECT * FROM unc_tpe2019.posicion AS p

INSERT INTO g06_posicion(id_pos,nro_posicion,nro_estanteria,nro_fila,estado,por_global) VALUES (288,1,-11,2,'OCUPADO',2);
INSERT INTO g06_fila(nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (-11,2,'null',0);
INSERT INTO g06_estanteria(nro_estanteria,nombre_estanteria) VALUES (-11, 'ESTANTERIA -11');
 
SELECT * FROM g06_estanteria AS ge

SELECT *
FROM unc_tpe2019.posicion
WHERE nro_estanteria=288

SELECT *
FROM g06_posicion AS gp

SELECT *
FROM g06_estanteria AS ge

SELECT * FROM g06_fila AS gf
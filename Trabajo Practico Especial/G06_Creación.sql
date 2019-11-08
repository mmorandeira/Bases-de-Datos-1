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
    pos_global int NOT NULL,
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
    REFERENCES G06_POSICION (id_pos)
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


INSERT INTO g06_cliente (cuit_cuil,apellido,nombre,fecha_alta,saldo,cant_pos_alq)
SELECT cuit_cuil,apellido,nombre,fecha_alta,saldo,cant_pos_alq FROM unc_tpe2019.cliente;

INSERT INTO g06_pallet (cod_pallet,descripcion,peso,tipo)
SELECT cod_pallet,descripcion,peso,tipo FROM unc_tpe2019.pallet;

INSERT INTO g06_estanteria (nro_estanteria,nombre_estanteria)
SELECT nro_estanteria,nombre_estanteria FROM unc_tpe2019.estanteria;

INSERT INTO g06_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg)
SELECT nro_estanteria,nro_fila,nombre_fila,peso_max_kg FROM unc_tpe2019.fila;

INSERT INTO g06_posicion (id_pos,nro_posicion,nro_estanteria,nro_fila,estado,pos_global)
SELECT id_pos,nro_posicion,nro_estanteria,nro_fila,estado,pos_global FROM unc_tpe2019.posicion ;

INSERT INTO g06_empleado (tipo_doc,nro_doc,apellido,nombre,tel_contacto,fecha_alta,fecha_baja,tipo)
SELECT tipo_doc,nro_doc,apellido,nombre,tel_contacto,fecha_alta,fecha_baja,tipo FROM unc_tpe2019.empleado;

INSERT INTO g06_zona (id_zona,descripcion,tipo)
SELECT id_zona,descripcion,tipo FROM unc_tpe2019.zona;

INSERT INTO g06_zona_posicion (id_pos,fecha,id_zona)
SELECT id_pos,fecha,id_zona FROM unc_tpe2019.zona_posicion;

INSERT INTO g06_movimiento (id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet)
SELECT id_movimiento,fecha,tipo,id_mov_ant,id_pos,tipo_doc,nro_doc,cod_pallet FROM unc_tpe2019.movimiento;

INSERT INTO g06_mov_entrada (id_movimiento,transporte,guia)
SELECT id_movimiento,transporte,guia FROM unc_tpe2019.mov_entrada;

INSERT INTO g06_mov_salida (id_movimiento,transporte,guia)
SELECT * FROM unc_tpe2019.mov_salida;

INSERT INTO g06_mov_interno(id_movimiento,razon,id_pos)
SELECT id_movimiento,razon,id_pos FROM unc_tpe2019.mov_interno;

INSERT INTO g06_alquiler(id_alquiler,id_cliente,tipo_alquiler,fecha_desde,fecha_hasta,importe_dia)
SELECT id_alquiler,id_cliente,tipo_alquiler,fecha_desde,fecha_hasta,importe_dia FROM unc_tpe2019.alquiler;

INSERT INTO g06_alquiler_posicion(id_alquiler, id_pos)
SELECT id_alquiler,id_pos FROM unc_tpe2019.alquiler_posicion;

INSERT INTO g06_movimiento_cc(id_mov_cc, fecha, cuit_cuil, importe, tipo_doc, nro_doc)
SELECT id_mov_cc,fecha,cuit_cuil,importe,tipo_doc,nro_doc FROM unc_tpe2019.movimiento_cc;

INSERT INTO g06_linea_alquiler(id_liquidacion,id_alquiler,id_pos,importe,id_mov_cc)
SELECT id_liquidacion,id_alquiler,id_pos,importe,id_mov_cc FROM unc_tpe2019.linea_alquiler;









--EJERCICIO 1
--########################################################################


CREATE TABLE tp3p1_ej1_empleado (
	TipoE char NOT NULL,
	NroE int NOT NULL,
	Nombre varchar(60) NOT NULL,
	Cargo varchar(60) NOT NULL,
	CONSTRAINT PK_tp3p1_ej1_empleado PRIMARY KEY(TipoE,NroE)
);

CREATE TABLE tp3p1_ej1_proyecto (
	IdProy int NOT NULL,
	NombreProy varchar(60) NOT NULL,
	AnioComienzo int NOT NULL,
	AnioFinal int NULL,
	CONSTRAINT PK_tp3p1_ej1_proyecto PRIMARY KEY(IdProy)
);

CREATE TABLE tp3p1_ej1_auspicio (
	IdProy int NOT NULL,
	NombreAuspiciante varchar(60) NOT NULL,
	TipoE char NULL,
	NroE int NULL,
	CONSTRAINT PK_tp3p1_ej1_auspicio PRIMARY KEY(IdProy,NombreAuspiciante)
);

CREATE TABLE tp3p1_ej1_trabaja_en (
	TipoE char NOT NULL,
	NroE int NOT NULL,
	IdProy int NOT NULL,
	Anio int NOT NULL,
	Mes int NOT NULL,
	cant_horas real NOT NULL,
	tarea varchar(60) NOT NULL,
	CONSTRAINT PK_tp3p1_ej1_trabaja_en PRIMARY KEY(TipoE,NroE,IdProy,Anio,Mes)
);

--restriccion numero 1
ALTER TABLE tp3p1_ej1_trabaja_en
	ADD CONSTRAINT fk_tp3p1_ej1_trabaja_en_tp3p1_ej1_empleado FOREIGN KEY(TipoE,NroE)
	REFERENCES tp3p1_ej1_empleado(TipoE,NroE)
		ON UPDATE RESTRICT
		ON DELETE CASCADE
;

--restriccion numero 2
ALTER TABLE tp3p1_ej1_trabaja_en
	ADD CONSTRAINT fk_tp3p1_ej1_trabaja_en_tp3p1_ej1_proyecto FOREIGN KEY(IdProy)
	REFERENCES tp3p1_ej1_proyecto(IdProy)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
;

--restriccion numero 3
ALTER TABLE tp3p1_ej1_auspicio
	ADD CONSTRAINT fk_tp3p1_ej1_auspicio_tp3p1_ej1_proyecto FOREIGN KEY(IdProy)
	REFERENCES tp3p1_ej1_proyecto(IdProy)
		ON UPDATE RESTRICT
		ON DELETE RESTRICT
;

--restriccion numero 4
ALTER TABLE tp3p1_ej1_auspicio
	ADD CONSTRAINT fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado FOREIGN KEY(TipoE,NroE)
	REFERENCES tp3p1_ej1_empleado(TipoE,NroE)
		ON UPDATE RESTRICT
		ON DELETE SET NULL
;

INSERT INTO tp3p1_ej1_empleado(TipoE,NroE,Nombre,Cargo) VALUES ('A',1,'Horacio Casado','Atiende boludos');
INSERT INTO tp3p1_ej1_empleado(TipoE,NroE,Nombre,Cargo) VALUES ('B',2,'Thomas Ojeda','No parar de agregar cosas');
INSERT INTO tp3p1_ej1_empleado(TipoE,NroE,Nombre,Cargo) VALUES ('A',2,'Dana Alvarez y Martinez','Se exagerada(intensa)');

INSERT INTO tp3p1_ej1_proyecto(IdProy,NombreProy,AnioComienzo,AnioFinal) VALUES (1,'proyecto bases',2019,10);
INSERT INTO tp3p1_ej1_proyecto(IdProy,NombreProy,AnioComienzo,AnioFinal) VALUES (2,'proyecto exploratoria parte2(tesis)',2019,2024);
INSERT INTO tp3p1_ej1_proyecto(IdProy,NombreProy,AnioComienzo,AnioFinal) VALUES (3,'proyecto exploratoria parte1',2019,2020);

INSERT INTO tp3p1_ej1_auspicio(IdProy,NombreAuspiciante,TipoE,NroE) VALUES (2,'Arcor','A',2);

INSERT INTO tp3p1_ej1_trabaja_en(TipoE,NroE,IdProy,Anio,Mes,cant_horas,tarea) VALUES ('A',1,1,2019,10,20,'Lustrar los pisos');
INSERT INTO tp3p1_ej1_trabaja_en(TipoE,NroE,IdProy,Anio,Mes,cant_horas,tarea) VALUES ('B',2,2,2019,10,32,'Detectar imagenes con cancer');

SELECT *
FROM tp3p1_ej1_empleado

SELECT *
FROM tp3p1_ej1_proyecto

SELECT *
FROM tp3p1_ej1_auspicio

SELECT *
FROM tp3p1_ej1_trabaja_en


--b.1
DELETE FROM tp3p1_ej1_proyecto WHERE IdProy=3;--lo ejecuta lo mas bien loco

--b.2
UPDATE tp3p1_ej1_proyecto SET IdProy=7 WHERE IdProy=3;--lo ejecuta lo mas bien loco

--b.3
DELETE FROM tp3p1_ej1_proyecto WHERE IdProy=1;--no se puede porque esta siendo referenciado en trabaja en

--b.4
DELETE FROM tp3p1_ej1_empleado WHERE TipoE='A' AND NroE=2;--lo ejecuta lo mas bien loco

--b.5
UPDATE tp3p1_ej1_trabaja_en SET IdProy=3 WHERE IdProy=1;--lo ejecuta lo mas bien loco

--b.6
UPDATE tp3p1_ej1_proyecto SET IdProy=5 WHERE IdProy=2;--no se puede porque esta siendo referenciado en auspicio



--c.1 match full
INSERT INTO tp3p1_ej1_auspicio VALUES(1,'Dell','B',NULL);

--c.2 match full
INSERT INTO tp3p1_ej1_auspicio VALUES(2,'Oracle',NULL,NULL);

--c.3 match full
INSERT INTO tp3p1_ej1_auspicio VALUES(3,'Google',A,3);

--c.4 match full
INSERT INTO tp3p1_ej1_auspicio VALUES(1,'HP',NULL,3);

ALTER TABLE tp3p1_ej1_auspicio
DROP CONSTRAINT fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado;

ALTER TABLE tp3p1_ej1_auspicio
	ADD CONSTRAINT fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado FOREIGN KEY(TipoE,NroE)
	REFERENCES tp3p1_ej1_empleado(TipoE,NroE)
		MATCH PARTIAL
		ON UPDATE RESTRICT
		ON DELETE SET NULL
;

--c.1 match parcial
INSERT INTO tp3p1_ej1_auspicio VALUES(1,'Dell','B',NULL);

--c.2 match parcial
INSERT INTO tp3p1_ej1_auspicio VALUES(2,'Oracle',NULL,NULL);

--c.3 match parcial
INSERT INTO tp3p1_ej1_auspicio VALUES(3,'Google',A,3);

--c.4 match parcial
INSERT INTO tp3p1_ej1_auspicio VALUES(1,'HP',NULL,3);


ALTER TABLE tp3p1_ej1_auspicio
DROP CONSTRAINT fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado;

ALTER TABLE tp3p1_ej1_auspicio
	ADD CONSTRAINT fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado FOREIGN KEY(TipoE,NroE)
	REFERENCES tp3p1_ej1_empleado(TipoE,NroE)
		MATCH SIMPLE
		ON UPDATE RESTRICT
		ON DELETE SET NULL
;

--c.1 match simple
INSERT INTO tp3p1_ej1_auspicio VALUES(1,'Dell','B',NULL);

--c.2 match simple
INSERT INTO tp3p1_ej1_auspicio VALUES(2,'Oracle',NULL,NULL);

--c.3 match simple
INSERT INTO tp3p1_ej1_auspicio VALUES(3,'Google',A,3);

--c.4 match simple
INSERT INTO tp3p1_ej1_auspicio VALUES(1,'HP',NULL,3);

--EJERCICIO 2
--########################################################################

CREATE TABLE tp3p1_ej2_cliente (
	Zona char NOT NULL,
	NroC int NOT NULL,
	Nombre varchar(60) NOT NULL,
	Ciudad varchar(60) NOT NULL,
	CONSTRAINT PK_tp3p1_ej2_cliente PRIMARY KEY(Zona,NroC)
);

CREATE TABLE tp3p1_ej2_servicio (
	IdServ varchar(60) NOT NULL,
	NombreServ varchar(60) NOT NULL,
	AnioComienzo int NOT NULL,
	AnioFin int NULL,
	CantInst int NOT NULL,
	CONSTRAINT PK_tp3p1_ej2_servicio PRIMARY KEY(IdServ)
);

CREATE TABLE tp3p1_ej2_referencia (
	IdServ varchar(60) NOT NULL,
	Motivo varchar(60) NOT NULL,
	Zona char NULL,
	NroC int NULL,
	CONSTRAINT PK_tp3p1_ej2_referencia PRIMARY KEY(IdServ,Motivo)
);

CREATE TABLE tp3p1_ej2_instalacion (
	Zona char NOT NULL,
	NroC int NOT NULL,
	IdServ varchar(60) NOT NULL,
	Anio int NOT NULL,
	Mes int NOT NULL,
	CantHoras real NOT NULL,
	Tarea varchar(60) NOT NULL,
	CONSTRAINT PK_tp3p1_ej2_instalacion PRIMARY KEY(Zona,NroC,IdServ)
);

ALTER TABLE tp3p1_ej2_instalacion
	ADD CONSTRAINT fk_tp3p1_ej2_instalacion_tp3p1_ej2_cliente FOREIGN KEY(Zona,NroC)
	REFERENCES tp3p1_ej2_cliente(Zona,NroC)
		ON UPDATE RESTRICT
		ON DELETE CASCADE
;

ALTER TABLE tp3p1_ej2_instalacion
	ADD CONSTRAINT fk_tp3p1_ej2_instalacion_tp3p1_ej2_servicio FOREIGN KEY(IdServ)
	REFERENCES tp3p1_ej2_servicio(IdServ)
		ON UPDATE RESTRICT
		ON DELETE RESTRICT
;

ALTER TABLE tp3p1_ej2_referencia
	ADD CONSTRAINT fk_tp3p1_ej2_referencia_tp3p1_ej2_servicio FOREIGN KEY(IdServ)
	REFERENCES tp3p1_ej2_servicio(IdServ)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
;

ALTER TABLE tp3p1_ej2_referencia
	ADD CONSTRAINT fk_tp3p1_ej2_referencia_tp3p1_ej2_cliente FOREIGN KEY(Zona,NroC)
	REFERENCES tp3p1_ej2_cliente(Zona,NroC)
		ON UPDATE SET NULL
		ON DELETE RESTRICT
;

INSERT INTO tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) VALUES('A',1,'Juan Ro','C1');
INSERT INTO tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) VALUES('A',2,'Alberto Efe','C1');
INSERT INTO tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) VALUES('B',1,'Esteban Hache','C1');
INSERT INTO tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) VALUES('C',2,'Jose Ge','C3');
INSERT INTO tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) VALUES('D',3,'Luis Ene','C2');

INSERT INTO tp3p1_ej2_servicio(IdServ,NombreServ,AnioComienzo,AnioFin,CantInst) VALUES('S1','Serv 1',2010,2012,2);
INSERT INTO tp3p1_ej2_servicio(IdServ,NombreServ,AnioComienzo,AnioFin,CantInst) VALUES('S2','Serv 2',2012,2012,1);
INSERT INTO tp3p1_ej2_servicio(IdServ,NombreServ,AnioComienzo,AnioFin,CantInst) VALUES('S3','Serv 3',2009,NULL,1);

INSERT INTO tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) VALUES('A',1,'S1',5,2011,5,'T1');
INSERT INTO tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) VALUES('B',1,'S2',5,2012,7,'T1');
INSERT INTO tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) VALUES('C',2,'S1',4,2010,9,'T2');
INSERT INTO tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) VALUES('A',2,'S3',8,2009,6,'T2');

INSERT INTO tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) VALUES('S1','Puntualidad','D',3);
INSERT INTO tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) VALUES('S2','Calidad inst.','C',2);
INSERT INTO tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) VALUES('S3','Costo','C',2);
INSERT INTO tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) VALUES('S1','Atención','D',3);

DELETE FROM tp3p1_ej2_instalacion AS tpei;
DELETE FROM tp3p1_ej2_cliente AS tpec;
DELETE FROM tp3p1_ej2_servicio AS tpes;
DELETE FROM tp3p1_ej2_referencia AS tper;

DELETE FROM tp3p1_ej2_cliente WHERE NroC=1; 
--Borra las tuplas ('A',1,'Juan Ro','C1') y ('B',1,'Esteban Hache','C1') y por el CASCADE
--borra las tuplas ('A',1,'S1',5,2011,5,'T1') y ('B',1,'S2',5,2012,7,'T1')

UPDATE tp3p1_ej2_instalacion SET IdServ='S5' WHERE IdServ='S2';
--La operacion se puede realizar, pero no hay ningun registro que contenga 
--un IdServ=2 por lo tanto no modifica ningun registro de la tabla instalacion

UPDATE tp3p1_ej2_cliente SET Zona='Z' WHERE Zona='D';
--Modifica el registro de ('D',3,'Luis Ene','C2') por ('Z',3,'Luis Ene','C2') 



--EJERCICIO 3
--########################################################################

CREATE TABLE tp3p1_ej3_articulo (
	id_articulo int NOT NULL,
	titulo varchar(60) NULL,
	autor varchar(60) NULL,
	nacionalidad varchar(60) NULL,
	fecha_pub date NULL,
	CONSTRAINT PK_tp3p1_ej3_articulo PRIMARY KEY(id_articulo)
);

CREATE TABLE tp3p1_ej3_contiene (
	id_articulo int NOT NULL,
	idioma varchar(60) NOT NULL,
	cod_palabra int NOT NULL,
	nro_seccion int NULL,
	CONSTRAINT PK_tp3p1_ej3_contiene PRIMARY KEY(id_articulo,idioma,cod_palabra)
);

CREATE TABLE tp3p1_ej3_palabra (
	idioma varchar(60) NOT NULL,
	cod_palabra int NOT NULL,
	descripcion varchar(60) NULL,
	CONSTRAINT PK_tp3p1_ej3_palabra PRIMARY KEY(idioma,cod_palabra)
);

ALTER TABLE tp3p1_ej3_contiene
	ADD CONSTRAINT fk_tp3p1_ej3_contiene_tp3p1_ej3_articulo FOREIGN KEY(id_articulo)
	REFERENCES tp3p1_ej3_articulo(id_articulo)
;

ALTER TABLE tp3p1_ej3_contiene
	ADD CONSTRAINT fk_tp3p1_ej3_contiene_tp3p1_ej3_palabra FOREIGN KEY(idioma,cod_palabra)
	REFERENCES tp3p1_ej3_palabra(idioma,cod_palabra)
;

SELECT a.*,p.*
FROM tp3p1_ej3_articulo a
JOIN tp3p1_ej3_contiene c ON(a.id_articulo=c.id_articulo)
JOIN tp3p1_ej3_palabra p ON(c.idioma=p.idioma AND c.cod_palabra=p.cod_palabra)

SELECT *
FROM tp3p1_ej3_articulo

SELECT *
FROM tp3p1_ej3_contiene

SELECT *
FROM tp3p1_ej3_palabra

ALTER TABLE tp3p1_ej3_articulo ADD CONSTRAINT nacionalidades_validas
CHECK (nacionalidad IN ('Argentina','Español','Ingles','Aleman','Chilena'));

ALTER TABLE tp3p1_ej3_articulo ADD CONSTRAINT fechas_validas
CHECK (NOT (EXTRACT(YEAR FROM fecha_pub)=2017 AND nacionalidad!='Argetina'));



--EJERCICIO 4
--########################################################################

CREATE TABLE tp3p1_ej4_producto (
	cod_producto int NOT NULL,
	presentacion varchar(60) NULL,
	descripcion varchar(60) NULL,
	tipo varchar(60) NULL,
	CONSTRAINT PK_tp3p1_ej4_producto PRIMARY KEY(cod_producto)
);

CREATE TABLE tp3p1_ej4_sucursal (
	cod_suc varchar(60) NOT NULL,
	nombre varchar(60) NULL,
	localidad varchar(60) NULL,
	CONSTRAINT PK_tp3p1_ej4_sucursal PRIMARY KEY(cod_suc)
);

CREATE TABLE tp3p1_ej4_proveedor (
	nro_prov int NOT NULL,
	nombre varchar(60) NULL,
	direccion varchar(60) NULL,
	localidad varchar(60) NULL,
	fecha_nac date NULL,
	CONSTRAINT PK_tp3p1_ej4_proveedor PRIMARY KEY(nro_prov)
);

CREATE TABLE tp3p1_ej4_provee (
	cod_producto int NOT NULL,
	nro_prov int NOT NULL,
	cod_suc varchar(60) NOT NULL,
	CONSTRAINT PK_tp3p1_ej4_provee PRIMARY KEY(cod_producto,nro_prov)
);

ALTER TABLE tp3p1_ej4_provee
	ADD CONSTRAINT fk_tp3p1_ej4_provee_tp3p1_ej4_producto FOREIGN KEY(cod_producto)
	REFERENCES tp3p1_ej4_producto(cod_producto)
;

ALTER TABLE tp3p1_ej4_provee
	ADD CONSTRAINT fk_tp3p1_ej4_provee_tp3p1_ej4_sucursal FOREIGN KEY(cod_suc)
	REFERENCES tp3p1_ej4_sucursal(cod_suc)
;

ALTER TABLE tp3p1_ej4_provee
	ADD CONSTRAINT fk_tp3p1_ej4_provee_tp3p1_ej4_proveedor FOREIGN KEY(nro_prov)
	REFERENCES tp3p1_ej4_proveedor(nro_prov)
;

ALTER TABLE tp3p1_ej4_sucursal ADD CONSTRAINT formato_cod_suc
CHECK (cod_suc like 'S_%');

ALTER TABLE tp3p1_ej4_producto ADD CONSTRAINT descripcion_o_pres_no_NULL
CHECK (NOT (descripcion IS NULL AND presentacion IS NULL));

INSERT INTO tp3p1_ej4_producto(cod_producto,descripcion) VALUES(1,'xD');







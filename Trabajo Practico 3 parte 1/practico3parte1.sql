--EJERCICIO 1
--########################################################################

create table tp3p1_ej1_empleado (
	TipoE char not null,
	NroE int not null,
	Nombre varchar(60) not null,
	Cargo varchar(60) not null,
	constraint pk_tp3p1_ej1_empleado primary key(TipoE,NroE)
);

create table tp3p1_ej1_proyecto (
	IdProy int not null,
	NombreProy varchar(60) not null,
	AnioComienzo int not null,
	AnioFinal int null,
	constraint pk_tp3p1_ej1_proyecto primary key(IdProy)
);

create table tp3p1_ej1_auspicio (
	IdProy int not null,
	NombreAuspiciante varchar(60) not null,
	TipoE char null,
	NroE int null,
	constraint pk_tp3p1_ej1_auspicio primary key(IdProy,NombreAuspiciante)
);

create table tp3p1_ej1_trabaja_en (
	TipoE char not null,
	NroE int not null,
	IdProy int not null,
	Anio int not null,
	Mes int not null,
	cant_horas real not null,
	tarea varchar(60) not null,
	constraint pk_tp3p1_ej1_trabaja_en primary key(TipoE,NroE,IdProy,Anio,Mes)
);

--restriccion numero 1
alter table tp3p1_ej1_trabaja_en
	add constraint fk_tp3p1_ej1_trabaja_en_tp3p1_ej1_empleado foreign key(TipoE,NroE)
	references tp3p1_ej1_empleado(TipoE,NroE)
		on update restrict
		on delete cascade
;

--restriccion numero 2
alter table tp3p1_ej1_trabaja_en
	add constraint fk_tp3p1_ej1_trabaja_en_tp3p1_ej1_proyecto foreign key(IdProy)
	references tp3p1_ej1_proyecto(IdProy)
		on update cascade
		on delete restrict
;

--restriccion numero 3
alter table tp3p1_ej1_auspicio
	add constraint fk_tp3p1_ej1_auspicio_tp3p1_ej1_proyecto foreign key(IdProy)
	references tp3p1_ej1_proyecto(IdProy)
		on update restrict
		on delete restrict
;

--restriccion numero 4
alter table tp3p1_ej1_auspicio
	add constraint fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado foreign key(TipoE,NroE)
	references tp3p1_ej1_empleado(TipoE,NroE)
		on update restrict
		on delete set null
;

insert into tp3p1_ej1_empleado(TipoE,NroE,Nombre,Cargo) values ('A',1,'Horacio Casado','Atiende boludos');
insert into tp3p1_ej1_empleado(TipoE,NroE,Nombre,Cargo) values ('B',2,'Thomas Ojeda','No parar de agregar cosas');
insert into tp3p1_ej1_empleado(TipoE,NroE,Nombre,Cargo) values ('A',2,'Dana Alvarez y Martinez','Se exagerada(intensa)');

insert into tp3p1_ej1_proyecto(IdProy,NombreProy,AnioComienzo,AnioFinal) values (1,'proyecto bases',2019,10);
insert into tp3p1_ej1_proyecto(IdProy,NombreProy,AnioComienzo,AnioFinal) values (2,'proyecto exploratoria parte2(tesis)',2019,2024);
insert into tp3p1_ej1_proyecto(IdProy,NombreProy,AnioComienzo,AnioFinal) values (3,'proyecto exploratoria parte1',2019,2020);

insert into tp3p1_ej1_auspicio(IdProy,NombreAuspiciante,TipoE,NroE) values (2,'Arcor','A',2);

insert into tp3p1_ej1_trabaja_en(TipoE,NroE,IdProy,Anio,Mes,cant_horas,tarea) values ('A',1,1,2019,10,20,'Lustrar los pisos');
insert into tp3p1_ej1_trabaja_en(TipoE,NroE,IdProy,Anio,Mes,cant_horas,tarea) values ('B',2,2,2019,10,32,'Detectar imagenes con cancer');

select *
from tp3p1_ej1_empleado

select *
from tp3p1_ej1_proyecto

select *
from tp3p1_ej1_auspicio

select *
from tp3p1_ej1_trabaja_en


--b.1
delete from tp3p1_ej1_proyecto where IdProy=3;--lo ejecuta lo mas bien loco

--b.2
update tp3p1_ej1_proyecto set IdProy=7 where IdProy=3;--lo ejecuta lo mas bien loco

--b.3
delete from tp3p1_ej1_proyecto where IdProy=1;--no se puede porque esta siendo referenciado en trabaja en

--b.4
delete from tp3p1_ej1_empleado where TipoE='A' and NroE=2;--lo ejecuta lo mas bien loco

--b.5
update tp3p1_ej1_trabaja_en set IdProy=3 where IdProy=1;--lo ejecuta lo mas bien loco

--b.6
update tp3p1_ej1_proyecto set IdProy=5 where IdProy=2;--no se puede porque esta siendo referenciado en auspicio



--c.1 match full
insert into tp3p1_ej1_auspicio values(1,'Dell','B',null);

--c.2 match full
insert into tp3p1_ej1_auspicio values(2,'Oracle',null,null);

--c.3 match full
insert into tp3p1_ej1_auspicio values(3,'Google',A,3);

--c.4 match full
insert into tp3p1_ej1_auspicio values(1,'HP',null,3);

alter table tp3p1_ej1_auspicio
drop constraint fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado;

alter table tp3p1_ej1_auspicio
	add constraint fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado foreign key(TipoE,NroE)
	references tp3p1_ej1_empleado(TipoE,NroE)
		match partial
		on update restrict
		on delete set null
;

--c.1 match parcial
insert into tp3p1_ej1_auspicio values(1,'Dell','B',null);

--c.2 match parcial
insert into tp3p1_ej1_auspicio values(2,'Oracle',null,null);

--c.3 match parcial
insert into tp3p1_ej1_auspicio values(3,'Google',A,3);

--c.4 match parcial
insert into tp3p1_ej1_auspicio values(1,'HP',null,3);


alter table tp3p1_ej1_auspicio
drop constraint fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado;

alter table tp3p1_ej1_auspicio
	add constraint fk_tp3p1_ej1_auspicio_tp3p1_ej1_empleado foreign key(TipoE,NroE)
	references tp3p1_ej1_empleado(TipoE,NroE)
		match simple
		on update restrict
		on delete set null
;

--c.1 match simple
insert into tp3p1_ej1_auspicio values(1,'Dell','B',null);

--c.2 match simple
insert into tp3p1_ej1_auspicio values(2,'Oracle',null,null);

--c.3 match simple
insert into tp3p1_ej1_auspicio values(3,'Google',A,3);

--c.4 match simple
insert into tp3p1_ej1_auspicio values(1,'HP',null,3);

--EJERCICIO 2
--########################################################################

create table tp3p1_ej2_cliente (
	Zona char not null,
	NroC int not null,
	Nombre varchar(60) not null,
	Ciudad varchar(60) not null,
	constraint pk_tp3p1_ej2_cliente primary key(Zona,NroC)
);

create table tp3p1_ej2_servicio (
	IdServ varchar(60) not null,
	NombreServ varchar(60) not null,
	AnioComienzo int not null,
	AnioFin int null,
	CantInst int not null,
	constraint pk_tp3p1_ej2_servicio primary key(IdServ)
);

create table tp3p1_ej2_referencia (
	IdServ varchar(60) not null,
	Motivo varchar(60) not null,
	Zona char null,
	NroC int null,
	constraint pk_tp3p1_ej2_referencia primary key(IdServ,Motivo)
);

create table tp3p1_ej2_instalacion (
	Zona char not null,
	NroC int not null,
	IdServ varchar(60) not null,
	Anio int not null,
	Mes int not null,
	CantHoras real not null,
	Tarea varchar(60) not null,
	constraint pk_tp3p1_ej2_instalacion primary key(Zona,NroC,IdServ)
);

alter table tp3p1_ej2_instalacion
	add constraint fk_tp3p1_ej2_instalacion_tp3p1_ej2_cliente foreign key(Zona,NroC)
	references tp3p1_ej2_cliente(Zona,NroC)
		on update restrict
		on delete cascade
;

alter table tp3p1_ej2_instalacion
	add constraint fk_tp3p1_ej2_instalacion_tp3p1_ej2_servicio foreign key(IdServ)
	references tp3p1_ej2_servicio(IdServ)
		on update restrict
		on delete restrict
;

alter table tp3p1_ej2_referencia
	add constraint fk_tp3p1_ej2_referencia_tp3p1_ej2_servicio foreign key(IdServ)
	references tp3p1_ej2_servicio(IdServ)
		on update cascade
		on delete restrict
;

alter table tp3p1_ej2_referencia
	add constraint fk_tp3p1_ej2_referencia_tp3p1_ej2_cliente foreign key(Zona,NroC)
	references tp3p1_ej2_cliente(Zona,NroC)
		on update set null
		on delete restrict
;

insert into tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) values('A',1,'Juan Ro','C1');
insert into tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) values('A',2,'Alberto Efe','C1');
insert into tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) values('B',1,'Esteban Hache','C1');
insert into tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) values('C',2,'Jose Ge','C3');
insert into tp3p1_ej2_cliente(Zona,NroC,Nombre,Ciudad) values('D',3,'Luis Ene','C2');

insert into tp3p1_ej2_servicio(IdServ,NombreServ,AnioComienzo,AnioFin,CantInst) values('S1','Serv 1',2010,2012,2);
insert into tp3p1_ej2_servicio(IdServ,NombreServ,AnioComienzo,AnioFin,CantInst) values('S2','Serv 2',2012,2012,1);
insert into tp3p1_ej2_servicio(IdServ,NombreServ,AnioComienzo,AnioFin,CantInst) values('S3','Serv 3',2009,null,1);

insert into tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) values('A',1,'S1',5,2011,5,'T1');
insert into tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) values('B',1,'S2',5,2012,7,'T1');
insert into tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) values('C',2,'S1',4,2010,9,'T2');
insert into tp3p1_ej2_instalacion(Zona,Nroc,IdServ,Mes,Anio,CantHoras,Tarea) values('A',2,'S3',8,2009,6,'T2');

insert into tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) values('S1','Puntualidad','D',3);
insert into tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) values('S2','Calidad inst.','C',2);
insert into tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) values('S3','Costo','C',2);
insert into tp3p1_ej2_referencia(IdServ,Motivo,Zona,NroC) values('S1','Atención','D',3);

delete from tp3p1_ej2_instalacion as tpei;
delete from tp3p1_ej2_cliente as tpec;
delete from tp3p1_ej2_servicio as tpes;
delete from tp3p1_ej2_referencia as tper;

delete from tp3p1_ej2_cliente where NroC=1; 
--Borra las tuplas ('A',1,'Juan Ro','C1') y ('B',1,'Esteban Hache','C1') y por el cascade
--borra las tuplas ('A',1,'S1',5,2011,5,'T1') y ('B',1,'S2',5,2012,7,'T1')

update tp3p1_ej2_instalacion set IdServ='S5' where IdServ='S2';
--La operacion se puede realizar, pero no hay ningun registro que contenga 
--un IdServ=2 por lo tanto no modifica ningun registro de la tabla instalacion

update tp3p1_ej2_cliente set Zona='Z' where Zona='D';
--Modifica el registro de ('D',3,'Luis Ene','C2') por ('Z',3,'Luis Ene','C2') 



--EJERCICIO 3
--########################################################################

create table tp3p1_ej3_articulo (
	id_articulo int not null,
	titulo varchar(60) null,
	autor varchar(60) null,
	nacionalidad varchar(60) null,
	fecha_pub date null,
	constraint pk_tp3p1_ej3_articulo primary key(id_articulo)
);

create table tp3p1_ej3_contiene (
	id_articulo int not null,
	idioma varchar(60) not null,
	cod_palabra int not null,
	nro_seccion int null,
	constraint pk_tp3p1_ej3_contiene primary key(id_articulo,idioma,cod_palabra)
);

create table tp3p1_ej3_palabra (
	idioma varchar(60) not null,
	cod_palabra int not null,
	descripcion varchar(60) null,
	constraint pk_tp3p1_ej3_palabra primary key(idioma,cod_palabra)
);

alter table tp3p1_ej3_contiene
	add constraint fk_tp3p1_ej3_contiene_tp3p1_ej3_articulo foreign key(id_articulo)
	references tp3p1_ej3_articulo(id_articulo)
;

alter table tp3p1_ej3_contiene
	add constraint fk_tp3p1_ej3_contiene_tp3p1_ej3_palabra foreign key(idioma,cod_palabra)
	references tp3p1_ej3_palabra(idioma,cod_palabra)
;

select a.*,p.*
from tp3p1_ej3_articulo a
join tp3p1_ej3_contiene c on(a.id_articulo=c.id_articulo)
join tp3p1_ej3_palabra p on (c.idioma=p.idioma and c.cod_palabra=p.cod_palabra)

select *
from tp3p1_ej3_articulo

select *
from tp3p1_ej3_contiene

select *
from tp3p1_ej3_palabra

alter table tp3p1_ej3_articulo add constraint nacionalidades_validas
check (nacionalidad in ('Argentina','Español','Ingles','Aleman','Chilena'));

alter table tp3p1_ej3_articulo add constraint fechas_validas
check (not (extract(year from fecha_pub)=2017 and nacionalidad!='Argetina'));



--EJERCICIO 4
--########################################################################

create table tp3p1_ej4_producto (
	cod_producto int not null,
	presentacion varchar(60) null,
	descripcion varchar(60) null,
	tipo varchar(60) null,
	constraint pk_tp3p1_ej4_producto primary key(cod_producto)
);

create table tp3p1_ej4_sucursal (
	cod_suc varchar(60) not null,
	nombre varchar(60) null,
	localidad varchar(60) null,
	constraint pk_tp3p1_ej4_sucursal primary key(cod_suc)
);

create table tp3p1_ej4_proveedor (
	nro_prov int not null,
	nombre varchar(60) null,
	direccion varchar(60) null,
	localidad varchar(60) null,
	fecha_nac date null,
	constraint pk_tp3p1_ej4_proveedor primary key(nro_prov)
);

create table tp3p1_ej4_provee (
	cod_producto int not null,
	nro_prov int not null,
	cod_suc varchar(60) not null,
	constraint pk_tp3p1_ej4_provee primary key(cod_producto,nro_prov)
);

alter table tp3p1_ej4_provee
	add constraint fk_tp3p1_ej4_provee_tp3p1_ej4_producto foreign key(cod_producto)
	references tp3p1_ej4_producto(cod_producto)
;

alter table tp3p1_ej4_provee
	add constraint fk_tp3p1_ej4_provee_tp3p1_ej4_sucursal foreign key(cod_suc)
	references tp3p1_ej4_sucursal(cod_suc)
;

alter table tp3p1_ej4_provee
	add constraint fk_tp3p1_ej4_provee_tp3p1_ej4_proveedor foreign key(nro_prov)
	references tp3p1_ej4_proveedor(nro_prov)
;

alter table tp3p1_ej4_sucursal add constraint fromato_cod_suc
check (cod_suc like 'S_%');

alter table tp3p1_ej4_producto add constraint descripcion_o_pres_no_null
check (not (descripcion is null and presentacion is null));

insert into tp3p1_ej4_producto(cod_producto,descripcion) values (1,'xD');



--EJERCICIO 1
--########################################################################

create table tp5_ej1_articulo (
	id_articulo varchar(10) not null,
	descripcion varchar(30) not null,
	peso numeric(5,2) not null,
	ciudad varchar(30) not null,
	constraint pk_tp5_ej1_articulo primary key(id_articulo)
);

create table tp5_ej1_proveedor (
	id_proveedor varchar(10) not null,
	nombre varchar(30) not null,
	rubro varchar(15) not null,
	ciudad varchar(30) not null,
	constraint pk_tp5_ej1_proveedor primary key(id_proveedor)
);

create table tp5_ej1_envio (
	id_proveedor varchar(10) not null,
	id_articulo varchar(10) not null,
	cantidad numeric(5,0) not null,
	constraint pk_tp5_ej1_envio primary key(id_proveedor,id_articulo)
);

alter table tp5_ej1_envio
	add constraint fk_tp5_ej1_envio_tp5_ej1_articulo foreign key(id_articulo)
	references tp5_ej1_articulo(id_articulo)
;

alter table tp5_ej1_envio
	add constraint fk_tp5_ej1_envio_tp5_ej1_proveedor foreign key(id_proveedor)
	references tp5_ej1_proveedor(id_proveedor)
;

insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('1412u','Pepas marca vea',300,'Tandil');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('1412v','Leche entera marca vea',999.99,'Tandil');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('1412w','leche descremada marca vea',999.99,'Tandil');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('18249a','Atun natural marca carrefour',170,'Necochea');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('18249b','Atun aceite marca carrefour',300,'Necochea');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('18249c','Arbejas marca carrefour',475,'Necochea');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('24722a','Hamburguesas',190,'Tandil');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('A1','null',0,'null');
insert into tp5_ej1_articulo(id_articulo,descripcion,peso,ciudad) values ('A2','null',0,'null');


insert into tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) values ('18249','carrefour','cualquier cosa','Tandil');
insert into tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) values ('1412','vea','cualquier cosa','Rauch');
insert into tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) values ('19134','golopolis','golosinas','tandil');
insert into tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) values ('24722','charcuteria','carnes','tandil');
insert into tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) values ('95821','dana','niidea','tandil');
insert into tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) values ('P1','null','null','null');
insert into tp5_ej1_proveedor(id_proveedor,nombre,rubro,ciudad) values ('P2','null','null','null');


insert into tp5_ej1_envio(id_proveedor,id_articulo,cantidad) values ('95821','24722a',500);
insert into tp5_ej1_envio(id_proveedor,id_articulo,cantidad) values ('95821','18249a',999);
insert into tp5_ej1_envio(id_proveedor,id_articulo,cantidad) values ('95821','18249b',1048);
insert into tp5_ej1_envio(id_proveedor,id_articulo,cantidad) values ('95821','18249c',248);
insert into tp5_ej1_envio(id_proveedor,id_articulo,cantidad) values ('95821','1412u',1820);
insert into tp5_ej1_envio(id_proveedor,id_articulo,cantidad) values ('P1','A1',666);
insert into tp5_ej1_envio(id_proveedor,id_articulo,cantidad) values ('P1','A2',820);



select *
from tp5_ej1_articulo;

select *
from tp5_ej1_proveedor;

select *
from tp5_ej1_envio;

--esta vista es actualizable, ya que no se utilizan
--ni funciones de agregacion o select en el from
create view tp5_ej1_envios500 as
	select *
	from tp5_ej1_envio
	where cantidad >= 500;
;

--esta vista es actualizable, ya que no se utilizan
--ni funciones de agregacion o select en el from
create view "tp5_ej1_envios500-999" as
	select *
	from tp5_ej1_envios500
	where cantidad <=999	
;

--esta vista es actualizable, ya que no se utilizan
--ni funciones de agregacion o select en el from
create view tp5_ej1_productos_mas_pedidos as
	select *
	from tp5_ej1_articulo
	where id_articulo in (	select id_articulo
							from tp5_ej1_envios500)
;

--esta vista no es actualizable debido al uso de una
--funcion de agregacion (el sum)
create view tp5_ej1_envios_prov as
	select id_proveedor,sum(cantidad)
	from tp5_ej1_envio
	group by id_proveedor
;

select *
from tp5_ej1_envios500

select *
from "tp5_ej1_envios500-999"

select *
from tp5_ej1_envios_prov

drop view tp5_ej1_envios500 cascade;

create view tp5_ej1_envios500 as
	select *
	from tp5_ej1_envio
	where cantidad >= 500
	with check option
;

--c.1)
--con o sin check option se inserta el valor 
insert into tp5_ej1_envios500 values ('P1', 'A1', 500);

delete from tp5_ej1_envio where id_proveedor='P1' and id_articulo='A1';

--c.2)
--sin check option se inserta el valor, pero con el check option no
insert into tp5_ej1_envios500 values ('P2', 'A2', 300);

delete from tp5_ej1_envio where id_proveedor='P2' and id_articulo='A2';

--c.3)
--con o sin check option se inserta el valor 
update tp5_ej1_envios500 set cantidad=1000 where id_proveedor='P1';

--c.4)
--sin check option se inserta el valor, pero con el check option no
update tp5_ej1_envios500 set cantidad=100 where id_proveedor='P1';

update tp5_ej1_envio set cantidad=666 where id_proveedor='P1' and id_articulo='A1';
update tp5_ej1_envio set cantidad=820 where id_proveedor='P1' and id_articulo='A2';


--EJERCICIO 2
--########################################################################


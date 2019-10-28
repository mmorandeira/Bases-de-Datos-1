-- tables
-- Table: mesa
CREATE TABLE mesa (
    nro_mesa integer  NOT NULL,
    codigo varchar(10)  NOT NULL,
    capacidad integer  NOT NULL,
    CONSTRAINT pk_mesa PRIMARY KEY (nro_mesa,codigo)
);

-- Table: reserva
CREATE TABLE reserva (
    nro_reserva integer  NOT NULL,
    fecha date  NOT NULL,
    hora time  NOT NULL,
    cant_personas integer  NOT NULL,
    nro_mesa integer  NOT NULL,
    codigo varchar(10)  NOT NULL,
    e_mail varchar(200)  NOT NULL,
    CONSTRAINT pk_reserva PRIMARY KEY (nro_reserva)
);

-- Table: restaurant
CREATE TABLE restaurant (
    codigo varchar(10)  NOT NULL,
    nombre varchar(80)  NOT NULL,
    direccion varchar(250)  NOT NULL,
    ciudad varchar(80)  NOT NULL,
    CONSTRAINT pk_restaurant PRIMARY KEY (codigo)
);

-- Table: usuario
CREATE TABLE usuario (
    e_mail varchar(200)  NOT NULL,
    apellido_nombre varchar(200)  NOT NULL,
    ciudad varchar(80)  NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (e_mail)
);

-- foreign keys
-- Reference: fk_mesa_restaurant (table: mesa)
ALTER TABLE mesa ADD CONSTRAINT fk_mesa_restaurant
    FOREIGN KEY (codigo)
    REFERENCES restaurant (codigo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: fk_reserva_mesa (table: reserva)
ALTER TABLE reserva ADD CONSTRAINT fk_reserva_mesa
    FOREIGN KEY (nro_mesa, codigo)
    REFERENCES mesa (nro_mesa, codigo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: fk_reserva_usuario (table: reserva)
ALTER TABLE reserva ADD CONSTRAINT fk_reserva_usuario
    FOREIGN KEY (e_mail)
    REFERENCES usuario (e_mail)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.
alter table mesa add constraint cant_max_mesas
check(not exists   (select 1
					from mesa
					group by codigo
					having count(nro_mesa)>20))


					
--EJERCICIO 3
--########################################################################				
SELECT 1
FROM restaurant NATURAL JOIN mesa
WHERE capacidad > 7 and upper(direccion) like 'AVENIDA%';

  codigo varchar(10)  NOT NULL,
    nombre varchar(80)  NOT NULL,
    direccion varchar(250)  NOT NULL,
    ciudad varchar(80)  NOT NULL,
    CONSTRAINT pk_restaurant PRIMA

insert into restaurant values('R1','MANOLO','avenida,','tandil');
insert into restaurant values('R2','MANOLO2','AVENIDA','tandil');

insert into restaurant values('R3','MANOLO3','AVENIDA','tandil');


 nro_mesa integer  NOT NULL,
    codigo varchar(10)  NOT NULL,
    capacidad integer  NOT NULL,

update mesa set capacidad=8 where nro_mesa=1; 

insert into restaurant values ()

insert into mesa values (1,'R3',6);
insert into mesa values (2,'R3',6);
insert into mesa values (3,'R3',6);
insert into mesa values (4,'R3',6);
insert into mesa values (5,'R3',6);
insert into mesa values (6,'R3',6);
insert into mesa values (7,'R3',6);
insert into mesa values (8,'R3',6);
insert into mesa values (9,'R3',6);
insert into mesa values (11,'R3',6);
insert into mesa values (12,'R3',6);
insert into mesa values (13,'R3',6);
insert into mesa values (14,'R3',6);
insert into mesa values (10,'R3',6);
insert into mesa values (15,'R3',6);
insert into mesa values (16,'R3',6);
insert into mesa values (17,'R3',6);
insert into mesa values (18,'R3',6);
insert into mesa values (19,'R3',6);
insert into mesa values (20,'R3',6);
insert into mesa values (21,'R3',6);
insert into mesa values (22,'R3',6);
insert into mesa values (23,'R3',6);
insert into mesa values (24,'R3',6);
insert into mesa values (25,'R3',6);
insert into mesa values (26,'R3',6);
insert into mesa values (27,'R3',6);
insert into mesa values (28,'R3',6);
insert into mesa values (29,'R3',6);
insert into mesa values (30,'R3',6);

insert into mesa values (31,'R3',3);

insert into mesa values (1,'R1',7);
insert into mesa values (2,'R1',7);
insert into mesa values (3,'R1',7);
insert into mesa values (4,'R1',7);
insert into mesa values (5,'R1',7);
insert into mesa values (6,'R1',7);
insert into mesa values (7,'R1',7);
insert into mesa values (8,'R1',7);
insert into mesa values (9,'R1',7);
insert into mesa values (10,'R1',7);
insert into mesa values (11,'R1',7);
insert into mesa values (12,'R1',7);
insert into mesa values (13,'R1',7);
insert into mesa values (14,'R1',7);
insert into mesa values (15,'R1',7);
insert into mesa values (16,'R1',7);
insert into mesa values (17,'R1',7);
insert into mesa values (18,'R1',7);
insert into mesa values (19,'R1',7);
insert into mesa values (20,'R1',7);
insert into mesa values (21,'R1',7);
insert into mesa values (22,'R1',7);
insert into mesa values (23,'R1',7);
insert into mesa values (24,'R1',7);
insert into mesa values (25,'R1',7);
insert into mesa values (26,'R1',7);
insert into mesa values (27,'R1',7);
insert into mesa values (28,'R1',7);
insert into mesa values (29,'R1',7);
insert into mesa values (30,'R1',7);
insert into mesa values (31,'R1',7);


insert into mesa values (6,'R2',8);

insert into mesa values (7,'R2',7);

insert into mesa values (8,'R2',7);

delete from mesa where nro_mesa=5;



select *
from mesa;

select *
from restaurant;

select 1
from mesa
group by codigo
having count(nro_mesa)>30


----EJERCICIO 4
--########################################################################

--CREATE ASSERTION ASS_1
--CHECK (NOT EXISTS ( SELECT 1
--					FROM restaurant NATURAL JOIN mesa
--					WHERE capacidad > 7 and upper(direccion) like 'AVENIDA%';

create or replace function check_max_mesas_avenida_insert()
returns trigger as
$$
declare
begin
	if exists (select 1
				from restaurant
				where codigo=new.codigo and upper(direccion) like 'AVENIDA%') then
		if(new.capacidad>=7) then
			raise exception 'Capacidad maxima de restaurante en avenida superada';
		end if;
	end if;
	return new;
end;
$$
language 'plpgsql';

create trigger check_max_mesas_avenida_insert
before insert on mesa
for each row
execute procedure check_max_mesas_avenida_insert();

create trigger check_max_mesas_avenida_update
before update on mesa
for each row
execute procedure check_max_mesas_avenida_update();

select count(nro_mesa)
from mesa
group by codigo

--EJERCICIO 5
--########################################################################

--Indique la sentencia SQL de creación un una vista ACTUALIZABLE en Posgresql que permita obtener
--el apellido_nombre y e_mail de lo/s usuario/s que no han realizado reservas para menos de 3 personas.
--Explique brevemente por qué es actualizable

insert into usuario values ('a','null','null');
insert into usuario values ('b','null','null');
insert into usuario values ('c','null','null');
insert into usuario values ('d','null','null');



  nro_reserva integer  NOT NULL,
    fecha date  NOT NULL,
    hora time  NOT NULL,
    cant_personas integer  NOT NULL,
    nro_mesa integer  NOT NULL,
    codigo varchar(10)  NOT NULL,
    e_mail varchar(200)  NOT NULL,

insert into reserva values(1,current_date,current_time,1,1,'R1','a');
insert into reserva values(2,current_date,current_time,1,2,'R1','a');
insert into reserva values(3,current_date,current_time,1,2,'R1','a');
insert into reserva values(4,current_date,current_time,2,1,'R1','a');
insert into reserva values(5,current_date,current_time,3,1,'R1','a');
insert into reserva values(10,current_date,current_time,4,1,'R1','b');
insert into reserva values(11,current_date,current_time,5,1,'R1','b');
insert into reserva values(12,current_date,current_time,6,1,'R1','b');

select *
from reserva;

drop view usuario_todas_reservas_mas_de_3

create view usuario_todas_reservas_mas_de_3 as
	select u.*
	from usuario u
	where exists(	select 1
					from reserva r
					where r.e_mail=u.e_mail 
					group by e_mail
					having min(cant_personas)>=3)
;

select e_mail,apellido_nombre,ciudad
from usuario u
where exists(	select 1
				from reserva r
				where r.e_mail=u.e_mail 
				group by e_mail
				having min(cant_personas)>=3)


select *
from usuario_todas_reservas_mas_de_3




create or replace function check_capacidad_max_mesas_avenida_insert()
returns trigger as
$$
declare
begin
    if exists (select 1
               from restaurant
               where codigo=new.codigo and upper(direccion) like 'AVENIDA%') then
        if(new.capacidad>=7) then
	    raise exception 'No se admiten mesas de mas de 6 personas para restaurantes situados en avenidas';
	end if;
    end if;
    return new;
end;
$$
language 'plpgsql';

create trigger check_capacidad_max_mesas_avenida_insert
before insert on mesa
for each row
execute procedure check_capacidad_max_mesas_avenida_insert();

create trigger check_capacidad_max_mesas_avenida_update
before update on mesa
for each row
execute procedure check_capacidad_max_mesas_avenida_update();




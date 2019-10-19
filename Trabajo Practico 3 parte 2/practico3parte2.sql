--EJERCICIO 1
--########################################################################



--EJERCICIO 2
--########################################################################

--CREACION DE LA TABLA HIS_ENTREGA
create table pelicula_his_entrega (
	nro_registro serial not null,
	fecha date not null,
	operacion varchar(10) not null,
	cant_reg_afectados int not null,
	usuario varchar(40) not null
);

create or replace function updateLog() returns trigger as
$$
declare
	cant integer;
begin
	select count(*) into cant
	from new_table;
	insert into pelicula_his_entrega(fecha,operacion,cant_reg_afectados,usuario) values (current_date,TG_OP,cant,current_user);
	return null;
end
$$
language 'plpgsql';

create trigger tr_updateLog1
after insert
on pelicula_entrega
REFERENCING NEW TABLE AS new_table
	for each statement execute procedure updateLog();
	
create trigger tr_updateLog2
after update
on pelicula_entrega
REFERENCING NEW TABLE AS new_table
	for each statement execute procedure updateLog();
	
create trigger tr_updateLog3
after delete
on pelicula_entrega
REFERENCING OLD TABLE AS new_table
	for each statement execute procedure updateLog();
	
create trigger tr_updateLog4
after insert
on pelicula_renglon_entrega
REFERENCING NEW TABLE AS new_table
	for each statement execute procedure updateLog();
	
create trigger tr_updateLog5
after update
on pelicula_renglon_entrega
REFERENCING NEW TABLE AS new_table
	for each statement execute procedure updateLog();
	
create trigger tr_updateLog6
after delete
on pelicula_renglon_entrega
REFERENCING OLD TABLE AS new_table
	for each statement execute procedure updateLog();
	
select *
from pelicula_entrega
where nro_entrega=585

--borro el registro (585,2006-09-06,6469,869)
delete from pelicula_entrega where nro_entrega=585

select *
from pelicula_his_entrega

--EJERCICIO 3
--########################################################################

create table tp3p2_ej3_empleado_1 (
	id_empleado int not null,
	nombre varchar(30) null,
	apellido varchar(30) null,
	sueldo int not null,
	constraint pk_tp3p2_ej3_empleado_1 primary key(id_empleado)
)

insert into tp3p2_ej3_empleado_1(id_empleado,sueldo) values (100,500);

create table tp3p2_ej3_empleado_2 (
	id_empleado int not null,
	nombre varchar(30) null,
	apellido varchar(30) null,
	sueldo int not null,
	constraint pk_tp3p2_ej3_empleado_2 primary key(id_empleado)
);

insert into tp3p2_ej3_empleado_2(id_empleado,sueldo) values (2,700),(3,300),(4,700);

select *
from tp3p2_ej3_empleado_1

select *
from tp3p2_ej3_empleado_2

create or replace function autoIncremento()
returns trigger as 
$$
begin
	update tp3p2_ej3_empleado_1 set
		sueldo=sueldo-(select min(sueldo)*0.05 from tp3p2_ej3_empleado_1)
	;
	return new;
end
$$
language 'plpgsql';

create trigger trigger_autoincremento
before insert on tp3p2_ej3_empleado_1
for each row
execute procedure autoIncremento()

insert into tp3p2_ej3_empleado_1
select * from tp3p2_ej3_empleado_2

delete from tp3p2_ej3_empleado_1 where id_empleado!=100

update tp3p2_ej3_empleado_1 set sueldo=500 where id_empleado=100


--EJERCICIO 4
--########################################################################

create table pelicula_historico (
	id_empleado numeric(6,0) not null,
	id_distribuidor numeric(5,0) not null,
	id_departamento numeric(4,0) not null,
	fecha_inicio timestamp not null,
	fecha_fin timestamp null,
	constraint pk_pelicula_historico primary key(id_empleado,id_departamento,id_distribuidor,fecha_inicio)
);

alter table pelicula_historico
	add constraint fk_pelicula_historico_pelicula_empleado foreign key(id_empleado)
	references pelicula_empleado(id_empleado)
;

alter table pelicula_historico
	add constraint fk_pelicula_historico_pelicula_departamento foreign key(id_departamento,id_distribuidor)
	references pelicula_departamento(id_departamento,id_distribuidor)
;

create table pelicula_historico_empleado (
	id_empleado numeric(6,0) not null,
	id_distribuidor numeric(5,0) not null,
	id_departamento numeric(4,0) not null,
	promedio real not null,--numeric(a,b) a cantidad de digitos totales, b parte decimal de digitos
	constraint pk_pelicula_historico_empleado primary key(id_empleado,id_departamento,id_distribuidor)
);

alter table pelicula_historico_empleado
	add constraint fk_pelicula_historico_empleado_pelicula_empleado foreign key(id_empleado)
	references pelicula_empleado(id_empleado)
;

alter table pelicula_historico_empleado
	add constraint fk_pelicula_historico_empleado_pelicula_departamento foreign key(id_departamento,id_distribuidor)
	references pelicula_departamento(id_departamento,id_distribuidor)
;

--AGREGAR TEMA DE HORAS TOTALES DEL SISTEMA
alter table pelicula_empleado
add column horas_totales real;

--el tema de las horas totales es muy mala. yo en ves de agregar
--las horas agregaria la fecha de inicio del sistema, y que se calcule
--la horas que estuve haciendo una cuenta de fecha aactual-fecha de ingreso
--porque esta hora no va estar nunca actualizada, a no se que se llame a un
--stored procedure

--agrego el valor por defecto
alter table pelicula_empleado
alter column horas_totales set default 0;

--updateo todos los registro con el valor por defecto
update pelicula_empleado 
set horas_totales=default;

--agrego la restriccion de not null
alter table pelicula_empleado
alter column horas_totales set not null;

--agrego la columna fecha_inicio
alter table pelicula_empleado
add column fecha_inicio timestamp;

--agrego el valor por defecto de la columna como "ahora"
alter table pelicula_empleado 
alter column fecha_inicio set default current_timestamp;

--seteo todos los valores de fecha_incio a "ahora"
update pelicula_empleado 
set fecha_inicio=default;

select *
from pelicula_empleado as pe;

--agrego la restriccion que no puede ser null
alter table pelicula_empleado
alter column fecha_inicio set not null;

create or replace function pelicula_logger()
returns trigger as 
$$
declare 
	prom real;
begin
	--agrego al historico el cambio de departamento
	insert into pelicula_historico(id_empleado,id_distribuidor,id_departamento,fecha_inicio,fecha_fin) 
	values(old.id_empleado,old.id_distribuidor,old.id_departamento,old.fecha_inicio,new.fecha_inicio); 
	--comprobar si existe el anterior	
	if exists(	select 1
				from pelicula_historico_empleado as phe
				where 	phe.id_empleado=old.id_empleado and
						phe.id_departamento=old.id_departamento and 
						phe.id_distribuidor=old.id_distribuidor) then
		--como ya existe, tengo que recalcular el promedio
		select avg(dif) into prom 
		from
		(	select (extract( epoch from fecha_fin-fecha_inicio)/3600.0) as "dif"
			from pelicula_historico ph2
			where (ph2.id_empleado=old.id_empleado and ph2.id_distribuidor=old.id_distribuidor and ph2.id_departamento=old.id_departamento)) t1;
		
		update pelicula_historico_empleado set promedio=prom 
		where id_empleado=old.id_empleado and id_distribuidor=old.id_distribuidor and id_departamento=old.id_departamento;
	else
		insert into pelicula_historico_empleado(id_empleado,id_distribuidor,id_departamento,promedio) 
		values (old.id_empleado,old.id_distribuidor,old.id_departamento,extract(epoch from new.fecha_inicio-old.fecha_inicio)/3600.0);
	end if;
	return new;
	
end
$$
language 'plpgsql';

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

--agregar trigger before modificando la fecha:_inicioo
--y utilizarla en el trigger after

create or replace function pelicula_logger_before()
returns trigger as
$$
begin
	new.fecha_inicio:=current_timestamp;
	return new;
end
$$
language 'plpgsql';

create trigger pelicula_logger_before
before update of id_departamento,id_distribuidor on pelicula_empleado
for each row
execute procedure pelicula_logger_before();


--stored procedure que agrega los datos preexistentes, si los hubiera,
--en la tabla pelicula_historico_empleado
create or replace procedure update_historico_empleado()
language 'plpgsql'
as $$
declare
	var record;--un registro, esto esta op toma los valores segun lo que le mandes
	fechahoy timestamp;
begin
	fechahoy:=current_timestamp;
	for var in (
		select id_empleado,id_departamento,id_distribuidor,avg((extract( epoch from fecha_fin-fecha_inicio)/3600.0)) as "horas"
		from pelicula_historico as ph
		group by id_empleado,id_departamento,id_distribuidor)
	loop
		insert into pelicula_historico_empleado(id_empleado,id_distribuidor,id_departamento,promedio) 
		values (var.id_empleado,var.id_distribuidor,var.id_departamento,var.horas);
	end loop;
	for var in (
		select id_empleado,min(fecha_inicio) as "fecha_entrada"
		from pelicula_historico as ph
		group by id_empleado
	)
	loop
		update pelicula_empleado emp set horas_totales=(extract( epoch from fechahoy-var.fecha_entrada)/3600.0)
		where emp.id_empleado=var.id_empleado;
	end loop;
end;
$$;

create or replace procedure update_horas_empleado()
language 'plpgsql'
as
$$
declare
	var record;
	fechahoy timestamp;
begin
	fechahoy:=current_timestamp;
	for var in (
		select id_empleado,min(fecha_inicio) as "fecha_entrada"
		from pelicula_historico as ph
		group by id_empleado
	)
	loop
		update pelicula_empleado emp set horas_totales=(extract( epoch from fechahoy-var.fecha_entrada)/3600.0)
		where emp.id_empleado=var.id_empleado;
	end loop;
end;
$$;


select id_empleado,id_departamento,id_distribuidor,avg((extract( epoch from fecha_fin-fecha_inicio)/3600.0))
from pelicula_historico as ph
group by id_empleado,id_departamento,id_distribuidor

create trigger trigger_pelicula_logger
after update of id_departamento,id_distribuidor on pelicula_empleado
for each row
execute procedure pelicula_logger();

drop trigger trigger_pelicula_logger on pelicula_empleado;

drop function pelicula_logger();

--modifico el valor de 	(7104,Juan C.,De,null,3489.00,De@gmail.com,1983-06-08,738-5664,5157,58,242,8357,2019-10-09 13:25:50,0)
--por 					(7104,Juan C.,De,null,3489.00,De@gmail.com,1983-06-08,738-5664,5157,75,219,8357,2019-10-09 13:25:50,0)
--INSERT INTO pelicula_empleado (id_empleado,nombre,apellido,porc_comision,sueldo,e_mail,fecha_nacimiento,telefono,id_tarea,id_departamento,id_distribuidor,id_jefe,fecha_inicio,horas_totales) VALUES 
--(7104,'Juan C.','De ',NULL,3489.00,'De@gmail.com','1983-06-08','738-5664','5157',58,242,8357,'2019-10-09 13:25:50.936',0)
--;
update pelicula_empleado set id_departamento=75,id_distribuidor=219 where id_empleado=7104;

update pelicula_empleado set id_departamento=95,id_distribuidor=977 where id_empleado=7104;

select *
from pelicula_departamento as pd

select id_departamento,id_distribuidor,fecha_inicio,horas_totales
from pelicula_empleado as pe
where id_empleado=7104;

select *
from pelicula_historico as ph;

select *
from pelicula_historico_empleado as phe;

delete from pelicula_historico;

delete from pelicula_historico_empleado;

call update_historico_empleado();--llamo al stored procedure para "añadir los datos preexistentes"

call update_horas_empleado();


--EJERCICIO 5
--########################################################################

create or replace function set_horas_aportadas()
returns trigger as
$$
begin
	new.horas_aportadas:=0;
	return new;
end
$$
language 'plpgsql';

create trigger set_horas_cero
before update of id_tarea on voluntario_voluntario
for each row
execute procedure set_horas_aportadas();

create or replace function check_horas_aportadas()
returns trigger as
$$
begin
	if(new.horas_aportadas not between old.horas_aportadas*0.9 and old.horas_aportadas*1.1) then
		raise exception 'Las horas aportadas no son validas';
	end if;
	return new;
end;
$$
language 'plpgsql';

create trigger check_horas_aportadas
before update of horas_aportadas on voluntario_voluntario
for each row
execute procedure check_horas_aportadas();

--Modifico la constraint de horas aportadas >0 ya que sino no me deja probarlo
alter table unc_248557.voluntario_voluntario drop constraint voluntario_chk_hs_ap;

ALTER TABLE unc_248557.voluntario_voluntario ADD CONSTRAINT voluntario_chk_hs_ap CHECK ((horas_aportadas >= (0)::numeric))

select *
from voluntario_voluntario

--134 tiene 2900
update voluntario_voluntario set horas_aportadas=3100 where nro_voluntario=134;


--EJERCICIO 6
--########################################################################


create table tp3p1_ej3_textosporautor (
	autor varchar(60) not null,
	cant_textos numeric(4,0) not null,
	fecha_ultima_public date not null,
	constraint pk_tp3p1_ej3_textosporautor primary key(autor)
);

create or replace procedure update_textosporautor()
language 'plpgsql'
as
$$
declare
--	 var record;
begin
--	for var in (
--		select autor,count(*) as "cant_textos",max(fecha_pub) as "ultima"
--		from tp3p1_ej3_articulo
--		group by autor
--		having autor is not null)
--	loop
--		insert into tp3p1_ej3_textosporautor(autor,cant_textos,fecha_ultima_public) values (var.autor,var.cant_textos,var.ultima);
--		raise notice 'xD';
--	end loop;

	insert into tp3p1_ej3_textosporautor(autor,cant_textos,fecha_ultima_public)
	select autor,count(*) as "cant_textos",max(fecha_pub) as "fecha_ultima_public"
	from tp3p1_ej3_articulo
	group by autor
	having autor is not null;
end;
$$;

select autor,count(*),max(fecha_pub)
from tp3p1_ej3_articulo
group by autor
having autor is not null

select *
from tp3p1_ej3_articulo
--where id_articulo=9;

update tp3p1_ej3_articulo set autor='Horacio Raul Casado', fecha_pub=to_date('2019-10-20','YYYY-MM-DD'),titulo='Ser otako en 10 pasos' where id_articulo=2;

update tp3p1_ej3_articulo set autor='Dana Mariel Alvarez y Martinez',fecha_pub=current_date,titulo='niidea' where id_articulo=9;
update tp3p1_ej3_articulo set autor='Juan Eliel Vivian',fecha_pub=to_date('2019-10-25','YYYY-MM-DD'),titulo='Como hacer 50 cosas en un dia' where id_articulo=8;
update tp3p1_ej3_articulo set autor='Thomas Agustin Ojeda',fecha_pub=to_date('2018-3-20','YYYY-MM-DD'),titulo='Como debugear mentalmente' where id_articulo=7;
update tp3p1_ej3_articulo set autor='Matias Morandeira',fecha_pub=to_date('2014-4-20','YYYY-MM-DD'),titulo='Aprender a que te caguen con las notas' where id_articulo=6;
update tp3p1_ej3_articulo set autor='Juan Pablo Correa',fecha_pub=to_date('2019-1-3','YYYY-MM-DD'),titulo='Como jugar al voley' where id_articulo=5;
update tp3p1_ej3_articulo set autor='Marcos Alejandro Lazarte',fecha_pub=to_date('2010-11-23','YYYY-MM-DD'),titulo='Aprendiendo a hablar' where id_articulo=4;
update tp3p1_ej3_articulo set autor='Exequiel Herrera de Rosa',fecha_pub=to_date('2019-05-22','YYYY-MM-DD'),titulo='Como tener todos los practicos al dia' where id_articulo=3;
update tp3p1_ej3_articulo set autor='Santiago Coria',fecha_pub=to_date('2017-7-13','YYYY-MM-DD'),titulo='El rey topo' where id_articulo=1;


call update_textosporautor();

select *
from tp3p1_ej3_textosporautor

delete from tp3p1_ej3_textosporautor;



create or replace procedure update_single_row_textosporautor_insert(_autor varchar(60),_fecha date)
language 'plpgsql'
as
$$
declare 
	_fecha_max date;
begin
	if exists(select 1
				from tp3p1_ej3_textosporautor as t
				where t.autor=_autor) then
		select fecha_ultima_public into _fecha_max
		from tp3p1_ej3_textosporautor t
		where t.autor=_autor;
		if(_fecha_max<_fecha) then
			update tp3p1_ej3_textosporautor t set cant_textos=cant_textos+1,fecha_ultima_public=_fecha where t.autor=_autor;
		else
			update tp3p1_ej3_textosporautor t set cant_textos=cant_textos+1 where t.autor=_autor;
		end if;
	else
		insert into tp3p1_ej3_textosporautor(autor,cant_textos,fecha_ultima_public) values (_autor,1,_fecha);
	end if;
end;
$$;

create or replace function update_textosporautor_insert()
returns trigger as
$$
declare
begin
	call update_single_row_textosporautor_insert(new.autor,new.fecha_pub);
	return new;
end;
$$
language 'plpgsql';

create trigger update_textosporautor_insert
after insert on tp3p1_ej3_articulo
for each row
execute procedure update_textosporautor_insert();

insert into tp3p1_ej3_articulo(id_articulo,titulo,autor,nacionalidad,fecha_pub) values(10,'Como ser forro','Horacio Raul Casado','Argentina',to_date('2019-12-25','YYYY-MM-DD'));

delete from tp3p1_ej3_articulo where id_articulo = 10;

create or replace procedure update_single_row_textosporautor_delete(_autor varchar(60),_fecha date)
language 'plpgsql'
as
$$
declare
	_var record;
	_aux date;
begin
	raise notice 'despues de %',_autor;
	select t.* into _var
	from tp3p1_ej3_textosporautor as t
	where t.autor=_autor;
	if(_var.cant_textos=1) then
		delete from tp3p1_ej3_textosporautor where autor=_autor;
	else
		
		select max(fecha_pub) into _aux
		from tp3p1_ej3_articulo a
		where a.autor=_autor
		group by a.autor;
		if(_var.fecha_ultima_public=_fecha) then
			update tp3p1_ej3_textosporautor set cant_textos=cant_textos-1,fecha_ultima_public=_aux where autor=_autor;
		else
			update tp3p1_ej3_textosporautor set cant_textos=cant_textos-1 where autor=_autor;
		end if;
	end if;
end;
$$;


create or replace function update_textosporautor_update()
returns trigger as
$$
declare 
	_var record;
	_aux date;
begin
	if(old.autor!=new.autor) then
		call update_single_row_textosporautor_insert(new.autor,new.fecha_pub);
		call update_single_row_textosporautor_delete(old.autor,old.fecha_pub);
	else
		if(old.fecha_pub!=new.fecha_pub) then
			select t.* into _var
			from tp3p1_ej3_textosporautor
			where t.autor=old.autor;
			if(new.fecha_pub>_var.fecha_ultima_public) then
				update tp3p1_ej3_textosporautor set fecha_ultima_public=new.fecha_pub where autor=old.autor;
			end if;
		end if;
	end if;
	return new;
end;
$$
language 'plpgsql';

create trigger update_textosporautor_update
after update of autor,fecha_pub on tp3p1_ej3_articulo
for each row
execute procedure update_textosporautor_update();

update tp3p1_ej3_articulo set autor='Dana Mariel Alvarez y Martinez' where id_articulo=9;

create or replace function update_textosporautor_delete()
returns trigger as
$$
begin
	call update_single_row_textosporautor_delete(old.autor,old.fecha_pub);
	return new;
end;
$$
language 'plpgsql';

create trigger update_textosporautor_delete
after delete on tp3p1_ej3_articulo
for each row
execute procedure update_textosporautor_delete();

delete from tp3p1_ej3_articulo where id_articulo=9;


select *
from tp3p1_ej3_articulo

select *
from tp3p1_ej3_textosporautor



select distinct d.*
from institucion i
join historico h on (i.id_institucion = h.id_institucion)
join direccion d on (i.id_direccion = d.id_direccion)
where id_director is not null and exists (	select
											from voluntario vin
											where vin.id_institucion!=i.id_institucion and vin.id_tarea = h.id_tarea)
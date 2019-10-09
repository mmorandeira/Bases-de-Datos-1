select distinct t.*
from tarea t
join voluntario v on (t.id_tarea = v.id_tarea)
join institucion i on (v.id_institucion = i.id_institucion)
join direccion d on (d.id_direccion = i.id_direccion)
join pais p on (p.id_pais = d.id_pais)
where (p.nombre_pais = 'Reino Unido')

CREATE TABLE name (
    pk_name pk_type
    CONSTRAINT PK_name PRIMARY KEY(pk_name)
);
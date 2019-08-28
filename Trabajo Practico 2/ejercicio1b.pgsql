SELECT distinct nro_voluntario, id_tarea, id_institucion
FROM historico
order by nro_voluntario

--SELECT distinct h.nro_voluntario, v.nombre, v.apellido, h.id_tarea, h.id_institucion
--FROM historico h, voluntario v
--WHERE h.nro_voluntario = v.nro_voluntario
--ORDER BY nro_voluntario
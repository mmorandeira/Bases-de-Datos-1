--SELECT h.nro_voluntario, v.nombre, v.apellido, count(h.id_tarea)
--FROM unc_esq_voluntario.historico h,unc_esq_voluntario.voluntario v
--WHERE h.nro_voluntario = v.nro_voluntario
--GROUP BY h.nro_voluntario,v.nombre,v.apellido
SELECT h.nro_voluntario, v.nombre, v.apellido, COUNT(h.id_tarea)
FROM unc_esq_voluntario.historico h JOIN unc_esq_voluntario.voluntario v ON (h.nro_voluntario = v.nro_voluntario)
GROUP BY h.nro_voluntario, v.nombre, v.apellido

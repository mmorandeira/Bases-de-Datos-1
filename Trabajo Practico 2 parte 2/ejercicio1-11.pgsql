SELECT DISTINCT i.nombre_institucion, i.id_institucion
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (v.id_institucion = i.id_institucion)
JOIN unc_esq_voluntario.tarea t ON (v.id_tarea = t.id_tarea)
WHERE (t.max_horas <= 3500) OR (v.horas_aportadas < 4000)
GROUP BY i.id_institucion, i.nombre_institucion
HAVING COUNT(*) > 4
--(SELECT id_tarea
--FROM unc_esq_voluntario.tarea t
--WHERE (t.max_horas < 3500))
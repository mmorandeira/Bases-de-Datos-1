SELECT i.nombre_institucion, id_institucion, d.*
FROM unc_esq_voluntario.institucion i 
JOIN unc_esq_voluntario.direccion d ON (i.id_direccion = d.id_direccion)
WHERE i.id_institucion NOT IN (SELECT v.id_institucion
        FROM unc_esq_voluntario.voluntario v 
        JOIN unc_esq_voluntario.tarea t ON (v.id_tarea = t.id_tarea)
        WHERE v.horas_aportadas >= t.max_horas)
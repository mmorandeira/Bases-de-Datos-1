SELECT t.nombre_tarea, t.id_tarea, t.max_horas
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (i.id_institucion = v.id_institucion)
JOIN unc_esq_voluntario.direccion d ON (i.id_direccion = d.id_direccion)
JOIN unc_esq_voluntario.tarea t ON (v.id_tarea = t.id_tarea)
WHERE   (d.ciudad = 'Munich') AND
        (v.id_tarea IN (  SELECT v.id_tarea
                                FROM unc_esq_voluntario.voluntario v
                                GROUP BY v.id_tarea
                                HAVING COUNT(v.id_tarea)=1))
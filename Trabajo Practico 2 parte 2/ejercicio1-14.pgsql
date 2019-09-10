SELECT i.id_institucion, i.nombre_institucion,COUNT(DISTINCT v.id_tarea)
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (i.id_institucion = v.id_institucion)
GROUP BY i.id_institucion, i.nombre_institucion
HAVING COUNT(DISTINCT v.id_tarea ) > (0.2*( SELECT COUNT(*)
                                            FROM unc_esq_voluntario.tarea t))
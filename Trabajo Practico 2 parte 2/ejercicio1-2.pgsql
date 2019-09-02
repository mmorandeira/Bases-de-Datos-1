SELECT v.nombre, v.apellido, v.e_mail, v.telefono
FROM unc_esq_voluntario.voluntario v JOIN unc_esq_voluntario.tarea t on (v.id_tarea = t.id_tarea)
JOIN unc_esq_voluntario.historico h ON (h.id_tarea = v.id_tarea)
WHERE (t.max_horas-t.min_horas <= 5000) AND (h.fecha_fin < TO_DATE('24/07/1998','DD/MM/YYYY'))
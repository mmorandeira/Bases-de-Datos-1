SELECT d.id_departamento, d.id_distribuidor, d.nombre, COUNT(e.id_empleado)
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.tarea t ON (e.id_tarea = t.id_tarea)
JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento AND e.id_distribuidor = d.id_distribuidor)
WHERE t.sueldo_minimo < 6000
GROUP BY d.id_departamento, d.id_distribuidor
HAVING COUNT(e.id_empleado) > 3
ORDER BY d.id_departamento, d.id_distribuidor
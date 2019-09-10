SELECT e.apellido || ', ' || e.nombre AS "Empleado", e.id_empleado AS "ID Empleado", j.apellido || ', ' || j.nombre AS "Jefe" 
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.empleado j ON (e.id_jefe = j.id_empleado)
LIMIT 100
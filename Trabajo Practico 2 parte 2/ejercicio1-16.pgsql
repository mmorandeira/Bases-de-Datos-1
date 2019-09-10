--SELECT *
--FROM unc_esq_peliculas.empleado e
--JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento)
--JOIN unc_esq_peliculas.ciudad c ON (d.id_ciudad = c.id_ciudad)
--WHERE e.id_jefe IS NULL AND (c.nombre_ciudad = 'Rawalpindi')
--LIMIT 100
SELECT j.*
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento)
JOIN unc_esq_peliculas.ciudad c ON (d.id_ciudad = c.id_ciudad)
JOIN unc_esq_peliculas.empleado j ON (e.id_jefe = j.id_empleado)
WHERE (c.nombre_ciudad = 'Rawalpindi')
GROUP BY j.id_empleado
LIMIT 100
--CONSULTAR
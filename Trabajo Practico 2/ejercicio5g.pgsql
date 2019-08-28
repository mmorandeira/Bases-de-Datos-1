SELECT id_departamento, COUNT(id_empleado)
FROM unc_esq_peliculas.empleado
GROUP BY id_departamento
--ORDER BY 2 DESC
SELECT e.*,d.*,p.*
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.empleado j ON (e.id_jefe = j.id_empleado)
JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento AND e.id_distribuidor = d.id_distribuidor)
JOIN unc_esq_peliculas.ciudad c ON (d.id_ciudad = c.id_ciudad)
JOIN unc_esq_peliculas.pais p ON (c.id_pais = p.id_pais)
WHERE (j.porc_comision > 40 AND p.nombre_pais = 'ARGENTINA')
ORDER BY e.id_empleado
LIMIT 100
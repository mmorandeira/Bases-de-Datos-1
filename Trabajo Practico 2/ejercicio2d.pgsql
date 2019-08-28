SET search_path = unc_esq_peliculas
SELECT apellido, nombre, e_mail
FROM unc_esq_peliculas.empleado
WHERE LOWER(e_mail) LIKE '%gmail.com' and sueldo > 1000
ORDER BY apellido, nombre
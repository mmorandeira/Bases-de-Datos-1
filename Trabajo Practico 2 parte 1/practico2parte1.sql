

--EJERCICIO 1
--########################################################################


--1
SELECT DISTINCT id_tarea
FROM unc_esq_voluntario.voluntario

--2
SELECT distinct nro_voluntario, id_tarea, id_institucion
FROM unc_esq_voluntario.historico
order by nro_voluntario

--SELECT distinct h.nro_voluntario, v.nombre, v.apellido, h.id_tarea, h.id_institucion
--FROM historico h, voluntario v
--WHERE h.nro_voluntario = v.nro_voluntario
--ORDER BY nro_voluntario


--EJERCICIO 2
--########################################################################


--1
SELECT apellido, nombre, e_mail
FROM unc_esq_voluntario.voluntario
WHERE horas_aportadas > 1000
ORDER BY apellido

--2
SELECT apellido, telefono
FROM unc_esq_voluntario.voluntario
WHERE id_institucion = 20 or id_institucion = 50
ORDER BY apellido, nombre

--3
SELECT apellido || ', ' ||  nombre as "Apellido, Nombre", e_mail as "Direccion de mail"
FROM unc_esq_voluntario.voluntario
WHERE telefono LIKE '011%'
ORDER BY apellido, nombre

--4
SELECT apellido, nombre, e_mail
FROM unc_esq_peliculas.empleado
WHERE LOWER(e_mail) LIKE '%gmail.com' and sueldo > 1000
ORDER BY apellido, nombre

--5
SELECT apellido, nombre, id_tarea, horas_aportadas
FROM unc_esq_voluntario.voluntario
WHERE (id_tarea = 'SA_REP' OR id_tarea = 'ST_CLERK') 
AND horas_aportadas != 2500 AND horas_aportadas != 3500 AND horas_aportadas != 7000


--EJERCICIO 3
--########################################################################


--1
SELECT apellido, nombre, id_empleado
FROM unc_esq_peliculas.empleado
WHERE porc_comision IS NULL OR porc_comision = 0
ORDER BY 1--ordena por la primera columna del query en este casso apellido

--2
SELECT id_distribuidor, nombre, direccion, telefono
FROM unc_esq_peliculas.distribuidor
WHERE tipo = 'I' AND (telefono = '' OR telefono IS NULL) 

--3
SELECT id_departamento, nombre_departamento
FROM unc_esq_peliculas.departamento
WHERE jefe_departamento IS NULL

--4
SELECT nombre_institucion, id_direccion, id_institucion
FROM unc_esq_voluntario.institucion
WHERE id_director IS NOT NULL

--5
SELECT apellido, id_tarea
FROM unc_esq_voluntario.voluntario
WHERE id_coordinador IS NULL

--6
SELECT apellido, horas_aportadas, porcentaje
FROM unc_esq_voluntario.voluntario
WHERE horas_aportadas IS NOT NULL OR horas_aportadas > 0
ORDER BY horas_aportadas DESC, porcentaje DESC


--EJERCICIO 4
--########################################################################


--1
SELECT apellido, nombre, id_tarea, TO_CHAR(fecha_nacimiento, 'YYYY-MM-DD') AS "Fecha Nacimiento"
FROM unc_esq_voluntario.voluntario
WHERE EXTRACT(MONTH FROM fecha_nacimiento) = 5

--2
SELECT nombre || ', ' || apellido AS "Nombre, Apellido", TO_CHAR(fecha_nacimiento, 'MM-DD') AS "Fechas de Cumpleaños"
FROM unc_esq_voluntario.voluntario
ORDER BY EXTRACT(MONTH FROM fecha_nacimiento), EXTRACT(DAY FROM fecha_nacimiento)


--EJERCICIO 5
--########################################################################


--1
SELECT SUM(sueldo)
FROM unc_esq_peliculas.empleado

--2
SELECT id_institucion, COUNT(*)
FROM unc_esq_voluntario.voluntario
GROUP BY id_institucion

--3
SELECT MAX(fecha_nacimiento) AS "Mas joven", MIN(fecha_nacimiento) AS "Mas viejo"
FROM unc_esq_voluntario.voluntario

--4
SELECT nro_voluntario, COUNT(DISTINCT id_tarea)
FROM unc_esq_voluntario.historico
GROUP BY nro_voluntario

--5
SELECT MIN(horas_aportadas) AS "Minimo", MAX(horas_aportadas) AS "Maximo", AVG(horas_aportadas) as "Promedio"
FROM unc_esq_voluntario.voluntario
WHERE EXTRACT(YEAR FROM AGE(fecha_nacimiento)) > 25

--6
SELECT idioma, COUNT(idioma)
FROM unc_esq_peliculas.pelicula
GROUP BY idioma

--7
SELECT id_departamento, COUNT(id_empleado)
FROM unc_esq_peliculas.empleado
GROUP BY id_departamento
--ORDER BY 2 DESC

--8
SELECT id_coordinador, COUNT(id_coordinador) AS "Cantidad"
FROM unc_esq_voluntario.voluntario
GROUP BY id_coordinador
HAVING COUNT(id_coordinador) > 8

--9
SELECT id_institucion, COUNT(id_institucion)
FROM unc_esq_voluntario.voluntario
GROUP BY id_institucion
HAVING COUNT(id_institucion) > 10

--10
SELECT codigo_pelicula, COUNT(codigo_pelicula)
FROM unc_esq_pelicuas.renglon_entrega
GROUP BY codigo_pelicula
HAVING COUNT(codigo_pelicula) BETWEEN 3 AND 5


--EJERCICIO 6
--########################################################################


--1
SELECT id_direccion
FROM unc_esq_voluntario.direccion
ORDER BY id_direccion
LIMIT 10

--2
SELECT *
FROM unc_esq_voluntario.tarea
WHERE nombre_tarea LIKE 'O%' OR nombre_tarea LIKE 'A%' OR nombre_tarea LIKE 'C%' 
LIMIT 5 OFFSET 5*3









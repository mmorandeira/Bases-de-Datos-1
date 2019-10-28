

--EJERCICIO 1
--########################################################################


--1
--SELECT h.nro_voluntario, v.nombre, v.apellido, count(h.id_tarea)
--FROM unc_esq_voluntario.historico h,unc_esq_voluntario.voluntario v
--WHERE h.nro_voluntario = v.nro_voluntario
--GROUP BY h.nro_voluntario,v.nombre,v.apellido
SELECT h.nro_voluntario, v.nombre, v.apellido, COUNT(h.id_tarea)
FROM unc_esq_voluntario.historico h JOIN unc_esq_voluntario.voluntario v ON (h.nro_voluntario = v.nro_voluntario)
GROUP BY h.nro_voluntario, v.nombre, v.apellido;

--2
SELECT v.nombre, v.apellido, v.e_mail, v.telefono
FROM unc_esq_voluntario.voluntario v JOIN unc_esq_voluntario.tarea t on (v.id_tarea = t.id_tarea)
JOIN unc_esq_voluntario.historico h ON (h.id_tarea = v.id_tarea)
WHERE (t.max_horas-t.min_horas <= 5000) AND (h.fecha_fin < TO_DATE('24/07/1998','DD/MM/YYYY'));

--3
SELECT i.nombre_institucion, id_institucion, d.*
FROM unc_esq_voluntario.institucion i 
JOIN unc_esq_voluntario.direccion d ON (i.id_direccion = d.id_direccion)
WHERE i.id_institucion NOT IN (SELECT v.id_institucion
        FROM unc_esq_voluntario.voluntario v 
        JOIN unc_esq_voluntario.tarea t ON (v.id_tarea = t.id_tarea)
        WHERE v.horas_aportadas >= t.max_horas);
        
--4
SELECT nombre_pais
FROM unc_esq_voluntario.pais
WHERE id_pais NOT IN (  SELECT DISTINCT d.id_pais
                        FROM unc_esq_voluntario.historico h
                        JOIN unc_esq_voluntario.institucion i ON (h.id_institucion = i.id_institucion)
                        JOIN unc_esq_voluntario.direccion d ON (d.id_direccion = i.id_direccion))
ORDER BY nombre_pais;

--5
--INDICAR TAREAS QUE NO SE ESTAN DESAROLLANDO
SELECT *
FROM unc_esq_voluntario.tarea
WHERE id_tarea NOT IN ( SELECT DISTINCT v.id_tarea
                        FROM unc_esq_voluntario.voluntario v);
--OTRA FORMA DE RESOLVER LA CONSULTA
--SELECT *
--FROM unc_esq_voluntario.tarea t
--WHERE NOT EXISTS (  SELECT v.nro_voluntario
--                    FROM unc_esq_voluntario.voluntario v
--                    WHERE (v.id_tarea = t.id_tarea));

--6
SELECT p.nombre_pais,COUNT(v.nro_voluntario)
FROM unc_esq_voluntario.pais p
JOIN unc_esq_voluntario.direccion d ON(p.id_pais = d.id_pais)
JOIN unc_esq_voluntario.institucion i ON(i.id_direccion = d.id_direccion)
JOIN unc_esq_voluntario.voluntario v ON(v.id_institucion = i.id_institucion)
WHERE (i.id_institucion IN ( SELECT id_institucion
                            FROM unc_esq_voluntario.voluntario v
                            GROUP BY id_institucion
                            HAVING (COUNT(nro_voluntario)>4) AND 
                                   (MAX(v.horas_aportadas)-MIN(v.horas_aportadas) <= 5000)))
AND (EXTRACT(YEAR FROM AGE(v.fecha_nacimiento)) >18)
GROUP BY p.nombre_pais;

--7
SELECT v.nombre, v.apellido, v.nro_voluntario
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (v.id_institucion = i.id_institucion)
WHERE v.id_institucion IN ( SELECT i.id_institucion 
                            FROM unc_esq_voluntario.institucion i
                            JOIN unc_esq_voluntario.direccion d ON (i.id_direccion = d.id_direccion)
                            JOIN unc_esq_voluntario.pais p ON (p.id_pais = d.id_pais)
                            WHERE (p.id_continente = 1)) 
AND (v.nro_voluntario IN (  SELECT id_director
                            FROM unc_esq_voluntario.institucion))
ORDER BY v.nombre, v.apellido;

--select nro_voluntario,nombre,apellido
--from voluntario
--where nro_voluntario in (	select i.id_director
--							from institucion i
--							join direccion d on (i.id_direccion = --d.id_direccion)
--							join pais p on (d.id_pais = p.id_pais)
--							where p.id_continente = 1);

--8
SELECT t.nombre_tarea, t.id_tarea, t.max_horas
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (i.id_institucion = v.id_institucion)
JOIN unc_esq_voluntario.direccion d ON (i.id_direccion = d.id_direccion)
JOIN unc_esq_voluntario.tarea t ON (v.id_tarea = t.id_tarea)
WHERE   (d.ciudad = 'Munich') AND
        (v.id_tarea IN (  SELECT v.id_tarea
                                FROM unc_esq_voluntario.voluntario v
                                GROUP BY v.id_tarea
                                HAVING COUNT(v.id_tarea)=1));

--9
select distinct d.*
from institucion i
join historico h on (i.id_institucion = h.id_institucion)
join direccion d on (i.id_direccion = d.id_direccion)
where id_director is not null and exists (	select
											from voluntario vin
											where vin.id_institucion!=i.id_institucion and vin.id_tarea = h.id_tarea);
										
--10
SELECT v.nombre, v.apellido, v.nro_voluntario, d.provincia
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (v.id_institucion = i.id_institucion)
JOIN unc_esq_voluntario.direccion d ON (i.id_direccion = d.id_direccion)
WHERE   d.provincia = 'Washington' AND
        v.nro_voluntario IN (   SELECT h.nro_voluntario
                                FROM unc_esq_voluntario.historico h
                                WHERE h.nro_voluntario IN ( SELECT DISTINCT id_director
                                                            FROM unc_esq_voluntario.institucion
                                                            WHERE id_director IS NOT NULL)
                                GROUP BY h.nro_voluntario
                                HAVING COUNT(nro_voluntario) >= 2);
                           
 --11
SELECT DISTINCT i.nombre_institucion, i.id_institucion
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (v.id_institucion = i.id_institucion)
JOIN unc_esq_voluntario.tarea t ON (v.id_tarea = t.id_tarea)
WHERE (t.max_horas <= 3500) OR (v.horas_aportadas < 4000)
GROUP BY i.id_institucion, i.nombre_institucion
HAVING COUNT(*) > 4;
--(SELECT id_tarea
--FROM unc_esq_voluntario.tarea t
--WHERE (t.max_horas < 3500));
                               
--12
SELECT nombre, apellido, telefono
FROM voluntario
WHERE nro_voluntario IN (	SELECT nro_voluntario
							FROM historico
							GROUP BY nro_voluntario
							ORDER BY count(nro_voluntario) DESC
							LIMIT 5);
				
--13
SELECT DISTINCT t.*
FROM tarea t
JOIN voluntario v ON (t.id_tarea = v.id_tarea)
JOIN institucion i ON (v.id_institucion = i.id_institucion)
JOIN direccion d ON (d.id_direccion = i.id_direccion)
JOIN pais p ON (p.id_pais = d.id_pais)
where (p.nombre_pais = 'Reino Unido');

--14
SELECT i.id_institucion, i.nombre_institucion,COUNT(DISTINCT v.id_tarea)
FROM unc_esq_voluntario.voluntario v
JOIN unc_esq_voluntario.institucion i ON (i.id_institucion = v.id_institucion)
GROUP BY i.id_institucion, i.nombre_institucion
HAVING COUNT(DISTINCT v.id_tarea ) > (0.2*( SELECT COUNT(*)
                                            FROM unc_esq_voluntario.tarea t));
                   
--15
SELECT e.apellido || ', ' || e.nombre AS "Empleado", e.id_empleado AS "ID Empleado", j.apellido || ', ' || j.nombre AS "Jefe" 
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.empleado j ON (e.id_jefe = j.id_empleado)
LIMIT 100;

--16
--SELECT *
--FROM unc_esq_peliculas.empleado e
--JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento)
--JOIN unc_esq_peliculas.ciudad c ON (d.id_ciudad = c.id_ciudad)
--WHERE e.id_jefe IS NULL AND (c.nombre_ciudad = 'Rawalpindi')
--LIMIT 100;
SELECT j.*
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento)
JOIN unc_esq_peliculas.ciudad c ON (d.id_ciudad = c.id_ciudad)
JOIN unc_esq_peliculas.empleado j ON (e.id_jefe = j.id_empleado)
WHERE (c.nombre_ciudad = 'Rawalpindi')
GROUP BY j.id_empleado
LIMIT 100;
--CONSULTAR

--17
SELECT n.id_distribuidor, n.nro_inscripcion
FROM unc_esq_peliculas.nacional n
JOIN unc_esq_peliculas.entrega e ON (n.id_distribuidor = e.id_distribuidor)
JOIN unc_esq_peliculas.renglon_entrega re ON (re.nro_entrega = e.nro_entrega)
JOIN unc_esq_peliculas.pelicula p ON (re.codigo_pelicula = p.codigo_pelicula)
WHERE (p.idioma = 'Farsi') AND EXTRACT (YEAR FROM e.fecha_entrega) = 1998
LIMIT 100;

--18
SELECT codigo_pelicula
FROM unc_esq_peliculas.pelicula
WHERE codigo_pelicula NOT IN (  SELECT re.codigo_pelicula
                                FROM unc_esq_peliculas.renglon_entrega re
                                JOIN unc_esq_peliculas.entrega e ON (e.nro_entrega = re.nro_entrega)
                                JOIN unc_esq_peliculas.distribuidor d ON (d.id_distribuidor = e.id_distribuidor)
                                WHERE d.tipo = 'N')
ORDER BY codigo_pelicula
LIMIT 100;

--19
SELECT e.*,d.*,p.*
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.empleado j ON (e.id_jefe = j.id_empleado)
JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento AND e.id_distribuidor = d.id_distribuidor)
JOIN unc_esq_peliculas.ciudad c ON (d.id_ciudad = c.id_ciudad)
JOIN unc_esq_peliculas.pais p ON (c.id_pais = p.id_pais)
WHERE (j.porc_comision > 40 AND p.nombre_pais = 'ARGENTINA')
ORDER BY e.id_empleado
LIMIT 100;

--20
SELECT d.id_departamento, d.id_distribuidor, d.nombre, COUNT(e.id_empleado)
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.tarea t ON (e.id_tarea = t.id_tarea)
JOIN unc_esq_peliculas.departamento d ON (e.id_departamento = d.id_departamento AND e.id_distribuidor = d.id_distribuidor)
WHERE t.sueldo_minimo < 6000
GROUP BY d.id_departamento, d.id_distribuidor
HAVING COUNT(e.id_empleado) > 3
ORDER BY d.id_departamento, d.id_distribuidor;


--EJERCICIO 2
--########################################################################

CREATE TABLE tp2p2_ej2_equipo (
	Id int NOT NULL,
	puntos int NULL,
	descripcion varchar(20) NULL,
	CONSTRAINT pk_tp2p2_equipo PRIMARY KEY(Id)
);

INSERT INTO tp2p2_ej2_equipo(id,puntos) VALUES(1,NULL);
INSERT INTO tp2p2_ej2_equipo(id,puntos) VALUES(2,NULL);
INSERT INTO tp2p2_ej2_equipo(id,puntos) VALUES(3,NULL);
INSERT INTO tp2p2_ej2_equipo(id,puntos) VALUES(4,NULL);

--1.a.1
SELECT avg(puntos),count(puntos),count(*)
FROM tp2p2_ej2_equipo;

--1.a.2
SELECT id,'Su descripcion es ' || descripcion
FROM tp2p2_ej2_equipo
WHERE puntos NOT IN (SELECT DISTINCT puntos FROM tp2p2_ej2_equipo);

--1.a.3
SELECT *
FROM tp2p2_ej2_equipo
WHERE puntos NOT IN (SELECT DISTINCT puntos FROM tp2p2_ej2_equipo);

--1.a.4
SELECT *
FROM tp2p2_ej2_equipo e1 JOIN tp2p2_ej2_equipo e2 ON (e1.puntos = e2.puntos);

--1.b.1
SELECT avg(COALESCE(puntos,0)),count(COALESCE(puntos,0)),count(*)
FROM tp2p2_ej2_equipo;

--1.b.2
SELECT id,'Su descripcion es ' || COALESCE(descripcion,'')
FROM tp2p2_ej2_equipo
WHERE COALESCE(puntos,0) NOT IN (SELECT DISTINCT COALESCE(puntos,0) FROM tp2p2_ej2_equipo);

--2
SELECT nro_voluntario,apellido,nombre
FROM voluntario_voluntario
WHERE NOT(porcentaje BETWEEN 0.15 AND 0.30);

--3
SELECT i.id_institucion, count(*)
FROM voluntario_institucion i LEFT JOIN voluntario_voluntario v ON (i.id_institucion = v.id_institucion)
GROUP BY i.id_institucion;


SELECT v.id_institucion, count(*)
FROM voluntario_institucion i LEFT JOIN voluntario_voluntario v ON (i.id_institucion = v.id_institucion)
GROUP BY v.id_institucion;



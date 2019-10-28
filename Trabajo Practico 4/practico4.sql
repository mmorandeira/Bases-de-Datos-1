
--EJERCICIO 2
--########################################################################

--1)
SELECT id_institucion
FROM voluntario_voluntario
WHERE id_institucion IS NOT NULL
GROUP BY id_institucion
HAVING count(nro_voluntario)=1
EXCEPT--resta de algebra relacional
SELECT id_institucion
FROM voluntario_historico

--2)
SELECT nombre || ',' || apellido
FROM voluntario_voluntario
WHERE id_coordinador IS NULL and horas_aportadas >=5000 --supongo que los coordinadores tienen NULL en id_coordinador hay que acomodarlo xd
union--union de algebra relacional
SELECT i.nombre_institucion
FROM voluntario_voluntario v
JOIN voluntario_institucion i ON (v.id_institucion=i.id_institucion)
WHERE v.horas_aportadas>=5000

--3)
(SELECT distinct c.nro_voluntario,c.nombre,c.apellido
FROM voluntario_voluntario v
JOIN voluntario_voluntario c ON (c.nro_voluntario=v.id_coordinador)
union--union algebra relacional (sin repetidos)
SELECT v.nro_voluntario,v.nombre,v.apellido
FROM voluntario_voluntario v
JOIN voluntario_institucion i ON (v.id_institucion=i.id_institucion)
JOIN voluntario_direccion d ON (i.id_direccion=d.id_direccion)
JOIN voluntario_paIS p ON (d.id_pais=p.id_pais)
JOIN voluntario_continente c ON (p.id_continente=c.id_continente)
WHERE c.nombre_continente='Europeo')
intersect--interseccion algebra relacional (sin repetidos)
SELECT i.id_director,v.nombre,v.apellido
FROM voluntario_institucion i
JOIN voluntario_voluntario v ON (i.id_director=v.nro_voluntario)

--4)



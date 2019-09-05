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
ORDER BY v.nombre, v.apellido
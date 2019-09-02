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
GROUP BY p.nombre_pais
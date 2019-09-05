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
                                HAVING COUNT(nro_voluntario) >= 2)
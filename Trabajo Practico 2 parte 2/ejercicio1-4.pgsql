SELECT nombre_pais
FROM unc_esq_voluntario.pais
WHERE id_pais NOT IN (  SELECT DISTINCT d.id_pais
                        FROM unc_esq_voluntario.historico h
                        JOIN unc_esq_voluntario.institucion i ON (h.id_institucion = i.id_institucion)
                        JOIN unc_esq_voluntario.direccion d ON (d.id_direccion = i.id_direccion))
ORDER BY nombre_pais
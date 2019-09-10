SELECT codigo_pelicula
FROM unc_esq_peliculas.pelicula
WHERE codigo_pelicula NOT IN (  SELECT re.codigo_pelicula
                                FROM unc_esq_peliculas.renglon_entrega re
                                JOIN unc_esq_peliculas.entrega e ON (e.nro_entrega = re.nro_entrega)
                                JOIN unc_esq_peliculas.distribuidor d ON (d.id_distribuidor = e.id_distribuidor)
                                WHERE d.tipo = 'N')
ORDER BY codigo_pelicula
LIMIT 100
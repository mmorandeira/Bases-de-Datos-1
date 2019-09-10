SELECT n.id_distribuidor, n.nro_inscripcion
FROM unc_esq_peliculas.nacional n
JOIN unc_esq_peliculas.entrega e ON (n.id_distribuidor = e.id_distribuidor)
JOIN unc_esq_peliculas.renglon_entrega re ON (re.nro_entrega = e.nro_entrega)
JOIN unc_esq_peliculas.pelicula p ON (re.codigo_pelicula = p.codigo_pelicula)
WHERE (p.idioma = 'Farsi') AND EXTRACT (YEAR FROM e.fecha_entrega) = 1998
LIMIT 100
SELECT codigo_pelicula, COUNT(codigo_pelicula)
FROM unc_esq_pelicuas.renglon_entrega
GROUP BY codigo_pelicula
HAVING COUNT(codigo_pelicula) BETWEEN 3 AND 5
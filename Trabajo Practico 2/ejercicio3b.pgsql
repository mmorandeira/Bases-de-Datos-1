SELECT id_distribuidor, nombre, direccion, telefono
FROM unc_esq_peliculas.distribuidor
WHERE tipo = 'I' AND (telefono = '' OR telefono IS NULL) 
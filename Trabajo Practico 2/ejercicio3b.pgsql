SELECT id_distribuidor, nombre, direccion, telefono
FROM distribuidor
WHERE tipo = 'I' AND (telefono = '' OR telefono IS NULL) 
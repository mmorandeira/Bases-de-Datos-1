SELECT apellido, nombre, id_empleado
FROM empleado
WHERE porc_comision IS NULL OR porc_comision = 0
ORDER BY 1--ordena por la primera columna del query en este casso apellido
SELECT apellido, nombre, id_tarea, TO_CHAR(fecha_nacimiento, 'YYYY-MM-DD') AS "Fecha Nacimiento"
FROM voluntario
WHERE EXTRACT(MONTH FROM fecha_nacimiento) = 5
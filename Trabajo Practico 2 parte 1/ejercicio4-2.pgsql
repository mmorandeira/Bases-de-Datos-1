SELECT nombre || ', ' || apellido AS "Nombre, Apellido", TO_CHAR(fecha_nacimiento, 'MM-DD') AS "Fechas de Cumpleaños"
FROM unc_esq_voluntario.voluntario
ORDER BY EXTRACT(MONTH FROM fecha_nacimiento), EXTRACT(DAY FROM fecha_nacimiento)
SELECT MIN(horas_aportadas) AS "Minimo", MAX(horas_aportadas) AS "Maximo", AVG(horas_aportadas) as "Promedio"
FROM voluntario
WHERE EXTRACT(YEAR FROM AGE(fecha_nacimiento)) > 25
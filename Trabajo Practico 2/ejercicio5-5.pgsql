SELECT MIN(horas_aportadas) AS "Minimo", MAX(horas_aportadas) AS "Maximo", AVG(horas_aportadas) as "Promedio"
FROM unc_esq_voluntario.voluntario
WHERE EXTRACT(YEAR FROM AGE(fecha_nacimiento)) > 25
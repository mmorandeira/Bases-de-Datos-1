SELECT nro_voluntario, COUNT(nro_voluntario)
FROM historico
GROUP BY nro_voluntario
SELECT nro_voluntario, COUNT(DISTINCT id_tarea)
FROM unc_esq_voluntario.historico
GROUP BY nro_voluntario
SELECT nro_voluntario, COUNT(nro_voluntario)
FROM unc_esq_voluntario.historico
GROUP BY nro_voluntario
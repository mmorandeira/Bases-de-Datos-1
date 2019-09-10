SELECT *
FROM unc_esq_voluntario.historico h
JOIN unc_esq_voluntario.voluntario v ON (h.nro_voluntario = v.nro_voluntario)
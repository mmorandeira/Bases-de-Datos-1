SELECT apellido, horas_aportadas, porcentaje
FROM unc_esq_voluntario.voluntario
WHERE horas_aportadas IS NOT NULL OR horas_aportadas > 0
ORDER BY horas_aportadas DESC, porcentaje DESC
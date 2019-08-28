SELECT id_institucion, COUNT(id_institucion)
FROM unc_esq_voluntario.voluntario
GROUP BY id_institucion
HAVING COUNT(id_institucion) > 10
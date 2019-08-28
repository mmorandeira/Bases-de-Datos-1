SELECT id_institucion, COUNT(id_institucion)
FROM voluntario
GROUP BY id_institucion
HAVING COUNT(id_institucion) > 10
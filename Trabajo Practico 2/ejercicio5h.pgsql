SELECT id_coordinador, COUNT(id_coordinador) AS "Cantidad"
FROM voluntario
GROUP BY id_coordinador
HAVING COUNT(id_coordinador) > 8
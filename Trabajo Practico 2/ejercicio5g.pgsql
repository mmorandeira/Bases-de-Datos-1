SELECT id_departamento, COUNT(id_empleado)
FROM empleado
GROUP BY id_departamento
--ORDER BY 2 DESC
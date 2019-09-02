--INDICAR TAREAS QUE NO SE ESTAN DESAROLLANDO
SELECT *
FROM unc_esq_voluntario.tarea
WHERE id_tarea NOT IN ( SELECT DISTINCT v.id_tarea
                        FROM unc_esq_voluntario.voluntario v)
--OTRA FORMA DE RESOLVER LA CONSULTA
--SELECT *
--FROM unc_esq_voluntario.tarea t
--WHERE NOT EXISTS (  SELECT v.nro_voluntario
--                    FROM unc_esq_voluntario.voluntario v
--                    WHERE (v.id_tarea = t.id_tarea))
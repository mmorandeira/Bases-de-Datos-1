SELECT apellido, nombre, id_tarea, horas_aportadas
FROM voluntario
WHERE (id_tarea = 'SA_REP' OR id_tarea = 'ST_CLERK') 
AND horas_aportadas != 2500 AND horas_aportadas != 3500 AND horas_aportadas != 7000
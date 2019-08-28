SELECT apellido, nombre, e_mail
FROM empleado
WHERE LOWER(e_mail) LIKE '%gmail.com' and sueldo > 1000
ORDER BY apellido, nombre
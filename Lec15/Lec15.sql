-- COMBINAR DEPARTAMENTO CON EMPLEADOS EN RH

select * from RH.dbo.empleado;

SELECT * 
FROM RH.dbo.departamento d
INNER JOIN RH.dbo.empleado e
ON d.iddepartamento = e.iddepartamento

SELECT d.nombre, COUNT(*) emps, 
	sum(e.sueldo) planilla,
	SUM(e.sueldo + ISNULL(e.comision,0)) planilla2
FROM RH.dbo.departamento d
INNER JOIN RH.dbo.empleado e
ON d.iddepartamento = e.iddepartamento
GROUP BY d.nombre;


-- =============================
-- INNER JOIN
-- =============================

-- Ejercicio 1
-- Desarrolle una sentencia SELECT para obtener un 
-- listado que incluya el nombre del curso con sus 
-- respectivos nombres de alumnos. Base de datos EDUCA.

select c.cur_nombre, a.alu_nombre, m.mat_nota
from educa.dbo.CURSO c
inner join educa.dbo.MATRICULA m
on c.cur_id = m.cur_id
inner join educa.dbo.ALUMNO a
on m.alu_id = a.alu_id;

select * from educa.dbo.matricula;


-- Ejercicio 2
-- Desarrolle una sentencia SELECT que muestre el 
-- nombre del alumno y la suma de todos sus pagos. 
-- Base de datos EDUCA.

select 
	alu.alu_nombre, 
	convert(varchar,cast(SUM(pag.pag_importe) as money),1) as pago
from educa.dbo.alumno alu
inner join educa.dbo.PAGO pag on alu.alu_id=pag.alu_id
group by alu.alu_nombre;

select SUM(pag_importe) from educa.dbo.PAGO;


-- Ejercicio 3
-- Desarrolle una sentencia SELECT que muestre el nombre 
-- del curso y el importe de todos sus pagos. 
-- Base de datos EDUCA.

select cur.cur_nombre, 
	convert(varchar,cast(SUM(pag.pag_importe) as money),1) as pago
from educa.dbo.CURSO cur
inner join educa.dbo.PAGO pag on cur.cur_id=pag.cur_id
group by cur.cur_nombre;


-- Ejercicio 3.1
-- Desarrolle una sentencia SELECT que muestre el nombre 
-- del curso, cantidad de matriculados y el importe de 
-- todos sus pagos. 
-- Base de datos EDUCA.



-- Ejercicio 4
-- Desarrolle una sentencia SELECT que muestre el nombre 
-- del departamento y el importe de su planilla. 
-- Base de datos RH.

select dep.nombre, 
	convert(varchar,cast(SUM(emp.sueldo) as money),1) as planilla
from rh.dbo.departamento dep
inner join rh.dbo.empleado emp on dep.iddepartamento=emp.iddepartamento
group by dep.nombre;


-- ===========================
-- [LEFT|RIGHT] OUTER JOIN
-- ===========================

select *
from rh.dbo.departamento d
left join rh.dbo.empleado e
on d.iddepartamento = e.iddepartamento
where e.iddepartamento is null;


-- ========================
-- Auto JOIN
-- ========================

-- Ejercicio 10

select e.idempleado, e.nombre, e.apellido, 
	j.idempleado + ' - ' + j.nombre + ' - ' + j.apellido jefe
from rh.dbo.empleado j
join rh.dbo.empleado e
on j.idempleado = e.jefe;







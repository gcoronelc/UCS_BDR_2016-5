-- CLAUSULA: TOP

-- El estudiante que tiene la nota mas alta
-- en el curso 1000

-- Sol 1

select top 1 a.IdAlumno, a.ApeAlumno, a.NomAlumno, m.Promedio
from edutec.dbo.Alumno a
join EduTec.dbo.Matricula m
on a.IdAlumno = m.IdAlumno
where m.IdCursoProg = 1000
order by m.Promedio desc;

-- Sol 2

select a.IdAlumno, a.ApeAlumno, a.NomAlumno, t.Promedio
from (
	select top 1 m.IdCursoProg, m.IdAlumno, m.Promedio
	from EduTec.dbo.Matricula m
	where m.IdCursoProg = 1000
	order by m.Promedio desc) t
join EduTec.dbo.Alumno a
on t.IdAlumno = a.IdAlumno;


-- sol 3

with t as (
	select top 1 m.IdCursoProg, m.IdAlumno, m.Promedio
	from EduTec.dbo.Matricula m
	where m.IdCursoProg = 1000
	order by m.Promedio desc)
select a.IdAlumno, a.ApeAlumno, a.NomAlumno, t.Promedio
from t join EduTec.dbo.Alumno a
on t.IdAlumno = a.IdAlumno;


-- Ejercicio 6
-- Desarrolle una consulta para averiguar quiénes son los 
-- trabajadores que tienen el sueldo más bajo. 
-- Base de datos RH.

-- Sol 1
select top 1 with ties * 
from rh.dbo.empleado
order by sueldo asc;

-- Sol 2
with v as (
	select MIN(sueldo) sueldo
	from rh.dbo.empleado)
select e.*
from rh.dbo.empleado e
join v on e.sueldo = v.sueldo;

-- Sol 3
with v as (
	select MIN(sueldo) sueldo
	from rh.dbo.empleado)
select e.*
from rh.dbo.empleado e
where sueldo in (select sueldo from v);



-- Ejercicio 10
-- Se necesita saber la cantidad de alumnos matriculados, 
-- aprobados y desaprobados por cada trimestre del año 2012, 
-- debe tomar en cuenta la fecha de matrícula.

select 
	DATEPART(q,FecMatricula) Trimestre,
	COUNT(*) Matriculados,
	SUM(case when Promedio >= 13.0 then 1 else 0 end) Aprobados,
	SUM(case when Promedio >= 13.0 then 0 else 1 end) Desaprobados
from edutec.dbo.Matricula
where YEAR(FecMatricula) = 2012
group by DATEPART(q,FecMatricula)
order by 1;


-- Ejercicio 11
-- Encontrar el ingreso por mes de cada curso. 
-- Base de datos EDUCA.

-- Sol 1

select * from educa.dbo.PAGO;

select cur_id, MONTH(pag_fecha) mes, SUM(pag_importe) importe
from educa.dbo.PAGO
where YEAR(pag_fecha) = 2016
group by cur_id, MONTH(pag_fecha)
order by 1, 2;

select cur_id CURSO, 
  SUM(case when MONTH(pag_fecha) = 1 then pag_importe else 0 end ) ENE,
  SUM(case when MONTH(pag_fecha) = 2 then pag_importe else 0 end ) FEB,
  SUM(case when MONTH(pag_fecha) = 3 then pag_importe else 0 end ) MAR,
  SUM(case when MONTH(pag_fecha) = 4 then pag_importe else 0 end ) ABR,
  SUM(case when MONTH(pag_fecha) = 5 then pag_importe else 0 end ) MAY,
  SUM(case when MONTH(pag_fecha) = 6 then pag_importe else 0 end ) JUN,
  SUM(case when MONTH(pag_fecha) = 7 then pag_importe else 0 end ) JUL,
  SUM(case when MONTH(pag_fecha) = 8 then pag_importe else 0 end ) AGO,
  SUM(case when MONTH(pag_fecha) = 9 then pag_importe else 0 end ) SEP,
  SUM(case when MONTH(pag_fecha) = 10 then pag_importe else 0 end ) OCT,
  SUM(case when MONTH(pag_fecha) = 11 then pag_importe else 0 end ) NOV,
  SUM(case when MONTH(pag_fecha) = 12 then pag_importe else 0 end ) DIC,
  SUM(pag_importe) TOTAL
from educa.dbo.PAGO
where YEAR(pag_fecha) = 2016
group by cur_id
order by 1;


-- Sol 2

SELECT 
	curso, 
	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] 
FROM (select 
	cur_id curso, MONTH(pag_fecha) mes, pag_importe importe
	from educa.dbo.PAGO where YEAR(pag_fecha) = 2016) AS datos 
PIVOT ( SUM(importe) FOR mes IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12]) ) AS PivotTable;


select 
	cur_id curso, MONTH(pag_fecha) mes, pag_importe importe
from educa.dbo.PAGO where YEAR(pag_fecha) = 2016;


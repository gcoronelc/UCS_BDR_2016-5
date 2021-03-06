/*1) Cuántos proveedores hay por país. Base de datos NorthWin. El formato del resultado es el siguiente.*/


select s.Country,
COUNT(*) cantidad 
--from dbo.Customers c
--inner join 
from dbo.Suppliers s-- on c.Country = s.Country
group by s.Country

/*
2) Cuantos empleados se tienen en cada ciudad de cada país. Base de datos NorthWin. El formato del resultado es el siguiente.
 */

select Country,City,
COUNT(*)empleados
from 
dbo.Employees
group by Country,City

/*
3) Se necesita saber cuántas matriculas se registraron por mes en el año 2011. Base de datos EDUTEC. El siguiente es el formato del resultado:
*/
select nro_mes ,nom_mes ,
count(*)matriculas from
(
select month(FecMatricula)nro_mes, 
DATENAME(month,FecMatricula) nom_mes
--COUNT(*) matriculas
from EDUTEC.dbo.Matricula
where YEAR(FecMatricula)= '2011'
group by FecMatricula
)as t

group by nro_mes,nom_mes
order by nro_mes

/*
4) Se necesita saber cuántas veces se ha programado cada curso 
en el 2014. Base de datos EDUTEC. El siguiente es el formato del resultado:
*/
SELECT C.IdCurso,C.NomCurso, COUNT(*)cantProgramacion 
FROM EDUTEC.DBO.Curso C
  INNER JOIN  EDUTEC.DBO.CursoProgramado P ON C.IdCurso = P.IdCurso
  INNER JOIN EDUTEC.DBO.Ciclo ci ON ci.IdCiclo = P.IdCiclo
  INNER JOIN EDUTEC.DBO.Matricula M ON M.IdCursoProg = P.IdCursoProg
where YEAR(ci.FecInicio) = 2014
group by  C.IdCurso,C.NomCurso
ORDER BY 1


SELECT C.IdCurso,C.NomCurso, COUNT(*)cantProgramacion 
FROM EDUTEC.DBO.Curso C
 INNER JOIN  EDUTEC.DBO.CursoProgramado P ON C.IdCurso = P.IdCurso
where (p.IdCiclo) like '2014%'
group by  C.IdCurso,C.NomCurso
ORDER BY 1


/*
5 )De cada ciclo programado del año 2012 se necesita saber:
 La cantidad de cursos que se han programado.
 La cantidad de vacantes programadas (Vacantes + Matriculados).
 La cantidad de matrículas.
 El precio promedio.
 El importe proyectado.
 El importe recaudado.
*/

with CUR as (
  SELECT 
     CIC.IdCiclo, COUNT(*) cantProgramacion,
     sum(cur.Vacantes + cur.Matriculados) vac_prog
  FROM EDUTEC.DBO.Ciclo CIC 
  INNER JOIN  EDUTEC.DBO.CursoProgramado CUR ON CUR.IdCiclo = CIC.IdCiclo
  where year(CIC.FecInicio) = 2012
  GROUP BY CIC.IdCiclo )
select CUR.*, COUNT(*) matriculas, avg(CURP.PreCursoProg)precio_promedio,(avg(CURP.PreCursoProg)*vac_prog)proyectado,
(avg(CURP.PreCursoProg)*COUNT(*))recaudado
from  EDUTEC.DBO.CursoProgramado CURP 
join CUR ON CURP.IdCiclo = CUR.IdCiclo
INNER JOIN EDUTEC.DBO.Matricula M ON M.IdCursoProg = CURP.IdCursoProg 
GROUP BY CUR.IdCiclo,cantProgramacion,vac_prog
order by IdCiclo;
go

SELECT 
     IdCiclo, 
     COUNT(*) cantCursosProgramados,
     sum(Vacantes + Matriculados) vac_prog,
     AVG(PreCursoProg) precio_promedio,
     SUM((Vacantes + Matriculados) * PreCursoProg) proyectado,
     SUM(Matriculados * PreCursoProg) Recaudado
FROM EDUTEC.DBO.CursoProgramado 
where IdCiclo like '2012%'
GROUP BY IdCiclo

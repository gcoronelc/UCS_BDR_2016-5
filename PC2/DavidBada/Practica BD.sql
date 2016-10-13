--Pregunta 1
--Cuántos proveedores hay por país. Base de datos NorthWin. El formato del resultado es el siguiente.
select s.country Pais, count(*) Proveedores from Northwind.dbo.Suppliers s
group by s.country;

--Pregunta 2
--Cuantos empleados se tienen en cada ciudad de cada país. Base de datos NorthWin. El formato del resultado es el siguiente.
select e.country Pais, e.city Ciudad, count(*) Empleados  from Northwind.dbo.employees e
group by e.country, e.city;

--Pregunta 3
--Se necesita saber cuántas matriculas se registraron por mes en el año 2011. Base de datos EDUTEC. El siguiente es el formato del resultado:
select month(fecMatricula) NroMes,
case 
when month(fecMatricula) = 1 then 'Enero' 
when month(fecMatricula) = 2 then 'Febrero' 
when month(fecMatricula) = 3 then 'Marzo' 
when month(fecMatricula) = 4 then 'Abril' 
when month(fecMatricula) = 5 then 'Mayo' 
when month(fecMatricula) = 6 then 'Junio' 
when month(fecMatricula) = 7 then 'Julio' 
when month(fecMatricula) = 8 then 'Agosto' 
when month(fecMatricula) = 9 then 'Septiembre' 
when month(fecMatricula) = 10 then 'Octubre' 
when month(fecMatricula) = 11 then 'Noviembre' 
when month(fecMatricula) = 12 then 'Diciembre' 
end Nom_Mes,
count(*) Matriculas
from edutec.dbo.matricula where Year(fecMatricula)=2011
group by month(fecMatricula)order by month(fecMatricula);

--Pregunta 4
--Se necesita saber cuántas veces se ha programado cada curso en el 2014. Base de datos EUTEC. El siguiente es el formato del resultado:
select c.idCurso,a.NomCurso, count(*)CantProgramacion from edutec.dbo.cursoprogramado c inner join edutec.dbo.matricula m
on c.idCursoProg= m.idCursoProg inner join edutec.dbo.curso a on c.idCurso=a.idCurso
where  Year(m.FecMatricula)=2014
group by c.idCurso, a.NomCurso
order by c.idCurso;

--Pregunta 5
--De cada ciclo programado del año 2012 se necesita saber:
--La cantidad de cursos que se han programado.
-- La cantidad de vacantes programadas (Vacantes + Matriculados).
--La cantidad de matrículas.
--El precio promedio.
--El importe proyectado.
--El importe recaudado.
select b.idciclo,count(*)CantProgramacion, (c.matriculados + c.vacantes) as VacProgramadas, c.matriculados Matriculados,
(c.Matriculados*PreCursoProg) PreProm,
(c.vacantes+c.Matriculados)*PreCursoProg Proyectado,
(c.Matriculados)*PreCursoProg Recaudado
from edutec.dbo.cursoprogramado c inner join edutec.dbo.matricula m
on c.idCursoProg= m.idCursoProg inner join edutec.dbo.curso a on c.idCurso=a.idCurso inner join edutec.dbo.ciclo b  on c.idciclo=b.idciclo
where  Year(m.FecMatricula)=2012
group by b.idciclo, (c.matriculados + c.vacantes), c.matriculados, c.Matriculados*PreCursoProg, (c.vacantes+c.Matriculados)*PreCursoProg, (c.Matriculados)*PreCursoProg
order by b.idciclo;


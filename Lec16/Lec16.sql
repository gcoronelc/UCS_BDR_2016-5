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
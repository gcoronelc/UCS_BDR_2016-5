--* PREGUNTA 1
select top 3 cur.IdCurso, 
	cur.NomCurso, 
	count(mat.IdAlumno) as 'cant.matriculados'
from edutec.dbo.Curso cur
	inner join edutec.dbo.CursoProgramado cpr on cur.IdCurso=cpr.IdCurso
	inner join edutec.dbo.Matricula mat on cpr.IdCursoProg=mat.IdCursoProg	
	inner join edutec.dbo.Ciclo cic on cpr.IdCiclo=cic.IdCiclo
where year(cic.FecInicio)=2011
group by cur.IdCurso, cur.NomCurso
order by count(mat.IdAlumno) desc;

--* PREGUNTA 2 *--
select al.IdAlumno, 
	al.NomAlumno, 
	al.ApeAlumno, 
	YEAR(mat.FecMatricula) as 'Año.Matricula', 
	SUM(pcu.PreCursoProg) as 'inversion'
from edutec.dbo.Alumno al
	inner join edutec.dbo.Matricula mat on al.IdAlumno=mat.IdAlumno
	inner join edutec.dbo.CursoProgramado pcu on mat.IdCursoProg=pcu.IdCursoProg
--where al.IdAlumno='A0001'
group by al.IdAlumno, al.NomAlumno, al.ApeAlumno, YEAR(mat.FecMatricula)
order by al.IdAlumno, YEAR(mat.FecMatricula);

--* PREGUNTA 3
select cu.idcurso, cu.nomcurso, cp.matriculados
 from EduTec.dbo.Curso cu
inner join EduTec.dbo.CursoProgramado cp on cp.idcurso = cu.idcurso
where cp.idciclo = '2015-10'
  and cp.matriculados < 10;

--* PREGUNTA 4
select cic.IdCiclo, 
	pro.IdProfesor, 
	pro.NomProfesor+' '+pro.ApeProfesor as 'nom.prof', 
	COUNT(cpr.IdCurso) as 'cant.cursos'
from edutec.dbo.Profesor pro
	inner join edutec.dbo.CursoProgramado cpr on pro.IdProfesor=cpr.IdProfesor
	inner join edutec.dbo.Ciclo cic on cpr.IdCiclo=cic.IdCiclo
where substring(cic.IdCiclo,1,4)='2015'
group by cic.IdCiclo, 
	pro.IdProfesor, 
	pro.NomProfesor+' '+pro.ApeProfesor
order by COUNT(cpr.IdCurso) desc;

--* PREGUNTA 5 *--
select al.IdAlumno, al.NomAlumno +' '+ al.ApeAlumno, COUNT(mat.IdCursoProg) as 'Cursos', 
	SUM(case when mat.promedio>=12 then 1 else 0 end ) as 'Aprobados',
	SUM(case when mat.promedio<12 then 1 else 0 end ) as 'Desaprobados'
from edutec.dbo.Alumno al
	inner join edutec.dbo.Matricula mat on al.IdAlumno=mat.IdAlumno
group by  al.IdAlumno, al.NomAlumno +' '+ al.ApeAlumno;

--* PREGUNTA 6
 with t_matriculados as (
select substring(idciclo,1,4) año, count(ma.idcursoprog) alumnos_matriculados
  from EduTec.dbo.CursoProgramado cp
 inner join EduTec.dbo.Matricula ma on ma.idcursoprog = cp.idcursoprog
 group by substring(cp.idciclo,1,4)
 ),
 t_cursos_prog as (
select substring(cp.idciclo,1,4) año, count(1) cuenta_curso, sum(cp.precursoprog) precio_curso
  from EduTec.dbo.CursoProgramado cp
 group by substring(cp.idciclo,1,4)
 )
 select substring(cp.idciclo,1,4) año
     , tcr.cuenta_curso cursos
     , tma.alumnos_matriculados
     , convert( varchar, convert( money, tcr.precio_curso * tma.alumnos_matriculados),1) recaudado
     , sum(case when ma.promedio >= 12 then 1 else 0 end) aprobados
     , sum(case when ma.promedio < 12 then 1 else 0 end) desaprobados
 from EduTec.dbo.CursoProgramado cp
inner join EduTec.dbo.Matricula ma on ma.idcursoprog = cp.idcursoprog
inner join t_matriculados tma on tma.año = substring(cp.idciclo,1,4)
inner join t_cursos_prog tcr on tcr.año = substring(cp.idciclo,1,4)
group by substring(cp.idciclo,1,4), tcr.cuenta_curso, precio_curso, tma.alumnos_matriculados
order by 1;

--* PREGUNTA 7
with a as (
select distinct c.IdCurso, min(Promedio) as minimo 
from edutec.dbo.Matricula m
	inner join edutec.dbo.CursoProgramado c on m.IdCursoProg=c.IdCursoProg
where c.IdCiclo='2011-10'
group by c.IdCurso)
select a.idcurso, 
	cur.NomCurso, 
	al.IdAlumno, 
	al.NomAlumno+' '+al.ApeAlumno as 'Alumno',  
	min(a.minimo) as 'NotaMinima' 
from a
	inner join edutec.dbo.CursoProgramado cpr on a.idcurso=cpr.IdCurso
	inner join edutec.dbo.Matricula mat on cpr.idcursoprog=mat.IdCursoProg
	inner join edutec.dbo.Alumno al on mat.IdAlumno=al.IdAlumno
	inner join edutec.dbo.Curso cur on cpr.IdCurso=cur.IdCurso
where a.minimo=mat.promedio
	and cpr.IdCiclo='2011-10'
group by a.idcurso, cur.NomCurso, al.IdAlumno, al.NomAlumno+' '+al.ApeAlumno



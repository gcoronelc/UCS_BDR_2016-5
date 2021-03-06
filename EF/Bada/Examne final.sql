
/* Examen final
INTEGRANTES
David Bada
Sergio Acosta
Kevin Villanueva
*/

/*
Pregunta 1
Se necesita saber los tres 3 cursos que han tenido mayor demanda en el año 2011 (Programados en el 2011). 
Los cursos que tienen mayor demanda son los que registran mayor cantidad de alumnos matriculados. Base de datos EDUTEC
*/
SELECT cp.idcurso,c.NomCurso, MAX(cp.Matriculados) Matriculados  FROM EDUTEC.DBO.CursoProgramado cp 
inner join EDUTEC.DBO.curso c on cp.idcurso= c.idcurso
inner join EDUTEC.DBO.matricula m on cp.idCursoprog= m.idCursoprog
where YEAR(m.fecMatricula)=2011
group by cp.idcurso,c.NomCurso,cp.Matriculados
order by cp.Matriculados desc;
/*
Pregunta 2
Se necesita saber cuánto invierte cada alumno por año en cursos de EduTec.
Se debe considerar la fecha en que realiza la matricula. El formato del resultado es el siguiente:
*/
SELECT a.idalumno, a.NomAlumno, a.ApeAlumno, Year(m.fecMatricula) Año, cp.PreCursoProg FROM EDUTEC.DBO.alumno a
inner join EDUTEC.DBO.matricula m on a.idAlumno = m.idAlumno
inner join EDUTEC.DBO.CursoProgramado cp on m.idCursoProg=cp.idCursoProg

/*
Pregunta 3
Se necesita saber que cursos del ciclo 2015-10 tienen menos de 10 matriculados. Base de datos EduTec. El formato del resultado es el siguiente:
*/
SELECT cp.idCurso AS "COD.CURSO", c.NomCurso AS  "NOM.CURSO", cp.Matriculados MATRICULADOS FROM EDUTEC.DBO.CursoProgramado cp
inner join EDUTEC.DBO.curso c on  cp.idCurso= c.idCurso
where cp.idCiclo='2015-10'
and cp.Matriculados <10;

/*
Pregunta 4
Se necesita saber el profesor que tiene más cursos programados en cada ciclo del año 2015.
 Se debe mostrar los empates. Base de datos EduTec. El formato del resultado es el siguiente:
*/
SELECT cp.idciclo, cp.idProfesor, (p.NomProfesor +' '+ p.apeProfesor) Profesor, COUNT(cp.idcurso) Cursos FROM EDUTEC.DBO.CursoProgramado  cp
inner join EDUTEC.DBO.Profesor p on cp.idProfesor= p.idProfesor
inner join EDUTEC.DBO.matricula m on cp.idCursoProg=m.idCursoProg
where year(m.fecMatricula)=2015
GROUP BY cp.idciclo,cp.idProfesor,(p.NomProfesor +' '+ p.apeProfesor), cp.idcurso
ORDER BY cp.idcurso;

/*
Pregunta 6
De cada año se necesita saber:
 La cantidad de cursos programados.
 La cantidad de alumnos matriculados. Cada matricula se considera un alumno matriculado.
 El importe recaudado por el pago de los alumnos matriculados.
 La cantidad de aprobados, la nota mínima para aprobar es 12.0.
 La cantidad de desaprobados, las notas menores a 12.0 se considera desaprobado.
*/
select Year(m.FecMatricula) año, count(*)CURSOS, c.matriculados alumnos, c.PreCursoProg recaudado from edutec.dbo.cursoprogramado c 
inner join edutec.dbo.matricula m on c.idCursoProg= m.idCursoProg inner join edutec.dbo.curso a on c.idCurso=a.idCurso
where  Year(m.FecMatricula)=2014
group by m.FecMatricula, c.matriculados, c.PreCursoProg

/*
Pregunta 7
De cada curso del periodo 2011-10 se necesita saber quién es el alumno con la menor nota,
se debe mostrar los empates. La plantilla del resultado es la siguiente:
*/
SELECT cp.idcurso cod_curso, c.Nomcurso nom_curso, m.idalumno cod_alumno, a.nomalumno nom_alumno, Min(m.promedio) promedio FROM EDUTEC.DBO.CursoProgramado CP 
inner join EDUTEC.DBO.curso c on cp.idcurso=c.idcurso
inner join EDUTEC.DBO.matricula m on cp.idcursoprog= m.idcursoprog
inner join EDUTEC.DBO.alumno a on m.idalumno= a.idalumno
where cp.idciclo='2011-10'
group by cp.idcurso, c.Nomcurso, m.idalumno, a.nomalumno, m.promedio
order by m.promedio;



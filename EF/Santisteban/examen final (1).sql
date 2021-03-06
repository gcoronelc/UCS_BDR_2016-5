/*
Pregunta 1
Se necesita saber los tres 3 cursos que han tenido mayor demanda en el año 2011 (Programados en el 2011). 
Los cursos que tienen mayor demanda son los que registran mayor cantidad de alumnos matriculados. 
Base de datos EDUTEC. El formato del resultado es el siguiente:
*/

SELECT TOP 3 
CUR.IdCurso, CUR.NomCurso, COUNT(*)MATRICULADOS  FROM 
EDUTEC.dbo.Curso CUR
INNER JOIN EDUTEC.dbo.CursoProgramado CPR ON CUR.IdCurso = CPR.IdCurso
INNER JOIN EDUTEC.DBO.Matricula MA ON MA.IdCursoProg = CPR.IdCursoProg
WHERE IdCiclo LIKE '2011%'
GROUP BY CUR.IdCurso, CUR.NomCurso
ORDER BY MATRICULADOS DESC

/*
Pregunta 2
Se necesita saber cuánto invierte cada alumno por año en cursos de EduTec. 
Se debe considerar la fecha en que realiza la matricula. El formato del resultado es el siguiente:
*/

SELECT 
MA.IdAlumno, AL.NomAlumno,AL.ApeAlumno, YEAR(FecMatricula)PERIODO,SUM(PreCursoProg) INVERSION
 FROM 
EDUTEC.dbo.Curso CUR
INNER JOIN EDUTEC.dbo.CursoProgramado CPR ON CUR.IdCurso = CPR.IdCurso
INNER JOIN EDUTEC.DBO.Matricula MA ON MA.IdCursoProg = CPR.IdCursoProg
INNER JOIN EDUTEC.DBO.Alumno AL ON AL.IdAlumno = MA.IdAlumno
GROUP BY MA.IdAlumno, AL.NomAlumno,AL.ApeAlumno,YEAR(FecMatricula)
ORDER BY MA.IdAlumno, PERIODO


--select *,YEAR(FecMatricula)PERIODO from EDUTEC.DBO.Matricula where IdAlumno = 'A0001'
/*
Pregunta 3
Se necesita saber que cursos del ciclo 2015-10 tienen menos de 10 matriculados. Base de datos EduTec. El formato del resultado es el siguiente:
*/

SELECT 
CUR.IdCurso, CUR.NomCurso, COUNT(*)MATRICULADOS   FROM 
EDUTEC.dbo.Curso CUR
INNER JOIN EDUTEC.dbo.CursoProgramado CPR ON CUR.IdCurso = CPR.IdCurso
INNER JOIN EDUTEC.DBO.Matricula MA ON MA.IdCursoProg = CPR.IdCursoProg
INNER JOIN EDUTEC.DBO.Alumno AL ON AL.IdAlumno = MA.IdAlumno
where IdCiclo = '2015-10'
GROUP BY CUR.IdCurso, CUR.NomCurso
having  COUNT(*) <10

/*
Pregunta 4
Se necesita saber el profesor que tiene más cursos programados en cada ciclo del año 2015. 
Se debe mostrar los empates. Base de datos EduTec. El formato del resultado es el siguiente:
*/

	SELECT TOP 3
	 IdCiclo,PRO.IdProfesor, PRO.NomProfesor, COUNT(*)CURSOS  FROM 
	 EDUTEC.dbo.CursoProgramado CPR 
	INNER JOIN EDUTEC.DBO.Profesor PRO ON PRO.IdProfesor = CPR.IdProfesor
	WHERE IdCiclo LIKE '2015%'
	GROUP BY IdCiclo,PRO.IdProfesor, PRO.NomProfesor

	ORDER BY CURSOS DESC

--SELECT * FROM EDUTEC.dbo.CursoProgramado WHERE IdProfesor = 'P009' AND IdCiclo LIKE '2015%'

/*
De la base de datos EduTec, de cada estudiante se necesita saber los siguientes datos:
 Cantidad de cursos matriculados
 Cantidad de cursos aprobados (Promedio >= 12.0).
 Cantidad de cursos desaprobados (Promedio < 12.0).
*/

SELECT 
al.IdAlumno, al.NomAlumno, COUNT(*)cursos ,
sum(case when Promedio >= 12.0 then  1 else 0 end) aprobado,
sum(case when Promedio < 12.0 then  1 else 0 end) desaprobado
  FROM 
 EDUTEC.dbo.CursoProgramado  CPR
INNER JOIN EDUTEC.DBO.Matricula MA ON MA.IdCursoProg = CPR.IdCursoProg
INNER JOIN EDUTEC.DBO.Alumno AL ON AL.IdAlumno = MA.IdAlumno
GROUP BY al.IdAlumno, al.NomAlumno


/*
Pregunta 6
De cada año se necesita saber:
 La cantidad de cursos programados.
 La cantidad de alumnos matriculados. Cada matricula se considera un alumno matriculado.
 El importe recaudado por el pago de los alumnos matriculados.
 La cantidad de aprobados, la nota mínima para aprobar es 12.0.
 La cantidad de desaprobados, las notas menores a 12.0 se considera desaprobado.
*/
select PERIODO, COUNT(curso) curso, SUM(ma)Matriculados, SUM(aprobado)aprobado,
SUM(desaprobado)desaprobado from (
		SELECT 
		YEAR(FecMatricula)PERIODO,CPR.IdCurso curso,count(*)ma,
		sum(case when Promedio >= 12.0 then  1 else 0 end) aprobado,
		sum(case when Promedio < 12.0 then  1 else 0 end) desaprobado
		 FROM 
		EDUTEC.dbo.Curso CUR
		INNER JOIN EDUTEC.dbo.CursoProgramado CPR ON CUR.IdCurso = CPR.IdCurso
		INNER JOIN EDUTEC.DBO.Matricula MA ON MA.IdCursoProg = CPR.IdCursoProg
		INNER JOIN EDUTEC.DBO.Alumno AL ON AL.IdAlumno = MA.IdAlumno
GROUP BY CPR.IdCurso,YEAR(FecMatricula)--,Matriculados--,AL.IdAlumno
--ORDER BY PERIODO
) as t
group by PERIODO
order by PERIODO


/*
Pregunta 7
De cada curso del periodo 2011-10 se necesita saber quién es el alumno con la menor nota, 
se debe mostrar los empates. La plantilla del resultado es la siguiente:
*/

SELECT CUR.IdCurso, CUR.NomCurso,  min(Promedio)  promedio 
FROM 
EDUTEC.dbo.Curso CUR
INNER JOIN EDUTEC.dbo.CursoProgramado CPR ON CUR.IdCurso = CPR.IdCurso
INNER JOIN EDUTEC.DBO.Matricula MA ON MA.IdCursoProg = CPR.IdCursoProg
--INNER JOIN EDUTEC.DBO.Alumno AL ON AL.IdAlumno = MA.IdAlumno
where IdCiclo = '2011-10'
GROUP BY CUR.IdCurso, CUR.NomCurso



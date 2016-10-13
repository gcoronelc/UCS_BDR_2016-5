/*
1. Se necesita saber los tres 3 cursos que han tenido mayor demanda en el año 2011 (Programados en el 2011). 
Los cursos que tienen mayor demanda son los que registran mayor cantidad de alumnos matriculados.
*/
SELECT TOP (3) WITH TIES B.IdCurso, C.NomCurso, SUM(Matriculados) AS Matriculados
FROM [EduTec].[dbo].[CursoProgramado] B
	 INNER JOIN [EduTec].[dbo].[Curso] C
		ON	C.IdCurso = B.IdCurso
WHERE B.IdCiclo LIKE '2011%'
GROUP BY B.IdCurso, C.NomCurso
ORDER BY 3 DESC

/*
2. Se necesita saber cuánto invierte cada alumno por año en cursos de EduTec. Se debe considerar la fecha en que realiza la matricula.
*/
SELECT A.IdAlumno, B.NomAlumno,  B.ApeAlumno, YEAR(A.FecMatricula) AS [Año], SUM(C.PreCursoProg) AS [Inversión]
FROM [EduTec].[dbo].[Matricula] A
	 INNER JOIN [EduTec].[dbo].[Alumno] B
		ON	A.idAlumno = B.idAlumno
	 INNER JOIN [EduTec].[dbo].[CursoProgramado] C
		ON	C.IdCursoProg = A.IdCursoProg
GROUP BY A.IdAlumno, B.NomAlumno,  B.ApeAlumno, YEAR(A.FecMatricula)
ORDER BY 4, 1

/*
3. Se necesita saber que cursos del ciclo 2015-10 tienen menos de 10 matriculados.
*/
SELECT B.IdCurso AS [COD. CURSO], C.NomCurso AS [NOM. CURSO], SUM(Matriculados) AS [MATRICULADOS]
FROM [EduTec].[dbo].[CursoProgramado] B
	 INNER JOIN [EduTec].[dbo].[Curso] C
		ON	C.IdCurso = B.IdCurso
WHERE B.IdCiclo LIKE '2015-10'
GROUP BY B.IdCurso, C.NomCurso
HAVING SUM(Matriculados) < 10

/*
4. Se necesita saber el profesor que tiene más cursos programados en cada ciclo del año 2015. Se debe mostrar los empates.
*/
SELECT A.IdCiclo AS [CICLO], A.IdProfesor AS [COD.PROF], B.NomProfesor AS [NOM.PROF.], COUNT(DISTINCT A.IdCurso) AS [CURSOS]
FROM [EduTec].[dbo].[CursoProgramado] A
	 INNER JOIN [EduTec].[dbo].[Profesor] B
		ON	A.IdProfesor = B.IdProfesor
	 INNER JOIN (
					--Máximo número de cursos programados en el ciclo para los profesores
					SELECT C.IdCiclo, MAX(CURSOS) AS [Maximo]
					FROM (
							--Cursos programados a cada profesor por ciclo 2015-x
							SELECT A.IdCiclo, A.IdProfesor, COUNT(DISTINCT A.IdCurso) AS [CURSOS]
							FROM [EduTec].[dbo].[CursoProgramado] A
							WHERE A.IdCiclo LIKE '2015%'
								AND A.IdProfesor IS NOT NULL
							GROUP BY A.IdCiclo, A.IdProfesor
					) AS C
					GROUP BY C.IdCiclo
				) AS C
		ON	C.IdCiclo = A.IdCiclo
GROUP BY A.IdCiclo, A.IdProfesor, B.NomProfesor, C.Maximo
HAVING COUNT(DISTINCT A.IdCurso) = C.Maximo --Sólo mostrar los cursos de los profesores que cumplan con el máximo de cursos programados.

/*
5. De la base de datos EduTec, de cada estudiante se necesita saber los siguientes datos:
Cantidad de cursos matriculados
Cantidad de cursos aprobados (Promedio >= 12.0).
Cantidad de cursos desaprobados (Promedio < 12.0).
*/
SELECT	A.IdAlumno AS [COD.ALUMNO], B.NomAlumno + ' ' + B.ApeAlumno AS [NOM.ALUMNO],
		COUNT(*) AS [CURSOS], 
		SUM((CASE WHEN A.Promedio >= 12 THEN 1 ELSE 0 END)) AS [APROBADOS],
		SUM((CASE WHEN A.Promedio < 12 THEN 1 ELSE 0 END)) AS [DESAPROBADOS]
FROM [EduTec].[dbo].[Matricula] A
	 INNER JOIN [EduTec].[dbo].[Alumno] B
		ON	A.IdAlumno = B.IdAlumno
GROUP BY A.IdAlumno, B.NomAlumno, B.ApeAlumno

/*
6. De cada año se necesita saber:
La cantidad de cursos programados.
La cantidad de alumnos matriculados. Cada matricula se considera un alumno matriculado.
El importe recaudado por el pago de los alumnos matriculados.
La cantidad de aprobados, la nota mínima para aprobar es 12.0.
La cantidad de desaprobados, las notas menores a 12.0 se considera desaprobado.
*/
SELECT	LEFT(A.IdCiclo, 4) AS [AÑO], 
		COUNT(DISTINCT A.IdCurso) AS [CURSOS],
		COUNT(B.IdAlumno) AS [ALUMNOS],
		SUM(A.PreCursoProg) AS [RECAUDADOS],
		SUM((CASE WHEN B.Promedio >= 12 THEN 1 ELSE 0 END)) AS [APROBADOS],
		SUM((CASE WHEN B.Promedio < 12 THEN 1 ELSE 0 END)) AS [DESAPROBADOS]
FROM [EduTec].[dbo].[CursoProgramado] A
	 INNER JOIN [EduTec].[dbo].[Matricula] B
		ON A.IdCursoProg = B.IdCursoProg
GROUP BY LEFT(A.IdCiclo, 4)

/*
7. De cada curso del periodo 2011-10 se necesita saber quién es el alumno con la menor nota, se debe mostrar los empates. 
*/
SELECT TOP (1) WITH TIES B.IdCurso AS [cod_curso], C.NomCurso AS [nom_curso], A.IdAlumno AS [cod_alumno], D.NomAlumno + ' ' + D.ApeAlumno AS [nom_alumno],
	   MIN(A.promedio) AS [promedio]
FROM [EduTec].[dbo].[Matricula] A
	 INNER JOIN [EduTec].[dbo].[CursoProgramado] B
		ON	B.IdCursoProg = A.IdCursoProg
	 INNER JOIN [EduTec].[dbo].[Curso] C
		ON	C.idCurso = B.idCurso
	 INNER JOIN [EduTec].[dbo].[Alumno] D
		ON	D.IdAlumno = A.IdAlumno
WHERE B.IdCiclo = '2011-10'
GROUP BY B.IdCurso, C.NomCurso, A.IdAlumno, D.NomAlumno, D.ApeAlumno
ORDER BY 5


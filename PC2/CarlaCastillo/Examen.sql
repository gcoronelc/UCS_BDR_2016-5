--1. Cu�ntos proveedores hay por pa�s. Base de datos NorthWin.
SELECT A.Country AS [Pa�s], COUNT(*) AS [Proveedores]
FROM [Northwind].[dbo].[Suppliers] A
GROUP BY A.Country;

--2. Cuantos empleados se tienen en cada ciudad de cada pa�s. Base de datos NorthWin.
SELECT A.Country, A.City, COUNT(*) AS [Empleados]
FROM [Northwind].[dbo].[Employees] A
GROUP BY A.Country, A.City;

--3. Se necesita saber cu�ntas matriculas se registraron por mes en el a�o 2011. Base de datos EDUTEC.
SELECT DATEPART(MONTH, FecMatricula) AS [Nro. de Mes], DATENAME(MONTH, FecMatricula) AS [Nombre Mes], COUNT(*) AS [Matr�culas]
FROM [EduTec].[dbo].[Matricula]
WHERE YEAR(FecMatricula) = 2011
GROUP BY DATEPART(MONTH, FecMatricula), DATENAME(MONTH, FecMatricula)
ORDER BY 1;

--4. Se necesita saber cu�ntas veces se ha programado cada curso en el 2014. Base de datos EUTEC
SELECT A.IdCurso, B.NomCurso, COUNT(*) AS [CanProgramaci�n]
FROM [EduTec].[dbo].[CursoProgramado] A
	 INNER JOIN [EduTec].[dbo].[Curso] B
		ON	A.IdCurso = A.IdCurso
WHERE A.IdCiclo LIKE '2014%'
GROUP BY A.IdCurso, B.NomCurso
ORDER BY A.IdCurso;

/*5. De cada ciclo programado del a�o 2012 se necesita saber:
La cantidad de cursos que se han programado.
La cantidad de vacantes programadas (Vacantes + Matriculados).
La cantidad de matr�culas.
El precio promedio.
El importe proyectado.
El importe recaudado.
*/
SELECT	A.IdCiclo, COUNT(DISTINCT A.IdCurso) AS [Cant. Prog.], SUM(A.Vacantes + A.Matriculados) AS [Vac. Prog.],
		SUM(A.Matriculados) AS [Matriculas], 
		AVG(A.PreCursoProg) AS [Pre. Promedio],
		SUM(A.PreCursoProg * (A.Matriculados + A.Vacantes)) AS [Proyectado],
		SUM(A.PreCursoProg * A.Matriculados) AS [Recaudado]
FROM [EduTec].[dbo].[CursoProgramado] A
WHERE A.IdCiclo LIKE '2012%'
GROUP BY A.IdCiclo
ORDER BY 1;
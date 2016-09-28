-- SELECCION DE COLUMNAS
-- ==========================

-- Ejercicio 1
-- Desarrolle una sentencia SELECT para consultar el 
-- id, nombre, apellido y email de todos los alumnos. 
-- Base de datos EDUTEC. 

SELECT IdAlumno, NomAlumno, ApeAlumno, EmailAlumno
FROM EduTec.DBO.Alumno;
go


-- Ejercicio 2
-- Desarrolle una sentencia SELECT para consultar el 
-- id, nombre, apellido y email de todos los profesores. 
-- Base de datos EDUTEC.

select IdProfesor, NomProfesor, ApeProfesor, EmailProfesor
from EduTec.dbo.Profesor;
go


-- Ejercicio 3
-- Desarrolle una sentencia SELECT para obtener de cada 
-- curso programado la siguiente información: 
-- id, id del curso, id del ciclo, Precio y horario. 
-- Base de datos EDUTEC.

select IdCursoProg, IdCurso, IdCiclo, PreCursoProg, Horario
from EduTec.dbo.CursoProgramado;
go





-- Campos calculados
-- ==================

-- Ejercicio 6
-- Desarrollar una sentencia SELECT que permita obtener el importe 
-- que se obtendría por cada curso programado si se logra vender 
-- todas las vacantes programadas. 
-- Base de datos EDUTEC.

select IdCursoProg, IdCurso, IdCiclo, PreCursoProg, 
	(Vacantes + Matriculados) "Vacantes Programadas",
	(Vacantes + Matriculados) * PreCursoProg "Ingresos Proyectados",
	Matriculados * PreCursoProg "Ingresos Reales"
from EduTec.dbo.CursoProgramado;
go


-- Ejercicio 7
-- Desarrollar una sentencia SELECT que permita obtener el importe 
-- recaudado por cada curso programado. 
-- Base de datos EDUTEC.

select IdCursoProg, IdCurso, IdCiclo, PreCursoProg, 
	Vacantes, Matriculados,
	Matriculados * PreCursoProg "Ingresos Reales"
from EduTec.dbo.CursoProgramado;
go


-- Ejercicio 8
-- Desarrollar una sentencia SELECT para consultar 
-- el nombre y apellido de un empleado en una sola columna. 
-- Base de datos RH.

select idempleado ID, apellido + ', ' + nombre NOMBRE
from RH.dbo.empleado;
go

-- =========================
-- FILTRO DE FILAS
-- =========================

--	Operadores de Comparación

-- Ejercicio 11
-- Desarrollar una sentencia SELECT para consultar 
-- los empleados del departamento de contabilidad. 
-- Base de datos RH.

-- Paso 1: Consultar la tabla de departamentos
-- Codigo de contabilidad: 101

select * from RH.dbo.departamento;
go

select *
from rh.dbo.empleado
where iddepartamento = 101;
go


-- Ejercicio 12
-- Desarrolle una sentencia SELECT para consultar los 
-- cursos programados del ciclo 2013-02 de la base 
-- de datos EDUTEC.

select *
from EduTec.dbo.CursoProgramado
where IdCiclo = '2013-02';
go


-- Operadores Logicos

-- Ejercicio 16
-- Desarrollar una sentencia SELECT para consultar 
-- los empleados que se desempeñan como gerentes. 
-- Base de datos RH.

-- Paso 1: Cuales son los codigos de gerentes
-- Codigos: C01 y C02

select * from rh.dbo.cargo;
go

-- Paso 2: Desarrollar la consulta

select * from rh.dbo.empleado
where idcargo='C01' OR idcargo='C02';
go

-- Ejercicio 17
-- Desarrolle una sentencia SELECT para consultar los 
-- cursos programados al profesor GUSTAVO CORONEL en 
-- el ciclo 2013-02 de la base de datos EDUTEC.

-- Paso 1: Averiguar el codigo de GUSTAVO CORONEL
-- Código: P002

select * from EduTec.dbo.Profesor
where ApeProfesor like '%Coronel%' and NomProfesor like '%Gustavo%';
go

-- Paso 2: Desarrollar la consulta

select * from EduTec.dbo.CursoProgramado
where IdProfesor = 'P002' AND IdCiclo = '2013-02';
go

-- OPERADOR LIKE

-- Permite comparar una cadena con un patrón.
-- Para crear el patrón se utilizan caracteres como: % _ [] ^ 

-- Ejercicio 21
-- Desarrollar una sentencia SELECT que permita consultar 
-- los empleados que su nombre finaliza con la letra "O". 
-- Base de datos RH.

select *
from rh.dbo.empleado
where nombre like '%O';
go

-- Ejercicio 22
-- Desarrollar una sentencia SELECT que permita 
-- consultar los empleados que su apellido tiene 
-- en la segunda posición la letra "A" ó "O". 
-- Base de datos RH.

select *
from rh.dbo.empleado
where apellido  like '_[AO]%';
go

-- Manipulación de valores NULL
-- -----------------------------

-- Cualquier operación con NULL su valor es NULL.

select 50 + null;
go

select 50 + ISNULL(null,0);
go

-- Ejercicio 27
-- Desarrollar una sentencia SELECT que permita averiguar 
-- los cursos que aún no tienen profesor. 
-- Base de datos EDUCA.

select * from educa.dbo.CURSO
where cur_profesor is NULL
or cur_profesor = '';
go

declare @cad varchar(10);
set @cad = '   ';
if (@cad = '')
   print 'hola';
go


-- Ejercicio 28
-- Desarrollar una sentencia SELECT para consultar 
-- el ingreso total de cada empleado. 
-- Base de datos RH.

select idempleado, sueldo, ISNULL(comision,0) comision,
	sueldo + ISNULL(comision,0) total
from RH.dbo.empleado;

-- Funciones de fecha y hora
-- ---------------------------

select DATENAME(m,GETDATE());
go

select DATENAME(dw,GETDATE());
go

-- Ejercicio 30
-- Desarrollar una sentencia SELECT para consultar 
-- los empleados que ingresaron a la empresa un mes 
-- de Enero. 
-- Base de datos RH.

select idempleado, apellido, nombre, fecingreso
from RH.dbo.empleado
where MONTH(fecingreso) = 4;
go


















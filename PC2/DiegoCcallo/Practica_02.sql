/*Practica
Alumnos:
-Angel Aldave Romo
-Diego Ccallo Ilachoque
*/

/*BD: Northwind*/

/*Pregunta 1*/
select country, count(1) from Northwind.dbo.Suppliers group by country order by 1;

/*Pregunta 2*/
select country, city, count(1) from Northwind.dbo.employees group by country, city order by 1, 2;

/*BD: Edutec*/

/*Pregunta 3*/
select datepart(MONTH,fecmatricula) nro_mes, datename(MONTH,fecmatricula) nom_mes, COUNT(1) matriculas
  from EduTec.dbo.Matricula
 where year(fecmatricula) = 2011
 group by datepart(MONTH,fecmatricula), datename(MONTH,fecmatricula)
 order by 1;
 
/*Pregunta 4*/
select cu.idcurso, cu.nomcurso, count(1) cantprogramación
  from EduTec.dbo.curso cu
  inner join EduTec.dbo.CursoProgramado cp on cu.idcurso = cp.idcurso
  inner join EduTec.dbo.ciclo ci on ci.idciclo = cp.idciclo
 where year(ci.fecinicio) = 2014
 group by cu.idcurso, cu.nomcurso
 order by cu.idcurso;
 
/*Pregunta 5*/
select ci.idciclo
     , count(cp.idcurso) cant_prog
     , sum(cp.vacantes + cp.matriculados) vac_prog
     , sum(cp.matriculados) matriculas
     , convert( varchar, convert( money, avg(cp.precursoprog)),1) pre_prom
     , convert( varchar, convert( money, sum((cp.vacantes + cp.matriculados) * cp.precursoprog)),1) proyectado
     , convert( varchar, convert( money, sum(cp.matriculados * cp.precursoprog)),1) recaudado
  from EduTec.dbo.CursoProgramado cp
  inner join EduTec.dbo.ciclo ci on ci.idciclo = cp.idciclo
 where year(ci.fecinicio) = 2012
 group by ci.idciclo
 order by ci.idciclo;
 

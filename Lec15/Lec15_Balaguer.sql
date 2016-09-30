select cur.cur_nombre, al.alu_nombre, mat.mat_nota
from educa.dbo.MATRICULA mat
	inner join educa.dbo.ALUMNO al on mat.alu_id=al.alu_id
	inner join educa.dbo.CURSO cur on mat.cur_id=cur.cur_id;

-- Ejercicio 2	
select alu.alu_nombre, convert(varchar,cast(SUM(pag.pag_importe) as money),1) as pago
from educa.dbo.alumno alu
	inner join educa.dbo.PAGO pag on alu.alu_id=pag.alu_id
group by alu.alu_nombre;

-- Ejercicio 3
select cur.cur_nombre, convert(varchar,cast(SUM(pag.pag_importe) as money),1) as pago
from educa.dbo.CURSO cur
	inner join educa.dbo.PAGO pag on cur.cur_id=pag.cur_id
group by cur.cur_nombre;

-- Ejercicio 4
select dep.nombre, convert(varchar,cast(SUM(emp.sueldo) as money),1) as planilla
from rh.dbo.departamento dep
	inner join rh.dbo.empleado emp on dep.iddepartamento=emp.iddepartamento
group by dep.nombre;

select ubi.ciudad, COUNT(emp.idempleado)
from rh.dbo.ubicacion ubi
	inner join rh.dbo.departamento dep on ubi.idubicacion=dep.idubicacion
	inner join rh.dbo.empleado emp on dep.iddepartamento=emp.iddepartamento
group by ubi.ciudad;




CREATE DATABASE educa;
GO

use educa;
go

select * from educa.sys.objects
where type='U';
GO


-- Tabla Alumno
CREATE TABLE educa.dbo.ALUMNO
( 
 alu_id               INT  NOT NULL ,
 alu_nombre           varchar(100)  NOT NULL ,
 alu_direccion        varchar(100)  NOT NULL ,
 alu_telefono         varchar(20)  NULL ,
 alu_email            varchar(50)  NULL  
);
GO


-- Tabla Curso
CREATE TABLE dbo.CURSO
( 
 cur_id               INT IDENTITY ( 1,1 ) NOT NULL ,
 cur_nombre           varchar(100)  NOT NULL ,
 cur_vacantes         int  NOT NULL ,
 cur_matriculados     int  NOT NULL ,
 cur_profesor         varchar(100)  NULL ,
 cur_precio           money  NOT NULL 
);
GO


CREATE TABLE dbo.MATRICULA
( 
 cur_id               INT  NOT NULL ,
 alu_id               INT  NOT NULL ,
 mat_fecha            datetime  NOT NULL ,
 mat_precio           money  NOT NULL ,
 mat_cuotas           int  NOT NULL ,
 mat_nota             int  NULL 
);
GO

CREATE TABLE dbo.PAGO
( 
 cur_id               INT  NOT NULL ,
 alu_id               INT  NOT NULL ,
 pag_cuota            int  NOT NULL ,
 pag_fecha            datetime  NOT NULL ,
 pag_importe          money  NOT NULL 
);
GO

-- Claves Primarias

-- Tabla: Curso
ALTER TABLE educa.dbo.CURSO
   ADD CONSTRAINT PK_CURSO
   PRIMARY KEY CLUSTERED ( cur_id );
GO

-- Tabla: Alumno
ALTER TABLE educa.dbo.ALUMNO
   ADD CONSTRAINT PK_ALUMNO
   PRIMARY KEY CLUSTERED ( alu_id );
GO

-- Tabla: Matricula
ALTER TABLE educa.dbo.MATRICULA
   ADD CONSTRAINT PK_MATRICULA
   PRIMARY KEY CLUSTERED ( cur_id, alu_id );
GO
		
-- Tabla: Matricula
ALTER TABLE educa.dbo.PAGO
   ADD CONSTRAINT PK_PAGO
   PRIMARY KEY CLUSTERED ( cur_id, alu_id, pag_cuota );
GO		
		
-- CLAVE FORANEA

-- Tabla Matricula - Curso

ALTER TABLE educa.dbo.MATRICULA
   ADD CONSTRAINT FK_MATRICULA_CURSO
   FOREIGN KEY ( cur_id  ) 
   REFERENCES educa.dbo.CURSO;
GO

-- Tabla Matricula - -Alumno

ALTER TABLE educa.dbo.MATRICULA
   ADD CONSTRAINT FK_MATRICULA_ALUMNO
   FOREIGN KEY ( alu_id  ) 
   REFERENCES educa.dbo.ALUMNO;
GO

-- Tabla Pago - Matricula

ALTER TABLE educa.dbo.PAGO
   ADD CONSTRAINT FK_PAGO_MATRICULA
   FOREIGN KEY ( cur_id, alu_id  ) 
   REFERENCES educa.dbo.MATRICULA;
GO			
	
	
-- VALORES UNICOS - UNIQUE

-- NOMBRE DE CURSO

ALTER TABLE educa.dbo.CURSO
   ADD CONSTRAINT U_CURSO_NOMBRE
   UNIQUE ( cur_nombre  ) ;
GO	


-- NOMBRE DEL ALUMNO

ALTER TABLE educa.dbo.ALUMNO
   ADD CONSTRAINT U_ALUMNO_NOMBRE
   UNIQUE ( alu_nombre  ) ;
GO	

-- CORREO DEL ALUMNO

ALTER TABLE educa.dbo.ALUMNO
   ADD CONSTRAINT U_ALUMNO_EMAIL
   UNIQUE ( alu_email  ) ;
GO		
		
		
-- RESTRICCIONES TIPO CHECK

-- CURSO: Las vacantes debe ser mayor que cero.

ALTER TABLE educa.dbo.CURSO	
   ADD CONSTRAINT CHK_CURSO_VACANTES
   CHECK ( cur_vacantes > 0  ) ;
GO

-- CURSO: Los matriculados debe ser mayor o igual a cero y menor o igual que las vacantes.

ALTER TABLE educa.dbo.CURSO	
   ADD CONSTRAINT CHK_CURSO_MATRICULADOS
   CHECK ( cur_matriculados >= 0 AND cur_matriculados <= cur_vacantes  ) ;
GO


-- CURSO: El precio debe ser mayor que cero.

ALTER TABLE educa.dbo.CURSO	
   ADD CONSTRAINT CHK_CURSO_PRECIO
   CHECK ( cur_precio > 0 ) ;
GO


-- MATRICULA: El precio debe ser mayor que cero.

ALTER TABLE educa.dbo.MATRICULA	
   ADD CONSTRAINT CHK_MATRICULA_PRECIO
   CHECK ( mat_precio > 0 ) ;
GO


-- MATRICULA: Las cuotas debe ser mayor o igual que uno.

ALTER TABLE educa.dbo.MATRICULA	
   ADD CONSTRAINT CHK_MATRICULA_CUOTAS
   CHECK ( mat_cuotas > 0 ) ;
GO

-- MATRICULA: La nota de ser NULL o un valor entre 0 y 20.

ALTER TABLE educa.dbo.MATRICULA	
   ADD CONSTRAINT CHK_MATRICULA_NOTA
   CHECK ( mat_nota is null  OR (mat_nota between 0 and 20) ) ;
GO


-- PAGO: El importe debe ser mayor que cero.

ALTER TABLE educa.dbo.PAGO	
   ADD CONSTRAINT CHK_PAGO_IMPORTE
   CHECK ( pag_importe > 0 ) ;
GO

-- RESTRICCIÓN: DEFAULT

ALTER TABLE educa.dbo.CURSO
   ADD CONSTRAINT D_CURSO_MATRICULADOS
   DEFAULT ( 0  )  FOR CUR_MATRICULADOS ;
GO
		

-- INSERTAR DATOS EN TABLA CURSO

SET IDENTITY_INSERT dbo.Curso ON;
GO

INSERT INTO CURSO(CUR_ID,CUR_NOMBRE,CUR_VACANTES,CUR_PRECIO,CUR_PROFESOR)
VALUES(1,'SQL Server Implementación',24,1000.0,'Gustavo coronel');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(2,'SQL Server Administración',24,1000.0,'Gustavo coronel');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(3,'Inteligencia de Negocios',24,1500.0,'Sergio Matsukawa');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(4,'Programación Transact-SQL',24,1200.0,NULL);

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(5,'Java Fundamentos',24,1600.0,'Gustavo Coronel');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(6,'Java Cliente-Servidor',24,1600.0,'Gustavo Coronel');

INSERT INTO CURSO(CUR_ID,CUR_NOMBRE,CUR_VACANTES,CUR_PRECIO,CUR_PROFESOR)
VALUES(7,'GESTION DE PROYECTOS',24,2200.0,'RICARDO MARCELO');
GO

SET IDENTITY_INSERT dbo.Curso OFF;
GO		

SELECT * FROM DBO.CURSO;


-- INSERTAR DATOS EN TABLA ALUMNO

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES
( 1,'YESENIA VIRHUEZ','LOS OLIVOS','986412345','yesenia@hotmail.com'),
( 2,'OSCAR ALVARADO FERNANDEZ','MIRAFLORES',NULL,'oscar@gmail.com'),
( 3,'GLADYS REYES CORTIJO','SAN BORJA','875643562','gladys@hotmail.com'),
( 4,'SARA RIEGA FRIAS','SAN ISIDRO',NULL,'sara@yahoo.com'),
( 5,'JHON VELASQUEZ DEL CASTILLO','LOS OLIVOS','78645345','jhon@movistar.com'),
( 6,'RODRIGUEZ ROJAS, RENZO ROBERT','SURCO','673465235','rrodrigiez@gmail.com'),
( 7,'CALERO MORALES, EMELYN DALILA','LA MOLINA','896754652','ecalero@peru.com'),
( 8,'KAREN FUENTES','San Isidro','555-5555','KAFUENTES@HOTMAIL.COM'),
( 9,'Yamina Ruiz','San Isidro','965-4521','yami_ruiz@gmail.com'),
(10,'MARIA EULALIA VELASQUEZ TORVISCO','SURCO','6573456','mvelasques@gmail.com'),
(11,'FIORELLA LIZET VITELLA REYES','SAN BORJA','5468790','fvitela@outlook.com');
GO
		
SELECT * FROM ALUMNO;

		
-- INSERTAR DATOS EN TABLA MATRICULA

SET DATEFORMAT DMY
GO

DECLARE @ANIO VARCHAR(10);
SET @ANIO =  cast(year(getdate()) as varchar);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(1, 5,'15-04-' + @ANIO +' 10:30',800.0,1,15);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(1, 3,'16-04-' + @ANIO +' 11:45',1000.0,2,18);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(1, 4,'18-04-' +@ANIO +' 08:33',1200.0,3,12);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(2, 1,'15-04-' + @ANIO +' 12:33',800.0,1,16);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(2, 2,'01-05-' + @ANIO +' 15:34',1000.0,2,10);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(2, 3,'03-05-' + @ANIO +' 16:55',1300.0,3,14);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(2, 4,'04-05-' + @ANIO +' 17:00',400.0,1,18);

INSERT INTO dbo.MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
VALUES(2, 5,'06-05-' + @ANIO +' 13:12',750.0,1,17);

GO

SELECT * FROM MATRICULA;

SELECT * FROM CURSO;

-- Actualizar Tabla Curso
-- Se debe actualizar la columna cur_matriculados en la tabla Curso.

UPDATE dbo.CURSO
SET cur_matriculados = (
 SELECT COUNT(*) FROM dbo.MATRICULA
 WHERE dbo.MATRICULA.cur_id = dbo.CURSO.cur_id );
GO


		
-- INSERTAR DATOS EN TABLA PAGO

	
SET DATEFORMAT DMY
GO

DECLARE @ANIO VARCHAR(10)
SET @ANIO = CAST(YEAR(GETDATE()) AS VARCHAR)
INSERT INTO DBO.PAGO VALUES(1,3,1,'16-04-' + @ANIO,500)
INSERT INTO DBO.PAGO VALUES(1,3,2,'16-05-' + @ANIO,500)
INSERT INTO DBO.PAGO VALUES(1,4,1,'18-04-' + @ANIO,400)
INSERT INTO DBO.PAGO VALUES(1,4,2,'18-05-' + @ANIO,400)
INSERT INTO DBO.PAGO VALUES(2,1,1,'15-04-' + @ANIO,800)
INSERT INTO DBO.PAGO VALUES(2,2,1,'01-05-' + @ANIO,500)
INSERT INTO DBO.PAGO VALUES(2,3,1,'03-05-' + @ANIO,430)
INSERT INTO DBO.PAGO VALUES(2,3,2,'03-06-' + @ANIO,430)
INSERT INTO DBO.PAGO VALUES(2,4,1,'04-05-' + @ANIO,400)
INSERT INTO DBO.PAGO VALUES(2,5,1,'06-05-' + @ANIO,750)
GO

SELECT * FROM PAGO;
GO

SELECT 
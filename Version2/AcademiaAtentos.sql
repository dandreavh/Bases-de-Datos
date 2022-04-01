-- MySQL Script generated by MySQL Workbench
-- Thu 20 Jan 2022 02:20:37 PM CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
-- AUTHOR: DANDREAVH

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema academia-atentos-db
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `academia-atentos-db` ;
USE `academia-atentos-db` ;

-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Poblaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Poblaciones` (
  `idPoblacion` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Provincia` VARCHAR(45) NULL,
  `CodigoPostal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPoblacion`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Personas`
-- -----------------------------------------------------
ALTER TABLE Personas MODIFY TABLE (
  `idPersona` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(45) NULL,
  `Telefono` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) CHARACTER SET 'ascii' NULL,
  `Poblaciones_idPoblacion` INT NOT NULL,
  PRIMARY KEY (`idPersona`),
  INDEX `fk_Personas_Poblaciones1_idx` (`Poblaciones_idPoblacion` ASC) VISIBLE,
  CONSTRAINT `fk_Personas_Poblaciones1`
    FOREIGN KEY (`Poblaciones_idPoblacion`)
    REFERENCES `academia-atentos-db`.`Poblaciones` (`idPoblacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Empleados` (
  `idEmpleado` INT NOT NULL,
  `Puesto` ENUM('Profesor', 'Auxiliar', 'Coodinador', 'Administrativo') NOT NULL,
  `Titulacion` VARCHAR(45) NULL,
  `Fecha_alta` DATE NULL,
  `Fecha_baja` DATE NULL,
  `Personas_idPersona` INT NOT NULL,
  `Empleados_idCoordinador` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_Empleados_Personas1_idx` (`Personas_idPersona` ASC) VISIBLE,
  INDEX `fk_Empleados_Empleados1_idx` (`Empleados_idCoordinador` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Personas1`
    FOREIGN KEY (`Personas_idPersona`)
    REFERENCES `academia-atentos-db`.`Personas` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleados_Empleados1`
    FOREIGN KEY (`Empleados_idCoordinador`)
    REFERENCES `academia-atentos-db`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Tutores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Tutores` (
  `idTutor` INT NOT NULL,
  `Tipo` ENUM('Madre', 'Padre', 'Otro') NULL,
  `Preferencia_contacto` VARCHAR(45) NULL,
  `Personas_idPersona` INT NOT NULL,
  PRIMARY KEY (`idTutor`),
  INDEX `fk_Tutores_Personas1_idx` (`Personas_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Tutores_Personas1`
    FOREIGN KEY (`Personas_idPersona`)
    REFERENCES `academia-atentos-db`.`Personas` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Alumnos` (
  `idAlumno` INT NOT NULL,
  `Curso` VARCHAR(45) NOT NULL,
  `Colegio` VARCHAR(45) NULL,
  `Trastorno` TINYINT NOT NULL,
  `Repetidor` TINYINT NULL,
  `Suspensos` INT NULL,
  `Personas_idPersona` INT NOT NULL,
  `Tutores_idTutor` INT NOT NULL,
  PRIMARY KEY (`idAlumno`),
  INDEX `fk_Alumnos_Personas1_idx` (`Personas_idPersona` ASC) VISIBLE,
  INDEX `fk_Alumnos_Tutores1_idx` (`Tutores_idTutor` ASC) VISIBLE,
  CONSTRAINT `fk_Alumnos_Personas1`
    FOREIGN KEY (`Personas_idPersona`)
    REFERENCES `academia-atentos-db`.`Personas` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumnos_Tutores1`
    FOREIGN KEY (`Tutores_idTutor`)
    REFERENCES `academia-atentos-db`.`Tutores` (`idTutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Recibos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Recibos` (
  `idRecibo` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Cantidad` DECIMAL(2) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Modo` ENUM('Efectivo', 'Tarjeta', 'Bizum', 'Transferencia') NULL,
  `Alumnos_idAlumno` INT NOT NULL,
  PRIMARY KEY (`idRecibo`),
  INDEX `fk_Recibos_Alumnos1_idx` (`Alumnos_idAlumno` ASC) VISIBLE,
  CONSTRAINT `fk_Recibos_Alumnos1`
    FOREIGN KEY (`Alumnos_idAlumno`)
    REFERENCES `academia-atentos-db`.`Alumnos` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Aulas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Aulas` (
  `idAula` INT NOT NULL,
  `Capacidad` INT NULL,
  `Medios` VARCHAR(45) NULL,
  PRIMARY KEY (`idAula`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Modalidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Modalidades` (
  `idModalidad` INT NOT NULL,
  `Tipo_modalidad` VARCHAR(80) NULL,
  `Tipo_asistencia` ENUM('Onlines', 'Presencial', 'Mixto') NULL,
  `Tarifa` DOUBLE NULL,
  PRIMARY KEY (`idModalidad`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Matricula` (
  `Fecha_matricula` DATE NULL,
  `Fecha_inicio` DATE NULL,
  `Alumnos_idAlumno` INT NOT NULL,
  `Modalidades_idModalidad` INT NOT NULL,
  INDEX `fk_Matricula_Alumnos1_idx` (`Alumnos_idAlumno` ASC) VISIBLE,
  INDEX `fk_Matricula_Modalidades1_idx` (`Modalidades_idModalidad` ASC) VISIBLE,
  CONSTRAINT `fk_Matricula_Alumnos1`
    FOREIGN KEY (`Alumnos_idAlumno`)
    REFERENCES `academia-atentos-db`.`Alumnos` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matricula_Modalidades1`
    FOREIGN KEY (`Modalidades_idModalidad`)
    REFERENCES `academia-atentos-db`.`Modalidades` (`idModalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia-atentos-db`.`Horarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia-atentos-db`.`Horarios` (
  `Dia` VARCHAR(45) NULL,
  `Hora` VARCHAR(45) NULL,
  `Alumnos_idAlumno` INT NOT NULL,
  `Empleados_idEmpleado` INT NOT NULL,
  `Aulas_idAula` INT NOT NULL,
  INDEX `fk_Horarios_Alumnos1_idx` (`Alumnos_idAlumno` ASC) VISIBLE,
  INDEX `fk_Horarios_Empleados1_idx` (`Empleados_idEmpleado` ASC) VISIBLE,
  INDEX `fk_Horarios_Aulas1_idx` (`Aulas_idAula` ASC) VISIBLE,
  CONSTRAINT `fk_Horarios_Alumnos1`
    FOREIGN KEY (`Alumnos_idAlumno`)
    REFERENCES `academia-atentos-db`.`Alumnos` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Horarios_Empleados1`
    FOREIGN KEY (`Empleados_idEmpleado`)
    REFERENCES `academia-atentos-db`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Horarios_Aulas1`
    FOREIGN KEY (`Aulas_idAula`)
    REFERENCES `academia-atentos-db`.`Aulas` (`idAula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


---------------------------------------------------------------------------------------------------------------
-- MODIFICACIONES PROPIAS
---------------------------------------------------------------------------------------------------------------
ALTER TABLE Personas ADD CONSTRAINT `fk_Personas_Poblaciones1` FOREIGN KEY (`idPoblacion`)
    REFERENCES `academia-atentos-db`.`Poblaciones` (`idPoblacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Empleados ADD CONSTRAINT `fk_Personas_Empleados` FOREIGN KEY (`Personas_idPersona`)
    REFERENCES `academia-atentos-db`.`Personas` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Empleados ADD CONSTRAINT `fk_Empleados_Empleados` FOREIGN KEY (`Empleados_idCoordinador`)
    REFERENCES `academia-atentos-db`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Tutores ADD CONSTRAINT `fk_Personas_Tutores` FOREIGN KEY (`Personas_idPersona`)
    REFERENCES `academia-atentos-db`.`Personas` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Alumnos ADD CONSTRAINT `fk_Personas_Alumnos` FOREIGN KEY (`Personas_idPersona`)
    REFERENCES `academia-atentos-db`.`Personas` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Alumnos ADD CONSTRAINT `fk_Tutores_Alumnos` FOREIGN KEY (`Tutores_idTutor`)
    REFERENCES `academia-atentos-db`.`Tutores` (`idTutor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
  
   ALTER TABLE Recibos ADD CONSTRAINT `fk_Recibos_Alumnos` FOREIGN KEY (`Alumnos_idAlumno`)
    REFERENCES `academia-atentos-db`.`Alumnos` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Matriculas ADD CONSTRAINT `fk_Matriculas_Modalidades` FOREIGN KEY (`Modalidades_idModalidad`)
    REFERENCES `academia-atentos-db`.`Modalidades` (`idModalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Matriculas ADD CONSTRAINT `fk_Matriculas_Alumnos` FOREIGN KEY (`Alumnos_idAlumno`)
    REFERENCES `academia-atentos-db`.`Alumnos` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
  
   ALTER TABLE Horarios ADD CONSTRAINT `fk_Horarios_Aula` FOREIGN KEY (`Aulas_idAula`)
    REFERENCES `academia-atentos-db`.`Aulas` (`idAula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
 
   ALTER TABLE Horarios ADD CONSTRAINT `fk_Horarios_Alumnos` FOREIGN KEY (`Alumnos_idAlumno`)
    REFERENCES `academia-atentos-db`.`Alumnos` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
   ALTER TABLE Horarios ADD CONSTRAINT `fk_Horarios_Grupos` FOREIGN KEY (`Grupos_idGrupo`)
    REFERENCES `academia-atentos-db`.`Grupos` (`idGrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
  ALTER TABLE Grupos ADD CONSTRAINT `fk_Grupos_Profesores` FOREIGN KEY (`Empleados_idProfesor`)
    REFERENCES `academia-atentos-db`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
   
  ALTER TABLE `academia-atentos-db`.Horarios ADD CONSTRAINT Horarios_PK PRIMARY KEY (Dia,Hora,Aulas_idAula,Grupos_idGrupo);
  
 ALTER TABLE `academia-atentos-db`.Matriculas ADD CONSTRAINT Matriculas_PK PRIMARY KEY (Fecha_matricula,Fecha_inicio,Alumnos_idAlumno);

-- -----------------------------------------------------
-- CONSULTAS
-- -----------------------------------------------------
 -- Nombre y apellidos de los alumnos en una misma columna que pagaron más que la media durante el año 2020 en Tomares. Se debe indicar la cantidad pagada y la fecha del recibo
SELECT CONCAT_WS(' ',p.Nombre, p.Apellidos) 'Alumno', DATE_FORMAT(r.Fecha, "%d %M %Y") 'Fecha de Pago', CONCAT(r.Cantidad, '€') Cantidad
FROM Personas p INNER JOIN Alumnos a INNER JOIN Recibos r INNER JOIN Poblaciones p2 
				ON p.idPersona = a.Personas_idPersona 
				AND r.Alumnos_idAlumno = a.idAlumno
				AND p2.idPoblacion = p.idPoblacion 
WHERE r.Cantidad > (SELECT AVG(r2.Cantidad) FROM Recibos r2)
					AND YEAR(r.Fecha) = 2020
					AND p2.Nombre = 'Tomares'
ORDER BY p.Nombre; 


 -- el profesor que haya estado en activo durante más tiempo, pero que ya no trabaje en la academia
SELECT CONCAT_WS (' ', p.Nombre, p.Apellidos) Profesor, e.Fecha_alta , e.Fecha_baja, DATEDIFF(e.Fecha_baja, e.Fecha_alta) Dias_trabajados 
FROM Personas p INNER JOIN Empleados e 
	ON p.idPersona = e.Personas_idPersona
WHERE e.Puesto = 'Profesor' 
	AND DATEDIFF(e.Fecha_alta, e.Fecha_baja) = (SELECT MIN(DATEDIFF(e2.Fecha_alta, e2.Fecha_baja)) 
												FROM  Empleados e2 
												WHERE e2.Puesto = 'Profesor');
			
											
-- el empleado que sea coordinador de todos, porque es el dueño de la academia
SELECT DISTINCT CONCAT_WS (' ', p.Nombre, p.Apellidos, ', que vive en', p2.Nombre,'-', p2.Provincia, ', es el dueño de Atentos y cobra', 
						   e.Salario, '€') 'Datos del propietario'   
FROM Personas p INNER JOIN Empleados e INNER JOIN Empleados e2 INNER JOIN Poblaciones p2
	ON p.idPersona = e.Personas_idPersona  
	AND e.idEmpleado = e2.Empleados_idCoordinador
	AND p2.idPoblacion = p.idPoblacion 
WHERE e.Empleados_idCoordinador is NULL; 


-- los alumnos de Castilleja de la Cuesta matriculados en Apoyo Escolar que asistan de manera presencial
SELECT p.Nombre, p.Apellidos  
FROM Personas p INNER JOIN Alumnos a INNER JOIN Matriculas m INNER JOIN Modalidades m2 INNER JOIN Poblaciones p2 
	ON p.idPersona = a.Personas_idPersona 
	AND a.idAlumno = m.Alumnos_idAlumno 
	AND m.Modalidades_idModalidad = m2.idModalidad
	AND p.idPoblacion = p2.idPoblacion 
WHERE m2.Tipo_modalidad = 'Apoyo escolar'
AND m2.Tipo_asistencia = 'Presencial'
AND p2.Nombre = 'Castilleja de la Cuesta'
ORDER BY p.Nombre, p.Apellidos;


-- Los alumnos que tienen clase los lunes a las 8 en cualquier aula y de cualquier asignatura
SELECT CONCAT_WS(' ',p.Nombre, p.Apellidos) Alumno, g.Asignatura,  CONCAT('Aula: ', a2.idAula) Aula
FROM Personas p INNER JOIN Alumnos a INNER JOIN Horarios h INNER JOIN Aulas a2 INNER JOIN Grupos g 
	ON p.idPersona = a.Personas_idPersona 
	AND h.Alumnos_idAlumno = a.idAlumno 
	AND h.Aulas_idAula = a2.idAula
	AND h.Grupos_idGrupo = g.idGrupo 
WHERE h.Dia = 'Lunes' AND h.Hora = '20:00'
ORDER BY a2.idAula;


-- Poblaciones de Sevilla con más cantidad de personas relacionadas con la academia
SELECT p2.Nombre, COUNT(*) Cantidad
FROM Personas p INNER JOIN Poblaciones p2
	ON p.IdPoblacion = p2.IdPoblacion
WHERE p2.Provincia = 'Sevilla'
GROUP BY p2.Nombre
HAVING COUNT(Cantidad) > 1;


--------------------------------------------------------------------
-- VISTAS
--------------------------------------------------------------------
-- VISTA 1: el empleado que sea coordinador de todos, porque es el dueño de la academia
CREATE VIEW Jefe AS (SELECT DISTINCT CONCAT_WS (' ', p.Nombre, p.Apellidos, ', que vive en', p2.Nombre,'-', p2.Provincia, ', es el dueño de Atentos y cobra', 
						   e.Salario, '€') 'Datos del propietario'   
FROM Personas p INNER JOIN Empleados e INNER JOIN Empleados e2 INNER JOIN Poblaciones p2
	ON p.idPersona = e.Personas_idPersona  
	AND e.idEmpleado = e2.Empleados_idCoordinador
	AND p2.idPoblacion = p.idPoblacion 
WHERE e.Empleados_idCoordinador is NULL);

 -- VISTA 2: Poblaciones de Sevilla con más cantidad de personas relacionadas con la academia

CREATE VIEW Poblaciones_frecuentes AS (SELECT p2.Nombre, COUNT(*) Cantidad
										FROM Personas p INNER JOIN Poblaciones p2
											ON p.IdPoblacion = p2.IdPoblacion
										WHERE p2.Provincia = 'Sevilla'
										GROUP BY p2.Nombre
										HAVING COUNT(Cantidad) > 1);
									
-- VISTA 3: el profesor que haya estado en activo durante más tiempo, pero que ya no trabaje en la academia
									
CREATE VIEW Profesor_mas_antiguo AS (SELECT CONCAT_WS (' ', p.Nombre, p.Apellidos) Profesor, e.Fecha_alta , e.Fecha_baja, DATEDIFF(e.Fecha_baja, e.Fecha_alta) Dias_trabajados 
										FROM Personas p INNER JOIN Empleados e 
											ON p.idPersona = e.Personas_idPersona
										WHERE e.Puesto = 'Profesor' 
										AND DATEDIFF(e.Fecha_alta, e.Fecha_baja) = (SELECT MIN(DATEDIFF(e2.Fecha_alta, e2.Fecha_baja)) 
																					 FROM  Empleados e2 
																					 WHERE e2.Puesto = 'Profesor'));
										 
-- -----------------------------------------------------------------------------------------------------
-- FUNCIONES, PROCEDIMIENTOS Y TRIGGERS (PROYECTO PARTE 2)
-- --------------------------------------------------------------------------------------------------------																																		
 -- -- FUNCIÓN PARA CALCULAR LA CANTIDAD DE PERSONAS DE UNA LOCALIDAD, PASÁNDOLE COMO PARÁMETRO EL NOMBRE DE DICHA POBLACIÓN
DELIMITER $$
CREATE FUNCTION calcular_personas_por_poblacion(nombrePoblacion VARCHAR(45)) RETURNS int 
DETERMINISTIC
BEGIN
    DECLARE resultado int DEFAULT 0;
   
    SELECT COUNT(*) INTO resultado 
   	FROM Personas p INNER JOIN Poblaciones p2
	ON p.IdPoblacion = p2.IdPoblacion
	WHERE p2.Nombre = nombrePoblacion 
	GROUP BY p2.Nombre;
   
    RETURN resultado;
   
END$$
DELIMITER ;

DROP function calcular_personas_por_poblacion;
SELECT calcular_personas_por_poblacion('Tomares'); 

-- ---------------
-- -- FUNCIÓN PARA CALCULAR EL BALANCE DEL MES en número (QUE SE PASA POR PARÁMETRO) EN UNA POBLACION (QUE SE PASA POR PARÁMETRO)
DELIMITER $$
CREATE FUNCTION calcular_balance_por_mes(numeroMes INT, anio INT, poblacion VARCHAR(45)) RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
    DECLARE resultado DECIMAL(10,2) DEFAULT 0;
   
	SELECT SUM(r.Cantidad) INTO resultado
	FROM Recibos r INNER JOIN Alumnos a 
				   INNER JOIN Personas per 
				   INNER JOIN Poblaciones pob
	ON r.Alumnos_idAlumno = a.idAlumno AND a.Personas_idPersona = per.idPersona AND per.idPoblacion = pob.idPoblacion
	WHERE MONTH(r.Fecha) = numeroMes 
	AND YEAR(r.Fecha) = anio
	AND pob.Nombre = poblacion;
   
    RETURN resultado;
   
END$$
DELIMITER ;

SELECT calcular_balance_por_mes(2,2019,'Tomares'); 
DROP function calcular_balance_por_mes;

-- ---------------
-- -- FUNCIÓN para saber si un alumno existe (pasándole un id)
DELIMITER $$
CREATE FUNCTION existe_alumno(idAlumno int) RETURNS int 
DETERMINISTIC
BEGIN
    DECLARE resultado int default 0;
   
    SELECT a.idAlumno INTO resultado 
   	FROM Alumnos a
   	WHERE a.idAlumno = idAlumno;

   	IF (resultado IS NULL) THEN
     	SET resultado = 0;
    END IF;
   
	RETURN (resultado);
END$$
DELIMITER ;

SELECT existe_alumno(5); 
DROP function existe_alumno;

-- ---------------
-- -- PROCEDIMIENTO QUE EVALÚE SI UN MES HA TENIDO UN BALANCE SUPERIOR A 1.000€ AÑADE UN SUPLEMENTO AL SALARIO DE LOS EMPLEADOS DE ESA POBLACIÓN UN 1% DE SU SALARIO, SIEMPRE QUE ESTE NO SEA SUPERIOR A 3.000€
DELIMITER $$
CREATE PROCEDURE aumentar_salario(IN numeroMes INT, IN anio INT, IN poblacion VARCHAR(45))
BEGIN	
  DECLARE balance NUMERIC(6,2) DEFAULT 0;  
  DECLARE fin INT DEFAULT FALSE;
  DECLARE idEmple INT DEFAULT 0;
  DECLARE oldSalario NUMERIC(6,2) DEFAULT 0;
  DECLARE newSalario NUMERIC(6,2) DEFAULT 0;
  DECLARE cursor1 CURSOR FOR SELECT e.idEmpleado, e.Salario 
  							 FROM Empleados e INNER JOIN Personas per INNER JOIN Poblaciones pob
   						  	 ON e.Personas_idPersona = per.idPersona
   						 	 AND per.idPoblacion = pob.idPoblacion
   						  	 WHERE pob.Nombre = poblacion;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
 SELECT calcular_balance_por_mes(numeroMes,anio,poblacion) INTO balance;
  IF balance >= 1000 THEN
    OPEN cursor1;
     	WHILE fin = FALSE DO
	    	FETCH cursor1 INTO idEmple, oldSalario; 
	    	SET newSalario = (oldSalario * 1.01);
	
			IF oldSalario<3000 THEN
				UPDATE Empleados e SET e.Salario = newSalario
	   			WHERE e.idEmpleado = idEmple;
	   		  ELSE
    			SIGNAL SQLSTATE '45003'
				SET MESSAGE_TEXT = 'No se puede aumentar el salario';	
			END IF;
		END WHILE;
  	CLOSE cursor1;
  ELSE
    SIGNAL SQLSTATE '45003'
	SET MESSAGE_TEXT = 'No se puede aumentar el salario';	
  END IF;
END $$
DELIMITER ;   

DROP PROCEDURE aumentar_salario;
CALL aumentar_salario(2,2019,'Castilleja de la Cuesta');


-- -----------------------------------
-- PROCEDURE INFORME POR ALUMNO: NOMBRE, APELLIDOS, COLEGIO, CURSO, MODALIDAD CONTRATADA, FECHA DE MATRÍCULA Y TARIFA
DELIMITER $$
CREATE PROCEDURE informe_alumno(IN idAlumno INT)
BEGIN
	 IF(existe_alumno(idAlumno) <> 0) THEN 
		SELECT CONCAT('+++++++++ INFORME ++++++++++', '\n', '\n', 'Alumno: ',p.Nombre, ' ', p.Apellidos, '\n', '----------', '\n',
				'Colegio: ', a.Colegio, ' Curso: ', a.Curso, '\n', '----------', '\n',
				'Modalidad: ', m2.Tipo_modalidad, ' Asistencia: ', m2.Tipo_asistencia, '\n', '----------', '\n',
				'Fecha de inicio: ', m.Fecha_inicio , ' Tarifa: ', m2.Tarifa, '€','\n', ' ++++++++++++++++++++++++++++')  
		FROM Personas p INNER JOIN Alumnos a 
						INNER JOIN Matriculas m 
						INNER JOIN Modalidades m2
						ON p.idPersona = a.Personas_idPersona 
						AND a.idAlumno = m.Alumnos_idAlumno 
						AND m.Modalidades_idModalidad = m2.idModalidad
		WHERE a.idAlumno = idAlumno
		ORDER BY p.Apellidos, p.Nombre, m.Fecha_inicio;
	 ELSE
	  	SIGNAL SQLSTATE '45001'
	  	SET MESSAGE_TEXT = 'El alumno no consta en nuestros registros';	
	 END IF; 
END $$
DELIMITER ;

CALL informe_alumno(5);
DROP PROCEDURE informe_alumno;

--  ----------------------------------------
-- PROCEDURE PARA ACTUALIZAR EL CURSO DE UN ALUMNO
DELIMITER $$
CREATE PROCEDURE actualizar_curso(idAlumno INT, curso varchar(13))
BEGIN
	IF(existe_alumno(idAlumno) <> 0) THEN 
		UPDATE Alumnos a
	    SET a.Curso = curso
		WHERE a.idAlumno = idAlumno;
	 ELSE
	  	SIGNAL SQLSTATE '45001'
	  	SET MESSAGE_TEXT = 'El alumno no consta en nuestros registros';	
	 END IF; 
END$$
DELIMITER ;

CALL actualizar_curso(1, 'ESO 3');
DROP PROCEDURE actualizar_curso;

-- ---------------------------------------------------------------------------------------------
-- triggerS 
DELIMITER $$
CREATE TRIGGER comprobar_tipo_tutor
BEFORE INSERT ON Tutores FOR EACH ROW 
BEGIN 
	IF (NEW.Tipo NOT IN (SELECT DISTINCT t.Tipo FROM Tutores t)) THEN 
		SIGNAL SQLSTATE '45005'
		SET MESSAGE_TEXT='Se debe introducir un tipo de parentezco correcto';
	END IF;
END$$ 
DELIMITER ;

DROP TRIGGER comprobar_tipo_tutor; 

INSERT INTO Personas VALUES (5555, 'Prueba', 'Prueba', '22222A', '123456789', 'PPPP', 'PPPP', 1);
INSERT INTO Tutores VALUES(5555, 'OtrA', 'Correo', 5555);
	

DELIMITER $$ 
CREATE TRIGGER grupo_con_menos_alumnos 
AFTER INSERT ON Horarios FOR EACH ROW 
BEGIN 
	DECLARE grupo_menor INT DEFAULT 0; 

	SELECT COUNT(1) AS cantidad INTO grupo_menor
	FROM Horarios h INNER JOIN Grupos g 
	ON h.Grupos_idGrupo = g.idGrupo
	GROUP BY h.Alumnos_idAlumno
	ORDER BY cantidad ASC
	LIMIT 1;

	IF (grupo_menor < 10) THEN -- 
		INSERT INTO Horarios (Dia, Hora, Aulas_idAula, Grupos_idGrupo, Alumnos_idAlumno) 
			   VALUES (NEW.Dia, NEW.Hora, NEW.Aulas_idAula, grupo_menor, NEW.Alumnos_idAlumno);			
	ELSE
		SIGNAL SQLSTATE '45008' 
		SET message_text='Todos los grupos están llenos';	
	END IF;
END$$ 
DELIMITER ;

DROP TRIGGER grupo_con_menos_alumnos;

INSERT INTO Horarios (Dia, Hora, Aulas_idAula, Alumnos_idAlumno) VALUES ('Lunes', '18:00', 5, 5555);


-- ------ LOS QUE FUNCIONAN -----------------------------------------------------------------------------
-- TRIGGER copia de seguridad al eliminar alumno
CREATE TABLE `academia-atentos-db`.AntiguosAlumnos (
	idAlumno INTEGER NULL,
	idPersona INTEGER NULL,
	idTutor INTEGER NULL,
	FechaBaja DATE NULL
);

DELIMITER $$ 
CREATE TRIGGER baja_alumno  
BEFORE DELETE ON Alumnos FOR EACH ROW 
BEGIN 

	INSERT INTO AntiguosAlumnos(idAlumno, idPersona, idTutor, FechaBaja) 
		   VALUES (OLD.idAlumno, OLD.Personas_idPersona, OLD.Tutores_idTutor, CURDATE());

END$$ 
DELIMITER ;

INSERT INTO Personas VALUES (5555, 'aaa','bbb', 'ccc', '11111', 'aaa@aaa', 'dddd', 5);
INSERT INTO Alumnos VALUES (5555, 'aaa', 'bbb', 1, 1, 2, 5555, 5);

DELETE FROM Alumnos WHERE idAlumno = 5555;

-- -------------

CREATE TABLE `academia-atentos-db`.HistoricoPagos (
	idAlumno INTEGER NULL,
	CantidadPagada DECIMAL(10,2) NULL,
	FechaPago DATE);

DELIMITER $$ 
CREATE TRIGGER total_pagos  
AFTER INSERT ON Recibos FOR EACH ROW 
BEGIN 

	IF (New.fecha <= CURDATE()) THEN -- 
		INSERT INTO HistoricoPagos(idAlumno, CantidadPagada, FechaPago) 
        VALUES (NEW.Alumnos_idAlumno, NEW.Cantidad, NEW.Fecha);	
	ELSE
		SIGNAL SQLSTATE '45008' 
		SET message_text='No se pueden guardar pagos de fechas futuras';	
	END IF;
END$$ 
DELIMITER ;

INSERT INTO Recibos VALUES (5555, '2022-03-29', 15, 'aaa', 'Tarjeta',5555);












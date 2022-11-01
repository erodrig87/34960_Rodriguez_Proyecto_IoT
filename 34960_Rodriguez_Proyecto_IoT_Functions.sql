use proyecto_iot;

-- Funcion que verifica estado de calibración
-- Recibe parameto fecha e intervalo caliobracion (en dias), Retorna texto segun resultado
DROP FUNCTION IF EXISTS fn_check_calibration_status;

DELIMITER ||
CREATE FUNCTION  check_calibration_status (calibration_date DATE, interval_calibration varchar(3))  
   RETURNS VARCHAR(10)   
    DETERMINISTIC    
     BEGIN
       DECLARE estado VARCHAR(10);        
         IF calibration_date> DATE_ADD(now(), INTERVAL -interval_calibration DAY)        
                THEN SET estado = 'Vigente';        
			ELSE  SET estado = 'Vencida';        
		END IF;     
        RETURN estado;    
      END ||
	 DELIMITER ;

-- Funcion que verifica estado de calibración
-- Recibe parameto fecha e intervalo caliobracion (en dias), Retorna texto segun resultado

DROP FUNCTION IF EXISTS contar_sensores;

DELIMITER //
CREATE FUNCTION contar_sensores_tipo(tipo VARCHAR(30))
  RETURNS INT UNSIGNED
  DETERMINISTIC
	BEGIN
	  DECLARE total_sensores INT UNSIGNED;
	  SET total_sensores = (
		SELECT COUNT(*) 
		FROM sensores 
		WHERE sensores.tipo = tipo);
	  RETURN total_sensores;
	END //
	 DELIMITER ;

-- Ejemplos utilización funciones 
SELECT * FROM   
sensores WHERE check_calibration_status(calibracion,120) = 'Vigente';

select contar_sensores_tipo("humedad");

select contar_sensores_tipo("temperatura");


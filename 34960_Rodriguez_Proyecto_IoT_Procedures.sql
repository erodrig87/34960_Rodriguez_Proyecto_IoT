use proyecto_iot;

-- se crea procedimiento para ordenar mediciones segun parametro y orden ingresados  

DROP PROCEDURE IF EXISTS sp_ordenar_mediciones;

 DELIMITER //
CREATE PROCEDURE sp_ordenar_mediciones (INOUT PARAM_ORDER VARCHAR(20),INOUT PARAM_ASC_DESC VARCHAR(20))
BEGIN
-- "t1 -> se escribe string que luego será sentencia de SQL que se ejecutara"
  SET @t1 =  CONCAT('SELECT * FROM mediciones U ORDER BY',' ',PARAM_ORDER,' ',PARAM_ASC_DESC);
  PREPARE param_stmt FROM @t1;
  EXECUTE param_stmt;  
  DEALLOCATE PREPARE param_stmt;
END //
DELIMITER ;

-- procedimiento que genera inseccion de medicion
-- se debe llamar al mismo ingresando id del sensor, valor de medicion y fecha_hora de la misma. 
-- el id de medicion es generado automatimante al insertar elemento
DROP PROCEDURE IF EXISTS sp_insertar_medicion;

 DELIMITER $$
CREATE PROCEDURE sp_insertar_medicion(IN n_sensor_id int, IN n_valor float,IN n_fecha_hora datetime)
	BEGIN
    insert into mediciones(sensor_id, valor, fecha_hora) values (n_sensor_id, n_valor,n_fecha_hora);
    END 
DELIMITER ;

-- ejemplo utilizacion procedimientos
CALL sp_insertar_medicion(20,1.01,now());

SET @PARAM_ORDER = 'fecha_hora'; -- se indica que campo/columna de la tabla se utilizara para ordenar
SET @PARAM_ASC_DESC = 'DESC'; -- se indica orden descendente
-- en este caso se ordenan mediciones segun fecha_hora mas reciente

CALL sp_ordenar_mediciones (@PARAM_ORDER ,@PARAM_ASC_DESC);

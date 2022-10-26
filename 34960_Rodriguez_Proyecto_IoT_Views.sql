use proyecto_iot;

--  Vista Descripcion simplificada cliente_id, cliente_nombre, provincia, pais
CREATE OR REPLACE VIEW clientes_descripcion AS
	(SELECT clientes.cliente_id, clientes.cliente_nombre, provincia, pais
	FROM clientes
    ORDER BY cliente_id ASC
    LIMIT 10);
    
-- Vista que indica los Centros que poseen cada cliente    
CREATE OR REPLACE VIEW centros_clientes AS
	(SELECT clientes.cliente_id, clientes.cliente_nombre, centros.centro_id, centros.centro_nombre
	FROM clientes
	INNER JOIN centros ON clientes.cliente_id=centros.cliente_id
	ORDER BY cliente_id ASC
    LIMIT 10);
    
-- Vista que indica los modulos que poseen cada cliente y el estado de cada uno
CREATE OR REPLACE VIEW modulos_clientes AS
	(SELECT clientes.cliente_id, clientes.cliente_nombre, modulos.modulo_id, modulos.modulo_nombre, modulos.estado
	FROM clientes
	INNER JOIN modulos ON clientes.cliente_id=modulos.cliente_id
	ORDER BY cliente_id ASC
    LIMIT 10);

-- Vista que indica la cantiad de modulos que 
CREATE OR REPLACE VIEW cantidad_modulos_centro_cliente AS
	(SELECT c.cliente_id, c.cliente_nombre, COUNT( DISTINCT m.modulo_nombre) as modulos_qty
	FROM clientes c
	INNER JOIN modulos m ON m.cliente_id=c.cliente_id
	GROUP BY c.cliente_id
    LIMIT 10);
    
 -- Vista que indica la cantidad de sensores operativos por centro 
 CREATE OR REPLACE VIEW sensores_opeartivos AS
	(SELECT c.centro_id,s.modulo_id, s.sensor_id,s.tipo,s.estado
	FROM sensores s
    JOIN modulos AS m ON m.modulo_id = s.modulo_id
    JOIN centros AS c ON m.centro_id = c.centro_id
	WHERE s.estado="Operativo"
    ORDER BY c.centro_id  ASC
    LIMIT 10);

-- Vista que indica la mediciones de sensores de temperatura
 CREATE OR REPLACE VIEW mediciones_temperatura AS
	(SELECT s.tipo, m.sensor_id,m.medicion_id,m.valor, m.fecha_hora
	FROM mediciones m
    JOIN sensores AS s ON m.sensor_id = s.sensor_id
    WHERE s.tipo="temperatura"
    ORDER BY m.sensor_id  ASC
    LIMIT 10);
    
-- Vista que indica la mediciones de sensores de humedad
 CREATE OR REPLACE VIEW mediciones_humedad AS
	(SELECT s.tipo, m.sensor_id,m.medicion_id,m.valor, m.fecha_hora
	FROM mediciones m
    JOIN sensores AS s ON m.sensor_id = s.sensor_id
    WHERE s.tipo="humedad"
    ORDER BY m.sensor_id  ASC
    LIMIT 10);
 

    
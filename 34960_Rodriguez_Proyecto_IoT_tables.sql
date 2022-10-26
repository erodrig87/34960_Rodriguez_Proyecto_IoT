drop schema if exists proyecto_iot;
create schema if not exists proyecto_iot;
use proyecto_iot;

-- Tabla CLIENTES contiene datos relacionados a los clientes
drop table if exists CLIENTES;
create table if not exists CLIENTES (
cliente_id int not null auto_increment, 
cliente_nombre varchar (50) not null,
direccion varchar (60),
ciudad char(40),
provincia varchar(40),
pais varchar (40),
Primary key (cliente_id)
);

-- Tabla CENTROS contiene CENTROS relacionados a cada cliente
drop table if exists CENTROS;
create table if not exists CENTROS (
centro_id int not null auto_increment primary key, 
cliente_id int not null,
centro_nombre varchar (50) not null,
direccion varchar (60),
ciudad char(40),
provincia varchar(40),
foreign key (cliente_id) references CLIENTES(cliente_id) on delete cascade
);


-- Tabla MODULOS contiene LOS MODULOS DE MEDICION relacionados a cada cliente y cada centro
drop table if exists MODULOS;
create table if not exists MODULOS (
modulo_id int not null auto_increment primary key, 
cliente_id int not null,
centro_id int not null,
modulo_nombre varchar (50) not null,
ubicacion varchar (60),
estado enum('Operativo', 'No_Operativo'),
foreign key (centro_id) references CENTROS(centro_id) on delete cascade,
foreign key (cliente_id) references CLIENTES(cliente_id) on delete cascade
);

-- Tabla SENSORES contiene LOS SENSORES relacionados a cada modulo de medicion
drop table if exists SENSORES;
create table if not exists SENSORES (
sensor_id int not null auto_increment primary key, 
modulo_id int not null,
tipo enum('temperatura', 'humedad'),
calibracion datetime,
estado enum('Operativo', 'No_Operativo'),
foreign key (modulo_id) references MODULOS(modulo_id) on delete cascade
);

-- Tabla mediciones contiene las mediciones relacionas a cada sensor
drop table if exists MEDICIONES;
create table if not exists MEDICIONES (
medicion_id int not null auto_increment primary key, 
sensor_id int not null,
valor float,
fecha_hora datetime,
foreign key (sensor_id) references SENSORES(sensor_id) on delete cascade
);
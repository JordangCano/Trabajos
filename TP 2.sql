


1 - Crear una función llamada "calcular_total_ventas" que tome como parámetro el mes y el año,
 y devuelva el total de ventas realizadas en ese mes.
 
 
DELIMITER //
 CREATE FUNCTION calcular_total_ventas(mes INT, año INT)
 RETURNS DECIMAL(10,2)
 BEGIN
      DECLARE total DECIMAL(10,2);
      
      SELECT sum(venta_total) INTO total
      FROM ventas
      WHERE month(fecha_venta) = mes
      AND year(fecha_venta) = año;
	
      
	  IF total IS NULL THEN
         SET total = 0;
	  END IF;
      
      RETURN total;
      END //
      
DELIMITER ;

2 - Crear una función llamada "obtener_nombre_empleado" que tome como parámetro 
el ID de un empleado y devuelva su nombre completo.


DELIMITER //

CREATE FUNCTION obtener_nombre_empleado(emp_id int)
returns VARCHAR(344)
BEGIN
     DECLARE emp_nombre varchar(344);
     
     select concat(primer_nombre, ´´, apellido) into emp_nombre
     from empleados
     where empleado_id = emp_id;
     
     return emp_nombre;
end //
DELIMITER ;


3 - Crear un procedimiento almacenado llamado "obtener_promedio" que tome como parámetro de entrada el nombre de un curso y calcule el promedio 
de las calificaciones de todos los alumnos inscritos en ese curso.


DELIMITER //

CREATE PROCEDURE obtener_promedio(IN nombre_curso VARCHAR(344))
BEGIN
     DECLARE total_calificaciones decimal(10,2);
     DECLARE total_alumos INT;
     DECLARE promedio DECIMAL (10,2);
     
     SELECT sum(calificacion) INTO total_calificaciones
     from calificaciones
     where curso = nombre_curso;
     
     select count(*) INTO total_alumnos
     from calificaciones
     where curso = nombre_curso;
     
     IF total_alumnos > 0 THEN
		SET promedio = total_calificaciones / total_alumnos;
	 else
       set promedio = 0;
	 end if;
     
     select promedio;
end //

DELIMITER ;


4 - Actualizar el procedimiento almacenado "actualizar_stock" para que tome como parámetros 
de entrada el código del producto y la cantidad a agregar al stock actual. El procedimiento debe actualizar el stock sumando 
la cantidad especificada al stock actual del producto correspondiente.


DELIMITER //

CREATE procedure actualizar_stock(in producto_codigo varchar(344) in cantidad int)
begin
     update productos
     set stock = stock + cantidad
     where codigo = producto_codigo;
END //

DELIMITER ;



5 - A partir de la siguiente especificación un Analista deberá recolectar datos para poder diseñar una Base de Datos.

a) Determinar las entidades relevantes al Sistema.

.TELEVISOR
.COMPONENTE
.IMPORTADOR
.FACTURA
.PIEZA
.OPERARIO
.HOJA DE CONFECCION
.MODELO DE TELEVISOR
.MAPA DE ARMADO


b) Determinar los atributos de cada entidad.

. TELEVISOR: ID_TELEVISOR, MODELO, FECHA_ARMADO.
. COMPONENTE: ID_COMPONENTE, NOMBRE, DESCRIPCION, PRECIO.
. IMPORTADOR: ID_IMPORTADOR, NOMBRE, DIRECCION, CONTACTO.
. FACTURA: ID_FACTURA, ID_IMPORTADOR, FECHA_COMPRA.
. PIEZA: ID_PIEZA, NOMBRE, DESCRIPCION, TIPO.
. OPERARIO: ID_OPERARIO, NOMBRE, ESPECIALIDAD.
. HOJA DE CONFECCION: ID_HOJA_CONFECCION, ID_OPERARIO, ID_PIEZA, FECHA, CANTIDAD_FABRICADA.
. MODELO TELEVISOR: ID_MODELO, NOMBRE, DESCRIPCION.
. MAPA DE ARMADO: ID_ MAPA_ARMADO, ID_MODELO, ID_PIEZA, UBICACION, ORDEN.


c) Confeccionar el Diagrama de Entidad Relación (DER), junto al Diccionario de Datos




d) Realizar el Diagrama de Tablas e implementar en código SQL la Base de Datos.

e) Crear al menos 2 consultas relacionadas para poder probar la Base de Datos.



CREATE DATABASE TPGBD;
USE TPGBD;
-- Creación de tablas
CREATE TABLE Importador (
  id_importador INT PRIMARY KEY,
  nombre_importador VARCHAR(255),
  direccion VARCHAR(255),
  telefono VARCHAR(20)
);

CREATE TABLE Compra (
  id_compra INT PRIMARY KEY,
  id_importador INT,
  fecha_compra DATE,
  monto_total DECIMAL(10, 2),
  FOREIGN KEY (id_importador) REFERENCES Importador(id_importador)
);

CREATE TABLE Pieza (
  id_pieza INT PRIMARY KEY,
  nombre_pieza VARCHAR(255),
  precio_unitario DECIMAL(10, 2)
);

CREATE TABLE Operario (
  id_operario INT PRIMARY KEY,
  nombre_operario VARCHAR(255),
  especialidad VARCHAR(255)
);

CREATE TABLE HojaConfeccion (
  id_hoja INT PRIMARY KEY,
  id_operario INT,
  id_pieza INT,
  fecha_confeccion DATE,
  cantidad_fabricada INT,
  FOREIGN KEY (id_operario) REFERENCES Operario(id_operario),
  FOREIGN KEY (id_pieza) REFERENCES Pieza(id_pieza)
);

CREATE TABLE ModeloTelevisor (
  id_modelo INT PRIMARY KEY,
  nombre_modelo VARCHAR(255)
);

CREATE TABLE MapaArmado (
  id_mapa INT PRIMARY KEY,
  id_modelo INT,
  id_pieza INT,
  ubicacion VARCHAR(255),
  orden INT,
   FOREIGN KEY (id_modelo) REFERENCES ModeloTelevisor(id_modelo),
  FOREIGN KEY (id_pieza) REFERENCES Pieza(id_pieza)
);
















     
     
     
     
     
     
     
     
     







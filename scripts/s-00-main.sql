--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Este archivo contiene ejecución de todos los scripts que 
--solicita el proyecto

@s-01-usuarios.sql
Prompt Conectando a usuario gaga_proy_admin 
connect gaga_proy_admin/gaga
@s-02-entidades.sql


Prompt =====PRIMER TABLA EXTERNA=====
@s-04-tablas-externa-med

Prompt =====SEGUNDA TABLA EXTERNA=====
@s-04-tablas-externas-nomb

Prompt =====CREANDO SECUECIAS=====
@s-05-secuencias.sql

Prompt =====CREANDO INDICES=====
@s-06-indices.sql

Prompt =====CREANDO SINONIMOS=====
@s-07-sinonimos.sql

Prompt =====CREANDO VISTAS=====
@s-08-vistas

Prompt =====CREANDO TABLAS TEMPORALES=====
@s-03-tablas-temporales

Prompt =====CARGA INICIAL=====
@s-09-carga-inicial.sql

@s-10-consultas




Prompt =====CREANDO TRIGGERS=====
@s-11-tr-auditoria-pedido
@s-11-tr-historico-pedido
@s-11-tr-historico-ubicacion
@s-11-tr-inicio-ubicacion
@s-11-tr-actualizar-sustancia

Prompt =====CREANDO PROCEDIMIENTOS=====
@s-13-p-genera-pedido
@s-13-p-genera-nuevo-usuario
@s-17-lob-cargar-almacen.sql

Prompt =====CREANDO FUNCIONES=====
@s-15-fx-genera-folio.sql
@s-15-fx-medicamentos-almacen.sql
@s-15-fx-pago-cliente.sql

commit;
Prompt ##########PRUEBAS##########

Prompt =====PRUEBAS TRIGGER=====
@s-12-tr-auditoria-pedido-prueba
@s-12-tr-historico-pedido-prueba
@s-12-tr-historico-ubicacion-prueba
@s-12-tr-actualizar-sustancia-prueba
commit;
Prompt =====PRUEBAS PROCEDIMIENTOS=====
@s-14-p-genera-pedido-prueba
@s-14-p-generar-nuevo-usuario-prueba
@s-18-lob-cargar-almacen-prueba.sql

Prompt =====PRUEBAS FUNCIONES=====
@s-16-fx-genera-folio-prueba.sql
@s-16-fx-medicamento-almacen-prueba.sql
@s-16-fx-pago-cliente-prueba.sql


commit;
























--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 05/01/2022
--@Descripción: Este archivo contiene la creación de los índices para 
--el proyecto Pharmacy Online (DDL)

create sequence farmacia_medicamento_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence medicamento_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence empleado_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence evento_almacen_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence medicamento_presentacion_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence operacion_evento_medicamento_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence cliente_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence pedido_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence pedido_medicamento_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence historico_status_pedido_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence historico_ubicacion_pedido_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
create sequence ubicacion_actual_seq
  start with 1
  increment by 1 
  nomaxvalue
  nominvalue
  nocycle
  cache 100
  order;
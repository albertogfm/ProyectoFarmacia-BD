--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Este archivo contiene la creación de las tablas para 
--el proyecto Pharmacy Online (DDL)

create table centro_operaciones(
  clave_centro_operaciones varchar2(6) not null,
  direccion blob not null,
  latitud number(7,4) not null,
  longitud number(7,4) not null,
  telefono_centro_operaciones number(10,0) not null,
  constraint centro_operaciones_pk primary key (clave_centro_operaciones)
);

create table oficina(
  clave_centro_operaciones varchar2(6) not null,
  clave number(10,0) not null,
  numero_oficina number(10,0) not null,
  nombre varchar2(50) not null,
  constraint oficina_pk primary key (clave_centro_operaciones),
  constraint oficina_clave_centro_operaciones_fk 
    foreign key(clave_centro_operaciones) 
    references centro_operaciones(clave_centro_operaciones)
);

create table farmacia(
  clave_centro_operaciones varchar2(6) not null,
  rfc_fiscal varchar2(14) not null,
  url varchar2(200) not null,
  constraint farmacia_pk primary key (clave_centro_operaciones),
  constraint farmacia_clave_centro_operaciones_fk 
    foreign key(clave_centro_operaciones) 
    references centro_operaciones(clave_centro_operaciones)
);

create table almacen(
  clave_centro_operaciones varchar2(6) not null,
  tipo_almacen char(1) not null,
  documento_secciones blob not null,
  almacen_contigencia_id varchar2(6),
  constraint almacen_pk primary key (clave_centro_operaciones),
  constraint almacen_clave_centro_operaciones_fk 
    foreign key(clave_centro_operaciones) 
    references centro_operaciones(clave_centro_operaciones),
  constraint almacen_contigencia_clave_centro_operaciones_fk 
    foreign key(almacen_contigencia_id) 
    references almacen(clave_centro_operaciones)
);

create table lista_nombres_medicamento(
  lista_nombres_medicamento_id number(10,0) not null,
  nombre varchar2(100) not null,
  constraint lista_nombres_medicamento_pk 
    primary key (lista_nombres_medicamento_id)
);

create table medicamento(
  medicamento_id number(10,0) not null,
  sustancia_activa varchar2(100) not null,
  descripcion varchar2(1000) not null,
  lista_nombres_medicamento_id number(10,0) not null,
  constraint medicamento_pk primary key (medicamento_id),
  constraint medicina_medicamento_fk 
    foreign key(lista_nombres_medicamento_id) 
    references lista_nombres_medicamento(lista_nombres_medicamento_id)
);

create table farmacia_medicamento(
  farmacia_medicamento_id number(10,0) not null,
  numero_unidades number(5,0) not null,
  clave_centro_operaciones varchar2(6) not null,
  medicamento_id number(10,0) not null,
  constraint farmacia_medicamento_pk primary key (farmacia_medicamento_id),
  constraint fm_clave_centro_operaciones_fk 
    foreign key(clave_centro_operaciones) 
    references centro_operaciones(clave_centro_operaciones),
  constraint fm_medicamento_id_fk 
    foreign key(medicamento_id) 
    references medicamento(medicamento_id)
);

create table empleado(
  empleado_id number(10,0) not null,
  nombre varchar2(50) not null,
  apellidos varchar2(50) not null,
  fecha_ingreso date not null,
  rfc varchar2(13) not null,
  clave_centro_operaciones varchar2(6) not null,
  constraint empleado_pk primary key (empleado_id),
  constraint emp_clave_centro_operaciones_fk 
    foreign key(clave_centro_operaciones) 
    references centro_operaciones(clave_centro_operaciones)
);

create table presentacion(
  presentacion_id numeric(10,0) not null,
  clave varchar(2) not null,
  unidades number(3,0) not null,
  constraint presentacion_pk primary key (presentacion_id)
);


create table medicamento_presentacion(
  medicamento_presentacion_id number(10,0) not null,
  presentacion_id number(10,0) not null,
  medicamento_id number(10,0) not null,
  pedido_medicamento_id number(10,0) not null,
  constraint medicamento_presentacion_pk primary key (medicamento_presentacion_id),
  constraint mp_presentacion_id_fk 
    foreign key(presentacion_id) 
    references presentacion(presentacion_id),
  constraint mp_medicamento_id_fk 
    foreign key(medicamento_id) 
    references medicamento(medicamento_id)
--   constraint mp_pedido_medicamento_id_fk
--     foreign key (pedido_medicamento_id)
--     references pedido_medicamento(pedido_medicamento_id)
);


create table evento_almacen(
  evento_almacen_id number(10,0) not null,
  fecha_evento date not null,
  tipo_evento varchar2(7) not null,
  clave_centro_operaciones varchar2(6) not null,
  empleado_id number(10,0) not null,
  constraint evento_almacen_pk primary key (evento_almacen_id),
  constraint ea_clave_centro_operaciones_id_fk 
    foreign key(clave_centro_operaciones) 
    references centro_operaciones(clave_centro_operaciones),
  constraint ea_empleado_id_fk 
    foreign key(empleado_id) 
    references empleado(empleado_id)
);



create table operacion_evento_medicamento(
  evento_medicamento_id number(10,0) not null,
  numero_unidades number(4,0) not null,
  evento_almacen_id number(10,0) not null,
  medicamento_presentacion_id number(10,0) not null,
  constraint oem_pk primary key (evento_medicamento_id),
  constraint oem_evento_almacen_id_fk 
    foreign key(evento_almacen_id) 
    references evento_almacen(evento_almacen_id),
  constraint oem_medicamento_presentacion_id_fk
    foreign key (medicamento_presentacion_id)
    references medicamento_presentacion(medicamento_presentacion_id)
);


create table ubicacion_actual(
  ubicacion_actual_id number(10,0) not null,
  latitud number(7,4) not null,
  longitud number(7,4) not null,
  constraint ubicacion_actual_pk primary key (ubicacion_actual_id)
);

create table status_pedido(
  status_pedido_id number(10,0) not null,
  clave varchar2(3) not null,
  descripcion varchar(15) not null,
  constraint status_pedido_pk primary key (status_pedido_id)
);


create table tarjeta(
  numero_tarjeta varchar2(16) not null,
  anio_expiracion varchar2(2) not null,
  mes_expiracion varchar2(2) not null,
  constraint tarjeta_pk primary key (numero_tarjeta)  
);

create table cliente(
  cliente_id number(10) not null,
  nombre varchar2(20) not null,
  apellido_paterno varchar2(20),
  apellido_materno varchar2(20) not null,
  curp varchar2(18) not null,
  rfc varchar2(13) not null,
  direccion varchar2(100) null,
  telefono number(10,0) not null,
  email varchar2(80) not null,
  numero_tarjeta varchar2(16) not null,
  constraint cliente_pk primary key (cliente_id),
  constraint cliente_numero_tarjeta_fk
    foreign key (numero_tarjeta)
    references tarjeta(numero_tarjeta)
);


create table pedido(
  pedido_id number(10,0) not null,
  folio char(13) not null,
  fecha_pedido date not null,
  importe number not null,
  fecha_status date not null,
  cliente_id number(10,0) not null,
  status_pedido_id number(10,0) not null,
  ubicacion_id number(10,0) null,
  constraint pedido_pk primary key (pedido_id),
  constraint pedido_cliente_id_fk 
    foreign key(cliente_id)
    references cliente(cliente_id),
  constraint pedido_status_pedido_id_fk  
    foreign key(status_pedido_id)
    references status_pedido(status_pedido_id),
  constraint pedido_ubicacion_id_fk 
    foreign key(ubicacion_id)
    references ubicacion_actual(ubicacion_actual_id)
);

create table historico_ubicacion_pedido_paquete(
  historico_ubicacion_pedido_paquete_id number(10,0) not null,
  fecha date not null,
  ubicacion_actual_id number(10,0) not null,
  pedido_id number(10,0) not null,
  constraint hupp_pk primary key (historico_ubicacion_pedido_paquete_id),
  constraint hupp_ubicacion_id_fk 
    foreign key(ubicacion_actual_id)
    references ubicacion_actual(ubicacion_actual_id),
  constraint hupp_pedido_id_fk 
    foreign key(pedido_id)
    references pedido(pedido_id)
);


create table pedido_medicamento( 
  pedido_medicamento_id number(10,0) not null,
  detalle varchar(200) null,
  numero_unidades number(4,0) not null,
  pedido_id number(10,0) not null,
  clave_centro_operaciones varchar(6) not null,
  medicamento_presentacion_id number(10,0) not null,
  constraint pedido_medicamento_pk primary key (pedido_medicamento_id),
  constraint pedido_pedido_id_fk 
    foreign key(pedido_id)
    references pedido(pedido_id),
  constraint pm_clave_centro_operaciones_fk
    foreign key(clave_centro_operaciones)
    references farmacia(clave_centro_operaciones),
  constraint pm_medicamento_presentacion_id_fk
    foreign key(medicamento_presentacion_id)
    references medicamento_presentacion(medicamento_presentacion_id)
);


create table historico_status_pedido(
  historico_status_pedido_id number(10,0) not null,
  fecha_status date not null,
  pedido_id number(10,0) not null,
  status_pedido_id number(10,0) not null,
  constraint historico_status_pedido_pk 
    primary key (historico_status_pedido_id),
  constraint hsp_pedido_id_fk 
    foreign key(pedido_id)
    references pedido(pedido_id),
  constraint hsp_status_pedido_id_fk 
    foreign key(status_pedido_id)
    references status_pedido(status_pedido_id)
);






--APLICANDO CHECKS

alter table centro_operaciones add constraint co_clave_centro_operaciones_chk
 check (length(clave_centro_operaciones) = 6);


alter table almacen add constraint almacen_tipo_almacen_chk
  check (tipo_almacen in ('M','C','D'));


alter table pedido add constraint pedido_folio_chk
  check( length(folio)=13);


alter table tarjeta add constraint tarjeta_numero_tarjeta_chk
  check (length(numero_tarjeta)=16);


alter table cliente add constraint cliente_telefono_chk
  check (length(telefono)=10);


alter table oficina add constraint oficina_numero_oficina_chk
  check (length(numero_oficina)=10);


alter table centro_operaciones add constraint cp_telefono_cp_chk
  check (length(telefono_centro_operaciones)=10);


alter table cliente add constraint cliente_curp_chk
  check (length(curp)=18);


alter table cliente add constraint cliente_rfc_chk
  check (length(rfc)=13);


alter table farmacia add constraint farmacia_rfc_fiscal_chk
  check (length(rfc_fiscal)=14);

alter table pedido add constraint pedido_importe_chk
  check (importe>0);


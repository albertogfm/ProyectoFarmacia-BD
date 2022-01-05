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
  descripcion varchar2(100) not null,
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
  constraint medicamento_presentacion_pk primary key (empleado_id),
  constraint mp_presentacion_id_fk 
    foreign key(presentacion_id) 
    references presentacion(presentacion_id),
  constraint mp_medicamento_id_fk 
    foreign key(medicamento_id) 
    references medicamento(medicamento_id),
--   constraint mp_pedido_medicamento_id_fk
--     foreign key (pedido_medicamento_id)
--     references pedido_medicamento(pedido_medicamento_id)
);

create table operaciones_evento_medicamento(
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
    foreign key(claveclave_centro_operaciones)
    references farmacia(claveclave_centro_operaciones),
  constraint pm_medicamento_presentacion_id_fk
    foreign key(medicamento_presentacion_id)
    references medicamento_presentacion(medicamento_presentacion_id)
);

create table pedido(
  pedido_id number(10,0) not null,
  folio char(13) not null,
  fecha_pedido date not null,
  importe number not null,
  fecha_status date not null,
  cliente_id number(10,0) not null,
  status_pedido_id number(10,0) not null,
  ubicacion_id number(10,0) not null
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

create table status_pedido(
  status_pedido_id number(10,0) not null,
  clave varchar2(3) not null,
  descripcion varchar(15) not null,
  constraint status_pedido_pk primary key (status_pedido_id)
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


create table ubicacion_actual(
  ubicacion_actual_id number(10,0) not null,
  latitud number(7,4) not null,
  longitud number(7,4) not null,
  constraint ubicacion_actual_pk primary key (ubicacion_actual_id)
);


create table cliente(
  cliente_id char(10) not null,
  nombre varchar2(20) not null,
  apellido_paterno varchar2(20),
  apellido_materno varchar2(20) not null,
  curp varchar2(18) not null,
  rfc varchar2(13) not null,
  direccion varchar2(100) null,
  telefono number(10,0) not null,
  email varchar2(80) not null,
  numero_tarjeta char(16) not null,
  constraint cliente_pk primary key (cliente_id),
  constraint cliente_numero_tarjeta_fk
    foreign key (numero_tarjeta)
    references tarjeta(numero_tarjeta)
);

create table tarjeta(
  numero_tarjeta varchar2(16) not null,
  anio_expiracion date not null,
  mes_expiracion date not null,
  constraint tarjeta_pk primary key (numero_tarjeta)  
);

--APLICANDO CHECKS
alter table centro_operaciones add constraint co_clave_centro_operaciones_chk
 check length(clave_centro_operaciones) = 6;

alter table almacen add constraint almacen_tipo_almacen_chk
  check tipo_almacen in ('M','C','D');

alter table pedido add constraint pedido_folio_chk
  check length(folio)=13;

alter table tarjeta add constraint tarjeta_numero_tarjeta_chk
  check length(numero_tarjeta)=16;

alter table tarjeta add constraint tarjeta_anio_mes_expiracion_chk
  check 





































-- 
-- table: cliente 
--

create table cliente(
    cliente_id          char(10)         not null,
    nombre              varchar2(20)     not null,
    apellido_paterno    varchar2(20),
    apellido_materno    varchar2(20)     not null,
    curp                varchar2(18)     not null,
    rfc                 varchar2(13)     not null,
    direccion           varchar2(100),
    telefono            number(10, 0)    not null,
    email               varchar2(80)     not null,
    numero_tarjeta      char(16)         not null,
    constraint pk9 primary key (cliente_id)
)
;



-- 
-- table: empleado 
--

create table empleado(
    empleado_id                 number(10, 0)    not null,
    nombre                      varchar2(50)     not null,
    apellidos                   varchar2(50)     not null,
    fecha_ingreso               date             not null,
    rfc                         varchar2(13)     not null,
    clave_centro_operaciones    varchar2(6)      not null,
    constraint pk10 primary key (empleado_id)
)
;



-- 
-- table: evento_almacen 
--

create table evento_almacen(
    evento_almacen_id           number(10, 0)    not null,
    fecha_evento                date             not null,
    tipo_evento                 varchar2(7),
    clave_centro_operaciones    varchar2(6)      not null,
    empleado_id                 number(10, 0)    not null,
    constraint pk12 primary key (evento_almacen_id)
)
;



-- 
-- table: farmacia 
--

create table farmacia(
    clave_centro_operaciones    varchar2(6)      not null,
    rfc_fiscal                  varchar2(14)     not null,
    url                         varchar2(200)    not null,
    constraint pk11 primary key (clave_centro_operaciones)
)
;



-- 
-- table: "farmacia-medicamento" 
--

create table "farmacia-medicamento"(
    "farmacia-medicamento_id"   number(10, 0)    not null,
    numero_unidades             number(5, 0)     not null,
    clave_centro_operaciones    varchar2(6)      not null,
    medicamento_id              number(10, 0)    not null,
    constraint pk15 primary key ("farmacia-medicamento_id")
)
;



-- 
-- table: historico_status_pedido 
--

create table historico_status_pedido(
    historico_status_pedido_id    number(10, 0)    not null,
    fecha_status                  date             not null,
    "´pedido_id"                  number(10, 0)    not null,
    status_pedido_id              number(10, 0)    not null,
    constraint pk8 primary key (historico_status_pedido_id)
)
;



-- 
-- table: historico_ubicacion_pedido_paquete 
--

create table historico_ubicacion_pedido_paquete(
    historico_ubicacion_pedido_paquete_id    number(10, 0)    not null,
    fecha                                    date,
    ubicacion_id                             number(10, 0)    not null,
    "´pedido_id"                             number(10, 0)    not null,
    constraint pk22 primary key (historico_ubicacion_pedido_paquete_id)
)
;






-- 
-- table: medicamento 
--

create table medicamento(
    medicamento_id                  number(10, 0)    not null,
    sustancia_activa                varchar2(100)    not null,
    descripcion                     varchar2(100)    not null,
    lista_nombres_medicamento_id    number(10, 0)    not null,
    constraint pk13 primary key (medicamento_id)
)
;



-- 
-- table: "medicamento-presentacion" 
--

create table "medicamento-presentacion"(
    "medicamento-presentacion_id"  number(10, 0)    not null,
    presentacion_id                number(10, 0)    not null,
    medicamento_id                 number(10, 0)    not null,
    pedido_medicamento_id          number(10, 0)    not null,
    constraint pk20 primary key ("medicamento-presentacion_id")
)
;



-- 
-- table: oficina 
--

create table oficina(
    clave_centro_operaciones    varchar2(6)      not null,
    clave                       number(10, 0)    not null,
    numero_oficina              number(10, 0)    not null,
    nombre                      varchar2(50)     not null,
    constraint pk5 primary key (clave_centro_operaciones)
);



-- 
-- table: operaciones_evento_medicamento 
--

create table operaciones_evento_medicamento(
    "evento-medicamento_id"        number(10, 0)    not null,
    numero_unidades                number(4, 0)     not null,
    evento_almacen_id              number(10, 0)    not null,
    "medicamento-presentacion_id"  number(10, 0)    not null,
    constraint pk18 primary key ("evento-medicamento_id")
)
;



-- 
-- table: pedido 
--

create table pedido(
    "´pedido_id"        number(10, 0)    not null,
    folio               char(13)         not null,
    fecha_pedido        date,
    importe             binary_float     not null,
    fecha_status        date,
    cliente_id          char(10)         not null,
    status_pedido_id    number(10, 0)    not null,
    ubicacion_id        number(10, 0)    not null,
    constraint pk7 primary key ("´pedido_id")
)
;



-- 
-- table: pedido_medicamento 
--

create table pedido_medicamento(
    pedido_medicamento_id       number(10, 0)    not null,
    detalle                     varchar2(200),
    numero_unidades             number(4, 0)     not null,
    "´pedido_id"                number(10, 0)    not null,
    clave_centro_operaciones    varchar2(6)      not null,
    constraint pk19 primary key (pedido_medicamento_id)
)
;



-- 
-- table: presentacion 
--

create table presentacion(
    presentacion_id    number(10, 0)    not null,
    clave              varchar2(2)      not null,
    unidades           number(3, 0)     not null,
    constraint pk16 primary key (presentacion_id)
)
;



-- 
-- table: status_pedido 
--

create table status_pedido(
    status_pedido_id    number(10, 0)    not null,
    clave               varchar2(3),
    descripcion         varchar2(15)     not null,
    constraint pk2 primary key (status_pedido_id)
)
;



-- 
-- table: tarjeta 
--

create table tarjeta(
    numero_tarjeta     char(16)    not null,
    anio_expiracion    date        not null,
    mes_expiracion     date,
    constraint pk6 primary key (numero_tarjeta)
)
;



-- 
-- table: ubicacion_actual 
--

create table ubicacion_actual(
    ubicacion_id    number(10, 0)    not null,
    latitud         number(7, 4)     not null,
    longitud        number(7, 4)     not null,
    constraint pk1 primary key (ubicacion_id)
)
;



-- 
-- table: almacen 
--

alter table almacen add constraint refcentro_operaciones6 
    foreign key (clave_centro_operaciones)
    references centro_operaciones(clave_centro_operaciones)
;

alter table almacen add constraint refalmacen24 
    foreign key (almacen_contigencia_id)
    references almacen(clave_centro_operaciones)
;


-- 
-- table: cliente 
--

alter table cliente add constraint reftarjeta30 
    foreign key (numero_tarjeta)
    references tarjeta(numero_tarjeta)
;


-- 
-- table: empleado 
--

alter table empleado add constraint reffarmacia12 
    foreign key (clave_centro_operaciones)
    references farmacia(clave_centro_operaciones)
;


-- 
-- table: evento_almacen 
--

alter table evento_almacen add constraint refalmacen19 
    foreign key (clave_centro_operaciones)
    references almacen(clave_centro_operaciones)
;

alter table evento_almacen add constraint refempleado20 
    foreign key (empleado_id)
    references empleado(empleado_id)
;


-- 
-- table: farmacia 
--

alter table farmacia add constraint refcentro_operaciones7 
    foreign key (clave_centro_operaciones)
    references centro_operaciones(clave_centro_operaciones)
;


-- 
-- table: "farmacia-medicamento" 
--

alter table "farmacia-medicamento" add constraint reffarmacia14 
    foreign key (clave_centro_operaciones)
    references farmacia(clave_centro_operaciones)
;

alter table "farmacia-medicamento" add constraint refmedicamento15 
    foreign key (medicamento_id)
    references medicamento(medicamento_id)
;


-- 
-- table: historico_status_pedido 
--

alter table historico_status_pedido add constraint refpedido31 
    foreign key ("´pedido_id")
    references pedido("´pedido_id")
;

alter table historico_status_pedido add constraint refstatus_pedido32 
    foreign key (status_pedido_id)
    references status_pedido(status_pedido_id)
;


-- 
-- table: historico_ubicacion_pedido_paquete 
--

alter table historico_ubicacion_pedido_paquete add constraint refubicacion_actual43 
    foreign key (ubicacion_id)
    references ubicacion_actual(ubicacion_id)
;

alter table historico_ubicacion_pedido_paquete add constraint refpedido44 
    foreign key ("´pedido_id")
    references pedido("´pedido_id")
;


-- 
-- table: medicamento 
--

alter table medicamento add constraint reflista_nombres_medicamento16 
    foreign key (lista_nombres_medicamento_id)
    references lista_nombres_medicamento(lista_nombres_medicamento_id)
;


-- 
-- table: "medicamento-presentacion" 
--

alter table "medicamento-presentacion" add constraint refpresentacion35 
    foreign key (presentacion_id)
    references presentacion(presentacion_id)
;

alter table "medicamento-presentacion" add constraint refmedicamento36 
    foreign key (medicamento_id)
    references medicamento(medicamento_id)
;

alter table "medicamento-presentacion" add constraint refpedido_medicamento38 
    foreign key (pedido_medicamento_id)
    references pedido_medicamento(pedido_medicamento_id)
;


-- 
-- table: oficina 
--

alter table oficina add constraint refcentro_operaciones4 
    foreign key (clave_centro_operaciones)
    references centro_operaciones(clave_centro_operaciones)
;


-- 
-- table: operaciones_evento_medicamento 
--

alter table operaciones_evento_medicamento add constraint "refmedicamento-presentacion41" 
    foreign key ("medicamento-presentacion_id")
    references "medicamento-presentacion"("medicamento-presentacion_id")
;

alter table operaciones_evento_medicamento add constraint refevento_almacen23 
    foreign key (evento_almacen_id)
    references evento_almacen(evento_almacen_id)
;


-- 
-- table: pedido 
--

alter table pedido add constraint refstatus_pedido42 
    foreign key (status_pedido_id)
    references status_pedido(status_pedido_id)
;

alter table pedido add constraint refubicacion_actual45 
    foreign key (ubicacion_id)
    references ubicacion_actual(ubicacion_id)
;

alter table pedido add constraint refcliente28 
    foreign key (cliente_id)
    references cliente(cliente_id)
;


-- 
-- table: pedido_medicamento 
--

alter table pedido_medicamento add constraint refpedido26 
    foreign key ("´pedido_id")
    references pedido("´pedido_id")
;

alter table pedido_medicamento add constraint reffarmacia27 
    foreign key (clave_centro_operaciones)
    references farmacia(clave_centro_operaciones)
;



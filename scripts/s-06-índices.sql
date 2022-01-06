--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 05/01/2022
--@Descripción: Este archivo contiene la creación de los índices para 
--el proyecto Pharmacy Online (DDL)

create unique index oficina_clave_iuk 
  on oficina(clave);

create unique index farmacia_rfc_iuk 
  on farmacia(upper(rfc_fiscal));

create unique index cliente_rfc_iuk 
  on cliente(upper(rfc));

create index oficina_nombre_clave_ix 
  on oficina(upper(nombre));

create unique index empleado_rfc_iuk 
  on empleado(upper(rfc));

create index medicamento_nombre_sustancia_ix 
  on medicamento(upper(sustancia_activa));

create index lista_nombres_medicamento_ix
  on lista_nombres_medicamento(upper(nombre));

create index centro_operaciones_telefono_ix
  on centro_operaciones(telefono_centro_operaciones);

create unique index folio_pedido_ix
  on pedido(folio);

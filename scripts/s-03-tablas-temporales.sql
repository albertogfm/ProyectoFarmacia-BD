--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Declaración de las tablas temporales, las cuales nos ayudarán a
--eliminar datos y definiciones de tablas.
create global temporary table carrito_compra(
  carrito_compra_id number(10,0) not null,
  pago_total number(5,0) not null,
  constraint carrito_compra_pk primary key (carrito_compra_id)
) on commit delete rows
;

create private temporary table ora$ptt_cupon_descuento(
  cupon_descuento_id number(10,0),
  descuento number(4,2),
  detalle varchar2(100)
) on commit preserve definition; 
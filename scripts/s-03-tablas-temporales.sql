create global temporary table carrito_compra(
  carrito_compra_id number(10,0) not null,
  pago_total number(5,0) not null,
  constraint carrito_compra_pk primary key (carrito_compra_id)
);

create private temporary table ora$ptt_cupon_descuento(
  cupon_descuento_id number(10,0) not null;
  descuento number(4,2) not null;
  detalle varchar2(100) not null;
  constraint cupon_descuento_pk primary key (cupon_descuento_id)
); 
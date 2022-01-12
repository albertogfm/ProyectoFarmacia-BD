create or replace function pago_cliente(p_cliente_id cliente.cliente_id%type)
return number
is
  v_sumapagos number(10,0) := 0;
begin
  select sum(cantidad) into v_sumapagos
  from pedido
  where codigocliente = p_cliente_id;
  return v_sumapagos;
end;
/
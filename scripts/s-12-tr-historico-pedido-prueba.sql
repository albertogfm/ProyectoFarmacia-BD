--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción:Prueba del trigger historico_pedido


declare
  v_pedido_id pedido.pedido_id%type;
  v_folio pedido.folio%type;
  v_fecha_pedido pedido.fecha_pedido%type;
  v_importe pedido.importe%type;
  v_fecha_status pedido.fecha_status%type;
  v_cliente_id pedido.cliente_id%type;
  v_status_pedido_id pedido.status_pedido_id%type;
  v_ubicacion_actual_id pedido.ubicacion_actual_id%type;
begin
  --Insertando un registro para que capture el estado capturado
  select dbms_random.value(1500,2000) into v_pedido_id from dual;
  v_folio := '0123456689HAM';
  v_fecha_pedido := sysdate;
  select dbms_random.value(1500,2000) into v_importe from dual;
  v_fecha_status := sysdate;
  v_cliente_id :=1;
  v_status_pedido_id :=1;
  insert into pedido (pedido_id,folio, fecha_pedido, importe, fecha_status, cliente_id, status_pedido_id)
    values(v_pedido_id,v_folio, v_fecha_pedido, v_importe, v_fecha_status, v_cliente_id, v_status_pedido_id);
  --Actualizando el registro a todos los status disponibles
  update pedido set status_pedido_id = 2 where pedido_id=v_pedido_id;
  update pedido set status_pedido_id = 3 where pedido_id=v_pedido_id;
  update pedido set status_pedido_id = 4 where pedido_id=v_pedido_id;
  update pedido set status_pedido_id = 5 where pedido_id=v_pedido_id;
end;
/
show errors
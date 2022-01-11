create or replace trigger tr_inicio_ubicacion
  after update of status_pedido_id on pedido
  for each row
declare
  v_ubicacion_actual_id number (10,0);
  v_latitud number (3,0);
  v_longitud number (3,0);
begin
  select ubicacion_actual_seq.nextval into v_ubicacion_actual_id from dual;
  v_latitud := dbms_random.value(20,999);
  v_longitud := dbms_random.value(20,999);
  if :new.status_pedido_id=2 or :new.status_pedido_id=3 then
    insert into ubicacion_actual (ubicacion_actual_id, latitud, longitud)
      values(v_ubicacion_actual_id,v_latitud, v_longitud);
    dbms_output.put_line('El pedido esta en transito o ya entregado');
  else 
    dbms_output.put_line('El pedido esta devuelto o cancelado, o puede estar recien creado');
  end if;
end;
/
show errors;


--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción:En este trigger se genera una nueva ubicación por cada cambio de 
--status en el pedido, de esta manera se podrá generar ubicaciones aleatorias y
--así simular una entrega

create or replace trigger tr_inicio_ubicacion
  before update of status_pedido_id on pedido
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
    :new.ubicacion_actual_id := v_ubicacion_actual_id;
  else 
    dbms_output.put_line('El pedido esta devuelto o cancelado, o puede estar recien creado');
  end if;
end;
/
show errors;


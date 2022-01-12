--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción:En este trigger actualizamos el historico de la tabla pedido por 
--cada cambio de ubicacion que exista en dicha tabla. 



create or replace trigger tr_ubicacion
  after insert or update of ubicacion_actual_id on pedido
  for each row
  declare
    v_ubicacion_actual_id number(2,0);
    v_fecha_status date;
    v_hist_id number(10,0);
    v_pedido_id number(10,0);
begin
    select historico_ubicacion_pedido_seq.nextval into v_hist_id from dual;
case
  when inserting then
    v_fecha_status := :new.fecha_status;
    v_ubicacion_actual_id := dbms_random.value(1,100);
    v_pedido_id := :new.pedido_id;
    -- obtiene el consecutivo de la secuencia
    --asigna valores a las variables con el nuevo status y fecha
    dbms_output.put_line('ubicacion anterior: '|| :old.ubicacion_actual_id);
    dbms_output.put_line('ubicacion nueva: '|| :new.ubicacion_actual_id);
    dbms_output.put_line('insertando en historico, pedido_id: '
    || v_pedido_id ||', ubicacion_actual_id: ' || v_ubicacion_actual_id
    ||', fecha: '|| v_fecha_status||', hist_id: '||v_hist_id);
    -- inserta en el histórico
    insert into historico_ubicacion_pedido_paquete
      (historico_ubicacion_pedido_paquete_id,fecha,ubicacion_actual_id,pedido_id)
      values(v_hist_id, v_fecha_status, v_ubicacion_actual_id,v_pedido_id);
  when updating then
    -- obtiene el consecutivo de la secuencia
   
    --asigna valores a las variables con el nuevo status y fecha
    v_fecha_status := :new.fecha_status;
    v_ubicacion_actual_id := dbms_random.value(1,100);
    v_pedido_id := :old.pedido_id;
    dbms_output.put_line('ubicacion anterior: '|| :old.ubicacion_actual_id);
    dbms_output.put_line('ubicacion nueva: '|| :new.ubicacion_actual_id);
    dbms_output.put_line('insertando en historico, pedido_id: '
    || v_pedido_id ||', ubicacion_actual_id: ' || v_ubicacion_actual_id
    ||', fecha: '|| v_fecha_status||', hist_id: '||v_hist_id);
    -- inserta en el histórico
    insert into historico_ubicacion_pedido_paquete
      (historico_ubicacion_pedido_paquete_id,fecha,ubicacion_actual_id,pedido_id)
      values(v_hist_id, v_fecha_status, v_ubicacion_actual_id,v_pedido_id);
  end case;
end;
/
show errors;
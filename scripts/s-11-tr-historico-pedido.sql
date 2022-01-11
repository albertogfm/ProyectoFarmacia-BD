create or replace trigger tr_status_pedido
  after insert or update of status_pedido_id on pedido
  for each row
  declare
    v_status_id number(2,0);
    v_fecha_status date;
    v_hist_id number(10,0);
    v_pedido_id number(10,0);
begin
-- obtiene el consecutivo de la secuencia
  select historico_status_pedido_seq.nextval into v_hist_id from dual;
--asigna valores a las variables con el nuevo status y fecha
  v_status_id := :new.status_pedido_id;
  v_fecha_status := :new.fecha_status;
  v_pedido_id := :new.pedido_id;
  dbms_output.put_line('status anterior: '|| :old.status_pedido_id);
  dbms_output.put_line('status nuevo: '|| :new.status_pedido_id);
  dbms_output.put_line('insertando en historico, pedido_id: '
  || v_pedido_id ||', status_id: ' || v_status_id
  ||', fecha: '|| v_fecha_status||', hist_id: '||v_hist_id);
-- inserta en el histórico
  insert into historico_status_pedido
    (historico_status_pedido_id,fecha_status,pedido_id,status_pedido_id)
    values(v_hist_id, v_fecha_status, v_pedido_id,v_status_id);
end;
/
show errors;
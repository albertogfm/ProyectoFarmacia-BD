--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción:En este trigger actualizamos el historico de la tabla pedido por 
--cada cambio de status que exista en dicha tabla. 


create or replace trigger tr_status_pedido
  after insert or update of status_pedido_id on pedido
  for each row
  declare
    v_status_id number(2,0);
    v_fecha_status date;
    v_hist_id number(10,0);
    v_pedido_id number(10,0);
begin
  select historico_status_pedido_seq.nextval into v_hist_id from dual;
  v_status_id := :new.status_pedido_id;
  v_fecha_status := :new.fecha_status;
  v_pedido_id := :new.pedido_id;
  dbms_output.put_line('PRUEBA PEDIDO');
  dbms_output.put_line('==Status anterior: '|| :old.status_pedido_id);
  dbms_output.put_line('==Status nuevo: '|| :new.status_pedido_id);
  dbms_output.put_line('INSERTANDO EN HISTORICO'
                   || u'\000A'' pedido_id: '|| v_pedido_id 
                   || u'\000A'||'status_id: ' || v_status_id
                   || u'\000A'||' fecha: '|| v_fecha_status
                   || u'\000A'||' hist_id: '||v_hist_id);
  insert into historico_status_pedido
    (historico_status_pedido_id,fecha_status,pedido_id,status_pedido_id)
    values(v_hist_id, v_fecha_status, v_pedido_id,v_status_id);
end;
/
show errors;
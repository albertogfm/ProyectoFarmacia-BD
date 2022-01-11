create or replace trigger tr_auditoria_pedido
  before 
  update of importe or
  delete on pedido
  for each row
declare
  v_importe pedido.importe%type;
  v_cliente_id number(10,0);
  v_USERNAME varchar2(50);
begin
  v_USERNAME := USER; 
  case
    when updating then 
      if :old.importe<>:new.importe then
        update pedido set status_pedido_id = 5 where pedido_id = :old.pedido_id;
      end if;
      dbms_output.put_line('El usuario que trató de cambiar el importe fue '|| v_USERNAME);
    when deleting then
      update pedido set status_pedido_id =5 where pedido_id = :old.pedido_id;
      dbms_output.put_line('El usuario que trató de eliminar el importe fue '|| v_USERNAME);
  end case;
END; 
  /
show errors
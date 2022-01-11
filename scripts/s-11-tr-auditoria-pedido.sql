create or replace trigger tr_auditoria_pedido
  after 
  update of importe  on pedido
  for each row
declare
  v_importe_actual pedido.importe%type;
  v_importe_nuevo pedido.importe%type;
  v_cliente_id number(10,0);
  v_USERNAME varchar2(50);
begin
  v_importe_actual := :old.importe;
  v_importe_nuevo := :new.importe;
  v_USERNAME := USER; 

    if v_importe_actual<>v_importe_nuevo then
      dbms_output.put_line('El usuario que trató de cambiar el importe fue '|| v_USERNAME);
      raise_application_error(-20001,'se intento cambiar el importe de un pedido');
    end if;

END; 
  /
show errors
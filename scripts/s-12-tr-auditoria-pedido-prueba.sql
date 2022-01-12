--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción:Prueba del trigger auditoria_prueba

declare
  v_importe number;
  v_importe_antes number;
  v_importe_despues number;
begin
  select dbms_random.value(1,1000) into v_importe from dual;

  select importe into v_importe_antes from pedido where pedido_id = 1;
  dbms_output.put_line('EL IMPORTE DEL PEDIDO 1 ANTES DEL UPDATE:  ' || v_importe_antes);
  
  update pedido set importe=v_importe where pedido_id=1;
  
  select importe into v_importe_despues from pedido where pedido_id = 1;
  dbms_output.put_line('EL IMPORTE DEL PEDIDO 1 DESPUES DEL UPDATE' || v_importe_despues);
  
  commit;
end;
/
show errors
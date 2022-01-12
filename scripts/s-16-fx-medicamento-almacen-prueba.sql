declare
  v_num_medicamentos number(10,0);
begin
  v_num_medicamentos := medicamento_almacen('MFD9LH');
  dbms_output.put_line('Hay '||v_num_medicamentos  ||' en el almacen MFD9LH');
end;
/
show errors

--NCR3WD9RENLCI

declare
begin
  v_num_medicamentos := pago_cliente(11);
  dbms_output.put_line("El cliente debe "||v_num_medicamentos  
  ||"en el almacen MFD9LH");
end;
/
show errors

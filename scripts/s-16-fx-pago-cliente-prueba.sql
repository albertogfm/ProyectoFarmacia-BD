--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Prueba funcion num_medicamentos

declare
  v_num_medicamentos number(10,0);
begin
  v_num_medicamentos := pago_cliente(11);
  dbms_output.put_line('El cliente genero  '||v_num_medicamentos  
  ||' dolares');
end;
/
show errors

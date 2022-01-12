--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Prueba función que genera folios.
declare
  v_folio pedido.folio%type;
begin
  v_folio := genera_folio();
  dbms_output.put_line('El folio creado es '||v_folio);
end;
/
show errors
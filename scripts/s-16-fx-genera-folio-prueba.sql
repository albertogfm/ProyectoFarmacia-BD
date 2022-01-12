declare
  v_folio pedido.folio%type;
begin
  v_folio := genera_folio();
  dbms_output.put_line('El folio creado es '||v_folio);
end;
/
show errors
declare
begin
  v_folio := genera-folio();
  dbms_output.put_line("El folio creado es "||v_folio);
end;
/
show errors
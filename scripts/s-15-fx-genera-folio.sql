create or replace function genera_folio()
return varchar2
is
v_folio varchar2(13);
begin
  v_folio:= dbms_random.string('x',13);
  return v_folio;
/
showerrors
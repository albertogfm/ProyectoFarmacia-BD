--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Función que genera folios para los pedidos.
create or replace function genera_folio
return varchar2
is
v_folio varchar2(13);
begin
  v_folio:= dbms_random.string('x',13);
  return v_folio;
end;
/
show errors
set serveroutput on
declare
    cursor cur_clave_almacen is
    select clave_centro_operaciones
    from almacen;
--    where clave_centro_operaciones='0Q5HBR'; 
begin
  for almacen in cur_clave_almacen loop
    sp_actualiza_almacen_dir(almacen.clave_centro_operaciones);
  end loop;
end;
/

--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Prueba script lob.


set serveroutput on
declare
    cursor cur_clave_almacen is
    select clave_centro_operaciones
    from almacen;
begin
  for almacen in cur_clave_almacen loop
    sp_actualiza_almacen_dir(almacen.clave_centro_operaciones);
  end loop;
end;
/

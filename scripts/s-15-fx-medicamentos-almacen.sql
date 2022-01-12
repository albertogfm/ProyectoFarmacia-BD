--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Función que indica el numeró de medicamentos existentes en un 
--almacen


create or replace function medicamento_almacen
(p_clave_almacen in almacen.clave_centro_operaciones%type)
return number
is
v_num_medicamentos number (10,0);
begin

select q1.entrada-nvl(q2.salida,0) into v_num_medicamentos
from (
  select clave_centro_operaciones,sum(e.numero_unidades) entrada
  from v_evento e
  where e.tipo_evento='ENTRADA'
  group by clave_centro_operaciones
)q1
left join (
  select clave_centro_operaciones,sum(e.numero_unidades) salida
  from v_evento e
  where e.tipo_evento='SALIDA'
  group by clave_centro_operaciones
)q2 on q1.clave_centro_operaciones=q2.clave_centro_operaciones
where Q1.clave_centro_operaciones=p_clave_almacen;


return v_num_medicamentos;
end;
/
show errors;



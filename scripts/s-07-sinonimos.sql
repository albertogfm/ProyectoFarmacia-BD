prompt creando sinonimos publicos
create or replace public synonym detalle_evento for operacion_evento_medicamento;
create or replace public synonym medicina for medicamento ;
create or replace public synonym cedis for centro_operaciones ;

prompt dando pemisos al invitado de lectura
grant select on detalle_evento to gaga_proy_invitado;
grant select on medicina to gaga_proy_invitado;
grant select on cedis to gaga_proy_invitado;

prompt conectando con el usuario invitado gaga_proy_invitado
connect gaga_proy_invitado/gaga

prompt creando sinonimos privados para el invitado
create or replace synonym detalle_evento for gaga_proy_admin.detalle_evento;
create or replace synonym medicina for gaga_proy_admin.medicina;
create or replace synonym cedis for gaga_proy_admin.cedis;

prompt conectando con el usuario invitado gaga_proy_admin
connect gaga_proy_admin/gaga

prompt creando sinonimos de software externo con prefijo
declare
  cursor cur_table_names is
   select table_name
   from user_tables;
begin 
  for i in cur_table_names loop
    execute immediate 
    'create or replace synonym XX_'||i.table_name||' for '||i.table_name;
  end loop;
end;
/

  Prompt Realizando pruebas con los sinonimos creados
  select * from XX_medicamento where medicamento_id between 1 and 5;
  select * from XX_empleado;
  select * from cedis;
  select * from medicina where medicamento_id between 1 and 5;
  select * from detalle_evento;

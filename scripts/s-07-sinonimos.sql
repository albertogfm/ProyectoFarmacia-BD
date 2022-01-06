prompt creando sinonimos publicos
create or replace public synonym operacion_evento_medicamento 
for detalle_evento;
create or replace public synonym  medicamento for medicicina;
create or replace public synonym centro_operaciones for cedis;

prompt dando pemisos al invitado de lectura
grant select on detalle_evento to gaga_proy_invitado;
grant select on medicina to gaga_proy_invitado;
grant select on cedis to gaga_proy_invitado;

prompt conectando con el usuario invitado gaga_proy_invitado
connect gaga_proy_invitado

prompt creando sinonimos privados para el invitado
create or replace synonym detalle_evento for gaga_proy_admin.detalle_evento;
create or replace synonym medicina for gaga_proy_admin.medicina
create or replace synonym cedis for gaga_proy_admin.cedis;

prompt conectando con el usuario invitado gaga_proy_admin
connect gaga_proy_admin

prompt creando sinonimos de software externo con prefijo
declare

  cursor cur_table_names is
   select table_name
   from user_tables;
  
begin 
  for i in cur_table_names loop
    execute immediate 
    'create or replace private synonym XX_'||i.table_name||' for '||i.table_name;
  end loop;
end;
/

--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: En este archivo se definen los sinonimos de algunas tablas para 
--simplificar alguna operación que se tengan que realizar sobre los datos de
--ellas.


Prompt =====CREANDO SINONIMOS PUBLICOS USANDO AL USUARIO ADMIN=====
create or replace public synonym detalle_evento for 
  operacion_evento_medicamento;
create or replace public synonym medicina for medicamento ;
create or replace public synonym cedis for centro_operaciones ;

Prompt =====DANDO PEMISOS AL INVITADO DE LECTURA=====
grant select on detalle_evento to gaga_proy_invitado;
grant select on medicina to gaga_proy_invitado;
grant select on cedis to gaga_proy_invitado;

Prompt ======CONECTANDO CON EL USUARIO INVITADO====== 
connect gaga_proy_invitado/gaga

Prompt =====CREANDO SINONIMOS PRIVADOS PARA EL INVITADO=====
create or replace synonym detalle_evento for gaga_proy_admin.detalle_evento;
create or replace synonym medicina for gaga_proy_admin.medicina;
create or replace synonym cedis for gaga_proy_admin.cedis;

Prompt CONECTANDO CON EL USUARIO GAGA_PROY_ADMIN
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
set linesize window


col sustancia_activa format a30
col descripcion format a55
col medicamento_id heading med_id
column medicamento_id clear
Prompt ============REALIZANDO PRUEBAS CON LOS SINONIMOS CREADOS=============
select * from XX_medicamento where medicamento_id between 1 and 5;
select * from XX_empleado;
select * from cedis;
select * from medicina where medicamento_id between 1 and 5;
select * from detalle_evento;

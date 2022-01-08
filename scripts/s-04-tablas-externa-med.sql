
--Creando tabla con los nombres del medicamento
prompt Conectando como sys
connect sys/system as sysdba
prompt creando directorio tmp_dir
create or replace directory tmp_dir 
  as '/tmp/bases';

grant read, write on directory tmp_dir to gaga_proy_admin;
prompt Contectando con usuario gaga_proy_admin para crear la tabla externa
connect gaga_proy_admin/gaga
show user
prompt creando tabla externa

-- Creando tabla medicamento
create table medicamento_respaldo (
  medicamento_id number(10,0) not null,
  sustancia_activa varchar2(150) not null,
  descripcion varchar2(1000) not null,
  lista_nombres_medicamento_id number(5,0) not null
)
organization external (
  type oracle_loader
  default directory tmp_dir
  access parameters (
  records delimited by newline
  badfile tmp_dir:'medicamento_respaldo_bad.log'
  logfile tmp_dir:'medicamento_respaldo.log'
  fields terminated by '#'
  lrtrim
  missing field values are null
  (
    medicamento_id, sustancia_activa, descripcion, lista_nombres_medicamento_id
  )
  )
  location ('medicamento.csv')
)
reject limit unlimited;

merge into medicamento_respaldo r using medicamento m on
(r.medicamento_id = m.medicamento_id)
when matched then update
set r.sustancia_activa=m.sustancia_activa, r.descripcion=m.descripcion, 
  r.lista_nombres_medicamento_id=m.lista_nombres_medicamento_id
when not matched then insert
(r.medicamento_id, r.sustancia_activa, r.descripcion, r.lista_nombres_medicamento_id) values
(m.medicamento_id, m.sustancia_activa, r.descripcion, m.lista_nombres_medicamento_id);

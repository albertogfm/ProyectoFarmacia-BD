
--Creando tabla con los nombres del medicamento
prompt Conectando como sys
connect sys as sysdba
prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';

grant read, write on directory tmp_dir to gaga_proy_admin;
prompt Contectando con usuario jorge0507 para crear la tabla externa
connect gaga_proy_admin
show user
prompt creando tabla externa
create table lista_nombres_respaldo (
  ln_medicamento_respaldo_id number(10,0) not null,
  nombre varchar2(100) not null
)
organization external (
  type oracle_loader
  default directory tmp_dir
  access parameters (
    records delimited by newline
    badfile tmp_dir:'lista_nombres_medicamento_bad.log'
    logfile tmp_dir:'lista_nombres_medicamento.log'
    fields terminated by ','
    lrtrim
    missing field values are null(
      lista_nombres_medicamento_id, nombre
    )
  )
  location ('lista_nombres_medicamento.csv')
)
reject limit unlimited;

-- Creando tabla medicamento
create table medicamento_respaldo (
  medicamento_id number(10,0) not null,
  sustancia_activa varchar2(1000) not null,
  descripcion varchar2(100) not null,
  lista_nombres_medicamento_id number(10,0) not null,
)
organization external (
  type oracle_loader
  default directory tmp_dir
  access parameters (
  records delimited by newline
  badfile tmp_dir:'medicamento_respaldo_bad.log'
  logfile tmp_dir:'medicamento_respaldo.log'
  fields terminated by ','
  lrtrim
  missing field values are null
  (
  medicamento_id, sustancia_activa, descripcion, lista_nombres_medicamento_id
  )
  )
  location ('medicamento.csv')
)
reject limit unlimited;


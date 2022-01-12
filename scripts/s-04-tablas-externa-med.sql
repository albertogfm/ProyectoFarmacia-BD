--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: El script contiene la declaración de la tabla temporal externa 
-- que obtiene los datos de un CSV, dicha tabla externa nos ayuda a inicar una 
--carga de datos a la tabla de medicamento a través de un cursor.

--Creando tabla con los nombres del medicamento
prompt Conectando como sys
connect sys/system as sysdba
prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';

grant read, write on directory tmp_dir to gaga_proy_admin;

prompt Contectando con usuario gaga_proy_admin para crear la tabla externa
connect gaga_proy_admin/gaga
show user
prompt creando tabla externa

-- Creando tabla medicamento
create table medicamento_respaldo (
  medicamento_id number(10,0) not null,
  sustancia_activa varchar2(150) not null,
  descripcion varchar2(350) not null
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
    medicamento_id, sustancia_activa, descripcion
  )
  )
  location ('medicamento.csv')
)
reject limit unlimited;


Prompt =========LLENANDO TABLA MEDICAMENTO CON LA EXTERNA==========
declare
--Declarando cursor
v_lista_nombres_medicamento_id number(5,0);
cursor cur_medicamento is
  select * from medicamento_respaldo;
begin
  for m in cur_medicamento loop
    insert into medicamento(medicamento_id,sustancia_activa,descripcion) 
    values (m.medicamento_id,m.sustancia_activa,m.descripcion);
  end loop;
end;
/
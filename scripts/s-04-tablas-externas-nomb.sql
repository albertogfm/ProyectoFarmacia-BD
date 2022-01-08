
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
create table lista_nombres_respaldo (
  lista_nombres_medicamento_id number(10,0) not null,
  nombre varchar2(100) not null
) organization external (
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
  location ('lista_nombres_medicamentos.csv')
)
reject limit unlimited;

prompt Realizando insercion de datos en medicamento nombres

declare
--Declarando cursor
cursor cur_medicamento is
  select * from lista_nombres_respaldo;
begin
  for m in cur_medicamento loop
    insert into lista_nombres_medicamento(lista_nombres_medicamento_id, nombre) 
    values (m.lista_nombres_medicamento_id, m.nombre);
  end loop;
end;
/




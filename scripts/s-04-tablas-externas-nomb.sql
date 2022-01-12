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
create table lista_nombres_respaldo (
  lista_nombres_medicamento_id number(10,0) not null,
  nombre varchar2(100) not null,
  medicamento_id number(10,0) not null
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
      lista_nombres_medicamento_id, nombre,medicamento_id
    )
  )
  location ('lista_nombres_medicamentos.csv')
)
reject limit unlimited;

prompt =========LLENANDO TABLA NOMBRES MEDICAMENTO CON LA EXTERNA==========

declare
--Declarando cursor
cursor cur_medicamento is
  select * from lista_nombres_respaldo;
begin
  for m in cur_medicamento loop
    insert into lista_nombres_medicamento(lista_nombres_medicamento_id, nombre, medicamento_id) 
    values (m.lista_nombres_medicamento_id, m.nombre, m.medicamento_id);
  end loop;
end;
/




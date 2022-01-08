--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Este archivo contiene la creación de usuarios para 
--el proyecto Pharmacy Online
clear screen
Prompt proporcione el password del usuario sys
connect sys/system as sysdba
--permite la salida de mensajes a consula empleabo dbms_output.put_line
set serveroutput on
--este bloque anómimo valida la existencia del usuario, si existe lo elimina.
declare
  v_count_1 number(1,0);
  v_count_2 number(1,0);
  v_count_3 number(1,0);
  v_count_4 number(1,0);
begin
  --USUARIO PROY INVITADO
  select count(*) into v_count_1
  from dba_users
  where username = 'GAGA_PROY_INVITADO';
  if v_count_1 > 0 then
    dbms_output.put_line('Eliminando usuario invitado');
    execute immediate 'drop user gaga_proy_invitado cascade';
  end if;
  --USUARIO PROY ADMIN
  select count(*) into v_count_2
  from dba_users
  where username = 'GAGA_PROY_ADMIN';
  if v_count_1 > 0 then
    dbms_output.put_line('Eliminando usuario existente');
    execute immediate 'drop user gaga_proy_admin cascade';
  end if;
  --USUARIO ROL ADMIN
  select count(*) into v_count_3
  from dba_roles
  where role = 'ROL_ADMIN';
  if v_count_3 > 0 then
    dbms_output.put_line('Eliminando rol admin');
    execute immediate 'drop role ROL_ADMIN';
  end if;
  --USUARIO ROL INVITADO
  select count(*) into v_count_4
  from dba_roles
  where role = 'ROL_INVITADO';
  if v_count_4 > 0 then
    dbms_output.put_line('Eliminando rol invitado');
    execute immediate 'drop role ROL_INVITADO';
  end if;
end;
/
Prompt Creando usuario invitado
create user gaga_proy_invitado identified by gaga quota unlimited on users;

Prompt Creando usuario admin
create user gaga_proy_admin identified by gaga quota unlimited on users;

create role rol_admin;
grant create session, create table, create view,create procedure,create trigger,
create sequence to rol_admin;

create role rol_invitado;
grant create session, create table to rol_invitado;

prompt Asignando roles
grant rol_admin to gaga_proy_admin;
grant rol_invitado to gaga_proy_invitado;
Prompt Listo!
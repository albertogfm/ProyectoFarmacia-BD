--@Autor:  GARCIA FIGUEROA MUNGUIA ALBERTO y GARCIA GUTIERREZ EDGAR CRISTOBAL
--@Fecha creación: 30/12/2021
--@Descripción: Creación de usuario Practica 12

prompt Configurando directorio
conn sys/system as sysdba
create or replace directory dir_files as '/tmp/bases/direccion_files';
grant read, write on directory dir_files to gaga_proy_admin;

prompt Creando procedimiento con usuario gaga_1201_autos
conn gaga_proy_admin/gaga
set serveroutput on
create or replace procedure sp_actualiza_almacen_dir (v_index in varchar2) is
  v_bfile bfile;
  v_src_offset number;
  v_dest_offset number;
  v_blob blob;
  v_src_length number;
  v_dest_length number;
  v_nombre_archivo varchar2(50);
begin
    --Nombre Archivo
    v_nombre_archivo:='auto-'||v_index||'.jpg';
    dbms_output.put_line('Cargando foto para '||v_nombre_archivo);
    
    --Validando si el archivo existe
    v_bfile:=bfilename('DIR_FILES',v_nombre_archivo);
    if dbms_lob.fileexists(v_bfile)=0 then
        raise_application_error(-20001,'El archivo '||v_nombre_archivo||' no existe.');
    end if;
    if dbms_lob.isopen(v_bfile)=1 then
        raise_application_error(-20001,'El archivo '||v_nombre_archivo||' está abierto. No se puede usar');
    end if;

    --Abriendo archivo 
    dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
   
    --Actualizando blob en la tabla
    --Asegurarse que la tabla auto contenga datos y la columna foto debe tener un blob vacío.
    --Asignar v_blob
    select documento_secciones into v_blob
      from almacen
      where clave_centro_operaciones=v_index 
      for update;
    --Escribiendo bytes
    v_src_offset:=1;
    v_dest_offset:=1;
    dbms_lob.loadblobfromfile(
        dest_lob      => v_blob,
        src_bfile     => v_bfile,
        amount        => dbms_lob.getlength(v_bfile),
        dest_offset   => v_dest_offset,
        src_offset    => v_src_offset
    );

    --Cerrando archivo
    dbms_lob.close(v_bfile);
    --Validando carga
    v_src_length:=dbms_lob.getlength(v_bfile);
    v_dest_length:=dbms_lob.getlength(v_blob);

    if v_dest_length<>v_src_length then 
        raise_application_error(-20001,'El archivo '||v_nombre_archivo||' no se cargó correctamente');
    end if;
end;
/
show errors

--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción:En este procedimiento se crea un usuario, el cual podrá realizar 
--pedidos



create or replace procedure createUser(
    v_nombre in varchar2,v_apellido_paterno in varchar2,v_apellido_materno in varchar2,
    v_rfc in varchar2, v_direccion in varchar2, v_telefono in number, v_email in varchar2,
    v_numero_tarjeta in varchar2, v_anio in number, v_mes in number,v_curp in varchar2 default null,
    v_status out number
) is
  v_cliente_id cliente.cliente_id%type;
  v_validar number(2,0);
begin
  v_status := -1;
  select cliente_seq.nextval into v_cliente_id from dual;

  select count(*) into v_validar 
   from empleado 
   where rfc = v_rfc;
  
  if v_validar > 0 then
    raise_application_error(-20001,'EL empleado ya existe ');
  end if;


  select count(*) into v_validar 
   from tarjeta 
   where numero_tarjeta = v_numero_tarjeta;
  
  if v_validar > 0 then
    raise_application_error(-20001,'La tarjeta ya existe ');
  end if;


  insert into tarjeta(numero_tarjeta,anio_expiracion,mes_expiracion) 
    values (v_numero_tarjeta,v_anio,v_mes);
  insert into cliente (cliente_id,nombre,apellido_paterno,apellido_materno,
    rfc,direccion,telefono,email,numero_tarjeta,curp) 
  values(v_cliente_id,v_nombre,v_apellido_paterno,v_apellido_materno,v_rfc,v_direccion,v_telefono,v_email,v_numero_tarjeta,v_curp);
   v_status := 1;
  if v_curp is null then
    dbms_output.put_line('EL CLIENTE SE REGISTRO CON EXITO PERO OMITIÓ SU CURP, EN ESTE MOMENTO SE AVISO AL 911 POR EVASION FISCAL XD');
  else 
    dbms_output.put_line('EL CLIENTE SE REGISTRO CON EXITO ');
  end if;
end;
/
show errors
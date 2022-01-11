declare 
  v_nombre cliente.nombre%type; 
  v_apellido_paterno cliente.apellido_paterno%type; 
  v_apellido_materno cliente.apellido_materno%type; 
  v_rfc cliente.rfc%type;
  v_direccion cliente.direccion%type;
  v_telefono cliente.telefono%type;
  v_email cliente.email%type;
  v_numero_tarjeta cliente.numero_tarjeta%type;
  v_anio tarjeta.anio_expiracion%type;
  v_mes tarjeta.mes_expiracion%type; 
  v_curp cliente.curp%type;
  v_estado number(10,0) := -1 ;
begin
  v_nombre := 'Ricardo';
  v_apellido_paterno := 'Perez';
  v_apellido_materno := 'Martinez';
  v_rfc := '0123456789HMM'; 
  v_direccion := 'CANDELARIA';
  v_telefono := 5566777888;
  v_email := 'UNCORREO@CORREO.COM';
  v_numero_tarjeta := '0000000000000000';
  v_anio := '23';
  v_mes :=  '12';
  v_curp := 'JAJE111555HMTRDA51';

  createUser(v_nombre, v_apellido_paterno, v_apellido_materno, v_rfc, v_direccion, v_telefono,v_email,v_numero_tarjeta, v_anio, v_mes, v_curp,v_estado);

  if v_estado = 1 then
    dbms_output.put_line('Prueba 1 realizada exitosamente');
  else
    dbms_output.put_line('Prueba 1 no fue exitosa');
  end if;
  rollback;
end;
/
show errors
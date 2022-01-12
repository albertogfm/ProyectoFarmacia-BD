--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Prueba procedimiento create_user.
declare 
  v_estado number(10,0) := -1 ;
begin

  createUser('RICARDO', 'PEREZ', 'MARTINEZ', '0123456789HMM', 'CANDELARIA 581',
  5566777888,'UNCORREO@CORREO.COM','0000000000000000', '23', '12', 'JAJE111555HMTRDA51',v_estado);

  if v_estado = 1 then
    dbms_output.put_line('Prueba 1 realizada exitosamente');
  else
    dbms_output.put_line('Prueba 1 no fue exitosa');
  end if;
  rollback;

  createUser('GERRARDO', 'FERNANDEZ', 'GUTIERREZ', 'BFBS003649N20', 'LOS PINOS 91',
  5566777888,'OTROCORREO@CORREO.COM','4700596613251155', '22', '1', null,v_estado);
  if v_estado = 1 then
    dbms_output.put_line('Prueba 1 realizada exitosamente');
  else
    dbms_output.put_line('Prueba 1 no fue exitosa');
  end if;
  rollback;


  createUser('CRISTOBAL', 'GARCIA', 'GUTIERREZ', 'GAGE000213V05', 'TEXCOCO MUY MUY LEJANO',
  5556697888,'CRIS@KGB.COM','4700596613251155', '25', '10', null,v_estado);
  if v_estado = 1 then
    dbms_output.put_line('Prueba 1 realizada exitosamente');
  else
    dbms_output.put_line('Prueba 1 no fue exitosa');
  end if;
  rollback;


end;
/
show errors
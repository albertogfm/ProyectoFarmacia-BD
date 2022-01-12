--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción:En este procedimiento se generan los pedidos de acuerdo a un 
--medicamento y cantidad especificada.


set serveroutput on
create or replace procedure genera_pedido(
  v_rfc in varchar2
)
is
  v_n number(2,0);
  v_pedido_id pedido.pedido_id%type;
  v_folio pedido.folio%type;
  v_fecha_status pedido.fecha_status%type;
  v_cliente cliente.cliente_id%type;
  v_status pedido.status_pedido_id%type;
  v_importe  pedido.importe%type;
  v_medicamento  varchar2(200);
  v_presentancion  varchar2(2);
  v_unidades number(10,0);
  v_medicamento_id medicamento.medicamento_id%type;
  v_presentancion_id number(10,0);
  v_fecha_pedido date;
begin
  select pedido_seq.nextval into v_pedido_id from dual; 
  select cliente_id into v_cliente from cliente where rfc = v_rfc;
  v_folio := DBMS_RANDOM.string('u',13);
  v_importe:= dbms_random.value(1000,5000);
  v_fecha_pedido := sysdate;
  v_fecha_status := sysdate;
  v_status := 1;
  insert into pedido(pedido_id, folio, fecha_pedido,fecha_status,importe,cliente_id,status_pedido_id,ubicacion_actual_id) 
  values(v_pedido_id, v_folio, v_fecha_pedido,v_fecha_status,v_importe,v_cliente,v_status,null);


    v_n := 3;
  
    for i in 1..v_n loop
      v_medicamento := 'UNAMOL';   
      v_presentancion := 'G';
      v_unidades := 2;
      select medicamento_id into v_medicamento_id 
        from lista_nombres_medicamento where nombre=v_medicamento;
      select presentacion_id into v_presentancion_id
        from presentacion where clave=upper(v_presentancion);
      insert into medicamento_presentacion(medicamento_presentacion_id,
        presentacion_id,medicamento_id) 
        values (medicamento_presentacion_seq.nextval,v_presentancion_id,v_medicamento_id);
      insert into pedido_medicamento(pedido_medicamento_id,numero_unidades, 
        pedido_id,clave_centro_operaciones,medicamento_presentacion_id)
        values(pedido_medicamento_seq.nextval,v_unidades,v_pedido_id,'ISX4YK',
        medicamento_presentacion_seq.currval);
    end loop;
  end;
  /
show errors

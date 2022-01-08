create or replace view v_cliente_tarjeta(
  cliente_id, nombre, apellido_paterno, apellido_materno, rfc, email, 
    numero_tarjeta
) as select c.nombre,c.apellido_paterno, c.apellido_materno, c.rfc, c.email,
t.numero_tarjeta 
from cliente c 
join tarjeta t 
  on c.numero_tarjeta=t.numero_tarjeta;

create or replace view v_evento(
  evento_medicamento_id, numero_unidades, fecha_evento, tipo_evento, 
  clave_centro_operaciones, rfc, nombre,apellidos,tipo_almacen
) as select op.evento_medicamento_id, op.numero_unidades, e.fecha_evento, 
  e.tipo_evento, a.clave_centro_operaciones, emp.rfc, emp.nombre, emp.apellidos,
    a.tipo_almacen
  from operacion_evento_medicamento op
  join evento_almacen e
    on op.evento_almacen=e.evento_almacen
  join empleado em
    on emp.empleado_id=op.empleado_id 
  join almacen a
    on a.clave_centro_operaciones=e.clave_centro_operaciones;

create or raplace v_pedido(
  folio, fecha_pedido, importe, nombre,apellido_paterno,direccion,
  status_pedido_id, latitud, longitud , numero_unidades, pedido_medicamento_id, unidades,
  sustancia_activa, descripcion
) as select p.folio, p.fecha_pedido, p.importe, c.nombre,c.apellido_paterno,
  c.direccion, sp.descripcion, u.latitud, u.longitud , pm.numero_unidades, 
  pm.pedido_medicamento_id, pr.unidades, m.sustancia_activa, m.descripcion
  from pedido p
   join cliente c on c.cliente_id=p.cliente_id;
   join status_pedido sp on p.status_pedido_id = sp.status_pedido_id
   left join ubicacion_actual u on p.ubicacion_actual_id=u.ubicacion_actual_id
   join pedido_medicamento pm on pm.pedido_id=p.pedido_id
   join medicamento_presentacion mp on pm.pedido_medicamento_id = 
     mp.pedido_medicamento
   join presentacion p on mp.presentacion_id=p.presentacion_id
   join medicamento m on mp.medicamento_id=m.medicamento_id;


select empleado_id, clave_centro_operaciones,min(fecha_ingreso)
  from empleado e
  join farmacia f
    on e.clave_centro_operaciones=f.clave_centro_operaciones
    group by empleado_id,clave_centro_operaciones;

--Consulta que obtiene los detalles del pedido más caro del cliente ROB 
--LIVINGSTONE BAMBROUGH, además de obtener los detalles de su tarjeta con la que 
--realizó la compra

--Se empleó
--inner join
--funciones de agregacion
--subconsultas

select p.folio, p.importe, c.nombre, c.apellido_paterno, c.apellido_materno, 
  t.numero_tarjeta
  from pedido p
  join cliente c on c.cliente_id=p.cliente_id
  join tarjeta t on c.numero_tarjeta=t.numero_tarjeta
  where p.importe = (
      select max(p.importe) 
        from pedido p 
        join cliente c
        on c.cliente_id = p.cliente_id
        where (c.nombre='ROB' and c.apellido_paterno='LIVINGSTONE' and 
        c.apellido_materno='BAMBROUGH')
  );

--Consulta que obtiene a los empleados que tengan la fecha de ingreso
--más reciente por cada registro de farmacia que exista

--Se empleó
--inner join
--uso de sinónimos
-- agregacion

select f.clave_centro_operaciones,f.rfc_fiscal,e.nombre,e.apellidos,e.rfc,q1.fecha_menor
from farmacia f
join empleado e
  on f.clave_centro_operaciones=e.clave_centro_operaciones
join (
  select f.clave_centro_operaciones,max(e.fecha_ingreso) fecha_menor
  from XX_empleado e
  join XX_farmacia f on e.clave_centro_operaciones = f.clave_centro_operaciones
  group by f.clave_centro_operaciones
) q1 on e.fecha_ingreso = q1.fecha_menor;


 --Consulta que obtiene el número total de medicamentos con las que 
 --cuenta la farmacia con el RFC RCYO6285480HYZ

select f.clave_centro_operaciones,f.rfc_fiscal, count(*) num_medicina
  from farmacia_medicamento fm
  join farmacia f on f.clave_centro_operaciones=fm.clave_centro_operaciones
  where f.rfc_fiscal='RCYO6285480HYZ'
  group by f.clave_centro_operaciones,f.rfc_fiscal;

--Consulta que obtiene al empleado con mas eventos en almacen, emplear la vista
-- v_evento
select emp.empleado_id, emp.nombre, emp.apellidos, e.evento_almacen_id, 
  e.tipo_evento, oem.operacion_evento_medicamento, oem.numero_unidades

--Consultar la sustancia activa de un medicamento de nombre , ademas
--mostrar todos los nombres que tengan la misma sustancia activa, empleando 
--la tabla externa


--Consultar el numero total de centros de operaciones, empleando el sinonimo
--cedis
select count(*) as cantidad_de_cedis
from cedis;

--Consulta que devuelve el los medicamentos devueltops por el cliente 
-- MADDIE SHIPLEY BELLIVEAU

select p.folio,m.sustancia_activa,pr.unidades as cantidad_caja,pm.numero_unidades as cajas_devueltas
from pedido p
join cliente c
  on p.cliente_id = c.cliente_id
join status_pedido sp
  on p.status_pedido_id=sp.status_pedido_id
join pedido_medicamento pm
  on pm.pedido_id=p.pedido_id
join medicamento_presentacion mp
  on mp.medicamento_presentacion_id=pm.medicamento_presentacion_id
join medicamento m
  on m.medicamento_id=mp.medicamento_id
join presentacion pr
  on pr.presentacion_id=mp.presentacion_id
where nombre='MADDIE' and apellido_paterno='SHIPLEY' 
  and apellido_materno='BELLIVEAU' and sp.descripcion='DEVUELTO';

--Consultar el almacen que tenga la mayor cantidad de entrada de productos


--Consultar al cliente cuya tarjeta tenga cierta fecha de expiracion

--Consultar un descuento que sea del 50%



--Consulta que devuelve los pedidos que deben ser retirados del sistema debido
--a diversas quejas, estos pedidos no deben tener los status capturado,
--en transito o entregado.
--Se empleó
-- Inner join
-- Algebra relacional

select p.pedido_id, p.folio, sp.descripcion
from pedido p
join status_pedido sp
on p.status_pedido_id = sp.status_pedido_id
minus
select p.pedido_id, p.folio, sp.descripcion
from pedido p
join status_pedido sp
on p.status_pedido_id = sp.status_pedido_id
where sp.descripcion = 'CAPTURADO'
or sp.descripcion = 'EN TRANSITO'
or sp.descripcion = 'ENTREGADO';




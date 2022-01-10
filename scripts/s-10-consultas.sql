
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

--Consulta que obtiene a los empleados que tienen mas de 4 eventos en almacen, 
--emplear la vista v_evento
select v.evento_medicamento_id,v.tipo_evento,v.rfc,v.clave_centro_operaciones
from v_evento v
join (
  select rfc,count(*) num_eventos
  from v_evento
  group by rfc
  having count(*) > 4
) q1 
 on  v.rfc=q1.rfc 
 order by v.rfc;

--Consultar la sustancia activa de un medicamento de nombre YONDELIS , ademas
--mostrar todos los nombres que tengan la misma sustancia activa, empleando 
--la tabla externa
SELECT m.sustancia_activa, n.nombre, m.descripcion
from medicamento_respaldo m
left join lista_nombres_respaldo n on n.medicamento_id=m.medicamento_id
where m.medicamento_id=(
  select MEDICAMENTO_ID
  from lista_nombres_respaldo 
  where nombre='YONDELIS'
);

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

--Consultar el almacen que tenga la mayor cantidad de entrada de 
--productos

select e.clave_centro_operaciones,e.tipo_almacen,co.latitud,co.longitud,co.telefono_centro_operaciones,sum(e.numero_unidades) SUMA_TOTAL_UNNIDADES
from v_evento e
join centro_operaciones co
  on co.clave_centro_operaciones=e.clave_centro_operaciones
where e.tipo_evento='ENTRADA'
group by e.clave_centro_operaciones,e.tipo_almacen,co.latitud,co.longitud,co.telefono_centro_operaciones
having sum(e.numero_unidades)= (
  select max(sum(e.numero_unidades)) 
  from v_evento e
  where e.tipo_evento='ENTRADA'
  group by clave_centro_operaciones
);




--Consultar al cliente cuya tarjeta tenga cierta fecha de expiracion
select numero_tarjeta,c.cliente_id,c.nombre,c.rfc
from cliente c
natural join tarjeta t
where( t.anio_expiracion=25 and t.mes_expiracion>8) or  t.anio_expiracion>25; 

--Consultar un descuento que sea mayor o igual del 50%
select * from ora$ptt_cupon_descuento d
where d.descuento>=50.00;

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




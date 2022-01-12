--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 04/01/2022
--@Descripción: Prueba del trigger historico_ubicacion


declare
begin
  --Actualizando un registro para que capture la ubicación actual 
  
  update pedido set ubicacion_actual_id= 1 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 2 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 3 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 7 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 1 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 40 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 50 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 1 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 1 where folio='O6EVA4ZH5KYNI';
  update pedido set ubicacion_actual_id= 1 where folio='O6EVA4ZH5KYNI';
end;
/
show errors
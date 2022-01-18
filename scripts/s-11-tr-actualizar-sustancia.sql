--@Autor(es): García Figueroa Munguía Alberto, Garcia Gutiérrez Edgar Cristóbal 
--@Fecha creación: 05/01/2022
--@Descripción:Prueba del trigger compound

create or replace trigger med_sustancia_trigger
for update of sustancia_activa on medicamento
compound trigger
type med_actualizado_type is record (
  medicamento_log_id medicamento_log.medicamento_log_id%type,
  medicamento_id medicamento_log.medicamento_id%type,
  sustancia_anterior medicamento_log.sustancia_anterior%type,
  sustancia_nuevo medicamento_log.sustancia_nuevo%type,
  fecha_actualizacion medicamento_log.fecha_actualizacion%type,
  usuario_actualiza medicamento_log.usuario_actualiza%type
);

type sustancia_list_type is table of med_actualizado_type;
sustancia_list sustancia_list_type := sustancia_list_type();
before each row is
  v_usuario varchar2(30) := sys_context('USERENV','SESSION_USER');
  v_fecha date := sysdate;
  v_index number;
begin
	sustancia_list.extend;
	v_index := sustancia_list.last;

	sustancia_list(v_index).medicamento_log_id := medicamento_log_seq.nextval;
	sustancia_list(v_index).medicamento_id := :new.medicamento_id;
	sustancia_list(v_index).sustancia_anterior := :old.sustancia_activa;
	sustancia_list(v_index).sustancia_nuevo := :new.sustancia_activa;
	sustancia_list(v_index).fecha_actualizacion := v_fecha;
	sustancia_list(v_index).usuario_actualiza := v_usuario;
end before each row;

after statement is
begin
  forall i in sustancia_list.first .. sustancia_list.last
	insert into medicamento_log(medicamento_log_id,medicamento_id,
	sustancia_anterior,sustancia_nuevo,fecha_actualizacion,
	usuario_actualiza)
	values(sustancia_list(i).medicamento_log_id, sustancia_list(i).medicamento_id,
	sustancia_list(i).sustancia_anterior,sustancia_list(i).sustancia_nuevo,
	sustancia_list(i).fecha_actualizacion, sustancia_list(i).usuario_actualiza
	);
end after statement;
end;
/
show errors;
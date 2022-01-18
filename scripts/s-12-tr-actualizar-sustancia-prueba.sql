
update medicamento
set sustancia_activa = sustancia_activa || ' ->CANCERIGENO '
where upper(sustancia_activa) like '%CARISOPRODOL%';

update medicamento
set sustancia_activa = sustancia_activa || ' ->ANTICOVID'
where upper(sustancia_activa) like '%CLINDAMICINA%';

update medicamento
set sustancia_activa = sustancia_activa || ' ->CONTIENE LAXANTE'
where upper(sustancia_activa) like '%SENÓSIDOS%';

set linesize window

col  medicamento_log_id format a5
col  medicamento_id format a5
col sustancia_anterior format a50
col  sustancia_nuevo  format a50
col  fecha_actualizacion format a20
col  usuario_actualiza format a15
col medicamento_log_id heading med_l_id
col sustancia_activa format a50
column medicamento_id clear
column medicamento_log_id clear



-- col descripcion format a55

Prompt ======MOSTRANDO MEDICAMENTO_LOG======
select * from medicamento_log;

Prompt ======MOSTRANDO MEDICAMENTO======
select * from medicamento 
where upper(sustancia_activa) like '%CARISOPRODOL%'
or upper(sustancia_activa) like '%CLINDAMICINA%'
or upper(sustancia_activa) like '%SENÓSIDOS%';

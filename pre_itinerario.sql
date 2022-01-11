CREATE OR REPLACE FUNCTION
pre_itinerario (ids varchar)
RETURNS VARCHAR AS $body$
DECLARE
	id1 integer;
	id2 integer;
	tupla record;
	a varchar := '';
BEGIN
	id1 := cast(SPLIT_PART(ids, ',',1) AS int);
	id2 := cast(SPLIT_PART(ids, ',',2) AS int);
	for tupla in select * from destinos where cid_ciudad_origen = id1 and cid_ciudad_destino= id2 LOOP
		a:= a || '-' || cast(tupla.did as varchar(10));
	END LOOP;
RETURN a;
END;
$body$ language plpgsql
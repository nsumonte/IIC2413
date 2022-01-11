CREATE OR REPLACE FUNCTION
algo3 (origen int,lista varchar)
RETURNS TABLE( ciudades varchar) AS $body$
DECLARE
c varchar ;
a varchar ;
tupla RECORD;
b varchar;
d varchar;
BEGIN
	CREATE TABLE tabla( id varchar);
	for tupla in select distinct cid_ciudad_origen, cid_ciudad_destino from destinos where cid_ciudad_origen=origen and cid_ciudad_destino in (select algo(lista)) loop
		a:= tupla.cid_ciudad_origen;
		b:= tupla.cid_ciudad_destino;
		insert into tabla values(concat(concat(a,','),b));
	end loop;
	for tupla in select distinct foo.oid, foo.did, destinos.cid_ciudad_destino from (select cid_ciudad_origen, cid_ciudad_destino from destinos where cid_ciudad_origen=origen and cid_ciudad_destino in (select algo(lista))) as foo(oid,did) inner join destinos on foo.did=destinos.cid_ciudad_origen where destinos.cid_ciudad_destino in (select algo(lista)) loop
		a:= tupla.oid;
		b:= tupla.did;
		c:= tupla.cid_ciudad_destino;
		insert into tabla values(concat(concat(concat(concat(a,','),b),','),c));
	end loop;
	for tupla in select distinct id1,id2,id3, cid_ciudad_destino from (select distinct foo.oid, foo.did, destinos.cid_ciudad_destino from (select cid_ciudad_origen, cid_ciudad_destino from destinos where cid_ciudad_origen=origen and cid_ciudad_destino in (select algo(lista))) as foo(oid,did) inner join destinos on foo.did=destinos.cid_ciudad_origen where destinos.cid_ciudad_destino in (select algo(lista))) as vee(id1,id2,id3) inner join destinos on vee.id3=destinos.cid_ciudad_origen where destinos.cid_ciudad_destino in (select algo(lista)) loop
		a:= tupla.id1;
		b:= tupla.id2;
		c:= tupla.id3;
		d:= tupla.cid_ciudad_destino;
		insert into tabla values(concat(concat(concat(concat(concat(concat(a,','),b),','),c),','),d));
	end loop;
	
RETURN QUERY SELECT DISTINCT id FROM tabla;
DROP TABLE tabla;
RETURN;
END
$body$ language plpgsql
				
			
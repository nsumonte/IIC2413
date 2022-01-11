CREATE OR REPLACE FUNCTION
itinerario (origen int,lista varchar, fecha date)
RETURNS TABLE( itinerarios varchar, costo int) AS $body$
DECLARE

horadesalida1 varchar ;
horadellegada1 varchar ;
tupla RECORD;
horadesalida2 varchar ;
horadellegada2 varchar ;
hora3 varchar;
fecha2 date;
fecha3 date;
data1 varchar;
data2 varchar;
data3 varchar;
tupla1 RECORD;
tupla2 RECORD;
tupla3 RECORD;
tupla4 RECORD;
BEGIN
	CREATE TABLE tabla( id varchar, c int);
	for tupla in select did, precio from destinos where cid_ciudad_origen=origen and cid_ciudad_destino in (select algo(lista)) loop
		data1:= id_tabla(tupla.did);
		insert into tabla values(data1 || '$' || fecha::varchar, tupla.precio);
	end loop;
	for tupla in select distinct foo.id, destinos.did, foo.costo1, destinos.precio from (select did, cid_ciudad_origen, cid_ciudad_destino, precio from destinos where cid_ciudad_origen=origen and cid_ciudad_destino in (select algo(lista))) as foo(id,oid,did, costo1) inner join destinos on foo.did=destinos.cid_ciudad_origen where destinos.cid_ciudad_destino in (select algo(lista)) loop
		for tupla1 in select cast(concat(duracion,' hours') as interval) + horadesalida as horadellegada, horadesalida from destinos where did=tupla.id loop
			horadesalida1:= tupla1.horadesalida;
			horadellegada1:= tupla1.horadellegada;
		end loop;
		if horadellegada1<=horadesalida1 then
			for tupla3 in select (fecha::date + interval '1 day')::date loop
				fecha2:= tupla3;
			end loop;
		else
			fecha2 := fecha;
		end if; 
		for tupla2 in select horadesalida from destinos where did=tupla.did loop
			horadesalida2:= tupla2;
		end loop;
		if horadellegada1>=horadesalida2 then
			for tupla3 in select (fecha2::date + interval '1 day')::date loop
				fecha2:= tupla3;
			end loop;
		else
			fecha2 := fecha2;
		end if;
		data1:= id_tabla(tupla.id);
		data2:= id_tabla(tupla.did) ;
		insert into tabla values(data1 || '$' || fecha::varchar || '#' || data2 || '$' || fecha2::varchar, tupla.costo1 + tupla.precio);
	end loop;
	for tupla in select distinct did1,did2, destinos.did, costo1, costo2, destinos.precio from (select distinct foo.id, destinos.did, foo.oid, foo.did, destinos.cid_ciudad_destino, foo.precio1, destinos.precio from (select did, cid_ciudad_origen, cid_ciudad_destino, precio from destinos where cid_ciudad_origen=origen and cid_ciudad_destino in (select algo(lista))) as foo(id,oid,did,precio1) inner join destinos on foo.did=destinos.cid_ciudad_origen where destinos.cid_ciudad_destino in (select algo(lista))) as vee(did1, did2,id1,id2,id3, costo1, costo2) inner join destinos on vee.id3=destinos.cid_ciudad_origen where destinos.cid_ciudad_destino in (select algo(lista)) loop
		for tupla1 in select cast(concat(duracion,' hours') as interval) + horadesalida as horadellegada, horadesalida from destinos where did=tupla.did1 loop
			horadesalida1:= tupla1.horadesalida;
			horadellegada1:= tupla1.horadellegada;
		end loop;
		if horadellegada1<=horadesalida1 then
			for tupla3 in select (fecha::date + interval '1 day')::date loop
				fecha2:= tupla3;
			end loop;
		else
			fecha2 := fecha;
		end if;
		for tupla2 in select cast(concat(duracion,' hours') as interval) + horadesalida as horadellegada, horadesalida from destinos where did=tupla.did2 loop
			horadesalida2:= tupla2.horadesalida;
			horadellegada2:= tupla2.horadellegada;
		end loop;
		for tupla4 in select horadesalida from destinos where did=tupla.did loop
			hora3:= tupla4;
		end loop;
		if horadellegada1>=horadesalida2 then
			for tupla3 in select (fecha2::date + interval '1 day')::date loop
				fecha2:= tupla3;
			end loop;
		else
			fecha2 := fecha2;
		end if;
		if horadellegada2<=horadesalida2 then
			for tupla3 in select (fecha2::date + interval '1 day')::date loop
				fecha3:= tupla3;
			end loop;
		else
			fecha3 := fecha2;
		end if;
		
		if horadellegada2>=hora3 then
			for tupla3 in select (fecha3::date + interval '1 day')::date loop
				fecha3:= tupla3;
			end loop;
		else
			fecha3 := fecha3;
		end if;
		data1:= id_tabla(tupla.did1) ;
		data2:= id_tabla(tupla.did2);
		data3:= id_tabla(tupla.did);
		insert into tabla values(data1 || '$' || fecha::varchar || '#' || data2 || '$' || fecha2::varchar || '#' || data3 || '$' || fecha3::varchar, tupla.costo1 + tupla.costo2+ tupla.precio);
	end loop;
	
RETURN QUERY SELECT id, c FROM tabla order BY c;
DROP TABLE tabla;
RETURN;
END
$body$ language plpgsql
				
			



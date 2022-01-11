CREATE OR REPLACE FUNCTION
id_tabla (id int)
RETURNS varchar AS $body$
DECLARE
    a varchar;
    tupla record;
    tupla1 record;
    duracion varchar;
    md integer;
    origen varchar;
    destino varchar;
    
BEGIN
    for tupla in select * from destinos where did=id loop
        duracion:= tupla.duracion;
    end loop;
    for tupla in select * from destinos where did=id loop
        md:= tupla.mid;
        for tupla1 in select * from ciudades where cid=tupla.cid_ciudad_origen loop
            origen:= tupla1.ciudad;
        end loop;
        for tupla1 in select * from ciudades where cid=tupla.cid_ciudad_destino loop
            destino:= tupla1.ciudad;
        end loop;
        for tupla1 in select * from medio where medio.mid=md loop
            a:= tupla.did::varchar || '$' || origen || '$' || destino || '$' || tupla1.medio || '$' || tupla.horadesalida::varchar || '$' || duracion || '$' || tupla.precio::varchar;
        end loop;
    end loop;
RETURN a;
END
$body$ language plpgsql
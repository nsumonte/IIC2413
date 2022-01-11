CREATE OR REPLACE FUNCTION
algo (lista varchar)
RETURNS TABLE (id integer) AS $body$
DECLARE
  c integer := 1;
  a varchar;
  
BEGIN
  CREATE TABLE tabla_temp( id varchar);
  a:= SPLIT_PART(lista, ',',c );
  WHILE a<>'' LOOP
    INSERT INTO tabla_temp(id) values (a);
    c:= c + 1;
    a:= SPLIT_PART(lista, ',',c );
  END LOOP;
RETURN QUERY SELECT DISTINCT t1.cid
    FROM dblink('dbname=grupo76e3 user=grupo76 password=holarabelo',
                'select c76c85.c85id, participo_en.aid from participo_en  
		inner join lugar_obra on participo_en.oid=lugar_obra.oid
		inner join lugar_ciudad on lugar_obra.lid=lugar_ciudad.cid
		inner join c76c85 on lugar_ciudad.cid=c76c85.c76id')
    		AS t1(cid int, aid varchar) where t1.aid in (select * from tabla_temp);
DROP TABLE tabla_temp;
RETURN;
END
$body$ language plpgsql
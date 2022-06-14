-- To copy name of schemata, tables and columns to a csv file (wihout header)
copy
(
select t.table_schema , t.table_name, c.column_name 
from information_schema."columns" c 
join information_schema."tables" t 
  on t.table_name = c.table_name 
where t.table_schema = 'kis'
and t.table_type = 'BASE TABLE'
and c.udt_name = 'varchar'
and c.column_name <> 'FALNR'
) to '/path/file.csv' with delimiter E';' csv;


-- function to convert a string in md5-hash and it in a big integer.
create function f_hash_to_bigint(text) returns bigint as $$
 select ('x'||substr(md5($1),1,16))::bit(64)::bigint;
$$ language sql;

-- create extensions
create extension pgcrypto;
create extension "uuid-ossp";
--\q

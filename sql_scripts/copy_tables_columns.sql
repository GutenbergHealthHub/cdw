--copy
--(
select t.table_schema , t.table_name, c.column_name 
from information_schema."columns" c 
join information_schema."tables" t 
  on t.table_name = c.table_name 
where t.table_schema = 'kis'
and t.table_type = 'BASE TABLE'
and c.udt_name = 'varchar'
and c.column_name <> 'FALNR'
and c.column_name <> 'PATNR'
and c.column_name <> 'EINRI';
--) to '/home/abel/test/kis_test/kis_tables_columns.csv' with delimiter E';' csv;

select * from information_schema."tables" t;

select table_schema, table_name, column_name from information_schema."columns" c where table_schema = 'kis' and udt_name like 'varchar';
select * from information_schema."columns" c where table_schema = 'kis' and udt_name like 'varchar';

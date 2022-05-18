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
and c.column_name <> 'FALNR';
) to '/path/file.csv' with delimiter E';' csv;

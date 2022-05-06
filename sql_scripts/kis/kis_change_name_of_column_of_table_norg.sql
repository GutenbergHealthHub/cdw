-- SELECT 'alter table '|| table_schema||'."'||table_name|| '" rename column '||column_name|| ' to "' || upper(column_name)|| '";' FROM INFORMATION_SCHEMA.columns where table_schema = 'kis' and table_name = 'NORG';

-- change name of column of table kis.NORG

alter table kis."NORG" rename column einri to "EINRI";  
alter table kis."NORG" rename column orgid to "ORGID";  
alter table kis."NORG" rename column orgty to "ORGTY";  
alter table kis."NORG" rename column orgna to "ORGNA";  
alter table kis."NORG" rename column orgkb to "ORGKB";  
alter table kis."NORG" rename column okurz to "OKURZ";  
alter table kis."NORG" rename column fachr to "FACHR";  
alter table kis."NORG" rename column fachr2 to "FACHR2";
alter table kis."NORG" rename column aufkz to "AUFKZ";  
alter table kis."NORG" rename column inten to "INTEN";  
alter table kis."NORG" rename column fachr9 to "FACHR9";
alter table kis."NORG" rename column paedkz to "PAEDKZ";
alter table kis."NORG" rename column fachr1 to "FACHR1";
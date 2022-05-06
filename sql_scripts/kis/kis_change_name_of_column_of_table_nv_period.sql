-- SELECT 'alter table '|| table_schema||'."'||table_name|| '" rename column '||column_name|| ' to "' || upper(column_name)|| '";' FROM INFORMATION_SCHEMA.columns where table_schema = 'kis' and table_name = 'NV_PERIOD';

-- change name of column of table kis.NV_PERIOD

alter table kis."NV_PERIOD" rename column einri to "EINRI";                
alter table kis."NV_PERIOD" rename column patnr to "PATNR";                
alter table kis."NV_PERIOD" rename column falnr to "FALNR";                
alter table kis."NV_PERIOD" rename column fname to "FNAME";                
alter table kis."NV_PERIOD" rename column lfdnr to "LFDNR";                
alter table kis."NV_PERIOD" rename column value to "VALUE";                
alter table kis."NV_PERIOD" rename column declare_date to "DECLARE_DATE";  
alter table kis."NV_PERIOD" rename column period_begdt to "PERIOD_BEGDT";  
alter table kis."NV_PERIOD" rename column period_enddt to "PERIOD_ENDDT";  
alter table kis."NV_PERIOD" rename column period_bem to "PERIOD_BEM";      
alter table kis."NV_PERIOD" rename column erdat to "ERDAT";                
alter table kis."NV_PERIOD" rename column updat to "UPDAT";                
alter table kis."NV_PERIOD" rename column storn to "STORN";                
alter table kis."NV_PERIOD" rename column stdat to "STDAT";                
alter table kis."NV_PERIOD" rename column retrievaldate to "RETRIEVALDATE";
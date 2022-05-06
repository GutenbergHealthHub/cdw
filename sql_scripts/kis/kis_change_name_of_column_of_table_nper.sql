-- SELECT 'alter table '|| table_schema||'."'||table_name|| '" rename column '||column_name|| ' to "' || upper(column_name)|| '";' FROM INFORMATION_SCHEMA.columns where table_schema = 'kis' and table_name = 'NPER';

-- change name of column of table kis.NPER

alter table kis."NPER" rename column pernr to "PERNR";                
alter table kis."NPER" rename column makz to "MAKZ";                  
alter table kis."NPER" rename column arzt to "ARZT";                  
alter table kis."NPER" rename column pfleg to "PFLEG";                
alter table kis."NPER" rename column barzt to "BARZT";                
alter table kis."NPER" rename column begdt to "BEGDT";                
alter table kis."NPER" rename column enddt to "ENDDT";                
alter table kis."NPER" rename column loekz to "LOEKZ";                
alter table kis."NPER" rename column lodat to "LODAT";                
alter table kis."NPER" rename column erdat to "ERDAT";                
alter table kis."NPER" rename column updat to "UPDAT";                
alter table kis."NPER" rename column fachr to "FACHR";                
alter table kis."NPER" rename column sptyp to "SPTYP";                
alter table kis."NPER" rename column retrievaldate to "RETRIEVALDATE";
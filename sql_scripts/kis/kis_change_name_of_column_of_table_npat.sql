--SELECT 'alter table '|| table_schema||'."'||table_name|| '" rename column '||column_name|| ' to "' || upper(column_name)|| '";' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'NPAT' and TABLE_SCHEMA = 'kis';

-- change name of column of table kis.NPAT

alter table kis."NPAT" rename column einri to "EINRI";                
alter table kis."NPAT" rename column patnr to "PATNR";                
alter table kis."NPAT" rename column gschl to "GSCHL";                
alter table kis."NPAT" rename column gbdat to "GBDAT";                
alter table kis."NPAT" rename column todkz to "TODKZ";                
alter table kis."NPAT" rename column toddt to "TODDT";                
alter table kis."NPAT" rename column todzt to "TODZT";                
alter table kis."NPAT" rename column toddb to "TODDB";                
alter table kis."NPAT" rename column todzb to "TODZB";                
alter table kis."NPAT" rename column todur to "TODUR";                
alter table kis."NPAT" rename column land to "LAND";                  
alter table kis."NPAT" rename column pstlz to "PSTLZ";                
alter table kis."NPAT" rename column erdat to "ERDAT";                
alter table kis."NPAT" rename column updat to "UPDAT";                
alter table kis."NPAT" rename column storn to "STORN";                
alter table kis."NPAT" rename column stdat to "STDAT";                
alter table kis."NPAT" rename column race to "RACE";                  
alter table kis."NPAT" rename column retrievaldate to "RETRIEVALDATE";
alter table kis."NPAT" rename column statu to "STATU";                
alter table kis."NPAT" rename column gebie to "GEBIE";                
alter table kis."NPAT" rename column rfpat to "RFPAT";                
alter table kis."NPAT" rename column unknown_gbdat to "UNKNOWN_GBDAT";
alter table kis."NPAT" rename column sex_special to "SEX_SPECIAL"; 







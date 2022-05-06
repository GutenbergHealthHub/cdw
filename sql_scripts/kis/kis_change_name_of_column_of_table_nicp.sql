-- SELECT 'alter table '|| table_schema||'."'||table_name|| '" rename column '||column_name|| ' to "' || upper(column_name)|| '";' FROM INFORMATION_SCHEMA.columns where table_schema = 'kis' and table_name = 'NICP';

-- change name of column of table kis.NICP

alter table kis."NICP" rename column einri to "EINRI";                
alter table kis."NICP" rename column falnr to "FALNR";                
alter table kis."NICP" rename column lnric to "LNRIC";                
alter table kis."NICP" rename column lfdbew to "LFDBEW";              
alter table kis."NICP" rename column icpmk to "ICPMK";                
alter table kis."NICP" rename column icpml to "ICPML";                
alter table kis."NICP" rename column icphc to "ICPHC";                
alter table kis."NICP" rename column anzop to "ANZOP";                
alter table kis."NICP" rename column bgdop to "BGDOP";                
alter table kis."NICP" rename column bztop to "BZTOP";                
alter table kis."NICP" rename column eztop to "EZTOP";                
alter table kis."NICP" rename column lslok to "LSLOK";                
alter table kis."NICP" rename column opart to "OPART";                
alter table kis."NICP" rename column updat to "UPDAT";                
alter table kis."NICP" rename column storn to "STORN";                
alter table kis."NICP" rename column stdat to "STDAT";                
alter table kis."NICP" rename column drg_category to "DRG_CATEGORY";  
alter table kis."NICP" rename column drg_relevant to "DRG_RELEVANT";  
alter table kis."NICP" rename column orgfa to "ORGFA";                
alter table kis."NICP" rename column orgpf to "ORGPF";                
alter table kis."NICP" rename column endop to "ENDOP";                
alter table kis."NICP" rename column prtyp to "PRTYP";                
alter table kis."NICP" rename column quantity to "QUANTITY";          
alter table kis."NICP" rename column unit to "UNIT";                  
alter table kis."NICP" rename column ccl to "CCL";                    
alter table kis."NICP" rename column oplebspen to "OPLEBSPEN";        
alter table kis."NICP" rename column retrievaldate to "RETRIEVALDATE";
alter table kis."NICP" rename column lnric_ref to "LNRIC_REF";        
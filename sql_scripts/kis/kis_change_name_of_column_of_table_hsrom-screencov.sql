--SELECT 'alter table '|| table_schema||'."'||table_name|| '" rename column '||column_name|| ' to "' || upper(column_name)|| '";' FROM INFORMATION_SCHEMA.columns where table_schema = 'kis' and table_name = '/HSROM/SCREENCOV';

-- change name of column of table kis."/HSROM/SCREENCOV"


alter table kis."/HSROM/SCREENCOV" rename column mand to "MAND";                          
alter table kis."/HSROM/SCREENCOV" rename column einri to "EINRI";                        
alter table kis."/HSROM/SCREENCOV" rename column falnr to "FALNR";                        
alter table kis."/HSROM/SCREENCOV" rename column setdate to "SETDATE";                    
alter table kis."/HSROM/SCREENCOV" rename column settime to "SETTIME";                    
alter table kis."/HSROM/SCREENCOV" rename column screenoption to "SCREENOPTION";          
alter table kis."/HSROM/SCREENCOV" rename column disscreendllentry to "DISSCREENDLLENTRY";
alter table kis."/HSROM/SCREENCOV" rename column disscreenresult to "DISSCREENRESULT";    
alter table kis."/HSROM/SCREENCOV" rename column screentesttype to "SCREENTESTTYPE";      
alter table kis."/HSROM/SCREENCOV" rename column screenstate to "SCREENSTATE";            
alter table kis."/HSROM/SCREENCOV" rename column screeniso to "SCREENISO";                
alter table kis."/HSROM/SCREENCOV" rename column screenisostate to "SCREENISOSTATE";      
alter table kis."/HSROM/SCREENCOV" rename column screenothers to "SCREENOTHERS";          
alter table kis."/HSROM/SCREENCOV" rename column screenvaccstat to "SCREENVACCSTAT";      
alter table kis."/HSROM/SCREENCOV" rename column screenvaccine to "SCREENVACCINE";        
alter table kis."/HSROM/SCREENCOV" rename column screenvaccdose to "SCREENVACCDOSE";      
alter table kis."/HSROM/SCREENCOV" rename column insdat to "INSDAT";                      
alter table kis."/HSROM/SCREENCOV" rename column instim to "INSTIM";                      
alter table kis."/HSROM/SCREENCOV" rename column patnr to "PATNR";                        
alter table kis."/HSROM/SCREENCOV" rename column riskpat to "RISKPAT";                    
alter table kis."/HSROM/SCREENCOV" rename column storn to "STORN";                        
alter table kis."/HSROM/SCREENCOV" rename column stdat to "STDAT";                        
alter table kis."/HSROM/SCREENCOV" rename column sttim to "STTIM";                        
alter table kis."/HSROM/SCREENCOV" rename column lfdbew to "LFDBEW";                      
alter table kis."/HSROM/SCREENCOV" rename column retrievaldate to "RETRIEVALDATE";        



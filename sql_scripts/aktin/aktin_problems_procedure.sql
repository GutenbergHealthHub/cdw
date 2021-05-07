-- Procedure to export the rows with problem into a file
create or replace procedure aktin.pr_aktin_copra_problem()
  language plpgsql
  as $$
  declare 
    file_date date;
    file_to_save varchar;
  begin 
	  file_date := now()::date;
	  file_to_save := '/media/db/cdw_database/schema_table_problem/aktin_copra/aktin_copra'||file_date||'.csv';
	  insert into aktin.aktin_copra_problem
        select 
          * 
        from aktin.v_aktin_copra_problem
        where zeitpunkt_aufnahme > (select max(zeitpunkt_aufnahme) from aktin.aktin_copra_problem acp) 
        or (select count(1) from aktin.aktin_copra_problem acp) = 0;
       
       execute 'copy (select * from aktin.v_aktin_copra_problem) to ''' || file_to_save || ''' with csv header delimiter '';'''; 
       
  end; $$;
 
--call aktin.pr_aktin_copra_problem();

--truncate table aktin.aktin_copra_problem restart identity;


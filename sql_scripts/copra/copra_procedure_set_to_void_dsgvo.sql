create or replace procedure copra.set_to_void_dsgvo()
  language plpgsql
  as $$
  
  begin 	  
	  update copra.co6_data_string 
	    set val = '' where varid in(
	      select 
	        id 
	      from copra.co6_config_variables ccv 
	      where name ~*'name|mail|efon|versic|stras|rede|chrift|fax|atzi|geber|nym' 
	      and name !~*'medik|atmu|mikro'
	    );
  end; $$;

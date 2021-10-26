-- procedure to insert new cases and date of insert into the aktin.jobtable_test 
-- after new insert into the table aktin.aktin_copra 
create or replace function aktin.aktin_copra_to_jobtable()
  returns trigger 
  language plpgsql
  as $$
    begin 
	  insert into aktin.jobtable
        select
          ac.fall_nummer,
          now() retrievaldate,
          TG_OP, -- trigger event
          current_user -- user
        ; 
      return null;
    end;
  $$;



-- trigger on aktin.aktin_copra by insert or update

-- drop trigger if exists tr_insert_into_jobtable on aktin.aktin_copra;

create trigger tr_insert_into_jobtable
  after insert or update
    on aktin.aktin_copra
    for each row execute function aktin.aktin_copra_to_jobtable()
;

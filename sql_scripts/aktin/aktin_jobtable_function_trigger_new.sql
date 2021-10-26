-- procedure to insert new cases and date of insert into the aktin.jobtable_test 
-- after new insert into the table aktin.aktin_copra 
create or replace function aktin.to_jobtable()
  returns trigger 
  language plpgsql
  as $$
    begin 
	  insert into aktin.jobtable_test 
        select
          ac.fall_nummer,
          now() retrievaldate
        from newtable ac -- aktin.aktin_copra, it is defined in the trigger
        ; -- cases not in jobtable
      return null;
    end;
  $$;

-- trigger on aktin.aktin_copra by insert 
create trigger tr_insert_into_jobtable 
  after insert 
    on aktin.aktin_copra 
    referencing new table as newtable
    for each statement execute function aktin.to_jobtable()
;

-- trigger on aktin.aktin_copra update 
create trigger tr_update_to_jobtable 
  after update 
    on aktin.aktin_copra 
    referencing new table as newtable
    for each statement execute function aktin.to_jobtable()
;
 

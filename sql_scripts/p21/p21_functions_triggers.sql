-- Insert encounterid and another information from p21.encounter into the management table

create or replace function p21.encounter_to_management()
  returns trigger 
  language plpgsql
  as $$
    begin 
	  insert into p21.management 
        select
          e.id,
          now() retrievaldate,
          TG_OP trigger_event, -- trigger event
          current_user user_event, -- user
          TG_NAME trigger_name,
          TG_TABLE_NAME table_name
        from newtable e  
        ; 
      return null;
    end;
  $$;

-- Insert encounterid and another information from tables from schema p21 but not encounter into the management table
create or replace function p21.encounter_another_table_to_management()
  returns trigger
  language plpgsql
  as $$
    begin
	  insert into p21.management
        select
          e.encounterid,
          now() retrievaldate,
          TG_OP trigger_event, -- trigger event
          current_user user_event, -- user
          TG_NAME trigger_name,
          TG_TABLE_NAME table_name
        from newtable e
        ;
      return null;
    end;
  $$;


-- trigger on p21.p21_encounter to insert into management table
create trigger tr_encounter_insert_into_management
  after insert
    on p21.p21_encounter
    referencing new table newtable
    for each statement execute function p21.encounter_to_management()
;

-- trigger on p21.p21_department to insert into management table
create trigger tr_department_insert_into_management
  after insert
    on p21.p21_department
    referencing new table newtable
    for each statement execute function p21.encounter_another_table_to_management()
;

-- trigger on p21.p21_diagnosis to insert into management table
create trigger tr_diagnosis_insert_into_management
  after insert
    on p21.p21_diagnosis
    referencing new table newtable
    for each statement execute function p21.encounter_another_table_to_management()
;


-- trigger on p21.p21_operation to insert into management table
create trigger tr_operation_insert_into_management
  after insert
    on p21.p21_operation
    referencing new table newtable
    for each statement execute function p21.encounter_another_table_to_management()
;

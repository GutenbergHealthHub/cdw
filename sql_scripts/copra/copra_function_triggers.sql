-- function to insert information of insert or truncate into patient_management
create or replace function copra.insert_into_patient_management()
  returns trigger 
  language plpgsql
  as $$
  begin 
	if (TG_OP = 'INSERT') then 
      insert into copra.patient_management
        select 
          n.patid,
          now() modif_date,
          current_user user_name,
          TG_OP trigger_event
        from newtable n
        where patid notnull;
       
    elsif (TG_OP = 'TRUNCATE') then
      insert into copra.patient_management
        values('no_patient', now(), current_user, TG_OP);
    end if;
    return null;
  end;
  $$
;

-- trigger to insert the patient id into the table patient_management
create trigger tr_insert_copra_patient_management 
after insert on copra.co6_medic_data_patient 
referencing new table as newtable
for each statement execute function copra.insert_into_patient_management();

-- trigger to register the truncate of table copra.co6_medic_data_patient
create trigger tr_truncate_copra_patient_management 
after truncate on copra.co6_medic_data_patient
for each statement execute function copra.insert_into_patient_management();

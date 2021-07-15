-- Patient String Parameters

drop function if exists copra.patient_string(config_id int);

create or replace function copra.patient_string(config_id int)
  returns table  (
    --pat_id bigint,
    pat_h_id varchar,
    pat_b_year int,
    pat_age int,
    pat_gender varchar,
    meassurement varchar,
    value varchar,
    meassurement_date timestamp
  )
  language plpgsql
  as $$

  begin
	  return query
	    select
          --s.id,
	      patid,
          date_part('year', geb)::int geb,
          (date_part('year', now()) - date_part('year', geb))::int,
          geschlecht,
          c.name param,
          val wert,
          datetimeto
        from copra.co6_medic_data_patient p
        join copra.co6_data_string s
          on s.parent_id = p.id
        join copra.co6_config_variables c
          on c.id = s.varid
        where parent_varid = 1
        and not s.deleted
	and flagcurrent
        and val not like ''
        and s.varid = config_id;
  end;$$;

-- Patient Decimal Parameters

drop function if exists copra.patient_decimal(config_id int);

create or replace function copra.patient_decimal(config_id int)
  returns table  (
    --pat_id bigint,
    pat_h_id varchar,
    pat_b_year int,
    pat_age int,
    pat_gender varchar,
    meassurement varchar,
    value decimal,
    unit varchar,
    meassurement_date timestamp
  )
  language plpgsql
  as $$

  begin
	  return query
	    select
          --s.id,
	      patid,
          date_part('year', geb)::int geb,
          (date_part('year', now()) - date_part('year', geb))::int,
          geschlecht,
          c.name param,
          val,
          c.unit,
          datetimeto
        from copra.co6_medic_data_patient p
        join copra.co6_data_decimal_6_3 d
          on d.parent_id = p.id
        join copra.co6_config_variables c
          on c.id = d.varid
        where parent_varid = 1
        and not d.deleted
	and flagcurrent
        and d.varid = config_id;
  end;$$;

-- Patient Pressure Parameters

drop function if exists copra.patient_pressure(config_id int);

create or replace function copra.patient_pressure(config_id int)
  returns table (
    pat_h_id varchar,
    pat_b_year int,
    pat_age int,
    pat_gender varchar,
    meassurement varchar,
    syst numeric,
    unit_syst varchar,
    diast numeric,
    unit_diast varchar,
    means numeric,
    unit_means varchar,
    meassurement_date timestamp
  )
  language plpgsql
  as $$

  begin
	  return query
	    select
          patid,
          date_part('year', geb)::int geb,
          (date_part('year', now()) - date_part('year', geb))::int,
          geschlecht,
          c.name param,
          systolic syst,
          c.unit,
          diastolic dia,
          c.unit,
          mean me,
          c.unit,
          datetimeto
        from copra.co6_medic_data_patient p
        join copra.co6_medic_pressure pr
          on pr.parent_id = p.id
        join copra.co6_config_variables c
          on c.id = pr.varid
        where parent_varid = 1
        and not pr.deleted
        and flagcurrent
        and varid = config_id ;
  end;$$;

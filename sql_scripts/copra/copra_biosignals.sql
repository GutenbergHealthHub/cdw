-- Patient String Parameters

drop function if exists copra.patient_string(config_id bigint);

create or replace function copra.patient_string(config_id bigint)
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
	  --c.name param,
          case 
            when displayname notnull then displayname
            when displayname isnull and description notnull then regexp_replace(description, '_', ' ', 'g')
            when displayname isnull and description isnull then regexp_replace(c.name, '_', ' ', 'g')
          end param,
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

drop function if exists copra.patient_decimal(config_id bigint);

create or replace function copra.patient_decimal(config_id bigint)
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
          (date_part('year', datetimeto) - date_part('year', geb))::int,
          geschlecht,
          --c.name param,
          case
            when displayname notnull then displayname
            when displayname isnull and description notnull then regexp_replace(description, '_', ' ', 'g')
            when displayname isnull and description isnull then regexp_replace(c.name, '_', ' ', 'g')
          end param,
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

drop function if exists copra.patient_pressure(config_id bigint);

create or replace function copra.patient_pressure(config_id bigint)
  returns table (
    pat_h_id varchar,
    pat_b_year int,
    pat_age int,
    gender varchar,
    meassurement varchar,
    systolic numeric,
    unit_syst varchar,
    diastolic numeric,
    unit_diast varchar,
    means numeric,
    unit_means varchar,
    datetimeto timestamp
  )
  language plpgsql
  as $$

  begin
	  return query
	    select
          p.patid,
          date_part('year', geb)::int geb,
          (date_part('year', pr.datetimeto) - date_part('year', geb))::int,
          geschlecht,
          --c.name param,
          case
            when displayname notnull then displayname
            when displayname isnull and description notnull then regexp_replace(description, '_', ' ', 'g')
            when displayname isnull and description isnull then regexp_replace(c.name, '_', ' ', 'g')
          end param,
          pr.systolic syst,
          c.unit,
          pr.diastolic dia,
          c.unit,
          pr.mean me,
          c.unit,
          pr.datetimeto
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

-- Patient Objects String Parameters
drop function if exists copra.patient_object_string(bigint);

create or replace function copra.patient_object_string(config_id bigint)
  returns table (
     --pat_id bigint,
    patid varchar,
    pat_b_year int,
    pat_age int,
    gender varchar,
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
          p.patid,
          date_part('year', geb)::int geb,
          (date_part('year', now()) - date_part('year', geb))::int,
          p.geschlecht,
          case
            when displayname notnull then displayname
            when displayname isnull and description notnull then regexp_replace(description, '_', ' ', 'g')
            when displayname isnull and description isnull then regexp_replace(c.name, '_', ' ', 'g')
          end param,
          val wert,
          datetimeto
        from copra.co6_data_string s
        join copra.co6_data_object o
          on o.id = s.parent_id
        join copra.co6_data_object op
          on op.id = o.parent_id
        join copra.co6_medic_data_patient p
          on p.id = op.parent_id
        join copra.co6_config_variables c
          on c.id = s.varid
        where op.parent_varid = 1
        and not s.deleted
        and not op.deleted
        and not o.deleted
        and op.flagcurrent
        and s.flagcurrent
        and o.flagcurrent
        and s.varid = config_id
   ;
end;$$;

-- Patient Objects Decimal Parameters
drop function if exists copra.patient_object_decimal(bigint);

create or replace function copra.patient_object_decimal(config_id bigint)
  returns table (
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
          case
            when displayname notnull then displayname
            when displayname isnull and description notnull then regexp_replace(description, '_', ' ', 'g')
            when displayname isnull and description isnull then regexp_replace(c.name, '_', ' ', 'g')
          end param,
          val wert,
	  c.unit,
          datetimeto
        from copra.co6_data_decimal_6_3 d
        join copra.co6_data_object o
          on o.id = d.parent_id
        join copra.co6_data_object op
          on op.id = o.parent_id
        join copra.co6_medic_data_patient p
          on p.id = op.parent_id
        join copra.co6_config_variables c
          on c.id = d.varid
        where op.parent_varid = 1
        and not d.deleted
        and not op.deleted
        and not o.deleted
        and op.flagcurrent
        and d.flagcurrent
        and o.flagcurrent
        and d.varid = config_id
   ;
end;$$;

--AKTIN Data Quality Analysis 

-- Demografie
create or replace view aktin.dqa_demografik
as
  select 
    count(fall_nummer) quantity, 
    case 
      when geschlecht isnull then 'geschlecht_nicht_dokumentiert'
      else 'geschlecht_'||geschlecht 
     end demografische_parameter
  from aktin.aktin_copra 
  group by geschlecht
    union 
  select
    count(fall_nummer),
    case
      when alter_aufnahme isnull then 'alter_aufnahme_nicht_dokumentiert'
      else 'alter_aufnahme_dokumentiert'
    end alt 
  from aktin.aktin_copra
  group by alt
    union 
  select
    count(fall_nummer),
    case
      when plz isnull then 'plz_nicht_dokumentiert'
      else 'plz_dokumentiert'
    end postleizal 
  from aktin.aktin_copra
  group by postleizal
  order by demografische_parameter
;

-- Zeiterfassung
create or replace view aktin.dqa_zeiterfassung
as    
  select count(fall_nummer) quantity, 
    case 
      when zeitpunkt_aufnahme isnull then 'zeitpunkt_aufnahme_nicht_dokumentiert'
      else 'zeitpunkt_aufnahme_dokumentiert'
    end zeit 
  from aktin.aktin_copra ac group by zeit
    union 
  select count(fall_nummer) quantity, 
    case 
      when zeitpunkt_ersteinsch isnull then 'zeitpunkt_ersteinsch_nicht_dokumentiert'
      else 'zeitpunkt_ersteinsch_dokumentiert'
    end zeit 
  from aktin.aktin_copra ac group by zeit
    union 
  select count(fall_nummer) quantity, 
    case 
      when zeitpunkt_entlassung isnull then 'zeitpunkt_entlassung_nicht_dokumentiert'
      else 'zeitpunkt_entlassung_dokumentiert'
    end zeit 
  from aktin.aktin_copra ac group by zeit
    union 
  select 
    count(fall_nummer),
    'aufnahme > entlassung'
  from aktin.aktin_copra
  where zeitpunkt_aufnahme > zeitpunkt_entlassung
    union 
  select 
    count(fall_nummer),
    'aufnahme > ersteinsch'
  from aktin.aktin_copra
  where zeitpunkt_aufnahme > zeitpunkt_ersteinsch
    union 
  select 
    count(fall_nummer),
    'ersteinsch > entlassung'
  from aktin.aktin_copra
  where zeitpunkt_ersteinsch > zeitpunkt_entlassung 
  order by zeit
;

--Aufnahmegrund
create or replace view aktin.dqa_aufnahmegrund
as
  select 
    count(fall_nummer) quantity,
    case 
      when aufnahmegrund isnull then 'aufnahmegrund_nicht_dokumentiert'
      else 'aufnahmegrund_dokumentiert'
    end aufnahmegrund_erfassung 
    from aktin.aktin_copra
    group by aufnahmegrund_erfassung
;    

--MTS
create or replace view aktin.dqa_mts
as
  select 
    count(fall_nummer) quantity,
    case 
      when mts_status_farbe isnull then 'mts_status_farbe_nicht_dokumentiert'
      else 'mts_status_farbe_dokumentiert'
    end mts
  from aktin.aktin_copra
  group by mts
    union
  select 
    count(fall_nummer),
    'mts_status_farbe_'||mts_status_farbe 
  from aktin.aktin_copra
  group by mts_status_farbe
    union 
  select 
    count(fall_nummer) quantity,
    case
      when mts_praesdiagr isnull then 'mts_praesdiagr_nicht_dokumentiert'
      else 'mts_praesdiagr_dokumentiert'
    end mts
  from aktin.aktin_copra
  group by mts
    union 
  select 
    count(fall_nummer) quantity,
    case
      when mts_symptom isnull then 'mts_symptom_nicht_dokumentiert'
      else 'mts_symptom_dokumentiert'
    end mts
  from aktin.aktin_copra
  group by mts
  order by quantity
;


--Atmung
create or replace view aktin.dqa_atemfrequenz
as
  select 
    count(fall_nummer) quantity,
    case 
      when atemfrequenz isnull then 'atemfrequenz_nicht_dokumentiert'
      else 'atemfrequenz_dokumentiert'
    end atem
  from aktin.aktin_copra
  group by atem
    union 
  select 
    count(fall_nummer) quantity,
    case 
      when atemfrequenz < 0 then 'atemfrequenz_minus_0'
      when atemfrequenz > 99 then 'atemfrequenz_plus_99'
      else 'atemfrequenz_ok'
    end atem
  from aktin.aktin_copra where atemfrequenz notnull
  group by atem
  order by atem
;
  
--Temperatur
create or replace view aktin.dqa_temperatur
as
  select 
    count(fall_nummer) quantity,
    case 
      when temperatur isnull then 'temperatur_nicht_dokumentiert'
      else 'temperatur_dokumentiert'
    end temperatur_erfassung
  from aktin.aktin_copra
  group by temperatur_erfassung 
    union 
  select 
    count(fall_nummer),
    case 
      when temperatur < 0 then 'temperatur_minus_0'
      when temperatur > 45 then 'temperatur_plus_45'
      else 'temperatur_ok'
    end temperatur_erfassung
  from aktin.aktin_copra where temperatur notnull
  group by temperatur_erfassung
  order by temperatur_erfassung
;

--Herzfrequenz
create or replace view aktin.dqa_herzfrequenz
as
  select 
    count(fall_nummer) quantity,
    case 
      when herzfrequenz isnull then 'herzfrequenz_nicht_dokumentiert'
      else 'herzfrequenz_dokumentiert'
    end herzfrequenz_erfassung
  from aktin.aktin_copra
  group by herzfrequenz_erfassung 
    union 
  select 
    count(fall_nummer),
    case 
      when herzfrequenz < 0 then 'herzfrequenz_minus_0'
      when herzfrequenz > 300 then 'herzfrequenz_plus_300'
      else 'herzfrequenz_ok'
    end herzfrequenz_erfassung
  from aktin.aktin_copra where herzfrequenz notnull
  group by herzfrequenz_erfassung
  order by herzfrequenz_erfassung
;
 
--Glagow Coma Scale Summe
create or replace view aktin.dqa_gcs
as
  select 
    count(fall_nummer) quantity,
    case 
      when gcs_scorevalue isnull then 'gcs_scorevalue_nicht_dokumentiert'
      else 'gcs_scorevalue_dokumentiert'
    end gcs_erfassung
  from aktin.aktin_copra
  group by gcs_erfassung 
    union 
  select 
    count(fall_nummer),
    case 
      when gcs_scorevalue < 3 then 'gcs_scorevalue_minus_3'
      when gcs_scorevalue > 15 then 'gcs_scorevalue_plus_15'
      else 'gcs_scorevalue_ok'
    end gcs_erfassung
  from aktin.aktin_copra where gcs_scorevalue notnull
  group by gcs_erfassung
    union 
  select 
    count(fall_nummer),
    case 
      when gcs_augenint isnull then 'gcs_augenint_nicht_dokumentiert'
      else 'gcs_augenint_dokumentiert'
    end gcs_erfassung
  from aktin.aktin_copra
  group by gcs_erfassung 
    union 
  select 
    count(fall_nummer),
    case 
      when gcs_augenint in (1,2,3,4) then 'gcs_augenint_ok'
      else 'gcs_augenint_nicht_ok'
    end gcs_erfassung
  from aktin.aktin_copra where gcs_augenint notnull
  group by gcs_erfassung
    union 
  select 
    count(fall_nummer),
    case 
      when gcs_motorik in (1,2,3,4) then 'gcs_motorik_ok'
      else 'gcs_motorik_nicht_ok'
    end gcs_erfassung
  from aktin.aktin_copra where gcs_motorik notnull
  group by gcs_erfassung
    union  
  select 
    count(fall_nummer),
    case 
      when gcs_motorik isnull then 'gcs_motorik_nicht_dokumentiert'
      else 'gcs_motorik_dokumentiert'
    end gcs_erfassung
  from aktin.aktin_copra
  group by gcs_erfassung
  order by gcs_erfassung
;
 

--Systolic pressure
create or replace view aktin.dqa_systolic_pressure
as
  select 
    count(fall_nummer) quantity,
    case 
      when systolic_pressure isnull then 'systolic_pressure_nicht_dokumentiert'
      else 'systolic_pressure_dokumentiert'
    end systolic_pressure_erfassung
  from aktin.aktin_copra
  group by systolic_pressure_erfassung 
    union 
  select 
    count(fall_nummer),
    case 
      when systolic_pressure < 0 then 'systolic_pressure_minus_0'
      when systolic_pressure > 300 then 'systolic_pressure_plus_300'
      else 'systolic_pressure_ok'
    end systolic_pressure_erfassung
  from aktin.aktin_copra where systolic_pressure notnull
  group by systolic_pressure_erfassung
  order by systolic_pressure_erfassung
;


--Schmerzskala
create or replace view aktin.dqa_schmerzskala
as
  select 
    count(fall_nummer) quantity,
    case 
      when schmerzskala isnull then 'schmerzskala_nicht_dokumentiert'
      else 'schmerzskala_dokumentiert'
    end schmerz
  from aktin.aktin_copra
  group by schmerz
    union
  select 
    count(fall_nummer),
    case 
      when schmerzskala < 0 then 'schmerzskala_minus_0'
      when schmerzskala > 10 then 'schmerzskala_plus_10'
      else 'schmerzskala_ok'
    end schmerz
    from aktin.aktin_copra where schmerzskala notnull
    group by schmerz
;
    


--Pupille
create or replace view aktin.dqa_pupille
as
  select 
    count(fall_nummer) quantity,
    case 
      when pupille_weite_links notnull then 'pupille_weite_links_dokumentiert'
      else 'pupille_weite_links_nicht_dokumentiert'
    end pupille
  from aktin.aktin_copra
  group by pupille
    union 
  select
    count(fall_nummer),
    'pupille_weite_links_'||pupille_weite_links
  from aktin.aktin_copra where pupille_weite_links notnull
  group by pupille_weite_links
    union 
  select 
    count(fall_nummer) quantity,
    case 
      when pupille_weite_rechts notnull then 'pupille_weite_rechts_dokumentiert'
      else 'pupille_weite_rechts_nicht_dokumentiert'
    end pupille
  from aktin.aktin_copra
  group by pupille
    union 
  select
    count(fall_nummer),
    'pupille_weite_rechts_'||pupille_weite_rechts
  from aktin.aktin_copra where pupille_weite_rechts notnull
  group by pupille_weite_rechts
    union 
  select 
    count(fall_nummer) quantity,
    case 
      when pupille_reaktion_links notnull then 'pupille_reaktion_links_dokumentiert'
      else 'pupille_reaktion_links_nicht_dokumentiert'
    end pupille
  from aktin.aktin_copra
  group by pupille
    union 
  select
    count(fall_nummer),
    'pupille_reaktion_links_'||pupille_reaktion_links
  from aktin.aktin_copra where pupille_reaktion_links notnull
  group by pupille_reaktion_links
    union 
  select 
    count(fall_nummer) quantity,
    case 
      when pupille_reaktion_rechts notnull then 'pupille_reaktion_rechts_dokumentiert'
      else 'pupille_reaktion_rechts_nicht_dokumentiert'
    end pupille
  from aktin.aktin_copra
  group by pupille
    union 
  select
    count(fall_nummer),
    'pupille_reaktion_rechts_'||pupille_reaktion_rechts
  from aktin.aktin_copra where pupille_reaktion_rechts notnull
  group by pupille_reaktion_rechts
  order by pupille 
; 
 
--Tetanus
create or replace view aktin.dqa_tetanus
as
  select 
    count(fall_nummer) quantity,
    tetanus
  from aktin.aktin_copra
  group by tetanus
    union 
  select 
   count(fall_nummer),
   'tetanusschutz_dokumentiert' tet
  from aktin.aktin_copra where tetanus not like 'Wer%nicht%'
  group by tet
;

--Schwanger
create or replace view aktin.dqa_schwanger
as
  select 
    count(fall_nummer) quantity,
    schwanger 
  from aktin.aktin_copra
  group by schwanger
    union 
  select 
   count(fall_nummer),
   'schwanger_dokumentiert' schw
  from aktin.aktin_copra where schwanger not like 'Wer%nicht%'
  group by schw
    union
  select 
    count(fall_nummer),
    'mann_ist_anamnestisch_nicht_schwanger' schw
  from aktin.aktin_copra ac 
  where geschlecht = 'M' 
  and schwanger not like 'Wert nicht dokumentiert'
  group by schw
  order by quantity
;

--Allergie
create or replace view aktin.dqa_allergie
as
  select 
    count(fall_nummer) quantity,
    allergie 
  from aktin.aktin_copra
  group by allergie
    union 
  select 
   count(fall_nummer),
   'allergie_dokumentiert' alle
  from aktin.aktin_copra where allergie not like 'Wer%nicht%'
  group by alle
  order by quantity
;

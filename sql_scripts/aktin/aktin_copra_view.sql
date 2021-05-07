--Aktin Produktiv
create or replace view aktin.v_aktin_copra
as
  SELECT 
    uuid_id fall_nummer, 
    alter_aufnahme, 
    geschlecht, 
    overlay(plz placing '000' from 3)::varchar(15) plz, 
    zeitpunkt_aufnahme, 
    zeitpunkt_ersteinsch, 
    zeitpunkt_entlassung, 
    case 
      when cedis_code = 'xxx' then null
      else cedis_code
    end cedis_code, 
    aufnahmegrund, 
    mts_status_farbe, 
    ee_system, 
    atemfrequenz, 
    systolic_pressure, 
    herzfrequenz, 
    temperatur,
    gcs_scorevalue,
    gcs_augenint,
    gcs_lang,
    gcs_motorik,
    mts_praesdiagr,
    mts_symptom,
    schmerzskala,
    pupille_weite_links,
    pupille_reaktion_links,
    pupille_weite_rechts,
    pupille_reaktion_rechts,
    case 
      when tetanus = 'Wert nicht dokumentiert' then null 
      else tetanus 
    end tetanus,
    case 
      when schwanger = 'Wert nicht dokumentiert' then null 
      else schwanger 
    end schwanger,
    case 
      when allergie = 'Wert nicht dokumentiert' then null 
      else allergie 
    end allergie
FROM aktin.aktin_copra ac
join diz_intern.diziduuid d
on d.fall_pat_nummer = ac.fall_nummer;


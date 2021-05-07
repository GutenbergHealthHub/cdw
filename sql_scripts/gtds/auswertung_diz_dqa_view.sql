-- patienten
create or replace view gtds.dqa_patient_quantity
as
  select count(patienten_id) quantity, 'total' entity from gtds.auswertung_diz
    union
  select count(distinct patienten_id), 'patienten' from gtds.auswertung_diz
    union  
  select count(distinct patienten_id), 'geschlecht_nicht_dokumentiert' from gtds.auswertung_diz where geschlecht isnull or geschlecht like ''
    union
  select count(distinct patienten_id), 'geburtsdatum_dokumentiert' from gtds.auswertung_diz where geburtsdatum notnull
   union 
  select count(distinct patienten_id), 'geburtsdatum_nicht_dokumentiert' from gtds.auswertung_diz where geburtsdatum isnull
   union 
  select count(patienten_id), 'addresse_dokumentiert' from gtds.auswertung_diz where plz notnull
   union 
  select count(patienten_id), 'addresse_nicht_dokumentiert' from gtds.auswertung_diz where plz isnull
    union
  select count(patienten_id), geschlecht from gtds.auswertung_diz group by geschlecht
  order by quantity; 

-- Datum der Auswertung
create or replace view gtds.dqa_datum_auswertung
as
   select 
     count(patienten_id) quantity, 
     'datum_der_auswertung_dokumentiert' datum_der_auswertung 
   from gtds.auswertung_diz where datum_der_auswertung notnull 
     union 
   select 
     count(patienten_id), 
     'datum_der_auswertung_nicht_dokumentiert' 
   from gtds.auswertung_diz where datum_der_auswertung isnull;

-- Aufnahmedatum
create or replace view gtds.dqa_aufnahmedatum
as
   select 
     count(patienten_id) quantity, 
     'aufnahmedatum_dokumentiert' aufnahmedatum 
   from gtds.auswertung_diz where aufnahmedatum notnull 
     union 
   select 
     count(patienten_id), 
     'aufnahmedatum_nicht_dokumentiert' 
   from gtds.auswertung_diz where aufnahmedatum isnull;

-- Diagnosen
create or replace view gtds.dqa_diagnosen
as
   select 
     count(patienten_id) quantity, 
     'diagnosedatum_dokumentiert' diagnosedatum 
   from gtds.auswertung_diz where diagnosedatum notnull 
     union 
   select 
     count(patienten_id), 
     'diagnosedatum_nicht_dokumentiert' 
   from gtds.auswertung_diz where diagnosedatum isnull
     union
   select count(patienten_id), 'diagnose_abteilung_nicht_dokumentiert' from gtds.auswertung_diz where diagnose_abteilung isnull
    union
   select count(patienten_id), 'diagnose_abteilung_dokumentiert' from gtds.auswertung_diz where diagnose_abteilung notnull
    union
  select count(patienten_id), 'icd9_dokumentiert' from gtds.auswertung_diz where icd9 notnull
    union 
  select count(patienten_id), 'icd9_nicht_dokumentiert' from gtds.auswertung_diz where icd9 isnull
    union
  select count(patienten_id), 'icd10_dokumentiert' from gtds.auswertung_diz where icd10 notnull
    union 
  select count(patienten_id), 'icd10_nicht_dokumentiert' from gtds.auswertung_diz ad where icd10 isnull
    union
  select count(patienten_id), 'diagnosetext_dokumentiert' from gtds.auswertung_diz where diagnosetext notnull
    union 
  select count(patienten_id), 'diagnosetext_nicht_dokumentiert' from gtds.auswertung_diz where diagnosetext isnull
  order by quantity;

-- Tumoren
create or replace view gtds.dqa_tumoren
as
  select count(patienten_id) quantity, 'tumor_id_nicht_dokumentiert' tumoren from gtds.auswertung_diz where tumor_id isnull
    union 
  select count(patienten_id), 'tumor_id_dokumentiert' tumoren from gtds.auswertung_diz where tumor_id notnull
    union 
  select count(patienten_id), 'tumor_id: '||tumor_id from gtds.auswertung_diz group by tumor_id
    union 
  select count(patienten_id), 'anzahl_tumoren_dokumentiert' from gtds.auswertung_diz where anzahl_tumoren notnull 
    union 
  select count(patienten_id), 'anzahl_tumoren_nicht_dokumentiert' from gtds.auswertung_diz where anzahl_tumoren isnull
    order by quantity;

-- Satznummer
create or replace view gtds.dqa_satznummer
as
  select count(patienten_id) quantity, 'satznummer_nicht_dokumentiert' satznummer from gtds.auswertung_diz where satznummer isnull 
    union 
  select count(patienten_id) quantity, 'satznummer_dokumentiert' from gtds.auswertung_diz where satznummer notnull
   
-- Sterbedatum
create or replace view gtds.dqa_sterbedatum
as
  select count(patienten_id) quantity, 'sterbedatum_dokumentiert' sterbedatum from gtds.auswertung_diz where sterbedatum notnull
   union 
  select count(patienten_id), 'sterbedatum_nicht_dokumentiert' from gtds.auswertung_diz where sterbedatum isnull
   union
  select 
    count(patienten_id), 
    case 
      when sterbedatum_exakt isnull then 'sterbedatun_exakt_nicht_dokumentiert'
      else 'sterbedatum_exakt: '||sterbedatum_exakt 
    end sterbedatum_exakt
  from gtds.auswertung_diz 
  group by sterbedatum_exakt;
   

create or replace view gtds.dqa_abteilung
as
  select count(patienten_id) quantity, 'anzahl_abteilungen_nicht_dokumentiert' abteilung from gtds.auswertung_diz where anzahl_abteilungen isnull
    union 
  select count(patienten_id), 'anzahl_abteilungen_dokumentiert' from gtds.auswertung_diz where anzahl_abteilungen notnull
    union 
  select count(patienten_id), 'abteilung1_dokumentiert' from gtds.auswertung_diz where abteilung1 notnull
    union 
  select count(patienten_id), 'abteilung1_nicht_dokumentiert' from gtds.auswertung_diz where abteilung1 isnull
    union 
  select count(patienten_id), 'abteilung2_dokumentiert' from gtds.auswertung_diz where abteilung2 notnull and anzahl_abteilungen > 1
    union 
  select count(patienten_id), 'abteilung2_nicht_dokumentiert' from gtds.auswertung_diz where abteilung2 isnull and anzahl_abteilungen > 1
    union 
  select count(patienten_id), 'abteilung3_dokumentiert' from gtds.auswertung_diz where abteilung3 notnull and anzahl_abteilungen > 2
    union 
  select count(patienten_id), 'abteilung3_nicht_dokumentiert' from gtds.auswertung_diz where abteilung3 isnull and anzahl_abteilungen > 2
; 

-- Abteilung 1
create or replace view gtds.dqa_abteilung1
as
  select 
    count(patienten_id) quantity, 
    abteilung1 
  from gtds.auswertung_diz 
  group by abteilung1 
  order by quantity desc;

-- Abteilung 2
create or replace view gtds.dqa_abteilung2
as
  select 
    count(patienten_id) quantity, 
    abteilung2 
  from gtds.auswertung_diz
  where abteilung2 notnull
  group by abteilung2 
  order by quantity desc;

-- Abteilung 3
create or replace view gtds.dqa_abteilung3
as
  select 
    count(patienten_id) quantity, 
    abteilung3 
  from gtds.auswertung_diz
  where abteilung3 notnull
  group by abteilung3 
  order by quantity desc;

-- Autopsie
create or replace view gtds.dqa_autopsie
as
  select count(patienten_id) quantity, autopsie from gtds.auswertung_diz where autopsie notnull group by autopsie
    union
  select count(patienten_id), 'autopsie_dokumentiert' from gtds.auswertung_diz where autopsie notnull 
    union 
  select count(patienten_id), 'autopsie_nicht_dokumentiert' from gtds.auswertung_diz where autopsie isnull 
  order by quantity
  

-- Arzt
create or replace view gtds.dqa_arzt
as
select count(patienten_id) quantity, 'anzahl_aerzte_dokumentiert' arzt from gtds.auswertung_diz where anzahl_aerzte notnull 
    union 
  select count(patienten_id), 'anzahl_aerzte_nicht_dokumentiert' from gtds.auswertung_diz where anzahl_aerzte isnull
    union 
  select count(patienten_id), 'hausarzt_nicht_vorhanden' from gtds.auswertung_diz where hausarzt isnull
    union 
  select count(patienten_id), 'hausarzt_vorhanden' from gtds.auswertung_diz where hausarzt notnull
    union 
  select count(patienten_id), 'arzt1_nicht_vorhanden' from gtds.auswertung_diz where arzt1 isnull
    union 
  select count(patienten_id), 'arzt1_vorhanden' from gtds.auswertung_diz where arzt1 notnull
    union 
  select count(patienten_id), 'anzahl_aerzte: '|| anzahl_aerzte ::varchar from gtds.auswertung_diz 
  group by anzahl_aerzte
  order by arzt;
  
  
-- Aufhenhalte
create or replace view gtds.dqa_aufhenhalten
as
  select count(patienten_id) quantity, 'anzahl_aufenthalte_dokumentiert' aufenhalten from gtds.auswertung_diz where anzahl_aufenthalte notnull
    union 
  select count(patienten_id), 'anzahl_aufenthalte_nicht_dokumentiert' from gtds.auswertung_diz where anzahl_aufenthalte isnull
    union
  select count(patienten_id), 'gesamtdauer_aufenhalte_dokumentiert' from gtds.auswertung_diz where gesamtdauer_aufenthalte notnull
    union 
  select count(patienten_id), 'gesamtdauer_aufenhalte_nicht_dokumentiert' from gtds.auswertung_diz where gesamtdauer_aufenthalte isnull
  
--Lokalisation
create or replace view gtds.dqa_lokalisation
as
  select count(patienten_id) quantity, 'lokalisation_dokumentiert' lokalisation from gtds.auswertung_diz where lokalisation notnull
    union 
  select count(patienten_id), 'lokalisation_nicht_dokumentiert' from gtds.auswertung_diz where lokalisation isnull
    union
  select count(patienten_id), 'lokalisation2_dokumentiert' from gtds.auswertung_diz where lokalisation2 notnull
    union 
  select count(patienten_id), 'lokalisation2_nicht_dokumentiert' from gtds.auswertung_diz where lokalisation2 isnull
    union
  select count(patienten_id), 'lok_seite_dokumentiert' from gtds.auswertung_diz where lok_seite notnull
    union 
  select count(patienten_id), 'lok_seite_nicht_dokumentiert' from gtds.auswertung_diz where lok_seite isnull
    union
  select count(patienten_id), 'lok_auflage_dokumentiert' from gtds.auswertung_diz where lok_auflage notnull
    union 
  select count(patienten_id), 'lok_auflage_nicht_dokumentiert' from gtds.auswertung_diz where lok_auflage isnull
    union
  select count(patienten_id), 'lok_haupt_neben_dokumentiert' from gtds.auswertung_diz where lok_haupt_neben notnull
    union 
  select count(patienten_id), 'lok_haupt_neben_nicht_dokumentiert' from gtds.auswertung_diz where lok_haupt_neben isnull
  order by lokalisation;
  

--Histologie
create or replace view gtds.dqa_histologie
as
  select count(patienten_id) quantity, 'anzahl_histologien_dokumentiert' histologie from gtds.auswertung_diz where anzahl_histologien notnull 
    union 
  select count(patienten_id), 'anzahl_histologien_nicht_dokumentiert' from gtds.auswertung_diz where anzahl_histologien isnull 
    union 
  select count(patienten_id), 'histologie_dokumentiert' from gtds.auswertung_diz where histologie notnull 
    union 
  select count(patienten_id), 'histologie_nicht_dokumentiert' from gtds.auswertung_diz where histologie isnull 
    union 
  select count(patienten_id), 'histo_lfdnr_dokumentiert' from gtds.auswertung_diz where histo_lfdnr notnull 
    union 
  select count(patienten_id), 'histo_lfdnr_nicht_dokumentiert' from gtds.auswertung_diz where histo_lfdnr isnull
    union 
  select count(patienten_id), 'histo_auflage_dokumentiert' from gtds.auswertung_diz where histo_auflage notnull 
    union 
  select count(patienten_id), 'histo_auflage_nicht_dokumentiert' from gtds.auswertung_diz where histo_auflage isnull 
    union 
  select count(patienten_id), 'histo_haupt_neben_dokumentiert' from gtds.auswertung_diz ad where histo_haupt_neben notnull 
    union 
  select count(patienten_id), 'histo_haupt_neben_nicht_dokumentiert' from gtds.auswertung_diz ad where histo_haupt_neben isnull
    union 
  select count(patienten_id), 'histo_diagnose_dokumentiert' from gtds.auswertung_diz ad where histo_diagnose notnull 
    union 
  select count(patienten_id), 'histo_diagnose_nicht_dokumentiert' from gtds.auswertung_diz ad where histo_diagnose isnull 
     union
  select count(patienten_id), 'histo_herkunft_dokumentiert' from gtds.auswertung_diz ad where histo_herkunft notnull 
    union 
  select count(patienten_id), 'histo_herkunft_nicht_dokumentiert' from gtds.auswertung_diz ad where histo_herkunft isnull
    union 
  select count(patienten_id), 'histo_grading_dokumentiert' from gtds.auswertung_diz where histo_grading notnull 
    union 
  select count(patienten_id), 'histo_grading_nicht_dokumentiert' from gtds.auswertung_diz where histo_grading isnull
  order by histologie;

-- Histo lfdnr 
create or replace view gtds.dqa_histo_lfdnr
as
  select count(patienten_id) quantity, histo_lfdnr from gtds.auswertung_diz where histo_lfdnr notnull group by histo_lfdnr order by histo_lfdnr;
 
-- Histo auflage
create or replace view gtds.dqa_histo_auflage
as
  select count(patienten_id) quantity, histo_auflage from gtds.auswertung_diz where histo_auflage notnull group by histo_auflage order by histo_auflage;
 
-- Histo haupt neben
create or replace view gtds.dqa_histo_haupt_neben
as
  select count(patienten_id) quantity, histo_haupt_neben from gtds.auswertung_diz where histo_haupt_neben notnull group by histo_haupt_neben order by histo_haupt_neben ;

-- Histo diagnose
create or replace view gtds.dqa_histo_diagnose
as
  select count(patienten_id) quantity, histo_diagnose from gtds.auswertung_diz where histo_diagnose notnull group by histo_diagnose order by histo_diagnose ;

-- Histo herkunft
create or replace view gtds.dqa_histo_herkunft
as
  select count(patienten_id) quantity, histo_herkunft from gtds.auswertung_diz where histo_herkunft notnull group by histo_herkunft order by histo_herkunft ;

 
-- Histo grading
create or replace view gtds.dqa_histo_grading
as
  select count(patienten_id) quantity, histo_grading from gtds.auswertung_diz where histo_grading notnull group by histo_grading order by histo_grading ;

 
create or replace view gtds.dqa_klin
as
    select count(patienten_id) quantity , 'klin_tnm_lfdnr_dokumentiert' klin from gtds.auswertung_diz where klin_tnm_lfdnr notnull 
    union 
  select count(patienten_id), 'klin_tnm_lfdnr_nicht_dokumentiert' from gtds.auswertung_diz where klin_tnm_lfdnr isnull 
    union 
  select count(patienten_id), 'klin_tnm_herkunft_dokumentiert' from gtds.auswertung_diz where klin_tnm_herkunft notnull 
    union 
  select count(patienten_id), 'klin_tnm_herkunft_nicht_dokumentiert' from gtds.auswertung_diz where klin_tnm_herkunft isnull
    union 
  select count(patienten_id), 'klin_tnm_datum_dokumentiert' from gtds.auswertung_diz where klin_tnm_datum notnull 
    union 
  select count(patienten_id), 'klin_tnm_datum_nicht_dokumentiert' from gtds.auswertung_diz where klin_tnm_datum isnull
    union 
  select count(patienten_id), 'klin_p_t_dokumentiert' from gtds.auswertung_diz where klin_p_t notnull 
    union 
  select count(patienten_id), 'klin_p_t_nicht_dokumentiert' from gtds.auswertung_diz where klin_p_t isnull
    union 
  select count(patienten_id), 'klin_t_dokumentiert' from gtds.auswertung_diz where klin_t notnull 
    union 
  select count(patienten_id), 'klin_t_nicht_dokumentiert' from gtds.auswertung_diz where klin_t isnull
    union 
  select count(patienten_id), 'klin_p_n_dokumentiert' from gtds.auswertung_diz where klin_p_n notnull 
    union 
  select count(patienten_id), 'klin_p_n_nicht_dokumentiert' from gtds.auswertung_diz where klin_p_n isnull
     union 
  select count(patienten_id), 'klin_n_dokumentiert' from gtds.auswertung_diz where klin_n notnull 
    union 
  select count(patienten_id), 'klin_n_nicht_dokumentiert' from gtds.auswertung_diz where klin_n isnull
    union 
  select count(patienten_id), 'klin_p_m_dokumentiert' from gtds.auswertung_diz where klin_p_m notnull 
    union 
  select count(patienten_id), 'klin_p_m_nicht_dokumentiert' from gtds.auswertung_diz where klin_p_m isnull 
     union 
  select count(patienten_id), 'klin_met_dokumentiert' from gtds.auswertung_diz where klin_met notnull 
    union 
  select count(patienten_id), 'klin_met_nicht_dokumentiert' from gtds.auswertung_diz where klin_met isnull 
    union 
  select count(patienten_id), 'klin_tnm_version_dokumentiert' from gtds.auswertung_diz where klin_tnm_auflage notnull 
    union 
  select count(patienten_id), 'klin_tnm_version_nicht_dokumentiert' from gtds.auswertung_diz where klin_tnm_auflage isnull
  order by klin
 
--Klin tnm lfdnr
create or replace view gtds.dqa_klin_tnm_lfdnr
as
  select count(patienten_id) quantity, klin_tnm_lfdnr from gtds.auswertung_diz where klin_tnm_lfdnr notnull group by klin_tnm_lfdnr order by quantity;

-- Klin tnm herkunft
create or replace view gtds.dqa_klin_tnm_herkunft
as
  select count(patienten_id) quantity, klin_tnm_herkunft from gtds.auswertung_diz where klin_tnm_herkunft notnull group by klin_tnm_herkunft order by quantity;

 
-- Klin p t
create or replace view gtds.dqa_klin_p_t
as
  select count(patienten_id) quantity, klin_p_t from gtds.auswertung_diz where klin_p_t notnull group by klin_p_t order by quantity;


-- Klin t
create or replace view gtds.dqa_klin_t
as
  select count(patienten_id) quantity, klin_t from gtds.auswertung_diz where klin_t notnull group by klin_t order by quantity;

 
-- Klin p n
create or replace view gtds.dqa_klin_p_n
as
  select count(patienten_id) quantity, klin_p_n from gtds.auswertung_diz where klin_p_n notnull group by klin_p_n order by quantity;

-- Klin n
create or replace view gtds.dqa_klin_n
as
  select count(patienten_id) quantity, klin_n from gtds.auswertung_diz where klin_n notnull group by klin_n order by quantity;


-- Klin p m
create or replace view gtds.dqa_klin_p_m
as
  select count(patienten_id) quantity, klin_p_m from gtds.auswertung_diz where klin_p_m notnull group by klin_p_m order by quantity;
 
-- Klin met
create or replace view gtds.dqa_klin_met
as
  select count(patienten_id) quantity, klin_met from gtds.auswertung_diz where klin_met notnull group by klin_met order by quantity;
 
-- Klin tnm auflage
create or replace view gtds.dqa_klin_tnm_auflage
as
  select count(patienten_id) quantity, klin_tnm_auflage from gtds.auswertung_diz where klin_tnm_auflage notnull group by klin_tnm_auflage order by quantity;
  
 
-- C Stadium
create or replace view gtds.dqa_c_stadium
as
  select count(patienten_id) quantity, 'c_stadium_dokumentiert' c_stadium from gtds.auswertung_diz where c_stadium notnull 
    union 
  select count(patienten_id), 'c_stadium_nicht_dokumentiert' from gtds.auswertung_diz where c_stadium isnull
    union
  select count(patienten_id), c_stadium from gtds.auswertung_diz where c_stadium notnull group by c_stadium
  order by quantity;
 
-- P
create or replace view gtds.dqa_p
as
  select count(patienten_id) quantity, 'p_tnm_lfdnr_dokumentiert' p from gtds.auswertung_diz where p_tnm_lfdnr notnull 
    union 
  select count(patienten_id), 'p_tnm_lfdnr_nicht_dokumentiert' from gtds.auswertung_diz where p_tnm_lfdnr isnull 
    union 
  select count(patienten_id), 'p_tnm_herkunft_dokumentiert' from gtds.auswertung_diz where p_tnm_herkunft notnull 
    union 
  select count(patienten_id), 'p_tnm_herkunft_nicht_dokumentiert' from gtds.auswertung_diz where p_tnm_herkunft isnull
    union 
  select count(patienten_id), 'p_tnm_datum_dokumentiert' from gtds.auswertung_diz where p_tnm_datum notnull 
    union 
  select count(patienten_id), 'p_tnm_datum_nicht_dokumentiert' from gtds.auswertung_diz where p_tnm_datum isnull
    union 
  select count(patienten_id), 'p_p_t_dokumentiert' from gtds.auswertung_diz where p_p_t notnull 
    union 
  select count(patienten_id), 'p_p_t_nicht_dokumentiert' from gtds.auswertung_diz where p_p_t isnull
    union 
  select count(patienten_id), 'p_t_dokumentiert' from gtds.auswertung_diz where p_t notnull 
    union 
  select count(patienten_id), 'p_t_nicht_dokumentiert' from gtds.auswertung_diz where p_t isnull
    union 
  select count(patienten_id), 'p_p_n_dokumentiert' from gtds.auswertung_diz where p_p_n notnull 
    union 
  select count(patienten_id), 'p_p_n_nicht_dokumentiert' from gtds.auswertung_diz where p_p_n isnull
    union 
  select count(patienten_id), 'p_n_dokumentiert' from gtds.auswertung_diz where p_n notnull 
    union 
  select count(patienten_id), 'p_n_nicht_dokumentiert' from gtds.auswertung_diz where p_n isnull
    union 
  select count(patienten_id), 'p_p_m_dokumentiert' from gtds.auswertung_diz where p_p_m notnull 
    union 
  select count(patienten_id), 'p_p_m_nicht_dokumentiert' from gtds.auswertung_diz where p_p_m isnull
    union 
  select count(patienten_id), 'p_met_dokumentiert' from gtds.auswertung_diz where p_met notnull 
    union 
  select count(patienten_id), 'p_met_nicht_dokumentiert' from gtds.auswertung_diz where p_met isnull
    union 
  select count(patienten_id), 'p_tnm_auflage_dokumentiert' from gtds.auswertung_diz where p_tnm_auflage notnull 
    union 
  select count(patienten_id), 'p_tnm_auflage_nicht_dokumentiert' from gtds.auswertung_diz where p_tnm_auflage isnull 
    union 
  select count(patienten_id), 'p_stadium_dokumentiert' from gtds.auswertung_diz where p_stadium notnull 
    union 
  select count(patienten_id), 'p_stadium_nicht_dokumentiert' from gtds.auswertung_diz where p_stadium isnull
  order by p;
 
-- p stadium
create or replace view gtds.dqa_p_stadium
as
  select count(patienten_id) quantity, p_stadium from gtds.auswertung_diz where p_stadium notnull group by p_stadium order by quantity;


 --p tnm lfdnr
create or replace view gtds.dqa_p_tnm_lfdnr
as
  select count(patienten_id) quantity, p_tnm_lfdnr from gtds.auswertung_diz where p_tnm_lfdnr notnull group by p_tnm_lfdnr order by quantity;

-- p tnm herkunft
create or replace view gtds.dqa_p_tnm_herkunft
as
  select count(patienten_id) quantity, p_tnm_herkunft from gtds.auswertung_diz where p_tnm_herkunft notnull group by p_tnm_herkunft order by quantity;

 
-- p p t
create or replace view gtds.dqa_p_p_t
as
  select count(patienten_id) quantity, p_p_t from gtds.auswertung_diz where p_p_t notnull group by p_p_t order by quantity;


-- p t
create or replace view gtds.dqa_p_t
as
  select count(patienten_id) quantity, p_t from gtds.auswertung_diz where p_t notnull group by p_t order by quantity;

 
-- p p n
create or replace view gtds.dqa_p_p_n
as
  select count(patienten_id) quantity, p_p_n from gtds.auswertung_diz where p_p_n notnull group by p_p_n order by quantity;

-- p n
create or replace view gtds.dqa_p_n
as
  select count(patienten_id) quantity, p_n from gtds.auswertung_diz where p_n notnull group by p_n order by quantity;


-- p p m
create or replace view gtds.dqa_p_p_m
as
  select count(patienten_id) quantity, p_p_m from gtds.auswertung_diz where p_p_m notnull group by p_p_m order by quantity;
 
-- p met
create or replace view gtds.dqa_p_met
as
  select count(patienten_id) quantity, p_met from gtds.auswertung_diz where p_met notnull group by p_met order by quantity;
 
-- p tnm auflage
create or replace view gtds.dqa_p_tnm_auflage
as
  select count(patienten_id) quantity, p_tnm_auflage from gtds.auswertung_diz where p_tnm_auflage notnull group by p_tnm_auflage order by quantity;
  
 
-- Ann_arbor
--create or replace view gtds.dqa_ann_arbor
--as
  select count(patienten_id) quantity, 'ann_arbor_lfdnr_dokumentiert' ann_arbor from gtds.auswertung_diz where ann_arbor_lfdnr notnull 
    union 
  select count(patienten_id), 'ann_arbor_lfdnr_nicht_dokumentiert' from gtds.auswertung_diz where ann_arbor_lfdnr isnull
    union 
  select count(patienten_id), 'ann_arbor_herkunft_dokumentiert' from gtds.auswertung_diz where ann_arbor_herkunft notnull 
    union 
  select count(patienten_id), 'ann_arbor_herkunft_nicht_dokumentiert' from gtds.auswertung_diz where ann_arbor_herkunft isnull
    union 
  select count(patienten_id), 'ann_arbor_datum_dokumentiert' from gtds.auswertung_diz where ann_arbor_datum notnull 
    union 
  select count(patienten_id), 'ann_arbor_datum_nicht_dokumentiert' from gtds.auswertung_diz where ann_arbor_datum isnull
    union 
  select count(patienten_id), 'ann_arbor_stadium_dokumentiert' from gtds.auswertung_diz where ann_arbor_stadium notnull 
    union 
  select count(patienten_id), 'ann_arbor_stadium_nicht_dokumentiert' from gtds.auswertung_diz where ann_arbor_stadium isnull
    union 
  select count(patienten_id), 'ann_arbor_allgemein_dokumentiert' from gtds.auswertung_diz where ann_arbor_allgemein notnull 
    union 
  select count(patienten_id), 'ann_arbor_allgemein_nicht_dokumentiert' from gtds.auswertung_diz where ann_arbor_allgemein isnull
  order by ann_arbor;
 
 
--Ann_arbor_lfdnr
create or replace view gtds.dqa_ann_arbor_lfdnr
as
  select count(patienten_id) quantity, ann_arbor_lfdnr from gtds.auswertung_diz where ann_arbor_lfdnr notnull group by ann_arbor_lfdnr order by quantity;
 
--Ann_arbor_herkunft
create or replace view gtds.dqa_ann_arbor_herkunft
as
  select count(patienten_id) quantity, ann_arbor_herkunft from gtds.auswertung_diz where ann_arbor_herkunft notnull group by ann_arbor_herkunft order by quantity;
 
--Ann_arbor_stadium
create or replace view gtds.dqa_ann_arbor_stadium
as
  select count(patienten_id) quantity, ann_arbor_stadium from gtds.auswertung_diz where ann_arbor_stadium notnull group by ann_arbor_stadium order by quantity;

--Ann_arbor_allgemein
create or replace view gtds.dqa_ann_arbor_allgemein
as
  select count(patienten_id) quantity, ann_arbor_allgemein from gtds.auswertung_diz where ann_arbor_allgemein notnull group by ann_arbor_allgemein order by quantity;


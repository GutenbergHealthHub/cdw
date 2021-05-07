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
  order by quantity
;

-- Diagnose df Abteilung id
create or replace view gtds.dqa_diagnose_df_abt_id
as
  select count(patienten_id) quantity, diagnose_df_abt_id from gtds.auswertung_diz group by diagnose_df_abt_id 
;

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
   from gtds.auswertung_diz where aufnahmedatum isnull
;

-- Diagnosen
create or replace view gtds.dqa_diagnosen
as
   select 
     count(patienten_id) quantity, 
     case 
       when diagnosedatum isnull then 'diagnosedatum_nicht_dokumentiert' 
       else 'diagnosedatum_dokumentiert' 
     end diagnose 
   from gtds.auswertung_diz 
   group by diagnose 
     union 
   select 
     count(patienten_id), 
     case 
       when diagnose_abteilung isnull then 'diagnose_abteilung_nicht_dokumentiert' 
       else 'diagnose_abteilung_dokumentiert'
     end diagnose 
   from gtds.auswertung_diz
   group by diagnose 
    union
  select 
    count(patienten_id), 
    case 
      when icd9 isnull then 'icd9_nicht_dokumentiert' 
      else 'icd9_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz 
  group by diagnose 
    union 
  select 
    count(patienten_id), 
    case 
      when icd10 isnull then 'icd10_nicht_dokumentiert' 
      else 'icd10_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose 
    union
  select 
    count(patienten_id), 
    case
      when diagnosetext isnull then 'diagnosetext_nicht_dokumentiert' 
      else 'diagnosetext_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose 
    union  
  select 
    count(patienten_id), 
    case 
      when diagnose_df_abt_id isnull then 'diagnose_df_abt_id_nicht_dokumentiert'
      else 'diagnose_df_abt_id_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose  
    union 
  select 
    count(patienten_id), 
    case 
      when diagnose_df_arzt_id isnull then 'diagnose_df_arzt_id_nicht_dokumentiert' 
      else 'diagnose_df_arzt_id_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose 
    union 
  select 
    count(patienten_id), 
    case 
      when plz_bei_diagnose isnull then 'plz_bei_diagnose_nicht_dokumentiert' 
      else 'plz_bei_diagnose_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose 
    union 
  select 
    count(patienten_id), 
    case 
      when nachfolgende_diagnosen isnull then 'nachfolgende_diagnosen_nicht_dokumentiert' 
      else 'nachfolgende_diagnosen_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose
    union 
  select 
    count(patienten_id), 
    case 
      when diagnosedatum_genau isnull then 'diagnosedatum_genau_nicht_dokumentiert' 
      else 'diagnosedatum_genau_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose
    union 
  select 
    count(patienten_id), 
    case 
      when vorangehende_diagnosen isnull then 'vorangehende_diagnosen_nicht_dokumentiert' 
      else 'vorangehende_diagnosen_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose
    union 
  select 
    count(patienten_id), 
    case 
      when gleichzeitige_diagnosen isnull then 'gleichzeitige_diagnosen_nicht_dokumentiert' 
      else 'gleichzeitige_diagnosen_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose
    union 
  select 
    count(patienten_id), 
    case 
      when okz_bei_diagnose isnull then 'okz_bei_diagnose_nicht_dokumentiert' 
      else 'okz_bei_diagnose_dokumentiert'
    end diagnose 
  from gtds.auswertung_diz
  group by diagnose
  order by diagnose 
;

-- PLZ bei Diagnosen
create or replace view gtds.dqa_plz_bei_diagnosen
as
  select
    count(patienten_id) quantity,
    plz_bei_diagnose 
  from gtds.auswertung_diz
  where plz_bei_diagnose notnull
  group by plz_bei_diagnose
  order by quantity desc
;
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
  select count(patienten_id) quantity, 'satznummer_dokumentiert' from gtds.auswertung_diz where satznummer notnull;
   
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
   

-- Abteilung
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
    union 
  select 
    count(patienten_id),
    case 
      when alle_abteilungen isnull then 'alle_abteilungen_nicht_dokumentiert'
      else 'alle_abteilungen_dokumentiert'
    end abteilung
    from gtds.auswertung_diz
    group by abteilung
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
  order by quantity;
  

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
    union 
  select 
    count(patienten_id),
    case 
      when alle_aerzte isnull then 'alle_aerzte_nicht_dokumentiert'
      else 'alle_aerzte_dokumentiert'
    end arzt 
  from gtds.auswertung_diz
  where anzahl_aerzte > 0
  group by arzt
    union 
  select 
    count(patienten_id),
    case 
      when arzt_anlass isnull then 'arzt_anlass_nicht_dokumentiert'
      else 'arzt_anlass_dokumentiert'
    end arzt 
  from gtds.auswertung_diz
  group by arzt
    union 
  select 
    count(patienten_id),
    case 
      when nachfragearzt isnull then 'nachfragearzt_nicht_dokumentiert'
      else 'nachfragearzt_dokumentiert'
    end arzt 
  from gtds.auswertung_diz
  group by arzt
  order by arzt
;
  
-- Arzt Anlass
create or replace view gtds.dqa_arzt_anlass
as
  select
    count(patienten_id) quantity,
    arzt_anlass 
  from gtds.auswertung_diz
  where arzt_anlass notnull
  group by arzt_anlass
  order by quantity
;



-- Aufhenhalte
create or replace view gtds.dqa_aufhenhalten
as
  select count(patienten_id) quantity, 'anzahl_aufenthalte_dokumentiert' aufenhalten from gtds.auswertung_diz where anzahl_aufenthalte notnull
    union 
  select count(patienten_id), 'anzahl_aufenthalte_nicht_dokumentiert' from gtds.auswertung_diz where anzahl_aufenthalte isnull
    union
  select count(patienten_id), 'gesamtdauer_aufenhalte_dokumentiert' from gtds.auswertung_diz where gesamtdauer_aufenthalte notnull
    union 
  select count(patienten_id), 'gesamtdauer_aufenhalte_nicht_dokumentiert' from gtds.auswertung_diz where gesamtdauer_aufenthalte isnull;
  
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
    union 
  select count(patienten_id), 'histologie2_nicht_dokumentiert' from gtds.auswertung_diz where histologie2 isnull
    union 
  select count(patienten_id), 'histologie2_dokumentiert' from gtds.auswertung_diz where histologie2 notnull
    union 
  select 
    count(patienten_id),
    case 
      when histo_datum isnull then 'histo_datum_nicht_dokumentiert'
      else 'histo_datum_dokumentiert'
    end histologie_doku 
  from gtds.auswertung_diz
  group by histologie_doku 
    union 
  select 
    count(patienten_id),
    case 
      when histo_sicherungsdatum isnull then 'histo_sicherungsdatum_nicht_dokumentiert'
      else 'histo_sicherungsdatum_dokumentiert'
    end histologie_doku 
  from gtds.auswertung_diz
  group by histologie_doku 
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

--Klin tnm 
create or replace view gtds.dqa_klin
as
  select 
    count(patienten_id) quantity, 
    case 
      when klin_tnm_lfdnr isnull then 'klin_tnm_lfdnr_nicht_dokumentiert' 
      else 'klin_tnm_lfdnr_dokumentiert'
    end klin 
  from gtds.auswertung_diz 
  group by klin 
    union 
  select 
    count(patienten_id), 
    case 
      when klin_tnm_herkunft isnull then 'klin_tnm_herkunft_nicht_dokumentiert' 
      else'klin_tnm_herkunft_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union 
  select 
    count(patienten_id), 
    case 
      when klin_tnm_datum isnull then 'klin_tnm_datum_nicht_dokumentiert' 
      else 'klin_tnm_datum_dokumentiert' 
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union 
  select 
    count(patienten_id), 
    case 
      when klin_p_t isnull then 'klin_p_t_nicht_dokumentiert' 
      else 'klin_p_t_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union 
  select 
    count(patienten_id), 
    case 
      when klin_t isnull then 'klin_t_nicht_dokumentiert'
      else 'klin_t_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin
    union  
  select 
    count(patienten_id), 
    case 
      when klin_p_n isnull then 'klin_p_n_nicht_dokumentiert' 
      else 'klin_p_n_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin
     union
  select 
    count(patienten_id), 
    case 
      when klin_n isnull then 'klin_n_nicht_dokumentiert' 
      else 'klin_n_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union 
  select 
    count(patienten_id), 
    case 
      when klin_p_m isnull then 'klin_p_m_nicht_dokumentiert' 
      else 'klin_p_m_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin 
     union 
  select 
    count(patienten_id), 
    case 
      when klin_met isnull then 'klin_met_nicht_dokumentiert' 
      else 'klin_met_dokumentiert' 
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union  
  select 
    count(patienten_id), 
    case 
      when klin_tnm_auflage isnull then 'klin_tnm_auflage_nicht_dokumentiert' 
      else 'klin_tnm_auflage_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union 
  select 
    count(patienten_id), 
    case 
      when klin_tnm_auswertungs_relevant isnull then 'klin_tnm_auswertungs_relevant_nicht_dokumentiert' 
      else 'klin_tnm_auswertungs_relevant_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union 
  select 
    count(patienten_id), 
    case 
      when klin_y_symbol isnull then 'klin_y_symbol_nicht_dokumentiert' 
      else 'klin_y_symbol_dokumentiert'
    end klin 
  from gtds.auswertung_diz
  group by klin 
    union 
  select 
    count(patienten_id),
    case 
      when klin_m isnull then 'klin_m_nicht_dokumentiert'
      else 'klin_m_dokumentier'
    end klin 
  from gtds.auswertung_diz
  group by klin
    union 
  select 
    count(patienten_id),
    case 
      when klin_l isnull then 'klin_l_nicht_dokumentiert'
      else 'klin_l_dokumentier'
    end klin 
  from gtds.auswertung_diz
  group by klin
    union 
  select 
    count(patienten_id),
    case 
      when klin_v isnull then 'klin_v_nicht_dokumentiert'
      else 'klin_v_dokumentier'
    end klin 
  from gtds.auswertung_diz
  group by klin
    union 
  select 
    count(patienten_id),
    case 
      when klin_s isnull then 'klin_s_nicht_dokumentiert'
      else 'klin_s_dokumentier'
    end klin 
  from gtds.auswertung_diz
  group by klin
    union 
  select 
    count(patienten_id),
    case 
      when klin_pni isnull then 'klin_pni_nicht_dokumentiert'
      else 'klin_pni_dokumentier'
    end klin 
  from gtds.auswertung_diz
  group by klin
    union 
  select 
    count(patienten_id),
    case 
      when klin_a_symbol isnull then 'klin_a_symbol_nicht_dokumentiert'
      else 'klin_a_symbol_dokumentier'
    end klin 
  from gtds.auswertung_diz
  group by klin
  order by klin;
 
--Klin tnm lfdnr
create or replace view gtds.dqa_klin_tnm_lfdnr
as
  select count(patienten_id) quantity, klin_tnm_lfdnr from gtds.auswertung_diz where klin_tnm_lfdnr notnull group by klin_tnm_lfdnr order by quantity;

-- Klin tnm herkunft
create or replace view gtds.dqa_klin_tnm_herkunft
as
  select count(patienten_id) quantity, klin_tnm_herkunft from gtds.auswertung_diz where klin_tnm_herkunft notnull group by klin_tnm_herkunft order by quantity;

-- Klin tnm auswertungs_relevant
create or replace view gtds.dqa_klin_tnm_auswertungs_relevant
as
  select 
    count(patienten_id) quantity, 
    klin_tnm_auswertungs_relevant 
  from gtds.auswertung_diz 
  where klin_tnm_auswertungs_relevant notnull 
  group by klin_tnm_auswertungs_relevant 
  order by quantity
;

--Klin pni
create or replace view gtds.dqa_klin_pni
as 
  select 
    count(patienten_id) quantity,
    klin_pni 
  from gtds.auswertung_diz
  where klin_pni notnull
  group by klin_pni
  order by quantity
;

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
    union 
  select count(patienten_id), 'p_tnm_auswertungs_relevant_nicht_dokumentiert' from gtds.auswertung_diz where p_tnm_auswertungs_relevant isnull
    union 
  select count(patienten_id), 'p_tnm_auswertungs_relevant_dokumentiert' from gtds.auswertung_diz where p_tnm_auswertungs_relevant notnull
    union 
  select count(patienten_id), 'p_y_symbol_dokumentiert' from gtds.auswertung_diz where p_y_symbol notnull
    union 
  select count(patienten_id), 'p_y_symbol_nicht_dokumentiert' from gtds.auswertung_diz where p_y_symbol isnull
    union 
  select 
    count(patienten_id),
    case 
      when p_m isnull then 'p_m_nicht_dokumentiert'
      else 'p_m_dokumentier'
    end p 
  from gtds.auswertung_diz
  group by p
    union 
  select 
    count(patienten_id),
    case 
      when p_l isnull then 'p_l_nicht_dokumentiert'
      else 'p_l_dokumentier'
    end p 
  from gtds.auswertung_diz
  group by p
    union 
  select 
    count(patienten_id),
    case 
      when p_v isnull then 'p_v_nicht_dokumentiert'
      else 'p_v_dokumentier'
    end p 
  from gtds.auswertung_diz
  group by p
    union 
  select 
    count(patienten_id),
    case 
      when p_s isnull then 'p_s_nicht_dokumentiert'
      else 'p_s_dokumentier'
    end p 
  from gtds.auswertung_diz
  group by p
    union 
  select 
    count(patienten_id),
    case 
      when p_pni isnull then 'p_pni_nicht_dokumentiert'
      else 'p_pni_dokumentier'
    end p 
  from gtds.auswertung_diz
  group by p
    union 
  select 
    count(patienten_id),
    case 
      when p_a_symbol isnull then 'p_a_symbol_nicht_dokumentiert'
      else 'p_a_symbol_dokumentier'
    end p 
  from gtds.auswertung_diz
  group by p
  order by p
;

-- p_pni
create or replace view gtds.dqa_p_pni
as
  select 
    count(patienten_id) quantity,
    p_pni
  from gtds.auswertung_diz
  where p_pni notnull 
  group by p_pni 
;
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

 
-- p tnm auswertungs relevant
create or replace view gtds.dqa_p_tnm_auswertungs_relevant
as
  select count(patienten_id) quantity, p_tnm_auswertungs_relevant from gtds.auswertung_diz where p_tnm_auswertungs_relevant notnull group by p_tnm_auswertungs_relevant order by quantity;
  
 
-- Ann_arbor
create or replace view gtds.dqa_ann_arbor
as
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
    union 
  select count(patienten_id), 'ann_arbor_extra_nicht_dokumentiert' from gtds.auswertung_diz where ann_arbor_extra isnull
    union 
  select count(patienten_id), 'ann_arbor_extra_dokumentiert' from gtds.auswertung_diz where ann_arbor_extra notnull 
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

--Ann_arbor_extra
create or replace view gtds.dqa_ann_arbor_extra
as
  select 
    count(patienten_id) quantity,
    ann_arbor_extra 
  from gtds.auswertung_diz ad
  where ann_arbor_extra notnull
  group by ann_arbor_extra ;
 
-- Sonstige
create or replace view gtds.dqa_sonstige
as
  select 
    count(patienten_id) quantity,
    case
      when anzahl_sonstige isnull then 'anzahl_sonstige_nicht_dokumentiert'
      else 'anzahl_sonstige_dokumentiert'
    end sonstige
  from gtds.auswertung_diz
  group by sonstige
      union
  select 
    count(patienten_id),
    case
      when sonstige_name isnull then 'sonstige_name_nicht_vorhanden'
      else 'sonstige_name_dokumentiert'
    end sonstige
  from gtds.auswertung_diz
  where anzahl_sonstige > 0
  group by sonstige
    union
  select 
    count(patienten_id),
    case 
      when sonstige_name isnull then 'sonstige_name_null'
      else 'sonstige_name_'||sonstige_name 
    end sonstige 
  from gtds.auswertung_diz  
  group by sonstige
    union 
  select 
    count(patienten_id),
    case 
      when sonstige_id isnull then 'sonstige_id_null'
      else 'sonstige_id_'||sonstige_id 
    end sonstige 
  from gtds.auswertung_diz  
  group by sonstige
    union 
  select 
    count(patienten_id),
    case
      when sonstige_name isnull then 'sonstige_id_nicht_vorhanden'
      else 'sonstige_id_dokumentiert'
    end sonstige
  from gtds.auswertung_diz
  where anzahl_sonstige > 0
  group by sonstige
    union 
  select 
    count(patienten_id),
    case 
      when sonstige_lfdnr isnull then 'sonstige_lfdnr_null'
      else 'sonstige_lfdnr_'||sonstige_lfdnr 
    end sonstige 
  from gtds.auswertung_diz
  where anzahl_sonstige > 0
  group by sonstige 
    union 
  select 
    count(patienten_id),
    case 
      when sonstige_lfdnr isnull then 'sonstige_lfdnr_nicht_vorhanden'
      else 'sonstige_lfdnr_dokumentiert' 
   end sonstige 
  from gtds.auswertung_diz
  group by sonstige
    union
  select 
    count(patienten_id),
    case 
      when sonstige_herkunft isnull then 'sonstige_herkunft_null'
      else 'sonstige_herkunft_'||sonstige_herkunft 
    end sonstige 
  from gtds.auswertung_diz
  where anzahl_sonstige > 0
  group by sonstige 
    union 
  select 
    count(patienten_id),
    case 
      when sonstige_herkunft isnull then 'sonstige_herkunft_nicht_vorhanden'
      else 'sonstige_herkunf_dokumentiert' 
   end sonstige 
  from gtds.auswertung_diz
  group by sonstige
    union 
  select 
    count(patienten_id),
    case 
      when sonstige_datum isnull then 'sonstige_datum_nicht_dokumentiert'
      else 'sonstige_datum_dokumentiert' 
    end sonstige 
  from gtds.auswertung_diz
  where anzahl_sonstige > 0
  group by sonstige
    union 
  select 
    count(patienten_id),
    case 
      when sonstige_stadium isnull then 'sonstige_stadium_nicht_dokumentiert'
      else 'sonstige_stadium_dokumentiert'
    end sonstige 
  from gtds.auswertung_diz
  where anzahl_sonstige > 0
  group by sonstige
    union 
  select 
    count(patienten_id),
    'anzahl_sonstige_plus_0'
  from gtds.auswertung_diz
  where anzahl_sonstige > 0 
    union 
  select 
    count(patienten_id),
    case 
      when sonstige_kuerzel isnull then 'sonstige_kuerzel_nicht_dokumentiert'
      else 'sonstige_kuerzel_dokumentiert'
    end sonstige 
  from gtds.auswertung_diz
  where anzahl_sonstige > 0
  group by sonstige
  order by sonstige
;
 

--Therapie
create or replace view gtds.dqa_therapie
as
  select 
    count(patienten_id) quantity,
    case
      when therapieebeginn isnull then 'therapiebeginn_nicht_dokumentiert'
      else 'therapiebeginn_dokumentiert'
    end therapie
  from gtds.auswertung_diz
  group by therapie
    union 
  select 
    count(patienten_id),
    case 
      when primaertherapie isnull then 'primaertherapie_nicht_dokumentiert'
      else 'primaertherapie_dokumentiert'
    end therapie 
  from gtds.auswertung_diz
  group by therapie
    union 
  select 
    count(patienten_id),
    case
      when therapieende isnull then 'therapieende_nicht_dokumentiert'
      else 'therapieende_dokumentiert'
    end therapie
  from gtds.auswertung_diz
  group by therapie
  order by therapie
;
 
-- Operationen
create or replace view gtds.dqa_operation
as
  select 
    count(patienten_id) quantity,
    case 
      when anzahl_operationen isnull then 'anzahl_operationen_nicht_dokumentiert'
      else 'anzahl_operationen_dokumentiert'
    end operationen
  from gtds.auswertung_diz
  group by operationen
    union 
  select 
    count(patienten_id),
    case
      when op_nummer isnull then 'op_nummer_nicht_dokumentiert'
      else 'op_nummer_dokumentier'
    end operationen 
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen 
    union 
  select 
    count(patienten_id),
    case 
      when op_datum isnull then 'op_datum_nicht_dokumentiert'
      else 'op_datum_dokumentiert'
    end operationen 
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen 
    union 
  select 
    count(patienten_id),
    case
      when op_abteilung isnull then 'op_abteilung_nicht_dokumentiert'
      else 'op_abteilung_dokumentiert'
    end operationen 
  from gtds.auswertung_diz
  where anzahl_operationen > 0
  group by operationen 
    union 
  select 
    count(patienten_id),
    case 
      when op_bezeichnung isnull then 'op_bezeichnung_nicht_dokumentiert'
      else 'op_bezeichnung_dokumentiert'
    end operationen 
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen 
    union 
  select 
    count(patienten_id),
    case 
      when op_schluessel isnull then 'op_schluessel_nicht_dokumentiert'
      else 'op_schluessel_dokumentiert'
    end operationen 
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen 
    union 
  select 
    count(patienten_id),
    case 
      when op_schluessel_auflage isnull then 'op_schluessel_auflage_nicht_dokumentiert'
      else 'op_schluessel_auflage_dokumentiert'
    end operationen 
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen
    union 
  select 
    count(patienten_id),
    case 
      when anzahl_operationen > 0 then 'anzahl_operationen_plus_zero'
      when anzahl_operationen < 1 then 'anzahl_operationen_ist_zero'
    end operationen 
  from gtds.auswertung_diz 
  group by operationen
    union
  select 
    count(patienten_id) quantity,
    case 
      when op_durchgefuehrt isnull then 'op_durchgefuehrt_nicht_dokumentiert'
      else 'op_durchgefuert_dokumentiert'
    end operationen
  from gtds.auswertung_diz
  where anzahl_operationen > 0
  group by operationen
    union
  select 
    count(patienten_id),
    case 
      when op_intention isnull then 'op_intention_nicht_dokumentiert'
      else 'op_intention_dokumentiert'
    end operationen
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen
    union 
  select 
    count(patienten_id),
    case 
      when op_df_abt_id isnull then 'op_df_abt_id_nicht_dokumentiert'
      else 'op_df_abt_id_dokumentiert'
    end operationen
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen
    union 
  select 
    count(patienten_id),
    case 
      when op_df_arzt_id isnull then 'op_df_arzt_id_nicht_dokumentiert'
      else 'op_df_arzt_id_dokumentiert'
    end operationen
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen
    union 
  select 
    count(patienten_id),
    case 
      when alle_operationen isnull then 'alle_operationen_nicht_dokumentiert'
      else 'alle_operationen_dokumentiert'
    end operationen
  from gtds.auswertung_diz 
  where anzahl_operationen > 0
  group by operationen
  order by operationen 
;

--Innere
create or replace view gtds.dqa_innere
as
  select 
    count(patienten_id) quantity,
    case 
      when anzahl_innere isnull then 'anzahl_innere_nicht_dokumentiert'
      else 'anzahl_innere_dokumentiert'
    end innere
  from gtds.auswertung_diz
  group by innere
    union 
  select 
    count(patienten_id),
    case 
      when innere_nummer isnull then 'innere_nummer_nicht_dokumentiert'
      else 'innere_nummer_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere 
    union 
  select 
    count(patienten_id),
    case 
      when innere_beginn isnull then 'innere_beginn_nicht_dokumentiert'
      else 'innere_beginn_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere 
    union 
  select 
    count(patienten_id),
    case 
      when innere_abteilung isnull then 'innere_abteilung_nicht_dokumentiert'
      else 'innere_abteilung_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere 
    union 
  select 
    count(patienten_id),
    case 
      when innere_protokoll_id isnull then 'innere_protokoll_id_nicht_dokumentiert'
      else 'innere_protokoll_id_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere 
    union 
  select 
    count(patienten_id),
    case 
      when innere_protokoll_typ isnull then 'innere_protokoll_typ_nicht_dokumentiert'
      else 'innere_protokoll_typ_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere 
    union 
  select 
    count(patienten_id),
    case 
      when anzahl_innere > 0 then 'anzahl_innere_plus_zero'
      when anzahl_innere < 1 then 'anzahl_innere_ist_zero'
    end innere 
  from gtds.auswertung_diz 
  group by innere
    union 
  select 
    count(patienten_id),
    case 
      when innere_anzahl_zyklen isnull then 'innere_anzahl_zyklen_nicht_dokumentiert'
      else 'innere_anzahl_zyklen_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere
    union 
  select 
    count(patienten_id),
    case 
      when innere_freitext isnull then 'innere_freitext_nicht_dokumentiert'
      else 'innere_freitext_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere
    union 
  select 
    count(patienten_id),
    case 
      when innere_df_abt_id isnull then 'innere_df_abt_id_nicht_dokumentiert'
      else 'innere_df_abt_id_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere
    union
  select 
    count(patienten_id),
    case 
      when innere_df_arzt_id isnull then 'innere_df_arzt_id_nicht_dokumentiert'
      else 'innere_df_arzt_id_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere
    union 
  select 
    count(patienten_id),
    case 
      when innere_protokoll_typ isnull then 'innere_protokoll_typ_nicht_dokumentiert'
      else 'innere_protokoll_typ_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere
    union 
  select 
    count(patienten_id),
    case 
      when alle_inneren isnull then 'alle_innere_nicht_dokumentiert'
      else 'alle_innere_dokumentiert'
    end innere 
  from gtds.auswertung_diz 
  where anzahl_innere > 0
  group by innere
  order by innere 
;

-- Innere Protokoll Typ
create or replace view gtds.dqa_innere_protokoll_typ
as
  select 
    count(patienten_id) quantity, 
    innere_protokoll_typ 
  from gtds.auswertung_diz 
  where innere_protokoll_typ notnull 
  group by innere_protokoll_typ
  order by quantity
;

-- Bestrahlung
create or replace view gtds.dqa_bestrahlung
as
   select 
    count(patienten_id) quantity,
    case 
      when anzahl_bestrahlungen isnull then 'anzahl_bestrahlungen_nicht_dokumentiert'
      else 'anzahl_bestrahlungen_dokumentiert'
    end bestrahlungen
  from gtds.auswertung_diz
  group by bestrahlungen
    union 
  select 
    count(patienten_id),
    case 
      when bestrahlung_nummer isnull then 'bestrahlung_nummer_nicht_dokumentiert'
      else 'bestrahlung_nummer_dokumentiert'
    end bestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_bestrahlungen > 0
  group by bestrahlungen 
    union 
  select 
    count(patienten_id),
    case 
      when bestrahlung_datum isnull then 'bestrahlung_datum_nicht_dokumentiert'
      else 'bestrahlung_datum_dokumentiert'
    end bestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_bestrahlungen > 0
  group by bestrahlungen
    union 
 select 
    count(patienten_id),
    case 
      when bestrahlung_abteilung isnull then 'bestrahlung_abteilung_nicht_dokumentiert'
      else 'bestrahlung_abteilung_dokumentiert'
    end bestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_bestrahlungen > 0
  group by bestrahlungen
    union 
  select 
    count(patienten_id),
    case 
      when bestrahlung_freitext isnull then 'bestrahlung_freitext_nicht_dokumentiert'
      else 'bestrahlung_freitext_dokumentiert'
    end bestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_bestrahlungen > 0
  group by bestrahlungen
    union 
  select 
    count(patienten_id),
    case 
      when bestrahlung_df_abt_id isnull then 'bestrahlung_df_abt_id_nicht_dokumentiert'
      else 'bestrahlung_df_abt_id_dokumentiert'
    end bestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_bestrahlungen > 0
  group by bestrahlungen
    union 
  select 
    count(patienten_id),
    case 
      when bestrahlung_df_arzt_id isnull then 'bestrahlung_df_arzt_id_nicht_dokumentiert'
      else 'bestrahlung_df_arzt_id_dokumentiert'
    end bestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_bestrahlungen > 0
  group by bestrahlungen
    union 
  select 
    count(patienten_id),
    case 
      when alle_bestrahlungen isnull then 'alle_bestrahlungen_nicht_dokumentiert'
      else 'alle_bestrahlungen_dokumentiert'
    end bestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_bestrahlungen > 0
  group by bestrahlungen
  order by bestrahlungen
;

--Bestrahlung df abt id
create or replace view gtds.dqa_bestrahlung_df_abt_id
as
  select 
    count(patienten_id) quantity, 
    bestrahlung_df_abt_id 
  from gtds.auswertung_diz 
  where bestrahlung_df_abt_id notnull 
  group by bestrahlung_df_abt_id
  order by quantity
;

-- Teilbestrahlung
create or replace view gtds.dqa_teilbestrahlung
as
  select 
    count(patienten_id) quantity,
    case 
      when anzahl_teilbestrahlungen isnull then 'anzahl_teilbestrahlungen_nicht_dokumentiert'
      else 'anzahl_teilbestrahlungen_dokumen'
    end teilbestrahlungen
  from gtds.auswertung_diz
  group by teilbestrahlungen
    union 
  select 
    count(patienten_id),
    case 
      when teil_bestr_beginn isnull then 'teil_bestr_beginn_nicht_dokumentiert'
      else 'teil_bestr_beginn_dokumentiert'
    end teilbestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_teilbestrahlungen > 0
  group by teilbestrahlungen
    union 
  select 
    count(patienten_id),
    case 
      when strahlenart isnull then 'strahlenart_nicht_dokumentiert'
      else 'strahlenart_dokumentiert'
    end teilbestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_teilbestrahlungen > 0
  group by teilbestrahlungen 
    union 
  select 
    count(patienten_id),
    case 
      when referenz isnull then 'referenz_nicht_dokumentiert'
      else 'referenz_dokumentiert'
    end teilbestrahlungen 
  from gtds.auswertung_diz 
  where anzahl_teilbestrahlungen > 0
  group by teilbestrahlungen 
  order by teilbestrahlungen
;

-- Zielgebiete
create or replace view gtds.dqa_zielgebiete
as
  select 
    count(patienten_id) quantity,
    case 
      when anzahl_zielgebiete isnull then 'anzahl_zielgebiete_nicht_dokumientiert'
      else 'anzahl_zielgebiete_dokumentiert'
    end zielgebiete
  from gtds.auswertung_diz
  where anzahl_teilbestrahlungen > 0
  group by zielgebiete
    union 
  select 
    count(patienten_id) quantity,
    case 
      when zielgebiet1 isnull then 'zielgebiet1_nicht_dokumientiert'
      else 'zielgebiet1_dokumentiert'
    end zielgebiete
  from gtds.auswertung_diz
  where anzahl_teilbestrahlungen > 0
  group by zielgebiete
    union
  select 
    count(patienten_id) quantity,
    case 
      when zielgebiet2 isnull then 'zielgebiet2_nicht_dokumientiert'
      else 'zielgebiet2_dokumentiert'
    end zielgebiete
  from gtds.auswertung_diz
  where anzahl_zielgebiete > 1
  group by zielgebiete
  order by zielgebiete
;


-- Applikation
create or replace view gtds.dqa_applikation
as
  select
    count(patienten_id) quantity,
    case
      when applikationsart isnull then 'applikationsart_nicht_dokumentiert'
      else 'applikationsart_dokumentiert'
    end applikation
  from gtds.auswertung_diz
  where anzahl_teilbestrahlungen > 0
  group by applikation
    union 
  select  
    count(patienten_id),
    case 
      when applikationstechnik isnull then 'applikationstechnik_nicht_dokumentiert'
      else 'applikationstechnik_dokumentiert'
    end applikation 
  from gtds.auswertung_diz
  where anzahl_teilbestrahlungen > 0
  group by applikation 
    union 
  select
    count(patienten_id) quantity,
    case 
      when gesamtdosis isnull then 'gesamtdosis_nicht_dokumentiert'
      else 'gesamtdosis_dokumentiert'
    end applikation 
  from gtds.auswertung_diz
  where anzahl_teilbestrahlungen > 0
  group by applikation
    union 
  select
    count(patienten_id),
    case 
      when gy_gbq isnull then 'gy_gbq_nicht_dokumentiert'
      else 'gy_gbq_dokumentiert'
    end applikation 
  from gtds.auswertung_diz
  where anzahl_teilbestrahlungen > 0
  group by applikation
  order by applikation
;


-- Sonstigetherapie
create or replace view gtds.dqa_sonstigetherapie
as
  select 
    count(patienten_id) quantity,
    case 
      when sonstigetherapie isnull then 'sonstigetherapie_nicht_dokumentiert'
      else 'sonstigetherapie_dokumentiert'
    end sonstigetherapie_info
    from gtds.auswertung_diz
    group by sonstigetherapie_info 
;
 
 
-- Erste R Klassifikation
create or replace view gtds.dqa_r_klassifikation
as
  select 
    count(patienten_id) quantity,
    case 
      when erste_r_klassifikation isnull then 'erste_r_klassifikation_nicht_dokumentiert'
      else 'erste_r_klassifikation_dokumentiert'
    end r_klassifikation
  from gtds.auswertung_diz
  where anzahl_r_klassifikationen not like '0'
  group by r_klassifikation
    union 
  select 
    count(patienten_id) quantity,
    case 
      when letzte_r_klassifikation isnull then 'letzte_r_klassifikation_nicht_dokumentiert'
      else 'letzte_r_klassifikation_dokumentiert'
    end r_klassifikation
  from gtds.auswertung_diz
  where anzahl_r_klassifikationen not like '0'
  group by r_klassifikation
    union 
  select 
    count(patienten_id) quantity,
    case 
      when anzahl_r_klassifikationen isnull then 'anzahl_r_klassifikationen_nicht_dokumentiert'
      else 'anzahl_r_klassifikationen_dokumentiert'
    end r_klassifikation
  from gtds.auswertung_diz
  group by r_klassifikation
;  
 
-- Erste R Klassifikation Klassen
create or replace view gtds.dqa_erste_r_klassifikation
as
 select 
    count(patienten_id) quantity ,
    erste_r_klassifikation 
  from gtds.auswertung_diz
  where erste_r_klassifikation notnull
  group by erste_r_klassifikation
  order by quantity desc
;

-- Letzte R Klassifikation Klassen
create or replace view gtds.dqa_letzte_r_klassifikation
as
 select 
    count(patienten_id) quantity ,
    letzte_r_klassifikation 
  from gtds.auswertung_diz
  where letzte_r_klassifikation notnull
  group by letzte_r_klassifikation
  order by quantity desc
;
-- Erste Rezidiv
create or replace view gtds.dqa_rezidiv
as
  select 
    count(patienten_id) quantity,
    case 
      when erstes_rezidiv isnull then 'erstes_rezidiv_nicht_dokumentiert'
      else 'erstes_rezidiv_dokumentiert'
    end rezidiv
  from gtds.auswertung_diz
  group by rezidiv
    union 
  select 
    count(patienten_id) quantity,
    case 
      when datum_erstes_rezidiv isnull then 'datum_erstes_rezidiv_nicht_dokumentiert'
      else 'datum_erstes_rezidiv_dokumentiert'
    end rezidiv
  from gtds.auswertung_diz
  group by rezidiv
    union 
  select 
    count(patienten_id),
    erstes_rezidiv rezidiv
  from gtds.auswertung_diz
  where erstes_rezidiv notnull
  group by rezidiv 
  order by quantity desc
;

-- Nachsorgen
create or replace view gtds.dqa_nachsorgen
as
  select 
    count(patienten_id) quantity,
    case 
      when anzahl_nachsorgen isnull then 'anzahl_nachsorgen_nicht_dokumentiert'
      else 'anzahl_nachsorgen_dokumentiert'
    end nachsorgen
  from gtds.auswertung_diz
  group by nachsorgen
    union 
  select 
    count(patienten_id),
    case 
      when beginn_nachsorge isnull then 'beginn_nachsorge_nicht_dokumentiert'
      else 'beginn_nachsorge_dokumentiert'
    end nachsorgen 
  from gtds.auswertung_diz 
  where anzahl_nachsorgen > 0
  group by nachsorgen 
    union 
  select 
    count(patienten_id),
    'anzahl_nachsorgen_plus_0'
  from gtds.auswertung_diz
  where anzahl_nachsorgen > 0
    union 
  select 
    count(patienten_id),
    case 
      when letzte_na_ohne_progression isnull then 'letzte_na_ohne_progression_nicht_dokumentiert'
      else 'letzte_na_ohne_progression_dokumentiert'
    end nachsorgen 
  from gtds.auswertung_diz 
  where anzahl_nachsorgen > 0
  group by nachsorgen 
  order by nachsorgen 
;

-- Metastasen
create or replace view gtds.dqa_metastasen
as
  select
    count(patienten_id) quantity,
    case 
      when anzahl_metastasen isnull then 'anzah_metastasen_nicht_dokumentiert'
      else 'anzahl_metastasen_dokumentiert'
    end metastasen
  from gtds.auswertung_diz
  group by metastasen
    union 
  select 
    count(patienten_id),
    case 
      when datum_erste_metastase isnull then 'datum_erste_metastase_nicht_dokumentiert'
      else 'datum_erste_metastase_dokumentiert'
    end metastasen 
  from gtds.auswertung_diz
  where anzahl_metastasen > 0
  group by metastasen
    union
  select 
    count(patienten_id),
    case 
      when metastase1 isnull then 'metastase1_nicht_dokumentiert'
      else 'metastase1_dokumentiert'
    end metastasen 
  from gtds.auswertung_diz 
  where anzahl_metastasen > 0
  group by metastasen 
    union 
  select 
    count(patienten_id),
    case 
      when metastase2 isnull then 'metastase2_nicht_dokumentiert'
      else 'metastase2_dokumentiert'
    end metastasen 
  from gtds.auswertung_diz 
  where anzahl_metastasen > 1
  group by metastasen
    union 
  select 
    count(patienten_id),
    case 
      when alle_metastasen isnull then 'alle_metastasen_nicht_dokumentiert'
      else 'alle_metastasen_dokumentiert'
    end metastasen 
  from gtds.auswertung_diz 
  where anzahl_metastasen > 0
  group by metastasen
  order by metastasen
;

-- Folgeerkrankungen
create or replace view gtds.dqa_folgeerkrankungen
as
  select 
    count(patienten_id) quantity,
    case 
      when anzahl_folgeerkrankungen isnull then 'anzahl_folgeerkrankungen_nicht_dokumentiert'
      else 'anzahl_folgeerkrankungen_dokumentiert'
    end folgeerkrankungen
  from gtds.auswertung_diz
  group by folgeerkrankungen
    union 
  select 
    count(patienten_id),
    case 
      when folgeerkrankung1 isnull then 'folgeerkrankung1_nicht_dokumentiert'
      else 'folgeerkrankung1_dokumentiert'
    end folgeerkrankungen 
  from gtds.auswertung_diz 
  where anzahl_folgeerkrankungen > 0
  group by folgeerkrankungen 
    union 
  select 
    count(patienten_id),
    case 
      when folgeerkrankung2 isnull then 'folgeerkrankung2_nicht_dokumentiert'
      else 'folgeerkrankung2_dokumentiert'
    end folgeerkrankungen 
  from gtds.auswertung_diz 
  where anzahl_folgeerkrankungen > 1
  group by folgeerkrankungen
    union 
  select 
    count(patienten_id),
    case 
      when alle_folgeerkrankungen isnull then 'alle_folgeerkrankungen_nicht_dokumentiert'
      else 'alle_folgeerkrankungen_dokumentiert'
    end folgeerkrankungen 
  from gtds.auswertung_diz 
  where anzahl_folgeerkrankungen > 0
  group by folgeerkrankungen
  order by folgeerkrankungen
;

-- Letzte Info
create or replace view gtds.dqa_letzte_info
as
  select
    count(patienten_id) quantity,
    case 
      when letzte_info_datenart isnull then 'letzte_info_datenart_nicht_dokumentiert'
      else 'letzte_info_datenart_dokumentiet'
    end letzte_info
  from gtds.auswertung_diz
  group by letzte_info
    union 
  select 
    count(patienten_id),
    'letzte_info_datenart:'|| letzte_info_datenart
  from gtds.auswertung_diz 
  where letzte_info_datenart notnull 
  group by letzte_info_datenart
    union 
  select 
    count(patienten_id),
    case 
      when letzte_info_datum isnull then 'letzte_info_datum_nicht_dokumentiert'
      else 'letzte_info_datum_dokumentiert'
    end letzte_info 
  from gtds.auswertung_diz 
  group by letzte_info
    union 
  select 
    count(patienten_id),
    case 
      when letzte_info_lfdnr isnull then 'letzte_info_lfdnr'
      else 'letzte_info_lfdnr_dokumentiert'
    end letzte_info
  from gtds.auswertung_diz 
  group by letzte_info
  order by quantity desc
;

--Register
create or replace view gtds.dqa_register
as
  select
    count(patienten_id) quantity,
    case 
      when register isnull then 'register_nicht_dokumentiert'
      else 'register_dokumentiert'
    end register_doku
  from gtds.auswertung_diz
  group by register_doku
    union 
  select 
    count(patienten_id),
    'register:'||register register_doku 
  from gtds.auswertung_diz
  group by register_doku
  order by quantity
;

--Ortskennzahl
create or replace view gtds.dqa_ortskennzahl
as
  select 
    count(patienten_id) quantity,
    case 
      when ortskennzahl isnull then 'ortskennzahl_nicht_dokumentiert'
      else 'ortskennzahl_dokumentiert'
    end ortskennzahl_info
  from gtds.auswertung_diz
  group by ortskennzahl_info 
;

--Tumorfolgenummer
create or replace view gtds.dqa_tumorfolgenummer
as
  select 
    count(patienten_id) quantity,
    case 
      when tumorfolgenummer isnull then 'tumorfolgenummer_nicht_dokumentiert'
      else 'tumorfolgenummer_dokumentiert'
    end tumorfolgenummer_info
  from gtds.auswertung_diz
  group by tumorfolgenummer_info 
;


-- Tumorfreiheit
create or replace view gtds.dqa_tumorfreiheit
as
  select 
    count(patienten_id) quantity,
    case 
      when zeitpunkt_tumorfreiheit isnull then 'zeitpunkt_tumorfreiheit_nicht_dokumentiert'
      else 'zeitpunkt_tumorfreiheit_dokumentiert'
    end tumortfreiheit
  from gtds.auswertung_diz
  group by tumortfreiheit
    union 
  select 
    count(patienten_id) quantity,
    case 
      when tumorfreiheit_verlauf isnull then 'tumorfreiheit_verlauf_nicht_dokumentiert'
      else 'tumorfreiheit_verlauf_dokumentiert'
    end tumortfreiheit
  from gtds.auswertung_diz
  group by tumortfreiheit
;

-- Begleiterkrankungen
create or replace view gtds.dqa_begleiterkrankungen
as
  select 
    count(patienten_id) quantity,
    case 
      when alle_begleiterkrankungen isnull then 'alle_begleiterkrankungen_nicht_dokumentiert'
      else 'alle_begleiterkrankungen_dokumentiert'
    end begleiterkrankungen
  from gtds.auswertung_diz
  group by begleiterkrankungen
;

-- Vorerkrankungen
create or replace view gtds.dqa_vorerkrankungen
as
  select 
    count(patienten_id) quantity,
    case 
      when alle_vorerkrankungen isnull then 'alle_vorerkrankungen_nicht_dokumentiert'
      else 'alle_vorerkrankungen_dokumentiert'
    end vorerkrankungen
  from gtds.auswertung_diz
  group by vorerkrankungen
;

-- Status
create or replace view gtds.dqa_status
as
  select 
    count(patienten_id) quantity,
    case 
      when letzter_status_datenart isnull then 'letzter_status_datenart_nicht_dokumentiert'
      else 'letzter_status_datenart_dokumentiert'
    end status
  from gtds.auswertung_diz
  group by status
    union 
  select 
    count(patienten_id),
    case 
      when letzter_status_datum isnull then 'letzter_status_datum_nicht_dokumentiert'
      else 'letzter_status_datum_dokumentiert'
    end status
  from gtds.auswertung_diz
  group by status
    union 
  select 
    count(patienten_id),
    case 
      when letzte_status_lfdnr isnull then 'letzte_status_lfdnf_nicht_dokumentiert'
      else 'letzte_status_lfdnr_dokumentiert'
    end status
  from gtds.auswertung_diz
  group by status
    union
  select 
    count(patienten_id),
    case 
      when letzter_status isnull then 'letzter_status_nicht_dokumentiert'
      else 'letzter_status_dokumentiert'
    end status
  from gtds.auswertung_diz
  group by status
  order by status 
;


-- Lok rezidiv
create or replace view gtds.dqa_lod_rezidiv
as
  select 
    count(patienten_id) quantity,
    case 
      when erstes_lok_rezidivdatum isnull then 'erstes_lok_rezidivdatum_nicht_dokumentiert'
      else 'erstes_lok_rezidivdatum_dokumentiert'
    end lok_rezidiv
  from gtds.auswertung_diz
  group by lok_rezidiv
    union
  select 
    count(patienten_id),
    case 
      when erstes_lok_rezidivart isnull then 'erstes_lok_rezidivart_nicht_dokumentiert'
      else 'erstes_lok_rezidivart_dokumentiert'
    end lok_rezidiv
  from gtds.auswertung_diz
  group by lok_rezidiv
    union 
  select 
    count(patienten_id) quantity,
    case 
      when erstes_lok_rezidivverlauf isnull then 'erstes_lok_rezidivverlauf_nicht_dokumentiert'
      else 'erstes_lok_rezidivverlauf_dokumentiert'
    end lok_rezidiv
  from gtds.auswertung_diz
  group by lok_rezidiv
  order by lok_rezidiv 
;

-- Lok rezidiv art
create or replace view gtds.dqa_lok_rezidiv_art
as 
  select 
    count(patienten_id) quantity, 
    erstes_lok_rezidivart 
  from gtds.auswertung_diz
  where erstes_lok_rezidivart notnull
  group by erstes_lok_rezidivart
  order by quantity
;

-- Lok rezidiv verlauf
create or replace view gtds.dqa_lok_rezidivverlauf
as
  select 
    count(patienten_id) quantity,
    erstes_lok_rezidivverlauf 
  from gtds.auswertung_diz
  where erstes_lok_rezidivverlauf notnull
  group by erstes_lok_rezidivverlauf 
  order by quantity
;

-- KKR_einwilligung
create or replace view gtds.dqa_kkr_einwilliging
as
  select
    count(patienten_id) quantity,
    case 
      when kkr_einwilligung isnull then 'kkr_einwillung_nicht_dokumentiert'
      else 'kkr_einwilligung_dokumentiert'
    end kkr_einwilligung_doku 
  from gtds.auswertung_diz
  group by kkr_einwilligung_doku
    union 
  select 
    count(patienten_id),
    kkr_einwilligung 
  from gtds.auswertung_diz 
  where kkr_einwilligung notnull 
  group by kkr_einwilligung
  order by quantity
;

-- Behandlungsanlass
create or replace view gtds.dqa_behandlungsanlass
as
  select
    count(patienten_id) quantity,
    case 
      when behandlungsanlass isnull then 'behandlungsanlass_nicht_dokumentiert'
      else 'behandlungsanlass_dokumentiert'
    end behandlungsanlass_doku
  from gtds.auswertung_diz
  group by behandlungsanlass_doku
    union 
  select 
    count(patienten_id),
    behandlungsanlass 
  from gtds.auswertung_diz 
  where behandlungsanlass notnull
  group by behandlungsanlass
  order by quantity
;

-- Erfassungsanlass
create or replace view gtds.dqa_erfassungsanlass
as
  select
    count(patienten_id) quantity,
    case 
      when erfassungsanlass isnull then 'erfassungsanlass_nicht_dokumentiert'
      else 'erfassungsanlass_dokumentiert'
    end erfassungsanlass_doku
  from gtds.auswertung_diz
  group by erfassungsanlass_doku
    union 
  select 
    count(patienten_id),
    erfassungsanlass
  from gtds.auswertung_diz
  where erfassungsanlass notnull
  group by erfassungsanlass 
  order by quantity
;

-- Zentkenn
create or replace view gtds.dqa_zentkenn_doku
as
  select
    count(patienten_id) quantity,
    case 
      when zentkenn isnull then 'zentkenn_nicht_dokumentiert'
      else 'zentkenn_dokumentiert'
    end zentkenn_doku
  from gtds.auswertung_diz
  group by zentkenn_doku
;

-- Zenzkenn
create or replace view gtds.dqa_zentkenn
as
  select 
    count(patienten_id) quantity,
    zentkenn 
  from gtds.auswertung_diz
  where zentkenn notnull 
  group by zentkenn 
  order by quantity
;

-- Primfall
create or replace view gtds.dqa_primfall
as
  select 
    count(patienten_id) quantity,
    case 
      when primfall isnull then 'primfall_nicht_dokumentiert'
      else 'primfall_dokumentiert'
    end primfall_doku
  from gtds.auswertung_diz
  group by primfall_doku
    union 
  select 
    count(patienten_id),
    primfall
  from gtds.auswertung_diz 
  where primfall notnull 
  group by primfall 
  order by quantity
;


--Transformations
create or replace view gtds.dqa_transformation
as
  select
    count(patienten_id) quantity,
    case 
      when transformation_verlauf isnull then 'transformation_verlauf_nicht_dokumentiert'
      else 'transformation_verlauf_dokumentiert'
    end transformation
  from gtds.auswertung_diz 
  group by transformation
    union 
  select
    count(patienten_id) quantity,
    case 
      when transformation_datum isnull then 'transformation_datum_nicht_dokumentiert'
      else 'transformation_datum_dokumentiert'
    end transformation
  from gtds.auswertung_diz 
  group by transformation 
    union 
  select
    count(patienten_id) quantity,
    case 
      when transformation_histo_code isnull then 'transformation_histo_code_nicht_dokumentiert'
      else 'transformation_histo_code_dokumentiert'
    end transformation
  from gtds.auswertung_diz 
  group by transformation
    union 
  select
    count(patienten_id) quantity,
    case 
      when transformation_histo_auflage isnull then 'transformation_histo_auflage_nicht_dokumentiert'
      else 'transformation_histo_auflage_dokumentiert'
    end transformation
  from gtds.auswertung_diz 
  group by transformation
  order by transformation
;

-- Transformation Histo Code
create or replace view gtds.dqa_transformation_histo_code
as
  select 
    count(patienten_id) quantity,
    transformation_histo_code 
  from gtds.auswertung_diz
  where transformation_histo_code notnull 
  group by transformation_histo_code 
  order by quantity
;

-- Transformation Histo Auflage
create or replace view gtds.dqa_transformation_histo_auflage
as
  select 
    count(patienten_id) quantity,
    transformation_histo_auflage 
  from gtds.auswertung_diz
  where transformation_histo_auflage notnull 
  group by transformation_histo_auflage 
  order by quantity
;

-- Transformation Verlauf
create or replace view gtds.dqa_transformation_verlauf
as
  select 
    count(patienten_id) quantity,
    transformation_verlauf 
  from gtds.auswertung_diz
  where transformation_verlauf notnull
  group by transformation_verlauf
  order by quantity
;

-- Erste lokale Radikalitaet
create or replace view gtds.dqa_lokale_radikalitaet
as
  select
    count(patienten_id) quantity,
    case 
      when erste_lokale_radikalitaet isnull then 'erste_lokale_radikalitaet_nicht_dokumentiert'
      else 'erste_lokale_radikalitaet_dokumentiert'
    end lokale_radikalitaet
  from gtds.auswertung_diz
  group by lokale_radikalitaet
    union 
 select
    count(patienten_id),
    case 
      when defin_lokale_radikalitaet isnull then 'defin_lokale_radikalitaet_nicht_dokumentiert'
      else 'defin_lokale_radikalitaet_dokumentiert'
    end lokale_radikalitaet
  from gtds.auswertung_diz
  group by lokale_radikalitaet
  order by lokale_radikalitaet 
;


-- Erste lokale radikalitaet
create or replace view gtds.dqa_erste_lokale_radikalitaet
as
  select
    count(patienten_id) quantity,
    erste_lokale_radikalitaet
  from gtds.auswertung_diz
  where erste_lokale_radikalitaet notnull 
  group by erste_lokale_radikalitaet
  order by quantity
;

-- Datum erste Progression
create or replace view gtds.dqa_datum_erste_progression
as
  select
    count(patienten_id) quantity,
    case 
      when datum_erste_progression isnull then 'datum_erste_progression_nicht_dokumentiert'
      else 'datum_erste_progression_dokumentiert'
    end datum_erste_progression_doku
  from gtds.auswertung_diz
  group by datum_erste_progression_doku
  order by datum_erste_progression_doku
;

--Diagsich_hoechste
create or replace view gtds.dqa_diagsich_hoechste
as
  select
    count(patienten_id) quantity,
    case 
      when diagsich_hoechste isnull then 'diagsich_hoechste_nicht_dokumentiert'
      else 'diagsich_hoechste_dokumentiert'
    end diagsich_hoechste_doku
  from gtds.auswertung_diz
  group by diagsich_hoechste_doku 
  order by quantity
;

-- Letzter Abschluss
create or replace view gtds.dqa_abschluss
as
  select
    count(patienten_id) quantity,
    case 
      when letzter_abschluss_lfdnr isnull then 'letzter_abschluss_lfdnf_nicht_dokumentiert'
      else 'letzter_abschluss_lfdnr_dokumentiert'
    end letzter_abschluss
  from gtds.auswertung_diz
  group by letzter_abschluss
    union 
  select
    count(patienten_id),
    case 
      when letzter_abschluss_datum isnull then 'letzter_abschluss_datum_nicht_dokumentiert'
      else 'letzter_abschluss_datum_dokumentiert'
    end letzter_abschluss
  from gtds.auswertung_diz
  group by letzter_abschluss
    union 
  select
    count(patienten_id),
    case 
      when letzter_abschluss_grund isnull then 'letzter_abschluss_grund_nicht_dokumentiert'
      else 'letzter_abschluss_grund_dokumentiert'
    end letzter_abschluss
  from gtds.auswertung_diz
  group by letzter_abschluss
  order by letzter_abschluss
;

-- Letzter Abschluss Grund
create or replace view gtds.dqa_letzter_abschluss_grund
as
  select
    count(patienten_id) quantity,
    letzter_abschluss_grund 
  from gtds.auswertung_diz
  where letzter_abschluss_grund notnull
  group by letzter_abschluss_grund
  order by quantity
;

-- Letzter Abschluss Lfdnr
create or replace view gtds.dqa_letzter_abschluss_lfdnr
as
  select
    count(patienten_id) quantity,
    letzter_abschluss_lfdnr 
  from gtds.auswertung_diz
  where letzter_abschluss_lfdnr notnull
  group by letzter_abschluss_lfdnr 
  order by quantity
;

-- ICD10
create or replace view gtds.dqa_icd10
as
  select 
    count(patienten_id) quantity,
    icd10 
  from gtds.auswertung_diz
 where icd10 notnull
 group by icd10 
 order by quantity desc 
;


-- IARC Flag
create or replace view gtds.dqa_iarc_flag
as 
  select 
    count(patienten_id) quantity,
    case 
      when iarc_flag isnull then 'iarc_flag_nicht_dokumentiert'
      else 'iarc_flag_dokumentiert'
    end iarc_flag_doku
  from gtds.auswertung_diz
  group by iarc_flag_doku
;

-- Met
create or replace view gtds.dqa_met
as
  select 
    count(patienten_id) quantity,
    case 
      when primmetdatum isnull then 'primmetdatum_nicht_dokumentiert'
      else 'primmetdatum_dokumentiert'
    end met 
  from gtds.auswertung_diz
  group by met
    union 
  select 
    count(patienten_id),
    case 
      when primmetloks isnull then 'primmetloks_nicht_dokumentiert'
      else 'primmetloks_dokumentiert'
    end met 
  from gtds.auswertung_diz
  group by met
    union 
  select 
    count(patienten_id),
    case 
      when sekmetdatum isnull then 'sekmetdatum_nicht_dokumentiert'
      else 'sekmetdatum_dokumentiert'
    end met 
  from gtds.auswertung_diz
  group by met
    union 
  select 
    count(patienten_id),
    case 
      when sekmetloks isnull then 'sekmetloks_nicht_dokumentiert'
      else 'sekmetloks_dokumentiert'
    end met 
  from gtds.auswertung_diz
  group by met
  order by met
;


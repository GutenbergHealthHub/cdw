-- problems in table gtds auswertung_diz

create or replace view gtds.problems
  as
    select 
      'datum_der_auswertung' problem, 
      'Datum der Auswertung liegt vor dem heutigen Datum'problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where datum_der_auswertung > now()
      union
    select 
      'patienten_id' problem,
      'ID der Patient ist leer' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where patienten_id isnull or patienten_id like ''
      union
    select 
      'tumor_id' problem,
      'Keine Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where tumor_id isnull
      union
    select 
      'anzahl_tumoren' problem,
      'Wert: '||anzahl_tumoren||' - Keine oder ungültige Anzahl an Tumoren' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_tumoren < 1
      union
    select 
      'geburtsdatum' problem, 
      'Geburtsdatum liegt vor der Auswertung oder Sterbedatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where geburtsdatum > datum_der_auswertung or geburtsdatum > sterbedatum 
      union
    select 
      'sterbedatum' problem, 
      'Sterbedatum liegt nach der Auswertung oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sterbedatum > datum_der_auswertung or sterbedatum < geburtsdatum  
      union
    select 
      'sterbedatum_exakt' problem, 
      'Wert: '||ad.sterbedatum_exakt||'- Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.sterbedatum_exakt se
      on ad.sterbedatum_exakt = se.sourceid 
    where se.sourceid isnull and ad.sterbedatum_exakt notnull
   union
    select 
      'geschlecht' problem,
      'Wert: '||geschlecht||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.gender g 
      on ad.geschlecht = g.sourceid 
    where g.sourceid isnull and ad.geschlecht notnull
      union
    select 
      'plz' problem, 
      'Wert: '||plz||' - Ungültige (Format)Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where plz !~'^\d{2}000'
      union
    select 
      'tumortod' problem, 
      'Wert: '||ad.tumortod||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.tumortod t 
      on t.sourceid = ad.tumortod 
    where t.sourceid isnull and ad.tumortod notnull
      union
    select 
      'autopsie' problem, 
      'Wert: '||ad.autopsie||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.autopsie a 
      on a.sourceid = ad.autopsie 
    where a.sourceid isnull and ad.autopsie notnull
      union
    select 
      'aufnahmedatum' problem,
      'Aufnahmedatum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where aufnahmedatum < geburtsdatum or aufnahmedatum > datum_der_auswertung or aufnahmedatum > sterbedatum 
      union
    select 
      'diagnosedatum' problem,
      'Diagnosedatum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where diagnosedatum < geburtsdatum or diagnosedatum > sterbedatum or diagnosedatum > datum_der_auswertung 
      union
    select
      'diagnose_abteilung' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_abteilungen' problem_beschreibung,      
      *
    from gtds.auswertung_diz
    where diagnose_abteilung isnull and anzahl_abteilungen > 0
      union
    select 
      'abteilung1' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_abteilungen' problem_beschreibung, 
      *
    from gtds.auswertung_diz
    where abteilung1 isnull and anzahl_abteilungen > 0 and abteilung2 isnull and abteilung3 isnull
      union
    select 
      'abteilung2' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_abteilungen' problem_beschreibung, 
      *
    from gtds.auswertung_diz
    where abteilung2 isnull and anzahl_abteilungen > 0 and abteilung1 isnull and abteilung3 isnull
      union 
    select 
      'abteilung3' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_abteilungen' problem_beschreibung, 
      *
    from gtds.auswertung_diz
    where abteilung3 isnull and anzahl_abteilungen > 0 and abteilung1 isnull and abteilung2 isnull
      union
    select 
      'anzahl_abteilungen' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalten abteilung(1,2,3)' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where anzahl_abteilungen < 1 and (abteilung1 isnull and abteilung2 isnull and abteilung3 isnull)
      union
    select 
      'anzahl_aerzte' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalten hausarzt und arzt1' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where anzahl_aerzte < 0 and (hausarzt isnull and arzt1 isnull)
      union 
    select 
      'anzahl_aufenthalte' problem,
      'Wert: '||anzahl_aufenthalte||' - Ungültig Angabe' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where anzahl_aufenthalte < 1
      union
    select 
      'gesamtdauer_aufenthalte' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_aufenthalte' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where gesamtdauer_aufenthalte isnull and anzahl_aufenthalte > 1
      union
    select 
      'icd10' problem, 
      'Wert: '||icd10||' - Keine oder ungültig Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.icd i 
      on ad.icd10 = i.codenormal 
    where i.codenormal isnull or ad.icd10 isnull
      union
    select 
      'lokalisation' problem, 
      'Keine Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad 
    where ad.lokalisation isnull
      union
    select 
      'lok_seite' problem, 
      'Wert: '||ad.lok_seite||' - Ungültig Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.lok_seite ls 
      on ls.sourceid = ad.lok_seite 
    where ls.sourceid isnull and lokalisation notnull
      union
    select 
      'lok_auflage' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte lokalisation' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where lok_auflage isnull and lokalisation notnull
      union
    select 
      'lok_haupt_neben' problem,
      'Wert: '||ad.lok_haupt_neben||' - Ungültig Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.lok_haupt_neben lhn 
      on lhn.sourceid = ad.lok_haupt_neben
    where lhn.sourceid isnull and ad.lok_haupt_neben notnull
      union
    select 
      'anzahl_histologien' problem, 
      'Wert: '||anzahl_histologien||' - Ungültig Angabe' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where anzahl_histologien < 0
      union
    select 
      'histologie' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_histologien' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where histologie isnull and anzahl_histologien > 0
      union
    select 
      'histo_lfdnr' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_histologien' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where histo_lfdnr isnull and anzahl_histologien > 0
      union
    select 
      'histo_auflage' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_histologien' problem_beschreibung, 
      * 
    from gtds.auswertung_diz 
    where histo_auflage isnull and anzahl_histologien > 0
      union
    select 
      'histo_haupt_neben' problem, 
      'Wert: '||ad.histo_haupt_neben||' - Ungültige Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.histo_haupt_neben hhn 
      on hhn.sourceid = ad.histo_haupt_neben
    where hhn.sourceid isnull and ad.histo_haupt_neben notnull
      union
    select 
      'histo_diagnose' problem, 
     'Wert: '||ad.histo_diagnose|| ' - Ungültige Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.histo_diagnose hd 
      on hd.sourceid = ad.histo_diagnose 
    where ad.histo_diagnose notnull and hd.sourceid isnull
      union
    select 
      'histo_herkunft' problem,
      'Wert: '||ad.histo_herkunft||' - Ungültige Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.herkunft hh 
      on hh.sourceid = ad.histo_herkunft 
    where ad.histo_herkunft notnull and hh.sourceid isnull
      union
    select 
      'histo_grading' problem, 
      'Wert: '||ad.histo_grading||' - Ungültige Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.histo_grading hg 
      on hg.sourceid = ad.histo_grading 
    where ad.histo_grading notnull and hg.sourceid isnull
      union
    select 
      'klin_tnm_herkunft' problem, 
      'Wert: '||ad.klin_tnm_herkunft||' - Ungültige Angabe' problem_beschreibung, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.klin_tnm_herkunft 
    where (ad.klin_tnm_herkunft notnull and ad.klin_tnm_herkunft not like 'O') and h.sourceid isnull 
      union
    select 
      'klin_tnm_datum' problem, 
      'klin_tnm_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_tnm_datum > sterbedatum or klin_tnm_datum > datum_der_auswertung or klin_tnm_datum < geburtsdatum 
      union
    select 
      'p_tnm_herkunft' problem, 
      'Wert:'||p_tnm_herkunft||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.p_tnm_herkunft 
    where (ad.p_tnm_herkunft notnull and ad.p_tnm_herkunft not like 'O') and h.sourceid isnull
      union
    select 
      'p_tnm_datum' problem, 
      'p_tnm_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_tnm_datum > sterbedatum or p_tnm_datum > datum_der_auswertung or p_tnm_datum < geburtsdatum 
      union    
    select 
      'ann_arbor_datum' problem, 
      'ann_arbor_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where ann_arbor_datum > sterbedatum or ann_arbor_datum > datum_der_auswertung or ann_arbor_datum < geburtsdatum 
      union
    select 
      'ann_arbor_herkunft' problem, 
      'Wert: '||ad.ann_arbor_herkunft||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.ann_arbor_herkunft 
    where ad.ann_arbor_herkunft notnull and ad.ann_arbor_herkunft not like 'O' and h.sourceid isnull
      union
    select 
      'ann_arbor_stadium' problem, 
      'Wert: '||ad.ann_arbor_stadium||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.ann_arbor_stadium aas 
      on aas.sourceid = ad.ann_arbor_stadium 
    where ad.ann_arbor_stadium notnull and aas.sourceid isnull
      union
    select 
      'ann_arbor_allgemein' problem, 
      'Wert: '||ad.ann_arbor_allgemein||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.ann_arbor_allgemein aaa 
      on aaa.sourceid = ad.ann_arbor_allgemein 
    where ad.ann_arbor_allgemein notnull and aaa.sourceid isnull
      union
    select 
      'anzahl_sonstige' problem, 
      'Wert: '||anzahl_sonstige||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_sonstige < 0
      union
    select 
      'sonstige_name' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_sonstige' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sonstige_name isnull and anzahl_sonstige > 0
      union
    select 
      'sonstige_id' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_sonstige' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sonstige_id isnull and anzahl_sonstige > 0
      union
    select 
      'sonstige_lfdnr' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_sonstige' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sonstige_lfdnr isnull and anzahl_sonstige > 0
      union
    select 
      'sonstige_herkunft' problem, 
      'Wert: '||ad.sonstige_herkunft||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.sonstige_herkunft 
    where ad.sonstige_herkunft notnull and sonstige_herkunft not like 'O' and h.sourceid isnull
      union
    select 
      'sonstige_datum' problem, 
      'sonstige_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sonstige_datum > sterbedatum or sonstige_datum > datum_der_auswertung or sonstige_datum < geburtsdatum 
      union
    select 
      'sonstige_stadium' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_sonstige' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sonstige_stadium isnull and anzahl_sonstige > 0
      union
    select 
      'therapieebeginn' problem, 
      'Therapieebeginn liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where therapieebeginn > sterbedatum or therapieebeginn > datum_der_auswertung or therapieebeginn < geburtsdatum 
      union
    select 
      'primaertherapie' problem, 
      'Wert: '||primaertherapie||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where primaertherapie notnull and primaertherapie !~'CHEMO|OP|BESTR|HORMON|IM|KMT|SO|ZS \(\w\d\)\;'
      union
    select 
      'anzahl_operationen' problem, 
      'Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_operationen < 0
      union
    select 
      'op_nummer' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_operationen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where op_nummer isnull and anzahl_operationen > 0
      union
    select 
      'op_datum' problem,
      'Datum der Operation liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where (op_datum isnull and anzahl_operationen > 0) or (op_datum > sterbedatum or op_datum > datum_der_auswertung or op_datum < geburtsdatum) 
      union
    select 
      'op_abteilung' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_operationen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where op_abteilung isnull and anzahl_operationen > 0
      union
    select 
      'op_bezeichnung' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_operationen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where op_bezeichnung isnull and anzahl_operationen > 0 
      union
    select 
      'op_schluessel' problem, 
      'Wert: '||ad.op_schluessel||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.ops o
      on ad.op_schluessel = o.code 
    where op_schluessel notnull and anzahl_operationen > 0 and o.code isnull and op_schluessel not like ''
      union
    select 
      'op_schluessel_auflage' problem, 
      'Keine oder ungültige Angabe, überprüfen Sie auch die Spalte op_schluessel' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where op_schluessel notnull and abs((op_schluessel_auflage::integer + 2000) - date_part('year', op_datum)::integer) > 1
      union
    select 
      'anzahl_innere' problem,
      'Wert: '||anzahl_innere||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_innere < 0
      union
    select 
      'innere_nummer' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_innere' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where innere_nummer isnull and anzahl_innere > 0
      union
    select 
      'innere_beginn' problem,
      'innere_beginn liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where innere_beginn > sterbedatum or innere_beginn < geburtsdatum or innere_beginn > datum_der_auswertung
      union
    select 
      'innere_abteilung' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_innere' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where innere_abteilung isnull and anzahl_innere > 0
      union
    select 
      'innere_protokoll_id' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_innere' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where innere_protokoll_id isnull and anzahl_innere > 0
      union
    select 
      'innere_anzahl_zyklen' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_innere' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where innere_anzahl_zyklen isnull and anzahl_innere > 0
      union
    select 
      'innere_freitext' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_innere' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where innere_freitext isnull and anzahl_innere > 0
      union
    select 
      'anzahl_bestrahlungen' problem, 
      'Wert: '||anzahl_bestrahlungen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_bestrahlungen < 0
      union
    select 
      'bestrahlung_nummer' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_bestrahlungen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where bestrahlung_nummer isnull and anzahl_bestrahlungen > 0
      union
    select 
      'bestrahlung_datum' problem, 
      'Datum der Bestrahlung liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where bestrahlung_datum < geburtsdatum or bestrahlung_datum > sterbedatum or bestrahlung_datum > datum_der_auswertung
      union
    select 
      'bestrahlung_abteilung' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_bestrahlungen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where bestrahlung_abteilung isnull and anzahl_bestrahlungen > 0
      union
    select 
      'bestrahlung_freitext' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_bestrahlungen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where bestrahlung_freitext isnull and anzahl_bestrahlungen > 0
      union
    select 
      'anzahl_teilbestrahlungen' problem,
      'Wert: '||anzahl_teilbestrahlungen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_teilbestrahlungen < 1
      union
    select 
      'teil_bestr_beginn' problem, 
      'teil_bestr_beginn liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where teil_bestr_beginn > datum_der_auswertung or teil_bestr_beginn > sterbedatum or teil_bestr_beginn < geburtsdatum
      union
    select 
      'anzahl_zielgebiete' problem, 
      'Wert: '||anzahl_zielgebiete||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_zielgebiete < 0
      union
    select 
      'zielgebiet1' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_zielgebiete' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where zielgebiet1 isnull and anzahl_zielgebiete > 0
      union
    select 
      'zielgebiet2' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalten anzahl_zielgebiete und zielgebiet1' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where zielgebiet2 isnull and anzahl_zielgebiete > 1 and zielgebiet1 isnull
      union
    select 
      'applikationsart' problem, 
      'Wert: '||ad.applikationsart||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.applikationsart a 
      on a.sourceid = ad.applikationsart
    where a.sourceid isnull and ad.applikationsart notnull
      union
    select 
      'applikationstechnik' problem,
      'Wert: '||ad.applikationstechnik||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.applikationstechnik a 
      on ad.applikationstechnik = a.sourceid 
    where ad.applikationstechnik notnull and a.sourceid isnull
      union
    select 
      'gesamtdosis' problem,
      'Wert: '||gesamtdosis||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where gesamtdosis !~'^\d+\,*\d*'
      union
    select 
      'gy_gbq' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte gesamtdosis' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where gy_gbq isnull and gesamtdosis notnull
      union
    select 
      'strahlenart' problem, 
      'Wert: '||ad.strahlenart||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.strahlenart s 
      on s.sourceid = ad.strahlenart 
    where ad.strahlenart notnull and s.sourceid isnull
      union
    select 
      'sonstigetherapie' problem,
      'Wert: '||sonstigetherapie||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sonstigetherapie notnull and sonstigetherapie !~'\d{2}\.\d{2}\.\d{2,4}'
      union
    select 
      'erste_r_klassifikation' problem,
      'Wert: '||ad.erste_r_klassifikation||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.r_klassifikation rk 
     on ad.erste_r_klassifikation ~ rk.sourceid
    where rk.sourceid isnull and ad.erste_r_klassifikation notnull
      union
    select 
      'erstes_rezidiv' problem,
      'Wert: '||ad.erstes_rezidiv||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.rezidiv r 
     on ad.erstes_rezidiv ~ r.sourceid
   where r.sourceid isnull and ad.erstes_rezidiv notnull
      union
    select 
      'datum_erstes_rezidiv' problem, 
      'datum_erstes_rezidiv liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where datum_erstes_rezidiv > datum_der_auswertung or datum_erstes_rezidiv < geburtsdatum or datum_erstes_rezidiv > sterbedatum
      union
    select 
      'anzahl_nachsorgen' problem,
      'Wert: '||anzahl_nachsorgen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_nachsorgen < 0
      union
    select 
      'beginn_nachsorge' problem, 
      'beginn_nachsorge liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where beginn_nachsorge < geburtsdatum or beginn_nachsorge > datum_der_auswertung or beginn_nachsorge > sterbedatum
      union
    select 
      'letzte_na_ohne_progression' problem, 
      'letzte_na_ohne_progression liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzte_na_ohne_progression < beginn_nachsorge or letzte_na_ohne_progression > sterbedatum or letzte_na_ohne_progression < geburtsdatum or letzte_na_ohne_progression > datum_der_auswertung 
      union
    select 
      'anzahl_metastasen' problem,
      'Wert: '||anzahl_metastasen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_metastasen < 0
      union
    select 
      'datum_erste_metastase' problem, 
      'datum_erste_metastase liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where datum_erste_metastase < geburtsdatum or datum_erste_metastase > datum_der_auswertung or datum_erste_metastase > sterbedatum
      union
    select 
      'metastase1' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte datum_erste_metastase' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where (datum_erste_metastase notnull and metastase1 isnull) or  (datum_erste_metastase isnull and metastase1 notnull)
      union
    select 
      'metastase2' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte metastase1' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where metastase2 notnull and metastase1 isnull
      union
    select 
      'anzahl_folgeerkrankungen' problem,
      'Wert: '||anzahl_folgeerkrankungen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_folgeerkrankungen < 0
      union
    select 
      'folgeerkrankung1' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_folgeerkrankungen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where folgeerkrankung1 isnull and anzahl_folgeerkrankungen > 0
      union
    select 
      'folgeerkrankung2' problem,
      'Keine Angabe, überprüfen Sie auch die Spalten folgeerkrankung1 und anzahl_folgeerkrankungen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where folgeerkrankung2 notnull and folgeerkrankung1 isnull
      union
    select 
      'letzte_info_datenart' problem, 
      'Wert: '||ad.letzte_info_datenart||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.gtds_datenart gd
      on ad.letzte_info_datenart = gd.datenart 
    where gd.datenart isnull
      union
    select 
      'letzte_info_datum' problem, 
      'letzte_info_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzte_info_datum > sterbedatum or letzte_info_datum > datum_der_auswertung or letzte_info_datum < geburtsdatum
      union
    select 
      'letzte_info_lfdnr' problem, 
      'Keine Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzte_info_lfdnr isnull
      union
    select 
      'op_durchgefuehrt' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte op_datum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where op_durchgefuehrt isnull and op_datum notnull
      union
    select 
      'register' problem, 
      'Wert: '||register||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where register <> 'GI'
      union
    select 
      'op_intention' problem, 
      'Wert: '||ad.op_intention||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.op_intention oi
      on oi.sourceid = ad.op_intention 
    where ad.op_intention notnull and oi.sourceid isnull
      union
    select 
      'klin_tnm_auswertungs_relevant' problem, 
      'Wert: '||klin_tnm_auswertungs_relevant||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_tnm_auswertungs_relevant not in ('J', 'N') and klin_tnm_auswertungs_relevant notnull
      union
    select 
      'p_tnm_auswertungs_relevant' problem, 
      'Wert: '||p_tnm_auswertungs_relevant||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_tnm_auswertungs_relevant not in ('J', 'N') and p_tnm_auswertungs_relevant notnull
      union
    select 
      'diagnose_df_abt_id' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte diagnosedatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where diagnose_df_abt_id isnull and diagnosedatum notnull
      union
    /*select 
      'diagnose_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where diagnose_df_arzt_id isnull and anzahl > 0;
      union*/
    select 
      'op_df_abt_id' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_operationen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where op_df_abt_id isnull and anzahl_operationen > 0
      union
    /*select 
      'op_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where op_df_arzt_id ...
      union*/
    select 
      'innere_df_abt_id' problem, 
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_innere' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where innere_df_abt_id isnull and anzahl_innere > 0    
      union
    /*select 
      'innere_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz where innere_df_arzt_id notnull;
    ;where innere_df_arzt_id ...
      union*/
    select 
      'bestrahlung_df_abt_id' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_bestrahlungen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_bestrahlungen > 0 and bestrahlung_df_abt_id isnull
      union
    /*select 
      'bestrahlung_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where bestrahlung_df_arzt_id ...
      union*/
    select 
      'innere_protokoll_typ' problem, 
      'Wert: '||ad.innere_protokoll_typ||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.protokoll_typ pt 
      on ad.innere_protokoll_typ ~ pt.sourceid
    where pt.sourceid isnull and innere_protokoll_typ notnull
      union
    /*select 
      'ortskennzahl' problem, 
      * 
    from gtds.auswertung_diz 
    where ortskennzahl ...
      union*/
    select 
      'tumorfolgenummer' problem,
      'Wert: '||tumorfolgenummer||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where tumorfolgenummer::int < 0
      union
    /*select 
      'histologie2' problem, 
      * 
    from gtds.auswertung_diz 
    where histologie2 ...
      union
    select 
      'klin_y_symbol' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_y_symbol ...
      union
    select 
      'p_y_symbol' problem, 
      * 
    from gtds.auswertung_diz 
    where p_y_symbol ...
      union*/
    select 
      'ann_arbor_extra' problem, 
      'Wert: '||ad.ann_arbor_extra||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.ann_arbor_extra aae
      on ad.ann_arbor_extra = aae.sourceid
    where aae.sourceid isnull and ad.ann_arbor_extra notnull
      union
    select 
      'sonstige_kuerzel' problem,
      'Keine Angabe, überprüfen Sie auch die Spalte anzahl_sonstige' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sonstige_kuerzel isnull and anzahl_sonstige > 0
      union
    select 
      'therapieende' problem,
      'therapieende liegt vor therapieebeginn' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where therapieende < therapieebeginn
      union
    select 
      'alle_operationen' problem, 
      'Wert: '||alle_operationen||' - Ungültige Angabe, überprüfen Sie auch die Spalte anzahl_operationen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_operationen > 0 and (alle_operationen isnull or alle_operationen !~'\d{2}\.\d{2}\.\d{2}\s*\d{1}-\d*.*\s*\(Auf\.\s*\d{2}\).*')
      union
    select 
      'alle_inneren' problem, 
      'Wert: '||alle_inneren||' - Ungültige Angabe, überprüfen Sie auch die Spalte anzahl_innere' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_innere > 0 and (alle_inneren isnull or alle_inneren !~'\d{2}\.\d{2}\.\d{2}\s+Prot\.\s*\d*\s+Typ\s*\w*\s*\.*')
      union
    select 
      'alle_bestrahlungen' problem, 
      'Wert: '||alle_bestrahlungen||' - Ungültige Angabe, überprüfen Sie auch die Spalte anzahl_bestrahlungen' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_bestrahlungen > 0 and (alle_bestrahlungen isnull or alle_bestrahlungen !~'\d{2}\.\d{2}\.\d{2}\s*.*')
      union
    select 
      'letzte_r_klassifikation' problem,
      'Wert: '||letzte_r_klassifikation||' - Ungültige Angabe, überprüfen Sie auch die Spalte anzahl_r_klassifikationen' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.r_klassifikation rk 
      on left(ad.letzte_r_klassifikation, 1) = rk.sourceid 
    where ad.letzte_r_klassifikation notnull and rk.sourceid isnull and ad.anzahl_r_klassifikationen::int > 0
      union
    select 
      'anzahl_r_klassifikationen' problem,
      'Wert: '||anzahl_r_klassifikationen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where anzahl_r_klassifikationen::int < 0
      union      
    select 
      'zeitpunkt_tumorfreiheit' problem, 
      'zeitpunkt_tumorfreiheit liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where zeitpunkt_tumorfreiheit > sterbedatum or zeitpunkt_tumorfreiheit > datum_der_auswertung or zeitpunkt_tumorfreiheit < geburtsdatum
      union
    select 
      'tumorfreiheit_verlauf' problem, 
      'Wert: '||tumorfreiheit_verlauf||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where tumorfreiheit_verlauf < 1
      union
    /*select 
      'alle_folgeerkrankungen' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_folgeerkrankungen ...
      union
    select 
      'alle_begleiterkrankungen' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_begleiterkrankungen ...
      union*/
    select 
      'alle_metastasen' problem, 
      'Wert: '||alle_metastasen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where alle_metastasen !~'(\w{3}\s+\d{2}\.\d{2}\.\d{2}\s+\w+.+\n)+'
      union
    select 
      'name' problem, 
      'Wert: '||name||' - Ungültige Angabe (muss leer sein!)' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where name notnull
      union
    select 
      'vorname' problem, 
      'Wert: '||vorname||' - Ungültige Angabe (muss leer sein!)' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where vorname notnull
      union
    select 
      'alle_vorerkrankungen' problem,
      'Wert: '||alle_vorerkrankungen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where alle_vorerkrankungen !~'((\d{4})*\:\s+\w\d+(\.\d+)*\s+Aufl\.\d+v\d+\s+\w+.+\n)+|((\d{4})*\:\s+\w\d+(\.\d+)*\s+Aufl\.\d+v\d+\s+\n)+'
      union
    select 
      'letzter_status_datenart' problem, 
      'Wert: '||ad.letzter_status_datenart||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.status_datenart sd 
      on ad.letzter_status_datenart = sd.status_datenart 
    where sd.status_datenart isnull and ad.letzter_status_datenart notnull
      union
    select 
      'letzter_status_datum' problem, 
      'letzter_status_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzter_status_datum > sterbedatum or letzter_status_datum > datum_der_auswertung or letzter_status_datum < geburtsdatum
      union
    select 
      'letzte_status_lfdnr' problem, 
      'Wert: '||letzte_status_lfdnr||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzte_status_lfdnr < 1
      union
    select 
      'letzter_status' problem, 
      'Wert: '||letzter_status||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzter_status !~'^G\w+\:\s+\w*\nP\w+\:\s+\w*\nL\w+\:\s+\w*\nM\w+\:\s+\w*\n'
      union
    select 
      'alle_abteilungen' problem, 
      'Wert: '||alle_abteilungen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where alle_abteilungen !~'^(\#\d+)+\#'
      union
    select 
      'alle_aerzte' problem, 
      'Wert: '||alle_aerzte||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where alle_aerzte !~'^(\#\d+)+\#'
      union
    select 
      'klin_m' problem,
      'Wert: '||klin_m||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_m not in ('2', '3', '4', 'is', 'a', 'm')
      union
    select 
      'klin_l' problem, 
      'Wert: '||klin_l||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_l !~'^[01]'
      union
    select 
      'klin_v' problem, 
      'Wert: '||klin_v||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_v !~'^[012]'
      union
    select 
      'klin_s' problem, 
      'Wert: '||klin_s||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_s !~'^[123X]'
      union
    select 
      'p_m' problem, 
      'Wert: '||p_m||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_m !~'(^[12347m])|is|sm\d'
      union
    select 
      'p_l' problem, 
      'Wert: '||p_l||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_l !~'^[012]'
      union
    select 
      'p_v' problem,
      'Wert: '||p_v||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_v !~'^[012]'
      union
    select 
      'p_s' problem,
      'Wert: '||p_s||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_s !~'^[120X]'
      union
    select 
      'erstes_lok_rezidivdatum' problem, 
      'erstes_lok_rezidivdatum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where erstes_lok_rezidivdatum > sterbedatum or erstes_lok_rezidivdatum > datum_der_auswertung or erstes_lok_rezidivdatum < geburtsdatum
      union
    select 
      'erstes_lok_rezidivart' problem, 
      'Wert: '||erstes_lok_rezidivart||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where erstes_lok_rezidivart !~'^[BTL]'
      union
    select 
      'erstes_lok_rezidivverlauf' problem, 
      'Wert: '||erstes_lok_rezidivverlauf||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where erstes_lok_rezidivverlauf < 1
      union
    select 
      'klin_pni' problem, 
      'Wert: '||klin_pni||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_pni !~'^[01]'
      union
    select 
      'p_pni' problem,
      'Wert: '||p_pni||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_pni !~'^[01]'
      union
    select 
      'kkr_einwilligung' problem, 
      'Wert: '||p_pni||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where kkr_einwilligung !~'^[JN]'
      union
    select 
      'behandlungsanlass' problem,
      'Wert: '||ad.behandlungsanlass||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.behandlungsanlass bh 
      on ad.behandlungsanlass = bh.sourceid
    where bh.sourceid isnull and ad.behandlungsanlass notnull
      union
    select 
      'erfassungsanlass' problem,
      'Wert: '||ad.erfassungsanlass||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.erfassungsanlass e 
      on ad.erfassungsanlass = e.sourceid
    where e.sourceid isnull and ad.erfassungsanlass notnull
      union
    select 
      'arzt_anlass' problem, 
      'Wert: '||ad.arzt_anlass||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.arzt_anlass e 
      on ad.arzt_anlass = e.sourceid
    where e.sourceid isnull and ad.arzt_anlass notnull
      union
    select 
      'zentkenn' problem, 
      'Wert: '||zentkenn||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where zentkenn !~'^\d{4}'
      union
    select 
      'primfall' problem,
      'Wert: '||primfall||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where primfall !~'^[JN]'
      union
    select 
      'transformation_verlauf' problem,
      'Wert: '||transformation_verlauf||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where transformation_verlauf < 1
      union
    select 
      'transformation_datum' problem,
      'transformation_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where transformation_datum > sterbedatum or transformation_datum > datum_der_auswertung or transformation_datum < geburtsdatum
      union
    select 
      'transformation_histo_code' problem, 
      'Wert: '||transformation_histo_code||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where transformation_histo_code !~'^\d{5}'
      union
    select 
      'transformation_histo_auflage' problem, 
      'Wert: '||transformation_histo_auflage||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where transformation_histo_auflage !~'\w{2}'
      union
    select 
      'erste_lokale_radikalitaet' problem, 
      'Wert: '||erste_lokale_radikalitaet||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where erste_lokale_radikalitaet !~'^[012X]'
      union
    select 
      'defin_lokale_radikalitaet' problem,
      'Wert: '||defin_lokale_radikalitaet||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where defin_lokale_radikalitaet !~'^[012X]'
      union
    select 
      'datum_erste_progression' problem, 
      'datum_erste_progression liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where datum_erste_progression > sterbedatum or datum_erste_progression > datum_der_auswertung or datum_erste_progression < geburtsdatum
      union
    select 
      'nachfragearzt' problem, 
      'Wert: '||nachfragearzt||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where nachfragearzt < 10027
      union
    select 
      'histo_datum' problem,
      'histo_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where histo_datum > sterbedatum or histo_datum > datum_der_auswertung or histo_datum < geburtsdatum
      union
    select 
      'histo_sicherungsdatum' problem, 
      'histo_sicherungsdatum liegt nach der Auswertung oder mehr als 5 Tagen nach dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where histo_sicherungsdatum - sterbedatum > 5 or histo_sicherungsdatum > datum_der_auswertung or histo_sicherungsdatum < geburtsdatum
      union
    select 
      'diagsich_hoechste' problem, 
      'Wert: '||ad.diagsich_hoechste||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.diagsich_hoechste dh 
      on ad.diagsich_hoechste = dh.sourceid 
    where dh.sourceid isnull and ad.diagsich_hoechste notnull
      union
    select 
      'letzter_abschluss_lfdnr' problem,
      'Wert: '||letzter_abschluss_lfdnr||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzter_abschluss_lfdnr not in (1,2)
      union
    select 
      'letzter_abschluss_datum' problem, 
      'letzter_abschluss_datum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where letzter_abschluss_datum > sterbedatum or letzter_abschluss_datum > datum_der_auswertung or letzter_abschluss_datum < geburtsdatum
      union
    select 
      'letzter_abschluss_grund' problem, 
      'Wert: '||letzter_abschluss_grund||' - Ungültige Angabe' problem_beschreibung,
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.abschluss_grund ag 
      on ad.letzter_abschluss_grund = ag.sourceid 
    where ag.sourceid isnull and ad.letzter_abschluss_grund notnull
      union
    select 
      'plz_bei_diagnose' problem, 
      'Wert: '||plz_bei_diagnose||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where plz_bei_diagnose !~'^\d+'
      union
    select 
      'vorangehende_diagnosen' problem,
      'Wert: '||vorangehende_diagnosen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where vorangehende_diagnosen !~'^(\d{2}\.\d{2}\.\d{4}\s+\w\d+(\.\d+)*\s+\w+.+(\s)*\n)+'
      union
    select 
      'gleichzeitige_diagnosen' problem, 
      'Wert: '||gleichzeitige_diagnosen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where gleichzeitige_diagnosen !~'^(\d{2}\.\d{2}\.\d{4}\s+\w\d+(\.\d+)*\s+\w+.+(\s)*\n)+'
      union
    select 
      'nachfolgende_diagnosen' problem, 
      'Wert: '||nachfolgende_diagnosen||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where nachfolgende_diagnosen !~'^(\d{2}\.\d{2}\.\d{4}\s+\w\d+(\.\d+)*\s+\w+.+(\s)*\n)+'
      union
    select 
      'klin_a_symbol' problem, 
      'Wert: '||klin_a_symbol||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where klin_a_symbol not like 'a'
      union
    select 
      'p_a_symbol' problem, 
      'Wert: '||p_a_symbol||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where p_a_symbol not like 'a'
      union
    /*select 
      'iarc_flag' problem, 
      * 
    from gtds.auswertung_diz 
    where iarc_flag ...
      union*/
    select 
      'okz_bei_diagnose' problem, 
      'Wert: '||okz_bei_diagnose||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where okz_bei_diagnose !~'^\d+'
      union
    select 
      'diagnosedatum_genau' problem, 
      'Wert: '||diagnosedatum_genau||' - Ungültige Angabe' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where diagnosedatum_genau not in ('T', 'J', 'M', 'X')
      union
    select 
      'primmetdatum' problem,
      'primmetdatum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where primmetdatum > sterbedatum or letzter_abschluss_datum > datum_der_auswertung or letzter_abschluss_datum < geburtsdatum
      union
    /*select 
      'primmetloks' problem, 
      * 
    from gtds.auswertung_diz 
    where primmetloks ...
      union*/
    select 
      'sekmetdatum' problem, 
      'sekmetdatum liegt nach der Auswertung oder dem Sterbedatum oder vor dem Geburtsdatum' problem_beschreibung,
      * 
    from gtds.auswertung_diz 
    where sekmetdatum > sterbedatum or sekmetdatum > datum_der_auswertung or sekmetdatum < geburtsdatum
      /*union
    select 
      'sekmetloks' problem, 
      * 
    from gtds.auswertung_diz 
    where sekmetloks ...*/
;


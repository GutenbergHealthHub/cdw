
    select 
      'datum_der_auswertung' problem, 
      * 
    from gtds.auswertung_diz 
    where datum_der_auswertung > now()
      union
    select 
      'patienten_id' problem, 
      * 
    from gtds.auswertung_diz 
    where patienten_id isnull or patienten_id like ''
      union
    select 
      'anzahl_tumoren' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_tumoren < 1
      union
    select 
      'geburtsdatum' problem, 
      * 
    from gtds.auswertung_diz 
    where geburtsdatum > datum_der_auswertung
      union
    select 
      'sterbedatum' problem, 
      * 
    from gtds.auswertung_diz 
    where sterbedatum > datum_der_auswertung or sterbedatum < geburtsdatum   
      union
    select 
      'sterbedatum_exakt' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.sterbedatum_exakt se
      on ad.sterbedatum_exakt = se.sourceid 
    where se.sourceid isnull and ad.sterbedatum_exakt notnull
   union
    select 
      'geschlecht' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.gender g 
      on ad.geschlecht = g.sourceid 
    where g.sourceid isnull and ad.geschlecht notnull
      union
    select 
      'plz' problem, 
      * 
    from gtds.auswertung_diz 
    where plz !~'^\d{2}000'
      union
    select 
      'tumortod' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.tumortod t 
      on t.sourceid = ad.tumortod 
    where t.sourceid isnull and ad.tumortod notnull
      union
    select 
      'autopsie' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.autopsie a 
      on a.sourceid = ad.autopsie 
    where a.sourceid isnull and ad.autopsie notnull
      union
    select 
      'aufnahmedatum' problem, 
      * 
    from gtds.auswertung_diz 
    where aufnahmedatum < geburtsdatum or aufnahmedatum > sterbedatum 
      union
    select 
      'diagnosedatum' problem, 
      * 
    from gtds.auswertung_diz 
    where diagnosedatum < geburtsdatum or diagnosedatum > sterbedatum
      union
    select
      'diagnose_abteilung' problem,
      *
    from gtds.auswertung_diz
    where diagnose_abteilung isnull and anzahl_abteilungen > 0
      union
    select 
      'abteilung1' problem,
      *
    from gtds.auswertung_diz
    where abteilung1 isnull and anzahl_abteilungen > 0 and abteilung2 isnull and abteilung3 isnull
      union
    select 
      'abteilung2' problem,
      *
    from gtds.auswertung_diz
    where abteilung2 isnull and anzahl_abteilungen > 0 and abteilung1 isnull and abteilung3 isnull
      union 
    select 
      'abteilung3' problem,
      *
    from gtds.auswertung_diz
    where abteilung3 isnull and anzahl_abteilungen > 0 and abteilung1 isnull and abteilung2 isnull
      union
    select 
      'anzahl_abteilungen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_abteilungen < 1 and (abteilung1 isnull and abteilung2 isnull and abteilung3 isnull)
      union
    select 
      'anzahl_aerzte' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_aerzte < 0 and (hausarzt isnull and arzt1 isnull)
      union 
    select 
      'anzahl_aufenthalte' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_aufenthalte < 1
      union
    select 
      'gesamtdauer_aufenthalte' problem, 
      * 
    from gtds.auswertung_diz 
    where gesamtdauer_aufenthalte isnull and anzahl_aufenthalte > 1
      union
    select 
      'icd10' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.icd i 
      on ad.icd10 = i.codenormal 
    where i.codenormal isnull or ad.icd10 isnull
      union
    select 
      'lokalisation' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    where ad.lokalisation isnull
      union
    select 
      'lok_seite' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.lok_seite ls 
      on ls.sourceid = ad.lok_seite 
    where ls.sourceid isnull and lokalisation notnull
      union
    select 
      'lok_auflage' problem, 
      * 
    from gtds.auswertung_diz 
    where lok_auflage isnull and lokalisation notnull
      union
    select 
      'lok_haupt_neben' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.lok_haupt_neben lhn 
      on lhn.sourceid = ad.lok_haupt_neben
    where lhn.sourceid isnull and ad.lok_haupt_neben notnull
      union
    select 
      'anzahl_histologien' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_histologien < 0
      union
    select 
      'histologie' problem, 
      * 
    from gtds.auswertung_diz 
    where histologie isnull and anzahl_histologien > 0
      union
    select 
      'histo_lfdnr' problem, 
      * 
    from gtds.auswertung_diz 
    where histo_lfdnr isnull and anzahl_histologien > 0
      union
    select 
      'histo_auflage' problem, 
      * 
    from gtds.auswertung_diz 
    where histo_auflage isnull and anzahl_histologien > 0
      union
    select 
      'histo_haupt_neben' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.histo_haupt_neben hhn 
      on hhn.sourceid = ad.histo_haupt_neben 
    where hhn.sourceid isnull and ad.histo_haupt_neben notnull
      union
    select 
      'histo_diagnose' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.histo_diagnose hd 
      on hd.sourceid = ad.histo_diagnose 
    where ad.histo_diagnose notnull and hd.sourceid isnull
      union
    select 
      'histo_herkunft' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.herkunft hh 
      on hh.sourceid = ad.histo_herkunft 
    where ad.histo_herkunft notnull and hh.sourceid isnull
      union
    select 
      'histo_grading' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.histo_grading hg 
      on hg.sourceid = ad.histo_grading 
    where ad.histo_grading notnull and hg.sourceid isnull
      union
    select 
      'klin_tnm_herkunft' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.klin_tnm_herkunft 
    where (ad.klin_tnm_herkunft notnull and ad.klin_tnm_herkunft not like 'O') and h.sourceid isnull 
      union
    select 
      'klin_tnm_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_tnm_datum > sterbedatum
      union
    select 
      'p_tnm_herkunft' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.p_tnm_herkunft 
    where (ad.p_tnm_herkunft notnull and ad.p_tnm_herkunft not like 'O') and h.sourceid isnull
      union
    select 
      'p_tnm_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where p_tnm_datum > sterbedatum
      union    
    select 
      'ann_arbor_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where ann_arbor_datum > sterbedatum
      union
    select 
      'ann_arbor_herkunft' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.ann_arbor_herkunft 
    where ad.ann_arbor_herkunft notnull and ad.ann_arbor_herkunft not like 'O' and h.sourceid isnull
      union
    select 
      'ann_arbor_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where ann_arbor_datum > sterbedatum
      union
    select 
      'ann_arbor_stadium' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.ann_arbor_stadium aas 
      on aas.sourceid = ad.ann_arbor_stadium 
    where ad.ann_arbor_stadium notnull and aas.sourceid isnull
      union
    select 
      'ann_arbor_allgemein' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.ann_arbor_allgemein aaa 
      on aaa.sourceid = ad.ann_arbor_allgemein 
    where ad.ann_arbor_allgemein notnull and aaa.sourceid isnull
      union
    select 
      'anzahl_sonstige' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_sonstige < 0
      union
    select 
      'sonstige_name' problem, 
      * 
    from gtds.auswertung_diz 
    where sonstige_name isnull and anzahl_sonstige > 0
      union
    select 
      'sonstige_id' problem, 
      * 
    from gtds.auswertung_diz 
    where sonstige_id isnull and anzahl_sonstige > 0
      union
    select 
      'sonstige_lfdnr' problem, 
      * 
    from gtds.auswertung_diz 
    where sonstige_lfdnr isnull and anzahl_sonstige > 0
      union
    select 
      'sonstige_herkunft' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.herkunft h 
      on h.sourceid = ad.sonstige_herkunft 
    where ad.sonstige_herkunft notnull and sonstige_herkunft not like 'O' and h.sourceid isnull
      union
    select 
      'sonstige_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where sonstige_datum > sterbedatum
      union
    select 
      'sonstige_stadium' problem, 
      * 
    from gtds.auswertung_diz 
    where sonstige_stadium isnull and anzahl_sonstige > 0
      union
    select 
      'therapieebeginn' problem, 
      * 
    from gtds.auswertung_diz 
    where therapieebeginn > sterbedatum
      union
    select 
      'primaertherapie' problem, 
      * 
    from gtds.auswertung_diz 
    where primaertherapie notnull and primaertherapie !~'CHEMO|OP|BESTR|HORMON|IM|KMT|SO|ZS \(\w\d\)\;'
      union
    select 
      'anzahl_operationen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_operationen < 0
      union
    select 
      'op_nummer' problem, 
      * 
    from gtds.auswertung_diz 
    where op_nummer isnull and anzahl_operationen > 0
      union
    select 
      'op_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where op_datum isnull and anzahl_operationen > 0 or op_datum > sterbedatum
      union
    select 
      'op_abteilung' problem, 
      * 
    from gtds.auswertung_diz 
    where op_abteilung isnull and anzahl_operationen > 0
      union
    select 
      'op_bezeichnung' problem, 
      * 
    from gtds.auswertung_diz 
    where op_bezeichnung isnull and anzahl_operationen > 0 
      union
    select 
      'op_schluessel' problem, 
      * 
    from gtds.auswertung_diz   
    where op_schluessel isnull and anzahl_operationen > 0
      union
    select 
      'op_schluessel' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.ops o
      on ad.op_schluessel = o.code 
    where op_schluessel notnull and anzahl_operationen > 0 and o.code isnull and op_schluessel not like ''
      union
    select 
      'op_schluessel_auflage' problem, 
      * 
    from gtds.auswertung_diz 
    where op_schluessel notnull and abs((op_schluessel_auflage::integer + 2000) - date_part('year', op_datum)::integer) > 1
      union
    select 
      'anzahl_innere' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_innere < 0
      union
    select 
      'innere_nummer' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_nummer isnull and anzahl_innere > 0
      union
    select 
      'innere_beginn' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_innere > 0 and (innere_beginn > sterbedatum or innere_beginn < aufnahmedatum)
      union
    select 
      'innere_abteilung' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_abteilung isnull and anzahl_innere > 0
      union
    select 
      'innere_protokoll_id' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_protokoll_id isnull and anzahl_innere > 0
      union
    select 
      'innere_anzahl_zyklen' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_anzahl_zyklen isnull and anzahl_innere > 0
      union
    select 
      'innere_freitext' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_freitext isnull and anzahl_innere > 0
      union
    select 
      'anzahl_bestrahlungen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_bestrahlungen < 0
      union
    select 
      'bestrahlung_nummer' problem, 
      * 
    from gtds.auswertung_diz 
    where bestrahlung_nummer isnull and anzahl_bestrahlungen > 0
      union
    select 
      'bestrahlung_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where (bestrahlung_datum isnull or bestrahlung_datum < aufnahmedatum) and anzahl_bestrahlungen > 0
      union
    select 
      'bestrahlung_abteilung' problem, 
      * 
    from gtds.auswertung_diz 
    where bestrahlung_abteilung isnull and anzahl_bestrahlungen > 0
      union
    select 
      'bestrahlung_freitext' problem, 
      * 
    from gtds.auswertung_diz 
    where bestrahlung_freitext isnull and anzahl_bestrahlungen > 0
      union
    select 
      'anzahl_teilbestrahlungen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_teilbestrahlungen < 1
      union
    select 
      'teil_bestr_beginn' problem, 
      * 
    from gtds.auswertung_diz 
    where (teil_bestr_beginn isnull or teil_bestr_beginn < aufnahmedatum) and anzahl_teilbestrahlungen > 1
      union
    select 
      'anzahl_zielgebiete' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_zielgebiete < 0
      union
    select 
      'zielgebiet1' problem, 
      * 
    from gtds.auswertung_diz 
    where zielgebiet1 isnull and anzahl_zielgebiete > 0
      union
    select 
      'zielgebiet2' problem, 
      * 
    from gtds.auswertung_diz 
    where zielgebiet2 isnull and anzahl_zielgebiete > 1 and zielgebiet1 isnull
      union
    select 
      'applikationsart' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.applikationsart a 
      on a.sourceid = ad.applikationsart
    where a.sourceid isnull and ad.applikationsart notnull
      union
    select 
      'applikationstechnik' problem, 
      ad.* 
    from gtds.auswertung_diz ad 
    left join metadata_repository.applikationstechnik a 
      on ad.applikationstechnik = a.sourceid 
    where ad.applikationstechnik notnull and a.sourceid isnull
      union
    select 
      'gesamtdosis' problem, 
      * 
    from gtds.auswertung_diz 
    where (gesamtdosis isnull or gesamtdosis !~'^\d+\,*\d*') and applikationsart notnull
      union
    select 
      'gy_gbq' problem, 
      * 
    from gtds.auswertung_diz 
    where gy_gbq isnull and gesamtdosis notnull
      union
    select 
      'strahlenart' problem, 
      ad.* 
    from gtds.auswertung_diz ad
    left join metadata_repository.strahlenart s 
      on s.sourceid = ad.strahlenart 
    where ad.strahlenart notnull and s.sourceid isnull
      /*union
    select 
      'referenz' problem, 
      * 
    from gtds.auswertung_diz 
    where referenz ...*/
      union
    select 
      'sonstigetherapie' problem, 
      * 
    from gtds.auswertung_diz 
    where sonstigetherapie ...
      union
    select 
      'erste_r_klassifikation' problem, 
      * 
    from gtds.auswertung_diz 
    where erste_r_klassifikation ...
      union
    select 
      'erstes_rezidiv' problem, 
      * 
    from gtds.auswertung_diz 
    where erstes_rezidiv ...
      union
    select 
      'datum_erstes_rezidiv' problem, 
      * 
    from gtds.auswertung_diz 
    where datum_erstes_rezidiv ...
      union
    select 
      'anzahl_nachsorgen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_nachsorgen ...
      union
    select 
      'beginn_nachsorge' problem, 
      * 
    from gtds.auswertung_diz 
    where beginn_nachsorge ...
      union
    select 
      'letzte_na_ohne_progression' problem, 
      * 
    from gtds.auswertung_diz 
    where letzte_na_ohne_progression ...
      union
    select 
      'anzahl_metastasen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_metastasen ...
      union
    select 
      'datum_erste_metastase' problem, 
      * 
    from gtds.auswertung_diz 
    where datum_erste_metastase ...
      union
    select 
      'metastase1' problem, 
      * 
    from gtds.auswertung_diz 
    where metastase1 ...
      union
    select 
      'metastase2' problem, 
      * 
    from gtds.auswertung_diz 
    where metastase2 ...
      union
    select 
      'anzahl_folgeerkrankungen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_folgeerkrankungen ...
      union
    select 
      'folgeerkrankung1' problem, 
      * 
    from gtds.auswertung_diz 
    where folgeerkrankung1 ...
      union
    select 
      'folgeerkrankung2' problem, 
      * 
    from gtds.auswertung_diz 
    where folgeerkrankung2 ...
      union
    select 
      'letzte_info_datenart' problem, 
      * 
    from gtds.auswertung_diz 
    where letzte_info_datenart ...
      union
    select 
      'letzte_info_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where letzte_info_datum ...
      union
    select 
      'letzte_info_lfdnr' problem, 
      * 
    from gtds.auswertung_diz 
    where letzte_info_lfdnr ...
      union
    select 
      'op_durchgefuehrt' problem, 
      * 
    from gtds.auswertung_diz 
    where op_durchgefuehrt ...
      union
    select 
      'register' problem, 
      * 
    from gtds.auswertung_diz 
    where register ...
      union
    select 
      'op_intention' problem, 
      * 
    from gtds.auswertung_diz 
    where op_intention ...
      union
    select 
      'klin_tnm_auswertungs_relevant' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_tnm_auswertungs_relevant ...
      union
    select 
      'p_tnm_auswertungs_relevant' problem, 
      * 
    from gtds.auswertung_diz 
    where p_tnm_auswertungs_relevant ...
      union
    select 
      'diagnose_df_abt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where diagnose_df_abt_id ...
      union
    select 
      'diagnose_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where diagnose_df_arzt_id ...
      union
    select 
      'op_df_abt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where op_df_abt_id ...
      union
    select 
      'op_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where op_df_arzt_id ...
      union
    select 
      'innere_df_abt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_df_abt_id ...
      union
    select 
      'innere_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_df_arzt_id ...
      union
    select 
      'bestrahlung_df_abt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where bestrahlung_df_abt_id ...
      union
    select 
      'bestrahlung_df_arzt_id' problem, 
      * 
    from gtds.auswertung_diz 
    where bestrahlung_df_arzt_id ...
      union
    select 
      'innere_protokoll_typ' problem, 
      * 
    from gtds.auswertung_diz 
    where innere_protokoll_typ ...
      union
    select 
      'ortskennzahl' problem, 
      * 
    from gtds.auswertung_diz 
    where ortskennzahl ...
      union
    select 
      'tumorfolgenummer' problem, 
      * 
    from gtds.auswertung_diz 
    where tumorfolgenummer ...
      union
    select 
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
      union
    select 
      'ann_arbor_extra' problem, 
      * 
    from gtds.auswertung_diz 
    where ann_arbor_extra ...
      union
    select 
      'sonstige_kuerzel' problem, 
      * 
    from gtds.auswertung_diz 
    where sonstige_kuerzel ...
      union
    select 
      'therapieende' problem, 
      * 
    from gtds.auswertung_diz 
    where therapieende ...
      union
    select 
      'alle_operationen' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_operationen ...
      union
    select 
      'alle_inneren' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_inneren ...
      union
    select 
      'alle_bestrahlungen' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_bestrahlungen ...
      union
    select 
      'letzte_r_klassifikation' problem, 
      * 
    from gtds.auswertung_diz 
    where letzte_r_klassifikation ...
      union
    select 
      'anzahl_r_klassifikationen' problem, 
      * 
    from gtds.auswertung_diz 
    where anzahl_r_klassifikationen ...
      union
    select 
      'zeitpunkt_tumorfreiheit' problem, 
      * 
    from gtds.auswertung_diz 
    where zeitpunkt_tumorfreiheit ...
      union
    select 
      'tumorfreiheit_verlauf' problem, 
      * 
    from gtds.auswertung_diz 
    where tumorfreiheit_verlauf ...
      union
    select 
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
      union
    select 
      'alle_metastasen' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_metastasen ...
      union
    select 
      'name' problem, 
      * 
    from gtds.auswertung_diz 
    where name ...
      union
    select 
      'vorname' problem, 
      * 
    from gtds.auswertung_diz 
    where vorname ...
      union
    select 
      'alle_vorerkrankungen' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_vorerkrankungen ...
      union
    select 
      'letzter_status_datenart' problem, 
      * 
    from gtds.auswertung_diz 
    where letzter_status_datenart ...
      union
    select 
      'letzter_status_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where letzter_status_datum ...
      union
    select 
      'letzte_status_lfdnr' problem, 
      * 
    from gtds.auswertung_diz 
    where letzte_status_lfdnr ...
      union
    select 
      'letzter_status' problem, 
      * 
    from gtds.auswertung_diz 
    where letzter_status ...
      union
    select 
      'alle_abteilungen' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_abteilungen ...
      union
    select 
      'alle_aerzte' problem, 
      * 
    from gtds.auswertung_diz 
    where alle_aerzte ...
      union
    select 
      'klin_m' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_m ...
      union
    select 
      'klin_l' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_l ...
      union
    select 
      'klin_v' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_v ...
      union
    select 
      'klin_s' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_s ...
      union
    select 
      'p_m' problem, 
      * 
    from gtds.auswertung_diz 
    where p_m ...
      union
    select 
      'p_l' problem, 
      * 
    from gtds.auswertung_diz 
    where p_l ...
      union
    select 
      'p_v' problem, 
      * 
    from gtds.auswertung_diz 
    where p_v ...
      union
    select 
      'p_s' problem, 
      * 
    from gtds.auswertung_diz 
    where p_s ...
      union
    select 
      'erstes_lok_rezidivdatum' problem, 
      * 
    from gtds.auswertung_diz 
    where erstes_lok_rezidivdatum ...
      union
    select 
      'erstes_lok_rezidivart' problem, 
      * 
    from gtds.auswertung_diz 
    where erstes_lok_rezidivart ...
      union
    select 
      'erstes_lok_rezidivverlauf' problem, 
      * 
    from gtds.auswertung_diz 
    where erstes_lok_rezidivverlauf ...
      union
    select 
      'klin_pni' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_pni ...
      union
    select 
      'p_pni' problem, 
      * 
    from gtds.auswertung_diz 
    where p_pni ...
      union
    select 
      'kkr_einwilligung' problem, 
      * 
    from gtds.auswertung_diz 
    where kkr_einwilligung ...
      union
    select 
      'behandlungsanlass' problem, 
      * 
    from gtds.auswertung_diz 
    where behandlungsanlass ...
      union
    select 
      'erfassungsanlass' problem, 
      * 
    from gtds.auswertung_diz 
    where erfassungsanlass ...
      union
    select 
      'arzt_anlass' problem, 
      * 
    from gtds.auswertung_diz 
    where arzt_anlass ...
      union
    select 
      'zentkenn' problem, 
      * 
    from gtds.auswertung_diz 
    where zentkenn ...
      union
    select 
      'primfall' problem, 
      * 
    from gtds.auswertung_diz 
    where primfall ...
      union
    select 
      'transformation_verlauf' problem, 
      * 
    from gtds.auswertung_diz 
    where transformation_verlauf ...
      union
    select 
      'transformation_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where transformation_datum ...
      union
    select 
      'transformation_histo_code' problem, 
      * 
    from gtds.auswertung_diz 
    where transformation_histo_code ...
      union
    select 
      'transformation_histo_auflage' problem, 
      * 
    from gtds.auswertung_diz 
    where transformation_histo_auflage ...
      union
    select 
      'erste_lokale_radikalitaet' problem, 
      * 
    from gtds.auswertung_diz 
    where erste_lokale_radikalitaet ...
      union
    select 
      'defin_lokale_radikalitaet' problem, 
      * 
    from gtds.auswertung_diz 
    where defin_lokale_radikalitaet ...
      union
    select 
      'datum_erste_progression' problem, 
      * 
    from gtds.auswertung_diz 
    where datum_erste_progression ...
      union
    select 
      'nachfragearzt' problem, 
      * 
    from gtds.auswertung_diz 
    where nachfragearzt ...
      union
    select 
      'histo_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where histo_datum ...
      union
    select 
      'histo_sicherungsdatum' problem, 
      * 
    from gtds.auswertung_diz 
    where histo_sicherungsdatum ...
      union
    select 
      'diagsich_hoechste' problem, 
      * 
    from gtds.auswertung_diz 
    where diagsich_hoechste ...
      union
    select 
      'letzter_abschluss_lfdnr' problem, 
      * 
    from gtds.auswertung_diz 
    where letzter_abschluss_lfdnr ...
      union
    select 
      'letzter_abschluss_datum' problem, 
      * 
    from gtds.auswertung_diz 
    where letzter_abschluss_datum ...
      union
    select 
      'letzter_abschluss_grund' problem, 
      * 
    from gtds.auswertung_diz 
    where letzter_abschluss_grund ...
      union
    select 
      'plz_bei_diagnose' problem, 
      * 
    from gtds.auswertung_diz 
    where plz_bei_diagnose ...
      union
    select 
      'vorangehende_diagnosen' problem, 
      * 
    from gtds.auswertung_diz 
    where vorangehende_diagnosen ...
      union
    select 
      'gleichzeitige_diagnosen' problem, 
      * 
    from gtds.auswertung_diz 
    where gleichzeitige_diagnosen ...
      union
    select 
      'nachfolgende_diagnosen' problem, 
      * 
    from gtds.auswertung_diz 
    where nachfolgende_diagnosen ...
      union
    select 
      'klin_a_symbol' problem, 
      * 
    from gtds.auswertung_diz 
    where klin_a_symbol ...
      union
    select 
      'p_a_symbol' problem, 
      * 
    from gtds.auswertung_diz 
    where p_a_symbol ...
      union
    select 
      'iarc_flag' problem, 
      * 
    from gtds.auswertung_diz 
    where iarc_flag ...
      union
    select 
      'okz_bei_diagnose' problem, 
      * 
    from gtds.auswertung_diz 
    where okz_bei_diagnose ...
      union
    select 
      'diagnosedatum_genau' problem, 
      * 
    from gtds.auswertung_diz 
    where diagnosedatum_genau ...
      union
    select 
      'primmetdatum' problem, 
      * 
    from gtds.auswertung_diz 
    where primmetdatum ...
      union
    select 
      'primmetloks' problem, 
      * 
    from gtds.auswertung_diz 
    where primmetloks ...
      union
    select 
      'sekmetdatum' problem, 
      * 
    from gtds.auswertung_diz 
    where sekmetdatum ...
      union
    select 
      'sekmetloks' problem, 
      * 
    from gtds.auswertung_diz 
    where sekmetloks ...
      union
;

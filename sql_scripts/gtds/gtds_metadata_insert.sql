 -- insert into sterbedatum_exakt
    insert into metadata_repository.sterbedatum_exakt(sourceid, sterbedatum_exakt)
      values
        ('J','Ja'),
        ('N','Nein'),
        ('X','Unbekannt')
;
    -- insert into tumortod
    insert into metadata_repository.tumortod(sourceid, tumortod)
      values
        ('J','Tod tumorbedingt, keine nähere Angabe'),
        ('T','Tod tumorbedingt durch das Tumorleiden, keine nähere Angabe'),
        ('P','Tod tumorbedingt d. Progression des primären Tumorgeschehens'),
        ('L','Tod tumorbedingt durch lokoregionäres Rezidiv'),
        ('M','Tod tumorbedingt durch Fernmetastasierung'),
        ('B','Tod tumorbedingt durch Behandlungskomplikation'),
        ('N','Tod nicht tumorbedingt'),
        ('E','Entscheidung nicht möglich'),
        ('X','unbekannt (Fraglich, nicht entscheidbar)'),
        ('F','(alter Code "F") Fraglich, nicht entscheidbar')
;

    -- insert into autopsie
    insert into metadata_repository.autopsie(sourceid, autopsie)
      values
        ('J','Ja'),
        ('N','Nein'),
        ('X','Unbekannt')
;

 
    -- insert into lokalisation
    insert into metadata_repository.lokalisation(sourceid)
     select distinct lokalisation from gtds.auswertung_diz ad where lokalisation notnull and lokalisation not like '' order by lokalisation;
;

    -- insert into lok_seite
    insert into metadata_repository.lok_seite(sourceid, lok_seite)
      values
        ('R','rechts'),
        ('L','links'),
        ('B','beidseits'),
        ('M','Mittellinienzone ( je 2cm rechts oder links d. Mittellinie)'),
        ('T','Trifft nicht zu'),
        ('X','unbekannt'),
        ('S','Systemerkrankung')
;

    -- insert into lok_haupt_neben
    insert into metadata_repository.lok_haupt_neben(sourceid, lok_haupt_neben)
      values
        ('H','Hauptlokalisation'),
        ('N','Nebenlokalisation')
;

    -- insert into histo_haupt_neben
    insert into metadata_repository.histo_haupt_neben(sourceid, histo_haupt_neben)
      values
        ('H','Haupthistologie'),
        ('N','Nebenhistologie')
;

    -- insert into histo_diagnose
    insert into metadata_repository.histo_diagnose(sourceid, histo_diagnose)
      values
        ('J','Ja'),
        ('N','Nein')
;

    -- insert into histo_herkunft
    insert into metadata_repository.histo_herkunft(sourceid, histo_herkunft)
      values
        ('D','Diagnose'),
        ('V','Verlauf')
;

    -- insert into histo_grading
    insert into metadata_repository.histo_grading(sourceid, histo_grading)
      values
        ('1','G1 (Gut differenziert)'),
('2','G2 (Mäßig differenziert)'),
('3','G3 (Schlecht differenziert)'),
('4','G4 (Undifferenziert)'),
('L','Low grade (G1/G2)'),
('M','Intermediate grade (G2/G3)'),
('H','High grade (G3/G4)'),
('G','Grenzfall bzw. Borderline (nur bei Ovar !)'),
('T','T-zellig'),
('B','B-zellig'),
('Z','Null-zellig'),
('X','GX (Differenzierungsgrad oder Herkunft nicht zu bestimmen)'),
('U','unbekannt'),
('N','trifft nicht zu'),
('0','Primär erworbene Melanose')
;



    -- insert into klin_tnm_herkunft
    insert into metadata_repository.klin_tnm_herkunft(sourceid, klin_tnm_herkunft)
      values
        ('D','Diagnose'),
        ('V','Verlauf')
;

  
    -- insert into ann_arbor_herkunft
    insert into metadata_repository.ann_arbor_herkunft(sourceid, ann_arbor_herkunft)
      values
        ('D','Diagnose'),
        ('V','Verlauf')
;

    -- insert into ann_arbor_stadium
    insert into metadata_repository.ann_arbor_stadium(sourceid, ann_arbor_stadium)
      values
        ('1','Stadium I'),
        ('2','Stadium II'),
        ('3','Stadium III'),
        ('4','Stadium IV'),
        ('X','unbekannt')
;

    -- insert into ann_arbor_allgemein
    insert into metadata_repository.ann_arbor_allgemein(sourceid, ann_arbor_allgemein)
      values
        ('A','Kategorie A (ohne Gewichtsverlust, Fieber,Nachtschweiss)'),
        ('B','Kategorie B (mit Gewichtsverlust, Fieber,Nachtschweiss)'),
        ('X','unbekannt')
;
    -- insert into sonstige_herkunft
    insert into metadata_repository.sonstige_herkunft(sourceid, sonstige_herkunft)
      values
        ('D','Diagnose'),
        ('V','Verlauf')
;

-- op_schluessel -> OPS
-- icd10 -> ICD10GM 

    -- insert into applikationsart
    insert into metadata_repository.applikationsart(sourceid, applikationsart)
      values
        ('P','Teletherapie (perkutane Therapie)'),
('PRCJ','Perkutan mit Radiochemotherapie/Sensitizer'),
('PRCN','Perkutan ohne Radiochemotherapie/Sensitizer'),
('K','Endokavitäre Kontakttherapie'),
('KHDR','endok. Kontaktth. mit high dose rate therapy'),
('KPDR','endok. Kontaktth. mit pulsed dose rate therapy'),
('KLDR','endok. Kontaktth. mit low dose rate therapy'),
('I','Interstitielle Kontakttherapie'),
('IHDR','interst. Kontaktth. mit high dose rate therapy'),
('IPDR','interst. Kontaktth. mit pulsed dose rate therapy'),
('ILDR','interst. Kontaktth. mit low dose rate therapy'),
('M','Therapie mit offenen Radionukliden (metabolische Therapie)'),
('MSIRT','Selektive Interne Radio-Therapie'),
('MPRRT','Peptid-Radio-Rezeptor-Therapie'),
('S','Sonstiges'),
('A','Andere Kontakttherapie'),
('B','besondere Applikation (alter Code)')
;

    -- insert into applikationstechnik
    insert into metadata_repository.applikationstechnik(sourceid, applikationstechnik)
      values
        ('1S','einzelnes Stehfeld'),
('1B','einzelnes Stehfeld mit Block'),
('2S','gegenständige Stehfelder'),
('2B','gegenständige Stehfelder mit Block'),
('3S','Stehfeldtechnik mit 3 und mehr als 3 Feldern'),
('3B','Stehfeldtechnik mit 3 und mehr als 3 Feldern mit Block'),
('4S','Boxtechnik (4 Felder)'),
('4B','Boxtechnik (4 Felder) mit Block'),
('BKW','Kleinwinkelpendelung'),
('BMA','monoaxiale Pendelung'),
('BBA','biaxiale Pendelung'),
('BVA','vieraxiale Pendelung'),
('BTA','tangentiale Pendelung'),
('BSS','Skip-Scan Technik'),
('BSO','sonstige Pendeltechnik'),
('KD','dynamische Bestrahlungstechnik'),
('KM','Mantelfeldtechnik'),
('KIM','intensitätsmodulierte Strahlentherapie (IMRT)'),
('SML','Multi-Leaf Technik'),
('SS','sonstige Stehfeldtechnik'),
('1','1 Stehfeld'),
('2','2 Stehfelder'),
('X','unbekannt'),
('B','Bewegungsbestrahlung'),
('S','sonstige Techniken'),
('K','komplexe Technik'),
('4','4 Stehfelder'),
('3','3 Stehfelder')
;

 

    -- insert into strahlenart
    insert into metadata_repository.strahlenart(sourceid, strahlenart)
      values
        ('AU','Gold-198'),
('CO','Cobalt-60'),
('CS','Caesium-137'),
('EL','Elektronenstrahlen'),
('IR','Iridium-192'),
('J1','Jod-125'),
('J2','Jod-131'),
('NE','Neutronenstrahlen'),
('PD','Palladium 103'),
('PH','Phosphor-32'),
('PN','Protonenstrahlen'),
('R2','Radium-223'),
('RA','Radium-226'),
('RO','konventionelle Roentgenstrahlen'),
('S1','Strontium-89'),
('S2','Strontium-90'),
('SM','Samarium 153'),
('SO','sonstige'),
('TA','Tantal-182'),
('UH','ultraharte Roentgenstrahlen / Photonen'),
('YT','Yttrium-90')
;

  
    -- insert into erste_r_klassifikation
    insert into metadata_repository.r_klassifikation(sourceid, r_klassifikation)
      values
        ('0','R0 (kein Residualtumor)'),
('1','R1 (mikroskopischer Residualtumor)'),
('2','R2 (makroskopischer Residualtumor)'),
('X','RX (Vorhandensein von Residualtu. kann n. beurteilt werden)'),
('3','R2b (makr.Residualtu., mikroskop. bestätigt)')
;

     -- insert into op_intention
    insert into metadata_repository.op_intention(sourceid, op_intention)
      values
        ('K','Kurativ'),
('P','Palliativ'),
('D','Diagnostisch'),
('R','Revision/Komplikation'),
('S','Sonstiges'),
('U','Unterstützender tumorferner Eingriff'),
('X','fehlende Angabe')
;

     -- insert into protokoll_typ
    insert into metadata_repository.protokoll_typ(sourceid, protokoll_typ)
      values
        ('C','Chemotherapie'),
('H','Hormontherapie'),
('I','Immun- und Antikörpertherapie'),
('K','Knochenmark-/Stammzelltransplantation'),
('W','Wait and see'),
('A','Active Surveillance'),
('Z','Zielgerichtete Substanzen'),
('S','Sonstiges'),
('CM','Mono-Chemotherapie'),
('CP','Poly-Chemotherapie'),
('CR','regionale Perfusion'),
('IU','unspezifische Immuntherapie'),
('IS','spezifische Immuntherapie'),
('IC','Immunchemotherapie'),
('BP','Bisphosphonate'),
('KM','Konditionierung für KMT'),
('SO','sonstige Therapie')
;

-- erstes_rezidiv -> Verlauf-\d([PMLG])
-- primaertherapie -> (OPERATION, BESTRAHLUNG, CHEMO, HORMON, IMMUN, KMT) semikolon ";"
-- defin_lokale_radikalitaet -> r_klasifikation

    -- insert into ann_arbor_extra
    insert into metadata_repository.ann_arbor_extra(sourceid, ann_arbor_extra)
      values
        ('E','Extralymphatischer Befall'),
        ('K','Kein extralymphatischer Befall'),
        ('X','unbekannt')
;

   
    -- insert into lok_rezidivart
    insert into metadata_repository.lok_rezidivart(sourceid, lok_rezidivart)
      values
        ('T','Primärtumor'),
        ('L','Lymphknoten'),
        ('B','beides')
;

    -- insert into einwilligung
    insert into metadata_repository.einwilligung(sourceid, einwilligung)
      values
        ('J','Ja'),
        ('N','Nein'),
        ('X','unbekannt')
;

    -- insert into behandlungsanlass -> tumorausprägung
    insert into metadata_repository.tumorauspraegung(sourceid, tumorauspraegung)
      values
        ('T','Primärtumor'),
('R','lokoregionäres Rezidiv'),
('L','Lymphknotenrezidiv'),
('M','Fernmetastasen'),
('B','lokoregionäres Rezidiv und Fernmetastasen'),
('G','generelle Progression des Krankheitsbildes'),
('X','unbekannt'),
('P','Primärtumorrezidiv')
;

    -- insert into erfassungsanlass
    insert into metadata_repository.erfassungsanlass(sourceid, erfassungsanlass)
      values
        ('E','Erstbehandlung'),
('W','Die Aufnahme des Patienten erfolgte zur Weiterbehandlung.'),
('S','symptomatische Therapie'),
('L','Nachsorge / Langzeitbetreuung'),
('D','Diagnostik'),
('A','Anderes'),
('Z','Zweitmeinung'),
('X','unbekannt')
;

 
    -- insert into arzt_anlass
    insert into metadata_repository.arzt_anlass(sourceid, arzt_anlass)
      values
        ('T','Tumorsymptomatik führte zum Arzt'),
('F','gesetzliche Früherkennungsmaßnahme'),
('C','spezifische Screeningmaßnahme'),
('V','nichtgesetzliche Vorsorgeuntersuchung'),
('S','Selbstuntersuchung'),
('L','Nachsorgeuntersuchung / Langzeitbetreuung'),
('A','andere Untersuchung'),
('X','unbekannt'),
('P','ausschließliche post mortem Diagnose')
;

    

    -- insert into diagsich_hoechste
    insert into metadata_repository.diagsich_hoechste(sourceid, diagsich_hoechste)
      values
        ('1','klinisch ohne tumorspezifische Diagnostik (körperliche Unts)'),
('2','klinisch mit spezieller Diagnostik, vor Sterbedatum'),
('4','spezifische Tumormarker'),
('5','zytologische Diagnosesicherung'),
('6','Histologie einer Metastase'),
('7','Histologie des Primärtumors'),
('M','(BY) Mortalitätsdaten aus Todesbescheinigung'),
('K','klinisch bzw. chirurgisch'),
('Z','zytologisch'),
('H','histologisch'),
('A','autoptisch'),
('S','sonstiges'),
('D','ausschließlich Leichenschauschein'),
('X','unbekannt'),
('C','(BY) DCN Fall')
;


-- lethter_abschluss_grund -> abschluss_grund
    -- insert into abschluss_grund
    insert into metadata_repository.abschluss_grund(sourceid, abschluss_grund)
      values
('T','Patient verstorben (Tod)'),
('A','Patient nicht mehr auffindbar (lost to follow-up)'),
('N','Betreuung/Nachsorge nicht mehr nötig'),
('B','Patient ist andernorts in Betreuung'),
('V','Patient verweigert weitere Betreuung'),
('X','unbekannt')
;

-- insert into rezidiv
insert into metadata_repository.rezidiv (sourceid, rezidiv)
  values
  ('P', 'Primärtumor'),
  ('L', 'Lymphknoten'),
  ('M', 'Metastasen'),
  ('G', 'Gesamtbeurteilung')
;


insert into metadata_repository.gtds_datenart (datenart)
  values
  ('Operation'),
  ('Bestrahlung'),
  ('Innere'),
  ('Verlauf'),
  ('Aufenhalt'),
  ('Abschluss'),
  ('Diagnose'),
  ('Metastase')
;

drop table if exists kis.norg_temp;
CREATE TABLE kis.norg_temp(
  "Organisationseinheit" TEXT,
  "Typ der OrgEinh." TEXT,
  "Name der Org.einheit" TEXT,
  "Zusatzbezeichnung" TEXT,
  "Kurzbez. OrgEinheit" TEXT,
  "Kürzel Org.einh." TEXT,
  "Einrichtung" TEXT,
  "Archivierte Daten" TEXT,
  "Länderschlüssel" TEXT,
  "Postleitzahl" TEXT,
  "Ort" TEXT,
  "Straße / Nr." TEXT,
  "Telefonnummer" TEXT,
  "Telefaxnummer" TEXT,
  "Teletexnummer" TEXT,
  "Bemerkung" TEXT,
  "Langtext" TEXT,
  "Fachrichtg. BPflV" TEXT,
  "Fachr. KHStatV" TEXT,
  "Fachr. Pflege-PR" TEXT,
  "Sperrkennzeichen" TEXT,
  "Gültig von" TEXT,
  "Gültig bis" TEXT,
  "Belegt interdis." TEXT,
  "Freigabekennzeichen" TEXT,
  "Fachl. Zuweisung" TEXT,
  "Pfleg. Zuweisung" TEXT,
  "Aufnahmestelle" TEXT,
  "Interdis. belegbar" TEXT,
  "Intensivbehandlung" TEXT,
  "Ambulanter Besuch" TEXT,
  "Datenschutzkennz." TEXT,
  "PPR-Ausschluß" TEXT,
  "Löschkennzeichen" TEXT,
  "Gelöscht von" TEXT,
  "Gelöscht am" TEXT,
  "Angelegt am" TEXT,
  "Angelegt von" TEXT,
  "Geändert am" TEXT,
  "Geändert von" TEXT,
  "Aktenarchiv" TEXT,
  "Sperrdatum von" TEXT,
  "Sperrdatum bis" TEXT,
  "Fachrichtung frei" TEXT,
  "Pädiatriekennz." TEXT,
  "Abrechnungskennz." TEXT,
  "Auft. in mehr. Kostl" TEXT,
  "Anforderung Gesperrt" TEXT,
  "Anforderbar" TEXT,
  "Disponierbar" TEXT,
  "Erbringbar" TEXT,
  "Anzahl StandAufruf." TEXT,
  "Aufrufzeitraum" TEXT,
  "Vercodungspflichtkz." TEXT,
  "Ext.-Anforderbarkz." TEXT,
  "Kabinenzuorndungskz." TEXT,
  "Kz.Leit.zwing.verw." TEXT,
  "Leistungsstellentyp" TEXT,
  "Terminvergabekz." TEXT,
  "Leistung" TEXT,
  "Zusatz-KZ" TEXT,
  "Fachrichtg. BV 95" TEXT,
  "Fachrichtg. Krazaf" TEXT,
  "Fachrichtung" TEXT,
  "Fachrichtung frei.1" TEXT,
  "Fachrichtung frei.2" TEXT,
  "Fachrichtung frei.3" TEXT,
  "Fachrichtg. POLIS" TEXT,
  "Kalender" TEXT,
  "Adreßnummer" TEXT,
  "Adreßsobjekt" TEXT,
  "Fachrichtung.1" TEXT,
  "Werk" TEXT,
  "Lagerort" TEXT,
  "EAN-Nummer" TEXT,
  "Belegabteilung" TEXT,
  "Fachr. KHStatV Besondere Einrichtungen" TEXT,
  "ObjektId" TEXT,
  "Gebäude-Code" TEXT,
  "Ambulanzcode" TEXT,
  "Intermediate Care" TEXT
);

copy kis.norg_temp from '/media/db/cdw_files/kis/norg_all_columns.csv' WITH DELIMITER E';' CSV QUOTE E'\b' header;

--select * from kis.norg_temp nt;

drop table if exists kis.norg cascade;
create table kis.norg(
  enri varchar(4) not null,
  orgid varchar(8) not null,
  orgty varchar(2),
  orgna varchar(30),
  orgkb varchar(12),
  okurz varchar(5),
  fachr varchar(4),
  fachr2 varchar(4),
  aufkz boolean,
  inten boolean,
  fachr9 varchar(4),
  paedkz boolean,
  fachr1 varchar(4),
  primary key (enri, orgid)
);

insert into kis.norg 
select 
  '000'||"Einrichtung" einri,
  "Organisationseinheit" orgid,
  "Typ der OrgEinh." orgty,
  "Name der Org.einheit" orgna,
  "Kurzbez. OrgEinheit" orgkb,
  "Kürzel Org.einh." okurz,
  "Fachrichtg. BPflV" fachr,
  "Fachr. KHStatV" fachr2,
  case 
    when "Aufnahmestelle" isnull then false 
    else true 
  end aufkz,
  case 
    when "Intensivbehandlung" isnull then false
    else true 
  end inten,
  "Fachrichtung frei" fachr9,
  case
    when "Pädiatriekennz." isnull then false 
    else true 
  end paedkz,
  "Fachrichtg. BV 95" fachr1 
from kis.norg_temp nt;


/*
 * SQL Error [2BP01]: ERROR: cannot drop table kis.norg because other objects depend on it
  Detail: view kis.dqa_nbew_orgfa depends on table kis.norg
view kis.dqa_nbew_orgau depends on table kis.norg
view kis.dqa_nbew_orgpf depends on table kis.norg
  Hint: Use DROP ... CASCADE to drop the dependent objects too.
 * */
select * from kis.norg n;

drop table if exists kis.norg_temp;


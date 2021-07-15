drop table if exists metadata_repository.bewegunstyp;

create table metadata_repository.bewegunstyp(
  id serial primary key,
  bewty varchar(4) not null,
  bewegunstyp varchar(255) not null,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(bewty, bewegunstyp)
);

insert into metadata_repository.bewegunstyp (bewty, bewegunstyp)
  values('1', 'Aufnahme'),
  ('2', 'Entlassung'),
  ('3', 'Verlegung'),
  ('4', 'Ambulanter Besuch'),
  ('6', 'Abwesenheitsbeginn'),
  ('7', 'Abwesenheitsende')
;

drop table if exists metadata_repository.bewegunsart;
create table metadata_repository.bewegunsart(
  id serial primary key,
  bwart varchar(4) not null unique,
  bewegunsart varchar(255),
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now()
);

--insert into metadata_repository.bewegunsart (bwart)
  --select distinct bwart from kis.nbew where bwart ~'\w';

drop table if exists metadata_repository.inter_status_amb_besu;
create table metadata_repository.inter_status_amb_besu(
  id serial primary key,
  statu varchar(4) not null,
  intstatu varchar(255) not null,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(statu, intstatu)
);

insert into metadata_repository.inter_status_amb_besu (statu, intstatu)
  values('1', 'Aufnahme'),
  ('10', 'Warteliste'),
  ('20', 'Plan'),
  ('30', 'Ist'),
  ('40', 'Angemldet'),
  ('50', 'Wartend'),
  ('55', 'Aufgerufen'),
  ('60', 'In Behandlung'),
  ('70', 'Behandlung abgschlossen')
;
 
drop table if exists metadata_repository.unfallart;

create table metadata_repository.unfallart(
  id serial primary key,
  unfkz varchar not null,
  unfallart varchar(255) not null,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(unfkz, unfallart)
);
 

insert into metadata_repository.unfallart (unfkz, unfallart)
  values
    ('A', 'Arbeitsunfall'),
    ('H', 'Hausunfall'),
    ('S', 'Sportunfall'),
    ('V', 'Verkehrsunfall'),
    ('X', 'Sonst.-Unfall')
;

drop table if exists metadata_repository.orgtype;
create table metadata_repository.orgtype(
  id serial primary key,
  orgty varchar not null,
  orgtype varchar(255) not null,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(orgty, orgtype)
);

insert into metadata_repository.orgtype(orgty, orgtype)
  values
    ('A','Ambulanz'),
    ('F','Fachabteilung'),
    ('IB','IBL - Orgeinheiten'),
    ('K','Klinik'),
    ('KA','Knoten Ambulanz'),
    ('KL','Knoten Leistungsstelle'),
    ('LS','Leistungsstelle'),
    ('ME','Med. Einrichtung'),
    ('MK','Med. Kooperationen'),
    ('MZ','Medizinische Zentren'),
    ('OL','operative Leitstelle'),
    ('S','Stationen'),
    ('SE','Sonst. Einrichtungen'),
    ('TR','Transporte')
;

drop table if exists metadata_repository.stornierungsgrund;

create table metadata_repository.stornierungsgrund(
  id serial primary key,
  stoid varchar not null,
  stornierungsgrund varchar(255) not null,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(stoid, stornierungsgrund)
);

insert into metadata_repository.stornierungsgrund(stoid, stornierungsgrund)
  values
    ('ACO', 'Absage Corona'),
    ('ATA', 'kein AT-Arzt'),
    ('ATF', 'keine AT-Freiga'),
    ('ATP', 'keine AT-Pflege'),
    ('DIA', 'Diag.änderung'),
    ('DOP', 'Erfass.fehler'),
    ('FRV', 'Fallrevision'),
    ('INF', 'Infektion Pat.'),
    ('INS', 'kein Instrument'),
    ('IRR', 'keine stat.beh.'),
    ('KIB', 'kein Intensivb.'),
    ('KOP', 'kein Operateur'),
    ('KOR', '§302-Korrekt.'),
    ('KOS', 'kein OP-Saal'),
    ('NOT', 'Pat.nicht gek.'),
    ('OPA', 'OP abgesetzt'),
    ('OPP', 'keine OP-Pflege'),
    ('PEN', 'Pat. entlassen'),
    ('PNG', 'Pat.nicht gek.'),
    ('OVS', 'Pat. verstorben'),
    ('TAB', 'Termin abg.Pat.'),
    ('TAK', 'Termin abg.Kli.'),
    ('ZUZ', '§302 Zuz.ford.')
;


drop table if exists metadata_repository.transportart;
create table metadata_repository.transportart(
  id serial primary key,
  tpart varchar not null,
  transportart varchar(255) not null,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(tpart, transportart)
);

insert into metadata_repository.transportart(tpart, transportart)
  values
    ('01', 'PSD'),
    ('02', 'RS/KPH/AH/RH'),
    ('03', 'Examiniert'),
    ('04', 'FZG+RS/RH'),
    ('05', 'FZG+Examiniert'),
    ('06', 'RTW + 02'),
    ('07', 'KTW infektiös'),
    ('08', 'RTW infektiös'),
    ('09', 'RTW + EKG'),
    ('10', 'RTW + O2 + EKG'),
    ('11', 'KTW FZ es + O2'),
    ('12', 'RTW+Iso/Inkub'),
    ('13', 'RTW+O2+Infektio'),
    ('14', 'RTW+EKG+Infekti'),
    ('15', 'RTW+O2+EKG+Infk'),
    ('16', 'KTW+O2+Infektio'),
    ('17', 'PSD Bett+Infekt'),
    ('18', 'PSD Liege+Infek'),
    ('19', 'PSD, Rolli+Infek'),
    ('20', 'PSD Siestaliege'),
    ('21', 'PSD Siesta+Infk'),
    ('22', 'PSD Fußgänger'),
    ('23', 'PSD'),
    ('24', 'PSD inefktiös'),
    ('25', 'PSD + O2'),
    ('26', 'RTW FZ ex'),
    ('27', 'RTW FZ ex + O2'),
    ('28', 'RTW FZ ex + EKG'),
    ('29', 'RTW FZex+O2+EKG'),
    ('30', 'RS/KPH'),
    ('GE', 'gehend'),
    ('LI', 'liegend'),
    ('SI', 'sitzend')
;


drop table if exists metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart;
create table metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart(
  id serial primary key,
  rfsrc varchar not null,
  einweisungs_ueberweisungs_nachbehandlungsart varchar(255) not null,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(rfsrc, einweisungs_ueberweisungs_nachbehandlungsart)
);

insert into metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart(rfsrc, einweisungs_ueberweisungs_nachbehandlungsart) 
  values
    ('EB', 'Entbindung'),
    ('EX', '<24Std, ext.KH'),
    ('FW', 'Feuerwehr'),
    ('KT', 'KTW'),
    ('NA', 'Notarztwagen'),
    ('PO', 'Polizei'),
    ('RH', 'Hubschrauber'),
    ('RT', 'RTW'),
    ('SE', 'Selbsteinweiser'),
    ('SP', 'Organspender'),
    ('UE', 'Überw. D.Arzt'),
    ('E', 'keine NT-Beh.'),
    ('EN', 'NT-Beh. Vorges.')
;

--deathcause
drop table if exists metadata_repository.deathcause;

CREATE TABLE metadata_repository.deathcause (
	id serial NOT NULL primary key,
	sourceid varchar NOT NULL,
	deathcause varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp not null default now(),
	UNIQUE (sourceid, deathcause)
);

insert into metadata_repository.deathcause (sourceid, deathcause)
  values
  ('01', 'Natürlicher Tod'),
  ('02', 'Krankheitsbedingt'),
  ('03', 'Operat. M. Todesfolge'),
  ('04', 'NA'),
  ('05', 'Unnatürlicher Tod'),
  ('06', 'Extern verstorben')
;

DROP TABLE if exists metadata_repository.country;

CREATE TABLE metadata_repository.country (
	id serial primary key,
	sourceid varchar NOT NULL,
	country varchar NOT NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp not null default now(),
	UNIQUE (sourceid, country)
);

INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('AE','AE','kis'),
	 ('AF','AF','kis'),
	 ('AL','AL','kis'),
	 ('AM','AM','kis'),
	 ('AR','AR','kis'),
	 ('AT','AT','kis'),
	 ('AU','AU','kis'),
	 ('AZ','AZ','kis'),
	 ('BA','BA','kis'),
	 ('BD','BD','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('BE','BE','kis'),
	 ('BG','BG','kis'),
	 ('BH','BH','kis'),
	 ('BR','BR','kis'),
	 ('BY','BY','kis'),
	 ('CA','CA','kis'),
	 ('CG','CG','kis'),
	 ('CH','CH','kis'),
	 ('CL','CL','kis'),
	 ('CM','CM','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('CN','CN','kis'),
	 ('CS','CS','kis'),
	 ('CY','CY','kis'),
	 ('CZ','CZ','kis'),
	 ('DE','DE','kis'),
	 ('DK','DK','kis'),
	 ('DZ','DZ','kis'),
	 ('EC','EC','kis'),
	 ('EE','EE','kis'),
	 ('EG','EG','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('ER','ER','kis'),
	 ('ES','ES','kis'),
	 ('FI','FI','kis'),
	 ('FR','FR','kis'),
	 ('GB','GB','kis'),
	 ('GE','GE','kis'),
	 ('GH','GH','kis'),
	 ('GR','GR','kis'),
	 ('HK','HK','kis'),
	 ('HR','HR','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('HU','HU','kis'),
	 ('ID','ID','kis'),
	 ('IE','IE','kis'),
	 ('IL','IL','kis'),
	 ('IN','IN','kis'),
	 ('IQ','IQ','kis'),
	 ('IR','IR','kis'),
	 ('IS','IS','kis'),
	 ('IT','IT','kis'),
	 ('JO','JO','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('JP','JP','kis'),
	 ('KE','KE','kis'),
	 ('KR','KR','kis'),
	 ('KS','KS','kis'),
	 ('KW','KW','kis'),
	 ('KZ','KZ','kis'),
	 ('LT','LT','kis'),
	 ('LU','LU','kis'),
	 ('LV','LV','kis'),
	 ('LY','LY','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('MA','MA','kis'),
	 ('MD','MD','kis'),
	 ('MK','MK','kis'),
	 ('MN','MN','kis'),
	 ('MX','MX','kis'),
	 ('MY','MY','kis'),
	 ('NA','NA','kis'),
	 ('NG','NG','kis'),
	 ('NI','NI','kis'),
	 ('NL','NL','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('NO','NO','kis'),
	 ('NZ','NZ','kis'),
	 ('OM','OM','kis'),
	 ('PA','PA','kis'),
	 ('PH','PH','kis'),
	 ('PK','PK','kis'),
	 ('PL','PL','kis'),
	 ('PT','PT','kis'),
	 ('PY','PY','kis'),
	 ('QA','QA','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('RO','RO','kis'),
	 ('RS','RS','kis'),
	 ('RU','RU','kis'),
	 ('RW','RW','kis'),
	 ('SA','SA','kis'),
	 ('SD','SD','kis'),
	 ('SE','SE','kis'),
	 ('SG','SG','kis'),
	 ('SK','SK','kis'),
	 ('SLO','SLO','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('SO','SO','kis'),
	 ('SR','SR','kis'),
	 ('SV','SV','kis'),
	 ('SY','SY','kis'),
	 ('SZ','SZ','kis'),
	 ('TH','TH','kis'),
	 ('TJ','TJ','kis'),
	 ('TM','TM','kis'),
	 ('TN','TN','kis'),
	 ('TR','TR','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('TW','TW','kis'),
	 ('UA','UA','kis'),
	 ('UNB','UNB','kis'),
	 ('US','US','kis'),
	 ('UY','UY','kis'),
	 ('UZ','UZ','kis'),
	 ('VA','VA','kis'),
	 ('VE','VE','kis'),
	 ('VN','VN','kis'),
	 ('YE','YE','kis');
INSERT INTO metadata_repository.country (sourceid,country,"source") VALUES
	 ('YU','YU','kis');

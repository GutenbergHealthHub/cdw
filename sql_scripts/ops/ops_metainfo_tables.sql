-- structured ops.

DROP SCHEMA IF EXISTS ops_metainfo cascade;

CREATE SCHEMA IF NOT EXISTS ops_metainfo;

create table ops_metainfo.ops_release_info(
  ops_version varchar primary key,
  ops_release date not null unique check(date_part('year', ops_release) <= date_part('year', now()))
);



--select '    ('|| * from generate_series(2007, 2022);

--select '    ('''||generate_series(2007, 2022)||''', '''||generate_series(2006, 2021)||'.10.25''),';


insert into ops_metainfo.ops_release_info
  values
    ('2007', '2006.10.25'),
    ('2008', '2007.11.16'),
    ('2009', '2008.10.20'),
    ('2010', '2009.10.26'),
    ('2011', '2010.10.21'),
    ('2012', '2011.10.14'),
    ('2013', '2012.10.12'),
    ('2014', '2013.11.04'),
    ('2015', '2014.10.17'),
    ('2016', '2015.10.16'),
    ('2017', '2016.10.19'),
    ('2018', '2017.10.18'),
    ('2019', '2018.10.19'),
    ('2020', '2019.10.18'),
    ('2021', '2020.10.16'),
    ('2022', '2021.10.22')
;

CREATE TABLE ops_metainfo.Kapitel (
      KapNr VARCHAR(2) PRIMARY KEY,
      KapTi VARCHAR(255) NOT NULL
);

CREATE TABLE ops_metainfo.Gruppen (
      KapNr VARCHAR(2) REFERENCES ops_metainfo.Kapitel(KapNr),
      GrVon VARCHAR(5) PRIMARY KEY,
      GrBis VARCHAR(5),      
      GrTi  VARCHAR(255) NOT NULL
);

CREATE TABLE ops_metainfo.Dreisteller (
      KapNr VARCHAR(2) REFERENCES ops_metainfo.Kapitel(KapNr),
      GrVon VARCHAR(5) REFERENCES ops_metainfo.Gruppen(GrVon),
      DKode VARCHAR(5) PRIMARY KEY,
      DTi   VARCHAR(255)
);

CREATE TABLE ops_metainfo.Kodes (
      ver	     VARCHAR(10) not null references ops_metainfo.ops_release_info(ops_version),
      Ebene          VARCHAR(2),
      Ort            VARCHAR(2),
      Art            VARCHAR(2),
      KapNr          VARCHAR(2) REFERENCES ops_metainfo.Kapitel(KapNr),
      GrVon          VARCHAR(5) REFERENCES ops_metainfo.Gruppen(GrVon),
      DKode          VARCHAR(5) REFERENCES ops_metainfo.Dreisteller(DKode),
      Kode           VARCHAR(9) PRIMARY KEY,
      Seite          VARCHAR(2),
      Titel          VARCHAR(255),
      Viersteller    VARCHAR(255),
      Fuenfsteller    VARCHAR(255),
      Sechssteller   VARCHAR(255),
      Para17bd       VARCHAR(2), 
      ZusatzK        VARCHAR(2),
      EinmalK        VARCHAR(2)
);

CREATE TABLE ops_metainfo.ops (
      ver	     VARCHAR(10) not null references ops_metainfo.ops_release_info(ops_version),
      Ebene          VARCHAR(2),
      Ort            VARCHAR(2),
      Art            VARCHAR(2),
      KapNr          VARCHAR(2) not null, 
      GrVon          VARCHAR(5) not null, 
      DKode          VARCHAR(5) not null, 
      Kode           VARCHAR(9) not null, 
      Seite          VARCHAR(2) not null,
      Titel          VARCHAR(255) not null,
      Viersteller    VARCHAR(255),
      Fuenfsteller    VARCHAR(255),
      Sechssteller   VARCHAR(255),
      Para17bd       VARCHAR(2), 
      ZusatzK        VARCHAR(2),
      EinmalK        VARCHAR(2)
);

CREATE TABLE ops_metainfo.ops_history (
      ver	     VARCHAR(10) not null references ops_metainfo.ops_release_info(ops_version),
      Ebene          VARCHAR(2),
      Ort            VARCHAR(2),
      Art            VARCHAR(2),
      KapNr          VARCHAR(2) not null, 
      GrVon          VARCHAR(5) not null, 
      DKode          VARCHAR(5) not null, 
      Kode           VARCHAR(9) not null, 
      Seite          VARCHAR(2) not null,
      Titel          VARCHAR(255) not null,
      Viersteller    VARCHAR(255),
      Fuenfsteller    VARCHAR(255),
      Sechssteller   VARCHAR(255),
      Para17bd       VARCHAR(2), 
      ZusatzK        VARCHAR(2),
      EinmalK        VARCHAR(2),
      oldver         VARCHAR(10) references ops_metainfo.ops_release_info(ops_version),
      verevent       VARCHAR(4) not null check(verevent in ('I', 'U', 'D', 'DI'))
);

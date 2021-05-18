-- structured ops.

DROP SCHEMA IF EXISTS ops_metainfo cascade;

CREATE SCHEMA IF NOT EXISTS ops_metainfo;

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
      Fünfsteller    VARCHAR(255),
      Sechssteller   VARCHAR(255),
      Para17bd       VARCHAR(2), 
      ZusatzK        VARCHAR(2),
      EinmalK        VARCHAR(2)
);

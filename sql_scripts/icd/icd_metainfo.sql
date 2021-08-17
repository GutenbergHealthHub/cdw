
CREATE SCHEMA IF NOT EXISTS icd_metainfo;

CREATE TABLE icd_metainfo.Kapitel (
      KapNr varchar(3) PRIMARY KEY,
      KapTi VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.Gruppen (
      GrVon VARCHAR(4) PRIMARY KEY,
      GrBis VARCHAR(4),
      KapNr VARCHAR(3) REFERENCES icd_metainfo.Kapitel(KapNr),
      GrTi  VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MorbL (
      MorbLCode VARCHAR(6) PRIMARY KEY,
      MorbLTi   VARCHAR(255) NOT NULL 
);

CREATE TABLE icd_metainfo.MortL1Grp (
      MortL1GrpCode VARCHAR(6) PRIMARY KEY,
      MortL1GrpTi   VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL1 (
      MortL1Code     VARCHAR(6) PRIMARY KEY,
      MortL1GrpCode  VARCHAR(6) REFERENCES icd_metainfo.MortL1Grp(MortL1GrpCode),
      MortL1Ti       VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL2 (
      MortL2Code     VARCHAR(6) PRIMARY KEY,
      MortL2Ti       VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL3Grp (
      MortL3GrpCode VARCHAR(6) PRIMARY KEY,
      MortL3GrpTi   VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL3 (
      MortL3Code     VARCHAR(6) PRIMARY KEY,
      MortL3GrpCode  VARCHAR(6) REFERENCES icd_metainfo.MortL3Grp(MortL3GrpCode),
      MortL3Ti       VARCHAR(255) NOT NULL
);

CREATE table icd_metainfo.MortL4 (
      MortL4Code     VARCHAR(5) CONSTRAINT MortL4CodeX PRIMARY KEY,
      MortL4Ti       VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.Kodes (
      Ebene          VARCHAR(2),
      Ort            VARCHAR(2),
      Art            VARCHAR(2),
      KapNr          VARCHAR(3) REFERENCES icd_metainfo.Kapitel(KapNr),
      GrVon          VARCHAR(4) REFERENCES icd_metainfo.Gruppen(GrVon),
      Code           VARCHAR(8) PRIMARY KEY,
      NormCode       VARCHAR(7) UNIQUE NOT NULL,
      CodeOhnePunkt  VARCHAR(6) UNIQUE NOT NULL,
      Titel          VARCHAR(255) NOT NULL,
      Dreisteller    VARCHAR(255),
      Viersteller    VARCHAR(255),
      Fuenfsteller    VARCHAR(255),
      P295           VARCHAR(2),
      P301           VARCHAR(2),
      MortL1Code     VARCHAR(6) REFERENCES icd_metainfo.MortL1(MortL1Code),
      MortL2Code     VARCHAR(6) REFERENCES icd_metainfo.MortL2(MortL2Code),
      MortL3Code     VARCHAR(6) REFERENCES icd_metainfo.MortL3(MortL3Code),
      MortL4Code     VARCHAR(6) REFERENCES icd_metainfo.MortL4(MortL4Code),
      MorbLCode      VARCHAR(6) REFERENCES icd_metainfo.MorbL(MorbLCode),
      SexCode        VARCHAR(2),
      SexFehlerTyp   VARCHAR(2),
      AltUnt         VARCHAR(5),
      AltOb          VARCHAR(5),
      AltFehlerTyp   VARCHAR(2),
      Exot           VARCHAR(2),
      Belegt         VARCHAR(2),
      IfSGMeldung    VARCHAR(2),
      IfSGLabor      VARCHAR(2)
);

truncate table icd_metainfo.kodes cascade;
truncate table icd_metainfo.mortl4 cascade;
truncate table icd_metainfo.mortl3 cascade;
truncate table icd_metainfo.mortl3grp cascade;
truncate table icd_metainfo.mortl2 cascade;
truncate table icd_metainfo.mortl1 cascade;
truncate table icd_metainfo.mortl1grp cascade;
truncate table icd_metainfo.morbl cascade;
truncate table icd_metainfo.gruppen cascade;
truncate table icd_metainfo.kapitel cascade;

COPY icd_metainfo.kapitel from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/icd10gm2022syst_kapitel.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.gruppen from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/icd10gm2022syst_gruppen.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.morbl from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/morbl_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl1grp from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/mortl1grp_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl1 from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/mortl1_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl2 from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/mortl2_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl3grp from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/mortl3grp_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl3 from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/mortl3_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl4 from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/mortl4_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.kodes from '/home/abel/cdw/ICD/icd_versions/icd10gm2022syst-meta/Klassifikationsdateien/icd10gm2022syst_kodes.txt' WITH DELIMITER E';' CSV QUOTE E'\b';


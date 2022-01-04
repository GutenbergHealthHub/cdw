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

COPY icd_metainfo.kapitel from '/media/db/cdw_files/ICD/Klassifikationsdateien/icd10gm2022syst_kapitel.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.gruppen from '/media/db/cdw_files/ICD/Klassifikationsdateien/icd10gm2022syst_gruppen.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.morbl from '/media/db/cdw_files/ICD/Klassifikationsdateien/morbl_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl1grp from '/media/db/cdw_files/ICD/Klassifikationsdateien/mortl1grp_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl1 from '/media/db/cdw_files/ICD/Klassifikationsdateien/mortl1_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl2 from '/media/db/cdw_files/ICD/Klassifikationsdateien/mortl2_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl3grp from '/media/db/cdw_files/ICD/Klassifikationsdateien/mortl3grp_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl3 from '/media/db/cdw_files/ICD/Klassifikationsdateien/mortl3_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl4 from '/media/db/cdw_files/ICD/Klassifikationsdateien/mortl4_2022.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.kodes from '/media/db/cdw_files/ICD/Klassifikationsdateien/icd10gm2022syst_kodes.txt' WITH DELIMITER E';' CSV QUOTE E'\b';



--call metadata_repository.newicd(2022);
--call metadata_repository.updicd(2022);
--call metadata_repository.oldicd(2022);

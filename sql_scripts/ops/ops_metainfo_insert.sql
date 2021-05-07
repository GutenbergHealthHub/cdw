truncate table ops_metainfo.kodes cascade;
truncate table ops_metainfo.dreisteller cascade;
truncate table ops_metainfo.gruppen cascade;
truncate table ops_metainfo.kapitel cascade;

COPY ops_metainfo.Kapitel from '/media/db/cdw_files/OPS/Klassifikationsdateien/ops2021syst_kapitel.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY ops_metainfo.Gruppen from '/media/db/cdw_files/OPS/Klassifikationsdateien/ops2021syst_gruppen.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY ops_metainfo.Dreisteller from '/media/db/cdw_files/OPS/Klassifikationsdateien/ops2021syst_dreisteller.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY ops_metainfo.Kodes from '/media/db/cdw_files/OPS/Klassifikationsdateien/ops2021syst_kodes.txt' WITH DELIMITER E';' CSV QUOTE E'\b';

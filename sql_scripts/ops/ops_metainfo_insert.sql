truncate table ops_metainfo.kodes cascade;
truncate table ops_metainfo.gruppen cascade;
truncate table ops_metainfo.dreisteller cascade;
truncate table ops_metainfo.kapitel cascade;

COPY ops_metainfo.kapitel from '/home/abel/cdw/OPS/Klassifikationsdateien/ops2022syst_kapitel.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY ops_metainfo.gruppen from '/home/abel/cdw/OPS/Klassifikationsdateien/ops2022syst_gruppen.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY ops_metainfo.dreisteller from '/home/abel/cdw/OPS/Klassifikationsdateien/ops2022syst_dreisteller.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY ops_metainfo.kapitel from '/home/abel/cdw/OPS/Klassifikationsdateien/ops2022syst_kodes.txt' WITH DELIMITER E';' CSV QUOTE E'\b';



call metadata_repository.newops(2022);
call metadata_repository.updops(2022);
call metadata_repository.oldops(2022);

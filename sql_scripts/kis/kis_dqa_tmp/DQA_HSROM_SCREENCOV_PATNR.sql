-- DQA_/HSROM/SCREENCOV_PATNR
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_PATNR"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."PATNR" ~ '\w' THEN n."PATNR"
        ELSE NULL
    END AS "PATNR",
    m.long_name
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.TABLE m ON n."PATNR" = m.sourceid
  GROUP BY n."PATNR", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


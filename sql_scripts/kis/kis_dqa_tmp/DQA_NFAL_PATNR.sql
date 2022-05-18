-- DQA_NFAL_PATNR
CREATE OR REPLACE VIEW kis."DQA_NFAL_PATNR"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."PATNR" ~ '\w' THEN n."PATNR"
        ELSE NULL
    END AS "PATNR",
    m.long_name
  FROM kis."NFAL" n
  LEFT JOIN metadata_repository.TABLE m ON n."PATNR" = m.sourceid
  GROUP BY n."PATNR", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


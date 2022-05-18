-- DQA_NFPZ_PERNR
CREATE OR REPLACE VIEW kis."DQA_NFPZ_PERNR"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."PERNR" ~ '\w' THEN n."PERNR"
        ELSE NULL
    END AS "PERNR",
    m.long_name
  FROM kis."NFPZ" n
  LEFT JOIN metadata_repository.TABLE m ON n."PERNR" = m.sourceid
  GROUP BY n."PERNR", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


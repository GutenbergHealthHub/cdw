-- DQA_NPAT_RFPAT
CREATE OR REPLACE VIEW kis."DQA_NPAT_RFPAT"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."RFPAT" ~ '\w' THEN n."RFPAT"
        ELSE NULL
    END AS "RFPAT",
    m.long_name
  FROM kis."NPAT" n
  LEFT JOIN metadata_repository.TABLE m ON n."RFPAT" = m.sourceid
  GROUP BY n."RFPAT", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


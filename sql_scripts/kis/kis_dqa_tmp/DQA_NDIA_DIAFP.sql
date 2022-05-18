-- DQA_NDIA_DIAFP
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIAFP"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DIAFP" ~ '\w' THEN n."DIAFP"
        ELSE NULL
    END AS "DIAFP",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DIAFP" = m.sourceid
  GROUP BY n."DIAFP", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


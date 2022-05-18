-- DQA_NDIA_DTYP1
CREATE OR REPLACE VIEW kis."DQA_NDIA_DTYP1"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DTYP1" ~ '\w' THEN n."DTYP1"
        ELSE NULL
    END AS "DTYP1",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DTYP1" = m.sourceid
  GROUP BY n."DTYP1", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


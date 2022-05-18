-- DQA_NDIA_DTYP2
CREATE OR REPLACE VIEW kis."DQA_NDIA_DTYP2"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DTYP2" ~ '\w' THEN n."DTYP2"
        ELSE NULL
    END AS "DTYP2",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DTYP2" = m.sourceid
  GROUP BY n."DTYP2", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


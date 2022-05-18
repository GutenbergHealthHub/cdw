-- DQA_NDIA_DKEY1
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKEY1"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DKEY1" ~ '\w' THEN n."DKEY1"
        ELSE NULL
    END AS "DKEY1",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DKEY1" = m.sourceid
  GROUP BY n."DKEY1", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


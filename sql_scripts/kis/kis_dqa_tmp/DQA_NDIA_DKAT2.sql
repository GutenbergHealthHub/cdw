-- DQA_NDIA_DKAT2
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKAT2"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DKAT2" ~ '\w' THEN n."DKAT2"
        ELSE NULL
    END AS "DKAT2",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DKAT2" = m.sourceid
  GROUP BY n."DKAT2", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


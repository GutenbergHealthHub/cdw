-- DQA_NDIA_DKEY2
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKEY2"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DKEY2" ~ '\w' THEN n."DKEY2"
        ELSE NULL
    END AS "DKEY2",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DKEY2" = m.sourceid
  GROUP BY n."DKEY2", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


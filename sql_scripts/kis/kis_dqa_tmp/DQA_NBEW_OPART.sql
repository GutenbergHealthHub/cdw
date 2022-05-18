-- DQA_NBEW_OPART
CREATE OR REPLACE VIEW kis."DQA_NBEW_OPART"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."OPART" ~ '\w' THEN n."OPART"
        ELSE NULL
    END AS "OPART",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."OPART" = m.sourceid
  GROUP BY n."OPART", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


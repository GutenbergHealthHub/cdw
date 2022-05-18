-- DQA_NBEW_CLASS
CREATE OR REPLACE VIEW kis."DQA_NBEW_CLASS"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."CLASS" ~ '\w' THEN n."CLASS"
        ELSE NULL
    END AS "CLASS",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."CLASS" = m.sourceid
  GROUP BY n."CLASS", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


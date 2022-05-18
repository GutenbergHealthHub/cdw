-- DQA_NBEW_PLANR
CREATE OR REPLACE VIEW kis."DQA_NBEW_PLANR"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."PLANR" ~ '\w' THEN n."PLANR"
        ELSE NULL
    END AS "PLANR",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."PLANR" = m.sourceid
  GROUP BY n."PLANR", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


-- DQA_NBEW_FACHR
CREATE OR REPLACE VIEW kis."DQA_NBEW_FACHR"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHR" ~ '\w' THEN n."FACHR"
        ELSE NULL
    END AS "FACHR",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHR" = m.sourceid
  GROUP BY n."FACHR", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


-- DQA_NBEW_ZIMMR
CREATE OR REPLACE VIEW kis."DQA_NBEW_ZIMMR"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ZIMMR" ~ '\w' THEN n."ZIMMR"
        ELSE NULL
    END AS "ZIMMR",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."ZIMMR" = m.sourceid
  GROUP BY n."ZIMMR", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


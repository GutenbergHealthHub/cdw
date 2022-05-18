-- DQA_NBEW_EZUST
CREATE OR REPLACE VIEW kis."DQA_NBEW_EZUST"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."EZUST" ~ '\w' THEN n."EZUST"
        ELSE NULL
    END AS "EZUST",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."EZUST" = m.sourceid
  GROUP BY n."EZUST", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


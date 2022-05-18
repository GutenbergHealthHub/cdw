-- DQA_NBEW_UNFAV
CREATE OR REPLACE VIEW kis."DQA_NBEW_UNFAV"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."UNFAV" ~ '\w' THEN n."UNFAV"
        ELSE NULL
    END AS "UNFAV",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."UNFAV" = m.sourceid
  GROUP BY n."UNFAV", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


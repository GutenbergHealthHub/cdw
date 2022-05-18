-- DQA_NPAT_RACE
CREATE OR REPLACE VIEW kis."DQA_NPAT_RACE"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."RACE" ~ '\w' THEN n."RACE"
        ELSE NULL
    END AS "RACE",
    m.long_name
  FROM kis."NPAT" n
  LEFT JOIN metadata_repository.TABLE m ON n."RACE" = m.sourceid
  GROUP BY n."RACE", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


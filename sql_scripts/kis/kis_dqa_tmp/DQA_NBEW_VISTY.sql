-- DQA_NBEW_VISTY
CREATE OR REPLACE VIEW kis."DQA_NBEW_VISTY"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."VISTY" ~ '\w' THEN n."VISTY"
        ELSE NULL
    END AS "VISTY",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."VISTY" = m.sourceid
  GROUP BY n."VISTY", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


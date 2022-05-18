-- DQA_NBEW_BEKAT
CREATE OR REPLACE VIEW kis."DQA_NBEW_BEKAT"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."BEKAT" ~ '\w' THEN n."BEKAT"
        ELSE NULL
    END AS "BEKAT",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."BEKAT" = m.sourceid
  GROUP BY n."BEKAT", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


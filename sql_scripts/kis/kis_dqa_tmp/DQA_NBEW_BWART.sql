-- DQA_NBEW_BWART
CREATE OR REPLACE VIEW kis."DQA_NBEW_BWART"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."BWART" ~ '\w' THEN n."BWART"
        ELSE NULL
    END AS "BWART",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."BWART" = m.sourceid
  GROUP BY n."BWART", m.long_name
  ORDER BY (count(n."FALNR")) DESC;


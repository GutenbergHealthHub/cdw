-- DQA_NBEW_UNFKZ
CREATE OR REPLACE VIEW kis."DQA_NBEW_UNFKZ"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UNFKZ" ~ '\w' THEN n."UNFKZ"
        ELSE NULL
    END AS "UNFKZ",
    m.unfallart
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.unfallart m ON n."UNFKZ" = m.sourceid
  GROUP BY n."UNFKZ", m.unfallart
  ORDER BY "QUANTITY" DESC;
 
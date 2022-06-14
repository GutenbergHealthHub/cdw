--drop view kis."DQA_NBEW_BEKAT";
-- DQA_NBEW_BEKAT
CREATE OR REPLACE VIEW kis."DQA_NBEW_BEKAT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BEKAT" ~ '\w' THEN n."BEKAT"
        ELSE NULL
    END AS "BEKAT",
    m.bltxt
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.tn24 m ON n."BEKAT" = m.bekat
  GROUP BY n."BEKAT", m.bltxt
  ORDER BY "QUANTITY" DESC;


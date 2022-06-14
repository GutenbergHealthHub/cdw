-- DQA_NBEW_BWART
CREATE OR REPLACE VIEW kis."DQA_NBEW_BWART"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BWART" ~ '\w' THEN n."BWART"
        ELSE NULL
    END AS "BWART",
    m.bewegunsart bewegungsart
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.bewegunsart m ON n."BWART" = m.bwart
  GROUP BY n."BWART", m.bewegunsart
  ORDER BY "QUANTITY" DESC;


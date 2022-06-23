-- DQA_NBEW_TPART
CREATE OR REPLACE VIEW kis."DQA_NBEW_TPART"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."TPART" ~ '\w' THEN n."TPART"
        ELSE NULL
    END AS "TPART",
    m.transportart
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.transportart m ON n."TPART" = m.sourceid
  GROUP BY n."TPART", m.transportart
  ORDER BY "QUANTITY" DESC;
 
 


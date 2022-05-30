-- DQA_NFAL_FALAR
CREATE OR REPLACE VIEW kis."DQA_NFAL_FALAR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FALAR" ~ '\w' THEN n."FALAR"
        ELSE NULL
    END AS "FALAR"/*,
    m.long_name*/
  FROM kis."NFAL" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FALAR" = m.sourceid
  GROUP BY n."FALAR"--, m.long_name
  ORDER BY "QUANTITY" DESC;


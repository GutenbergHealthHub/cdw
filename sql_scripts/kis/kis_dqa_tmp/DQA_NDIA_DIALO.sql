-- DQA_NDIA_DIALO
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIALO"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DIALO" ~ '\w' THEN n."DIALO"
        ELSE NULL
    END AS "DIALO"/*,
    m.long_name*/
  FROM kis."NDIA" n
  --LEFT JOIN metadata_repository.TABLE m ON n."DIALO" = m.sourceid
  GROUP BY n."DIALO"--, m.long_name
  ORDER BY "QUANTITY" DESC;


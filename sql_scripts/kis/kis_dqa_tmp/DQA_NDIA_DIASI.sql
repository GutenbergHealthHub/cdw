-- DQA_NDIA_DIASI
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIASI"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DIASI" ~ '\w' THEN n."DIASI"
        ELSE NULL
    END AS "DIASI"/*,
    m.long_name*/
  FROM kis."NDIA" n
  --LEFT JOIN metadata_repository.TABLE m ON n."DIASI" = m.sourceid
  GROUP BY n."DIASI"--, m.long_name
  ORDER BY "QUANTITY" DESC;


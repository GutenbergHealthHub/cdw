-- DQA_NDIA_DKAT_REF
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKAT_REF"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DKAT_REF" ~ '\w' THEN n."DKAT_REF"
        ELSE NULL
    END AS "DKAT_REF"/*,
    m.long_name*/
  FROM kis."NDIA" n
  --LEFT JOIN metadata_repository.TABLE m ON n."DKAT_REF" = m.sourceid
  GROUP BY n."DKAT_REF"--, m.long_name
  ORDER BY "QUANTITY" DESC;


-- DQA_NDIA_DTYPE_REF
CREATE OR REPLACE VIEW kis."DQA_NDIA_DTYPE_REF"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DTYPE_REF" ~ '\w' THEN n."DTYPE_REF"
        ELSE NULL
    END AS "DTYPE_REF"/*,
    m.long_name*/
  FROM kis."NDIA" n
  --LEFT JOIN metadata_repository.TABLE m ON n."DTYPE_REF" = m.sourceid
  GROUP BY n."DTYPE_REF"--, m.long_name
  ORDER BY "QUANTITY" DESC;


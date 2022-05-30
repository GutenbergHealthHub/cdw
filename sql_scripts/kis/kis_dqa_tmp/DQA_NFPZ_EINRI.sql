-- DQA_NFPZ_EINRI
CREATE OR REPLACE VIEW kis."DQA_NFPZ_EINRI"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."EINRI" ~ '\w' THEN n."EINRI"
        ELSE NULL
    END AS "EINRI"/*,
    m.long_name*/
  FROM kis."NFPZ" n
  --LEFT JOIN metadata_repository.TABLE m ON n."EINRI" = m.sourceid
  GROUP BY n."EINRI"--, m.long_name
  ORDER BY "QUANTITY" DESC;


-- DQA_NFAL_EINZG
CREATE OR REPLACE VIEW kis."DQA_NFAL_EINZG"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."EINZG" ~ '\w' THEN n."EINZG"
        ELSE NULL
    END AS "EINZG"/*,
    m.long_name*/
  FROM kis."NFAL" n
  --LEFT JOIN metadata_repository.TABLE m ON n."EINZG" = m.sourceid
  GROUP BY n."EINZG"--, m.long_name
  ORDER BY "QUANTITY" DESC;


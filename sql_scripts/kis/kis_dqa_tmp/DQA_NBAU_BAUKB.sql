-- DQA_NBAU_BAUKB
CREATE OR REPLACE VIEW kis."DQA_NBAU_BAUKB"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BAUKB" ~ '\w' THEN n."BAUKB"
        ELSE NULL
    END AS "BAUKB"/*,
    m.long_name*/
  FROM kis."NBAU" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BAUKB" = m.sourceid
  GROUP BY n."BAUKB"--, m.long_name
  ORDER BY "QUANTITY" DESC;


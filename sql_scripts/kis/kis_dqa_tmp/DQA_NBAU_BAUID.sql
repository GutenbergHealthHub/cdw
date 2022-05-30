-- DQA_NBAU_BAUID
CREATE OR REPLACE VIEW kis."DQA_NBAU_BAUID"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BAUID" ~ '\w' THEN n."BAUID"
        ELSE NULL
    END AS "BAUID"/*,
    m.long_name*/
  FROM kis."NBAU" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BAUID" = m.sourceid
  GROUP BY n."BAUID"--, m.long_name
  ORDER BY "QUANTITY" DESC;


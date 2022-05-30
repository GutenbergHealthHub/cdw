-- DQA_TN11H_UNTBT
CREATE OR REPLACE VIEW kis."DQA_TN11H_UNTBT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UNTBT" ~ '\w' THEN n."UNTBT"
        ELSE NULL
    END AS "UNTBT"/*,
    m.long_name*/
  FROM kis."TN11H" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UNTBT" = m.sourceid
  GROUP BY n."UNTBT"--, m.long_name
  ORDER BY "QUANTITY" DESC;


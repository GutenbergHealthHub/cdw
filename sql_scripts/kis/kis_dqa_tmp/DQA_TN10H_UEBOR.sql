-- DQA_TN10H_UEBOR
CREATE OR REPLACE VIEW kis."DQA_TN10H_UEBOR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UEBOR" ~ '\w' THEN n."UEBOR"
        ELSE NULL
    END AS "UEBOR"/*,
    m.long_name*/
  FROM kis."TN10H" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UEBOR" = m.sourceid
  GROUP BY n."UEBOR"--, m.long_name
  ORDER BY "QUANTITY" DESC;


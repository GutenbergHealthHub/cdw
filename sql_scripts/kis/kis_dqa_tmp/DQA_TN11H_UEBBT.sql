-- DQA_TN11H_UEBBT
CREATE OR REPLACE VIEW kis."DQA_TN11H_UEBBT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UEBBT" ~ '\w' THEN n."UEBBT"
        ELSE NULL
    END AS "UEBBT"/*,
    m.long_name*/
  FROM kis."TN11H" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UEBBT" = m.sourceid
  GROUP BY n."UEBBT"--, m.long_name
  ORDER BY "QUANTITY" DESC;


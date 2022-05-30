-- DQA_TN11H_UEBBE
CREATE OR REPLACE VIEW kis."DQA_TN11H_UEBBE"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UEBBE" ~ '\w' THEN n."UEBBE"
        ELSE NULL
    END AS "UEBBE"/*,
    m.long_name*/
  FROM kis."TN11H" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UEBBE" = m.sourceid
  GROUP BY n."UEBBE"--, m.long_name
  ORDER BY "QUANTITY" DESC;


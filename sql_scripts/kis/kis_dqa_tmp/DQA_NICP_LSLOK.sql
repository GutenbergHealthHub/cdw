-- DQA_NICP_LSLOK
CREATE OR REPLACE VIEW kis."DQA_NICP_LSLOK"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."LSLOK" ~ '\w' THEN n."LSLOK"
        ELSE NULL
    END AS "LSLOK"/*,
    m.long_name*/
  FROM kis."NICP" n
  --LEFT JOIN metadata_repository.TABLE m ON n."LSLOK" = m.sourceid
  GROUP BY n."LSLOK"--, m.long_name
  ORDER BY "QUANTITY" DESC;


-- DQA_/HSROM/SCREENCOV_SCREENVACCSTAT
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENVACCSTAT"
  AS
  SELECT count("RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENVACCSTAT" ~ '\w' THEN n."SCREENVACCSTAT"
        ELSE NULL
    END AS "SCREENVACCSTAT"/*,
    m.long_name*/
  FROM kis."/HSROM/SCREENCOV" n
  --LEFT JOIN metadata_repository.TABLE m ON n."SCREENVACCSTAT" = m.sourceid
  GROUP BY n."SCREENVACCSTAT"--, m.long_name
  ORDER BY "QUANTITY" DESC;

